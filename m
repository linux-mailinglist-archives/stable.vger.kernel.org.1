Return-Path: <stable+bounces-126850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ECDA72E96
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1D63B3CE1
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314021018D;
	Thu, 27 Mar 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="emyof0Fo"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CE20E6EE
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073920; cv=fail; b=UdOp4rppmUQVwi/9wN1XOI23mZTY470iWEfG+cY3UqAhx8JO97UJRnGE7chCxuaomuAkq0aWv/8G5Sv9FkQJfNMyEHdUqQ+VP1J5j3MVXjc5Qwi3FCiB4oGnSX/XFhLj6E1w835vly9IpXRueTTzqcJjELG4uHPzDU6M4Zn9Szo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073920; c=relaxed/simple;
	bh=1hO0XpL6kuLd74ngTZr3K+u3Z1pcT0A3ZzMGB8F9lFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCMHKLfMuqULk340vjIHF/3PsOx8qfy2StdWpD5nSXUzldbTAf+V3TO2g3oABf5XlO4vZeL9ThmMqK4tvnatpw7EwlN6J6WZB7Gpf6ZtLnfyGlnNSihaEZ/mauqmuxuPH3H+wDlRFBp/6EysGzjgD+vzLUHRonDeW4Ch8YWRmo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=emyof0Fo; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj4QTTmv1cJhAiVTnQqzFdNlZlJCyXNLlILdNVcSmbOFRK8v5uHVd5dGVIOroyh11n3BqL/JEwBFEVOVwp86Z1pOtFYWJstk2ymbZKuhT/NF88uTXn10UmBF8ubc+DuOLlgU/OFj1INTybeiITESEuaMBNgWy1gfGZxM9eBKl1BVWxa6IwW1qO8h53E5xDZa4VTucbJbybVxQ8reMaEjcpFXFypt+kRFPEmZqD2u9hjqNAUicXvN9QPA4ssVgR5EoF1yLKMb6ACLwvgCwEmxQ4dJDrGf4rM0vwr8DKDsRwLsUY2uxAY6+ggZlgW4P0audpudOzR7MxX/0RvL452yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo0QoRtT26x4j7BLL96a2+psL5gYEwwQuZg0Be+uQm0=;
 b=rPIFisgyTJi28w69D+QHyuQ1toSlLdC/gg7/MyV4B/Oo+tRl2tle9q9E5i3g2i6JgT9+xjbkCGOVALX8HB+/05BdRnASoaKfhfup6dLxx7g/raQZt9prC25iWN0CVeRbMJmBx6gE6NDm/x7MiHoGYYo+0QdOeT2dfQkle7E65KJgg33gEMxS+06+L7dDjtjv38g0t3ZkBaWrJEd6oRtPinxZfD1LASdBsEENZGLtB8Y73OAYdnM7OdhooJRutdKg4Q1EsgUEKYekDcBxke5aDbvfUrUbkvmPbxEveSouKgPXgj8QAAsu1HqJWZ7YziQJNi+OSHis6Lydzrl6w/Rn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo0QoRtT26x4j7BLL96a2+psL5gYEwwQuZg0Be+uQm0=;
 b=emyof0Fo6ROrTcqLW7Lhf+p5O3oFx9s7HbRdxqYC4GJCRb01fbXEA7fh9Vm9Y1JjKxJeU8YCYRUDcgiokUup9/0P4yDt1G9bKsfQNZd+FvTfsezwPEwb5mt3sScq48dDIM6nwUWrOFIg4ZYGf4F+DS6xy554oXbbzSl0YsEyD+o=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:11:57 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::53) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 11:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 11:11:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 06:11:52 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <Rajesh1.Kumar@amd.com>,
	<Sanket.Goswami@amd.com>, <basavaraj.natikar@amd.com>,
	<Raju.Rangoju@amd.com>, <Krishnamoorthi.M@amd.com>,
	<guruvendra.punugupati@amd.com>, <akshata.mukundshetty@amd.com>,
	<sanath.s@amd.com>, <mayukh.shyam@amd.com>, <prakruthi.sp@amd.com>,
	<Patil.Reddy@amd.com>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net 2/2] amd-xgbe: Ensure dependent features are toggled with RX checksum offload
Date: Thu, 27 Mar 2025 16:41:30 +0530
Message-ID: <20250327111130.3075202-3-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaf50c5-e9c9-44dc-25ed-08dd6d20302b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FT2fv9pcXFLTKmeeNCuOR2V1yvEyzKWGry80vGgYoBtv4YEDM+17zl9Z42e?=
 =?us-ascii?Q?J0J43uzi9T64Az7a7VDl9rbmssUdHC4p+pPQ3xyX9TVAJxj0Qx6k413LlBSV?=
 =?us-ascii?Q?gujW6bUiSPYuB7bKuRyKZx448AID8crCxQhRMS7GmX+d87HplKtIbBhV5nzI?=
 =?us-ascii?Q?PYyN7O8lQ/Rje9/bPRCBJPNhMPOkFFHPFX6jZioeWj5+4p5sm4LHUtvF0mBy?=
 =?us-ascii?Q?3iq7XmNn4dw1YqlyHycTvp2c3SP1gFNAk7rEeP1MP6j2PBZBxGAYJutJTVUj?=
 =?us-ascii?Q?+Gk8ac3aE56GiNyC5iAqwOQr+f7NUpiRFEBMgF0b0oHPX0eFA2MRlgvOluGI?=
 =?us-ascii?Q?L72gzCo/9x3O46NErvpepC0a8cFmW5tCuyXVv94RqOvBeYG5rUYQjTxd+zjn?=
 =?us-ascii?Q?vUVJSpLzpRMCXQPzfx8hMS3NgXwjI32u8qVJtw1Ea7+xXY+GBOn2GobBWof8?=
 =?us-ascii?Q?VAx2QdoAEVBu5zl1U0Z5YrYbsZk7XvZZziz3FrRFh6D2xqGDFJt3zBtRlgJp?=
 =?us-ascii?Q?4Ll86JqmICuM9d3k+Qe64mqKbC7K2BgpCFw9b7Rikjkxaz2ZYb/AdGeoj7le?=
 =?us-ascii?Q?12pFteE2H2Xmg7evl8WbQd6zmXhntRyhG29+GYbBQMcW0FaF2l+RNY9njJeL?=
 =?us-ascii?Q?gnFVGjVoOqcd/4bVSbZyeFQwar1kZW92i3luuo2sS+VyRJKVcD59PdvTZ+Uj?=
 =?us-ascii?Q?gd6FoLZFmgh20t7YeU5/CGHv7rc5Apcu2sPzkHG5AHIzA/fneYMo4mnuKQJF?=
 =?us-ascii?Q?TKCV2CNTBgaT22aIqlEOwyUruJYT0YNK8ZdrjGuM+X0tfPJJ1oQl41DuB17R?=
 =?us-ascii?Q?FjCM3afj0e+3t7/FjdfMmCASzuoclXehNNvpBFhetcDnFB4puNXg+o4Erovg?=
 =?us-ascii?Q?rZJdVGlb/tABaj0MV8fmcER4dOSSN0IwssWTTlI6RLSVu8CfPfGdbRK3kkjg?=
 =?us-ascii?Q?2dz7y9H3JqojdR9uakk29WfX2+X/NhFcbEn2ghuf2jzJSVu/4m/Sc4eZRXZV?=
 =?us-ascii?Q?EirebFYoYVzb6FLSEBdNfVuZT3GiwlAnWCoYkWI26ZKnv1feVT2BTiKy7iM3?=
 =?us-ascii?Q?nZTTUwROekThAappJ/lndZuNCCO1Z0oqUFgo2MpnPTiAWGfHKZvtOuBcgHv8?=
 =?us-ascii?Q?1sGMYuVt+bi6uRgWOSVn8uxiwG+u0+22o1S1mM/9wiuJVbrWJ0vTXJ+2rPoE?=
 =?us-ascii?Q?27hImKIHthIwUfMJAlFgZQwOB4QSE+FOa/sDBqW2cVYt23GtS7hlU5lplj0+?=
 =?us-ascii?Q?9LV2PYXFeaDSNpwd/WAbvp0iDRc1ydhL0FhpcSCW8zwUam8PrC3+NDP4xc26?=
 =?us-ascii?Q?OeAZCfNsBd7rwMk69xj+sXr22InUfIl3fa2W1mfn/RtE6CKYn2vawjjKW4se?=
 =?us-ascii?Q?uAyebyjgfCRGU97qBwOJM1Sejwz2hUz5QC0BeThJhgh9hE2XhWUzTpDD2jnI?=
 =?us-ascii?Q?t/Z2E3+wFPJrW60loKazNCbBPYUSQhkBnYS91Sqt3+TMxHt2/fBMSSQHHTlf?=
 =?us-ascii?Q?Y2HPzeG9RpDsOjal6501qdeew9EEM+N5exFA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:11:57.0681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaf50c5-e9c9-44dc-25ed-08dd6d20302b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

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


