Return-Path: <stable+bounces-136581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6BA9AE5E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC904A33CE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA5128467F;
	Thu, 24 Apr 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMvtRc+L"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43592284685;
	Thu, 24 Apr 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499801; cv=fail; b=u0y2/D8oKEp7x6dW8iIKxprrSoMHBBx2oV0TK1J1RlVzSXX2E/TCoOsb5llEHUt4GdvA1S1cXukK0etYStbYXvQmxsf0Wj8+R0YDqqGuI9+3/ZUyPK6v1NNRS3HQ5LdUiIDGHnX+Lg7fw8M0T6ZM10f1AYXHtE9tUN7/ALUvIHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499801; c=relaxed/simple;
	bh=y9CFPGYTuzMIYsXXod8hLPnipZFOc91+9abstXqF5Uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMm24P4sw6dSVP5vaMbE1MqjLV2umb7FvW2soixLU8je1/8eJkvnSFvNtgPqbFf4aHbWu3P0NKt3kOV4YWulEVA8tFRg2B2Pj5LeJPzp+6C1+iBMKg1dT/rcphKA0OfuPhQ/lTa44S0qd8+k/qsUKIlZ1k8ZO3P2ltrEewNIos4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMvtRc+L; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es5I4kJnD5co9Gr06OEpEaVXNnidJJFeNKqUd8wey5m83C8uf9HebVhaoWbnqAVG0h1i6hR4Usz+GAF/TSIWA5YAG69Fr8d6zO6LpsaMqYU+1AH8NA8HK9kF+kbKh0cqyc6s4kPjbCR+Y/okYcEIa1AMyByMiZ5fp8AXJ7JPz3jDzG+HKD5OJ3RphVc6YFE7A8nzrepJYDlhOA3ZyZkIOxW4NTuy4AjXfIibHZhBJ+dS4tTujUKp6jXaD0dZueAPY1Ztm21+QL1NwAqrrfBd8bXu1TOWsio8DOg3xFXz718HRePT8CwsG9ZOSktczdjKl03daLlGwVmmrBh3G5rL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBusw4xQtG3EwQY2dz0ihgBqHBL1dgg2AkUov+Um1zk=;
 b=KIvOETDHmSEBvTvwNeezCpD1wLuPuaERLOeDBohDfD8hjvnphjTbcQ4ogg0Ty4uenYMADWNM1Bjghy5s6WCgpv4iYQBsGq6RW3VsB3zg3WCH1qlKI4WzMUWrC+53vJ4yjofNoWz1rVYmzN4/jBpjQ42BwDF43SDsZUQ1qbUQdp8+CmaQfHD0WC/Ma+fzyUeuJFjB6ViD/4HRSBdiKa6x9NsCp0bkxp2nLMrwvXeY0XnL/FRtjjEmkVjo5N3zHZGUNq7K8SwVoMq5gB4kS0tkhL4gNhMcl5kSm+f4x1mPjtrqiCSXhQ92PAp3LWu73yuN3ZNaxF65yuWJcB4YvmxgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBusw4xQtG3EwQY2dz0ihgBqHBL1dgg2AkUov+Um1zk=;
 b=SMvtRc+L+ZvvKMbwmiUCpgVR7tu1uRHpxxZZaMXbw7ttkDDijgzu/aijEqBPEniWaVdhuWnpSMi75xNVDrO2J9rIrkiT/HmLizYlgJNRCUXEtSN5yXyfUn6yYb2uT3GnEf8Q1Fc9It1Xhq83kxtnS+pGHz1NyjM63xLqCGxcGqg=
Received: from MW4PR03CA0339.namprd03.prod.outlook.com (2603:10b6:303:dc::14)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 13:03:12 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::a0) by MW4PR03CA0339.outlook.office365.com
 (2603:10b6:303:dc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 13:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:03:11 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:03:06 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <vishal.badole@amd.com>, <Raju.Rangoju@amd.com>, Vishal Badole
	<Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net V3] amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload
Date: Thu, 24 Apr 2025 18:32:48 +0530
Message-ID: <20250424130248.428865-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 91464f90-f88d-4517-95a7-08dd83305df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2cGbRAeLtIpyKzBp/MU0+LxV+R1u1y4EJDdpBc+b44KNv6RfvanjjDTLIvJ?=
 =?us-ascii?Q?Fq8my8Hwz3+YN8KP/SFOkgEGdsMZgy42hrhYfkHzG4UEg0+fLr9+f5PNv/4G?=
 =?us-ascii?Q?yRVLw/Pn+f3d6F1QoT/iT4wEPbxwyHT//WC5masY7Ffyb38VVsAXgg5eMs+E?=
 =?us-ascii?Q?tnDlzqXUbKV8Oc3Xc2m9N7aYkLkB/dXhuz+chN5S90d9dVGg8ilx2VTZQDUa?=
 =?us-ascii?Q?FayELl5z1OSoePWSSJ2it959IwhV7DG5YJRNaRUQhaYu04ZGlv0n3AME+uE4?=
 =?us-ascii?Q?bPpYme8poMuu4reP/LlKzUg87dLiJDWFOYkJNBiPD0egoyMWsABHbegFn6Wp?=
 =?us-ascii?Q?fmc9qPDnnmpqCybQBUVbeEl7dmp80p3IUckjfhhs+tz6EJqKY+EfG09FwDMl?=
 =?us-ascii?Q?RGmmQXbpc17VQcbapMvM8vWX25C7E+ffQhF/x8qRLv08QsbIUEqB/Qtg6wG8?=
 =?us-ascii?Q?YV2+ajzc8ja8bPepNrfuIXD23xNxYAe1SDBUqdldGGLAl2L2oHalzNDtdHGj?=
 =?us-ascii?Q?15DU22wRgLn7JQNEsyFBUli8iq3iPln0K6qs9CMmu9r+l+UEM2ARpCBG6rTq?=
 =?us-ascii?Q?H1ISdJFmLu/a3VRdgAm0bLZnNmGrK6qXWk0AX2wsB1JfaY7BXTyKdGJm9Eol?=
 =?us-ascii?Q?NItywj6DNCzdqGNdiG5DSgB9oFyYCeUVe2GwiPrCoxf4S+sWOlR25eyHcO9I?=
 =?us-ascii?Q?670dR7+tFsbkxAFBEm8S7EvYoq5uW4nfPECN0xO6qXI0AmQnbLpp/0nz6YKN?=
 =?us-ascii?Q?yiuOtA+gUU8uOQLWn0QrQfaErqghm8qsODlLG9Q7cGLltM5ONqnqyLD0UOWF?=
 =?us-ascii?Q?Va4ET2+0seRt5yLkEKMu+F/ZN6RDLi+oPVkvlnTcncEvgMFAZTDtWCZCWEET?=
 =?us-ascii?Q?kUd0TtdUuub8pSDVLtPPfgIRhI5u4hm4fGp9i51Of4zgtNVeXGPjT3JlopGj?=
 =?us-ascii?Q?l3vGFnrifGExeaiP7YCJv34coMpURlrzNw9AeXC92gdqEnIEQR1wk7FU5Cnx?=
 =?us-ascii?Q?WtPe4Fdb4V+9t5g7XZWhsgoDO+7awJejRC3nHB8pDi6a3JmjdTuO9H6GeZCl?=
 =?us-ascii?Q?yortqDh6ISJWYDTWflhZps9Oiv5lHT3UV7GpZ/wje7pQLv6vdQw4bKaFQI/V?=
 =?us-ascii?Q?bgvSw4ZoMLX0+oVJNNprJ/fH8KdiPLhMp5ECVWt2YTSPZpzPoDOzWO5daVHh?=
 =?us-ascii?Q?nSeTBHINxOhfZspaQDGBbKJsEz7NkRA884JlUQf21zeEonXw0oaC2GF87pCR?=
 =?us-ascii?Q?qzAIHrNMixXe8uNBum3zNkllzaUo5HGsMA8RnQsGgha2BK2MpLsCPz3QOrxf?=
 =?us-ascii?Q?VfkjnTBcwfUWcTHu7cIIvvh6Ayg3ANXO86uSP1tpzkYiwpcVuhgol50VdsSm?=
 =?us-ascii?Q?GSacrSZqYAk1ZAbAhyStfWMaoYLHdNla3ECJ82YfEFnY5kOEG/UqcF+bry/H?=
 =?us-ascii?Q?Uf4QbBg474g9ZvL0JKvWmPcj146rbw8C5PA96axiKw+rrFk5OBM5gCzYtBU+?=
 =?us-ascii?Q?iMIy0mNr8zPb6zHyJy7xYt+PBgbGw32ZxvCS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:03:11.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91464f90-f88d-4517-95a7-08dd83305df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

According to the XGMAC specification, enabling features such as Layer 3
and Layer 4 Packet Filtering, Split Header and Virtualized Network support
automatically selects the IPC Full Checksum Offload Engine on the receive
side.

When RX checksum offload is disabled, these dependent features must also
be disabled to prevent abnormal behavior caused by mismatched feature
dependencies.

Ensure that toggling RX checksum offload (disabling or enabling) properly
disables or enables all dependent features, maintaining consistent and
expected behavior in the network device.

v2->v3:
-------
- Removed RSS feature toggling as checksum offloading functions correctly
without it

v1->v2:
-------
- Combine 2 patches into a single patch
- Update the "Fix: tag"
- Add necessary changes to support earlier versions of the hardware as well

Cc: stable@vger.kernel.org
Fixes: 1a510ccf5869 ("amd-xgbe: Add support for VXLAN offload capabilities")
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c |  9 +++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c  | 24 +++++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 11 +++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h      |  4 ++++
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index 230726d7b74f..d41b58fad37b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -373,8 +373,13 @@ static int xgbe_map_rx_buffer(struct xgbe_prv_data *pdata,
 	}
 
 	/* Set up the header page info */
-	xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
-			     XGBE_SKB_ALLOC_SIZE);
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     XGBE_SKB_ALLOC_SIZE);
+	} else {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     pdata->rx_buf_size);
+	}
 
 	/* Set up the buffer page info */
 	xgbe_set_buffer_data(&rdata->rx.buf, &ring->rx_buf_pa,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 7a923b6e83df..d0a35aab7355 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -321,6 +321,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
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
@@ -3750,8 +3762,12 @@ static int xgbe_init(struct xgbe_prv_data *pdata)
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
@@ -3910,5 +3926,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->disable_vxlan = xgbe_disable_vxlan;
 	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
 
+	/* For Split Header*/
+	hw_if->enable_sph = xgbe_config_sph_mode;
+	hw_if->disable_sph = xgbe_disable_sph_mode;
+
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f249f89fec38..51b4adb8a404 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2290,10 +2290,17 @@ static int xgbe_set_features(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+	if ((features & NETIF_F_RXCSUM) && !rxcsum) {
+		hw_if->enable_sph(pdata);
+		hw_if->enable_vxlan(pdata);
 		hw_if->enable_rx_csum(pdata);
-	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		schedule_work(&pdata->restart_work);
+	} else if (!(features & NETIF_F_RXCSUM) && rxcsum) {
+		hw_if->disable_sph(pdata);
+		hw_if->disable_vxlan(pdata);
 		hw_if->disable_rx_csum(pdata);
+		schedule_work(&pdata->restart_work);
+	}
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
 		hw_if->enable_rx_vlan_stripping(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index db73c8f8b139..92b61a318f66 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -902,6 +902,10 @@ struct xgbe_hw_if {
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


