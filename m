Return-Path: <stable+bounces-116552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF3A37F23
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003CC3A31B3
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D8218EBF;
	Mon, 17 Feb 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X7yXEPP4"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F5218EB7;
	Mon, 17 Feb 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786215; cv=fail; b=jYVCuJceNpKq1QxRJd/bdDd1zLkh0wfX0mQqMtl0Ig+DjzkVqgX75rRtxSPQXCRlF9Z2HIX4oHULESGBF+JGI5qLt+cEKvIrisfoDr0BvI86p1sdJr2x/Afub2LsIMtVxnHhBlcjTMVEicbMa+A/29lsqnSJugSXtOwmZTpgOQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786215; c=relaxed/simple;
	bh=SP6TZxIaEhEMo8C+P9H7M5EREttzZB+jbLAdg8+f7Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKGX77RHFvCn9TNQVvfRnTKHuUyyvky6dCmk7ieMyoyzSioKJXeKk8wkrM+/2F1ow6J6iTuOtR0RSi3GVCIS++71PqVFZ0rurS2sHLeqrJimOV9JKSjkbNTgeQzv/Yr3/iFPced7Mo39PDJJS7beAbQll3a5eYS54s6jAQSkF2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X7yXEPP4; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsWhb2WLSonD2kopP4dvStC1FsbPkCRk3/gmU0HF15ryd19I8GI2pAVZOYm7qOycTRIMoIoqrPy6wpEdQqAaulb6wpbIflT6WDoCs9lfIGiDy4+98IjXWTl7BorqupGEbHFe4Z5ftbJybPPLNUyzhCpOawfKm0KD8/RZacRId1EPzfBSfFHMHbwmVWOZkjst+axzM5hVCzZHZ6xKoRmPpw5ucsiohdyL5oe2lwCKh11SO6PQmUpBthc0z6sWtx5EKZRSm23fwoQ5ORL5dCFis2lXAyNgN9/yYcn+JwJcATP+Y2fSsshwWPMQWFWougr5e5pPXz3obYnsNlHjgAxolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9yx1YaYWjAy1qn5fIAa3JB/XfXPGsDihJy7IjQF4Ss=;
 b=eVEWdJS8qvJXGx4RBkyzycbhcy/y0Qz8y32GEgBC3b64lszLZuW1WwXVc/UcHh/ms5lFuUpPBJRKd64505VSZ+CArUb+uzow/J05+mZ2UGoZN3s5mYDt4NeXz6JYkOidzhAhEDpRt00nyjBAIcqcUUwtr55M6cCoTKQ52oIMzt9AvXJHYHWMwQLLHBPwy/d6h/DpojtkdhzgcV1qsFAKHd7ppa7wy6FdlLUw02ne+zHrfRxxez32vbTosVbTlR5qTYWkOtJgQ+jGWB/OnCzGGZaVt04CijdUeWEhDMEeZvHHXgo8mya600dYIKZl7BRw6PRyNR7uZNfaR4eXX430iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9yx1YaYWjAy1qn5fIAa3JB/XfXPGsDihJy7IjQF4Ss=;
 b=X7yXEPP4JOqJa+E2dRMtlk9vc/fhq/EYwqcsVDOlDDforHFVOOCh3OLggyswB023sgivl5RrRCtWkPWl6acXJQPzHSiyI2z5guEgV3x1T98BnTaoqvtUb1SkJ03yTXe64NQA21duRBBWwjiSxSj5GZNP6G4r86R6N9d4W1TcPaLLU3AKY+NQQH7TaA0oZlDtHHPWGj+Xp7rJki1ayCpDTssI1/s0SOw2XZCVTI/F6l5aPDXbyr2LSlma0E08h8GlPkp6ohfwLrwH211qCbv3q6OTDlwBlZcvZ9F7Vf8JC+q0nslWfB/C7bRHHA3+udXzzX0cKasNdscoNtRwqWFe7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 8/8] net: enetc: correct the EMDIO base offset for ENETC v4
Date: Mon, 17 Feb 2025 17:39:06 +0800
Message-Id: <20250217093906.506214-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217093906.506214-1-wei.fang@nxp.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: f48c892a-ae23-4c06-d89f-08dd4f396603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryTWGu25H77wa7Vt+3plXQUE1gSkKEBIF/269oBtDpYmzPOkvnVgZ6SGJoUL?=
 =?us-ascii?Q?uyU2RkS4NQw7ZRdoQ8zF9uSIgY/MqnVezvmuqh32kCaf6hsKW+zHCqzq4nvP?=
 =?us-ascii?Q?OGTCsHVCKlyhc5xwmZpwTRSl0qLS2bW9VaPdyPBnn2JQWVVWoKAIaOZCFxoY?=
 =?us-ascii?Q?69kOoSMC7Gi/Ece7KmVBKUEWbhvJ8PiSwI3n3F6H2UEUwFN8Ix3kXKiP8UHT?=
 =?us-ascii?Q?rSAIizQkgU+EV82TQxhwyp45ia105E/MG9VKo8cn07DzrPZi8aqz8fLDWpjh?=
 =?us-ascii?Q?DZjZBm6EOnK7e6YCs6fL8pMWnkQe9s8wsxoJh0dzg7/rHWWN6X4X6YWBGmfR?=
 =?us-ascii?Q?peqe+sFVJ5wo+xzYTQY+fzQ6xvoVXzf7N7rER8KlpyjUXymzvlWmWRyd8b2E?=
 =?us-ascii?Q?djInrLRXsIWW0ZGT71WCKUERgqJ7YwCkVlWztK6diKY1XNgMTNPjNc7x9kcc?=
 =?us-ascii?Q?Ij+lRsTUzv+5/y3YfjI5I695V90VJtFSwV9i39D+pY+Pj62VZSgJtxo1D+Dm?=
 =?us-ascii?Q?CHE2BKL6SgVXrur12PbxIXMN3lwJcMUQ6A7+yzzqNNQH2dYg7tE3UviRfFpD?=
 =?us-ascii?Q?lh1JAzxPONi1MdkN+asvgXIdbit6e1fFSgGOHYhpAggFtomi64I6SJfuG7f4?=
 =?us-ascii?Q?9RA1MvGRJMMzJ9xk2NbDVEL49j2v61VMmWY16WbFBuS3HsIvE/EZ/KncVxOq?=
 =?us-ascii?Q?kAfRmo9k+GXHzDGZN5Fu1PeU+1gUOhOTSUX5zR2u8Vqa81EceJAI5MjEdGxp?=
 =?us-ascii?Q?kD7/pJ69sGznj7YkghtLHmLOCJq0lblqjVfiyfOmiMt2norAD2eCLKTMSeHb?=
 =?us-ascii?Q?hXnhCohUB3R7QtKkENa49nEQvcuL3bByubHpI+82GEEgFvcT87rGIFMw0MJs?=
 =?us-ascii?Q?yz9YRj0gF5pgBN1KiLix34Jb4Ac0flCHGBpbxy2xN64+28SONNhR/zAtaZmz?=
 =?us-ascii?Q?iBsuRnYTmHN3FcuLwrH0C4M72dBcxL0RVoxKURzUC5/M2OrnE3wfJaz7fCyW?=
 =?us-ascii?Q?7f0fX1jOK43sTKgsIEv3Y5w2NFT7+Nr6nPDb+EFM9clOdvyzcf7bSy18khhx?=
 =?us-ascii?Q?YPREXhlDLszrzfBzMdD6DqYCHoOCnmfvfdLl61yIESU09ROQRnN6MiTqMzyf?=
 =?us-ascii?Q?yoKqsmoAdMIyKlPKsuCnX+vrEDrlOEs3QcyZf2uSRpCjV1wHXL7L434NiXj4?=
 =?us-ascii?Q?znfZjzGYU7ud5LVwzVYdH3IBX/xctTk7y02knWzUyCYTV9yxcRC/7QJS8n+9?=
 =?us-ascii?Q?QQJEdIw98mFrWUp/0OeqEV//d3r2YgyGGvN6OedCdAh17s7Sst5MWaxK756y?=
 =?us-ascii?Q?ZLdPkbycjWYvcP1NBk93oq53FX3DntkDTwoZmxEDUTLmB7eKgskgh9v66rD5?=
 =?us-ascii?Q?P7gXgegKdNO2ngenIRDEzg2VWNrZ2Mujiub4Lj9KbKbmAxwDtKqEeweMmgJm?=
 =?us-ascii?Q?3zSZhMGsnO6QmtF0x/eJTP/Raz1ty8hc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWHwX9LSJ2nSlE2zE9ss7Kw9FyRuq1tNpE21cj+Y9JIzQ6fSQu7s8BMoGmbV?=
 =?us-ascii?Q?JSBP8la+mQ0/sVMsYxAIqwhDDscsFdvc5PgHrokAQ1R951pCZO5112p76ffA?=
 =?us-ascii?Q?B0p0olf1Xda9K3xe8jaBkdqGON5sguV2ZpqhCfLDJy5+eJV1wW7HcogaTW8s?=
 =?us-ascii?Q?kw8TLP5qsX/sy8ZRUxwlBbD1HgDKwRbnC/ABCTqdf0vgaeMHVYrSpYyPoqBH?=
 =?us-ascii?Q?1DnXq5osoZ29QGQMCsysY5vZtJL2AaUcMV/jcXfFrd8FnAOO0mtY1vD4zBgc?=
 =?us-ascii?Q?Pi+FKKHwRsKjYHdRc6/CCFG8xmis4LPGNHCZMQ/6Ipt//Dey04mV73RwF7d/?=
 =?us-ascii?Q?m88J/5p9WUMMWQ/6sZ/AaQ6TiqtrBd0WHyGU7qsyEVteSZXa+1LDbunl/nW8?=
 =?us-ascii?Q?4XmhYDdH4Gpa+My1Q4yl7KIseP7pf8gnXxnMc4pEcppxzMWv+H8Gq/GEer+U?=
 =?us-ascii?Q?2rZ6zq0s/cOeHwa5m+EeQATHw51ypbyEiO4e8Syenduj85QKGYCq4315NXWn?=
 =?us-ascii?Q?UhPURQcIdqLK+h3EdApEoM70ZzFu0uZUSQgXQ0MUtcnM7U78BWqM3YzRHFBO?=
 =?us-ascii?Q?vvZgedY5qmf9ioJTCo+4dBVs0gsr42kquNRr9wzxAbxiXQ9FHsLlH6QUsfWL?=
 =?us-ascii?Q?yFXwEVB29ZRmWLIrGRwNqvq/yMV6YsQ0g4t08TqHfsKX0ykpvonLID3eZSTx?=
 =?us-ascii?Q?4f/3pJr2AYaCOtXam4GTXF+SHHBrSH2QWBY2pJDm/sNiSolwn8WLUruonFWW?=
 =?us-ascii?Q?meaotb77osWn02o/ZkpoRd3Fj9IC4qZccdX0cU4AaPx8nfQ58nGAbUu+UyR9?=
 =?us-ascii?Q?god+rRSbwLXWKTTXLnjDFw/i26n8tqOJjowDWQr+V25ArDfgqprdwhysiQuj?=
 =?us-ascii?Q?pebeeAyHQ5d7UjbLL7IK/hfnHlv89udjCqLC4zsrGbxXhwg4HlinJsIVNeyn?=
 =?us-ascii?Q?F47t0RCrDjwBkwTP8HaW5I8TeyC13xsDEEWiqWcHNcImk13XnzMD59ILYCHy?=
 =?us-ascii?Q?2Q3HF7N9kICrur8CMtbkIxE3v/JOIlFqOs9fpctvW3MpZF6FuxsefYTJS2bp?=
 =?us-ascii?Q?gc+wTwUMg2WnU2bfBCtTE3SdtN6A/AjRVdpqeS9WwuKbt6hs0moWMAt02OAu?=
 =?us-ascii?Q?mgbz+tWiHlgEyRwj6+L6Q6AFrXZz2Dh2nNnPWzWHWIQqhoYdS4BfAdDLf598?=
 =?us-ascii?Q?JoJwrQXK/W6JCQUJQ0hKiNbcELihYnZcTUBP07tL6YY0BGPmduZ7Dx2HrQmM?=
 =?us-ascii?Q?5smbQ+SuMTcqMavi2SG+gWoXG05pqWeuYnMrETlx98Pz3t1xTMqlVA1UiI81?=
 =?us-ascii?Q?lNOjZqRVKJQA1yj+Hts1dUFn+Ox/xQfBRTZfQupZhiwLCy6LHVJTqm851ce1?=
 =?us-ascii?Q?u6AtPcpXLP+QhN81K+3nFUZ0cN7739eJgt8m45ipaPs5P0r5czEychbV2vI1?=
 =?us-ascii?Q?v1SuJ3LyxWm2xBi6KdfT5sXnRpWwPeMhmYS6b2RyMAyCRJg37Z5ZOVaNS3yX?=
 =?us-ascii?Q?+EUDNewRD/GXAUzRNljp8ul0wgqViku6RoQ24K51XWpCcDo8TxC3GAQidICR?=
 =?us-ascii?Q?lcG1aYE0idnBQVvCerLMAYfFWWcrpggY+pudifam?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48c892a-ae23-4c06-d89f-08dd4f396603
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:50.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u59Mk5QIyOkUQMqbmfY6lV2yqDJa1NqOIfWfDRjVMAghAKurIgAam/SbHQAxfRoUTYR1hKhhiZQxZBTh25M4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

In addition to centrally managing external PHYs through EMIDO device,
each ENETC has a set of EMDIO registers to access and manage its own
external PHY. When adding i.MX95 ENETC support, the EMDIO base offset
was forgot to be updated, which will result in ENETC being unable to
manage its external PHY through its own EMDIO registers.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h       |  3 +++
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 695cb07c74bc..02d627e2cca6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -175,4 +175,7 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port external MDIO Base address, use to access off-chip PHY */
+#define ENETC4_EMDIO_BASE		0x5c00
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3fd9b0727875..13e2db561c22 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -154,6 +154,14 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 }
 EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
+static int enetc_get_mdio_base(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return ENETC_EMDIO_BASE;
+
+	return ENETC4_EMDIO_BASE;
+}
+
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
 	struct device *dev = &pf->si->pdev->dev;
@@ -173,7 +181,7 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	mdio_priv->mdio_base = enetc_get_mdio_base(pf->si);
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	err = of_mdiobus_register(bus, np);
-- 
2.34.1


