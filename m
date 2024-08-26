Return-Path: <stable+bounces-70214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28F95F131
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704B01C21C2B
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E1140369;
	Mon, 26 Aug 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooGCTohS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB0433AD
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674921; cv=none; b=Ly0+sEHCYO+2xqle+1GCFJceH9CJVuvErLvcxCmQgkNH7FLRbZUfDEOMl7zHU47IjATZNN8hL7j2bTvl0Di+wFHe5fRWgOMmV+TnY+LN6Iu6G89P29TOYBKPSAICPtZ/Z3Qe7A7opm8PFbXEY0PTzujhlxNj4atlsU0pzrgAYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674921; c=relaxed/simple;
	bh=VpUNwtKJ6lhfcYTm1o/YIl0kalLNw1AJdt9PCKafv0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rmH4V38KR58+W2ux605+Lq3DvdUc0Aczb7BQI5UKrCHPt36rrv9NHq8mG/ASnTI2Cf4rK5OrFySFItEj7QjZYSjEg396OYFOHBLi6ALPkXbY1Rj0FPiSmoESDREepcvAzalbAxe18zlV9kAB/Tw2N2rzzEK6A/A0vGMK7+D6VuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooGCTohS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991DCC4DDE7;
	Mon, 26 Aug 2024 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674921;
	bh=VpUNwtKJ6lhfcYTm1o/YIl0kalLNw1AJdt9PCKafv0M=;
	h=Subject:To:Cc:From:Date:From;
	b=ooGCTohSI2DDxrDgNYwAtpSMODSvYZqBlteDrWgWoGPWG3Riam/+U29GeGt8uAn07
	 MPakPrFWK7TSzuEh4gzVcv9YnlKIOEyWNblIcqsuD4DZeCbTJ86X4MmeONPSv/OI3V
	 DPaZg2wAEL9U4bLjhh5uzdFFZuG8SBofXvDyFgjA=
Subject: FAILED: patch "[PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,ruijing.dong@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:21:49 +0200
Message-ID: <2024082649-shading-anyhow-2d3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e3e4bf58bad1576ac732a1429f53e3d4bfb82b4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082649-shading-anyhow-2d3e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e3e4bf58bad1 ("drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1")
a03ebf116303 ("drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell")
94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3e4bf58bad1576ac732a1429f53e3d4bfb82b4b Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 14 Aug 2024 10:28:24 -0400
Subject: [PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1

The workaround seems to cause stability issues on other
SDMA 5.2.x IPs.

Fixes: a03ebf116303 ("drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3556
Acked-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2dc3851ef7d9c5439ea8e9623fc36878f3b40649)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index af1e90159ce3..2e72d445415f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -176,14 +176,16 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-		/* SDMA seems to miss doorbells sometimes when powergating kicks in.
-		 * Updating the wptr directly will wake it. This is only safe because
-		 * we disallow gfxoff in begin_use() and then allow it again in end_use().
-		 */
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
-		       lower_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
-		       upper_32_bits(ring->wptr << 2));
+		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(5, 2, 1)) {
+			/* SDMA seems to miss doorbells sometimes when powergating kicks in.
+			 * Updating the wptr directly will wake it. This is only safe because
+			 * we disallow gfxoff in begin_use() and then allow it again in end_use().
+			 */
+			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+			       lower_32_bits(ring->wptr << 2));
+			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+			       upper_32_bits(ring->wptr << 2));
+		}
 	} else {
 		DRM_DEBUG("Not using doorbell -- "
 				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "


