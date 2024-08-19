Return-Path: <stable+bounces-69566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9095683E
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C030281087
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431B15B14C;
	Mon, 19 Aug 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8gEJ91/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75082900
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062931; cv=none; b=tpLAuDZbsth3Pjj/qkcjgTROIoBE2H6DE4KKryQfJuSqj7liqDzVd5Ktrgei4398dV3zOe73gVu+0xQwNAsw8n4yl7zEm8GYanv+HAwPhhWpIU6T01kLZkYJtlmYqI2EMFvMa9nPQbmp+UTsPsHszK3ZHVnS3JjI2Keax3NLsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062931; c=relaxed/simple;
	bh=76IfUajEPgxYQVvDKE2Y47gkZXo96F4PlGC1qqytf/s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DCgclKvJhY3yq9vIBXfIAfOYVzfCpLjFuLWGdvc6vbZ1waA+R7wEpES+Y8INutjvWmcTdmeuXGBAOzWFD2XjUdMhKIy+9iBhgrMhr8Q8J1RG8UvBDcn0qxxE7CVq21NokingJ8wuwcWwDKFlJ30K8qqXMWTAQi4G7CvLGebjUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n8gEJ91/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC29C32782;
	Mon, 19 Aug 2024 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062931;
	bh=76IfUajEPgxYQVvDKE2Y47gkZXo96F4PlGC1qqytf/s=;
	h=Subject:To:Cc:From:Date:From;
	b=n8gEJ91/vGLbEAx09Egqkq7qjC1MZFbZYji3OqYQzvbS4BazfOda6QJurlE86DQzK
	 5ZOIlINX+wnM1cn+nZHCHV8ciCVVKsS4AAk97DHbcKxvVpLjqiJXPEkiAeyS6YvaD7
	 v/jLGd/G7DDvFVntEAgr6mTwmVYgPIw4Nyg7sH4Y=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix MST BW calculation Regression" failed to apply to 5.4-stable tree
To: Jerry.Zuo@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:21:56 +0200
Message-ID: <2024081956-latter-uproar-9ce6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 338567d17627064dba63cf063459605e782f71d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081956-latter-uproar-9ce6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

338567d17627 ("drm/amd/display: Fix MST BW calculation Regression")
00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
da87132f641e ("drm/amd/display: Add some DCN401 reg name to macro definitions")
ef319dff5475 ("drm/amd/display: add support for chroma offset")
a41aa6a7d0a6 ("drm/amd/display: Add comments to improve the code readability")
5324e2b205a2 ("drm/amd/display: Add driver support for future FAMS versions")
f3736c0d979a ("drm/amd/display: Add code comments clock and encode code")
8b2cb32cf0c6 ("drm/amd/display: FEC overhead should be checked once for mst slot nums")
4df96ba66760 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
2dbe9c2b2685 ("drm/amd/display: add DCN 351 version for microcode load")
1c5c36530a57 ("drm/amd/display: Set DCN351 BB and IP the same as DCN35")
5034b935f62a ("drm/amd/display: Modify DHCUB waterwark structures and functions")
9d43241953f7 ("drm/amd/display: Refactor DML2 interfaces")
8cffa89bd5e2 ("drm/amd/display: Expand DML2 callbacks")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
88867807564e ("drm/amd/display: Refactor DPP into a component directory")
eed4edda910f ("drm/amd/display: Support long vblank feature")
caef6c453cf2 ("drm/amd/display: Add DML2 folder to include path")
2d7f3d1a5866 ("drm/amd/display: Implement wait_for_odm_update_pending_complete")
4f5b8d78ca43 ("drm/amd/display: Init DPPCLK from SMU on dcn32")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 338567d17627064dba63cf063459605e782f71d2 Mon Sep 17 00:00:00 2001
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Date: Mon, 29 Jul 2024 10:23:03 -0400
Subject: [PATCH] drm/amd/display: Fix MST BW calculation Regression

[Why & How]
Revert commit 8b2cb32cf0c6
("drm/amd/display: FEC overhead should be checked once for mst slot nums")
Because causes bw calculation regression

Cc: mario.limonciello@amd.com
Cc: alexander.deucher@amd.com
Reported-by: jirislaby@kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3495
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1228093
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 12dbb3ed212fc7655fce421542a5add637f8af7a)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 915eb2c08ece..2e9f6da1acdc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -804,12 +804,25 @@ struct dsc_mst_fairness_params {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-static int kbps_to_peak_pbn(int kbps)
+static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
+{
+	u8 link_coding_cap;
+	uint16_t fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B;
+
+	link_coding_cap = dc_link_dp_mst_decide_link_encoding_format(dc_link);
+	if (link_coding_cap == DP_128b_132b_ENCODING)
+		fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B;
+
+	return fec_overhead_multiplier_x1000;
+}
+
+static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x1000)
 {
 	u64 peak_kbps = kbps;
 
 	peak_kbps *= 1006;
-	peak_kbps = div_u64(peak_kbps, 1000);
+	peak_kbps *= fec_overhead_multiplier_x1000;
+	peak_kbps = div_u64(peak_kbps, 1000 * 1000);
 	return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
 }
 
@@ -910,11 +923,12 @@ static int increase_dsc_bpp(struct drm_atomic_state *state,
 	int link_timeslots_used;
 	int fair_pbn_alloc;
 	int ret = 0;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled) {
 			initial_slack[i] =
-			kbps_to_peak_pbn(params[i].bw_range.max_kbps) - vars[i + k].pbn;
+			kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec_overhead_multiplier_x1000) - vars[i + k].pbn;
 			bpp_increased[i] = false;
 			remaining_to_increase += 1;
 		} else {
@@ -1010,6 +1024,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	int next_index;
 	int remaining_to_try = 0;
 	int ret;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled
@@ -1039,7 +1054,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 		if (next_index == -1)
 			break;
 
-		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps);
+		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 		ret = drm_dp_atomic_find_time_slots(state,
 						    params[next_index].port->mgr,
 						    params[next_index].port,
@@ -1052,8 +1067,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 			vars[next_index].dsc_enabled = false;
 			vars[next_index].bpp_x16 = 0;
 		} else {
-			vars[next_index].pbn = kbps_to_peak_pbn(
-				params[next_index].bw_range.max_kbps);
+			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 			ret = drm_dp_atomic_find_time_slots(state,
 							    params[next_index].port->mgr,
 							    params[next_index].port,
@@ -1082,6 +1096,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int count = 0;
 	int i, k, ret;
 	bool debugfs_overwrite = false;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	memset(params, 0, sizeof(params));
 
@@ -1146,7 +1161,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	/* Try no compression */
 	for (i = 0; i < count; i++) {
 		vars[i + k].aconnector = params[i].aconnector;
-		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
+		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 		vars[i + k].dsc_enabled = false;
 		vars[i + k].bpp_x16 = 0;
 		ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr, params[i].port,
@@ -1165,7 +1180,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	/* Try max compression */
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps, fec_overhead_multiplier_x1000);
 			vars[i + k].dsc_enabled = true;
 			vars[i + k].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1173,7 +1188,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			if (ret < 0)
 				return ret;
 		} else {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 			vars[i + k].dsc_enabled = false;
 			vars[i + k].bpp_x16 = 0;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index fa84d34b7373..600d6e221011 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -46,6 +46,9 @@
 #define SYNAPTICS_CASCADED_HUB_ID  0x5A
 #define IS_SYNAPTICS_CASCADED_PANAMERA(devName, data) ((IS_SYNAPTICS_PANAMERA(devName) && ((int)data[2] == SYNAPTICS_CASCADED_HUB_ID)) ? 1 : 0)
 
+#define PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B     1031
+#define PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B  1000
+
 enum mst_msg_ready_type {
 	NONE_MSG_RDY_EVENT = 0,
 	DOWN_REP_MSG_RDY_EVENT = 1,


