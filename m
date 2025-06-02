Return-Path: <stable+bounces-148374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2CACA156
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66872171CB5
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF3257AC2;
	Sun,  1 Jun 2025 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URc9jV5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B0257451;
	Sun,  1 Jun 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820300; cv=none; b=aXpjLKXKxzPRbU0RNrnRrhPPngSSV0LgvKAacoHWvcoSAuYJtS5FNUZisK/9PMXWIVxF5yPcV4Adey/ul1AAqL43H7yxrQtjW5KlB/SJK9JyFpEjrabRuHW1+MBlj+XJ1bDFNPicCF1RfyKKCKN3i7DS318uP95Vld7yvYGditw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820300; c=relaxed/simple;
	bh=QZFDa7bYCggNE+YvuxSeXpMMdvPHtdpdYuAPi17x5QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uenMyeN4j7UiSfW80X+mr3levnpquLtik8GI3VEkY04cFikTzO3BZHBIgE/j0HjCv7ifDEhlqyGxHgepna7gxUs51Zpr0NbO946OHMR786Cd8Xq5LmSYqpZmm4FTyqZHdEkc03lmvgUWse+O1Tuh7kslOpraIO5zZtzBbLHSF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URc9jV5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A49C4CEE7;
	Sun,  1 Jun 2025 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820299;
	bh=QZFDa7bYCggNE+YvuxSeXpMMdvPHtdpdYuAPi17x5QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URc9jV5pqfL2eAT/a5plf0MmpSOzcZX1/tHAo+HheitZuoVMIznInLZSHfsWAhYq8
	 rAyUbxUrMCrcTfBhTn1jTNB/HcnzmKsQ20RtrvZMHw515FMAfihLtzXMkdlnZIJ7wG
	 GSRhwCzM7jSgjBcBwKTJ/BGhrUbuPbd//DXSBfbG4ukwVeAvhlv1YY3A+2rmpt+ogt
	 6iXdmKaNrLtdM4f7rJRNuSIwNMCwWvMfZ6szf6dRPkfMraLrlmeJgitGSGQuQIqJOL
	 duiqR1mpBNbhyfsIeuo8ws3UjDCHJ+r7WKYx0YL1lbKIvcCmKdL1SzhO9oOO8/YkIG
	 1m5B+SJnA3hMA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	"Shaoyun . liu" <Shaoyun.liu@amd.com>,
	Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Jack.Xiao@amd.com,
	srinivasan.shanmugam@amd.com,
	shaoyun.liu@amd.com,
	Jiadong.Zhu@amd.com,
	Hawking.Zhang@amd.com,
	michael.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 008/110] drm/amdgpu: Fix API status offset for MES queue reset
Date: Sun,  1 Jun 2025 19:22:50 -0400
Message-Id: <20250601232435.3507697-8-sashal@kernel.org>
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit ad7c088e31f026d71fe87fd09473fafb7d6ed006 ]

The mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue functions were
using the wrong union type (MESAPI__REMOVE_QUEUE) when getting the offset
for api_status. Since these functions handle queue reset operations, they
should use MESAPI__RESET union instead.

This fixes the polling of API status during hardware queue reset operations
in the MES for both v11 and v12 versions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-By: Shaoyun.liu <Shaoyun.liu@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
the following analysis: ## Bug Analysis The commit fixes a clear
functional bug where `mes_v11_0_reset_hw_queue()` and
`mes_v12_0_reset_hw_queue()` functions were using the wrong union type
(`MESAPI__REMOVE_QUEUE`) to get the API status offset for polling
completion. Since these functions handle **reset** operations, they
should use the `MESAPI__RESET` union instead. ## Code Changes Assessment
1. **Small and contained**: The fix changes only 2 lines across 2 files:
- `mes_v11_0.c:480`: `offsetof(union MESAPI__REMOVE_QUEUE, api_status)`
→ `offsetof(union MESAPI__RESET, api_status)` - `mes_v12_0.c:500`: Same
change 2. **Logical correctness**: The functions create `union
MESAPI__RESET mes_reset_queue_pkt` packets but were polling using the
wrong union offset. This is a clear mismatch that could cause incorrect
polling behavior. 3. **No architectural changes**: This is purely a bug
fix that aligns the API status polling with the correct packet type. ##
Impact Assessment - **Affects GPU queue management**: MES (Micro Engine
Scheduler) queue reset is a critical operation for AMD GPUs -
**Potential for silent failures**: Wrong offset polling could lead to
improper completion detection - **User-visible impact**: Could cause GPU
hangs or incorrect queue state management - **Low regression risk**: The
fix aligns the code with its intended design ## Comparison with Similar
Commits All 5 provided similar commits were marked "NO" for backporting
because they: - Added new APIs/features (commits #1, #2) - Made
functional changes to queue reset behavior (commits #3, #4, #5) In
contrast, this commit: - Fixes an existing bug without adding features -
Maintains existing behavior while correcting implementation - Follows
the stable tree rule of "important bugfixes with minimal risk" ## Stable
Tree Criteria Met ✅ **Important bugfix**: Fixes incorrect API status
polling in GPU queue reset ✅ **Minimal risk**: Two-line change with
clear logic ✅ **No new features**: Pure correctness fix ✅ **Contained
change**: Limited to MES driver subsystem ✅ **Clear side effects**:
Improves reliability of queue reset operations This commit represents
exactly the type of focused bug fix that stable trees are designed to
include.

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index ef9538fbbf537..480283da18454 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -480,7 +480,7 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index e6ab617b9a404..624c6b4e452c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -500,7 +500,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
-- 
2.39.5


