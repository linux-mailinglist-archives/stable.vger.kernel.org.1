Return-Path: <stable+bounces-66718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C994F0D9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C2F1C21CD5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD4172773;
	Mon, 12 Aug 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ireSU8SU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B264B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474517; cv=none; b=Cfq6RY+baJsKL+lGtU+Qg1uYqU0wJfMic2TuB1KHf0Xdyzn85WJx0tCONkp9KuvjIe1KyWFBPBRhSuF1qxuV5kTf8GB9z6Vq+9IuNCV4JEgpYmo71ffKRAUMj2F8kLNP+yVElTAfT/okPzvpeh2MWRZ2SfN1MAc6sfPU+hhjss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474517; c=relaxed/simple;
	bh=1zHoCi06l6w5Mkyw0zP9VCmYtBVA831+GUy1HVg1hEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EHPnkDnkQmKpbw+2WmPYovYPYocmwSBjnjLsbrq3m2xzCwBxmFojlxBWgv1Z++hgCGHbUfMcIK3jnglILreEcGBO7XuWrEQkVijb+SXlm/FHGPCet9yDNWDIS6mtC/hf02X7kNFOkie/G1tE5bvit/DHHT7iQRVYacxiY7Eoe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ireSU8SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC6CC32782;
	Mon, 12 Aug 2024 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474517;
	bh=1zHoCi06l6w5Mkyw0zP9VCmYtBVA831+GUy1HVg1hEM=;
	h=Subject:To:Cc:From:Date:From;
	b=ireSU8SUBGBknNLlzx0XzfDQdWkSETtu5zQFqrar0RA01ja2RRvLok4fHAQZpIowJ
	 T3T98ACuT0QjOLxFjARpFOgr3zA1woyH6yhnGHxZVSLIVuIFtiX3dfuCYthQh+NT0u
	 zdYI5plJRW2LlLZ43W4mEHLu2oCFjVn3Aa2Nm2NI=
Subject: FAILED: patch "[PATCH] drm/amd/display: resync OTG after DIO FIFO resync" failed to apply to 6.6-stable tree
To: tungyu.lu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:14 +0200
Message-ID: <2024081213-demotion-carry-49c5@gregkh>
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
git cherry-pick -x f86b47bee6343c9f74630d7fc2fb8f5e41db0440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081213-demotion-carry-49c5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f86b47bee634 ("drm/amd/display: resync OTG after DIO FIFO resync")

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


