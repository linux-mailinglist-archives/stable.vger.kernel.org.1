Return-Path: <stable+bounces-179480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9CCB560DE
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BAF3A7BFA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC52ECD28;
	Sat, 13 Sep 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mog4p/5i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708D26F29B
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767216; cv=none; b=K050TZUeCw0sOSGbUIrNnuptgLTX1vwKEgHVMjbhpAMP5jptHWrsEvW1LJXLMPhbQaITl1m2mObH3A6XPXRUg1pAmWTicpIw7ZX0OjDrAdfzUALooDvGvE53U/3LkTf7Re+Sdxob7aKL+0zFQK1L/PhNOQgQoDKJH7zfXwcPi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767216; c=relaxed/simple;
	bh=8MmpviY4yP2OEu/geBFgvp6ztWd2pjjNilpug2jDyTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GIqha/I265AOWDegPAyDPdQSn9tkHQm9Z/8mcpOuQYduYWwF6gQ1tmavM0chUsL5ryexHFQvTNZV5rk0HgqYzla82HtPxPLEar8gOUij6W2/QYmvIoRp+Hu3UoYTZd4kQf90/GNRuSO7kX8EFS8GQZRU/xsglW2YP6dyfDVybH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mog4p/5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEEAC4CEEB;
	Sat, 13 Sep 2025 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757767215;
	bh=8MmpviY4yP2OEu/geBFgvp6ztWd2pjjNilpug2jDyTc=;
	h=Subject:To:Cc:From:Date:From;
	b=mog4p/5imKcns8l/z6RfG+G61nuB7OI5yVXsHYjY76UJnaBTCooxhhjYJBkVSkPJv
	 wgi5+QaW5ktw5LO66EmGe78RPysvng+tbrF9KFdV1U+MtrEwKB/4T2qVfr4dD3Aijc
	 P2iDyvIl7rh5r8p3fdKpVAH71gtJVtw8awLNDaEA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop dm_prepare_suspend() and dm_complete()" failed to apply to 6.16-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com,hikaph+oss@gmail.com,prz.kopa@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:40:12 +0200
Message-ID: <2025091312-armful-thus-2400@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 60f71f0db7b12f303789ef59949e38ee5838ee8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091312-armful-thus-2400@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60f71f0db7b12f303789ef59949e38ee5838ee8b Mon Sep 17 00:00:00 2001
From: "Mario Limonciello (AMD)" <mario.limonciello@amd.com>
Date: Fri, 5 Sep 2025 10:36:27 -0500
Subject: [PATCH] drm/amd/display: Drop dm_prepare_suspend() and dm_complete()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Why]
dm_prepare_suspend() was added in commit 50e0bae34fa6b
("drm/amd/display: Add and use new dm_prepare_suspend() callback")
to allow display to turn off earlier in the suspend sequence.

This caused a regression that HDMI audio sometimes didn't work
properly after resume unless audio was playing during suspend.

[How]
Drop dm_prepare_suspend() callback. All code in it will still run
during dm_suspend(). Also drop unnecessary dm_complete() callback.
dm_complete() was used for failed prepare and also for any case
of successful resume.  The code in it already runs in dm_resume().

This change will introduce more time that the display is turned on
during suspend sequence. The compositor can turn it off sooner if
desired.

Cc: Harry Wentland <harry.wentland@amd.com>
Reported-by: Przemysław Kopa <prz.kopa@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org/T/#m383d9c08397043a271b36c32b64bb80e524e4b0f
Reported-by: Kalvin <hikaph+oss@gmail.com>
Closes: https://github.com/alsa-project/alsa-lib/issues/465
Closes: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4809
Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2fd653b9bb5aacec5d4c421ab290905898fe85a2)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7808a647a306..352b3dcd0e0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3127,25 +3127,6 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 	dm->cached_state = NULL;
 }
 
-static void dm_complete(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	dm_destroy_cached_state(adev);
-}
-
-static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_in_reset(adev))
-		return 0;
-
-	WARN_ON(adev->dm.cached_state);
-
-	return dm_cache_state(adev);
-}
-
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3571,10 +3552,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.early_fini = amdgpu_dm_early_fini,
 	.hw_init = dm_hw_init,
 	.hw_fini = dm_hw_fini,
-	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
-	.complete = dm_complete,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.check_soft_reset = dm_check_soft_reset,


