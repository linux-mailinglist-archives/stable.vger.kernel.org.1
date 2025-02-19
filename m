Return-Path: <stable+bounces-116971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A384A3B150
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C08F1897FE4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292B1CF5C0;
	Wed, 19 Feb 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OunjxoqR"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFC1CCEE7;
	Wed, 19 Feb 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944832; cv=fail; b=Swd4B5obFlp4tOURNX9w8wRy9byizePbW3ik4KDJE1tcXp73sw2gWXkIzf5+McnarVMtBd5F5XIR2nFTFYtWngg35M8x1ONbdPJ6mAhRCbGfoPXHZWxUd+Y2o9dPSNMLHkaN/In8peD3PNnaIWLehhksjvh7QvN+A+nzKaSNVaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944832; c=relaxed/simple;
	bh=d5syhM+1/mG1CwjQgg4EJoAooeiENcpIOC6WIXxW0Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N00mzadojSrXxee/h9N4Q3l9qSuHWkLEqXpKhOBmU03D9E6wEp+1Y3xhWtCWoAk/nSALcZqlDDa+4NrWukY8S5rZHQcydD9EB+6CrQ821OosTnJWyhO1YdKC35sOa8V05Czirg7ALu6dg6YSQyj6YuqLj3QYg3K0uAWwc00cQ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OunjxoqR; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyD74ugDMNxRmgURjk45lgRKXiLCMraQSF1fQSCkgni0wtFmuKf6l6ylyB3kSqdpK87qBubOMjCObkVNIpq+p40mNDtXFDch739OdeUQk6Oqj4uaO9miRRyuW73RPWqSsuj8nlirUZrv7DAOXoRTRfA6ig0/6nYMeTz3WSwzvjKimWLOQlcOV9ZWsKo9qDmbyMF9HLFdPfmdnEOYFu0JzBgLNLOONM/WvbkxQTz+X54kAlff6DxUHzKFJe0y1cnA+K0iB+2PhTGOpSnhsFCgZvMW+tsThXg557/BEe8exD/lCbgTAdiBZvAKCgKxMRyd4f0n95MkyG92loqA3qu1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv0EF12VetJkAtI6zvtFQaruFyXr2djdYe7DShCNJk0=;
 b=v71SaQQa1gfTOiumK/MlcQX23hmaxv3M7eY8XDHEcjxBDh8GyJSm9g7YyCrAzYb2ogMFK1sCDmjEYxUHHVUrtmK8AKPehhLZP9dOcFWKzKTsmE0tNRX7e+40WBreJs0fLBfLBCdE8kloCAlkS3kNIiSObmqUVm2f6miXEqQlDOIr8M5unBut8LhjQ4Bsx8L2gVTZXgE1bnwEwCEqE+WRa1DodpywUVw2CRitgNMbFbOds+fx+dKzc/KhZxe04ENVOOU/jGDZ10F3XlJVg9X1GacTTrG4fv68K795Fh+zAGsO6BJNkjyaPAhx2agIAj+aP59xU0MlB7zlZtaUSuRz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv0EF12VetJkAtI6zvtFQaruFyXr2djdYe7DShCNJk0=;
 b=OunjxoqR46i1uSKCgXgLF8RiHgY1XmTKjC+w25drfSzxpgZogpTnu+TiHu+HaGpS1nCT0/qVhkCg89T0w+vpiImxt+tV/qhVb7WBPq6sD84oNkhXfUwAWu1xV9DpNDf8dSH5OvYBzHuyjE3XdhRcNgExI/PRtjS4caG+uCPctSGNwDFm8nAkX8rK8aj2MQjhBRZ/I9b227SiBfmvP0l4TUjOpf9pKRLdN8WHYSAG+hvn6V8zk3P8p8EPEDwYdM1ucYH42IC8fyV0wGVziNr9RwTsUA8yv0B1M0wbMIgSVlbWZrAN8Ynk3xMvpwLyONHGGUY4jtnQQ5kMKPtCYcgQDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:28 +0000
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
Subject: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()
Date: Wed, 19 Feb 2025 13:42:47 +0800
Message-Id: <20250219054247.733243-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec3903d2-99f7-4252-a971-08dd50aab605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZyGhHcv8yhEJbmEx8EmyG37zVNQFkTtJVtC4twss5UZttg8Z6ACgLk+Vk2o?=
 =?us-ascii?Q?Y4n41AM6QCxzFhHisMx3XQOM/wtXnwx4DmJy2kcUqCrM8364Kps6zM+RSQ40?=
 =?us-ascii?Q?yxfXcLQwRrHqU+j3Vx5kXk2yDjz2gm915Tj+jyW5GEE/8kBygJiPaN3BhgD6?=
 =?us-ascii?Q?Aw46uzX1YhBIqru6R13Evq+emfUcAp0zbMTmiMXIhsdNyWepk4WRgAp1usUU?=
 =?us-ascii?Q?Z89uviWKEMhXtQDnoQRUmUeMPaOsONEPbNOjCndokxV0GT5ZqpGyAKzOid2b?=
 =?us-ascii?Q?LUB/SZbBqIPOrLXsM7yavEeq/hh46ApnZ957QVNGQo79Cve/83N3UN5HHh/i?=
 =?us-ascii?Q?DeVdJM64Ue8gZOWxfPexBN7HrJwEA7pJHg94I2+QL0+zjxOYNQ0+9474Mp86?=
 =?us-ascii?Q?+iZJEVf9+jPawZ6vbF4OD0igFKSSUtQtdTVOA6ZlbrqkurJX+JruNWAJL3Dq?=
 =?us-ascii?Q?BpB2nAT4Er/uO4xoR0PBVEpzEYyettCWg3L6Zqy3218KjJRQ0sriRyU6pkxc?=
 =?us-ascii?Q?nUtwlP1OI8/zKvApyU2lYyrTdwM/JDiOnK8ehNJl2WFwDZqmIrKS8MeIJIRE?=
 =?us-ascii?Q?A133fwKOmLCHbgaPOBnYRHiJpUdXejqtB/4p2Ix8pPWxWGJTQsSP0Qlp0wEB?=
 =?us-ascii?Q?80LzH1t7UeQrVK6nAmUFFY6cWwRkHiBqSiPzKeT1QCByE+yIRd5PMmds+V5L?=
 =?us-ascii?Q?aemHomb6n7e1S1oxD3YfUzRQW5hJzsDmFPJk2UOVXFsTkPJEzj0kXhMGpPIz?=
 =?us-ascii?Q?loqMN2hCrYYJXY6E9eqEXH19dwW5FiAVf1tHvMxVnWW3oUsyabJb0xQLn3pu?=
 =?us-ascii?Q?eG7iDTDbtVuKBPHXC+B4BDRpRnHpv+VnhzfiPrncIDoZ41w6LsO1kaJ0o8QV?=
 =?us-ascii?Q?s6ux9W/6LfN94hp6F5znpNIPoYqTejfghvftHZdXTSvd+iGAsZ1k7ZP/lL40?=
 =?us-ascii?Q?/ezxYNcJkdbPcEgiii2dXuxj1lSsN4dd8GyXx4/eiv3l3sN8YtpavZN09Jt5?=
 =?us-ascii?Q?BioDU+Tq5P9gHGCjvXkX3DHFaAgvJ9arr2ge5Q5CLsZWXGTmGd6LT9wVxNxo?=
 =?us-ascii?Q?oBqQWuqneeC1zKr3Sn/Wepu1GtavAxKqG8Fi5IBUH26RizrPuFUX7wP3miGk?=
 =?us-ascii?Q?1BPlMMsMJKamYfLL7nnkVGP2oh39hc+TNhR8H4ZmciKhBYPyW4cyOKnYglJK?=
 =?us-ascii?Q?6AQTdZJkVa/yeVWUR6xgNiG5g7MD4hNbS5CpSkgCLMXEDVbCAgEa2X1fwNPW?=
 =?us-ascii?Q?x8PUeFuW3GcYzHN41urKhRE/luAKWUhOampukNvCe377PjNrtJAvvOBMCz2x?=
 =?us-ascii?Q?ICMTQbRSDtxEl5kfl92gXxnVLZEuFVJgeDjXBfgeMLCJF/dDDu9NbcUUqRDb?=
 =?us-ascii?Q?yfSC/J/w1sSqKF6MLiQqs8psa3vHRee6g8/wzMbibT3il9E4/Pj85QeHN78r?=
 =?us-ascii?Q?NmyOfX0SD2wDmbsKpxU6c8cl+LEaWOzZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Vca9qcNYBTO+eKS9uCcAPuOWRdDV5mVrEnViadzSsTGqycSoxVNWS0ey3vj?=
 =?us-ascii?Q?x4EagF/zwDwHz46OrKZN3TNlBbWfHvZs9jQzxuy7SLBD9zt9qqF6lMW+VWj1?=
 =?us-ascii?Q?+0LskTCn6/Cw8sN5jY0K+wRzIbzUnPlVtugm3ug3I25R1UT4SEONdJUs+Yam?=
 =?us-ascii?Q?BnhpvIHeRa3khOwaFdcmu8Bu8EFCdiZCjbQFDisBSWEpQGxaVBHmiz/QMxJY?=
 =?us-ascii?Q?5kGbUYXa8LSJcky5gKYQuhft8gqXlzHcxT9fQM1xc8FA2TI+BG49yLnY07iN?=
 =?us-ascii?Q?RTomPNSOsUT2IHzT/ZauMPVNsLm55xOLo2EJHV7KtxDRmfku/2OPTSJMYIHO?=
 =?us-ascii?Q?ZOpIuMmGi3HqWN/awnECqTfcK3DksL24GWrBy3OYT/8AbmJ2k+sV9x9SoLMr?=
 =?us-ascii?Q?8yL/+BNvD9ZiRvB4JMtrn5G47VMTRpohqEtTZNr6NMdgeZswyhtO0WzqPLNV?=
 =?us-ascii?Q?DJ/6KkzdLW8T8XtYTkftjU++zSeqJI0Z+l+ABL3MTmCHWc4HsIBwb8G6nz5S?=
 =?us-ascii?Q?Cmzp95gEIzniDzZAXRsqhLIbTvhqbJ4Bg8fRp/VZ+aiuN/26s2Wk68jlRl+w?=
 =?us-ascii?Q?H2HunxZnZ7sPmW9gI3fKOfzmplMQbMIXQEt2uMUJVF7EkJ/HbFwcTmenTOK/?=
 =?us-ascii?Q?SsUNHlm+otVF3mDR88sdFzp3LwYBbdqkTIcODeuBZh56R8BFMZlsbA0aztF3?=
 =?us-ascii?Q?pkk7+aM1zeP2fYoMk0AimHJI/3rEDmLGWzv0lwq0UjY4RtVBz9+fg8QtbXcQ?=
 =?us-ascii?Q?PsmuEuUl7e7a+bjHWxWsaq3/tdFJa/wlh60eSu8aAkzbeLHb8dXddSpev23c?=
 =?us-ascii?Q?co3u1oF5ub9fC07VO/865z2GoQzcqFMwUcrTI34gkyf3Bcvy72/Fwl5dPcju?=
 =?us-ascii?Q?7u4iyYKhroXiglRqqv2d0yjVY7emlz52bugdGp9wY8QmhUQKsPsxajSPHebg?=
 =?us-ascii?Q?ku/PJuQkHS8mPF2EvGsXY0qWWo1PkBszHlw+oF9aBGZh7P4coCXtxizrr75A?=
 =?us-ascii?Q?qOyx7YpaaIQGTArOlhLH9a3FAjLlI6zHa5kZWtoa4zFrf+wgf9DkFNlEhvId?=
 =?us-ascii?Q?je/yJc+eiA6aN1G/movL6ipl9y9rcr8PkcRoY+RBPqjljuyzgRngiyaQXm6z?=
 =?us-ascii?Q?VcMLKaReIZKVz7ttvQsxJMVf5ts2f7Z92GyWbC/wnu4EdL6PFjAQ2BhFTZKw?=
 =?us-ascii?Q?osx2Jg95QU/lttmGryT6S6Cwi8gzWzmGdM2P6n2tle7T5QNdiIDM7V0mqtbb?=
 =?us-ascii?Q?yS2wOhBAFYNuSuz/I86UTy4t0exSPAM9IOPnHc2cpvDu7rwHw5kYB++6Z9Bg?=
 =?us-ascii?Q?fG9M4CCaykOmWAAcHE4yNPwAe4nNSy99syILz2cV4OAI+7/bzCp8mIylslM0?=
 =?us-ascii?Q?8UH3HFvX7mK+a8/kW9681VMKZrq9BE1hluhhayJIOIN0SdbXJa0QBJbRfsVd?=
 =?us-ascii?Q?oTHpFwF5jtxo7BBNsyWgge0NUXgOHB/UB1+V+G+pLCbVHJHNwPmj6P1VP+wi?=
 =?us-ascii?Q?fqxL2Ci02I8PsCxcgrYkwa7Pq+YHt8M3QsPOFEN+D3yuEX6GZJAEdmfapTc5?=
 =?us-ascii?Q?W3S0DkORll4qCJJH4H1QkWEliDIouwY7Y5bVFQhk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3903d2-99f7-4252-a971-08dd50aab605
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:28.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRtRGnXPS977dkxNtkaxXMJz2v0VkrN6l8YYxXJ+OjfLh7D2vwUpW9KRbLk2e154eObCjhqbXxQ9KsJtpi86Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

There is an off-by-one issue for the err_chained_bd path, it will free
one more tx_swbd than expected. But there is no such issue for the
err_map_data path. To fix this off-by-one issue and make the two error
handling consistent, the loop condition of error handling is modified
and the 'count++' operation is moved before enetc_map_tx_tso_data().

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9a24d1176479..fe3967268a19 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			txbd = ENETC_TXBD(*tx_ring, i);
 			tx_swbd = &tx_ring->tx_swbd[i];
 			prefetchw(txbd);
+			count++;
 
 			/* Compute the checksum over this segment of data and
 			 * add it to the csum already computed (over the L4
@@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 				goto err_map_data;
 
 			data_len -= size;
-			count++;
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
@@ -874,13 +874,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	do {
+	while (count--) {
 		tx_swbd = &tx_ring->tx_swbd[i];
 		enetc_free_tx_frame(tx_ring, tx_swbd);
 		if (i == 0)
 			i = tx_ring->bd_count;
 		i--;
-	} while (count--);
+	}
 
 	return 0;
 }
-- 
2.34.1


