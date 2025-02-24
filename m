Return-Path: <stable+bounces-118903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B36A41DE5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064083BCFF1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECFD266B73;
	Mon, 24 Feb 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IgBccFIT"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42A266B67;
	Mon, 24 Feb 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396628; cv=fail; b=O9iLdqaJ5W9+ZcLtN7cJlZ08b9rxLlRRkLWD+SBRX7h6VWcs+mu1dvD8YK3fuyOBUBRyLo1qoK462oZ8PwN6PLafGoUqj7YybLtVHnNg/TmmyApt+czulDtUCTT7dxK0ScYFHI0eC5fc++jAySNRS7RYIQK7donSQsnyvxbqrN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396628; c=relaxed/simple;
	bh=PVcUNP8tv9WeTuKGuMSHTfJybsSOpK3+43vdiYAP1hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFqAOmZScExer1IC6PBr7BFkpQE3bjKDUvkqsKrhuDMDC5nnpsTyUvC8P1myWbRbLKoYXEb2o3OPY238yr1twbHJ0gpKS7YAKkQpbXihbDUlxit4qdzkWTKWkloprekA0ZOL5gdzYPyx3fEdjYPOCikYbqIE25SP9tKEd6OSvJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IgBccFIT; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4nEAyOFXW1p41zJn8koewFqp9m5bHPrpi+gRcDbejN5OhcF+h+ZMYIOmZSLsULHOtaB5eOJKEK0afM4Z/qi+Ai6Uh6tWJVS0Kovsbwby5KtCoVPp6AoahgLNjBnTgbdprg8P9olLDTq482PPrZib/4bPJX8uygANyslWOVX2AuTQGlIarGdaHtm8SMYahWrdq939cRbWn06LW43NmTCL/zv6cQUwVW0QZtGmhjlRn+PpD8Pasx56QEI2obuCU8a89FLkVxEZwwLWvGAkwVWkik7lZ3JZ9q8WI75ZSC2CD1/8W4w7hGVafdM1F+19yyT0eizZi2FPAX+mAwb9FWYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyxKsfHD9ssUcFxEmaHOYxB+iAIERoKaa7iOZ3p90Jo=;
 b=eNacM9ErVjHjjvrdjanlePQt0wfBupIyTO+HqSDza9vF2bRNTkTMYIfxWgRzmPyOc3jiCG+P30B+voC3luMu0BSNBzzusmyagEZPddOr+tQQyqJHGhHhUMRq2GgPkmN3b3Y7KAHSGaWOk4ch36p/MiXzm7PC8oCX7S/hOWkB5AzAxAqXqGc9a3FdQH8GuFvegswMYDiEgKIucXI7etEK+lgDdc25XHQPniw7PM9oF3qZPEA18feKP+OO6EoXMk12SFRMzwJvshHVREFE2NbMmvz+lwz9aJLz04gWvQjhIeTCo1VqeC9/YyuI0eTPmprpkHn9qXpRj+S8Fe8p1VNBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyxKsfHD9ssUcFxEmaHOYxB+iAIERoKaa7iOZ3p90Jo=;
 b=IgBccFITVeop5490f4bnfRbOf6XkB0L+F5UTEp+SUoFpx45RxXNWjAq7hM4sYPyBFBROm6xf5zilJy4d2PMeyNNzkR7atv5xqVWHhg8lqykO6K2dwxF2bZpudupcOqp3C8FwUXteD36o4q7EBDsjMkTow+8FMddmwrDxXe704dl0tNEDk6jCWsKgHkd8F7wBhfDr8WlsX5/CDZmmg17sbgHTzpXIDqw2IYjf57NlAI8eFYSKb+K1TjLV8YAFKytt1HYB329rA8ck0f0Z5ibk4aAY3q2wZ2EFGOsoPItaDz1STeG1HT3hsX4vQMZ7xAH6woxtA1ozj5dwDye86x/9qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:21 +0000
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
Subject: [PATCH v3 net 6/8] net: enetc: add missing enetc4_link_deinit()
Date: Mon, 24 Feb 2025 19:12:49 +0800
Message-Id: <20250224111251.1061098-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e9399c-4ac4-46ef-e5d9-08dd54c69f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0jdFFj9rlAdLbaBi2S7XHmtbmPXA2c9JFseF7rdVJQnsTPw7EvofVieV25P?=
 =?us-ascii?Q?+L0R6My97XgqjgT3RvUD5xklQ8on4djA1oVTZWo1tp0wcJXnMqhQ+W1BOWj8?=
 =?us-ascii?Q?1tz77kkA5mLiKn64m3tI65CYlOmtGH0fBRtb4KecCTYw4vAi3Ic+Es63XiMJ?=
 =?us-ascii?Q?QB7EZcE5MGFWWCgCOp7UBtq7+zhknwNdSsFrmw8IuoQySndhglJ5Dd4SvxjX?=
 =?us-ascii?Q?Dp+0nuZwtNRNpiT1riATkVChdEHQwgfzhJg476zPqvhpQZG2a/GWerT1Xx3T?=
 =?us-ascii?Q?YFB6gf2h77wVEosrZktLlKQYJPknldFeq/6MX5VEBEQt0Oq9Ft9Gq5aTEn3N?=
 =?us-ascii?Q?7x1QXLT1kuVeqOKkh63YKFYT6BFL8eMliFBtLCx/mHJapGXM8oloi2iTwXtB?=
 =?us-ascii?Q?vBgVe+FWqD0kQPffmR4nks/AfAiOkdjJ2MIqH9ZnkjomZsAdfZdU2knNIed4?=
 =?us-ascii?Q?rfbSRbOXMWx9Ok0AW6RMoaFwrPhF4fIIC/OmKM5wc4tUZCvGSn/BISLHzNl/?=
 =?us-ascii?Q?+qYI4l/VsSBPX2Updag6gRNvfOimr+KQAdDzLvWg4kJpmm4Bod4HEuZgkPq1?=
 =?us-ascii?Q?9xlVd8sJWtVCZ3gxLkAZKM2941wcFlGW34ce89eNVVrn1BVKPxynTb8FfN8D?=
 =?us-ascii?Q?rr8vCpYyc+WC4dyiKbOYSeuSqdmf8qigd+BuRw/jo19cW3lA+PGlZoENWcQq?=
 =?us-ascii?Q?Ae1qx6f1lZ9haPMoDUZV4jWLtdTa4jvuGJxbcmmyLDPs2l+Mk9SWwnuH1LV0?=
 =?us-ascii?Q?cglqqCrF4s8/4NE8UHqzqNbxTvHpUaGfPHlC2uf1bPkV9ScWlknIocCyWA7i?=
 =?us-ascii?Q?rz4o4uoXukNS+nZmxSCYst+zgkzow0/eYl1uOIZsecqgZK8JQk8Dt5uCWCbw?=
 =?us-ascii?Q?7Chqu+OiZayeIuvInpymBnEVr2X/FsRmIIGKIUgUzbnvrinXuBzwXiXYbOfM?=
 =?us-ascii?Q?X7ApHeNaNO+AvGTlmHq+N1t3XHGm0S5d1M9hGR2gRk+xd07BulSr0ZVPNXkf?=
 =?us-ascii?Q?ZC5Ks4295DZRR+IaQnXZfHHtlJBgl5ppgMPejaehNI8KA8nFc7rMGND6BMKj?=
 =?us-ascii?Q?4IBOhdqI1TNTFx0i4IgmH4NZvJ82rPaF0EtQzT8QVP2dh41nymXc9AKAmNIn?=
 =?us-ascii?Q?OnOINBaA2p37J0HswbSKFJ/2xTS+H+NtZ04EMS1x9xLVXILc0x/w4XjLDaI1?=
 =?us-ascii?Q?Z+8RkuI7AUg857zEqkKKyzb5yQOKgZZELEobLE9APxYH7f4idKiLcU4hQ3FQ?=
 =?us-ascii?Q?JBTlTiZ/r6HrQ9wFGf702D54+AIuniXTULnOcC9xkOzw1M57k7P0Yq/eHI2I?=
 =?us-ascii?Q?fBBj6kKl4ymV1WNujNTeW/jgv1PggqZ41e6WGkk8WSvjpHw35kzY9K+dTppx?=
 =?us-ascii?Q?edRyPZYjjHkSW7W+dPq3Cp/Sw0tXIIgKXG7aUsf9uqI2wJ7bnNGEK09cqrTT?=
 =?us-ascii?Q?2Zyd7nriWGDfI6qFm7rXGboCFGfIuiN7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogqvUy4IIOx8h+/r4kbFut08yoDV8Vl7KQ2FJRIU+MqB6L4TdkqhSURf8ax7?=
 =?us-ascii?Q?J70CFvRumT0HkwIEUUJt4nVsLwptKv2T8NSMHclrrBAJldqQf4sPmTd/iXHJ?=
 =?us-ascii?Q?H/m0GsRPTdnxZZBHhDmlYbjB1GjmuN+Rd/Xal2saRRDthaQ8LpR7mVplCRE0?=
 =?us-ascii?Q?0gZJouruMG1knbFOt6l9Jsxhh++lww5Delfmek6ipE+68xu4NvrINiMJ57eP?=
 =?us-ascii?Q?iS+wh9IdjDXmkPmm93RnN3SJ/UcFeYiDg2Yq+WM+VAv69R0VHFop1DIfMrzu?=
 =?us-ascii?Q?9cRbOZ8Mm54NZAaGL1qdu5x+PJ+Uhd/Et9Bx2W2AGbPtM2nckLzyMKXG7vFW?=
 =?us-ascii?Q?yEOaUYZ9eoBbikIJX8UzeWJsSpzwdHuN/Qge28TXWd78YqeZV3653gDGSpp4?=
 =?us-ascii?Q?xgbODriADmzawVv8vkYKmxzV29OAJmqTfZVZV99z38YErSUUOmI1QloA+qHz?=
 =?us-ascii?Q?zhwTgKuBVayUnXWKUiGDN7dC6YbsFF7YeJORsVa6cT4Gm/eDQnoCQHyvKKGs?=
 =?us-ascii?Q?9ocNk1gWKUPgUnyQWnWe55wQQJVULousfi6K0dD4Kip9tsh8lDTpTIfzZ3ja?=
 =?us-ascii?Q?hhOumGT1UuMPW6gm8aGodlQzZQWtbduD0bjkYHquMFMU/xY6wPxjc9oRkrhc?=
 =?us-ascii?Q?d7iPb7FNjk2gE9u1gTmtDoWiw2ly/dNNzInmwtCrINy3M2x2EOExMiLLeEDC?=
 =?us-ascii?Q?jZm+L+clMJiYbjyf/IcE+1rSG/+qnvWO7XlfNbarYs4ITGjTcKZKDxw8+UWo?=
 =?us-ascii?Q?FHzt4/2pn2YqYG2C8ONYFgKt1rMEqEKFiVYkQd8WdnT3NO02iEZSNh/86CT9?=
 =?us-ascii?Q?0WLnQtGwN43jzwYbHwavkrxMeW3g8HyXw1R8mIwfzs7G0oFmb1HuY8dOWNie?=
 =?us-ascii?Q?bmihqbugyamRsuwlKRupzuowyieq3wizAFJxllqfc4HEeCEu+7JF+XdWtz4D?=
 =?us-ascii?Q?pXKuN/uSgX5VjfHpFvovYgwN8/SlIvXghjHHAmShNlJiwi9a9WIH/+cTA1yP?=
 =?us-ascii?Q?oP4lERwBEQ+q2RnLr9aJefpFaLZ+axvEF0MR1bHjEXbgTOvGgk2rpTKn9GXg?=
 =?us-ascii?Q?+/tC6zy83RYCXToANABFxjKuC7xunN0CjPSKgd9jPtewcuQGmvIZvDB/5SNP?=
 =?us-ascii?Q?pv3TJyQfqNzudRI9qHp07NEiLstoET6Vn6Rtm3B2DmxTT0q8q3bhLnP+BvU5?=
 =?us-ascii?Q?TZR43dRwy+z4LWpUVrEmj8Ujt8tTQ0flEuA/p7ys2b4iVPnHpbS0eVLOOnAf?=
 =?us-ascii?Q?h3LRYh7ts8apOtfUUTPBa3vl4Daarg1AYBrPb3AB7ButexndpDUxJbLx0hiR?=
 =?us-ascii?Q?AB3GRHwZRB73/EFdXtftDmdHKn+sD106wKdhNzqLngS7hfjjSnoXG6AUo37U?=
 =?us-ascii?Q?6mCLlJzHxci1aGJnP6G742eQAuaS/xtSjBJmX17QeS8XPa/LNAVm1R/HEO7M?=
 =?us-ascii?Q?RgEBXZ81uDIFCugvbUic7UqDErUl7DCf8o/zZDqNhbhUif5tMcuPmv9+XY0M?=
 =?us-ascii?Q?pl8UvNcG32Bed5f66yqsAaWuT/VcMrwWv+lsTQqXUJvw7OunvU1UvB0FpRZ+?=
 =?us-ascii?Q?/kim04tblutnsBgql7WZidKRwVt4LaPppw35tSrl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e9399c-4ac4-46ef-e5d9-08dd54c69f8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:21.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wauXLYPng65IEivUnV72Ri5gASbrzXCeKvpEt9NZvlWW1uJ7qHRCpQtLysMMI2qj8fvGyvDdO3l9T2qID5Velg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

The enetc4_link_init() is called when the PF driver probes to create
phylink and MDIO bus, but we forgot to call enetc4_link_deinit() to
free the phylink and MDIO bus when the driver was unbound. so add
missing enetc4_link_deinit() to enetc4_pf_netdev_destroy().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index fc41078c4f5d..48861c8b499a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -684,6 +684,7 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
+	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
 }
-- 
2.34.1


