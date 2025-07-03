Return-Path: <stable+bounces-159490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC78AF78FB
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F14564CA6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541202F0058;
	Thu,  3 Jul 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jD2V+uVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104062EF9C0;
	Thu,  3 Jul 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554398; cv=none; b=FEXnvr/QHt1vj5S1funYn8rQnX+2idpjbeD3MDUMzUbsA0a8y/GZkpCeE4HDFtnP2pjoOul2wy1kLkH3Q9MSBxtlL3QZUr3Bb7CF8L8fzD75vxJNooUf2pZaVOgKC5DsAqrIRLnOpmzU8b+QVJMUZMHqHi1TNwhjEaO0VjumUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554398; c=relaxed/simple;
	bh=5buA2Fgy9hMh49JUZSIwYpn/6T60xu+xCR/FrUdnjIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL1GXhxUdwa2M1HjWY+Z77NW7KBqwSemiGSFN0g8g0FIsohx/HfHyFvN376dfs7PeGFzVCUm5lrU9xp1l1FWSXBiSUGbH1oN1Op+CjTbj/VAtpjYoeRe0vxKOtTwfUPFhrR4CIJkteA/P9mnF/5q+s73G4rEiF+rnXVvs5YHNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jD2V+uVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D45C4CEF1;
	Thu,  3 Jul 2025 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554395;
	bh=5buA2Fgy9hMh49JUZSIwYpn/6T60xu+xCR/FrUdnjIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jD2V+uVkxWK1hoY70IE3cxVg2cle/g4OH96wOUoEESdXCp+mTnW50X5YeJH8iLtkl
	 KLm8a92POP5XfQBm1TO127x25tmL9EU1fK8oaP+3Xr+cQiUXa+VbBTh7vFMQbo4pf5
	 1GernNIHekY6fwfLobxoFLsF+f0kh9DcsEtEm/aU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Kim <jonathan.kim@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 174/218] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop sequences
Date: Thu,  3 Jul 2025 16:42:02 +0200
Message-ID: <20250703144003.127972210@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Zhang <jesse.zhang@amd.com>

commit 7f3b16f3f229e37cc3e02e9e4e7106c523b119e9 upstream.

This commit makes two key fixes to SDMA v4.4.2 handling:

1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
   by reading the current value before modifying UTC_L1_ENABLE bit.

2. Ensure UTC_L1_ENABLE is consistently managed by:
   - Adding the missing register write when enabling UTC_L1 during start
   - Keeping UTC_L1 enabled by default as per hardware requirements

v2: Correct SDMA_CNTL setting (Philip)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 375bf564654e85a7b1b0657b191645b3edca1bda)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -485,7 +485,7 @@ static void sdma_v4_4_2_inst_gfx_stop(st
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
-	u32 rb_cntl, ib_cntl;
+	u32 rb_cntl, ib_cntl, sdma_cntl;
 	int i;
 
 	for_each_inst(i, inst_mask) {
@@ -497,6 +497,9 @@ static void sdma_v4_4_2_inst_gfx_stop(st
 		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+		sdma_cntl = RREG32_SDMA(i, regSDMA_CNTL);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
 
 		if (sdma[i]->use_doorbell) {
 			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
@@ -953,6 +956,7 @@ static int sdma_v4_4_2_inst_start(struct
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
+		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
 			/* enable context empty interrupt during initialization */



