Return-Path: <stable+bounces-55383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C271916359
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279571F21703
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87161494AF;
	Tue, 25 Jun 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDFhSoGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551C1465A8;
	Tue, 25 Jun 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308742; cv=none; b=tXKILZccf3OCpgg01V54DSJVwfojtXPASThGoX1rEA0W0IBhtmGHZGtRPlVZhJ358xjty315DMv0g3DlOQ1cv75DVuVHtfpcuV6/1CXufuyq2UAJaR0aSCZzUss+Dt28GZelggTDSIURg3ZYPUp8ukhqzQgFUZLRi2uYK15qAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308742; c=relaxed/simple;
	bh=GBR3LXpubMTS8rxFkIPjdThzAZCfFvsEFMu9U0gdtMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4oM7I3mIY5++ld5hbtCYAiQJIPjAnu48p4uacDc7U39mtcs7YBhrymj5pmqu79EvQ4b67Y72a6iesLDn9jgnz9m6NbmNSBm8oeAz94I76kFNii7FeOzstynmIXmiegE7KGOQV0v6MHImrfgKmwuF4jRB2vEiuIq/vBDGw6/KmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDFhSoGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B83C32781;
	Tue, 25 Jun 2024 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308742;
	bh=GBR3LXpubMTS8rxFkIPjdThzAZCfFvsEFMu9U0gdtMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDFhSoGXRE8dz84d+fw9Ep08HKDtu4WzhwTYEUP0k/fdSbEnUZJ7gYhOe7vZpug8x
	 iAJ1fE4Rfn1Qzeb2bYnM9uPPEuJPUFKUPjRD4wvuhA6AXCEmzHm4q1HJEFWYrtLaTi
	 WI623REztHrNMFmjsXA11OiCFwQ+MCVrgYEu8Z8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9 224/250] mm: shmem: fix getting incorrect lruvec when replacing a shmem folio
Date: Tue, 25 Jun 2024 11:33:02 +0200
Message-ID: <20240625085556.651070015@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linux.alibaba.com>

commit 9094b4a1c76cfe84b906cc152bab34d4ba26fa5c upstream.

When testing shmem swapin, I encountered the warning below on my machine.
The reason is that replacing an old shmem folio with a new one causes
mem_cgroup_migrate() to clear the old folio's memcg data.  As a result,
the old folio cannot get the correct memcg's lruvec needed to remove
itself from the LRU list when it is being freed.  This could lead to
possible serious problems, such as LRU list crashes due to holding the
wrong LRU lock, and incorrect LRU statistics.

To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
to replace the old shmem folio.

[ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d9960
[ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
[ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
[ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
[ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0000000000000000
[ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[ 5241.100338] ------------[ cut here ]------------
[ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:775 folio_lruvec_lock_irqsave+0x140/0x150
[...]
[ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
[ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
[ 5241.100376] sp : ffff80008b38b930
[...]
[ 5241.100398] Call trace:
[ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
[ 5241.100401]  __page_cache_release+0x90/0x300
[ 5241.100404]  __folio_put+0x50/0x108
[ 5241.100406]  shmem_replace_folio+0x1b4/0x240
[ 5241.100409]  shmem_swapin_folio+0x314/0x528
[ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
[ 5241.100412]  shmem_fault+0x74/0x160
[ 5241.100414]  __do_fault+0x40/0x218
[ 5241.100417]  do_shared_fault+0x34/0x1b0
[ 5241.100419]  do_fault+0x40/0x168
[ 5241.100420]  handle_pte_fault+0x80/0x228
[ 5241.100422]  __handle_mm_fault+0x1c4/0x440
[ 5241.100424]  handle_mm_fault+0x60/0x1f0
[ 5241.100426]  do_page_fault+0x120/0x488
[ 5241.100429]  do_translation_fault+0x4c/0x68
[ 5241.100431]  do_mem_abort+0x48/0xa0
[ 5241.100434]  el0_da+0x38/0xc0
[ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
[ 5241.100437]  el0t_64_sync+0x14c/0x150
[ 5241.100439] ---[ end trace 0000000000000000 ]---

[baolin.wang@linux.alibaba.com: remove less helpful comments, per Matthew]
  Link: https://lkml.kernel.org/r/ccad3fe1375b468ebca3227b6b729f3eaf9d8046.1718423197.git.baolin.wang@linux.alibaba.com
Link: https://lkml.kernel.org/r/3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com
Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    3 +--
 mm/shmem.c      |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7531,8 +7531,7 @@ void __mem_cgroup_uncharge_folios(struct
  * @new: Replacement folio.
  *
  * Charge @new as a replacement folio for @old. @old will
- * be uncharged upon free. This is only used by the page cache
- * (in replace_page_cache_folio()).
+ * be uncharged upon free.
  *
  * Both folios must be locked, @new->mapping must be set up.
  */
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1786,7 +1786,7 @@ static int shmem_replace_folio(struct fo
 	xa_lock_irq(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, old, new);
 	if (!error) {
-		mem_cgroup_migrate(old, new);
+		mem_cgroup_replace_folio(old, new);
 		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
 		__lruvec_stat_mod_folio(new, NR_SHMEM, 1);
 		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);



