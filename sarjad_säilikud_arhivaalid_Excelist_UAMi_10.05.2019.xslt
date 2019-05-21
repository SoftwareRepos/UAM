<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:html="http://www.w3.org/TR/REC-html40"
 exclude-result-prefixes="ss o x html">
	<xsl:output method="xml" encoding="utf-8" indent="yes" />

	<xsl:template match="ss:Workbook">
		<xsl:for-each select="ss:Worksheet">
			<xsl:if test="position()=1">

				<UAM_import xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">

					<!--Kui tegemist on sarjadega-->
					<xsl:if test="normalize-space(ss:Table/ss:Row[1]/ss:Cell[1]/ss:Data)='Sarja tähis algsüsteemis'">
						<Arhiivikirjeldus>
							<xsl:for-each select="ss:Table/ss:Row">
								<xsl:if test="position()!=1 and ss:Cell[1]/ss:Data">

									<Kirjeldusyksus>
										<KyTasand>						
											<xsl:value-of select="string('sari')"/>
										</KyTasand>
										<KyIdentiteediala>
											<xsl:if test="normalize-space(ss:Cell[1]/ss:Data) != '-'">
												<!--Tähis algsüsteemis-->
												<KyViit>
													<xsl:value-of select="ss:Cell[1]/ss:Data"/>
												</KyViit>
											</xsl:if>	
											<xsl:if test="normalize-space(ss:Cell[2]/ss:Data) != '-'">
												<KyPealkiri>
													<xsl:value-of select="ss:Cell[2]/ss:Data" />
												</KyPealkiri>
											</xsl:if>			
										</KyIdentiteediala>

										<KySisuStruktAla>
											<xsl:if test="normalize-space(ss:Cell[3]/ss:Data) != '-'">
												<KyHoiustamiseAjalugu>
													<xsl:value-of select="ss:Cell[3]/ss:Data" />
												</KyHoiustamiseAjalugu>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[4]/ss:Data) != '-'">
												<KySisu>
													<xsl:value-of select="ss:Cell[4]/ss:Data" />
												</KySisu>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[5]/ss:Data) != '-'">
												<KyKorrastussysteem>
													<xsl:value-of select="ss:Cell[5]/ss:Data" />
												</KyKorrastussysteem>
											</xsl:if>
										</KySisuStruktAla>	

										<xsl:if test="normalize-space(ss:Cell[6]/ss:Data) != '-' or normalize-space(ss:Cell[7]/ss:Data) != '-'">
											<KyJuurdepaasuala>
												<xsl:if test="normalize-space(ss:Cell[6]/ss:Data) != '-'">
													<xsl:call-template name="keel">
														<xsl:with-param name="list" select="lower-case(ss:Cell[6]/ss:Data)"/>
														<xsl:with-param name="list2" select="lower-case(ss:Cell[6]/ss:Data)"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>
												</xsl:if>
												<xsl:if test="normalize-space(ss:Cell[7]/ss:Data) != '-'">
													<xsl:call-template name="jpp">
														<xsl:with-param name="list" select="ss:Cell[7]/ss:Data"/>
														<xsl:with-param name="list2" select="ss:Cell[8]/ss:Data"/>
														<xsl:with-param name="list3" select="ss:Cell[9]/ss:Data"/>
														<xsl:with-param name="list4" select="ss:Cell[10]/ss:Data"/>
														<xsl:with-param name="list5" select="ss:Cell[11]/ss:Data"/>	
														<xsl:with-param name="list6" select="ss:Cell[12]/ss:Data"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>	
												</xsl:if>
											</KyJuurdepaasuala>
										</xsl:if>

									</Kirjeldusyksus>	
								</xsl:if>
							</xsl:for-each>
						</Arhiivikirjeldus>
					</xsl:if>
					
					<!--Kui tegemist on säilikute/toimikutega-->
					<xsl:if test="normalize-space(ss:Table/ss:Row[1]/ss:Cell[2]/ss:Data)='Toimiku tähis algsüsteemis'">
						<Arhiivikirjeldus>
							<xsl:for-each select="ss:Table/ss:Row">
								<xsl:if test="position()!=1 and ss:Cell[2]/ss:Data">

									<Kirjeldusyksus>
										<KyTasand>						
											<xsl:value-of select="string('toimik')"/>
										</KyTasand>
										<KyIdentiteediala>
											<xsl:if test="normalize-space(ss:Cell[2]/ss:Data) != '-'">
												<KyViit>
													<xsl:value-of select="ss:Cell[2]/ss:Data"/>
												</KyViit>
											</xsl:if>	
											<xsl:if test="normalize-space(ss:Cell[1]/ss:Data) != '-'">	
												<KyVanemViit>
													<xsl:value-of select="ss:Cell[1]/ss:Data" />
												</KyVanemViit>
											</xsl:if>	
											<xsl:if test="normalize-space(ss:Cell[5]/ss:Data) != '-'">
												<KyAeg>
													<Algus>
														<Tyyp>kuupäev</Tyyp>
														<Tapsus>true</Tapsus>
														<Vaartus>
															<xsl:value-of select="ss:Cell[5]/ss:Data" />
														</Vaartus>
													</Algus>
													<Lopp>
														<Tyyp>kuupäev</Tyyp>
														<Tapsus>true</Tapsus>
														<Vaartus>
															<xsl:value-of select="ss:Cell[6]/ss:Data" />
														</Vaartus>
													</Lopp>
												</KyAeg>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[3]/ss:Data) != '-'">
												<KyPealkiri>
													<xsl:value-of select="ss:Cell[3]/ss:Data" />
												</KyPealkiri>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[4]/ss:Data) != '-'">
												<KyPealkiriVoorkeeles>
													<Pealkiri>
														<xsl:value-of select="ss:Cell[4]/ss:Data" />
													</Pealkiri>
												</KyPealkiriVoorkeeles>	
											</xsl:if>					
										</KyIdentiteediala>

										<KySisuStruktAla>
											<xsl:if test="normalize-space(ss:Cell[15]/ss:Data) != '-'">
												<KyKogus>
													<Kogus><xsl:value-of select="ss:Cell[15]/ss:Data" /></Kogus>
													<Yhik><xsl:value-of select="ss:Cell[16]/ss:Data" /></Yhik>
												</KyKogus>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[7]/ss:Data) != '-'">
												<KySisu>
													<xsl:value-of select="ss:Cell[7]/ss:Data" />
												</KySisu>
											</xsl:if>
										</KySisuStruktAla>	

										<xsl:if test="normalize-space(ss:Cell[8]/ss:Data) != '-' or normalize-space(ss:Cell[9]/ss:Data) != '-'">
											<KyJuurdepaasuala>
												<xsl:if test="normalize-space(ss:Cell[8]/ss:Data) != '-'">
													<xsl:call-template name="keel">
														<xsl:with-param name="list" select="lower-case(ss:Cell[8]/ss:Data)"/>
														<xsl:with-param name="list2" select="lower-case(ss:Cell[8]/ss:Data)"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>
												</xsl:if>
												<xsl:if test="normalize-space(ss:Cell[9]/ss:Data) != '-'">
													<xsl:call-template name="jpp">
														<xsl:with-param name="list" select="ss:Cell[9]/ss:Data"/>
														<xsl:with-param name="list2" select="ss:Cell[10]/ss:Data"/>
														<xsl:with-param name="list3" select="ss:Cell[11]/ss:Data"/>
														<xsl:with-param name="list4" select="ss:Cell[12]/ss:Data"/>
														<xsl:with-param name="list5" select="ss:Cell[13]/ss:Data"/>	
														<xsl:with-param name="list6" select="ss:Cell[14]/ss:Data"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>	
												</xsl:if>
											</KyJuurdepaasuala>
										</xsl:if>

									</Kirjeldusyksus>	
								</xsl:if>
							</xsl:for-each>
						</Arhiivikirjeldus>
					</xsl:if>

					<!--Kui tegemist on dokumentidega-->
					<xsl:if test="normalize-space(ss:Table/ss:Row[1]/ss:Cell[3]/ss:Data)='Dokumendi pealkiri'">
						<xsl:for-each select="ss:Table/ss:Row">
							<xsl:if test="position()!=1 and ss:Cell[1]/ss:Data">

								<Arhivaal>
									<KyMeta>
										<KyIdentiteediala>
											<xsl:if test="normalize-space(ss:Cell[2]/ss:Data) != '-'">
												<KyViit>
													<xsl:value-of select="ss:Cell[2]/ss:Data" />
												</KyViit>	
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[1]/ss:Data) != '-'">	
												<KyVanemViit>
													<xsl:value-of select="ss:Cell[1]/ss:Data" />
												</KyVanemViit>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[5]/ss:Data) != '-'">
												<KyAeg>
													<Tyyp>kuupäev</Tyyp>
													<Tapsus>true</Tapsus>
													<Vaartus>
														<xsl:value-of select="ss:Cell[5]/ss:Data" />
													</Vaartus>
												</KyAeg>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[3]/ss:Data) != '-'">
												<KyPealkiri>
													<xsl:value-of select="ss:Cell[3]/ss:Data" />
												</KyPealkiri>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[4]/ss:Data) != '-'">
												<KyPealkiriVoorkeeles>
													<Pealkiri>
														<xsl:value-of select="ss:Cell[4]/ss:Data" />
													</Pealkiri>
												</KyPealkiriVoorkeeles>	
											</xsl:if>					
										</KyIdentiteediala>

										<KySisuStruktAla>
											<xsl:if test="normalize-space(ss:Cell[14]/ss:Data) != '-'">
												<KyKogus>
													<Kogus><xsl:value-of select="ss:Cell[14]/ss:Data" /></Kogus>
													<Yhik><xsl:value-of select="ss:Cell[15]/ss:Data" /></Yhik>
												</KyKogus>
											</xsl:if>
											<xsl:if test="normalize-space(ss:Cell[6]/ss:Data) != '-'">
												<KySisu>
													<xsl:value-of select="ss:Cell[6]/ss:Data" />
												</KySisu>
											</xsl:if>
										</KySisuStruktAla>	

										<xsl:if test="ss:Cell[7]/ss:Data or normalize-space(ss:Cell[8]/ss:Data) != '-'">
											<KyJuurdepaasuala>

												<xsl:if test="normalize-space(ss:Cell[7]/ss:Data) != '-'">
													<xsl:call-template name="keel">
														<xsl:with-param name="list" select="lower-case(ss:Cell[7]/ss:Data)"/>
														<xsl:with-param name="list2" select="lower-case(ss:Cell[7]/ss:Data)"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>
												</xsl:if>

												<xsl:if test="normalize-space(ss:Cell[8]/ss:Data) != '-'">
													<xsl:call-template name="jpp">
														<xsl:with-param name="list" select="ss:Cell[8]/ss:Data"/>
														<xsl:with-param name="list2" select="ss:Cell[9]/ss:Data"/>
														<xsl:with-param name="list3" select="ss:Cell[10]/ss:Data"/>
														<xsl:with-param name="list4" select="ss:Cell[11]/ss:Data"/>
														<xsl:with-param name="list5" select="ss:Cell[12]/ss:Data"/>	
														<xsl:with-param name="list6" select="ss:Cell[13]/ss:Data"/>
														<xsl:with-param name="delimiter">;</xsl:with-param>
													</xsl:call-template>
												</xsl:if>

											</KyJuurdepaasuala>
										</xsl:if>
									</KyMeta>

									<!--Failid-->
									<xsl:if test="normalize-space(ss:Cell[16]/ss:Data) != '-'">
										<xsl:call-template name="fail">
											<xsl:with-param name="list" select="ss:Cell[16]/ss:Data"/>
											<xsl:with-param name="delimiter">;</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</Arhivaal>
							</xsl:if>
						</xsl:for-each>
					</xsl:if> <!--Kui tegemist oli dokumentidega-->
					
				</UAM_import>
			</xsl:if>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="keel" xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">
		<xsl:param name="list"/>
		<xsl:param name="list2"/>
		<xsl:param name="delimiter"/>
		<xsl:variable name="newlist">
			<xsl:choose>
				<xsl:when test="contains($list, $delimiter)">
					<xsl:value-of select="normalize-space($list)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="kirjaviis_list">
			<xsl:choose>
				<xsl:when test="contains($list2, $delimiter)">
					<xsl:value-of select="normalize-space($list2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list2), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="first" select="substring-before($newlist, $delimiter)"/>
		<xsl:variable name="first2" select="substring-before($kirjaviis_list, $delimiter)"/>

		<xsl:variable name="remaining" select="substring-after($newlist, $delimiter)"/>
		<xsl:variable name="remaining2" select="substring-after($kirjaviis_list, $delimiter)"/>

		<KyKeel xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">
			<Keel xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">
				<xsl:choose>
					<xsl:when test="string($first)='abhaasi'">
						<xsl:value-of select="string('abk')"/>
					</xsl:when>
					<xsl:when test="string($first)='atšehi'">
						<xsl:value-of select="string('ace')"/>
					</xsl:when>
					<xsl:when test="string($first)='akoli'">
						<xsl:value-of select="string('ach')"/>
					</xsl:when>
					<xsl:when test="string($first)='adangme'">
						<xsl:value-of select="string('ada')"/>
					</xsl:when>
					<xsl:when test="string($first)='adõgee'">
						<xsl:value-of select="string('ady')"/>
					</xsl:when>
					<xsl:when test="string($first)='afroaasia keeled'">
						<xsl:value-of select="string('afa')"/>
					</xsl:when>
					<xsl:when test="string($first)='afrihili'">
						<xsl:value-of select="string('afh')"/>
					</xsl:when>
					<xsl:when test="string($first)='afrikaani'">
						<xsl:value-of select="string('afr')"/>
					</xsl:when>
					<xsl:when test="string($first)='aguli'">
						<xsl:value-of select="string('agx')"/>
					</xsl:when>
					<xsl:when test="string($first)='ainu'">
						<xsl:value-of select="string('ain')"/>
					</xsl:when>
					<xsl:when test="string($first)='akani'">
						<xsl:value-of select="string('aka')"/>
					</xsl:when>
					<xsl:when test="string($first)='akadi'">
						<xsl:value-of select="string('akk')"/>
					</xsl:when>
					<xsl:when test="string($first)='albaania'">
						<xsl:value-of select="string('alb/sqi')"/>
					</xsl:when>
					<xsl:when test="string($first)='aleuudi'">
						<xsl:value-of select="string('ale')"/>
					</xsl:when>
					<xsl:when test="string($first)='algonkini keeled'">
						<xsl:value-of select="string('alg')"/>
					</xsl:when>
					<xsl:when test="string($first)='altai'">
						<xsl:value-of select="string('alt')"/>
					</xsl:when>
					<xsl:when test="string($first)='amhara'">
						<xsl:value-of select="string('amh')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanainglise (u 450–1100)'">
						<xsl:value-of select="string('ang')"/>
					</xsl:when>
					<xsl:when test="string($first)='angika'">
						<xsl:value-of select="string('anp')"/>
					</xsl:when>
					<xsl:when test="string($first)='apatši keeled'">
						<xsl:value-of select="string('apa')"/>
					</xsl:when>
					<xsl:when test="string($first)='araabia'">
						<xsl:value-of select="string('ara')"/>
					</xsl:when>
					<xsl:when test="string($first)='aramea'">
						<xsl:value-of select="string('arc')"/>
					</xsl:when>
					<xsl:when test="string($first)='aragoni'">
						<xsl:value-of select="string('arg')"/>
					</xsl:when>
					<xsl:when test="string($first)='armeenia'">
						<xsl:value-of select="string('arm/hye')"/>
					</xsl:when>
					<xsl:when test="string($first)='mapudunguni'">
						<xsl:value-of select="string('arn')"/>
					</xsl:when>
					<xsl:when test="string($first)='arapaho'">
						<xsl:value-of select="string('arp')"/>
					</xsl:when>
					<xsl:when test="string($first)='tehiskeeled'">
						<xsl:value-of select="string('art')"/>
					</xsl:when>
					<xsl:when test="string($first)='aravaki'">
						<xsl:value-of select="string('arw')"/>
					</xsl:when>
					<xsl:when test="string($first)='assami'">
						<xsl:value-of select="string('asm')"/>
					</xsl:when>
					<xsl:when test="string($first)='astuuria'">
						<xsl:value-of select="string('ast')"/>
					</xsl:when>
					<xsl:when test="string($first)='aserbaidžaani'">
						<xsl:value-of select="string('aze')"/>
					</xsl:when>
					<xsl:when test="string($first)='atapaski keeled'">
						<xsl:value-of select="string('ath')"/>
					</xsl:when>
					<xsl:when test="string($first)='Austraalia keeled'">
						<xsl:value-of select="string('aus')"/>
					</xsl:when>
					<xsl:when test="string($first)='avaari'">
						<xsl:value-of select="string('ava')"/>
					</xsl:when>
					<xsl:when test="string($first)='avadhi'">
						<xsl:value-of select="string('awa')"/>
					</xsl:when>
					<xsl:when test="string($first)='avesta'">
						<xsl:value-of select="string('ave')"/>
					</xsl:when>
					<xsl:when test="string($first)='aimara'">
						<xsl:value-of select="string('aym')"/>
					</xsl:when>
					<xsl:when test="string($first)='banda keeled'">
						<xsl:value-of select="string('bad')"/>
					</xsl:when>
					<xsl:when test="string($first)='bamileke keeled'">
						<xsl:value-of select="string('bai')"/>
					</xsl:when>
					<xsl:when test="string($first)='baškiiri'">
						<xsl:value-of select="string('bak')"/>
					</xsl:when>
					<xsl:when test="string($first)='belutši'">
						<xsl:value-of select="string('bal')"/>
					</xsl:when>
					<xsl:when test="string($first)='bambara'">
						<xsl:value-of select="string('bam')"/>
					</xsl:when>
					<xsl:when test="string($first)='bali'">
						<xsl:value-of select="string('ban')"/>
					</xsl:when>
					<xsl:when test="string($first)='baski'">
						<xsl:value-of select="string('baq/eus')"/>
					</xsl:when>
					<xsl:when test="string($first)='basaa'">
						<xsl:value-of select="string('bas')"/>
					</xsl:when>
					<xsl:when test="string($first)='balti keeled'">
						<xsl:value-of select="string('bat')"/>
					</xsl:when>
					<xsl:when test="string($first)='bedža'">
						<xsl:value-of select="string('bej')"/>
					</xsl:when>
					<xsl:when test="string($first)='valgevene'">
						<xsl:value-of select="string('bel')"/>
					</xsl:when>
					<xsl:when test="string($first)='bemba'">
						<xsl:value-of select="string('bem')"/>
					</xsl:when>
					<xsl:when test="string($first)='bengali'">
						<xsl:value-of select="string('ben')"/>
					</xsl:when>
					<xsl:when test="string($first)='berberi keeled'">
						<xsl:value-of select="string('ber')"/>
					</xsl:when>
					<xsl:when test="string($first)='bhodžpuri'">
						<xsl:value-of select="string('bho')"/>
					</xsl:when>
					<xsl:when test="string($first)='bihaari keeled'">
						<xsl:value-of select="string('bih')"/>
					</xsl:when>
					<xsl:when test="string($first)='bikoli'">
						<xsl:value-of select="string('bik')"/>
					</xsl:when>
					<xsl:when test="string($first)='edo'">
						<xsl:value-of select="string('bin')"/>
					</xsl:when>
					<xsl:when test="string($first)='bislama'">
						<xsl:value-of select="string('bis')"/>
					</xsl:when>
					<xsl:when test="string($first)='mustjalaindiaani'">
						<xsl:value-of select="string('bla')"/>
					</xsl:when>
					<xsl:when test="string($first)='bantu keeled'">
						<xsl:value-of select="string('bnt')"/>
					</xsl:when>
					<xsl:when test="string($first)='bosnia'">
						<xsl:value-of select="string('bos')"/>
					</xsl:when>
					<xsl:when test="string($first)='bradži'">
						<xsl:value-of select="string('bra')"/>
					</xsl:when>
					<xsl:when test="string($first)='bretooni'">
						<xsl:value-of select="string('bre')"/>
					</xsl:when>
					<xsl:when test="string($first)='bataki keeled'">
						<xsl:value-of select="string('btk')"/>
					</xsl:when>
					<xsl:when test="string($first)='burjaadi'">
						<xsl:value-of select="string('bua')"/>
					</xsl:when>
					<xsl:when test="string($first)='bugi'">
						<xsl:value-of select="string('bug')"/>
					</xsl:when>
					<xsl:when test="string($first)='bulgaaria'">
						<xsl:value-of select="string('bul')"/>
					</xsl:when>
					<xsl:when test="string($first)='birma'">
						<xsl:value-of select="string('bur/mya')"/>
					</xsl:when>
					<xsl:when test="string($first)='bilini'">
						<xsl:value-of select="string('byn')"/>
					</xsl:when>
					<xsl:when test="string($first)='kado'">
						<xsl:value-of select="string('cad')"/>
					</xsl:when>
					<xsl:when test="string($first)='kesk-ameerika indiaani keeled'">
						<xsl:value-of select="string('cai')"/>
					</xsl:when>
					<xsl:when test="string($first)='kariibi'">
						<xsl:value-of select="string('car')"/>
					</xsl:when>
					<xsl:when test="string($first)='katalaani'">
						<xsl:value-of select="string('cat')"/>
					</xsl:when>
					<xsl:when test="string($first)='kaukaasia keeled'">
						<xsl:value-of select="string('cau')"/>
					</xsl:when>
					<xsl:when test="string($first)='sebu'">
						<xsl:value-of select="string('ceb')"/>
					</xsl:when>
					<xsl:when test="string($first)='keldi keeled'">
						<xsl:value-of select="string('cel')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšamorro'">
						<xsl:value-of select="string('cha')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšibtša'">
						<xsl:value-of select="string('chb')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšetšeeni'">
						<xsl:value-of select="string('che')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšagatai'">
						<xsl:value-of select="string('chg')"/>
					</xsl:when>
					<xsl:when test="string($first)='hiina'">
						<xsl:value-of select="string('chi/zho')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšuugi'">
						<xsl:value-of select="string('chk')"/>
					</xsl:when>
					<xsl:when test="string($first)='mari'">
						<xsl:value-of select="string('chm')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšinuki žargoon'">
						<xsl:value-of select="string('chn')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšokto'">
						<xsl:value-of select="string('cho')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšipevai'">
						<xsl:value-of select="string('chp')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšerokii'">
						<xsl:value-of select="string('chr')"/>
					</xsl:when>
					<xsl:when test="string($first)='kirikuslaavi'">
						<xsl:value-of select="string('chu')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšuvaši'">
						<xsl:value-of select="string('chv')"/>
					</xsl:when>
					<xsl:when test="string($first)='šaieeni'">
						<xsl:value-of select="string('chy')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšaami keeled'">
						<xsl:value-of select="string('cmc')"/>
					</xsl:when>
					<xsl:when test="string($first)='kopti'">
						<xsl:value-of select="string('cop')"/>
					</xsl:when>
					<xsl:when test="string($first)='korni'">
						<xsl:value-of select="string('cor')"/>
					</xsl:when>
					<xsl:when test="string($first)='korsika'">
						<xsl:value-of select="string('cos')"/>
					</xsl:when>
					<xsl:when test="string($first)='inglispõhjalised kreool- ja pidžinkeeled'">
						<xsl:value-of select="string('cpe')"/>
					</xsl:when>
					<xsl:when test="string($first)='prantsuspõhjalised kreool- ja pidžinkeeled'">
						<xsl:value-of select="string('cpf')"/>
					</xsl:when>
					<xsl:when test="string($first)='portugalipõhjalised kreool- ja pidžinkeeled'">
						<xsl:value-of select="string('cpp')"/>
					</xsl:when>
					<xsl:when test="string($first)='krii'">
						<xsl:value-of select="string('cre')"/>
					</xsl:when>
					<xsl:when test="string($first)='krimmitatari'">
						<xsl:value-of select="string('crh')"/>
					</xsl:when>
					<xsl:when test="string($first)='kreool- ja pidžinkeeled'">
						<xsl:value-of select="string('crp')"/>
					</xsl:when>
					<xsl:when test="string($first)='kašuubi'">
						<xsl:value-of select="string('csb')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšehhi'">
						<xsl:value-of select="string('cze/ces')"/>
					</xsl:when>
					<xsl:when test="string($first)='kuši keeled'">
						<xsl:value-of select="string('cus')"/>
					</xsl:when>
					<xsl:when test="string($first)='dakota'">
						<xsl:value-of select="string('dak')"/>
					</xsl:when>
					<xsl:when test="string($first)='taani'">
						<xsl:value-of select="string('dan')"/>
					</xsl:when>
					<xsl:when test="string($first)='dargi'">
						<xsl:value-of select="string('dar')"/>
					</xsl:when>
					<xsl:when test="string($first)='sisemaadajaki keeled'">
						<xsl:value-of select="string('day')"/>
					</xsl:when>
					<xsl:when test="string($first)='delavari'">
						<xsl:value-of select="string('del')"/>
					</xsl:when>
					<xsl:when test="string($first)='sleivi'">
						<xsl:value-of select="string('den')"/>
					</xsl:when>
					<xsl:when test="string($first)='dogribi'">
						<xsl:value-of select="string('dgr')"/>
					</xsl:when>
					<xsl:when test="string($first)='dinka'">
						<xsl:value-of select="string('din')"/>
					</xsl:when>
					<xsl:when test="string($first)='maldiivi'">
						<xsl:value-of select="string('div')"/>
					</xsl:when>
					<xsl:when test="string($first)='dogri'">
						<xsl:value-of select="string('doi')"/>
					</xsl:when>
					<xsl:when test="string($first)='draviidi keeled'">
						<xsl:value-of select="string('dra')"/>
					</xsl:when>
					<xsl:when test="string($first)='alamsorbi'">
						<xsl:value-of select="string('dsb')"/>
					</xsl:when>
					<xsl:when test="string($first)='dzongkha'">
						<xsl:value-of select="string('dzo')"/>
					</xsl:when>
					<xsl:when test="string($first)='duala'">
						<xsl:value-of select="string('dua')"/>
					</xsl:when>
					<xsl:when test="string($first)='keskhollandi (u 1050–1350)'">
						<xsl:value-of select="string('dum')"/>
					</xsl:when>
					<xsl:when test="string($first)='hollandi'">
						<xsl:value-of select="string('dut/nld')"/>
					</xsl:when>
					<xsl:when test="string($first)='djula'">
						<xsl:value-of select="string('dyu')"/>
					</xsl:when>
					<xsl:when test="string($first)='efiki'">
						<xsl:value-of select="string('efi')"/>
					</xsl:when>
					<xsl:when test="string($first)='egiptuse'">
						<xsl:value-of select="string('egy')"/>
					</xsl:when>
					<xsl:when test="string($first)='ekadžuki'">
						<xsl:value-of select="string('eka')"/>
					</xsl:when>
					<xsl:when test="string($first)='eelami'">
						<xsl:value-of select="string('elx')"/>
					</xsl:when>
					<xsl:when test="string($first)='inglise'">
						<xsl:value-of select="string('eng')"/>
					</xsl:when>
					<xsl:when test="string($first)='keskinglise (1100–1500)'">
						<xsl:value-of select="string('enm')"/>
					</xsl:when>
					<xsl:when test="string($first)='esperanto'">
						<xsl:value-of select="string('epo')"/>
					</xsl:when>
					<xsl:when test="string($first)='eesti viipekeel'">
						<xsl:value-of select="string('eso')"/>
					</xsl:when>
					<xsl:when test="string($first)='eesti'">
						<xsl:value-of select="string('est')"/>
					</xsl:when>
					<xsl:when test="string($first)='eve'">
						<xsl:value-of select="string('ewe')"/>
					</xsl:when>
					<xsl:when test="string($first)='evondo'">
						<xsl:value-of select="string('ewo')"/>
					</xsl:when>
					<xsl:when test="string($first)='fangi'">
						<xsl:value-of select="string('fan')"/>
					</xsl:when>
					<xsl:when test="string($first)='fääri'">
						<xsl:value-of select="string('fao')"/>
					</xsl:when>
					<xsl:when test="string($first)='fanti'">
						<xsl:value-of select="string('fat')"/>
					</xsl:when>
					<xsl:when test="string($first)='fidži'">
						<xsl:value-of select="string('fij')"/>
					</xsl:when>
					<xsl:when test="string($first)='filipiini'">
						<xsl:value-of select="string('fil')"/>
					</xsl:when>
					<xsl:when test="string($first)='soome'">
						<xsl:value-of select="string('fin')"/>
					</xsl:when>
					<xsl:when test="string($first)='soome-ugri keeled'">
						<xsl:value-of select="string('fiu')"/>
					</xsl:when>
					<xsl:when test="string($first)='foni'">
						<xsl:value-of select="string('fon')"/>
					</xsl:when>
					<xsl:when test="string($first)='prantsuse'">
						<xsl:value-of select="string('fre/fra')"/>
					</xsl:when>
					<xsl:when test="string($first)='keskprantsuse (1400–1600)'">
						<xsl:value-of select="string('frm')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanaprantsuse (842 – u 1400)'">
						<xsl:value-of select="string('fro')"/>
					</xsl:when>
					<xsl:when test="string($first)='põhjafriisi'">
						<xsl:value-of select="string('frr')"/>
					</xsl:when>
					<xsl:when test="string($first)='idafriisi'">
						<xsl:value-of select="string('frs')"/>
					</xsl:when>
					<xsl:when test="string($first)='friisi'">
						<xsl:value-of select="string('fry')"/>
					</xsl:when>
					<xsl:when test="string($first)='fula'">
						<xsl:value-of select="string('ful')"/>
					</xsl:when>
					<xsl:when test="string($first)='friuuli'">
						<xsl:value-of select="string('fur')"/>
					</xsl:when>
					<xsl:when test="string($first)='gaa'">
						<xsl:value-of select="string('gaa')"/>
					</xsl:when>
					<xsl:when test="string($first)='gagauusi'">
						<xsl:value-of select="string('gag')"/>
					</xsl:when>
					<xsl:when test="string($first)='gajo'">
						<xsl:value-of select="string('gay')"/>
					</xsl:when>
					<xsl:when test="string($first)='gbaja'">
						<xsl:value-of select="string('gba')"/>
					</xsl:when>
					<xsl:when test="string($first)='germaani keeled'">
						<xsl:value-of select="string('gem')"/>
					</xsl:when>
					<xsl:when test="string($first)='gruusia'">
						<xsl:value-of select="string('geo/kat')"/>
					</xsl:when>
					<xsl:when test="string($first)='saksa'">
						<xsl:value-of select="string('ger/deu')"/>
					</xsl:when>
					<xsl:when test="string($first)='geezi'">
						<xsl:value-of select="string('gez')"/>
					</xsl:when>
					<xsl:when test="string($first)='kiribati'">
						<xsl:value-of select="string('gil')"/>
					</xsl:when>
					<xsl:when test="string($first)='gaeli'">
						<xsl:value-of select="string('gla')"/>
					</xsl:when>
					<xsl:when test="string($first)='iiri'">
						<xsl:value-of select="string('gle')"/>
					</xsl:when>
					<xsl:when test="string($first)='galeegi'">
						<xsl:value-of select="string('glg')"/>
					</xsl:when>
					<xsl:when test="string($first)='mänksi'">
						<xsl:value-of select="string('glv')"/>
					</xsl:when>
					<xsl:when test="string($first)='keskülemsaksa (u 1050–1500)'">
						<xsl:value-of select="string('gmh')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanaülemsaksa (u 750–1050)'">
						<xsl:value-of select="string('goh')"/>
					</xsl:when>
					<xsl:when test="string($first)='gondi'">
						<xsl:value-of select="string('gon')"/>
					</xsl:when>
					<xsl:when test="string($first)='gorontalo'">
						<xsl:value-of select="string('gor')"/>
					</xsl:when>
					<xsl:when test="string($first)='gooti'">
						<xsl:value-of select="string('got')"/>
					</xsl:when>
					<xsl:when test="string($first)='grebo'">
						<xsl:value-of select="string('grb')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanakreeka (1453. a-ni)'">
						<xsl:value-of select="string('grc')"/>
					</xsl:when>
					<xsl:when test="string($first)='kreeka (pärast 1453. a)'">
						<xsl:value-of select="string('gre/ell')"/>
					</xsl:when>
					<xsl:when test="string($first)='kreeka'">
						<xsl:value-of select="string('gre/ell')"/>
					</xsl:when>
					<xsl:when test="string($first)='guaranii'">
						<xsl:value-of select="string('grn')"/>
					</xsl:when>
					<xsl:when test="string($first)='šveitsisaksa'">
						<xsl:value-of select="string('gsw')"/>
					</xsl:when>
					<xsl:when test="string($first)='gudžarati'">
						<xsl:value-of select="string('guj')"/>
					</xsl:when>
					<xsl:when test="string($first)='gvitšini'">
						<xsl:value-of select="string('gwi')"/>
					</xsl:when>
					<xsl:when test="string($first)='haida'">
						<xsl:value-of select="string('hai')"/>
					</xsl:when>
					<xsl:when test="string($first)='haiti'">
						<xsl:value-of select="string('hat')"/>
					</xsl:when>
					<xsl:when test="string($first)='hausa'">
						<xsl:value-of select="string('hau')"/>
					</xsl:when>
					<xsl:when test="string($first)='havai'">
						<xsl:value-of select="string('haw')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanaheebrea keel'">
						<xsl:value-of select="string('hbo')"/>
					</xsl:when>
					<xsl:when test="string($first)='serbia-horvaadi '">
						<xsl:value-of select="string('hbs')"/>
					</xsl:when>
					<xsl:when test="string($first)='heebrea'">
						<xsl:value-of select="string('heb')"/>
					</xsl:when>
					<xsl:when test="string($first)='herero'">
						<xsl:value-of select="string('her')"/>
					</xsl:when>
					<xsl:when test="string($first)='hiligainoni'">
						<xsl:value-of select="string('hil')"/>
					</xsl:when>
					<xsl:when test="string($first)='himatšali keeled'">
						<xsl:value-of select="string('him')"/>
					</xsl:when>
					<xsl:when test="string($first)='hindi'">
						<xsl:value-of select="string('hin')"/>
					</xsl:when>
					<xsl:when test="string($first)='heti'">
						<xsl:value-of select="string('hit')"/>
					</xsl:when>
					<xsl:when test="string($first)='hmongi'">
						<xsl:value-of select="string('hmn')"/>
					</xsl:when>
					<xsl:when test="string($first)='hirimotu'">
						<xsl:value-of select="string('hmo')"/>
					</xsl:when>
					<xsl:when test="string($first)='horvaadi'">
						<xsl:value-of select="string('hrv')"/>
					</xsl:when>
					<xsl:when test="string($first)='ülemsorbi'">
						<xsl:value-of select="string('hsb')"/>
					</xsl:when>
					<xsl:when test="string($first)='ungari'">
						<xsl:value-of select="string('hun')"/>
					</xsl:when>
					<xsl:when test="string($first)='hupa'">
						<xsl:value-of select="string('hup')"/>
					</xsl:when>
					<xsl:when test="string($first)='ibani'">
						<xsl:value-of select="string('iba')"/>
					</xsl:when>
					<xsl:when test="string($first)='ibo'">
						<xsl:value-of select="string('ibo')"/>
					</xsl:when>
					<xsl:when test="string($first)='islandi'">
						<xsl:value-of select="string('ice/isl')"/>
					</xsl:when>
					<xsl:when test="string($first)='ido'">
						<xsl:value-of select="string('ido')"/>
					</xsl:when>
					<xsl:when test="string($first)='nuosu'">
						<xsl:value-of select="string('iii')"/>
					</xsl:when>
					<xsl:when test="string($first)='idžo keeled'">
						<xsl:value-of select="string('ijo')"/>
					</xsl:when>
					<xsl:when test="string($first)='inuktituti'">
						<xsl:value-of select="string('iku')"/>
					</xsl:when>
					<xsl:when test="string($first)='interlingue'">
						<xsl:value-of select="string('ile')"/>
					</xsl:when>
					<xsl:when test="string($first)='iloko'">
						<xsl:value-of select="string('ilo')"/>
					</xsl:when>
					<xsl:when test="string($first)='rahvusvaheline viipekeel'">
						<xsl:value-of select="string('ils')"/>
					</xsl:when>
					<xsl:when test="string($first)='interlingua'">
						<xsl:value-of select="string('ina')"/>
					</xsl:when>
					<xsl:when test="string($first)='india keeled'">
						<xsl:value-of select="string('inc')"/>
					</xsl:when>
					<xsl:when test="string($first)='indoneesia'">
						<xsl:value-of select="string('ind')"/>
					</xsl:when>
					<xsl:when test="string($first)='indoeuroopa keeled'">
						<xsl:value-of select="string('ine')"/>
					</xsl:when>
					<xsl:when test="string($first)='inguši'">
						<xsl:value-of select="string('inh')"/>
					</xsl:when>
					<xsl:when test="string($first)='injupiaki'">
						<xsl:value-of select="string('ipk')"/>
					</xsl:when>
					<xsl:when test="string($first)='Iraani keeled'">
						<xsl:value-of select="string('ira')"/>
					</xsl:when>
					<xsl:when test="string($first)='irokeesi keeled'">
						<xsl:value-of select="string('iro')"/>
					</xsl:when>
					<xsl:when test="string($first)='isuri'">
						<xsl:value-of select="string('izh')"/>
					</xsl:when>
					<xsl:when test="string($first)='itaalia'">
						<xsl:value-of select="string('ita')"/>
					</xsl:when>
					<xsl:when test="string($first)='jaava'">
						<xsl:value-of select="string('jav')"/>
					</xsl:when>
					<xsl:when test="string($first)='ložban'">
						<xsl:value-of select="string('jbo')"/>
					</xsl:when>
					<xsl:when test="string($first)='jaapani'">
						<xsl:value-of select="string('jpn')"/>
					</xsl:when>
					<xsl:when test="string($first)='juudipärsia'">
						<xsl:value-of select="string('jpr')"/>
					</xsl:when>
					<xsl:when test="string($first)='juudiaraabia'">
						<xsl:value-of select="string('jrb')"/>
					</xsl:when>
					<xsl:when test="string($first)='karakalpaki'">
						<xsl:value-of select="string('kaa')"/>
					</xsl:when>
					<xsl:when test="string($first)='kabiili'">
						<xsl:value-of select="string('kab')"/>
					</xsl:when>
					<xsl:when test="string($first)='katšini'">
						<xsl:value-of select="string('kac')"/>
					</xsl:when>
					<xsl:when test="string($first)='grööni'">
						<xsl:value-of select="string('kal')"/>
					</xsl:when>
					<xsl:when test="string($first)='kamba'">
						<xsl:value-of select="string('kam')"/>
					</xsl:when>
					<xsl:when test="string($first)='kannada'">
						<xsl:value-of select="string('kan')"/>
					</xsl:when>
					<xsl:when test="string($first)='kareni keeled'">
						<xsl:value-of select="string('kar')"/>
					</xsl:when>
					<xsl:when test="string($first)='kašmiiri'">
						<xsl:value-of select="string('kas')"/>
					</xsl:when>
					<xsl:when test="string($first)='kasahhi'">
						<xsl:value-of select="string('kaz')"/>
					</xsl:when>
					<xsl:when test="string($first)='kanuri'">
						<xsl:value-of select="string('kau')"/>
					</xsl:when>
					<xsl:when test="string($first)='kaavi'">
						<xsl:value-of select="string('kaw')"/>
					</xsl:when>
					<xsl:when test="string($first)='kabardi-tšerkessi'">
						<xsl:value-of select="string('kbd')"/>
					</xsl:when>
					<xsl:when test="string($first)='khasi'">
						<xsl:value-of select="string('kha')"/>
					</xsl:when>
					<xsl:when test="string($first)='khoisani keeled'">
						<xsl:value-of select="string('khi')"/>
					</xsl:when>
					<xsl:when test="string($first)='khmeeri'">
						<xsl:value-of select="string('khm')"/>
					</xsl:when>
					<xsl:when test="string($first)='saka'">
						<xsl:value-of select="string('kho')"/>
					</xsl:when>
					<xsl:when test="string($first)='kikuju'">
						<xsl:value-of select="string('kik')"/>
					</xsl:when>
					<xsl:when test="string($first)='ruanda'">
						<xsl:value-of select="string('kin')"/>
					</xsl:when>
					<xsl:when test="string($first)='kirgiisi'">
						<xsl:value-of select="string('kir')"/>
					</xsl:when>
					<xsl:when test="string($first)='hakassi'">
						<xsl:value-of select="string('kjh')"/>
					</xsl:when>
					<xsl:when test="string($first)='mbundu'">
						<xsl:value-of select="string('kmb')"/>
					</xsl:when>
					<xsl:when test="string($first)='permikomi'">
						<xsl:value-of select="string('koi')"/>
					</xsl:when>
					<xsl:when test="string($first)='konkani'">
						<xsl:value-of select="string('kok')"/>
					</xsl:when>
					<xsl:when test="string($first)='komi'">
						<xsl:value-of select="string('kom')"/>
					</xsl:when>
					<xsl:when test="string($first)='kongo'">
						<xsl:value-of select="string('kon')"/>
					</xsl:when>
					<xsl:when test="string($first)='korea'">
						<xsl:value-of select="string('kor')"/>
					</xsl:when>
					<xsl:when test="string($first)='kosrae'">
						<xsl:value-of select="string('kos')"/>
					</xsl:when>
					<xsl:when test="string($first)='kpelle'">
						<xsl:value-of select="string('kpe')"/>
					</xsl:when>
					<xsl:when test="string($first)='karatšai-balkaari'">
						<xsl:value-of select="string('krc')"/>
					</xsl:when>
					<xsl:when test="string($first)='karjala'">
						<xsl:value-of select="string('krl')"/>
					</xsl:when>
					<xsl:when test="string($first)='kruu keeled'">
						<xsl:value-of select="string('kro')"/>
					</xsl:when>
					<xsl:when test="string($first)='kuruhhi'">
						<xsl:value-of select="string('kru')"/>
					</xsl:when>
					<xsl:when test="string($first)='kvanjama (ambo)'">
						<xsl:value-of select="string('kua')"/>
					</xsl:when>
					<xsl:when test="string($first)='kumõki'">
						<xsl:value-of select="string('kum')"/>
					</xsl:when>
					<xsl:when test="string($first)='kurdi'">
						<xsl:value-of select="string('kur')"/>
					</xsl:when>
					<xsl:when test="string($first)='kutenai'">
						<xsl:value-of select="string('kut')"/>
					</xsl:when>
					<xsl:when test="string($first)='ladiino'">
						<xsl:value-of select="string('lad')"/>
					</xsl:when>
					<xsl:when test="string($first)='lahnda'">
						<xsl:value-of select="string('lah')"/>
					</xsl:when>
					<xsl:when test="string($first)='lamba'">
						<xsl:value-of select="string('lam')"/>
					</xsl:when>
					<xsl:when test="string($first)='lao'">
						<xsl:value-of select="string('lao')"/>
					</xsl:when>
					<xsl:when test="string($first)='ladina'">
						<xsl:value-of select="string('lat')"/>
					</xsl:when>
					<xsl:when test="string($first)='läti'">
						<xsl:value-of select="string('lav')"/>
					</xsl:when>
					<xsl:when test="string($first)='laki'">
						<xsl:value-of select="string('lbe')"/>
					</xsl:when>
					<xsl:when test="string($first)='lesgi'">
						<xsl:value-of select="string('lez')"/>
					</xsl:when>
					<xsl:when test="string($first)='limburgi'">
						<xsl:value-of select="string('lim')"/>
					</xsl:when>
					<xsl:when test="string($first)='lingala'">
						<xsl:value-of select="string('lin')"/>
					</xsl:when>
					<xsl:when test="string($first)='leedu'">
						<xsl:value-of select="string('lit')"/>
					</xsl:when>
					<xsl:when test="string($first)='liivi'">
						<xsl:value-of select="string('liv')"/>
					</xsl:when>
					<xsl:when test="string($first)='mongo'">
						<xsl:value-of select="string('lol')"/>
					</xsl:when>
					<xsl:when test="string($first)='lozi'">
						<xsl:value-of select="string('loz')"/>
					</xsl:when>
					<xsl:when test="string($first)='letseburgi'">
						<xsl:value-of select="string('ltz')"/>
					</xsl:when>
					<xsl:when test="string($first)='kasai luba'">
						<xsl:value-of select="string('lua')"/>
					</xsl:when>
					<xsl:when test="string($first)='katanga luba'">
						<xsl:value-of select="string('lub')"/>
					</xsl:when>
					<xsl:when test="string($first)='ganda'">
						<xsl:value-of select="string('lug')"/>
					</xsl:when>
					<xsl:when test="string($first)='luisenjo'">
						<xsl:value-of select="string('lui')"/>
					</xsl:when>
					<xsl:when test="string($first)='lunda'">
						<xsl:value-of select="string('lun')"/>
					</xsl:when>
					<xsl:when test="string($first)='luo (keenia ja tansaania)'">
						<xsl:value-of select="string('luo')"/>
					</xsl:when>
					<xsl:when test="string($first)='mizo'">
						<xsl:value-of select="string('lus')"/>
					</xsl:when>
					<xsl:when test="string($first)='makedoonia'">
						<xsl:value-of select="string('mac/mkd')"/>
					</xsl:when>
					<xsl:when test="string($first)='madura'">
						<xsl:value-of select="string('mad')"/>
					</xsl:when>
					<xsl:when test="string($first)='magahi'">
						<xsl:value-of select="string('mag')"/>
					</xsl:when>
					<xsl:when test="string($first)='maršalli'">
						<xsl:value-of select="string('mah')"/>
					</xsl:when>
					<xsl:when test="string($first)='maithili'">
						<xsl:value-of select="string('mai')"/>
					</xsl:when>
					<xsl:when test="string($first)='makassari'">
						<xsl:value-of select="string('mak')"/>
					</xsl:when>
					<xsl:when test="string($first)='malajalami'">
						<xsl:value-of select="string('mal')"/>
					</xsl:when>
					<xsl:when test="string($first)='malinke'">
						<xsl:value-of select="string('man')"/>
					</xsl:when>
					<xsl:when test="string($first)='maoori'">
						<xsl:value-of select="string('mao/mri')"/>
					</xsl:when>
					<xsl:when test="string($first)='austroneesia keeled'">
						<xsl:value-of select="string('map')"/>
					</xsl:when>
					<xsl:when test="string($first)='marathi'">
						<xsl:value-of select="string('mar')"/>
					</xsl:when>
					<xsl:when test="string($first)='maasai'">
						<xsl:value-of select="string('mas')"/>
					</xsl:when>
					<xsl:when test="string($first)='malai'">
						<xsl:value-of select="string('may/msa')"/>
					</xsl:when>
					<xsl:when test="string($first)='mokša'">
						<xsl:value-of select="string('mdf')"/>
					</xsl:when>
					<xsl:when test="string($first)='mandari'">
						<xsl:value-of select="string('mdr')"/>
					</xsl:when>
					<xsl:when test="string($first)='mende'">
						<xsl:value-of select="string('men')"/>
					</xsl:when>
					<xsl:when test="string($first)='mauritiuse kreoolkeel'">
						<xsl:value-of select="string('mfe')"/>
					</xsl:when>
					<xsl:when test="string($first)='keskiiri (900–1200)'">
						<xsl:value-of select="string('mga')"/>
					</xsl:when>
					<xsl:when test="string($first)='mikmaki'">
						<xsl:value-of select="string('mic')"/>
					</xsl:when>
					<xsl:when test="string($first)='minangkabau'">
						<xsl:value-of select="string('min')"/>
					</xsl:when>
					<xsl:when test="string($first)='kodeerimata keeled'">
						<xsl:value-of select="string('mis')"/>
					</xsl:when>
					<xsl:when test="string($first)='moni-khmeeri keeled'">
						<xsl:value-of select="string('mkh')"/>
					</xsl:when>
					<xsl:when test="string($first)='malagassi'">
						<xsl:value-of select="string('mlg')"/>
					</xsl:when>
					<xsl:when test="string($first)='malta'">
						<xsl:value-of select="string('mlt')"/>
					</xsl:when>
					<xsl:when test="string($first)='mandžu'">
						<xsl:value-of select="string('mnc')"/>
					</xsl:when>
					<xsl:when test="string($first)='manipuri'">
						<xsl:value-of select="string('mni')"/>
					</xsl:when>
					<xsl:when test="string($first)='manobo keeled'">
						<xsl:value-of select="string('mno')"/>
					</xsl:when>
					<xsl:when test="string($first)='mohoogi'">
						<xsl:value-of select="string('moh')"/>
					</xsl:when>
					<xsl:when test="string($first)='moldova'">
						<xsl:value-of select="string('mol')"/>
					</xsl:when>
					<xsl:when test="string($first)='mongoli'">
						<xsl:value-of select="string('mon')"/>
					</xsl:when>
					<xsl:when test="string($first)='moore'">
						<xsl:value-of select="string('mos')"/>
					</xsl:when>
					<xsl:when test="string($first)='mitu keelt'">
						<xsl:value-of select="string('mul')"/>
					</xsl:when>
					<xsl:when test="string($first)='munda keeled'">
						<xsl:value-of select="string('mun')"/>
					</xsl:when>
					<xsl:when test="string($first)='maskogi'">
						<xsl:value-of select="string('mus')"/>
					</xsl:when>
					<xsl:when test="string($first)='miranda'">
						<xsl:value-of select="string('mwl')"/>
					</xsl:when>
					<xsl:when test="string($first)='maarvari'">
						<xsl:value-of select="string('mwr')"/>
					</xsl:when>
					<xsl:when test="string($first)='maaja keeled'">
						<xsl:value-of select="string('myn')"/>
					</xsl:when>
					<xsl:when test="string($first)='ersa'">
						<xsl:value-of select="string('myv')"/>
					</xsl:when>
					<xsl:when test="string($first)='asteegi keeled'">
						<xsl:value-of select="string('nah')"/>
					</xsl:when>
					<xsl:when test="string($first)='põhja-ameerika indiaani keeled'">
						<xsl:value-of select="string('nai')"/>
					</xsl:when>
					<xsl:when test="string($first)='napoli'">
						<xsl:value-of select="string('nap')"/>
					</xsl:when>
					<xsl:when test="string($first)='nauru'">
						<xsl:value-of select="string('nau')"/>
					</xsl:when>
					<xsl:when test="string($first)='navaho'">
						<xsl:value-of select="string('nav')"/>
					</xsl:when>
					<xsl:when test="string($first)='lõunandebele'">
						<xsl:value-of select="string('nbl')"/>
					</xsl:when>
					<xsl:when test="string($first)='ndebele'">
						<xsl:value-of select="string('nde')"/>
					</xsl:when>
					<xsl:when test="string($first)='ndonga'">
						<xsl:value-of select="string('ndo')"/>
					</xsl:when>
					<xsl:when test="string($first)='alamsaksa'">
						<xsl:value-of select="string('nds')"/>
					</xsl:when>
					<xsl:when test="string($first)='nepali'">
						<xsl:value-of select="string('nep')"/>
					</xsl:when>
					<xsl:when test="string($first)='nevari'">
						<xsl:value-of select="string('new')"/>
					</xsl:when>
					<xsl:when test="string($first)='niasi'">
						<xsl:value-of select="string('nia')"/>
					</xsl:when>
					<xsl:when test="string($first)='nigeri-kordofani keeled'">
						<xsl:value-of select="string('nic')"/>
					</xsl:when>
					<xsl:when test="string($first)='niue'">
						<xsl:value-of select="string('niu')"/>
					</xsl:when>
					<xsl:when test="string($first)='uusnorra'">
						<xsl:value-of select="string('nno')"/>
					</xsl:when>
					<xsl:when test="string($first)='norra bokmål'">
						<xsl:value-of select="string('nob')"/>
					</xsl:when>
					<xsl:when test="string($first)='nogai'">
						<xsl:value-of select="string('nog')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanapõhja'">
						<xsl:value-of select="string('non')"/>
					</xsl:when>
					<xsl:when test="string($first)='norra'">
						<xsl:value-of select="string('nor')"/>
					</xsl:when>
					<xsl:when test="string($first)='nkoo'">
						<xsl:value-of select="string('nqo')"/>
					</xsl:when>
					<xsl:when test="string($first)='pedi'">
						<xsl:value-of select="string('nso')"/>
					</xsl:when>
					<xsl:when test="string($first)='nzima'">
						<xsl:value-of select="string('nzi')"/>
					</xsl:when>
					<xsl:when test="string($first)='Nuubia keeled'">
						<xsl:value-of select="string('nub')"/>
					</xsl:when>
					<xsl:when test="string($first)='vananevari'">
						<xsl:value-of select="string('nwc')"/>
					</xsl:when>
					<xsl:when test="string($first)='njandža'">
						<xsl:value-of select="string('nya')"/>
					</xsl:when>
					<xsl:when test="string($first)='njamvesi'">
						<xsl:value-of select="string('nym')"/>
					</xsl:when>
					<xsl:when test="string($first)='njankole'">
						<xsl:value-of select="string('nyn')"/>
					</xsl:when>
					<xsl:when test="string($first)='njoro'">
						<xsl:value-of select="string('nyo')"/>
					</xsl:when>
					<xsl:when test="string($first)='oksitaani (pärast 1500. a)'">
						<xsl:value-of select="string('oci')"/>
					</xsl:when>
					<xsl:when test="string($first)='odžibvei'">
						<xsl:value-of select="string('oji')"/>
					</xsl:when>
					<xsl:when test="string($first)='oria'">
						<xsl:value-of select="string('ori')"/>
					</xsl:when>
					<xsl:when test="string($first)='oromo'">
						<xsl:value-of select="string('orm')"/>
					</xsl:when>
					<xsl:when test="string($first)='oseidži'">
						<xsl:value-of select="string('osa')"/>
					</xsl:when>
					<xsl:when test="string($first)='osseedi'">
						<xsl:value-of select="string('oss')"/>
					</xsl:when>
					<xsl:when test="string($first)='osmanitürgi (1500-1928)'">
						<xsl:value-of select="string('ota')"/>
					</xsl:when>
					<xsl:when test="string($first)='otomi keeled'">
						<xsl:value-of select="string('oto')"/>
					</xsl:when>
					<xsl:when test="string($first)='paapua keeled'">
						<xsl:value-of select="string('paa')"/>
					</xsl:when>
					<xsl:when test="string($first)='pangasinani'">
						<xsl:value-of select="string('pag')"/>
					</xsl:when>
					<xsl:when test="string($first)='pahlavi'">
						<xsl:value-of select="string('pal')"/>
					</xsl:when>
					<xsl:when test="string($first)='pampanga'">
						<xsl:value-of select="string('pam')"/>
					</xsl:when>
					<xsl:when test="string($first)='pandžabi'">
						<xsl:value-of select="string('pan')"/>
					</xsl:when>
					<xsl:when test="string($first)='papiamento'">
						<xsl:value-of select="string('pap')"/>
					</xsl:when>
					<xsl:when test="string($first)='belau'">
						<xsl:value-of select="string('pau')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanapärsia (u 600–400 eKr)'">
						<xsl:value-of select="string('peo')"/>
					</xsl:when>
					<xsl:when test="string($first)='pärsia'">
						<xsl:value-of select="string('per/fas')"/>
					</xsl:when>
					<xsl:when test="string($first)='filipiini keeled'">
						<xsl:value-of select="string('phi')"/>
					</xsl:when>
					<xsl:when test="string($first)='foiniikia'">
						<xsl:value-of select="string('phn')"/>
					</xsl:when>
					<xsl:when test="string($first)='paali'">
						<xsl:value-of select="string('pli')"/>
					</xsl:when>
					<xsl:when test="string($first)='poola'">
						<xsl:value-of select="string('pol')"/>
					</xsl:when>
					<xsl:when test="string($first)='poonpei'">
						<xsl:value-of select="string('pon')"/>
					</xsl:when>
					<xsl:when test="string($first)='portugali'">
						<xsl:value-of select="string('por')"/>
					</xsl:when>
					<xsl:when test="string($first)='praakriti keeled'">
						<xsl:value-of select="string('pra')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanaprovansi (1500. a-ni)'">
						<xsl:value-of select="string('pro')"/>
					</xsl:when>
					<xsl:when test="string($first)='puštu'">
						<xsl:value-of select="string('pus')"/>
					</xsl:when>
					<xsl:when test="string($first)='ketšua'">
						<xsl:value-of select="string('que')"/>
					</xsl:when>
					<xsl:when test="string($first)='radžastani'">
						<xsl:value-of select="string('raj')"/>
					</xsl:when>
					<xsl:when test="string($first)='rapanui'">
						<xsl:value-of select="string('rap')"/>
					</xsl:when>
					<xsl:when test="string($first)='rarotonga'">
						<xsl:value-of select="string('rar')"/>
					</xsl:when>
					<xsl:when test="string($first)='romaani keeled'">
						<xsl:value-of select="string('roa')"/>
					</xsl:when>
					<xsl:when test="string($first)='romanši'">
						<xsl:value-of select="string('roh')"/>
					</xsl:when>
					<xsl:when test="string($first)='mustlaskeel'">
						<xsl:value-of select="string('rom')"/>
					</xsl:when>
					<xsl:when test="string($first)='vene viipekeel'">
						<xsl:value-of select="string('rsl')"/>
					</xsl:when>
					<xsl:when test="string($first)='rumeenia'">
						<xsl:value-of select="string('rum/ron')"/>
					</xsl:when>
					<xsl:when test="string($first)='rundi'">
						<xsl:value-of select="string('run')"/>
					</xsl:when>
					<xsl:when test="string($first)='aromuuni'">
						<xsl:value-of select="string('rup')"/>
					</xsl:when>
					<xsl:when test="string($first)='vene'">
						<xsl:value-of select="string('rus')"/>
					</xsl:when>
					<xsl:when test="string($first)='rutuli'">
						<xsl:value-of select="string('rut')"/>
					</xsl:when>
					<xsl:when test="string($first)='sandave'">
						<xsl:value-of select="string('sad')"/>
					</xsl:when>
					<xsl:when test="string($first)='sango'">
						<xsl:value-of select="string('sag')"/>
					</xsl:when>
					<xsl:when test="string($first)='jakuudi'">
						<xsl:value-of select="string('sah')"/>
					</xsl:when>
					<xsl:when test="string($first)='lõuna-ameerika indiaani keeled'">
						<xsl:value-of select="string('sai')"/>
					</xsl:when>
					<xsl:when test="string($first)='sališi keeled'">
						<xsl:value-of select="string('sal')"/>
					</xsl:when>
					<xsl:when test="string($first)='samaaria aramea'">
						<xsl:value-of select="string('sam')"/>
					</xsl:when>
					<xsl:when test="string($first)='sanskriti'">
						<xsl:value-of select="string('san')"/>
					</xsl:when>
					<xsl:when test="string($first)='sasaki'">
						<xsl:value-of select="string('sas')"/>
					</xsl:when>
					<xsl:when test="string($first)='santali'">
						<xsl:value-of select="string('sat')"/>
					</xsl:when>
					<xsl:when test="string($first)='sitsiilia'">
						<xsl:value-of select="string('scn')"/>
					</xsl:when>
					<xsl:when test="string($first)='šoti'">
						<xsl:value-of select="string('sco')"/>
					</xsl:when>
					<xsl:when test="string($first)='sölkupi'">
						<xsl:value-of select="string('sel')"/>
					</xsl:when>
					<xsl:when test="string($first)='semi keeled'">
						<xsl:value-of select="string('sem')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanaiiri (900. a-ni)'">
						<xsl:value-of select="string('sga')"/>
					</xsl:when>
					<xsl:when test="string($first)='viipekeeled'">
						<xsl:value-of select="string('sgn')"/>
					</xsl:when>
					<xsl:when test="string($first)='šani'">
						<xsl:value-of select="string('shn')"/>
					</xsl:when>
					<xsl:when test="string($first)='sidamo'">
						<xsl:value-of select="string('sid')"/>
					</xsl:when>
					<xsl:when test="string($first)='singali'">
						<xsl:value-of select="string('sin')"/>
					</xsl:when>
					<xsl:when test="string($first)='siuu keeled'">
						<xsl:value-of select="string('sio')"/>
					</xsl:when>
					<xsl:when test="string($first)='hiina-tiibeti keeled'">
						<xsl:value-of select="string('sit')"/>
					</xsl:when>
					<xsl:when test="string($first)='slaavi keeled'">
						<xsl:value-of select="string('sla')"/>
					</xsl:when>
					<xsl:when test="string($first)='slovaki'">
						<xsl:value-of select="string('slo/slk')"/>
					</xsl:when>
					<xsl:when test="string($first)='sloveeni'">
						<xsl:value-of select="string('slv')"/>
					</xsl:when>
					<xsl:when test="string($first)='lõunasaami'">
						<xsl:value-of select="string('sma')"/>
					</xsl:when>
					<xsl:when test="string($first)='põhjasaami'">
						<xsl:value-of select="string('sme')"/>
					</xsl:when>
					<xsl:when test="string($first)='saami keeled'">
						<xsl:value-of select="string('smi')"/>
					</xsl:when>
					<xsl:when test="string($first)='lule saami'">
						<xsl:value-of select="string('smj')"/>
					</xsl:when>
					<xsl:when test="string($first)='inari saami'">
						<xsl:value-of select="string('smn')"/>
					</xsl:when>
					<xsl:when test="string($first)='samoa'">
						<xsl:value-of select="string('smo')"/>
					</xsl:when>
					<xsl:when test="string($first)='koltasaami'">
						<xsl:value-of select="string('sms')"/>
					</xsl:when>
					<xsl:when test="string($first)='šona'">
						<xsl:value-of select="string('sna')"/>
					</xsl:when>
					<xsl:when test="string($first)='sindhi'">
						<xsl:value-of select="string('snd')"/>
					</xsl:when>
					<xsl:when test="string($first)='soninke'">
						<xsl:value-of select="string('snk')"/>
					</xsl:when>
					<xsl:when test="string($first)='sogdi'">
						<xsl:value-of select="string('sog')"/>
					</xsl:when>
					<xsl:when test="string($first)='somaali'">
						<xsl:value-of select="string('som')"/>
					</xsl:when>
					<xsl:when test="string($first)='songai keeled'">
						<xsl:value-of select="string('son')"/>
					</xsl:when>
					<xsl:when test="string($first)='sotho'">
						<xsl:value-of select="string('sot')"/>
					</xsl:when>
					<xsl:when test="string($first)='hispaania'">
						<xsl:value-of select="string('spa')"/>
					</xsl:when>
					<xsl:when test="string($first)='sardi'">
						<xsl:value-of select="string('srd')"/>
					</xsl:when>
					<xsl:when test="string($first)='sranani'">
						<xsl:value-of select="string('srn')"/>
					</xsl:when>
					<xsl:when test="string($first)='serbia'">
						<xsl:value-of select="string('scc/srp')"/>
					</xsl:when>
					<xsl:when test="string($first)='sereri'">
						<xsl:value-of select="string('srr')"/>
					</xsl:when>
					<xsl:when test="string($first)='niiluse-sahara keeled'">
						<xsl:value-of select="string('ssa')"/>
					</xsl:when>
					<xsl:when test="string($first)='svaasi'">
						<xsl:value-of select="string('ssw')"/>
					</xsl:when>
					<xsl:when test="string($first)='sukuma'">
						<xsl:value-of select="string('suk')"/>
					</xsl:when>
					<xsl:when test="string($first)='sunda'">
						<xsl:value-of select="string('sun')"/>
					</xsl:when>
					<xsl:when test="string($first)='susu'">
						<xsl:value-of select="string('sus')"/>
					</xsl:when>
					<xsl:when test="string($first)='sumeri'">
						<xsl:value-of select="string('sux')"/>
					</xsl:when>
					<xsl:when test="string($first)='suahiili'">
						<xsl:value-of select="string('swa')"/>
					</xsl:when>
					<xsl:when test="string($first)='rootsi'">
						<xsl:value-of select="string('swe')"/>
					</xsl:when>
					<xsl:when test="string($first)='vanasüüria'">
						<xsl:value-of select="string('syc')"/>
					</xsl:when>
					<xsl:when test="string($first)='süüria'">
						<xsl:value-of select="string('syr')"/>
					</xsl:when>
					<xsl:when test="string($first)='sapoteegi'">
						<xsl:value-of select="string('zap')"/>
					</xsl:when>
					<xsl:when test="string($first)='blissi sümbolid'">
						<xsl:value-of select="string('zbl')"/>
					</xsl:when>
					<xsl:when test="string($first)='zenaga'">
						<xsl:value-of select="string('zen')"/>
					</xsl:when>
					<xsl:when test="string($first)='maroko tamasikti kirjakeel'">
						<xsl:value-of select="string('zgh')"/>
					</xsl:when>
					<xsl:when test="string($first)='tšuangi'">
						<xsl:value-of select="string('zha')"/>
					</xsl:when>
					<xsl:when test="string($first)='zande keeled'">
						<xsl:value-of select="string('znd')"/>
					</xsl:when>
					<xsl:when test="string($first)='zaza'">
						<xsl:value-of select="string('zza')"/>
					</xsl:when>
					<xsl:when test="string($first)='suulu'">
						<xsl:value-of select="string('zul')"/>
					</xsl:when>
					<xsl:when test="string($first)='sunji'">
						<xsl:value-of select="string('zun')"/>
					</xsl:when>
					<xsl:when test="string($first)='keelelise sisuta'">
						<xsl:value-of select="string('zxx')"/>
					</xsl:when>
					<xsl:when test="string($first)='tahiti'">
						<xsl:value-of select="string('tah')"/>
					</xsl:when>
					<xsl:when test="string($first)='kami-tai keeled'">
						<xsl:value-of select="string('tai')"/>
					</xsl:when>
					<xsl:when test="string($first)='tamili'">
						<xsl:value-of select="string('tam')"/>
					</xsl:when>
					<xsl:when test="string($first)='tatari'">
						<xsl:value-of select="string('tat')"/>
					</xsl:when>
					<xsl:when test="string($first)='tulu'">
						<xsl:value-of select="string('tcy')"/>
					</xsl:when>
					<xsl:when test="string($first)='telugu'">
						<xsl:value-of select="string('tel')"/>
					</xsl:when>
					<xsl:when test="string($first)='temne'">
						<xsl:value-of select="string('tem')"/>
					</xsl:when>
					<xsl:when test="string($first)='terena'">
						<xsl:value-of select="string('ter')"/>
					</xsl:when>
					<xsl:when test="string($first)='tetumi'">
						<xsl:value-of select="string('tet')"/>
					</xsl:when>
					<xsl:when test="string($first)='tadžiki'">
						<xsl:value-of select="string('tgk')"/>
					</xsl:when>
					<xsl:when test="string($first)='tagalogi'">
						<xsl:value-of select="string('tgl')"/>
					</xsl:when>
					<xsl:when test="string($first)='tai'">
						<xsl:value-of select="string('tha')"/>
					</xsl:when>
					<xsl:when test="string($first)='tiibeti'">
						<xsl:value-of select="string('tib/bod')"/>
					</xsl:when>
					<xsl:when test="string($first)='tigree'">
						<xsl:value-of select="string('tig')"/>
					</xsl:when>
					<xsl:when test="string($first)='tigrinja'">
						<xsl:value-of select="string('tir')"/>
					</xsl:when>
					<xsl:when test="string($first)='tivi'">
						<xsl:value-of select="string('tiv')"/>
					</xsl:when>
					<xsl:when test="string($first)='tokelau'">
						<xsl:value-of select="string('tkl')"/>
					</xsl:when>
					<xsl:when test="string($first)='klingoni'">
						<xsl:value-of select="string('tlh')"/>
					</xsl:when>
					<xsl:when test="string($first)='tlingiti'">
						<xsl:value-of select="string('tli')"/>
					</xsl:when>
					<xsl:when test="string($first)='tamašeki'">
						<xsl:value-of select="string('tmh')"/>
					</xsl:when>
					<xsl:when test="string($first)='tonga (malawis)'">
						<xsl:value-of select="string('tog')"/>
					</xsl:when>
					<xsl:when test="string($first)='tonga (okeaanias)'">
						<xsl:value-of select="string('ton')"/>
					</xsl:when>
					<xsl:when test="string($first)='tok-pisini'">
						<xsl:value-of select="string('tpi')"/>
					</xsl:when>
					<xsl:when test="string($first)='tsimši keeled'">
						<xsl:value-of select="string('tsi')"/>
					</xsl:when>
					<xsl:when test="string($first)='tsvana'">
						<xsl:value-of select="string('tsn')"/>
					</xsl:when>
					<xsl:when test="string($first)='tsonga'">
						<xsl:value-of select="string('tso')"/>
					</xsl:when>
					<xsl:when test="string($first)='türkmeeni'">
						<xsl:value-of select="string('tuk')"/>
					</xsl:when>
					<xsl:when test="string($first)='tumbuka'">
						<xsl:value-of select="string('tum')"/>
					</xsl:when>
					<xsl:when test="string($first)='tupii keeled'">
						<xsl:value-of select="string('tup')"/>
					</xsl:when>
					<xsl:when test="string($first)='türgi'">
						<xsl:value-of select="string('tur')"/>
					</xsl:when>
					<xsl:when test="string($first)='altai keeled'">
						<xsl:value-of select="string('tut')"/>
					</xsl:when>
					<xsl:when test="string($first)='tvii'">
						<xsl:value-of select="string('twi')"/>
					</xsl:when>
					<xsl:when test="string($first)='tuvalu'">
						<xsl:value-of select="string('tvl')"/>
					</xsl:when>
					<xsl:when test="string($first)='tõva'">
						<xsl:value-of select="string('tyv')"/>
					</xsl:when>
					<xsl:when test="string($first)='udmurdi'">
						<xsl:value-of select="string('udm')"/>
					</xsl:when>
					<xsl:when test="string($first)='ugariti'">
						<xsl:value-of select="string('uga')"/>
					</xsl:when>
					<xsl:when test="string($first)='uiguuri'">
						<xsl:value-of select="string('uig')"/>
					</xsl:when>
					<xsl:when test="string($first)='ukraina'">
						<xsl:value-of select="string('ukr')"/>
					</xsl:when>
					<xsl:when test="string($first)='umbundu'">
						<xsl:value-of select="string('umb')"/>
					</xsl:when>
					<xsl:when test="string($first)='määratlemata keeled'">
						<xsl:value-of select="string('und')"/>
					</xsl:when>
					<xsl:when test="string($first)='urdu'">
						<xsl:value-of select="string('urd')"/>
					</xsl:when>
					<xsl:when test="string($first)='usbeki'">
						<xsl:value-of select="string('uzb')"/>
					</xsl:when>
					<xsl:when test="string($first)='vai'">
						<xsl:value-of select="string('vai')"/>
					</xsl:when>
					<xsl:when test="string($first)='vakaši keeled'">
						<xsl:value-of select="string('wak')"/>
					</xsl:when>
					<xsl:when test="string($first)='volaita'">
						<xsl:value-of select="string('wal')"/>
					</xsl:when>
					<xsl:when test="string($first)='varai'">
						<xsl:value-of select="string('war')"/>
					</xsl:when>
					<xsl:when test="string($first)='vašo'">
						<xsl:value-of select="string('was')"/>
					</xsl:when>
					<xsl:when test="string($first)='kõmri'">
						<xsl:value-of select="string('wel/cym')"/>
					</xsl:when>
					<xsl:when test="string($first)='venda'">
						<xsl:value-of select="string('ven')"/>
					</xsl:when>
					<xsl:when test="string($first)='sorbi keeled'">
						<xsl:value-of select="string('wen')"/>
					</xsl:when>
					<xsl:when test="string($first)='vepsa'">
						<xsl:value-of select="string('vep')"/>
					</xsl:when>
					<xsl:when test="string($first)='vietnami'">
						<xsl:value-of select="string('vie')"/>
					</xsl:when>
					<xsl:when test="string($first)='vallooni'">
						<xsl:value-of select="string('wln')"/>
					</xsl:when>
					<xsl:when test="string($first)='volapük'">
						<xsl:value-of select="string('vol')"/>
					</xsl:when>
					<xsl:when test="string($first)='volofi'">
						<xsl:value-of select="string('wol')"/>
					</xsl:when>
					<xsl:when test="string($first)='vadja'">
						<xsl:value-of select="string('vot')"/>
					</xsl:when>
					<xsl:when test="string($first)='kalmõki'">
						<xsl:value-of select="string('xal')"/>
					</xsl:when>
					<xsl:when test="string($first)='koosa'">
						<xsl:value-of select="string('xho')"/>
					</xsl:when>
					<xsl:when test="string($first)='jao'">
						<xsl:value-of select="string('yao')"/>
					</xsl:when>
					<xsl:when test="string($first)='japi'">
						<xsl:value-of select="string('yap')"/>
					</xsl:when>
					<xsl:when test="string($first)='jidiš'">
						<xsl:value-of select="string('yid')"/>
					</xsl:when>
					<xsl:when test="string($first)='joruba'">
						<xsl:value-of select="string('yor')"/>
					</xsl:when>
					<xsl:when test="string($first)='jupiki keeled'">
						<xsl:value-of select="string('ypk')"/>
					</xsl:when>
					<xsl:when test="string($first)='neenetsi'">
						<xsl:value-of select="string('yrk')"/>
					</xsl:when>
					<xsl:otherwise>								
						<xsl:message terminate="yes">
							<xsl:value-of select="string(concat('Kontrollige elemendi keel väärtust! Keel=', string($first)))"/>
						</xsl:message>
						<xsl:value-of select="string(concat('Kontrollige elemendi keel väärtust!', string($first)))"/>
					</xsl:otherwise>
				</xsl:choose>									
			</Keel>
			<Kirjaviis xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1"/>		
		</KyKeel>
		<xsl:if test="$remaining">
			<xsl:call-template name="keel">
				<xsl:with-param name="list" select="$remaining"/>
				<xsl:with-param name="list2" select="$remaining2"/>
				<xsl:with-param name="delimiter">
					<xsl:value-of select="$delimiter"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>	

	<!--Juurdepääsupiirangute mall-->
	<xsl:template name="jpp"  xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">
		<xsl:param name="list"/>
		<!--piirang-->
		<xsl:param name="list2"/>
		<!--piirangAlgus--> 
		<xsl:param name="list3"/>
		<!--piirangLopp-->
		<xsl:param name="list4"/>
		<!--piirangKestvus-->
		<xsl:param name="list5"/>
		<!--piirangAlus-->
		<xsl:param name="list6"/>
		<!--piirangKirjeldus-->
		<xsl:param name="delimiter"/>
		<xsl:if test="string-length(translate($list2, ' ',''))!=string-length(translate($list3, ' ',''))">	
			<xsl:message terminate="yes">
				<xsl:value-of select="string(concat('Kontrollige juurdepääsupiirangu kuupäevasid!', ' Juurdepääsupiirangu algus: ', string($list2), ' Juurdepääsupiirangu lõpp: ', string($list3)))"/>
			</xsl:message>

		</xsl:if>
		<xsl:variable name="newlist">
			<xsl:choose>
				<xsl:when test="contains($list, $delimiter)">
					<xsl:value-of select="normalize-space($list)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="algus_list">
			<xsl:choose>
				<xsl:when test="contains($list2, $delimiter)">
					<xsl:value-of select="normalize-space($list2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(translate(normalize-space($list2), ' ',''), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="lopp_list">
			<xsl:choose>
				<xsl:when test="contains($list3, $delimiter)">
					<xsl:value-of select="normalize-space($list3)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(translate(normalize-space($list3), ' ',''), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="kestvus_list">
			<xsl:choose>
				<xsl:when test="contains($list4, $delimiter)">
					<xsl:value-of select="normalize-space($list4)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list4), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="alus_list">
			<xsl:choose>
				<xsl:when test="contains($list5, $delimiter)">
					<xsl:value-of select="normalize-space($list5)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list5), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="kirjeldus_list">
			<xsl:choose>
				<xsl:when test="contains($list6, $delimiter)">
					<xsl:value-of select="normalize-space($list6)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list6), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="first" select="substring-before($newlist, $delimiter)"/>
		<xsl:variable name="first2" select="substring-before($algus_list, $delimiter)"/>
		<xsl:variable name="first3" select="substring-before($lopp_list, $delimiter)"/>
		<xsl:variable name="first4" select="substring-before($kestvus_list, $delimiter)"/>
		<xsl:variable name="first5" select="substring-before($alus_list, $delimiter)"/>
		<xsl:variable name="first6" select="substring-before($kirjeldus_list, $delimiter)"/>

		<xsl:variable name="remaining" select="substring-after($newlist, $delimiter)"/>
		<xsl:variable name="remaining2" select="substring-after($algus_list, $delimiter)"/>
		<xsl:variable name="remaining3" select="substring-after($lopp_list, $delimiter)"/>
		<xsl:variable name="remaining4" select="substring-after($kestvus_list, $delimiter)"/>
		<xsl:variable name="remaining5" select="substring-after($alus_list, $delimiter)"/>
		<xsl:variable name="remaining6" select="substring-after($kirjeldus_list, $delimiter)"/>

		<JuurdepaasPiirang>
			<Piirang>
				<xsl:choose>
					<xsl:when test="string($first)='Ametkondlikuks kasutamiseks'">
						<xsl:value-of select="string('AK')"/>
					</xsl:when>
					<xsl:when test="string($first)='AmetkondlikuksKasutamiseks'">
						<xsl:value-of select="string('AK')"/>
					</xsl:when>
					<xsl:when test="string($first)='AK'">
						<xsl:value-of select="string('AK')"/>
					</xsl:when>
					<xsl:when test="string($first)='Ametkondlikuks kasutamiseks sisaldab eraelulisi isikuandmeid'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='AmetkondlikuksKasutamiseksSisaldabEraelulisiIsikuandmeid'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='Asutusesiseseks kasutamiseks'">
						<xsl:value-of select="string('AK')"/>
					</xsl:when>
					<xsl:when test="string($first)='AsutusesiseseksKasutamiseks'">
						<xsl:value-of select="string('AK')"/>
					</xsl:when>
					<xsl:when test="string($first)='Üleandja piirang'">
						<xsl:value-of select="string('UleandjaPiirang')"/>
					</xsl:when>
					<xsl:when test="string($first)='UleandjaPiirang'">
						<xsl:value-of select="string('UleandjaPiirang')"/>
					</xsl:when>
					<xsl:when test="string($first)='Sisaldab isikuandmeid'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='SisaldabIsikuandmeid'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='Delikaatsed ja eraelulised isikuandmed'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='DelikaatsedJaEraelulisedIsikuandmed'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:when test="string($first)='DEI'">
						<xsl:value-of select="string('DEI')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="string(concat('Kontrollige juurdepääsupiirangut! ', $first))"/>
					</xsl:otherwise>
				</xsl:choose>				
			</Piirang>		
			<PiirangAeg>
				<Algus>
					<Tyyp>kuupäev</Tyyp>	
					<Tapsus>true</Tapsus>
					<Vaartus>
						<xsl:value-of select="string($first2)"/>
					</Vaartus>
				</Algus>
				<Lopp>
					<Tyyp>kuupäev</Tyyp>	
					<Tapsus>true</Tapsus>
					<Vaartus>
						<xsl:value-of select="string($first3)"/>
					</Vaartus>
				</Lopp>				
			</PiirangAeg>	
			<PiirangKestus>
				<xsl:value-of select="string($first4)"/>
			</PiirangKestus>	
			<PiirangAlus>
				<xsl:value-of select="string($first5)"/>
			</PiirangAlus>
			<PiirangKirjeldus>
				<xsl:value-of select="string($first6)"/>
			</PiirangKirjeldus>
		</JuurdepaasPiirang>
		<xsl:if test="$remaining">
			<xsl:call-template name="jpp">
				<xsl:with-param name="list" select="$remaining"/>
				<xsl:with-param name="list2" select="$remaining2"/>
				<xsl:with-param name="list3" select="$remaining3"/>
				<xsl:with-param name="list4" select="$remaining4"/>
				<xsl:with-param name="list5" select="$remaining5"/>
				<xsl:with-param name="list6" select="$remaining6"/>
				<xsl:with-param name="delimiter">
					<xsl:value-of select="$delimiter"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>	

	<!--Failid-->
	<xsl:template name="fail">
		<xsl:param name="list"/>
		<xsl:param name="delimiter"/>
		<xsl:variable name="newlist">
			<xsl:choose>
				<xsl:when test="contains($list, $delimiter)">
					<xsl:value-of select="normalize-space($list)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="first" select="substring-before($newlist, $delimiter)"/>
		<xsl:variable name="remaining" select="substring-after($newlist, $delimiter)"/>
		<Fail xmlns="http://www.ra.ee/public/Digiarhiiv/UAM/schemas/import/UAM_import_EE_2.1">
			<FailNimi>
				<xsl:call-template name="filename">
				  <!--xsl:with-param name="x" select="substring-before($first, '.')"/-->
				  <xsl:with-param name="x" select="string($first)"/>
				 </xsl:call-template>
			</FailNimi>
			<FailViide>
				<xsl:value-of select="string($first)"/>
			</FailViide>
			<FailLoplik>true</FailLoplik>
			<FailOriginaal>true</FailOriginaal>
			<FailArhiivivormingus>false</FailArhiivivormingus>
			<FailKasutuskoopia>false</FailKasutuskoopia>
		</Fail>
		<xsl:if test="$remaining">
			<xsl:call-template name="fail">
				<xsl:with-param name="list" select="$remaining"/>
				<xsl:with-param name="delimiter">
					<xsl:value-of select="$delimiter"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="filename">
   <xsl:param name="x"/>
   <xsl:choose>
     <xsl:when test="contains($x,'\')">
       <xsl:call-template name="filename">
         <xsl:with-param name="x" select="substring-after($x,'\')"/>
       </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="$x"/>
     </xsl:otherwise>
   </xsl:choose>
 </xsl:template>

</xsl:stylesheet>