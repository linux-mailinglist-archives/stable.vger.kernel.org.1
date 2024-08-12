Return-Path: <stable+bounces-66722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0A94F0DD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158691F21067
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0511172773;
	Mon, 12 Aug 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOCG7FhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B694B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474531; cv=none; b=WAzDfVrnN1lAsV/8tpW0ediHrwd6i6rHk9n1TCGS7X7aSmOZFjJlbolllY3Tp55ucL14hrp2gnHFtBriYKMuSapkIJi3ZUF/dYRnhINg7QrS9Eysy6t1Gv8AB8RVklcUUrmrUUVG0hnc5GYuilgtIT2lDOPDtG2KpNAlIfwtwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474531; c=relaxed/simple;
	bh=fKivL8+t1qxzGSVesxmDch4xxixzpJxl5Hnwizsps7s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WZqgKSoCdXngjgLTDCRPBGTAwIdHYarq/YhTM5xZ4UTuaVbs26KqMxCcJ9xiLou6YKqUrXn0d8178Hbt9H98j5PZa2ThhEp44IDhpcTdYcK72klEpDoXIshhdCH40ACCLMAHZU+fD6TTWg96oGCXRxkR+E/m+hOpqOJQsMD4L7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOCG7FhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83DC32782;
	Mon, 12 Aug 2024 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474531;
	bh=fKivL8+t1qxzGSVesxmDch4xxixzpJxl5Hnwizsps7s=;
	h=Subject:To:Cc:From:Date:From;
	b=FOCG7FhEzNKKF9iuGK95EQAppsIyqI5qmoTInk6Gp+0Ik3NG3M89ko+xgmsceIsUy
	 80Vzi78hzy1pNDjqfvm4CmseP/mFBhqvMy0hwcbBq1qc9NO8egwp7RgKBklUBfSUTz
	 n46XHWXPFGX/QqPb/wG61gXTLCSdvlrM+nbRWKa0=
Subject: FAILED: patch "[PATCH] drm/amd/display: resync OTG after DIO FIFO resync" failed to apply to 5.4-stable tree
To: tungyu.lu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:53:17 +0200
Message-ID: <2024081216-cradle-pronounce-d867@gregkh>
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
git cherry-pick -x f86b47bee6343c9f74630d7fc2fb8f5e41db0440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081216-cradle-pronounce-d867@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


