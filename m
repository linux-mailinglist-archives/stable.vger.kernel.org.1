Return-Path: <stable+bounces-246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5B7F75BB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B0C1C210B6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C92C854;
	Fri, 24 Nov 2023 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgSzNh0/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E62C1AB
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C39C433C7;
	Fri, 24 Nov 2023 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834078;
	bh=7Rh7t/Pek7agvFmtvadmNp3PWHl4HOSJGhEItZbZ+2A=;
	h=Subject:To:Cc:From:Date:From;
	b=AgSzNh0/WDD+LuRcJTv6DljthJ0ljVsMyf/ad9FwsQdeoLBtXwL9AHHJHluj/2M0b
	 ivdMEBcJUVlI9BniVYHiOsUvsHsRH3c2hC1SFa0o+4xkjWzNBD7gHKfPZ1lUuXPHB9
	 0cXq7hpYkwkOjOAilG605xbr0rAWZQbhYkdixdd0=
Subject: FAILED: patch "[PATCH] drm/amd/display: always switch off ODM before committing more" failed to apply to 6.1-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,dillon.varone@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:54:31 +0000
Message-ID: <2023112431-smooth-crewmate-6ccd@gregkh>
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
git cherry-pick -x ea7e2edca8b2150f945ee25af142fef8438c9944
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112431-smooth-crewmate-6ccd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ea7e2edca8b2 ("drm/amd/display: always switch off ODM before committing more streams")
24e461e84f1c ("drm/amd/display: add ODM case when looking for first split pipe")
e4c1b01bc35b ("drm/amd/display: Use min transition for all SubVP plane add/remove")
9e7d03e8b046 ("drm/amd/display: Use min transition for SubVP into MPO")
1e8fd864afdc ("drm/amd/display: skip commit minimal transition state")
f6ae69f49fcf ("drm/amd/display: Include surface of unaffected streams")
0e986cea0347 ("drm/amd/display: Copy DC context in the commit streams")
7b36f4d18e3e ("drm/amd/display: Enable new commit sequence only for DCN32x")
10fdb0a11c55 ("drm/amd/display: Rework context change check")
03ce7b387e8b ("drm/amd/display: Check if link state is valid")

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


