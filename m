Return-Path: <stable+bounces-128925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10EA7FC52
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E123B39B8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B6268C41;
	Tue,  8 Apr 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="USlzNCyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1822686B9
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108230; cv=none; b=OC3PXXa+vH+jLFrc4Pso1KLPY14mm9Nl8ZGy1DG8dTAI0ijRIWauqrgWG1/TdKt4HPSFNFer2iPo4LbNE9fCyKqjBi41kyJtNTxBPTWH2wrnTidY+QIHJTXeybxUgPu0RMVmtiqFVl5P8Si3E1KAi9GYINhpLp0pR6yhhOYfU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108230; c=relaxed/simple;
	bh=NUmS2Ww0wDH8Eb58cvktXMeFiD1RjdMtkYK6/MsB1g8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uryn7/CjK1fmqOSYTWDjHZcU3wzjh4idUIYDVvVrkVHaK1mjUa1Rx3G2DljoNdD8CKvyzn9aJ0+CFQKvihZtHnRQYZL9aTDQ1WPzJVe6zKJ1F1atequzwcyZYtiAxFU+UYH32PpjrLUb2jgdNX+vCGeeTc6CJICEqbYxMcrgxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=USlzNCyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B71C4CEEA;
	Tue,  8 Apr 2025 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744108230;
	bh=NUmS2Ww0wDH8Eb58cvktXMeFiD1RjdMtkYK6/MsB1g8=;
	h=Subject:To:Cc:From:Date:From;
	b=USlzNCyT9cMZwcTTtI9OmiFMCXQwZLVubGBfZW6jj8/1spVbyvm2fPteBZbJT46JW
	 Gek4EFRW/rrw6s+oxhU/KXVfy7tD67QGHS80spP098s4VXlYDBNP6ROvHfk57BbLra
	 zAMTNuZEvjJp3czWRtD7YWeP0dLHzW3NwfBzU6Ws=
Subject: FAILED: patch "[PATCH] slab: kmalloc_size_roundup() must not return 0 for non-zero" failed to apply to 5.15-stable tree
To: david.laight@aculab.com,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:28:57 +0200
Message-ID: <2025040857-displace-theorize-0492@gregkh>
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
git cherry-pick -x 8446a4deb6b6bc998f1d8d2a85d1a0c64b9e3a71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040857-displace-theorize-0492@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8446a4deb6b6bc998f1d8d2a85d1a0c64b9e3a71 Mon Sep 17 00:00:00 2001
From: David Laight <david.laight@aculab.com>
Date: Thu, 7 Sep 2023 12:42:20 +0000
Subject: [PATCH] slab: kmalloc_size_roundup() must not return 0 for non-zero
 size

The typical use of kmalloc_size_roundup() is:

	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
	if (!ptr) return -ENOMEM.

This means it is vitally important that the returned value isn't less
than the argument even if the argument is insane.
In particular if kmalloc_slab() fails or the value is above
(MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
its single zero-length buffer ZERO_SIZE_PTR.

Fix this by returning the input size if the size exceeds
KMALLOC_MAX_SIZE. kmalloc() will then return NULL as the size really is
too big.

kmalloc_slab() should not normally return NULL, unless called too early.
Again, returning zero is not the correct action as it can be in some
usage scenarios stored to a variable and only later cause kmalloc()
return ZERO_SIZE_PTR and subsequent crashes on access. Instead we can
simply stop checking the kmalloc_slab() result completely, as calling
kmalloc_size_roundup() too early would then result in an immediate crash
during boot and the developer noticing an issue in their code.

[vbabka@suse.cz: remove kmalloc_slab() result check, tweak comments and
 commit log]
Fixes: 05a940656e1e ("slab: Introduce kmalloc_size_roundup()")
Signed-off-by: David Laight <david.laight@aculab.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e99e821065c3..306e6f0074ff 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -745,24 +745,24 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
 
 size_t kmalloc_size_roundup(size_t size)
 {
-	struct kmem_cache *c;
+	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
+		/*
+		 * The flags don't matter since size_index is common to all.
+		 * Neither does the caller for just getting ->object_size.
+		 */
+		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+	}
 
-	/* Short-circuit the 0 size case. */
-	if (unlikely(size == 0))
-		return 0;
-	/* Short-circuit saturated "too-large" case. */
-	if (unlikely(size == SIZE_MAX))
-		return SIZE_MAX;
 	/* Above the smaller buckets, size is a multiple of page size. */
-	if (size > KMALLOC_MAX_CACHE_SIZE)
+	if (size && size <= KMALLOC_MAX_SIZE)
 		return PAGE_SIZE << get_order(size);
 
 	/*
-	 * The flags don't matter since size_index is common to all.
-	 * Neither does the caller for just getting ->object_size.
+	 * Return 'size' for 0 - kmalloc() returns ZERO_SIZE_PTR
+	 * and very large size - kmalloc() may fail.
 	 */
-	c = kmalloc_slab(size, GFP_KERNEL, 0);
-	return c ? c->object_size : 0;
+	return size;
+
 }
 EXPORT_SYMBOL(kmalloc_size_roundup);
 


