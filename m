Return-Path: <stable+bounces-25846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7686FAF4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CC62829E7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068F813FF0;
	Mon,  4 Mar 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyUSdKxs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DF15AE0
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537818; cv=none; b=EUYu75Irg3Nybuq9Cq/Ynua821q/CFWJevfDbG3bOxkD8fN60oA22D8uXNmxkQv2I9khQYIalI91fjFSQzpPogYWwxi/zG9eolYN8fhgThONsr2zE3gP8H3FiTAv8QU0MBTyF/t/+/0YEWP2WKUu69Sity3rZNR4MbeHB0SPYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537818; c=relaxed/simple;
	bh=6Q4RuIKOjCURVgJ23tm1/m5YK3k3VyZlKBfW0hT4Uxg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bvcFkJIGaSqOJrOqZEOA5uo+ycbj5leobNFiNUpxlhmA7DHNFsF09/EYMhovPISG3uKHQuAd8xFIZ6okgBqwPeWOAyJeu82FLYgzUWw50W2wSuTD0kRFkAOrep4h3x2CFw9XhY8QdHU8NAsX46+53Kf2yj0Der+cvsssPFRt6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyUSdKxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5195C433F1;
	Mon,  4 Mar 2024 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537818;
	bh=6Q4RuIKOjCURVgJ23tm1/m5YK3k3VyZlKBfW0hT4Uxg=;
	h=Subject:To:Cc:From:Date:From;
	b=zyUSdKxsY/+mSX1pqaLZIvuHSot/UJ4KvoP/Yu6QrfIOfIdOuFDUw79GVbIeF+Wng
	 OZUmtDfIR1O7srOI7tgmaGN+C0WI1QJdTy5yx8zK1HPdSNIHh3VN0NKCHM/3jDJbKv
	 x9mo3mAz/LC6OnVmShFklLlkNVSjNzMMpW6X9u+4=
Subject: FAILED: patch "[PATCH] mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong" failed to apply to 6.6-stable tree
To: byungchul@sk.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,hannes@cmpxchg.org,hyeongtak.ji@sk.com,osalvador@suse.de,stable@vger.kernel.org,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:36:55 +0100
Message-ID: <2024030455-recite-camera-0413@gregkh>
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
git cherry-pick -x 2774f256e7c0219e2b0a0894af1c76bdabc4f974
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030455-recite-camera-0413@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2774f256e7c0219e2b0a0894af1c76bdabc4f974 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 16 Feb 2024 20:15:02 +0900
Subject: [PATCH] mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong
 zone index

With numa balancing on, when a numa system is running where a numa node
doesn't have its local memory so it has no managed zones, the following
oops has been observed.  It's because wakeup_kswapd() is called with a
wrong zone index, -1.  Fixed it by checking the index before calling
wakeup_kswapd().

> BUG: unable to handle page fault for address: 00000000000033f3
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> Code: (omitted)
> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
> ? __die
> ? page_fault_oops
> ? __pte_offset_map_lock
> ? exc_page_fault
> ? asm_exc_page_fault
> ? wakeup_kswapd
> migrate_misplaced_page
> __handle_mm_fault
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> RIP: 0033:0x55b897ba0808
> Code: (omitted)
> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>  </TASK>

Link: https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..c27b1f8097d4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2519,6 +2519,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return 0;
+
 		wakeup_kswapd(pgdat->node_zones + z, 0,
 			      folio_order(folio), ZONE_MOVABLE);
 		return 0;


