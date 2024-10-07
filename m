Return-Path: <stable+bounces-81484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BC993973
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 23:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161671C22A01
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11A18C90F;
	Mon,  7 Oct 2024 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUsirjIw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1418C351
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337348; cv=none; b=V0ci4yo7Yh45lZQvSIGNDsgg2DJ5Ug8W1dt5AAVwFd+0nIdALGYh9MvAkS0rd4yi4A/XES8fj9CaYm6FlRSobC1PWzwlkNVH+WA23CXj68S1+/iUIWmxUwmZVNZ3yBLv5SRvSUe8XaTcsfqSPe5ZepxZL1kBg/UI0sA1DXsSZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337348; c=relaxed/simple;
	bh=cge+0ZUm06KK/0QAuuB6eoRRP/4JrG1w5WnCUSMC+us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y/VboyfAF0kQEKzF/lzR5KPc/st89M0vBZfXjb0GAn+4Kq0oMZZm4TpIXavx3ZqOMqbdk9/I/SOeQxa+BtWsuOmjNbFpUCyJQFSHE8k2au9Ae+DXWWshBoLBTssoolGr/eZYuS88SxNcPAbvrnRFgxrWaYGM8T/8YvvQlTwyzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUsirjIw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae4ead5bso28595e9.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728337344; x=1728942144; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEqYXVDZfj34LfL39Znx/Mkr1hRg4FTviS8biIN1NTU=;
        b=xUsirjIwb4cA1SELocp1kwCSZnCN8wmwuq6rAvfgkpAdtmoXOccLL0ljG063GaEzke
         SI3MCWyZZHIvAwnBtGpNztj2Y4juwoBmutc5KLuWCFa016o/QNqQKQg93Tm3BTkBZjWH
         0z3w+75coJ23XtUz85tVT9+t/x1rcUoZwwqWz3k3tTxivagUg580pscavf+QR6a4363G
         bY0kDeYOGrKZSaUUC0PYDiR6a4EdwkBfabbHYFmL+9Yo6su3AYbcP2BUCEetvbpeeLAM
         nRObyMWPcH/Qeva6M8xat8lGZTVnxMPX1Gnzt4m/vl6DBhxMe1sychMTq2IVp8oyz5bj
         p9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728337344; x=1728942144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEqYXVDZfj34LfL39Znx/Mkr1hRg4FTviS8biIN1NTU=;
        b=DMjdaocHpzfimDZrANFmhxKGPs+pPvrSr5qUMSsRTrziHL6DyJ/4f7qTLMKneaupQB
         M/SfZb3pXdJpawPl8J43aHwWDatZQy4F433hCmPoZjTGEosP0UyQNRnUbboqHHXJrUC1
         qNs20yt5DVI/wGr0Da72lWiEcYVzCv+RT4CUFT+LHRdKrcYRhYbEv0igbbLoyb5RXBEC
         WwoHbex8Ru6bY5pBX0O6fDx53f71R1j0LSUDoVUJuuvNIjwiQzjtxiIudqPorhevjB8x
         YVefTuEKLsh5qk9GS3akRHH3vfnyJ63XxPcgzVRgCITj36GPQBtKdII0OO0qiyI21oeU
         TvJw==
X-Forwarded-Encrypted: i=1; AJvYcCVUWxhu+OKiuOu55yqxL68ilDqvhXIsU1gNAr8CUgueZqc1bphxD1izacIljaYbq+6OW/9RsTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkkAoJUsi6lv9vqWXo75ZKCNsiHy0Ww5gzNnlA1dNeclncjmMO
	ad4fUlFQshTbyToeBjwDoiEhiIMFIV5iv3wuovx/pm10R/47JsCViiNRNL4E0w==
X-Google-Smtp-Source: AGHT+IE+EIiw1yOPib1Q6zhGz6XSc+go3+7VvfBDNqOXffHNmeo1/5vijDgYWuZ+sdL4mS7/SOTyXA==
X-Received: by 2002:a05:600c:c0b:b0:42b:a8fc:3937 with SMTP id 5b1f17b1804b1-42fcdcdbc9emr1453395e9.4.1728337343926;
        Mon, 07 Oct 2024 14:42:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:39d2:ccab:c4ec:585b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8a519sm87095545e9.14.2024.10.07.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:42:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Oct 2024 23:42:04 +0200
Subject: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
X-B4-Tracking: v=1; b=H4sIAKtVBGcC/x2NWwqDMBAAryL73YUYi7G9ShEJybZdyIssBEG8u
 8HPYWDmAKHKJPAeDqjUWDinDuNjAPe36UfIvjNopZ+jUgZjbrSlXKMNW4kem6DLIdgihF/eUeO
 0GHrZeXHGz9A7pVIX9+OznucFX/vrH3MAAAA=
To: akpm@linux-foundation.org, david@redhat.com
Cc: linux-mm@kvack.org, willy@infradead.org, hughd@google.com, 
 lorenzo.stoakes@oracle.com, joel@joelfernandes.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728337339; l=5356;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cge+0ZUm06KK/0QAuuB6eoRRP/4JrG1w5WnCUSMC+us=;
 b=v+M5lo/3HNLWdMaYqWCgKp61ZnCEjXO6kZ29J1qibLRoisxNUT4w4LP94eX/peroRQBPTrj/0
 GI58xxIN8OMBIF3GkTO48gkh57jyPnTb9SykhQG26HYEZjWrRqdv9It
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

In mremap(), move_page_tables() looks at the type of the PMD entry and the
specified address range to figure out by which method the next chunk of
page table entries should be moved.
At that point, the mmap_lock is held in write mode, but no rmap locks are
held yet. For PMD entries that point to page tables and are fully covered
by the source address range, move_pgt_entry(NORMAL_PMD, ...) is called,
which first takes rmap locks, then does move_normal_pmd().
move_normal_pmd() takes the necessary page table locks at source and
destination, then moves an entire page table from the source to the
destination.

The problem is: The rmap locks, which protect against concurrent page table
removal by retract_page_tables() in the THP code, are only taken after the
PMD entry has been read and it has been decided how to move it.
So we can race as follows (with two processes that have mappings of the
same tmpfs file that is stored on a tmpfs mount with huge=advise); note
that process A accesses page tables through the MM while process B does it
through the file rmap:


process A                      process B
=========                      =========
mremap
  mremap_to
    move_vma
      move_page_tables
        get_old_pmd
        alloc_new_pmd
                      *** PREEMPT ***
                               madvise(MADV_COLLAPSE)
                                 do_madvise
                                   madvise_walk_vmas
                                     madvise_vma_behavior
                                       madvise_collapse
                                         hpage_collapse_scan_file
                                           collapse_file
                                             retract_page_tables
                                               i_mmap_lock_read(mapping)
                                               pmdp_collapse_flush
                                               i_mmap_unlock_read(mapping)
        move_pgt_entry(NORMAL_PMD, ...)
          take_rmap_locks
          move_normal_pmd
          drop_rmap_locks

When this happens, move_normal_pmd() can end up creating bogus PMD entries
in the line `pmd_populate(mm, new_pmd, pmd_pgtable(pmd))`.
The effect depends on arch-specific and machine-specific details; on x86,
you can end up with physical page 0 mapped as a page table, which is likely
exploitable for user->kernel privilege escalation.


Fix the race by letting process B recheck that the PMD still points to a
page table after the rmap locks have been taken. Otherwise, we bail and let
the caller fall back to the PTE-level copying path, which will then bail
immediately at the pmd_none() check.

Bug reachability: Reaching this bug requires that you can create shmem/file
THP mappings - anonymous THP uses different code that doesn't zap stuff
under rmap locks. File THP is gated on an experimental config flag
(CONFIG_READ_ONLY_THP_FOR_FS), so on normal distro kernels you need shmem
THP to hit this bug. As far as I know, getting shmem THP normally requires
that you can mount your own tmpfs with the right mount flags, which would
require creating your own user+mount namespace; though I don't know if some
distros maybe enable shmem THP by default or something like that.

Bug impact: This issue can likely be used for user->kernel privilege
escalation when it is reachable.

Cc: stable@vger.kernel.org
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Closes: https://project-zero.issues.chromium.org/371047675
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
@David: please confirm we can add your Signed-off-by to this patch after
the Co-developed-by.
(Context: David basically wrote the entire patch except for the commit
message.)

@akpm: This replaces the previous "[PATCH] mm/mremap: Prevent racing
change of old pmd type".
---
 mm/mremap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24712f8dbb6b..dda09e957a5d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 {
 	spinlock_t *old_ptl, *new_ptl;
 	struct mm_struct *mm = vma->vm_mm;
+	bool res = false;
 	pmd_t pmd;
 
 	if (!arch_supports_page_table_move())
@@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
-	/* Clear the pmd */
 	pmd = *old_pmd;
+
+	/* Racing with collapse? */
+	if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
+		goto out_unlock;
+	/* Clear the pmd */
 	pmd_clear(old_pmd);
+	res = true;
 
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
 	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
 	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
 
-	return true;
+	return res;
 }
 #else
 static inline bool move_normal_pmd(struct vm_area_struct *vma,

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241007-move_normal_pmd-vs-collapse-fix-2-387e9a68c7d6
-- 
Jann Horn <jannh@google.com>


