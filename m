Return-Path: <stable+bounces-116966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C00A3B146
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A0B1734BC
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FDE15C15C;
	Wed, 19 Feb 2025 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lC8SagnP"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2451C4A10;
	Wed, 19 Feb 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944808; cv=fail; b=sSo+jCwwCroLxyHdQ2QXgeVop81vNInWtjimra0ha55rBFHFKTbrnMB5FkHJ1J988+QnaujVOx8k2YmnJDHAAjbKDRV+Bqu1jQB1jSyQkXTO3a84pj/wivypB2MJBF6DnG4i5b9m4mDuQM1Bt0ARKc4/hPltF9w7yEm47k6n6Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944808; c=relaxed/simple;
	bh=MO9hvzWqfzCrjYwrLcrjV2v96AHU8EhBqUKmkHcoap8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQ+kr+/d49oLqW/E8M8tJzOCbcpr8ZHJqzPh3cemb7FBYLBYDdq2s5n75tcsd30bdcd0U7zOCYOsUbSNxhxYtDbRRJUH2/lvEN7Vbql5z6LcLBVIt6d/EpJqB930TMRPZhPVo6pveK7Fk5PmNGvczkyzCMeg3xlm3vQWLGojAAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lC8SagnP; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROFmuz1Qmj4xn0K0O/7Q2qWVBX88FsQx9uGS2mwVQdC+MZx4sj07/Ldm1WenQpPqddEYYLiEaiYVRJ+iO+QHCyrvQC0uLQq4U3bE3l/no4Um526GaBQkI2wqzR4AfJ/Lh8X95SsjSoigJrIKybrmbqtkJmva8BQVwl+bm1hBet4XbYzOMxOuL3sQ/y1RrTXN3Y1K27msLAE2XUtX9FBD8k3LNt6F92fXeWkicjFTwGGrMGLhPU//u9/XAvXBOI4EPJcDX/OiF9uWOM1CsDmWe8atoBfh3iHVx0TypM57nv3BzZCN99Da88rO4bVycKbAuX/imkoLtmqYjq7glbS+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFNi+GepQ8WXhAHAlaVWMRFdDn1I6sogJ/sqK8KRNHU=;
 b=STamLn8QwUirc8Wb5Qq4/EfIH7/pMXDw/3FKqsStlVT31sjcWBhkkJXHnZq7l/tte99pevnGb3uLJnqS3rYaU4j7EjX9ccPMkQ4BdOokl2HIYsrxk7hcbr9v/TjUYhDd8uZW4521XXXdku8mWa7CzlwjZKNj6sUkW6rYzjqaXUVm0z7VimdRoVDIr57i3cb8CfelzqAjcbLQm2FcX7dM+JzoAWBTyY59xdXh3CM92l3qqq8NGALvayt2616JX4rhwqWtoHCr1koQbxC3ANECXMSI36xrZDxNmTS7xEdJnMwWDSQHViykQETjBP7EdUvqcWexL/wbl1xaL5N8fXEWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFNi+GepQ8WXhAHAlaVWMRFdDn1I6sogJ/sqK8KRNHU=;
 b=lC8SagnP5xXxgKVndyk+xpqrfuB9lSCKpzbc06Bpwja919ignyN4NvEUxX3K4DYqhoMqyyx9uKPpatEjIFDsrIUlTm46X5UpCmLlsE4E/lL6FPeVSdnVn8H/mML6T1Gb9d+HErfL3R1YWSHJW0bPY++gtuHAcIzHqjhsY8PO6/8XHjDBOWZemLXkwghwSACzjJs7V+nj8DQjzASDjrICbQPwFmSU54czFjvWzTYHWn1WTbthOCDUPkyMLf/qIrvjxiJ3GEct3mAIt7MVCpG39k4nLwAB+7PH0letcT12rq8WYp2xx+TK/KRjVmwhy54q7FYTyp0dV2fI+lhMdEsdyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 06:00:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 06:00:04 +0000
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
Subject: [PATCH v2 net 4/9] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
Date: Wed, 19 Feb 2025 13:42:42 +0800
Message-Id: <20250219054247.733243-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e1ad161-44ec-4feb-8d5f-08dd50aaa74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zcjrZu3D5q3yp8lyRuqHiqesSBdzo0nGFeAFysy/weggRDac8Ihvd+BJITj?=
 =?us-ascii?Q?UM/D23zVolNowerf+7wsD5jCpUEuDbXJxXuyhsV+JzMIM6ib0xUBAvvHPC1s?=
 =?us-ascii?Q?qAnpiQh9c0+WQC+i/m1eIRVBqSchiVf5MSaT3afPVNy/td2dphCzTOdhUQ0F?=
 =?us-ascii?Q?4hh1P8GBTuVx3L+DE/uKUxLTUjrTdEDhfvLKAN7GxO2oBrW/+jg95Sq/6HMv?=
 =?us-ascii?Q?aHUYis6fhzVVR3Co74soRFyXYmscQkuiRgz6Cd1qLj9KoTR0xjk1S0G8BeFe?=
 =?us-ascii?Q?Hg1sizqQQCWnKNHuXv0ks/u3i783A5r8Jf94ZZG2ftsKA6dAYqWQjJUtuIc/?=
 =?us-ascii?Q?aG472Pr53h16rBv/1Y+gUk1UbYIff9ZjnlTtg/Ecp64Br8zON0loyY29Bk3C?=
 =?us-ascii?Q?hqnPSNUnZTEI8CI6j7tzSRoFXZBsd+5lYSkhIrT8x00w55NaJqvKc3u60lA4?=
 =?us-ascii?Q?oENYkhw9ixUX6FHN3ogmRVJ+EZROGFbX6LfUx0vlzhewwuZEXjlCxXW3uY1j?=
 =?us-ascii?Q?wQYoCpwl1jUFuVmbFzVN7JzByOrIg6yiLqoA36FTayQxdrq6oNJyahTCoC8l?=
 =?us-ascii?Q?VPZkACjb1LGvwfqsztDcqGeDZ8/l6NtaC1dV/K+/nBvOoxmY0WmYov9lrPnr?=
 =?us-ascii?Q?0MpmPDqlR6avQt7rfp2kFXKdLKI91z+HMGMoi75WGmhYG2UNK0/J6pW1kwSE?=
 =?us-ascii?Q?MhFdXwMaRI+RfAlLsP6PeqWleLGBip2JooovO07xPQ3tzyy0KDui4FbEn0TA?=
 =?us-ascii?Q?mAWBaMJPYwv4nMteV82Y3a4GtJnAdO+lXnHc69Pu8Y+55T2ivKVduyLuK0VN?=
 =?us-ascii?Q?CVHbTsFQYJWoKSs++3J83OYR5dSnSnrzVuMpXFR4y963GeP0AJpSwq6fMGcQ?=
 =?us-ascii?Q?S0O9vu661Jw70udCIEARq+m3GFxKRops0dizxNygsxU1/Res3w67754wYFsJ?=
 =?us-ascii?Q?vXfmGUSObZh82IDMSo+vkE5IBub99Prrhyb13D/dfAWJYR/AajhDIjfqN/GT?=
 =?us-ascii?Q?2+znCv4ubk9ggFGKeK2GafJn5193zXTu6YM9LWAClsQAGHZDfLU8Da7mnusj?=
 =?us-ascii?Q?XB2563PhKXV5PZWu/sglYRkAHcsS3pMbZa654yjVyCr6b+3Qe/1ZCj2dj8P1?=
 =?us-ascii?Q?Se5kV+layy0K2iIYtjLjOXU9MoWVFS1TLUmzl4J8CZDQgpsH0b9rCAs3kHTr?=
 =?us-ascii?Q?nL8yHWlGXB28iqxACsdjhMiRd1xXx15tyKdV9yggifIDs0hpatt7JV9+55Ph?=
 =?us-ascii?Q?n7JM06fa8Ts4izLizFcIrXIAMfShofeI4cLpklIAOf513CtDUufnYoLtNn3w?=
 =?us-ascii?Q?w0uTbEVH4PaY1RWjypDStFjPPpeCyzn2SLCFbynTPBb+vQKubIhZPooA/V6l?=
 =?us-ascii?Q?RlPxuuBdJpQ6+fbvDHQXFOO6Fck/uIov6J1DJ5yCujV2MWbBE2clf2+WsMvo?=
 =?us-ascii?Q?fRiiqhobgSJJjUudXcZVwREf4V6TdR1L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxdIM6wELFwrGTMgEVOWA7r/S1vvhwtN2FHOpB7ebJTyn04A9kIKwdKil60b?=
 =?us-ascii?Q?Ii5dRrM6/byQR+BTgn39yR1Xne5L3Rk81UQdEYbhVOonnx8c4QsRh4ERyW9c?=
 =?us-ascii?Q?LPZW1I6vN1tCsFg+9Hf55yjfyDq+4JD2HxaTEkQwTYblJcKiUpdE8Ujdi6q/?=
 =?us-ascii?Q?Lq+/40QEDBrMMAc+RJjwgFOjkOjz79cu89zEiqruBtAW6UbAHC3fE2OTmSR2?=
 =?us-ascii?Q?gkO5hzD45pT+6in80/47NSH+HL7FQcbaclYkMTi1SRliyW6cJWQOp39AMF1m?=
 =?us-ascii?Q?EitX4QWW0MZALoZDcMDbaRI/1QPi1XRBjHJz4rH+iwP4ysntpGlvNXOsWFRH?=
 =?us-ascii?Q?RBbOAnhYyUriwTFhm0NGBIfIkVfF5lKpkIIpwD8rKP5hXKYUOE0K1qGenKJl?=
 =?us-ascii?Q?T9r6B4qlLCRITUqj5y60HEFA0Fp1+WlgRAjoPA5p+V4ZZftngKIdWAWu/xrn?=
 =?us-ascii?Q?i/dXNPzB/G2PSjH7e0shNNiKsUAd6eXnO6JOT9Z5fKk/ScuKqyqphst/8itc?=
 =?us-ascii?Q?sN1csliv7ILjRtAMAZfh+cp+n8Q0d/aKa9Ej9MnF0Ha1/Obd5L3KCjCadqXv?=
 =?us-ascii?Q?rFRvq12o9dI28JC6OaQuH9PoH9MWQkQKjvfNjarFBd3hUs0HbdiwbPz0b9bv?=
 =?us-ascii?Q?LlbgExQAqi9tF1Z33GyR/IphqJCQT+X0FeVf5DklbNGJ/kI1EipRYXEeqmpt?=
 =?us-ascii?Q?5QA63aBKvkf9mEqccjWS1KffCif0GUSJUcHz2XFIOuUC/t9VojLOSo2oAsSW?=
 =?us-ascii?Q?7pKe0j3grWYZiK5O2ntXAD3z/2rIWl+D94/83VcGCXjl/bGF4p1rUzO8OaW4?=
 =?us-ascii?Q?zFmHDZ7Z/CXrO7uuJFNqAxZ0LTYwk97B/ny+jSiraVTCevsqXtJjwUGkGn40?=
 =?us-ascii?Q?cBrRx3PGHPhrQ7inDwDSoc/DHS+eF+kK1V8+BPNyCdgif5Ew/2AuH/N+xY3l?=
 =?us-ascii?Q?Mm+WMVAM3mt1CBHw2g8zt4rPqmr058n/kyit5i6h6fAhnqS1ZwXoqnIjEe4a?=
 =?us-ascii?Q?R0JGj4rWvSdoznuehWMGmLHPvORbE8spSIV1LaQNKk5BAustLLFjGpXLTwbm?=
 =?us-ascii?Q?oPAXN37PpWC4gMMq9tUowj3SWHcMhxhULFPdtkVMbgFn/9Ew5I7Og79g1nPS?=
 =?us-ascii?Q?Shf/SvjLb70MQn4MUBCiz5Yr4p+jbtEjF5uuOsDchWJ8EeGExmKZTwc8y31V?=
 =?us-ascii?Q?/iYpcvFkIpAN4nuhN90iS20Bz93n6hz4EqQqQefiK5ZtUEHHSB/8VAVlRgbz?=
 =?us-ascii?Q?DU9tIYrJYk2PDWHuThUbBnWXhLH0iTYg+EuaZc1vovSncOcOKKQ+i7JVzDAq?=
 =?us-ascii?Q?J5j12vbFTt4VwAjIDhIaSZHACZzdZES7XpywqhMPOEHGfdxzmr29wpCZzb4c?=
 =?us-ascii?Q?/zCAR7rplgqLQHoA7TVPH5+dZlJwuqDr2QZH1L4BlsTGBPBjeRW/zXbUQZm7?=
 =?us-ascii?Q?ky6gsJ1Z5cnue+YSW0g56djlowGj98QBsH9o5SX+JMlz2Y+r/s/sXHdQ2y93?=
 =?us-ascii?Q?TfM5YhuetjWk+5YdqcBZ6ufIG/6vdiCVQbgyJqvEkt1aoWm1UZrE76PyvVnI?=
 =?us-ascii?Q?pdnnrVxbOxvlrLmtUI5/+703jr2IyH0RFwS36JUF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1ad161-44ec-4feb-8d5f-08dd50aaa74a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:00:04.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ecw5VgMzXmEpD/AHzyae9y/t5/SionNmtn3rgYVqecHAUdqgd/R/gjk0nt7wYAiBPkajIh5+tqrs6TwQkRxQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

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
index 83f9e8a9ab2b..77f8ef5358b6 100644
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


