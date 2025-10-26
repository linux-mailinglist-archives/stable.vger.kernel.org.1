Return-Path: <stable+bounces-189810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C8C0AA56
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700303B0C15
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897C1A9F92;
	Sun, 26 Oct 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8TWztI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0D5C96
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489328; cv=none; b=F23A92s+QHlCxjq6uwBNzxQGqyZjVf8yoUqCzVGeR9lMLjZwls42AXjq/7U9t6Z6YVafTZPoxW3wpGdF5Zc8iLKRc/apRMwN7lOWad8rP2hvhOPNSvsb9nJb7so1nqQ5DDDGdWFr+32ycN2aKMMSB8XR9xhq8WDBhfhAqU6KpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489328; c=relaxed/simple;
	bh=NqR7h6rBVAanHf1fsLg6o8mnto084Xu3cskTgkTYcPI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=drjvcFzUCYPTGxeZ7K5yANQPqsu/A9Ajty0jLLc+LmJQa9E8Itrj7AvENfxyAqSrwCssAokt1HUA08iPJPt40mpSSwtnYRJ4HVAY3cc+VLrobjNAqzKHTu3aPw5g6AS0WpXNAw4f5Np4tzERXbwy/TDRvRoJ/4wSxweWUNAg/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8TWztI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C636C4CEE7;
	Sun, 26 Oct 2025 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489327;
	bh=NqR7h6rBVAanHf1fsLg6o8mnto084Xu3cskTgkTYcPI=;
	h=Subject:To:Cc:From:Date:From;
	b=N8TWztI1/rzBe2QfOy/qQEpNov1c3MaWC/Utlbi0+s/JU1Cy+xLOsAw0Aco+Ts/+m
	 ZBWOyzxGLlBUmOqHRSCf0zo/8hpO6c9sFu0HbDlrXEiy3/QluT/CSI+N+bkjNaiHeM
	 6U3XdyNcF+T2iQMQYNIpK+s/sQ1YSiQoVFCrxWBQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix NULL pointer dereference" failed to apply to 6.17-stable tree
To: meenakshikumar.somasundaram@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,charlene.liu@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:35:25 +0100
Message-ID: <2025102625-bright-circulate-8844@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 89939cf252d80237ed380c1d20575ecfe56ff894
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102625-bright-circulate-8844@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89939cf252d80237ed380c1d20575ecfe56ff894 Mon Sep 17 00:00:00 2001
From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Date: Mon, 29 Sep 2025 14:28:34 -0400
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference

[Why]
On a mst branch with multi display setup, dc context is obselete
after updating the first stream. Referencing the same dc context
for the next stream update to fetch dc pointer leads to NULL
pointer dereference.

[How]
Get the dc pointer from the link rather than context.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dc69b48988b171d6ccb3a083607e4dff015e2c0d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 9e33bf937a69..2676ae9f6fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -78,6 +78,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct audio_output audio_output[MAX_PIPES];
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
+	struct dc *dc = (struct dc *)link->dc;
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -150,7 +151,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 		if (streams_on_link[i] && streams_on_link[i]->link && streams_on_link[i]->link == link) {
 			stream_update.stream = streams_on_link[i];
 			stream_update.dpms_off = &dpms_off;
-			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, streams_on_link[i], &stream_update);
+			dc_update_planes_and_stream(dc, NULL, 0, streams_on_link[i], &stream_update);
 		}
 	}
 }


