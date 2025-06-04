Return-Path: <stable+bounces-151458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887DACE50A
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C898C1893D94
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014422F164;
	Wed,  4 Jun 2025 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4E7Ae6T"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876422D790
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065877; cv=fail; b=S8ndA1rF2QF9V6N7MyIfvxw5Q9MOkwbTh2R36E7DEKorkTU7lBls3dx9tB2/bgEwv6OLNzTakDNYjui6dXZSNTKNzUbR6EortxT1KVQP+muoEMR1DR+Ct8nugIu84Dw1z5Ln6fcKBXWWIrwic13krpAf8rKD96skEXAbl+LZsgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065877; c=relaxed/simple;
	bh=nnu5pfYGAjGya1FETHuZzdI1Z9AmZ6vE59b9W/EcQ8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7a+ZdZ4jCu2jEvyw+3ylN7L3naI0RA0B2SepeNEmSHqb4hr2amUUfjESl2uGsZc8UI+KoeOcA5XDW78egBpsvHHcSX7xwb6+mf4S50jK5BerG9gmCT1egRd7hK7ouVIUdqDydfbQaJsJJ0jpy6gG9KlPJ/Af1j+R67beb49a90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4E7Ae6T; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBBax5MG4csR/ijAhpz+rosPX5nvWxJOFu4QKQgsxP8m4GoNSGnVfXpTjfERT4TKDHy/1wxqOC0KjEGwsb09BLqsIxWbNtOI5OhKvuP+plgkFvlS8fDbKxBepNRttaEpJ3+C0mtLKn4OYdk2T3x90lRucF/dYu3npmzn+QVd5A+UtTjpk8RAoxjylZ6c3qEoGXMfTDkphkZHFh5B/3uAjaFcEixCVrscyxoZdSCOTdnGZjdDPB3bV+X7gABntYQpR6HeEmIYZvS8PICkrxz7jyMDJV5pgLpRn570rxrKqZcOrKydlO/p0scpTUR/9y68YGQH5u2TSSyqYpBV8uzVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRNxu+xVf9DoZc3qOS+cW0bjXSVfZ0Q7ekrf08naWhg=;
 b=JMuw+IiJYdeT9pHwwIzCmu9BiHmNaUj02uxQ+L8AGoUO5cTaUiDks1CE+VAIK7Wqvm+lrJRbFLT9Mem7SD+D94bMYWoeUJwf+yaY6faUk2+grSP5fiD3J62yHg040rnP9dYdKoS7q1kFnAI6uaZtaZtnp5/7oy6cI3/21mOcrsXccR7CNwhkr+MS3zfqSXvPnmfcHxe3zDybMQnS8Q6wkE0+4JFbNfxHgzjtNih5CHe+1jFy3sCFk82jAM6NfNrhn6LNP40Zi8+ffVA+54DpUOWDw8nQ5sbYO1US4aE5uz2Km3i3i1cGKWjx2KY+8ITfzXRpgJjpu51zDwphvovmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRNxu+xVf9DoZc3qOS+cW0bjXSVfZ0Q7ekrf08naWhg=;
 b=k4E7Ae6TIC4LvzPqRmKoT5i1Pg6xRiGWMjZdZjQ4ugsg9WtQSj9t/PRj3+/lr6afpNSL80B/dQz52AxEk7TPvG030TuPdeVYMlkppqoiyelrPqSjAKk2JS5CLDcb0a5+47AQnOEIH7ozxXYblM9jEdhWe9i3FobIHFDiyH7W9CM=
Received: from CH3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::34)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Wed, 4 Jun
 2025 19:37:52 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::7e) by CH3P220CA0006.outlook.office365.com
 (2603:10b6:610:1e8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 4 Jun 2025 19:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:37:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:37:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Peichen Huang
	<PeiChen.Huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Cruise Hung
	<cruise.hung@amd.com>
Subject: [PATCH 02/23] drm/amd/display: Add dc cap for dp tunneling
Date: Wed, 4 Jun 2025 12:43:13 -0600
Message-ID: <20250604193659.2462225-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd1f1b4-1420-4dd9-ff21-08dda39f4b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdogG7KZpkOwrNzSFD8ooF9AL+HAG4d7fT4SgvtOpdixw7NHQnO1DhlKcLwc?=
 =?us-ascii?Q?IbovS+tb3EH0FtzBTdebWeYG98sP9pxr+Df+A39+URNMdlZTTBFkgH9cWOfz?=
 =?us-ascii?Q?Z5chN3ur/xT7bE0HgGs33Wz0HLL+QIXhDcReNzbrLMiNnJkDki3/5howP46L?=
 =?us-ascii?Q?cVZMsfyzGMgxtcpK2M8ZUn3EWJgJ4OfZpQ5wH5qW1vBRSKSQ9rBAbJI8lwYJ?=
 =?us-ascii?Q?uPfgw0GJQAcgzJqhcXeuHPpVPq7iyTJ6qkFI3rLG4SY1G3sVWL72M3caqMlZ?=
 =?us-ascii?Q?hw0zVlb9mgWicyfICf9XpPmZeeWMyC3fXxmFhi77v16KnaPVhlkq6r9cpu/p?=
 =?us-ascii?Q?FwRVyP8yUtxuUPhcyN1C8HJFo+sXTH+PbtfgQ/3+NHPT4XIZx3tItq3eI0pG?=
 =?us-ascii?Q?977fhNH2HI0vdiYItGnvaYzFlXyh1EzOxINfNSvoSy4P5bU1owFHS2DWN48/?=
 =?us-ascii?Q?+FeZCe8aGgc4uAlnPTy+FfvUrf69ox5rgTKckdG9ku8zx59WL47CVCO07BoF?=
 =?us-ascii?Q?6st8nmAqQvziwl7lc90Sw6lqq5kAykc6zLVSYbJl2+6tUgiGni+5spWGu0BV?=
 =?us-ascii?Q?F+OxxtyFbfA8nSaQ7KZVEEthKsSkIWF/VVJIGR1zSk1qDpRCzAccIzv9DnZ5?=
 =?us-ascii?Q?sUSYWy0C8asxQj8eCb0rsuHtHsdGmIuZTkLC8EOSEY/bi+jlJ0GRBL6UBLMX?=
 =?us-ascii?Q?aMwGtiMRCVyWspmuFy/2kbmFoTXe4IpXH9u5VdjYz9WwqHLD88ZfxZi75fQq?=
 =?us-ascii?Q?lRYJHq6YQcoup9ajZA2Alqhk1+igX0FkK6Hach5gHtDerbn8yItugH1FZ+fC?=
 =?us-ascii?Q?uV96XeC1cx948TofhbzcpLYjOdT1uwC1o4quzI9tFsiHA/LQiyF7lGVTPMBq?=
 =?us-ascii?Q?E3kNNp5F05kaffnLkmBY9EIGiAsIsxT4uW5H42+SLbAkYQzM76tpNcKegsui?=
 =?us-ascii?Q?zDPmaYzVuV2vO3tQmh73Cq0cin8yzjlKJ2vB0DROhe5irnUR9mKVrrV8WpML?=
 =?us-ascii?Q?7gQGwKLEQwkeFd4zex3W6osWzy73nBKeqHZx7ihvTIjt/UL5JSOe/He3Ac6j?=
 =?us-ascii?Q?5lwTqIYqmEM10PxG7Zo+S7qt7vgRN53jgYgdOgKiY0dr7d/gcYjaHuHDn2wo?=
 =?us-ascii?Q?2xHHXd++XMiYvXLxgL2njLgWgAfi3R9mMInsyIBNvIZjd++kejKB/2JRfxs7?=
 =?us-ascii?Q?vjX3ojvliLXLbuFMldNHh57cl4ij3B/EZLD/JuYeVLt0rRPi9SVmJxxRIw2R?=
 =?us-ascii?Q?gkMZDqLq37+IfMFMaRSvfLE7t2iBlwjyt/+Io8pPQL1SCKImttso6bJ+vrNp?=
 =?us-ascii?Q?E2gebZjyovAsdq0cO6ECmpLsI6EgfloGfb3BkQDDmVbgyCWeftQyhq/iPZdi?=
 =?us-ascii?Q?E85Vd5khvbkS4fqPossh+9M/4ceWeMqQHDG6pOuKg6DAq4XAlKPm+mBCxDcP?=
 =?us-ascii?Q?a4i8+0BEoeZOPi1c4T+X+L4sfhpdblEjLkpZRJT9Zg46AeVgAcMuSGDuLloE?=
 =?us-ascii?Q?GlFcdaiSKVhavByrXvGELHPfw+abPbPS1qzJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:37:51.5519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1f1b4-1420-4dd9-ff21-08dda39f4b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHAT]
1. add dc cap for dp tunneling
2. add function to get index of host router

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 33 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 ++++-
 .../dc/resource/dcn31/dcn31_resource.c        |  3 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  3 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  3 ++
 .../dc/resource/dcn351/dcn351_resource.c      |  3 ++
 .../dc/resource/dcn36/dcn36_resource.c        |  3 ++
 7 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 284261cd372f..eaf44e6046b5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -241,6 +241,7 @@ static bool create_links(
 	DC_LOG_DC("BIOS object table - end");
 
 	/* Create a link for each usb4 dpia port */
+	dc->lowest_dpia_link_index = MAX_LINKS;
 	for (i = 0; i < dc->res_pool->usb4_dpia_count; i++) {
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
@@ -253,6 +254,9 @@ static bool create_links(
 
 		link = dc->link_srv->create_link(&link_init_params);
 		if (link) {
+			if (dc->lowest_dpia_link_index > dc->link_count)
+				dc->lowest_dpia_link_index = dc->link_count;
+
 			dc->links[dc->link_count] = link;
 			link->dc = dc;
 			++dc->link_count;
@@ -6378,6 +6382,35 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
 	else
 		return 0;
 }
+/**
+ ***********************************************************************************************
+ * dc_get_host_router_index: Get index of host router from a dpia link
+ *
+ * This function return a host router index of the target link. If the target link is dpia link.
+ *
+ * @param [in] link: target link
+ * @param [out] host_router_index: host router index of the target link
+ *
+ * @return: true if the host router index is found and valid.
+ *
+ ***********************************************************************************************
+ */
+bool dc_get_host_router_index(const struct dc_link *link, unsigned int *host_router_index)
+{
+	struct dc *dc = link->ctx->dc;
+
+	if (link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+		return false;
+
+	if (link->link_index < dc->lowest_dpia_link_index)
+		return false;
+
+	*host_router_index = (link->link_index - dc->lowest_dpia_link_index) / dc->caps.num_of_dpias_per_host_router;
+	if (*host_router_index < dc->caps.num_of_host_routers)
+		return true;
+	else
+		return false;
+}
 
 bool dc_is_cursor_limit_pending(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0839a679901..5c01a535b4fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,7 +68,8 @@ struct dmub_notification;
 #define MAX_STREAMS 6
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
-#define MAX_HOST_ROUTERS_NUM 2
+#define MAX_HOST_ROUTERS_NUM 3
+#define MAX_DPIA_PER_HOST_ROUTER 2
 #define MAX_SUPPORTED_FORMATS 7
 
 /* Display Core Interfaces */
@@ -338,6 +339,8 @@ struct dc_caps {
 	/* Conservative limit for DCC cases which require ODM4:1 to support*/
 	uint32_t dcc_plane_width_limit;
 	struct dc_scl_caps scl_caps;
+	uint8_t num_of_host_routers;
+	uint8_t num_of_dpias_per_host_router;
 };
 
 struct dc_bug_wa {
@@ -1637,6 +1640,7 @@ struct dc {
 
 	uint8_t link_count;
 	struct dc_link *links[MAX_LINKS];
+	uint8_t lowest_dpia_link_index;
 	struct link_service *link_srv;
 
 	struct dc_state *current_state;
@@ -2625,6 +2629,8 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 
 unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context);
 
+bool dc_get_host_router_index(const struct dc_link *link, unsigned int *host_router_index);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 6b6efc2e75c0..2a33c82cfedb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1954,6 +1954,9 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.num_of_host_routers = 2;
+	dc->caps.num_of_dpias_per_host_router = 2;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.disable_hbr_audio_dp2 = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index e84526c51590..cec03e81c6bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1885,6 +1885,9 @@ static bool dcn314_resource_construct(
 
 	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
+	dc->caps.num_of_host_routers = 2;
+	dc->caps.num_of_dpias_per_host_router = 2;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 62f6c7abb9c6..1f20069018ca 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1894,6 +1894,9 @@ static bool dcn35_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.num_of_host_routers = 2;
+	dc->caps.num_of_dpias_per_host_router = 2;
+
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 85a96258bce8..6266fc77c7eb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1866,6 +1866,9 @@ static bool dcn351_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.num_of_host_routers = 2;
+	dc->caps.num_of_dpias_per_host_router = 2;
+
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index e977866802bf..10d3182b3058 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1867,6 +1867,9 @@ static bool dcn36_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.num_of_host_routers = 2;
+	dc->caps.num_of_dpias_per_host_router = 2;
+
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
-- 
2.43.0


