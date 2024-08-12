Return-Path: <stable+bounces-66582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F094F03C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D91C21BB0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4E184552;
	Mon, 12 Aug 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Nf2Qgt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBC183CAB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474051; cv=none; b=pKsrmewnXASu0Y7pfeGoBf5BJHOFl/cX7aGrjCgUexc3VQehVTqwUScfaETQUPhs1CTqQPeMSbu0K6Xl6icU7m7zE+ZOgi8UToufERayqXo8dDRY9h8twEMDSvoQwN1akHOfoMcG47r5M3Xr+HsMmjgOEVKqf0plgZer6wJChkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474051; c=relaxed/simple;
	bh=b2JyJ7QaYAe4eiy9OdBjscjYJfef2EQql7MES2fReEY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QDlcNiUsUXYB5j5U7DYPQ9zQhoVg4r13OhdAlI+IUMn6jcPcstPS48cFtenaEbp6xPKkcr7m05bs5j+qFp+UKhu497IQKe7GS42iJHQWP+FjeOrCc5MKLBbPXgNZRL1MoUpl8A5jUCsHl1Jolwgr8BbnN8y+itzHBXrQ5BBDXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Nf2Qgt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFBDC32782;
	Mon, 12 Aug 2024 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474051;
	bh=b2JyJ7QaYAe4eiy9OdBjscjYJfef2EQql7MES2fReEY=;
	h=Subject:To:Cc:From:Date:From;
	b=0Nf2Qgt67HWO6JNKl53Fmp4do+/wjDGmnpvnn6kR1H0xHKKVH0OZ2bgu8cTrLG4jS
	 N7DHYiszR41+GYdUH7crsJxP95xUI70BT7gw+0d54YYXORg5672OVX9vZfLZVUrJ7d
	 NiOOego/EbxQ1GJMDO8cbcBPzBt2Ji1neXlArG5M=
Subject: FAILED: patch "[PATCH] drm/amd/display: Adjust reg field for DSC wait for disconnect" failed to apply to 5.4-stable tree
To: ryanseto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:13 +0200
Message-ID: <2024081213-guileless-sludge-4dcb@gregkh>
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
git cherry-pick -x 569d7db70e5dcf13fbf072f10e9096577ac1e565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081213-guileless-sludge-4dcb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

569d7db70e5d ("drm/amd/display: Adjust reg field for DSC wait for disconnect")
176278d8bff2 ("drm/amd/display: reset DSC clock in post unlock update")
0127f0445f7c ("drm/amd/display: Refactor input mode programming for DIG FIFO")
e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
532a0d2ad292 ("drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util next mode set"")
47745acc5e8d ("drm/amd/display: Add trigger FIFO resync path for DCN35")
4d4d3ff16db2 ("drm/amd/display: Keep VBios pixel rate div setting util next mode set")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
9712b64d6f3f ("drm/amd/display: Remove MPC rate control logic from DCN30 and above")
eed4edda910f ("drm/amd/display: Support long vblank feature")
2d7f3d1a5866 ("drm/amd/display: Implement wait_for_odm_update_pending_complete")
c7b33856139d ("drm/amd/display: Drop some unnecessary guards")
6a068e64fb25 ("drm/amd/display: Update phantom pipe enable / disable sequence")
db8391479f44 ("drm/amd/display: correct static screen event mask")
4ba9ca63e696 ("drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue")
9af68235ad3d ("drm/amd/display: Fix static screen event mask definition change")
f6154d8babbb ("drm/amd/display: Refactor INIT into component folder")
a71e1310a43f ("drm/amd/display: Add more mechanisms for tests")
85fce153995e ("drm/amd/display: change static screen wait frame_count for ips")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 569d7db70e5dcf13fbf072f10e9096577ac1e565 Mon Sep 17 00:00:00 2001
From: Ryan Seto <ryanseto@amd.com>
Date: Fri, 14 Jun 2024 14:56:15 -0400
Subject: [PATCH] drm/amd/display: Adjust reg field for DSC wait for disconnect

[WHY]
DSC was waiting for the wrong field to disconnect cleanly.

[HOW]
Changed field the DSC disconnect was waiting on.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index a23308a785bc..1fb90b52b814 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -454,7 +454,9 @@
 	type DSCCIF_UPDATE_TAKEN_ACK; \
 	type DSCRM_DSC_FORWARD_EN; \
 	type DSCRM_DSC_OPP_PIPE_SOURCE; \
-	type DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING
+	type DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING; \
+	type DSCRM_DSC_FORWARD_EN_STATUS
+
 
 struct dcn20_dsc_registers {
 	uint32_t DSC_TOP_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 52f23bb554af..6acb6699f146 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -208,7 +208,7 @@ static void dsc401_wait_disconnect_pending_clear(struct display_stream_compresso
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 
-	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_DOUBLE_BUFFER_REG_UPDATE_PENDING, 0, 2, 50000);
+	REG_WAIT(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN_STATUS, 0, 2, 50000);
 }
 
 static void dsc401_disconnect(struct display_stream_compressor *dsc)
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
index 2143e81ca22a..3c9fa8988974 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
@@ -196,7 +196,8 @@
 	DSC2_SF(DSCCIF0, DSCCIF_CONFIG0__BITS_PER_COMPONENT, mask_sh), \
 	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, DOUBLE_BUFFER_REG_UPDATE_PENDING, mask_sh), \
 	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, mask_sh), \
-	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_OPP_PIPE_SOURCE, mask_sh)
+	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_OPP_PIPE_SOURCE, mask_sh), \
+	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN_STATUS, mask_sh)
 
 struct dcn401_dsc_registers {
 	uint32_t DSC_TOP_CONTROL;


