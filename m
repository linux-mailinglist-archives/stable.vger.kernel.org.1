Return-Path: <stable+bounces-170031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C68CB2A013
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B50A18A1189
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263830DEC8;
	Mon, 18 Aug 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIKE9G+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CC261B75
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515331; cv=none; b=RjRD/fiFgSv2s0SiQmj2cBWm1Zw3F06zpkOc/5CX46ar6YL1UoDYlwxc7bxiINVqcONuv760WLGdZvE26S+ccXU1QQFJm0ylW3VbwDe2FYw51GvVq0wNjeY0UXQW89QQ6Bxm1HOmEyJoh8iyPw9Lk35Hj4foAIRx/12fKyRhIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515331; c=relaxed/simple;
	bh=aDB9UPZrALgktwwWrWwPcs0VY1ZV1fPALYVHsLPDseQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wfi9t57UID6oKgpJFvwxD/SaYh5LkFGr0Vu6hhvC2cZdhuVdDqDDKiPKbkgWHv8sBJYivXF4oowIT8qPDTmH5mzi5ZgrotCs9RESkN7gD7R6qjIP6QrG79Z3FRkl8timBOIZ7ljzryvwjPlG0hbTpd6TfXj8dYGcO33XAcmisYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIKE9G+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E09C4CEEB;
	Mon, 18 Aug 2025 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515331;
	bh=aDB9UPZrALgktwwWrWwPcs0VY1ZV1fPALYVHsLPDseQ=;
	h=Subject:To:Cc:From:Date:From;
	b=QIKE9G+kK+a/MniD9KtjBCuCcJfE/2Wi2IWcK6cgqkUOgZAHK8r96ByYNNVM4sfj5
	 0xFpwe5KLlDdgqcTOXLCCPQX7ptubEvwOdYIBGWv1efmxegiCk4YpfbR2sXF7J6HEx
	 5uGEr+AFQKcVmmMggJ94zV7bc39m4iyeGzeuEf0Y=
Subject: FAILED: patch "[PATCH] mm/kmemleak: avoid deadlock by moving pr_warn() outside" failed to apply to 5.4-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,catalin.marinas@arm.com,kuba@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:08:48 +0200
Message-ID: <2025081848-proximity-feline-dfea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 47b0f6d8f0d2be4d311a49e13d2fd5f152f492b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081848-proximity-feline-dfea@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47b0f6d8f0d2be4d311a49e13d2fd5f152f492b2 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Thu, 31 Jul 2025 02:57:18 -0700
Subject: [PATCH] mm/kmemleak: avoid deadlock by moving pr_warn() outside
 kmemleak_lock

When netpoll is enabled, calling pr_warn_once() while holding
kmemleak_lock in mem_pool_alloc() can cause a deadlock due to lock
inversion with the netconsole subsystem.  This occurs because
pr_warn_once() may trigger netpoll, which eventually leads to
__alloc_skb() and back into kmemleak code, attempting to reacquire
kmemleak_lock.

This is the path for the deadlock.

mem_pool_alloc()
  -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
      -> pr_warn_once()
          -> netconsole subsystem
	     -> netpoll
	         -> __alloc_skb
		   -> __create_object
		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);

Fix this by setting a flag and issuing the pr_warn_once() after
kmemleak_lock is released.

Link: https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org
Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8d588e685311..e0333455c738 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -470,6 +470,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	bool warn = false;
 
 	/* try the slab allocator first */
 	if (object_cache) {
@@ -488,8 +489,10 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
-		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		warn = true;
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (warn)
+		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
 
 	return object;
 }


