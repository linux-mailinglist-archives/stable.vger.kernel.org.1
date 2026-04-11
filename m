Return-Path: <stable+bounces-235711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO/jONYu2mkgzAgAu9opvQ
	(envelope-from <stable+bounces-235711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:21:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 509913DF754
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C086303E2C8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE832E743;
	Sat, 11 Apr 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX8HYexk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AB3446A5
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906487; cv=none; b=soM5n8jKHs5fo9osDEOEsGALW8Q+jWL8YRGMv2r0s4JqHqNUg/SOgyr2gCZepOK45R/hft8kCx5BBXLTaZ3R0yt0Hy3zJXZVofEr2UicvMH0lX0tTUvrLoXgkKQeNlJDKhk82SMYoN/2EsIGTqZmxg2cdYaEfJofgxblOYX82gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906487; c=relaxed/simple;
	bh=9QlHGdkTLeV9V00JRc0JOW6i7+Q0aVko8DuLbBYPo4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOm2nbZjoqeejP6g2UpyX472OR8Opwwo62O+MhqZij4jDgHy2TkWO11A4x8dZj7poyHVkWJevO0Yxg0ZB+OkdLhmQKKWtIVKfPVFSAcDAXH5/JkSxaat7MHqhsnCHQ75BUcnDG8CHQN6seUbH3FkehjRNPMbkDwdu8KdpBsryRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX8HYexk; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c54c68db4dso5180541eec.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775906485; x=1776511285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ZPcIa5OvWR2yiUKd/+yp0eIrmzRtU8HCVYMTSVr1M=;
        b=hX8HYexkyUvLcWyGgcBsgEGdbuFKzy/o/9PuIHS0L7wPfBPifaGs/UIvfv0Dfnj7GC
         zaRxX7wmX+Nr2gKxQoNsKOd5YH8lw2Gf9YMF+AnxuXEAIkuuOEdRL7BKEDLokRF6qsFJ
         mtUXAg+Y96apufmdmOfyLeH8mYBG1eIMBZbJb8Z52i+2fAjzsnCXlZWsc0qsvMmo9A1a
         tuUEgypwpwksvTzAYxJouDFmt4lAyFCJJZnKHGVZdwSjrhbak5tnGkZBTb6XGnwEGod6
         TH+AOnjjvhPAmb+mfT8KIt7gwQCKd0cXgbqSLdKm7iawjBxb1nZ9VMT9X0YtUux1+Tke
         hdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775906485; x=1776511285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3ZPcIa5OvWR2yiUKd/+yp0eIrmzRtU8HCVYMTSVr1M=;
        b=sJSL/TOes7PWe19dcBonOrHtq+SoIkMoZ9L6YbuHgf2kz7c0nv43TLY+VYHQlNE5Aj
         P+U8N8wMSquFUjGq95FBzoqwMKbRL3SgNUcINazXzslzJwfit2TWtcT8bZetMLFCBPdS
         Jz39LHax4FSV5CE2KzzwkbYPeFbaEwLSx/Mp+pDFgcTXdjQO/rDNGDu7FdHG7QjoLxGb
         CRgZsNo6PZG27ziqq4kIwX/Hr3c48LDZ5kwxCqoMBShItrf0K3CPrRp/Lkggq8CaWxNi
         HqgCTmTFc+6TB0kmTT52x3n0emgNbtQmmL8wXrNMrCQADquEi+rp5Qs0XVcOI3IYWvIH
         4OYg==
X-Forwarded-Encrypted: i=1; AJvYcCWgCJhyuRgvlZCVbDokO/gV9HHIFMREf6YRkPI8py1gvuBiwmcVK7IMNApIpVLHv8rBXRD8t0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmFMZfx8jDlF3hK1bngSofZ3TLB0wCSppy2f2w1+bfyt1XkKX
	q6Obv/Vt7gxw7Mbc7xzVpAFd/1F45VP5KfLXfQpjGMXcSOuqCM3iUPUB
X-Gm-Gg: AeBDievKUkrYCEf+iQqFKPwnRrFO/J93Wzn+/32LHY+hnvMXns+pcWXYf8YOBeRWDyt
	81NdJHHS8yhue27HWkud9oXlVUKsJgcljEPo5UtcYIJLjSQdD+FU8eTI86UQdIrfyTG+hYGwC8S
	CBGFWozmdWo85uwA6cBsHlnZxrKaZ0bocM3/RNqes4qi/DdzWHikc1COnA/bZo3TB38+u/isnBq
	mYH6h8wUHqkm8qYLaA5Hd+eI7ke7HWNw4QI+BXPoT2F2t9RbKHQwVGokRRevAaWWquuAtmJFiz5
	yx6akanYyhbzkwS2Tl1j0yk2dj2XJ7uopJN+aPTZJ3cG5ektP/H5S6nk1hfeNv0MTr0l073Jc8q
	nSTklDFDKqXOBbLu9884KrVEaB5ZTmHzgHvXFHB2b6gzcjkgANhA7/ImUkQkZd0H3Uh26VCiYdz
	vsSsuuprAUCEdIcS+/V3+9Iif+X4X9R71iOs6lWSWqM7Ynj25rinsy4+08bA72q00B6OQxv62oZ
	qpra4L2wQ==
X-Received: by 2002:a05:7300:8c14:b0:2c4:ec89:bd3 with SMTP id 5a478bee46e88-2d5898aa893mr3717101eec.24.1775906485373;
        Sat, 11 Apr 2026 04:21:25 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm8224984eec.27.2026.04.11.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:21:24 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix use-after-free of arena VMA on fork
Date: Sat, 11 Apr 2026 04:20:50 -0700
Message-ID: <20260411112050.1454548-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411112050.1454548-2-bestswngs@gmail.com>
References: <20260411112050.1454548-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-235711-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 509913DF754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

arena_vm_open() only increments a refcount on the shared vma_list entry
but never registers the new VMA or updates the stored vma pointer. When
the original VMA is unmapped while a forked/split copy still exists,
arena_vm_close() drops the refcount without freeing the vma_list entry.
The entry's vma pointer now refers to a freed vm_area_struct. A
subsequent bpf_arena_free_pages() call iterates vma_list and passes
the dangling pointer to zap_page_range_single(), causing a
use-after-free.

The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
deterministically -- no race condition is involved.

 BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:2234)
 Call Trace:
  <TASK>
  zap_page_range_single+0x101/0x110   mm/memory.c:2234
  zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
  arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
  bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
  __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
  __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
  do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
  entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
  </TASK>

Fix this by giving each VMA its own vma_list entry, following the
HugeTLB vma_lock pattern (hugetlb_vm_op_open). arena_vm_open() now
detects an inherited vm_private_data pointer via the vma_lock->vma !=
vma check, clears it, and allocates a fresh entry for the new VMA.
arena_vm_close() unconditionally removes and frees the entry. The
shared refcount is no longer needed and is removed.

Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/arena.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..3a156ec473a8 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
-	refcount_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc_obj(*vml);
 	if (!vml)
 		return -ENOMEM;
-	refcount_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
@@ -336,9 +334,28 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 
 static void arena_vm_open(struct vm_area_struct *vma)
 {
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	refcount_inc(&vml->mmap_count);
+	/*
+	 * If vm_private_data points to a vma_list for a different VMA, it was
+	 * inherited via vm_area_dup (fork or split). Clear it and allocate a
+	 * fresh entry for this VMA, following the HugeTLB vma_lock pattern.
+	 */
+	if (vml && vml->vma != vma)
+		vma->vm_private_data = NULL;
+
+	if (vma->vm_private_data)
+		return;
+
+	vml = kmalloc_obj(*vml);
+	if (!vml)
+		return;
+	vml->vma = vma;
+	vma->vm_private_data = vml;
+	guard(mutex)(&arena->lock);
+	list_add(&vml->head, &arena->vma_list);
 }
 
 static void arena_vm_close(struct vm_area_struct *vma)
@@ -347,10 +364,9 @@ static void arena_vm_close(struct vm_area_struct *vma)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct vma_list *vml = vma->vm_private_data;
 
-	if (!refcount_dec_and_test(&vml->mmap_count))
+	if (!vml)
 		return;
 	guard(mutex)(&arena->lock);
-	/* update link list under lock */
 	list_del(&vml->head);
 	vma->vm_private_data = NULL;
 	kfree(vml);
-- 
2.43.0


