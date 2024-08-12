Return-Path: <stable+bounces-66676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF594F0AB
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A74C1C21F9E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857517D354;
	Mon, 12 Aug 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWZkQwhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B767180032
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474369; cv=none; b=Zn0FruW89F4VSMmxuy2LlS0PsnKdg2K9CwuJN6vzjlNIHkdfoAnIJ1h0Ipe0KrfwP/fZMGTLYC1iOLo2c++KQbQhemviw3EOmm69FidUAcXBxjymPBZzazOCog0EmfyoDX06MSg3XJe2B0W5F3fO+mqVXY+TSDXcPO2B+Hozm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474369; c=relaxed/simple;
	bh=t4bSWbXXZOwwNa3maS4Tbm2XnhNhG+4wWcLCiTlVXvs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BF14mgcg7ppnimBI2pMxRA0KhLlTl6gy0g6eEZ9GJL8zlywhpQOZmph+k+V+YgnmgH8g7MFf9M3LIUkJmXUu+BfYzdmlFYB4FDbGFYYYyBt8atUb7eFlaJ1cp00defzww/LajxqTWvK0FNDHFgUVd7/ckWEhKS4oX24OpxOm8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWZkQwhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA08C32782;
	Mon, 12 Aug 2024 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474369;
	bh=t4bSWbXXZOwwNa3maS4Tbm2XnhNhG+4wWcLCiTlVXvs=;
	h=Subject:To:Cc:From:Date:From;
	b=vWZkQwhGRSJhQRmFxrSewL76cGOvwVkH8o1Bo/8RJOz+DLgllJf7lWVjkSXr7IfiM
	 40wrAE+JwTYbsQENfdhqXFrneGV329SeZ4u3cbEs/D7lCCcSSn2In4R4FQOW5CTomZ
	 WOlUvhyIciN492z3pmxgM5olwJEm9E/tBByz0IDM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix idle optimization checks for" failed to apply to 6.10-stable tree
To: nicholas.kazlauskas@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:50:31 +0200
Message-ID: <2024081231-nuptials-manor-7064@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5922deae69beabae98644f3cd902df45da932297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081231-nuptials-manor-7064@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

5922deae69be ("drm/amd/display: Fix idle optimization checks for multi-display and dual eDP")

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


