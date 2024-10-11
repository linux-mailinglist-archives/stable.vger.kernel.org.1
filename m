Return-Path: <stable+bounces-83477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597C99A851
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AB8282676
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCB198A1A;
	Fri, 11 Oct 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocQdl8Ww"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9E197A9E
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661878; cv=none; b=A9p736wBDmwHFLriGQdKvQjG4W4PIKyo3mNnAmDHPMJ3vhq2KmzNWuQO92wvszGO+v3dEL/09WoaQx9LQGE2eKAPabA6ouHSRb4K07sbPTc2+p2KP4TEEHqY1k+zbOG7D6a744HAhNzypyRSIanYTdbMlFF7v5kO1BCG7meNv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661878; c=relaxed/simple;
	bh=HUif9feDehDnmA4OSsbtnTJKJixKUTKSxisX6qbYo20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eSqJVUgjFVnnkP7JrRPH0gofmb3MoIG2PBkgzw/i3wypPdSUkDGQ+Xg2QuaxXmnBF/yJoXuo1U2horXgFf5wexdZKht9v74kOdmvKppFgZI0619qz+vu7zU4M0jnAVE3HIBtD/vH2V+MO2GgQ+lz8mW1CtVWbeLRgEbP9Y43ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocQdl8Ww; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539c10ea8adso17015e87.1
        for <stable@vger.kernel.org>; Fri, 11 Oct 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728661874; x=1729266674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YRE8/CzNlPy/fMHd19CbAQn1zdYlnyMbeoTyUUS2vk=;
        b=ocQdl8WwaJw1VZTcuDrhEOzAY67vBsuP09SGImObwyd89OzVq+rWnityFfYta+kMOn
         Re9D5Qw5CMaCkBGv9cjSdZcNOYzAPSeGS97MSws8G+5E3DplSWsoL4LUVgHLxAmyDUXE
         h6+Y0eM8mNHWES9wjBxW7JB9+iVzomcFFsGcan1Nk/U75j53H/KPsoJaGyJ6CnKqw+si
         hfT8PyOpS0nfhRNHdl41W/tUyISC2OW/vJBx72hPVTO/OxqViL6ZSHdRMaRi1DPeTZUc
         yuK8Fot6knmQ5+yPpJEMuujKlpEHBAriaSDirD85ZS0cQxxFcYFRkOFl300St+bG3o1y
         qBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661874; x=1729266674;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YRE8/CzNlPy/fMHd19CbAQn1zdYlnyMbeoTyUUS2vk=;
        b=MN3EPRfWbWslRykj9n2SD+9SYogFD5MAw6woxXyFqU2M85LiCnJ/g/opWZBwRb3ZPL
         ZVgaquJFh3wk3ZLJfJRYlHUvyBsm7DUpg3KjOwKO01bcDci6udKyt8f8/YpxkZoYkiQD
         0zPtfssMAxBq/HgJtmzpCt2j2TK3SoI5QyuE/qm6vTNQGo6KXL0yE7PWEn0se+2UU+Qs
         +l3UIBaa24SxnxT0kTGXB6ggR7y0vJZkxFJtdymBpLCiPQSvtMTjY4NTB3Flh+WAFBzM
         NL3Fvx78XmhttbGA9lHg5eRgP2yZxp69K4Lb20u6oKCXuZXEOOBx8ca1EZc98mIJWO0Q
         6lPA==
X-Forwarded-Encrypted: i=1; AJvYcCXbaP0WTDjM10Hjwjluhi1f35zjewLuYGUALD7Amy7JMl/kiWhNfvjP1GdEzN5cETLG3m0ZdDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydClvGSwxOFJhSjaUItBQJc9aXSHyipAK8FiE/AJA8kuQL3fZs
	WsPeQgPSKeb7LYEa5/AETAsRMbPVsRVYvU8Kq2/R0FJUFSh+tzh5VEM/8dqUSQ==
X-Google-Smtp-Source: AGHT+IHbRO/TNFy7alHZxLobfYm/Oko0TRXn7KWSllCdtpS6OjkyKtxH3+hpEOvuWxvc/O2hrXqvBg==
X-Received: by 2002:a05:6512:3e12:b0:538:9e44:3034 with SMTP id 2adb3069b0e04-539d6937c6cmr273779e87.6.1728661873505;
        Fri, 11 Oct 2024 08:51:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:b0bd:4045:f14c:aaf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9b4sm4248242f8f.86.2024.10.11.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:51:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Oct 2024 17:50:54 +0200
Subject: [PATCH RFC v2] mm: Enforce the stack gap when changing
 inaccessible VMAs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-stack-gap-inaccessible-v2-1-111b6a0ee2cb@google.com>
X-B4-Tracking: v=1; b=H4sIAF1JCWcC/4WNQQqDMBBFryKzboqTBoxdFQo9QLfFRUzGOFSNJ
 CIt4t0bvECX73/++xskikwJrsUGkVZOHKYM8lSA7c3kSbDLDLKUCstSi7QY+xbezIInYy2lxO1
 AwlYXrLvKqRZbyOM5UsefQ/yC5+MOTQ57TkuI3+NsxaP6511RoNBKO+V0jZ3Emw/BD3S2YYRm3
 /cft9gtJ8IAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Michal Hocko <mhocko@kernel.org>, Helge Deller <deller@gmx.de>, 
 Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, 
 Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728661866; l=8264;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=HUif9feDehDnmA4OSsbtnTJKJixKUTKSxisX6qbYo20=;
 b=L/KAPOP/fjJFNJQs+u+BvgpI0X/1jnDmAhoZeLII7xgJiUM/TUvNiOJW8hDegFH/+QXqnxHNu
 kasxkG6dsZTA1klbWQwFJoaRQw/4x/A/eKd8bMzIiSaBmMjRuMRsKHV
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

As explained in the comment block this change adds, we can't tell what
userspace's intent is when the stack grows towards an inaccessible VMA.

We should ensure that, as long as code is compiled with something like
-fstack-check, a stack overflow in this code can never cause the main stack
to overflow into adjacent heap memory - so the bottom of a stack should
never be directly adjacent to an accessible VMA.

As suggested by Lorenzo, enforce this by blocking attempts to:

 - make an inaccessible VMA accessible with mprotect() when it is too close
   to a stack
 - replace an inaccessible VMA with another VMA using MAP_FIXED when it is
   too close to a stack


I have a (highly contrived) C testcase for 32-bit x86 userspace with glibc
that mixes malloc(), pthread creation, and recursion in just the right way
such that the main stack overflows into malloc() arena memory, see the
linked list post.

I don't know of any specific scenario where this is actually exploitable,
but it seems like it could be a security problem for sufficiently unlucky
userspace.

Link: https://lore.kernel.org/r/CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com/
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED holes in the stack")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
This is an attempt at the alternate fix approach suggested by Lorenzo.

This turned into more code than I would prefer to have for a scenario
like this...

Also, the way the gap is enforced in my patch for MAP_FIXED_NOREPLACE is
a bit ugly. In the existing code, __get_unmapped_area() normally already
enforces the stack gap even when it is called with a hint; but when
MAP_FIXED_NOREPLACE is used, we kinda lie to __get_unmapped_area() and
tell it we'll do a MAP_FIXED mapping (introduced in commit
a4ff8e8620d3f when MAP_FIXED_NOREPLACE was created), then afterwards
manually reject overlapping mappings.
So I ended up also doing the gap check separately for
MAP_FIXED_NOREPLACE.

The following test program exercises scenarios that could lead to the
stack becoming directly adjacent to another accessible VMA,
and passes with this patch applied:
<<<

int main(void) {
  setbuf(stdout, NULL);

  char *ptr = (char*)(  (unsigned long)(STACK_POINTER() - (1024*1024*4)/*4MiB*/) & ~0xfffUL  );
  if (mmap(ptr, 0x1000, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) != ptr)
    err(1, "mmap distant-from-stack");
  *(volatile char *)(ptr + 0x1000); /* expand stack */
  system("echo;cat /proc/$PPID/maps;echo");

  /* test transforming PROT_NONE mapping adjacent to stack */
  if (mprotect(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC) == 0)
    errx(1, "mprotect adjacent to stack allowed");
  if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED, -1, 0) != MAP_FAILED)
    errx(1, "MAP_FIXED adjacent to stack allowed");

  if (munmap(ptr, 0x1000))
    err(1, "munmap failed???");

  /* test creating new mapping adjacent to stack */
  if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0) != MAP_FAILED)
    errx(1, "MAP_FIXED_NOREPLACE adjacent to stack allowed");
  if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) == ptr)
    errx(1, "mmap hint adjacent to stack accepted");

  printf("all tests passed\n");
}
>>>
---
Changes in v2:
- Entirely new approach (suggested by Lorenzo)
- Link to v1: https://lore.kernel.org/r/20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com
---
 include/linux/mm.h |  1 +
 mm/mmap.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c      |  6 +++++
 3 files changed, 72 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..ecd4afc304ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3520,6 +3520,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
 		unsigned long addr);
+bool overlaps_stack_gap(struct mm_struct *mm, unsigned long addr, unsigned long len);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..937361be3c48 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -359,6 +359,20 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			return -EEXIST;
 	}
 
+	/*
+	 * This does two things:
+	 *
+	 * 1. Disallow MAP_FIXED replacing a PROT_NONE VMA adjacent to a stack
+	 * with an accessible VMA.
+	 * 2. Disallow MAP_FIXED_NOREPLACE creating a new accessible VMA
+	 * adjacent to a stack.
+	 */
+	if ((flags & (MAP_FIXED_NOREPLACE | MAP_FIXED)) &&
+	    (prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
+	    !(vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
+	    overlaps_stack_gap(mm, addr, len))
+		return (flags & MAP_FIXED) ? -ENOMEM : -EEXIST;
+
 	if (flags & MAP_LOCKED)
 		if (!can_do_mlock())
 			return -EPERM;
@@ -1341,6 +1355,57 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
+/*
+ * Does the specified VA range overlap the stack gap of a preceding or following
+ * stack VMA?
+ * Overlapping stack VMAs are ignored - so if someone deliberately creates a
+ * MAP_FIXED mapping in the middle of a stack or such, we let that go through.
+ *
+ * This is needed partly because userspace's intent when making PROT_NONE
+ * mappings is unclear; there are two different reasons for creating PROT_NONE
+ * mappings:
+ *
+ * A) Userspace wants to create its own guard mapping, for example for stacks.
+ * According to
+ * <https://lore.kernel.org/all/1499126133.2707.20.camel@decadent.org.uk/T/>,
+ * some Rust/Java programs do this with the main stack.
+ * Enforcing the kernel's stack gap between these userspace guard mappings and
+ * the main stack breaks stuff.
+ *
+ * B) Userspace wants to reserve some virtual address space for later mappings.
+ * This is done by memory allocators.
+ * In this case, we want to enforce a stack gap between the mapping and the
+ * stack.
+ *
+ * Because we can't tell these cases apart when a PROT_NONE mapping is created,
+ * we instead enforce the stack gap when a PROT_NONE mapping is made accessible
+ * (using mprotect()) or replaced with an accessible one (using MAP_FIXED).
+ */
+bool overlaps_stack_gap(struct mm_struct *mm, unsigned long addr, unsigned long len)
+{
+
+	struct vm_area_struct *vma, *prev_vma;
+
+	/* step 1: search for a non-overlapping following stack VMA */
+	vma = find_vma(mm, addr+len);
+	if (vma && vma->vm_start >= addr+len) {
+		/* is it too close? */
+		if (vma->vm_start - (addr+len) < stack_guard_start_gap(vma))
+			return true;
+	}
+
+	/* step 2: search for a non-overlapping preceding stack VMA */
+	if (!IS_ENABLED(CONFIG_STACK_GROWSUP))
+		return false;
+	vma = find_vma_prev(mm, addr, &prev_vma);
+	/* don't handle cases where the VA start overlaps a VMA */
+	if (vma && vma->vm_start < addr)
+		return false;
+	if (!prev_vma || !(prev_vma->vm_flags & VM_GROWSUP))
+		return false;
+	return addr - prev_vma->vm_end < stack_guard_gap;
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..2300e2eff956 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -772,6 +772,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	error = -ENOMEM;
+	if ((prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
+	    !(vma->vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
+	    overlaps_stack_gap(current->mm, start, end - start))
+		goto out;
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241008-stack-gap-inaccessible-c7319f7d4b1b
-- 
Jann Horn <jannh@google.com>


