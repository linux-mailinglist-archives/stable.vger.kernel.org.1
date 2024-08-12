Return-Path: <stable+bounces-66574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE294F036
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1DBB2641A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E618733C;
	Mon, 12 Aug 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bATJEw2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34086184541
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474021; cv=none; b=T+LzcflXBj6KT2vt42gmErWGMOH4ckKjOWa2qgRylpH2CluY/XF3TbuzruigTxNdoD4gGw1e3cmOB4Cnuz0DK433YXl/iXqWdwOdTdk08FDFwlL77Yi8Zne+0RRpT87UCB7pSPkYtXNGFMdL31uMdBKqwHCNPCRuwfijOUfinKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474021; c=relaxed/simple;
	bh=8koKx4pJZlIh2MfZHh96XbFzYpWv5XkHHu11cBL95zw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eggdF6G6TDowPvL0xtX/HpmzbQnfnBDiGbkdNBS6TxFE3nj2Ln7SseBEfn3Janc2+kymsX2tZLSDkj8ed4vRsKl22cp1dlvBdkgyO84IAnYBmi7Av0k+3ViNctfcUgFV1mXy1z2pArDUj+tyWTkaNQ1kmrvimURA+WghM+f6Egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bATJEw2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADFC32782;
	Mon, 12 Aug 2024 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474021;
	bh=8koKx4pJZlIh2MfZHh96XbFzYpWv5XkHHu11cBL95zw=;
	h=Subject:To:Cc:From:Date:From;
	b=bATJEw2UgH/QLtLrtHisr7id0bTk+AnhJyaq0yNdpSEA2RGQ1DmvqPcpF2L+XvRBH
	 2UEiRM+lMTPIhp63cY8BF+hd1Lu6lCm4wosCJf88eqL0kkNj5TW28QmIZ6mqt/NyKP
	 TenMQ1dixU0K+glFRqlzoGZdruW1UBeXWg7EGqEw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Call dpmm when checking mode support" failed to apply to 5.10-stable tree
To: george.shen@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,chaitanya.dhere@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:46:40 +0200
Message-ID: <2024081239-pungent-monetize-073a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a42e74391783603b28f266fc7bbfc1011eb0a151
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081239-pungent-monetize-073a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a42e74391783 ("drm/amd/display: Call dpmm when checking mode support")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a42e74391783603b28f266fc7bbfc1011eb0a151 Mon Sep 17 00:00:00 2001
From: George Shen <george.shen@amd.com>
Date: Tue, 4 Jun 2024 10:11:23 -0400
Subject: [PATCH] drm/amd/display: Call dpmm when checking mode support

[WHY]
In check_mode_supported, we should validate that the required clocks
can be successfully mapped to DPM levels.

This ensures we only apply dynamic ODM optimizations to modes that
are supported without dynamic ODM optimizations to begin with.

[HOW]
Call dpmm to check that the display config can successfully be
mapped to a DPM level.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index b442e1f9f204..9c28304568d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -257,6 +257,7 @@ static bool dml21_check_mode_support(const struct dc *in_dc, struct dc_state *co
 
 	mode_support->dml2_instance = dml_init->dml2_instance;
 	dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
+	dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_programming_locals.mode_programming_params.programming = dml_ctx->v21.mode_programming.programming;
 	is_supported = dml2_check_mode_supported(mode_support);
 	if (!is_supported)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index 6f334fdc6eb8..2fb3e2f45e07 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -96,10 +96,15 @@ bool dml2_check_mode_supported(struct dml2_check_mode_supported_in_out *in_out)
 {
 	struct dml2_instance *dml = (struct dml2_instance *)in_out->dml2_instance;
 	struct dml2_check_mode_supported_locals *l = &dml->scratch.check_mode_supported_locals;
+	/* Borrow the build_mode_programming_locals programming struct for DPMM call. */
+	struct dml2_display_cfg_programming *dpmm_programming = dml->scratch.build_mode_programming_locals.mode_programming_params.programming;
 
 	bool result = false;
 	bool mcache_success = false;
 
+	if (dpmm_programming)
+		memset(dpmm_programming, 0, sizeof(struct dml2_display_cfg_programming));
+
 	setup_unoptimized_display_config_with_meta(dml, &l->base_display_config_with_meta, in_out->display_config);
 
 	l->mode_support_params.instance = &dml->core_instance;
@@ -122,6 +127,18 @@ bool dml2_check_mode_supported(struct dml2_check_mode_supported_in_out *in_out)
 		mcache_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &mcache_phase);
 	}
 
+	/*
+	 * Call DPMM to map all requirements to minimum clock state
+	 */
+	if (result && dpmm_programming) {
+		l->dppm_map_mode_params.min_clk_table = &dml->min_clk_table;
+		l->dppm_map_mode_params.display_cfg = &l->base_display_config_with_meta;
+		l->dppm_map_mode_params.programming = dpmm_programming;
+		l->dppm_map_mode_params.soc_bb = &dml->soc_bbox;
+		l->dppm_map_mode_params.ip = &dml->core_instance.clean_me_up.mode_lib.ip;
+		result = dml->dpmm_instance.map_mode_to_soc_dpm(&l->dppm_map_mode_params);
+	}
+
 	in_out->is_supported = mcache_success;
 	result = result && in_out->is_supported;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index dd90c5df5a5a..5632cdacb7f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -870,6 +870,7 @@ struct dml2_check_mode_supported_locals {
 	struct dml2_optimization_phase_locals optimization_phase_locals;
 	struct display_configuation_with_meta base_display_config_with_meta;
 	struct display_configuation_with_meta optimized_display_config_with_meta;
+	struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out dppm_map_mode_params;
 };
 
 struct optimization_init_function_params {


