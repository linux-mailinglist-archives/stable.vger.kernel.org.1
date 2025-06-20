Return-Path: <stable+bounces-155186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0329AE240D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DC5A688A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A2225390;
	Fri, 20 Jun 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzlVSSYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857E233721
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455228; cv=none; b=ZzOSfwXjC/Ay9rKw5TzbjP8T41usoaLrSVi4D+MsyDRs51g7iI5ny9xoRZjiHHzEci/0ZTF7LVe6oQdBCX2Nd5lofYmvj2+qnTVI0bvzw0E7IDjTq1WFrrssmbV8nUhvOuV/Q0/AcLzB9Ko/O45d/UBqAlIfEc3+nfMwwsKjX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455228; c=relaxed/simple;
	bh=H8ksrERdq29vnu5Lm0AtjjetHkB9Qc5iYE9tWmZqYF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6DY3m8iEWFsCxFCV/M6arZLjczyZ9h38f4PUeHym7oqw2uox+N/wC4vzY+9gUyKGv/CY5/VP11JiEKEcDxPv+bVgPFGh2/8Oz27Wqhtu13Jm690joBIQMar7M1lJmdepFzmkSS1IdgM7T9hjSAuOJDSxiAAl66bye6Eyd8FQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzlVSSYP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7455e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455225; x=1751060025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNf6Ny2iXlC8EyAb4cTZNY06NgYPwt8FKnro78CSTdM=;
        b=LzlVSSYPib86Z6e0xGjXqW0OPzJPTRTHGlFWvE8fpHoDCMYsSEnqud1Vd1VEiiy3YD
         jTSl3MhYLrK2Sk9DYL6bdq0LF0jdW3UkirSCTfzPbK1SQi1DJ8uEbpzptT4iJECitmOV
         1n0DwMsfZ/7hW1MQXizaVQAhcuigqJtERDyJRgRAP21mAdcf33U51XLq7STX7KGjsIXE
         3MIMfwEO8ATBIaDIIXw0OvpwNzcvMKmGH4D+50KeQYZ0FISYgJyGlWmf5y5XCrLHLvtn
         VcIIQJU/M2zRYLNKNpdK6M9k/X80e0fADnnRNvM30OFWY2E+Bj7G9DSpQY9NkmLWUIwd
         A77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455225; x=1751060025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNf6Ny2iXlC8EyAb4cTZNY06NgYPwt8FKnro78CSTdM=;
        b=R8nPBwi1WkQHn3l0QA+jjALhPIUUYBINt8Db76p5mv2QNl7ojxnHUp7hvNRluGBOcT
         KTC9wIrrZZfv3N5QzNJeBmyw9Sk7d97DoaXrb+H2oX5IgaNrtR2aCP6+gwsffc/v2/fx
         NkcfTlIOPaRVMVWXnWjUNRspF6FR/Ok6KtRqmt1xpbX877TEGa0P7qm2qkImOK0KD6qa
         CQ77kuH8twMva/c1bK25bNmLWoiCgtXgyuRMrsK7kepN1jhmwEqB6nuX7DgL3iNWYek9
         bbBsS07bamgBkuYVO/9/GdNeKZTtURpO2xt3c32UcNA4zggQ04Cj2hWosPh6cZAe8PuH
         cVjA==
X-Gm-Message-State: AOJu0YzJmI1Nx37eP73yRuCZtkX61iEVoEl8AKpPU2IeJEOskji9t3xv
	mr7V2voiWFPVqvcBN+IxnxFaGzp33+55uaLIOpW0FtQJoumx1Dy9+nd3s5Om4ReNpVdaPxUyD9q
	i0dGIvBKx
X-Gm-Gg: ASbGncuWPgPtjm9sLKZBoUGo4GjodDFPbNjg9OQOpdm2IfTa18QKc2ZtDbqn+yyVUTL
	WBLPGqNbMN268UmcPd7oX5qMAbmrj8FyXArOPnvpSKIC/0hMN/jEMTkLco1PGJnFr14/zQ4j/HE
	UKbPhMwdMGnQbfye4Aov6zPXmcrJJ/KAOHb552QmNFwExdHG3q0JG38F3vP2PWIgBQV4P0qnVEG
	K7zUK9L/kIacwc73djcXeo8kj4kaQWR2Ld92Wk/tYZTEEcSOrDl3wvYQGPbuPM51ydCafjTmMB+
	S6bHlACm/jRiOnGGTUvhw7Zqjt/0MCv12x4DSJWcsuQKVCY/UA==
X-Google-Smtp-Source: AGHT+IGxK8IgwE+LPzqHRZ5UNASy4zM7ROGiz57m1kZCv5jOtxQUtpTcrhxfDFPbPOESrgmaUDzC3w==
X-Received: by 2002:a05:600c:1c0f:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-4536abfa310mr345435e9.2.1750455225045;
        Fri, 20 Jun 2025 14:33:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453646fd589sm35912195e9.26.2025.06.20.14.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:33:44 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 3/3] mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
Date: Fri, 20 Jun 2025 23:33:33 +0200
Message-ID: <20250620213334.158850-3-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213334.158850-1-jannh@google.com>
References: <2025062041-uplifted-cahoots-6c42@gregkh>
 <20250620213334.158850-1-jannh@google.com>
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
[backport]
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a3907edf2909..2dee7dcb3b18 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7162,6 +7162,13 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
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
 	return 1;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


