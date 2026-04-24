Return-Path: <stable+bounces-241053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIFyKTLd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0A46370A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207F23020D7D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7C33F8D9;
	Fri, 24 Apr 2026 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwQMV41S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623D34404E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065237; cv=none; b=EbSmt9rynoz/kjWkZiPs3UJ9dKZkyztf8bhTX7684ecZjM42r330g3WbDP0N71xPltNa1kApgGzB1xtQeaoFxKHFZApDdwnmq6Xi8VtmSEDrn2ko2Ql/UokOSPd3o9lBWGkkU7rJdGt4WT6Dosr43owvDGb1YtIGqqH65VgZl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065237; c=relaxed/simple;
	bh=KsupXsFNo+EuiMn7OQ4LqElWvKZuD8MTBNAL/XRXDFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ragMOPT99HaiKPVYnnrg+TWZyNMKaUKw/eUvTaVD6w3wvI5iJ7DysH3vfJYapLA6SvECZbNBZ4sR3EDCKDt7ItDsO2RAUasXnIgKiz/6gm3VxjpNUb5SkeTE0pIPKfhwNk3eDrGXA03iX3kk85d8+WWBFG2vT+g1MOrd+p0p3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwQMV41S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfd832155so6077392f8f.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065234; x=1777670034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqDSoqQFeKS+EClGztfCqJhTgKB6YvX/XVfIE7se57w=;
        b=FwQMV41S/SFUgCHwKRkIlIw+0HTkGeeiF3aAq5V4t/oyGWWKbZ0iUx/op3Em3ow62g
         Q3XXzY+I+Nzb5/0QwipWU3Z2nIa3wmPirEPDGfqomboiT3pKUqg2Nzo7UBlvVEZzkTVE
         qrcsaaf8Hbfcq6fz+bqtVIxBfBETCOg+Z7iP6nzk8hX8ym88W/uRfu0aBBTcj9/G6BPF
         BupRp/xI+GKtL+xXIIF2nXnqU08FKuqwTpu3P8ESTYUVX3/+1GYJHuRkpuBKxxWR7m1A
         a1UZCJQ99w2QVTXC65nG6SY+m26Fej8chP79mhE/J4enZPFOhS639IQZeUiIv/zznOd/
         wL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065234; x=1777670034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqDSoqQFeKS+EClGztfCqJhTgKB6YvX/XVfIE7se57w=;
        b=Ah+78fj1V/XyGa0vKMXZe/yEZBR/lrS09oiu+J7AX5HuOtMP6WvfKCj3jUQXv1fY3i
         JZAsvpzlaDDakrhPmi9cfrbfh25M1RYtvft8WQSVxhjmC84F1gIqFYO74MCB353o2y5E
         l0NZyeY/5gEhwPnXtS0MqSsV5XJOy+4Ff/D/EdZGFAGFwAc4Eos1KlpXjyJk7kLccMV5
         4Vjxd+oO0mWDBiEhkclMmHsn/IycXDmpKMcgsqsXTTwxnlbWQftUmksJOwTqNKazG/+z
         WC6gav/EoVKnl7EbZp4z5X/+wIasplIoIJlXzyx5ImY0ukqY6ZQyLMpm/Hn88s0Kf+xU
         Cspg==
X-Gm-Message-State: AOJu0YwOrt8ulvSHCMAA1zsdL30L04BM7lPzepYRG2ws+7Z2PbofX3cj
	ao321GNRWrfPZL6RlHNdrZTGhVrSg+cdSmW5Ao2T2UCR+u+Gjs/eaa3QiahfNOuA
X-Gm-Gg: AeBDietIxRS43cOWXLYJKanc7Rafkul9GDuLcNtKlF0A1Hw2rpMe3DoRDzvvL7r99Az
	JWFYmQPDH1snife+Np6oKlgRzY3gyFDcK3+GS34W8QpKC80mneXqHMNh5+Zq4aP54UWB/gDywZM
	xQtLXsAnOC68H1M0yzgAITSay6JOYqRnzmzLLBHRhrjGWEbnWFuR2S1Yfq+Kc6aC6q21azUM6nU
	o1NpveGH2EJVc0iDPGqOJBYqfXl1UKb4HDx7nE2eDbCClT+ZGnzOIDi9ephlmizMXqovdZNv3xf
	jtZh+iAg3Vb3ySIgDmjyYc+CeAhxpAOVNgi4EFALnhdnw915WE7vq32nMm/b3n7Cv9lTdSUrvH8
	xXchfytH8C/eZs+EYhq+9jd/2ueXv78Hw1TiGansBZESwN+kgoxrub4Neoa+8k/7uAj1ovY28o5
	r7CrRxtT9mu6vPqX3GRCIRMJl7dYeL9A==
X-Received: by 2002:a05:6000:1ac9:b0:43d:6787:9934 with SMTP id ffacd0b85a97d-43fe3db39b2mr50423602f8f.9.1777065233899;
        Fri, 24 Apr 2026 14:13:53 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:53 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
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
Subject: [PATCH v1 8/9] mm: propagate VM_SOFTDIRTY on merge
Date: Sat, 25 Apr 2026 00:12:42 +0300
Message-ID: <20260424211315.1072123-9-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: 19B0A46370A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,suse.cz,kernel.org,suse.de,google.com,suse.com];
	TAGGED_FROM(0.00)[bounces-241053-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,suse.de:email]

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
Link: https://lkml.kernel.org/r/cover.1763399675.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/955478b5170715c895d1ef3b7f68e0cd77f76868.1763399675.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
2.53.0


