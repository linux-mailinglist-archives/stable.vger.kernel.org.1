Return-Path: <stable+bounces-245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBAF7F75B7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0735D282613
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F12C1BA;
	Fri, 24 Nov 2023 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wu1Juzn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23612286B9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D0DC433C8;
	Fri, 24 Nov 2023 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834074;
	bh=6crSOfxwqcEDpbFIsF/oTd5qzuiCXr6dwi6yOXQGwxc=;
	h=Subject:To:Cc:From:Date:From;
	b=Wu1Juzn3pv0vzG2QFupkAt17H/fJN0zxeThsuPrX4BONOZJBbMGwg0Fwmc4qj9zl+
	 ATnrYIN0l75umX4Ym8EYfvKtqkddTmLTN95oSzFSGD3uycBjXkgnkjMh/vODqeFSYS
	 173TwiY76DyOdwvb+ufQaZrWl7dKZ8W7FYMyRjZQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: always switch off ODM before committing more" failed to apply to 6.5-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,dillon.varone@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:30 +0000
Message-ID: <2023112430-curled-hurried-e134@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x ea7e2edca8b2150f945ee25af142fef8438c9944
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112430-curled-hurried-e134@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

ea7e2edca8b2 ("drm/amd/display: always switch off ODM before committing more streams")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea7e2edca8b2150f945ee25af142fef8438c9944 Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Tue, 15 Aug 2023 10:47:52 -0400
Subject: [PATCH] drm/amd/display: always switch off ODM before committing more
 streams

ODM power optimization is only supported with single stream. When ODM
power optimization is enabled, we might not have enough free pipes for
enabling other stream. So when we are committing more than 1 stream we
should first switch off ODM power optimization to make room for new
stream and then allocating pipe resource for the new stream.

Cc: stable@vger.kernel.org
Fixes: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c8f301aabcf8..5aab67868cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2073,12 +2073,12 @@ enum dc_status dc_commit_streams(struct dc *dc,
 		}
 	}
 
-	/* Check for case where we are going from odm 2:1 to max
-	 *  pipe scenario.  For these cases, we will call
-	 *  commit_minimal_transition_state() to exit out of odm 2:1
-	 *  first before processing new streams
+	/* ODM Combine 2:1 power optimization is only applied for single stream
+	 * scenario, it uses extra pipes than needed to reduce power consumption
+	 * We need to switch off this feature to make room for new streams.
 	 */
-	if (stream_count == dc->res_pool->pipe_count) {
+	if (stream_count > dc->current_state->stream_count &&
+			dc->current_state->stream_count == 1) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe->next_odm_pipe)


