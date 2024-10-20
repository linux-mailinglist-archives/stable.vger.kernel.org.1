Return-Path: <stable+bounces-86934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D99A5269
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 06:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9060F282AC3
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 04:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08161C2C6;
	Sun, 20 Oct 2024 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8sCFTf+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0BBE40
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729398141; cv=none; b=lUsPVGZ6Adj4xHMQGIbDOLEUTb//SDIFyuSyow1iXKqSzvWelkp2XPx0PMTZJuCQLhy5PXsNU0dlP6fcLA5RKa0j6QvEgMC8xBY7Fq7i5fI3Vyk120PnOMMIRVLHuvwYhYbh1J72fk93WAwwFG5wVxu0kDlmHCF/OGsGh4BV2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729398141; c=relaxed/simple;
	bh=XaCuofOydV2xR3Tg6aOIIGLypo6I2Fmon7MLCN+dBzs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nNfS+9Mb04MT/TCtwdh7iVRQVMLg5pdQTBmPLDW93nKcfX/uzVr+GdWGAcB5IVxqeZrRJzvnywtdMcYNkpmF8QrdxOb4aaec8z/w0jrIFyh4aZYgSc1DtNQRsL2fmTNO2rkKAaF0gZwqTZ6gFIqt8wFozpE03glshKSbqMin+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8sCFTf+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e4874925so57463067b3.1
        for <stable@vger.kernel.org>; Sat, 19 Oct 2024 21:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729398138; x=1730002938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hunIrxaAZBKXG3dXiSGVda8Y0C34IOSFspIj4rrZhK0=;
        b=K8sCFTf++DTB88Zvo49KOyZE4XeEv99eNq/w8TAG1tGaj9ny9bTWOt1XrUq2eYqrjj
         JY+PMU+wrx75bw3BwPKfMUjGORJVLNUg0tdY8xsjNe1wYOO/WPe+tnHKZyvqWz/8bU5Y
         Lj9I5g4jCdS/WIOdwxagPzPuQOCceqjhxwEfw/hvuJnO4rOmP6rg3KwFrMATNgUal3Nx
         l1KOxrU0CIOI9lhXQyijQ6ly1RNZ4aoISBFp66T7bpqh7ZWcsvqJDZFBfWFG+fLkTTPm
         UJSZhA3tYf0mAUCi+y6iFcEU60Xx/mYmFjrPnBJP1w3l4QmvHbbScEqUWSm8emtnorPV
         M6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729398138; x=1730002938;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hunIrxaAZBKXG3dXiSGVda8Y0C34IOSFspIj4rrZhK0=;
        b=I1wg6PYDZ8nUFaTjlLhRIscFHl+AYKSU31iVVMfKzVYbZgH0dVcEVHTr3jKMvi7Vas
         8KlL645mtNdbRnL1ICWu2XWC5B/xswJwzhwIMATimqhqhv4zWioN/RK9fnpLsDGB97mO
         X6j9eqg+c9naQxwoaYNKAMUiAugECUlLItr4BOMsfgzqPyniLZAup2FxugCJJzad5lw/
         sX8jBrPd8/5k3XQ3I2jdNBxew0Zhr766M3vStV4xODjYQBU/RrvSAEcIwcb11CfePZ5D
         fZHNurslp+rNM+VTTdiTma7nFpx7nzJx9jFtYRTNh1Z6zRBeUNxaljC4tHbshsnkfplu
         6T3g==
X-Forwarded-Encrypted: i=1; AJvYcCUzgYMCDHsy6Wb+j1XUiq8XDEflN85q51xJrO2lS94aaqKS6j/PTsHAOi3RivsFnYJgIdHObJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+zL0iW4E2yyfB7p7ltZqzA+F46kGlxnhSP97/eeXPchE+L25
	T/3A8JTcoKOIribCA7BoGA7X85vnPhCXH6uSO2w82+ZlHQFCJR/tGkaLH2/YcAxMat+Ep6vpCUx
	M2g==
X-Google-Smtp-Source: AGHT+IFifeZ9dPCzrp2wsmyKhCEmFpT64OFwbRHZPKpAAxcfKYugj5DI1/4Uq3aosY7cj+7jHzLwU352+Fw=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:882f:cbc3:2127:9e93])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:7010:b0:6e3:1023:3645 with SMTP id
 00721157ae682-6e5bfc56d11mr1792447b3.8.1729398137687; Sat, 19 Oct 2024
 21:22:17 -0700 (PDT)
Date: Sat, 19 Oct 2024 22:22:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241020042212.296781-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm: allow set/clear page_type again
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some page flags (page->flags) were converted to page types
(page->page_types). A recent example is PG_hugetlb.

From the exclusive writer's perspective, e.g., a thread doing
__folio_set_hugetlb(), there is a difference between the page flag and
type APIs: the former allows the same non-atomic operation to be
repeated whereas the latter does not. For example, calling
__folio_set_hugetlb() twice triggers VM_BUG_ON_FOLIO(), since the
second call expects the type (PG_hugetlb) not to be set previously.

Using add_hugetlb_folio() as an example, it calls
__folio_set_hugetlb() in the following error-handling path. And when
that happens, it triggers the aforementioned VM_BUG_ON_FOLIO().

  if (folio_test_hugetlb(folio)) {
    rc = hugetlb_vmemmap_restore_folio(h, folio);
    if (rc) {
      spin_lock_irq(&hugetlb_lock);
      add_hugetlb_folio(h, folio, false);
      ...

It is possible to make hugeTLB comply with the new requirements from
the page type API. However, a straightforward fix would be to just
allow the same page type to be set or cleared again inside the API,
to avoid any changes to its callers.

Fixes: d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/page-flags.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ccf3c78faefc..e80665bc51fa 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -977,12 +977,16 @@ static __always_inline bool folio_test_##fname(const struct folio *folio) \
 }									\
 static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
+	if (folio_test_##fname(folio))					\
+		return;							\
 	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
 			folio);						\
 	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
+	if (folio->page.page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
 	folio->page.page_type = UINT_MAX;				\
 }
@@ -995,11 +999,15 @@ static __always_inline int Page##uname(const struct page *page)		\
 }									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
+	if (Page##uname(page))						\
+		return;							\
 	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
 	page->page_type = (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
+	if (page->page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type = UINT_MAX;					\
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


