Return-Path: <stable+bounces-241048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB7qMgnd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 472894636D0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D46B4301C978
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8E33D4EC;
	Fri, 24 Apr 2026 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPsK/GS2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E40194C96
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065222; cv=none; b=co2O5uiYSc2+MHPBwNnZasI2rBd4VT0vKGgOn+uQfJZlJGkkcOyF6a6UTeGHsCgsshxnUa0u8YBVHk1HT/f66LaCImJ2SAf50BwfmUYvpg1BfIq0FdOCOJhKqQXrc3JcIcW6IfOxpV5kTtPZYEJ8+KfOYrHBUTUMYIOlnDncjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065222; c=relaxed/simple;
	bh=Ij/QSVnM1IMlySJa6NjMYvIUC1FK3VXbCfDKnzsZz+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr0rcbvgbWaXlJFj0C8KkShrTecRIKB6aNyDszf+sBusolRN3nB68/0LHBY8L1cL+2A75Z2hwpl3hlCIaYGfAZGI3DxRy6LqBnR3aO7OCUDjWtbfWJqEtDCPBZl1JIsiiFAHH1dAtX99/HqBxhWFHuHWwq4OLLn1r+T0fpMsQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPsK/GS2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so42196435e9.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065219; x=1777670019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0958+TQb7qAfxErMIaSt5ikd6IjAeaeyLXm9i3E0xg8=;
        b=ZPsK/GS25zek+qojrcL7ZtwPZWapKS5p6f5/RS9WlIE9dVGhNqFkiWPBUBZep/aB4l
         4hf5h8yN5ppt99lyv6uTXkGKEn0SMJMQNUeMJKGP5aB4EvyJxqyScuzq9KlYXawDbi55
         hYcVYnlskHUXzaGw/aOXk9VVyM5rkguElW3hVoBwki9PiJYPjMMzoX7POWZeP09rmnZ0
         SDJtNa6omEIzttqHs705h7/3z6uJMp/KXtzhYLBCImxskZwdsV56O3L3XRzSyHyPrUNl
         vXMBhn0Vyev1Ti46VeLKGGQcM02+lu7GRe8idjWTwvOZXYIzMVhgM7y00Ha85Q/TGuyS
         QXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065219; x=1777670019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0958+TQb7qAfxErMIaSt5ikd6IjAeaeyLXm9i3E0xg8=;
        b=CtnOEtqo4T5PD0Oz/mjmjO7mOErIpCiDO1ho4+05LdkY9y4s131U3hINTKJXp2iadM
         8skZNWMJmUEbWkStreuAC8lQfEDso9s2sUebcQ/Sde8ZN5eXcSi5XaYnVko6xRIIB1Yu
         G/eyKPAbCzyj1k7hy5Ml55Tcoit1drnunpswxSTAGUUGoE1O5Z11mnGBFkg/kkjObaF5
         5jYXbDU2jxd/ma9dBy9To+yyFUccgSVu3lXhzpMYE6v2+lT8lINZ1JCZ5BFSbxlGWjT7
         E77D/UmPvsY8nJd1N4Ka6vubRPA6OeMkmjjroaUGIWXiluOnoo4d726fkrqBi2iKqDSw
         tBxg==
X-Gm-Message-State: AOJu0Yw7UzFFIWj7vs7lWIyIoc9nPj6jcd9RP7PtLzBQqvfNH7hWq5IP
	Wq8aLvoWyouP9PH5kSmpzCYJAMxCeQHsOdtJD+08yGMUbg1+axVdHc6if6G5Bch+
X-Gm-Gg: AeBDiesSGJp0F3hRwluMGux1SXkdLPdENsWX6tIgqVbKj+I8c+/BsEZoeP3Izf5DA+9
	l3IhfQGLtdFsEYAarNkhMMefr53uyIgS8hAqoPhSHtdZEWbLMVk1C5pmIUT3edy/6nMHwBDa1k1
	E8zyEEPgZr9yjibEkXSkfRv629vXnnGpq4E8G+bC0kNy6tDOibUlxNodGUq6Ow4usNxTGoVxuCM
	cXk3UGqnccWQ+Q2urQXKnsXDnM4YWwGifIrnexPDrcnLwa3gNrism8hf4z8vyZE8Ab3v0fS8pqk
	mTeNvx0k0jxQ5y/ejA0YyIKYZw+eNHiBXi+RWNt41MvDVqWXfuuKBAl4E3/zJOGKLuq86Vw1cRz
	P02+KdkRriO0Wo6vjxTNx5RqO3CydzDg41gfckzfpXXAuNwxXanUqfxm6BD2/ANcaY+I/K/IWCa
	v4uaV5c2ga4ooPP2idh/jonzdoojaEeA==
X-Received: by 2002:a05:600c:2256:b0:489:1927:5c0 with SMTP id 5b1f17b1804b1-48919270787mr252333975e9.0.1777065218866;
        Fri, 24 Apr 2026 14:13:38 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:38 -0700 (PDT)
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
Subject: [PATCH v1 3/9] mm: update vma_modify_flags() to handle residual flags, document
Date: Sat, 25 Apr 2026 00:12:37 +0300
Message-ID: <20260424211315.1072123-4-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: 472894636D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.de,suse.cz,linux.alibaba.com,kernel.org,arm.com,google.com,lwn.net,linux.dev,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-241048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

The vma_modify_*() family of functions each either perform splits, a merge
or no changes at all in preparation for the requested modification to
occur.

When doing so for a VMA flags change, we currently don't account for any
flags which may remain (for instance, VM_SOFTDIRTY) despite the requested
change in the case that a merge succeeded.

This is made more important by subsequent patches which will introduce the
concept of sticky VMA flags which rely on this behaviour.

This patch fixes this by passing the VMA flags parameter as a pointer and
updating it accordingly on merge and updating callers to accommodate for
this.

Additionally, while we are here, we add kdocs for each of the
vma_modify_*() functions, as the fact that the requested modification is
not performed is confusing so it is useful to make this abundantly clear.

We also update the VMA userland tests to account for this change.

Link: https://lkml.kernel.org/r/23b5b549b0eaefb2922625626e58c2a352f3e93c.1763460113.git.lorenzo.stoakes@oracle.com
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
(cherry picked from commit 9119d6c2095bb20292cb9812dd70d37f17e3bd37)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 mm/madvise.c            |   2 +-
 mm/mlock.c              |   2 +-
 mm/mprotect.c           |   2 +-
 mm/mseal.c              |   7 +-
 mm/vma.c                |  56 ++++++++--------
 mm/vma.h                | 140 +++++++++++++++++++++++++++++-----------
 tools/testing/vma/vma.c |   3 +-
 7 files changed, 143 insertions(+), 69 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..0b3280752bfb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -167,7 +167,7 @@ static int madvise_update_vma(vm_flags_t new_flags,
 			range->start, range->end, anon_name);
 	else
 		vma = vma_modify_flags(&vmi, madv_behavior->prev, vma,
-			range->start, range->end, new_flags);
+			range->start, range->end, &new_flags);
 
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
diff --git a/mm/mlock.c b/mm/mlock.c
index bb0776f5ef7c..2f699c3497a5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -478,7 +478,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	vma = vma_modify_flags(vmi, *prev, vma, start, end, &newflags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 988c366137d5..fa818cd58201 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -813,7 +813,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		newflags &= ~VM_ACCOUNT;
 	}
 
-	vma = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
+	vma = vma_modify_flags(vmi, *pprev, vma, start, end, &newflags);
 	if (IS_ERR(vma)) {
 		error = PTR_ERR(vma);
 		goto fail;
diff --git a/mm/mseal.c b/mm/mseal.c
index c561f0ea93e8..3d2f06046e90 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -69,9 +69,10 @@ static int mseal_apply(struct mm_struct *mm,
 		const unsigned long curr_end = MIN(vma->vm_end, end);
 
 		if (!(vma->vm_flags & VM_SEALED)) {
-			vma = vma_modify_flags(&vmi, prev, vma,
-					curr_start, curr_end,
-					vma->vm_flags | VM_SEALED);
+			vm_flags_t vm_flags = vma->vm_flags | VM_SEALED;
+
+			vma = vma_modify_flags(&vmi, prev, vma, curr_start,
+					       curr_end, &vm_flags);
 			if (IS_ERR(vma))
 				return PTR_ERR(vma);
 			vm_flags_set(vma, VM_SEALED);
diff --git a/mm/vma.c b/mm/vma.c
index 5815ae9e5770..06609f4116b4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1676,25 +1676,35 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	return vma;
 }
 
-struct vm_area_struct *vma_modify_flags(
-	struct vma_iterator *vmi, struct vm_area_struct *prev,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	vm_flags_t vm_flags)
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		vm_flags_t *vm_flags_ptr)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+	const vm_flags_t vm_flags = *vm_flags_ptr;
+	struct vm_area_struct *ret;
 
 	vmg.vm_flags = vm_flags;
 
-	return vma_modify(&vmg);
+	ret = vma_modify(&vmg);
+	if (IS_ERR(ret))
+		return ret;
+
+	/*
+	 * For a merge to succeed, the flags must match those requested. For
+	 * flags which do not obey typical merge rules (i.e. do not need to
+	 * match), we must let the caller know about them.
+	 */
+	if (vmg.state == VMA_MERGE_SUCCESS)
+		*vm_flags_ptr = ret->vm_flags;
+	return ret;
 }
 
-struct vm_area_struct
-*vma_modify_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       struct anon_vma_name *new_name)
+struct vm_area_struct *vma_modify_name(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct anon_vma_name *new_name)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
@@ -1703,12 +1713,10 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
+struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct mempolicy *new_pol)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
@@ -1717,14 +1725,10 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       vm_flags_t vm_flags,
-		       struct vm_userfaultfd_ctx new_ctx,
-		       bool give_up_on_oom)
+struct vm_area_struct *vma_modify_flags_uffd(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, vm_flags_t vm_flags,
+		struct vm_userfaultfd_ctx new_ctx, bool give_up_on_oom)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
diff --git a/mm/vma.h b/mm/vma.h
index d73e1b324bfd..1f2d11bb08b4 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -266,47 +266,115 @@ void remove_vma(struct vm_area_struct *vma);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/* We are about to modify the VMA's flags. */
-__must_check struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
+/**
+ * vma_modify_flags() - Peform any necessary split/merge in preparation for
+ * setting VMA flags to *@vm_flags in the range @start to @end contained within
+ * @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @vm_flags_ptr: A pointer to the VMA flags that the @start to @end range is
+ * about to be set to. On merge, this will be updated to include any additional
+ * flags which remain in place.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * In order to account for VMA flags which may persist (e.g. soft-dirty), the
+ * @vm_flags_ptr parameter points to the requested flags which are then updated
+ * so the caller, should they overwrite any existing flags, correctly retains
+ * these.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * flags altered to *@vm_flags.
+ */
+__must_check struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		vm_flags_t *vm_flags_ptr);
+
+/**
+ * vma_modify_name() - Peform any necessary split/merge in preparation for
+ * setting anonymous VMA name to @new_name in the range @start to @end contained
+ * within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @new_name: The anonymous VMA name that the @start to @end range is about to
+ * be set to.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * anonymous VMA name changed to @new_name.
+ */
+__must_check struct vm_area_struct *vma_modify_name(struct vma_iterator *vmi,
 		struct vm_area_struct *prev, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
-		vm_flags_t vm_flags);
-
-/* We are about to modify the VMA's anon_name. */
-__must_check struct vm_area_struct
-*vma_modify_name(struct vma_iterator *vmi,
-		 struct vm_area_struct *prev,
-		 struct vm_area_struct *vma,
-		 unsigned long start,
-		 unsigned long end,
-		 struct anon_vma_name *new_name);
-
-/* We are about to modify the VMA's memory policy. */
-__must_check struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
+		struct anon_vma_name *new_name);
+
+/**
+ * vma_modify_policy() - Peform any necessary split/merge in preparation for
+ * setting NUMA policy to @new_pol in the range @start to @end contained
+ * within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @new_pol: The NUMA policy that the @start to @end range is about to be set
+ * to.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * NUMA policy changed to @new_pol.
+ */
+__must_check struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev, struct vm_area_struct *vma,
 		   unsigned long start, unsigned long end,
 		   struct mempolicy *new_pol);
 
-/* We are about to modify the VMA's flags and/or uffd context. */
-__must_check struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       vm_flags_t vm_flags,
-		       struct vm_userfaultfd_ctx new_ctx,
-		       bool give_up_on_oom);
-
-__must_check struct vm_area_struct
-*vma_merge_new_range(struct vma_merge_struct *vmg);
-
-__must_check struct vm_area_struct
-*vma_merge_extend(struct vma_iterator *vmi,
-		  struct vm_area_struct *vma,
-		  unsigned long delta);
+/**
+ * vma_modify_flags_uffd() - Peform any necessary split/merge in preparation for
+ * setting VMA flags to @vm_flags and UFFD context to @new_ctx in the range
+ * @start to @end contained within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @vm_flags: The VMA flags that the @start to @end range is about to be set to.
+ * @new_ctx: The userfaultfd context that the @start to @end range is about to
+ * be set to.
+ * @give_up_on_oom: If an out of memory condition occurs on merge, simply give
+ * up on it and treat the merge as best-effort.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its VMA
+ * flags changed to @vm_flags and its userfaultfd context changed to @new_ctx.
+ */
+__must_check struct vm_area_struct *vma_modify_flags_uffd(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, vm_flags_t vm_flags,
+		struct vm_userfaultfd_ctx new_ctx, bool give_up_on_oom);
+
+__must_check struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
+
+__must_check struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+		  struct vm_area_struct *vma, unsigned long delta);
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..fd37ce3b2628 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -339,6 +339,7 @@ static bool test_simple_modify(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
+	vm_flags_t flags = VM_READ | VM_MAYREAD;
 
 	ASSERT_FALSE(attach_vma(&mm, init_vma));
 
@@ -347,7 +348,7 @@ static bool test_simple_modify(void)
 	 * performs the merge/split only.
 	 */
 	vma = vma_modify_flags(&vmi, init_vma, init_vma,
-			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
+			       0x1000, 0x2000, &flags);
 	ASSERT_NE(vma, NULL);
 	/* We modify the provided VMA, and on split allocate new VMAs. */
 	ASSERT_EQ(vma, init_vma);
-- 
2.53.0


