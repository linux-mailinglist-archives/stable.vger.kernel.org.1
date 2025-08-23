Return-Path: <stable+bounces-172566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04084B3278C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97475E5DE9
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC921ABB0;
	Sat, 23 Aug 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="muhlbktd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760520299E
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936353; cv=none; b=OCg97mBb8w6ov/M82wpbI02mUADCrJjrmbBno7VDETu2xR28yiNFRbrXxVMgZXEzJFqH0ETMmHM7wOOhP/dHMxQ6NCqAnVnCQ2FuNmxaauBCm/Zx4Oz9d+DOCKbcDcUX7DKWmLc0Wr3huZaaMUV/OsOQPDnoYEMB7e+RwodbuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936353; c=relaxed/simple;
	bh=jEHlHUQbThZfAZVg+r/Ogmzf+ixrwHDJALmcgWfrHaQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Cb6XbciXexU/z3iCuMKYcKQKFR7c9reXVnqDKUPNtKl/nUgFsgkuWcxJn3PGd8ukQTJUrFFRFjBvO81MzK2Qev9fSniEUH84rWaNmzxo96NVPXkphFlNtEd9ammTcSB4s6OkijhqKF/dly2rOBKI4mMZ/NvDMJOQFZ7l2o8cZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=muhlbktd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB34C4CEE7;
	Sat, 23 Aug 2025 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755936353;
	bh=jEHlHUQbThZfAZVg+r/Ogmzf+ixrwHDJALmcgWfrHaQ=;
	h=Subject:To:Cc:From:Date:From;
	b=muhlbktdfxh8x4wvPTpOqoGOYWJ1j25hFp4YYaFZQDC6uyRjLYzZKpA8XxzQB/TPm
	 I1Z+r08XIh1fegj2/p1TUdzPxzRGh+JyU3q1XXzZNc2egnxamQqlbfb3eMh+PMx3Qb
	 D2H8V1OX3Pp8DR+CQn1D6P04D7Dm94E0wDPKgRK4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Don't overclock DCE 6 by 15%" failed to apply to 5.15-stable tree
To: timur.kristof@gmail.com,alex.hung@amd.com,alexander.deucher@amd.com,siqueira@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 10:05:50 +0200
Message-ID: <2025082350-improper-wrecker-f81c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cb7b7ae53b557d168b4af5cd8549f3eff920bfb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082350-improper-wrecker-f81c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


