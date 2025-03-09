Return-Path: <stable+bounces-121593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C909A586F1
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA863188B4EA
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AB1F4CB4;
	Sun,  9 Mar 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dN7rGs+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC411EF395
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544089; cv=none; b=PxzXQJ6LIQT8Sv7QuvUg6UcZFzWrJOipKH51a+nYGXlOdv7EGVN0m2yzVZsq6GMvsj21R5Otpv+LGx3UXjyerhfSQ96VJgXWaeb801fDK5Fn8ko4da1xP0EzXLTxPnfIDL4j/+U4bFoweoecdDLDivl5VjkMrOnCOEgt3Qsp3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544089; c=relaxed/simple;
	bh=IF0g0/NRC4hKH9l2yZBS2lBUDyU/W4vPXRfl8zPOFi8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B3p7WshtKEpTEIX9J7OVQHzpHNj8x+niAbikxQqje/h0u09h0BkF9EN6iW0bSsdqSFcmapAE8KXTYnv1ZFVTLdtwFqGZYynsm+jMKROp05R70WfZlyeneOWvK+QaxgrEEp+XEe5rUhy3o6xkL4a+5Y+XawrFSVhHDGOyY1+5Xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dN7rGs+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA4AC4CEE3;
	Sun,  9 Mar 2025 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544089;
	bh=IF0g0/NRC4hKH9l2yZBS2lBUDyU/W4vPXRfl8zPOFi8=;
	h=Subject:To:Cc:From:Date:From;
	b=dN7rGs+S41j9Et6Pk8iyXRKPLfbS3UOSIiqs4zlOe3w97686U8qxDPLlI7aWII/EZ
	 /TagT3b7UBlA7enwJWcaals2HmmzHZMF+fIS7V3G+cunPq03B21GgJTqjud1RI5YoP
	 DXg2NsntmoJhznUC4xAp0RxBsh16uN4V+dcBtzRo=
Subject: FAILED: patch "[PATCH] hwpoison, memory_hotplug: lock folio before unmap hwpoisoned" failed to apply to 5.4-stable tree
To: mawupeng1@huawei.com,akpm@linux-foundation.org,david@redhat.com,linmiaohe@huawei.com,mhocko@suse.com,nao.horiguchi@gmail.com,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:14:37 +0100
Message-ID: <2025030937-relax-dubbed-d185@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x af288a426c3e3552b62595c6138ec6371a17dbba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030937-relax-dubbed-d185@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af288a426c3e3552b62595c6138ec6371a17dbba Mon Sep 17 00:00:00 2001
From: Ma Wupeng <mawupeng1@huawei.com>
Date: Mon, 17 Feb 2025 09:43:29 +0800
Subject: [PATCH] hwpoison, memory_hotplug: lock folio before unmap hwpoisoned
 folio

Commit b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to
be offlined) add page poison checks in do_migrate_range in order to make
offline hwpoisoned page possible by introducing isolate_lru_page and
try_to_unmap for hwpoisoned page.  However folio lock must be held before
calling try_to_unmap.  Add it to fix this problem.

Warning will be produced if folio is not locked during unmap:

  ------------[ cut here ]------------
  kernel BUG at ./include/linux/swapops.h:400!
  Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 4 UID: 0 PID: 411 Comm: bash Tainted: G        W          6.13.0-rc1-00016-g3c434c7ee82a-dirty #41
  Tainted: [W]=WARN
  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
  pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : try_to_unmap_one+0xb08/0xd3c
  lr : try_to_unmap_one+0x3dc/0xd3c
  Call trace:
   try_to_unmap_one+0xb08/0xd3c (P)
   try_to_unmap_one+0x3dc/0xd3c (L)
   rmap_walk_anon+0xdc/0x1f8
   rmap_walk+0x3c/0x58
   try_to_unmap+0x88/0x90
   unmap_poisoned_folio+0x30/0xa8
   do_migrate_range+0x4a0/0x568
   offline_pages+0x5a4/0x670
   memory_block_action+0x17c/0x374
   memory_subsys_offline+0x3c/0x78
   device_offline+0xa4/0xd0
   state_store+0x8c/0xf0
   dev_attr_store+0x18/0x2c
   sysfs_kf_write+0x44/0x54
   kernfs_fop_write_iter+0x118/0x1a8
   vfs_write+0x3a8/0x4bc
   ksys_write+0x6c/0xf8
   __arm64_sys_write+0x1c/0x28
   invoke_syscall+0x44/0x100
   el0_svc_common.constprop.0+0x40/0xe0
   do_el0_svc+0x1c/0x28
   el0_svc+0x30/0xd0
   el0t_64_sync_handler+0xc8/0xcc
   el0t_64_sync+0x198/0x19c
  Code: f9407be0 b5fff320 d4210000 17ffff97 (d4210000)
  ---[ end trace 0000000000000000 ]---

Link: https://lkml.kernel.org/r/20250217014329.3610326-4-mawupeng1@huawei.com
Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a6abd8d4a09c..16cf9e17077e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1832,8 +1832,11 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
-			if (folio_mapped(folio))
+			if (folio_mapped(folio)) {
+				folio_lock(folio);
 				unmap_poisoned_folio(folio, pfn, false);
+				folio_unlock(folio);
+			}
 
 			goto put_folio;
 		}


