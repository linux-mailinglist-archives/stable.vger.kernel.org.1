Return-Path: <stable+bounces-144859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F1ABBF4C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92748188FD57
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11819B3CB;
	Mon, 19 May 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyP2Zjyr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD68249F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661768; cv=none; b=UMG3mSAjllkT+XieyjiGo7SyItpr9L5Wb4jbN3KMkyXOamguOSZ/PgC+peA4NBUYAvIT6aFJVrqLtnIF0B0zqPNEGC8xuSPj4jnSGJcXdnZW/fknp8HVvnLHK2eltHopAKdZ4A/2JHwZFwz1aG9ul+uu8D7osZuVhrQahgLzVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661768; c=relaxed/simple;
	bh=leYKQsss12mCxU00PcjhPp2naNB6NHDjrJ/fvEkpiVQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M5R4IrZFYBclknl4B3plriqG8pOVOFgbbqyJ8SZsWYGzT+D0199F7/OwpAudt44XQd07wwmEljrq4a1bY2ilmZ0rk1qEGkCuEVYwIjzZYZ4L47aCpX34MM7fBIsG7ohrmffqpoXUNvgL+q/NsxpeM5XWkhqSoW70JWTPoH0ZKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyP2Zjyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A15EC4CEEF;
	Mon, 19 May 2025 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747661767;
	bh=leYKQsss12mCxU00PcjhPp2naNB6NHDjrJ/fvEkpiVQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ZyP2ZjyryXdJJUDAP5IGkOgwEoncopSciPHaqrhNSfiGFolkszjtPDt98Hn5WA/J5
	 9mvjRNm5kkadPsS+MRI1/xmqe/NtLcg/v4fO3X6sLyPbOxuk7zdDQaQg42fUxpOe1G
	 eh/xHLvpzsfwlia21H2wlCEROqWOWgR+xwkwaY7w=
Subject: FAILED: patch "[PATCH] dmaengine: idxd: Add missing cleanups in cleanup internals" failed to apply to 5.15-stable tree
To: xueshuai@linux.alibaba.com,dave.jiang@intel.com,fenghuay@nvidia.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:36:04 +0200
Message-ID: <2025051904-earache-virtuous-e35d@gregkh>
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
git cherry-pick -x 61d651572b6c4fe50c7b39a390760f3a910c7ccf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051904-earache-virtuous-e35d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61d651572b6c4fe50c7b39a390760f3a910c7ccf Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Fri, 4 Apr 2025 20:02:13 +0800
Subject: [PATCH] dmaengine: idxd: Add missing cleanups in cleanup internals

The idxd_cleanup_internals() function only decreases the reference count
of groups, engines, and wqs but is missing the step to release memory
resources.

To fix this, use the cleanup helper to properly release the memory
resources.

Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250404120217.48772-6-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a40fb2fd5006..f8129d2d53f1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -407,14 +407,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
-	int i;
-
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_groups(idxd);
+	idxd_clean_engines(idxd);
+	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
 }
 


