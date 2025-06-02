Return-Path: <stable+bounces-148425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58801ACA273
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CC81732DF
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53E26B972;
	Sun,  1 Jun 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJqTl48c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3626B098;
	Sun,  1 Jun 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820443; cv=none; b=IhKGIUXxcVl1QQIIEgvVmB/0kjGPTkTL7RhjhEmt1ip7qVIvZ7pLbhTo/xFCTsRYsQZ8wLyCp45m3zZc8u20Tb/V8AZjxBBH89CdnJzrU00ph9qyKEWKvmOhZyL4LScyntAqJMVb4BAzFVpR/nqGWMt6brs91U1zjxlQvsWht7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820443; c=relaxed/simple;
	bh=zMIf3X4Cj87IoZgWZ9ImgTOEPt/1OA45YJjRsLLU2tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoYnbMMETlaTT3nCDEO7/N3MfAi24NhMpp9rR+K9DuDPcSxlaAwyYz//0Hz0FeGzjCccFqxFUKX0JPUV3XqRw1WeMGfcR10/WcEGkN4V34yjqvmQLZiMsWtTjmnkBcfbBIOp3JfP4YkHNS0Va+4QSPdYUZgrAkZFDIjmkB8BA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJqTl48c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BFEC4CEF1;
	Sun,  1 Jun 2025 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820443;
	bh=zMIf3X4Cj87IoZgWZ9ImgTOEPt/1OA45YJjRsLLU2tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJqTl48cHf+6jR3qPjsJraydInxxKWH/wUnDI7VEor+3JKyF9hUVzEEs7W/ITBphg
	 A1SP4gBlCrJ7OwjfVKLxNyUDWsdWzq4EC4akfINquz98Mh7KJakbcbTFwecWmCVadE
	 ym7jg/jdeece5kFrQG6N4VvtSLteGy9y9OnXXu2ZSgP+HNMn1qyzRQtdTPPZno8sIa
	 6r8z0YqnSbomrJG2wfVXM0pMvd8JfkDYVVkQ5kn13YCGzQyzLDliwxnM5nmcYypzpu
	 /4AF3mIAx5mhSM6XaM4GhZCA9XARwLeZS5EdTS5PpLC6J1vu1jqIysfaCdU3hHr3SN
	 3PLkc+os3fCjA==
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
	boyuan.zhang@amd.com,
	lijo.lazar@amd.com,
	Prike.Liang@amd.com,
	kevinyang.wang@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 059/110] drm/amdgpu/gfx8: fix CSIB handling
Date: Sun,  1 Jun 2025 19:23:41 -0400
Message-Id: <20250601232435.3507697-59-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit c8b8d7a4f1c5cdfbd61d75302fb3e3cdefb1a7ab ]

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Extensive Analysis:** **1. Critical Bug Nature:** The code changes fix
a serious logic error in the CSIB (Clear State Indirect Buffer) handling
for AMD GFX8 hardware. The bug occurs in `gfx_v8_0_get_csb_buffer()`
where there's an early `return` statement in the `else` branch at line
1252: ```c if (sect->id == SECT_CONTEXT) { // Handle SECT_CONTEXT
sections... } else { return; // BUG: Early exit prevents rest of buffer
setup! } ``` **2. Impact and Severity:** This bug has significant
functional impact because: - The function is responsible for setting up
the Clear State Buffer, which is critical for GPU state initialization -
When encountering any section that isn't `SECT_CONTEXT` (such as
`SECT_CLEAR`, `SECT_CTRLCONST`, or `SECT_NONE` as defined in
`clearstate_defs.h`), the function exits early - This prevents the
essential final buffer setup steps from executing: - PA_SC_RASTER_CONFIG
register setup (lines 1257-1261) - PACKET3_PREAMBLE_END_CLEAR_STATE
packet (lines 1263-1264) - PACKET3_CLEAR_STATE packet (lines 1266-1267)
**3. Real-World Consequences:** An incomplete CSB buffer can lead to: -
GPU initialization failures - Rendering corruption - System instability
- Potential hangs during graphics operations **4. Code Quality
Assessment:** - **Small and contained:** The fix removes only 2 lines of
problematic code - **No architectural changes:** Pure bug fix with no
design modifications - **Clear intent:** The commit message explicitly
states the problem and solution - **Low regression risk:** Removing an
early return cannot introduce new failures **5. Comparison with
Historical Examples:** This commit aligns perfectly with the "Backport
Status: YES" example (#4) which also fixed a critical handling issue in
AMD GPU code. Like that commit, this: - Fixes a clear functional bug -
Has immediate user impact - Is small and low-risk - Affects critical GPU
subsystem functionality **6. Stable Tree Compliance:** ✓ Fixes important
user-affecting bug ✓ Small, contained change ✓ No new features
introduced ✓ Critical hardware subsystem affected ✓ Clear regression
prevention The fix ensures that all necessary GPU state initialization
packets are properly written to the buffer, which is essential for
correct hardware operation on GFX8 hardware generations.

 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bfedd487efc53..fc73be4ab0685 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1248,8 +1248,6 @@ static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
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


