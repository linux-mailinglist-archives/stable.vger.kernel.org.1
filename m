Return-Path: <stable+bounces-118902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECAA41DCA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1624016C63F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1636266B4D;
	Mon, 24 Feb 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oA2Qz0sU"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7D266581;
	Mon, 24 Feb 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396622; cv=fail; b=l6UeLKA8TJDeAmDeo3yh4lzhyP4fwkRy/HBRNsGP8nweW/bC7QEV7uQQEvdeVWYrk6z9dyTpE53vwh7dgB8KE/BDFU+rTJblSxvBWNEatw1XRAnOmlKaIkemai3Y5moudDLnfjzR+XXQoherCV30ksNQsWkWAco6MTI0+LskoVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396622; c=relaxed/simple;
	bh=TWp2qYJ9Fniz09X+etGvVri5zCWGgpzTjUxx3iQEdBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KK1piYxIwxqtBJ+9Ksu1qqOdRgHQ1QixHxu1sWLp8XkEh+qxH6lBUAl0g8tqnReoIc7eUs0xPoisJkHQddgD7kEhf+EVJ9SFcIothJQXbqyaDOpCKWwygNZkIMHApalvnYVmERxe85ItFTtopS32c1SSKk3ulKXiiCKptdjIe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oA2Qz0sU; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZASCOKpGrLbpjpIcXZLbThFcrviXgpZnumroR/d4ZD8f4u+2EFswz+mKyhMIO3w5G6mm7EVrfeIaKYwb4WJFBpV2ZnoIATeHv5KUOWRQRjUy8FEEF8lgAilmsV5AyP3uy1jaluCXCL46oQDsHjrtdX/lR9b93CpfZtjYJ7V0hTjlFV20/EPS7R0JMYeAvrR0v5cg5xQNlEVlNEBV2iCCXSpVp399FIBE2kyJBReSL9mGF/AeVFZzIOtlGm98Ovv6qphU1SwsNbXZDkQQYJwR7dt9T/9y8+dlzbGYejcyPqKF23oLMMCMV7NeXLjjmEQMCwV2MR7qZ42SDmfiuuH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8jjXs3s2VKwq1bjCxgxPSjcBFmZeDuxYtCzP8VvxUY=;
 b=To/CUxcU3QTRFvVwEh2MvnkTX1vbbCDxPwKr/4MD88Caxr93YtYh7NSqHHzXWKWYVtm6Os2Oo/5b8OCN5Vo0/IDOVlZ8yzLD9hGV7xt3nFMv61r9XaxbGhgMIloJ7TPV3OdvsIX8uLG9ypgn5xr1TrJPmAD9ibj6xj06qtDRN5Yb67OLoHLebKUCxoInR/zmviBYoNlanj3QSB/xNH8obH4mm/bXf1JUjiD5VlUumlqR9vDIsUjm5rCTlWGmJEr5X2u4gPs/LCHN6v963cMfFMx73883Z2s6OEUt5RGyy6RcmIzp8eyXtFUyUspewcNYE1REhULyD5A4d2P5omCVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8jjXs3s2VKwq1bjCxgxPSjcBFmZeDuxYtCzP8VvxUY=;
 b=oA2Qz0sU2cuqe7eiSO5H8kqGU6zoEdlyf+K0L9LVOJ+fSCEEaoPBtJpKQwt9DAcJm//3vogMH8MLD2DA0S/5tA5v6oc6r6YDrQtxUgxM5niMUS4ItuZBDuIS35jUjqc8CUC0uiIAmUVIl+NE0icjpF/UylIot06dVLbljtKca5j5Z4aWN9MYhgX3H/i6s6hSwAZ9CGxAVgFSSIr1FztZAPan2KYc0pMQkzlsZHpPe2DuVwBf4sMmmJXkG/XMG68+Lwfwl2DlxTc9o0GtpFKePTZ/+NlAm6+gktcNmg1ynl6yteOFeGX4cBpwc5/ul3/CUtNaonHuEqCR2Xd/oHWM3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:17 +0000
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
Subject: [PATCH v3 net 5/8] net: enetc: update UDP checksum when updating originTimestamp field
Date: Mon, 24 Feb 2025 19:12:48 +0800
Message-Id: <20250224111251.1061098-6-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10979:EE_
X-MS-Office365-Filtering-Correlation-Id: d574f940-cb84-443d-5b3e-08dd54c69cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJbuLkLyLxAXOxqJQwzWmh6NhE5OvNTnKzgTAKOj5a+hdUAG2Ffk+6Lt6O8Y?=
 =?us-ascii?Q?wIbdohgzyykXM3eCpM8qKYMMu+SIG9r0h3yVjdHOziCpHLOaqSBHwRRSrnhe?=
 =?us-ascii?Q?w0MFfX9YNvVin4dcoEM3w0uvAui3u3TGPEmPTvMDdyxoNvJEdGmEg82TNbXE?=
 =?us-ascii?Q?/O3q5Pp4Onxaq1Lgf0EgQ5Tlq7oIYnGi5jaNk2E3Pbx6v19IruD1uG5eQ2yW?=
 =?us-ascii?Q?2HXnnGtpL1ZL7n+VmTWb1JJfrXE/sCpSkk3qs2FG/f9Wy7Db1ld3wh7vRu3O?=
 =?us-ascii?Q?bnwY4sJK+33UBg52bgMhAtiM9SpMhfYYoy63NSKb7wpX5aedZ7NH1rRw7FsR?=
 =?us-ascii?Q?przKmWcMsw5TJQi6p8xbJXxrLv1iVaEjWo7SnMoWS3OhM/K8s1FSo8S9drwB?=
 =?us-ascii?Q?S/hKqoo8k3VMHu1zuU4YhP2OOGvxn7J3m2bp74X3uFTnjkaePhPGOtqEBsTK?=
 =?us-ascii?Q?mzhBvdHFMbDulym6LzjMuSGrcPX67trlQzLlVfVi85tWBtSfTqxsGf9Eb46+?=
 =?us-ascii?Q?ik713fUx7SucAtCkbpo12o97F48DRuAhSKfiqRHtaWcK1cJYtNwkgTRDYTwe?=
 =?us-ascii?Q?0qWfOHnYo5Pb8TP/rQvpgWrchudkxcuzjIRuiPFM/V5Hnu9gk6CUjTLN5XW9?=
 =?us-ascii?Q?8+HWRS59G3FInFo8rUG4PNchhJ5Zljv72sfAZF9LLILq3k9XTx5GXKlglmOd?=
 =?us-ascii?Q?1p95HObHmBXkLmNbbwff3YUnwCb+0fQGztEqm4/5E2MQFyaqyrtAP9AJQ71D?=
 =?us-ascii?Q?IzvWaw2z5CQV1OKnnNsutTY5rFOpkza2sKIbFQK9Ze8Uywn9z82FJsy/ojlN?=
 =?us-ascii?Q?W5ULdI8O3U47TvJ3Mss4aiPgr0nd2gZfMplY5fBFVztp792Ajw26LPqt2nFg?=
 =?us-ascii?Q?tu3a7znBcabVMypGRcFwXscAyqhbW/1q8JosT7ICl2cyJ+KQgsSncrjBophX?=
 =?us-ascii?Q?e1lpu54JlMZXfJX+/QGfsE4hCNUm7OVF0aNXw9KhNdkQtCekrsFn7iG2U6er?=
 =?us-ascii?Q?+rKHIXQDG5HHqh3H4sRCHXIXGWOk524V/Xvz7I147Kx9wLHb97bc9aVsuM5g?=
 =?us-ascii?Q?4FN1oMqugZanUzH6G1pfIiKA72hwSluGvDR8qAmSqCfez/03MOwKnHQHvq82?=
 =?us-ascii?Q?YGylcSkT/DrWrCwka7I8nn/lxUu7ghElnorBwejS3ybZFrTGCzQqdTe5sK8Y?=
 =?us-ascii?Q?+hRuwwTojSNRrZR5DiykiWhdNGNpCe+yyLyUJecOnMI2TuVUfUFbdh/DGBNC?=
 =?us-ascii?Q?/970KroPSyoaXNphBQiyyshomtnGK2Bq9dExwtgcN43LdDl2fd85/X1w2uuj?=
 =?us-ascii?Q?hm8Rh9gxYjz86y4ywPucRRtuE9C7iIhDvrG/G+YN2c02Rot0LOmngSpaNnhI?=
 =?us-ascii?Q?yWYMHf+m3mOoMjfqhdqW9dqiXxhxpmVBzSgzobZtipW/BlvwoFI2EIXSJ3CF?=
 =?us-ascii?Q?16GLg9OBYN7tu9OFgaN/+HdWniLIa+xp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRt4ID/Ehvl+MesqLpB0/b+04j/lNpd6EvDUjY3lZ4Nhi/E57/FiW8e3ItcV?=
 =?us-ascii?Q?k+bGMcsm5zmfpKiLjkxndTgxwXbaYDTsS1dDaxqupv8CQG9sdu+mDO8crXO3?=
 =?us-ascii?Q?SLGwxVB8gWFwGpDpHrj9rndmvhC4i1q+ZvOCcXCek4taNqn+ObfKAVjJ5C6m?=
 =?us-ascii?Q?oRPegIINxkmbWCYOdiJJop65LX2sbrJrPwbXUur86gGVzBf3Bu4ipq3+haUD?=
 =?us-ascii?Q?gEo6h+/4BhP2yEmCBOui1UhNsJQ+6QVS23YbVJFruY2CI3ASJhOiwQJDUQAb?=
 =?us-ascii?Q?DcwvKgZZp3WikFTbqaBccSPJf+zbhOWboF+hap9C9l/hSOCWSjaIOAIxH/nn?=
 =?us-ascii?Q?LiMSUJkja0syWMHqKinL8KOLqjbsGN/dFwlSdZI9O6w3aE4YH2ATfRE5Mof3?=
 =?us-ascii?Q?wN+/LvyH79jt5pcnUs1n929dFdFArQATl7uEOyV0V+VlkKEOxiE3q+DrQCUf?=
 =?us-ascii?Q?d0+9rFFeLhnrCAeUCFfIraI9RvxYvU9oistfzdbJUobhWFYmwSXcRIiFwss9?=
 =?us-ascii?Q?uShMQ1UQ6a5wMg86VPpfueg/z2XukTBffcdN7AiMjrCo7QrnucVs4/gp7xv1?=
 =?us-ascii?Q?APoVlzeiSBIRu1/wpIJaxgP6QKOP4bbrlCQTlelG5hzoL8jC0Z7nz94eqZjh?=
 =?us-ascii?Q?w/YOLK1b9qnlHKJd/Z1T3ue99DHor/IF3thV2kIOMlsxcvlXPQhE/+gWYdnd?=
 =?us-ascii?Q?hXoOZWdbo5g8uU+ctIi1JRW+OrEgYYFAFtxVgdjrfG0HimL6gs4dspb30CN3?=
 =?us-ascii?Q?/9CQFy3xFFh03bVUu6XeqxFqdx3RYMFaBEXxvfEuTLbamjCEeKb7P9+zyO+2?=
 =?us-ascii?Q?RObvon0fswey2Ili/GoBYQiSg8CZ1A5BUUdFSklr9ukz4Q8nnHlK1Ae6594A?=
 =?us-ascii?Q?1TvWAZzoWf58isV9aX0DeecB82MKhSQy0x5RQxnK1n/QJ0+2jYL71CrGkn+O?=
 =?us-ascii?Q?v8oCSUcMd72VKLtVoo4AzkLbcMF/7N+D2zcH2Obrd6xXpNDW/6Dxh9zJ81hS?=
 =?us-ascii?Q?mLHLflMPcMr139psl0s00ctf1xucs7VPVINX101O4FtDKHd+QiWsakNTRYhK?=
 =?us-ascii?Q?CDEMCvaltbmQ2YUIxatOj5fEI0a2Gzp82/ZzghoQ6mmhfhJmz/BoPY2/+afz?=
 =?us-ascii?Q?EFEtoIEtkpwjcTE36MKzIGBw+VQgSf9ZlM2wSSp0PkS1BR6IG2MzjiJXnEpt?=
 =?us-ascii?Q?P4I22CGyXPLwHzwaDMxjS/EbmCu8OautCu2LJNOAtr1BCfRtHDXp80mbXEpv?=
 =?us-ascii?Q?iYaNSUPUUmAf+ZTDCWtdAfiqtXzldQAtAyoFY1f3UFnLtLdO/7INQGt+rX7q?=
 =?us-ascii?Q?l5mcwKEtSat24a2N3KrQkiuxLsO0f7t2k/WsaxJGRpaz9U2/Cnz/iV2fmy6a?=
 =?us-ascii?Q?bQtu9UMo5pxpWX5fMXotbz29sNbriJ3ycn8Okhu6VneyTkQlUMdMgaRZEFWp?=
 =?us-ascii?Q?WBxsE1oA+KgT/aH067FJt85749eLWzV87m2WQ24iTLCo130l89lnvw2w++xH?=
 =?us-ascii?Q?4xlUO9XmYle3Jc/BZBiNa++ShgrlBGorQ/OBU7ReV9EoxCxfsCIJgzJVEzT6?=
 =?us-ascii?Q?wIkdgjPTwMp2RVtQg+/+m6rZJqRpHZ6vHZsNNNv0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d574f940-cb84-443d-5b3e-08dd54c69cd6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:17.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBIhdl3o1nh4i9T3TaNf7N4SCbbxGXTghnLDUFY8zz7YKaqfJ55ri5Su1fXTmOXXfGJ5OFvqn8GY4NPF9zLmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979

There is an issue with one-step timestamp based on UDP/IP. The peer will
discard the sync packet because of the wrong UDP checksum. For ENETC v1,
the software needs to update the UDP checksum when updating the
originTimestamp field, so that the hardware can correctly update the UDP
checksum when updating the correction field. Otherwise, the UDP checksum
in the sync packet will be wrong.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 41 ++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e946d8652790..9801c51b6a59 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -297,9 +297,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 lo, hi, val;
-			u64 sec, nsec;
+			__be32 new_sec_l, new_nsec;
+			u32 lo, hi, nsec, val;
+			__be16 new_sec_h;
 			u8 *data;
+			u64 sec;
 
 			lo = enetc_rd_hot(hw, ENETC_SICTR0);
 			hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -313,13 +315,38 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			/* Update originTimestamp field of Sync packet
 			 * - 48 bits seconds field
 			 * - 32 bits nanseconds field
+			 *
+			 * In addition, the UDP checksum needs to be updated
+			 * by software after updating originTimestamp field,
+			 * otherwise the hardware will calculate the wrong
+			 * checksum when updating the correction field and
+			 * update it to the packet.
 			 */
 			data = skb_mac_header(skb);
-			*(__be16 *)(data + offset2) =
-				htons((sec >> 32) & 0xffff);
-			*(__be32 *)(data + offset2 + 2) =
-				htonl(sec & 0xffffffff);
-			*(__be32 *)(data + offset2 + 6) = htonl(nsec);
+			new_sec_h = htons((sec >> 32) & 0xffff);
+			new_sec_l = htonl(sec & 0xffffffff);
+			new_nsec = htonl(nsec);
+			if (udp) {
+				struct udphdr *uh = udp_hdr(skb);
+				__be32 old_sec_l, old_nsec;
+				__be16 old_sec_h;
+
+				old_sec_h = *(__be16 *)(data + offset2);
+				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+							 new_sec_h, false);
+
+				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+							 new_sec_l, false);
+
+				old_nsec = *(__be32 *)(data + offset2 + 6);
+				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+							 new_nsec, false);
+			}
+
+			*(__be16 *)(data + offset2) = new_sec_h;
+			*(__be32 *)(data + offset2 + 2) = new_sec_l;
+			*(__be32 *)(data + offset2 + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-- 
2.34.1


