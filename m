Return-Path: <stable+bounces-228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B977F75A4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B800282079
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40421286B9;
	Fri, 24 Nov 2023 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+3SnTCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6D28E26
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B77C433C8;
	Fri, 24 Nov 2023 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700833978;
	bh=4cKs8Uo1V/nIcYefFpH++Yi75hB1+6kmvhSsJF92nmQ=;
	h=Subject:To:Cc:From:Date:From;
	b=o+3SnTCni8CfszuPITH3GvuPIh9YNpIsfJTrufTbAbv+Is2Ctnolgy4usrRaOE567
	 8cEBoEw34EyLOG6PE7NkMS/KidmdMFiD30fx9UmXKjX3TGLApGiL23WK5c8pPoUjeL
	 2RhxEulWJa+Y2qhHI8Xt9GP7eMD+GysjJrUAB4bQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix the ability to use lower resolution" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,mark.broadworth@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:52:56 +0000
Message-ID: <2023112456-gumdrop-bobble-e462@gregkh>
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
git cherry-pick -x 1101185bc50f5e45b8b89300914d9aa35a0c8cbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112456-gumdrop-bobble-e462@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1101185bc50f ("drm/amd/display: fix the ability to use lower resolution modes on eDP")
95dd6efc6bd3 ("drm/amd/display: fix mode scaling (RMX_.*)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1101185bc50f5e45b8b89300914d9aa35a0c8cbe Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Wed, 13 Sep 2023 14:48:08 -0400
Subject: [PATCH] drm/amd/display: fix the ability to use lower resolution
 modes on eDP

On eDP we can receive invalid modes from dm_update_crtc_state() for
entirely new streams for which drm_mode_set_crtcinfo() shouldn't be
called on. So, instead of calling drm_mode_set_crtcinfo() from within
create_stream_for_sink() we can instead call it from
amdgpu_dm_connector_mode_valid(). Since, we are guaranteed to only call
drm_mode_set_crtcinfo() for valid modes from that function (invalid
modes are rejected by that callback) and that is the only user
of create_validate_stream_for_sink() that we need to call
drm_mode_set_crtcinfo() for (as before commit cb841d27b876
("drm/amd/display: Always pass connector_state to stream validation"),
that is the only place where create_validate_stream_for_sink()'s
dm_state was NULL).

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2693
Fixes: cb841d27b876 ("drm/amd/display: Always pass connector_state to stream validation")
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c462261b3aff..ed1afbb5da78 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6143,8 +6143,6 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (recalculate_timing)
 		drm_mode_set_crtcinfo(&saved_mode, 0);
-	else if (!old_stream)
-		drm_mode_set_crtcinfo(&mode, 0);
 
 	/*
 	 * If scaling is enabled and refresh rate didn't change
@@ -6706,6 +6704,8 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 		goto fail;
 	}
 
+	drm_mode_set_crtcinfo(mode, 0);
+
 	stream = create_validate_stream_for_sink(aconnector, mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);


