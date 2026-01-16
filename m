Return-Path: <stable+bounces-210078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA7D379EB
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A160A3003851
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78A337B91;
	Fri, 16 Jan 2026 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI9UaJx4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E728C009
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584154; cv=none; b=ZuYZbkfRpsvUgKSKszW0THQ1GOwc1NivOHujxjQ+Tf+v6xW9aXugRQhz3qVquNhjr6uXjwUteELpvY1rzRDRh6aQSJV3ycaKQNUfWbDMp35TdQERouVJHEuS2CF4AK+lbnaYjqsPe858K8XqIpjwqp+qKcEDoGtVjRGUvHhjXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584154; c=relaxed/simple;
	bh=d9f5sZVS14eI+pgL73Hdubv7SzBhSzm4I8yWmZplO6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVGYeKlqZSKg5MAWcMc+uAzXqoCV+uTnmlQ9MtddIis7KEqWbscvQDB2izYJsZ7NAe0GOCfSVkVGnnwH0L4xZuMTJr2spKQJZFPc2oOpPwReSV8DlrHF6iOsum2HsBDP8dR2zS0JMtSOfYsPjMLZVUxuuFkbqaNcj8tEIOorE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI9UaJx4; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12336c0a8b6so4644859c88.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768584151; x=1769188951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmSdIONelOl20/6Slm+Qq4VYpMB55wu2zVMlHt4LAJ0=;
        b=UI9UaJx44PVGiYC62fuabJStvXweSUDfpGE7FkQ8IREI569RsGUKiDpJD0qH7Xa9F0
         IEuRexgpSMs/JXJCpCggmK+gBQTIHr4NRZaGJSGhC4+RAngVdg50fM6v4j795fdwvPsj
         1G6s8Nz9xHpa7ri/zVkZGEsNISF4mnSQ/g+j5oo/qzqKDWQWb5DCF26uVSs+2n0lxK24
         HWZ8x1Txs5e/nkbb9VQ1V6l6VI2Uom4XjzJqvind698zpMnHdrHB0mhpKIj1J17qw4In
         enrBeIBATK3IEdn7Db0xMw9Go8VrcDinIJ/pRLrS0+Edx8kBr3VpENlgi/LSXriNTTRN
         c0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584151; x=1769188951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmSdIONelOl20/6Slm+Qq4VYpMB55wu2zVMlHt4LAJ0=;
        b=SFDcrvbyLpU1UQchUdFf2x2FDCwIQBoBBoKcjuR5w7DXjt0awUJCszxI+HLxRgKqbV
         LHNgoHGrNDLdwUv6FZ/1HInnbhdxelcgadOzgMBvIUHA5dgXp0miN7jSbP3h/Mniu3C3
         VTEl+1BwVUtSiA8imRwqUpxq67dLkZmNRaBXgEHnOUGuKRttM9LZbFMdnnej3iG04SEN
         +5P5Jewh43Zge0VCFQKmX2uAe47XdRxHsfERrup8hqbmKxwWkBvvtu5ICMTnN1Nb//OC
         Nq4HJ+zKybyEAy49suYJiPpWahM1vhn8JGghYQbMaaV7jQiyvPzSSSeKofvzY07DcFS9
         azPA==
X-Gm-Message-State: AOJu0YzXchzRjAW1ZF4ZC6JqMQGCit2dbzGZgukS7S0CQzkBdKlFf1kL
	EfWpfbd04RbP6eHv04FFLAG9oFn/uOeZI8/incnkkUCZpYza7F2Hb9qwRO0PmQ==
X-Gm-Gg: AY/fxX4YBMWy3bvUCPt1pz8n0NGq4E0TmRPVvzb8EWU3CPc+9H6H6WpHxlHMPdz5SVe
	QFG4d6z0NYUInO/HRxiDH+wHXeRa/ziCctlVmN6WRZ2Akv008cYBr3q0lhA9/H/9w3LEmSRhJcf
	XKXZFiuV2U8DV96r8KAHk5dVfxqA8xQeR56H5qaWKqiNFaVjlUXuZKO8rnslu76c0uj1+09wQpf
	WbfQxRrpI1SDKtEPOKRs86eb+X1v+Ibuomco1GbQmVq/6JVCmM1gj0o91olILthXDBBqsXSULUW
	HDu9x4PYJLTOTrvTLRYGmPw4FWyageuBRyesX1LXGlN901z5hl1NT05Z4yE7yNhlq4AUY2a9PQm
	tRuKIUsTE76GqxPyV5MPZQI1UvJAy5xCEwb8LZ2DbyORmE5GflUl2y+THU84eXBk5l/PdQnbKT2
	fB+EmjxWsM+Q/358j6FE6gEm/700+bu6b2nVuKJ7ClJQFihMwxW10XwAgI+lF/n96Z7gu+6Iw=
X-Received: by 2002:a05:7022:608d:b0:11a:641f:ba11 with SMTP id a92af1059eb24-1244a75ec9cmr2955426c88.29.1768584151421;
        Fri, 16 Jan 2026 09:22:31 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:274c:de00:6aad:5873:dac7:9b5c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm3537705c88.8.2026.01.16.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:22:30 -0800 (PST)
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
Subject: [PATCH 5.15.y 1/2] mm/pagewalk: add walk_page_range_vma()
Date: Fri, 16 Jan 2026 14:19:13 -0300
Message-ID: <20260116171914.298018-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025112003-afloat-squall-e39d@gregkh>
References: <2025112003-afloat-squall-e39d@gregkh>
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
index ac7b38ad5903..cfeedc69461e 100644
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
index fa7a3d21a751..8ebde6aed6fc 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -509,6 +509,26 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
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


