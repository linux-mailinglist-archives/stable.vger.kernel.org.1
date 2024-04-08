Return-Path: <stable+bounces-36363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4A89BD08
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8D7282B22
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EBD535DC;
	Mon,  8 Apr 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CAGkSSe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D6535C1
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571984; cv=none; b=Yk71DF0ro55HXCJ/RMYV+oD0hMyg5b3KWfgPRsqjU+OxI2zw89YmEFPTYkYsz7cdOt0Ak0bnBaaonCytH5s8P8/hjHVqx3rykWG6Fv1CFavZ4/kTWeNgBLvYo2lbr0XGaDEgNSsgNTtr7bVEQIy66CF9ZEtXTsE9Da10oQxRMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571984; c=relaxed/simple;
	bh=R862mnwpIw3d74Ib4jY5vYV/ClqX2cl/lPU6+miCeEY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ekTkrL7zjUrYRF5gSBwJiX/Tlu19HJQ8LiYuULYVnu5MMHlQGmBcTjkp21vBK5j8mZWZwiNvJa/KzoJ6Lnv3olJbjkvagpSBfyVmdl6ekQOF60ZUv5ZkuKMn3p1yn4600EHte9o7ZDeIMzKBpOvRAfNpfzGL9qriJHXoQ/BJN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CAGkSSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89442C433C7;
	Mon,  8 Apr 2024 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571983;
	bh=R862mnwpIw3d74Ib4jY5vYV/ClqX2cl/lPU6+miCeEY=;
	h=Subject:To:Cc:From:Date:From;
	b=0CAGkSSe2y6MPdkeCHb4G2y4tbO5RkWyIdUsoPuFcEBWlfm0u3oXESbyFJvGMiA1g
	 tAmHI/IsqtwA6wR90xfoIJcMd5rKb05oqSOFTCX/dbUzzivHl8yUMFzIB1mxKvJUHq
	 KkIxLfy3tD1aZHt5iKvPkNv3QpeZNYhLmPCvJQe0=
Subject: FAILED: patch "[PATCH] drm/xe: Make TLB invalidation fences unordered" failed to apply to 6.8-stable tree
To: thomas.hellstrom@linux.intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:26:21 +0200
Message-ID: <2024040820-unfocused-ricotta-37e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x fd1c8085113fb7c803fd81280f7e0bb25a5797ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040820-unfocused-ricotta-37e3@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

fd1c8085113f ("drm/xe: Make TLB invalidation fences unordered")
6240c2c43fd0 ("drm/xe: Document nested struct members according to guidelines")
997a55caa1c3 ("drm/xe/gsc: Initialize GSC proxy")
7c0f97cb62dc ("drm/xe: Invert access counter queue head / tail")
1fd77ceaf0d8 ("drm/xe: Invert page fault queue head / tail")
6ae24344e2e3 ("drm/xe: Add exec_queue.sched_props.job_timeout_ms")
a8004af338f6 ("drm/xe: Fix modifying exec_queue priority in xe_migrate_init")
b16483f9f812 ("drm/xe: Fix guc_exec_queue_set_priority")
9d612ee52c60 ("drm/xe: Annotate multiple mmio pointers with __iomem")
fa78e188d8d1 ("drm/xe/dgfx: Release mmap mappings on rpm suspend")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd1c8085113fb7c803fd81280f7e0bb25a5797ab Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 0453f1757501df2e82b66b3183a24bba5a6f8fa3)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index f03e077f81a0..e598a4363d01 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -61,7 +61,6 @@ int xe_gt_tlb_invalidation_init(struct xe_gt *gt)
 	INIT_LIST_HEAD(&gt->tlb_invalidation.pending_fences);
 	spin_lock_init(&gt->tlb_invalidation.pending_lock);
 	spin_lock_init(&gt->tlb_invalidation.lock);
-	gt->tlb_invalidation.fence_context = dma_fence_context_alloc(1);
 	INIT_DELAYED_WORK(&gt->tlb_invalidation.fence_tdr,
 			  xe_gt_tlb_fence_timeout);
 
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index 70c615dd1498..07b2f724ec45 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -177,13 +177,6 @@ struct xe_gt {
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
index 5fc4ad1e4298..29d1a31f9804 100644
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


