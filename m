Return-Path: <stable+bounces-189809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77784C0AA53
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9391C189ADD4
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECE23B612;
	Sun, 26 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqdkPQn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27E23EA98
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489298; cv=none; b=a8jqMM/KyeOq7wrhLcvSqglgex6O8ttu3KFLWP+ZjhE94zMZ6dOhmO5FHxybfV2pBfzLLZxaG+sPqSc81nzE9G1iP1Dc1K9BxwY4z9VpC4aG28onM+DP7YM+fL10DGYmkOOrZVFHTOv00zsy0ahCItxugHLevpCFrEbqcsPsY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489298; c=relaxed/simple;
	bh=3W78hD+UM7eXcyyBt+Rx74PEBDsFvrpz1/J2CBHKsXI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fs5RWGihaZurwEqTt8vxcF3OOFWTFbqrOAjKP0S20KHEZ6eyjLhhWI0Lwzx3fzpqMJG7XS3hChdSGQwaFJoqNyzRR0Fhws0puvo+4mfjSAiHEUhbzGuD9iIFum45Uchga37Ibb4n1lDAyRP1/QU0mt8eCBmjPJtXmqni5DMF0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqdkPQn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF18C4CEE7;
	Sun, 26 Oct 2025 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489298;
	bh=3W78hD+UM7eXcyyBt+Rx74PEBDsFvrpz1/J2CBHKsXI=;
	h=Subject:To:Cc:From:Date:From;
	b=PqdkPQn8naeWI1CsLES4jV5Uv0Ldks7YdvLgzq+RlzU7jpkNE2jk5JA6UbgDSEJ9T
	 fFQRE8rmutCO37lRbD0L0ifaT3GmMPuZVYducPqMIqBPZPpsDbi52l9KHY5zsjZZ/U
	 ihDVvPRi0pgOrmCFg0HgG/DTGMyxG3sU35dWNCF4=
Subject: FAILED: patch "[PATCH] drm/xe: Check return value of GGTT workqueue allocation" failed to apply to 6.12-stable tree
To: matthew.brost@intel.com,lucas.demarchi@intel.com,matthew.auld@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:34:55 +0100
Message-ID: <2025102655-unsettled-dingy-acaf@gregkh>
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
git cherry-pick -x ce29214ada6d08dbde1eeb5a69c3b09ddf3da146
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102655-unsettled-dingy-acaf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce29214ada6d08dbde1eeb5a69c3b09ddf3da146 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Tue, 21 Oct 2025 17:55:36 -0700
Subject: [PATCH] drm/xe: Check return value of GGTT workqueue allocation

Workqueue allocation can fail, so check the return value of the GGTT
workqueue allocation and fail driver initialization if the allocation
fails.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://lore.kernel.org/r/20251022005538.828980-2-matthew.brost@intel.com
(cherry picked from commit 1f1314e8e71385bae319e43082b798c11f6648bc)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 7fdd0a97a628..5edc0cad47e2 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -292,6 +292,9 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 		ggtt->pt_ops = &xelp_pt_ops;
 
 	ggtt->wq = alloc_workqueue("xe-ggtt-wq", 0, WQ_MEM_RECLAIM);
+	if (!ggtt->wq)
+		return -ENOMEM;
+
 	__xe_ggtt_init_early(ggtt, xe_wopcm_size(xe));
 
 	err = drmm_add_action_or_reset(&xe->drm, ggtt_fini_early, ggtt);


