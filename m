Return-Path: <stable+bounces-53768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4590E614
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43217B20BC0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCC7BAF4;
	Wed, 19 Jun 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jHLgevQa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDF7B3EB
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786396; cv=none; b=PhYol4bxhvKrmfsL/T8SANumzcsRIqQBob2XVjy50EydYN7ZxNSRNmwZWDgi4Jz7EKKsISyMQ+L/yZt4pdOp+h5IK8ZkzhxEcBkHoa8bQRwwXYWcLY4kLZaxh1g1Va0l0K38j+Rt9F3++hcrhml2uSaW+NKWqRsIBfyfYjRnpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786396; c=relaxed/simple;
	bh=dZ2aQaTfs6P1j3iYg31W7/B/WltYotzoysiHvipBhrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nKV6GjzbW2eHkwK7jCn2Wbav9Hk24EYEXr2A78mZ4VjJvh8miAs0wDaQMGCWykHghRtHhVi4FAF2aIv1tPIlHOARKia4KWD7XWwFqHXGD1hBXHqlSX5RlLMex2wvvrYE20pDiTMYapNvNlKBsoPsSISXJqJaoqP0O7wd0N4tejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jHLgevQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93301C32786;
	Wed, 19 Jun 2024 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786396;
	bh=dZ2aQaTfs6P1j3iYg31W7/B/WltYotzoysiHvipBhrI=;
	h=Subject:To:Cc:From:Date:From;
	b=jHLgevQaVF5elWCEDtY6HhH8y9TNCpndn+3tk1ivRInWevpVxicjHyNlNPVtRyB2I
	 bkFrFo6fRI3O9HaHLmcriclr6/d89X1uCKsOX/hg8tHyTSCnU+Th7EIrhUuqKqnG+e
	 EbctGimQ4wrOSCS6dm2dZUy2uKuv61Ce6xa/fD1w=
Subject: FAILED: patch "[PATCH] drm/amd/display: Program VSC SDP colorimetry for all DP sinks" failed to apply to 6.9-stable tree
To: harry.wentland@amd.com,Agustin.Gutierrez@amd.com,agustin.gutierrez@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,joshua@froggi.es,mwen@igalia.com,xaver.hugl@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:39:15 +0200
Message-ID: <2024061915-stopped-flint-1802@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 1abfb9f9c767ca4c98c12ba2754abfe3ecf5ce8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061915-stopped-flint-1802@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

1abfb9f9c767 ("drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4")
5daa29473cf6 ("Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1abfb9f9c767ca4c98c12ba2754abfe3ecf5ce8c Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 12 Mar 2024 11:55:52 -0400
Subject: [PATCH] drm/amd/display: Program VSC SDP colorimetry for all DP sinks
 >= 1.4

In order for display colorimetry to work correctly on DP displays
we need to send the VSC SDP packet. We should only do so for
panels with DPCD revision greater or equal to 1.4 as older
receivers might have problems with it.

Cc: stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Agustin Gutierrez <Agustin.Gutierrez@amd.com>
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e80a75312cf7..7b016a2125e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6326,7 +6326,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
 
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+	    stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6336,7 +6338,8 @@ create_stream_for_sink(struct drm_connector *connector,
 			stream->use_vsc_sdp_for_colorimetry =
 				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
 		} else {
-			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)


