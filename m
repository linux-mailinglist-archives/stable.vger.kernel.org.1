Return-Path: <stable+bounces-132447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4FA87FF2
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644F73B3331
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A292BE7C1;
	Mon, 14 Apr 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DeOr86lZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984B2BD598;
	Mon, 14 Apr 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632209; cv=fail; b=Lzhj1YMorDTVrVlHMrzNQu3NK2MplJu8MhC34X68B/Pmg4lVCKkiULzf1wnmR5zq3E2yTpgVblquFbQLipScgX/4TY+iYADWSxFUSgdnfIfNVaEE5eOSMmICHlm23FV4pBcc/U3d9ycl+HEWD86oBiROH1qaLw2grpFuuN2Lhqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632209; c=relaxed/simple;
	bh=GLRXkkfneXcnkhkWa7JJWhdjVfINz2a03COLbIiAbxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWJuo0jSa7A0VbY9gNFp6QoFjtZZNYvcWfZNSTOz8JDpugGeRSYQEbUEjDrlEvl7DmEhLX42VW9CjFQuKKee0n8M6cDKxVODSq0yeCTo5UC69Zz35SyW+JUYNbx/33vVjUugaNGQ07PYeqBTvBKjn0fLxX7xVw7xvPeecLEKWJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DeOr86lZ; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdJ/R0zAr9urFfrSGflOlSAaq+HQfTYbZktZCl/aYu7lXk+ZIeFJmO342l8Vka4aYFLQYkDo1ZN22VkfQmva4NK7DOEZsfvrmf4tzKipq7n8NKEDFU66YzmkgrbiJnfkZlRKIC9F6lMCEIFtio2dB9wHwYM/Spyg/4t4mpYyAQ/hVo7AY66V9wiliPFXK8TsoeZTBas/iqKadl4YivfV6jcepCADfCmrCcFKo0TpG4/H+2t00wxycUK8N1nXWE0a/u5kBOL8UQLJkYN8Ffq1CF7GkNMMldaDbWUPxY9I14ehRA3lRK2ErP/ceBf0icuYVf61CewA/3Mf5fNpR2fJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydmCh2KkKYvAaThkc3Bvh4ZWGfwUTZw0BD5omlqmf7c=;
 b=fnIjf1Onbqkjw412JGF3elCib/VzYd+Eh2c0Vqwe+B307rtY2+1A0qr8gHs/f41ix/nFlxdgIJcmiWnv+RpEiRh+nILG8S6Gcclj74apeILiJJWuH8JBr62SKO9rs+d0yQ2JxcF7RG44rH+G7t2wOoF1ctOhGsuZ9EwdqVwrrac4HBLScOplHVMJKJO6a2iLO9sF3KApufUKph8SL8FP+lfWQckcbhjDTCCwsn4arpGBMkDoIAS0tm41ZiSAm4T0wMMfbja/NKlA2SnOkRz/6BdoRholJFw2cGjszMf6VXASgVLUPXwaFesH8bhppyKmv4J8Ejf9mEyf/RRuacS/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydmCh2KkKYvAaThkc3Bvh4ZWGfwUTZw0BD5omlqmf7c=;
 b=DeOr86lZET0N1IHJek0IB6VIy6cRzW/qO9NB0A6Kvtapzss5FW+NvMn27OdFqZuENtICLQ1SEOTHeM5lpn4dv0d4FwJ9r9w8tpbqU4mJftqzfbDhsld0YVFZVxR/M5XaIaKOCj4NnBCL89uj6Z/fVH3fi6SGa1a3MeYLYr317qU=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 12:03:25 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::f6) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 12:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 12:03:24 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 07:03:21 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net 2/2] amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload
Date: Mon, 14 Apr 2025 17:32:28 +0530
Message-ID: <20250414120228.182190-3-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: e682fbc8-f3f6-421a-5db7-08dd7b4c5c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48KclsQmtl8Y++LNDXx1LzLGKHvSz5y6mWs4aQ+OzMzYei05YZrEIWs0cXAZ?=
 =?us-ascii?Q?HgD1XvLpcwLI6vV0jgb2Aa15jC37AIE9Hg1qiUZKL4FwZzBh/SVxul0vASJE?=
 =?us-ascii?Q?ZvFLYzR1b6vAcBPeQSE54Lide4mdPo7LzsWGaR+CbmV//ZQDYBPBNalKtk4C?=
 =?us-ascii?Q?iIRPeePsC5TPng4y9UFI7gsPR/8yc23rgiCYDN/qzwe4s29wBbMxqQtQUJBX?=
 =?us-ascii?Q?xR/ygz0VMDyZNkwlFFgnGJcTVxvLnrlS7Onv7CtElLCwergg6nhnC7WYJY3N?=
 =?us-ascii?Q?RgNBDq+dOrvJBMyz6qhvLTnAShrPP2qDmo855uWR4M9I1Z2J7WJYT9QbEbhQ?=
 =?us-ascii?Q?pSw4T4S4OlabiTnyK96LyMbVFALBQEHUEPI+NlHS9g+waEgXt9Q1dHh/MBYQ?=
 =?us-ascii?Q?Xn2CtQoZ3VAuNduQn+JocZW9tLHCYKMnchmwCxIF8ZvjDrvN8WpMsuDauIfg?=
 =?us-ascii?Q?6AwZsbhQIplK1dPZXG7cHFT65YgDqGAYgHYz2qNETWHQyWTzNiOX9X6zEo/x?=
 =?us-ascii?Q?Hd3v86QuPBFOoSdiP9ZU/EksWl81pOFKYgBhx0Cdg3vw1t9ROQj2KZZQGqCc?=
 =?us-ascii?Q?Ugj5AFeLII4Tj6n9DZMis6mI1B2hZQnYvx4UdosWOoCtCO5r/rTjXHNhvFhN?=
 =?us-ascii?Q?XiGm1x5XYoMZ+jH2C5YQRZlI2S6SegdNQ91i1J5AQAaJJjp5SOnQA3uJBpod?=
 =?us-ascii?Q?I6mcKR2qSoalRPWHiEDe0TgBn3UoABo0tjdHmXs2WntE10VOVTKJ5b/atwNN?=
 =?us-ascii?Q?N2n76hf8vRCv0MuV/QXBKQVi79MqtYxrPXTmxVt7VDbcW31dt1g0Qbg4/QNl?=
 =?us-ascii?Q?ETW3JjlH+WJl09usKLund/QVSiHECX+E68y5fdKFu0gtuhLaURzvkHBHJ8HM?=
 =?us-ascii?Q?CE1fqZbZ5fE+8wJuM/1PGHlI9NjYw3Q27dhn2CxytyAkLj5NFMAJXSg9Q+bc?=
 =?us-ascii?Q?HfQh9aatRqqs7vVCizleByihq/6w08vODxO4qIcqpBRxut9rQhiwXBqsrvpG?=
 =?us-ascii?Q?tyIyxRLshbTALZX0R6O6QSHi9xIAFRW6AX6yR66B7BE2Fhk8e9TcYyXVXFco?=
 =?us-ascii?Q?o9J1dZiMndkV3rq/3gsSp6qAZXe5wVYzl7j0KhI9BWRnRyJBggwbYmy+JCUC?=
 =?us-ascii?Q?s7Q3UKY/y9VV2RrNy8+PDSsOzCA/yrPC5syElGvCysXxUA81x5p/b56bRqgN?=
 =?us-ascii?Q?pY0MhEyyGrxLjg1nKVe8G2iTsl0lvy78AMmu6DqySj2sgrhUhr25WjYbyisz?=
 =?us-ascii?Q?b4VEH8jBsTPGVeNSCUnNsNH2qfb+mL7AwPnx/fM0PCpeBVo18WTuDoeZmgIN?=
 =?us-ascii?Q?oRbIKi26JgXJNCmayLxKhtEi/gax7Xj/4xSndX/x3qsLklAdiJS91jOtn7Vo?=
 =?us-ascii?Q?r8O37FOHgqt3ni9ki9ms1Z7jFBIjdrb8HcF3XwoJkViQNjqS94YBTW9SlP/J?=
 =?us-ascii?Q?B8STUISB4FNRgOqaYtA3dOMPyjP/4mk0omxYPgvWgpY0Jl/uBsyWFjG1YtaB?=
 =?us-ascii?Q?Z6QuON7eEnbhKw6Ri4s2XPn5GP/hn3Qw4o1h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:03:24.9874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e682fbc8-f3f6-421a-5db7-08dd7b4c5c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

According to the XGMAC specification, enabling features such as Layer 3
and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
and Virtualized Network support automatically selects the IPC Full
Checksum Offload Engine on the receive side.

When RX checksum offload is disabled, these dependent features must also
be disabled to prevent abnormal behavior caused by mismatched feature
dependencies.

Ensure that toggling RX checksum offload (disabling or enabling) properly
disables or enables all dependent features, maintaining consistent and
expected behavior in the network device.

Cc: stable@vger.kernel.org
Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c |  8 ++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 429c5e1444d8..48a474337d96 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3764,8 +3764,12 @@ static int xgbe_init(struct xgbe_prv_data *pdata)
 	xgbe_config_tx_coalesce(pdata);
 	xgbe_config_rx_buffer_size(pdata);
 	xgbe_config_tso_mode(pdata);
-	xgbe_config_sph_mode(pdata);
-	xgbe_config_rss(pdata);
+
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_config_sph_mode(pdata);
+		xgbe_config_rss(pdata);
+	}
+
 	desc_if->wrapper_tx_desc_init(pdata);
 	desc_if->wrapper_rx_desc_init(pdata);
 	xgbe_enable_dma_interrupts(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f249f89fec38..0146af7f93cd 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2267,6 +2267,16 @@ static netdev_features_t xgbe_fix_features(struct net_device *netdev,
 		}
 	}
 
+	if (features & NETIF_F_RXCSUM) {
+		netdev_notice(netdev,
+			      "forcing receive hashing on\n");
+		features |= NETIF_F_RXHASH;
+	} else {
+		netdev_notice(netdev,
+			      "forcing receive hashing off\n");
+		features &= ~NETIF_F_RXHASH;
+	}
+
 	return features;
 }
 
@@ -2290,10 +2300,15 @@ static int xgbe_set_features(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+	if ((features & NETIF_F_RXCSUM) && !rxcsum) {
+		hw_if->enable_sph(pdata);
+		hw_if->enable_vxlan(pdata);
 		hw_if->enable_rx_csum(pdata);
-	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+	} else if (!(features & NETIF_F_RXCSUM) && rxcsum) {
+		hw_if->disable_sph(pdata);
+		hw_if->disable_vxlan(pdata);
 		hw_if->disable_rx_csum(pdata);
+	}
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
 		hw_if->enable_rx_vlan_stripping(pdata);
-- 
2.34.1


