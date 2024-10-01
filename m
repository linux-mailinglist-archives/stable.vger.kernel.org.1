Return-Path: <stable+bounces-78380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6098B8E9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9651C222A5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829571A0724;
	Tue,  1 Oct 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1z5jDhkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC619F49F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777097; cv=none; b=hRR/4293oibCpwv/qLzczWPexpbv/3bphpeOqfuHvKxaX0IvrFAi6yvOBXsTACA6wAlodzcrGJUkpHuCvtgiWbBGRPM/eUZXtbZoAk27RvNy98282WFteRD+QNQWL2bCFSP8BcuH/e6hAcqTXkxWLtNqTHUaSsu8PdtFuxR/Xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777097; c=relaxed/simple;
	bh=Cs1mavNfaECoteZ5NTcKo8Ie63yXJuP2EdWoY0/aHrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cL1sAMjVfjkjfc6K1eI58U44vESzG8mI8+d9M2wUy1XLl7LYuqhnHv8hhUvOak7U4Nnp67JRgzHIBPlWvwIrQ4dMSjD5vgtwXk7iW76fIbiDXXfL4VlT6pAMz3nY8OVc0j+FPcyfxkZcKykFJP1TbMtsKVdsrvDJuyOtI7HabCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1z5jDhkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C9BC4CEC6;
	Tue,  1 Oct 2024 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777096;
	bh=Cs1mavNfaECoteZ5NTcKo8Ie63yXJuP2EdWoY0/aHrY=;
	h=Subject:To:Cc:From:Date:From;
	b=1z5jDhkALUJX39GRslP+EVKogSAcqmRrKIj63DsU9gIAJb4qwiTV7GMhmmefTDXyK
	 1SUckqYugWi0FlGryAsNdDSzLfFx21JQR+2owF1X8XCZjIUscv/TZ91htBSNwuw2mx
	 sTEwBO4MDIv37LbqBFLEt1iex1X7Ws+1UsikYCWo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use full update for swizzle mode change" failed to apply to 6.10-stable tree
To: Charlene.Liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,chris.park@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:04:16 +0200
Message-ID: <2024100115-dazzling-daunting-ed53@gregkh>
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
git cherry-pick -x b74571a83fd3e50f804f090aae60c864d458187c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100115-dazzling-daunting-ed53@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

b74571a83fd3 ("drm/amd/display: Use full update for swizzle mode change")
09cb922c4e14 ("drm/amd/display: Add debug options to change sharpen policies")
efaf15752d11 ("drm/amd/display: Add sharpness control interface")
469a486541b6 ("drm/amd/display: add sharpness support for windowed YUV420 video")
6efc0ab3b05d ("drm/amd/display: add back quality EASF and ISHARP and dc dependency changes")
85ecfdda063b ("drm/amd/display: Re-order enum in a header file")
f9e675988886 ("drm/amd/display: roll back quality EASF and ISHARP and dc dependency changes")
748b3c4ca0bf ("drm/amd/display: Add visual confirm for Idle State")
f82200703434 ("drm/amd/display: remove dc dependencies from SPL library")
c18fa08e6fd8 ("drm/amd/display: Disable subvp based on HW cursor requirement")
5f30ee493044 ("drm/amd/display: quality improvements for EASF and ISHARP")
bbd0d1c942cb ("drm/amd/display: Fix possible overflow in integer multiplication")
0057b36ac2be ("drm/amd/display: Send message to notify the DPIA host router bandwidth")
6b6d38c5086f ("Revert "drm/amd/display: workaround for oled eDP not lighting up on DCN401"")
6184bd5750a8 ("drm/amd/display: Enable DCN401 idle optimizations by default")
e902dd7f3e3b ("drm/amd/display: workaround for oled eDP not lighting up on DCN401")
a00e85713c37 ("drm/amd/display: Update DML2.1 generated code")
2998bccfa419 ("drm/amd/display: Enable ISHARP support for DCN401")
9716bae1eaaf ("drm/amd/display: Disable DCN401 idle optimizations")
7a1dd866c5ac ("drm/amd/display: enable EASF support for DCN40")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b74571a83fd3e50f804f090aae60c864d458187c Mon Sep 17 00:00:00 2001
From: Charlene Liu <Charlene.Liu@amd.com>
Date: Wed, 4 Sep 2024 15:58:25 -0400
Subject: [PATCH] drm/amd/display: Use full update for swizzle mode change

[WHY & HOW]
1) We did linear/non linear transition properly long ago
2) We used that path to handle SystemDisplayEnable
3) We fixed a SystemDisplayEnable inability to fallback to passive by
   impacting the transition flow generically
4) AFMF later relied on the generic transition behavior

Separating the two flows to make (3) non-generic is the best immediate
coarse of action.

DC can discern SSAMPO3 very easily from SDE.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67812fbbb006..a1652130e4be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2376,7 +2376,7 @@ static bool is_surface_in_context(
 	return false;
 }
 
-static enum surface_update_type get_plane_info_update_type(const struct dc_surface_update *u)
+static enum surface_update_type get_plane_info_update_type(const struct dc *dc, const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
@@ -2455,7 +2455,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 		/* todo: below are HW dependent, we should add a hook to
 		 * DCE/N resource and validated there.
 		 */
-		if (u->plane_info->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
+		if (!dc->debug.skip_full_updated_if_possible) {
 			/* swizzled mode requires RQ to be setup properly,
 			 * thus need to run DML to calculate RQ settings
 			 */
@@ -2547,7 +2547,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	update_flags->raw = 0; // Reset all flags
 
-	type = get_plane_info_update_type(u);
+	type = get_plane_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	type = get_scaling_info_update_type(dc, u);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e659f4fed19f..78ebe636389e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1060,6 +1060,7 @@ struct dc_debug_options {
 	bool enable_ips_visual_confirm;
 	unsigned int sharpen_policy;
 	unsigned int scale_to_sharpness_policy;
+	bool skip_full_updated_if_possible;
 };
 
 


