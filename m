Return-Path: <stable+bounces-293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41A7F7647
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB31C21199
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA02D03C;
	Fri, 24 Nov 2023 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8LwQh8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC042D02F
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9346C4339A;
	Fri, 24 Nov 2023 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835773;
	bh=pS4O6+adzkFf9ThOM1q5ayDg4kXd0Ks2XcQ03xCXhlY=;
	h=Subject:To:Cc:From:Date:From;
	b=R8LwQh8IezkaaQ7zsKyLvJoksKmTzVxM25Bb8C2rma/g1VHOTC+rUwF2POYjY0Kxp
	 ws1gdYNSWlYVdgcuWHLb40ad7a7puP2ZLAorN3cAnpXhnjTNyiob66BKmW8SwIRWYE
	 YMkMy1y6mgVhALRQYb7FGMYp5sYQebNb5fBCxPnw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Negate IPS allow and commit bits" failed to apply to 6.1-stable tree
To: duncan.ma@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:22:45 +0000
Message-ID: <2023112445-mutilator-landed-4578@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5e8a0d3598b47ee5a57708072bdef08816264538
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112445-mutilator-landed-4578@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5e8a0d3598b4 ("drm/amd/display: Negate IPS allow and commit bits")
92e11f0159f6 ("drm/amd/display: Enable more IPS options")
da2d16fcdda3 ("drm/amd/display: Fix IPS handshake for idle optimizations")
d591284288c2 ("drm/amd/display: Add a check for idle power optimization")
d5f9a92bd1e2 ("drm/amd/display: Revert "Improve x86 and dmub ips handshake"")
bf7951561051 ("drm/amd/display: reprogram det size while seamless boot")
d0a767f7b8e2 ("drm/amd/display: Revert "drm/amd/display: Add a check for idle power optimization"")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")
2358ecdabe37 ("drm/amd/display: 3.2.254")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e8a0d3598b47ee5a57708072bdef08816264538 Mon Sep 17 00:00:00 2001
From: Duncan Ma <duncan.ma@amd.com>
Date: Wed, 25 Oct 2023 19:07:21 -0400
Subject: [PATCH] drm/amd/display: Negate IPS allow and commit bits

[WHY]
On s0i3, IPS mask isn't saved and restored.
It is reset to zero on exit.

If it is cleared unexpectedly, driver will
proceed operations while DCN is in IPS2 and
cause a hang.

[HOW]
Negate the bit logic. Default value of
zero indicates it is still in IPS2. Driver
must poll for the bit to assert.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0fa4fcd00de2..507a7cf56711 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -820,22 +820,22 @@ static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
 
 	if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
 		dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 		val = val & ~DMUB_IPS1_ALLOW_MASK;
 		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
 	}
 
 	if (!allow_idle) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
 	}
 
 	dcn35_smu_write_ips_scratch(clk_mgr, val);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d8f434738212..76b47f178127 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4934,8 +4934,8 @@ bool dc_dmub_is_ips_idle_state(struct dc *dc)
 	if (dc->hwss.get_idle_state)
 		idle_state = dc->hwss.get_idle_state(dc);
 
-	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
-		(idle_state & DMUB_IPS2_ALLOW_MASK))
+	if (!(idle_state & DMUB_IPS1_ALLOW_MASK) ||
+		!(idle_state & DMUB_IPS2_ALLOW_MASK))
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index e4c007203318..0e07699c1e83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1202,11 +1202,11 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		allow_state = dc->hwss.get_idle_state(dc);
 		dc->hwss.set_idle_state(dc, false);
 
-		if (allow_state & DMUB_IPS2_ALLOW_MASK) {
+		if (!(allow_state & DMUB_IPS2_ALLOW_MASK)) {
 			// Wait for evaluation time
 			udelay(dc->debug.ips2_eval_delay_us);
 			commit_state = dc->hwss.get_idle_state(dc);
-			if (commit_state & DMUB_IPS2_COMMIT_MASK) {
+			if (!(commit_state & DMUB_IPS2_COMMIT_MASK)) {
 				// Tell PMFW to exit low power state
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
@@ -1216,7 +1216,7 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 				for (i = 0; i < max_num_polls; ++i) {
 					commit_state = dc->hwss.get_idle_state(dc);
-					if (!(commit_state & DMUB_IPS2_COMMIT_MASK))
+					if (commit_state & DMUB_IPS2_COMMIT_MASK)
 						break;
 
 					udelay(1);
@@ -1235,10 +1235,10 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (allow_state & DMUB_IPS1_ALLOW_MASK) {
+		if (!(allow_state & DMUB_IPS1_ALLOW_MASK)) {
 			for (i = 0; i < max_num_polls; ++i) {
 				commit_state = dc->hwss.get_idle_state(dc);
-				if (!(commit_state & DMUB_IPS1_COMMIT_MASK))
+				if (commit_state & DMUB_IPS1_COMMIT_MASK)
 					break;
 
 				udelay(1);


