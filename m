Return-Path: <stable+bounces-116549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE466A37F15
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A99A3A3A24
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495DA21859F;
	Mon, 17 Feb 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+R5hjhz"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC55217F40;
	Mon, 17 Feb 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786201; cv=fail; b=USbfqlPhQu7guGEnxn7d36lYYZi4FlJsv4m+8z+fdknGaPyQeaO9ck5pjV/5yQpzN3raRF+2GVoRPko9hrweulFkeSV/0wRkk/wZ2vLUWWJ75nHu93xNKMqLt9r9AVkESf7pK3MwA89nVm9FsZs+IPz1kqgmEFofXTuSj5I98FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786201; c=relaxed/simple;
	bh=4UEml9V10zq569n2YVtXPrX26vzb/0pXGmxTyNTI8MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZLczL189VRRcuftgg2vN3coRqzKi4HvCZWn4a1DFyPjxKRKiNPXh5KMylVF2D8Hl766oEM17BuQL+n2chh8cl11LvPJozgR+36KATgdu6aeq7eRAXlxLkb2/vw/PWe8ogL70wBeEcxPf1fnGUXHlnqTmTZXEOER58kJNB2alME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y+R5hjhz; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF8cA617iER1OW1EoYtszR8g6OcLvpxJMGQ917bn51VbJumIpl7ziJt2UH2S2PNGEbHrVpVH2hT5P3ZAWqPmc4kDJQhEnBjZYP+tPz+PgZjGgIBOrJz7F2R/PJsxFwcpH7EZtJhGBctfa38ZixR3gASv494Q030UzKBimk3c2Hn2he4V+Km1hgOGZBMlWIQZ8fyEZYcG+jTm/cxEk0Vd4R6oxCfbzLuzrY2sRDmmwdfpgM+MfRQr7YNakNQoy2fY0e5QJVnUmL409ZsVyWZ5D/wd9mcz4NgHzSlPRF/Zrkp0Z2VVdVHQ7VrnCcHPkQ59Lyvl09q+D0Ib/PB9Ym5InA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpGXal+/+Yw9GDtNm1NHJ1ZWB9nXd9OBCCkAux62czE=;
 b=LLeZmEpZsAntR/V//HcyP9erWusCyxCevXRar5FKq3QRPIppvaaYv+zJUxEQue+oE5mgmizushCsMeVQ3BoEj7dG4kIqIBjdc+ZJZRxrjB1zwjmreO7sVghsbedoeJWRqdwYJDoTpE0cxaTH5tHkTFmMlexlzy1DRb40GbGeLui7OeKVywx09/DGsmAYfOBJBMw72DVPoTTlTFtowWjX/xkUjMvXrbwS6amSxeqJOPolbT0AcosDfXOT5qbFsFwc7qeIdYjBjHGIGCoFShfe+L77gallyFdfZXDdqWYpmZtY1i3yVhLa9tKGTacnyWc9U9sQXp9Px2rQni14wnoRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpGXal+/+Yw9GDtNm1NHJ1ZWB9nXd9OBCCkAux62czE=;
 b=Y+R5hjhzApDbHUXA2Ip1eZd5BDuXezhTUShcs1sn7WUW80Fa8tl5HLte3DivoSOZO37c85y42HZ5FamL1ahHgVjEtyjepKL4Sb3EC1PiRxZq0GDi7c+RZxZQMo387HmNGViKx70BONe2htgri0jtAfHRVZIeJlzNZO2Hpj+FY+Sl9wXhUHbZwaD6yq/s0UQNUqD9VNgLRRxJZeQvNxdKA4VNpiYY0H/oBTl8hwEAEtzSjSxxJszpK91wKCZVHVLjl50be/lXpDnUXDrO45r8JibD+Cr4Lgm+dDdTS6RX8exK/tdmT4k3r3W1HRI/DrnDiwLxl6dHPuYZjSjQUPGB4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:37 +0000
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
Subject: [PATCH net 5/8] net: enetc: update UDP checksum when updating originTimestamp field
Date: Mon, 17 Feb 2025 17:39:03 +0800
Message-Id: <20250217093906.506214-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: affeb771-68fe-4248-af19-08dd4f395e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oV1ofucBaYYUvKhFymu9dHTRvUvJiCwvEzQZy72jnBUBI0JtwR8lZwQAHGcc?=
 =?us-ascii?Q?dklr0SFgCl1ihB8Zco7AA9rASMAMlK0A9btUwx2fxTdPLwqFyHSxJbE+Fg4c?=
 =?us-ascii?Q?m4y8uU8kGq2aUX/WEELs3RxvpPF9UbqL9V/6i+mbLFkkNFI4hX6Iut/60cdL?=
 =?us-ascii?Q?ngGd36LxePLhAPYqiL6UoSERrOpxY7Pfe2LywLDloSrbUBEOxqk/DVlpi32i?=
 =?us-ascii?Q?psx4aPPikjR4wLOGZnVP8HksA0FqHD287N3sU6A8pjfT3Ov07jt7RiJJGxlx?=
 =?us-ascii?Q?bnMSWZJ6icMl4+m3mt9KmRqWKQATZHi+4CnGgwMT6T0/1aNdysN0vUpyRa4T?=
 =?us-ascii?Q?/3qyNhT5ISmQNvme2AVEjGxu/J/2UTs6d9gt9Y/HDIcZpy0jZRwf8pUpZPr+?=
 =?us-ascii?Q?MQ4I+v9JHxc3QaLvUf2xDpJU3Oos8GzGcsV0mZv8mdCNoZMQ1jym4rw4kOff?=
 =?us-ascii?Q?U1Qybj1PnjL+XqCEqIpmbiFpVcTSPks3yHT0HD5pHuKDoAgRq2N6C1YoUjPp?=
 =?us-ascii?Q?lhDP3obLUxwTqQkvJWDpH8ZtRa4oBVO6Iel+C771yM9mAJDYARmz4nNY3oZ9?=
 =?us-ascii?Q?Ny0pZsE2b40KftcRBoujIbh3QKHSXnygy3tQlxHZ/Yho+yaCqUoNMJ2rD2BI?=
 =?us-ascii?Q?0SBG5qIH8JwPRELAU2rajbbYPdM/nAvyme24f/gNeloO/eGLODwmmnj44agI?=
 =?us-ascii?Q?H2a1dzTYXL7QBhP7IYtHRMun7+Hix9S4zImYJji6qfH3zVUPZ1C1zd9ZWjnt?=
 =?us-ascii?Q?0tmAlJUDA4AR6NtzQT3c+e39QyuweEnzfFxv+2WNEElgwViG1ZwfMv6/5JPH?=
 =?us-ascii?Q?042CwMkq4G7p66E/qsA4ZYuc3381vagsNWm2I9GhRKOF014KSojwW3kAkft8?=
 =?us-ascii?Q?HU+Roocc0mkmgdxQAO51KzcClnOdHlFKW4h7sL97r/6al6S9x8L+umMEWpEA?=
 =?us-ascii?Q?JEerWw+WKGcnm/OBxYVILhVtbiwpiM0mtnbscV8F3hxSO+jbR9r6rcl2LbiW?=
 =?us-ascii?Q?DcF4viPL0d8UFFrPElmG2JuahKAI3m6jdSJSIGlzKaFOBXBuIy3rQ2hCK8jz?=
 =?us-ascii?Q?fezczEcn9fTjfNSrt+/hvbudxZjrfmURL5VMo9/9q7OlEuJN3M1Sh706ioWh?=
 =?us-ascii?Q?qEk++QIfuklFg9Ey7fcBKs7xk10xwh+PCDzI1Ft6Vf/sQPz9yRjdAeS93Jb9?=
 =?us-ascii?Q?QwugaWLZDUJwk20Q12ysWXMS9mB670YAiVCNSN/Gh9GfnVhbT79MegFiyOZX?=
 =?us-ascii?Q?fZypBBIz1e53f8plawKfrIg3j3ydR0FJihHXX7hzjJXcxcNoLW0NAqD61LmQ?=
 =?us-ascii?Q?N9GmEAKsYPgPqfPvvu9qA6zrbQ68LFSX5dxFzTYDsi0r1gBoZQbYmW9ssd5+?=
 =?us-ascii?Q?2cxUwQZVtD6o3OU5YtRyWRTwHiaNR+/7uVmQ/8nBo4M4xqYNQ6PC6cQm0OMQ?=
 =?us-ascii?Q?5KrLt31JutUZYWcB5AQ3x6we6dQsmF+d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBDpJD+aYmz+mqmYCdfmFaVLDjkR+CUs7c2x//U2BV/zlGtutAdIyj8rJ1Al?=
 =?us-ascii?Q?2tDdy3fvfw80fwEQVx94h91lIFHyq43iH3c+eSSMit0EmCal0vurjJzgfZ7H?=
 =?us-ascii?Q?zQP5y6A/d7VEBdWZBX2iRaU1EhTSdaTOxUDH0FCjhE9Job6H0R1uJHH5pj3S?=
 =?us-ascii?Q?uf/PO+YOwUPHJDuu1TfMwdh5W3s8pQl66JPciqpPq/+NJ0+CS56IHUMxmTgb?=
 =?us-ascii?Q?ILXa+CIfvgEs9EFjohhr8d1Cjr64XXVbN/WgzwQU939bBofY0oGjRU15vQGj?=
 =?us-ascii?Q?bASAIJTh0zGU0/Rxk6is7PjnhLvTGvGqcrFWOJpQT0+aMpwf30mrsDs2vo3S?=
 =?us-ascii?Q?ZRQbtuVeLaOr4mF+TDX0T8fmNSRAhVv59aOda8Od78ALdtZWiUox5L8hgGX2?=
 =?us-ascii?Q?GUbmkjPksyWOZt1RaCCtQE4eBEjfelDsY1T1AUyDRBuM6EQSh/82ykGkrng9?=
 =?us-ascii?Q?4foF6AbVTAXWIJoW4pn5nYoz4v/i/hmGnQsfMZTXWNx7Hw+V6SJRU3kuW6pu?=
 =?us-ascii?Q?e/sYBG3UKq6L0IqJ8ZEJ/4d4a30fLHfHKDqTk3unz9sMr05zR9cEbndYzL2v?=
 =?us-ascii?Q?itXHLQZPLBDCAiSAzFl5Ctu9ShL8S1voxZkPYTkiZKHzb1BmDqwutClEJY9l?=
 =?us-ascii?Q?aknOr68yJkbuLNOcM4QgDpINbN9MiSAgikZwVJkGo6EETprX5aGMP1eBKkGO?=
 =?us-ascii?Q?4s/KYg8Ekq3oiwiemDQUMlty5WMAsK3AXdhaEZSYI/Euf85OOvdqUaRQYdUH?=
 =?us-ascii?Q?GOupYmlmTMF/gBZH3jqUDbzWiUCjYEoZHb2SbTR7j0bPSSqlXjUTYKqli+2/?=
 =?us-ascii?Q?P+fN8ksYxFWJ3SmO3dCLOn+tuKO2VsGMOOT0EHrPZA08HmeKcyxV6bCJcWsS?=
 =?us-ascii?Q?TuwSEb8O+1WJ0B8psyrLc79ubcrnsa0rQ/gyq1u9dmAHjywYD8pOvlcAg1U6?=
 =?us-ascii?Q?SkiTytOKqIaZdwcHRQgSaZz1jqg0HHYNUPs92PGL64yrWwYVVjnVTB/5Ne+F?=
 =?us-ascii?Q?WEMP+lBt7xxvqSKw4TR5WgS8h6azjqwEWStfxnKOtlnG5+A7pBWqTQxKnEJp?=
 =?us-ascii?Q?fDnWt4xXImk/SNInktOyO+06WiRDotCTIxVxD4Mu1GdhcOED0Huzxdw5XhxJ?=
 =?us-ascii?Q?Tj3mXSc6yFe8NmZ3ayxkW8jFGnahKxcrsMMamtIECgMk3OIhufu5f+N7p9eu?=
 =?us-ascii?Q?5GrEk2rbH1ZdfY409OM2BOH8ouASlTnKW7mBL9kWx+PMoTezFjzBF7GNC/he?=
 =?us-ascii?Q?dIRC3gRLCTtedAK+pzmPSGzzU4Wa0j+K9vfTFgExgAoRTceko0MXBkhfj9MG?=
 =?us-ascii?Q?M5+BozFEldwsQRx3PrAkzJtayc0PY2I0+kNftDZLSkZBTvMCOrHmDonpLjdQ?=
 =?us-ascii?Q?cP7cLY9mXG0KftaTzWem2lp51JFSdQgJAuAYmbfi5CwfWT1+8EbrbBs9XakE?=
 =?us-ascii?Q?1mISUy513vehTBUEXnYNvHGC35xH+UsMo1MCJSsztgOKiREIy/7jPcbhHmFv?=
 =?us-ascii?Q?k4RbbsNnLs8wt8Q5oJHmTMECaEEpqCnP5FEaPtjZqJ1XZD7hpRRbn8ZP9u+n?=
 =?us-ascii?Q?vim+Cm8WSP5SYP6fZekNMV0ADbuFXrmfrtv3BYzQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affeb771-68fe-4248-af19-08dd4f395e2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:37.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iBPgynMP0dTeLnblQwtnpoNXtAXpYdKu6DBjWRrIe4qw+Qa71wMbrvIdnXQtUBvHiwfgrR+Jjl6+suQzFeT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

There is an issue with one-step timestamp based on UDP/IP. The peer will
discard the sync packet because of the wrong UDP checksum. For ENETC v1,
the software needs to update the UDP checksum when updating the
originTimestamp field, so that the hardware can correctly update the UDP
checksum when updating the correction field. Otherwise, the UDP checksum
in the sync packet will be wrong.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 41 ++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6b84c5ac7c36..cb05b881ba66 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -279,9 +279,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
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
@@ -295,13 +297,38 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
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


