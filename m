Return-Path: <stable+bounces-40746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6478AF5DA
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97D028500B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275F13E3F7;
	Tue, 23 Apr 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6m6iNl2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2813DDD0
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894764; cv=none; b=CwQN8JHqkMgV4J5G4wbAxIHlFqaFDt6rtX1qRix1+Gits2sQLN/DE9AzvrTj91zj8+sGNTgUxP6ntYVZc4Kki6X0u5H7AX4NtDRj+feF8dRPM4Dq0sa3A+HmwAv6jsUGnm6fCx+58ifN2EeiVxG+MmkhIGL8AAbb8xyQWA2BKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894764; c=relaxed/simple;
	bh=n+i70T4/d3rinPz7Q+nnDtEGWZN7DqBJq1N0B30DRT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZo+3WxuuzVv605IzdfwXPhwVW5leC5B1+i4TnsEQYiytWck/h9zTCFrplmwZDEPRThoY8Gd80Mcq13XvV9GBtLivfy2D/7ylhN+w1+f1qwxhXoW36r1wOAlnkZjOMcfekH4D28svVlsXTv5FIdMcjalwQoJ11GIqMhUwZRYfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6m6iNl2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618596c23b4so100055007b3.0
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713894762; x=1714499562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfgZhNW8AfIN/1GPTg88pz2fGb52KUwbdMJXdtfspKw=;
        b=X6m6iNl2zlISyCtZpnvBCu4aAavnYzmiXFjWSfkw7oKxLhKAP3FeUghdyfNtZVpiio
         Pv6gFeEoqduDxcc/ofzRjxpktoM0GePe6ioVbzU19DeJgD1Rh+RToEi/mRuykET+OG+e
         7p7itWMim/xyw4/JT3gUhzISkrcFnpfmRFT6xV8qfoKRqVgYyT9AbuZXSHPXWJtBtm6T
         qiUpU+sqz5J5zMr8/kFczrGhaUPidxE0m8UBaiMVls6BHydWNjgzZLWNcIXqNESKK6SK
         dY/6XvS2rQ7wkKuqdpzwwrZ/tj9DJjMkwJDLTvMoEZqeso/xyD98juHeDZwQhdyGjoK9
         7k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713894762; x=1714499562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfgZhNW8AfIN/1GPTg88pz2fGb52KUwbdMJXdtfspKw=;
        b=pKQnaEzhONNcwUrKs5wdel165JzOtQeQF4ImmtyCBklclm2oZi0O8m1wfR2wLl1aIV
         tFvHqhJwvSSXFV0bEkbnq4jN8nmag7Xfq1CDv3mNQgpslWOeBcoPcVLUQ/540taXlkTa
         A78kCJue4aVB7aMIdql4iSDvyZpdnoI+D5KPILpj6ahgQWtDIBaRU2G3ipkuwhyAor3D
         pYKj1CC+WmQxXCHVegzDBI2LQ05eipm8M7OmUgnePJ5v/Py4bJVYijS/Y3fmUT5Ux/Ir
         yXceCShYTJv4HOsYZvvityTdU7krW/JjHzoswlUYWLqwarOTWhPXWEE5Y6e/4Yol8NQJ
         qSmQ==
X-Gm-Message-State: AOJu0YxC78IlD9lM1WwhucsieLwc5+qiRqZbI7xlRZdT3VKgr026LXMu
	VG6WmWNyIJEEtfPUG3JFJH3aKqWgSRnF8aVg7aQrT+4FmP+3FdEFdSiUqsAZmmEO036EAvNRsrG
	WzyusJzpTwHb21Vd8zxhL9CN58TYKd0IXvX+0ltUiQpFPnU6A5RNhBEmn1c0J8q6ax2oLmuCLnu
	XgcN+gcN8MvEnSvST2dif1Ghj6gtGevjjzjSwkcr1ASHffQQDkBwp0Kq2sQqA=
X-Google-Smtp-Source: AGHT+IFL9rRyPPyt8vMKP6ocEgDxEnn+8mGY8YcytOqY3fIr8LvFPeHiGUP+h9U9HrCz6rtdAq/ULbShGuC0W9HtIw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:aec9:515c:8866:7850])
 (user=lokeshgidra job=sendgmr) by 2002:a0d:d5ca:0:b0:618:4a14:54b8 with SMTP
 id x193-20020a0dd5ca000000b006184a1454b8mr39167ywd.1.1713894762276; Tue, 23
 Apr 2024 10:52:42 -0700 (PDT)
Date: Tue, 23 Apr 2024 10:52:38 -0700
In-Reply-To: <2024042334-agenda-nutlike-cb77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024042334-agenda-nutlike-cb77@gregkh>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423175238.1258250-1-lokeshgidra@google.com>
Subject: [PATCH 6.8.y] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
From: Lokesh Gidra <lokeshgidra@google.com>
To: stable@vger.kernel.org
Cc: surenb@google.com, Lokesh Gidra <lokeshgidra@google.com>, 
	David Hildenbrand <david@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Nicolas Geoffray <ngeoffray@google.com>, 
	Peter Xu <peterx@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Commit d7a08838ab74 ("mm: userfaultfd: fix unexpected change to src_folio
when UFFDIO_MOVE fails") moved the src_folio->{mapping, index} changing to
after clearing the page-table and ensuring that it's not pinned.  This
avoids failure of swapout+migration and possibly memory corruption.

However, the commit missed fixing it in the huge-page case.

Link: https://lkml.kernel.org/r/20240404171726.2302435-1-lokeshgidra@google.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit c0205eaf3af9f5db14d4b5ee4abacf4a583c3c50)
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..6790f93fda45 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2244,9 +2244,6 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		goto unlock_ptls;
 	}
 
-	folio_move_anon_rmap(src_folio, dst_vma);
-	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
-
 	src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
 	/* Folio got pinned from under us. Put it back and fail the move. */
 	if (folio_maybe_dma_pinned(src_folio)) {
@@ -2255,6 +2252,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		goto unlock_ptls;
 	}
 
+	folio_move_anon_rmap(src_folio, dst_vma);
+	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
 	_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */
 	_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
-- 
2.44.0.769.g3c40516874-goog


