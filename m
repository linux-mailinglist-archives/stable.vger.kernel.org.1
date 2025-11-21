Return-Path: <stable+bounces-196518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EFC7AB46
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA9F3A103F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759B298991;
	Fri, 21 Nov 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="shSSuZ/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338C2D97BB
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741093; cv=none; b=NfBSwG3AtB5ACRVXsVpSwbfiaqriHpUGR93PHgYncxXV3dYWLGoyumMyGIBLWeAkUjLRbtrJWtvZR/vMMslIgATvA0pWC0pTnLmipQu8s15z2F0OKk9vKczb5QduSqfKSOzMmy/N92CsTSI1d8918ueHslR9x8otk5/Tce27/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741093; c=relaxed/simple;
	bh=ExG2l4+z5tGCF1GBw23CKVQq5VLMRGEogstvezbsdyo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OekTGNMxb49dhFaflt2SQhW2F8xj7tKwyE5HSrjbwyU44H8hD+R3ZuFfk9dIM+rQyKh8y8/zy4/BttfK3hVNoQJLwuathr9kEav8Cckxkh35LvvPsiBwKL0zjeUbyJXfHoljpNw6Bkra3K/a0RinMjwiZIJUwBmqzYzOOIke1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=shSSuZ/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67171C4CEF1;
	Fri, 21 Nov 2025 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763741092;
	bh=ExG2l4+z5tGCF1GBw23CKVQq5VLMRGEogstvezbsdyo=;
	h=Subject:To:Cc:From:Date:From;
	b=shSSuZ/l71IWwlKxbTKtmEun5SOtwl09dV2XT5orv0BN3FAdaVNXhfQsNaw+N35Kp
	 11rZK4LCjSNL94FOu3WSja5X1QMnsgABX53uGmNXqcvOtDskqjZA6de+5h+T8CR5V9
	 +9/o0NPPUT2Ivy86mg8K+H79cpty/sU7I+/uIE8g=
Subject: FAILED: patch "[PATCH] kho: allocate metadata directly from the buddy allocator" failed to apply to 6.17-stable tree
To: pasha.tatashin@soleen.com,akpm@linux-foundation.org,brauner@kernel.org,corbet@lwn.net,dmatlack@google.com,graf@amazon.com,jgg@ziepe.ca,masahiroy@kernel.org,ojeda@kernel.org,pratyush@kernel.org,rdunlap@infradead.org,rppt@kernel.org,skhawaja@google.com,stable@vger.kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Nov 2025 17:04:49 +0100
Message-ID: <2025112149-ahoy-manliness-1554@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x fa759cd75bce5489eed34596daa53f721849a86f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112149-ahoy-manliness-1554@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa759cd75bce5489eed34596daa53f721849a86f Mon Sep 17 00:00:00 2001
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 20:08:52 -0400
Subject: [PATCH] kho: allocate metadata directly from the buddy allocator

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc().  This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled.  kzalloc() calls can be randomly
intercepted by kfence_alloc(), which services the allocation from a
dedicated KFENCE memory pool.  This pool is allocated early in boot via
memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it.  This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec.  If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Link: https://lkml.kernel.org/r/20251021000852.2924827-4-pasha.tatashin@soleen.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Matlack <dmatlack@google.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0ceb4e09306c..623bee335383 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/topology.h>
 #include <linux/alloc_tag.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 
 struct vm_area_struct;
@@ -463,4 +464,6 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 /* This should be paired with folio_put() rather than free_contig_range(). */
 #define folio_alloc_gigantic(...) alloc_hooks(folio_alloc_gigantic_noprof(__VA_ARGS__))
 
+DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
+
 #endif /* __LINUX_GFP_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 9217d2fdd2d3..2a8c20c238a8 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -142,7 +142,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -348,9 +348,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 


