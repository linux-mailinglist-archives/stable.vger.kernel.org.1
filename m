Return-Path: <stable+bounces-139996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B8AAA3C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE857B4664
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CDD284669;
	Mon,  5 May 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZFpC/2Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4010283FFD;
	Mon,  5 May 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483853; cv=none; b=cl0e7PQSx+/ri730EharFYJBR3e7lGKL88sElS3ibkz8gRxK8U3Vyc9/SZW/lA46S6h9R6GZZmz/3yIXg4HxiZ6ZjOuzVgP4fHis5yM45xf2Rdftjq2Akau0Fq5LqyCa2noMSJwGcWjhJiUo6K2t+/wsCCaPwS3IeBaDaUde6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483853; c=relaxed/simple;
	bh=egpS6UJh7Lj/3mue8VnA4+D1vCiFYuhsAHYgQT7/KU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAO9nWI/2H++yMkWyfxvyCa8jTNm9+Ei1/Andq0ReJlFMFDWkMim3mqA5sb15/LF0/A13Uj+8tBlGUVDwG4VMR8/tbnriJcjPaeUkWfV+OMnCJ0OGBufsBgO6453xAHqLfKNY3SUkoBICqCdKHprLacJHDKjhQNXzmUlG/zDa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZFpC/2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FEEC4CEE4;
	Mon,  5 May 2025 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483853;
	bh=egpS6UJh7Lj/3mue8VnA4+D1vCiFYuhsAHYgQT7/KU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZFpC/2ZOslDgdSVekTb0YYTR8rHrxR+mAdpi7/4PwbgqvIthLbp3Ox8GNF7heDbd
	 YIgVmu7VKLfcPkKP53C0z8+kkD5hwnXaBIqBVL4/LD6y4V6Y99PstcNRspYuFynppr
	 OcB22ezD+essir+NGx+a0gMQdY7puOeMm3zlvBybJFRlRzSBPWAEHHiM/r68eI+yma
	 IGN+78kfhBeeltKKZpqpNyklb24VWNLRHomoGPyiM8WwV15KlGCtWEY4v87MIfGzSu
	 l1ppbn1uiEh4JaghblAj9qozIQr0hs62zg5+h355LauMHjrR4bDaeG3PfNJwXbyD7/
	 GBNk10ZkkfFBw==
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
	Cruise.Hung@amd.com,
	joshua.aberback@amd.com,
	duncan.ma@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 249/642] drm/amd/display: Ensure DMCUB idle before reset on DCN31/DCN35
Date: Mon,  5 May 2025 18:07:45 -0400
Message-Id: <20250505221419.2672473-249-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e5e77bd3c31ea..01d013a12b947 100644
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


