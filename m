Return-Path: <stable+bounces-67547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D3950DDD
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 22:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C19284452
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8F1A706B;
	Tue, 13 Aug 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nq6cFsC7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C31A7043
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580746; cv=none; b=R+iefIgsXLimriMPVXYhAZO4JCtjaKWVJWFnduOTiCMi6xBVnqRJOUvhE0K/oU8r9B+MBpHaUZMmZxWzkTSYtqwq/zDkaaos1ezXReFkDZnfa7DYhX0//Xx2ZbOWi1ONIQcHiIjtLtb+2UUyxKVS7kvYW2eR6iLGWnVbXADGMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580746; c=relaxed/simple;
	bh=tzIAzt339urOnQP09jTAjXTel5g3L+lCAuxLVJJcPg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8O79PXa3iwMxQcDspdR93yCL5/SNpscPhXl9MstZavlc3hu5r3R2KuOYD+lhYvlUnASSxmFpMiRrW+01tjDyzre3HUWjNca5mDbjbX/F8sv2y8z3+0Eq/cPzRg/JiVo8DDcRMFIoJhbUOtc4BW4AaCyUSE576pt+k9gk2BoXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nq6cFsC7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so9945e9.0
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723580743; x=1724185543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8hC/8u5rHQIE5OTDIzO5nzE5ccZrI6SAOcdv8SAfDg=;
        b=Nq6cFsC7R9m1nkBGwXL8XV5lNp1CMHOmel6arhe4m3i2d0zk2qFJ/9rhLIOb5jUjem
         180RAWApLDXqQ0v/ghxPslCcWt56gG1+NS3CyYRhEsULlQx9MMrhJLi1i/o2Xn4EHDoM
         TB/lz+NJ5tnf+0Y73MxL+A9FZWmfCat9Tcg/UEkuFsP9pht7SBTHtZEHmGf57Dpm0zCR
         FijL/PozcaZFA7abHphrB0tjAtaomVleSzOdkEUPQmPTxTgEbvLLYpmOao+X2JVoCzMJ
         Z7WbJUGWRSO2mfgg2gIPqQ04nFkUVOPB1VxozmIQkqLSPMLzpit63ZOjDRVVmEw2RyEs
         93bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580743; x=1724185543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8hC/8u5rHQIE5OTDIzO5nzE5ccZrI6SAOcdv8SAfDg=;
        b=iFx8bvu/mammWLosRkQkV6aTTsXVFtxkjF/UqCF4myhQXFYrVEIYOzb5APmaVjvT03
         K21xxq4pZCQS94UAgob/+xKtAAeoNuTLYEmVjtOgPVVLff5OHrGohPFPgqggRHd+z0Yq
         Wr+LpUnVt+YHe/cq4H7UgUsQu6ks65+OakOdKWIPKdK20EXyjjd++6pYAE/Yo0zqZ2pL
         ep0CbIdEi+a6SAoMM6CHRplMqlvnbzI17H6CoGToEC2KeA5cKVZGOx+KYB2cuAzv3Dcf
         Lc7TgObAkMd9dip1Ku7110YCWXcb7Me1bVzgCXroXiJbK4j5gnpE1m95+PUM0rMN9rLb
         4zQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJOUx+XPQPnDNJR0zfyRdFtjM/aysAHdQ8QT3xXQ3GJANqfsRNoZK7tUJVRBzLsMteHIYQ3tIwZ69vnWPETDq+zRXTGan
X-Gm-Message-State: AOJu0Yy76A25G8fAkF/CODcrk9tO+9Ja6u7LsnGR4ZHp9XbwvFZxKT9z
	pFivw8e7d3e+ws+e/euEZqI83yzx7qhkY+ivQW8U5B1WCqlYkL+4CODjEnq+sQ==
X-Google-Smtp-Source: AGHT+IGLLbA7isZyCSmnyKczKWq9+cyJGJEJpYUawegxPAI3pwvA6i9O/zVRBIs345jqiM6wxH4Ilg==
X-Received: by 2002:a05:600c:501f:b0:426:7018:2e2f with SMTP id 5b1f17b1804b1-429dec3d255mr5555e9.5.1723580742844;
        Tue, 13 Aug 2024 13:25:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a608:a4cb:f4c2:6573])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877f234sm26530545e9.1.2024.08.13.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:25:42 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:25:22 +0200
Subject: [PATCH v2 2/2] userfaultfd: Don't BUG_ON() if khugepaged yanks our
 page table
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-uffd-thp-flip-fix-v2-2-5efa61078a41@google.com>
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
In-Reply-To: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelianov <xemul@virtuozzo.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723580736; l=1397;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=tzIAzt339urOnQP09jTAjXTel5g3L+lCAuxLVJJcPg8=;
 b=U5pU3rpcbs7XfZhd6TtUWxvTgQAQAflkgJ5K+vZYgkKpqqGS3XYHTVRAJkLG94mCVkVX5F7fz
 XY0Lb4AZrHXC6jrhYrjoIfRyPG3EWQwDdn3PUdv78rzxnTrCvAGxNWq
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Since khugepaged was changed to allow retracting page tables in file
mappings without holding the mmap lock, these BUG_ON()s are wrong - get rid
of them.

We could also remove the preceding "if (unlikely(...))" block, but then
we could reach pte_offset_map_lock() with transhuge pages not just for file
mappings but also for anonymous mappings - which would probably be fine but
I think is not necessarily expected.

Cc: stable@vger.kernel.org
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 290b2a0d84ac..acc56c75ba99 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -807,9 +807,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-
-		BUG_ON(pmd_none(*dst_pmd));
-		BUG_ON(pmd_trans_huge(*dst_pmd));
+		/*
+		 * For shmem mappings, khugepaged is allowed to remove page
+		 * tables under us; pte_offset_map_lock() will deal with that.
+		 */
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
 				       src_addr, flags, &folio);

-- 
2.46.0.76.ge559c4bf1a-goog


