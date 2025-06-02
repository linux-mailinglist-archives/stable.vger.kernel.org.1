Return-Path: <stable+bounces-148497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB97ACA3D3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E13A60D6
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD928B4F2;
	Sun,  1 Jun 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJYsx24+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04428B4E1;
	Sun,  1 Jun 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820636; cv=none; b=Rog3gyLmKcmYXC2lZMDCsDT+vUJQuy2XvdNOUmzhcta5xBSmHE8GB6P11VkfUxjH4U1MEOSuNLlsBTA6kv63KBie14U5h6IJRU8lTxiHirDcegS4VjIIOkzjoR6FCTqJVFLAZUt70+dNqSLRRM1OIhBo6dRsPJQbL6/qeNjtWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820636; c=relaxed/simple;
	bh=29NBcHQHWtqh2gzCoQamWy8eEn9O0h9e48EmVeFAWN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qk8tR4RRqedQTkfQ7t6XGhCHAtFTd3mlWsaIlCeNjS1x3HVWeEO6HQ+H+fiNhJuIYmir5PV55BDfqEmAsLyE55zVTioGxeB+qs8+F36LZUdjnHtFT4sZ7uc7i2sLB7JBhGP39QJk7GOrk//yHWJ6gbE6BcclnrYhFywGVm40804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJYsx24+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCD6C4CEE7;
	Sun,  1 Jun 2025 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820636;
	bh=29NBcHQHWtqh2gzCoQamWy8eEn9O0h9e48EmVeFAWN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJYsx24+2rSJU1FPU/cd7p9qfd50DqUSw/lhSoAfYeeaRL8dywLeIlIjWnOXodh04
	 LVKfnlUcmSCBOyzYB9SerohIJQAR4Z1W8ErVS0iKUQAtRh5EBcJD+xbLLo5SAWI6Qx
	 mUSPHmJDulZ+khCtLYto0ox2zLQnDesVYiQ8qcyxlzZnuTB83eNY2oCJJ3FXfsyJrO
	 TCIhv8j1RM3h5rjyvtRnCFtyJIXWjeQInajvbIiQnqPBvCKGXdxQ6UIe49JF1+lUV/
	 gTMNNPLKbwIQ3dLFz5FX4B5lVw2HAftpunJOSLEz9USrb2c41ij2zZ4jnEOU+p1rYY
	 vhUugFPG7pIjA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	vitaly.prosyak@amd.com,
	srinivasan.shanmugam@amd.com,
	tim.huang@amd.com,
	Prike.Liang@amd.com,
	Jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 021/102] drm/amdgpu/gfx11: fix CSIB handling
Date: Sun,  1 Jun 2025 19:28:13 -0400
Message-Id: <20250601232937.3510379-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit a9a8bccaa3ba64d509cf7df387cf0b5e1cd06499 ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Analysis ### Code Change Analysis The commit fixes a **critical bug in
CSIB (Clear State Init Buffer) handling** in the GFX11 AMD GPU driver.
The problematic code in `gfx_v11_0_get_csb_buffer()` at line 861
contained: ```c } else { return; // This was the bug! } ``` This early
return statement prevented the function from completing the CSIB setup
when encountering non-SECT_CONTEXT sections. The fix removes this
premature return, allowing the function to continue and properly
complete the buffer initialization with: 1.
**PA_SC_TILE_STEERING_OVERRIDE register setup** (lines 866-870) 2.
**PACKET3_PREAMBLE_END_CLEAR_STATE** (lines 872-873) 3.
**PACKET3_CLEAR_STATE** (lines 875-876) ### Why This Qualifies for
Backporting 1. **Fixes Important Hardware Initialization Bug**: CSIB is
critical for GPU state management. Incomplete initialization can cause
GPU hangs, rendering artifacts, or system instability. 2. **Small,
Contained Fix**: The change removes only 2 lines (`} else { return; }`)
- minimal and low-risk. 3. **No Architectural Changes**: This is a pure
bugfix with no new features or major code restructuring. 4. **Critical
Subsystem**: Graphics drivers are essential for system functionality,
and GPU state corruption can cause severe user-visible issues. 5.
**Pattern Consistency**: Looking at similar sections across different
GFX versions (v10, v9, etc.), they all handle non-SECT_CONTEXT sections
by continuing rather than returning early, confirming this was indeed a
bug. ### Historical Context Support From examining the codebase, this
pattern is consistent across all GFX generations: - **gfx_v10_0.c:4227**
and **gfx_v10_0.c:4266**: Handle SECT_CONTEXT but continue for other
sections - **gfx_v9_0.c:1609** and **gfx_v9_0.c:1645**: Same pattern -
**gfx_v8_0.c**, **gfx_v7_0.c**, **gfx_v6_0.c**: All follow the same
approach The previous GFX10 CSIB fix (commit 4905880b4515) shows AMD's
commitment to ensuring proper CSIB initialization across GPU
generations, reinforcing the importance of this subsystem. ### Risk
Assessment - **Regression Risk**: Extremely low - only removes incorrect
early termination - **Testing Surface**: Affects GFX11 GPU
initialization, easily testable - **Side Effects**: None - only allows
completion of intended initialization sequence This is a textbook
example of a stable-worthy fix: important bug, minimal change, no
regression risk, and affects critical hardware functionality.

 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e050c2e4ea734..a1a49042e6152 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -857,8 +857,6 @@ static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.39.5


