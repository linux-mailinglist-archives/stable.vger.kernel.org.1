Return-Path: <stable+bounces-66717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2494F0D8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419B4B2338A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0817BB03;
	Mon, 12 Aug 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCYrsrVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B54B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474514; cv=none; b=FsBZ6YzADpqp9w1D48ldk6q6LsjuRBKHKXi5vjtBkyXnJeJwTmZ89uDH17l5P6LVs0IYWzV/yeIp1LkZpD8w7y2RL09jY8zowVxynCPq1PNQnQS0Msg+qPkpx/sFa1oAdKcRAQDbVgJ5CtSkOBRNXFMaEGpX9UfnpDhP0iYR8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474514; c=relaxed/simple;
	bh=+4S1gzNQFuen+hUMMsOB0DOGXb3Al7J3fjMPUmWzTpA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EeelPrGlSepGaDRTKJmh2PDlKi6XRUPmUZmlpJkABm2sIYaylZraL5Y4YQ9I+ZGbOm3z2S8GLyAwSu6hiOQNVlmyekRbs0r0+TjGQKbxyojraKABs9FFQU5oUBcrkMz8yiIJAp9qDh/6oQoOKoKj+TB8BuiFmTm2RFBQ2uCMKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCYrsrVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAD3C32782;
	Mon, 12 Aug 2024 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474514;
	bh=+4S1gzNQFuen+hUMMsOB0DOGXb3Al7J3fjMPUmWzTpA=;
	h=Subject:To:Cc:From:Date:From;
	b=oCYrsrVbCE6w+UJwDil6GUkuxro9pGJ7Nq2/8A5XCjqS3zdtSWkLgQQ9pOtLG9oMu
	 eeBFF5Wu6iHAaLg0WsClsXc50V90ctk66ls7KsYWRxDm7B1HU72YsoHwfxBDzT0EY4
	 v9vNJAN6cW+p0w+EaReSCAG4WEsTBIU2oKuI6WOA=
Subject: FAILED: patch "[PATCH] drm/amd/display: resync OTG after DIO FIFO resync" failed to apply to 6.1-stable tree
To: tungyu.lu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:14 +0200
Message-ID: <2024081214-glimmer-navigate-f46d@gregkh>
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
git cherry-pick -x f86b47bee6343c9f74630d7fc2fb8f5e41db0440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081214-glimmer-navigate-f46d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


