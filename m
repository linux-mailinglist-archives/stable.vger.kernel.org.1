Return-Path: <stable+bounces-125930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF3A6DED5
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D40C3AA8D1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5A25F982;
	Mon, 24 Mar 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6L60PZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB425E446
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830433; cv=none; b=TIKWpFU7qBbvE8lDTGkvdewX/2aAZjYUeYT749w6gFd2sU3cDSbCryZoB7mJ8xtAA3jGe5O7uHDAZItQKV+EIHsmUD3sBcC5jHE76dVCYibgxn2jTasaHBBLsG0F91wfzKzDkpF0a3wZf1wQ9kjyCBH4kNtRLzRzqGS5oXKG8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830433; c=relaxed/simple;
	bh=6NEgnyHQ26lRiOzhiMtveSk4/z7X6EBLLPoNWy8k/Iw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JW4ttQHEumGukI9PdxortLFi4mwmaWhLuLWtnIWYTSdJBVNSnegb9edIhm0D4bFwtci8KixoQ1nWG8mkQy+olsLoBMJajuewvy9CKVs5rDgV62Odf5mT1WRdaqecUYGdCxJtds8iUDC2SEvq3pI1QNDNlgeoAyZUvUhFdg6EvDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6L60PZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C6C4CEDD;
	Mon, 24 Mar 2025 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830432;
	bh=6NEgnyHQ26lRiOzhiMtveSk4/z7X6EBLLPoNWy8k/Iw=;
	h=Subject:To:Cc:From:Date:From;
	b=x6L60PZZj0q9d7XGg0hiBT43JSbXmrqVmZeBm67zRKH66R2Y84zlO8kLbkFay7+Iz
	 WK0hkGO5Dix/ICUl6saGnKsLTyIlky4iOYWA/Dcmkk8lTH/5ffxvoAumC+HhmQ0WW7
	 oSaG821vEP/16QWDdE7fqfXfcmvMQBaMK3W3hLu8=
Subject: FAILED: patch "[PATCH] mm/huge_memory: drop beyond-EOF folios with the right number" failed to apply to 6.12-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@redhat.com,hughd@google.com,jhubbard@nvidia.com,kirill.shutemov@linux.intel.com,linmiaohe@huawei.com,mcgrof@kernel.org,p.raghav@samsung.com,ryan.roberts@arm.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com,willy@infradead.org,yang@os.amperecomputing.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:32:30 -0700
Message-ID: <2025032430-granny-hunter-c6a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 14efb4793519d73fb2902bb0ece319b886e4b4b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032430-granny-hunter-c6a5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14efb4793519d73fb2902bb0ece319b886e4b4b9 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 10 Mar 2025 11:57:27 -0400
Subject: [PATCH] mm/huge_memory: drop beyond-EOF folios with the right number
 of refs

When an after-split folio is large and needs to be dropped due to EOF,
folio_put_refs(folio, folio_nr_pages(folio)) should be used to drop all
page cache refs.  Otherwise, the folio will not be freed, causing memory
leak.

This leak would happen on a filesystem with blocksize > page_size and a
truncate is performed, where the blocksize makes folios split to >0 order
ones, causing truncated folios not being freed.

Link: https://lkml.kernel.org/r/20250310155727.472846-1-ziy@nvidia.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com/
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..373781b21e5c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3304,7 +3304,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
 			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
+			folio_put_refs(tail, folio_nr_pages(tail));
 		} else if (!folio_test_anon(folio)) {
 			__xa_store(&folio->mapping->i_pages, tail->index,
 					tail, 0);


