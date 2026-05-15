Return-Path: <stable+bounces-247755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOdDID0aB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:06:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6F5502AE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5F23141544
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118F1DF27F;
	Fri, 15 May 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVSIOZxQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E747DF8F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849052; cv=none; b=uvCoHte4TDeNfiWg7dSX+65i72KUPTrC9D2mwlnD1lM/iNiocatDdp9EQkTlfPhCh3TP/OwxgyDLmfivA9ZF/UaanWf9kcppniGXMKeIvMgS+ww+kMIPSvVboUD4p+tGC6pSGeOQqrGggW1bpa92VayjAZKihN5pYKWX0eF897M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849052; c=relaxed/simple;
	bh=5ciwepOKd+C37NkpIBnEhnrKj8aXSPDXJFDO4Pi2hUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+iBSyP0dk+V34v1vuemSt5xjlvTdjjktfRj5I38sNJmt6kgkwTjwUGcaPeT31qMRGAysljHaeFizM0Fhag4Bxu+KBUYB/VyH1rNpw+01rX4UBE0oAwZ8Rzdx/rQfgBIN0ifW+arHv+9hE6Iivwl9tzPigaCQo1nqKg98m8d2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVSIOZxQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so151023325e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849047; x=1779453847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tc1Hi4hRis6nDBLT1nxBblw8j7Bbw8+zpnBKWgjEvE=;
        b=RVSIOZxQ7Jij/ATUWsoDCrJE3q2SJZ9b4poEe7k+qXArOjv8qd2wtcgH2fBD1Bn9XE
         DoayFvEApK1rqhH/sD1Jpfb3f8a2POhYYma9sOrGYo3FY77thuIZ0czbUfXhr/aiH9eg
         E2eniQditluMnYf7/0FG31BzN1AjWsAGln2/jO/l2pb9Gc9GX7wBnBrBrc3AyHibfYnM
         JlPj3pBt7GA6DdN/X29HoQKmZ91bH5C5fHwuPBqzV2mCn/OCKHkAY2AIBb2M3RvfdVWK
         QUo+gpFL/cY51oS9sAa91tR0Rz4aHjPis78nVPsQlq0ydrr9xJNR7pdeyRognmCqaJWq
         29ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849047; x=1779453847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6tc1Hi4hRis6nDBLT1nxBblw8j7Bbw8+zpnBKWgjEvE=;
        b=BmiSEvwSZ1OUwdAkx7DdchDIEzNpQaaRJZ4BRM2EFTqYRux2OKhW9ECXmvhkLnTCo8
         rWeZ+rtctZvqZp2yxg7orDYbcJPkzae4xs7821dB+y49GOqwgMcdsTBAk2hiErE/pBnE
         G1eKytr802cfAwFtvyxS60VeNMTrOQTXOZi8oFmILgLnH/MdKnDf+2w47/9nsCJ69g6A
         mAAngNWnk6KL37sjQOtQ1PeRnDgP9xjQyPTdoHj7aPMvspryUMb2M1KLEXIPZNaMul2r
         /Tq926O7i52iMBn/AgNcxxg3vzXL4TxIRZDNLiQVcvQmv2JFpZ5yMiNXfnkbc4qLKhbI
         PKcA==
X-Gm-Message-State: AOJu0YxPEfOX29epZUvKGuLE3E1tuMGdpMo6dRrOfUZuzBKjatdq6yTa
	4s6Uvu2UczoO0KKs6DXrvOrDOJLHmKXLybDQQNCe0WpYoH5lrA70DwX1Ui6Lmw==
X-Gm-Gg: Acq92OH0HzOydcIWgOBsWVOuTAjxP1/R3YIJzu8As98HdehlrhGRFDY0tdADn5c3dq7
	VzDXo1zbeJtZ+v5FYlychCSK0n90o0aabXO+G/d6AMsYuTU+ooHALj5pxV987hXHXplAgWkUqW7
	cLbgrTK0heWOCnYR4yTaTyeS4sTy9awtSpwBGiqGLV5P+uTXKwmt6wngUKGlQY+5MLphEJ1M5Cl
	ZWN5/wZSE4J/kEooILYQ6kh7Qia4pYHuYb7SMpQ5m5K5818eteJvON1FQSBYa864FTOE+E6ED6F
	DF0Vv6FY8ZiuLx7hLiQKkMP/irMcc7XzU/ghK+4cKWGyd2253c+OIzAgyjrUn9+ay5XDwC4r9Ie
	XaoWSBP6avIQNt1zKIdu1SAVp7PcfvLLQpo9NUy2Bclgr99QE7GuaxGLuyUDLvGfRoujn+7AX4m
	ejQjIdy/ERSKfyqwPjS1fzKAYhb1Ry6w==
X-Received: by 2002:a05:600c:8184:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48fe60edcefmr49132125e9.13.1778849047119;
        Fri, 15 May 2026 05:44:07 -0700 (PDT)
Received: from fedora ([156.207.183.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm100188115e9.1.2026.05.15.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:44:06 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	avagin@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v4 8/9] mm: propagate VM_SOFTDIRTY on merge
Date: Fri, 15 May 2026 15:42:18 +0300
Message-ID: <20260515124218.151966-10-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: D5B6F5502AE
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
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,gmail.com,oracle.com,suse.cz,suse.de,google.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-247755-lists,stable=lfdr.de];
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

Patch series "make VM_SOFTDIRTY a sticky VMA flag", v2.

Currently we set VM_SOFTDIRTY when a new mapping is set up (whether by
establishing a new VMA, or via merge) as implemented in __mmap_complete()
and do_brk_flags().

However, when performing a merge of existing mappings such as when
performing mprotect(), we may lose the VM_SOFTDIRTY flag.

Now we have the concept of making VMA flags 'sticky', that is that they
both don't prevent merge and, importantly, are propagated to merged VMAs,
this seems a sensible alternative to the existing special-casing of
VM_SOFTDIRTY.

We additionally add a self-test that demonstrates that this logic behaves
as expected.

This patch (of 2):

Currently we set VM_SOFTDIRTY when a new mapping is set up (whether by
establishing a new VMA, or via merge) as implemented in __mmap_complete()
and do_brk_flags().

However, when performing a merge of existing mappings such as when
performing mprotect(), we may lose the VM_SOFTDIRTY flag.

This is because currently we simply ignore VM_SOFTDIRTY for the purposes
of merge, so one VMA may possess the flag and another not, and whichever
happens to be the target VMA will be the one upon which the merge is
performed which may or may not have VM_SOFTDIRTY set.

Now we have the concept of 'sticky' VMA flags, let's make VM_SOFTDIRTY one
which solves this issue.

Additionally update VMA userland tests to propagate changes.

[akpm@linux-foundation.org: update comments, per Lorenzo]
  Link: https://lkml.kernel.org/r/0019e0b8-ee1e-4359-b5ee-94225cbe5588@lucifer.local
Link: https://lkml.kernel.org/r/cover.1763399675.git.ljs@kernel.org
Link: https://lkml.kernel.org/r/955478b5170715c895d1ef3b7f68e0cd77f76868.1763399675.git.ljs@kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Andrey Vagin <avagin@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6707915e030a3258868355f989b80140c1a45bbe)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>

Fixes: 34228d473efe ("mm: ignore VM_SOFTDIRTY on VMA merging")
Cc: stable@vger.kernel.org # 6.18.x
---
 include/linux/mm.h               | 15 +++++++--------
 tools/testing/vma/vma_internal.h | 18 ++++++------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2bad4bf67d0f..a68bced816fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -515,28 +515,27 @@ extern unsigned int kobjsize(const void *objp);
  * possesses it but the other does not, the merged VMA should nonetheless have
  * applied to it:
  *
+ *   VM_SOFTDIRTY - if a VMA is marked soft-dirty, that is has not had its
+ *                  references cleared via /proc/$pid/clear_refs, any merged VMA
+ *                  should be considered soft-dirty also as it operates at a VMA
+ *                  granularity.
+ *
  * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
  *                  mapped page tables may contain metadata not described by the
  *                  VMA and thus any merged VMA may also contain this metadata,
  *                  and thus we must make this flag sticky.
  */
-#define VM_STICKY VM_MAYBE_GUARD
+#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
 
 /*
  * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
  * of these flags and the other not does not preclude a merge.
  *
- * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
- *                dirty bit -- the caller should mark merged VMA as dirty. If
- *                dirty bit won't be excluded from comparison, we increase
- *                pressure on the memory system forcing the kernel to generate
- *                new VMAs when old one could be extended instead.
- *
  *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
  *                'sticky'. If any sticky flags exist in either VMA, we simply
  *                set all of them on the merged VMA.
  */
-#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+#define VM_IGNORE_MERGE VM_STICKY
 
 /*
  * Flags which should result in page tables being copied on fork. These are
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 6ee803873e00..bff75a4c3c8c 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -122,28 +122,22 @@ extern unsigned long dac_mmap_min_addr;
  * possesses it but the other does not, the merged VMA should nonetheless have
  * applied to it:
  *
- * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
- *                  mapped page tables may contain metadata not described by the
- *                  VMA and thus any merged VMA may also contain this metadata,
- *                  and thus we must make this flag sticky.
+ *   VM_SOFTDIRTY - if a VMA is marked soft-dirty, that is has not had its
+ *                  references cleared via /proc/$pid/clear_refs, any merged VMA
+ *                  should be considered soft-dirty also as it operates at a VMA
+ *                  granularity.
  */
-#define VM_STICKY VM_MAYBE_GUARD
+#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
 
 /*
  * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
  * of these flags and the other not does not preclude a merge.
  *
- * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
- *                dirty bit -- the caller should mark merged VMA as dirty. If
- *                dirty bit won't be excluded from comparison, we increase
- *                pressure on the memory system forcing the kernel to generate
- *                new VMAs when old one could be extended instead.
- *
  *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
  *                'sticky'. If any sticky flags exist in either VMA, we simply
  *                set all of them on the merged VMA.
  */
-#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+#define VM_IGNORE_MERGE VM_STICKY
 
 /*
  * Flags which should result in page tables being copied on fork. These are
-- 
2.54.0


