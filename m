Return-Path: <stable+bounces-16167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172783F182
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AA41C21478
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45925200B2;
	Sat, 27 Jan 2024 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lokcuCZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072011F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396986; cv=none; b=gQc//XqMY1yUK1N3tqym8la0Aw6PutgFlNkjkpwekbIdeMh9SVDk2RxY12g/LqaG3/dmjP98iOvl85Tp2YhAfFjIdfcuahgNXpeGUKYb/KlV+x27jKA2fUsQuL7oxgBP5frBI79JhmAc3ztSyWKkFxPTE04RMF/TNy07KniCcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396986; c=relaxed/simple;
	bh=eDphjm5UNr/3JhWF0A1uOf+IAtVE9U2u2Yv/UXzvi0w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VEmjBF0zyHIeyhU5ZXz+UEZJw6DpeJPvgUFydVM+dRAyDN6sD3qhYx1NSo8b772mpLyeIHD7Mjnwgb7ziWrIkFOAzhOWosEV3QGIHOU+XTPJpJ077DC8lzUq9gpch8P+4/MwoG/PdOjIyi2p8EAGpQu7ZtwzS1dKfSXjgEDXVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lokcuCZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857DDC43390;
	Sat, 27 Jan 2024 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706396985;
	bh=eDphjm5UNr/3JhWF0A1uOf+IAtVE9U2u2Yv/UXzvi0w=;
	h=Subject:To:Cc:From:Date:From;
	b=lokcuCZSWdD3YLrjp89nD2xBpwFicMfvZrEUMuQ5oCtVEGD0OQPEGKmbUTHm6dro7
	 9TiRRFvzl2LkGO079U2x1tL28OvQ9be+5tDyQVm8wjh8Xs1Zabt80All+jr96S6LuV
	 idhQbjZYBnPg8sqRGqMbEW7KBGrrgl1PwuB3VKxY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Refactor DMCUB enter/exit idle interface" failed to apply to 6.1-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hansen.dsouza@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:09:43 -0800
Message-ID: <2024012743-shortcake-unsure-ebfd@gregkh>
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
git cherry-pick -x 8e57c06bf4b0f51a4d6958e15e1a99c9520d00fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012743-shortcake-unsure-ebfd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8e57c06bf4b0 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
0f657938e434 ("drm/amd/display: do not send commands to DMUB if DMUB is inactive from S3")
1ffa8602e39b ("drm/amd/display: Guard against invalid RPTR/WPTR being set")
b63eae94d28c ("drm/amd/display: clean up some inconsistent indenting")
10406abe036b ("drm/amd/display: make dc_set_power_state() return type `void` again")
1ca965719b5b ("drm/amd/display: Change dc_set_power_state() to bool instead of int")
7441ef0b3ebe ("drm/amd: Propagate failures in dc_set_power_state()")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
06b1661e45b4 ("drm/amd/display: Add DCN35 DM Support")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
920f879c8360 ("drm/amd/display: Add DCN35 PG_CNTL")
fb8c3ef80584 ("drm/amd/display: Update dc.h for DCN35 support")
5e77c339a291 ("drm/amd/display: Skip dmub memory flush when not needed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e57c06bf4b0f51a4d6958e15e1a99c9520d00fa Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Mon, 4 Dec 2023 14:10:05 -0500
Subject: [PATCH] drm/amd/display: Refactor DMCUB enter/exit idle interface

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
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54861136dafd..97776ba1c70a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2856,7 +2856,7 @@ static int dm_resume(void *handle)
 	bool need_hotplug = false;
 
 	if (dm->dc->caps.ips_support) {
-		dc_dmub_srv_exit_low_power_state(dm->dc);
+		dc_dmub_srv_apply_idle_power_optimizations(dm->dc, false);
 	}
 
 	if (amdgpu_in_reset(adev)) {
@@ -9001,7 +9001,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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


