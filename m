Return-Path: <stable+bounces-66720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F694F0DA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7141C2149E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1C17995B;
	Mon, 12 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HDDpSVx5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59154724
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474524; cv=none; b=Bxl948gYR3otzN+ubU/1DN9GNPSnALUS7KrNDXPoFj2bzkjvq3KkRrem+0xW/RuNxThRUQuXcG8zaN6F3Ur6eU8OZw9PCSrlDEczCTSAnjCt68CA8qy5BXfZJw4mUV82FUxFUs1CFRT1aegd3BFuMELzF/Uv/sHXFETLIhWtvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474524; c=relaxed/simple;
	bh=riyO52Mz0QSdsdmEaEQFeYdpz4+lYwI+RQz5UWjTcJA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j2Pm+WTG+dQKHyT8s9yGAXUmiuafv7XOSAStYmvGwmWStJqSRdH2Z4BWJYYb70xP700qoH0FCCHSar31M8YFAOnbw+dPZrYmxYjF4fa6c12NId9G9pAnzj/0qbvjzcb6luLfEVOfy368EOzeQjP8LM625z/3u2eD7R3Hy6fJGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HDDpSVx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF4C32782;
	Mon, 12 Aug 2024 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474524;
	bh=riyO52Mz0QSdsdmEaEQFeYdpz4+lYwI+RQz5UWjTcJA=;
	h=Subject:To:Cc:From:Date:From;
	b=HDDpSVx5WmZXVHX5QOgdkk2NexHL1bLYvNKnFWAmQJCiKTlJic6fGXuK45s6pFsx2
	 MVvzD+QLjyKabBmnB2dCRlTkM8GJ7AiQIrmeZDHdeRTrPaQf/yD73bd5ui3nPZrnww
	 2G8Eb7LuOu5VaPe3Dar4nVpbKrLrjRVVZf2SPhbI=
Subject: FAILED: patch "[PATCH] drm/amd/display: resync OTG after DIO FIFO resync" failed to apply to 5.10-stable tree
To: tungyu.lu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:16 +0200
Message-ID: <2024081216-dullness-remnant-2840@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f86b47bee6343c9f74630d7fc2fb8f5e41db0440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081216-dullness-remnant-2840@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f86b47bee634 ("drm/amd/display: resync OTG after DIO FIFO resync")
e53524cdcc02 ("drm/amd/display: Refactor HWSS into component folder")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f86b47bee6343c9f74630d7fc2fb8f5e41db0440 Mon Sep 17 00:00:00 2001
From: TungYu Lu <tungyu.lu@amd.com>
Date: Wed, 12 Jun 2024 22:34:33 +0800
Subject: [PATCH] drm/amd/display: resync OTG after DIO FIFO resync

[WHY]
Tiled displays showed not aligned on 8K60hz when system resumed
from S3/S4.

[HOW]
Do dc_trigger_sync to re-sync pipes to ensure OTG become synced.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index bdbb4a71651f..fe62478fbcde 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1254,6 +1254,8 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 			pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
+
+	dc_trigger_sync(dc, dc->current_state);
 }
 
 void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,


