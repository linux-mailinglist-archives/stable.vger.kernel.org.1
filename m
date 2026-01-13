Return-Path: <stable+bounces-208266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F0D19156
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01690300FE0A
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CB2BEFF1;
	Tue, 13 Jan 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwDW3RO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E2257851
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310505; cv=none; b=XsY00dzmhqmqk0VhC0GHq7WEL86OOiQ6A+zOD5hQwNUx/ia60DUBar5OMy0Wc0nMJ2h4W/wyxO6WgO913PQgrG4ugk09ertZGHgDnr+PthPwc7HB3ujBST+mvihrV5avycUwhC/5BSTcnh/barID5s+SEhlrtmZgbFv+AVIUDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310505; c=relaxed/simple;
	bh=Krb9jk1HWnid7LjYryDPycLSK3bEf8Nxx/S5AePIvXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNhvhKicMQKSOMDpEHMziYd6vaDImr/p6IYdzcUTe7OF3AWcx1lNvdHFu/+tEee26AieHGE6prHaJGNmxaSqgl26yCN7W7nbhiQ1ZebGElZE39/V5szQ9evqC7SYuKCEI+S5r3QPdr342tUd3zNAGAxbz3rwJRxFMG90sMy/MI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwDW3RO8; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11f3a10dcbbso6828919c88.1
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768310503; x=1768915303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TK0lCTgdvVLUtm1X8Q1FwcQYz6WTr9vRpWnHkii9TsM=;
        b=WwDW3RO8kYFy98BE7Lwl/JeclVcNHPqQFNjdA9US8dPgVHQbVBJlPku/Dkaf7fekS2
         o31ZRtCXP405N4j3YNI/1wfCw5hauk2LR8N31M8552tEEaiVLIM84T+DSU4wNTnCyNNT
         Fq8Gr9kMNT7mK70VBgQ84boibsr2PgtEsgzeh+4t8L9YrSyrwMfRV0KltkzI9cAaiQZX
         ZmOSQ6KqH7TvYrXQDW7azQ3NsiuPVocCBl+PqoD4wYyHng8fPg5Xnqfbkbf+bvdW46OG
         HJWdKz+I5BeWUoXb6JmM3In6wpI3caZ1xJKAtyK9mpF+4eRccTO/rGIlU4COF9U7fCky
         aaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768310503; x=1768915303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TK0lCTgdvVLUtm1X8Q1FwcQYz6WTr9vRpWnHkii9TsM=;
        b=oKWs2bXULDJspoOZuESw8eKwzgl/2oxjBPb3F6Fc8PzrxXuqdXD7hSm/AW9RQJtt11
         fSBE451MzbhNZKB6Wx1/NZ4UPg5KdZekoSklowxsyeizp/TD5qpo1ojzV3U5/TMuZjgo
         HGr0pvalJp47i43mDKRb0yyxj6j4CD/M4KgZMpdOVbRqvtlUB4CgI2lckb6TZ0iAMV6m
         O0UDP84IuH4/tBrJ3XnJDEK8t1nk07oWk3UWTz15KgcZR/la95oCZEsv4NYrE250j7rE
         vXkre2SpE64OeCL6nVVVh09j3T/WpwdGzVHAiryX9mG+DD7VVvviBx0PtpYodYe9fcE0
         a7Qg==
X-Gm-Message-State: AOJu0YwGxbOeACSF5XxCe4aFVWatHp+unTcCjduYB3NcblSXhIqLEWK0
	KH5OpwNpyLmnBHtqaCACghrJAX+CXk4G1Y9+x2ZdRCU63+lTqnZTLac41n7AIQ==
X-Gm-Gg: AY/fxX6JoeKCKHaOs/Emm4sIBARReMKXhKazEbDRpbd/wYojZ2Anz96XMSx8+fwMx5D
	ubT0fAK/wb3+d243dnMbxbvobmGgtPkevhzPskt3teFy3Fiqv+Yog9747woNATKn3ivSIekbgjY
	ol7JqQD20jt3fYzWPMgspXMjdFIzP7Oow6Aq1n6vvYPUG6s2rT+spm/0pWmU1sD6tW4yhbwNdFk
	JmmChzShhQZ/v4KlXA+z4v+fggsK9EBxPEw+M/xp0l2fZesc0pvMuLiZPZN6DHzq3y03XFlD8/H
	2RIEb+LaG+B1o05j9SCrUDlsD0Fw64+4N12bXqL7kAKQvUlzogipQdYF5I1S64zG5qZx5R7ccft
	G6N49JR4TfkNJtCGU18ucJjmFeUCNrkAQomL5pInKwCr8GESth9i1ovJtcWODErO6eqePmyW3Q0
	YlmiY0aZ1LUFkqxnJhC8ti+7HwGfxaGQa+qWteq2Nndq6oPBg92ZSkG2DpyQqy/aZ/WKbu0rN3N
	DFH3fBrWg==
X-Google-Smtp-Source: AGHT+IHVRZNN7vA21jn+EmxVb8Lj877E/eo/0twCLiZYOopNozU6nuf1X+iUF1OY4UZB2x+vUFqHKw==
X-Received: by 2002:a05:7300:e1b5:b0:2ae:5ba5:d27c with SMTP id 5a478bee46e88-2b17d1f1046mr13260292eec.1.1768310502794;
        Tue, 13 Jan 2026 05:21:42 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:274c:de00:6a34:91bb:fdd0:8bea])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b0b2bsm17368853eec.23.2026.01.13.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:21:42 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: stable@vger.kernel.org
Cc: Zhi.Yang@windriver.com,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 6.1.y 1/2] mm/pagewalk: add walk_page_range_vma()
Date: Tue, 13 Jan 2026 10:01:55 -0300
Message-ID: <20260113130156.220078-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025112001-kitten-trickily-a02d@gregkh>
References: <2025112001-kitten-trickily-a02d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit e07cda5f232fac4de0925d8a4c92e51e41fa2f6e ]

Let's add walk_page_range_vma(), which is similar to walk_page_vma(),
however, is only interested in a subset of the VMA range.

To be used in KSM code to stop using follow_page() next.

Link: https://lkml.kernel.org/r/20221021101141.84170-8-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f5548c318d6 ("ksm: use range-walk function to jump over holes in scan_get_next_rmap_item")
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 include/linux/pagewalk.h |  3 +++
 mm/pagewalk.c            | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f3fafb731ffd..2f8f6cc980b4 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -99,6 +99,9 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private);
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2ff3a5bebceb..5295f6d1a4fa 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -517,6 +517,26 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return walk_pgd_range(start, end, &walk);
 }
 
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= vma->vm_mm,
+		.vma		= vma,
+		.private	= private,
+	};
+
+	if (start >= end || !walk.mm)
+		return -EINVAL;
+	if (start < vma->vm_start || end > vma->vm_end)
+		return -EINVAL;
+
+	mmap_assert_locked(walk.mm);
+	return __walk_page_range(start, end, &walk);
+}
+
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private)
 {
-- 
2.43.0


