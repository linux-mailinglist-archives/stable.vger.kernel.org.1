Return-Path: <stable+bounces-124691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942EA658CC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458D91888FBB
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96A1CB9EA;
	Mon, 17 Mar 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhZbzU3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3D1A3163;
	Mon, 17 Mar 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229563; cv=none; b=VRORVeUD1sWu+Edzs1nDr5BwJmb3wCN96fIeXYnX+rc/HSjUv4kf3Ui+/HeF9XWxQWR3ySEQxNEofe5rvIdFKjtKvA/uvsrHxckzeb3wQslqp+vnPemhpS38Dc+MSp64d6aMyc+7MKM4iQMT25zRLQkbJL37yaCRxxe2SgfGBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229563; c=relaxed/simple;
	bh=zgWZaqceqFPunHhxCh9P0gIfWLby5B3NHXKqZzQouFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrRGvLqhI+ZZjyG1Vezlnzlb82ilykOMjSDhB3xeSe00ifIwllnb6+EADxRBTHgmnrofacoAklBS2QGFgOrJCS9ZwDEH/rMwFU28KkWLCzFj5eW9guXB7fmKOoYV/ZFUSTz2Memho/KDB3TSkT9SHo/r6rvCK9qT2wtz0xSjB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhZbzU3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C1AC4CEEC;
	Mon, 17 Mar 2025 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229563;
	bh=zgWZaqceqFPunHhxCh9P0gIfWLby5B3NHXKqZzQouFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhZbzU3c+QiVjq7w23LtruzkfzcSjDIrNKQcxsTiot5QUsvh4fJ/tXATgsNl8djtL
	 ew0vc6g6hQahj1Y5G3B+PurzKcc6D10z0VTyO7HeogP/sbkcMq21bVyzuh3UgQk9qV
	 ZGpzRNJq0mkKxTCLLf4wysZ25FnjasUCSMg9I1RBhXIapYBMg6+sMJkddMg+uvFR/b
	 zYclF47fk0PD/PVOx/zOBW6/17VNIPjv1vRWNJ3Vg2h7QTHcVJ2jw1Tblx9oJAKIfi
	 jRexlD7HPzybrIFbV4qp5Dw63ie4UWgwm8WhOCGBeov1MQoZ9VfdDZOl44SCqOvyGC
	 J5ktfCvUN5fiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunpeng.li@amd.com,
	lijo.lazar@amd.com,
	tzimmermann@suse.de,
	rajneesh.bhardwaj@amd.com,
	kenneth.feng@amd.com,
	shaoyun.liu@amd.com,
	Ramesh.Errabolu@amd.com,
	Jack.Xiao@amd.com,
	chiahsuan.chung@amd.com,
	siqueira@igalia.com,
	sunil.khatri@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	hersenxs.wu@amd.com,
	mwen@igalia.com,
	hamzamahfooz@linux.microsoft.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 7/8] drm/amd: Keep display off while going into S4
Date: Mon, 17 Mar 2025 12:39:01 -0400
Message-Id: <20250317163902.1893378-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163902.1893378-1-sashal@kernel.org>
References: <20250317163902.1893378-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.83
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 4afacc9948e1f8fdbca401d259ae65ad93d298c0 ]

When userspace invokes S4 the flow is:

1) amdgpu_pmops_prepare()
2) amdgpu_pmops_freeze()
3) Create hibernation image
4) amdgpu_pmops_thaw()
5) Write out image to disk
6) Turn off system

Then on resume amdgpu_pmops_restore() is called.

This flow has a problem that because amdgpu_pmops_thaw() is called
it will call amdgpu_device_resume() which will resume all of the GPU.

This includes turning the display hardware back on and discovering
connectors again.

This is an unexpected experience for the display to turn back on.
Adjust the flow so that during the S4 sequence display hardware is
not turned back on.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2038
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Link: https://lore.kernel.org/r/20250306185124.44780-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 68bfdc8dc0a1a7fdd9ab61e69907ae71a6fd3d91)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f9bc38d20ce3e..a51ceebb80547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2461,7 +2461,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 
 	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
 	if (r)
 		return r;
 
@@ -2473,8 +2472,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->in_s4 = false;
+
+	return r;
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2487,6 +2491,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aab99df3ba1ae..37e087e8fcb23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2881,6 +2881,11 @@ static int dm_resume(void *handle)
 
 		return 0;
 	}
+
+	/* leave display off for S4 sequence */
+	if (adev->in_s4)
+		return 0;
+
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_release_state(dm_state->context);
 	dm_state->context = dc_create_state(dm->dc);
-- 
2.39.5


