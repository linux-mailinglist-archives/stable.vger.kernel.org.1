Return-Path: <stable+bounces-241398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEBjFUCS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:43:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD654769A4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68113017BE3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73063D170C;
	Mon, 27 Apr 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGF7VDAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA483C73EA
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308172; cv=none; b=qEa2OhIAy9qQFjgADkvXFbh2CiRtv/GcbGz65Z50e/N/CRh9L+2BQMeDZV7uVmUeGqX7LDb4p5TMsNBzm94Vcj5OOu1JPqk6Z0U9DZz01rcrDhmge4Sa3fukuJ57HLKNMgQw/3FRAz4M21qT+tfn5ivfiKCQVRRXjQrftK2YvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308172; c=relaxed/simple;
	bh=/VkUlJtqRvSc91+OkJscOCaxgA923dddg632OTJOqOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DPhwoCR0IuD8uGAp0w/1jG/aMPrUUzWfxyIqlONCEPf+vVMWgbUlQS/T+d08sK9GyUg1C9eaFMy9Cfnap5XOkdV3E8uRVkA/knj7Fx3WZss9rYzz5izaxcI4Zwt7ufzBInPDqAfSxWWt+DXJuCtzFgwAn4/ivC+0gTTIxx9GlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGF7VDAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2780BC2BCB4;
	Mon, 27 Apr 2026 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308172;
	bh=/VkUlJtqRvSc91+OkJscOCaxgA923dddg632OTJOqOg=;
	h=Subject:To:Cc:From:Date:From;
	b=QGF7VDAcsxuvhkoPb/pw1SArDuD9XC1uC2UKE5JyiCH/Ge7WJbqX4iYQ4xct+IgRP
	 IXkH27yGIOq5EtuAbDY4wVxSwtOyTVJz3P4pEaXi+kwdxAMteP+dD9mtKbrHXzbiSq
	 G06uVqkNEZ6Ub2AtmRqIZIIwotGFHf1r+JdbBtSU=
Subject: FAILED: patch "[PATCH] lib: test_hmm: evict device pages on file close to avoid" failed to apply to 6.1-stable tree
To: apopple@nvidia.com,akpm@linux-foundation.org,balbirs@nvidia.com,david@kernel.org,jgg@ziepe.ca,leon@kernel.org,liam.howlett@oracle.com,ljs@kernel.org,matthew.brost@intel.com,mhocko@suse.com,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com,zenghui.yu@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:42:09 -0600
Message-ID: <2026042709-regress-upper-c18d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAD654769A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241398-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 744dd97752ef1076a8d8672bb0d8aa2c7abc1144
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042709-regress-upper-c18d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 744dd97752ef1076a8d8672bb0d8aa2c7abc1144 Mon Sep 17 00:00:00 2001
From: Alistair Popple <apopple@nvidia.com>
Date: Tue, 31 Mar 2026 17:34:43 +1100
Subject: [PATCH] lib: test_hmm: evict device pages on file close to avoid
 use-after-free

Patch series "Minor hmm_test fixes and cleanups".

Two bugfixes a cleanup for the HMM kernel selftests.  These were mostly
reported by Zenghui Yu with special thanks to Lorenzo for analysing and
pointing out the problems.


This patch (of 3):

When dmirror_fops_release() is called it frees the dmirror struct but
doesn't migrate device private pages back to system memory first.  This
leaves those pages with a dangling zone_device_data pointer to the freed
dmirror.

If a subsequent fault occurs on those pages (eg.  during coredump) the
dmirror_devmem_fault() callback dereferences the stale pointer causing a
kernel panic.  This was reported [1] when running mm/ksft_hmm.sh on arm64,
where a test failure triggered SIGABRT and the resulting coredump walked
the VMAs faulting in the stale device private pages.

Fix this by calling dmirror_device_evict_chunk() for each devmem chunk in
dmirror_fops_release() to migrate all device private pages back to system
memory before freeing the dmirror struct.  The function is moved earlier
in the file to avoid a forward declaration.

Link: https://lore.kernel.org/20260331063445.3551404-1-apopple@nvidia.com
Link: https://lore.kernel.org/20260331063445.3551404-2-apopple@nvidia.com
Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Closes: https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Tested-by: Zenghui Yu <zenghui.yu@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zenghui Yu <zenghui.yu@linux.dev>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 0964d53365e6..79fe7d233df1 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -185,11 +185,73 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
+{
+	unsigned long start_pfn = chunk->pagemap.range.start >> PAGE_SHIFT;
+	unsigned long end_pfn = chunk->pagemap.range.end >> PAGE_SHIFT;
+	unsigned long npages = end_pfn - start_pfn + 1;
+	unsigned long i;
+	unsigned long *src_pfns;
+	unsigned long *dst_pfns;
+	unsigned int order = 0;
+
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
+
+	migrate_device_range(src_pfns, start_pfn, npages);
+	for (i = 0; i < npages; i++) {
+		struct page *dpage, *spage;
+
+		spage = migrate_pfn_to_page(src_pfns[i]);
+		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		if (WARN_ON(!is_device_private_page(spage) &&
+			    !is_device_coherent_page(spage)))
+			continue;
+
+		order = folio_order(page_folio(spage));
+		spage = BACKING_PAGE(spage);
+		if (src_pfns[i] & MIGRATE_PFN_COMPOUND) {
+			dpage = folio_page(folio_alloc(GFP_HIGHUSER_MOVABLE,
+					      order), 0);
+		} else {
+			dpage = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_NOFAIL);
+			order = 0;
+		}
+
+		/* TODO Support splitting here */
+		lock_page(dpage);
+		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
+		if (src_pfns[i] & MIGRATE_PFN_WRITE)
+			dst_pfns[i] |= MIGRATE_PFN_WRITE;
+		if (order)
+			dst_pfns[i] |= MIGRATE_PFN_COMPOUND;
+		folio_copy(page_folio(dpage), page_folio(spage));
+	}
+	migrate_device_pages(src_pfns, dst_pfns, npages);
+	migrate_device_finalize(src_pfns, dst_pfns, npages);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
+}
+
 static int dmirror_fops_release(struct inode *inode, struct file *filp)
 {
 	struct dmirror *dmirror = filp->private_data;
+	struct dmirror_device *mdevice = dmirror->mdevice;
+	int i;
 
 	mmu_interval_notifier_remove(&dmirror->notifier);
+
+	if (mdevice->devmem_chunks) {
+		for (i = 0; i < mdevice->devmem_count; i++) {
+			struct dmirror_chunk *devmem =
+				mdevice->devmem_chunks[i];
+
+			dmirror_device_evict_chunk(devmem);
+		}
+	}
+
 	xa_destroy(&dmirror->pt);
 	kfree(dmirror);
 	return 0;
@@ -1377,56 +1439,6 @@ static int dmirror_snapshot(struct dmirror *dmirror,
 	return ret;
 }
 
-static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
-{
-	unsigned long start_pfn = chunk->pagemap.range.start >> PAGE_SHIFT;
-	unsigned long end_pfn = chunk->pagemap.range.end >> PAGE_SHIFT;
-	unsigned long npages = end_pfn - start_pfn + 1;
-	unsigned long i;
-	unsigned long *src_pfns;
-	unsigned long *dst_pfns;
-	unsigned int order = 0;
-
-	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
-	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
-
-	migrate_device_range(src_pfns, start_pfn, npages);
-	for (i = 0; i < npages; i++) {
-		struct page *dpage, *spage;
-
-		spage = migrate_pfn_to_page(src_pfns[i]);
-		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
-			continue;
-
-		if (WARN_ON(!is_device_private_page(spage) &&
-			    !is_device_coherent_page(spage)))
-			continue;
-
-		order = folio_order(page_folio(spage));
-		spage = BACKING_PAGE(spage);
-		if (src_pfns[i] & MIGRATE_PFN_COMPOUND) {
-			dpage = folio_page(folio_alloc(GFP_HIGHUSER_MOVABLE,
-					      order), 0);
-		} else {
-			dpage = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_NOFAIL);
-			order = 0;
-		}
-
-		/* TODO Support splitting here */
-		lock_page(dpage);
-		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
-		if (src_pfns[i] & MIGRATE_PFN_WRITE)
-			dst_pfns[i] |= MIGRATE_PFN_WRITE;
-		if (order)
-			dst_pfns[i] |= MIGRATE_PFN_COMPOUND;
-		folio_copy(page_folio(dpage), page_folio(spage));
-	}
-	migrate_device_pages(src_pfns, dst_pfns, npages);
-	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kvfree(src_pfns);
-	kvfree(dst_pfns);
-}
-
 /* Removes free pages from the free list so they can't be re-allocated */
 static void dmirror_remove_free_pages(struct dmirror_chunk *devmem)
 {


