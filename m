Return-Path: <stable+bounces-133070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE7AA91B3C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86FB460918
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245FE238164;
	Thu, 17 Apr 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8UhZBNS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EC22E412
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890554; cv=none; b=EniUTSqhu5X35uJClzY4dvBV+O04hsXblSwEjRWUtIwk/IzBweWe8rJ3EnlBR0SzHEHHeye1O1psT2yM0uU1W5S+hsw3D87eCzPhbfZObZT7oRM26du8jvMOxALMSnkvgK2FnAVTxLKMUmy4u9psPlHom6vpsfuxZfwVQInFgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890554; c=relaxed/simple;
	bh=NuKIoApXnElDfAc7v626x0sT3N+EK6wUaeWiK/2Lm/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p7KmzEZHju115Aw27xY2CE2P9gwW7WPqSRzHyq0Xx9m+oD20NtD0E3bTmyy/QiW8KmvDD06H2gssYXpZqLulChOFiVLci9EsP8c7RsvtKUZWejWrNmZgSCLkduSnzlSN85qV5iTMbCjeR3Cjwc67gDrOSXJ06ymw/WjLTlebcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8UhZBNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E1C4CEE4;
	Thu, 17 Apr 2025 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744890554;
	bh=NuKIoApXnElDfAc7v626x0sT3N+EK6wUaeWiK/2Lm/I=;
	h=Subject:To:Cc:From:Date:From;
	b=O8UhZBNSIXr6eRZ0E8p3XTbUYrMsYrhm5BSU6tW0I6MeVJOa8BVfVaAxG2ysFl+aL
	 AUgzvIkzYyYAvrcbSgBLZSm9HW9IDOePaa8XIaMTAfLOkPR9JCVKej03eo0azb4tPe
	 M+GYxNu2uzoy0p/B9r56/nlSWCuFFfF1XSE4sEWs=
Subject: FAILED: patch "[PATCH] mm/rmap: reject hugetlb folios in" failed to apply to 5.15-stable tree
To: david@redhat.com,airlied@gmail.com,akpm@linux-foundation.org,alexs@kernel.org,apopple@nvidia.com,corbet@lwn.net,dakr@kernel.org,jannh@google.com,jgg@nvidia.com,jglisse@redhat.com,jhubbard@nvidia.com,kherbst@redhat.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,lyude@redhat.com,mhiramat@kernel.org,oleg@redhat.com,pasha.tatashin@soleen.com,peterx@redhat.com,peterz@infradead.org,si.yanteng@linux.dev,simona.vetter@ffwll.ch,sj@kernel.org,stable@vger.kernel.org,v-songbaohua@oppo.com,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:45:52 +0200
Message-ID: <2025041752-tightwad-catwalk-8586@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bc3fe6805cf09a25a086573a17d40e525208c5d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041752-tightwad-catwalk-8586@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc3fe6805cf09a25a086573a17d40e525208c5d8 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 10 Feb 2025 20:37:44 +0100
Subject: [PATCH] mm/rmap: reject hugetlb folios in
 folio_make_device_exclusive()

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

diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7..17fbfa61f7ef 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2499,7 +2499,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);


