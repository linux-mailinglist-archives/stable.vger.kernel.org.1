Return-Path: <stable+bounces-116965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6663A3B140
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD03175223
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E41C3C05;
	Wed, 19 Feb 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RagZwzfw"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C815C15C;
	Wed, 19 Feb 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944804; cv=fail; b=oC+j58E608xCeKPszK0OtZU1DQrUqW/lhQG5JdRzy5wXKIyiJqrtROYpVIKCVvB7DmwOjYSN/sRMfbF6phcdU4xrcZIl+cer/PnCk9T4W7XPHavY0EaxZnrdUOAOEuQ4ky1vniQr8a7DEt1pNDXujs7XBEHlh6U+bzuM25UEOyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944804; c=relaxed/simple;
	bh=OdVj99klIA5mM4vclnK+hAyraHydf1HzySYdNydS2BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiuwogSLzUecjWg6T+6Q8bibIbX4GpLZlsiE2vdBtqI8mDOpjsM1BbqdZsKDxXynr0lXZR7I4PXhIYVGvP9dz3kBFL+7WfwlBkm7TtwsFNvRDZAjE+FATPWc4cL63ahD2GtjwuqiXawj+lHNp4oboTsvdNlQY/ZWRoDNQx8itDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RagZwzfw; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v45sb1bAhUYwYpnoux1cdhA3aMNd4mq6PcqiHW0CWrSgy7cf1sZ7s4tFGt12jhsHEYGoP9uoOKihDuaNDRWkSyYZ8D6cFDOgho0+i5pB8fgJydu1G738/ueCBWwzXoDQyQGS9rFQNX4IAKE57C5yAl3hEPlNLwryg3enRce2S+ZoHnUredntFoZkcissG5Xwx4sEX/6fNKil8K8bPcyicoZBgFSXokLXNAKejIhSY8YtIdbrG2H0I9Xk5OKyhNUSqEE7A2DB2xCubHcKrMbmMjYk1YQucUeCazJmmCQ42MaymAWc77OQd8oOv53BSy8ReUhAlzG8XZn1wmqnWtbe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QoAiCKudVYspUiTuQuBMj+zdN91YEUKaXuj+KNb/2A=;
 b=Il7oF2ofRUpH9Ov0vPodmFntxJQdGItfwEq+gMAb2+MaVt03UHGW51gI+Bfw/jlilvW9O3k5qn6/CcxobKjj/XoQOo8JWHqGH1EeWcr/yq9GxUhO/w+/c/2y02XDoc4eb91cWFHHyQ4EJeuGDye5qUfKzz8Y28ZjnOyPCy1dAFSjuWA+qG8gTQ4l98r0OKeqG9QM7yXVMXXn13icZ9VMYcv37uv10b5pCkBmg4BwI7A3ufxIyKeDFCGKRXVzVdp2cgd3n7mQpJOr/x9ouDquXLwDqrkPlu4U0hOpt6e0DUycc6oWGiWw+b1pjO3EzuCoVr8QVw9bpEm/yig+iAhzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QoAiCKudVYspUiTuQuBMj+zdN91YEUKaXuj+KNb/2A=;
 b=RagZwzfwO4o3FOYUQ626MxcsqjTSmmMkXkTAOyOK8ngE/f2f0v01Z/ZqbQzJa7s0m7feX59IFhWvn+B2MgpqkfNdZG/zLcqwTJOPtOlhQ1t7uwxRdGilJfuKA1cbTjTRSSyHLLGGLdWhPmhoJLxEVOwBGPzQwe9NGlxFtBxwJ4zouagcRErX+7m1rB6qvVCf9JwNeGPpGYwN119dDadSB6x7ZBoUhOgXwLMICRhebWSytO8YSg8LWWI7hKW7UxmQdxWt8ckTyQfLiP6LfTG0VVV3B/Fd7jVTEgkkNCO0+fIIGkxHTDlXZES1GQFnHbYsZxiP8pEs+EX93O+PZYuVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 05:59:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 05:59:59 +0000
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
Subject: [PATCH v2 net 3/9] net: enetc: correct the xdp_tx statistics
Date: Wed, 19 Feb 2025 13:42:41 +0800
Message-Id: <20250219054247.733243-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2b8619c-93b9-499d-628d-08dd50aaa486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F3mTAPT+z3r19zTUj7yfsmqpOVeHgzQezX1+2e0shoelOm26Iein4ELhMgO7?=
 =?us-ascii?Q?bUrm1MmE1nFR4FqCzjW2HlZ0QCah3q5ulGsy3pZdA58y6+MJ0tx021A+BjYW?=
 =?us-ascii?Q?ubL1maR41hWOVmhHQD7gEenFKcWJEoZkpHv95nr3vLk2a/jP73BJdKXfk4H+?=
 =?us-ascii?Q?l7OEXqATLei4WeGub1qzwM7bb+143Ecy+wuSAswoHaZEb/g+yz+mUbo0mwPd?=
 =?us-ascii?Q?MsxfD8Bnf5Kb2OFdgXA/tfXMKa9udKML6jy8bi6iNhUF5FFCZmh2t2KTDu4z?=
 =?us-ascii?Q?XUtbJqaV9Keu9G8nyvTkxDLhDIXwaNHOt8Xwuib8ILTRu+1iWYKkzVCmurLY?=
 =?us-ascii?Q?6WgGZaOuhGg0llx1Y+losPQ6wZzUMnx6jq/HN1+N562PmyKIP2JOtjbGBO0e?=
 =?us-ascii?Q?gNzlW8nf0HJjr9enVj7FtZFsg2jRu/uxWPmt4C0Olvha+q4hI3yoRdlgWAqj?=
 =?us-ascii?Q?6qT6tWcw2MJcCr99tp4bGtvevvlNTYG4RTBvCstKY9gwMRL7be5roJHAIafZ?=
 =?us-ascii?Q?Y50ktcuE39lY4in7ydTyu1E7NI+orNGtZBfYMqrcwrxjb8t4xQ7Tg6q9MMn0?=
 =?us-ascii?Q?aWKoSgdGeIaCfY99YRSTffwtgeEfq0XFAmK0at7iRXBstLSkUklz7o/+YVwX?=
 =?us-ascii?Q?XJmQrjFa4NQW8Vpw5c6bXgMExvv1VfCrWe6VRB2Vhk8q+wIWSLnawW/y2oKo?=
 =?us-ascii?Q?LQU1SEkLqmDBlgqWnM/7SGbzUAyVQNUhxqBDVpXnp+1Rj1bFIqG6lGJ6+aPI?=
 =?us-ascii?Q?WBWlBxW0YaYrJUS/VY0vX/C+TIBYteS2y2eOk6xAQ86iMdES9w0ocz9aaICY?=
 =?us-ascii?Q?r4hvrFI1byA2LkfsxlZVkpMcDmZbB0ddTv/57nATv6q/8kffmCxMmioFvk2/?=
 =?us-ascii?Q?3DrzkOMRr7iinISIi2Lbzn9C//172Pw6uHymv/5oJJ2W5UtM5z6yhLSmxBHG?=
 =?us-ascii?Q?saikZ9ma18dvxkrIY1HsfDk+nyl7cZW+8zJBFe2RfLT81fXiuApBEd82Hcpc?=
 =?us-ascii?Q?4hvm/1XV/+K9O1j2ZK2hXjbP6oPG9ZOrbeKlme/lSaUMsZW44PsPvCDQfztX?=
 =?us-ascii?Q?2mS6CEbxak79C6Thrhz6pyHtjX1QXfl652KyCU4Z7WSg26k+3N2qS7xgTaX+?=
 =?us-ascii?Q?uYFUex5j3iEBppAXJXgYu2B6kDqqZNpjoB02Xs4lw2Bz9eSdbtz8jNjlFhTA?=
 =?us-ascii?Q?zMaT8tvTh4cbshGiR2gX+2z7elh3SooZrn0WnbFSJkfDRkp+ypKYll/ixIGo?=
 =?us-ascii?Q?S4t06LizvwiyrSdvI55FWHC+BqFXwkVCyj4HqeprpXdrnlx5SKYHN15GpqC5?=
 =?us-ascii?Q?MGkhCVKQOvcSeYUkutnUIjSsWV/zikkjUC5n90RWGNZI0DIcYAIvHRTeuu7v?=
 =?us-ascii?Q?fadelcIZJPpp0eIJHR+X15OpVK/GjFgPAHjVGjS4XivvsIlY5Wg0123DuRpZ?=
 =?us-ascii?Q?QgC4+dQYfSxp5AJEqzcMuukNDOydDfwp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vd3FypH8gEAgnz/Xa4WMXxvMacG2P8J/IpQySAH+kWtqXCX5lxwR53IBSEku?=
 =?us-ascii?Q?E6FuTLLXH/aA+uAEyioojgAfPzByHfwK95Mqqz2Aceaso6WnsUEaOm6K3U5u?=
 =?us-ascii?Q?yjZ4D1TAMwqguqHuUDVBiZp8Wrz12AMtNyspd+pDphj/jfWM7YyvNthquQVw?=
 =?us-ascii?Q?ozpTOErfhlu/vtmYljSyKcgvIF9WDqgTKLk8UQzffbBfLfZG5z0f3kOQRhVS?=
 =?us-ascii?Q?M7C4cpU5u+JtA+Wxs3RUDLu27QNejEs/XcKy0fgNfEhDIX/DVtqCFrSRhfG/?=
 =?us-ascii?Q?xORcpCP3yJqT1+eFPCdeM9SF08bI01bvI1BDfH6x4uBfqjPJ0xOcGJkQhk1J?=
 =?us-ascii?Q?9Q2cPS+QD7WAk014ysNJeQxgf422WiCMbr9FmmFpXQZMD2zZohVskS1pLtFe?=
 =?us-ascii?Q?3Ty9x8XMEHlwU6Uj7CfCE4N7DS7ujCdLBwLuTWxLn4HfqapzXhoPFg3PesB5?=
 =?us-ascii?Q?u6XMJqlNT5YXlBB9yha0lOA3uBjRHi9fzhLKFRHchJ+QEGLFMUPQU71bOFFr?=
 =?us-ascii?Q?HVt3RikHvLYm6dzJQZR711t2TpVINcjDwaj4eh/7S6rYaR8odo5U94LtyNoZ?=
 =?us-ascii?Q?+PReVUG8K3jotRCWEaWSvzBiR9gQngHvFNWkCTQe5pJ4yzzkoKvrEPEWueHG?=
 =?us-ascii?Q?/BuVzbbxSHagG2UoHQXt7PKpYzIJVj/MEnl8tQ8/ZEvCMCI9FH9REJLB7LmG?=
 =?us-ascii?Q?MyJuDeCVJ1lFX175QHgoc2DjD0e+PQB6Ivv6+AlscXV8gnSLqU1otuaQh18A?=
 =?us-ascii?Q?XHWOaFZiZ26P3xyztptW7OBuJDwS/bDFs0sGdhz5+m2Tb0WKmLbGdt4Gt7pq?=
 =?us-ascii?Q?KQ6o+VWMbEaktS1O9RzfuUZBSk29AtMxebmyOiSu1tmUuONOkx+bcSkSgO7w?=
 =?us-ascii?Q?R20elKHKfgDnEZ2OMGTwd0yiubCJy+GRiFfCaXtXOOsCvxKyRVmmxG9tGNio?=
 =?us-ascii?Q?arm0OGVbUnVpXsaIMHCDkMEASY4az+0+Fj5AWmLUt+sZzu2uop3UV7vJQiGt?=
 =?us-ascii?Q?LNXIduNreNgOZcVcM5QVsZ0Ieg6bNk5pdTVlezjwKOIhzaDvI4++1Xqkn1jx?=
 =?us-ascii?Q?/7dExEF8GEZlPUMxmqY5ZVPWi3B8K1bXw9EYG1c5Z/L2MEUpLvgv2ntabSQ3?=
 =?us-ascii?Q?VFz800AJgB68/+yg/UQjg5Jwh3If2HPUyem3THcs9DAprTbroDJRJ/gSUAYL?=
 =?us-ascii?Q?pfd1ixipZ1a2xmcWXOjNDhV0KkMH+95MQtiBOaIlcBEXHvtqqIBPo0S05Odc?=
 =?us-ascii?Q?deC266HItLZ76mUrEwjfIzmGb2fnq3ukXKzSi2ixBXK+vq4AoGwKjH7+MED2?=
 =?us-ascii?Q?yTLh7eEJoQMJUFjVxkLHLwEZFiWwRWhZJYuxxBvXABXf8nw9uNJTCcYqG30v?=
 =?us-ascii?Q?24JLjfCEnkmUjgL2o1WV7Hv/2u0NrQfw9peeG8o/fjgmd/ZIpNcCU65V5rup?=
 =?us-ascii?Q?ZJZx1iWl/mrQIVuAN65TFilvO6C3GkXyX+hcFH4H3eO2TB1bbsVttCK2/RyT?=
 =?us-ascii?Q?j+bVa9zkryUd9ozxroUSQuys1pQ3or0XLXdvat0EdvZETBO9Z0hHppA4K/6k?=
 =?us-ascii?Q?9aKsNnN61+jxn7h/KsZbSB1YEf/TfZnz1oJKAFj0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b8619c-93b9-499d-628d-08dd50aaa486
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:59:59.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1f6QXr8qR5lJMYxQfZltXcGsxPJ9zZ3Wzr08+pcPCD587UNVFs+LOT/I3e1ZXFXv+yDR+rcyjsVFtiEPAUzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

The 'xdp_tx' is used to count the number of XDP_TX frames sent, not the
number of Tx BDs.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0658c06a23c1..83f9e8a9ab2b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1902,7 +1902,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
 			} else {
-				tx_ring->stats.xdp_tx += xdp_tx_bd_cnt;
+				tx_ring->stats.xdp_tx++;
 				rx_ring->xdp.xdp_tx_in_flight += xdp_tx_bd_cnt;
 				xdp_tx_frm_cnt++;
 				/* The XDP_TX enqueue was successful, so we
-- 
2.34.1


