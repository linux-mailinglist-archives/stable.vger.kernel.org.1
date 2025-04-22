Return-Path: <stable+bounces-135024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F96A95E11
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34F63A545B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFA19D8BE;
	Tue, 22 Apr 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTqyn51l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D32F872
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303085; cv=none; b=R9VT6ed+kLhezQ/b3oepe36CATRmWArZEUp9LCWDwB77dbx7dUUVQOChN23EITNh/CQo48dKkMxRqu+p8d0dCsFrwYOwVaEag2hNVDWELRGZb3P8NV9R2NeCMLY2nVsZgkO5qXZ89fT/d+NVn+FNY/nb4fNSbyKbTBCGeflLMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303085; c=relaxed/simple;
	bh=hrJrVyfNxYOqNQYgfhoH5NTKLkNk5befZofih8jaoLA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KjgqIZg6QXnyByUCuC25Uf2NLBNIE1xKOQvE18sui7cQ2YSiYBODzTVUp74A255a7+vyrMhWPy4TBGUu07/PCCrxDyivm5iJ/G0AQW+x5iTiLTZaNi9N33oBYvHehyz2vWl5ht4kfTmGTkSa4N/VmgClWy72EMCVOU6h39WeIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTqyn51l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018C4C4CEE9;
	Tue, 22 Apr 2025 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303084;
	bh=hrJrVyfNxYOqNQYgfhoH5NTKLkNk5befZofih8jaoLA=;
	h=Subject:To:Cc:From:Date:From;
	b=NTqyn51l8F/uUqLijbht1eL9am8SxSxgeLRNGC2ilMvhv3Gv1h464HkkGI2O6wNvA
	 DCJWzB8OQ2wp4u5Q+GwE/9eDNBX3fNDhzi261Sfs9gL9Zv/73bH9MFhju4/RF97XiT
	 NZDwsd4SIrR5LV+6wdcHiNJ8jbPtlKK/HTqHuFvU=
Subject: FAILED: patch "[PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9" failed to apply to 6.14-stable tree
To: jonathan.kim@amd.com,alexander.deucher@amd.com,david.belanger@amd.com,harish.kasiviswanathan@amd.com,jesse.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:24:36 +0200
Message-ID: <2025042236-old-underpay-f993@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x b3862d60b1a8b6face673c820dccdd9c449563cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042236-old-underpay-f993@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b3862d60b1a8b6face673c820dccdd9c449563cc Mon Sep 17 00:00:00 2001
From: Jonathan Kim <jonathan.kim@amd.com>
Date: Thu, 27 Mar 2025 11:50:42 -0400
Subject: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9

ASICs post GFX 9 are being flagged as SDMA per queue reset supported
in the KGD but KFD and scheduler FW currently have no support.
Limit SDMA queue reset capabilities to GFX 9.

Fixes: ceb7114c961b ("drm/amdkfd: flag per-sdma queue reset supported to user space")
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2c4711c67d8a..9bbee484d57c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1983,9 +1983,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
 		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
 
-	if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
-		dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
-
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
 		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3) ||
 		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 4))
@@ -2003,6 +2000,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 
 		if (!amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
+
+		if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+			dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;


