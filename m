Return-Path: <stable+bounces-112127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534DA26F1E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98421886060
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1132080C3;
	Tue,  4 Feb 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxIQGtXx"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444D207E16
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664035; cv=fail; b=bbQlnwqUnlFl0EAzrYeVC6AYbsoE5NEskkOXLbRnomCmYC7OtzvTjkl0HCT/C+5T/KcSqlj+knVCMno9BRka4DC8CTSWuOMYWLn9I2B7C3R62MMPd54U7P+HsAFoncpeobwJQ98oAOh68DnWESkp4QzIMa/PKkP9oG+G6+UPuUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664035; c=relaxed/simple;
	bh=zE91o8bOx8ni2Xwou47K/Q0zRINu3fQhQfizO45s5Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX802IwptqoDUSgiQLNMBFTDvA21KfhlxWmhkHEztCM9N+uclFoAvlvOkW6c4LsiYQCOLxR8l0ZpSlMFUeGII1OlyfAwn83v00uFvmKhg7X2W8ECwfZnDZOKOn8wNEdu+3TFP3Tw5IMaBuQ4EG4ZvYRGylOQ7q5f7fviarQoT4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxIQGtXx; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKdT4W0ngBLfcpdEAM03OSM2WKi9xgCl/WyqmpEqYox9cYuivTHjQl8xpAhA89wdhj9WKm9Q8Bqor2Nj2Mv8QW25pevCY/ZuJvScJpmwRwkx9FBjyGnTknWBDnhWuSWdIUw+2JKOWp+P0Nh++59P2w3L2vOSHJcNFxW0ZhMXMxYA9l+46nzpYpcAtK62oNfHIIt8UdO42NwiG49AcM8UyA4UQpYkwGWsVLfw1Z36tesbF3/kUFCWzicendzdfYU9iQVLdxcIx3sLC2StcuPTcgTIIoDoc2emC8wWDl/NOInBkYC/phtlgTSiluKjGTqO8mxpKogR4uKfWCZJpNyPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsNyRCnJaBXTGdvB+w/lpvZmvBiEZmsAnixViBN9svU=;
 b=KF7976LmH2iuMsV+suzVXDXr3+c0TcofXVA8WC9selWyLB4y88mSHvNUjNQe2l+o5ElYWbKsgYDfhyQE6EZ5CyZnJgXeQV63vOxaRijykMcFhc7IkCu2bS0b9Dtf3AThjk71AJAcQT+zJp/+QEMioPrkry3AZcXuYp62W6lqmo++55Sme+X7uPpueKVHOVgz857qu7ZBrRSXd1rAmAqPUkKW4Xy2XrEM+xn/pTrDU9DuX1Fljztl7U3440+I5BzNPfM64o0Hr0/1WAku9RDGkgFAn3yZVKhk2c4vzCfRP3wOLUQOH/8+ruL8XXXRD6R6v3beFbsCFd27aIO/c7bxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsNyRCnJaBXTGdvB+w/lpvZmvBiEZmsAnixViBN9svU=;
 b=oxIQGtXxf70pQ69Ti6LQSxZHYxGvENF7LIF8PMX8uWosONN/gWojwnCOkshEnfqA4hF5apfkSRbmGonuU3wCP6Ya/7uwzX+J1NP32HBLuTqpbVfq99iQVCkMTIyHdld9u9L44UwyPGaVKlvyZNE90o4wtiNj5NihMmYjnH3K6W4=
Received: from BYAPR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:c0::48)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 10:13:49 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::8e) by BYAPR05CA0035.outlook.office365.com
 (2603:10b6:a03:c0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 10:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 10:13:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 04:13:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 04:13:46 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 04:13:44 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <stable@vger.kernel.org>
CC: Wayne Lin <Wayne.Lin@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Jerry
 Zuo" <jerry.zuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>
Subject: [PATCH 6.12.y] drm/amd/display: Reduce accessing remote DPCD overhead
Date: Tue, 4 Feb 2025 18:13:36 +0800
Message-ID: <20250204101336.2029586-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <2025012032-phoenix-crushing-da7a@gregkh>
References: <2025012032-phoenix-crushing-da7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ab8d3a-15ab-4890-098c-08dd45049dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4lxOPAbsqB8uabTXgga506j0bBAUThL8WNIpeINHpWSy0iD93Q9+encI4SG5?=
 =?us-ascii?Q?BaiUBifQYGzM+TZKJIuKU0NFs5ulxSUEiIeQ40RrCKjNshz17a+qmGn6jek3?=
 =?us-ascii?Q?kYymSShfiLOATH+AIK0qFdzolcwH4YXFJprbW4I44vqKPF/7tb6gFD9M984O?=
 =?us-ascii?Q?VxiaLqjzUkOvd6FsebL+TT7a2w8jNJk3agONgNCauOZys7P1v1ovUzLFwIf6?=
 =?us-ascii?Q?kIeKDfqHswO5gThZDVfcIC0z9ay+jG0dHgSZ8MFaBs/In1ntjP7q3EI2OrOe?=
 =?us-ascii?Q?1dK3Mes+QbZs4GEVlFXMtc0jQNhFZdD1UtFbPn+YhOrHMn2jY2X5J3o+gKzO?=
 =?us-ascii?Q?JiGXyWUh0oexr+3Di5tBilQSzFx2uV/Zpdphi5HaEOWqnC0u54H3qQGe4Ki5?=
 =?us-ascii?Q?fmWkyS2KGGy2v83fV28KiRh5uIUxbAYsqZCfgsEnrnywakWCBRimcqBduC5b?=
 =?us-ascii?Q?GVuorIv0aJlXieMG+HsXLb1g0eF93DUFGhxTYdWGg+X1ZkkhCEQeDUodZ7Kt?=
 =?us-ascii?Q?bY/Ce99jii2C08/zHgl/jOicQUfd3zDjwk4XwxDmM458vNYUPG7oTtF+idTN?=
 =?us-ascii?Q?KfKn5rzgbEGgzsSx4K76h9QkMsed2vOsQbWvTc1jDGDJ2PLjrPfIAK+JgEec?=
 =?us-ascii?Q?aSRbB5+nndhngIYLabizhgc+frsvlKg4/hjdbYWP1UqXlgsMW9I6B+B2tJof?=
 =?us-ascii?Q?YexEsz731+rO9aplpGjqCJyJSBlx5QsJ/A+eVOsqhCox3glo5QPpiWQ01etl?=
 =?us-ascii?Q?8O78Ek84U0Z7QjY+2jtavhX3z8bj2bJln1d6JWKp2DOLrU4SkQpA4OXeMHL/?=
 =?us-ascii?Q?MIGadfjCvboKvTBSkK+AerCRv9Sdf8H4apmScqavp+GdQjqRPnZLGTWL7Z5X?=
 =?us-ascii?Q?1hKTZZno+ThjXk6NxgjyQ98wJQsmx0hecoC49+VD0YhsKY7NkAWIZbi7BBT2?=
 =?us-ascii?Q?V6rbb5Ni44uxWPruMhmuQIS6EqGUR0mU2/OEGkojTY0xEHFe69RRD+U4bI+j?=
 =?us-ascii?Q?BgZRqp50qja0KSkwvZvHNjPFSWVivfLlxlEGO+7yHSFwtyu97aQF3zHqxcCG?=
 =?us-ascii?Q?339efn4Fwcm9txewLY0DIYKoxm8Jzu24DvaWZB2g7Hj1Rc7rWVeXRDTiUqCT?=
 =?us-ascii?Q?Xn75U7RrCLSmFcjoeDkX5XoyClWZqnowP2RuMix74TJtVckTFcKsDFeOnm4M?=
 =?us-ascii?Q?oYsb8W7aSJYqSeDnlYHcpFYEige/nIFEiq963slpJdaHpnA/NigcD7H7oI4X?=
 =?us-ascii?Q?MUKsLYYl3WwSpxBubCkUc1eupomwNtq/0dfH8WCuWU/LgFDJ+5T6/CbF3y3F?=
 =?us-ascii?Q?LVLSc28zufdcjhavhmnRnFlY10HyL5S3h044s5a+e5L/yEU4lONoTwtpmsjA?=
 =?us-ascii?Q?jO7f3dYCzXwvNcolFYndFjx2lt3eBZ8MhZFFNTIQ9E7tQfRR8iZacd/2PZI6?=
 =?us-ascii?Q?kVn43/FLVBg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:13:48.2530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ab8d3a-15ab-4890-098c-08dd45049dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

[Why]
Observed frame rate get dropped by tool like glxgear. Even though the
output to monitor is 60Hz, the rendered frame rate drops to 30Hz lower.

It's due to code path in some cases will trigger
dm_dp_mst_is_port_support_mode() to read out remote Link status to
assess the available bandwidth for dsc maniplation. Overhead of keep
reading remote DPCD is considerable.

[How]
Store the remote link BW in mst_local_bw and use end-to-end full_pbn
as an indicator to decide whether update the remote link bw or not.

Whenever we need the info to assess the BW, visit the stored one first.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3720
Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4a9a918545455a5979c6232fcf61ed3d8f0db3ae)
Cc: stable@vger.kernel.org
(cherry picked from commit adb4998f4928a17d91be054218a902ba9f8c1f93)
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 34 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a0bc2c0ac04d..20ad72d1b0d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -697,6 +697,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *mst_output_port;
 	struct amdgpu_dm_connector *mst_root;
 	struct drm_dp_aux *dsc_aux;
+	uint32_t mst_local_bw;
+	uint16_t vc_full_pbn;
 	struct mutex handle_mst_msg_ready;
 
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 3d624ae6d9bd..754dbc544f03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -155,6 +155,17 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 	return 0;
 }
 
+
+static inline void
+amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
+{
+	aconnector->edid = NULL;
+	aconnector->dsc_aux = NULL;
+	aconnector->mst_output_port->passthrough_aux = NULL;
+	aconnector->mst_local_bw = 0;
+	aconnector->vc_full_pbn = 0;
+}
+
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
@@ -182,9 +193,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 	}
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
@@ -500,9 +509,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
@@ -1815,9 +1822,18 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			struct drm_dp_mst_port *immediate_upstream_port = NULL;
 			uint32_t end_link_bw = 0;
 
-			/*Get last DP link BW capability*/
-			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
-				if (stream_kbps > end_link_bw) {
+			/*Get last DP link BW capability. Mode shall be supported by Legacy peer*/
+			if (aconnector->mst_output_port->pdt != DP_PEER_DEVICE_DP_LEGACY_CONV &&
+				aconnector->mst_output_port->pdt != DP_PEER_DEVICE_NONE) {
+				if (aconnector->vc_full_pbn != aconnector->mst_output_port->full_pbn) {
+					dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw);
+					aconnector->vc_full_pbn = aconnector->mst_output_port->full_pbn;
+					aconnector->mst_local_bw = end_link_bw;
+				} else {
+					end_link_bw = aconnector->mst_local_bw;
+				}
+
+				if (end_link_bw > 0 && stream_kbps > end_link_bw) {
 					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
 							 "Mode required bw can't fit into last link\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
-- 
2.37.3


