Return-Path: <stable+bounces-77518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAED985E04
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42AA28D1F3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C7209E5B;
	Wed, 25 Sep 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEE1yHzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAF209E57;
	Wed, 25 Sep 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266093; cv=none; b=auU7p3wwZewidF3/6YTlK5/KPOVAB8iQg6oM3xr93HNm6mFi+Bafpvhr9PVyBjb0+c156xndozQlZvnxLsg6tcT+2bG6kYaRvaOzdxkFIiUyKieu5nGo1riagQx3+7QiK+DYO5xvBCml1dbhHdfxzAVmGfpJdfVbPnrgBuoN4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266093; c=relaxed/simple;
	bh=hcjXj2b6DyEXX6sx67kGasHZ8IDL964jReM/A2+m9es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1XszA0RaAMqLG0Ph7IVbo9byURWLPUWNaMC1NaVt0MkBfjTMLd5vj+TsuAwebei8KsahhW8Jf58CxETslRgjLzrzMdSjn4V4fq6Qe2CngLEArSnRZ0tWoLsTVLjgYdX3Q+hxQVnxYASe15USQty4MQor+v5IHc8Ze8Fl1Ngj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEE1yHzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C8CC4CECD;
	Wed, 25 Sep 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266093;
	bh=hcjXj2b6DyEXX6sx67kGasHZ8IDL964jReM/A2+m9es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEE1yHzrtnni5LbFGqHSJ7NP2WBcCafWeVHfPiQVpxCw7sTt2RpBMsk9nPf+tmkdI
	 CXZSXk/NCWn4sg3BI+8wBf9rP8rSw5bVtad3HI+1XrNB+Y73ozb5mYchWPbO63IfW+
	 E4ww1DnvBS+dg4np+OhNqIKjppMg5RTVNoxk6paEso2M23fMqLgjJ0XA2L/mrVNfGt
	 sn6dFmW5BkOjCaovT1xNEswVy6vj13P5wtNFiyqEpZuGemwDY7WR7Nxq+iXKKKFdCB
	 4gxPrNRmSTLk2GMO69ZSXS21fhqZfIEU5qb7N0lAqYWpwd0p2uAns0nDtFAK19lE4J
	 B6pc7E7ajtMww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Skvortsov <victor.skvortsov@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	kevinyang.wang@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	sathishkumar.sundararaju@amd.com,
	boyuan.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 170/197] drm/amdgpu: Block MMR_READ IOCTL in reset
Date: Wed, 25 Sep 2024 07:53:09 -0400
Message-ID: <20240925115823.1303019-170-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Victor Skvortsov <victor.skvortsov@amd.com>

[ Upstream commit 9e823f307074c0f82b5f6044943b0086e3079bed ]

Register access from userspace should be blocked until
reset is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 43 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 977cde6d13626..6d4e774b6cedc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amd_pcie.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
@@ -778,6 +779,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
+		int ret = 0;
 		unsigned int n, alloc_size;
 		uint32_t *regs;
 		unsigned int se_num = (info->read_mmr_reg.instance >>
@@ -787,24 +789,37 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -ENOENT;
+
 		/* set full masks if the userspace set all bits
 		 * in the bitfields
 		 */
-		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
+		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
 			se_num = 0xffffffff;
-		else if (se_num >= AMDGPU_GFX_MAX_SE)
-			return -EINVAL;
-		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
+		} else if (se_num >= AMDGPU_GFX_MAX_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
 			sh_num = 0xffffffff;
-		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
-			return -EINVAL;
+		} else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		if (info->read_mmr_reg.count > 128)
-			return -EINVAL;
+		if (info->read_mmr_reg.count > 128) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
-		if (!regs)
-			return -ENOMEM;
+		if (!regs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
 		amdgpu_gfx_off_ctrl(adev, false);
@@ -816,13 +831,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
 				amdgpu_gfx_off_ctrl(adev, true);
-				return -EFAULT;
+				ret = -EFAULT;
+				goto out;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
-		return n ? -EFAULT : 0;
+		ret = (n ? -EFAULT : 0);
+out:
+		up_read(&adev->reset_domain->sem);
+		return ret;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
 		struct drm_amdgpu_info_device *dev_info;
-- 
2.43.0


