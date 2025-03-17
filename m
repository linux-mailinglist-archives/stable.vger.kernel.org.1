Return-Path: <stable+bounces-124681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D664A658B2
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275413B3AE6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1C1ADC8F;
	Mon, 17 Mar 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9xZXLqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A41A2381;
	Mon, 17 Mar 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229528; cv=none; b=D4zys/9duo2z0HVA1TAjmnRcOix9k+8zbsTvGZBDVAJwSINtPJF9WrUKVeNF1+uKtvL/ZUVaEZYWPeqVNtb4U3xzmRwg0mwIBx7ebLoc/UNnRW1RnrvyRc7EFwmyA6494aSnf38fnUu+mJ/V2giF/YEQCIz/Ez7n8K85uMfHc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229528; c=relaxed/simple;
	bh=EcyO65qRUdnNsmlnJCLF/E88IXXOSBet6vNR1pQI/sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXNCSVu8JnOoRGGxlHCyVty+rfMhY5/SzPYkS9320EIYm3cNs6qHAkqdDwQqq4imuo5BHXWmRdF7+pcSmKiDEd6+03C37SiVUwMVUqg2GOP3cxpoCyyigBHTV1XyNoiA8u+ijQcSZ/CthFg3VRByu+VtrnLuc/qkSdVwzi2LVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9xZXLqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDB7C4CEEC;
	Mon, 17 Mar 2025 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229528;
	bh=EcyO65qRUdnNsmlnJCLF/E88IXXOSBet6vNR1pQI/sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9xZXLqV/864PDiPOpRjWdKqSDZacmJaHN2qkW1xmlN7JIRIuK2PvAM4halqm8gx6
	 CoCx9yTgxO6LXzoA2nTTaepWS94ADcn7w9b4QazjynhTaDqAETHD/cyk2TD7Qq1/ya
	 nbGav/0udQEcY27OCf3z+IfT4QoXlvq9XUVzIJwmCqXe/iZRpcMvdRlc2WH1H2UClX
	 kOs7YG39fsVHLAOFaEDF4pP/lG20Z9nbdppvITurtzHQ8CcvlOvcLGWcoFr/R1LeFX
	 j/rwQ/iLdjMbWgoPGZaoayJ8/pe4A/Omwzc8NqPV+UQDSgTjp2JEQkMEYdeLNnGmYP
	 unm5Ll9JQHIKg==
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
Subject: [PATCH AUTOSEL 6.12 10/13] drm/amd: Keep display off while going into S4
Date: Mon, 17 Mar 2025 12:38:15 -0400
Message-Id: <20250317163818.1893102-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
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
index 32afcf9485245..7978d5189c37d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2633,7 +2633,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 
 	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
 	if (r)
 		return r;
 
@@ -2645,8 +2644,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
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
@@ -2659,6 +2663,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5df26f8937cc8..35bbc7e0b2739 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3297,6 +3297,11 @@ static int dm_resume(void *handle)
 
 		return 0;
 	}
+
+	/* leave display off for S4 sequence */
+	if (adev->in_s4)
+		return 0;
+
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_state_release(dm_state->context);
 	dm_state->context = dc_state_create(dm->dc, NULL);
-- 
2.39.5


