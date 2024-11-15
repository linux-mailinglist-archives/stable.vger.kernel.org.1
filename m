Return-Path: <stable+bounces-93609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1D9CFA69
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC00B247E0
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD81FF606;
	Fri, 15 Nov 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a99cfkiJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C861FC7C2
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707583; cv=none; b=Pdki0kPfMU6FGemVGoG+rpCqlgVOuk398AtnQ9+iaJxKJFyNVGbdvQsCLEXH9Aj1sv8ZFLGS6cW64NX5XjqubnVuUsQlZXTpaNhXFGbsE7J+CBHTREFzMfTaUBdDtjRSJw88kaHeMWJpXkY0nMuM57O4SVEkOEbTAMGeUqb8V1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707583; c=relaxed/simple;
	bh=n4OKgydlm0TVJwIGzSF/rXT3pH9BAUZabTwfDhlmxBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=tHoNGiJp6V69PI51U0uP1+dC3DXVlWHC96OzWWnuxGyBEVOStBU7HOQWFspYAxLLcceR2wqM0Cb68UUMo674J1LNWNlfgSDorZTnNHU1+wJ9lkTEaSzMEg0WuCPlBMkSFROI9hqU/4Uujc+o5CPfLcl9EVcm38IPlsCZM9HolaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a99cfkiJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea86f1df79so41926137b3.1
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731707579; x=1732312379; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3Lr4WdOKy4VbAqfpb23fqAMFS0TE/YrDm6ZBGH4WtQ=;
        b=a99cfkiJCYUPWAL4wNPXHukpv9rqlK+EM2chui0zUyYLCTDJJfqwpBgAJqeQRCdI4P
         To7cShT0SSGJTOgnEddjQN+1KF+cGdXZmhakQ8NTrYVkAKr1Qdo/lg9zK45WV/K0k/+m
         ek4dFWgu1pnSpiltdbL5oLlJzvpomHWBdY6exQlGbGunVEget+b4AKnq5g8Te8OM4k/5
         KF90BTX38gmLJXXd3hmLWAobvJfd55FBSEjY4Ej/5CXoqE8AXKzx/gZB2lAzGiuXsw8y
         N4MP6Pjg/F8PVOAVJgExanbTBtKo7G9K8NHtQv/luoTlgvrujo5kJtY7XrcRQZAfQCHa
         /AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707579; x=1732312379;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3Lr4WdOKy4VbAqfpb23fqAMFS0TE/YrDm6ZBGH4WtQ=;
        b=U+voJpAFVqFCGL7P+2tJat7yMAQXpxgeUNR723UfNNWkO8GIVo8KmgcEhS4Jzzs85/
         uwsfBjrVZvF2RQbrf9TX2BfTseJiXQKEMpNzzxo4s4XPEk7smzGZxMUgtCpedrJUGsxt
         bYeiuwgsvB8eEuScVNUcfPXi1UIotJqYS65arDPEKZYkQ/c/hP+vwoE/GVF2Ax3jzsMH
         t+sFUB5n7CG3/HsU4wHU1sH1M/lUcYNuNKUEQz8Ha6xpaeLPeLvL0uZtrd2eoESHUEJ4
         gmkoq6zPnXgXxfQsreih0Lq3uqJmBFw9Ofa3hU2AsCVkgPUmgTo28LxkS+mOEk+m9MJC
         RQNA==
X-Forwarded-Encrypted: i=1; AJvYcCXmb4qQOg1tpN9KtvHoeqWxsN72fERkdzQfjC46ph5nSfj7XmPEDEo8c9NRSZdftfdqYUBcQ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5laEUTM9Jcl6d4LdZuJyHRczSmDUMpFDdbuvHSUhNAWQZ+vAl
	553mchw1V4IMZtKkVjA9wWXJhTsAGa7Iqk1Qtm+jWMaFppCLhxX4H6lgIK+tNwps1NLYKMZMxvf
	0r2fVzKHZE0hHx+p+2N0lfA==
X-Google-Smtp-Source: AGHT+IH2lTnSTmkXeTH4jQY5dTMIBM7aAaY2KmefhKNRgP76mCWxBocb32PIi9hyqSL27HkXkJlJGHgg1gmJMiKP0A==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:fabe:251a:db8:7fc4])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:8f07:b0:6ea:34c3:742b with
 SMTP id 00721157ae682-6ee55c7a403mr497207b3.6.1731707579432; Fri, 15 Nov 2024
 13:52:59 -0800 (PST)
Date: Fri, 15 Nov 2024 13:52:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115215256.578125-1-kaleshsingh@google.com>
Subject: [PATCH] mm: Respect mmap hint address when aligning for THP
From: Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Yang Shi <yang@os.amperecomputing.com>, 
	Rik van Riel <riel@surriel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") updated __get_unmapped_area() to align the start address
for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=y.

It does this by effectively looking up a region that is of size,
request_size + PMD_SIZE, and aligning up the start to a PMD boundary.

Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
on 32 bit") opted out of this for 32bit due to regressions in mmap base
randomization.

Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
mappings to PMD-aligned sizes") restricted this to only mmap sizes that
are multiples of the PMD_SIZE due to reported regressions in some
performance benchmarks -- which seemed mostly due to the reduced spatial
locality of related mappings due to the forced PMD-alignment.

Another unintended side effect has emerged: When a user specifies an mmap
hint address, the THP alignment logic modifies the behavior, potentially
ignoring the hint even if a sufficiently large gap exists at the requested
hint location.

Example Scenario:

Consider the following simplified virtual address (VA) space:

    ...

    0x200000-0x400000 --- VMA A
    0x400000-0x600000 --- Hole
    0x600000-0x800000 --- VMA B

    ...

A call to mmap() with hint=0x400000 and len=0x200000 behaves differently:

  - Before THP alignment: The requested region (size 0x200000) fits into
    the gap at 0x400000, so the hint is respected.

  - After alignment: The logic searches for a region of size
    0x400000 (len + PMD_SIZE) starting at 0x400000.
    This search fails due to the mapping at 0x600000 (VMA B), and the hint
    is ignored, falling back to arch_get_unmapped_area[_topdown]().

In general the hint is effectively ignored, if there is any
existing mapping in the below range:

     [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)

This changes the semantics of mmap hint; from ""Respect the hint if a
sufficiently large gap exists at the requested location" to "Respect the
hint only if an additional PMD-sized gap exists beyond the requested size".

This has performance implications for allocators that allocate their heap
using mmap but try to keep it "as contiguous as possible" by using the
end of the exisiting heap as the address hint. With the new behavior
it's more likely to get a much less contiguous heap, adding extra
fragmentation and performance overhead.

To restore the expected behavior; don't use thp_get_unmapped_area_vmflags()
when the user provided a hint address.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Hans Boehm <hboehm@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: <stable@vger.kernel.org>
Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 79d541f1502b..2f01f1a8e304 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
 	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+		   && !addr /* no hint */
 		   && IS_ALIGNED(len, PMD_SIZE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0.338.g60cca15819-goog


