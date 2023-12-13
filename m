Return-Path: <stable+bounces-6563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C235810A0D
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 07:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D571F21B05
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3CF9D2;
	Wed, 13 Dec 2023 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MH1VME67"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5EDB
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBXiJMqtLR5p3hRu04iaaDulWuXKMEqQL+dZFkhMu1dAVz+3NPRtUdEplxDKSzZmNHX+KbKGAK7c18nRmJKRlzh7JkBlaxP8b9hTzJGcqiAkwTtcwyUkAjbE10nDRM+auzL6oIWnjJrAeFGqT1/iX1Q7oUZeBlCoJK+d0ZOnpOGfgtFPOiN7gB6LoHwVqOf8iceUL829e/BHwo20QigmiMEDtymYQnECZgjc+dngRMeYElEMcriP/QEZoQYqHVZaC+TUEmE32b5ftEN+WRh+prbHLPBOmRUF8rFk7cYzMG/LTeqtEPetq2CHtQ1InyGH5T9r6qRjPR6LkdWDVLpBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w3+NW+pzn/3TN5LszBFTRfwxPLE9pxcoTz8+tSz1sM=;
 b=Wpo/vMiqFzNDKdG2Q9TsITNpkxk9+86VUdzYh4SIAeqIQXjDmngghToVzAGWjAbcx4ykcyCLbf0IdirpnCSEohf9t9FO5zSFAnA6a0yQVnRvVv39oDrVPhwA1T7bs6iZ2PRNtVBtm25501dvBqB4ktcJK4ULcY05z5NCyQzTiQxb2SQooVYA4B94V0ucxdakkonOwvXkPSvnJgg4SpuqUWyooEGOq5osxqARQqnp24oiGTkedjaC6iQNImgg+IwvqiomDgvXYpmSv3T7IUqWPD/PRYEyKnmaLDnPxoQhe/+uqrxm50uPcbIMCIcR8YEjbv87yzTYzekF43WrSKu7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w3+NW+pzn/3TN5LszBFTRfwxPLE9pxcoTz8+tSz1sM=;
 b=MH1VME6711lvtDjchcm7lz6hgByXCQfWyqkF7XpIeRv0b8RK1OKUqpjisyRUJtlx3DBUWYCz6yF7v6d6D6a0kh5YV94qardC2O3ILvYcBTVgP10nw62UXa32jY2XvY/AWaVjbA3zhtHjOPtyyRiwxEwnTJHdYtupQiWZ6kOl43M=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:14:24 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a4) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:14:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:22 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:14:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Hansen Dsouza <hansen.dsouza@amd.com>
Subject: [PATCH 15/25] drm/amd/display: Refactor DMCUB enter/exit idle interface
Date: Wed, 13 Dec 2023 14:12:17 +0800
Message-ID: <20231213061227.1750663-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3678b8-1f63-4c25-7fc2-08dbfba2c0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bp9lKINCUyy1YuQsfCEyQg3tcqUG/3IDdgbJTeNPiXTc6ZSOm6QYRkyWVh/v0U3y/3oDYB7COrGLZr2a7Nir57N/qfkPjJX45Vn9rqxIgFY/Ty1HP0+yfEW4F+KrpuZQMw4C7eflHblIqYMvIMrLQFhI7Fg6udv3bjcUHwbWp2yLWDTtLDKudNVdGKY+bbvKUFbePWsXrMLR8Ztc+bQnR2en4Q3Xn2/XGe/vupX2mZVN9dq31G1S7MPpPKsqP6xQtb5zZrQy7r2Zl7EXjHIc8Xc9PKHtAczRSJp8XGTvmI+OtgsVOcdtDbafvk+k0twSMtijD+RpwVjSFCFP+iMwKJoLbxRPkjVf+kt52bTuWwDzjUWof298VKgPremsRdPjxiKWwPQ9/88NBn65lxKQGwNGl20a84jJNw+q/XkzcCByo/+S6nsC9t+rhgkG9LlwCvDRlKyx35kMwhgOarseMPM+b/jBqYPJ5GwbsLp+jjyvU0vZzuyz6ilz6cAM4ODB74h6AqX9+p4mhFlYllvjpyZGPsVNgafdddvUrsJgPrP4FYHdXzkcDtU8pQ/Pn8kUuywK0EYiQxBHW40hvXmd+QOoR9jECF9prjIopT7REIFsKimiLRhlv5FHJJIet9jszCnTacB1wOYaN1QkWBeUGAGO5+cVEJTghTER2yTbaSgixYt7Ee/sF0yv0T8fI6XahQoOKng1QgFkGwGwty5C6kydp+XU2onCqCGn6UZqHQK5j6mA7tawdwWDzdhGu16E/5qT5dIJHeNhHN7TaLcKmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36756003)(41300700001)(82740400003)(356005)(47076005)(81166007)(36860700001)(2906002)(5660300002)(7696005)(83380400001)(336012)(426003)(2616005)(26005)(1076003)(478600001)(54906003)(70206006)(70586007)(8936002)(86362001)(8676002)(316002)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:23.9289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3678b8-1f63-4c25-7fc2-08dbfba2c0c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We can hang in place trying to send commands when the DMCUB isn't
powered on.

[How]
We need to exit out of the idle state prior to sending a command,
but the process that performs the exit also invokes a command itself.

Fixing this issue involves the following:

1. Using a software state to track whether or not we need to start
   the process to exit idle or notify idle.

It's possible for the hardware to have exited an idle state without
driver knowledge, but entering one is always restricted to a driver
allow - which makes the SW state vs HW state mismatch issue purely one
of optimization, which should seldomly be hit, if at all.

2. Refactor any instances of exit/notify idle to use a single wrapper
   that maintains this SW state.

This works simialr to dc_allow_idle_optimizations, but works at the
DMCUB level and makes sure the state is marked prior to any notify/exit
idle so we don't enter an infinite loop.

3. Make sure we exit out of idle prior to sending any commands or
   waiting for DMCUB idle.

This patch takes care of 1/2. A future patch will take care of wrapping
DMCUB command submission with calls to this new interface.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 37 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  6 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  8 +---
 4 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 84efa9e7c951..0954d7057a9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2854,7 +2854,7 @@ static int dm_resume(void *handle)
 	bool need_hotplug = false;
 
 	if (dm->dc->caps.ips_support) {
-		dc_dmub_srv_exit_low_power_state(dm->dc);
+		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
 	}
 
 	if (amdgpu_in_reset(adev)) {
@@ -8968,7 +8968,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			if (new_con_state->crtc &&
 				new_con_state->crtc->state->active &&
 				drm_atomic_crtc_needs_modeset(new_con_state->crtc->state)) {
-				dc_dmub_srv_exit_low_power_state(dm->dc);
+				dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index eb6f5640f19a..ccfe2b6046fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1162,6 +1162,9 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	enum dmub_status status;
 
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return true;
+
 	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
 		return true;
 
@@ -1183,7 +1186,7 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 	return true;
 }
 
-void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
+static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 {
 	union dmub_rb_cmd cmd = {0};
 
@@ -1207,7 +1210,7 @@ void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
+static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
 	const uint32_t max_num_polls = 10000;
 	uint32_t allow_state = 0;
@@ -1220,6 +1223,9 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	if (!dc->idle_optimizations_allowed)
 		return;
 
+	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
+		return;
+
 	if (dc->hwss.get_idle_state &&
 		dc->hwss.set_idle_state &&
 		dc->clk_mgr->funcs->exit_low_power_state) {
@@ -1296,3 +1302,30 @@ void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_c
 	else
 		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D3);
 }
+
+void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_idle)
+{
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	if (dc_dmub_srv->idle_allowed == allow_idle)
+		return;
+
+	/*
+	 * Entering a low power state requires a driver notification.
+	 * Powering up the hardware requires notifying PMFW and DMCUB.
+	 * Clearing the driver idle allow requires a DMCUB command.
+	 * DMCUB commands requires the DMCUB to be powered up and restored.
+	 *
+	 * Exit out early to prevent an infinite loop of DMCUB commands
+	 * triggering exit low power - use software state to track this.
+	 */
+	dc_dmub_srv->idle_allowed = allow_idle;
+
+	if (!allow_idle)
+		dc_dmub_srv_exit_low_power_state(dc);
+	else
+		dc_dmub_srv_notify_idle(dc, allow_idle);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index c25ce7546f71..b63cba6235fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -50,6 +50,8 @@ struct dc_dmub_srv {
 
 	struct dc_context *ctx;
 	void *dm;
+
+	bool idle_allowed;
 };
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
@@ -100,8 +102,8 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc);
 void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, const struct dc_plane_address *addr, uint8_t subvp_index);
 
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait);
-void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle);
-void dc_dmub_srv_exit_low_power_state(const struct dc *dc);
+
+void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_idle);
 
 void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 9262d3336182..f48001317fab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -687,11 +687,7 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	}
 
 	// TODO: review other cases when idle optimization is allowed
-
-	if (!enable)
-		dc_dmub_srv_exit_low_power_state(dc);
-	else
-		dc_dmub_srv_notify_idle(dc, enable);
+	dc_dmub_srv_apply_idle_power_optimizations(dc, enable);
 
 	return true;
 }
@@ -701,7 +697,7 @@ void dcn35_z10_restore(const struct dc *dc)
 	if (dc->debug.disable_z10)
 		return;
 
-	dc_dmub_srv_exit_low_power_state(dc);
+	dc_dmub_srv_apply_idle_power_optimizations(dc, false);
 
 	dcn31_z10_restore(dc);
 }
-- 
2.37.3


