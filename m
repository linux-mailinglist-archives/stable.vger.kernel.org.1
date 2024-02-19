Return-Path: <stable+bounces-20646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B22EA85AAC2
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4711B2222A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEE481B2;
	Mon, 19 Feb 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nM0/8t2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9247F79
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366692; cv=none; b=mYcV9Jj80M5LR12ns9JJQPvTQeNEfiFixSeyECcKdVswf9JC3HifWQVZ811Ap7j6nByXGatAW/ZfxNVDgSfk1zg0rmg5L/KvKWdG0Ft9TbRqSBWTMjw+DCFNO1Tnoia3AGFPe/8sSN6e73AyauraGsKL6uoE91Y4gjkoQtAq5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366692; c=relaxed/simple;
	bh=1zST9+VkVHybu7w/+4UBThjFt0PL7LisD4vRK2CU0JI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dCaI8a/HrVnMkdRTvWXegV3dlDym1ttj3GcDSI1BPM/hXKifSgktNY5oBIP1mx9qFoDGg2wrWwR6Bq3XfDM53jJVuGBbKYrK/2GJOqG4DRdTBpzz9JIELUysjWF+un2VOb8ntGRoRDkhrB65dW/FNWgyzOHqpmCanorG4OQvTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nM0/8t2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44661C433C7;
	Mon, 19 Feb 2024 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366691;
	bh=1zST9+VkVHybu7w/+4UBThjFt0PL7LisD4vRK2CU0JI=;
	h=Subject:To:Cc:From:Date:From;
	b=nM0/8t2JbRBACchButqZGlP50ZtRkKueweWKgbNMaRggw/X00RWg7n2V4MFWMDlTA
	 QUmomFiO3/a85oWyg+pYb8y9oaXC/zx+iKyPnoQidh/qtwTA4yDI2vhtZL5zD5QEcB
	 WHydRLrmx64yL0XYsU4TQ5q7Xblw/3nUTd9/Escw=
Subject: FAILED: patch "[PATCH] drm/amd/display: set odm_combine_policy based on context in" failed to apply to 6.7-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,chaitanya.dhere@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:18:05 +0100
Message-ID: <2024021905-conceded-surfacing-5652@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 2103370afba74dda39ff5d2d69163c86644ce528
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021905-conceded-surfacing-5652@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

2103370afba7 ("drm/amd/display: set odm_combine_policy based on context in dcn32 resource")
dd2c5fac91d4 ("drm/amd/display: Add ODM check during pipe split/merge validation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2103370afba74dda39ff5d2d69163c86644ce528 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Thu, 18 Jan 2024 18:12:15 -0500
Subject: [PATCH] drm/amd/display: set odm_combine_policy based on context in
 dcn32 resource

[why]
When populating dml pipes, odm combine policy should be assigned based
on the pipe topology of the context passed in. DML pipes could be
repopulated multiple times during single validate bandwidth attempt. We
need to make sure that whenever we repopulate the dml pipes it is always
aligned with the updated context. There is a case where DML pipes get
repopulated during FPO optimization after ODM combine policy is changed.
Since in the current code we reinitlaize ODM combine policy, even though
the current context has ODM combine enabled, we overwrite it despite the
pipes are already split. This causes DML to think that MPC combine is
used so we mistakenly enable MPC combine because we apply pipe split
with ODM combine policy reset. This issue doesn't impact non windowed
MPO with ODM case because the legacy policy has restricted use cases. We
don't encounter the case where both ODM and FPO optimizations are
enabled together. So we decide to leave it as is because it is about to
be replaced anyway.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index dd781a20692e..ba76dd4a2ce2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1288,7 +1288,7 @@ static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *contex
 	return updated;
 }
 
-static bool should_allow_odm_power_optimization(struct dc *dc,
+static bool should_apply_odm_power_optimization(struct dc *dc,
 		struct dc_state *context, struct vba_vars_st *v, int *split,
 		bool *merge)
 {
@@ -1392,9 +1392,12 @@ static void try_odm_power_optimization_and_revalidate(
 {
 	int i;
 	unsigned int new_vlevel;
+	unsigned int cur_policy[MAX_PIPES];
 
-	for (i = 0; i < pipe_cnt; i++)
+	for (i = 0; i < pipe_cnt; i++) {
+		cur_policy[i] = pipes[i].pipe.dest.odm_combine_policy;
 		pipes[i].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+	}
 
 	new_vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
@@ -1403,6 +1406,9 @@ static void try_odm_power_optimization_and_revalidate(
 		memset(merge, 0, MAX_PIPES * sizeof(bool));
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, new_vlevel, split, merge);
 		context->bw_ctx.dml.vba.VoltageLevel = *vlevel;
+	} else {
+		for (i = 0; i < pipe_cnt; i++)
+			pipes[i].pipe.dest.odm_combine_policy = cur_policy[i];
 	}
 }
 
@@ -1580,7 +1586,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		}
 	}
 
-	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
+	if (should_apply_odm_power_optimization(dc, context, vba, split, merge))
 		try_odm_power_optimization_and_revalidate(
 				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
 
@@ -2209,7 +2215,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		int i;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
-		dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
+		if (!dc->config.enable_windowed_mpo_odm)
+			dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
 
 		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
 		 * we have to re-calculate the DET allocation and run through DML once more to
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c958ef37b78a..77a60aa9f27b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -427,22 +427,18 @@ struct pipe_ctx *resource_get_primary_dpp_pipe(const struct pipe_ctx *dpp_pipe);
 int resource_get_mpc_slice_index(const struct pipe_ctx *dpp_pipe);
 
 /*
- * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
- * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
- * the number of MPC "cuts" for the plane.
+ * Get the number of MPC slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an MPC combine
+ * pipe topology.
  */
-int resource_get_mpc_slice_count(const struct pipe_ctx *opp_head);
+int resource_get_mpc_slice_count(const struct pipe_ctx *pipe);
 
 /*
- * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
- * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for ODM combine. otherwise
- * the number of ODM "cuts" for the timing.
+ * Get the number of ODM slices associated with the pipe.
+ * The function returns 0 if the pipe is not associated with an ODM combine
+ * pipe topology.
  */
-int resource_get_odm_slice_count(const struct pipe_ctx *otg_master);
+int resource_get_odm_slice_count(const struct pipe_ctx *pipe);
 
 /* Get the ODM slice index counting from 0 from left most slice */
 int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c4d71e7f18af..6f10052caeef 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1829,7 +1829,21 @@ int dcn32_populate_dml_pipes_from_context(
 		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
 		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		if (dc->config.enable_windowed_mpo_odm &&
+				dc->debug.enable_single_display_2to1_odm_policy) {
+			switch (resource_get_odm_slice_count(pipe)) {
+			case 2:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+				break;
+			case 4:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+				break;
+			default:
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+			}
+		} else {
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		}
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;


