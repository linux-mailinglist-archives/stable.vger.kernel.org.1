Return-Path: <stable+bounces-116970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658EA3B152
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4899A3B1B3D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156821CAA98;
	Wed, 19 Feb 2025 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TN4Y3rIh"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43F1CAA76;
	Wed, 19 Feb 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944828; cv=fail; b=MpFs5RJdbOhdoo2XUusz3MtgJsT1iullMydK01yoiM6RfFPpZIk6eSurZ/tcE3/nsMsomIja+nsslDhZw62nN6614uNwSLjZOwHN994MWBksBp93T7XBouzdVkpJO4GN+NtnFibvCH2yRJXujQiYetr8pbDNczCH4C8Xscsole8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944828; c=relaxed/simple;
	bh=SP6TZxIaEhEMo8C+P9H7M5EREttzZB+jbLAdg8+f7Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBXbJEhKc8FXrvZtVkiM2WiKrolKqxgfNSH2pwjq7LZOUr7TTXGMC2QfmsXiienFLzMQPOQBfbyC9rECG2C+pWAQ2V7gEyyCC7zoAhZcsX+/DDwG8cjQzorP2VVn3Y+KdrW+LKY9osCUKqBD/V30UeXvMmI4YvE0uYWoz3E05TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TN4Y3rIh; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUNu2d5bI7MMW0Dbb1AnR+UyOhgFNpkqbqLtQhpiQSSXc6d0+pPGmkyoCcxTw1oFLG1JT3fPTVK1Ti/xPPxHMT3mHSk5HmRFNxayphG8lPLIr2mNCtdeLOePjJAbETnGqt1kvJUsBirbN6rn2f7VKXtuEA1YIza04DsUXuPjB8/ib70T8y2nGi1xoiaSSadObMeR4ewwTjurMpB5Z+uDdIA9OZIO/SqFJSLH5ww2GBAUJHN34ngEO0RVjSHbQt9YdwH1594wkEp/vC5aKKtNs+Mc6g5yU+korzTVI/bhjgAcIblkqPHJAVuDg5r39loeUAdI5qI3kQShnPAcF7A1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9yx1YaYWjAy1qn5fIAa3JB/XfXPGsDihJy7IjQF4Ss=;
 b=lEhcTK7LOVHHVxKyiDYwNzCHDSEjqq1R4WTb9yS+NuwBPDySHD7KXsk6/H3TwMLZcpoEBC9Qt3udCoL1AtSf3tjGov8YMOzx1dGAT4tQBgqAUOFCcXFaXcN95fMjk54LqTF6sn5tcK5IOeLc12FJEc2Lb4oaB+bpaEFTJqh6IMvFdJeLtvY6aGj2GWnJK/N7UA6ye04hmOjzrUtlz/aEYw8tSOQwkbulYVeTVkJlJVjFLIlbhygBzMPz/EkHb15T/qgFcOn4vSJuMrbUbiWOMMxi/IyTp23sFI2AJiM1bEi2hJBBP2LS2RTCCvpum3zMAtz+y32aRrjDmKZyKLHOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9yx1YaYWjAy1qn5fIAa3JB/XfXPGsDihJy7IjQF4Ss=;
 b=TN4Y3rIh1SeeRj6hXZZNygUfFQLfQzK4tphSDrIRm0vNkXWmR2pKEd+uciuBdRSkOCj8KNtO27VJfqc531K+PHr4LYTVmsrLY0OMfWXZsdya7BVjs7E0MH6ZfFpu1UcVU7E8B41RMCDddfR/3I6F+DC0QeRpir4iDHD4UXChmSVHHcnNwZj7IvF5+1sGaV+HpQBl1XdSwk5lxHgpMLC5i44wDapWQYl9R7IDldAUutKJCldr/LC9+NR1pcxBaB9OcXPVSWWavOo8m5g/FMOHl+YY/PBs5/nYCnxcouyttonPZuBUzy1TD50FLmocxdeiDJ9v0kBc0Dt0pUI9QQ55oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:24 +0000
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
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 net 8/9] net: enetc: correct the EMDIO base offset for ENETC v4
Date: Wed, 19 Feb 2025 13:42:46 +0800
Message-Id: <20250219054247.733243-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219054247.733243-1-wei.fang@nxp.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 53675095-f76b-404f-dbb6-08dd50aab32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHbOxxXM6D5wWABCfP/qANLHp/2+ahEXewN/ib8epueLyJG2INKwQmbZsqjK?=
 =?us-ascii?Q?1yvKG1MAtA5/6EIs0z+RQ6AatKwuayU5JLouISyshYpfu+iBGQNEhzOvn/i4?=
 =?us-ascii?Q?PF+wQrG+aPIZkugfrT8eI+jikUBNI0Cc8tY81Z4NBMIA3+X1nX+PAXb3rr9R?=
 =?us-ascii?Q?oJGuYTIFX23jHp3Dhp7tkaG37YOa85v5qhtAxIkW3OZW8xiPw8jXIaxx1qts?=
 =?us-ascii?Q?x+TM/kSswzkDW/gtPb5XbLxId+SSfJh6MG28maU9Sm32hlCBPOQ4mxxUyqI4?=
 =?us-ascii?Q?ExR0QLLG2kMdUCWhwzZeCycQc8th8cAq6+vVSaKwjs1JYe6GqmT0nZ30a7GG?=
 =?us-ascii?Q?/e9pwa5/vN934HZC5BCTfXyO+8CccuAhbmfsBz6H0fR2vZRnmEJmpwJsRQqQ?=
 =?us-ascii?Q?IH4qUbzuCiLUdGU+uRcHxfT6sRMBFkEqAk4Ux0bTxKedItXiSsJ9W26JhzZ3?=
 =?us-ascii?Q?awVcUN1mwYokOwDyr3xEyh5aHpULqGiyzV88SC53QFYZhJ2e/r9zPQ/NamwN?=
 =?us-ascii?Q?emGPlUG2hTnclR3XOBrn12dk96fXmPu875GhmSTvro//wGgb12YvvroZ+pS8?=
 =?us-ascii?Q?V0IQnvJIPnhqHANH/2O2gs2MF6HUMYklwxw+QIaaH7N/OCEKxMiPvjJiq5oH?=
 =?us-ascii?Q?KRJIjwqzwitecdG6kQeVLCQMPrOASiJA19Jb/fRUmP3uI7ouGanLQP/m7Kl5?=
 =?us-ascii?Q?UhzdDcIqMDJDYyHYFeWg6Dpcy/5ltkLaBzDEMRMYdd+DndUEDI3rDCuQsVsJ?=
 =?us-ascii?Q?q4McTJngwUuJ22N06wEabZ+RHNH4SItu5Dr6iOIPBpfvFTLGSs+MVxG1DcTD?=
 =?us-ascii?Q?SRaq+vy3ONka1hjCqhsuMc4OH1feJ66aiYv0qp4OwinPR/Bym71jDg4ghH/Q?=
 =?us-ascii?Q?MHJX8Fze0/yEtaUq/K5Be5lA3VHR49aTxLO69HNi+1oo81ZGhO8SzPgCHgbr?=
 =?us-ascii?Q?A2lQ6ti/8Tl8KNspgChlp21ODQZiplH0gdtk05TZOXf0zs1tyxeILdnXTe72?=
 =?us-ascii?Q?8W98FoQNItA7fGPRPMx6txJEna37IwJZnBIjT7XB7f2MGfQK4ocAMjY41st0?=
 =?us-ascii?Q?swWcyuppdK/hiHBkCXTsCxINcXORD1kl4+Vag28JyW3YYzSsYfqFyCQvDGFj?=
 =?us-ascii?Q?Nl4OR1vsgCuo8FF161RBHZopWgAeckk4n04YOttQu7qpreZvMglzcyi00XM9?=
 =?us-ascii?Q?aNihh3hk+rNN6h1hSWixIyXpFiR8B7vuR4Ma4WZK9trscOJ5DcPM8I/RCYQe?=
 =?us-ascii?Q?m9Y6vPMRfT74d7q/s5ZaJv0wmEAh53ZMlNAWld6h2xLWxOZJHev5g8xxSY+h?=
 =?us-ascii?Q?+3g/DJSkbmTMblKdWgPtwOk+N7t3uQw7zduAh4Rhcku3lANl5zv8zZLM6xp6?=
 =?us-ascii?Q?7N1TA795LfzzHaQOVT2fv2DCUO6+GzziS5mD16ydTDZ0ojO0ANmqyb2a5rgQ?=
 =?us-ascii?Q?8tuf82W/M4v9EdzuJ2nol3NiQejoA3yS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHc2tEFHCKXX/V4OIvSNrftH2tXCMVAVs1Isu2phtz3OCIx8anU+x4AiapOm?=
 =?us-ascii?Q?UzNrq4jAECVgmm3eUYXCuSQaEtU+ULYS2I9GxR+BRwSjshH5Q/MpZK5IhS5f?=
 =?us-ascii?Q?9Q5oMO76EwB87kftVcFLL1kIo0o9KNHC82COAGerZDQqNEY1DBd+4BzwGgrw?=
 =?us-ascii?Q?EEsaK3RqfAv6km5gc/7x/u6IaHoaMNVlP3cT7wmGHXQauT/CDJwNQp/YMB9Q?=
 =?us-ascii?Q?mM2qf4ZmczaLrTOHjtHI8QYLE/mAcTKuavS7Lc3Ht68aVrCfbzlpSlylWmvQ?=
 =?us-ascii?Q?RsF3U8Cubeb+5zbilAskXKXFbUULudpakGxd+k3FY/BnO35Hh+ZCSUhUXwU/?=
 =?us-ascii?Q?6E/+CNope4ZVDxJ4uh6PHJoFAulnO0sX+bIi5GFY7ol93DW7T7UwHtM0FXo9?=
 =?us-ascii?Q?jrPLR0zgzSov5vkkG7GAQtP0Gk3t3JknwBVlHajgg7AMqp91EhSM4LroE/19?=
 =?us-ascii?Q?mkKfPHkMslhiVjAKSyRnns9Mrr0jaZ7fOmTYDeBSmAYYMfWT8I2vwtWCf8hc?=
 =?us-ascii?Q?JeJ/9zhHkkwYuqbae8hlztr/65pAiUNfo3XVj6osiTchReToS3LLU32FJDiK?=
 =?us-ascii?Q?guEg0PQHyFnozVMgMu9+/eO7tDTbouGRwtxrbWBrJ/mnlGNbFdu6jzIbEgk+?=
 =?us-ascii?Q?VjW91sPsAefofknK9npLyQ0yi+D3rbNVPTXUnfXVWHkUW3OV3H4PuCZxs4aQ?=
 =?us-ascii?Q?yVqpXKg7yh+IL41PE6yOZJxwTqhEVWuEM/G2tha51pLsD2lzzT/Z8Wgxs4uk?=
 =?us-ascii?Q?3CZEu/7YL9ky1QkZxJcQfqyPz3qQxDI+kaSWYdFNnmDZejKY9KVtMCEl1/gS?=
 =?us-ascii?Q?145FQStUsr+pyZNJfOc2QAqu25aOA2gflo4VEifWMycbzUZP56CSQkEXM0Fc?=
 =?us-ascii?Q?iLZ3OoKQWhwCx48zDZEpySf6qGG9O8jKgJAKW1OSSlJ7L/aTQ+pPY7qsqWGv?=
 =?us-ascii?Q?U7IZ3xj7T8bEyblWRPCPCPj5KbuFcTYV3Mq2qrZ9RRNOUixefDxyZRuaz4dm?=
 =?us-ascii?Q?FPGTgpbFssfO/MmEqHRgxqA1alY/q42JTjJ/dw6U/v+0HTqN9APQA0cGcjz0?=
 =?us-ascii?Q?Rpv9Hm0bx0Tfy9mcma+aidL5Pr33QeJQ4p3ZYgI2TL2g94qO4NpojlBzkmOb?=
 =?us-ascii?Q?qc6v7Px+iMloj9Xcj7TGPnDgbLiHKpoePYaV/zzKlt027W7SWoor119JpDbK?=
 =?us-ascii?Q?KuRvu/5zGiBCHdcBmxOcUYI/veQs6PZ/OL5bhKzy3A8VLmsW3ooLzqtMjMpB?=
 =?us-ascii?Q?YW2kovzHn+BbcOWNNCf/KCya06LpMfi7JlJQnJpR5HGwQ8Il7ktnK1PQHPHp?=
 =?us-ascii?Q?ZgzQHjaeRng3iuSHypMZIv8Otsy+YIyK889eadBLv3QzAZ2dlOdoAEJtDuFU?=
 =?us-ascii?Q?ySrpG7rNwQWr5FNysos80/i6/+aA58ygjqgapYF72ZJeAJMKyU5Lin3zXoi5?=
 =?us-ascii?Q?46PdZKnB5NAm1mlGtfmlLd4NsksuGjxdHjExqOog7XuDnwBaaFG1SwulNPS6?=
 =?us-ascii?Q?vaWajt4tbZW+G2QnlPWk61RrMzTwnNHXhrn6RdN4T7r+62t/xtEoW5eC2a8P?=
 =?us-ascii?Q?D700RVaTPPlEdKcn9xD8Q5WrcBDwtx7Ei7kPzawR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53675095-f76b-404f-dbb6-08dd50aab32d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:24.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZrDEukjoU63txE2L5C/0e42xcqiF4yIB6AECXMiryiyLdHoAcf/fRPLRqM1w0g6Nqu3bh89OzIibDUwa3deAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

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


