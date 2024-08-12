Return-Path: <stable+bounces-66710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8D94F0D1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8BF1F237CF
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273CB17995B;
	Mon, 12 Aug 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJvkiJ9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20D4B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474490; cv=none; b=iK5T+SgBcU1i9amRQuoGVXJCWF7C7bbaiFLqH39ppT/3An6dG+8BVf5hsukv/WATNhtmD7irW45SOwcKRsHBV+c+iuCNoUGUIgy5eHGHMEjacG1PuQjodGGHUD1Tzz/HE2dYuCEl4XZU+EspMRvf+MJPF63w0OD4eEPnA5Hf/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474490; c=relaxed/simple;
	bh=zwIgvbxnGedpHSDzDZRYEliB2cRWhfD4k/Ij8kEbPLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WLbKZmFX9g+CwC8sAU7KYjZabwpwxW1BiWdVnIeQ484GzHzwLafQ6K9r4OuQ7COJutH41uAq+R/fB87PGaCgmFfLlP+MaNzY3JBjii43PDeVVHClM1u06Q4LeXrEPsngd+pVPLXJjUYzzymgBgNfYu0jihYWhmv9mJt2AU7GeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJvkiJ9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926EC32782;
	Mon, 12 Aug 2024 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474490;
	bh=zwIgvbxnGedpHSDzDZRYEliB2cRWhfD4k/Ij8kEbPLg=;
	h=Subject:To:Cc:From:Date:From;
	b=hJvkiJ9F5gUAvjpQT/b2skcwbwJwYHgbu7SN5fOobGUGHWfUPcLhFOH0GKmjUZRpm
	 IXf29Zp9TPnwfTz/Unn69s2tI1X1MCgvI1to/HrdQdIR7qgen8E5+3BOzjpd7IZ3oV
	 iIEATgtJatWg6vfaAlBoh9/PjWQ28iyGbuRWpjqM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Change ASSR disable sequence" failed to apply to 6.6-stable tree
To: swapnil.patel@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:52:14 +0200
Message-ID: <2024081214-riding-spotter-5611@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2d696cc837eaf5394d79bfd2b0b0483c4778aa83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081214-riding-spotter-5611@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

2d696cc837ea ("drm/amd/display: Change ASSR disable sequence")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d696cc837eaf5394d79bfd2b0b0483c4778aa83 Mon Sep 17 00:00:00 2001
From: Swapnil Patel <swapnil.patel@amd.com>
Date: Thu, 18 Apr 2024 14:30:39 -0400
Subject: [PATCH] drm/amd/display: Change ASSR disable sequence

[Why]
Currently disabling ASSR before stream is disabled causes visible
display corruption.

[How]
Move disable ASSR command to after stream has been disabled.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 16549068d836..8402ca0695cc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2317,8 +2317,6 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
-	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
-
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
@@ -2372,6 +2370,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 	}
+	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))


