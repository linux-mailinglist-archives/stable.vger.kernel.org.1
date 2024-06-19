Return-Path: <stable+bounces-53705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8790E5BE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B26E1F21CCE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38507C6DF;
	Wed, 19 Jun 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiMiwVBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC887BB15
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786170; cv=none; b=FT4SZLjU14V+nBp0MJJeEi3+IfKNxzS+F5KCNlmaOCzhHm5dLMhzl9FUaZkrFyX0c9uW/hlesUGwIRLaZRKQZ0n5jH6dDMPBna1W0MRaIMI+nU8/gUfmSulSd6sZLBWZQqnf6LL2NZpDqMw6tMtQZR6RMlDu75/yYe0gwKjzKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786170; c=relaxed/simple;
	bh=8kxAZMba5F8hADX9r+JDXw3S4NCGm+nRn/couEJN4dA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GgKVvMq0CM6cGcQq78eLUT3rOlGw4ILePdPi1OoCM3ouzJLbrRCMGEXp563mpT0nowGDA7+aJMANOn8VoyXeOPjS25J2K59XssLwK6Vwc8GSDD62ca4OQQKKQVOrsInaBftWFncmiEfET484/0bwH0Vtl0mL7G97LT+rSkk9/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiMiwVBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86F0C2BBFC;
	Wed, 19 Jun 2024 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786170;
	bh=8kxAZMba5F8hADX9r+JDXw3S4NCGm+nRn/couEJN4dA=;
	h=Subject:To:Cc:From:Date:From;
	b=xiMiwVBz0K11Eqt0IXg96ijhPhTb3jgRfcXpwJNesK0RpV1eATAwcc7JTZah66y0h
	 4Buxs/I/IKNjaE8Hc68pSgdl4r/3QlioCZbZqEr+VGalBsYkX08FbsakmQzdpgarwm
	 /eiB+RFThxr+wO3NsktbVHKQaJiW7lSHoHIFyaJM=
Subject: FAILED: patch "[PATCH] drm/xe: Make TLB invalidation fences unordered" failed to apply to 6.9-stable tree
To: thomas.hellstrom@linux.intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:36:07 +0200
Message-ID: <2024061907-subdivide-persuaded-d5af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 0453f1757501df2e82b66b3183a24bba5a6f8fa3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061907-subdivide-persuaded-d5af@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

0453f1757501 ("drm/xe: Make TLB invalidation fences unordered")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0453f1757501df2e82b66b3183a24bba5a6f8fa3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Wed, 27 Mar 2024 10:11:35 +0100
Subject: [PATCH] drm/xe: Make TLB invalidation fences unordered
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

They can actually complete out-of-order, so allocate a unique
fence context for each fence.

Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240327091136.3271-4-thomas.hellstrom@linux.intel.com

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 25b4111097bc..93df2d7969b3 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -63,7 +63,6 @@ int xe_gt_tlb_invalidation_init(struct xe_gt *gt)
 	INIT_LIST_HEAD(&gt->tlb_invalidation.pending_fences);
 	spin_lock_init(&gt->tlb_invalidation.pending_lock);
 	spin_lock_init(&gt->tlb_invalidation.lock);
-	gt->tlb_invalidation.fence_context = dma_fence_context_alloc(1);
 	INIT_DELAYED_WORK(&gt->tlb_invalidation.fence_tdr,
 			  xe_gt_tlb_fence_timeout);
 
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index f6da2ad9719f..2143dffcaf11 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -179,13 +179,6 @@ struct xe_gt {
 		 * xe_gt_tlb_fence_timeout after the timeut interval is over.
 		 */
 		struct delayed_work fence_tdr;
-		/** @tlb_invalidation.fence_context: context for TLB invalidation fences */
-		u64 fence_context;
-		/**
-		 * @tlb_invalidation.fence_seqno: seqno to TLB invalidation fences, protected by
-		 * tlb_invalidation.lock
-		 */
-		u32 fence_seqno;
 		/** @tlb_invalidation.lock: protects TLB invalidation fences */
 		spinlock_t lock;
 	} tlb_invalidation;
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 632c1919471d..d1b999dbc906 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1135,8 +1135,7 @@ static int invalidation_fence_init(struct xe_gt *gt,
 	spin_lock_irq(&gt->tlb_invalidation.lock);
 	dma_fence_init(&ifence->base.base, &invalidation_fence_ops,
 		       &gt->tlb_invalidation.lock,
-		       gt->tlb_invalidation.fence_context,
-		       ++gt->tlb_invalidation.fence_seqno);
+		       dma_fence_context_alloc(1), 1);
 	spin_unlock_irq(&gt->tlb_invalidation.lock);
 
 	INIT_LIST_HEAD(&ifence->base.link);


