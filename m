Return-Path: <stable+bounces-241046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AApPOBDd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E604636E5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B07F430179CF
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525433D4EC;
	Fri, 24 Apr 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baxLFGKX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A51194C96
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065213; cv=none; b=aIQSASr2bnt5VrXFJsAyJZT8sv9C8T2GayL6s7tdZeP9IZbSD1/a3EO04TCIanYg2pAhjK/5Hj12glVTkpsrdQsUfbiKOcCkTk2/QhDrV0l0GNDcNOt61Z6bXlpJlGVSZ4GwfjozEg8eUOA9GhYQFlQ8NVgaMjqYG1k6OecDmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065213; c=relaxed/simple;
	bh=Hu4RDEthOUPh9S7rklzA2uBWLBmGjizWYoHpaYBBp2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+Vr0lQyVxra7t3l8qXbzqhIQ+kjB2Rj6M3FjGZ0FeiO+nti58dxhp/YWeMJVnY42aaTLwzplMuoE3rtCZzTFZuqz1ZVVWxROGufFdj4D3x8fAc9mhYqvJFNr4gkIf0l+sKCCGIpPVCSIIrR6NVOigDC6aFrVrgx9xAOIpToSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baxLFGKX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d75312379so5936598f8f.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065210; x=1777670010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZjzCUUsesNLmJFuXuHKf9RuHQuQN+tzG8EJowoiGQk=;
        b=baxLFGKXtHG9FhaTrU+NoywIZkwkL9tz0HuFdjKKr7fXMiTtFhuMVlDWE6t1cecaTH
         tBZV9BwtweRpVfzu5bAAeI8hg5RgEzK7JH7Cg2yuMB7zqevGWZtLOY2YOMfX/gXJBH0F
         JTxYIvdy2qLWw/eLpV231BLXiTxFS8NEgPAQLk02ae6QVauGm+6MMoKNbnaf+iOMfBcc
         jqVqOdogY6BsVAp2xPPlNFh9qJgTF51TX95ywVt3ha9bFeUQfV0v63ilRu/gZ5/Q3Lsu
         6jwCsgeq+UQSUUlj2BEKXMhecFuXUf3QsqWNtKGzWluImv5+DYi134l8rkCw2HeOJ1AS
         +ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065210; x=1777670010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZjzCUUsesNLmJFuXuHKf9RuHQuQN+tzG8EJowoiGQk=;
        b=mwHG2MyJ2iHA2H3nQxMrVtUK6aD1r1ESDkwa3enR7vlIp8nWsKS1tQcfdpJ6GC6/Jo
         NSUQ4Z173d9X9LaaxftnrHxYc9CtG+oDeKWmfJsy+p+gt+BM6GuxDHrizexpnCLvia12
         aeYrMc2tmmJDt9wL7ywbm+RPvEF2q2QXhuPHiR/J0oLGJbE+jq6hE6NWfvznx8UxnL3j
         IztUajDl8HlfBa8ZuNjwccnmal9rKFEeP+SJ7jk32ClsT1BHzgogQH2UxP+OEnyfEpnx
         DrwONaH84fpq9Q1D9P8V9mGdmn11J7JWW6gaNmT/Ad+ME0HhFF2+ddF90rz6L909ArTa
         GOzQ==
X-Gm-Message-State: AOJu0YxDD9aIxtgdCczCcZmoPMqOltOGqHy7le87F+1TC7vHZ6hZk3rZ
	01zatTDKkPaV/HJBBKADF9WfvlY+RafrFofoMTIwIXBkAbJY1doo0vqN1qWI9yfF
X-Gm-Gg: AeBDiesWIwbfnTfNqvW7WnexEWofyv0zAoxkf2/mi0YiczRmvaz7q5BxJ8xsf+97mHc
	ex31QFUtyOlKZtL19vcrq4NlDJEN8eapsiDXJeP2WerVlKih9N8VtxfwrjSenzds/CE4bQF/ahV
	75TTr3cnElHFGtylCa1a09PAjVgIoZk6/O6s2fKDW159Gzn4LJpg/eFCZkfYv1WvZwFOPUhBbXH
	4GiMo2dQHrH8l6NzBDX2ymj+YGirC0n/yq7KzggVXCKfbJ1TYvGXwEp6bzt7CkPpcRZ9uH/crRv
	DrAkE9EiL6/2kAds4UpkMC3VTA+EuWDSffIn/s+5tR6ALnJWirrPc83KSw1r93k4Nv9J+EDHHMJ
	pKuIZoYV80gL2g6fTXuqvc8ag1XnxpZ/YOKa8FWoDqiFpW1JT+Z7pPAKcNOONAhZHBlM2ENspzN
	Hg5sjYeWe49RZ3JYQINShKWI4V68TROQ==
X-Received: by 2002:a05:6000:2d8a:b0:439:adc3:f0e7 with SMTP id ffacd0b85a97d-43fe4043f54mr33365742f8f.9.1777065209838;
        Fri, 24 Apr 2026 14:13:29 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:29 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v1 1/9] mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
Date: Sat, 25 Apr 2026 00:12:35 +0300
Message-ID: <20260424211315.1072123-2-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424211315.1072123-1-elaidya225@gmail.com>
References: <20260424211315.1072123-1-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49E604636E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUBJECT_HAS_CURRENCY(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241046-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.de,suse.cz,kernel.org,linux.dev,linux.alibaba.com,arm.com,google.com,lwn.net,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Patch series "introduce VM_MAYBE_GUARD and make it sticky", v4.

Currently, guard regions are not visible to users except through
/proc/$pid/pagemap, with no explicit visibility at the VMA level.

This makes the feature less useful, as it isn't entirely apparent which
VMAs may have these entries present, especially when performing actions
which walk through memory regions such as those performed by CRIU.

This series addresses this issue by introducing the VM_MAYBE_GUARD flag
which fulfils this role, updating the smaps logic to display an entry for
these.

The semantics of this flag are that a guard region MAY be present if set
(we cannot be sure, as we can't efficiently track whether an
MADV_GUARD_REMOVE finally removes all the guard regions in a VMA) - but if
not set the VMA definitely does NOT have any guard regions present.

It's problematic to establish this flag without further action, because
that means that VMAs with guard regions in them become non-mergeable with
adjacent VMAs for no especially good reason.

To work around this, this series also introduces the concept of 'sticky'
VMA flags - that is flags which:

a. if set in one VMA and not in another still permit those VMAs to be
   merged (if otherwise compatible).

b. When they are merged, the resultant VMA must have the flag set.

The VMA logic is updated to propagate these flags correctly.

Additionally, VM_MAYBE_GUARD being an explicit VMA flag allows us to solve
an issue with file-backed guard regions - previously these established an
anon_vma object for file-backed mappings solely to have vma_needs_copy()
correctly propagate guard region mappings to child processes.

We introduce a new flag alias VM_COPY_ON_FORK (which currently only
specifies VM_MAYBE_GUARD) and update vma_needs_copy() to check explicitly
for this flag and to copy page tables if it is present, which resolves
this issue.

Additionally, we add the ability for allow-listed VMA flags to be
atomically writable with only mmap/VMA read locks held.

The only flag we allow so far is VM_MAYBE_GUARD, which we carefully ensure
does not cause any races by being allowed to do so.

This allows us to maintain guard region installation as a read-locked
operation and not endure the overhead of obtaining a write lock here.

Finally we introduce extensive VMA userland tests to assert that the
sticky VMA logic behaves correctly as well as guard region self tests to
assert that smaps visibility is correctly implemented.

This patch (of 9):

Currently, if a user needs to determine if guard regions are present in a
range, they have to scan all VMAs (or have knowledge of which ones might
have guard regions).

Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
pagemap") and the related commit a516403787e0 ("fs/proc: extend the
PAGEMAP_SCAN ioctl to report guard regions"), users can use either
/proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
operation at a virtual address level.

This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
that guard regions exist in ranges.

This patch remedies the situation by establishing a new VMA flag,
VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
uncertain because we cannot reasonably determine whether a
MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
additionally VMAs may change across merge/split).

We utilise 0x800 for this flag which makes it available to 32-bit
architectures also, a flag that was previously used by VM_DENYWRITE, which
was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
bee reused yet.

We also update the smaps logic and documentation to identify these VMAs.

Another major use of this functionality is that we can use it to identify
that we ought to copy page tables on fork.

We do not actually implement usage of this flag in mm/madvise.c yet as we
need to allow some VMA flags to be applied atomically under mmap/VMA read
lock in order to avoid the need to acquire a write lock for this purpose.

Link: https://lkml.kernel.org/r/cover.1763460113.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/cf8ef821eba29b6c5b5e138fffe95d6dcabdedb9.1763460113.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5dba5cc2e0ffa76f2f6c8922a04469dc9602c396)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 Documentation/filesystems/proc.rst | 5 +++--
 fs/proc/task_mmu.c                 | 1 +
 include/linux/mm.h                 | 3 +++
 include/trace/events/mmflags.h     | 1 +
 mm/memory.c                        | 4 ++++
 tools/testing/vma/vma_internal.h   | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 0b86a8022fa1..8256e857e2d7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -553,7 +553,7 @@ otherwise.
 kernel flags associated with the particular virtual memory area in two letter
 encoded manner. The codes are the following:
 
-    ==    =======================================
+    ==    =============================================================
     rd    readable
     wr    writeable
     ex    executable
@@ -591,7 +591,8 @@ encoded manner. The codes are the following:
     sl    sealed
     lf    lock on fault pages
     dp    always lazily freeable mapping
-    ==    =======================================
+    gu    maybe contains guard regions (if not set, definitely doesn't)
+    ==    =============================================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b490245ff9be..4c5adfd4fc1f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1159,6 +1159,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
+		[ilog2(VM_MAYBE_GUARD)]	= "gu",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1e74eb7267ac..f1787efaedc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -269,6 +269,8 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+#define VM_MAYBE_GUARD_BIT 11
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
@@ -294,6 +296,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..a6e5a44c9b42 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
+	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/mm/memory.c b/mm/memory.c
index 94bf107a47ca..dde20cd5fa5b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
+	/* Guard regions have modified page tables that require copying. */
+	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+		return true;
+
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index dc976a285ad2..c87bcc9013f5 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_MAYEXEC	0x00000040
 #define VM_GROWSDOWN	0x00000100
 #define VM_PFNMAP	0x00000400
+#define VM_MAYBE_GUARD	0x00000800
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-- 
2.53.0


