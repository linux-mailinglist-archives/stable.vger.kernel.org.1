Return-Path: <stable+bounces-4928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF5808B0F
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD11F214FB
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65A42AB0;
	Thu,  7 Dec 2023 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LreE+XzX"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7DA3
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 06:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiRmSfGKyyeLR8BvObDZDL+GnTc1ictxpHtIQPcttMc5qknBACgfHiajk4JfJVKQsv+XJf8JwCDa2DoWo0Ts/VpFnfPmabqg9ar9oPRHt3gaNlc7LVS5EzFOPVYEy6TPEPF5eXxKJHO/snCCHbcByqi8ZdTkUnT/Oxo7XrZndPIH5TK7veWvvv3ke+RMkMImS8eaKPpQ5Wv58t80dfLP+7oNE//laXgatocDYRzz17yd38WCGJXEmQHpKgzTSEihoLvqmvjXLhAP8XcMYRhOdWjFC9BuXTCMbOrBWOFFlHrxSl/QCb8KCktbW8FGtaMTgH+pcECpRKi8pMhPi0M+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEICp29xb+HmD0HUU9fYriDrKB3Ewy6G7GbmP6KNcs4=;
 b=PUmBfPe7fl6fV8FG1ozSvXPHd41Uh0+MuF938WwliFAau76ZJIWz2OEzD9e+1RxNqxp9FUpzNIJBxrR+DWCgr5d+xzLeAoLMRKd3hLLAbbVEMgCDkfn4uc/VzzU9aqSL/CnCHAMZ3hYhJzWGqUMd2FdKxfepFo/AF8ls0jz5tkOTmAjdnKiy+jOdaFWKo1PjrKvu3dBFxkjGJSo26BecJk0tLtiqEK7O6PTis02vFwp7tzv/w/98+HKJfuvxHB5TsVTAlZdH4kHaA2RSS9eiWjDgH1tUqGkWJeWpCe0kewA0a+Q1FCKaUPbd2prIlR0VRGvTR1xhJGoMYsz0ZqdQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEICp29xb+HmD0HUU9fYriDrKB3Ewy6G7GbmP6KNcs4=;
 b=LreE+XzXalnt9SfGBGjy5DRBgPavCFFnF49uE+prwhPN8RHMM0mZ9izkKQCP+3RQM2u1VpXRJ9ndZ2dCBjNYZ/26bsTqFZFUMokEmXsdNl49Epr8/b1GqZkaGHMj5Y3w1XPjp68mxLDk4987UyO69BjfRz8iRYMgE99fh10PueM=
Received: from CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47) by
 DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Thu, 7 Dec 2023 14:52:02 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::5d) by CH2PR05CA0034.outlook.office365.com
 (2603:10b6:610::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Thu, 7 Dec 2023 14:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 14:52:02 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 08:51:59 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, <stable@vger.kernel.org>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, Bin Li <binli@gnome.org>
Subject: [PATCH v2] drm/amd/display: fix hw rotated modes when PSR-SU is enabled
Date: Thu, 7 Dec 2023 09:51:44 -0500
Message-ID: <20231207145144.7961-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: f2062940-94a0-4072-7abc-08dbf7341269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MOknAAoFoaNeE0S0LaAfm76yvoQnj1Ssp2iWEPH2uMR1CJUY2CstDrq6WvsW+Eu9es9CUgH/qh3S0KoNVfUcJC4+3xfjQs9Hl9U/DSsVMOqRPjfUxKHNcnPxtNUDFphMLc4EW3qZLpqILZGOVdH+xLE9Qi3QsgOOF2x8LjKf5hTWnD8XSrHzQm87hL5pQIonuvaexaFf1beslvbbE6g2MUd/U1Z/iy5Q0DKwpIWGkhXso/RwtAbBT4dP+yGXUMKPUM0tEu60iOJMl6ZHQ7+1tCBd/xr4MWgMXFFnUpWJF7ygVBFahdidjBu5P2EPvAWxlGFxo5rloUGZR+oJKHoza/EZoY3l3+RM6xBFK2i4nqOHOTmtxwm27FOrECVFkqMRjcoGsLfaSUqZjxJ3oPJjBGtAv4+11i9BMttPo7BEg0jLVARa7HE4plWNvwqDFwxAjOGNIEMoOrXYb5GV4J/0CUNSl+gMagJsFbOpqRvKFneIejkwd1q0YsCQXWsMGtWdQ/kIZMm0XRuLmclPTSKphIUbY8ShbSAUSPls2B50pTMSwcXJA1ORE/JKwjk75ZXL/NMcu0/ZduXtj/TfvM3kOmEVS0QjKZBBDezc8TLPEQssaarTW2RtbWU0Ka15YbuVwgC7UFxYR780nGP/wIWWHDKJCU6RpA96sUWKXgHygPnT5wutdwEoO0E2FXkZ7uwG8ch6Aekf5s0sM5uQdeJQ+66xTzWyR+DGtoHdhLquBEIlI12nVcwwzCE4dTbYmYSU3AGU0msv8Gp9GYQscXA4eaZa/YKBMRs7oRFyW7APHUk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(5660300002)(44832011)(47076005)(82740400003)(6666004)(4326008)(86362001)(356005)(36756003)(8936002)(41300700001)(81166007)(8676002)(2906002)(40460700003)(316002)(426003)(26005)(6916009)(336012)(83380400001)(16526019)(1076003)(2616005)(966005)(70586007)(478600001)(70206006)(54906003)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:52:02.1538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2062940-94a0-4072-7abc-08dbf7341269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389

We currently don't support dirty rectangles on hardware rotated modes.
So, if a user is using hardware rotated modes with PSR-SU enabled,
use PSR-SU FFU for all rotated planes (including cursor planes).

Cc: stable@vger.kernel.org
Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Bin Li <binli@gnome.org>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v2: fix style issues and add tags
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++--
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c146dc9cba92..3cd1d6a8fbdf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5217,6 +5217,9 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
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
index 2b8b8366538e..cdb903116eb7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz,
 		.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert,
 		.rotation = pipe_ctx->plane_state->rotation,
-		.mirror = pipe_ctx->plane_state->horizontal_mirror
+		.mirror = pipe_ctx->plane_state->horizontal_mirror,
+		.stream = pipe_ctx->stream,
 	};
 	bool pipe_split_on = false;
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
-- 
2.43.0


