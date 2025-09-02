Return-Path: <stable+bounces-176919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1570AB3F1E9
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 03:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C481189EC6A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE442DF153;
	Tue,  2 Sep 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDfo6bmw"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA61A288;
	Tue,  2 Sep 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776745; cv=fail; b=cqFIusPGEnZVIeWeqtz+7Ih8JOhTWhAghB5Md0IKWk//dVfQrF3V1N3tfbvl9hzibn5UEO6KHL4aoASMFfJxqfoCTiVo2lxXi49S45QANof2hLyz0EY8ym/Cua+wjobWGBc6LnFwSjTwh1L935DscA4zSWlSJvXguxB9GNr2cqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776745; c=relaxed/simple;
	bh=KO9GAkPxXG0vjRh0RpJg6t0gUOqGZRBK+TZh4+Wu+Wc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9xZK5W+fI03N2OIGmiSijY6Rw7z9oxDPkuqQGC9CqUheLXFiGiwQnvwuk63oyB+apRbBo13TAhBm7V9/iLoIc4WlpBwQ63l2UOPmp5hiu3INCl24lDnGMVQoT56Ntc845Ps7bS4aI2hTlwvCcsqg3GIwXmbRhWFF3B9l+8FsrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDfo6bmw; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiqGjJICPDKiUAYkW88lsWJXdSFjU2nXvDj/xPjkjo1U+oSCH1T0XGw8BOLBDMaHfSQLNXr9ax/SYtFefmGyRiBN0yxdykJg5RNl+jAJ2x6HaGl2s+3A15qtuAR+9EXpuSgoejV1nEHOaL5VAOrqZQ1bE2hjoTDTpGVUG9IkRekf+SmqNX5NcivDeJwBDKZPIYy1WC7bk3YJ9VtC4NI+TTdxR1vcTB6grpG+VHR+EiKLLtkgqOLtXXuzY/oxsacoRxBDdTmuTfpvd5xAF2e7YMCokLux6tqUdReuRsfrH1vH0xUIRKRjc25E1rHEq3oAIMmyPon8vUI7FVDxUIGG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVVNzRh8T8JLyCNoAZ79IEkQcS/VJTNo8wJjeji3QLI=;
 b=bQqcYbmUV7G4E6Klo0wU+NlupPzQdlAZ6k3iky3cgWJU+5lfpCG6O9TPRabjzvZmmBOU/qkDieRGK4BRdsoGD3jpTDlSlvIbKfnE16cfM3fE7yQdhe4UYlABLQzODRgIgODVl+Ui4JUGNCYL7yRvKh4nH1CKiXjEDFzGq3NVIDCNAkDczJ2czA/6qENwviNtkW+Eg4B6busb7FpApnAx6XHb0yZrbmZOU2LaEUCQLuSZnsnwZNZKawEf3naBAfkFbg/KTL2ux4J2pavzYrKRaYvxGse2EFisDFtW/9q7ShzIrBxgC6ue45SVwgsxD14mgklLuh32+8BxELuMtKzMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVVNzRh8T8JLyCNoAZ79IEkQcS/VJTNo8wJjeji3QLI=;
 b=SDfo6bmwUZsmD7INo1WTQlIT53v+3TFY9oXZfC4na2ubu/RDnRCIyi/cTlM1cb78oI4C/0rPqSKF5R+dOHiBMYHl1vvapeUSGka2DpqZdOZ9/3sC3qaPrd1Y7OWcrdyQ2EP/WIzRxIo5ts2Qn6dH9rEnzRnwe+RfNKjctaN3d3w=
Received: from SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 01:32:20 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::c8) by SA0PR11CA0117.outlook.office365.com
 (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 01:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 01:32:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 20:32:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 20:32:17 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Sep 2025 20:32:07 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH net v2] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval
Date: Tue, 2 Sep 2025 07:02:05 +0530
Message-ID: <20250902013205.2849707-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d29c0bb-ae93-4a3f-50e9-08dde9c08ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rQ+gKSEWeN5D3j20nuT2TmErrBsk7L2u05Pf6uUL4AIG6ygdR81HfvGqT1s?=
 =?us-ascii?Q?VxTeV5KpiXzZkJTIsqX0CqiK75fpgOk5T09QgQQ/HTxdl+9usRE2UBL9OVkZ?=
 =?us-ascii?Q?TgzF/qa5vjUQv8yS+6LWSeSFXtuOx/I0lMNzKbh0Q0UCEiZE44ecxWhuQVLt?=
 =?us-ascii?Q?A4FoMs44RFeGH07z7I61m2v2Bst/YyFBa9h1jbn/qfoLJEbveQ9Fe78udc87?=
 =?us-ascii?Q?4BKCgYzFPAwFJeN3meacylgNvPxQVHmfxp0dR9zh815xdAoE56kD2LCqLwV1?=
 =?us-ascii?Q?zKWmSLdhYEeYYRYsHH1VHs00nsJHg2T4yeCMwz1ElwLRn2QhKt6679T7zTy8?=
 =?us-ascii?Q?L2Yv7BWuKEzcsQM4fhgnLfAxDfh6TsGAzAqkNCvVI9DkZQoCUnkpTxjMcIVI?=
 =?us-ascii?Q?SIj30GeRmiM4DMhxTLRDGsi3BqYHVDT0Vc5ShbPldT8QRJzigwh4sxz/ek9R?=
 =?us-ascii?Q?L+DGLBG4BfDWGJO4zMyTsiZZeDGEKX2fR5rCerPKyQYffByma+i9Qt7atquH?=
 =?us-ascii?Q?0qg7GlJx1SorN0YtHodt2W7yQ7IRaCuAUe4Ay2pXxnUAe3eE1jePXtckm079?=
 =?us-ascii?Q?WrGBkiNOzTiNptLjeqgFCdBq290h3QusiyxwZQS3EBduSwEMcw9rmFHma0ou?=
 =?us-ascii?Q?EJv18HQpUv53UBQNcTLviCEv4LtmmQbCDZxZji/A5owZF0s88Ss4uAEVgo1z?=
 =?us-ascii?Q?o4WK6Z6c+jYtCYqujSwB5l5IbYfJNgPSGs9g2FS/W9aQayfOeTsmTQpnRtXN?=
 =?us-ascii?Q?e4Fzd4Nz70hDRdrEBeEgDxESmytK1L7bRFMsfxaqc8S+1Jjgbrv1nkyOh/UL?=
 =?us-ascii?Q?zUYU1+2bgxkm9MUNXWPn6efbAtoSzLstv4U3hLQJDSShvcgKRYYHUjlOXXpa?=
 =?us-ascii?Q?j+LY2yl+IQC4NxsA1lK2d4GyRcFArtlUbiSarxdo0qTl295fjO1vFu0AqlpH?=
 =?us-ascii?Q?dJN5qCH+nm+ZRnKjVo4gUiT3yUinB6VF9pQidiapBaSBptBEGxipNTb8KWEP?=
 =?us-ascii?Q?ZvkNe/YAqJ+nKfj4ljhJFTddTpDfQ6fjcY0d/xN/iu23yzku7Ey8qphLHTWa?=
 =?us-ascii?Q?QUqs7zr9HljkDhnUzo/jFsDUWL3pPYtSZPPgZSTG0DO/enVGQYckqQHoo/zB?=
 =?us-ascii?Q?vT4+ztLQ78n3xjOcdwPigpR1ZXPsmg00FpOC6Zv+7MPVczVhAMK6aZqd4ZBx?=
 =?us-ascii?Q?Uq7eLZ8eQPpBqUYbvtC2YrzcWwyasklS0fgEm3dXvNkrIyCDzcwWnudcLJKS?=
 =?us-ascii?Q?Am6IDakCURoOzH0ZRk3spoT5ykPPzUykFvO+yXyr45r2cmGbaYL7myHVMUCz?=
 =?us-ascii?Q?r8IkKTKhzCKMDOmpt2Wusu3XAu0oGFPdDidIp3YsgsL+D0FhOMOw2jgQEwYR?=
 =?us-ascii?Q?IQtELYYHgSeBxokqjsL3aUnWlF4CW3tYJWLANBUjIzJ5rjPLWg+9irFN0sm7?=
 =?us-ascii?Q?u/B1J1WEiCf8jkQEZdKEBMsn32t1O87SgXe4qu3BtegcOMrQgwqNfmUCkP8d?=
 =?us-ascii?Q?EpUQlcffVGbneCYW4l7U5wCxbAhuCMhUTCgM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 01:32:19.4221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29c0bb-ae93-4a3f-50e9-08dde9c08ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Add proper error checking for dmaengine_desc_get_metadata_ptr() which
can return an error pointer and lead to potential crashes or undefined
behaviour if the pointer retrieval fails.

Properly handle the error by unmapping DMA buffer, freeing the skb and
returning early to prevent further processing with invalid data.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

Changes in v2:
Update the alias to net

---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0d8a05fe541a..83469f7f08d1 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1166,8 +1166,18 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	skb = skbuf_dma->skb;
 	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
 						       &meta_max_len);
+
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
+
+	if (IS_ERR(app_metadata)) {
+		if (net_ratelimit())
+			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
+		dev_kfree_skb_any(skb);
+		lp->ndev->stats.rx_dropped++;
+		goto rx_submit;
+	}
+
 	/* TODO: Derive app word index programmatically */
 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
 	skb_put(skb, rx_len);
@@ -1180,6 +1190,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
 
+rx_submit:
 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
 				   RX_BUF_NUM_DEFAULT); i++)
 		axienet_rx_submit_desc(lp->ndev);
-- 
2.34.1


