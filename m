Return-Path: <stable+bounces-197937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662AAC982A2
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C081344586
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5F2F60D8;
	Mon,  1 Dec 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kt5tHZ9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0270284889
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605065; cv=none; b=YBoReFbHV0muW1XZfZfwf4VhkpK5XTjW0LVDzxcujAGx+96zm1d/odudzE6xvmXjLi63+Tle8IR0oxhuiW314kA3L2fJcLFSj+p2Gij8zW4ItevhKhvU5q/tKpuwXqkhqqMixzqVmX3ayJDEgypcJjIFxlRY9xHOTIR0Y4JGG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605065; c=relaxed/simple;
	bh=VVysza45+EyHGdZkCgEYCP58nSmgX+I6fO6NGhUSFqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kF02FvRaiUxw2d/VwHMqSz4Az2awFKANTxI3iiHf/K6eRonJW8P/Q4QrUQCbq30lBxb5c5Se59Jpu1avH9NSV7bxe+JnViSOUbnEh4nKC+Y75w/l+3ZZJNnN8PrUw8i+wjQ41awu6vQCe7sDA4ADcJ5gkmTgrCwbCTeaCjQVhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kt5tHZ9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B41C4CEF1;
	Mon,  1 Dec 2025 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764605064;
	bh=VVysza45+EyHGdZkCgEYCP58nSmgX+I6fO6NGhUSFqQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Kt5tHZ9i3ZbU/6fXjqqPQ2s9qs2datk4c8gvMj9wU3cBZC2wPjnF2NrBtRrMP4GPO
	 N9cEIPcqy3CrUwup6vOnfrYU/OVdJmnGr0+YMg5/ekxbMtZm4xS6zIBNXLL/vzrS++
	 dzaU6JpaXKc0A8dEdMwLMhYM/suV1GNtvtukYM5k=
Subject: FAILED: patch "[PATCH] mm: swap: remove duplicate nr_swap_pages decrement in" failed to apply to 6.17-stable tree
To: youngjun.park@lge.com,akpm@linux-foundation.org,baohua@kernel.org,bhe@redhat.com,chrisl@kernel.org,kasong@tencent.com,nphamcs@gmail.com,shikemeng@huaweicloud.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 17:04:21 +0100
Message-ID: <2025120121-fifteen-liver-792b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x f5e31a196edcd1f1bb44f26b6f9299b9a5b9b3c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120121-fifteen-liver-792b@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5e31a196edcd1f1bb44f26b6f9299b9a5b9b3c4 Mon Sep 17 00:00:00 2001
From: Youngjun Park <youngjun.park@lge.com>
Date: Sun, 2 Nov 2025 17:24:56 +0900
Subject: [PATCH] mm: swap: remove duplicate nr_swap_pages decrement in
 get_swap_page_of_type()

After commit 4f78252da887, nr_swap_pages is decremented in
swap_range_alloc(). Since cluster_alloc_swap_entry() calls
swap_range_alloc() internally, the decrement in get_swap_page_of_type()
causes double-decrementing.

As a representative userspace-visible runtime example of the impact,
/proc/meminfo reports increasingly inaccurate SwapFree values.  The
discrepancy grows with each swap allocation, and during hibernation
when large amounts of memory are written to swap, the reported value
can deviate significantly from actual available swap space, misleading
users and monitoring tools.

Remove the duplicate decrement.

Link: https://lkml.kernel.org/r/20251102082456.79807-1-youngjun.park@lge.com
Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: <stable@vger.kernel.org> [6.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 10760240a3a2..a1b4b9d80e3b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2005,10 +2005,8 @@ swp_entry_t get_swap_page_of_type(int type)
 			local_lock(&percpu_swap_cluster.lock);
 			offset = cluster_alloc_swap_entry(si, 0, 1);
 			local_unlock(&percpu_swap_cluster.lock);
-			if (offset) {
+			if (offset)
 				entry = swp_entry(si->type, offset);
-				atomic_long_dec(&nr_swap_pages);
-			}
 		}
 		put_swap_device(si);
 	}


