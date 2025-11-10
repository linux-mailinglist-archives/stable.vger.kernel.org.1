Return-Path: <stable+bounces-192922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50CC459B5
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3418E18904D2
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C302FFDD8;
	Mon, 10 Nov 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RgU45k1M"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C052FF178;
	Mon, 10 Nov 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766582; cv=fail; b=qiJnm3liUp0itZKXZ2xqs0A9W8g2yuOyHyRmQwEhHLFtZOAEEzYvJuLH1tMMrmz55UfnOe2YAemdq8945npGfYBXMs4KwGjj921MuzfJRz8ZqrHboDp0+CheaDLM23GNShMlzsvREzsl7oQcGnP4mR1JBO/2eNrFmbZ4IxrEIzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766582; c=relaxed/simple;
	bh=wkslA28Vh5RJo09M6n0HjKmcOCMrAElvPhEaWaZQmbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pv4SoUAcM5gZ/pISp96bVknLZzNJaEN6lsKFoLO1zN3W2Oy9BXEVGt+CNRj2m2lm/lZZLJRa0eZqImYo2iIg/moH8xMaO5aghqpVS/9VZqTgPiyTK+hkCMIVY3RR/jQUGi+PSA3kIKPZuFoRdwKAyoLcBNNcAgD+d/TkoNOAdhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RgU45k1M; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruc/YAJ9NTGUJ28UisgnAuqR9tEX6ePIr4BpkiIdZrc7ihoGPRURg17hq+5x8DF8o/OnxCzi4OfJEWG5kazUmJ33mJx7XyjBypY5JVUD0r0k0S5xPAYb5lesYyjp3Vw4nnDHf7wiLFpRmKW98O/6sY2d70aWDBp2Kf7yGV/QpNWlbhVEXhQgq96lhibb3kAbaiqqp/77McSbrHj6dnvD8KCqVCwumwpls6JWqyJbbhQlA3qtfvEgE48fkgB7AuUl92DAZsImj7e4XhNVq16muPllGq+rfVDCnIPdW2vluJHjex29r48EuCv73Wa/F2nupvJ4rrUylrpHrc2Fadui0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae8ycNzXGDr9WytYMmukQejOvzL8QHCLJm8/qL4UkiQ=;
 b=o/Ye6fkb0zEfYeOw+KD3dq2TIrev+SWXhzDMULwiz/TRYyF0sBTtLDUMeoP1zWzRI05hTAVlO0oWBfYcNFKL5NhKSFHDQViwJIJgSsyCXQfd5vPMjcphUxFI6Blm6YuZ5W53XSVsyD3n45wemuFhO7z4IBcvUz17iwYY7zkHJgDbQ2J1sXDPty6BJ1xptq8VIkXvdf3FGiFoXvuKS0bfU6TtnyBaoCAou93v3QdL2aFPtS6zH1kU77i+KC4bP71i0qXVsOp3NY5j2Wn87rkEOJj2UswbCn7tlRKOIP5/bHA5GaDPJczm+rr4Ki+3ekDXF+Vq/7Wr70ZXHmy8h3kZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae8ycNzXGDr9WytYMmukQejOvzL8QHCLJm8/qL4UkiQ=;
 b=RgU45k1MPLjDF+PyqeH4VZ9HuJ44r6c5qZXs+eCGkID2KlgWt3f/28MZt/DnB7trYT9IUelznVIdTAaMJc/Afp90JqzuDpFevI9svIlgwj2ck8NdROI3hQPMiq14zcUOXqoFGHL1Ou1RlSq/3Zi+B6s2Wp83mGlqBYHtjd3cup+cRZep9TucGZeEwevEjUGU+OB2Op48clmEXXQwyRNGRxuJn76WL2PNxmdKwIfZ6JXkrT6cJZAaPt7pgOdoG6qwDZD2B04KwnQ49jE5OAvZakNtqGhhsIb7n6fIHTigNPFR3tm6R8P1GjxUobmttMBFUZr48a5ZqJEiu+FLWsb0kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:22:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:22:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 phy 02/16] phy: lynx-28g: refactor lane probing to lynx_28g_probe_lane()
Date: Mon, 10 Nov 2025 11:22:27 +0200
Message-Id: <20251110092241.1306838-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 77786232-bbba-418d-616b-08de203abae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a9VJlEYGetkAxenBOVZRuipfddcMfJagjNFiQHJ/WTMY26k48QUdOnBPUoyd?=
 =?us-ascii?Q?7QBs1iEwXd8IMG2y3vyUssE8XxQ6u51Pql4pey1+OuIhCcJgHy/azVwY2frP?=
 =?us-ascii?Q?IudqXP/C+LzjTttLWLlHwj5bh7knr3GbaQGxbjMohxj5NZ1gdRuv3R/jXCfD?=
 =?us-ascii?Q?+8EvMeOo0FmT30w3QUT1ZZMjsBLO/G1bHbwgUWQbDGtiWfy4tF7BK/riWqNU?=
 =?us-ascii?Q?7Ho9FB1Syg3d4vfiXp+SDkt173UBKcrkQcPudDkv31Dju6YyzRn6WJLuNCXT?=
 =?us-ascii?Q?hCns4tp0ADeik0phhARVu51Hk05wptyaHP+pG6CxyLvDQdkpDTC1WBbg7I0X?=
 =?us-ascii?Q?4g5LDdOgjy2+vl6RAy9WJT/O4nz3iGTOEnFsh+EbqkWvpqoOo7rWuZyK8F5X?=
 =?us-ascii?Q?2N8ovczv6OvIpcFBG53WLVRR2zlSEHKRblW8gAabzv1+Av7/ZJi0g3TEVTsc?=
 =?us-ascii?Q?ZxjPdfOk7fsi/FB2s4ZTGBYZRzxP+8d3qqOlUZa3BPCp3OocDJhyTObs9jCe?=
 =?us-ascii?Q?MvoJYPoVYOvZ6/wglraxBeSihEqOX8xPIzshsDIsQLheKLnpmNa4vi5fDli3?=
 =?us-ascii?Q?v4tyLhUgwA4vX81TR0n0yjJ2tnbObhRce8W2wQEjgXGS8IJRkaoP4JJQKIkZ?=
 =?us-ascii?Q?ofwZqxdwQYoFFT70FHajOPcVfIZr0MHLhFP8epvBZfF8k9htIyYVpQ9ZAQC8?=
 =?us-ascii?Q?CuXhM9I6wihJcld+dBgNVqQXLxEBG02PJ55oMP/IO84VvNGaC5i3LKXArkN/?=
 =?us-ascii?Q?HciFrNIDnSbuyNEmfK1R0oGola3De5Rd7Qi8UpexdMpA95t+hYpp3qRss48G?=
 =?us-ascii?Q?XUkHW+5Xitg+ZwbpPVp6l31I5wwOq3q6w4GBSg29nsedz4yP98yiY6JNx/1M?=
 =?us-ascii?Q?tc0Dh/6ph3jd4qjQUvm9C0cmUPoLBY3qkn3f8oUhc3HPstVKwbekec12klXz?=
 =?us-ascii?Q?8BZ+JLlBo71BzGpTiM//wSqlgkaEapmjwC8MAiznq9KoaCre+IoOBWtb7pOR?=
 =?us-ascii?Q?l2jp/PlfkyTte3Q6pbXCriX6AWajcVh364vuxj+V9eI4ug2IDMYXUa17CoGf?=
 =?us-ascii?Q?1tG5CMTc1x56+Yu1URzh1EUcppBNZ1BLk9BQLdUIwU5VYJRaasZGKzCtGVy/?=
 =?us-ascii?Q?Y5l5t5UuUwNqCX50IQBlhycg90gJ60MbqWxSnMDDovBwTSESJFvIAZQS07gh?=
 =?us-ascii?Q?dTZQ7a3fdVXumtu6ythqPruxYrHp5Dj6N83yM/BVRBCdGcEsSVRDDBIrVAk5?=
 =?us-ascii?Q?AifGuT0j1wQIu3BPZVJL9aw7hY/lwHYEnFvWyLT8wseJa0owJoJgJImQVwOv?=
 =?us-ascii?Q?6NCORg7kX3Y8v31yQIxaC96QCRhj8jzjqWEW3olnVSxBiZl8090VruYoCKUA?=
 =?us-ascii?Q?Ydke//t0WVr9Fx4gs1WmeA2eLCB82CNMmkUNY0j6e6Vp6GCaqQvgHHBeBWoF?=
 =?us-ascii?Q?9v6cbrLmu3sNeoTLVxKR7tjRh2Rmocglm5UeRHzwBzOBXeuWXHfLROeufoCg?=
 =?us-ascii?Q?TsCBX2oLJ/5H1PMebEDNFssbdTX9xwad4Xnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6s31vPxIDAV4ZednLwPTS4sYD3EM4v11qfRGxBTvn/waQb+5oqBMZWytnsmz?=
 =?us-ascii?Q?PaG0chvCV0LarbeSwXUesBXFhkPbnncv6kF6sHAioFSdZsAWhcIDrQ0oXxzd?=
 =?us-ascii?Q?8ZX0NIeUoh9p5rJ77KEFpcKHIJiE7euOFN0sSvr9WBGl2AE2agXXHisxQeMi?=
 =?us-ascii?Q?sfRnA5oyflHkCufAUQRxzz6ehuPb7cIAB7qHJZh/yg0IMBAet6QhtI6H/zta?=
 =?us-ascii?Q?zapgswDw2KBZjms5Pie99EdEGPVoablX9oKYyeohb47EDqhdQMM+RKgibS9V?=
 =?us-ascii?Q?oJEmuXLnPb1D5CKeybDdU74PcYEQaVQ6PRXwNYNOQfvTA5EQrK8iYM5HMj5d?=
 =?us-ascii?Q?XpJ13m2Wzvc6JdYiMa/iRU1P6RBuli/298MX6YsZ0b3RT3O0wP5UQRTTfULy?=
 =?us-ascii?Q?b8DOS1IDk2y2O0xepKxGtThP+JaNSsfNJBEkowyuFhoveqGfOLEyJoIGA+Ws?=
 =?us-ascii?Q?/TrVdSzPmUCV4wjYssMBskov97AP3NjzkdDJCWwykZQKYVvRmgxeDOjRsNT+?=
 =?us-ascii?Q?1FPeMcbjmUfIdW/76OWZfTpUUjeSDprt/G7VPtb+45Isea0dMSAiqkhUu9Ew?=
 =?us-ascii?Q?EFUxGX8Ml1rLv4XRIWnwFm/EgeWDiI7YHFN+KdMqfEcjeNjjBlZl5gwwNeOi?=
 =?us-ascii?Q?6oYVjPK4dZq0ZO8/RnK2eNqm7hwzPxaLr03y6xXndweE1MfVqjXtVsOIlIsp?=
 =?us-ascii?Q?dDkU6M9BU/JI+YafoDhREtTYV/UJOOvOM/aegOFi806NwTzPRQxb87Y4dpF7?=
 =?us-ascii?Q?Fa8PRNQMgDPBJyCklJ06+c0luTKJsZCkqTMMqCOs4Fh+Cny8hcB1zN6mSyEo?=
 =?us-ascii?Q?bpc59YL9Xy3r5U+hgd4pokUDrXLGrFgj7bobUCcD6mdmhZMnFbiKND+F20ba?=
 =?us-ascii?Q?nt7HiIQfkWB7ERTg5TzX/FF+xE/54E78Hm61ZfqTMaDiuGZzALMrg4ox9v+S?=
 =?us-ascii?Q?AJorbu61MYojdHqnCI9GODoM/sW+g447xv4o80P9TEcVBIpB6emFi9eS3Sn0?=
 =?us-ascii?Q?gS0qkj//L2jxCUzb9qnvS/tje54MO5mFAjcSeqKnqCLgmc1Sq1oWIgT3LgV/?=
 =?us-ascii?Q?CelRBLfido74ceFS8buShaBH8Yh+kprLmIlkcQJuABZI9EpwX5VWAIMt+3Cr?=
 =?us-ascii?Q?gIEz4jGNTgWIf4AlXtMW5ScRGUl+GG8HYBTHSbErMOsI0/tXwqZbEIe2CQ+F?=
 =?us-ascii?Q?d35JROyDX0xxXS0AE8nZdpPzGxaHqtFAo/l7wuYKCQBbMg3+xUbCbNGmmRG7?=
 =?us-ascii?Q?UcdO9uo9Y7wCFSGXLwvkjUrO3Rh1y+JWmlbOs0bpZpvni0A0vbKEzPx6WmIM?=
 =?us-ascii?Q?bSkVx15w2zNUZOZCJUDvmLp2NMfIITn6I55oE868OoL/VF8f3fRimbyhgOLd?=
 =?us-ascii?Q?sS7BdyDCKIkXnDwKQlmWFhY2VnPzF+fiZisK3oeTs8mzpKOWWbWdssbwQxRN?=
 =?us-ascii?Q?03bjbA4Ygg+XIqhtrMPN/93XPOx8ccg3or8d7O5Z4SoK21X9wr7Vr5eT/iSX?=
 =?us-ascii?Q?Mk1RSQMR635a7wwgl7IWphoNc3DmGvcI1+dRES6GitZXz7fawJ0/tn+xNELO?=
 =?us-ascii?Q?KA3VOsE6tZsXcfQM1HUdXdgIi+321rGidSeZrQJEUayZLLZKyh4HTKfV2KAK?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77786232-bbba-418d-616b-08de203abae0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:22:55.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpFbcsKSG9qEh7t1QTGUv9aVm4rqecSyW66h/FcIZNf1NxlY/fyGnJztFWdkfSyVqG23NEOhgXea7jEGZQ5oMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

This simplifies the main control flow a little bit and makes the logic
reusable for probing the lanes with OF nodes if those exist.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- patch is new, broken out from previous "[PATCH v3 phy 13/17] phy:
  lynx-28g: probe on per-SoC and per-instance compatible strings" to
  deal only with lane OF nodes, in a backportable way

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 42 +++++++++++++++---------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index c20d2636c5e9..901240bbcade 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -579,12 +579,33 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 	return priv->lane[idx].phy;
 }
 
+static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
+			       struct device_node *dn)
+{
+	struct lynx_28g_lane *lane = &priv->lane[id];
+	struct phy *phy;
+
+	memset(lane, 0, sizeof(*lane));
+
+	phy = devm_phy_create(priv->dev, dn, &lynx_28g_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	lane->priv = priv;
+	lane->phy = phy;
+	lane->id = id;
+	phy_set_drvdata(phy, lane);
+	lynx_28g_lane_read_configuration(lane);
+
+	return 0;
+}
+
 static int lynx_28g_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct phy_provider *provider;
 	struct lynx_28g_priv *priv;
-	int i;
+	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -597,21 +618,10 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	lynx_28g_pll_read_configuration(priv);
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
-		struct lynx_28g_lane *lane = &priv->lane[i];
-		struct phy *phy;
-
-		memset(lane, 0, sizeof(*lane));
-
-		phy = devm_phy_create(&pdev->dev, NULL, &lynx_28g_ops);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
-
-		lane->priv = priv;
-		lane->phy = phy;
-		lane->id = i;
-		phy_set_drvdata(phy, lane);
-		lynx_28g_lane_read_configuration(lane);
+	for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
+		err = lynx_28g_probe_lane(priv, i, NULL);
+		if (err)
+			return err;
 	}
 
 	dev_set_drvdata(dev, priv);
-- 
2.34.1


