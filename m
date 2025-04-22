Return-Path: <stable+bounces-135025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28557A95E13
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63265177A21
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405419D8BE;
	Tue, 22 Apr 2025 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eaiyS8eU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557392F872
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303090; cv=none; b=oEOM6q/QCNq5TXlZnJ3OMAQaf+/DKE9FgwleNRbwwoM46+Z5FRfIylPgX7bFbybZfZQCjswQLnGFmB0rnvPBJvRJKnfFELeXd352gomkL7I1qlOCZSpA9Pk/D45+bhL/qWpWqijBYjqzKiGUsBq+okbhM3bh9R1vmj1ObeLO8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303090; c=relaxed/simple;
	bh=z13Id5Qb51x/yW3nD4ydgWXu2jZihEU+oV6IscuHhsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QWMZsdefn2JOTE4231eSCr8nNzYzEhczM5Qf7jNOP6A1ZFXHCqo/wS0Nd+kHr2z8bS4zGHZ0StwD3R/j5EgIcP3IX1dnO+v6uUszG1FBMn3CC9hwfhI7d91UIuPAFZv2PsJR010cmYG0mWCxPsVNtJNsqSsS/Z2gAKdUENrjePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eaiyS8eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71345C4CEE9;
	Tue, 22 Apr 2025 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303089;
	bh=z13Id5Qb51x/yW3nD4ydgWXu2jZihEU+oV6IscuHhsA=;
	h=Subject:To:Cc:From:Date:From;
	b=eaiyS8eUMPT+NNSS28UvqhqBBQJAaTesZtRxQa9Ryjcyxjxk/VJN/BhYM3Jjp6aRU
	 /U+XWYSEfnzt4gdcdOezteQ0K5DeUOPCLhQ/DZfBxMQwLbuqIqlXUdTlPJ9Vr5ekaP
	 YNp6a/owYvFvN/7YZzqG+0on/f6FPHYcrYIdZYMo=
Subject: FAILED: patch "[PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9" failed to apply to 6.12-stable tree
To: jonathan.kim@amd.com,alexander.deucher@amd.com,david.belanger@amd.com,harish.kasiviswanathan@amd.com,jesse.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:24:42 +0200
Message-ID: <2025042242-enquirer-clip-cf7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b3862d60b1a8b6face673c820dccdd9c449563cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042242-enquirer-clip-cf7c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


