Return-Path: <stable+bounces-140640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49BAAAA5F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EB8188DC09
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C238B4C6;
	Mon,  5 May 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS3OVwQh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21C2DA53E;
	Mon,  5 May 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485571; cv=none; b=pna+UKXtiNUdg7p8W/lUXoNWR5EUO8Upot9Isc5tdH+8KW6ef4v+0rPGOLnWJ3FF+nNFxI1AIPNyMchgmKSGx9/oMATsHbY18xB0L3/8DwzRPVSe9x4+BlAzym2nF3Bnni1ysSEc/L1Pe+s7w8v/xlDp9DxNP7OSIemqAfL/Vac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485571; c=relaxed/simple;
	bh=tEpnyqxpUwmbm0CU1poVcn8w/flZiQr2S/rIImIpo/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbuApivZn6OsciQJvBPJf5N0ga/vDNDgipgbqoNndePJIz1vB5WBUs6IghEnE51GuSDnNASEGO07GhL6wFDbB/jZXw/aSBHkXxJe6I7yOOCtN0MHgrxI+32+ZY3UPUzWIhPtpjE4GLcRwpFCSs8WAPYfk8XXenUN899LkmuxImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS3OVwQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6135DC4CEED;
	Mon,  5 May 2025 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485570;
	bh=tEpnyqxpUwmbm0CU1poVcn8w/flZiQr2S/rIImIpo/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qS3OVwQh7BtCvrQLE2l0sAplxMcRFeHH+INgvnHU+GmfyKk5zS3NfyiCQ0w+NEdFq
	 pSPuHyaaLYndzSEHnlMy63j/UJs6+NGz3hqQKsHZ8VJE/V5OqeJx9nixSVLvFYwUlV
	 f7aoR+/YwBLTHxAMjJso9utXxoR7RFeNHFyP+SWHXEWB1GLCwUuIo6r5dt9nN6qho7
	 WFf+D0FcHP8q0ZtGlfZmqFTgvnwKaD9D+HVQxNL8V5GcuwUPPnEJp4sLHpmR0JeCPj
	 CV8pngSLP6ffRYeyhLrcRG9R+qU2WNuYZK2J0Z3wlXvdARC7RdGUVzPIy9K5r5lFXG
	 BEowQCdAddyNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joshua Aberback <joshua.aberback@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Alvin.Lee2@amd.com,
	rodrigo.siqueira@amd.com,
	alex.hung@amd.com,
	dillon.varone@amd.com,
	Austin.Zheng@amd.com,
	Samson.Tam@amd.com,
	rostrows@amd.com,
	yi-lchen@amd.com,
	PeiChen.Huang@amd.com,
	aurabindo.pillai@amd.com,
	linux@treblig.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 371/486] drm/amd/display: Increase block_sequence array size
Date: Mon,  5 May 2025 18:37:27 -0400
Message-Id: <20250505223922.2682012-371-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Joshua Aberback <joshua.aberback@amd.com>

[ Upstream commit 3a7810c212bcf2f722671dadf4b23ff70a7d23ee ]

[Why]
It's possible to generate more than 50 steps in hwss_build_fast_sequence,
for example with a 6-pipe asic where all pipes are in one MPC chain. This
overflows the block_sequence buffer and corrupts block_sequence_steps,
causing a crash.

[How]
Expand block_sequence to 100 items. A naive upper bound on the possible
number of steps for a 6-pipe asic, ignoring the potential for steps to be
mutually exclusive, is 91 with current code, therefore 100 is sufficient.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e1e3142cdc00a..62fb2009b3028 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -621,7 +621,7 @@ struct dc_state {
 	 */
 	struct bw_context bw_ctx;
 
-	struct block_sequence block_sequence[50];
+	struct block_sequence block_sequence[100];
 	unsigned int block_sequence_steps;
 	struct dc_dmub_cmd dc_dmub_cmd[10];
 	unsigned int dmub_cmd_count;
-- 
2.39.5


