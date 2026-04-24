Return-Path: <stable+bounces-241049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKw4Nwzd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBE4636D8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50469301C94F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0782DD60E;
	Fri, 24 Apr 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWzmpjBM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38F341ADD
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065226; cv=none; b=du0Zxhj8ESkCy84NbFkidwlvyGWj+yWyGFFmB/s2eQH4jefUPweEhsMY5zJ6depIChSU0Ymf9IIGL8rnGrFAww109IF8cEvvn0gIC+zLLEk3MIJB+f8D5ZAjrKe9vWf1Isi4Nzwqh7LUYCsKUNSGX9gWSHQxhj7sm3I/U7iTCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065226; c=relaxed/simple;
	bh=tYa2797NsxdXzWg+SL51O8N3knaKFDvTYlXeYtdV9CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spW4fuQlaWKsE4ToovZfyaPPtt0Tq5+1t0ATUT5HD1/mS/P3ybC2Uw7ZTOcQeJjNBLjc/nyjf5gMkAs/uk29xvS1tR2nokd9SFk0vs3onnQHIWtIrdbzX3G6QHdAT9NlplRJyCYnz2iPojW5WaI5Mf7hkCylhN6EiVIdfsDhba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWzmpjBM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b0786beso54326185e9.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065223; x=1777670023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BLQZOnf6TjLPQYnkDewvD/+2jIL5XRBDQmwK8f4mkk=;
        b=lWzmpjBM++wM13kM7w6gm3L/99ZbUx6QrpXSVwqTFCs82Zc1lErqZqodrg4Gvqe1cO
         ybJB8FLnwTL6LO0hBTZansk2IlbpQU31rRDmXFh2WbTmS+2SZ+C240A5CurDGDCbXpYb
         87qvRrGoC0EL0I/bvhqgOw1CSgr6kVnvrWiuoNvtcxVT+yaYf+Sgx2/WpaLOjLUqD2Xq
         Eks9m/8YOeXLyAlnzGxAq7lvnDbnrDTpcH16pkUny3279XrABSlhibKsSu1aH+hnnxnV
         0sY91OLM/bBSVFz8si/zEnimx9MJEB/gie2jzbzTWt3uGto6KeNRkKBlKx628WbLcpKB
         uVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065223; x=1777670023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BLQZOnf6TjLPQYnkDewvD/+2jIL5XRBDQmwK8f4mkk=;
        b=msi487GU4TfeGuF/CnMIcX7JIvqzMX7gkDshyGwRRNGle3SOgAo6eueAlQKVVe9iNb
         HFobX0Nfyg1VO+DFq6xRihHUOt4iAdjjwNdy6HqYFC9m0lftbg5J1UJEO4aKENf/pBR7
         JSWLt5xDT9U9t0Q6lQHNfFbHqUEwL+gw5FP+bcHsJvZnyIzwABl+undYj88k1TDFWlZR
         f02sb3BxR/5oFvNKGskA6f24FwQnajmnf1YfER6vIH3yJCvvjEZmZ4xddMYBtAjEbgZ/
         4blbjRVThAnbNBeHVu7FtIANxL/mxC0qLpa31qprENvdOPVVSFOJYIio6rmXarx8RoDX
         VN6g==
X-Gm-Message-State: AOJu0Yz2CItle+5i3uMWgf2L13D9xts53ng/J5WuL8QJLRxu6bYpzkiq
	e2aavti9/xM0bn2lM2+ikRyhzUkeXfO5hZ2RQzEyGdoQeqNH/IRwalGKHlakKSU7
X-Gm-Gg: AeBDieu15zEOhtpLNDOuncO+CaQNZcVDpTVLN6AOO9s+6od1MmLdM6h5vWCm3l899ce
	JzFXKfAmL7ZMIvIDQtA7e71y5Vrj9baTPUo/7As8ektjOdex5dPL4qq+FVoBpb+dsB5rjZFTc+l
	XFzMJh0y5lw5Kvq7UP6oyHuLv1Gh8FKwxfqbfZxYL6Qo5oTgegKNpE1oE9MT2ra6xu088nM3TWS
	frxEuUCf5xxld0tlal3oYondcszkzdCLwKBwx4qOj2uf8ZlXuXoVa18rmAE5qtHNFbVhp0RFK5g
	eKIeo9kAUi9x9fPbKHKiX4rksDuY3RXuzl9e7c9uffPNPniaZy//Sbpmtv8HVU53GEIng64mnEy
	AdY377M8Vv4OA04v97Gc0q+6eWUAoWeyl+rqRRAdQAQLtPJp/5q+tIj1ugQ1jfmDst6tZ2SSm58
	aWrm7Z7en0+PpoyaegnnMyOvJsKRI2nA==
X-Received: by 2002:a05:600d:16:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48919e9b29fmr261690915e9.1.1777065222564;
        Fri, 24 Apr 2026 14:13:42 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:42 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	Pedro Falcato <pfalcato@suse.de>,
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
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v1 4/9] mm: implement sticky VMA flags
Date: Sat, 25 Apr 2026 00:12:38 +0300
Message-ID: <20260424211315.1072123-5-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: 56DBE4636D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.de,suse.cz,linux.alibaba.com,kernel.org,arm.com,google.com,lwn.net,linux.dev,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-241049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

It is useful to be able to designate that certain flags are 'sticky', that
is, if two VMAs are merged one with a flag of this nature and one without,
the merged VMA sets this flag.

As a result we ignore these flags for the purposes of determining VMA flag
differences between VMAs being considered for merge.

This patch therefore updates the VMA merge logic to perform this action,
with flags possessing this property being described in the VM_STICKY
bitmap.

Those flags which ought to be ignored for the purposes of VMA merge are
described in the VM_IGNORE_MERGE bitmap, which the VMA merge logic is also
updated to use.

As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
already had this behaviour, alongside VM_STICKY as sticky flags by
implication must not disallow merge.

Ultimately it seems that we should make VM_SOFTDIRTY a sticky flag in its
own right, but this change is out of scope for this series.

The only sticky flag designated as such is VM_MAYBE_GUARD, so as a result
of this change, once the VMA flag is set upon guard region installation,
VMAs with guard ranges will now not have their merge behaviour impacted as
a result and can be freely merged with other VMAs without VM_MAYBE_GUARD
set.

Also update the comments for vma_modify_flags() to directly reference
sticky flags now we have established the concept.

We also update the VMA userland tests to account for the changes.

Link: https://lkml.kernel.org/r/22ad5269f7669d62afb42ce0c79bad70b994c58d.1763460113.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
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
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 64212ba02e66e705cabce188453ba4e61e9d7325)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 include/linux/mm.h               | 28 ++++++++++++++++++++++++++++
 mm/vma.c                         | 31 +++++++++++++++++--------------
 mm/vma.h                         | 10 ++++------
 tools/testing/vma/vma_internal.h | 28 ++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a96c99066351..ebc5fb0af5ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -510,6 +510,34 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/vma.c b/mm/vma.c
index 06609f4116b4..b194ea8cb283 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -82,15 +82,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -810,6 +802,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
+	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -904,11 +897,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
+		sticky_flags |= (next->vm_flags & VM_STICKY);
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
+		sticky_flags |= (prev->vm_flags & VM_STICKY);
 	}
 
 	if (merge_both) {
@@ -978,6 +973,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1156,14 +1152,20 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
 	int ret = 0;
+	vm_flags_t sticky_flags;
+
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
 
-	if (next && target != next && vmg->end == next->vm_end)
+	if (next && target != next && vmg->end == next->vm_end) {
+		sticky_flags |= next->vm_flags & VM_STICKY;
 		remove_next = true;
+	}
 
 	/* We must have a target. */
 	VM_WARN_ON_VMG(!target, vmg);
@@ -1197,6 +1199,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
+	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1692,9 +1695,9 @@ struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
 		return ret;
 
 	/*
-	 * For a merge to succeed, the flags must match those requested. For
-	 * flags which do not obey typical merge rules (i.e. do not need to
-	 * match), we must let the caller know about them.
+	 * For a merge to succeed, the flags must match those
+	 * requested. However, sticky flags may have been retained, so propagate
+	 * them to the caller.
 	 */
 	if (vmg.state == VMA_MERGE_SUCCESS)
 		*vm_flags_ptr = ret->vm_flags;
@@ -1959,7 +1962,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 1f2d11bb08b4..4c7ea8b893ab 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -276,17 +276,15 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
  * @start: The start of the range to update. May be offset within @vma.
  * @end: The exclusive end of the range to update, may be offset within @vma.
  * @vm_flags_ptr: A pointer to the VMA flags that the @start to @end range is
- * about to be set to. On merge, this will be updated to include any additional
- * flags which remain in place.
+ * about to be set to. On merge, this will be updated to include sticky flags.
  *
  * IMPORTANT: The actual modification being requested here is NOT applied,
  * rather the VMA is perhaps split, perhaps merged to accommodate the change,
  * and the caller is expected to perform the actual modification.
  *
- * In order to account for VMA flags which may persist (e.g. soft-dirty), the
- * @vm_flags_ptr parameter points to the requested flags which are then updated
- * so the caller, should they overwrite any existing flags, correctly retains
- * these.
+ * In order to account for sticky VMA flags, the @vm_flags_ptr parameter points
+ * to the requested flags which are then updated so the caller, should they
+ * overwrite any existing flags, correctly retains these.
  *
  * Returns: A VMA which contains the range @start to @end ready to have its
  * flags altered to *@vm_flags.
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c87bcc9013f5..19914c28977e 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -117,6 +117,34 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_SEALED	VM_NONE
 #endif
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.53.0


