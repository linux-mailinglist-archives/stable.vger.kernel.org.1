Return-Path: <stable+bounces-126848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B80A72E79
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23933B4FA2
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34F20FA9C;
	Thu, 27 Mar 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CigS6RvQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C420D504
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073641; cv=fail; b=roHgtuP16qel8DLhZJzo65IJzU7jjSWfT/2oQq5ckn37hHOfKWkuSyXzjUunIkpu8FToULqDBwPS3GgPq/5n9TqYt5uNqEDks7aK4U2QFIUU+9vK2lsPe7knOd0ut9+FBMAXZ6MzDpE/0gH41W0mxR2voILsVgWBmLhbSgftps8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073641; c=relaxed/simple;
	bh=1hO0XpL6kuLd74ngTZr3K+u3Z1pcT0A3ZzMGB8F9lFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkDjIaY0R79XdfIlXnGgEy5Gt17QQDhH3Xg3zwKqABqe8LwwEUwLzLvnaf7waGIz10FPa0k7HiBIQ3bJvIxqqLGgrg77RZFsxzVqxuvKHdaC/om3CNrfYJPHoYwBMakRVv0xVrp9gsJIkA3DyWJr1XKmCGy1GyBTEToDIy6Kf6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CigS6RvQ; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6bMay4rm2FK1DIVt36pbFMEl9zWe8fUa1qFzd4xyAhqKXNgq9QA2h1MPQpQUKGctSR9n7ysz1/LCwLjwJtm7NtDI1NmTCwfJ9PW/w4DYG7fYTU1sHfaINPVaSakOtSyG/81+2KnM6m7ctCAJLuODI4/qAfa2ULwwD9CzjrFZ09Y6ODvXUVwSrqAYe904wQPE6NxM1nDwcAySB5Gs/i9T9Zx9oysJpSn3G0rlqIt/eQ/cjlwkpWgN56FwXvp75CuwSgJj+E5yW48oM9Lrl9bhkjbi5KkBP7HwSgPbGirUHY8jjIqvnTXKplq5kvgQ64NVDkAMM07xX9MEJktcY06BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo0QoRtT26x4j7BLL96a2+psL5gYEwwQuZg0Be+uQm0=;
 b=EtYtKnsOwbDHR7VMCxnIlh5vdp7ITVk0A0uJL28JVWJXchPb2R2UP+8LhZTUoRchvTCPPgRhcfkermV3abTFODMaU8d1LDXLitBlJfN3voxGElEBOYYWI/tgr+8l/UU9vS5oC0yFwFNXvpl7pjcY6zt4azhruEw4FVrnDayAjmIPPjeamSE3K0WAfflHa3M2D0s9ovL+SgWAEHTzvjTGEDsAdxPLSPAeM0ySEoIDSR6J9cSquGfl3ae2rZr0qIiQYLdx+baMQKV+WUrdRdPNWPhJmO0C4PGqtkCZP5wtZgYPuFm60jSnf4xkQemi5DGf+rBqHZec2EAP8FPnQYCZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo0QoRtT26x4j7BLL96a2+psL5gYEwwQuZg0Be+uQm0=;
 b=CigS6RvQhZFTZBG+3rwVj2kJxx9rghs6I0g2QSrxw0GAUOKPCcBTQr55pgzfz7xZONJZFwqHy2Hpi13SgKkEY7ysLNRQU7qUzN+6vCWUmhFBQw7+tBOFnKKcExDlyPoPMURlFD9DDD41K0oZC+TvnPBzD5kVlTSBaKmQwpDNEwQ=
Received: from SA0PR11CA0052.namprd11.prod.outlook.com (2603:10b6:806:d0::27)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 27 Mar
 2025 11:07:16 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::7) by SA0PR11CA0052.outlook.office365.com
 (2603:10b6:806:d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 11:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 11:07:16 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 06:07:14 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Vishal.Badole@amd.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH net 2/2] amd-xgbe: Ensure dependent features are toggled with RX checksum offload
Date: Thu, 27 Mar 2025 16:36:53 +0530
Message-ID: <20250327110653.3075154-3-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d07527-d1e5-486e-33e9-08dd6d1f88cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFMhvFCmpUL9HWMnkOmQBj4OxcPXBO/dPnsKl9p/iGxvUSMBIjW+TOoQbLI+?=
 =?us-ascii?Q?o0KgD8PDcqSZFDyx0KmNfFdgumQ+MV1Vxfbut+75RyXZ4Gw+15XIxrF9XaZD?=
 =?us-ascii?Q?vnQkFAS0Y+tVKXRpsKl22M/kTUwHMCqA3LF+csd9ygW8oofJzhUKBLX4H9o+?=
 =?us-ascii?Q?zEyyKW8I4QglY7L3FOJu8pSc6nZruIr7F6JtHvBXn1zEoMOZz2Z9IE2iNeEz?=
 =?us-ascii?Q?QW7DFOZWSdIbvWjlfW6ljvei6vT9sIttbvMjIwpZn2LWlPLyUkxsVX1pL6yD?=
 =?us-ascii?Q?pd90fGf77bF2FaC/KWyxQFGitEzDYmD6D2wTq8czg4flo+Of1K0MQGwJ552s?=
 =?us-ascii?Q?3AlSxFmVgzjkBpnabX44VQbARgwv6Ho7vzoSe4MoI2LM/L3C3L7Y3XFblFzS?=
 =?us-ascii?Q?duU2HdRJLswr47bwNpwZJWZeJS540FQi8cu/SQ+ZnhDjmfU9AC8RuZXmpmDR?=
 =?us-ascii?Q?9H72P+/VIb1JkeSdn824pzto2YRq4wLsLnrPPlg0baSMcwclr6ycVRtbDQBR?=
 =?us-ascii?Q?L/vBheu9vU0fIcmGK2xzXRm8UNA25SXl1rroeQwPFubQD4uF6ok4uI/OKMxq?=
 =?us-ascii?Q?6GPcFtrKIeeyC1wlpi8K85cfxilo1gmwsj+VFJSlQIw1CNa9WciQpqd19RbY?=
 =?us-ascii?Q?Ila0U6ntafW4xDkFYEuJ+hshQ5oOsJuIsQK6Z1dFwj6pTSkzh6Am7T9CH4iM?=
 =?us-ascii?Q?A5UtptirqVj8i+sWP+jxd0BTR0omzynP1MuJcjO424pbRijVRBepUYBnSGzR?=
 =?us-ascii?Q?COFGsTQfSSmDuIEaGqix8VuddOmA4Eogk93uwwrNdBp+LL8DTtr1SMb5JJA6?=
 =?us-ascii?Q?EqWudSoeRGU1tSMzwTau3fB0NIrQCUhouhHdgZzkOB1yQXlvGdyiq8W/nm70?=
 =?us-ascii?Q?ztfTiuHSnxlQNpET1JoU03zp2aZFWyiQBj/Jltk7dcb+8ZSabVwmnw6Y0MfX?=
 =?us-ascii?Q?JgYjtvH+FRDwRIAkTbh6sG+kjX6E3Pyx3xd+6gkojD5kbe9U1WZ8LnVCk8mb?=
 =?us-ascii?Q?6u/OcWwhL0s3v6Ev0gasS2qZQXkQoqoCEXEUErp9mrtRAFedoZf/uae02TON?=
 =?us-ascii?Q?0tYqCiRpgX86/qp5W0PLFvQGRR76SmQxryh8EvbE1X9+CGKC5sihhpqffgA9?=
 =?us-ascii?Q?Wdo8eZppgVGQR9AL/KsT0G3+yDs1s94r1Dih+ep0p/Qgj9M1IdF5yk9zznrf?=
 =?us-ascii?Q?nRzHPZnzin6y4vrhEZFE0tngkrv9Z/SSMz4YVLV3VheefiEGvpDSZxHQR6lz?=
 =?us-ascii?Q?5hywCCf4rlwRLxq9Xva6Mb9g43BSNlfA+lHUv9F/LYWguAxbeU9CbSZAwiA1?=
 =?us-ascii?Q?1jAAiJH6kdNEJFewWDFYaQuI0vzqLcH74VexPsjmnskS06/BA0yHcN5LM50f?=
 =?us-ascii?Q?nGXUvON9sL/Hc5rJFBxUZfIG0Vot0N8IhRGND07bKKaZWsKsNx+T3DHL/hRp?=
 =?us-ascii?Q?RXL4OWEDuzp6ysls8tNx1bRLYGocvnHoyGi3MZRy82Z/TpB28+5HYZ5yXFeK?=
 =?us-ascii?Q?IiTvOunorJfuKJk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:07:16.2285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d07527-d1e5-486e-33e9-08dd6d1f88cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467

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
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 11 +++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

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
index f249f89fec38..d7c192d9da2e 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2290,10 +2290,17 @@ static int xgbe_set_features(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+	if ((features & NETIF_F_RXCSUM) && !rxcsum) {
+		hw_if->enable_sph(pdata);
+		hw_if->enable_rss(pdata);
+		hw_if->enable_vxlan(pdata);
 		hw_if->enable_rx_csum(pdata);
-	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+	} else if (!(features & NETIF_F_RXCSUM) && rxcsum) {
+		hw_if->disable_sph(pdata);
+		hw_if->disable_rss(pdata);
+		hw_if->disable_vxlan(pdata);
 		hw_if->disable_rx_csum(pdata);
+	}
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
 		hw_if->enable_rx_vlan_stripping(pdata);
-- 
2.34.1


