Return-Path: <stable+bounces-94919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271C9D7341
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDECB2C767
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52C18C03D;
	Sun, 24 Nov 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es1qXrhJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46A18C018;
	Sun, 24 Nov 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455243; cv=none; b=YOnnV3toqgOtokAOsnsK76zvhNx/X2NZWvfQ7YXsewAUesuFZYZ/Z4m2ftA9XWJBqJgxl8DrxHYvpVICz/IiRlxS6cp4Int9JWBe4XOT0GVOzAMSkR5ANMTu42c8AfzGOhr4EXoapYxkkpiKmfL3IL/DB1pFMg+6oBwo2vYf5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455243; c=relaxed/simple;
	bh=JveZwb+ymZYdli8lEvczJNa71WCVVqfPBsvviIeB+YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbY77eY2wurIbRfTc/vKTACy04wbtR19jeak+fmTOpVK8PnFOxF0w/CLr5DgzdBNYcyEwN1bjwH1nGUU2kJl2BiILipKl+guKymNqQzFIE59hISwZLC8FysxgJ5Wfj3ABcWacdz4ZIoLF8DOILIsnw0gkz2WO9neyzgroK+16oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es1qXrhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB4C4CED1;
	Sun, 24 Nov 2024 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455243;
	bh=JveZwb+ymZYdli8lEvczJNa71WCVVqfPBsvviIeB+YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Es1qXrhJA8fcQuNcvWBhEPevA2+gXeOjhB90K+DxTd06OoQTaw/szWk5aRb/GNd9p
	 xVqfppFE/uuUanubbQhgioKehnrrs+YahUzwmFIygYoeCL3ZS8UylR6ZKtkv6KC2ou
	 Uj7nIH7LJj5zL7hBnpxuB79yk5POnCLVnkfnw0ktp71SUNeOGvMwZAm/Nzo71rBL4r
	 XoytptJnUplDAgV2ag3nNRl0AldYoKGq/AxAFQYVcOtSRHHhHqT8/vaHZx8BcH8ceO
	 XQaPBNvzM6V5UkFxNpZB53t4Xb71opoxkVEqlL1xq5aJDapH9iZhxP3wsIItPd/XRA
	 6VhwkJjtYVxKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	hamza.mahfooz@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	sunil.khatri@amd.com,
	aurabindo.pillai@amd.com,
	mwen@igalia.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 023/107] drm/amd/display: disable SG displays on cyan skillfish
Date: Sun, 24 Nov 2024 08:28:43 -0500
Message-ID: <20241124133301.3341829-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 66369db7fdd7d58d78673bf83d2b87ea623efb63 ]

These parts were mainly for compute workloads, but they have
a display that was available for the console.  These chips
should support SG display, but I don't know that the support
was ever validated on Linux so disable it by default. It can
still be enabled by setting sg_display=1 for those that
want to play with it.  These systems also generally had large
carve outs so SG display was less of a factor.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3356
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8d97f17ffe662..623e349b6f137 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1886,7 +1886,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		else
 			init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0);
 	} else {
-		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(2, 0, 3))
+			init_data.flags.gpu_vm_support = (amdgpu_sg_display == 1);
+		else
+			init_data.flags.gpu_vm_support =
+				(amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
 	}
 
 	adev->mode_info.gpu_vm_support = init_data.flags.gpu_vm_support;
-- 
2.43.0


