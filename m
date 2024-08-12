Return-Path: <stable+bounces-67366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215294F531
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2981F21B9D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B81187342;
	Mon, 12 Aug 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYqsb+CL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D2187328
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481282; cv=none; b=i534OC0zUu0OGX0B5BitOWi/9tf2QTBUNyJF8yVRN+PdkyihNrnNGuwSY2U/u8Lpjv3o4W91rcoJFjaBcG/IEaJsV1BJrK43SclqB4dFT/p/oQ1Bo3eYvgm9h6gIZEkKU8EDQ4fkXtZ093mhXilPoiox+mxm1kJeUzq4HHc24cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481282; c=relaxed/simple;
	bh=cyEqwtJdd73Z0XZVi41RqSUaVwXAJZY8AuIAhW9WDHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lczTfX5TdO7e+f5J5eij3nr8Npi/CmmQk3AI/4PCQ2Iq8xQkvseODiQLgQErHyl6KKFBmfiYUzn+PrndX0QLb1HVmoYvyy9N6G/VNO4z9psO8Arbz5YrlTCRZv3G1CkTzUpCbJ7h4oKcWc+xgP4sqbB6e82ZhvjbILEK/ysA4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYqsb+CL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so71a12.1
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481279; x=1724086079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlU1qRayR5F9JUx5MXjL9SPDXmWr10IpUL5fPzVi5M=;
        b=fYqsb+CLR7WOOnNowxZDWxgZYJUbo01lF1XNxbct8JdtDQ5mwiMA+TBiaAAQIcp+rQ
         jXqTwm8wkRA3F07hQxlKKlu0Hq09jGdTgFFaWwFZhVl0rJYdPndPY/dJLCv8GU2gnM4e
         Vr04HcYWuJ2h3iANji7IRjhAU1LNx+qIUaSV3JUvjh/MNbo7RQkrM4Ys/XhhblkaVs7t
         y9Fb8meMHXIS8TMU+lISPnSCsqiZpFjTwGn1RysNPC1zmXkatVy9euYRtII+f8DGqnU0
         1lU/+sY4XJsoFbnldOkHL03vlRmDWurkd4siHUaRas7TVrPAnxZ6N02tHNZR90WqxyBS
         4otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481279; x=1724086079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJlU1qRayR5F9JUx5MXjL9SPDXmWr10IpUL5fPzVi5M=;
        b=byiN8Jd5RuThHZ9kpSrz0PyNbQOubMuSQAH0je55dKFMqDgGSNxE+DOiWQL6zwPGU0
         /PA7AgyaZBnVwHzW6quIixfEx7NkE7sy1IUk63OiGpkp/RtbDcgcm58pHicK7NaR1KgM
         +Xlzn5ECZqaLPyAAkVnob37OBK8Kt+ZWhV5CTxb9JJudS5OvX45PFDayvLkwDd+7wGN6
         e54dYUDDsEbzdDqTkejGIPiH3j1WSB7ebzcs9Rx9e0RYdywo6GcAB+iNWO1rt60+bKIp
         wkhzyHtFS481TzhBU4gS+r03wYE2fsbVu3ae0aA35AFFHJ5CE3586rrMM7pSmRe6OiUf
         6Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCWn1+RyyWJWkvXGsSAQLun/esdzREs2Mbmtame7X6BqmfbrkxWeqgMuUXHMk8zrPPL8BtrkQb32YrIwTF8CUFx3AhrnDBE/
X-Gm-Message-State: AOJu0YwLIr6IbcyHMw+U0m0G8HByQyWArY/P4yhxS8yZiiXgj4fU3Zyp
	yaiAkDu/ANfwxUC1KLtrMaWYxs3wHcJdoZ1vtDOVsewIPN9LaFOfUaKrfVIr0hbo4OcLWz9a0+B
	pxA==
X-Google-Smtp-Source: AGHT+IF3zlvPwjqUofQiL0ZC5eEQF3fcknxLRKQAkZEkHYcLKefHOkHnk0bRtOc+kUzO6CYwrPRQqA==
X-Received: by 2002:a05:600c:1d9d:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-429c7ab73f3mr3104265e9.4.1723480961010;
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ecc7ab6sm7913066f8f.104.2024.08.12.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:40 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 18:42:16 +0200
Subject: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1791;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cyEqwtJdd73Z0XZVi41RqSUaVwXAJZY8AuIAhW9WDHE=;
 b=aJA7M7sFrH6fD8l5+lxzjeojnHNOZEjoqfdSfrX7+15r0/hEZsfJhoS9jBzIQjwlC/09kjeLt
 aliIZZ7VCkXCOia7BI5iwegqhOGJUdxnMWHy2QCvS7PsVHzM0h5yHQr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The following race can occur:

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

Cc: stable@vger.kernel.org
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..ec3750467aa5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}

-- 
2.46.0.76.ge559c4bf1a-goog


