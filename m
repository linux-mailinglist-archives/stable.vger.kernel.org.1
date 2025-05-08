Return-Path: <stable+bounces-142934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD65AB05D5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F075C1C2710E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F854226D1F;
	Thu,  8 May 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKlKKkro"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F62222BA;
	Thu,  8 May 2025 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742165; cv=none; b=DfCJtCzHa6n14a++SIh3V2GFkNJZzckMb0X7LGzP46phzd4X21CK7pgzRZPuL5uIk/lVkDjrwMi5muyU5Dh9ROU/PkGCTzk7gYmjW+RizsBZjxlREtXnbI9SZoa3ZHytRauAHmjjmBqSlVcFT2oQtG7oiaUHsi4m7Q/DBvq88uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742165; c=relaxed/simple;
	bh=VXIalOPd7qfE59DRjVfo6aZAb2m474rAniDu80owj2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I2bx+SZ6OQBNlyupAbps3ZcjDoBYKAGOmp/KaFxCtsdKOvdEgKfoaJY7vlRlJ9i4XQLNEPZCnJ43V6ujKNOvD85MJWHuzmjOqZniLfq2FvDBvNle0h2fGpQZNFWu8ZQA++QQC7I8PwGFwiobiMZeH4QUnNcf5JETQEkO4kOGvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKlKKkro; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7396f13b750so1715855b3a.1;
        Thu, 08 May 2025 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746742163; x=1747346963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izwRWOO45q1gJjUhAd8RLBY3xuEu+OORG94FpQzpIq8=;
        b=OKlKKkroseur3UqEBk7CYJsk8PrzicHr3YRwfh8Vkp+/Ty+NACUlakDh3sEnzLLTbG
         bVZsrlAfWdpR1fHmvp8QnXFYzqh2oiss1xOTMufiy91LeoL7CU1D/bdPXC9C4F4ISjbF
         IFR+W9I4BuAs0HX9s5eWQaWoXXqyC4X5a+Fg5UVudPuL/uiajgd2cWf4CkRR/QHzK74Y
         LQzPealUwDGfKa5EkqpCr2P7JG7mE06I+o478GeDjc5+zxwZ9Hb0L6bfR2FXU9SEU2p6
         8k3R6Kd5rH5kY+9i02xCs2ISBCWCd97uj42cQTJA1JzhBv8pChJXdsCAHizOolRYEZH/
         GnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746742163; x=1747346963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izwRWOO45q1gJjUhAd8RLBY3xuEu+OORG94FpQzpIq8=;
        b=w/qIwyjkDvkQzYnO4I4/BS1aXVvvGAlIx+YSelOMe5T13tAB2oDjLRL8sjPlBZVec/
         j8lXORSdp3Bcqa9D6TjwVQeAM31DivM7xiadyh758n35IH0YmoHH/B+I+kRiTv6HvhCc
         KE10Lwh6YntCcyL9kFxoVKpDDJCYtzKrh8SK7Y2SykCg08J+HuK9ltPKhk8NFtQGe/Y/
         DOhu277Yop7nCFkSvMoGqI0u92iOcn/Gmh1hP8EFqde39rJRiN0IlLBX6ILOMXzPUpy2
         sbry9/s8osrEzeLMSFiMWcJHw4X038bshB3vSeI0BdVYmNGk02Vp9QmYo+01/60NySuX
         kItw==
X-Forwarded-Encrypted: i=1; AJvYcCVqdP9OTfkD1bSawnkWKf7t0Czah37RzykUTce0Ya8AzYMXSy7xUu+2WzRzofgcfDrDaTpyP1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywey+JJ0SJ96zLC+UGKoJhl5foaCUQRQfxv2ObvIQNNGYLVvsEC
	581hHV4ilknF0cwu5asWgmL0EuGAU9l+tw+MOUNHi0fgfrLwT2RA
X-Gm-Gg: ASbGncsCCR1lLeyDOCsvVfFBmhsZ36EFVfesSgX7fUI4TNb7+Z1Um41tv8YOvAUdMy5
	WIOmThGuRk0XgjdMJCjM1isA04hWx9mPRAaRwDDX+i6EG5ZTidS9I39oX404xF09MMQWrhUki/s
	bm8vltVVChaew2HEfBBoddFXDhtJuO47yfoJjOO4EQBy0H5yJZX4d3FedD9baTLoKxX053ZN+85
	dw7gTabAPcUgSUMps+rlNNPsJj1ajLIMMjaF16VTvwwXgiJ9n7bY2dITfZGk+sBfKoTEv1HoI9T
	WW3ypZGOh7ELxB++00u1y+t9I5ououhjahG7CIrrx2SMiQLrEN0+7XxK
X-Google-Smtp-Source: AGHT+IFkZ/rzCCAl+euvoNiSCCwS0EK66FZhD9x1Yb5CCdnY4h1LOdX0thkT3oEe3BUDFyuGOmH/aQ==
X-Received: by 2002:a05:6a00:4148:b0:740:921a:3cb4 with SMTP id d2e1a72fcca58-7423bd57d80mr1528325b3a.13.1746742162742;
        Thu, 08 May 2025 15:09:22 -0700 (PDT)
Received: from Barrys-MBP.hub ([118.92.10.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772750bsm533327b3a.42.2025.05.08.15.09.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 May 2025 15:09:21 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: userfaultfd: correct dirty flags set for both present and swap pte
Date: Fri,  9 May 2025 10:09:12 +1200
Message-Id: <20250508220912.7275-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

As David pointed out, what truly matters for mremap and userfaultfd
move operations is the soft dirty bit. The current comment and
implementation—which always sets the dirty bit for present PTEs
and fails to set the soft dirty bit for swap PTEs—are incorrect.
This could break features like Checkpoint-Restore in Userspace
(CRIU).

This patch updates the behavior to correctly set the soft dirty bit
for both present and swap PTEs in accordance with mremap.

Reported-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/linux-mm/02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com/
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
Cc: stable@vger.kernel.org
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/userfaultfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e8ce92dc105f..bc473ad21202 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1064,8 +1064,13 @@ static int move_present_pte(struct mm_struct *mm,
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
 	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
+	/* Set soft dirty bit so userspace can notice the pte was moved */
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
+#endif
+	if (pte_dirty(orig_src_pte))
+		orig_dst_pte = pte_mkdirty(orig_dst_pte);
+	orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
 
 	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 out:
@@ -1100,6 +1105,9 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
+#endif
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
-- 
2.39.3 (Apple Git-146)


