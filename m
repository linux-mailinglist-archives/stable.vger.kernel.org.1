Return-Path: <stable+bounces-165159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F82B15726
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F254218A6B4E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852391A0711;
	Wed, 30 Jul 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLwOD95v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821E198E9B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840341; cv=none; b=pyd5KP7jDVYZCdKkQE0TQfedIvZtz8fGX+lXprh5CaI189Xze68wwhQXn2CiQE/kU81ybAtmhg7GZ+1QejTWgIUqu1VfTPxHzE5I8TLDxEOimuGABiJVGuvEwIrJ50/8JWzaNUpuIisEDmU1g2DvQDsSRTwPJwv193OeCIS0DFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840341; c=relaxed/simple;
	bh=DFsUmBoSxpvEl1jbcoyHdUsySmtnyVJkjTVNKb4iPAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2iZMpiaxwJvV4KZRtVs+Uv+Vdo0q1hhyV6AuQL/U5WaG8iL3j2DV8n6EincWRhMLO0MgfbCCqcU7OsYsnQf9Juf09bwOAOu3MgZx8ql8ZJaYopkJclceMUtbDmPm1HCDHn3URCJUfDiFBVOcPiEQXBBl05bdMC8s0t/0MIh2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLwOD95v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403c86ff97so31830895ad.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840339; x=1754445139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lpYwICX0CJSHu8yDb7qWIdE6OnXVrrqjQR/9Vf5znQ=;
        b=XLwOD95vFpuIQD+32Yfp6PDmLmYoROvJqTy4v1h8uRuSm3Wj4DhZ1CQ6dLNGsrRIZE
         HKXdSWmeKCc247MAD34y1H147tkttWaVqbvCx9J6XJHQzh/owSRjDvAEYCmCy04yUf5k
         gjVlXenVGjQzcY7laVJCDffBN/qcPrVOzGiihdKbTkz8LaLUfjPmSWI//A1+IQoST9Fe
         rxxt9NY2uQNlF581kedQrJC4F+bx+LtN5cqv3KGsoOlvJTOtTOctQJor5m97kK8c4cpP
         +riAJL95pFDGqkBwxjh5DpGeY1TyZ9x7bh35QGGwrrTdyIfbph194JXH3cqgbamHHDv1
         ifBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840339; x=1754445139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lpYwICX0CJSHu8yDb7qWIdE6OnXVrrqjQR/9Vf5znQ=;
        b=NPONFp/cVvs96+6IKeLQNyNWTiQydydXkHJQee+m1Ehme1c8uM2aSkFjwH0070QioX
         +8UEYm44SguaMuLnD++eeadSwQ0seZsKtPdxGjmq0Aj1MmwzSbN1F7YS73Xk+qKyYDMI
         rQNqS/l2WisBZl+MjXyK+w9UVzkatfss3u/Ctm754l1wzTcEAxQ/BGgKQj5892QkV/Rm
         NyfOPQhJdToY3T+/uXj7Jth1e+usUtjd8chA33f9IW6NRJVD3Fw86zUJ2BbQU9+2HdV1
         o1JagkNPKlALb/bYzH1zGujntCRQE2nENm3alAvwrKOl0fN6pmiPQe53k9aLPMBE/kIL
         UcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVVzPeKiTnqFxX1PoKWaMfDSrBCVJtny6yBRjLKuEn9wZE8bxPr5CWaAv62Wl7wPSP8/4Ei0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqXlad+7tWnA2nSY2lKio4dwF7J1jFvhBWlqiPDWZeNYLbpAW
	4JiqpMng23wfQdWjoA4qH+LmCTZH2YD4kjTweoiiph7v+lkblskHr/RAYstQ2117az2Lp1lSxQq
	4Wa4TCiqF0Jnw0GNvFkBusC1L4cz9ccB0dxFlrQ==
X-Google-Smtp-Source: AGHT+IGeZs7EIs+wsidrRLh3DvOWd/rMI+xlaw3P1K3iT5U0r2fWnca34EEPi5qKaWhGTlIWdLQsx8AEbCbxzPoxkPb7kA==
X-Received: from plil7.prod.google.com ([2002:a17:903:17c7:b0:234:c2e4:1df6])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70d:b0:240:4faa:75cd with SMTP id d9443c01a7336-24096bb3415mr20277435ad.48.1753840338964;
 Tue, 29 Jul 2025 18:52:18 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:51:45 -0700
In-Reply-To: <20250730015152.29758-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015152.29758-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015152.29758-2-isaacmanjarres@google.com>
Subject: [PATCH 6.6.y 1/4] mm: drop the assumption that VM_SHARED always
 implies writable
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andy Lutomirski <luto@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lstoakes@gmail.com>

[ Upstream commit e8e17ee90eaf650c855adb0a3e5e965fd6692ff1 ]

Patch series "permit write-sealed memfd read-only shared mappings", v4.

The man page for fcntl() describing memfd file seals states the following
about F_SEAL_WRITE:-

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

With emphasis on 'writable'.  In turns out in fact that currently the
kernel simply disallows all new shared memory mappings for a memfd with
F_SEAL_WRITE applied, rendering this documentation inaccurate.

This matters because users are therefore unable to obtain a shared mapping
to a memfd after write sealing altogether, which limits their usefulness.
This was reported in the discussion thread [1] originating from a bug
report [2].

This is a product of both using the struct address_space->i_mmap_writable
atomic counter to determine whether writing may be permitted, and the
kernel adjusting this counter when any VM_SHARED mapping is performed and
more generally implicitly assuming VM_SHARED implies writable.

It seems sensible that we should only update this mapping if VM_MAYWRITE
is specified, i.e.  whether it is possible that this mapping could at any
point be written to.

If we do so then all we need to do to permit write seals to function as
documented is to clear VM_MAYWRITE when mapping read-only.  It turns out
this functionality already exists for F_SEAL_FUTURE_WRITE - we can
therefore simply adapt this logic to do the same for F_SEAL_WRITE.

We then hit a chicken and egg situation in mmap_region() where the check
for VM_MAYWRITE occurs before we are able to clear this flag.  To work
around this, perform this check after we invoke call_mmap(), with careful
consideration of error paths.

Thanks to Andy Lutomirski for the suggestion!

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

This patch (of 3):

There is a general assumption that VMAs with the VM_SHARED flag set are
writable.  If the VM_MAYWRITE flag is not set, then this is simply not the
case.

Update those checks which affect the struct address_space->i_mmap_writable
field to explicitly test for this by introducing
[vma_]is_shared_maywrite() helper functions.

This remains entirely conservative, as the lack of VM_MAYWRITE guarantees
that the VMA cannot be written to.

Link: https://lkml.kernel.org/r/cover.1697116581.git.lstoakes@gmail.com
Link: https://lkml.kernel.org/r/d978aefefa83ec42d18dfa964ad180dbcde34795.1697116581.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
[isaacmanjarres: resolved merge conflicts due to
due to refactoring that happened in upstream commit
5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")]
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/fs.h |  4 ++--
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      |  2 +-
 mm/filemap.c       |  2 +-
 mm/madvise.c       |  2 +-
 mm/mmap.c          |  8 ++++----
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b641a01512fb..4cdeeaedaa40 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -456,7 +456,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -559,7 +559,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee26e37daa0a..036be4a87e3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -941,6 +941,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 7966c9a1c163..0e20d7e94608 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -739,7 +739,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 			get_file(file);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/mm/filemap.c b/mm/filemap.c
index 05eb77623a10..ab24dbf5e747 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3716,7 +3716,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 9d2a6cb655ff..3d6370d3199f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -987,7 +987,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index a9c70001e456..3ef45bac62e6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -107,7 +107,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -383,7 +383,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -2845,7 +2845,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	mm->map_count++;
 	if (vma->vm_file) {
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2926,7 +2926,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		return -EINVAL;
 
 	/* Map writable and ensure this isn't a sealed memfd. */
-	if (file && (vm_flags & VM_SHARED)) {
+	if (file && is_shared_maywrite(vm_flags)) {
 		int error = mapping_map_writable(file->f_mapping);
 
 		if (error)
-- 
2.50.1.552.g942d659e1b-goog


