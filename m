Return-Path: <stable+bounces-158948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49786AEDD57
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B5D3AA0D3
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406141B4F1F;
	Mon, 30 Jun 2025 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtj5zUND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B72459EA
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287517; cv=none; b=I0RuWhnWNMi3ehliisiDkoak0jpatGRonisSe/4SvDmHrFwRTEQ8E+TLqMfSuCLM58IOQvv69tnKHBlcV3bKG6uLGQ8CGsm6JBqxVYmu6Iv2dOC2+29piGvg6S6UyT2IoNxvdM6wnJUd2GyLIm1q7J3I9tDwuaO6KlBmBNJsMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287517; c=relaxed/simple;
	bh=yaEO9Gc5Sp5T2G+/qOWe0UnqwMKzzDBbaWNCExqWg0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KnWPSVFVRADPSOMCSkpkfjTQY3rHGOtUVhJApvrwhhNp4qD/iwwVe6FmzRSi1S7RrHAvxLxtbgEMkfOH1thUGUk99z/KLs7wUTlXdmdX462venTjLuaUhm3iqg28bEmlx510oY8Kpt+lKHruZDoLRjLMADYrdfGnXhUVrykUso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtj5zUND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C408C4CEE3;
	Mon, 30 Jun 2025 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287516;
	bh=yaEO9Gc5Sp5T2G+/qOWe0UnqwMKzzDBbaWNCExqWg0M=;
	h=Subject:To:Cc:From:Date:From;
	b=gtj5zUNDttxAUcnO02vXS/zX2imn783SVVX/IKStlFr6vc2l/utMXkqzB9NT/7i53
	 ykNzOv0wHBbPCHWh8Vi8kXVRg0zBY9p8GvMnE3gae/OeMKqsNFEfR1mwm1l4xVzb3e
	 6s7ZwjsVS0suwmVYO9X/TMcsyB+eF4ts9oK8OEec=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Use logical instance ID for SDMA v4_4_2 queue" failed to apply to 6.15-stable tree
To: jesse.zhang@amd.com,Jesse.Zhang@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:45:13 +0200
Message-ID: <2025063013-outrank-ecology-3fc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x caade9d69f2e2b76d2e2d47089736a99135b8772
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063013-outrank-ecology-3fc7@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From caade9d69f2e2b76d2e2d47089736a99135b8772 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <jesse.zhang@amd.com>
Date: Wed, 11 Jun 2025 15:07:11 +0800
Subject: [PATCH] drm/amdgpu: Use logical instance ID for SDMA v4_4_2 queue
 operations

Simplify SDMA v4_4_2 queue reset and stop operations by:
1. Removing GET_INST(SDMA0) conversion for ring->me
2. Using the logical instance ID (ring->me) directly
3. Maintaining consistent behavior with other SDMA queue operations

This change aligns with the existing queue handling logic where
ring->me already represents the correct instance identifier.

Signed-off-by:  Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3bab282dfe25dff7a55add432f56898505a6cc6c)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..3de125062ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 id = GET_INST(SDMA0, ring->me);
+	u32 id = ring->me;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
@@ -1686,7 +1686,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = GET_INST(SDMA0, ring->me);
+	u32 instance_id = ring->me;
 	u32 inst_mask;
 	uint64_t rptr;
 


