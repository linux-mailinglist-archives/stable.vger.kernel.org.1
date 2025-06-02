Return-Path: <stable+bounces-148738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA61ACA637
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79BB17B1E3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2183188C9;
	Sun,  1 Jun 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mktuiSXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968443188B9;
	Sun,  1 Jun 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821215; cv=none; b=Spva5TsNG+iun3rI78iXOfZ9ko+bYDfI7hmTJgdUD944U7hInqtpaRhC5wtYP4fMQ2iKsA2KorZNW05tLnAZwLUQacTsVLrJCcz/i12ALTAXGkq6ciVff6Vt8BBybgWATNgxS7MwijtOcc2r3GE59MGQrFZMGDsc21WgDhB5dyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821215; c=relaxed/simple;
	bh=OALBLlLWLL80XnYhYJHu1fr33EUA2ALC9d2lhTp52AA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyrPOKtvCJMAUfVtpfAXvK+zx6N6wFR2blO2/jpenc8i7OuFvbRSAph/W/3O3DnWVIwJCnmr/DDhGTFjqeR1kDKdj9mbWQhLayLw/hmZa/TltEyOGCaOTWp7o2mbCVUm87/K5dvDo3WLjornc0QCmmhOBDYArO2+bGxoIoKgda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mktuiSXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C587EC4CEE7;
	Sun,  1 Jun 2025 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821215;
	bh=OALBLlLWLL80XnYhYJHu1fr33EUA2ALC9d2lhTp52AA=;
	h=From:To:Cc:Subject:Date:From;
	b=mktuiSXwWkmBN8fYD/9HP2J6kAtSDcVe2XWXPy6Gn60ZbEYuSww9wSQkJPAVoUcM4
	 isVAipadEHGigXHNi5wQRS6Ih3K2qvnxQA+E0aS5zIDGEKzwoajSVSwVgrNGVNxH2q
	 1P+J0FXOt4UL+vPnT4pt5lwjjz05PDe8Ea/Gk/OyRM4+LPN23rDupKeDUntcdlI2u2
	 yqVaCBivRSWlXoP4/iXI6fXtPeZHmB2y5YEdgKnQKjuZYNHD+maJs+8ZoJ+PasuIaV
	 uH/T/iPkRt6XWK+d9DKq9fvd/J3BEjXQgfOCNt5xvBb7ugw8m0zN5yPdq0POppSUFh
	 YJerJZ9VLscgQ==
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
Subject: [PATCH AUTOSEL 6.1 01/58] drm/amdgpu/gfx6: fix CSIB handling
Date: Sun,  1 Jun 2025 19:39:14 -0400
Message-Id: <20250601234012.3516352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
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
index 204b246f0e3f9..0219f1175c078 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2873,8 +2873,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
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


