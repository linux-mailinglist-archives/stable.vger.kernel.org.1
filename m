Return-Path: <stable+bounces-3903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15472803B80
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C20281091
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8E2E828;
	Mon,  4 Dec 2023 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzGYea8n"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B6FE
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 09:27:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3f951af5aso51937367b3.0
        for <stable@vger.kernel.org>; Mon, 04 Dec 2023 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710829; x=1702315629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhY7K21fTuleJoRqinTH8FQOk8orwGh5uZOpWymHf1Q=;
        b=WzGYea8n8gKWhOwUN/QBnPZuZ64gGSovVSoWBoiu4lbkEjmhix1LpnW/02s19SFZrU
         QMVFdWKaxmPZunHSypbzY+U7yR2JTPyA41Cbhk3LyKYudi8ww5ybiC3hT+8dLtwBDuQq
         Qg74t1rFE9TL1mv3NkTfGz2vK3NybbXMukI32VwczFC2vBgCRWOjUSHMYJs+emm/e3nO
         xJFhfR5/0+lQmbwE/Uo0mGt4fp6L7vE/lQzYwMNzQTTLWdUS1e4TAi4krkOISbwofcZg
         mKe0cT4CAIz81vMLSxpK8K8AUvk5aMUMSlTkMo+6raEgYH+8Z5D8apajVYlCQjqmzIDZ
         9+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710829; x=1702315629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhY7K21fTuleJoRqinTH8FQOk8orwGh5uZOpWymHf1Q=;
        b=pmMKITUyoI114vMzI45JPPtkEC1AirDyVO3C1EQeNeVZc6a2NTc/tnNjZ2Aq1yHl6o
         /69OgWKJRrt9dsJYR+7pBdNp8eGeFgc5jB3SdU3KESjuCUXLFeIcINYHvg/hiSKb1pUl
         442HIXhZcuwQYlVIME1vTSWTxUl+XhLgFB4sC+quzzwuNK1c5CYOOgvHwtQcNIp+blnV
         BirZTVCsTXEBugr5DJP9lHh6ZitodOTkqT1VataPC79g/FvZjVVJ7RnUJXcAGX5J7oG4
         0NjuMlFseNp4dM4fZgQ+ydI9IBvfM70sa8UQNTzm72SIDO5/FkUU8gKYjkUp16VvKqhn
         Bqlg==
X-Gm-Message-State: AOJu0Yw6T2/2pdb281k13Hadw6yyYfzQXnbwqqkl0WhDm+gJuMU+rMkd
	0t39K6CZceweiTJMmi0NAz/VaBEWK/42fUT+
X-Google-Smtp-Source: AGHT+IEhvePiHl3xyV55jaT6gG1N1cwFNsflp2+fj8EBDZAd96hh+3/YkVm099+dmC2eTTOXHiutCQyCzt5QJhnb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b61d:0:b0:5d3:84d4:eb35 with SMTP
 id u29-20020a81b61d000000b005d384d4eb35mr358241ywh.3.1701710828830; Mon, 04
 Dec 2023 09:27:08 -0800 (PST)
Date: Mon,  4 Dec 2023 17:26:45 +0000
In-Reply-To: <20231204172646.2541916-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172646.2541916-2-jthoughton@google.com>
Subject: [PATCH 1/2] arm64: hugetlb: Distinguish between hw and sw dirtiness
 in __cont_access_flags_changed
From: James Houghton <jthoughton@google.com>
To: Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__cont_access_flags_changed was originally introduced to avoid making
unnecessary changes to the PTEs. Consider the following case: all the
PTEs in the contiguous group have PTE_DIRTY | PTE_RDONLY | PTE_WRITE,
and we are running on a system without HAFDBS.  When writing via these
PTEs, we will get a page fault, and hugetlb_fault will (rightly)
attempt to update the PTEs with PTE_DIRTY | PTE_WRITE, but, as both the
original PTEs and the new PTEs are pte_dirty(),
__cont_access_flags_changed prevents the pgprot update from occurring.

To avoid the page fault loop that we get ourselves into, distinguish
between hardware-dirty and software-dirty for this check. Non-contiguous
PTEs aren't broken in the same way, as we will always write a new PTE
unless the new PTE is exactly equal to the old one.

Fixes: 031e6e6b4e12 ("arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags")
Signed-off-by: James Houghton <jthoughton@google.com>
Cc: <stable@vger.kernel.org>

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f5aae342632c..87a9564976fa 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -437,7 +437,10 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
 	for (i = 0; i < ncontig; i++) {
 		pte_t orig_pte = ptep_get(ptep + i);
 
-		if (pte_dirty(pte) != pte_dirty(orig_pte))
+		if (pte_sw_dirty(pte) != pte_sw_dirty(orig_pte))
+			return 1;
+
+		if (pte_hw_dirty(pte) != pte_hw_dirty(orig_pte))
 			return 1;
 
 		if (pte_young(pte) != pte_young(orig_pte))
-- 
2.43.0.rc2.451.g8631bc7472-goog


