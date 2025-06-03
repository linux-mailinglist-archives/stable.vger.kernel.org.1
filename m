Return-Path: <stable+bounces-150746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4DACCCC8
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831493A3C42
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6B288C32;
	Tue,  3 Jun 2025 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYu6JARN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51094288C0E
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974878; cv=none; b=SI09EzUYK3EuqBeEMeaF35ANYy27nh0Jc2JMfixfqSp5IzGquErv4O77VWBDAO5pWZ6qWrc2mP2+k+qFtZZMSEvs5wsuUyIo+hzi7N18XnDFcgHPypW983mbiby5zcL8Kcz9FsLr6t5U3qjuKtfJdX8zgdD/ZtzhjcXQoy8nLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974878; c=relaxed/simple;
	bh=dKdCCyeFq6LySYsnlmhBK1IaYpelr+oq3BA9S1KT0HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9fzS9eGKFDrdAQGpfiszG3kMF6FkP/VQ/K+qtmTKmoy+veno9TY4x4Y5MlZE0sOlbZ/Pt3RrhHzwYBO8vP+HdnRmbSJ9nHrNLNxrniEQa3cwrDB07UAyUQ2x7M5aVVA78eOqJgq8+QPJQi3G8cjwRko2kFZUltb33CVgtxU50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYu6JARN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450dab50afeso9185e9.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748974874; x=1749579674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx0neXVgtNC/kVhbJbk2XialOz0qQ4TlGtQ7P71fgqA=;
        b=bYu6JARN1H+G8w92zz46VlfYaj9qEfPMuCjpGh9Cbhop7o4VUkzcOn0FLQklP3xDsB
         VC+U5UtndscGyMXTE05SlsRYcaEqS5dQ6kZeeh8eKLlWD3i0tx8Lu0Q2L5ZUjV02xqDH
         xLpWonut4kmWIcewMauGA0NO/E48qAPLJLpUgaP2XOudFL2treaw+YPYCMaCkEa8B5Gm
         VLDkj5gV5TGzvQWObtRxYE2ls+Cg0MIW1t94vUJnbAngtSVYHcW5TOS4WIylu3Mn+Rz3
         7hMiYcYXFdZ2Uh/rYQYyP+3hIi1npaSquS4W+yEcYKvuaNz3OSU5KcQN6LEqJyKFE+Ax
         uh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748974874; x=1749579674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx0neXVgtNC/kVhbJbk2XialOz0qQ4TlGtQ7P71fgqA=;
        b=wZMMTeDV7aDx42dMxUrsgfCu7SkdTm7dem2rkYDW1zraUjoJILgrmxSJIVRwhdbl3r
         istYxeOPy2A9POWHRQdzCp+5zJJFYL9ILgZLmNlYLZJOlsEEjM21KW/230mebELcvbqT
         ZV6LxTmtT9KL6uofMphJwYwk9hANkuWOLI+j6tEMpaLp7D1qojObb1rc5NxsvnRepX4K
         x5odb/hn18M+eV1be7UEF0yEcuCOg7BjeZVBVuZMZP/ojptFC4Sgg3OHfvGvowK08AuO
         5cirh+52Ck/VUJXFwjE54DUeiMf5BYRKklXmmg2L8eTJ5lLrpR6BILlARZGlWc5tA28f
         of6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsPXxF8kYEHcYHt5lLacy9uJ/1TnzkK5fjDMxshHor6D1ZhpAQ4ZRAZNk12cuG87//VV9JjPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3jpofU3HcSt9ZfY08C5oSSVshfJSxdFS1HHPJrOCHSH7dLtY
	ei+dG4TQGGmSIzgD54iKPtEWhoZCICO2/e9FqA4fkTOWsqHjphyw5Iv36GjoO/p8qg==
X-Gm-Gg: ASbGncuaU2uNUHnZMcMJZdGJ3Oo6jNGVleizfDWRYNvhMNq6fvSuzHlV4KioS//1Skl
	RcZJJ8NWHX90voRz6PWqZfxa+0UYUsFUF91JLHEsBAYFCgV0gnrvxPlVnw9ziiK215eHnq22hWH
	gs9dqFvVqhqhWLKF4qp5GbPqUc/g3rSAWi6MEfDcEgk/qV8tQcu4v+i13SnL+TFykRL8rdj1b/v
	TBz9TLQ/MDVwFQPG6EejahzpZlmSDWDw1lyrizNLpcDkX9yP2ILOboEwy/oKc+jjqJo3g6mgYeO
	R/xnrkdFIMKMmiVDP74BgLFicGHN1J8hVzKfclXu6ikoDHeBhw==
X-Google-Smtp-Source: AGHT+IG/MDcPn3lv3392MJVxs0YSZE8tHIiSmeSX+GAcuLe69+/JxBU9ary9/s0lV/XWjZK4w5fp0A==
X-Received: by 2002:a05:600c:a49:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-451ef81dd27mr74105e9.0.1748974874117;
        Tue, 03 Jun 2025 11:21:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:796:935b:268f:1be4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fa2541sm166778185e9.15.2025.06.03.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:21:13 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 03 Jun 2025 20:21:02 +0200
Subject: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
In-Reply-To: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748974869; l=3052;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=dKdCCyeFq6LySYsnlmhBK1IaYpelr+oq3BA9S1KT0HM=;
 b=GoRay08an3IgCzb96xM4NNdXnjvH0pAT1kssW24Wshk8I9JFTVg7UcCciTteDEoS3hNae8Ri7
 CahzDeKuKUmCzyCsIv3BsVwz3E7fQlRhOKyUi+wEAqs9YsR6eDq0UPP
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When fork() encounters possibly-pinned pages, those pages are immediately
copied instead of just marking PTEs to make CoW happen later. If the parent
is multithreaded, this can cause the child to see memory contents that are
inconsistent in multiple ways:

1. We are copying the contents of a page with a memcpy() while userspace
   may be writing to it. This can cause the resulting data in the child to
   be inconsistent.
2. After we've copied this page, future writes to other pages may
   continue to be visible to the child while future writes to this page are
   no longer visible to the child.

This means the child could theoretically see incoherent states where
allocator freelists point to objects that are actually in use or stuff like
that. A mitigating factor is that, unless userspace already has a deadlock
bug, userspace can pretty much only observe such issues when fancy lockless
data structures are used (because if another thread was in the middle of
mutating data during fork() and the post-fork child tried to take the mutex
protecting that data, it might wait forever).

On top of that, this issue is only observable when pages are either
DMA-pinned or appear false-positive-DMA-pinned due to a page having >=1024
references and the parent process having used DMA-pinning at least once
before.

Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/memory.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 49199410805c..b406dfda976b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -917,7 +917,25 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	/*
 	 * We have a prealloc page, all good!  Take it
 	 * over and copy the page & arm it.
+	 *
+	 * One nasty aspect is that we could be in a multithreaded process or
+	 * such, where another thread is in the middle of writing to memory
+	 * while this thread is forking. As long as we're just marking PTEs as
+	 * read-only to make copy-on-write happen *later*, that's easy; we just
+	 * need to do a single TLB flush before dropping the mmap/VMA locks, and
+	 * that's enough to guarantee that the child gets a coherent snapshot of
+	 * memory.
+	 * But here, where we're doing an immediate copy, we must ensure that
+	 * threads in the parent process can no longer write into the page being
+	 * copied until we're done forking.
+	 * This means that we still need to mark the source PTE as read-only,
+	 * with an immediate TLB flush.
+	 * (To make the source PTE writable again after fork() is done, we can
+	 * rely on the page fault handler to do that lazily, thanks to
+	 * PageAnonExclusive().)
 	 */
+	ptep_set_wrprotect(src_vma->vm_mm, addr, src_pte);
+	flush_tlb_page(src_vma, addr);
 
 	if (copy_mc_user_highpage(&new_folio->page, page, addr, src_vma))
 		return -EHWPOISON;

-- 
2.49.0.1204.g71687c7c1d-goog


