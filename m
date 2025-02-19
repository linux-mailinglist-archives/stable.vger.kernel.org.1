Return-Path: <stable+bounces-116964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F6A3B13C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED503B1D79
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D41C174E;
	Wed, 19 Feb 2025 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SuXC5DVr"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F01BFDFC;
	Wed, 19 Feb 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944797; cv=fail; b=V8TmIFOattaZWQ+5oQjeHFjjGBE4XsiDg035vRjmsHwBUd9WFJ8/RAM3Z+EXBgq1g9B2xA+4B1lL3TNLyZU8SH/Duoum1luJ6DquIeiRtRTLd2hrauF8XWFk0Tq+J60XpfJusjTBVD75szcn9M3vr+bFmWmxkkqBK8+lZWHkvmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944797; c=relaxed/simple;
	bh=9BL2G3E8UqnQEtOj/Orzb2xv5RxUh9YT1EiH/AkkNmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5UWc9SXetHZu+e8sdfV/E5VoR5QfWhqNCtwd87W65GdMoZZHvM6l7i/Fn+Fox99+iax2AXGpWfQcNtW1LB9D8QjoB16vcC0j9GVzK0o1CuXIW93c+7+U4np+1a+lWOTRG3gjGpmuWZkPIuMZM0eGTrgNGmjq1cJ2d1fG+9LGlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SuXC5DVr; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpSPw8rKwB+0U3HVEr14labNIcGZsmlHbBdPULT7FkYCRAvvcGVm/aIBGThORlqwGf5ohgHuUpc2SkZa8aLslb9xMOnp585TGEoURnx/yXaqs/MZl9c+7AmQ0igHe4eC05TJe3NNvmU1slzTpm9troAIjoNtzvUL9FvuUmL1eItEdHxICzf7mN1F/ebhn9s3NZiWiSIM2xD5X3jnpNFaiit28T5sdSsPBVFP8ZKQu6XcsOHxjfHQTIOfdtbnWgIUTH60q2NqrbP+uCmF6nmDy+wc7KA3ZIIfLT0P9B3Jx82F+1745s5ZA+HERe2C5rRCN5JUoh0NDLI8qztYqskF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n3wcYp2XOkjCupQLVpXrM//xX1NZCMsSvlSk7sq/mg=;
 b=K5MWtJFrGj8yARml3uJPU0cgPhq9N8GB1EB8uq7PN+X28QsEE0KJyIlFq5y5Ruz0b8jJwo7hwv2UXRHHRLIstUnTsIIdzZ6tWIbcYI/7EOCK1TIo3GzD/M/bvOi5Buo23TyjkP86CXN01dFrWPRgLMZYBHEtvM7zXIEdWEl2hI5DwMsLhibrKxR5XaKZVbIJ7ODv+2tM8wEWRJutCGLvAP4tTHVwrxBP1rIUTTOUmXvQ3Cvg7k8/h5cr0KuyaHIk2tiLkCaLKWc+EMiRJKUH0hVPajSP/8zSd1+mrf61+Gl4hkaCPV2kVJgFLqv6+awz6NK54TS6smPTHMDxGZEHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n3wcYp2XOkjCupQLVpXrM//xX1NZCMsSvlSk7sq/mg=;
 b=SuXC5DVrz043H3jFg8cufjti/95qaucXx/Fp0c47T+qlsS38X5xRuyPlRpAeJmvWZnzzeWfOSsOps9gsr8Tl+Ao8IQ2d0NHyMKtA7PNMr6HxDxLrKtZfuxDcMzNFW2bxP6cHREU+jztKBfsEu7Nj+UI0gRAFSdGn1k74e3rYwUtc1j0HiFEm4xkLRZn0Y9ttSzSUU011PzGVUbOGbRkEjXlDy5mdrhCL0PGCdcq2CYFW1QsmMxGKOuFID/ZqynaA+tzsc/D3NJiXymUjpmfbh1wHymK6LmqnNQ8uLRt2WWcYCJdPt720WrOayNGt25jkBYZRLRIHfz9bf2msTXDCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 05:59:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 05:59:54 +0000
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
Subject: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Date: Wed, 19 Feb 2025 13:42:40 +0800
Message-Id: <20250219054247.733243-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5645940-7284-4f4a-36c9-08dd50aaa1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wkWw5X7UThqKk/FT7Ym1is17G/waHGCwEhRvPjAyEPUQnUIcFvwRLzN5d56n?=
 =?us-ascii?Q?Izpgd7Gl6TVuYg/zQh1G/mMDg4Me6zbrcza06djh1hZ2tZpGhU96N7fRR9gT?=
 =?us-ascii?Q?7EcZw87AwH54xZy7fqD7/v8zd1NJ1kvd//+VBSyCn8c1vHm/C4x021q82Amb?=
 =?us-ascii?Q?/6FUoVKy6hCTtqMcyKf6xVGEE0BLoYOKTSBhgbjCG3HccSEnKbj7Mz+0fZ/T?=
 =?us-ascii?Q?5G/CflQXhwgl4IH4HWIg5xiwbws8nc4mI/GMaXbU1o70rhY7Tmcy1xDtXUJe?=
 =?us-ascii?Q?pEgJJtJG78qgrzWv4adg5xm/nXJ9H7WSY2zK8kIRF1i59obt34bM2zHdEqwn?=
 =?us-ascii?Q?pLONYIsF1KeAloyaOYUT39m0D+Qc/Y+DRPzpN+aNLtUNIvzinQgBXbyaig8W?=
 =?us-ascii?Q?lEYIb3iNw+QjSNqAtjd4YI0eetQuB8yIWOsXdY6oYMVPN7IPJzoaQYmWAjru?=
 =?us-ascii?Q?cMzR5fnEvteZlLEz9npzbrxo8egydq5LnTRZ05WVTq10SoNfW4ub80W9BwU0?=
 =?us-ascii?Q?CCx4NWq7/guCitV/RfN4Zib/FiAYewCv5u17oaHK+l3m4ayIbRLPAJC8V89G?=
 =?us-ascii?Q?sxwGbmZtTVaQ5OaWvjErytHchlk1DdkLJ3+J/c21DWXaZCFtfgpdFFKbyGGE?=
 =?us-ascii?Q?DByQHU6TLW5ATMYg+a5iyJunxkIi2h+3OYr4YCyA/K0iWl9Q6+/n/0ODLB6X?=
 =?us-ascii?Q?aQp6tukEZpnJD6vV5z6hjw7PT3nt0AzES8ww7fs/TbdpYTwZr7hysE7iwF+8?=
 =?us-ascii?Q?+Kd2FpU3iIlky3Ipn5ntaxn3/YJFtGu7anMV/t1OoH98nSqfNj9shzh4bSCI?=
 =?us-ascii?Q?4da5GOhb9xxsoyRCZU9k6d/nVpC4+qxUUqxRfEKrfSB6dR/Vcs9/VvdbzttH?=
 =?us-ascii?Q?OCsuTYnlKJAsW0ejpChZMhlhcwpN3n0/faOw6Ro2EPtf8j/YYlokTx7Ra7Df?=
 =?us-ascii?Q?we35XqJfn2rWTVTuDUfxnxUg9ykTlAv1BVjef9Q53fLtFCq9EuGGmvksZ+Rw?=
 =?us-ascii?Q?2Cu/rJiPUtuix+2dFXvnCSjzWyygpJvq/rbdb+5S5Yj39NBvPVsGiJ0gCRra?=
 =?us-ascii?Q?J5WuExq3wsAaarHVHt3xNWNncKGMZEZUWykJoTaOo6TGqhl9ibIh0i0fcKoE?=
 =?us-ascii?Q?4Al9vfOVNsqdml3EpWM22Zn5vWbHakoyA6v7OIzTSzizCP04tsMjzq29QbZ0?=
 =?us-ascii?Q?aQJltRdNP00HM08Mmfutk+cM/Qj2Vc4BoNDRkF4MLEv+X+oj4d2t2aCA9sOc?=
 =?us-ascii?Q?dg7K+ZEPwtA8NK+wjGwkbT0B2SVRgvEW++L5OFyABto6buJPl4Ze3Rv+RCIX?=
 =?us-ascii?Q?Dl2HV/hWi2c3r5NE09fqdjVcT6p6h80xSlS2ppJRTJMqHFOUJrRSQbWxCfPg?=
 =?us-ascii?Q?+Scd8C2Hv9kRuNG2FKZDaF72cbKHIRLfiXhzmv70D/YXG4rEkui0H2dqBX8Y?=
 =?us-ascii?Q?oxTTGxR1glALEyL/bsRIwzZp0qeBOQnr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbwEhccY7fCZBH1dlvSrPJ5pOBT3NHgqMPn8csBAEfYNuhIt0FIVDumk3lF6?=
 =?us-ascii?Q?OxZnNgfC4uqEf7gc28VkKy2dIytk5tWXtkMRE317Lh89uA552T3OX313AXr4?=
 =?us-ascii?Q?aU01tFGeU39GfafvBxIACGqTTvoFLd8O5BTTbKttG0ZC+j1WJHmZoz5An9/7?=
 =?us-ascii?Q?sdi88IkPT+Kdqu4wnaIjn8j1vQaXf7wbGkYPimyP+usIOba0KuniSGUymZh+?=
 =?us-ascii?Q?PD9TauroezJDMO2U5n/OYOVyh3iJ4gq8wUdYq+Mf3fZDAozX4nnR+m5ZVyXc?=
 =?us-ascii?Q?qT3vXgiN8WDwy9FvyfjrXQ8vRR+tjD6th3FERIsZnP4reTkwaGrZ9OUUoU6Q?=
 =?us-ascii?Q?JluRsLJX7d0JYVVuKSupBH3+U+HtL0+zbS/sWyn+rJPbxqOtHlrpJWRnAzC9?=
 =?us-ascii?Q?jitBJfFCNPc138CGSVJwlfyqI9qrP0zy8ds8mOp5bTSdEmh1cm07HJ8/SkE/?=
 =?us-ascii?Q?/KPlONTbQE3uM+aMEZxSe7w7SGa267EamzTSx+jYmB+7vs4psBnw/ghAYS+i?=
 =?us-ascii?Q?/aMpMizcgHbJNoYaWwJL9Ee7kvTYZ14WwpwGauOXi6rWQEf7Wmgir+k+1XHo?=
 =?us-ascii?Q?MeNR87mhbMYL1ZbpMlI23CAOHjCi+fimaBwyj7C+YMHlrPfuC3DjAY1bftf5?=
 =?us-ascii?Q?TEQV7ISlrGZIcxWEPRs3Iy4lp/xNy2zRApgSQVXcEAUcceDiegHwL2zDEh8p?=
 =?us-ascii?Q?SKdyrtQr50wk8gS381bNA+5WY+rsn6b45FMjddbCnwT4xWlDSAA7Noi/OFIb?=
 =?us-ascii?Q?1H+JbqYidoXue+FH8QwQG7tkgy5UTnDGGyK/r6TYKyDiicq8hpbsESbRLgpG?=
 =?us-ascii?Q?0SaEzbeDAyoqcug026rc0xUWC8QuE5epE7RUV4Pi096rUOQKkZ3pK3coV/ow?=
 =?us-ascii?Q?B84ZYGBYidGpczrb7QX96xSfaNdCDwwNfu7B1ZgP7/mKSYsg4BrdMQfS2L9q?=
 =?us-ascii?Q?PpeMF6Fu80U9Ten0fxAY0NikGE8hpYVeIPNmJOGvfYZgvr1/0RkcDtjQQhAd?=
 =?us-ascii?Q?P2kY6SHsLgiL4aZ2RmG5iKXDubu5SFs4alecYDuJIiD81EeEQN8MfLpUFuaa?=
 =?us-ascii?Q?03tK82lHydopnj/W2LrhZU5V5EkytU/g578SbccOXuil1cACUQeKtDQOR6EJ?=
 =?us-ascii?Q?Msoc+Rvtg0jTpl4pD2JYYqMdQm7YVOEUySh9sJ0PPcGCeBwPZqmtzMsln2T/?=
 =?us-ascii?Q?aOppu2q6b6D28bvDKh6/q1Ago6LfFNMTVyMazvIKbbrYNxEhRKOhkTNU0GqC?=
 =?us-ascii?Q?2iE8PvZS+GsjWjdlwK4KitNnzdPsUncA/yyU7vEf/7u31pi3yuc3rxKa736M?=
 =?us-ascii?Q?yCaYb4HKWgssLqnsHECDQhTOV5nS3tXE8HC4negpHlmsrH8YR3mUJl5LPSEF?=
 =?us-ascii?Q?KfqD+9EynVTLhjjsSEKlA6awcUv/5va0w1IlO5wr8rw72BQwwNLfKSFGLlUP?=
 =?us-ascii?Q?HNchCTPQYW/ZxIu2Y+Nmr1vcjYXsrpVVQ6R2CbtaDYVcQMqoXdvf8I3aE+X4?=
 =?us-ascii?Q?y3Z/VV8GZnUh+H2cXaDvjomvYlGb2ksKn+ed7piGRdjelh6LHSszL0ZLqFyv?=
 =?us-ascii?Q?bJWOczel8DSpKoHiSj2mT0AGsR5e6Li3DcxBsXPP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5645940-7284-4f4a-36c9-08dd50aaa1ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:59:54.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QF1Ri0qEA1ouV5hdFJmoBv9l15x3d3XwSZfxnO4HMiWw3VdvXoofIOdCidC6QI3Wgj4xwJ+QB2O/GoHm7XstMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

When creating a TSO header, if the skb is VLAN tagged, the extended BD
will be used and the 'count' should be increased by 2 instead of 1.
Otherwise, when an error occurs, less tx_swbd will be freed than the
actual number.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 01c09fd26f9f..0658c06a23c1 100644
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


