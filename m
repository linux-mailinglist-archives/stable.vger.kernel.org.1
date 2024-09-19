Return-Path: <stable+bounces-76773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A497CDBA
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BC1C20F75
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCA23774;
	Thu, 19 Sep 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IR0ToXNP"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F22AF0D
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770917; cv=fail; b=UMjSEjiNx1iNR8xuc9X1pH6/4T34gyV1sdQ2HWrF4+oE+X8LDZMCam88jV+Zip4AkECuD6ipI/PQH3W+IQI/pRlsuX4wxaLJjQFSORdiZpwYny7h0yD3WKTgE86I2C0TT0BFN/UMh6DElB9h7YXD8qC9tv0ue8t6EmOoktQJab0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770917; c=relaxed/simple;
	bh=pruOK6T6Oi4lh4n/uUCXQflLKjHc9FSihcSNCdvnsBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAkKhUDB8ItUpwWHjzwDAZny3ky0hILAZ5t4zlmyo7MBgP2VQ1E2YLg6ch+0lX4etdhEW4hfmIq30SMxxnFoFmfbC4b+M4VZZGFUWr98qLkSTNkkjIfiEr6r2dKbmE/lTjy+PDAvUBnapBvYlyir6avgs7RB9/cK6k7Ew8VNhkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IR0ToXNP; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7uS5q0DUENcqZpEM/0spgkPkQnekiS2RcKO8+SdcWuRyt1iPvHTCQNN2+KGcZsu7RoLMYJ9AihXh7CS3FFVldpr53iP57MUJU6S7XpWJ6pcFARCZbXmR+dMvgmkPm3ePaXiKgR2/MQGCod+hL/xQFBp5PdGnAwBY1PtshhYMmeakIzRspHCBD/uDIjOtNm0DIc/SfOMHR+P9vIVRVpGkfiIL8eoch9gxHaX08m/ay//RQotvnf5wTKow4m/a5xnUWHOZyDEKmFndSpDvotc0INv1dZP3LFQWVMGO/ullbnRd2OR/LxlIAwDNTarLWkvHChOPZ+zPoPPFMo69KbFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeRCSru406pyWT3r5/WRwMXp7Lvs3Doye8Qf05brZuw=;
 b=BPC7sff1Tkp6CKGX6n6oshiFHHfl2eKdELTp1zoACfRleCUg29CDpERp3AS1IcgGzWSK/MdyONvvsPBEPC2WzRudVuXuuUt3YLhskaD4aVUe/Z2b7BaIj8M9J6c38P6u8TujB58pOfbE/N8sSHKUKmYnQdxSDGWsirbrb3PURqLbQvO0UzmDa/8EQS9HxJidX23ijOvAElB/2C0KUkph2UlQQUdoMGa3OSQKL0peR3njR4S0tJyVIRXgVRthuDa56Z6SVUwJnc41J86fP0BWAtRM9SVaM3kiAwRornrvQNnnsDIdBmP1yH+8PUNFWjaACRvkcdxaEFVKdqRhv7yQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeRCSru406pyWT3r5/WRwMXp7Lvs3Doye8Qf05brZuw=;
 b=IR0ToXNPgIwyTF3a6zA07zwwa0fCC+gcGLuw6j8QdJV94JSxU9CQh4pS4OIAtYJhMT60DFeWFE8L0xvDCEayepiGZYlGydxhqH7wl1Aj+zlZFF4tdNn5nD2IarwNxYrpxYZmVrrp6Uv/XRFg5EI+bdBBBqsYZU5jqeSnI+FCFuI=
Received: from BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::22)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 18:35:09 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::41) by BL1P223CA0017.outlook.office365.com
 (2603:10b6:208:2c4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:04 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 18/21] drm/amd/display: Add HDR workaround for specific eDP
Date: Thu, 19 Sep 2024 14:33:36 -0400
Message-ID: <20240919183435.1896209-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: b4268a17-702e-47df-0cc6-08dcd8d9ca8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1X4AMypERCKIWfFCUk2+3u2C+5Oqrpm/AWvuqRGKDvDu7xCfvHGKGrIB0OL?=
 =?us-ascii?Q?vHV7e8yeXjaPPN+dTKZlIfQ47mwgEB3YOaDWkdOQiyBOMaSnYlWy5Cz2ymCu?=
 =?us-ascii?Q?pHbWPiuMi3wwY8aZCPTw6dwfC8afM277S8w/60XN7MvgUN2IS3gau3ijjxaS?=
 =?us-ascii?Q?/A1mKgLf7vhkDLXgogem6E4wv12O9uQ2NrdiwMOcNsZ3JmidsCcm7ArDrrQ3?=
 =?us-ascii?Q?xqlSFBAzvlc3JPlJFMobjn43xPQMsCRCb4vlnJFe4F91T4VUF9ahMksUXrpS?=
 =?us-ascii?Q?P3q/0MTf9F0N6F3CqsBdqFTr9XOzaX96liI5HHn04QdZOR7jLnlxJaD2m2kh?=
 =?us-ascii?Q?VPyBIdg58pX8+468hbJJEx70Fb08KC6sPsMHA/wepUu2gIZuDVhZzxa3gRhC?=
 =?us-ascii?Q?+9MWMeQulR23BQ6CnveiQH5dXmTK3uD+YTmmbfXmshYmiA7qBkd0TKw5ZL8X?=
 =?us-ascii?Q?0W8iSFkzljKWyO+Su1UJsSN+T2m9A2259e9a6FruPfQvjRhdqASuVwgDC8Og?=
 =?us-ascii?Q?7jwFtPNtU0orRpK7rBRA9Hl+27w9j5IupHloI1+6yMckwzQk94ANNDoRsG6E?=
 =?us-ascii?Q?4UfE7FrgAstAVEwOAlV8NjkkkhTt8N1yV1spSa90qPAiG1nDuyvaQrIOTtOp?=
 =?us-ascii?Q?uvRgKQA6qc9Fu3UOfQCm+3pRN3rhQEWV033OCnT6B15GIW/tAXdAsvBzsoOV?=
 =?us-ascii?Q?JVI2hrEPCMiqIg/UWmWhW313ZHK9ZYoaEEc2kv/ytm80LTLOsFHgS5b7Xwm7?=
 =?us-ascii?Q?q7yNLbqQq5Cx6R5dO7eTHNxn/AiKn3aMxqsiy7nCjI23VjC7pu/rgjPeUTY4?=
 =?us-ascii?Q?0ons5EfvwAEi3IJruaYiFEPFVFzBYDU2ts0WI9xfwBU+2YvDMjOhVlxsoZBh?=
 =?us-ascii?Q?aOy4Tjd47vHb/kV2td4kQ0N6CQnAjOnaH5oFAgbxbNDHdZnVw2WIHfIAQPpZ?=
 =?us-ascii?Q?FYvCJHKDb6qW2+1r9JQhphYzYPM2C2ROZvMQtit0J0DUdhMxp6XKJSmmPrOW?=
 =?us-ascii?Q?7TABemT7mMzQmmVVFlvhw+lFFOo7jbptnFMj/rLWbXcsYK4fB36Kz13xWrwo?=
 =?us-ascii?Q?wjM5WtKvwIfS/+pToiTCvkAgSEaVi1qBTkmONMIy1oR1HfHEpPyd3di8cWln?=
 =?us-ascii?Q?Mm+EpmXZv2FzcBkEsJErDSH54a8mMAT/nMz4EN8vDCQ0aHYoak4b9cCe6ZNX?=
 =?us-ascii?Q?r54PPXbArlhiMOgMtvuYXzYywOAdo1gOvwIwLKWjaGuU/nJ626lpjxgXURkM?=
 =?us-ascii?Q?YnBUta3aKKpQpU0q0bG4MzwkYiFL0xsRZjqq+AZ1qnaof3Xl5YJFEcGQGg/6?=
 =?us-ascii?Q?151Vlz+duvGXIgj6cyq8Ywjz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:09.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4268a17-702e-47df-0cc6-08dcd8d9ca8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
Some eDP panels suffer from flicking when HDR is enabled in KDE. This
quirk works around it by skipping VSC that is incompatible with eDP
panels.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3151

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 11 ++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h             |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fe7fe707a8a..3bf2db3b3059 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6735,12 +6735,21 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
 	    stream->signal == SIGNAL_TYPE_EDP) {
+		const struct dc_edid_caps *edid_caps;
+		unsigned int disable_colorimetry = 0;
+
+		if (aconnector->dc_sink) {
+			edid_caps = &aconnector->dc_sink->edid_caps;
+			disable_colorimetry = edid_caps->panel_patch.disable_colorimetry;
+		}
+
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
 		//
 		stream->use_vsc_sdp_for_colorimetry = stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED;
+						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED &&
+						      !disable_colorimetry;
 
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 39b82c73a0dd..b62b0406a6d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -73,6 +73,10 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4154):
+		DRM_DEBUG_DRIVER("Disabling VSC on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_colorimetry = true;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2bbafd1cdce4..b0b7102fdbc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -178,6 +178,7 @@ struct dc_panel_patch {
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
 };
 
-- 
2.46.0


