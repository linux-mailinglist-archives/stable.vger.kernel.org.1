Return-Path: <stable+bounces-241050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDo7Hibd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97974636F3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99390301E6CC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737B194C96;
	Fri, 24 Apr 2026 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoLfoQ0/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3693368A2
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065229; cv=none; b=uneuzfkGsLpohrOExACtAx3c+4too5e575yIX2Ii37j/mK+EIro51mSqVgIxM908enEBAsdsoK4QO448lyyAHycQnRnDvBE8khLZHFcKZPUx0ZLzY30aecg3Ad+ZSIIr23s9t16MmUuG9774mIenHLE2uV55tfBJEXGsadrT62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065229; c=relaxed/simple;
	bh=XZxKTibaMCTYhrxBwPPHJiuAKDrTnqXEcFROxm4nS34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0MbD7HtUOL5FTozp6KZJmUzEdus3sXoLutGo60YWyQ0288cRajboUAOdhJ8CCXaMmih7GbKhYZBTUzxT6p4LCAdqfT3mO2HSYVdOvEfFJTIncCN+WaN2kHhS4vj1v5Qu6ZRAnufC9FKbAk0guOfuCiKwO5dH5VnpEgempcuboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoLfoQ0/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so7281444f8f.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065226; x=1777670026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ/6HUw5dElWk7B0xLynBcGoo6YPR5w98Vo1tEio3a4=;
        b=aoLfoQ0/FdKtjdUz4uPZMNkhPJwDpLe3O6KycJh8poaBzxvA/dq+viRO++y+gU3QVf
         gAM20t6OwPWHRYh+KcE3eunlE+QyAGzG3seZiywSEXzhEr9h3SHthtoG/uHiLkYVkEO5
         px5b7FpsJLD7MHc99pgu+0sBZogOlfSwE+yTOvIc9LfBwVF4Y1ObL5bSf95V4U/ja8ox
         5gLiNIJKI1cfrxTVagQumNylHJDAiKno61g9q934iQ++xxQf6pi1UPo2MmZ2bg9ycBJt
         iDOa0eOJ/icsRIBY4bvQBL/0D1C2dnHmDN4enPW9QS09fGgRCx4cbeAnSvqg7ZD6sn8r
         Lmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065226; x=1777670026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZ/6HUw5dElWk7B0xLynBcGoo6YPR5w98Vo1tEio3a4=;
        b=UUBd/Ba1PVfflqH6PQwr7713DIAkrnhBX/IjCS09oHWK5njreF9nYIptaj5Y/qS2BS
         6QlhndzMBF3cSUzwM7kURYmyrFAJt0S65kmbG2gRSWWTYRJycqQjZruXqYrv0Ga9lrEQ
         6GEqcS8vGem90ApeKC7L4zHU/Sq8PO0ipY3J0spvEmelRqDc2uEhgMkdmrnWageuCKXX
         mWdEmifNDrgWKs/emuKW2EBvm8aGFn7HD9lRMI7jdR7awzJ3DbSM+RYvVL5+mdCf4G75
         M/rSGzOsRKHJjFKc6Vrf5RSfS0f3oLtobUFK7Nn+XFGw5DGrBrnjecHCwl3Pkw9BjmPO
         Lbhw==
X-Gm-Message-State: AOJu0YxDqRSgwCU7IYJ3BsjUkZZ2rZ1eHmaJ9rxQqK2fPPRbqcZnTIo5
	7clYWA5w33Y00JsyPE94gMSxVsf0v77y8FNRFahhD6v6WMOCRFuQvqapL6rRsw9z
X-Gm-Gg: AeBDietDitInCAwvSfBqgR2noLLfAYSFGKjjwBZWZOzj6/ybtdqsJLQZ2OUKjSVgEi/
	M4FddtowrCnNA+Tx/vomxnIAx+yBrwc9faiMc99EWiPp+Mdsg+SXoJlZ/TSnS7aJMZ7EqiBIx0P
	pzPQvrAPb+wXd3wdKcTBYghkMIisPKVsrjH3rfwQ8dKL/+IT7hzgyxHJBnuC4qxhedfSwC71TSm
	OuccYw50LhY2dSOQs6DX54DX/PNFhaXDKwJhMVeO8aMGwqtogTPYKJZo/my+/e5Egiyv7wXuFNQ
	Yuj4rMPOGF3+RqKARFeD5aisbF6bbJtXdanSExyeuHcccbyQ/KJW4yvTVuKLFwzN0gEuCWMwXiZ
	Mb22aBduq4zi1+EiXOMKjDpNbp6g25yw3KIgvY1wfafChkLx004nzggUycBG6haX/Y3fO8SuAi7
	vYdZkTjEahDWLOPRR8OKnn5uKuww8iwA==
X-Received: by 2002:a5d:5d83:0:b0:441:1e41:19c with SMTP id ffacd0b85a97d-4411e4102d7mr27409657f8f.20.1777065225832;
        Fri, 24 Apr 2026 14:13:45 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:45 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
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
Subject: [PATCH v1 5/9] mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
Date: Sat, 25 Apr 2026 00:12:39 +0300
Message-ID: <20260424211315.1072123-6-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: E97974636F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.de,suse.cz,kernel.org,linux.alibaba.com,arm.com,google.com,lwn.net,linux.dev,efficios.com,suse.com,redhat.com,goodmis.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-241050-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Gather all the VMA flags whose presence implies that page tables must be
copied on fork into a single bitmap - VM_COPY_ON_FORK - and use this
rather than specifying individual flags in vma_needs_copy().

We also add VM_MAYBE_GUARD to this list, as it being set on a VMA implies
that there may be metadata contained in the page tables (that is - guard
markers) which would will not and cannot be propagated upon fork.

This was already being done manually previously in vma_needs_copy(), but
this makes it very explicit, alongside VM_PFNMAP, VM_MIXEDMAP and
VM_UFFD_WP all of which imply the same.

Note that VM_STICKY flags ought generally to be marked VM_COPY_ON_FORK too
- because equally a flag being VM_STICKY indicates that the VMA contains
metadat that is not propagated by being faulted in - i.e.  that the VMA
metadata does not fully describe the VMA alone, and thus we must propagate
whatever metadata there is on a fork.

However, for maximum flexibility, we do not make this necessarily the case
here.

Link: https://lkml.kernel.org/r/5d41b24e7bc622cda0af92b6d558d7f4c0d1bc8c.1763460113.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
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
(cherry picked from commit ab04b530e7e8bd5cf9fb0c1ad20e0deee8f569ec)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 include/linux/mm.h               | 26 ++++++++++++++++++++++++++
 mm/memory.c                      | 18 ++++--------------
 tools/testing/vma/vma_internal.h | 26 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ebc5fb0af5ce..2bad4bf67d0f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -538,6 +538,32 @@ extern unsigned int kobjsize(const void *objp);
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
+/*
+ * Flags which should result in page tables being copied on fork. These are
+ * flags which indicate that the VMA maps page tables which cannot be
+ * reconsistuted upon page fault, so necessitate page table copying upon
+ *
+ * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
+ *                           reasonably reconstructed on page fault.
+ *
+ *              VM_UFFD_WP - Encodes metadata about an installed uffd
+ *                           write protect handler, which cannot be
+ *                           reconstructed on page fault.
+ *
+ *                           We always copy pgtables when dst_vma has uffd-wp
+ *                           enabled even if it's file-backed
+ *                           (e.g. shmem). Because when uffd-wp is enabled,
+ *                           pgtable contains uffd-wp protection information,
+ *                           that's something we can't retrieve from page cache,
+ *                           and skip copying will lose those info.
+ *
+ *          VM_MAYBE_GUARD - Could contain page guard region markers which
+ *                           by design are a property of the page tables
+ *                           only and thus cannot be reconstructed on page
+ *                           fault.
+ */
+#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/memory.c b/mm/memory.c
index dde20cd5fa5b..1dd68a0e2be4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1463,25 +1463,15 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 static bool
 vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
+	if (src_vma->vm_flags & VM_COPY_ON_FORK)
+		return true;
 	/*
-	 * Always copy pgtables when dst_vma has uffd-wp enabled even if it's
-	 * file-backed (e.g. shmem). Because when uffd-wp is enabled, pgtable
-	 * contains uffd-wp protection information, that's something we can't
-	 * retrieve from page cache, and skip copying will lose those info.
+	 * The presence of an anon_vma indicates an anonymous VMA has page
+	 * tables which naturally cannot be reconstituted on page fault.
 	 */
-	if (userfaultfd_wp(dst_vma))
-		return true;
-
-	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-		return true;
-
 	if (src_vma->anon_vma)
 		return true;
 
-	/* Guard regions have modified page tables that require copying. */
-	if (src_vma->vm_flags & VM_MAYBE_GUARD)
-		return true;
-
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 19914c28977e..6ee803873e00 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -145,6 +145,32 @@ extern unsigned long dac_mmap_min_addr;
  */
 #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
 
+/*
+ * Flags which should result in page tables being copied on fork. These are
+ * flags which indicate that the VMA maps page tables which cannot be
+ * reconsistuted upon page fault, so necessitate page table copying upon
+ *
+ * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
+ *                           reasonably reconstructed on page fault.
+ *
+ *              VM_UFFD_WP - Encodes metadata about an installed uffd
+ *                           write protect handler, which cannot be
+ *                           reconstructed on page fault.
+ *
+ *                           We always copy pgtables when dst_vma has uffd-wp
+ *                           enabled even if it's file-backed
+ *                           (e.g. shmem). Because when uffd-wp is enabled,
+ *                           pgtable contains uffd-wp protection information,
+ *                           that's something we can't retrieve from page cache,
+ *                           and skip copying will lose those info.
+ *
+ *          VM_MAYBE_GUARD - Could contain page guard region markers which
+ *                           by design are a property of the page tables
+ *                           only and thus cannot be reconstructed on page
+ *                           fault.
+ */
+#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.53.0


