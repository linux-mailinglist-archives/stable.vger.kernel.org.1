Return-Path: <stable+bounces-148392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475BACA1D0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786F81892991
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386625F993;
	Sun,  1 Jun 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdfCPI+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224025FA1F;
	Sun,  1 Jun 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820345; cv=none; b=Krael7yDg8MEEWwxZt0CGpGvo+KFsVl5iJkGsmSbATOxOh/AcWRZOpSvBatD3MWJrStcl90GODQyJsVjw7828vwKJroKDf3JYSOfCB5y8hHjomFfKRmV/wQzWqOVmpSn4EUri3wlrtSxGdmM2Zl/ZzyCJMA1KQErieXJ9lDwEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820345; c=relaxed/simple;
	bh=bvw+k3QRqKUAJ2ZYFESlxQQEAa5h0GeMvUWBFW9RKdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpBtZ+tuOt3xsnZN6AgCrGXtwzjVDg7QGo0fYCdXHqjrNrPWEvhDrJI82ifzwKlUCZHuhaXsL0/GkoZEoZjEC1b3ee+oieHtVIZTq2nla11MY7MDjtRhLj3gbFBny3nK8jLove5T+lKcfUCS12uq51nKdUDS10QKrwNO/Mlm+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdfCPI+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E65C4CEE7;
	Sun,  1 Jun 2025 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820344;
	bh=bvw+k3QRqKUAJ2ZYFESlxQQEAa5h0GeMvUWBFW9RKdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdfCPI+P2rvKQ5OVgvAGdLEQlOey95CDQfIJ8t4DBaI2h0jnGmLG90j8R/jjJGnex
	 F3MU3joz1Cx47e4eJhNDCuzbWfEF2vkG28VUt+s72cyVwq9mM6ikgaBLqKHmyPNYrt
	 H/13NlYanc+s6iN0Xj6g2Y/7MLUKRhWDuwupImsAHcqiIW4kc1Ikp1UAGxv6T0hNoH
	 wwNRfqtxGXfD2zJ6qbj6szs7LXXQcIc3jGszddKsRVBefNdkCdjeL9SyOkgg9vlAVB
	 dGTsf2evNJBvWIIbsOYzjxbKDy9Z3HLnEHgO/hwRvmDDLRFi2OnAQcP3gYK2XHflAe
	 mdYEyI8biHW+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ben Skeggs <bskeggs@nvidia.com>,
	Dave Airlie <airlied@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	lyude@redhat.com,
	dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	zhiw@nvidia.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 026/110] drm/nouveau/gsp: fix rm shutdown wait condition
Date: Sun,  1 Jun 2025 19:23:08 -0400
Message-Id: <20250601232435.3507697-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Ben Skeggs <bskeggs@nvidia.com>

[ Upstream commit 7904bcdcf6b56602a049ed2b47282db63671fa99 ]

Though the initial upstreamed GSP-RM version in nouveau was 535.113.01,
the code was developed against earlier versions.

535.42.02 modified the mailbox value used by GSP-RM to signal shutdown
has completed, which was missed at the time.

I'm not aware of any issues caused by this, but noticed the bug while
working on GB20x support.

Signed-off-by: Ben Skeggs <bskeggs@nvidia.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Timur Tabi <ttabi@nvidia.com>
Tested-by: Timur Tabi <ttabi@nvidia.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Analysis:** **1. Nature of the Bug Fix:** The commit fixes a bug in
the GSP-RM shutdown wait condition in the r535_gsp_fini() function at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:2612. The change is from:
```c if (nvkm_falcon_rd32(&gsp->falcon, 0x040) & 0x80000000) ``` to:
```c if (nvkm_falcon_rd32(&gsp->falcon, 0x040) == 0x80000000) ``` **2.
Technical Impact:** - The original code used a bitwise AND operation
(`&`) to check if bit 31 is set in the mailbox value - The fixed code
uses an equality comparison (`==`) to check if the mailbox value is
exactly 0x80000000 - This fixes a version compatibility issue where GSP-
RM 535.42.02 changed the shutdown completion signal value - The bug
could potentially cause incorrect shutdown behavior or timing issues
**3. Backport Criteria Assessment:** - **Fixes important bug**: YES -
This fixes a GSP-RM shutdown synchronization bug that could affect
system stability - **Small and contained**: YES - Single line change,
very minimal and focused - **No architectural changes**: YES - Simple
conditional logic fix - **Minimal regression risk**: YES - The change is
specific to GSP-RM shutdown sequence and well-understood - **Clear side
effects**: NO - The fix has no unexpected side effects, only corrects
the intended behavior **4. Critical Subsystem Impact:** The change
affects the Nouveau DRM GSP (Graphics System Processor) subsystem,
specifically the shutdown sequence. GSP is critical for modern NVIDIA
GPU operation, and incorrect shutdown behavior could lead to system
instability, resource leaks, or improper hardware state transitions.
**5. Historical Context:** Looking at the similar commits provided as
reference, all were marked "NO" for backporting because they were
architectural preparation changes for GSP-RM support (adding `if
(nvkm_gsp_rm(device->gsp)) return -ENODEV;` guards). This commit is
fundamentally different - it's a targeted bug fix rather than a feature
preparation change. **6. Stability Tree Rules Compliance:** - This is an
important bugfix that corrects faulty synchronization logic - It has
minimal risk of introducing regressions - The change is confined to a
specific subsystem (nouveau GSP) - No new features are introduced The
commit message explicitly states this was developed against earlier GSP-
RM versions and the bug was "missed at the time" when 535.42.02 modified
the mailbox behavior. While the author mentions being unaware of
specific issues, incorrect shutdown synchronization in GPU drivers can
lead to subtle but serious problems including system hangs, resource
leaks, or corrupted GPU state.

 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index db2602e880062..6a964b54f69c2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -2838,7 +2838,7 @@ r535_gsp_fini(struct nvkm_gsp *gsp, bool suspend)
 		return ret;
 
 	nvkm_msec(gsp->subdev.device, 2000,
-		if (nvkm_falcon_rd32(&gsp->falcon, 0x040) & 0x80000000)
+		if (nvkm_falcon_rd32(&gsp->falcon, 0x040) == 0x80000000)
 			break;
 	);
 
-- 
2.39.5


