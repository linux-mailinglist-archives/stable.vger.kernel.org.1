Return-Path: <stable+bounces-67368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27A94F548
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B6C2823A5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D28136348;
	Mon, 12 Aug 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8T5Zs3I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15515C127
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481446; cv=none; b=LYnayLcGQsskJDlEb4abE8w64qMo+QHQsNEe9S1Jae4tvz51oxrw3JvGr39D0tK5u0Bb0vmWbqWUIk9JewdwHNsmV3aUYz2U4lfr4MlKbDG5iLdrourHaO9DRshx8wiB3GwDMZoi7UAA/2r3+6IReeJw+ywPpfYdUzQPhZJbesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481446; c=relaxed/simple;
	bh=DZesoZHTRWCbLwwNstyM7gJ5jwQEg9bMdX+DVGz6a38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2FsUVYgLM91RpFrTOthnNBhEvcZe5Lc8TnZyS1Aj3yz7p+vHMdsFy4blXQvc5x6P4bY/WV6fuC+yAz3yRCn78fJNy1Itn5ZhMghxKpoDXf5b5lZVWngO59N2Rx8YrVndp2sZqPtVh0JcK/AozYB4pyk/CV6GD/98pt3AdRdLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8T5Zs3I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso1105e9.1
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481444; x=1724086244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Pwh5Yck0NJ63ftZanRvFS8ng+FvBnwXPy4oihzU0QE=;
        b=I8T5Zs3I/mkAmqRSGbSiDGHBC9qfr90A1ObNkNOOwp9XW3UVnc83boxV2gVfxdysz2
         Inrid9RpbJmf3+UxclxitN9lqmCkAQxGzGBIpqEFNlWqS5ynsHpDeQgfWrAmjwh9BE2s
         hXHtcyqT4Oq1/iHSDDuA2PpjF7te0eZTFTBrgwSaE1veYS+Vzo/9GY9MTlNef1oRnEXq
         NavBLsuLWDMbsVt3iGi4QidHZxNEBUwvpQrLe3NjPOHm5fjfz7udyXIqHj/jGrBncGr3
         aNa0xPx1IPQjNvtyPO3Ed50xc63wVpscZbK2eMJNxyNYWEoYIdRggpeydgyeUvCk+MDO
         tNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481444; x=1724086244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Pwh5Yck0NJ63ftZanRvFS8ng+FvBnwXPy4oihzU0QE=;
        b=jAP2chvlBzmyJwmxc9RNEMFu6Q2t2ZnjCN4+m/AQO8aQTIthOduVuADqSAH5Z9e/81
         5K+dMeTzQuxVCXEUe4R2c/WgOwOx3qd2KWv0Rxr17JegvtYgX3ak+GmPTJuTCFvQy8lM
         Bl2EcRYIx1cfg6zLD2lL7GXna3DrAuUlMLk3UG1wlw23DcB74GByAP9v0F3g1/9yIKHH
         Mv80ZTVwN8c3EisrcjRVgK8gWjODwLcvk1pww610FzqqVlWk6xrin7in+hIgndrA37ae
         c1006ARhvO/84++rCRIHksoLDS3EcNx9yqYjYmhZLqKZ+eLk/y4E+eHVG1T/TAEz6PgN
         Cxiw==
X-Forwarded-Encrypted: i=1; AJvYcCWREuJ2eL0PPaWFY2tv4bnJQbeg/SWuZHLQwx6lLjz62C52ZyDGbjfnAc5+zraCdZrSWnZtiOEmi71Od/rVTZxj6QG7bjE+
X-Gm-Message-State: AOJu0YxhN3h+f/CC/91V7s8NAPAptq5ehN16ezNj+Ob3TCYIrzwSAXgG
	gcfaDZ2niqBBnpnpQnuODj0F+DmghmQk+yUiO9do7bV5C/5+ovefZjhVc5yQjsDMO+9ON9GMDYe
	pptCc
X-Google-Smtp-Source: AGHT+IHfHCfh/WSuaqttUqyZE+PyNP9LtWGsB/jH2gcAVk2r+RVkhkgxxEdBJPnJp7LHUeTtjOy/kw==
X-Received: by 2002:a05:600c:3d0f:b0:424:898b:522b with SMTP id 5b1f17b1804b1-429c827a41dmr2993975e9.1.1723480961958;
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3416sm7942206f8f.100.2024.08.12.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 18:42:17 +0200
Subject: [PATCH 2/2] userfaultfd: Don't BUG_ON() if khugepaged yanks our
 page table
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1297;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=DZesoZHTRWCbLwwNstyM7gJ5jwQEg9bMdX+DVGz6a38=;
 b=ZH3EnaCLnxnBAMGfLvSGP0Eka8HeLuZeSjPlA42GsqIFj8e3TEDej8ARd5JVzffIeA0SjAHpP
 K2ENAU38N1DDTzCRll9WxUJ6b3Q4wSjqJacAcWC80k9zPshbwINOyyv
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
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ec3750467aa5..0dfa97db6feb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -806,9 +806,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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


