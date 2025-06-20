Return-Path: <stable+bounces-155193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C62AE2420
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34303BE76C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B123717C;
	Fri, 20 Jun 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keumRFJj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259C238D42
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455435; cv=none; b=J5wyawq9tNvQ8UuQueDo1w54yOX5e8GWo37JqdS5lLI/OwaujktxYoX0EbDZFbpq1vekrDgyQXgaQYwe9h+7jno1VJFXi+lZeAXVW86g7MkXRC0cp7fLWRRMSFFnzBZwCuqWLjIAsgbtbqNpxisy9RgsQuD++t5WKLWJQrkngXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455435; c=relaxed/simple;
	bh=lxlM+UGPS/XOS+p2EskWCD9+wX3DWGtAR/IBPXndO8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmPqDBil7HXuAeDB7VSjzoj+IYgaVoKdS913+gnw2PIgppeN1UdJwuVtZHoCa6Dd/83rjSJc9XtSjM4m/0g6wKTZ5NhsMVZ/nF+DIhaCM9CpwB+ByyNA54RHOYu0nrAomhcbCYzaYi0/J3Cx/WjXhEVvVXqVGTu7CRJ5Mlzwa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keumRFJj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7685e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455432; x=1751060232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC+q6wO4doiqv6yXXHoNoawuF72Gd3lYtx4bhCud88s=;
        b=keumRFJjtp8G9JLZMzhlOKFMUtOJABAOOTLJcx+5qRnUeOpr7GR2DndFD8at/hk4Dl
         TPlUtXypy0FIZg7nUED4YLRynD8j50MrgYowQVSkOSAH6J3+dcwA+XhtB57cwprTufxe
         CaxG0Qs5KQeeuaNcJvCUe6pN3q+vDH4RSpj8GkJAbjh2LPum8wsfdZoDo9hR3mXGPKQ8
         U2s/0+If/9+BBSp2jPcMNiATY7gXxtKL70GFlR6+5xT6od8x67oLExALUM8p3uD47pMZ
         cHmOPga5tfbEhbfXZ9flzKDVgA4DMSbUaFoZ5FLp9X3gRcCF2tbATSIM4pm1pyLJCyL1
         2zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455432; x=1751060232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC+q6wO4doiqv6yXXHoNoawuF72Gd3lYtx4bhCud88s=;
        b=bgtwotxR0fpRVaj9KEgg00rrJG1BvFSi1wvak6lRgCswcMUs1cB7QpQIXNMfStxA8W
         4jbBGF7k9775K+C3qcVVOwTuVlwRemLqfaB0oSVWyAoQHqo2mbUKNHMfV57ZJUuawx8E
         zTCPTnk7y4uNfe68t6e/X6jbjgoRkJi/OhXQ7Wn9cf5VLyuzJLh3Y06ooWlnlWClknQ6
         zmBE4zig7g1WvjPnsI5w+CHH9WCP5hfJFgt7OVIhl0WmTiNe33EOySkPSpuhagB4/aLE
         Z4pboF344pF8URyjmJ/nxuJx5M+q08g/bycv/UgznmfKbaEJY5f13sMT7QcMwDFi+c4o
         Rk7A==
X-Gm-Message-State: AOJu0Yy2qN3eT8i3VvOr9+IxhjgLP4jv5SdddzpCCeHeReBX4dsABOrV
	zz/V37wwj8Qnisnf19rLYH9ASpCr66H9D3PG4wGyaJ9SSPQmOtX1vb43kPWkimefs7eIUTzM/cg
	DgXerzH/k
X-Gm-Gg: ASbGnctOiKSL212ottvtfh70SRVA8X1qfbuT6As3ksmWuThuCJQWD/KeefxoJfv1pY9
	b3IsO3FwjrF33zJQY+Cb9OkM77FUtki89gBgQao+kHEprHKbLAiU8OP+2oQ2OWQd01N1Q10SRtq
	soYrUjXFNDrLkM1SnUxQerZ5ai/41hr1Iqj89HYfMrlqu8wJq5aozK6i3wgD+m3ziCcKMDBedbM
	vzBx5L2762CP82ohg3vqE4UEwoUUSV1sjqHQWyPrwqOhG9KfF5Dnfnnxab8lMpg4OxPyDuuux5E
	iVSh3JzMDw/qhJ8KScIpA0WktF6dyVPvhzC3lmVJYpc+yoB9bzU=
X-Google-Smtp-Source: AGHT+IEedI+jrSG+gPRJLH0Zn4XGRuOzHc6kc21BHF1CDPudX9NxEOg/Dwvk26R41sMdod5M9ciK7w==
X-Received: by 2002:a05:600c:c04c:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-4536ab32a7bmr164895e9.0.1750455432016;
        Fri, 20 Jun 2025 14:37:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6d0f104bbsm3041079f8f.4.2025.06.20.14.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:37:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 4/4] mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
Date: Fri, 20 Jun 2025 23:37:06 +0200
Message-ID: <20250620213706.161203-4-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213706.161203-1-jannh@google.com>
References: <2025062043-plunging-sculpture-7ca1@gregkh>
 <20250620213706.161203-1-jannh@google.com>
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
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2221c6acebbb..1411c2f34bbf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5488,6 +5488,13 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
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


