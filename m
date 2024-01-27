Return-Path: <stable+bounces-16208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A783F1AB
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4957280CA3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063B200BD;
	Sat, 27 Jan 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lg0geWjb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D64200AA
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397332; cv=none; b=OAzGsw/ikQ/Wyp18Wlef5RxmwJjLjXk1ElDMvWUh4Q8Qm3Cw2N0ZeZOFL4iasAyhM7nyCPxkDahGTTsJ3FWcr9m7mUVYA2NCkvwdn2a1iqCWg2RttszSQ9V6/a1DdqEZdwWQcZwjuyrnWz6tMVSwmdq72gueefHBseRvbYwwyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397332; c=relaxed/simple;
	bh=3QyaP8RYUUYUUFAd6/HQmNY1D1a0QPy5DUjVHyP5Dhs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SWWT1mFhSdYANUMUarpPAjHogG81ARiITeEz+3jDooGTprQHad0aaWM/KJgDTjUAn8xCUlfFJNBu/VXQSwTK6er2AFO0MPcxxX6HuyXKer4BUu9BepJ0xvf12f4XNO7oPID28bgMurryrkCMfWSEoUVF97Z+cvTqECaZrDK9GJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lg0geWjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B2C43394;
	Sat, 27 Jan 2024 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397331;
	bh=3QyaP8RYUUYUUFAd6/HQmNY1D1a0QPy5DUjVHyP5Dhs=;
	h=Subject:To:Cc:From:Date:From;
	b=Lg0geWjb9tTTyscjW4mbBboz2+gJ230Wc7wyFc8d4BhcWqoHyZDn0EOGj7bChLmyX
	 rjuHc8yTddysc8BuVcAAVQwp2lZ/WrB/yB3qAnVwyhp4V3ELm453u6sbyK4R+cyC4s
	 XrSVNh1pYdrbsnZUcJUCO9tFlsGmzMkZ43fDVNZg=
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL" failed to apply to 6.1-stable tree
To: srinivasan.shanmugam@amd.com,Rodrigo.Siqueira@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:31 -0800
Message-ID: <2024012731-dislodge-unranked-578d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b2139c96dc954b58b81bc670fc4ea5f034ed062c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012731-dislodge-unranked-578d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b2139c96dc95 ("drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests.")
c81e13b929df ("drm/amd/display: Hande writeback request from userspace")
98a80bb3dd9d ("Revert "drm/amd/display: Hande writeback request from userspace"")
731a20cb89e6 ("Revert "drm/amd/display: Add writeback enable field (wb_enabled)"")
6d2959df6575 ("Revert "drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer"")
7086af68fab9 ("Revert "drm/amd/display: Disable DWB frame capture to emulate oneshot"")
77a66faaccc0 ("drm/amd/display: Disable DWB frame capture to emulate oneshot")
428542d91772 ("drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer")
f6893fcb10c7 ("drm/amd/display: Add writeback enable field (wb_enabled)")
cd1a4bc22821 ("drm/amd/display: Hande writeback request from userspace")
fff7b95a5046 ("drm/amd/display: Fix race condition when turning off an output alone")
c82eddf81276 ("drm/amd/display: Clean up errors & warnings in amdgpu_dm.c")
6c5e25a0255d ("drm/amd/display: add prefix to amdgpu_dm_crtc.h functions")
b8272241ff9d ("drm/amd/display: Drop dc_commit_state in favor of dc_commit_streams")
1e88eb1b2c25 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
455ad25997ba ("drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu")
8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
5ca38a18b5a4 ("drm/amd/display: move public dc link function implementation to dc_link_exports")
54618888d1ea ("drm/amd/display: break down dc_link.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2139c96dc954b58b81bc670fc4ea5f034ed062c Mon Sep 17 00:00:00 2001
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date: Sat, 13 Jan 2024 14:32:27 +0530
Subject: [PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL
 check for writeback requests.

Return value of 'to_amdgpu_crtc' which is container_of(...) can't be
null, so it's null check 'acrtc' is dropped.

Fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9302 amdgpu_dm_atomic_commit_tail() error: we previously assumed 'acrtc' could be null (see line 9299)

Added 'new_crtc_state' NULL check for function
'drm_atomic_get_new_crtc_state' that retrieves the new state for a CRTC,
while enabling writeback requests.

Cc: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10b2a896c498..d55eeb30ccb2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9293,10 +9293,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (!new_con_state->writeback_job)
 			continue;
 
-		new_crtc_state = NULL;
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 
-		if (acrtc)
-			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+		if (!new_crtc_state)
+			continue;
 
 		if (acrtc->wb_enabled)
 			continue;


