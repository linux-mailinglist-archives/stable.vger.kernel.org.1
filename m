Return-Path: <stable+bounces-116548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB797A37F13
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B703B0348
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F362165EA;
	Mon, 17 Feb 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIVCoaXe"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FB217F3D;
	Mon, 17 Feb 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786198; cv=fail; b=AC4sqdXnHE3GCbdy2H0A+G+nGITgNlPt7V4rQyDYvs7YuANnfhZmefBpF18qAskrCp1wllF+2U895H+KH/4u8ClD1ywhtp9NTpSmpkK+FDR9sotuEsR0XYymZwBJptgTTuk1MFc/Pdj5uLntBiifvV4t/Q4kJJxmMsk2gAHQ3o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786198; c=relaxed/simple;
	bh=eyI6QkeblL0Pel7K+fpqzy0LLVyNZQCiZ7I4Zdf83jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StzNVnz3zgSfEQFVUOyj3lvB77RGi/eD/VQODW/yPT/kDp7J0+3jAM7Nk5hW+D5ybUmBmKtjnkRhk93I+jbNoHn2qVIDooFO4XJ3YmVQdrcrgy5vusvJsbQo6pbm/OnvNSpWAeSlg7N+gf5QM1DlZOL3yvkizSfvvWtSQ/qD0Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YIVCoaXe; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4RArU5d9jyG7ptm4GqW5rCaDMZCxilW4ILbLnT815HVR20BZTbyCSwo0YAMpRmiHNoIwJ+bGMkJhpiXlYwwtsfI9xt0+xdm1tKxewkPG6lmVMblIfMoNK9TJmmPb53X/ZZQEV6q9/DSyA4pqhNR61xpcxrF2IpNt2O/O2coZDZCP/dagTIMydah9w19RZQaQTq3TVCfexByl8A8sZOtvoDFqp6Vg/ZotMv80dKvmqXGDlegh1GiNNQi7Zio/KpLhlxFVnu6mknKy/DnNX5qYhJy5wmbRuWpXAlxqV9q6qM5JNV5P7h3AUmxmeeZTKrmuNpQsj2Pov+jXarJs8GHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcH8L6+luCg0WBinBX432f26+Rxp6BL9WR1EKPLEWXo=;
 b=GJstj2Cy7e7iKvoU8Os85VJEOOitc5QmW6Tvb8BK15WgzGx5dv0XID+VuDM8xej6lUseBMGNG1qb7vuvBRID3Iusc771p7ftG1gXmklMzgZlWbToBGSI0uNtDFEufYU8K/DWHrHwAxyEhUSFpojv7qa+At4QHtk1fmtuM+Gw+NhYc5v1rfluqFIyU+QIgf1m1l8mIH/LmGlCqXGokHUrdVElFcEvJxdEJ7dd68qitYjqGNJCalB2kAGvW0GcooVWM5ABTOPF2NS7nC8Pe5UgWvptE+1OzUaVggrvZI/PcITOWoy5S4yivkEQ1XOdQFEgoCSNRLABppIkPHuuy2C9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcH8L6+luCg0WBinBX432f26+Rxp6BL9WR1EKPLEWXo=;
 b=YIVCoaXe6+cfmWP8+d1H5D7MGvRYkxRAO2gcMvdPVOJokGac1gLMOFRMUOC3NpcBnNoqmHCUWm1LDgrpVn31nrebgqrDl0FyUUvj3PMJ70BhAM6y5Q8RalFDUw1YttxBWjBB3r2t2T0NusDpKbPIvbWP2jdu8qic6veoBSyuNjFWWHng6ZPC9E1W+ZRFu0aMOVtf89RcQJRSGKhilO2VkL9+8mDackbXrT0BdBnmUiHrrArr5cuZq5ThsDiFMv25DdOV76MEd7WJ8nkF18ZZQqWmoHl0EgltFrQECI+sMxRU1LiquM0a+3kg+gEcoiKvTt8lygxXTC+8eMxXcdBaAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:32 +0000
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
Subject: [PATCH net 4/8] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
Date: Mon, 17 Feb 2025 17:39:02 +0800
Message-Id: <20250217093906.506214-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d9df4ed-8543-4c74-b221-08dd4f395b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49u+Tz68GTLJDp3GjjWzodmEsIrOvo9uXRJx8RdcNQygcDdohMCMwsQnRNBZ?=
 =?us-ascii?Q?/4Qzp02mReryz4IGGTg3B+nD9x8mijLpQ83chx7nrhnU3Gcan3FnOMOOilCS?=
 =?us-ascii?Q?Lf045ChV+FuqqvDKDIalJrIJd6LIqCI6Pj5ivZ5S77oIVZbQIaePJPKfXwyT?=
 =?us-ascii?Q?9aLJc7d3u8xS17fJzh3uVJppSFdERSZ+/t2mFssECvGmLG7Lnc+N9atpiu5B?=
 =?us-ascii?Q?by/x9QR7NhngflZwvVSXiSZat+5h9pfBJtzS55ryjXIq1hrzCPm+8DUdhN2u?=
 =?us-ascii?Q?7zgjuv00Z922NV5wlbGGLXUgbNU4mmUBHpHY8ikLmR+DpdHij7AmGCj67vO4?=
 =?us-ascii?Q?cZp/hI/1sxcC1YfMuvrsWWN6tFM6UCiFJsDXI2nmxnZLarxkSbDF25XVHZhL?=
 =?us-ascii?Q?h3tlBSEEWBnvV5T8sZCXxaYe38reN6tV+Nhr7Xdr6shYMmzcUTFEzvHTBl/r?=
 =?us-ascii?Q?egiak14n1i1gJUfP+w1FM3sPv14rjK9d4r4zD32CfVnHo8j5TXpurcZEXe1T?=
 =?us-ascii?Q?CGOF9xcLMBtyycYPksDW84ITI48ciOYOgqEuNVNk66amyCVEmUxu3HhOhrsJ?=
 =?us-ascii?Q?Tceurw5CmhQ/wqQwzgdZhmcKPXVEQLGiwaVHU0jKymZA7QGcyihjJWxdMUqq?=
 =?us-ascii?Q?ohKCd8SCd025npRru/GdMP1FBk0ap/HI9//G4LKNeVM3XFH56Ehkuf6yfGFZ?=
 =?us-ascii?Q?ObL5wM0MCuWbLSz9UxHIgxdQPxSnpegqtwjC+CDKKo+yH3q2ipJ0LvQAwSpq?=
 =?us-ascii?Q?Yl4Lj+n8N1Kxi0OS0nyFtfYvRdwonJEXwEAMahaUmjmb+2xh0DxDiZPvayVK?=
 =?us-ascii?Q?ILJUCe42f3qWnwZ2rkjgGZk4mh/k4DXUqGGafFy3u1H5bfvDLIlpgHjU2XEY?=
 =?us-ascii?Q?p2T7rjbye2f5UatyXl7kFi6F07pToJVEK5nd09p1PwvXjqT5DtrQmgnq3uou?=
 =?us-ascii?Q?kwP69FCMHVjctn1bJNSVUbvOhzJVNXSmh70IYRYyexjxg4CQPjRsTWcy0h9G?=
 =?us-ascii?Q?JzQL13XNI2vX+AKSv/YykEboagnACAaw2nPdr1qIdd75j+40ZwYfgN4Wv0o2?=
 =?us-ascii?Q?UP/qgr5FADflr40yCEosYHqVVesBsMq+NjEyqZyNU/hvBhAlkQIpu6NZ5TwO?=
 =?us-ascii?Q?ssdgLL1+C9dxnpZEXGTeKBSxFCnpIoehmDJ8Ey0WqUhUtb8tO1WoRihWgSBe?=
 =?us-ascii?Q?TcAzxPKFxkvncykJcHmQyoB94/6yDWmyX4/MBa7S0lowHuVfSndMhOtW/hNo?=
 =?us-ascii?Q?UmSM0Eyo+l1a5MPVtVkn1d+A3f2o9eBT34OD1fAD8rULUSj2MS6sxCnB3M6/?=
 =?us-ascii?Q?+2xLt0/ZQTHo/DAOmPoi5CQY8Y6FT3e79hEg3SIQsGDm93nJywaoL1TqdjkC?=
 =?us-ascii?Q?OWwUeBBLDgpecoGWguI80ksHB1NnUOAUvH/tt8QzIVnz7qKSYqswTrKeKr+/?=
 =?us-ascii?Q?aIh6kEtEAg1nrl6qrhpjCsDbobMbfdNb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HDMq7Ftfc5TJUBThTAl8cPgi/jL5eGfE/Me393NBXmvwOEeFOM310dWzVrSh?=
 =?us-ascii?Q?3UoIBBLl1zq7ERLVIDC8ETKeJbG8x/8TWTwnAAkIDSNPZG5ecqiE4vw8dK5V?=
 =?us-ascii?Q?agyXx+SC+S/N6rqzAkkhPw7R4Kv/HBThygHQeAqg/aJ5OPL1kHJGRmrHH0zg?=
 =?us-ascii?Q?jbgUNV86lcD72NIjPAHCLQPNYSlzDbJhvZTxA7NumcpnH1sR3xNK1+mIo15/?=
 =?us-ascii?Q?m0tSAJYnVfEDY1MoVJuK0+WnOFWAmnI+YLSJVxB/HqroCU+TLUIRDzXcW0pi?=
 =?us-ascii?Q?adfjThQk/DwX/W1heA6kqmsKoypzqIM+ulBFs9DCKyaaH8Si8N4reoj8IUd8?=
 =?us-ascii?Q?KmkQTlbwHa1eB6YCYC0/fbSXlbXUmVJFIgq45R4TKQIJobvmw+4fb7KKzbiu?=
 =?us-ascii?Q?gHp9Jlv1/1eDpHSNMch0l5jjetJY8f0U0ylhQRxZBtn/qHtDkGIm2UjMrMyu?=
 =?us-ascii?Q?slt9MEnY7ySqaKYJvI4+J1SDhVx6N79j+C7BeJ4FXQIT6bFTFh081qU2FHDq?=
 =?us-ascii?Q?GlBJKZYMMkaTuZ6RFlLsp0irRjl8Zw9pQuWF8a8Yv/2Fw3Lx9Sbohbcvu65Z?=
 =?us-ascii?Q?M37zdvQTrlGxR6cfUxUP+AW4DakunebSSvcqB9EPx9wcbnHdM+pWR7PJzQe8?=
 =?us-ascii?Q?yFpmbWlcuiCMChESpzknDtvmHmoLNXlRkNl0l4QxtauWiXGfUin2chM6lkBA?=
 =?us-ascii?Q?KFyCNSKyQ53QtAPa2ojqh3TT4wG+UTUqn4fl18v95CwC1+CLFSJuDoi/eNUo?=
 =?us-ascii?Q?RDSfuwXR3a4OIUSOW4RGPC/wCP4Uh3XsfnJmHszZJeRBNA/og2y0GFgrpNoh?=
 =?us-ascii?Q?3oAqcYJ6AkYCYGZ6RYmD2E+zzxPiaidcEHLg2jCTs3WRuQOidi2qQeQEU2ij?=
 =?us-ascii?Q?bOVZFP0nlGLVJLnoPl6YuFHUHAANcY9qCgu7Kklz0jk/F7kDOd+UbBTDG+we?=
 =?us-ascii?Q?hU+zUbcjKz3PtXqYhDSJhtYDkPIGx6rmj62uwoERBq3798byBHKeod518UDJ?=
 =?us-ascii?Q?xVRifRQswhrQR6/GHthmnBKyHOljuwkP1rmoai1aFWc6X7p69TvSjo12i6PS?=
 =?us-ascii?Q?X5qGPQ510UYCXJCDW2++hP4SpYaDng60PRRP6wr3DWuDMbT6rWpM/qrzLKu+?=
 =?us-ascii?Q?U65FhT+h2heSJooDmxBnBKWvYd0Ia0wbf2kvo6Tr63VFhYPpOhnkZ+TapYJZ?=
 =?us-ascii?Q?3tI30UUphLYCrNhkJc552TrfmTsoD9v7qpFqsld05S6czPPQdfhlaSKVzF0t?=
 =?us-ascii?Q?OA6lUHK041P9Wr21dIhRSn21D2yRCcT4LIwSuwy6wipx+3+C3ICLaEf+NL/M?=
 =?us-ascii?Q?SBegDfUYHMWmo/5TN1ubSKY7T9UErm+CKOeeDrbDdctUbD9yDz2rA7yI7bfs?=
 =?us-ascii?Q?WzWivNLE1ru2s4SzG+RKR5V8dOUJ8D6AfXczrgPpYjwP+VGY+NLntInJDTFa?=
 =?us-ascii?Q?hKgivfBOvMvdd49pburT0vR5c0J0GtvjXD6OF5YdEcBCJDdEunYUfkbI8T/X?=
 =?us-ascii?Q?tAVav3/GLveqCFEKEfhfPKB7FG/fF+6doo4PtpV+L22oH3rl1GHr97OG+5Gi?=
 =?us-ascii?Q?NlBCDfDlQdWHU39bo02EBr5KvhLoMtfRL7dLoxvD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9df4ed-8543-4c74-b221-08dd4f395b80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:32.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UP3MEiKV0sOZZ9SR2WJCCrKa5/T/xfpuceOR45u8pWl3+CX8jks+HUGGupdgH4x+JT1SktdRjCuQKKBEwb1V4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

Actually ENETC VFs do not support HWTSTAMP_TX_ONESTEP_SYNC because only
ENETC PF can access PMa_SINGLE_STEP registers. And there will be a crash
if VFs are used to test one-step timestamp, the crash log as follows.

[  129.110909] Unable to handle kernel paging request at virtual address 00000000000080c0
[  129.287769] Call trace:
[  129.290219]  enetc_port_mac_wr+0x30/0xec (P)
[  129.294504]  enetc_start_xmit+0xda4/0xe74
[  129.298525]  enetc_xmit+0x70/0xec
[  129.301848]  dev_hard_start_xmit+0x98/0x118

Fixes: 41514737ecaa ("enetc: add get_ts_info interface for ethtool")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 3 +++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index eb0d7ef73303..6b84c5ac7c36 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3229,6 +3229,9 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (!enetc_si_is_pf(priv->si))
+			return -EOPNOTSUPP;
+
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index bf34b5bb1e35..ece3ae28ba82 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -832,6 +832,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 static int enetc_get_ts_info(struct net_device *ndev,
 			     struct kernel_ethtool_ts_info *info)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int *phc_idx;
 
 	phc_idx = symbol_get(enetc_phc_index);
@@ -852,8 +853,10 @@ static int enetc_get_ts_info(struct net_device *ndev,
 				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
-			 (1 << HWTSTAMP_TX_ON) |
-			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+			 (1 << HWTSTAMP_TX_ON);
+
+	if (enetc_si_is_pf(priv->si))
+		info->tx_types |= (1 << HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
-- 
2.34.1


