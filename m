Return-Path: <stable+bounces-66681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC594F0B0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0446E1F21EF4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD3153BF6;
	Mon, 12 Aug 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCrmk9Rx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4D4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474386; cv=none; b=Uf0mSNKXqKx8xur97Ic8PPBNMH5VIJbuE9F/VA58AXxu7BX0EwQGqAaYRUbZB/nZc55+oiWc4x8P1UyBGmJzFS0htIq4tlfVP6exxQMq+T39pV3VFSWo3/2q41+9/3HOUx5ygZPM5v7sEl+7DUkcyZyEmWoKlQviN0wpNvET4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474386; c=relaxed/simple;
	bh=OIdMyt2W9OVNgu9ylY0RPAG6WZeY9sK1vY/OoOaoJZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uRDKccMmjEN1BAnspx3knv6pPpZa0RG3F+fYmxc3AzBQYVDKknB7Kec4AEdYiheqwnvk/7xp9231yigPSZfXrYIpHnHRoMxR79z0AcnX6f1Dt2tTiKOViuBFd+TwDRJFdtjsVe747BWDXaEp0CuRYVBx9eb12VK7B6Wg2r5J5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCrmk9Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6E4C4AF09;
	Mon, 12 Aug 2024 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474385;
	bh=OIdMyt2W9OVNgu9ylY0RPAG6WZeY9sK1vY/OoOaoJZY=;
	h=Subject:To:Cc:From:Date:From;
	b=OCrmk9Rxasp2W2GOkue+SyOgUFDUdsph/elxJCwvvnmqoBmD74Z1usLv3aMafjr7z
	 lYXyNrm+QKqu/hwijL3qDYnuyxQgYYIvQ90BOXREBi+clIAtGks58EZS3l8go1Lf5Q
	 oFYz7cBCKb9YrMC0ckD+NcLX16dLXamh8BZpaXVA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix idle optimization checks for" failed to apply to 5.4-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:50:35 +0200
Message-ID: <2024081235-precision-pacifist-0880@gregkh>
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
git cherry-pick -x 5922deae69beabae98644f3cd902df45da932297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081235-precision-pacifist-0880@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

5922deae69be ("drm/amd/display: Fix idle optimization checks for multi-display and dual eDP")
ac9c748362fd ("drm/amd/display: Allow IPS2 during Replay")
16927047b396 ("drm/amd/display: Disable IPS by default")
198891fd2902 ("drm/amd/display: Create one virtual connector in DC")
0c9ae5cfefb0 ("Revert "drm/amd/display: Create one virtual connector in DC"")
7d3dc50e241d ("Revert "drm/amd/display: Disable virtual links"")
3dcb66171583 ("Revert "drm/amd/display: Initialize writeback connector"")
c66705c5a87e ("Revert "drm/amd/display: Create amdgpu_dm_wb_connector"")
b22c336268e4 ("drm/amd/display: Disable virtual links")
c0af8c744e7e ("drm/amd/display: Make driver backwards-compatible with non-IPS PMFW")
a5f9523c9ca3 ("drm/amd/display: Create amdgpu_dm_wb_connector")
a2830b9e852f ("drm/amd/display: Initialize writeback connector")
554340133e4f ("drm/amd/display: Create one virtual connector in DC")
1b097bcd224e ("drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
77ad5f6febdc ("drm/amd/display: Add new logs for AutoDPMTest")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5922deae69beabae98644f3cd902df45da932297 Mon Sep 17 00:00:00 2001
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date: Thu, 25 Apr 2024 11:26:59 -0400
Subject: [PATCH] drm/amd/display: Fix idle optimization checks for
 multi-display and dual eDP

[Why]
Idle optimizations are blocked if there's more than one eDP connector
on the board - blocking S0i3 and IPS2 for static screen.

[How]
Fix the checks to correctly detect number of active eDP.
Also restrict the eDP support to panels that have correct feature
support.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 1c71a5d4ac5d..bddcd23a2727 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -660,22 +660,43 @@ void dcn35_power_down_on_boot(struct dc *dc)
 
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
-	struct dc_link *edp_links[MAX_NUM_EDP];
-	int i, edp_num;
 	if (dc->debug.dmcub_emulation)
 		return true;
 
 	if (enable) {
-		dc_get_edp_links(dc, edp_links, &edp_num);
-		if (edp_num == 0 || edp_num > 1)
-			return false;
+		uint32_t num_active_edp = 0;
+		int i;
 
 		for (i = 0; i < dc->current_state->stream_count; ++i) {
 			struct dc_stream_state *stream = dc->current_state->streams[i];
+			struct dc_link *link = stream->link;
+			bool is_psr = link && !link->panel_config.psr.disable_psr &&
+				      (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
+				       link->psr_settings.psr_version == DC_PSR_VERSION_SU_1);
+			bool is_replay = link && link->replay_settings.replay_feature_enabled;
 
-			if (!stream->dpms_off && !dc_is_embedded_signal(stream->signal))
+			/* Ignore streams that disabled. */
+			if (stream->dpms_off)
+				continue;
+
+			/* Active external displays block idle optimizations. */
+			if (!dc_is_embedded_signal(stream->signal))
 				return false;
+
+			/* If not PWRSEQ0 can't enter idle optimizations */
+			if (link && link->link_index != 0)
+				return false;
+
+			/* Check for panel power features required for idle optimizations. */
+			if (!is_psr && !is_replay)
+				return false;
+
+			num_active_edp += 1;
 		}
+
+		/* If more than one active eDP then disallow. */
+		if (num_active_edp > 1)
+			return false;
 	}
 
 	// TODO: review other cases when idle optimization is allowed


