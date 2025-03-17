Return-Path: <stable+bounces-124695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09227A658DE
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD671897A3F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CEB1632D9;
	Mon, 17 Mar 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4tKAyme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E321A4F21;
	Mon, 17 Mar 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229585; cv=none; b=Ijt4ziRn/InmaoRZk455IqFNpGPTxCeGkzGpWX4iN4OXrYCA1ZxmeZNOTeuZK+pTIA4PEaYqCErSeVqbbcWqrRieAhZtlgTDx5pGz8NAbqdpU8pa/5sMvu5f6QtewCUTwrAtBoc+hEJAl9FJTu16R5SwzxcmFdSOCf1oJ0ztE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229585; c=relaxed/simple;
	bh=7kWfQ8zlguWQyuWeZIGhdUr9z+FhjfCrOr/e16jJDlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCUGdrL4KcICCbOs41GiUGsroG+WTn4wx3/cfa1UB203jphiatUKiFtmVLD2uN8Lkq3r+0ZyB+aafx2nCM+Nf97Q+MLkbewiGwuXC6ctrQSl3xFsXNPq+TQwOGoEiBCgFQTYvcVmvSSCmARX1PwNl4cjCUswocGQUdmH1COggLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4tKAyme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4D4C4CEEC;
	Mon, 17 Mar 2025 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229584;
	bh=7kWfQ8zlguWQyuWeZIGhdUr9z+FhjfCrOr/e16jJDlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4tKAymeska0K8Ywk/da2HVtejrhcUgbsBTPRxkVM7nHwv0VQuDoR1aYjFuhpS4pp
	 QOrokEp+vDDGfukl+XME2mYcW4unoNG9kS7tOt1u5cfRZ55FzZ0KNBbPLzrTGzqlYh
	 kXKSxNRjG1d3cYxJ2RupwBR1RO2Hzg2tWqR1hmY9e0ddgeupyLTHXb3THkp7s3L5GV
	 /j3oZvM9dWZFhDaD3B6+ILfWjiur1hvCA5qyCm+neiW8/ZkvN5UbQnSXpL3VHNxqQ9
	 c1V6h0P1jd+i+1exM8Rx9XDWMSitrghaBjLKJf4LUo5G7h5C33sCKN6pX6dg+vlfyW
	 E6JZYN4Mw0i6Q==
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
Subject: [PATCH AUTOSEL 6.1 3/4] drm/amd: Keep display off while going into S4
Date: Mon, 17 Mar 2025 12:39:26 -0400
Message-Id: <20250317163927.1893521-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163927.1893521-1-sashal@kernel.org>
References: <20250317163927.1893521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.131
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
index 238c15c0c7e1e..48076cf8ba803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2466,7 +2466,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 
 	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
 	if (r)
 		return r;
 
@@ -2478,8 +2477,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
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
@@ -2492,6 +2496,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dc0f70df24f8..f541ce3328f36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2887,6 +2887,11 @@ static int dm_resume(void *handle)
 
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


