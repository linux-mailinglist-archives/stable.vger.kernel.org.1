Return-Path: <stable+bounces-126847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02731A72E78
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7890F3B9AEF
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E061FFC46;
	Thu, 27 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOoEMXnB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090820D504
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073639; cv=fail; b=h5/VMVU3fE1BFJza23Sdv+pFm0oinICSV9eXnBq/Mwmmjf+Hn2Iu1L7almkLUQI4Lpjp0hLfCyWp1f2RmwgN628+YZoz+sP/45Xjs6Se7fyEfz0jTSnctf/zw4v28AObp8enj5fX1/j0ulfpLJzq8qKKKfD4GKqF2H93I4r1XqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073639; c=relaxed/simple;
	bh=AdOAIb63nYpvVH6X1hDFycYa+9Vh/eNR5kJJWH0zsIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVfoe2rzESWGl/p2dChs1Irm2FyrvpOg12Uq5LkchBN2ejViWxPH05kEthc4pE5kk+KOKc/F5yobkFbLd8gtVAc2Y6FbOcjVzLUiOERTRy8EdtIT034h80GUd5TyIqrHf6XlA6G6hafbzb+IL7W3/LStBNQzvOcxPxb+AoaYCzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOoEMXnB; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olf1/LJ18d6/PMWjzPdgFBcghhYILxLey/2xqA4PnOqLBldMG5YUAxhKWlVuns+g7lyQDwKT0cBx1IqyjAR+6N84JusRlntVljSYcO/FvxW5XSVkPjVVy9aHWwumLcqDPX/Jioamr++yLLgWljPsS+A5VOiK8DmD69buo25cz5miYed0YKbtdXDKemTa1LSG1CBfDnRe+QgC8XBt6pA0gZ6j6S0ni20cgf1mVQZJMipJSu28z60BMVgRxRBBZAnOBC6TgZpVUkXU+8dfXcJ8PSv57ioz+bbLNpkZyXpAJXjAJz+67ChEs5SfNlzBLPhWsjyhd3YhzvMzFlNzfryVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=AMpFaj4SHJ5u83ShPQ8YCf9TSS/yUVAKZW6b/FQcNRk3GHGzGHwjIG2AskZjAjXvmiE1h4+RirNe5YBTX10eN/Qdtr/24bgIJ/LIvz57qq31sYoR8eOOIMULDEacqMZxY+BjV80YAJsBAmY/l5EAw4svF1diTXV9kZ/kUDQ2TLH0mfLhRQ4PplAg4ywwqjpyX+grktrfH+N+WAMRLIFJYXnzs3QnheeV3ZSIEHC60YACOE3PuYMsjV8AYLfdqk/d6ZFzOClNH4HIdMOHA6FrUtWo5o4ugbN9+lj4GEa0NKjIR2U1v8pIvSryWgPJ4wBKW8A0fb+F08TTr8j1FwLMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=IOoEMXnBiMlRIrj6llLLCBgyoG7dcP3k7NJdkpM10nc86if2TbS3IBKJ+6FjByF4WqGc2FdQOYTsYzB49LSHaOK7V6CLBodGDp6glOD0AxsNxdMhNlJ3MUnWWg8jNQD20Pd2bqVcYoJ/NafXvu0TA9ZrAEYXJrQEtOYmV+iT6jA=
Received: from PH7PR17CA0066.namprd17.prod.outlook.com (2603:10b6:510:325::15)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:07:15 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::ec) by PH7PR17CA0066.outlook.office365.com
 (2603:10b6:510:325::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 11:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 11:07:14 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 06:07:13 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Vishal.Badole@amd.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH net 1/2] amd-xgbe: Fix data loss when checksum offloading is disabled
Date: Thu, 27 Mar 2025 16:36:52 +0530
Message-ID: <20250327110653.3075154-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327110653.3075154-1-Vishal.Badole@amd.com>
References: <20250327110653.3075154-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebf0587-692c-4d75-0aa3-08dd6d1f87d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQuaikn/fQiY616art7bAk+NABwTEwFyCSalPl/2Rbj4425gYp4VMYF3s8BP?=
 =?us-ascii?Q?IDQMgQysWtnvqYR+2KdUMCbtMxdPMm5x4/StzsCuemRfXugQend7nFbAiUEZ?=
 =?us-ascii?Q?fn22TcjKUbD9S78Xa1t5jaRYRVL0ioGXDOgqv1e/swRDL5YWObSrwWg068ib?=
 =?us-ascii?Q?onSq82bjV4rAg0D8s/FEVkulSU/6HPoIGiJ6NQma21klZv6CvBLGCypWQxgW?=
 =?us-ascii?Q?8CwqRx/IWgylnp+2spJAf7m3iXpWFBGQsO4dVAJWiI/XdpCsQwd3nNANSOd1?=
 =?us-ascii?Q?HPKjCNGG23fW8sTJPmTyCJIDbM3WyALzU/+l3WJqJMRZ16KXTKA01uaWa/E5?=
 =?us-ascii?Q?I6uIUS92BJwHCbbwlIKbfqfkHW8N3G4KYVXPtmGv96nGXXNfcfpvS0ndQvIA?=
 =?us-ascii?Q?lJLWYaksmW6z6umWtw5xUOfodVUGvSO4WWJDIJkSvnh6duLL/3Em5sq3KJsa?=
 =?us-ascii?Q?Qib9VaskrNJOnMf/ZsdRFH4N80NrUkR4pUbN8Pm3HjAfiCMvPiXz/L5J52mV?=
 =?us-ascii?Q?hjvyD2hvjago+Xuq7FiOORd85UrHHj0dmQK3mWFxyIGuE7jvo3jhTLuEFuqv?=
 =?us-ascii?Q?YUJURpA5J5DQ+F3+4d3CM2TgcTK5GZONdBn4B2ZLrpq6TZaMM+jVA5BmfwHy?=
 =?us-ascii?Q?3xchnrFbOA9QsTLv3FK+p+8JHg4imtjLpO89w6mB6vaq943bGSfN3Wf7NCxR?=
 =?us-ascii?Q?eawswlasvxNnr6Caxmb6EKatl8vKUsU6G8tdlVB1qI7UYADSionN30692YtT?=
 =?us-ascii?Q?UosSu6aIoCtGcosyAUEcue0G2AGCrCZd8QjNnhPTFv3CWKTxslCo/XAWKDXN?=
 =?us-ascii?Q?NMIJbM1S+qTcovfN6PVoHPKotn2kQ7NPXgxvLcmo991Str9jW3nlY6UP+G8Z?=
 =?us-ascii?Q?9BuobjRctbMWGkzqpb6/7UhsZZG2yLCOspve9oYTuTJ8KO8rnngFotEk+MHH?=
 =?us-ascii?Q?GbIxt9O1+2DFtG5OTyxyxFodp8XtWXXcI2CMxM2uMDvb4oDRx27j0UKEOnUd?=
 =?us-ascii?Q?qFBoBUnM+ugYo0vpIFJy27+q0xipWA/Zi7Ck5vTP0gHGLTYxAEeqbcGd0IC8?=
 =?us-ascii?Q?4J2iHhWC/0eXVBIhV6IJ7qsi2oes+9DQrVpcCBUM66hWSquzjcPq5KVQHk/P?=
 =?us-ascii?Q?Kw8PuiOHlcmGH2TjgJBAZ4n1JEA1vh2z5txAPpML75fH5E0eyQyuECd17PS2?=
 =?us-ascii?Q?Fq8WrmvqTLS8iL6K21+DDg2+aq+9eAPH2haKjuh0MAQZrhjyJZQAMRUAVwhO?=
 =?us-ascii?Q?BJNJZ1MR36Vpg+pPzfx5CwKuBo5HglucUTk/YgLmU+jpKqC4i1Z5b0bOjx3M?=
 =?us-ascii?Q?8q4Obi65/U9zKXkbmaex8Wt9o5SfCeoW2+nYIR2gaecltPJzFfO4kU2rX1/0?=
 =?us-ascii?Q?QpPY9xIQDyL/0S0HAx+0g+I2goOKmmb09HDS+jDbmR455JexGXRRTxgTQisC?=
 =?us-ascii?Q?uNMsRGWpn1z6MjUl2YKC8dRP1ESv8E6F1iV6Bn7ZqNjhICMHDbnL9hFgzezZ?=
 =?us-ascii?Q?IKYYIODgwrS53+Kzb/8UULVYOmU5QNYGv7o0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:07:14.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebf0587-692c-4d75-0aa3-08dd6d1f87d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

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


