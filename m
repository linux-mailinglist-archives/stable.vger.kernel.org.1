Return-Path: <stable+bounces-67546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B31950DDA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FBBB276C7
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EAD1A7056;
	Tue, 13 Aug 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxTo4p+5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079A1A4F3A
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580745; cv=none; b=i0Vmhc6l8moEN+yyvPvFddtU4AN6ZBMp76RQjP36MkKibB/tqZ8KhsWtW9oeF49Oyqbylapc6qULKgaLaZOhU6s04MNk4x+K6W5Ov0d30GYtyWMtqmeJ3BRrCieG1yNg8ceetIbXqcpXw4yZUp40uU3I+et45L82RmNEDmfW5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580745; c=relaxed/simple;
	bh=NjEb/5kWU2ZKZsYUDCoXZhjVmSL4k/e2MGJXrVl34QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+fN+MsWFr1BT/5RHLeUM+vJ6PaqaRg1UEyhl+c2gD8GRGmdjLm7ewIkAAdHhvUNcTAazABnTxMh3otDGfUxmdPaMx4fM54kHWPGDV3RxuA6V9CzZg+Kuq523aBM214PQxwkUjlKfe5D0UhGdWJYsRg2e+eHBeUy24e/10ex3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxTo4p+5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso2685e9.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723580742; x=1724185542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xs2mtlmkE8RENg4xcjJxmH3AsBKwUjYWFgttp/hIQKk=;
        b=dxTo4p+5KkvQ9CsTVJgQfAcJ6atD/Bgl7HDK1yKBAWSd4rzYXBOR2R4aEdauCxMtvK
         OEon3H7Au0nLxfNEQ+/u2u+n2p++uDeMfMIQNpT1zl9mX8l2+cpqIekveBOX8V8lyDDI
         b4Qzy7IN1SoC7rXYCD5kDPWUZnXt1FdmznQvSIvV3NufpGXzZCK98oye3a7J9rEhXAEN
         lLG76oskUhWb08O/XyUa7LF9SRr76SQHpthLNiWutQEMK/fKX9p3DA7NV4cXxwcI3HtM
         4l4qT/FByvIQGSSgcppm1g/f011ZQoVeiXOZSnWeYmGT7cI5xmxMwqo8kwaX6YjK9PGu
         AZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580742; x=1724185542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs2mtlmkE8RENg4xcjJxmH3AsBKwUjYWFgttp/hIQKk=;
        b=Ski6cTxnxGpk7IPEtctmxhWcoJwxR7TCHt//WSWR4EZkv4o0HgGvA0ea6pHShqhIe7
         sC7eWnRJcQmaa/XS+GYJ1Lt7Oe1bZh50IdK4TMs7JUpLJrW4yfmLUEc0VNNPTzcy9A04
         8wVQOBYdbDAiHQXH1QXipuyET935wdLIOEi5+qbgepBfRU2BzDpZOgk3hHcplsh3L92u
         qxgSVLIbOnwhBsCq09wA+U0ODtKsyZbH5nSGCLjLGalE3KR9S6p6pA+H/lEwLujRG8Ui
         1XaF8Ge9Z4XkF6/oCbSRvVnRDNt1bLcMz4jODXMzg62YA1rrY1dIrh3gBiBWFheYT/f9
         mPrg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7cnmS6dEVRdMqqg4R7JqNAiA3fgh931hElK1vyxW0NzV+22Q2JAwCtL4z/hLo4PN9ZtK6XJpq+r6uyQAhHBl7UPlMjW4
X-Gm-Message-State: AOJu0YyWckPPlkUVxA831QUGzol6NPAx7o08kIgwpQ2ofVWjvIuEoyND
	/jODmfsK/AqYCPOsDEqr0S02BHSVtxNvQHuT8wn5faqJYEcRnLAgW/hz5fidWQ==
X-Google-Smtp-Source: AGHT+IFO4Kwu8LOnDCVoNHKE9IDgnB2lyd4k/4Eah6HV4M7+c2hknCrXNstVkl9ev/iPKDtfSvDJqg==
X-Received: by 2002:a05:600c:1e24:b0:426:62a2:dfc with SMTP id 5b1f17b1804b1-429dec3dd98mr5415e9.5.1723580741697;
        Tue, 13 Aug 2024 13:25:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a608:a4cb:f4c2:6573])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429deb4c1bbsm910225e9.20.2024.08.13.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:25:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:25:21 +0200
Subject: [PATCH v2 1/2] userfaultfd: Fix checks for huge PMDs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com>
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
In-Reply-To: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelianov <xemul@virtuozzo.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723580736; l=3813;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=NjEb/5kWU2ZKZsYUDCoXZhjVmSL4k/e2MGJXrVl34QQ=;
 b=BJybKHoOx2uHAvfMX0klbtA/6hnFPEr8ifxsqo6HrIRCT1MpuWH3+pMSr68JQN+RXy0lPCIuT
 FleIsksNrFQCttylm7aL6gN/0i9yu5T6ZOyquKvGCEyUVqVI7VwWUvq
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This fixes two issues.

I discovered that the following race can occur:

  mfill_atomic                other thread
  ============                ============
                              <zap PMD>
  pmdp_get_lockless() [reads none pmd]
  <bail if trans_huge>
  <if none:>
                              <pagefault creates transhuge zeropage>
    __pte_alloc [no-op]
                              <zap PMD>
  <bail if pmd_trans_huge(*dst_pmd)>
  BUG_ON(pmd_none(*dst_pmd))

I have experimentally verified this in a kernel with extra mdelay() calls;
the BUG_ON(pmd_none(*dst_pmd)) triggers.

On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
a BUG_ON(), since the page table access helpers are actually designed to
deal with page tables concurrently disappearing; but on older kernels
(<=6.4), I think we could probably theoretically race past the two BUG_ON()
checks and end up treating a hugepage as a page table.

The second issue is that, as Qi Zheng pointed out, there are other types of
huge PMDs that pmd_trans_huge() can't catch: devmap PMDs and swap PMDs
(in particular, migration PMDs).
On <=6.4, this is worse than the first issue: If mfill_atomic() runs on a
PMD that contains a migration entry (which just requires winning a single,
fairly wide race), it will pass the PMD to pte_offset_map_lock(), which
assumes that the PMD points to a page table.
Breakage follows: First, the kernel tries to take the PTE lock (which will
crash or maybe worse if there is no "struct page" for the address bits in
the migration entry PMD - I think at least on X86 there usually is no
corresponding "struct page" thanks to the PTE inversion mitigation, amd64
looks different).
If that didn't crash, the kernel would next try to write a PTE into what it
wrongly thinks is a page table.

As part of fixing these issues, get rid of the check for pmd_trans_huge()
before __pte_alloc() - that's redundant, we're going to have to check for
that after the __pte_alloc() anyway.

Backport note: pmdp_get_lockless() is pmd_read_atomic() in older
kernels.

Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Closes: https://lore.kernel.org/r/59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com
Cc: stable@vger.kernel.org
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..290b2a0d84ac 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -787,21 +787,23 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		}
 
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
-		/*
-		 * If the dst_pmd is mapped as THP don't
-		 * override it and just be strict.
-		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
-			err = -EEXIST;
-			break;
-		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
 		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
 			err = -ENOMEM;
 			break;
 		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		/*
+		 * If the dst_pmd is THP don't override it and just be strict.
+		 * (This includes the case where the PMD used to be THP and
+		 * changed back to none after __pte_alloc().)
+		 */
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
+			     pmd_devmap(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
+		if (unlikely(pmd_bad(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}

-- 
2.46.0.76.ge559c4bf1a-goog


