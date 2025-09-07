Return-Path: <stable+bounces-178815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB5B48105
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB451897DA9
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A92223DD9;
	Sun,  7 Sep 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSbnLXAt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DB22258C
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283985; cv=none; b=llBPWc77FDB+RH2Ev8YfANtQU+GcMlWFDj7fZYw+TwXKWZNMNuUmb0oRedd097S8lIJ1tiD/Ovuu7qLn07xJQPEqgygf3nxRWI/48l6gqz9bk02r2BVeqfURs5pQUDv8n+P40ke5wbjD64ATr8bHx3OrmB99XBWGjNruXOu+2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283985; c=relaxed/simple;
	bh=iTdczuKyxSrJYzwFcLxO9GNAlg2euIKIYd6uKrGA2X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feNzHj3tlkpCcqtoswt6LmQrYXuP8bOkiQhzNpBkUTpf4/Nze5Fj9ExNI5gPGLJg2u1ukUX6D1/hLxZ92VThVZgKjgI9z3ivRbSHuuqPIzUWGz0l6n8sr21dtegnUazJZ5iJ2RmnEvooQx85z1hEPyuwV83lfv07164lmVf9k18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSbnLXAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86591C4CEF0;
	Sun,  7 Sep 2025 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757283984;
	bh=iTdczuKyxSrJYzwFcLxO9GNAlg2euIKIYd6uKrGA2X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSbnLXAtuXZQo9E+jX/EQLgmN8Ij47hKuVaxjSUyLE8RsPz9PY1isryo5T8hFnE/W
	 UQzSWm20nJ1Cq0tn5DMxipPqidkuD0rTkPztswIHFRKB18TLQFPantT3WB0pm9TGCa
	 9y1zI0zGdvFt8PqTtouhB7c/gkRrvq6SJ8yGURh2GVjrPNLk7Qzeg/vrtB48dJ2Y8+
	 xBAygrYzRx7Y5YO38UbnMqp22+6XPmNNtHqx9Mqm8iQp/Ln8q7bIIHRw7UtIf/zGwR
	 w6rvFc3LPIw73OhkxZ66w2EM+jG405lHcAGX5/nq3Mq/tgSMIe1Q1bahL2kc8eFHkv
	 LEn6+qHQLyleg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Alex Shi <alexs@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@gmail.com>,
	Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Karol Herbst <kherbst@redhat.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Lyude <lyude@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yanteng Si <si.yanteng@linux.dev>,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/rmap: reject hugetlb folios in folio_make_device_exclusive()
Date: Sun,  7 Sep 2025 18:26:20 -0400
Message-ID: <20250907222620.932696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041752-tightwad-catwalk-8586@gregkh>
References: <2025041752-tightwad-catwalk-8586@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit bc3fe6805cf09a25a086573a17d40e525208c5d8 ]

Even though FOLL_SPLIT_PMD on hugetlb now always fails with -EOPNOTSUPP,
let's add a safety net in case FOLL_SPLIT_PMD usage would ever be
reworked.

In particular, before commit 9cb28da54643 ("mm/gup: handle hugetlb in the
generic follow_page_mask code"), GUP(FOLL_SPLIT_PMD) would just have
returned a page.  In particular, hugetlb folios that are not PMD-sized
would never have been prone to FOLL_SPLIT_PMD.

hugetlb folios can be anonymous, and page_make_device_exclusive_one() is
not really prepared for handling them at all.  So let's spell that out.

Link: https://lkml.kernel.org/r/20250210193801.781278-3-david@redhat.com
Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alistair Popple <apopple@nvidia.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Lyude <lyude@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ folio_test_hugetlb() => PageHuge() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 330b361a460ea..cb133bd49e029 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2184,7 +2184,7 @@ static bool page_make_device_exclusive(struct page *page, struct mm_struct *mm,
 	 * issues. Also tail pages shouldn't be passed to rmap_walk so skip
 	 * those.
 	 */
-	if (!PageAnon(page) || PageTail(page))
+	if (!PageAnon(page) || PageTail(page) || PageHuge(page))
 		return false;
 
 	rmap_walk(page, &rwc);
-- 
2.51.0


