Return-Path: <stable+bounces-249067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIXUL9xyCWpJaQQAu9opvQ
	(envelope-from <stable+bounces-249067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 09:48:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF9655FC5C
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 09:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D93301E20E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509F3164AA;
	Sun, 17 May 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1iKEco/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34330C154
	for <stable@vger.kernel.org>; Sun, 17 May 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004053; cv=none; b=VCjF6PQdrC/Lw2rvhxwqZ1+qaN79uKnsRFEisyDuyDqlgCKWZBEt0rtd9edKqqI9w3XJvX/l8M/BSBjx8u/evkrZc2rXkj9/FMLs1TNvTe+1znH+BbmPreFu+55AwNujspNC6RjG4RvRVREaxBD7CHwGBmU+2Ji88CzWJseTaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004053; c=relaxed/simple;
	bh=DcaQAvyTv+B0bzkQ71JQZ9CCPRMCIstVRIyuOQa2hZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HapZrhh6vqBCSQdge1fuxOeoienD1bpO2H9+FRIoCxugvNMwSo1VgkxaXO/NAvbjA+lxJidATRxDa1+68Dev7qmekqwQ5OYZDo2CJN9/+nI75ij94zIyoPtjIqUDAUZhvEeGnFmpNiPRZocyz6aYSyNambtxPuTSig8GwXxisJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1iKEco/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so2230661a12.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004050; x=1779608850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lq35AOf8XMoPBRf51zQYzOvH5l4HY+x3jHyuSK93u4=;
        b=L1iKEco/74W7rrNvrGy5b++L/SSv0YyXcopfZb+Gfmsl34BOPdzBRKcrud4nLBgWiu
         SygN9s8qqADHtv1cYbSOxeTURGQjxOtD3173hhmipGJgsBgBC2VlvDtwekCN4pSkBOIq
         8eV8gOZ0wPUZNsU/5dYJWd0smqZFeQRQ5eUhsTdxg6H31yZHSkZfyGW8hAEOpVeczi0b
         kYhYWNK5x+pi877lf/vxCMoOsZiNrikMHN9Ub8h+O4Oj+0b4jJScvFZ10uRDE/AwjetC
         swUZdgwZfmAQvxyAwLQqjFeBRBWVsOuFi59kHn6PmypvFUYK4F89JT498ay5NCZvlZvW
         2Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004050; x=1779608850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lq35AOf8XMoPBRf51zQYzOvH5l4HY+x3jHyuSK93u4=;
        b=TRORFfsjNbQUa+YmhtkTxId7Pt8AJEDq1t8xYfFZRaE/+2GywhO3n20vN6deabyz3Q
         Qb9cuPXb0ZuCmrO2OwHaKV6qFOOW9t1XXWLhz3c4n1uqTn47Qx7uJHU/7EancNg6NXvl
         kW8EF9UMDSXFtb/WBBKV64OrO2pGTXlFkrbpYERgyShJqVqFr2wshXnLveAZ9Nzc37G0
         /yJftSvHwNCrezmBaEeAHo9U7O7cos9sMkH213Zh/o9g5t/oikIdd2uA0AUvKm4NixnE
         CcxKgvfDTiYXgb8q/52N0isyPRgAPdHOpff2wLRVqDAY9NdrJR/+BlvE/WhzKbev1zES
         ktOw==
X-Forwarded-Encrypted: i=1; AFNElJ/Po4JZHBbL7hOXYdI1LPWaC86TNKsBdGE+p2I7HlpRyTTcnPqXoOmdVDxRmKmPdJ2LugKN+BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg84a54tR6kNZCgLHWhCbYuXIkfaQ2BNDvwh9dRIJ/QWQs3oon
	HujrmuRRpzU7ZlNnC5A57tXxTmOjdeTZXvs5caqWl04zBSkZQq1NcfYt
X-Gm-Gg: Acq92OHwRB9nPmyhgZAf6FPrurkcigpOeJa908+ux9pTq3BYeLvfH2x4SRpsS3ZJT8P
	YnroKaFuUGg6Q+N9USuljm8qn9+0hMnjtHKMSbTgY4ZbR0B3ILnnowreg/A0AYzo52hkuC2idV7
	eHmwC2WnIXcqwJwhT5thDMpNOqZfgo0FyD/kesoocbXWThuIwkdG3NkyxxvnSR84GdGzyiYzEPV
	odYN18rHKn8DkIGaHA+16usrMizR0BnE4sOPvFmv0JeRorbbedQP9PbkgirbbG6CJg2kbzn1m33
	pHWFZhYICJBhID75WTAipnJc7MAExgoZoK6BU6DQSjhdMDX0mjgMYUQUvdWEIDL+xxRV7nbzu7s
	zzpherNs5aYdSjDm/srtkBz+alqcKFEVimyMzaRUmwp4egE9JmFBDKZs9NEOAIrBZZ+zh1ULM3M
	DX35s6kxBzritn3qY9dhbVKkBnWTX+pQ==
X-Received: by 2002:a05:6402:46d6:b0:683:1cc8:84ae with SMTP id 4fb4d7f45d1cf-683bc6b76e8mr5153525a12.7.1779004050379;
        Sun, 17 May 2026 00:47:30 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b50a34sm3925355a12.7.2026.05.17.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:47:30 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: arena: fix TOCTOU race in arena_vm_fault()
Date: Sun, 17 May 2026 10:47:25 +0300
Message-ID: <20260517074725.7516-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BF9655FC5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249067-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The vmalloc_to_page() check and range_tree_clear() in arena_vm_fault()
are not protected by a common critical section. A concurrent
bpf_arena_free_pages() call on the same pgoff can return the physical
page to the allocator between these two operations. arena_vm_fault()
then inserts a stale or already-freed page into the user PTE, resulting
in a SIGSEGV on next access or a silent use-after-free.

Fix: acquire arena->lock before vmalloc_to_page() and hold it through
range_tree_clear(), making the check-and-claim atomic with respect to
concurrent allocators and free operations.

arena->lock is a mutex already used by arena_vm_open() and
arena_vm_close() for vma_list serialization. Reusing it here is
consistent with the existing locking model and avoids introducing a
new lock. arena_vm_fault() runs in page fault context with
mmap_read_lock held and is sleepable, so taking a mutex is safe.

The pte_none() check inside apply_range_set_cb() is not a sufficient
guard: it prevents double-mapping but does not prevent the range tree
desynchronization that occurs when the race is lost, leaving pgoff
marked free while the PTE remains populated.

Fixes: a7d032218a53 ("bpf: Introduce bpf_arena")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
 kernel/bpf/arena.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index a1b2c3d..e4f5c6d 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -XXX,7 +XXX,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct page *page;
-	long kbase, kaddr;
+	long kbase, kaddr;
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
@@ -XXX,12 +XXX,24 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
+	/*
+	 * Acquire arena->lock before vmalloc_to_page() and hold it through
+	 * range_tree_clear() to close the TOCTOU window.
+	 *
+	 * Without this lock, a concurrent bpf_arena_free_pages() on the
+	 * same pgoff can run between vmalloc_to_page() returning NULL and
+	 * range_tree_clear() completing:
+	 *
+	 *   arena_vm_fault()              bpf_arena_free_pages()
+	 *   vmalloc_to_page() = NULL
+	 *   [window]                      page freed, PTE zeroed in kern vma
+	 *   range_tree_clear(pgoff)
+	 *   alloc_page() + vm_insert_page() -> stale PTE in user vma
+	 *
+	 * The user VMA then holds a reference to a freed physical page.
+	 * Next access produces SIGSEGV or silent use-after-free.
+	 */
+	guard(mutex)(&arena->lock);
+
 	page = vmalloc_to_page((void *)kaddr);
 	if (page)
 		goto out;
-
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
 	if (ret)
 		return VM_FAULT_SIGBUS;
-- 
2.39.0

