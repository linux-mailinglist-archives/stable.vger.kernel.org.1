Return-Path: <stable+bounces-126849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D492A72E95
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CB71887B05
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731A20FAB2;
	Thu, 27 Mar 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X1TrdXLK"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495120E6EE
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073918; cv=fail; b=YhiiNbdRPhzlaDRapuRtfNz8NSfzrbJp8Fh6HwC9oWlFpEgv129wtcGu3uqZ+1Of+oLlTx4vX0QiqKgQMle+dg7lmqCS2/D3kDjQNG6230d+7pQiALUpraGNOvF+m1PYVUBlRvRxWDRFO469kvOXm2tR0ZfrVNUoYljnLy+KnlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073918; c=relaxed/simple;
	bh=AdOAIb63nYpvVH6X1hDFycYa+9Vh/eNR5kJJWH0zsIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZG2bPKMl8OHBrWveVin/KIE5L858NWlgw2F7cTVe82cKEGp9g2XCPrbx+CXX3s4qou/lvJjM/4/gCkHnz3hJkE1rNoZb8dLSLS590rPYtP8mdZluU2ODbNEeyadqHjLHlqRHMrjUiRjn1QDH9gvaofEUMA+w/MfbNHXzDLxIWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X1TrdXLK; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djasycN8ZCw2Fbd1gSbR5KKKDyOt4kTIUPp5omVJ59+w0PNZci9n0FOSfSC4QsM2Qr4fqs+VUs+l6JojI+MEZ7nMdE8dRKyTinpMaHooWGayhaTrvSuEVcI/og/sYnol5uUAiwLUEphpFlekwap3nmWv7vuqOz7WmvKwlM2bdpFsHAm7dROlR0hgPF1v7GZii7sr7JVHBf3/7PF7zI5n1OdJsCFDei8rRuSoUo+e7Vk5J0UBa/vwKVltAI5LeLRG+i12PKVP0WqXy44vd1vlgo5lVoCUFnXQDaY/XsjJWBLo0UVolaOkPInhkbIxpLoNdQE9b5VarX1zhYR6mYc/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=k+GIsp/RLiPK2Si4VJOn6FHdb97Xq0dKmPAxIcmqw7nW98F16iGNIYUP5VM0l3xWI9/XtLkvCWGlvfwuGGO0E0Fq9HN+t/QYQABcYp1Eclk6IpthsfrLp/N+8+aT7nTwfzkHJAycZFVacHZMNi71wrg1ZmunZBzNmDAlVzZTthliCiq0QO7n34LcgvrmGbFbhWuPqjo45Gkb3HHk7q5EcvYgjWIez4sjBB9EvBSCS9MSm/B7oaMp/tEbPIwudNsqC6CjR75JOfRHUbnXvUVMYshVSCpZpyLCiEpW5gkY895P/MHvoY5cdapEYCZTWCNeSehD0Om1BUoWRAfiCiPysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=X1TrdXLKc17bJ9a282e0PDlART/5n3bP9NFhiG9WoLASYQiNqh8K+1DHoBycsW7jo7ao6/32Flf38iQGtEoUzga/4ioM2yCiBw/vyP+sjepTDokpQUn6/UAaglOlqi1cjT3Wl6/PItPe/r17/lCpale3ScZHRZR49Cptt2E3AsA=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:11:53 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::c6) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 11:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 11:11:52 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 06:11:48 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <Rajesh1.Kumar@amd.com>,
	<Sanket.Goswami@amd.com>, <basavaraj.natikar@amd.com>,
	<Raju.Rangoju@amd.com>, <Krishnamoorthi.M@amd.com>,
	<guruvendra.punugupati@amd.com>, <akshata.mukundshetty@amd.com>,
	<sanath.s@amd.com>, <mayukh.shyam@amd.com>, <prakruthi.sp@amd.com>,
	<Patil.Reddy@amd.com>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net 1/2] amd-xgbe: Fix data loss when checksum offloading is disabled
Date: Thu, 27 Mar 2025 16:41:29 +0530
Message-ID: <20250327111130.3075202-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327111130.3075202-1-Vishal.Badole@amd.com>
References: <20250327111130.3075202-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: dd56de1d-69a9-438b-807e-08dd6d202d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqCFIzSlFEABqm0lSAcCv8QQJAcmyYWAf6H8T4S1C7VLmc4pv50gdRhe4ar5?=
 =?us-ascii?Q?2O62z941BHBS2Jmna0RzUsL3WB3rHx726rSvKDR1o7UAQVVPXcip8lnUzGWi?=
 =?us-ascii?Q?pTK1fu/47+anB3wyPsm9Mu2ahkil+NFLrpfE1x2zqfGOxYIeNgwrQw8y16WE?=
 =?us-ascii?Q?LHp0FgJ9/7u0KBDIYyJVe1TJRUnrAySzvHPEyIWmgyjd5tG/mmbgYxYWA3tO?=
 =?us-ascii?Q?EKq97SrqUIasw/a5bKLfVymvcq3SC5e422tjgOKlP0Bj43mTOzd5mjIh/u9o?=
 =?us-ascii?Q?1+E54+byQwzZpbHnfOrsV7AqwKWI1L5lNVaAbm48ZY2oO5qzX0OfJC5iAtlP?=
 =?us-ascii?Q?j0Lcnbt3MoF49M2JjHTcdCDtBYncpLKcVgpGo6AIBZNcNbQF/QhJ1FPlXqVB?=
 =?us-ascii?Q?3GXrOg3v6EzvqcZicnWHv6rU0LGNu/Oq9F3oDhOOKhKh4O63xeoueZVNuCDI?=
 =?us-ascii?Q?EsbUGjRs0eyCAcPpc88HLiRL2tzidaTlZTPmYz3YOMgVZgFQuKkg82b6IHdV?=
 =?us-ascii?Q?hNhAulWouoNlzsQavv/lkoP0tovUIQNi95OQwGtm+QRH5PZRKfVMo/wUP4tY?=
 =?us-ascii?Q?qQA0FACEKG9vpp4TBvMjO3juQkf32ptdZAC346VbM9DSp8obTtKzOK7P/Kxi?=
 =?us-ascii?Q?DE1D4zaIq6ojd0736SbsRXLSMONPYshKxSoO7mvLiokYWd/aY1ARufZpI+Nv?=
 =?us-ascii?Q?4EjuOEu5Thmsxy9X0jLL3C0vXqWLcD2frnLY8RctN2XmQo+993kzQHPSXRR5?=
 =?us-ascii?Q?ZLk6b0HSGPSIEvLJIQqurKvVVTLyZ5RCscR5kZuzpNPRYt2cJc7cmwLnumZa?=
 =?us-ascii?Q?kYAcSJK5cduDZ16LeibhAINrbsNo3ttdo3WcN2NQxjxv4fwO4KrFSQlx/n1M?=
 =?us-ascii?Q?K2SjfHNZgYH7SsdUNAwPV0qRRfs/v32gEteU0AN8LeYbUxqHorQPCzKramot?=
 =?us-ascii?Q?GqYmp7mR3LtvxpDVN0hpWr0hHDPM+9dZwqxXrxtuA3b6I4dIGsL4wD0UMSdg?=
 =?us-ascii?Q?3qEr/2xHnCJhaFPWbWrJcTQQDoCe0fQNU9iWLhs5TszIBglylsuu5Kg1cPL5?=
 =?us-ascii?Q?Tgt2iNdKXE3oq4RDgLJDCZMKhHBYs7Vo+BSIsc6PzqjSsuqAlTalCSlX3YzV?=
 =?us-ascii?Q?P1hhH2AKQ0wt/XXqu99RRjH3vH6k62mJdNlZGRIRzIjmfMlY+iPXQtOIBkrP?=
 =?us-ascii?Q?qe+CkYWI/MVcSEWUB0SA7wzfV/z6g3iS6jMOUezNojPC0GXM/OTckL/+fjAx?=
 =?us-ascii?Q?qScPBSPfVfYVHhi2R63Ycm8DBWeAF/tN7u/+O/wlUikkj3bmoO4bjEwm61Gw?=
 =?us-ascii?Q?KvffYFNwGtuWDyEtwet168cpp18kYRXFLvgFb+kf5uUOIZubs9RFan4mpX3J?=
 =?us-ascii?Q?4f5QA0k62Qjmv0zTNvLujHQ3SNVDroJGXC2/ELgrrWsz2xE/kaP0+uj7BO9w?=
 =?us-ascii?Q?XyJIA5xzSwuHvTosIjyJQr9oKjMwmtqSxqwHa02rTHrQgVBhcGXdtcTt03n7?=
 =?us-ascii?Q?ZDVgwzPbwfL6kBDeYiHZtDpdtguvlgRibsfz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:11:52.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56de1d-69a9-438b-807e-08dd6d202d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705

To properly disable checksum offloading, the split header mode must also
be disabled. When split header mode is disabled, the network device stores
received packets (with size <= 1536 bytes) entirely in buffer1, leaving
buffer2 empty. However, with the current DMA configuration, only 256 bytes
from buffer1 are copied from the network device to system memory,
resulting in the loss of the remaining packet data.

Address the issue by programming the ARBS field to 256 bytes, which aligns
with the socket buffer size, and setting the SPH bit in the control
register to disable split header mode. With this configuration, the
network device stores the first 256 bytes of the received packet in
buffer1 and the remaining data in buffer2. The DMA is then able to
transfer the full packet from the network device to system memory without
any data loss.

Cc: stable@vger.kernel.org
Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  2 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 18 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index bcb221f74875..d92453ee2505 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -232,6 +232,8 @@
 #define DMA_CH_IER_TIE_WIDTH		1
 #define DMA_CH_IER_TXSE_INDEX		1
 #define DMA_CH_IER_TXSE_WIDTH		1
+#define DMA_CH_RCR_ARBS_INDEX		28
+#define DMA_CH_RCR_ARBS_WIDTH		3
 #define DMA_CH_RCR_PBL_INDEX		16
 #define DMA_CH_RCR_PBL_WIDTH		6
 #define DMA_CH_RCR_RBSZ_INDEX		1
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 7a923b6e83df..429c5e1444d8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -292,6 +292,8 @@ static void xgbe_config_rx_buffer_size(struct xgbe_prv_data *pdata)
 
 		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, RBSZ,
 				       pdata->rx_buf_size);
+		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, ARBS,
+				       XGBE_ARBS_SIZE);
 	}
 }
 
@@ -321,6 +323,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
 }
 
+static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
+{
+	unsigned int i;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		if (!pdata->channel[i]->rx_ring)
+			break;
+
+		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
+	}
+}
+
 static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
 			      unsigned int index, unsigned int val)
 {
@@ -3910,5 +3924,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->disable_vxlan = xgbe_disable_vxlan;
 	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
 
+	/* For Split Header*/
+	hw_if->enable_sph = xgbe_config_sph_mode;
+	hw_if->disable_sph = xgbe_disable_sph_mode;
+
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index db73c8f8b139..1b9c679453fb 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -166,6 +166,7 @@
 #define XGBE_RX_BUF_ALIGN	64
 #define XGBE_SKB_ALLOC_SIZE	256
 #define XGBE_SPH_HDSMS_SIZE	2	/* Keep in sync with SKB_ALLOC_SIZE */
+#define XGBE_ARBS_SIZE	        3
 
 #define XGBE_MAX_DMA_CHANNELS	16
 #define XGBE_MAX_QUEUES		16
@@ -902,6 +903,10 @@ struct xgbe_hw_if {
 	void (*enable_vxlan)(struct xgbe_prv_data *);
 	void (*disable_vxlan)(struct xgbe_prv_data *);
 	void (*set_vxlan_id)(struct xgbe_prv_data *);
+
+	/* For Split Header */
+	void (*enable_sph)(struct xgbe_prv_data *pdata);
+	void (*disable_sph)(struct xgbe_prv_data *pdata);
 };
 
 /* This structure represents implementation specific routines for an
-- 
2.34.1


