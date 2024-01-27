Return-Path: <stable+bounces-16206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4383F1A9
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A5C280A71
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0101F95F;
	Sat, 27 Jan 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xpTOZLd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC701B7E5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397330; cv=none; b=Pjk+2jm6XM+rPncsD7I+ZClAx4RkwbQeAMBnvHT6evJhRqqT8TNgb8lk21lW4in0JgKEymuGqaKb3Tekd5/08DCojpK6jTnXGCSPrtFVvYFQulpLO+wavmJd81PMYJIfikTI2/OGs4IZt+1K0Bf8S+pogqUBS2GLZZizD8yLJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397330; c=relaxed/simple;
	bh=bf03UoHJk2DzkSh9fYARVu9t5J4wdRspXgpXGoHcqAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tmWsbAi4EOZP+twEw62abfYZ1EmbbqR1ScokTHdSSEjUKxueS185ZNUK+XdYgX1C6q39s60IorVrnu+uWr9rhNXTiYX0/wnTa5NNGOhW3xrks3hN/SO5+7/dOh/upp4XgcEaTTMcDZt2GZP75UsXaS9XWpRJqmftcPFt3/WNR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1xpTOZLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B60C433C7;
	Sat, 27 Jan 2024 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397329;
	bh=bf03UoHJk2DzkSh9fYARVu9t5J4wdRspXgpXGoHcqAI=;
	h=Subject:To:Cc:From:Date:From;
	b=1xpTOZLdfZArJ2XW/0zpK5BDWmeXa2HYVhEOyIEHYLx0ZoTlQ7eMZPXmWv0kxCeQQ
	 6gCqvbb49TMXa9Vz22f54aQ5SsK2J0V5+HcQu1xihofyrbIz4mkbkEkoYO9f4K6/Bo
	 2Tzb8KGfuUZ6Jm6WGSoLaTkZTk0wLmwc8L8qa3V0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL" failed to apply to 6.7-stable tree
To: srinivasan.shanmugam@amd.com,Rodrigo.Siqueira@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:15:28 -0800
Message-ID: <2024012728-pouring-landlady-2518@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x b2139c96dc954b58b81bc670fc4ea5f034ed062c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012728-pouring-landlady-2518@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

b2139c96dc95 ("drm/amd/display: Drop 'acrtc' and add 'new_crtc_state' NULL check for writeback requests.")
c81e13b929df ("drm/amd/display: Hande writeback request from userspace")

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


