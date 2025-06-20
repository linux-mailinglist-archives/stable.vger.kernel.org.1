Return-Path: <stable+bounces-155189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CEAE241A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891F8168F27
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D523814A;
	Fri, 20 Jun 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAmufYB/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714A23717C
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455342; cv=none; b=jb4XINiStpaE8FLsf/OvFww1B5wjo8Kh34+82KAgUW5cxH016I+hC2V+y2DtnATHM7nV63dZC9I1l1UgZHe9uxmciVgRANSX6CmZAagszPjUnJCWAJD9wZ97/53zPA0vPrTvQApB3zKsOosiRt+Ff5j9nUQUwDqk2Gd5Ibp2cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455342; c=relaxed/simple;
	bh=dR08lLEbVug+dWi4DZoxqQjPpG2+ljvtZ4aHSbMUOw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqcoN9j87YT+7qEgfYjGwyZVAhj6ze8K7D4bPhNOhCRlrzWRolZJY7CPhaSrQ9J/SDQAexGnNmEWI3CYeoI2mTs/JNi0cjBy5GU5eDoDsIFNQzlk8pltb1JpFEey7MjLLiPUB/P8rgdwpuAyF3uL9oT2OD0URIXUmEoD1kf92bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAmufYB/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450dab50afeso14385e9.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455339; x=1751060139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODRmW9snA0fKgQq7mhHt8liuWyfdc+mhhHPFT1PRR08=;
        b=kAmufYB/9q6MNI2a1k3RmCqoj76wujW14dajA4vy2uusreV8vZ4L0CYmWO0VuSbcV+
         qwRm38ucwvKz+XGuSXpuhZOK1Q7j9ECxMQro3EMHAbWeI/VwY2RweddMzJYk6J1P3nH2
         Pm/q9/nt71g+zDgAxTi1x4iIzC32DLqNlvRyEe6GrstL+A9njWX5xUBdqZBNFVuB1fWj
         ZZdc+O7pgD+75uE7IO+Fz75BJSOjriSYCsw8Gk+pfZf/3I6ppOTYkdoDPdO1VD9nkJlf
         8PX6W1x4zHXs+P59k/f4e2DSo1xknPqb3W/8RoM+HAIyvcg6boTevEWT5XfHVO/ZNzxW
         g/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455339; x=1751060139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODRmW9snA0fKgQq7mhHt8liuWyfdc+mhhHPFT1PRR08=;
        b=NqXpveGnr5mjy34AFpvHbpSUmrZMETbULt4fP+cM3bdM8fgaKO2/zuf+ecMgsw/8jm
         tjfz1koUKHsZ57l3BgCasN01bjaZ2D3NIaoKdCt9agN1a5VyF9c0zztQUlWLW2X1hDrN
         xE0Y5Irnj3fmQ4PwypUBW+1JPoAFPLK5LBntkSfSdCqnoI7lbKNk4HFIUdBlaY2lndww
         7bYxUwR3g7td10QuDksn7OdN/6P/6iiP+DqQvlnEOkwuqCZPz6yA+mHCjlaFfcig0YLa
         Jefxf+U6nMz/nz6nzER8hC9fg597voCuQUc9Jf1GX4h3/jzfFseLTUk915DSn9uxfwLJ
         lhRQ==
X-Gm-Message-State: AOJu0YzbdcVTZlLxa1gb8fvgbr97WzQ+BTvycR0znMavybeNeyyxZ8SS
	k9g5YXJF85tdspIRRUJr7Uy7xfhYUceM9b+OcsGIv5oPAAn8uTxdOzEf6X4araGCNLYMW3Eh/my
	/9nQf+Vz2
X-Gm-Gg: ASbGncuAiksKGgYgydFw2Tgg5ntCiPiHkB+t8qaGe17WzBUbvXaLPVBnnaxLGT6CBdK
	g0hodXTYqDPgqXD8KMEj6WV/SXR3xMBbBc3Czf7hf6QergSdngEZksZLHrc5FfXEuR1PzMlQ0za
	eTfhKw20a4x35lEipwrfPQo5v8oKqnBkGwhERcTdpF6xLnhhsOXgtv9LDQnB91O06xXwEZY7+Nu
	GBFlki0IwCSLW1/isQF32ZZn/G4njAPMnxBawzYlfJiRlxGlDoL1u6kZw/JuokTOJBGorcSSBnd
	Y98Z3FMabSoGMhjUPZY09rRmlhLxuzm1LcaEJThhqzCYuyBC4w==
X-Google-Smtp-Source: AGHT+IHljLvhvNe7/C3mNzwaZu95kN5i/BxbXUzFbRcJTQMHBa62JIsziCraRDvqVAihZ3tIAByvYQ==
X-Received: by 2002:a05:600c:8112:b0:442:feea:622d with SMTP id 5b1f17b1804b1-4536b54b58fmr79455e9.1.1750455338359;
        Fri, 20 Jun 2025 14:35:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6d0f19e7dsm3106681f8f.38.2025.06.20.14.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:35:37 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 3/3] mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
Date: Fri, 20 Jun 2025 23:35:32 +0200
Message-ID: <20250620213532.159985-3-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213532.159985-1-jannh@google.com>
References: <2025062042-thrill-gyration-f247@gregkh>
 <20250620213532.159985-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

huge_pmd_unshare() drops a reference on a page table that may have
previously been shared across processes, potentially turning it into a
normal page table used in another process in which unrelated VMAs can
afterwards be installed.

If this happens in the middle of a concurrent gup_fast(), gup_fast() could
end up walking the page tables of another process.  While I don't see any
way in which that immediately leads to kernel memory corruption, it is
really weird and unexpected.

Fix it with an explicit broadcast IPI through tlb_remove_table_sync_one(),
just like we do in khugepaged when removing page tables for a THP
collapse.

Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-2-1329349bad1a@google.com
Link: https://lkml.kernel.org/r/20250527-hugetlb-fixes-splitrace-v1-2-f4136f5ec58a@google.com
Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e45773b08b5c..bca110617f51 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6092,6 +6092,13 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	pud_clear(pud);
+	/*
+	 * Once our caller drops the rmap lock, some other process might be
+	 * using this page table as a normal, non-hugetlb page table.
+	 * Wait for pending gup_fast() in other threads to finish before letting
+	 * that happen.
+	 */
+	tlb_remove_table_sync_one();
 	atomic_dec(&virt_to_page(ptep)->pt_share_count);
 	mm_dec_nr_pmds(mm);
 	/*
-- 
2.50.0.rc2.701.gf1e915cc24-goog


