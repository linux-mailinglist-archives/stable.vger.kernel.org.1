Return-Path: <stable+bounces-140571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC92AAA9D6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592C37B2390
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1862DA54A;
	Mon,  5 May 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVdrO5Gh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43672D1638;
	Mon,  5 May 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485172; cv=none; b=qNTt19MIrPwxa0YTeQ+4+V7JnDQrPtBx8yStmoupvus7tsWf6u6H/SOIs+tL3Q3yoKI+eiQw7B3TmvYWXUBV/hO19f0TvzQXTekU0hLjwFmDdj2mjWsHHzGP7yzZ6HekwzO4cN6tit2j6/gKOpUD7DsgJ4DB4qOSnElAbx92bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485172; c=relaxed/simple;
	bh=0tuhh9/DxMp177RlmvvmX2DCNEAa0XiBPG0HzEDVFiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9XasVJqadGjsoQHlJOdQR3NOAb4S5v4BwfAn9c9OwF/RymlKlz91nM27FZ3sq/3zLweO/iUbmwY93y+K5+emY+n4Bi9IZSRiCHNgmuVMtvFqt+Vrx4/lGg3hKJ0st8uMbEVcugaWL1ZqwwWXOJLvVIsRHLamfWE8fyq2e/UshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVdrO5Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE09C4CEEE;
	Mon,  5 May 2025 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485171;
	bh=0tuhh9/DxMp177RlmvvmX2DCNEAa0XiBPG0HzEDVFiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVdrO5GhucS4MWa1jVJnxD70GQb0zSpkoQe2G+/QZoUU1ce3VJTKvbQNVCaMt8Y4K
	 L9Wrwo0JrrHzIXcBhNhhsRmGjubqYh9UJIu+HSz1s3WVlnFv6YxW5TljbYe6m2a9Hj
	 uOyGdnx4SzXN7rwNdMmk11qx8Ym0lApKFBtvZ4L2hTQFDmJoVrR94cEQA9jQiLxjoQ
	 AALHMj9+7G1g01lgau+o0Liasl7S2JXP2xXc+Q8CzrgAkGKwSqFPQ5VU8/7W0NgOnh
	 4vpNzaRKG36anMfDprmccYnOKKAy+sKyA9FQ6Z5rJ8vum/ALHyO4xXm6RX3H4wRr5p
	 wSuXywe5v0e6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	zaeem.mohamed@amd.com,
	Hansen.Dsouza@amd.com,
	joshua.aberback@amd.com,
	Cruise.Hung@amd.com,
	PeiChen.Huang@amd.com,
	duncan.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 197/486] drm/amd/display: Ensure DMCUB idle before reset on DCN31/DCN35
Date: Mon,  5 May 2025 18:34:33 -0400
Message-Id: <20250505223922.2682012-197-sashal@kernel.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit c707ea82c79dbd1d295ec94cc6529a5248c77757 ]

[Why]
If we soft reset before halt finishes and there are outstanding
memory transactions then the memory interface may produce unexpected
results, such as out of order transactions when the firmware next runs.

These can manifest as random or unexpected load/store violations.

[How]
Increase the timeout before soft reset to ensure the DMCUB has quiesced.
This is effectively 1s maximum based on experimentation.

Use the enable bit check on DCN31 like we're doing on DCN35 and reorder
the reset writes to follow the HW programming guide.

Ensure we're reading SCRATCH7 instead of SCRATCH8 for the HALT code.
No current versions of DMCUB firmware use the SCRATCH8 boot bit to
dynamically switch where the HALT code goes to maintain backwards
compatibility with PSP.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c   | 17 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c   |  4 ++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index d9f31b191c693..1a68b5782cac6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -83,8 +83,8 @@ static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
-	uint32_t in_reset, scratch, i, pwait_mode;
+	const uint32_t timeout = 100000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -108,7 +108,7 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
@@ -125,9 +125,14 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 2ccad79053c58..4581eb4794518 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -88,7 +88,7 @@ static inline void dmub_dcn35_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn35_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
+	const uint32_t timeout = 100000;
 	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
@@ -113,7 +113,7 @@ void dmub_dcn35_reset(struct dmub_srv *dmub)
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
-- 
2.39.5


