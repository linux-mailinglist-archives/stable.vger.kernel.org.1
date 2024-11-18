Return-Path: <stable+bounces-93871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8539D1ACA
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569BAB24587
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB91E767B;
	Mon, 18 Nov 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HH8AUolW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AA1E5728
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966417; cv=none; b=kr2JC1AUhsMA21CfBHM+SKSJzjfByoWcxgdw+W+VwFdT1yWERV9/NA9JQwPu6W+qZgQVYp5jrE0y2f3ZojWO4XdOwTTcS+PqRkFkauZGXpSqOslmzvv0Rol86Y68iV6UYg3Jjl2p814pAGxhC2v66mPzN7igBjsYpNYUnOBnRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966417; c=relaxed/simple;
	bh=lxFaUlbo4+BirV6isrV4hkn96boBXGf0A8P1B0Tn2LE=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=orlgVHO8El5jLYPnak6rd7Rdyq9umrdB7+KJiZ7syhMvFVB+jqeBcJFAjt4xavAv4D6n4FCR0rwdahesw3yFxYqeIr8GJJNyVB0Rb0or6LOSXZIsl19W02EhurclfbsUPbFuA+uQsYT4P4SWBQuewXKozce6kr629084rsB5rZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HH8AUolW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee813065afso33079197b3.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731966415; x=1732571215; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TvOCdV4s2TNa5ISzo3BdsjjuMEaKM722wwhwoXrHkjQ=;
        b=HH8AUolWiekxJKi4WsT+kpfbgjunkJ2PetQJLFXvfsGGp8HZKpQ0GjLVz9vDJGPyEO
         OBcMgb1qaejcG7iEm6KvEfajKxYDJZJSxBF/j565bFnX+/biFk4PuzzvOd7ItOTwoZvE
         GCDzSzJqNdb6ppUzuVJ7RsF4X2R304L1jSZexaZOfqPxMDVgjyCSWLzott5KDe2gjYOU
         EIHosC3eTH50QXCQbp1UFspnUuvx2bI1328zG5lgxItpm4YVjyPIyadao9e4cMkp2Ean
         5UY/um/Rkcwut+XzduSWYQP4UMrfeNoZCbZlP5UXvTVSKzSr/LFOhmklgYgWqxLRa8EV
         sCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966415; x=1732571215;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvOCdV4s2TNa5ISzo3BdsjjuMEaKM722wwhwoXrHkjQ=;
        b=OJvw+n03o0tAtdLiFFWFI/zBy6FR9YauNrSb9Z7BDR4frKdHEmZcaWMR9A1nO5tv4x
         SHe8ez46scO7x7hWjr5wz8dbc0uJS0PWk7sqKHBUJmFTbsrBJu5MOhhptUQi3x4WyRf5
         t3ON9S2ahzRmUM7WgM4YrrRT3wSQ9MdDh2c+w7O6tjukzGSKSB6kkz8cZp4XxnoJ7LWS
         Z8zjV0n766qYUm/Kfz8R/duFKC+q7K83Eo8MDKmycB2itpmrpySDmjnqXQkLARk7sooi
         b0psWESJguypnTU0PcCz9iyxz7/SVFBk/0jEmLwPGSlJwbrX55ss2wfgO0qgmtzyN43V
         szdg==
X-Forwarded-Encrypted: i=1; AJvYcCU8FDuRxE6xqb6DJSX/tGbkxAWbLGm5H6uwL/Ppsp0UjSp83pIh2jeIdTuopDcV6dRChhw7B7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFgLjliNsEDjavvEMCv7cyPDmqJD9ynSUabMYVK9LNSnptvKU
	y10GtW6+EwJsuX+ABJTFrOkhqFYNnnT7QQsiNYxwTlgDGfdJ016++C7ZvO941elOcCTWDrOJWDa
	6I5jLYhvccT+x4Kc7fSf2cA==
X-Google-Smtp-Source: AGHT+IEuDWbTMXz+ht1hQLEvCDYEG9ppylXQkzguGm3T6mmWzkk/64xr+RI0ZQ0tDGlSNMX+q8PbO7BDoMupncte1g==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ed74:6cb:48a0:1f9b])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:8bc1:b0:6ee:5091:4254 with
 SMTP id 00721157ae682-6ee55cf1b83mr921467b3.6.1731966414927; Mon, 18 Nov 2024
 13:46:54 -0800 (PST)
Date: Mon, 18 Nov 2024 13:46:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118214650.3667577-1-kaleshsingh@google.com>
Subject: [PATCH v2] mm: Respect mmap hint address when aligning for THP
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
when the user provided a hint address, for anonymous mappings.

Note: As, Yang Shi, pointed out: the issue still remains for filesystems
which are using thp_get_unmapped_area() for their get_unmapped_area() op.
It is unclear what worklaods will regress for if we ignore THP alignment
when the hint address is provided for such file backed mappings -- so this
fix will be handled separately.

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
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---

Changes in v2:
  - Clarify the handling of file backed mappings, as highlighted by Yang
  - Collect Vlastimil's and Rik's Reviewed-by's

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


