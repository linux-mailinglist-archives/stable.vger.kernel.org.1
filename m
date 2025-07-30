Return-Path: <stable+bounces-165161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CFB1572B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A856356074F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F6198E9B;
	Wed, 30 Jul 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHIcsKwp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776E1CD1E1
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840348; cv=none; b=GUe4PagMmFU5DgL7g557lrwWXMeoY7mAhcemuslaMmy+Mjny3uCcJaPUVMurXxBwFkLc1XLIWzyfqqJ6xpRg4364kZGsHb+CaAnOvIb8a3VMpxelMvVs++RAU+rA0nEu9a1MC67aHZ4u4k02rj1bQS8ScYf7l4ReFB9DEJsw6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840348; c=relaxed/simple;
	bh=Sl5ADfTK5NXgHCaSSMe5oFzJY0VRo3N+obuUPt7jvNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyI47ObeF7V85PW+b+x+IkIxA91QyGwVoB24Pm01oSbwNXQ2OWP/cE5HdYfgNP/kN6nkNP9HuwzdPVSvxhSDps1U+hEOKFplizhXSQs7uZVw4zWIMh0HuoIzE5qeblL7nF+Sd9pd6jk9cetvJ0iCsOmhiZGlfb9jqfLUSebj3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHIcsKwp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71a22853b7aso24598497b3.2
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840345; x=1754445145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AA3tqwZAYn4iYWY4gZnS2TnDx/Uhfk7tBeQY06ar3TU=;
        b=CHIcsKwpmGXuTbL9oOw8oPYBNpUQtSxEGVr+HCdFr3FVuiWoPzExQTCSfpWBDYMu9N
         xMxV0nMN05LQmeXJQGY30SFFcVYRxuVtiO4KDF9W8cHMrE49nUYC9kZKfK9VELeyIe06
         OF265stTbCPlL87VbLlKnWlb6Hmjha/NH6LwYZmr8af43LvD37sTIoQDEaoo6HYADPBr
         ENxHjcFw/FBGVc+IBCO3GBhZQbC2s0Onjsf5BXheVHhiXKA7Wb2XpOGY2JrxE5XLSAmS
         IFqyNZu8dJXKpA/Mv+VJ5Go/9zBxj7QUCh0DjrU0GX3PtjC6dupgdFea5uALj+D/XT1O
         HVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840345; x=1754445145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AA3tqwZAYn4iYWY4gZnS2TnDx/Uhfk7tBeQY06ar3TU=;
        b=sQSsmmUyR03xaKWcN2HbfcQjA+AmvhpXYpLG5Y2uWliPh2sApc9U+4KVj/NOI1Refe
         w0o6eQbvJ+JaLtArvi9tJYwosRqiPLqH8T2Gh/mc16pl0bpiVd7q8/oHaHMp8hPh6/Xl
         vrrtXTcqKPSWvvHwjQRy4ePEelml4MwbiWbEInjf+hT9C/Ed0/5Fo2Y0SiGtTF2S4zn1
         kOjnNsajDCwi6buhiDMCyCGBHndM/qx12OhapBaGPaZv77lVTY8Uy9RmmTmq2e7HstrE
         Hd1S/1GPWU5c+NJIBsF3F6mBP3gwDuu5PAZHOoH/spSm2ocL+MyB3e58HGOt4B63vl2U
         iWwA==
X-Forwarded-Encrypted: i=1; AJvYcCVyPSjy2mEmc9V3AakNKlAnWiGdJni+zGZTWVB7lzehHVc3aSfF1qZ2tFueEdkoyPVd8siaXiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7VVk7Q98KQSS7FPq+RokiiSkC+Nif2yQbtP0uiITIjOgAJnA
	AdeBCYDge1hqL6TWp7a8PqhnLEZoCH40il3pBc0VsFey5joD7FDTVHk+1HuWALjf59jW74LnxeW
	OhpiqwuoGA7Q1Tz6D6jKBc3RxS6jUxWiBh+KnWw==
X-Google-Smtp-Source: AGHT+IFN0NxB+ZPpjQbg9OjOCHaSNw5JP5NzhGugQD1VX9N+qSsWv5fy9DdXmUxNKYMeHXMinUiUJAtxrOorcoRQ/t7Mbw==
X-Received: from ybbd9.prod.google.com ([2002:a05:6902:4a89:b0:e8d:e2f3:3cfb])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6304:b0:719:5d76:742 with SMTP id 00721157ae682-71a46521ffcmr33189837b3.2.1753840345590;
 Tue, 29 Jul 2025 18:52:25 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:51:47 -0700
In-Reply-To: <20250730015152.29758-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015152.29758-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015152.29758-4-isaacmanjarres@google.com>
Subject: [PATCH 6.6.y 3/4] mm: reinstate ability to map write-sealed memfd
 mappings read-only
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Julian Orth <ju.orth@gmail.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 8ec396d05d1b737c87311fb7311f753b02c2a6b1 ]

Patch series "mm: reinstate ability to map write-sealed memfd mappings
read-only".

In commit 158978945f31 ("mm: perform the mapping_map_writable() check
after call_mmap()") (and preceding changes in the same series) it became
possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

This series reworks how we both permit write-sealed mappings being mapped
read-only and disallow mprotect() from undoing the write-seal, fixing this
regression.

We also add a regression test to ensure that we do not accidentally
regress this in future.

Thanks to Julian Orth for reporting this regression.

This patch (of 2):

In commit 158978945f31 ("mm: perform the mapping_map_writable() check
after call_mmap()") (and preceding changes in the same series) it became
possible to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

This was previously unnecessarily disallowed, despite the man page
documentation indicating that it would be, thereby limiting the usefulness
of F_SEAL_WRITE logic.

We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
seal (one which disallows future writes to the memfd) to also be used for
F_SEAL_WRITE.

For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
read-only mapping to disallow mprotect() from overriding the seal - an
operation performed by seal_check_write(), invoked from shmem_mmap(), the
f_op->mmap() hook used by shmem mappings.

By extending this to F_SEAL_WRITE and critically - checking
mapping_map_writable() to determine if we may map the memfd AFTER we
invoke shmem_mmap() - the desired logic becomes possible.  This is because
mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
have cleared.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

We reinstate this functionality by moving the check out of shmem_mmap()
and instead performing it in do_mmap() at the point at which VMA flags are
being determined, which seems in any case to be a more appropriate place
in which to make this determination.

In order to achieve this we rework memfd seal logic to allow us access to
this information using existing logic and eliminate the clearing of
VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
instead.

Link: https://lkml.kernel.org/r/99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com
Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/memfd.h | 14 +++++++++++
 include/linux/mm.h    | 58 +++++++++++++++++++++++++++++--------------
 mm/memfd.c            |  2 +-
 mm/mmap.c             |  4 +++
 4 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index e7abf6fa4c52..40cc726a8a0c 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -6,11 +6,25 @@
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
+unsigned int *memfd_file_seals_ptr(struct file *file);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
 	return -EINVAL;
 }
+
+static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+{
+	return NULL;
+}
 #endif
 
+/* Retrieve memfd seals associated with the file, if any. */
+static inline unsigned int memfd_file_seals(struct file *file)
+{
+	unsigned int *sealsp = memfd_file_seals_ptr(file);
+
+	return sealsp ? *sealsp : 0;
+}
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 05b970a6cd28..b97d8a691b28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4022,6 +4022,37 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif
 
+static inline bool is_write_sealed(int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+/**
+ * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
+ *                      in which case writes should be disallowing moving
+ *                      forwards.
+ * @seals: the seals to check
+ * @vm_flags: the VMA flags to check
+ *
+ * Returns whether readonly sealed, in which case writess should be disallowed
+ * going forward.
+ */
+static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
+{
+	/*
+	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
+	 * MAP_SHARED and read-only, take care to not allow mprotect to
+	 * revert protections on such mappings. Do this only for shared
+	 * mappings. For private mappings, don't need to mask
+	 * VM_MAYWRITE as we still want them to be COW-writable.
+	 */
+	if (is_write_sealed(seals) &&
+	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
+		return true;
+
+	return false;
+}
+
 /**
  * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
  *                    handle them.
@@ -4033,24 +4064,15 @@ static inline void mem_dump_obj(void *object) {}
  */
 static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
-		/*
-		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * write seals are active.
-		 */
-		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-			return -EPERM;
-
-		/*
-		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
-		 * MAP_SHARED and read-only, take care to not allow mprotect to
-		 * revert protections on such mappings. Do this only for shared
-		 * mappings. For private mappings, don't need to mask
-		 * VM_MAYWRITE as we still want them to be COW-writable.
-		 */
-		if (vma->vm_flags & VM_SHARED)
-			vm_flags_clear(vma, VM_MAYWRITE);
-	}
+	if (!is_write_sealed(seals))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
+		return -EPERM;
 
 	return 0;
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index 2dba2cb6f0d0..187265dc68f5 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -134,7 +134,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	return error;
 }
 
-static unsigned int *memfd_file_seals_ptr(struct file *file)
+unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3ef45bac62e6..8cf23a07ae50 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,7 @@
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1285,6 +1286,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 
 	if (file) {
 		struct inode *inode = file_inode(file);
+		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
@@ -1323,6 +1325,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
+			else if (is_readonly_sealed(seals, vm_flags))
+				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
-- 
2.50.1.552.g942d659e1b-goog


