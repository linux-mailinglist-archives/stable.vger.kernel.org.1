Return-Path: <stable+bounces-172568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FCB3278E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D561BC50E3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D921ABB0;
	Sat, 23 Aug 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ct8/sBl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F220299E
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936401; cv=none; b=aPmsbGIOajILPo376RGeLRbciLMPNYwF5TnMUerNB41PQWtwC17UWZODB3OXm/o0OFuXoD7j8+TOFr+BLBVH9yy/dKS8qmpFD1z9rJSCZ20jZTJ6RqvVCI/24+db5RfXWB3KsN61qtcOzTtvceuJlcQQS9VZnmBLc+z/c6Cww2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936401; c=relaxed/simple;
	bh=dCNaWFNAdE+5FtgM/RPp47vX5hAnBejjT8+8rhmjQ40=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QbDR8VBv2o1om+lHkUzVDPR6BSL+G1nHgQKfeE+ifyHUzJiakpigdl5/iw/Hi4p/nboDhsBgNccayAsCUFY/Po/SW8RKAapTbPvS/YWz950UFttyAqvTwDolnNKD1sJsHhxguxZnNi74/xQh850uUgKilCGDF3O5B1/YfScC1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ct8/sBl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E1CC4CEE7;
	Sat, 23 Aug 2025 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755936399;
	bh=dCNaWFNAdE+5FtgM/RPp47vX5hAnBejjT8+8rhmjQ40=;
	h=Subject:To:Cc:From:Date:From;
	b=ct8/sBl1ufqpMpYsAkkUmD2nSeQjdfZ8rVxFyPTje1iOKkkFXuGoghRHxDKd3S9nI
	 8xx7/1jP3pnq5yCmMqXV1J2cYuLBVKqxGBBJJ2WF6Rpnlh4UX+YD3HcIes06QPn2Zd
	 iGkv7OB9FMzDkQL5+h76QFql0ytLtvAmk3AJjON0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Don't overclock DCE 6 by 15%" failed to apply to 6.6-stable tree
To: timur.kristof@gmail.com,alex.hung@amd.com,alexander.deucher@amd.com,siqueira@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 10:06:36 +0200
Message-ID: <2025082336-hasty-pregame-9547@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cb7b7ae53b557d168b4af5cd8549f3eff920bfb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082336-hasty-pregame-9547@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb7b7ae53b557d168b4af5cd8549f3eff920bfb5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Thu, 31 Jul 2025 11:43:46 +0200
Subject: [PATCH] drm/amd/display: Don't overclock DCE 6 by 15%
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 6 which
is already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also adds a check to make sure
not to exceed the maximum DCE 6 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Fixes: 3ecb3b794e2c ("drm/amd/display: dc/clk_mgr: add support for SI parts (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 427980c1cbd22bb256b9385f5ce73c0937562408)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..cfd7309f2c6a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -123,11 +123,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */


