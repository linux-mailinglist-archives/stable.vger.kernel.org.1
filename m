Return-Path: <stable+bounces-53755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6D90E606
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D501C21702
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3647E0E8;
	Wed, 19 Jun 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbHQZCQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B87D40D
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786357; cv=none; b=Cwh8Qq/6B2ro9ngUj2W2X9Y7dKSTFmsgwkjpY3JKg/h82QurHpG2ig0VAzcqmEUJnHwYV37SywadHG9ae6/pnhOvi4aH9JgbbEMi7s9Wt2tglPt67Bx2gI4jU1Z0ZpY8Kc905YALkuAISGBuMkob6CmKPMmBxBPjVKhK71QhTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786357; c=relaxed/simple;
	bh=lLrNaepEkTPhuMycjQgfguF4C3dAlXNv75Yj8licJGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NkiHbTS4AfrtT0OwAjsbd/DY68Uk3NZrjgoi1MUZhDGJ1UVDm2c+LpaAVm+4rieJyM5YarsAKKrv9i4qu+o56mr9AWt1ZARh6ObUMj7u0pSSqIMiy3wnDp9cSOKPt0PsusKyCrhfJ8JcpdcfBeMHDevxgiQ5ImI4XKSP2Hgf2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbHQZCQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F7C2BBFC;
	Wed, 19 Jun 2024 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786357;
	bh=lLrNaepEkTPhuMycjQgfguF4C3dAlXNv75Yj8licJGk=;
	h=Subject:To:Cc:From:Date:From;
	b=RbHQZCQ4M3kwBWfB+/AFxGhvNB546ceQHnP0staLDsVSGcPtPaXU5Y2FkKUd97zua
	 Pzc/5X3htc+/XnKBPgF2m+TMZu6Zbiy7qBm4KhHpGJzgbw4N6kBM/jXCzqmJtCHOmJ
	 //Cegwsbv+YutXQuFRt8aCAofw6QdDNY6GjvLHAE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set VSC SDP Colorimetry same way for MST and" failed to apply to 5.10-stable tree
To: harry.wentland@amd.com,agustin.gutierrez@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:48 +0200
Message-ID: <2024061948-rare-sculpture-e88a@gregkh>
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
git cherry-pick -x 038e2e2e0150f1649d40f7d915561cdf9e4dd5bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061948-rare-sculpture-e88a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

038e2e2e0150 ("drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST")
1abfb9f9c767 ("drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4")
285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
02367f529019 ("drm/amd/display: fix a dereference of a NULL pointer")
5daa29473cf6 ("Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR"")
d62d5551dd61 ("drm/amd/display: Backup and restore only on full updates")
2d5bb791e24f ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
d2dea1f14038 ("drm/amd/display: Generalize new minimal transition path")
0701117efd1e ("Revert "drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel"")
a9b1a4f684b3 ("drm/amd/display: Add more checks for exiting idle in DC")
dcbf438d4834 ("drm/amd/display: Unify optimize_required flags and VRR adjustments")
9ccfe80d022d ("drm/amd/display: Fix potential NULL pointer dereferences in 'dcn10_set_output_transfer_func()'")
8457bddc266c ("drm/amd/display: Revert "Rework DC Z10 restore"")
2a8e918f48bd ("drm/amd/display: add power_state and pme_pending flag")
e6f82bd44b40 ("drm/amd/display: Rework DC Z10 restore")
012fe0674af0 ("drm/amd/display: Add logging resource checks")
a465536ebff8 ("drm/amd/display: revert "Optimize VRR updates to only necessary ones"")
30afdffb3f60 ("drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR")
ca1ecae145b2 ("drm/amd/display: Add null pointer guards where needed")
a71e1310a43f ("drm/amd/display: Add more mechanisms for tests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 038e2e2e0150f1649d40f7d915561cdf9e4dd5bf Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Thu, 21 Mar 2024 11:13:38 -0400
Subject: [PATCH] drm/amd/display: Set VSC SDP Colorimetry same way for MST and
 SST

The previous check for the is_vsc_sdp_colorimetry_supported flag
for MST sink signals did nothing. Simplify the code and use the
same check for MST and SST.

Cc: stable@vger.kernel.org
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7b016a2125e0..4d9a76446df8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6333,15 +6333,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
 		//
-		stream->use_vsc_sdp_for_colorimetry = false;
-		if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			stream->use_vsc_sdp_for_colorimetry =
-				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
-		} else {
-			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
-				stream->use_vsc_sdp_for_colorimetry = true;
-		}
+		stream->use_vsc_sdp_for_colorimetry = stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED;
+
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);


