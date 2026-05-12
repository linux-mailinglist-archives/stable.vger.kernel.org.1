Return-Path: <stable+bounces-245393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gChcFOe4AmonwAEAu9opvQ
	(envelope-from <stable+bounces-245393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:21:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E8519D47
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4EB3303EC0A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C932BF51;
	Tue, 12 May 2026 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tl6uEvWb"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B989F9D9;
	Tue, 12 May 2026 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563256; cv=fail; b=E3VFR5CpiJ45rwzJpXPWXGToqSa2sZAsGmLRlcu6TgDzyVwSWiOqSRh/R+4GxcvG9igbxeLMdPgRVwkE1Jub2QumWrsmTRx/4WtGjM3YeUKqlvM20q5DlOpceG+5sifPAXFE8SLEfaM3xRpc3r7qLF5b3y40NwVBl7v3I6ElfaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563256; c=relaxed/simple;
	bh=Er3zotiFTjcVVLogKzZjNsGXIBrmN9KuG6/xE6mg8jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSrmYQfMa0sTvHTzIRX1oc0J/5WLDawfwTSVBYqHz90cUdnXT4rah9AwvIBFDg1ueTaFAFTFYZ1wHIg76XkfslHAHFqO0PMBWSYkaOyI6IvrANN1YWyxim4vTp8wpY60G/IygzMlhliQcUDiUuviA6Gu97pzYusbdvTZbgVavm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tl6uEvWb; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkL2j87r5Q4FuDI2EkJ3i52yzHzY76VavxBurgrub3aABSB4wrnGf29M8/gPBTLl5p9fN/ogmwLpVRwzkLOZoI58CankPCEp9hK6nNZLzimnNNpPVwkExt/xAkG4bFzeWZ8yD/XphF4LdQkhHxzvT0Fogtl5G7mJdv7ZyvbsdLI5uutXSuogt1GXGRQ8rVX7vtY0ZXnmlwhsl+T/lsYh/iBmG2NguVEdxZn8ZO6pI7ULpoeeUkOBzqa9gxV9pUcoGm6tPHNkCJBkZkTbvwo1pkW9Sm0u/+PLM6vb0FTHkxaOgECa+yxApiHv7Ti1cLyt6OET12+9LKBNpXDiyrsJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXnXgH8iNZ8XzKuVryMUAEPiwUY54fZY2LQJlzDOUDo=;
 b=hEg2oh/KCTexsLPppXrOibm8lwULOnJMJzSVylpI/dkEjPIey3Pj8/MQwhP9ME18mCZ6slAloFHc9Vor8xT52HiuezEvlGzv7WWDzicwxpD56+owPxY1DRbyIPkxLY24wu5z7fMRa2yPGZbpUZJKKCrDU/2TQWzTwEIVuZwPH4U3NTtDGCcgPdxWxP1GKKtbxAeEXDl+Ze5Yo6vaUhW3voO/0Qq1rJZ9VdjF4X2qPlISDyH0B3eLR3rtEIQIan/4b//k5wqK/CLTwKcRWzqSS7+F2hO9V6OFhHQ1RVQNRxkwyJDeQBGeEKiNh9pyOlT3XP8/gQsVx8WSUANnQCPg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXnXgH8iNZ8XzKuVryMUAEPiwUY54fZY2LQJlzDOUDo=;
 b=Tl6uEvWbD4on+EmTcOfNIen96gTsiAUczVTLWDGLJq7BlBBXQF5tfxzn5JcEDJd6264jmiSf3jJrHytOcaiYiWnjQyfWy9QU4tvLN74l5LcWIPUAmB/peplYMSzJvUzQwcZMuPaLp3AFZJkbIFMWmZfpECoQ63G+EMJF8JJOD/SYp/J1dXgqO5ZoMQ8slhI3zFU0fK1B3Fdc0k1782AOPqmN5gEfLK6le3wRxO9TrgMK+jNH5chLeDlbtWE5VbuHZ/Kj2K1Xc43FpDZVwT6EN9MpyPngVTrs/zwqCn3I/AWS7jybE2i8l/szCKq51sAm0iSh4nuUG22yPPsnAEYSpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AS5PR04MB11443.eurprd04.prod.outlook.com
 (2603:10a6:20b:6c9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:20:51 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 05:20:51 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95
Date: Tue, 12 May 2026 13:22:44 +0800
Message-Id: <20260512052244.49414-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260512052244.49414-1-hongxing.zhu@nxp.com>
References: <20260512052244.49414-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::15) To GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12019:EE_|AS5PR04MB11443:EE_
X-MS-Office365-Filtering-Correlation-Id: 69568027-1c4d-4fe3-ce17-08deafe63bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|22082099003|18002099003|11063799003|921020|38350700014|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	EgJUEtxwI0IynqnpfDSICNJa2ZPV/mNMYIeLSq7GuvjRr2hEceSGW9gMIKtjwEDzZ9Mu90xIODkAlH8Fzbca5UIc07ap4t7H6Z1srPQ0L6bJP0nAMoELz4CTsKqbBXl45zVyRTVDoh8d/mbfdfapU2iLvJ6gMwC4TAx2cdsCyi+YR5gj/BoR0HEBLA6Ylc/14pucc0HlOgms/kfe5d8Pb7c+ckAW+1VhlPnCugXtOhEpEWNXuWWa0F+BTWR2xEPLqwX+mP9vWFUGKMXKkzobZQj1hWmJD60WGOBhZdk5eU4sGQUdlkzKWvT/MbXjs40V+VAWHQsjAYyVmwC/0n0FledI1P/ESDZh2fOSMp8F8zoB0iinM6ir8vVxjGTPedmAkkU9IWEYWWij5FOcZOfggpe0Csh/3vniLhVPul8nPHzQrvu9lkrLqEcmSDnGyNlmzZJyr2gA4JJ3oHrHwuLhXdH95n5DUNwSRKsEaBobDhiQKN42VZW5R4BKKaV4Drpk9817CkuCenS5M+B07WeQnrLqw9WoH9Kru0Ew6AN1IE9cncNuqb02UtxuTmpxEohxCIbawKK5NC+aIRJz/3sHIBnlA+x2cbCRrSuA9Ziy4UjcrOk2o/r60JHBOxcHi3ldWmIMi9p/qSZ2H4SzuRT4HrkP5Krz7V1cBzvUKg1XjvgePX89yZdpXPoCFf26S/4z0JxLgDRMNVnMGJ0mpBrs2i5U+5LkDfBA1OVk05flVI3lzX8iABN7ZHJPKNuFFlOiWi0VoNBZiLXSv8BLQyrzGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(22082099003)(18002099003)(11063799003)(921020)(38350700014)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LeVyixzmR4bGhHhE9jwPW2cQxwEfTQR0SJkCGUSkhUiALsOXtyS6BQM/+019?=
 =?us-ascii?Q?dATiskJBHXB6B65IBebwfdhNTYmqwvnGyRyEXxiRwTNgzWpoqdUHM/HtqLtj?=
 =?us-ascii?Q?rg4aRaADzjKylW8nCZgPBM4yN/dPmSEFxqBNBdkyEPD6FSCyPC33hp82pno+?=
 =?us-ascii?Q?Eh316YD9pkF97v8LqUeLXEpuIht0S2qWbQBAoDvljozkV8+OMevZTTtGaI3h?=
 =?us-ascii?Q?wXFUs9qgMfSAEAkj5Sfa1AXQ3+o1ZyRhwGTx0Q0x2e67DAXUWInrJ/Yk1jBN?=
 =?us-ascii?Q?1qVjUjIRtvgvxYbvDRLxjNUJzXgioFkRn5OiHozZ1uKEpEg54QejHfGaCxH0?=
 =?us-ascii?Q?u67StnOEoGHtmwMLGa9iy8QQJYaZ96ODZ9ic/znz2TlMfeP545fIutKEN5/T?=
 =?us-ascii?Q?s61Fe4HPQfdn0AC6Gt4ZWJVTg/w0EkOSuuibRtMJCJ8ET2G4Fqy3IsrtrxpZ?=
 =?us-ascii?Q?59ZDO+Mrj4FQ+q8vXhSkZWoVwJCAudfvjeSaLZHEwx+EZMEFxwxBlOBQ0dlr?=
 =?us-ascii?Q?KFCuiN+hP/5fHMG6MDqNGK4P7RQGPdia9OXXwBs+YrmNZIaLlch8aFGyWnY2?=
 =?us-ascii?Q?xTavkS8UsYi2VvsW5MMFwhQktyufUS9e5+O9/ewjfziqPzQKnPQ/WHCAXobc?=
 =?us-ascii?Q?ozfuoNinspK5rw00s0dh1NI8++SrqQs9kjr1fr8WtjA7FQnPQbFkXpnuLdYj?=
 =?us-ascii?Q?ayfG05BIG5J7TP37KQXcqB70m3YaIUTBbzC+qt8wzYZtG0xWKlrfjK7/8KJS?=
 =?us-ascii?Q?knwgY5AAFo7qR2qrgGz/t26vBks+shNz0waxds2rgl4ulcNtCezuU9asiYaM?=
 =?us-ascii?Q?45p8FHlu/twypJR/vMaT2suHXZ9N26ybcN+FJrlwRv3CFljGPlL2okctYjzt?=
 =?us-ascii?Q?8FvltGB4YuWjgGElXMXmkcIlxGWV/Yghv2D9PkY23NFlvNrkzcpm3KxI4Pd6?=
 =?us-ascii?Q?TmYf1SrDgbDOCj+3nLyIBe6guJgzeQm4REW6haJQEvQlEpR0yN/81Z4OvkU6?=
 =?us-ascii?Q?VPxzmF9ki0Ahb30mJ82xpFWJIsXaI9LEdYQlFNtnp1jhly1TA5H90G8kpCoJ?=
 =?us-ascii?Q?4xihYnfwcGzvlq8OV2GpmLvgi6tbHCNL7+Fw2S8l0zpNNzf6+63eZj/DssEm?=
 =?us-ascii?Q?/Q58M+SEDRA5QdMLt26A7gHStrZ4Xxfkmih9qKCcMGtB0Gzm18RD56xRgk1f?=
 =?us-ascii?Q?H+gbzW6Aaw+0IsqtkA3/5TBpYhvu+XnBkWPONyU+fpoiUdxY6W2eDgD3ps/X?=
 =?us-ascii?Q?nWzczLCFvjRxezeeAPAzN0PSjprGsTe41ldzxv3hnqktTQhQUz9gWLzfk+D9?=
 =?us-ascii?Q?9wugnhxE2SAumwap7M2e55wVQ5A2gnBavhev6FhuCKOrVbctnmaBlwSjJndT?=
 =?us-ascii?Q?0i3c7JeAdSIeSx4Dpg1JxJ+KkvRDYl0vNmiZkGfuR5T28T8GOk4QMGDxtDWU?=
 =?us-ascii?Q?Mx9SRFUS5Ap2HZGd5w0K6l1bJRC3Ip4sTIRtOAqANdbjVa7pwSN8P7LCIF8q?=
 =?us-ascii?Q?s4RBTzyweCg5rs2VDN4HBJ2Q/+3gbPDgqgLm0QqsLNiDaPcSC8JYX58w2/Kt?=
 =?us-ascii?Q?2GfoIKZXymvQY2eROrXtXXld3OEd3JvWiuJr9ETcDkq2W4xVx1ZTsAhrysrQ?=
 =?us-ascii?Q?SoCBUbqzVyQPMsBNjF20I801rd8mcdp/6aHhdygIFAN74KM/7V/BYuDyVgBK?=
 =?us-ascii?Q?hUd6cRoP94z9J+7ZMMQscDPLNew48hmfbOGPcOruqu/QPnMmqmg+x9BpVJYf?=
 =?us-ascii?Q?U2B3N0EcGw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69568027-1c4d-4fe3-ce17-08deafe63bb0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:20:51.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69QpLBr+ZYy8P4Eu5W9pkiO1u9ChY8haD+T+xyes9QlRUkE9nGWrqOncvd8UTzs2HfIRSmHXMq3zXKhizjwvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11443
X-Rspamd-Queue-Id: EE1E8519D47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245393-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

According to the PHY Databook Common Block Signals section, the
ref_clk_en signal must remain de-asserted until the reference clock is
running at the appropriate frequency. Once the clock is stable,
ref_clk_en can be asserted. For lower power states where the reference
clock to the PHY is disabled, ref_clk_en should also be de-asserted.

Move the ref_clk_en bit manipulation into imx95_pcie_enable_ref_clk()
to ensure the reference clock stabilizes before ref_clk_en is asserted
and before the PHY reset is de-asserted. This aligns with the timing
requirements specified in the PHY documentation.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 40 +++++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c57f18d9e4ffa..c3e623aa18bc2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -268,8 +268,6 @@ static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	bool ext = imx_pcie->enable_ext_refclk;
-
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -288,10 +286,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
-			   IMX95_PCIE_REF_CLKEN,
-			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
-
 	return 0;
 }
 
@@ -740,7 +734,29 @@ static void imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 
 static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	imx95_pcie_clkreq_override(imx_pcie, enable);
+	/*
+	 * The ref_clk_en signal must remain de-asserted until the
+	 * reference clock is running at appropriate frequency, at which
+	 * point this bit can be asserted. For lower power states where
+	 * the reference clock to the PHY is disabled, it may also be
+	 * de-asserted.
+	 * +------------------- -+--------+----------------+
+	 * | External clock mode | Enable | PCIE_REF_CLKEN |
+	 * +---------------------+--------+----------------+
+	 * | TRUE                | X      | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | TRUE   | 1b'1           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | FALSE  | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   ext || !enable ? 0 : IMX95_PCIE_REF_CLKEN);
+
 	return 0;
 }
 
@@ -1262,6 +1278,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	ret = imx_pcie_clk_enable(imx_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_reg_disable;
+	}
+
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
 		pp->bridge->enable_device = imx_pcie_enable_device;
 		pp->bridge->disable_device = imx_pcie_disable_device;
@@ -1278,12 +1300,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_pcie_configure_type(imx_pcie);
 
-	ret = imx_pcie_clk_enable(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
-	}
-
 	if (imx_pcie->phy) {
 		ret = phy_init(imx_pcie->phy);
 		if (ret) {
-- 
2.37.1


