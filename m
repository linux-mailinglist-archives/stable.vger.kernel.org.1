Return-Path: <stable+bounces-285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCD7F763F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266D01C210C6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962172D035;
	Fri, 24 Nov 2023 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFHEBRMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A042C864
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A975C433D9;
	Fri, 24 Nov 2023 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835742;
	bh=W5Co5hGD1hd3HX7OZA1UYzPCqkJ7aZjdmNv9MiGsBW4=;
	h=Subject:To:Cc:From:Date:From;
	b=qFHEBRMTgdJryimykQvm1pcxIIajMEMC0GKEMreHXrq5pLsqcJ1IvdD0tVr0xkDv0
	 wsFgKjjPUNSbMs8eZpiKSt3BaBx9573CFB9jpFlWJ4apkKeHN3ONQijO61B9893zcn
	 F8mxNeBE4a2RVEb5w26RA+vOR3/rNRHYZ69+QGv8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add null checks for 8K60 lightup" failed to apply to 6.6-stable tree
To: ahmed.ahmed@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:22:20 +0000
Message-ID: <2023112420-schematic-petty-3e38@gregkh>
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
git cherry-pick -x 9725a4f9eb495bfa6c7f5ccdb49440ff06dba0a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112420-schematic-petty-3e38@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

9725a4f9eb49 ("drm/amd/display: Add null checks for 8K60 lightup")
051d90070d4c ("drm/amd/display: Refactor DPG test pattern logic for ODM cases")
ddd5298c63e4 ("drm/amd/display: Update cursor limits based on SW cursor fallback limits")
13c0e836316a ("drm/amd/display: Adjust code style for hw_sequencer.h")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
e87a6c5b7780 ("drm/amd/display: Blank phantom OTG before enabling")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
920f879c8360 ("drm/amd/display: Add DCN35 PG_CNTL")
fb8c3ef80584 ("drm/amd/display: Update dc.h for DCN35 support")
5e77c339a291 ("drm/amd/display: Skip dmub memory flush when not needed")
3001e6d1dedc ("drm/amd/display: Add support for 1080p SubVP to reduce idle power")
0b9dc439f404 ("drm/amd/display: Write flip addr to scratch reg for subvp")
96182df99dad ("drm/amd/display: Enable runtime register offset init for DCN32 DMUB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9725a4f9eb495bfa6c7f5ccdb49440ff06dba0a1 Mon Sep 17 00:00:00 2001
From: Muhammad Ahmed <ahmed.ahmed@amd.com>
Date: Tue, 31 Oct 2023 16:03:21 -0400
Subject: [PATCH] drm/amd/display: Add null checks for 8K60 lightup

[WHY & HOW]
Add some null checks to fix an issue where 8k60
tiled display fails to light up.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b9bf5cb4529..d8f434738212 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3178,7 +3178,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
 					context->streams[i]);
 
-			if (otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1d48278cba96..a1f1d1003992 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5190,6 +5190,9 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 	sec_next = sec_pipe->next_odm_pipe;
 	sec_prev = sec_pipe->prev_odm_pipe;
 
+	if (pri_pipe == NULL)
+		return false;
+
 	*sec_pipe = *pri_pipe;
 
 	sec_pipe->top_pipe = sec_top;


