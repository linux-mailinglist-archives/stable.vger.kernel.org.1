Return-Path: <stable+bounces-148839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4EACA778
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1759E0373
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77C331435;
	Sun,  1 Jun 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFamE6Y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936833142A;
	Sun,  1 Jun 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821442; cv=none; b=N/rdh96mAKl5a2BPNS54p5QgUFiac4QoknNYkA09f6pP8HGEonmG9O7npIwlzoRshvEJ9PFu7E9lvTDiAvOFN3hhmkYdgYeogGeO//DgcnwWIbCcZ8pk8kam+T6rBWoVIKS3gLcfA6Rq4fmfJMDbL0WdmZhnGGKGJYWCybznYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821442; c=relaxed/simple;
	bh=8ap7oBQTRaglvG6WPf8bWVn25FVVNO5wlzMPqfDUgaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EEzLTDmGKN7XUyY2Q117zgwQHsqx2EpIDdIxEN7Cb+14Y1WWm3DpWv+bhTl6QPJGu03g/p2bJrqQU6ALNklpg2DGNYUJ3PrFtYwUIANreoZDB/eEhlmPsYXDx3V9mBmkKE08AWTRRTzRgwQi4/SwL8XPcZuaOHARfETQKp2Jx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFamE6Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8343AC4CEE7;
	Sun,  1 Jun 2025 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821442;
	bh=8ap7oBQTRaglvG6WPf8bWVn25FVVNO5wlzMPqfDUgaE=;
	h=From:To:Cc:Subject:Date:From;
	b=IFamE6Y2LE480zrjtS5v8nXnaQDapjsW3OnlxxvXAnmkAt44QvyOK5+VUtNjJxday
	 wTAipizwOjSlH1ug67fZmA9SkDcKljGDWU1YPgCjQRhqElTCv5ScfZ7ZK4NECDlCZJ
	 gWG86k7eSpCF30scc9Aw2ljpxeuhgADe0ACJBZh5tC3N1vWQ03QseLcrbDPBxrWRIB
	 ZjsM5dxaC7Nw44KEPoMOL1sWGKFSQwLoSF4iJiRlFltfJ07in9CHGlFegg/LCoLd1Y
	 acmSWOvsNEeRhtkVzXSpfjU4DnWWBx6A8Pn5B5LceRonWjI+8HDeyAa+9NffVdflqz
	 HsSr8W18/6c/A==
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
	alexandre.f.demers@gmail.com,
	boyuan.zhang@amd.com,
	kevinyang.wang@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/34] drm/amdgpu/gfx6: fix CSIB handling
Date: Sun,  1 Jun 2025 19:43:25 -0400
Message-Id: <20250601234359.3518595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 8307ebc15c1ea98a8a0b7837af1faa6c01514577 ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now let me understand what the bug is. Looking at the original code:
```c for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
for (ext = sect->section; ext->extent != NULL; ++ext) { if (sect->id ==
SECT_CONTEXT) { // process SECT_CONTEXT sections } else { return; //
BUG: This returns early, skipping remaining code } } } // Important code
that should always run: buffer[count++] =
cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1)); buffer[count++] =
cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START); //
... more important buffer initialization ``` The fix removes the early
return so that all sections are processed and the important buffer
initialization at the end always runs. **YES** This commit should be
backported to stable kernel trees for the following reasons: 1. **Clear
Bug Fix**: The commit fixes a clear logic error where an early return
statement prevents critical buffer initialization code from executing.
The original code would return immediately when encountering a non-
SECT_CONTEXT section, skipping the important packet commands that should
always be written to the buffer (PACKET3_SET_CONTEXT_REG,
PACKET3_PREAMBLE_END_CLEAR_STATE, PACKET3_CLEAR_STATE). 2. **Functional
Impact**: This bug affects the Clear State Indirect Buffer (CSIB)
handling in AMD GPU driver for GFX6 hardware. The incomplete buffer
initialization could lead to: - Incorrect GPU state during graphics
operations - Potential rendering issues or GPU hangs - Inconsistent
hardware behavior 3. **Small and Contained Fix**: The fix is minimal -
it simply removes two lines (the else block with return statement). This
is a low-risk change that doesn't introduce new functionality or alter
the architecture. 4. **Hardware-Specific Bug**: This affects real users
with GFX6 AMD GPUs. The bug prevents proper initialization of the GPU's
clear state buffer, which is essential for correct GPU operation. 5.
**Similar to Historical Backports**: Looking at commit 4 in the similar
commits (marked as YES for backporting), which also fixed preamble
handling issues in the AMD GPU driver, this follows a similar pattern of
fixing command buffer handling bugs. The commit message clearly
indicates this is a bug fix ("We shouldn't return after the last
section. We need to update the rest of the CSIB"), and the code change
confirms that critical buffer initialization was being skipped due to
the premature return.

 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 79c52c7a02e3a..d447b2416b98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2896,8 +2896,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
 				buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.39.5


