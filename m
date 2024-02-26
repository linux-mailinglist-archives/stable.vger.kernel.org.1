Return-Path: <stable+bounces-23648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05591867157
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FF71F2BC00
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816245467E;
	Mon, 26 Feb 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNzKJsQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002D53E3F
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943413; cv=none; b=qyO44NJxNzJZ5a/A0ziG+l53vVVp2NpbZ61FZOtadTYy3rtIc0gESJ4Ri9TcQYi6fIMDOHOh2uvoT6hA+76TvSEl0LC/0iXPZGDVxjdzc6wuE6qpwjSkJ6lsHnDpLzpsOL/mfoiM6q1AeFx8tvu8eHqlwOPPPyPeRSkpe8JkguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943413; c=relaxed/simple;
	bh=GZ+Wzx1nOyqamrgFHyaW/pngHPq3gMhYhW2ARzXcb34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J4rL6YwPaZjzBoQEl28ASzfNRjIN5sGv1XCB0kL7mm822ji7nQ23bkco6bL9MS4ie5OA/UM0Y5iOnUlU+vacKDyDUJPdj56exgHDzHOcJhalUxZNww/iPD2nB8kn2hKlT6QEJmrczevYt7qbPXIw9WFEJomu6w9OcJW+TrhvBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNzKJsQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7501C43394;
	Mon, 26 Feb 2024 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943413;
	bh=GZ+Wzx1nOyqamrgFHyaW/pngHPq3gMhYhW2ARzXcb34=;
	h=Subject:To:Cc:From:Date:From;
	b=DNzKJsQWotkT2EauG+C31GqQgo4SaQ2Gtpq2xITTwlZAt3WlGpxCLdF/NiGcewuGG
	 1WJtF84NO+d4hF9VsSZCSFBAX7wodqg1VXiTJIgquT3pW8ft+0qmdFTN22OLV8UB94
	 T2BWf81yXil4L6SP4xtums5Z/wiJCc2dUaCwwCDU=
Subject: FAILED: patch "[PATCH] mm: zswap: fix missing folio cleanup in writeback race path" failed to apply to 6.7-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,cerasuolodomenico@gmail.com,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org,zhouchengming@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:30:10 +0100
Message-ID: <2024022610-amino-basically-add3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x e3b63e966cac0bf78aaa1efede1827a252815a1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022610-amino-basically-add3@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

e3b63e966cac ("mm: zswap: fix missing folio cleanup in writeback race path")
96c7b0b42239 ("mm: return the folio from __read_swap_cache_async()")
e947ba0bbf47 ("mm/zswap: cleanup zswap_writeback_entry()")
32acba4c0483 ("mm/zswap: refactor out __zswap_load()")
c75f5c1e0f1d ("mm/zswap: reuse dstmem when decompress")
b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
a65b0e7607cc ("zswap: make shrinking memcg-aware")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3b63e966cac0bf78aaa1efede1827a252815a1d Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 08:51:27 +0000
Subject: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled.  If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd.  Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path handles
a race condition that should not happen often, and the bug would not crash
the system, it will only strand the folio indefinitely.

Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 350dd2fc8159..d2423247acfd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1440,6 +1440,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);


