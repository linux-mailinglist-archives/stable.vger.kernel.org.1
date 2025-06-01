Return-Path: <stable+bounces-148880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FEACA7C8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A21D1899255
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44133AC78;
	Sun,  1 Jun 2025 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9u34seL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADA33AC70;
	Sun,  1 Jun 2025 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821537; cv=none; b=OcIPBfJIpjcQiG/vsKNrn82XV/J1L3zPh4XLd/L0unfTpUcVNzEeL+ju27k/pi6mWbABmZQMTMgaIsXgxm+lI2Mg9E9Qzvllnd8Gf/rkigJ8N4raFekoTxVcruN9+XGbjMu7BgRX/BHGHDUg+GvrRqLyRCRtVDueIFVxRSJ/0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821537; c=relaxed/simple;
	bh=QFvusWPOJs3GzG14D1yTz4rw7YTwnJOfd8skCIvP97Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUgvyPW3khpUw6yrks9t2jHT/TPFTWBetYMonf7eKMIl1xKbnsG2PMi67eYl8to1hzYIzJNwbx7rgZbRbEe2Z8fwAhGI7P2MNBU5ZJ1E0jfEZX7yPG3cP4WgU7C8ZlXQzfNMqPkP6VCkFGpCWW4npnz1BDFmsjrwVGO3YxoUAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9u34seL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D0C4CEE7;
	Sun,  1 Jun 2025 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821537;
	bh=QFvusWPOJs3GzG14D1yTz4rw7YTwnJOfd8skCIvP97Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9u34seLDgus0szNL8cGqT2WX0dLEKUbHUuSMJWg1x4vBPasl+tY092iZTw1fCz+B
	 TOIiWRBzzS3lazoyAIZ7+J1K4Gk9es9C/wE1IBSGlJTIc8gk9u+z/j9vQ1iRJFT41H
	 7dnGtMl0T+tASMrcKAdnWmMzG5qz72j9jWEVLWoioJNbPUnWJc/YQw2DhbrkDMcY63
	 ik0qK3WBoYqR2Ncjtw/edJZdWu9ucQj/JgMKTAye+qg+XUV7MiMKwjqLdNI0N+/iQn
	 jzOuB5PexC8bmZzsx1V83BEna4gtk53ZeX2bDL+EJOqndK8CtXAjRYa+tsb8Q2+Hzi
	 DS7ymsvFOQDLg==
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
	srinivasan.shanmugam@amd.com,
	vitaly.prosyak@amd.com,
	Jesse.zhang@amd.com,
	Jiadong.Zhu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/22] drm/amdgpu/gfx10: fix CSIB handling
Date: Sun,  1 Jun 2025 19:44:59 -0400
Message-Id: <20250601234515.3519309-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234515.3519309-1-sashal@kernel.org>
References: <20250601234515.3519309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 683308af030cd9b8d3f1de5cbc1ee51788878feb ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Detailed Analysis: ### The Bug The commit fixes a critical bug in the
`gfx_v10_0_get_csb_buffer()` function in
`/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c`. The function is responsible
for building a Command Stream Buffer (CSB) for GPU initialization. **The
problematic code before the fix:** ```c for (sect =
adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) { for (ext =
sect->section; ext->extent != NULL; ++ext) { if (sect->id ==
SECT_CONTEXT) { buffer[count++] =
cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
buffer[count++] = cpu_to_le32(ext->reg_index -
PACKET3_SET_CONTEXT_REG_START); for (i = 0; i < ext->reg_count; i++)
buffer[count++] = cpu_to_le32(ext->extent[i]); } else { return; // ←
BUG: Early return prevents rest of buffer initialization } } } ``` **The
fix removes the early return:** ```c for (sect = adev->gfx.rlc.cs_data;
sect->section != NULL; ++sect) { for (ext = sect->section; ext->extent
!= NULL; ++ext) { if (sect->id == SECT_CONTEXT) { buffer[count++] =
cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
buffer[count++] = cpu_to_le32(ext->reg_index -
PACKET3_SET_CONTEXT_REG_START); for (i = 0; i < ext->reg_count; i++)
buffer[count++] = cpu_to_le32(ext->extent[i]); } // ← Early return
removed - now continues to process rest of buffer } } ``` ### Why This
Should Be Backported: 1. **Fixes Important GPU Initialization Bug**:
This is a clear functional bug that affects AMDGPU GFX10 hardware.
Looking at the clearstate data structure, I can see that
`gfx10_cs_data[]` contains only `SECT_CONTEXT` sections, but if any
future section was not `SECT_CONTEXT`, the early return would prevent
critical buffer initialization from completing. 2. **Affects Critical
Hardware Functionality**: The CSB (Command Stream Buffer) is essential
for proper GPU initialization. An incomplete buffer could lead to: - GPU
hang during initialization - Incorrect register states - System
instability - Failed GPU bring-up 3. **Small, Contained Fix**: The fix
is minimal - it simply removes an erroneous `else { return; }` clause.
This has very low risk of introducing regressions. 4. **No Architectural
Changes**: This doesn't change any APIs, interfaces, or architectural
decisions. It's a pure bugfix. 5. **Follows Stable Tree Criteria**: -
Important bugfix ✓ - Minimal risk ✓ - Confined to a subsystem ✓ - No new
features ✓ 6. **Critical GPU Subsystem**: The commit touches GPU command
submission infrastructure, which is critical for system stability when
AMD GFX10 hardware is present. 7. **Clear Commit Message**: The commit
message clearly explains the bug: "We shouldn't return after the last
section. We need to update the rest of the CSIB." Looking at the
reference commits, this aligns with "Similar Commit #4" which was marked
YES for backporting - it's a clear functional bugfix in critical GPU
subsystem code that prevents proper operation. The missing code after
the early return includes essential buffer finalization: - Setting
PA_SC_TILE_STEERING_OVERRIDE register - Adding
PACKET3_PREAMBLE_END_CLEAR_STATE - Adding PACKET3_CLEAR_STATE command
Without these, the GPU's clear state buffer would be incomplete,
potentially causing initialization failures.

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a84deb3c79a30..44380923b01c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -944,8 +944,6 @@ static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
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


