Return-Path: <stable+bounces-70215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AC95F132
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854B6B2256F
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9B155382;
	Mon, 26 Aug 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zEatBupf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F412433AD
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674925; cv=none; b=ak9lFCxa+iSJc+U8OCGTm0Vi70snCQS3A4rbpG1y4EYx60EBVutyVl0kneWaaOT6I6hUm9hNdIylz14X5GiDBOgmpQnWV3Moo2x/M7fSAUbU1Gnl3CwVM5AGW2n0EHf1JhgIfTuyCrrpb8d5ZujSmqUgoumuAm7u+k7DlXV9UpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674925; c=relaxed/simple;
	bh=X0ez+PYaXHlHdymihNqaGvGHedAKTKf2XZCLWpaRRhs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=azuj3RzpkAzuyeYjdLoSvpKkaYczxabKtVShuKsUXhV8OJLBaVDbJOh2TTrZOZvzEKkggF1q/a4kNdrujH2ij4+dplyGjuegl5qoPYXb3wn+w5cQp82oesq3J5baILVgL07O9sQL2Ss99Tcp1C0DOBKliv1SlLO1rP4lX2+F9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zEatBupf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02673C58125;
	Mon, 26 Aug 2024 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674924;
	bh=X0ez+PYaXHlHdymihNqaGvGHedAKTKf2XZCLWpaRRhs=;
	h=Subject:To:Cc:From:Date:From;
	b=zEatBupf7IcgcjCvUXvBblWYfuBHW8zuiiZzCHAPFvQStz8wQtnB2FJ+DxtJKa7aH
	 MtIjeoFz38fZkCEbTTUqRDjia3v7W7aMdQQqfB4kWe35ASYEZ5BndKZcrLz+fwB4mV
	 CnSDQbiBckMKBC6+0W/xo2M8DBvX5zgGboykaLS0=
Subject: FAILED: patch "[PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1" failed to apply to 5.15-stable tree
To: alexander.deucher@amd.com,ruijing.dong@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:21:50 +0200
Message-ID: <2024082650-decompose-customer-0b61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e3e4bf58bad1576ac732a1429f53e3d4bfb82b4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082650-decompose-customer-0b61@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


