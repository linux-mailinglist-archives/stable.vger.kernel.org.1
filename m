Return-Path: <stable+bounces-68350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553D9531C8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A91F2146D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359F19DFA6;
	Thu, 15 Aug 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqJYVJ47"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED018D64F;
	Thu, 15 Aug 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730291; cv=none; b=Gji+6lIv27Ua9RNprebwS99L3/iPR9u1/r3s4f8htb5we16aWt+afLhQ3rZkPJFd9tIEQq3Js9bpB40zYgxN2n+7vzndM2qLtssFXYWefuxXByQQEyZufTB4TXJ5LWqAlu6Wzn2sxYw/c5/xkHbkrI77nzzFnrKfyzjeqUQPYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730291; c=relaxed/simple;
	bh=bPalll4QMbfsijfwpGTi8llixoGp85QD2MplMMrAPAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8rQfQC/ElJ3av3ciEMYtvuPxu+Gg6IlAEHFqRFHqYr4qSQCqkTIGCoYTHWS9JRdHPO7WAu9MYpwhoWpCTv8dIEr3A9AhM6clkbZTeQoS9+jxb8gxSQYLHnAHhP0CRQlP63ekkq2YXu915LEHBJWtDVk5wSE5mKZKtI5ejxxr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqJYVJ47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70323C32786;
	Thu, 15 Aug 2024 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730290;
	bh=bPalll4QMbfsijfwpGTi8llixoGp85QD2MplMMrAPAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqJYVJ47Pd0q5QmfwvPuUqFyVzO9P2hjHQssA2XnQvREwDjhzfJXytbReBy0PEg96
	 jXdX7ai5UfvDLpE5GKkeb1s+dpiv9WbhPw//juZPD85wiBfrCnKgxh7xczod5V0d63
	 tvKa7K3SqaAyX1HqLNI2I6rWaqqc9ji4zm5VdvCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+263426984509be19c9a0@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 361/484] net: bridge: mcast: wait for previous gc cycles when removing port
Date: Thu, 15 Aug 2024 15:23:39 +0200
Message-ID: <20240815131955.375559683@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit 92c4ee25208d0f35dafc3213cdf355fbe449e078 ]

syzbot hit a use-after-free[1] which is caused because the bridge doesn't
make sure that all previous garbage has been collected when removing a
port. What happens is:
      CPU 1                   CPU 2
 start gc cycle           remove port
                         acquire gc lock first
 wait for lock
                         call br_multicasg_gc() directly
 acquire lock now but    free port
 the port can be freed
 while grp timers still
 running

Make sure all previous gc cycles have finished by using flush_work before
freeing the port.

[1]
  BUG: KASAN: slab-use-after-free in br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
  Read of size 8 at addr ffff888071d6d000 by task syz.5.1232/9699

  CPU: 1 PID: 9699 Comm: syz.5.1232 Not tainted 6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
   print_address_description mm/kasan/report.c:377 [inline]
   print_report+0xc3/0x620 mm/kasan/report.c:488
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
   call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1843 [inline]
   __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
   __run_timer_base kernel/time/timer.c:2428 [inline]
   __run_timer_base kernel/time/timer.c:2421 [inline]
   run_timer_base+0x111/0x190 kernel/time/timer.c:2437

Reported-by: syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=263426984509be19c9a0
Fixes: e12cec65b554 ("net: bridge: mcast: destroy all entries via gc")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20240802080730.3206303-1-razor@blackwall.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9765f9f9bf7ff..3cd2b648408d6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1890,16 +1890,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
-	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
-	br_multicast_gc(&deleted_head);
+	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
 	free_percpu(port->mcast_stats);
 }
-- 
2.43.0




