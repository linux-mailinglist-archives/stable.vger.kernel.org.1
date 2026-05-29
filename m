Return-Path: <stable+bounces-256673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJLYFgrNGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:29:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E360675E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20B9030722BA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE80D3803FA;
	Fri, 29 May 2026 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvWVTOzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935037AA9E
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075447; cv=none; b=LVN72c7Nt+SYXWfxle2IQPNpegXJM03BO0UVFYt7Ytdakm/Aw2f1YaC0HzmG9+2KpNPh/ti0xBBhL4YNNPal8JblsLyIj3+Fl0DhvXVYO2ocOvbg8m4d/KcnxdizUsTDj8M9azl5r+9rqyWgw+RyLSiuNtYNsZYbyp59TqR577M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075447; c=relaxed/simple;
	bh=UwLNADmc/f1Ohq1rz7sGbukVglOCoVqv/s7Ixqt+HRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGvQG5/8MUOAkjakq2+LCyoYbSb38wuz2zBEDKuIOHHZRDK2fJla19n07pCKrc64omQGy0bFhUZmedQ5y1QOttJnieVVWfR64H9/g9Rg0mimcyNVXlnN6ceAuXMwNz8Ij5Gm2swk1qTH8C6V4hcoZrMs8L9tUmEq4PqLe+2J344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvWVTOzE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3741F00893;
	Fri, 29 May 2026 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075446;
	bh=nYuIV9AvDafYDcSbmI0+95lKITkmfWI6WJtx/j8RINo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvWVTOzEc6sLLsdd4agf0l6vVfQ3dDH3V6mSedWMZ0sIe8WfAkKZgTwvAtegYhe1J
	 /9O9mfzQVuRCoqpPEx7Az7/6HCtpkbMVElfEZx42ZaEquV8f5HlHw3OG4INX4RrbGC
	 F/mpfWR5y73pWB9956SiFHQhTs7Xwfwl1zTpqorsQ+Y6GURSENcSb3wICGdSBxJBu+
	 4CwnPFXu99Z5zip652MehYlCylZTvq/OckJhvgowMP1xFkJuZb9Kd+VLPG9SJz/dPg
	 8uKCgilCOIw/6NI5HsFb77mwYdpIL4yyrKNh6UJUf0OhgRWqKEKKXtgFuK3jGqvdb6
	 Ug4vkXyw7FjmQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4A2CAF4006D;
	Fri, 29 May 2026 13:24:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 29 May 2026 13:24:05 -0400
X-ME-Sender: <xms:tcsZaiZfNBo4HsT7yU7AfTjnsw_oC5UsxFxbzzhN9ulyJ43y5FtDdg>
    <xme:tcsZatVdx-RI6g1CgDTFEycYUwUjeNjQlr27bteqOX0c-lH6wnYxJ6msprJqu5gmz
    BRoIR-a5ShL_dktzy4y-bV8RPH1v5AvctM9j_tYuxeVpbAcFxFnYDw>
X-ME-Received: <xmr:tcsZakJbMtPFiZjdDr6OBXudwfo9copsfwbDDvbgfRNtKVSXSo1YrsT0CeMlow>
X-ME-Proxy-Cause: dmFkZTEZfpMr5/eRRE28w8SXJrP2dhbWJDto6huRdd/cnfVbAAhK4j6L5mXvQtvbZW1Tgn
    qdHjS1xVDGkdt7hr1SYRochmR7yuP2KsuqbhH6HkebbwRdIZkVYqIRv2TfGI9SaQtUiic8
    G8SBlRV6/L2Xtb05bm6QmOQTKoj3b/RGprk0F6woL4YfqntUvh+0D5sL6ruauatQhdAfx4
    sxg873kOfAaKAVmot+PkxhAMe2YWyy/aSlFAam2C/bHdTY9DLsPBVhceLLRJtCvIR2Q+zM
    kaoJA5O2aRPotfcyz8zPVtzBiOjMLe5Pw3NzV/bo4OKaUt+lobJ5eojHQXZMuqCslD6AnS
    ok5QtyObWq6j+DXuni1rlZOw3XtlbsdrBtLk/PduNPZnMWbxiseSW1kQIaGiYoG0Owi9Jp
    9XjI1ZxuqSyNya4Ifrta5xPSeY6MbudbjLqoQOxnqqoSfmGjibIBRAdMYKp0lTqE92dtia
    gIKy/RhhuXxoarlGCcIglkcPQ/ZRLxd6pcw2uj5oCWiJXoJC0ZVSRe+qltKVCgafAsu4hU
    rYsD0f1RyR4nUE9eGm/7OvFVKPnlAstWfYnjFnH6iAP4Dv8Dm284OQXfbNkidxkyt9DHu6
    +bwThVFcMbvJHZ6h4DjLhbKj4GHVfcB11PnXN1U61Tttbh5oo2wkrZpwBzwA
X-ME-Proxy: <xmx:tcsZarGEKZyBHoXSotxu6Euz06YCtqFwMzYwFMdR1gKwaOaJvaCTTw>
    <xmx:tcsZapzX_01yOuXs3Fu_seV961tbe_1QPS9F1Eni8nOvoiWsg__gvg>
    <xmx:tcsZaogtK0IJGEdVqN8B4vq1cIMulL9p2Ir9PFS5eZptLq_rJcn1Pg>
    <xmx:tcsZamKHCfuqMzkPpdKJQMaeEJmPvl6IejKZow3tn3Q_jRgOihC83g>
    <xmx:tcsZajCI2rn5lz_26HGnADnkJBOWToyvw2nF1181XMs9uV0jtDenYIiy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:24:03 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Andrei Vagin <avagin@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] fs/proc/task_mmu: fix hugetlb self-deadlock in pagemap_scan_pte_hole()
Date: Fri, 29 May 2026 18:23:27 +0100
Message-ID: <20260529172331.356655-4-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172331.356655-1-kas@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,kernel.org,infradead.org,google.com,suse.de,rere.qmqm.pl,arm.com,gmail.com,canb.auug.org.au];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256673-lists,stable=lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.202.2.42:received,10.202.2.162:received,100.90.174.1:received,100.103.45.18:received];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 684E360675E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A PAGEMAP_SCAN ioctl requesting PM_SCAN_WP_MATCHING on a hugetlb VMA hangs
the calling thread, unkillably, as soon as the scan reaches an unpopulated
part of the range:

  do_pagemap_scan()
    walk_page_range()
      walk_hugetlb_range()
        hugetlb_vma_lock_read()           # take the vma lock for read ...
        pagemap_scan_pte_hole()           # ... ->pte_hole() for a hole
          uffd_wp_range()
            change_protection()
              hugetlb_change_protection()
                hugetlb_vma_lock_write()  # ... and block taking it for write

walk_hugetlb_range() holds the hugetlb vma lock for read across the whole
walk.  A present entry goes to ->hugetlb_entry(); an unpopulated one goes
to ->pte_hole(), i.e. pagemap_scan_pte_hole().  To write-protect the hole
that handler calls uffd_wp_range(), which on a hugetlb VMA reaches
hugetlb_change_protection() and takes the same vma lock for write.  The
thread then blocks in down_write() waiting for the read lock it is itself
holding.

The populated path avoids this: pagemap_scan_hugetlb_entry() write-protects
the entry inline under the page-table lock and never enters
hugetlb_change_protection().

Do the same for holes.  Fault in the page table and install the uffd-wp
marker directly with make_uffd_wp_huge_pte() under the page-table lock,
rather than routing through uffd_wp_range().  That is the same sequence
hugetlb_change_protection() runs for an unpopulated entry, minus the vma
write lock -- which is safe to skip because PMD sharing is disabled on
uffd-wp VMAs (hugetlb_unshare_all_pmds() runs at registration), leaving
nothing for that lock to serialise against.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/proc/task_mmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1489c67e88f7..06fb94a965ff 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2977,8 +2977,62 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 
 	return ret;
 }
+
+/*
+ * Write-protect the unpopulated hugetlb entries covering [addr, end) by
+ * installing uffd-wp markers inline, exactly as pagemap_scan_hugetlb_entry()
+ * does for populated entries.
+ *
+ * walk_hugetlb_range() currently calls ->pte_hole() once per huge page, so the
+ * loop normally runs a single iteration; it is written to cover the full range
+ * in case the walker ever coalesces adjacent holes.
+ *
+ * The obvious route -- uffd_wp_range() -> hugetlb_change_protection() --
+ * cannot be used here: it takes hugetlb_vma_lock_write(), but the page-table
+ * walker (walk_hugetlb_range()) already holds hugetlb_vma_lock_read() on the
+ * same VMA, so the scanning thread would deadlock against itself. PMD sharing
+ * is disabled on uffd-wp VMAs (hugetlb_unshare_all_pmds() at registration), so
+ * the vma lock guards nothing that matters for these entries anyway.
+ */
+static int pagemap_scan_hugetlb_hole_wp(struct vm_area_struct *vma,
+					unsigned long addr, unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long psize = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+	pte_t *ptep;
+	pte_t pte;
+
+	for (addr = ALIGN_DOWN(addr, psize); addr < end; addr += psize) {
+		ptep = huge_pte_alloc(mm, vma, addr, psize);
+		if (!ptep)
+			return -ENOMEM;
+
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+		ptl = huge_pte_lock(h, mm, ptep);
+		pte = huge_ptep_get(mm, addr, ptep);
+		make_uffd_wp_huge_pte(vma, addr, ptep, pte);
+		/*
+		 * A none entry has no cached translation, so installing the
+		 * marker needs no TLB flush. Flush only if a fault populated
+		 * the entry between huge_pte_alloc() and the page table lock.
+		 */
+		if (!huge_pte_none(pte))
+			flush_hugetlb_tlb_range(vma, addr, addr + psize);
+		spin_unlock(ptl);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	return 0;
+}
 #else
 #define pagemap_scan_hugetlb_entry NULL
+static int pagemap_scan_hugetlb_hole_wp(struct vm_area_struct *vma,
+					unsigned long addr, unsigned long end)
+{
+	return 0;
+}
 #endif
 
 static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
@@ -2998,7 +3052,10 @@ static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 	if (~p->arg.flags & PM_SCAN_WP_MATCHING)
 		return ret;
 
-	err = uffd_wp_range(vma, addr, end - addr, true);
+	if (is_vm_hugetlb_page(vma))
+		err = pagemap_scan_hugetlb_hole_wp(vma, addr, end);
+	else
+		err = uffd_wp_range(vma, addr, end - addr, true);
 	if (err < 0)
 		ret = err;
 
-- 
2.54.0


