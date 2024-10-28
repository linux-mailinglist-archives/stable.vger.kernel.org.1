Return-Path: <stable+bounces-88254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3E9B2197
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A48C281303
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570F3A1BF;
	Mon, 28 Oct 2024 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IpwUI8pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA701CA5A
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730076170; cv=none; b=ZquMVQ/EHpuuVTxKsN3ofIIIxSsHWuPm5hyNZ69U7Yem5MHVEDm/qpDaoTP8dJt5+B0w4vBt6uVb/MQDEZJ6zuFWdaTD3xJkIGWkI7qemjpBisfNMuNPtIacc6JRauz86s8SHIP1tTzHZybG0+UAFbGctFhbg+Cd5iHgHQI9sjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730076170; c=relaxed/simple;
	bh=UK+FvNXEygBm3iJI/N2hP9NxNFGaQR+e0K7wTKELZw4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dRI7xxkhiRhlLMVom9UM4HZw6yhYLQDwGs7EZJUXMZx1AZxPN5zoS4nY98SoSh7TjFlCj+u5HeXyCCpWnbceh1gfQHJ0YSX4mTT7zefbV7GSSEuhT097kSxLSow1TL1FSMa8zyb9VuVFBco3LfANLdDO3XA3X5L5dg+42kNz5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IpwUI8pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385D8C4CEC3;
	Mon, 28 Oct 2024 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730076170;
	bh=UK+FvNXEygBm3iJI/N2hP9NxNFGaQR+e0K7wTKELZw4=;
	h=Subject:To:Cc:From:Date:From;
	b=IpwUI8pe4xYLTuSdzl38IjycwjB4bvOljgF09qi2reYNV7/foA+tTb/HoDBFEVM6A
	 et+Xwd1J8B8hPWY1EV4RUEI5WE+7z/wiYVaxhqFKF5vN+xUpYN5g9sib2uJ7Orz72z
	 nMIXXY7RG4/K9z0PMIKQDdIbS2eSqdGEzRBrO3Xc=
Subject: FAILED: patch "[PATCH] drm/amd/display: temp w/a for dGPU to enter idle" failed to apply to 6.11-stable tree
To: aurabindo.pillai@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,harry.wentland@amd.com,mario.limonciello@amd.com,rodrigo.siqueira@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:42:38 +0100
Message-ID: <2024102838-opal-rule-c671@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 23d16ede33a4db4973468bf6652a09da5efd1468
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102838-opal-rule-c671@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23d16ede33a4db4973468bf6652a09da5efd1468 Mon Sep 17 00:00:00 2001
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Date: Tue, 1 Oct 2024 18:03:02 -0400
Subject: [PATCH] drm/amd/display: temp w/a for dGPU to enter idle
 optimizations

[Why&How]
vblank immediate disable currently does not work for all asics. On
DCN401, the vblank interrupts never stop coming, and hence we never
get a chance to trigger idle optimizations.

Add a workaround to enable immediate disable only on APUs for now. This
adds a 2-frame delay for triggering idle optimization, which is a
negligible overhead.

Fixes: 58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Fixes: e45b6716de4b ("drm/amd/display: use a more lax vblank enable policy for DCN35+")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9b47278cec98e9894adf39229e91aaf4ab9140c5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6b5e2206e687..13421a58210d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8374,7 +8374,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
 		    IP_VERSION(3, 5, 0) ||
 		    acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED) {
+		    DC_PSR_VERSION_UNSUPPORTED ||
+		    !(adev->flags & AMD_IS_APU)) {
 			timing = &acrtc_state->stream->timing;
 
 			/* at least 2 frames */


