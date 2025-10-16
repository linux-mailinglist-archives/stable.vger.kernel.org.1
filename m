Return-Path: <stable+bounces-185992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A780BE2753
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949E83E455A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDB3191D5;
	Thu, 16 Oct 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U50RpXKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768D3191C1
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607249; cv=none; b=MpuUacjfaz6Qi7qCzmh8Lq53i7nNHsEXM0rcYIAN97oMkz2DAiL4rSBZd7sI1eI9aJpxJDxhXWEHNukClusU/fywi6dmc3tnTSlZ/aJCsJLRsB0H/I55KQJZIeRTS3GXXFQtK0pXFqPwnX20qhGLLVKECRsQKMEhF/M6IIG0584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607249; c=relaxed/simple;
	bh=Q66X6igimOSJ4mO8hOsCTUFd421jUfUEZ1zAX1dvxdc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rqqtadrKiVBw0CbEKQ5m1ho2uLFfIaVqxphz04CgbBtz5lfnkmz43x3hpj0AGGxfaS5YqHTgjcQdApYLbwKLVy53MzFuj1jNk1hjiujOHSVvJVAZ8+lfzEf9VMG4+pRKZukaemmWRnvCXpReM0A7hy2bq8q6CvFsp3pDu1xg6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U50RpXKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EFDC4CEF1;
	Thu, 16 Oct 2025 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760607247;
	bh=Q66X6igimOSJ4mO8hOsCTUFd421jUfUEZ1zAX1dvxdc=;
	h=Subject:To:Cc:From:Date:From;
	b=U50RpXKUS0YxiqBRUWD6kOV/tJAs7Non7CNnVjHQz2+pam8uadoG/kgwh04b7sGw/
	 JyLaDpWC4k55QwlaxnbK7me52vpD2S/xozWHXlaOSJh7VZdrN6F2tqNjSqJo6R5ARk
	 yXnT/2CuPEfg+PgrN0TN5rKqWS5adO/bDb7v+uJ4=
Subject: FAILED: patch "[PATCH] drm/amd: Fix hybrid sleep" failed to apply to 6.17-stable tree
To: superm1@kernel.org,alexander.deucher@amd.com,ionut_n2001@yahoo.com,kenny@panix.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:33:57 +0200
Message-ID: <2025101656-trailside-reabsorb-e368@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 0a6e9e098fcc318fec0f45a05a5c4743a81a60d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101656-trailside-reabsorb-e368@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a6e9e098fcc318fec0f45a05a5c4743a81a60d9 Mon Sep 17 00:00:00 2001
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Thu, 25 Sep 2025 13:51:08 -0500
Subject: [PATCH] drm/amd: Fix hybrid sleep

[Why]
commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for
normal hibernation") optimized the flow for systems that are going
into S4 where the power would be turned off.  Basically the thaw()
callback wouldn't resume the device if the hibernation image was
successfully created since the system would be powered off.

This however isn't the correct flow for a system entering into
s0i3 after the hibernation image is created.  Some of the amdgpu
callbacks have different behavior depending upon the intended
state of the suspend.

[How]
Use pm_hibernation_mode_is_suspend() as an input to decide whether
to run resume during thaw() callback.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for normal hibernation")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: 6.17+ <stable@vger.kernel.org> # 6.17+: 495c8d35035e: PM: hibernate: Add pm_hibernation_mode_is_suspend()
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 395c6be901ce..dcea66aadfa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering())
+	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);


