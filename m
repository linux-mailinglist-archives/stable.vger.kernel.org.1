Return-Path: <stable+bounces-241755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH2BKWP68GlpbgEAu9opvQ
	(envelope-from <stable+bounces-241755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6948A945
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AA47306FC3F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050B477E3D;
	Tue, 28 Apr 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEPddcDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0F477E3B
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400389; cv=none; b=fjjxWwZ0qvSCXcYmazfwaPpRiwZ+VolIljRzy5dZRnXIpwWAIX7T3Xg1osESRRWNm8l1FbZwOoW/8R1+jRNFfdYy/O+sHmnwAuwVNiiAE/LewHZh4LFBJtQCzWntZv6zy0bocu58XgERJcISVEMFbofn73LxMJyvtUVfOlTgwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400389; c=relaxed/simple;
	bh=/ssUFuB9o6RnsgcayK2618PGF/5eliGmW172OERM1vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spJ1L9l1810rStkcV24URUrKPkyBfSVaV3RhvY2yfOLqCaR5rBgOCeIgOlrfhGzLIyNjn0Fv+jYckjJ28wwnOEaMXYN64jzML8okKGK9xirA12mxWZIAUvuRxa3LjWVjeidqbf+VZtFnaPlgn+WUVllqRuusc5OchfNp8pEuMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEPddcDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE5EC2BCAF;
	Tue, 28 Apr 2026 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400388;
	bh=/ssUFuB9o6RnsgcayK2618PGF/5eliGmW172OERM1vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEPddcDwkN1c/ZY1eeXBpZoSmZk1/A3FdVnYtjxUajG4C3W3+uXBP0rgo/haYiIln
	 Ih5VJhD6WWecRHRqms/jwt51IAjcs+m+44zccDgJYdulwrQDqnj0Q0dmwZ9etxiCXr
	 n03ALauqtv+C5raui4NNeMLx3XC5ADzYjqGFFYzj2vwIFzEmWnhosiEJh0UyvIF376
	 cRKZfMDya03V+6tvXV/9Vd2TEZqh5x+0NG8uvDw3cKKrD6fFApkiEpvHxQahD5N6nn
	 1uVEOhwWnnj7KMNAw2/OouutnNbUhmYTUtF+Qfnspz61VQWkoo4mR5B9GsWZekK8SY
	 //1B36n2mznzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] lib: test_hmm: evict device pages on file close to avoid use-after-free
Date: Tue, 28 Apr 2026 14:19:44 -0400
Message-ID: <20260428181944.3126951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042708-emu-barometer-99a0@gregkh>
References: <2026042708-emu-barometer-99a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBD6948A945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241755-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Alistair Popple <apopple@nvidia.com>

[ Upstream commit 744dd97752ef1076a8d8672bb0d8aa2c7abc1144 ]

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
[ kept the existing simpler `dmirror_device_evict_chunk()` body instead of the upstream compound-folio version ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_hmm.c | 86 ++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index b823ba7cb6a15..cb50065e37a34 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -183,11 +183,60 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
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
+		spage = BACKING_PAGE(spage);
+		dpage = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_NOFAIL);
+		lock_page(dpage);
+		copy_highpage(dpage, spage);
+		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
+		if (src_pfns[i] & MIGRATE_PFN_WRITE)
+			dst_pfns[i] |= MIGRATE_PFN_WRITE;
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
@@ -1217,43 +1266,6 @@ static int dmirror_snapshot(struct dmirror *dmirror,
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
-		spage = BACKING_PAGE(spage);
-		dpage = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_NOFAIL);
-		lock_page(dpage);
-		copy_highpage(dpage, spage);
-		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
-		if (src_pfns[i] & MIGRATE_PFN_WRITE)
-			dst_pfns[i] |= MIGRATE_PFN_WRITE;
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
-- 
2.53.0


