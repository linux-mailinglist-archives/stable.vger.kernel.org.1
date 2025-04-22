Return-Path: <stable+bounces-135029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F72A95E1B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAA8189933E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F561F473A;
	Tue, 22 Apr 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDt3Y+0v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F6135A63
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303181; cv=none; b=NTjTD73xCoi38zDitXpxdFd0rUFbpLayxhPJA7Qaf3OFNpigxHBfjqAafXJ9LjdKTWb0MNK9u3wHu7nekEXE1WkfdHRSb0a8YmnWNrIQe14J3/DE7j8Ij+BiU0zVy3TUMsL7s2cHczpvfRxwvxvANa7ryuEFMzAoQxlTjPwUsd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303181; c=relaxed/simple;
	bh=W36oUdZ7M+28Go8SSJmowUuAwNVvgNpI47APQ2t/cfM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qfviVxuelFjc+Yy1T6+ZPX0weBD12Pc+mRl3Ee1KiSndWyjMopTBnXJSWq2IYxLGpXT3jukALjr+IbKIeXFy+hT+qYzPmpI+9iQdJ4KyHKRcP7cBSgPmK+HIoF5HoNP1WcuFVTq1G3Qcep1zqeLYaWt/JCRf0dif8uc+Ym3yxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDt3Y+0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB2FC4CEE9;
	Tue, 22 Apr 2025 06:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303180;
	bh=W36oUdZ7M+28Go8SSJmowUuAwNVvgNpI47APQ2t/cfM=;
	h=Subject:To:Cc:From:Date:From;
	b=uDt3Y+0v3vss+4zLMDRvk0KVlaPPyorSR1KFKecSIrSiwQwG2r3kDj83XEWf0tLBJ
	 JkJfajYI9l37ziwhp/YBVqA1URUBwwEBVUnNubmZWhuqK17ltfJiazu9Ssv+lvjrek
	 RlkmKWLnkzMCtimXEZQSvpanF2c4jOd4sp0/LYb4=
Subject: FAILED: patch "[PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc" failed to apply to 6.12-stable tree
To: alexander.deucher@amd.com,aurabindo.pillai@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:26:18 +0200
Message-ID: <2025042218-sturdily-railroad-e879@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cd9e6d6fdd2de60bfb4672387c17d4ee7157cf8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042218-sturdily-railroad-e879@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd9e6d6fdd2de60bfb4672387c17d4ee7157cf8e Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Tue, 8 Apr 2025 21:27:15 -0400
Subject: [PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc

The structures are large and they do not require contiguous
memory so use vzalloc.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4126
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 20c50a9a793300a1fc82f3ddd0e3c68f8213fbef)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 94e99e540691..5d16f36ec95c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include <linux/vmalloc.h>
 
 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -13,11 +14,11 @@
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	*dml_ctx = vzalloc(sizeof(struct dml2_context));
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
+	(*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -27,7 +28,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KERNEL);
+	(*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming));
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
@@ -115,8 +116,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 
 void dml21_destroy(struct dml2_context *dml2)
 {
-	kfree(dml2->v21.dml_init.dml2_instance);
-	kfree(dml2->v21.mode_programming.programming);
+	vfree(dml2->v21.dml_init.dml2_instance);
+	vfree(dml2->v21.mode_programming.programming);
 }
 
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index f549a778f6f1..e89571874185 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -24,6 +24,8 @@
  *
  */
 
+#include <linux/vmalloc.h>
+
 #include "display_mode_core.h"
 #include "dml2_internal_types.h"
 #include "dml2_utils.h"
@@ -747,7 +749,7 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 
 static inline struct dml2_context *dml2_allocate_memory(void)
 {
-	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	return (struct dml2_context *) vzalloc(sizeof(struct dml2_context));
 }
 
 static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
@@ -821,7 +823,7 @@ void dml2_destroy(struct dml2_context *dml2)
 
 	if (dml2->architecture == dml2_architecture_21)
 		dml21_destroy(dml2);
-	kfree(dml2);
+	vfree(dml2);
 }
 
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,


