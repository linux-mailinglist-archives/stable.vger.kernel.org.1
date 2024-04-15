Return-Path: <stable+bounces-39902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A82A8A5547
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AC7B24ADA
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AB757FB;
	Mon, 15 Apr 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cx8ibR7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDD73163;
	Mon, 15 Apr 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192160; cv=none; b=Sf9Lo9Qw+6u9LFkjYeB4bwcIiXWBDuu5FU43yrFkZ0LJcNA3xgsZa2YqjrG68wsTQTC6NE/d6M4DyvineZ/5bVye3cJpLNQMRnveEemjVqKDiUQ0DRXZaU4G6RTSnfwu1Ia1TfD3Fsk/R5ZEO08YcoZ/DU4xgQ8jEkbvk1tR3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192160; c=relaxed/simple;
	bh=EIpD9HMpiIyN/t0uHT98yGGzg1alakdgx6bVhcjeWTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPTv23WeJNhHAx8pbGofSdaaYKxC7NdPPS0txSJd2PCtG1/vhpwYclyS3AQQP6238aouD5apiQBJgtPxjelAPb0wk+mIyp5W27qXJ4gbNwnpsxjEEADXdOTuxuzXSqPWbkbx3O/hKp/CKYer4QP4MC6pEE6FIjRIcSFhntOaMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cx8ibR7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6AEC113CC;
	Mon, 15 Apr 2024 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192160;
	bh=EIpD9HMpiIyN/t0uHT98yGGzg1alakdgx6bVhcjeWTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx8ibR7qT/J6rE7+N0ZgFkYAvhmfYbPka+lDAtCshZk1sRzy847LLMOgZMoWR+EkU
	 A+j2eJjFgVm/qnEfy5dNR1gcjzCDgXORU8C4Zxl84JaQi1Yql7ceuB55a8jgwr7JAa
	 bDv6KE5h2VMWKSPOPgXiyvDxJ41biv5qfG5TzrGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/45] ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr
Date: Mon, 15 Apr 2024 16:21:24 +0200
Message-ID: <20240415141942.762833100@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
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

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit 7633c4da919ad51164acbf1aa322cc1a3ead6129 ]

Although ipv6_get_ifaddr walks inet6_addr_lst under the RCU lock, it
still means hlist_for_each_entry_rcu can return an item that got removed
from the list. The memory itself of such item is not freed thanks to RCU
but nothing guarantees the actual content of the memory is sane.

In particular, the reference count can be zero. This can happen if
ipv6_del_addr is called in parallel. ipv6_del_addr removes the entry
from inet6_addr_lst (hlist_del_init_rcu(&ifp->addr_lst)) and drops all
references (__in6_ifa_put(ifp) + in6_ifa_put(ifp)). With bad enough
timing, this can happen:

1. In ipv6_get_ifaddr, hlist_for_each_entry_rcu returns an entry.

2. Then, the whole ipv6_del_addr is executed for the given entry. The
   reference count drops to zero and kfree_rcu is scheduled.

3. ipv6_get_ifaddr continues and tries to increments the reference count
   (in6_ifa_hold).

4. The rcu is unlocked and the entry is freed.

5. The freed entry is returned.

Prevent increasing of the reference count in such case. The name
in6_ifa_hold_safe is chosen to mimic the existing fib6_info_hold_safe.

[   41.506330] refcount_t: addition on 0; use-after-free.
[   41.506760] WARNING: CPU: 0 PID: 595 at lib/refcount.c:25 refcount_warn_saturate+0xa5/0x130
[   41.507413] Modules linked in: veth bridge stp llc
[   41.507821] CPU: 0 PID: 595 Comm: python3 Not tainted 6.9.0-rc2.main-00208-g49563be82afa #14
[   41.508479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[   41.509163] RIP: 0010:refcount_warn_saturate+0xa5/0x130
[   41.509586] Code: ad ff 90 0f 0b 90 90 c3 cc cc cc cc 80 3d c0 30 ad 01 00 75 a0 c6 05 b7 30 ad 01 01 90 48 c7 c7 38 cc 7a 8c e8 cc 18 ad ff 90 <0f> 0b 90 90 c3 cc cc cc cc 80 3d 98 30 ad 01 00 0f 85 75 ff ff ff
[   41.510956] RSP: 0018:ffffbda3c026baf0 EFLAGS: 00010282
[   41.511368] RAX: 0000000000000000 RBX: ffff9e9c46914800 RCX: 0000000000000000
[   41.511910] RDX: ffff9e9c7ec29c00 RSI: ffff9e9c7ec1c900 RDI: ffff9e9c7ec1c900
[   41.512445] RBP: ffff9e9c43660c9c R08: 0000000000009ffb R09: 00000000ffffdfff
[   41.512998] R10: 00000000ffffdfff R11: ffffffff8ca58a40 R12: ffff9e9c4339a000
[   41.513534] R13: 0000000000000001 R14: ffff9e9c438a0000 R15: ffffbda3c026bb48
[   41.514086] FS:  00007fbc4cda1740(0000) GS:ffff9e9c7ec00000(0000) knlGS:0000000000000000
[   41.514726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.515176] CR2: 000056233b337d88 CR3: 000000000376e006 CR4: 0000000000370ef0
[   41.515713] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   41.516252] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   41.516799] Call Trace:
[   41.517037]  <TASK>
[   41.517249]  ? __warn+0x7b/0x120
[   41.517535]  ? refcount_warn_saturate+0xa5/0x130
[   41.517923]  ? report_bug+0x164/0x190
[   41.518240]  ? handle_bug+0x3d/0x70
[   41.518541]  ? exc_invalid_op+0x17/0x70
[   41.520972]  ? asm_exc_invalid_op+0x1a/0x20
[   41.521325]  ? refcount_warn_saturate+0xa5/0x130
[   41.521708]  ipv6_get_ifaddr+0xda/0xe0
[   41.522035]  inet6_rtm_getaddr+0x342/0x3f0
[   41.522376]  ? __pfx_inet6_rtm_getaddr+0x10/0x10
[   41.522758]  rtnetlink_rcv_msg+0x334/0x3d0
[   41.523102]  ? netlink_unicast+0x30f/0x390
[   41.523445]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   41.523832]  netlink_rcv_skb+0x53/0x100
[   41.524157]  netlink_unicast+0x23b/0x390
[   41.524484]  netlink_sendmsg+0x1f2/0x440
[   41.524826]  __sys_sendto+0x1d8/0x1f0
[   41.525145]  __x64_sys_sendto+0x1f/0x30
[   41.525467]  do_syscall_64+0xa5/0x1b0
[   41.525794]  entry_SYSCALL_64_after_hwframe+0x72/0x7a
[   41.526213] RIP: 0033:0x7fbc4cfcea9a
[   41.526528] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[   41.527942] RSP: 002b:00007ffcf54012a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   41.528593] RAX: ffffffffffffffda RBX: 00007ffcf5401368 RCX: 00007fbc4cfcea9a
[   41.529173] RDX: 000000000000002c RSI: 00007fbc4b9d9bd0 RDI: 0000000000000005
[   41.529786] RBP: 00007fbc4bafb040 R08: 00007ffcf54013e0 R09: 000000000000000c
[   41.530375] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   41.530977] R13: ffffffffc4653600 R14: 0000000000000001 R15: 00007fbc4ca85d1b
[   41.531573]  </TASK>

Fixes: 5c578aedcb21d ("IPv6: convert addrconf hash list to RCU")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Link: https://lore.kernel.org/r/8ab821e36073a4a406c50ec83c9e8dc586c539e4.1712585809.git.jbenc@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/addrconf.h | 4 ++++
 net/ipv6/addrconf.c    | 7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 700a19e0455e6..5cf1a73774078 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -435,6 +435,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
 	refcount_inc(&ifp->refcnt);
 }
 
+static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
+{
+	return refcount_inc_not_zero(&ifp->refcnt);
+}
 
 /*
  *	compute link-local solicited-node multicast address
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 968ca078191cd..a17e1d744b2d0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2054,9 +2054,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
 		if (ipv6_addr_equal(&ifp->addr, addr)) {
 			if (!dev || ifp->idev->dev == dev ||
 			    !(ifp->scope&(IFA_LINK|IFA_HOST) || strict)) {
-				result = ifp;
-				in6_ifa_hold(ifp);
-				break;
+				if (in6_ifa_hold_safe(ifp)) {
+					result = ifp;
+					break;
+				}
 			}
 		}
 	}
-- 
2.43.0




