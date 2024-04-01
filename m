Return-Path: <stable+bounces-34459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDAA893F70
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEC1C216E5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657801DFFC;
	Mon,  1 Apr 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUtMJuZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B77446AC;
	Mon,  1 Apr 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988194; cv=none; b=PGoRnu4NOWwzJgz56JodIyWCDfsBdnfjE6ZeN5Sm15CTiwXxe3b+ixA6KHAd7jPLqtktPkt1/TTs1jqf4IA57lFCU+REyUGBQampA90wymBvKje9lO/eYF8zwPQn/OuKqVq32iHc4eNfuoemBfqJK0qNMONNOnxF9bXh64quEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988194; c=relaxed/simple;
	bh=3tevZB4sAqbrR8H49Uoup/N0K1pZtzerwUIAIK2rP4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9EtGqMMAttTLJ5Wv0iSQkE5c9CGXlhDVAIJ0IY9cR+gZEJF/eB/Tc3JKeBEcvzQudOaHzMfoywC5s3nu/i5MC0b/4h107EaXgLL/jy6iQHPFGCOS+9G0CBfP8N3vV4bzaLrS7XNmOPvHMtaDSwmIe7deH+vjk1pVD8m6JeukHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUtMJuZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B955FC433F1;
	Mon,  1 Apr 2024 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988193;
	bh=3tevZB4sAqbrR8H49Uoup/N0K1pZtzerwUIAIK2rP4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUtMJuZtRUDzFN5pjcOF7x9zJQZQ36DZRRO/fM6DNkewT2Yp+JFtZev8Es2jxvtlh
	 J6Z/J6LKrbCXX8bP+LaFVTFyBXzOZT3Hr05xgWS0hPnAcj8agrOaYi+8c+XlH/V0zs
	 beckWch2aihoXVvnh2hwkjaFwGst1gTNMuxyGGSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 112/432] mm: swap: fix race between free_swap_and_cache() and swapoff()
Date: Mon,  1 Apr 2024 17:41:39 +0200
Message-ID: <20240401152556.469367725@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit 82b1c07a0af603e3c47b906c8e991dc96f01688e ]

There was previously a theoretical window where swapoff() could run and
teardown a swap_info_struct while a call to free_swap_and_cache() was
running in another thread.  This could cause, amongst other bad
possibilities, swap_page_trans_huge_swapped() (called by
free_swap_and_cache()) to access the freed memory for swap_map.

This is a theoretical problem and I haven't been able to provoke it from a
test case.  But there has been agreement based on code review that this is
possible (see link below).

Fix it by using get_swap_device()/put_swap_device(), which will stall
swapoff().  There was an extra check in _swap_info_get() to confirm that
the swap entry was not free.  This isn't present in get_swap_device()
because it doesn't make sense in general due to the race between getting
the reference and swapoff.  So I've added an equivalent check directly in
free_swap_and_cache().

Details of how to provoke one possible issue (thanks to David Hildenbrand
for deriving this):

--8<-----

__swap_entry_free() might be the last user and result in
"count == SWAP_HAS_CACHE".

swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.

So the question is: could someone reclaim the folio and turn
si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().

Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
still references by swap entries.

Process 1 still references subpage 0 via swap entry.
Process 2 still references subpage 1 via swap entry.

Process 1 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE
[then, preempted in the hypervisor etc.]

Process 2 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE

Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
__try_to_reclaim_swap().

__try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
swap_entry_free()->swap_range_free()->
...
WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);

What stops swapoff to succeed after process 2 reclaimed the swap cache
but before process1 finished its call to swap_page_trans_huge_swapped()?

--8<-----

Link: https://lkml.kernel.org/r/20240306140356.3974886-1-ryan.roberts@arm.com
Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 022581ec40be3..91397a2539cbe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1226,6 +1226,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * with get_swap_device() and put_swap_device(), unless the swap
  * functions call get/put_swap_device() by themselves.
  *
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1603,13 +1608,19 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (non_swap_entry(entry))
 		return 1;
 
-	p = _swap_info_get(entry);
+	p = get_swap_device(entry);
 	if (p) {
+		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
+			put_swap_device(p);
+			return 0;
+		}
+
 		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		put_swap_device(p);
 	}
 	return p != NULL;
 }
-- 
2.43.0




