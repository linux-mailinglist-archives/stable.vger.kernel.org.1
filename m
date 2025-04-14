Return-Path: <stable+bounces-132446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B9A87FEE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB23A8B68
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784802BE7BA;
	Mon, 14 Apr 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KL8r87p0"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763829DB8A;
	Mon, 14 Apr 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632207; cv=fail; b=qbPolIIdXf6SuQrP0INBnh1bAnBM71ZO0yzIUxEJTq9rldzFFh7+HvKsBB+j5qrteAjTNUSbnD3tarSXZNJCNjkKyTA8Ti/VKERdqVNjgidSvWNTZrh+W/zXAV8zlko4uaVBfS4HFeJ0N89QFK7/ycUjrg5szBQRe3jfh7sYrXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632207; c=relaxed/simple;
	bh=AdOAIb63nYpvVH6X1hDFycYa+9Vh/eNR5kJJWH0zsIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0+IEfqxiAgq/m2gHOz1fpRtg4c5ittofzroNCwiVwtRlVdmQd1QV3y8Sxpg1mNMFgw0sdXtJz4zzCbhliSdm4TG//ACMLff8TVCYliX0IJmnqURcSIOyPWJ+F5FdjKy0MTSD4jdFU9xTn+gdgRXWDoe8I8pwXuteCYVv1aAyLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KL8r87p0; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6WG0UgOiwDL2d2QkKBll1Utl66nqwQqoQpN1Ite936oE0OBkepUFAkuFrqWiEh3aCGir35Oyb2cndTopgyBgMh9dqI/hs1tCBdYYrlENGaT5YVcPOR+0gFpzdoDjXGpxAfashsKT6FUt7WnNFnfproJhbsJrZq1mhI9Hx9jHz2zZaDkg8ao98Vs9j165QZV6PmVIZVtCKhIE8GcQIUFHPsp4tDzva9Q0gsbHPYhKD2gNjD6inamqTlE/QvJiXx54lfoL6Ux1WdC+/HEBBfMdqJHdCpOKb4d10PpIWVQ5CjUs7RZP1XP0jrzVa+EeRWGaPdrHKCnht5fvDOjBhJTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=O6P4ukHnUywh4yI5bwMrgKAGbf3cF8UulmGKjou0Vz4LOevbgKoDdJx68G8XVZ8okwVUv1rdTorQEPhcJtoWwoVQaUnm+CaTaZKR+sdEZtx3K0ZqB8rVSwP67UCiP65TlZNBkmJVDNp8bYRrcpl0Yk8aRzK3xJsWa7kHbUv70SN/ZAcPBIXbCPNs1pybJy8gpfgm5aXJWyZVf9Xmr3cnFzSEZVXrif72JEQe82/MAzPad9rkGxsU4pTZniAY7jBMgGY9evgpmumanp1y5XIHiZUOoSdMUg90iOWiE9s/OhNsBsFtyqjHtqTOZAw+V+nxbGpBwhrQh2Qf532y2bjtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJuts5a8zwFeyT9L+eToKexGTuovnyoHpLWkkTB93bc=;
 b=KL8r87p0tWIW16U7ZkMh/mtewwQb0hyJHLLzfsG7WMnC0NmC+LoJCRKqpY2hpb7Pr2PP9DIA4NQQVDhh0jm805bzMZT3tMNZE8P/wU2IF0OCixIG26Gy47eWVzWBDGdKK10jm5ovTvlULy69r1cK0xWKAKMnWJFl2I1RGxloD74=
Received: from MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 12:03:22 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::21) by MN2PR16CA0050.outlook.office365.com
 (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 12:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 12:03:22 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 07:03:18 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net 1/2] amd-xgbe: Fix data loss when RX checksum offloading is disabled
Date: Mon, 14 Apr 2025 17:32:27 +0530
Message-ID: <20250414120228.182190-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414120228.182190-1-Vishal.Badole@amd.com>
References: <20250414120228.182190-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: e90c4ccc-0f99-41cb-f050-08dd7b4c5a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SFmVlZ9YkdWC5/vrEikGwQNSLcxzGy9OKSKjHF1ziI+043XmkBG/NmOVI+Q/?=
 =?us-ascii?Q?Neq/ovTc7oGQDUd3GO1HCckkk+Ggqh6Vzo/0KD9NvXburv/oHHfg9C6oFFMv?=
 =?us-ascii?Q?keftWjuj4laMvuBAr8Db19WhsSqH+ouGPxfTQ15ZLDFxCays8vGnR9jzOvH1?=
 =?us-ascii?Q?OjZ6F2QHf5mZRuvxhkR0dKvyi/5s+A5fEMi1A1/fPdCJmUW7eWJM22dF3WK2?=
 =?us-ascii?Q?NJJTmL0uhRhov65cHmNCq8pWWcmDuAbmE+xWn2egb4G//IkRfFbRMV434hxH?=
 =?us-ascii?Q?ljEs4Yh7H3U3H4i3OkIKxlTcu4omdv5ob2dKlnyQYcGq6ONtULyOKLWRM8m2?=
 =?us-ascii?Q?oG/UfucjVnVKr1uiCBEcJRrwlhqqukMtOX0zpS9hbVyDgtCsR8il98DZS/aH?=
 =?us-ascii?Q?8OiRCY6B0ClDNJZG/Lkm/pdcnES4GfAb/UOJ6Gqjr5+aP9UMM37iqDdeCrV5?=
 =?us-ascii?Q?iFd3fzIp/Eg7vJN6yyrkzlFvVEvVn7X4+k8XH0ExdZIUpTh8mAdm75FvVcBI?=
 =?us-ascii?Q?ZnEyByvrEVuIdTMWDuLZLZRKlaznvB2MRBrgWKZtBRuIZcx3c1Eub7kXBxVz?=
 =?us-ascii?Q?/UEspOoEO2Sqy1K+XHLg1u63tNZ6zG5TCXNpYxGuA59X9PuEUCdF2xuYrcnA?=
 =?us-ascii?Q?1ThzKqX4rgBGdi5lwmBEi1PWizNj5v5EvQ8NtdwULv2w7SKM3dbztjzUwRkM?=
 =?us-ascii?Q?6pcFmYbdDw36CDFX0dU/12xHHELEHwaDpSg8A0w/6tOQjD8K61BWM+dm2Fa9?=
 =?us-ascii?Q?11cuc8xy7V2u4Ez/VVMC6SrfWxu+hBL8G5MIborLLIhB8CB5oMKF46v3Hb+/?=
 =?us-ascii?Q?LnIXsu1kEM03xukx+4iWae4oV2P9llJQ67CIz7o7j4Ac09k27mRIXaOkqluN?=
 =?us-ascii?Q?VxVlzMIBJgtec6uMrMSP3N+11lrxHgiIPMyRZvvOBMBCrGVjVq1rBbqOoh1S?=
 =?us-ascii?Q?Fu167t6oCB27OYco8zOmrHRpkYlAvHTSgoUbO33gDOaavMG7G3IAdon/5FK9?=
 =?us-ascii?Q?CmcbWpg9HficeANpzNwxhQ5z/bspiLoi4Ffu8i7oQT8s6bLaltooAEXNGdbs?=
 =?us-ascii?Q?iDQK+yU/1zF5Y5JMPj1yVw6+NmgFqlV7LUnhtYnTlXfbM4b9idnmYnc6Ysv2?=
 =?us-ascii?Q?shT6Q7HJoq1tOwo4i3MQNCKzIOZA83HoLlioGBWj1rqDmPdxq2Y4L04mJrbv?=
 =?us-ascii?Q?Hr6GpKqnfKZwuBjuVGx+MakZizLhJHsRaobIoeRnA1JrrCwuAyAeJEBGzlha?=
 =?us-ascii?Q?a14Zz57OeGkLa25+PerDzpWJMcG0VIipcfwjXbB0DFRXV6hCO3yC5C/3rmwD?=
 =?us-ascii?Q?XPIxqKsIrSPfKz2KWdOiQKEOznWLSHOgVEULd5kJyDfED3zGN4Z/u5x7aXMP?=
 =?us-ascii?Q?DO8AMkM686v6P4J+eTeNzIE7g6FWOU/26MEJ7cTtM35jMBjGeV2ITgwewe3E?=
 =?us-ascii?Q?WtfJFB3L3A+3kcA9EeVx/8UrYh+JaYTOPfV4Qbv2OPPHyO8JitzRGmUH3Zk7?=
 =?us-ascii?Q?onmLTB4X8ec6g8icGcqJj1HpC8YMycsk+Wg6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:03:22.3225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90c4ccc-0f99-41cb-f050-08dd7b4c5a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

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


