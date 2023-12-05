Return-Path: <stable+bounces-4767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F4805F42
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E46281DD5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612D6DCFF;
	Tue,  5 Dec 2023 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxlH21W4"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169FBC6
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 12:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An1GRKb76e6gI4LUMJy/vYwnSlebSTKICfrbcZhbiDpDyAE9TSKDOYjlkeaBI7SIlEG0KQHj40ARh3VYWp6hGOq1GGzhlbyyBQ5Idk7MwHDnt86JqJ8PY9TWCtpuiACuX8Fr1wvs931wd1NGpnUbEBROz9aDqUW6f4qlnUwbj9Pu2rhqrmlaQv5uAQ8EB7vrzF2rTGcSjLY7c0Tfvq7vR7rN6+y6j6x0B2oUMvkxIl3evO99UPUvcl4K4KQ3V62VuHt13/CMDlBrHpSp3/WJfR9nG+/SRiDzaRFFmhZSRRq0oUJUbXCM1a6JKXFRyRUYtER/BzPXSfx6I34EzVg7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NklNprng1pLaHQzNHAvkWOsVU6/PIeerjKt1rHqVX3g=;
 b=e8MEIqaSi5xdi+9OMqN7Nm1IUgigs3F2YGAhTP1+IckNa8p32soImovLWdyyuafjX//vk8xVLRfPpkq6F+aemyeUyM6BhgXYi3TkyxIlvabLyfMC1LvuwmP7FeSafxqfT11pMADzobj5QpmQTgzJfZ2DeQXaNmf6jbpRVy1A3mSKBXPgLGFSGkHSjJUKj/eUbGBuKdoUKgdz8J8kCS3CokX3VaL6ZnwrBK/Eea/5jZ5g0M2UAai4mgIp4v/V+6dZwKRnF4hhLFX0yNsoRmlq6t4Ewp5EtkeUA6954FE6TObbXv5mHJ+2aRe5NAfJKzaIWJlar3zfA0a8AfX7UKZBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NklNprng1pLaHQzNHAvkWOsVU6/PIeerjKt1rHqVX3g=;
 b=ZxlH21W4NtuDMp27/Q4sjwnmf14dKqXNWCJN7VhV7cHkGFj3MsPeccE5QRiZf47ON6S0ci8z9GEAypCHwa7AZKjJpQbZZR9lPrwzzrux7gtEYzRjNUJqBnyO32SnBJ4dW5GPsE+LqPpQ5XI113HUn89x32NR8DBmFnGN0A0s3G4=
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:18:10 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6d) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Tue, 5 Dec 2023 20:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 20:18:09 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 14:18:08 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, Alex Hung
	<alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Taimur Hassan
	<syed.hassan@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is enabled
Date: Tue, 5 Dec 2023 15:17:49 -0500
Message-ID: <20231205201749.213912-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e29cb3-39cc-41aa-55f7-08dbf5cf4cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bFdTTFahJrQ5kcprbQ0dzbGDwABwK4IJVZ9ze6QoF2dWUtwBde7eSQdt9AokQAHO3xbzKtGxmnOuLXov/tlo6CDkJ05dfJ5RVZdQVQ+oW2uUk4zMJ4bcRL0DpS1nCBBn5dAkJU1WWt4UgF2JLNYwiuFJbmelppbIWfhlx+a1DDAlb17cP0Ytmlk4L4Kv4SfIY5K8bYeKreNPD108mL2+yDH/RRcylZyMRW6rvDv6MVBJoidRhvtn54yI6Piio2hh/QsRMxuiu0WQiGjKeJhIqV7CLT91YlwTQ+xcdk97mdUUpgBPbXTjHs/mXsihCbqMMIFQue8I7X4iOqoTcNSJLR4oibfbnsEicsjZl5JMXtV1T0bD3eTVVm8NPUCuQ8VOMJTk3Nzyd01ojhLHj6F+vElNJDTE6vMgCPNSV5nhrxh32NkYgaGX7H456EsVF4ZyPfr12Wf8I9qFRBRkaErGNn9117HQp9zR0Q6Ek5H40HyOfhDPwZTbvt6YBV6luf05svvGtuH7zErarcXUACPdkJTZM67X5CYHboy6FezJsTLw3zRKIUJsA5V4+aXY3YIM4mf3E1k/G41eOp7w0q9QxL3B16JSSOHWBONAg3AYOGBQGsq1HvY9eIYHPPVlqdINHf/LLwpCyh+1Vd7m3JZRsXWoj9Ggww2tMCunKo+uQq4q804oSvBvqWZQ7khTTtYkwwRF0e9nh8ISX/TSW2u9W3i5euFHBZVpM61rhFnS9rchoG48/6uWH1rrPQtTSP/teQp01T6pEKlK2Uc325bzzyHUQKTMi7MiU5FRZvbagRA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(1076003)(41300700001)(36756003)(86362001)(426003)(44832011)(2616005)(83380400001)(40460700003)(26005)(16526019)(966005)(336012)(70586007)(316002)(6916009)(54906003)(70206006)(6666004)(4326008)(8676002)(8936002)(478600001)(82740400003)(81166007)(356005)(36860700001)(2906002)(40480700001)(47076005)(5660300002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:18:09.5769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e29cb3-39cc-41aa-55f7-08dbf5cf4cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140

We currently don't support dirty rectangles on hardware rotated modes.
So, if a user is using hardware rotated modes with PSR-SU enabled,
use PSR-SU FFU for all rotated planes (including cursor planes).

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c146dc9cba92..79f8102d2601 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	bool bb_changed;
 	bool fb_changed;
 	u32 i = 0;
+
 	*dirty_regions_changed = false;
 
 	/*
@@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	if (plane->type == DRM_PLANE_TYPE_CURSOR)
 		return;
 
+	if (new_plane_state->rotation != DRM_MODE_ROTATE_0)
+		goto ffu;
+
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 9649934ea186..e2a3aa8812df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
 	struct fixed31_32 v_scale_ratio;
 	enum dc_rotation_angle rotation;
 	bool mirror;
+	struct dc_stream_state *stream;
 };
 
 /* IPP related types */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 139cf31d2e45..89c3bf0fe0c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
 	if (src_y_offset < 0)
 		src_y_offset = 0;
 	/* Save necessary cursor info x, y position. w, h is saved in attribute func. */
-	hubp->cur_rect.x = src_x_offset + param->viewport.x;
-	hubp->cur_rect.y = src_y_offset + param->viewport.y;
+	if (param->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
+	    param->rotation != ROTATION_ANGLE_0) {
+		hubp->cur_rect.x = 0;
+		hubp->cur_rect.y = 0;
+		hubp->cur_rect.w = param->stream->timing.h_addressable;
+		hubp->cur_rect.h = param->stream->timing.v_addressable;
+	} else {
+		hubp->cur_rect.x = src_x_offset + param->viewport.x;
+		hubp->cur_rect.y = src_y_offset + param->viewport.y;
+	}
 }
 
 void hubp2_clk_cntl(struct hubp *hubp, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 2b8b8366538e..ce5613a76267 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
 		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
 		.rotation = pipe_ctx->plane_state->rotation,
-		.mirror = pipe_ctx->plane_state->horizontal_mirror
+		.mirror = pipe_ctx->plane_state->horizontal_mirror,
+		.stream = pipe_ctx->stream
 	};
 	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
-- 
2.43.0


