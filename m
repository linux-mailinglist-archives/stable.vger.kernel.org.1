Return-Path: <stable+bounces-76170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B987979A64
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 06:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9061F22C6E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909241BC58;
	Mon, 16 Sep 2024 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdw4a1lN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DD200A3
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461292; cv=none; b=OTLLfZaJwL7BKZC9umT2MJ44LlfBDkuxeiNxhgRxXFUbGhRTWPA+UA/CUXg2cRIX6fdgu7d2IcAgLSGO9DR5sziHQL7FHS6WDGDL8BRoBQZhnf7YMINVi/Tnhr2O3bqDHVzAkibJswdybf/ohNxs6IULmYflXnsTFpBSS664Foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461292; c=relaxed/simple;
	bh=ThWd2UtxW2x9I+IYpHMl4gRO7sgS6KMVeEq07neoMMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YAsfk2XCaYSTIWbLUV2aGKKFIClBx3a+UOo5au7ei0XyhQFgrgf7aOz2HhowFkr152UYQiF56wsNA1KsPeqt1gsxcEp2jKYslTAS8u+Oc2dJWSzqmWunw74gwkHhbCQvmXHuv3csb7Mdrp7Vux4AqQJu+iMKLPalk4H1Mma8roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdw4a1lN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4bd76f5a8so123456197b3.0
        for <stable@vger.kernel.org>; Sun, 15 Sep 2024 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726461290; x=1727066090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c4EvMoEy9WsXEBcEuZ7+o7nbPZhcyr/e1sU0DElzMN0=;
        b=qdw4a1lNOa4cb7Mx86nNyFyjMeo7ZU28mNvF/4Z2yBDzAzzY0ZRD7QRCmCi4LJzbgD
         FN6ft+TD8EbH45cu/1BiONe8llY4RRq0XrF4gopbTKJu7IQJMlGiwrnvnFvb5QQ5Ce2I
         rUzw2vxrgZpapaSivg3ha6vboG6iAd+dVZ8LLhTvJPhCisjlAECwyxARemW6XLx42K7u
         Xnchjm1L+mqzbdUnreTWG8B+SkqQM9cYZXXVNRNLYks76/V9JbYtW7fh5O9ntietyn70
         BLtUsUpdkEklt9DD07cKi2q4R0lldx+BV0HbXnXkqMtbqqCQUz0c526imZ5eYTdd9J2b
         yOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726461290; x=1727066090;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4EvMoEy9WsXEBcEuZ7+o7nbPZhcyr/e1sU0DElzMN0=;
        b=nZXv+j3EBWQCW/aK1T5qBOwdKKf2/tNm8F+jm4+8oaqXVlBXqzlxiuT0sk+d0zYANL
         9yatUae7s9SCy2xpfhbggJbISJPRuTmuBjTrz1O44FGRqEB+GDrr0I6zb173uKg/GmkC
         Op0N30Xv1+nykinB8NNAR2pQ7nMgLEbMlzEKop0b/8/vq7toPmfzu2SG+Gg4f3n58pcI
         oWd55lz2pj0FpinGWi8zNx2nYIqDWopNs0Rpo+sj8uIiPLpE2xyomRyJUgK3z0nB8yoc
         blJVc/SwOH0j2C8cI/fddG0mT+uwI8cuKgbw5m6qJ14+rvJFP8YivpGD5CbyHvIomSau
         2rdw==
X-Gm-Message-State: AOJu0YzV/ov6dFBt8kc/yhOA4xPyO6hZM4MQ/i87q+E1lkC/MXgxqR+m
	U04vWpJGwOe8P+tKHYZg73P/VuE9CwmI2SbHOJ1rWuJ4isQVjuSmO87GZUmryAEhkOJwsOEs23B
	VToIBp7kTGZXh9ZpyEIFkUQXXETaB81xoT98eB+QmXjadynnhaU3ddH4crdhkRsnnqa91cYsitm
	T4dSYTPqJwjISKQBPwL+8BOXnt2brqW5dCtUxu1qsvYqMRJSKI
X-Google-Smtp-Source: AGHT+IFZXNg0p9y252GxKOJOb2Y9hhuDrzInlFSAAnhXSNxuisxh7Zhe5DG4/ASRPIS3vWLY7PMkUPAUooq6OPA=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:690c:338e:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6dbb6acf2ebmr7690517b3.1.1726461289617; Sun, 15 Sep 2024
 21:34:49 -0700 (PDT)
Date: Mon, 16 Sep 2024 04:34:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240916043441.323792-1-tjmercier@google.com>
Subject: [PATCH 5.10.y] dma-buf: heaps: Fix off-by-one in CMA heap fault handler
From: "T.J. Mercier" <tjmercier@google.com>
To: stable@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>, Xingyu Jin <xingyuj@google.com>, 
	John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"

commit ea5ff5d351b520524019f7ff7f9ce418de2dad87 upstream.

Until VM_DONTEXPAND was added in commit 1c1914d6e8c6 ("dma-buf: heaps:
Don't track CMA dma-buf pages under RssFile") it was possible to obtain
a mapping larger than the buffer size via mremap and bypass the overflow
check in dma_buf_mmap_internal. When using such a mapping to attempt to
fault past the end of the buffer, the CMA heap fault handler also checks
the fault offset against the buffer size, but gets the boundary wrong by
1. Fix the boundary check so that we don't read off the end of the pages
array and insert an arbitrary page in the mapping.

Reported-by: Xingyu Jin <xingyuj@google.com>
Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
Cc: stable@vger.kernel.org # Applicable >= 5.10. Needs adjustments only for 5.10.
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240830192627.2546033-1-tjmercier@google.com
[TJ: Backport to 5.10. On this kernel the bug is located in
dma_heap_vm_fault which is used by both the CMA and system heaps.]
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/heaps/heap-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index d0696cf937af..a852b5e8122f 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -161,7 +161,7 @@ static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct heap_helper_buffer *buffer = vma->vm_private_data;
 
-	if (vmf->pgoff > buffer->pagecount)
+	if (vmf->pgoff >= buffer->pagecount)
 		return VM_FAULT_SIGBUS;
 
 	vmf->page = buffer->pages[vmf->pgoff];
-- 
2.46.0.662.g92d0881bb0-goog


