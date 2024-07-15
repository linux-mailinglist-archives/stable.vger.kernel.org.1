Return-Path: <stable+bounces-59333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4793131B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6212827DD
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611C4500D;
	Mon, 15 Jul 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzAaEY+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412C1E89C
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043095; cv=none; b=QHNAN099cgAlcZOsFVO2qrZJH6sA6W3w3SpbSiK5MI9Cv7YPdaJkBOuz55bYmOrUUhAso7Qit4YIdxatbV2CLDAAku8iljBl9JvC7dwOAbOYr1eMt6UQiZVfKUzX0wjyo7DPxKc0BFbiHIwYINzFHSmxeDcWBnfTGFO1iaNPJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043095; c=relaxed/simple;
	bh=4e1blWcsnCUhvxx6gABQ3t5zaaTYFZv4YtlSmbhjoQI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KJJ/+G3gKe1iPwYa6I9kVjomrJ5go7dlCSgQkf/afAKKJUnIhCI8jNGmvSbYZcSHp32STI8vSHi3jjIx8Elj/dr23UDI6yPgckXwLBoFXoMMwDF11Dl9XEq4P7Ul7Inz0yetCoH++dfqlGUNif0stPI35aMpx6/zl+XtR9VoRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzAaEY+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2287BC32782;
	Mon, 15 Jul 2024 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043094;
	bh=4e1blWcsnCUhvxx6gABQ3t5zaaTYFZv4YtlSmbhjoQI=;
	h=Subject:To:Cc:From:Date:From;
	b=vzAaEY+hoUdsSqjcwddaPdtFdQxU6Q7/roplG8VTGY760214rLkP2164aCUzQ1pNm
	 GoW/pb7Q1+O014usY3qLitZyHJTFpK+ZCCMVbScsPBCL1jNz89QgUOiJP/Ka1TiZVv
	 gpg4jaSBMNki/goAnJxkjf7Dex2nQOfN18KXTcl8=
Subject: FAILED: patch "[PATCH] mm/readahead: limit page cache size in page_cache_ra_order()" failed to apply to 6.6-stable tree
To: gshan@redhat.com,akpm@linux-foundation.org,david@redhat.com,ddutile@redhat.com,djwong@kernel.org,hughd@google.com,ryan.roberts@arm.com,stable@vger.kernel.org,torvalds@linux-foundation.org,william.kucharski@oracle.com,willy@infradead.org,zhenyzha@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:31:31 +0200
Message-ID: <2024071531-junkyard-cornea-9a80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1f789a45c3f1aa77531db21768fca70b66c0eeb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071531-junkyard-cornea-9a80@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1f789a45c3f1 ("mm/readahead: limit page cache size in page_cache_ra_order()")
e03c16fb4af1 ("readahead: use ilog2 instead of a while loop in page_cache_ra_order()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f789a45c3f1aa77531db21768fca70b66c0eeb1 Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Thu, 27 Jun 2024 10:39:50 +1000
Subject: [PATCH] mm/readahead: limit page cache size in page_cache_ra_order()

In page_cache_ra_order(), the maximal order of the page cache to be
allocated shouldn't be larger than MAX_PAGECACHE_ORDER.  Otherwise, it's
possible the large page cache can't be supported by xarray when the
corresponding xarray entry is split.

For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size is
64KB.  The PMD-sized page cache can't be supported by xarray.

Link: https://lkml.kernel.org/r/20240627003953.1262512-3-gshan@redhat.com
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: <stable@vger.kernel.org>	[5.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..817b2a352d78 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < MAX_PAGECACHE_ORDER)
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	}
+
+	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();


