Return-Path: <stable+bounces-16170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E683F186
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD3CB21A99
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C41F946;
	Sat, 27 Jan 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GTWlWcva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160C1F95B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397006; cv=none; b=Y/GuW2MX+j3IEEeNyr3BjhVPUsfbRnJ9FIh1w4dDjoaGro57CJXAIibwegkIKx3KYztzGv7SOsuPjgXGHxG1noPvX1VupiIkKj0r40iImbEISuqAV2GszJvPP1wB3A6/F4DgXWwxkRaHaqFrZo49q6kSWJDDQANd7m2E1EgIY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397006; c=relaxed/simple;
	bh=9egQMw2YJfkfHIZhSRwfQfRQLBH4KfYrRX95azqi4hw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W11tHhcMFoSZaiVrNL41f8rj9ZxLZM69ISbRy8IyO0ll3eru7PiTtptl8SorhimOW+xY5MS33Oic/8RxARw4NPmLWdPS+sd6l0QFgDk00r9zFqAd31dsuFbvP3qk3gkQ6DEPKLUvEp7CCIdiqD/h8dlWWfBGplBdR+PlLhGQ+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GTWlWcva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF831C433C7;
	Sat, 27 Jan 2024 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397005;
	bh=9egQMw2YJfkfHIZhSRwfQfRQLBH4KfYrRX95azqi4hw=;
	h=Subject:To:Cc:From:Date:From;
	b=GTWlWcvaQ4T0luJ1YoOPVwFvD216uEVA/cM0ruH4dzdOg13kiVLHputal0GXhTGcw
	 LlZPMlZFtrjAC1DZhduwGk2Aruauthxxz5GS+F8ExuBuLQ4diCcOTE93focw4SIx8n
	 dxBfZm3oJElAeyeNlvdi/x9gp+q7CCHxvZpOHu+M=
Subject: FAILED: patch "[PATCH] drm/amd/display: Wake DMCUB before executing GPINT commands" failed to apply to 6.1-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,hansen.dsouza@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:09:56 -0800
Message-ID: <2024012756-pauper-underdog-470b@gregkh>
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
git cherry-pick -x e5ffd1263dd5b44929c676171802e7b6af483f21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012756-pauper-underdog-470b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e5ffd1263dd5 ("drm/amd/display: Wake DMCUB before executing GPINT commands")
8892780834ae ("drm/amd/display: Wake DMCUB before sending a command")
8e57c06bf4b0 ("drm/amd/display: Refactor DMCUB enter/exit idle interface")
0f657938e434 ("drm/amd/display: do not send commands to DMUB if DMUB is inactive from S3")
c41028a2a163 ("drm/amd/display: add a debugfs interface for the DMUB trace mask")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5ffd1263dd5b44929c676171802e7b6af483f21 Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Tue, 5 Dec 2023 11:22:56 -0500
Subject: [PATCH] drm/amd/display: Wake DMCUB before executing GPINT commands

[Why]
DMCUB can be in idle when we attempt to interface with the HW through
the GPINT mailbox resulting in a system hang.

[How]
Add dc_wake_and_execute_gpint() to wrap the wake, execute, sleep
sequence.

If the GPINT executes successfully then DMCUB will be put back into
sleep after the optional response is returned.

It functions similar to the inbox command interface.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 98b41ec7288e..68a846323912 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2976,7 +2976,6 @@ static int dmub_trace_mask_set(void *data, u64 val)
 	struct amdgpu_device *adev = data;
 	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
 	enum dmub_gpint_command cmd;
-	enum dmub_status status;
 	u64 mask = 0xffff;
 	u8 shift = 0;
 	u32 res;
@@ -3003,13 +3002,7 @@ static int dmub_trace_mask_set(void *data, u64 val)
 			break;
 		}
 
-		status = dmub_srv_send_gpint_command(srv, cmd, res, 30);
-
-		if (status == DMUB_STATUS_TIMEOUT)
-			return -ETIMEDOUT;
-		else if (status == DMUB_STATUS_INVALID)
-			return -EINVAL;
-		else if (status != DMUB_STATUS_OK)
+		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, res, NULL, DM_DMUB_WAIT_TYPE_WAIT))
 			return -EIO;
 
 		usleep_range(100, 1000);
@@ -3026,7 +3019,6 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 	enum dmub_gpint_command cmd = DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD0;
 	struct amdgpu_device *adev = data;
 	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
-	enum dmub_status status;
 	u8 shift = 0;
 	u64 raw = 0;
 	u64 res = 0;
@@ -3036,23 +3028,12 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 		return -EINVAL;
 
 	while (i < 4) {
-		status = dmub_srv_send_gpint_command(srv, cmd, 0, 30);
-
-		if (status == DMUB_STATUS_OK) {
-			status = dmub_srv_get_gpint_response(srv, (u32 *) &raw);
-
-			if (status == DMUB_STATUS_INVALID)
-				return -EINVAL;
-			else if (status != DMUB_STATUS_OK)
-				return -EIO;
-		} else if (status == DMUB_STATUS_TIMEOUT) {
-			return -ETIMEDOUT;
-		} else if (status == DMUB_STATUS_INVALID) {
-			return -EINVAL;
-		} else {
+		uint32_t response;
+
+		if (!dc_wake_and_execute_gpint(adev->dm.dc->ctx, cmd, 0, &response, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 			return -EIO;
-		}
 
+		raw = response;
 		usleep_range(100, 1000);
 
 		cmd++;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index fea13bcd4dc7..4b93e7a529d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -301,17 +301,11 @@ bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask)
 {
-	struct dmub_srv *dmub;
-	const uint32_t timeout = 30;
-
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
-	dmub = dc_dmub_srv->dmub;
-
-	return dmub_srv_send_gpint_command(
-		       dmub, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
-		       stream_mask, timeout) == DMUB_STATUS_OK;
+	return dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
+					 stream_mask, NULL, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv)
@@ -1126,25 +1120,20 @@ bool dc_dmub_check_min_version(struct dmub_srv *srv)
 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
-	struct dmub_srv *dmub;
-	enum dmub_status status;
-	static const uint32_t timeout_us = 30;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
 
-	dmub = dc_dmub_srv->dmub;
-
-	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1, 0x0010, timeout_us);
-	if (status != DMUB_STATUS_OK) {
+	if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1,
+				       0x0010, NULL, DM_DMUB_WAIT_TYPE_WAIT)) {
 		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
 		return;
 	}
 
-	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK, 0x0000, timeout_us);
-	if (status != DMUB_STATUS_OK) {
+	if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK,
+				       0x0000, NULL, DM_DMUB_WAIT_TYPE_WAIT)) {
 		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
 		return;
 	}
@@ -1368,3 +1357,52 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 
 	return result;
 }
+
+static bool dc_dmub_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+				  uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type)
+{
+	struct dc_dmub_srv *dc_dmub_srv = ctx->dmub_srv;
+	const uint32_t wait_us = wait_type == DM_DMUB_WAIT_TYPE_NO_WAIT ? 0 : 30;
+	enum dmub_status status;
+
+	if (response)
+		*response = 0;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	status = dmub_srv_send_gpint_command(dc_dmub_srv->dmub, command_code, param, wait_us);
+	if (status != DMUB_STATUS_OK) {
+		if (status == DMUB_STATUS_TIMEOUT && wait_type == DM_DMUB_WAIT_TYPE_NO_WAIT)
+			return true;
+
+		return false;
+	}
+
+	if (response && wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+		dmub_srv_get_gpint_response(dc_dmub_srv->dmub, response);
+
+	return true;
+}
+
+bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+			       uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type)
+{
+	struct dc_dmub_srv *dc_dmub_srv = ctx->dmub_srv;
+	bool result = false, reallow_idle = false;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	if (dc_dmub_srv->idle_allowed) {
+		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, false);
+		reallow_idle = true;
+	}
+
+	result = dc_dmub_execute_gpint(ctx, command_code, param, response, wait_type);
+
+	if (result && reallow_idle)
+		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 784ca3e44414..952bfb368886 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -145,5 +145,16 @@ bool dc_wake_and_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cm
 bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count,
 				       union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
+/**
+ * dc_wake_and_execute_gpint()
+ *
+ * @ctx: DC context
+ * @command_code: The command ID to send to DMCUB
+ * @param: The parameter to message DMCUB
+ * @response: Optional response out value - may be NULL.
+ * @wait_type: The wait behavior for the execution
+ */
+bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
+			       uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type);
 
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3d7cef17f881..3e243e407bb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -105,23 +105,18 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
  */
 static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state, uint8_t panel_inst)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint32_t raw_state = 0;
 	uint32_t retry_count = 0;
-	enum dmub_status status;
 
 	do {
 		// Send gpint command and wait for ack
-		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, panel_inst, 30);
-
-		if (status == DMUB_STATUS_OK) {
-			// GPINT was executed, get response
-			dmub_srv_get_gpint_response(srv, &raw_state);
+		if (dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__GET_PSR_STATE, panel_inst, &raw_state,
+					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
 			*state = convert_psr_state(raw_state);
-		} else
+		} else {
 			// Return invalid state when GPINT times out
 			*state = PSR_STATE_INVALID;
-
+		}
 	} while (++retry_count <= 1000 && *state == PSR_STATE_INVALID);
 
 	// Assert if max retry hit
@@ -452,13 +447,11 @@ static void dmub_psr_force_static(struct dmub_psr *dmub, uint8_t panel_inst)
  */
 static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency, uint8_t panel_inst)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
 	/* Send gpint command and wait for ack */
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__PSR_RESIDENCY, param, 30);
-
-	dmub_srv_get_gpint_response(srv, residency);
+	dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__PSR_RESIDENCY, param, residency,
+				  DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
 
 static const struct dmub_psr_funcs psr_funcs = {


