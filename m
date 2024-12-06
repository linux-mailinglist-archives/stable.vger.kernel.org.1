Return-Path: <stable+bounces-99075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5EA9E6F39
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2661282B5E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570BA20764F;
	Fri,  6 Dec 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sN2zI9ku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780D206F2F
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491417; cv=none; b=FFNHpuJZcUmSTIMjACA4ofk588CvR7Erlu2AWXryV/rJSRDhvkA5BLnLcjqmaE1wtmhRTsOnh+m48PdGSUSqpaILmIOrGh1p7I/SRp0EGs8ekrb9CvsXqP+kzouGxsZzTaqrMhXWTn3YWy3STXDsfPPoFa5XKACjCZBSUNpwlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491417; c=relaxed/simple;
	bh=Na+vxHc/Yljsvb9IAC+9T7IcPIC3o+QJrc/zTJJ/nLw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=poV3oVqQvi+xPb/mJCjufMJiq+xU+S8N44REPoi+jCFLyJL8BhybZN3BVVWFqWSecLOxuLVfotPvrZHW0bbTWsTjE12naeg97dsFt9ypiZqw5BvRDn/QYu9ImZm/KCtk5yQgPwDHvgth1R9EyJ/b3HwbVdrJ8IfpfcRghSRLaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sN2zI9ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D920C4CED1;
	Fri,  6 Dec 2024 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733491416;
	bh=Na+vxHc/Yljsvb9IAC+9T7IcPIC3o+QJrc/zTJJ/nLw=;
	h=Subject:To:Cc:From:Date:From;
	b=sN2zI9ku6EMGtKkQGfzUgq7PJDyFki7Xb3cqr4QLwL5mUeXYQ3VPTRNVtX+vKWSCk
	 L/F5a0+Qnn+YY5cRq7pnLAOXdv499JRgaDCbTUddSeTmIERvncpych+mp7hmREUzbH
	 NaE4oqSnb8St/A5qrRS/HXwu40AL/bSnb4jmslMc=
Subject: FAILED: patch "[PATCH] drm/amd/display: Populate Power Profile In Case of Early" failed to apply to 6.12-stable tree
To: Austin.Zheng@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,dillon.varone@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:22:26 +0100
Message-ID: <2024120626-expire-joining-ee6b@gregkh>
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
git cherry-pick -x c3ea03c2a1557644386e38aaf2b5a9c261e0be1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120626-expire-joining-ee6b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3ea03c2a1557644386e38aaf2b5a9c261e0be1a Mon Sep 17 00:00:00 2001
From: Austin Zheng <Austin.Zheng@amd.com>
Date: Tue, 5 Nov 2024 10:22:02 -0500
Subject: [PATCH] drm/amd/display: Populate Power Profile In Case of Early
 Return

Early return possible if context has no clk_mgr.
This will lead to an invalid power profile being returned
which looks identical to a profile with the lowest power level.
Add back logic that populated the power profile and overwrite
the value if needed.

Cc: stable@vger.kernel.org
Fixes: d016d0dd5a57 ("drm/amd/display: Update Interface to Check UCLK DPM")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0c1875d35a95..1dd26d5df6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6100,11 +6100,11 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 {
 	struct dc_power_profile profile = { 0 };
 
-	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
+	profile.power_level = !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	if (!context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
 		return profile;
 	struct dc *dc = context->clk_mgr->ctx->dc;
 
-
 	if (dc->res_pool->funcs->get_power_profile)
 		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
 	return profile;


