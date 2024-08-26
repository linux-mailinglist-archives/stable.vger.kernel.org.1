Return-Path: <stable+bounces-70213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103D195F130
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E8D1C21C37
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA311140369;
	Mon, 26 Aug 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izHqe/T5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFB433AD
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674912; cv=none; b=WyRAO1ygL/8gpG/lu6Z4PgKJ0347369cE9jNoF7UdJwUGfxBIP8waCdgOIo7xF8gwJfUQtLJAJliGr+H7/Cgt6x1m4UFn+mL9c8OEjoGgoxVRyhKmYoOZWptj9XJY6PrphMJ+PvijqUQhKqGQ6klLqIUPVSR15aP3+6ISqUrsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674912; c=relaxed/simple;
	bh=F7BWTktRPTNjZE6SDSRAk1ta1OIxDbdVr+RIzM5Qs5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pr9r0jd/xDHgPjQzLpBv+V0w6neWJGV54iGc6UwZBFUuYbW3oA7FjDfsaHg07CKlDVYsbjcG5QKD1qj+WlQP5Il0GID1SQsbBKRgaQ5m+1NcZubcQaKF2TpD8KFEcQ6R1Z2IDm9o+rx1e9PxX0ayIq+aEg6Xf/EChZ//ODvbEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izHqe/T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BD8C4DDE7;
	Mon, 26 Aug 2024 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674912;
	bh=F7BWTktRPTNjZE6SDSRAk1ta1OIxDbdVr+RIzM5Qs5g=;
	h=Subject:To:Cc:From:Date:From;
	b=izHqe/T5v3hEnz0fbXecMsDfi+VZtXMVAbgeJQc9tgztRkSCx67ybaeQJ2ZfldH+z
	 VuC96lF+lAPpBeUEeTOVNGg/UIUkkpyxxw8oQKu7eHkH0cRYAKPqWj9KTzlRa1pxWv
	 AvKY5pFZvq2hvKamphC/uenx1/mXL0G9ZlO5nf0I=
Subject: FAILED: patch "[PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,ruijing.dong@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:21:48 +0200
Message-ID: <2024082648-curry-rack-be6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e3e4bf58bad1576ac732a1429f53e3d4bfb82b4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082648-curry-rack-be6b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


