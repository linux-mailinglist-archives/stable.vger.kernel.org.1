Return-Path: <stable+bounces-116544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DBA37F18
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F25188B7E3
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8422163B9;
	Mon, 17 Feb 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h292Lw14"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C182165F9;
	Mon, 17 Feb 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786180; cv=fail; b=fnUEf6z7/XCca1+OiqBnllcnwHK/oT7MbWFMcRfPuF58ewpWpAWJd7f9Jhn8zYnUae4OHOh0Biy9d1rsG1GGaEOAHJXEUtD8z2qXvaA2bdfRM2d86wKoonyd/S2g/QyTEmhD45W6DjdEC58JPxsMA9aE/rPiOwfuXXf2MqahAGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786180; c=relaxed/simple;
	bh=jPu1ZP22+NClqqng6QlP5eqoDB1CNQTLuEMrSuFRHic=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MvTY1QrfYGDgJONxCTVenqFu1tRxvDjmPVCEFwoXGYB8vOvxrGqVP3IZ803hoFfaKmgXTUMD9FYZBLaVZ8ORsFwZbHDofSRsjFcJJSxMAYBX+SH4+m5P7UHf9mc6s/vzKH4EDBs0qSxsosvkjVLFBDwCpvHAwYR63BTd7+bOOu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h292Lw14; arc=fail smtp.client-ip=40.107.103.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE1AqGIaCxnrbJ84n1bky6JbmbHK7RCmaJQG+PYlb1bc+Gg35rfZCVgwb2njhurc/KIAy28rNkp6HlUyFTLzQO6B+mIoAwTnxkbK+w+lbR0NvKIatwJqnXgDMR0sxvaD58q7YrVV10pXtFp4jNb8AZIPhXZRQ79XGPdKKrn3gQeMB207GpMpXePBSxd6TyxkertwIJUVyoTjRCS9+DZl7eypx2GO/+UK9rpFHa+F/cv1wF9Qlw5FxYtRT5ArJ8hMRZgJgNIAsxVTN4TbrLW3h1gnJrcpVcyRLgF+SYvfuHDABCaGtQv4cxAYSudFUO1itBha3Bp6mR4ZbQ/bpPhRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8G7MSe2P/2X03ljRDMV4899Mbm1A4oIxxTH6ARR+dA=;
 b=nQd0gXvSbWFNNQHJ0L73905Gx6auZACy556tmNyhk673q3NFr4JCH0iDlml6C1g5aqTteLTr76QxcLXpTO++Hx9g/JdWJ9a8T9YsbiZxNw5lujAoBjAFITgvI0xWeiG8kD1YZyv0Sa/7r4Jjw9ny4UR3J3EpsvLXcXQ3nsz70aHWBWUeNh9X/ernQNhRHB0A7Q7hioZmRozNTx3TUSjRgEMP3OgSIPbkP8vVW5lPGKHFYuqzczu9vKjaphRIHfQXIdtS7z3a/Px+ZftsMc1q2je4pSSQakay8JRj7Z8nqz3cd7xTI7t7rXtZwDKxvjA09/WIC6XLPUKcliInOvxPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8G7MSe2P/2X03ljRDMV4899Mbm1A4oIxxTH6ARR+dA=;
 b=h292Lw1455TXH2+vKbmGv4Cp4n2cyHi5j2M6BV2SFSr2PwA9sJ607NXpHL8Jwl/w1lmKlqyw+T+c8jOnrNKmIyKaqL0dMFtJMieZrKT/puTMxMK1pSrqL8qk2AiOiizFgJ0mwbFSii8VARTJMmC2MzkhWwMcv/KI9OhyqSLUcygy9+QTet6qWoiq6RwVG86DthImwBKXVtfh9EMFWUGhOY/DzMFTTs2spQSGd5T3vqCVBV+WdIdtzBFeJ7U/cp+rnkeUXgyF1iUlxHwsagE7jmUqtg8cLgaWFwTSLA06PBmzF74F8/goJANGF8c3GzgCwlns/VTKEpZZeBCLxvbLdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:56:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:14 +0000
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
Subject: [PATCH net 0/8] net: enetc: fix some known issues
Date: Mon, 17 Feb 2025 17:38:58 +0800
Message-Id: <20250217093906.506214-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d2fcd4-b940-4e25-547e-08dd4f3950c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rl+HKIODbHJ8Geo2yBpwQa5CvyT3GTJnWyku0cDXoBRE9Uz/r5za0lm5xaRU?=
 =?us-ascii?Q?saUKbJiM6E2Ir6N0FlEQp/jG/3Me5FiLq6bXd1fk5VLEVt4Y3Zlu96QPC081?=
 =?us-ascii?Q?b+3g/sJyiT+BxCCtd4VbYsTeoUhu0dKH+iWDqeJj3p5R8rwHvzRNyLDarrIH?=
 =?us-ascii?Q?cHCKLEqTEbpXv89XWvvZRy+Ylmyo5fxpvRAKSA/m8mF3CLqGoTmE5ERxGT0K?=
 =?us-ascii?Q?NHW8fzkWkc/jzgQo8G2ZatQXbg0jrlOKf4JY0q7xQNKLm+T/Gru6TigrBXre?=
 =?us-ascii?Q?Shc68B1nkMSN752MgyvBLgQfLWKQrloIoDrU2ifO5CtTPJyCvlTaOPY9OfN5?=
 =?us-ascii?Q?PIbjja5fHSAxPe7D4S5sImZzVtluNEExRJjRiwQO8IciXwX+uNRf0fKbiZKf?=
 =?us-ascii?Q?urVOkUp6IbvP2wXGFUgJlLcgWVUYgrpH/eASGuG7rnDNGDGT0RD/7BAppBNu?=
 =?us-ascii?Q?OEWQTDh2wamnXSr15/6/+nOWmnggnGWEkzzgpDNwpX75MC8Ve0Hg/FYHZM7s?=
 =?us-ascii?Q?nOoYiyAPoU/AUwh9B62fmhS4YlKYmS7P18quKcIJ839mv3fZCEzD+GAdz48o?=
 =?us-ascii?Q?6HF17X5z8gfoq29/NW5lEqVWPTYOzoMoiG7i9qyGGb4XefiX2m4Hei7WHWgp?=
 =?us-ascii?Q?tTlYsZo/r9xJNfLqj1PY9VBucrr+WBjcvfzCzLgf++TpdgljyoRkr1CCCNUU?=
 =?us-ascii?Q?R0tIU38VRL7JXVTnIA4oWSicF61JOla4o5MBhEFmRia9coWiTpEAnXZAAPEe?=
 =?us-ascii?Q?Giq8Tj/sE23smOZrCDPbvWZAxaVh6M33kVpEXGN0n0NBURbor8pFOBYcewTb?=
 =?us-ascii?Q?fGL5nuRkV8SPvGnE1AMNtC6Wmy59J+cC3f0nVfCRUzr+T3+MbZf3ZRKm3CVH?=
 =?us-ascii?Q?teeWgHTkahtmKz8xKINhofOeGFo4pF3G8CAI3c0TyYFKUtF3Gith3rVAPEdg?=
 =?us-ascii?Q?WnGHquWysK+sN33JigiLEAUxussVAoJD3G0kZVKpVzl9s5/viP6Ro5bwe5h/?=
 =?us-ascii?Q?CCGs7+/aYj2KJBuL9I79K3cZIt0kcyq3ZQAlOBqgpHWTLjqS95we3SRTM/vt?=
 =?us-ascii?Q?bUfMVgwJhTPebjhwB99ZHT2W7bENAbHurBBp25fum/b/6W2Ez3Yn6FcJkUze?=
 =?us-ascii?Q?IQ+UlvcUDjQmvnK9tKqReCKJkj/hjBF/epbihKE6fkn96zIH1nQ0kynlgjb9?=
 =?us-ascii?Q?AwWgrcff+3C3iAmSmg7XClPpYnOndgIJXCeO+eNTmjnsFkcOiDY9h+xwqXdl?=
 =?us-ascii?Q?mwe5wcUw3mEXie8qX/sGMprCGTv+i1K4qsrlzvbGMTVZTaaZGQ6i1i24FuHr?=
 =?us-ascii?Q?ZzjCZXwbZGr6XmQw9CSTLLluCO40sDMc7N7jAYxn32Oq2uVhRUnJWsM8SD3E?=
 =?us-ascii?Q?M8I5LP6pM8oMR/7ViEbLywwK03TdnatUsU6NjpZyoE/kq3glOUCnwTyaQnsc?=
 =?us-ascii?Q?nT2jAIJkpPqVB6sfvezl+CA8I0z3OXkS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGU43UyynQfl0cuzDWLb2ukspbsDn3KcD8ISlvSrsxkZKUz6Q3+xoBfTGZ/C?=
 =?us-ascii?Q?4VJhETd6V2OjLpjVjs1MFjIwHQb9p5ePd/swKOZFC5rJfz6aV/72B40spLBf?=
 =?us-ascii?Q?ZxmhmpyoFMJI73b7gyoVmABWiEAXEQoLioQlNxHnLYLsJBEaC5BdpMOgkKlH?=
 =?us-ascii?Q?KIAkRH5Gls3lrwjQ5OnIGTSPhuTjD8FcFZzi/4w7Xj0kfmx2ugy6g66nKAV/?=
 =?us-ascii?Q?WO3G5fYT28vGJi9N/DQFQK5Yi71cSIKulnfJB0PBzA+SeXXf78LbsXd/pDvG?=
 =?us-ascii?Q?l4lM7jiFn3IEeDfGxYrRm9XvFmbhE1yQO3M2ZWP1x3z30baTl167ZZ8e/Q1z?=
 =?us-ascii?Q?eyVV4D6YStbyYiRj7lFpemGHUscAZbQUqqailVChdb7nmwIChF8mx7rFeiLp?=
 =?us-ascii?Q?69n25uJDqFNME4d3cSfo2wn/SfxamzzAt9q6hCBokOmKtYx5h1iqM2gu2VkD?=
 =?us-ascii?Q?mimXZS1wAeAVaGbjEgL64P1uYy4Of0xYVqzz59gStR8KHG+IPBVhnyT2oIoM?=
 =?us-ascii?Q?uX/jGql89OjK80Zp+y6juYn7dbyEAIQ/qSGVk8b6rjExOzmzqogYbELUHUxJ?=
 =?us-ascii?Q?ynz3tgHRowGR4mgW0mp5WHHxfsV1sdDxiTo0u0wrAJJ8FIY5+4OBsLHrD2yj?=
 =?us-ascii?Q?NFeEeg4sCNi4L89EAUl9Z56AHfQ++zt6hiEJL4Ny+Ebama0guOXu8W9g7f1h?=
 =?us-ascii?Q?47HqnmbxSFruYuYDpGK/I4Y0DcV3KWc3/9Eg3fjQApVrNrPj744dgd6WEPjv?=
 =?us-ascii?Q?RimmcroKgsqlwSFd8hyEe5lVCfmtKWWSLWYCBMPHGhcXeUstaYrPsWaJSHqq?=
 =?us-ascii?Q?pAXBh1lnQNGdxOUbVPVeyhfPexnnrk104uNUFzzh6MCLQp8RxNSf59ziO/Bu?=
 =?us-ascii?Q?xbfj6P8GqLsFK+hVOJVIO9sbyK+oluokZHxslk3Y5tVzHgJAfSkZ4Dpw/zlS?=
 =?us-ascii?Q?tiacYFxccjKslfPpbw9Mn6qPhygSkd5EYhVwCl6DRen+Aea/op0qC6bmmTuU?=
 =?us-ascii?Q?OQ0kl8FVUo/CfZq27AhY9EMKxzQJ0nVEY71XfLhhrX0y31P+4H/XGXQjgduW?=
 =?us-ascii?Q?oNQ/bk4aXe4fdLILi8Ijox/DgJD0MtoC+j1puutTHW2HR5cZ7PpzHbfDnXRK?=
 =?us-ascii?Q?ON8flskhDV6HuKPpYgG2ADitLd6JwB4YVJiVq6hgbFBL5nELo5KjOpbVSL0e?=
 =?us-ascii?Q?wg9Tz4+zXJwGAXwLQxXxE7NbpW6PXAjf7dAeVhA6UpkHyNe0zeHRK15XuIg1?=
 =?us-ascii?Q?7bspwRdb2EdWv1Mp8NtqPNUulacolVocPFDe/nGEYnjVp7KjsMsoSf1Y/Zii?=
 =?us-ascii?Q?LbYb8W8VenCDQQwtxUtN9RPlcu0CC0sH+mxgE6eW2yxlyHl/9gbO6xNSKfW0?=
 =?us-ascii?Q?9xsppuKwH3T5Ljd5RIb1zdge39dXIrACCxBrAcGKE3GIj1yfwI8Wi3D3JVWm?=
 =?us-ascii?Q?fABtqnd6mSPrExc++WYu3Uq6jB0aYFCkv88vt7lIo8T6xcbSYAZkVHJnuvXy?=
 =?us-ascii?Q?htaESXrc14U70zs86/7/3d0GAMGAs9wBOLaaxRajPN1sCl9CkneIAbhPcnU9?=
 =?us-ascii?Q?J3EKsU/AmV3+rCE+SWktF2Azocrc5Br5qZUJ8lWW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d2fcd4-b940-4e25-547e-08dd4f3950c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:14.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBAvxQZbqZF+qo/oTEorXQa5ZGAG/ChqTctbvRWfMmavyZMHCww559kd77S8c+kwRiLZm3CfEpvAYZT6LN0Knw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

There are some issues with the enetc driver, some of which are specific
to the LS1028A platform, and some of which were introduced recently when
i.MX95 ENETC support was added, so this patch set aims to clean up those
issues.

Wei Fang (8):
  net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
  net: enetc: correct the tx_swbd statistics
  net: enetc: correct the xdp_tx statistics
  net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
  net: enetc: update UDP checksum when updating originTimestamp field
  net: enetc: add missing enetc4_link_deinit()
  net: enetc: remove the mm_lock from the ENETC v4 driver
  net: enetc: correct the EMDIO base offset for ENETC v4

 drivers/net/ethernet/freescale/enetc/enetc.c  | 53 +++++++++++++++----
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  3 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  2 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  7 ++-
 .../freescale/enetc/enetc_pf_common.c         | 10 +++-
 5 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.34.1


