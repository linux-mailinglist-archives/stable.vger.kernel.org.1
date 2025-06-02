Return-Path: <stable+bounces-148531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE01ACA417
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C65D7A318F
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4829188F;
	Sun,  1 Jun 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPWakWyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3F291889;
	Sun,  1 Jun 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820724; cv=none; b=jYoT84/Q22OWOUiViKmLacpG8+Dc+trhRJ6i7TyPdgrzYADhU5pjtnoVd0/gcTLYloO9cSqYMqDD9T04LnMr3TZ++gNED7xtkzKo5aK1tFbJbz+uIsjCqnOjGWJ1BG1LIce/KacD9LISyZWZRkAFeVLQQjHpfQid/n049m5opFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820724; c=relaxed/simple;
	bh=L0mEhtjo0xBQ6haNaEvNksebneCU4awd78Ge78HcjkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrzeWRcGk7E9r+1lAGQgyCQ0oMVpIx2gf8gII5Xu+jy0FkdBIdqqIL8sEni5zNuz9S9aYs+ql9vAHyTr4GaXxeYIoIwRb6bl4llqNQzzbgX5h360BM7V54X4o/TvtJ8T4IbG3i/lt0HdWHGs/JpoFhLaKVvAn1DoOKmN1eEEkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPWakWyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDEC4CEEE;
	Sun,  1 Jun 2025 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820724;
	bh=L0mEhtjo0xBQ6haNaEvNksebneCU4awd78Ge78HcjkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPWakWyDNrx/aOSRudniAktkfPTbzOtE/1tT0U2v8MNIXiPsxz6XZyU1tBnKDzOsK
	 7w9BbR4hcEnMGoaGONloOyY8yImcSD7KicynE/ec6G59UvGaRJ3wMgRbrUKqtByC49
	 pWxrvMCb80UfPHMHNFLqhutewevCXBAbhVWxEpkHm5l2sLtZzko2pD9PvEig5f1M32
	 S8lIOnkh+gzxXqqfHdaiKVtyb5nC1rFkaATvSrJln+rb2mk89AFQrOS2IME7bNaYc1
	 yYJN21XnIp62qVjpxTj3QldcUENmJUguTG0/mg+8CwkCjDdkezaUqe/o9nfUsY6fIa
	 vVQ0YhN90DtMw==
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
Subject: [PATCH AUTOSEL 6.14 055/102] drm/amdgpu/gfx8: fix CSIB handling
Date: Sun,  1 Jun 2025 19:28:47 -0400
Message-Id: <20250601232937.3510379-55-sashal@kernel.org>
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
index 6a025438f9d04..9491ddc48db47 100644
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


