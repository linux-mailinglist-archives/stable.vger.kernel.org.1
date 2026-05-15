Return-Path: <stable+bounces-247753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAfUEDgaB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:06:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DFC5502A7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C857630B47F1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3E3BFAD1;
	Fri, 15 May 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="px6rtltI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B333A451F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849045; cv=none; b=VWibMueR8CB7/zACqPgTmInF5vF8cVwdrHwKk3K+Mf2kiiD7HhyQCKjySqDZA037UgkcOlG4GPkZfxkyNooumyVjwhzTqUErie7/ALhzQlbkP9BkP0cPo7mcU/mAIii9iCZMXK31dfXzW56cuhWEtcFVXYHrDMa8EkWq4N7N1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849045; c=relaxed/simple;
	bh=FYK3DEysUlHO9xqmyMoNEUnjJStrl3PdNA5yZadQjNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwDLaQV0BxVfCPpUQ/UfyufGhxtAj8DvsAUl87sJoLeJh7rb+/VfxK49Jr/ePS4dlDzMY2gTTE0zDUVilfbVtzMLwo17irDuFaLFXL1x5GSblKEmOqMmnHYQti8ZS3S8jNLuBjBi4t4RUapE0a1dVyNeVRcCVttvxZNSL9xph/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=px6rtltI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so89508005e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849041; x=1779453841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRwqnsxTLxrW/eYaYg5wfX+DDYr7GyQHDxxuw2ZHfsg=;
        b=px6rtltIRnyjjirzHhwo+7IN+r6V0nDU2Pc5fGy4j/rlqJaB5lyIur9eMrsXdMLyAR
         47CB7xUSVXSeZvmq3wkfb7/eGLV8Unn679UMx64JKkdLfcvV8CXLgm2/EewikrHaJM0E
         XM8IcmZGeGLyytT1QqSuBj63dsTCl9aNfl0gQ3RWZLqRkZ189vgTkbBxY1F2wp8FdEGZ
         A9jd0XpIrRP5w5sNw/4IktB4q+82FJ4ACiVDvxnhiV5JZheGa7qnGMwixkb4IFBtb4ZD
         RWiKTac9lky+kHHqs735V2FCL25ebNn1/okvY8yPdlcQpxrrHU8wYKWOrb6OeCsK1GSr
         MpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849041; x=1779453841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QRwqnsxTLxrW/eYaYg5wfX+DDYr7GyQHDxxuw2ZHfsg=;
        b=UrLCuqc9r8bYvz/gE3uKGjHqQsOVbsO8FK+XqU5cZEbWAbrfzQ9KrUeoDG4t7UJyf+
         GWp5c8Aomdvhyqevmw+Iz2mD685/2al9bQF8S8711KBDdKWOOlkcSdakpL2u+58WS/3a
         3G9Dq3ppC2OY6xD8Flgy2DyzaevVdYXBbDlie+nSCfLLsgCHHspdpqHzlkIUfu5Znwrv
         /Ud6bLn80yl/y3zicwNWh5FzT0UmmarFIxdZZz3kEyWFznSf6OWVXPaK2mY2W4BHsnha
         t9khuZGxS2bS0fxQ9WSpZtzwOO8AkAhfULYTG8bj7AISdH5xdA/r4NpocciylfwNpucu
         dNxg==
X-Gm-Message-State: AOJu0YyyGwUTAR+/AsEejRvMopWGRudJi/0Bw7x1esNLXZvWPNtCA9va
	U/tq1dapP2/oCfUUtaDdfIJOZepPmH9mzT5ZHDp/wEFx6jyeauEUOng2DR9bjlrM
X-Gm-Gg: Acq92OGXs3PycjZbSW2LEz3PR5HLLTQt/HvBQoo7+N+EtlQj3ZKbvQL4yT1qog2My9t
	Jw1NW0wkBgzoplXahz9qKsAPKiiQAXyvoSAXEEaMDQ8k76I0AgYX+D/kkYtkbUAgKg7xp3khoyu
	eTXDToFnEn+PDexuDJRESWQnJgmynfXRjg17RajM+EeaLv0mYieZD+91P808C9JQ5tllQIbeRxJ
	s51lgxVkTsdAwR6gNxCOozjlBSoz/QDp78gQ6+johfBOzmQqC1Y+USaXLNoK0WUhVXzkitBr85m
	I510LlpNup3gK/lzihpbbPbgLuVLStXglJ/lw99Bv/nSVv8ZjRuk+OoCeApDdwaHCYYAINBO9Op
	h339LGCDHKsRKrqnM3zeeTP4XcrWwYWfRHq4LARxvBATELBSDeREamk5PBWVsLwjKVmc0FgO/i5
	Losh9AEqbw0NxyaQDxmxjIZA2XyUIOmw==
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-48fe6514c31mr42790005e9.33.1778849041339;
        Fri, 15 May 2026 05:44:01 -0700 (PDT)
Received: from fedora ([156.207.183.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm100188115e9.1.2026.05.15.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:44:00 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	avagin@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nico Pache <npache@redhat.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v4 6/9] mm: set the VM_MAYBE_GUARD flag on guard region install
Date: Fri, 15 May 2026 15:42:16 +0300
Message-ID: <20260515124218.151966-8-elaidya225@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515124218.151966-2-elaidya225@gmail.com>
References: <20260515124218.151966-2-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93DFC5502A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,gmail.com,oracle.com,suse.cz,linux.alibaba.com,arm.com,google.com,lwn.net,linux.dev,efficios.com,suse.com,redhat.com,suse.de,goodmis.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-247753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Now we have established the VM_MAYBE_GUARD flag and added the capacity to
set it atomically, do so upon MADV_GUARD_INSTALL.

The places where this flag is used currently and matter are:

* VMA merge - performed under mmap/VMA write lock, therefore excluding
  racing writes.

* /proc/$pid/smaps - can race the write, however this isn't meaningful
  as the flag write is performed at the point of the guard region being
  established, and thus an smaps reader can't reasonably expect to avoid
  races.  Due to atomicity, a reader will observe either the flag being
  set or not.  Therefore consistency will be maintained.

In all other cases the flag being set is irrelevant and atomicity
guarantees other flags will be read correctly.

Note that non-atomic updates of unrelated flags do not cause an issue with
this flag being set atomically, as writes of other flags are performed
under mmap/VMA write lock, and these atomic writes are performed under
mmap/VMA read lock, which excludes the write, avoiding RMW races.

Note that we do not encounter issues with KCSAN by adjusting this flag
atomically, as we are only updating a single bit in the flag bitmap and
therefore we do not need to annotate these changes.

We intentionally set this flag in advance of actually updating the page
tables, to ensure that any racing atomic read of this flag will only
return false prior to page tables being updated, to allow for
serialisation via page table locks.

Note that we set vma->anon_vma for anonymous mappings.  This is because
the expectation for anonymous mappings is that an anon_vma is established
should they possess any page table mappings.  This is also consistent with
what we were doing prior to this patch (unconditionally setting anon_vma
on guard region installation).

We also need to update retract_page_tables() to ensure that madvise(...,
MADV_COLLAPSE) doesn't incorrectly collapse file-backed ranges contain
guard regions.

This was previously guarded by anon_vma being set to catch MAP_PRIVATE
cases, but the introduction of VM_MAYBE_GUARD necessitates that we check
this flag instead.

We utilise vma_flag_test_atomic() to do so - we first perform an
optimistic check, then after the PTE page table lock is held, we can check
again safely, as upon guard marker install the flag is set atomically
prior to the page table lock being taken to actually apply it.

So if the initial check fails either:

* Page table retraction acquires page table lock prior to VM_MAYBE_GUARD
  being set - guard marker installation will be blocked until page table
  retraction is complete.

OR:

* Guard marker installation acquires page table lock after setting
  VM_MAYBE_GUARD, which raced and didn't pick this up in the initial
  optimistic check, blocking page table retraction until the guard regions
  are installed - the second VM_MAYBE_GUARD check will prevent page table
  retraction.

Either way we're safe.

We refactor the retraction checks into a single
file_backed_vma_is_retractable(), there doesn't seem to be any reason that
the checks were separated as before.

Note that VM_MAYBE_GUARD being set atomically remains correct as
vma_needs_copy() is invoked with the mmap and VMA write locks held,
excluding any race with madvise_guard_install().

Link: https://lkml.kernel.org/r/e9e9ce95b6ac17497de7f60fc110c7dd9e489e8d.1763460113.git.ljs@kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 49e14dabed7a294427588d4b315f57fbfcab9990)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>

Cc: stable@vger.kernel.org # 6.18.x
---
 mm/khugepaged.c | 71 ++++++++++++++++++++++++++++++++-----------------
 mm/madvise.c    | 22 +++++++++------
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index abe54f0043c7..3dcd884c844e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1715,6 +1715,43 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
+/* Can we retract page tables for this file-backed VMA? */
+static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
+{
+	/*
+	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
+	 * got written to. These VMAs are likely not worth removing
+	 * page tables from, as PMD-mapping is likely to be split later.
+	 */
+	if (READ_ONCE(vma->anon_vma))
+		return false;
+
+	/*
+	 * When a vma is registered with uffd-wp, we cannot recycle
+	 * the page table because there may be pte markers installed.
+	 * Other vmas can still have the same file mapped hugely, but
+	 * skip this one: it will always be mapped in small page size
+	 * for uffd-wp registered ranges.
+	 */
+	if (userfaultfd_wp(vma))
+		return false;
+
+	/*
+	 * If the VMA contains guard regions then we can't collapse it.
+	 *
+	 * This is set atomically on guard marker installation under mmap/VMA
+	 * read lock, and here we may not hold any VMA or mmap lock at all.
+	 *
+	 * This is therefore serialised on the PTE page table lock, which is
+	 * obtained on guard region installation after the flag is set, so this
+	 * check being performed under this lock excludes races.
+	 */
+	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
+		return false;
+
+	return true;
+}
+
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
@@ -1729,14 +1766,6 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *ptl;
 		bool success = false;
 
-		/*
-		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
-		 * got written to. These VMAs are likely not worth removing
-		 * page tables from, as PMD-mapping is likely to be split later.
-		 */
-		if (READ_ONCE(vma->anon_vma))
-			continue;
-
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK ||
 		    vma->vm_end < addr + HPAGE_PMD_SIZE)
@@ -1748,14 +1777,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 
 		if (hpage_collapse_test_exit(mm))
 			continue;
-		/*
-		 * When a vma is registered with uffd-wp, we cannot recycle
-		 * the page table because there may be pte markers installed.
-		 * Other vmas can still have the same file mapped hugely, but
-		 * skip this one: it will always be mapped in small page size
-		 * for uffd-wp registered ranges.
-		 */
-		if (userfaultfd_wp(vma))
+
+		if (!file_backed_vma_is_retractable(vma))
 			continue;
 
 		/* PTEs were notified when unmapped; but now for the PMD? */
@@ -1782,15 +1805,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
 		/*
-		 * Huge page lock is still held, so normally the page table
-		 * must remain empty; and we have already skipped anon_vma
-		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
-		 * held, it is still possible for a racing userfaultfd_ioctl()
-		 * to have inserted ptes or markers.  Now that we hold ptlock,
-		 * repeating the anon_vma check protects from one category,
-		 * and repeating the userfaultfd_wp() check from another.
+		 * Huge page lock is still held, so normally the page table must
+		 * remain empty; and we have already skipped anon_vma and
+		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
+		 * it is still possible for a racing userfaultfd_ioctl() or
+		 * madvise() to have inserted ptes or markers.  Now that we hold
+		 * ptlock, repeating the retractable checks protects us from
+		 * races against the prior checks.
 		 */
-		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
+		if (likely(file_backed_vma_is_retractable(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
 			success = true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 0b3280752bfb..5dbe40be7c65 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1141,15 +1141,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		return -EINVAL;
 
 	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
-	 *
-	 * This ensures that on fork, we copy page tables correctly.
+	 * Set atomically under read lock. All pertinent readers will need to
+	 * acquire an mmap/VMA write lock to read it. All remaining readers may
+	 * or may not see the flag set, but we don't care.
+	 */
+	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
+
+	/*
+	 * If anonymous and we are establishing page tables the VMA ought to
+	 * have an anon_vma associated with it.
 	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
+	if (vma_is_anonymous(vma)) {
+		err = anon_vma_prepare(vma);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
-- 
2.54.0


