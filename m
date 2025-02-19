Return-Path: <stable+bounces-116962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FBA3B134
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86590171CE9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E821BBBD4;
	Wed, 19 Feb 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cnq7oJBX"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012E1B87E3;
	Wed, 19 Feb 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944790; cv=fail; b=PHEO/9tOnv2c5cI0N+lq+Wer4ZRWQrbGiQWa29zYzPimn9nRmbN/ZJ/D8rWNSFPjq/7GNAfz6QVTWeYWrthZlp1/SIffEQ7AWVcNPknOIHnpW5FD7jNdf01RcOQcSpwIMRPx0ljs50HjEaCpsEb/kxjEZ8m0dewgLwcYEQDamsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944790; c=relaxed/simple;
	bh=apO2jZbpkjF7AtwBRIZrPiXjDxzt6VEEkDAkq7oP7mA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KKf22k1EWOlPjeH5qie3nROU0gRpad87pu7ndcuF6cUMSvHfMCyu/SIeUayWUy/NlKfUSSRyiAm8UzEjtp9MM/n9bg69gKaye6cyUyw/oybiV6qrXej1TCtEvoPN4TR2YlO1zZh2/ZWesNo+LkOSv2K6Lcu4xYGGFjCQG9dPwxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cnq7oJBX; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inzaoIG+jgqj3RfjCNFnE/CJH0PUDDLudsBvDb9ybj3vWJM13kjZfy6L+aL8S1CUWdHtflOJNvFCQDTqJU4+2l12WiXaaV0/+I5UqGF6CcBUn/I0cqReGWWLqibvbSyfHMezJd7AV8gMs0lVUSwAE38+wKybfXYlr9m675Nob6cwmape2EElVFrJeMIYhHjT+h30rhEFalxH7lqImcmjrdwHSqhgyDssNc+ox4QU+tWSq9bI0B0eURIlbMXnZIpHFC+XTt2kwrT0xvx2H+Fyxg6lVQ6DWKEpxrG9FABEUIQZEVHavA2bPX9XQPLkfOf6uEZJ580Kzc9LgI1TLl+PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcksdm+GdZcdY/gntH9gf9veEUCyRBbPuwJ41cfJKsk=;
 b=q3DLcGC/BbFdXyFdxxOeuQ+kf6cJMFIiEnz9Ukm6guaeqH6bOOMxAq9/7SST6+8htZSvN5b1K9E8je4ivUu1WlsMupxA8XHrqzn/IoTKfgEfte/+N8wNUGY6cKiFtixbyIwUA67XBWnDxY0zwuRiVXbmuvYcJWGbFUuMOroUJJvd52WMMIAj86HtFb5sUO5GYUEL28/xjQg2oM3N0k7vho6jx+RX9YMvT5uHTzUGKqKGhZaZWCMJAwVIyFzCmi1xXhrv07O9zL7IVxWtGosFqDheGuL/2GpAu8s7xBTcJ2X7zZeheltPrrdn6jfJhdGFKO18JYOLlxPPeUgO0WGwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcksdm+GdZcdY/gntH9gf9veEUCyRBbPuwJ41cfJKsk=;
 b=cnq7oJBXPGObsUQ7rMGcRlOrZJAyKvALQ26WbERCg6bVNa55bVTeZPPzszL1JT3dy7wB88bt4CUYEnPv7/1inAW3UvzN9WX33z/mYCbAdQOHJM6iwTojqdNj1ZVl6/hDwRpq5/YruqGqW21H4bc3upVbE8EkLFF6vsu6axS231p8bUSvzNPPOWMbMWJfH/CAbJaE5qTYKqg5irUBth0agX1bHem4KLoonU70XTuJrDr4MvKwQlqQisWbdFpbtctc3ChnUN9QwsWfCK7Tb4aIS1FIPI08trK/x6lHjQHG613XJn+Oxs31/W1u9hmgCMVJjpvqXUjeBKxd/ceJHcXvTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 05:59:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Wed, 19 Feb 2025
 05:59:45 +0000
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
Subject: [PATCH v2 net 0/9] net: enetc: fix some known issues
Date: Wed, 19 Feb 2025 13:42:38 +0800
Message-Id: <20250219054247.733243-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: d8ff8d44-6691-4efa-d694-08dd50aa9bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cAUf5XQW/SeCETlMzq0vPEg+3HipvxHsigyE302OgmHkv7dVrkOWU1VXi0GR?=
 =?us-ascii?Q?Ccx5Yyh4aqKrssKK0SPfOBqXyNuREscWQs0Grj++1oN0RuVdhq7g6cQsHsV9?=
 =?us-ascii?Q?/3jGXldP1t01AeBVEwk9rGJ4rwhVZ3SwcEMYOF7Oy2sqphiCMRZH5M4yMsBm?=
 =?us-ascii?Q?Od69Rm+64qt7H01oZoe1uqhf0GnBM/73odmGw8+/hv584xzK1dVQrU4J/tEF?=
 =?us-ascii?Q?NhT+wFPU/Dh4Vs37o2Bf5YecOlXKgz6gUaFxHw5+Ynxl07AHhuP0XfMUHe3c?=
 =?us-ascii?Q?MVHD9MgOv0/bskqwycGT9X+bDDfE37T49Z32jCeoCdDdMuiQvI32y5wFvoJa?=
 =?us-ascii?Q?61IOK1/jx4z0vAVfqUy+xLMDA7ahsqAR1FVA8qCmAyuVghs5YBR9nRnlgBiZ?=
 =?us-ascii?Q?yTkbaMxIp9StI63fYiXKNpRaMiH9/M2Mnc4dzY7zk8u9qjq5b2OqdrRXx3BF?=
 =?us-ascii?Q?JComG1Mu9V7vjUmwMGx4Kr3eNFL3MutSTms4AqHWdhmsys04XAtwqjRae91J?=
 =?us-ascii?Q?BOW2YG76x/dkvfAmcQehLN549efC1FMnPu87MrVD9jbG7ck/KkaUPvXKziDI?=
 =?us-ascii?Q?5Zef93nZMGCoS7XX+ODnpxiMR9rbZVVUKDvO8UUZjb7W37n5WP1SvsPaTpuY?=
 =?us-ascii?Q?yBiGsc71Lih5sPmHb28OYBo6BoQ+QwhBuk+ApL+l0v9Q7hR8UtjV0htmGqCp?=
 =?us-ascii?Q?pqCsHdZK+xVPLyI/8eIL3QN5cgav2Okd6w8InwrUm3jWzAQTqpxqoyUBXymJ?=
 =?us-ascii?Q?1gB0Wt0cVGFUJXop0z5mnfEwpSk5+3JMHa4kYa77k/NFrao9NXuKmRFLReXv?=
 =?us-ascii?Q?F3iloye8NslMXYRj5bibjXjDiMbn7INCoK5C1S5v8k1WsfYf4BtJedi3fubH?=
 =?us-ascii?Q?TTCRm5Hgl0JJJPKX1PCJFTExsB9TyL8OiTvVMPcaKaOBnVEU+ghmSr/a2Epf?=
 =?us-ascii?Q?oLNCbeY9+Af3idhxK00r2VmQ/5T6V1Wb9Uh3eavsaz5hIwrt1TzTSEDM3Ct4?=
 =?us-ascii?Q?T3+sM9k64fxFms7ZLXrtrlRDCA03c13tLhqVEYjTJAHLBuga3NLk8F0IVIFP?=
 =?us-ascii?Q?7DSwzsBfTa7xit1HYxHqOjKZcbXOn7pt999dKXvP+LyXdVTWc5BIzCcPsPET?=
 =?us-ascii?Q?RSZ1nGjWyIVj2DhU5BorD+F0PMYOnBIheemohXfq/L2uOEW0lwM82ufn2dHd?=
 =?us-ascii?Q?3IldyJAud6s/VHxD4Ng0Ttc+H4oSY0KegHd74UNpuBQONOmR+//AXrOsqOyg?=
 =?us-ascii?Q?8LLHhxjfC1w+BfwPuvYubhDyNbAn4ID9LzCsXwKxKpn/1ORVJISXYkmbkuub?=
 =?us-ascii?Q?szCx1vr6KE8oGft3Gjsi9sQpbmYloQrJo0WG9p4ad7vWo6qXWsA5iEoGbFzB?=
 =?us-ascii?Q?fDAVSAYLUcGDnnhIKiYXlvHCiCPGG17t0Mn0IV/fUJSM7vKYOWlZFUpIaQnZ?=
 =?us-ascii?Q?h+e91OUVYZuQ2FnKqgeeArUVNrBm7fMZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMuwSXJPqbYXqfjNsgnYcNY5eSnUD0q/VI0w1z7yHw6ir30lgXZ0oJwtLIed?=
 =?us-ascii?Q?oIh5flxAR/xtDeZfJbJlSyOn4XFAKAhLYqDAuL0b8jUYZG6nFRS8f45bQ72z?=
 =?us-ascii?Q?bOfE91+AvjKC6Zpp5bUHOEfURC2cqwcUmGCkcsCYhmak4BDmP9JAVr3QR4ug?=
 =?us-ascii?Q?U9o4dD8Zh/zZCAJH3tlHLydE0Im8xbtm10aHvHnBjxwfDOIXWXTk3ww+NjFH?=
 =?us-ascii?Q?DhbzEi/QFJacF0hInjb8+oSIGB4Im9wY+0HapBbfindHAeZbAT0s324uwOg+?=
 =?us-ascii?Q?e5XsrYIUjCbGd+3loPFqcyy9rJT7H7bxNIY2wS+H8oNhQ/CgrX86X+rgcG8O?=
 =?us-ascii?Q?nkO56DPJLUyKmbPgBaRSR7lc2nVITyqt2GEgEGi7DkFErc6p74kU6oJ9QUko?=
 =?us-ascii?Q?cYEKvGMX5OO+OGR6oI06BqqGk9lVAuAgmdVMPdpdx4+NfbzpGBBSHxJ/Tphl?=
 =?us-ascii?Q?RJK6R67EDUAxVI941VMtWrIFO+WPB+ufqxAppTgOMxAvg5ksbS5feV4VzLeJ?=
 =?us-ascii?Q?54bDVAtQiFIjTWV/pPDu8vIRehV6dKYDFljPw1SSJG2H2LPe5x5Mg8RdS0ey?=
 =?us-ascii?Q?PcFpRILpgNybsMr+izbJkyW2s3D9KnmzQMRkeQ5wYvxINoSIaJT+HZP8xa8t?=
 =?us-ascii?Q?1CJ2J7wriNI3/BO/9bs3WY/jRviVFdMVQqaEL/GI0bdLQNnT7RjO5HxtIGt9?=
 =?us-ascii?Q?DtCaUCJz8aVi8L3jg38NMjGBJlmDWn8cDe50JrWinCtmNT3AwodOZUxOcite?=
 =?us-ascii?Q?6Z1zaq8bCAm4pDPluGn/xFC+EKMA2FNymzfyQn544h7dBKXD2xnZ9zUkPJ1i?=
 =?us-ascii?Q?UC6C0WTYMw70NUWJ0wJCLs9E5RogUuZFyirUlMMROpUHFAMLx2wBMA/N2q3K?=
 =?us-ascii?Q?vlXM9Iy9wzmUlwjaRMq3lOEnSxoR350y0I1vGGGfwF08by5pg1KifF6X4mw1?=
 =?us-ascii?Q?SB+WUwLOT+6Yv1wWRr0YkXYWiInVHPduuTWBaUBf9BdnnBQzEIvH3uxbZDlv?=
 =?us-ascii?Q?i+CKwYrU6Ra6+q1d6zU4TsiU7VSp9UDvbyxHMd4ESxSFMmuaqM9tZwauebEk?=
 =?us-ascii?Q?xYjO3e3neWdcJta4Cs8iDyCJqWxTfeww9UytGhCzasYd6dkaMsNAiy3V7CQ1?=
 =?us-ascii?Q?YJTV7p3AIvYpsnkor/S53mZx2Semx1JztpR/yxOLH97eVvkKDMqWnVViZKWg?=
 =?us-ascii?Q?RkWIOhwKq/Ksbs/GkH+FsADahhNJBZB16Lwsay+gIUzcKsySNijJOqcuh9XV?=
 =?us-ascii?Q?etWnelNarl9FaJubIKGqgtlFGiy5N32DCfdo7QUU7psKXodk8qEjNyGg+bsh?=
 =?us-ascii?Q?wG6UO3mkNBqJVFA50Jezxb6bspENqIwRXTDJwy7TjxGY01vMTTgrZIDZbMh2?=
 =?us-ascii?Q?0+P1jF8g4eTXx8lAEYvX0xDkN8XoxSPo89C8UGHpu6j7QhluApWLtFUunHbo?=
 =?us-ascii?Q?nX3UMbGChfK8LCY2d9bM1lgQXPpnryQolITMH5P7uTcTCGT7JpaNoI+ekUKa?=
 =?us-ascii?Q?RKkJQlSGXpZlZuJRF/In9G5KryoJ957imTBx3IYfOyE1NrmvGYx4mLJ9MKtt?=
 =?us-ascii?Q?zXCHG6zct93gdq8is4EQQmWfPnXGLT3cTD7fDN8L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ff8d44-6691-4efa-d694-08dd50aa9bf9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:59:45.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hx2Re2AVeyNTpffb2CRcWmYgOkXIQ+KtOFUsn3+b2RsGenByZlJbC+O6I6nVmea7NblLXAcB3jTSQP+2nzVx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

There are some issues with the enetc driver, some of which are specific
to the LS1028A platform, and some of which were introduced recently when
i.MX95 ENETC support was added, so this patch set aims to clean up those
issues.

---
v1 link: https://lore.kernel.org/imx/20250217093906.506214-1-wei.fang@nxp.com/
v2 changes:
1. Remove the unneeded semicolon from patch 1
2. Modify the commit message of patch 1
3. Add new patch 9 to fix another off-by-one issue
---

Wei Fang (9):
  net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
  net: enetc: correct the tx_swbd statistics
  net: enetc: correct the xdp_tx statistics
  net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
  net: enetc: update UDP checksum when updating originTimestamp field
  net: enetc: add missing enetc4_link_deinit()
  net: enetc: remove the mm_lock from the ENETC v4 driver
  net: enetc: correct the EMDIO base offset for ENETC v4
  net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

 drivers/net/ethernet/freescale/enetc/enetc.c  | 59 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  3 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  2 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  7 ++-
 .../freescale/enetc/enetc_pf_common.c         | 10 +++-
 5 files changed, 63 insertions(+), 18 deletions(-)

-- 
2.34.1


