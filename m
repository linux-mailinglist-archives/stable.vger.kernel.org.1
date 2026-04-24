Return-Path: <stable+bounces-241052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKLmHC7d62llSQAAu9opvQ
	(envelope-from <stable+bounces-241052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA1463703
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7236C3019F24
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2672DD60E;
	Fri, 24 Apr 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3eh5XuC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6336DA1C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065236; cv=none; b=q8KzqqK317puzDpTBXZ7+0+bPRtirCdPJa5aQmnMFBuLcy4ecTsJo7x9ZqXRZp19hJBSvBUx0fiH0dXU2bGh42ba+yaEcQdkdQs0mfmlJoLigup/HtQZmcgz1YVCCViYaqYcSaUh2nWR3JplXsCGRlQ1K/YyD39m7gc5ZeCWG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065236; c=relaxed/simple;
	bh=4kE0Cn3BhncTsgDqvkJPf6ebHMHHhSlii+gGC/8Jza0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfCUqe8pVZFPQpGKFk4EcvqLMsgsLea0XMURpWm7TJw78f/wTMpWftMmE57QGiwj4x4yZy7lVijzJ2adx1kMWm3dZws5GtXQ0l2Iy+J0poBHmptq2Hnc/DmTSn3SKQ1w+05tdWng+2qB6BTzfJT8I1TOJfIvydVVcbLWVsd31sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3eh5XuC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso7051423f8f.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065232; x=1777670032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH4D3KJ1uR7ePvwBlIBXZU5OUty06kk4V5FneHmkobs=;
        b=O3eh5XuCfpDUfp2eEizUV8oZDWvapIw3Jl8KoJAInfwBJqRLHdbC9seEx3DdmlCgrd
         vFnOuHVDC2qbWj62sI4xYEjlRNmo+rhA7zrJsr3zX4XIbJCsULmseYzAPdZ1p0EI5Dzu
         YQ9HRxq4+A5RXYilc451J400jvd9dUNzkPt7Fff9BVerV817WtMPCtoqmmJXsIjws6Z5
         cDucqZnImJN1kprLUw/ieCHeX8uS6dC7+tQJQf5O8gsato9/Tll6VF3NEQgB0fl0PvQk
         7gNHQq8cJpuk5hxw7wt2VSmQPrknGgU7zdlbdCcJN3OCXiJLpvtZbcUrj/mZYIwrld6W
         U1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065232; x=1777670032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yH4D3KJ1uR7ePvwBlIBXZU5OUty06kk4V5FneHmkobs=;
        b=Z1aAbNc2e0EjcjMPvj4gkPBjIv72jGCTbhXoGl395ehwVsNe6XG+M9T4HFARQC91qH
         Dv0129ZPR5VbzJlHKAlrp78dreMMJRs0fLiW5HMC8j2GvbKx71NtYw61hleR3jsNbXrz
         btJTTk77/SPOo1AnZ0uq7ilz+Zrh4lHJJALKaJcLmY9k9B33Ir3gpg9M+aYE+O7XlbEQ
         +x9W00pbylWV4qOqRj+S6s+FbVNDKW6KngUyhuS3eVOsja/6X+rQqS2ALk5NWa3zQ780
         QcQSUzRFH2FsYgdwBOoWnrqezx01TEEizzc5KDy9S2aSdbzvv7cdTRGNUi7O2JEH6wBd
         MZQw==
X-Gm-Message-State: AOJu0YyKsD7EKq/q3JtFnpRod6u1r+4olNN7VWB7atGzJWfmszZAr40K
	7GsZug3Y9JXH3pfDS0/g49eO8/FP20nc+3c2Ylgvnn+hrX35ojoPO7hLqO+48vlm
X-Gm-Gg: AeBDiesnAbnV3PYu2NraC9qwFYVAOfKN5F62wqIFoeU9355OVRbTWGk21HQRUC3RmtU
	1uGYowtFAJKfndvIwyyGT9P7tb7JbpSH3PGXsU52h+v+5/Byz3geAu3SRz+S1N8ngS8qs9zuQE/
	RisTYOdRXs5Ej8IwPEZF39iElRyb971HOoB890X1RwLQjOUcqLHttEB31a3xf/ET44Y7zXmVs3C
	NfAuO5P4hejF3ioWoQ2bJXFXqf80Ey37bYINe+Jn7fhWh3XH73dVEm8WFHsKu6u9meSGqi/Bd+M
	fBOS2Pyy239Rftng56lEB/sJUn6A6BdEqq7itl0ly+AO6EvWZ3+E7g4ApSH25lSPTuRbUS1r8Us
	bjnDyfh3jzFF+8ux5X0t4srDXqDfIXaSGs4r7AgS2GzG5QYEKfNEsH8b04il1Zjx3l+yyweaSaT
	ERP4F07CQ+SnhmNDtQn8ukFqiznm7S+g==
X-Received: by 2002:a05:6000:144c:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-43fe3dd339emr51622902f8f.11.1777065232001;
        Fri, 24 Apr 2026 14:13:52 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:51 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
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
	Pedro Falcato <pfalcato@suse.de>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v1 7/9] tools/testing/vma: add VMA sticky userland tests
Date: Sat, 25 Apr 2026 00:12:41 +0300
Message-ID: <20260424211315.1072123-8-elaidya225@gmail.com>
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
X-Rspamd-Queue-Id: 11DA1463703
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
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,linux.alibaba.com,kernel.org,arm.com,google.com,lwn.net,linux.dev,efficios.com,suse.com,redhat.com,suse.de,goodmis.org,suse.cz,nvidia.com];
	TAGGED_FROM(0.00)[bounces-241052-lists,stable=lfdr.de];
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

Modify existing merge new/existing userland VMA tests to assert that
sticky VMA flags behave as expected.

We do so by generating every possible permutation of VMAs being
manipulated being sticky/not sticky and asserting that VMA flags with this
property retain are retained upon merge.

Link: https://lkml.kernel.org/r/5e2c7244485867befd052f8afc8188be6a4be670.1763460113.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 29bef05e6d90b6123275159b52a1e520722243cb)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 tools/testing/vma/vma.c | 89 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index fd37ce3b2628..be79ab2ea44b 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -442,7 +444,7 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
-static bool test_merge_new(void)
+static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
@@ -470,23 +472,32 @@ static bool test_merge_new(void)
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
 
+	if (is_sticky)
+		vm_flags |= VM_STICKY;
+
 	/*
 	 * 0123456789abc
 	 * AA B       CC
 	 */
 	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
+	if (a_is_sticky)
+		vm_flags_set(vma_a, VM_STICKY);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
 	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
+	if (b_is_sticky)
+		vm_flags_set(vma_b, VM_STICKY);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
 	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
+	if (c_is_sticky)
+		vm_flags_set(vma_c, VM_STICKY);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
 
@@ -521,6 +532,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky || b_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -538,6 +551,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -557,6 +572,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky) /* D uses is_sticky. */
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -575,6 +592,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -593,6 +612,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -610,6 +631,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
+	if (is_sticky || a_is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Final state.
@@ -638,6 +661,20 @@ static bool test_merge_new(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	int i, j, k, l;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				for (l = 0; l < 2; l++)
+					ASSERT_TRUE(__test_merge_new(i, j, k, l));
+
+	return true;
+}
+
 static bool test_vma_merge_special_flags(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -974,9 +1011,11 @@ static bool test_vma_merge_new_with_close(void)
 	return true;
 }
 
-static bool test_merge_existing(void)
+static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t prev_flags = vm_flags;
+	vm_flags_t next_flags = vm_flags;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -989,6 +1028,13 @@ static bool test_merge_existing(void)
 	};
 	struct anon_vma_chain avc = {};
 
+	if (prev_is_sticky)
+		prev_flags |= VM_STICKY;
+	if (middle_is_sticky)
+		vm_flags |= VM_STICKY;
+	if (next_is_sticky)
+		next_flags |= VM_STICKY;
+
 	/*
 	 * Merge right case - partial span.
 	 *
@@ -1001,7 +1047,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1019,6 +1065,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1034,7 +1082,7 @@ static bool test_merge_existing(void)
 	 *   NNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1047,6 +1095,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1061,7 +1111,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
@@ -1081,6 +1131,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1095,7 +1147,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
@@ -1110,6 +1162,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1124,10 +1178,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1140,6 +1194,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1159,9 +1215,9 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
 
 	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
@@ -1204,6 +1260,19 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+static bool test_merge_existing(void)
+{
+	int i, j, k;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				ASSERT_TRUE(__test_merge_existing(i, j, k));
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-- 
2.53.0


