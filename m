Return-Path: <stable+bounces-66577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA66F94F039
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD86B217D0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC25318454A;
	Mon, 12 Aug 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLTHGLcB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD305153BF6
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474033; cv=none; b=juXU6uyVhmSEwkrKs772Uogw4oC3ZSa7CgQg6K1RIoi2Zaxs77VDw6YEhq+3dkwJJDnagJnetN3dut/x+/gIHWh1+70xwu595z7k33IwWRwKnjfcp18aSGnXp21LTeqM153ksEqA5ll4+bXBooi5wr8+VS8wJoamcRU6p1zlK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474033; c=relaxed/simple;
	bh=XQAqv5uFRrJ8UzKxOcAY3O2USWTp7Smngn6v0VNQ/hE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HL8cmkZx4WbR7m0SB3kKhZ97ac5tQd8PSGwchh7BEKi0p9Vg53gJOX4368PsToctwDooZthUYP59q8QR67BILNq/OnkTuFodtxk+xdJNDFoIwV11SxfTSg7XNCwlcsC8YZTL+J+agYzOBH+aQ9uxDlK23DjXqh8bAhrj+Q1tOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JLTHGLcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CD9C32782;
	Mon, 12 Aug 2024 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474033;
	bh=XQAqv5uFRrJ8UzKxOcAY3O2USWTp7Smngn6v0VNQ/hE=;
	h=Subject:To:Cc:From:Date:From;
	b=JLTHGLcB+XSbQ5PjEwPhRxMofX9HymLLX8oT+qENi+zSB9wxNVqYBI0VyTA1XNRBf
	 /C8nh2K4aDOOwFAC0eI/6moY0SnHHz/uYRiFWpcD1faJPWZs9hPfdyXjlNAvWYP6nW
	 TTSmcUQdRyWMPD6iVg8Wc31hY70RGEvqKzu5FkPE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Adjust reg field for DSC wait for disconnect" failed to apply to 6.10-stable tree
To: ryanseto@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:47:10 +0200
Message-ID: <2024081209-condiment-kick-c449@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 569d7db70e5dcf13fbf072f10e9096577ac1e565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081209-condiment-kick-c449@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

569d7db70e5d ("drm/amd/display: Adjust reg field for DSC wait for disconnect")
176278d8bff2 ("drm/amd/display: reset DSC clock in post unlock update")
0127f0445f7c ("drm/amd/display: Refactor input mode programming for DIG FIFO")
e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
532a0d2ad292 ("drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util next mode set"")
47745acc5e8d ("drm/amd/display: Add trigger FIFO resync path for DCN35")
4d4d3ff16db2 ("drm/amd/display: Keep VBios pixel rate div setting util next mode set")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

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


