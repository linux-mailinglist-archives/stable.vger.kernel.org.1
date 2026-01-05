Return-Path: <stable+bounces-204791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901ACF3D9A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09714314B226
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192119E968;
	Mon,  5 Jan 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a745J147"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D11946DF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619613; cv=none; b=boaXOC9BTRiY5MCI0yCxrHAForNtLwXj910IdKDSi776NM//z6vJnep5OJ/iyYCtfpHQEfODDslM8Y4d3iWiwGUXQDHMgWPVMGaJhaMQ2ccJaQqzXfH5D7+v41ISyMw5zFsfEZXUnaBh8MsXo3UOVZLVREgFDJ+M667uRXu3Pq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619613; c=relaxed/simple;
	bh=JLjROzsRmrwFfvx5fWFeGklpiSVrsNvyNnXiNMaP6YI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mnQU8uhlTfeKKbImpP5g6SjIFsb+WCNiE6KDFybbf/i2qX42EbsAPcU0BJp2RwI+gIAjuisaYR4tRH83v9EYU+wyn8366RoQ9k8EBx4syWWbIMQr+yzavR9VH4bv2W+XfUNnKwMddyC+TyZLXtQk6zipPlzIpeIo2AOOEMH/xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a745J147; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88CC116D0;
	Mon,  5 Jan 2026 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619612;
	bh=JLjROzsRmrwFfvx5fWFeGklpiSVrsNvyNnXiNMaP6YI=;
	h=Subject:To:Cc:From:Date:From;
	b=a745J147Hp5WN2P/ddUS4HQKt8aApH744/6/gFyhpa8toiRWgN6erqUcqTqkBW5L2
	 meqrFw06wtAf1xoElt5/7muqOm/v4h0cQMyB1WZyuAgM6t0nmPDWgpYnOr3CcL1LMG
	 X1AJUKS2YcZA1RvGH5UlpBy0nYgF5W+QIB9SsfGY=
Subject: FAILED: patch "[PATCH] drm/ttm: Avoid NULL pointer deref for evicted BOs" failed to apply to 5.10-stable tree
To: Simon.Richter@hogyros.de,christian.koenig@amd.com,matthew.brost@intel.com,shuicheng.lin@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:26:49 +0100
Message-ID: <2026010549-periscope-recluse-8408@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 491adc6a0f9903c32b05f284df1148de39e8e644
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010549-periscope-recluse-8408@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 491adc6a0f9903c32b05f284df1148de39e8e644 Mon Sep 17 00:00:00 2001
From: Simon Richter <Simon.Richter@hogyros.de>
Date: Tue, 14 Oct 2025 01:11:33 +0900
Subject: [PATCH] drm/ttm: Avoid NULL pointer deref for evicted BOs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is possible for a BO to exist that is not currently associated with a
resource, e.g. because it has been evicted.

When devcoredump tries to read the contents of all BOs for dumping, we need
to expect this as well -- in this case, ENODATA is recorded instead of the
buffer contents.

Fixes: 7d08df5d0bd3 ("drm/ttm: Add ttm_bo_access")
Fixes: 09ac4fcb3f25 ("drm/ttm: Implement vm_operations_struct.access v2")
Cc: stable <stable@kernel.org>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6271
Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20251013161241.709916-1-Simon.Richter@hogyros.de

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index b47020fca199..e6abc7b40b18 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -434,6 +434,11 @@ int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
 	if (ret)
 		return ret;
 
+	if (!bo->resource) {
+		ret = -ENODATA;
+		goto unlock;
+	}
+
 	switch (bo->resource->mem_type) {
 	case TTM_PL_SYSTEM:
 		fallthrough;
@@ -448,6 +453,7 @@ int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
 			ret = -EIO;
 	}
 
+unlock:
 	ttm_bo_unreserve(bo);
 
 	return ret;


