Return-Path: <stable+bounces-116963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF9A3B13A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092471749E1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3D1BFDEC;
	Wed, 19 Feb 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mce1Xxpg"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F641BEF76;
	Wed, 19 Feb 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944795; cv=fail; b=CrPdJTf2sRx+ppo14/CfeAADX/M7vjXeOWnL5WSqWmlm3lqHaBs2NsgnIO+EOQjxF2/ZNFIlkN6p6d95gDTlTnsa3xsTZfxWrORhBJShqTRmgfuZlpRZNrnPga3dn2bN0M6pldE3/WelAo6iVjocclS0krXZcpSb0G6UtVLsvyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944795; c=relaxed/simple;
	bh=TQuIRlq1Nj6/oHXYWspIHKuFmnBNnYUGFP81mds72+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr5hPxNHsCC18LUBVP4XQC/oAULYU38ZSA6mpzkR+/Eqtg3P5s32jXMnYBnvYck99dauJzIAvd8dd2i0TW0o2CS73POv0CF1fODyRGa7ZW7RhUVIk6Uw3dtBHZ/uPgVkLazJbwC2/CFyEFa+tNM4ner+hvwCYsFp6dAwy17o9ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mce1Xxpg; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHO2PXYDhCPVLfq2aJIA5g5yifN3iKM2wmWacpAePUoyijOVy52xnopnoZdiIoVUBHxIxJjcaYmUPbh4MyqdbXtshI+csY63Klj2BFRv6+oK4bZCrfkOz3tDatcqjHQxH40dJRWZ8vORxeXwr8WZ3amPJwu0qen6zNxQq7LJtyZo7bgkTpMpIPyrL9T5XjTN7SPw7RxBM1cE1NenyeCe/e6Ds85mXDPVp3Nl+WLSu6KV8ksR/uKZXrALTDdrtFA4C+zdREezNPOggRoalMX9OXfOfrZ9IP/2Euf8rXLP6qbu/z134fVk+IMt3/PZAYNkvVpcM6fonF2IJyQ6h4IGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5apxbpH2LLAyJYAD3j8rB05rKBH8emX0VENqmwVaxOo=;
 b=qrzOU2FhFXLNs7t7MNaGmIU2sP9EnRu+jjxM4VUr7FwbwkzWWPQ9vJhGmMuePEnzEhysshq0Lu8s8VALnYkXtG+KozavWliGdWe4j2+qYzyo4O2HRbkqOKCNDESQLHSsvV9nFXzxu4rmZlLujULLgs74dfPyxxZFvOGRGIt/Ze4heHyjIrBybIJFDcmS/aGHc+6XHBXJMJ9zbxfRoYmo011RrpO9KuasbN+ziU6JzsVotSYZOcbcai14TpADPwsZuWKV+E3aP0NHluV0HLtnVg4KBOmhe4hOLhjqEK2AETkhuoA4WyM5shqluAyS/8x5UDiAiEPLnyFlc26nP++6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5apxbpH2LLAyJYAD3j8rB05rKBH8emX0VENqmwVaxOo=;
 b=mce1XxpgrnkWzyIr/+F1kCon1l3QfLUS8ah2Gy8yxOQ7GsmIRT48r8aA2tSzQQfGnOZbmo9sD2Ni+55UBYIKwrS5SKlo3GQbwMilLjMMo0N9SeqU9w2tPLddnaXvner8VmgWTWcAyIZ93/7D9QDPHSL0n+bZAHxDypAch5K46jDSDNjYaMRrp8Trj33LAukwWumNOHmzIAoLij4KvWMxTalE9LcpDP6RZWKRFLLvlpezMEVv0dq3Y70ReKE4z3qLHPfBrXT6dAg8VmFJHha+0ISWlQ4R6Yt8R0kE2oO+Pl9YecTz0FL1fFhScye33ZK26lW5g2sg/upQa2zIGaEf9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 05:59:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 05:59:50 +0000
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
Subject: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
Date: Wed, 19 Feb 2025 13:42:39 +0800
Message-Id: <20250219054247.733243-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2b722db-fff1-456c-6be5-08dd50aa9ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/SiYZYJ6LL924Ffwv3Yw2SRcMgswCChykKEGjdnSSon0RT4bxjvQYnpjOLz7?=
 =?us-ascii?Q?Ajqo+1qiFz3w2HtEDJX2Zn/VHnX44qG3OfNYDefd3FxsCDjNp9pJImhN7E/v?=
 =?us-ascii?Q?iAVVFAOd0px19MARuoUgNnE7bCaE8aqzPEIRK2HuHsFWh9UNMahG83P6ImsC?=
 =?us-ascii?Q?z8fklnwVqYd+vaMKixZzE2U6qc8Cr7+hM7H8hSySzOM7mRFAeIChsJ8liYqS?=
 =?us-ascii?Q?M9PCo4vLpX62N1tAI0Lretu/PK5A3LZT+qbgxyWoxq+Bs29t4yT2bn9o2AdN?=
 =?us-ascii?Q?o6C8bcWDeI3sj6VbofCMmtXhHOiBP96ylA90F0rEIj5yg2wZBI1vZ/Pl7s9q?=
 =?us-ascii?Q?WCrVkWmf5I1SDMdQuS0wMijwrwcPynVsuSRJYWIC1nYa29kgjgR9T7hb6XTl?=
 =?us-ascii?Q?CrHC2kQzBkm2E0a4mLohUnf0GIZMacp2SytxfBRMJs3EnOdxvSNX7ln7b/cN?=
 =?us-ascii?Q?y27az22oRPZjiDPJHV9PL5CjxeOpur2lQnNhoAxB79WM2HklQ32L0yyLdsyv?=
 =?us-ascii?Q?PrqDZjMrfc681h3nZ1ykQynWyl28fjIJdvtJDJUYfTsUTgLi0IxLeY1MBq5c?=
 =?us-ascii?Q?IB2pMQ9ciVo3Rio/ZAE8kerC4w4HuMkvcWHKSYiimXRciQpSfzJhCxGpiKNC?=
 =?us-ascii?Q?5cQsqbEPh/A+eYRXpCXfwfbNWhgJ2dBJruus7vU5e1zkJixmejqiEFqecKBe?=
 =?us-ascii?Q?MLgQ2NfUhO7EXXYdjVf29smaA/6aTV4VNrjZ9QA832PTZhRW4RVxH/b25Iyp?=
 =?us-ascii?Q?sK96INDv9T3lU02CmWyTGH/VoEuzCRQe4qF7YblkVvlxuePObRCqFjZovfwX?=
 =?us-ascii?Q?lFR+zuPpZK9ZKcB+1H95huVSJ4+7Nc7VA8kQUAC2cNbdHwszx3ARQ707RPjS?=
 =?us-ascii?Q?+y/YNeasfJLDvCO9YRgIrjnBpQsdUghIC49wIGcSdkQwnRMDPUplzXv8Q2E9?=
 =?us-ascii?Q?6fxLNRYLL76TfY6YwUMKUnhhN+HIJbXeUfC7/TYnd56iS1QR+7obDtWWs8MT?=
 =?us-ascii?Q?dx2D/KKmajdrAqAnqyfmVlRZ2lUgXvivqO0YvTYr0RZUNdWQIQhKQks8JBNk?=
 =?us-ascii?Q?15esDcl2B5rgh58YDQR50+NqJUwuWI3hy+jkk7GGm1o5VRH70NpAkVVECGuU?=
 =?us-ascii?Q?VAQQYbSe89nao1FzU0jkmLU80xooXVQyT/WPNMjJGG1KgOJyxjDjxhdxySdR?=
 =?us-ascii?Q?DPoxxRNc/u8+/GjbrJDNYaxLj2iS+p9MbY/gAEW5atC2CUI5L6skOo+HvQtp?=
 =?us-ascii?Q?hINhY6eBjGbQjAw5AfyGHeHzUR8HU1jssqDfSzZ65Xo17qkGAD82En6DJaLn?=
 =?us-ascii?Q?P8LwkpRL7a3WUaWWlJz4+G3CPPbLTfrDbfyVjaXVT0CJiFSvTdARKrlRVC2/?=
 =?us-ascii?Q?wvjNeR3PXPwJuWilgwRODE7tRPy8mSj3z4/NI+mGgnV+1S+xV7VX0v/H4nPB?=
 =?us-ascii?Q?AhmBGbGbZMB8HmenSKrLQQDBJ5F+HDkg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jyh96k3N9feOn4B4/C2vImXlRjNC/vtHwt8UG7AChaVZp+HLAjdwCm9UjDL2?=
 =?us-ascii?Q?Rn6UzJF3mkumaLKTojAkPV8CQA8VLoREiVR+JMm8JoO70btfxIkuBHCVSqPt?=
 =?us-ascii?Q?TEeXU6Ysp9+m623eTCslnC3WFTEGCiicsvL4JWs0bGuGsTFix5WYGQmBgba1?=
 =?us-ascii?Q?z+P28JIgAbzgwpHvsGKFr2dQiPdndNxmk2w1cAYnlAGfWAWHmUbEJ9/mGE4T?=
 =?us-ascii?Q?Vubsqxb1qdcAGP77xCuhYEScahVh1S2cMylMqBazTFMEaIa+IgMLzjX0S9DM?=
 =?us-ascii?Q?/PMaSjmBxjOSTRaq15Fqjbn7QOr5GAJSicHn4PgyefkN3kDCfkyzzhHuqozm?=
 =?us-ascii?Q?S77WnbG+BHLNZ/VhjstcEmwglmevK6wxtCVElEA9m+9766XmzZdTLxyY5AIP?=
 =?us-ascii?Q?6AtEXT1cRp5Skb3q1R9MYc8TA2X7o7U2j889fvKg2gvWTQnb9kJ8Tfwg3H22?=
 =?us-ascii?Q?isHsjPFbIy4ZYkvLO+0m0q2olmGLF5Bk6OQPOekU0c/aBdxvBc+TOG4kv36c?=
 =?us-ascii?Q?IDK3CRI+l4+8duWPzqt6ofpTiDUpdWyPpBa1G1nQTiL6lScCa1tPRo4gc/66?=
 =?us-ascii?Q?iBUVkIsbBoh21aYIyq+V2Sb9mGWF2Ks3uv9hYCjcHWedcapCInDAprWmdfLM?=
 =?us-ascii?Q?e6McMTn2SmgPKTtRazf8AAWRUOtkcxuvE3LoYFwbn9Fp33nyCo0IwE2QyyAm?=
 =?us-ascii?Q?mKTD8mnlz6paapl488dajBNhwjbbjiQ1Mi8sgIwER+3QRnFe/ErEqD0RmqgX?=
 =?us-ascii?Q?gNU9KlXWcINRTbcW9elN48tOc/Fp4t9CmOBrK9HXZj/rl82OldKg0DA6oiUD?=
 =?us-ascii?Q?L15uoaO7Pm7OAzoHh4vbqljYoynO+qirUUXlJ33IV4GjAVI/VvPJcoSOO7Nq?=
 =?us-ascii?Q?7Fv7u7r9BjrI5uvZGilGeE1WrrS8p9fzx/PKx1C0XWQHeQfEKHkNxebpftzi?=
 =?us-ascii?Q?kauVG67jHTHTGy8i7JSIaAEDoooGkUhwuwAnJOBX32pjMrcz3BxmJGp1UW1Z?=
 =?us-ascii?Q?D48OYku527DfV9gu5HsiPzmaR5hinG3yzZMPOYTE1uBUcwFpZ+d9//ySq3mU?=
 =?us-ascii?Q?kV5l1BUHLAOVctNkqQfkgRQMIEDou9AX3OwiBiJSEkbqvJhVgYPchk9OwEl8?=
 =?us-ascii?Q?5q/de6So5Q8ccG6gINSFnkHreB16kyRD+Q9HDvXlBIKM5esmaxjx8ZOUK9b9?=
 =?us-ascii?Q?Q5YxeHrXVFrbj025EgRm1oCfy4jI2UKmk/rAr/nWdnvkk208USlq2IkfQnM3?=
 =?us-ascii?Q?aw8V4BocmL/KW+ofDmjz9tcV/cMA7DTTrS5ljogTRXQZbNyiaxGufeG2beBM?=
 =?us-ascii?Q?guUU9GB9CKBv61BDlZwSm6ydnERsKfmX0mnMg2+uXCDaDYUIcZ9Hxjx6TD9o?=
 =?us-ascii?Q?KYYElNyXLzp+lUvctmruQNgr+BIuERXb+03dpRPAjw0mC6uz+3KuJLPIw1m/?=
 =?us-ascii?Q?9Gga7vuDAfzfMp9o/zTChkStG6ZieZ6HjXzOKrpoIW8pTwmN8bd/ZUuHxjDm?=
 =?us-ascii?Q?hqWQJVfV1/G3p9pHev5njeMuEPJUhDl9py/2jLm01PAuPe03WRm/gnGHN7ES?=
 =?us-ascii?Q?k4+RBQhTRkeUl1NgwdiGsNzHFXVqwu9RQYo7fyTb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b722db-fff1-456c-6be5-08dd50aa9ed4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:59:50.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m2AlB9NYZkLMjI/5VJKMNZOb40iYWBLhUq4i0k/JDHw/zqH7inC95+/8Y9dewi0pXtWksHsX8/LO/rRDDOItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

When a DMA mapping error occurs while processing skb frags, it will free
one more tx_swbd than expected, so fix this off-by-one issue.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6a6fc819dfde..01c09fd26f9f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -372,13 +372,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
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


