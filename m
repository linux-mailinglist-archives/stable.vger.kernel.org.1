Return-Path: <stable+bounces-67116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00594F3F5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9078F1C21908
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BE183CD9;
	Mon, 12 Aug 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObGv9HKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EF187332;
	Mon, 12 Aug 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479861; cv=none; b=JjD4KMVhPmd5YYWGTqhmMjBMyLORa1KxpyN3H5lI3V1Xek6kcizFJ3B5mKr/U4ZQV6nkRwNtdE1/Y9p0WbCcOHi51BllDfi10YFVxHGhbPKxyJaXSbzc1zNnGSS8ZV6xk5r6HN2EQgd5HSL5EBpYtbq9eL8jKnJ6Q7lvTWLrFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479861; c=relaxed/simple;
	bh=zSN2nUJ0EPuwn1LY/unKOmUusC1Y+9Gn+3U1M67y4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL/RQEJoUUcPNVaevDCeVR01qsdQUiLcDckMtrL6ALkP+IEpSEB4cHeL5j8YH4aeCci/7ywG07S6IFt+l8JCb+N/crH/BgWvfqD2zC/xYBVzn5jEThJwECQecJq2cgyx/EI24Vc6CqeyZvsspKNJqyarPtVbHX2TU6YI9YvhkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ObGv9HKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ED4C32782;
	Mon, 12 Aug 2024 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479861;
	bh=zSN2nUJ0EPuwn1LY/unKOmUusC1Y+9Gn+3U1M67y4u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObGv9HKyCSlUpLOMwn4cLyQWwpqMYG0wEk5UVRqqxLG98JSI0vHcRvthRQvcsGACj
	 pRrR8tQf07JO3ImP+JapvRG6iv4/hFu/P8VMNSprcilkPpK5rlVWd4Qvd/tdiSG7S1
	 Kq33jbD0aGHzF1Ye73OriFOXpE8/NRbtpO892EmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+263426984509be19c9a0@syzkaller.appspotmail.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 024/263] net: bridge: mcast: wait for previous gc cycles when removing port
Date: Mon, 12 Aug 2024 18:00:25 +0200
Message-ID: <20240812160147.466766936@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
index 9a1cb5079a7a0..b2ae0d2434d2e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2045,16 +2045,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
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




