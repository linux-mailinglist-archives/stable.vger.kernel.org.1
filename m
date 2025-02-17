Return-Path: <stable+bounces-116546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C0A37F21
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554471891297
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCA21767A;
	Mon, 17 Feb 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j8ZBHNPD"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE85216E07;
	Mon, 17 Feb 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786188; cv=fail; b=pUWLJUfmlJFojr30jw/AR/omX8vdCG+KDyU2834Gtq0Uen9sQNbr1ZnMGc7D0VmodkHbKBBpBQYvMjmKLV5KCOYU781hbb3aXnlsWVELMeiSwKpWbMNAMvWG9QN5jRTpJkkofT2nbYZONbPXqaM9yhkiZXa3aPWVvFr/N4+DzuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786188; c=relaxed/simple;
	bh=Z5MLH+FRnOZi/8gfSUJIPu/ziRJyoqyDeDTH88SWovM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nk9KFNHDl3BI74TTA5IgQDSGwZbihlfFOJ/1sqNc9hhI29kyG06h6eAhaZIq3Sfh+X6+cSj+N56OKEvzrKMxPEXnfWQYgvimLoAC5cFa6oVJEr0FGLlh+h7CALmqRR129PI2UQdpYISEGjJHhH6P/tL9VhpwP3mnq6c4WS4hXys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j8ZBHNPD; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNXiKGF6p/jOFNKGXs+8JMc6xkv+LSvFdjiKsLIjKnZrs8+D/jOpY5Dx5I0yNgev46IdfsUALD/Cd1h7N4gkP9ebUOrfidChao9ogzpuJqLV8dbv9Q2e/tyHY2wVJHdQnD6s3V1sxpDmyzUgcsAQZ++EgnLubndN4sPGTpZNo727+nmmtjQQRrGze8I9Xr4UicqYkoU0cB+XNTjQM24EnmFPQ4vWI+wGq3bgOZgrBdzwMHNJUkG6QvDpCFcuJMTUCdsoSw5E7G0QuS/My30Cecsuot3rXMK+nWOXI7z8jY/axNmkdNBEH3zGEvBksp5nasZQQxF45JaI2Ya4MMKwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V5bxYjuiFZc0YoMYFLe4abEuLcZOtZuN1nUb32Hos4=;
 b=zQp1lH1B6qSLBJUwiqUFGCkk5/gXPoaaqCFwOepLRDV/ANeClDnXqT7AIC1EI3NLnOs5fR8jeMzRbLuNBU8vLiij0ahP5bPqdmj7Vs+GACm1I9FgGUgZU1d4i1sGmQr2WmJ4s2DuQA44uRGGCDvtaR2az8Guoc6oiX9jj7WLDXXCqDBxzrWFjeimIgkde84jNntcw47o/rbvDMR2/h2EKCGHMi3eZN5ov/nFaeqPsh+PjpQijsLjZuWuYkLZCrAyBBBg3K6h5iq7ezts4Hd2SFyE6e8x0BZnu9FkImY19RSVWZqCQ/9IxyRRjqEx8zgC+f12PSQirj0Sm4Jzrjsz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V5bxYjuiFZc0YoMYFLe4abEuLcZOtZuN1nUb32Hos4=;
 b=j8ZBHNPDlsje5+PVIjmEGZV1Mz7DLbpSpYZyWejqMERFa+GJwlRGNaaqUc4SYIWP1fLkIqGTTIEZIJgYW1YPpy4/LEBJG984+b5KKhed01BL+hlaAyZEqMFfOx1Z4Iu2NUcJqlufn0zLxAMW1ZXJ3uOChic7AKXl+fEgIwaBycJxuAxQwEt9pbrOW4QomyIbWUQFGb156XqhNtHXsFYf3ahT0ATTdhO6sDkzDFMfhNAzqWGjWryoWzIkFPqwkym/gCVNTZHjR2Ve+nKZcoJKxxAAxBSIdVL7C+cW40vAYT5K91SNj43pYIvSal5FQoCSZ9NimIJXGBpjTXYv+ZauPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:23 +0000
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
Subject: [PATCH net 2/8] net: enetc: correct the tx_swbd statistics
Date: Mon, 17 Feb 2025 17:39:00 +0800
Message-Id: <20250217093906.506214-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdf92d99-1215-4413-f61f-08dd4f395634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7afctV5AkP2PYAuQRmf3K5w4d24cNG2F5ir/B+e4ReDpcrnLooVJUol79/i?=
 =?us-ascii?Q?ygray5ImNREVoyBY41uq6unb4zcPORgdV05aUk6tzJ8ShcndOhUqGY1OFesX?=
 =?us-ascii?Q?sXumlevC5ed+o8X3/jxWPFZauyyVohd7VF9AFSm9wce/SwfvOILs/pKkHmxN?=
 =?us-ascii?Q?ceAZCotnyKGsHeO374rpv1QM2Py89iaOPW5TXTI5BoU3s6aJrGdjODZuSK+J?=
 =?us-ascii?Q?CUOAHkyUTVbV4/ZBK/X2QY+qyxzs6gPGYTCSZvIBLDswSKZNtKo4OrMd6C1E?=
 =?us-ascii?Q?1DpYpaMc9OILE62bol9z+qyUsNZA9iQAwG2y97vFcahT/eRM4AlsxIr4w+l+?=
 =?us-ascii?Q?qMXqT0/OlNsrNR6lBvTYwRTJbaNwMYg9x10nCKoQE56vcZ6C71yyU0JgmEjs?=
 =?us-ascii?Q?0TPF4D5KaaG9YOjATzz7g60gspUNvyllncSFTkXeaP7BMIbikwnKx4rBPoaF?=
 =?us-ascii?Q?FClm//bVe8Iu3LnAsP113Dlmx7fbQrKnuAUmPkngY2pyeMMJs9SNYpP6a+yB?=
 =?us-ascii?Q?wHlNEWnEGQxn0lV0+g9HxdZJ+ZRayw4T5TqT6SMVe7wNxhfg8l+vTkA7kXcc?=
 =?us-ascii?Q?Q2UF7aqc156abzmLEtjFUSTOIeAIYSdK8embU9rgSIQaCqm2g87GWzPhYSv3?=
 =?us-ascii?Q?LA1t4rfzeLlSAtNAqNZdYVl/dKWeDvVaTh76KPYFw6daM7/W9239Dm9k/XyY?=
 =?us-ascii?Q?0hjtti5y8UBzs0kyM0guhQVdb71jMeWWnr0GTE2NpYVybGLOMTiERwKg4U8y?=
 =?us-ascii?Q?oXEmShFRsjIb854ZQw7EXAhJjhXZnwMvBUMhRGgQCZDDJ4RLJA0zUTFZQsW8?=
 =?us-ascii?Q?EDqCMkmLs0Bql+3OoAcGkd9Luow0a4GNt8c9658iBX2Kwq1z8t51gBNOPjc+?=
 =?us-ascii?Q?oLBYfQf2gwvjKvsuyVv4qi3vzIVYDlzAlv/7eEPu6UXDjx0v7t0PzrpnkMS5?=
 =?us-ascii?Q?g8Ev2baeuV4wWLxmChyj520P1m+5l2e5lc2ztZQBfZh0Sb9WF6s2MV+nXIOV?=
 =?us-ascii?Q?sdZrn15SHlhtjJgEIAe/9I7AJiFZIAQsujXf2pXHL2yCUITS/+QxBSqLLBGW?=
 =?us-ascii?Q?AJS7thivf7vwkLJXrTcwgIpiVSiOIPTGVAh0WDlICdrUyW/C64Kx/tqL8chu?=
 =?us-ascii?Q?6VgO23nF0kQUon/ekGsBJXVmuWaHTNF9uHquR6z2hrQ03T5cjKlMJCNGl3rT?=
 =?us-ascii?Q?HdwBokYlOR2gPpBYX4/wHocTv8JE4lt0xTcT0JYGJuD1gnFhyvBbrZc3ntFU?=
 =?us-ascii?Q?/fuwqAJZcRgouvgEM5A487DyCvaJpJ3Rz5BpnPekYcLnPJoNG9GWJ02V7hVP?=
 =?us-ascii?Q?DMzS4WRCR6DZnzhkR2ipoVtMpSs1KqMI4qkz93tceUVsgegqvAnWqcYbgikh?=
 =?us-ascii?Q?s33mX/bUkpq6C+MfiEQpaEnKXpGVpwUJ0vmHir8Rqq077t7agyP5r62v89k4?=
 =?us-ascii?Q?R/A7xa0OFIGntKWjcE11KhnEftEOBSks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuykpByE1q7bOxuTHq2LDxr+XeEG6Aqj2CUhiXXFtgUsXTaU9e8W44Qzbe1o?=
 =?us-ascii?Q?iRSjA05lOCQMZ7lBPiW8HMsP1PslMNGUPKYw8kqBlMIY0UAlKKMMo5+r2IKi?=
 =?us-ascii?Q?8o3qV1aNJJ7koJA/DaWlsTx8DI249bKfm3l0/XhFk08uVFBL6AT9Phi7LrbM?=
 =?us-ascii?Q?FqBnQDxo+OG9T2vot2YJ9PIyWaU3go+uCKwxutkuWkt2yf9OchuIARC9vDK4?=
 =?us-ascii?Q?yOsDPN1BD72GdTNrGiKHtJ+EBOTNLTh2+41P4IajkrpTHXX7tEK1Zg8SZEr2?=
 =?us-ascii?Q?OToHHax3av3+QsyRJIkB8yDJTKyzugMux3CmPYm+BjltbGOoPgSnE9pCqbsO?=
 =?us-ascii?Q?I9fcc68p6Udy+kQ/mvpOw1P8yDVD34cSdnpv+Cmas6RdrEqha0ZaNXIfi5sE?=
 =?us-ascii?Q?oY6+1UmJsWFr5mVJQkwZW84faY0xOgzWg23DJKSspMZsi1pSdMpfGXDajkIW?=
 =?us-ascii?Q?T4Gk6cniMOsG1Kh5EZ0YB5Cle/8bix6sad2vXXdHuSOBrETZsN+jxEYltnOo?=
 =?us-ascii?Q?7Lh2GFmMuUKDyllvDhBmGFz4N7TNX84KVb6oO8Eo7WFUNlJn5PDl0ZfKJxEU?=
 =?us-ascii?Q?aMny3s4Qjf7V8mDVG2sa0KycBCXHet18ZVp55Haa8Re8PuLeGjQ8XRwP4umx?=
 =?us-ascii?Q?ojYCxKArTHR1ryDW4lqUlfAkcmxymZv0lYxn7IvUFbsysmMr06e35GYbo+Bg?=
 =?us-ascii?Q?3XsWVbxTdsvN6tHvXInQ85YU+bn4Nd9JY6ZHbgzYWDdXAj1mWaL/P6kBjsDp?=
 =?us-ascii?Q?dnp8n9SLbIcP2YgGq63ZFomWSmF8iTQ8wl+B5evpiXimEEWvE+OFFnzJSbwq?=
 =?us-ascii?Q?Lm598LgSD+eFmlE42bq1D9oQR9LcvssGSj/I0w8ybf7CoN5nhUl2y0elXso7?=
 =?us-ascii?Q?cVrYbRb0TxA09skkY9HZXg2+kc1bCdFyMfvN1jyv3MbmH/iieGcFJtWh7zL8?=
 =?us-ascii?Q?iioZg5qHe+gKoJc/UJBcAWE/aG8oIde/izwdMluJJRmpKbpot7//nPVwexWF?=
 =?us-ascii?Q?IgDnEITQh3pYvxeyl+kEuIa6YVDpOSoDpvWWeNLSh5jDOaiNdijf1pwp3KD7?=
 =?us-ascii?Q?fa5liNGt0pQWqTQxh686P7jrbWSBqYjokWYAMkI7cifxAsJHa8Zt9vIuV65x?=
 =?us-ascii?Q?ODn8SZPQ8asu6V0h5TsP7bXVUAEa4J3WIMXhBXKznXPLXLa8eL64NEDfGXRC?=
 =?us-ascii?Q?XF86KhbTxUSWjU9Q4DMGw6YOdou9gfM6lQ8L21hakpYWTXY3hG4SLRCQttE1?=
 =?us-ascii?Q?uFwdlfUhYO/zHDew7cm6H1frIyyIjsJXKw7HOMIfb1lOoaAen64GO+w/yfLJ?=
 =?us-ascii?Q?vhN8K9TooKW2E+lJ7DBI7iyZTTgxZoIz5M0oGv6SsE6afSnstJPl6QuG8i2C?=
 =?us-ascii?Q?B8xB/BM1wA8pbXoDo+bs0Y3h1K5VTOB5QlZ+MZy8ZNQl0WBwSDTljRFew6Vz?=
 =?us-ascii?Q?oefH3wWnHA88XUrhdKPpsWquIWsUEDWB2U71yW73v2zP/Iw1cLZ0G6UScVb5?=
 =?us-ascii?Q?7ONeDyjOS3tR6Te4WfATfcoRYrM5pXVjMyRqfyzajKA7WT59AIDK6Y/bNAZc?=
 =?us-ascii?Q?w2G0JU1rr+IkbjQBBi1wytr5B4a+VCR30jCN9qYL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf92d99-1215-4413-f61f-08dd4f395634
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:23.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spdCMnOeQeadlc1nnfHjW5siTFQGAR0Hw6GkFB9Xbjda9NxILMu7Oxf9zu1QeNLY7alULxZHnEDgM/QSta4PHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

When creating a TSO header, if the skb is VLAN tagged, the extended BD
will be used and the 'count' should be increased by 2 instead of 1.
Otherwise, when an error occurs, less tx_swbd will be freed than the
actual number.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f7bc2fc33a76..0a1cea368280 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -759,6 +759,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	bool ext_bd = skb_vlan_tag_present(skb);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -792,7 +793,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
 		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
 		bd_data_num = 0;
-		count++;
+		count += ext_bd ? 2 : 1;
 
 		while (data_len > 0) {
 			int size;
-- 
2.34.1


