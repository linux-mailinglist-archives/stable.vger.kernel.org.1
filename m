Return-Path: <stable+bounces-36570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003389C06E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0408281685
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D886F08B;
	Mon,  8 Apr 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s1qfyKKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843A2DF73;
	Mon,  8 Apr 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581712; cv=none; b=EWC7H0U8Hv+G3qBOHZvnc/PdUsOmSlAySSudhrjkGzx/QI1Hn0roydyW9eKQVqQhSmpqfYbZu4mB0F/sv4tGicXbSpvWvjsN+nAJFo0+JVj4RNJY++soNEgWFCwtk8r0fo+8/vOLje2Aslg0Jh87WuQI8kfa4hM9lUFe3UIr94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581712; c=relaxed/simple;
	bh=CARApZojGPBwYxEmA951gFQ1GGSHExsjQHL2L/9Rvko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx17F/ZLJ28ed5nDY/qRH8/WsxzW57bI4xGTmwI0d3Mxxue43m3/KAvMBRKoVSiLdRNwsamO9fHowdzhRRRRgMKznTMZaa4fWgOk4Loxtp1likysTC6gwPe+hPX94JKj1uUhmGSdqoAFP9i/EjBH28i9/Hj2xVOv/xRPvl5531A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s1qfyKKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC4C433C7;
	Mon,  8 Apr 2024 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581712;
	bh=CARApZojGPBwYxEmA951gFQ1GGSHExsjQHL2L/9Rvko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1qfyKKCIkZp6+UL70yycM14xthKTTNWWZk/FstWY6+nhxGg30K3M9+XjMvEdkWwD
	 NWaSRfITuvFTUcmPXnOrQq0o/ZvV6m0Szd87cJpk2TDy3Y849GB88884Vs04CWtr7r
	 3CZWbrs3WzJ4DaR3XmZIhAlMbNS93JWKIRUXkaCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 046/138] net/sched: act_skbmod: prevent kernel-infoleak
Date: Mon,  8 Apr 2024 14:57:40 +0200
Message-ID: <20240408125257.661780919@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit d313eb8b77557a6d5855f42d2234bd592c7b50dd upstream.

syzbot found that tcf_skbmod_dump() was copying four bytes
from kernel stack to user space [1].

The issue here is that 'struct tc_skbmod' has a four bytes hole.

We need to clear the structure before filling fields.

[1]
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
 BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
 BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
 BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
  copy_to_user_iter lib/iov_iter.c:24 [inline]
  iterate_ubuf include/linux/iov_iter.h:29 [inline]
  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
  iterate_and_advance include/linux/iov_iter.h:271 [inline]
  _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
  copy_to_iter include/linux/uio.h:196 [inline]
  simple_copy_to_iter net/core/datagram.c:532 [inline]
  __skb_datagram_iter+0x185/0x1000 net/core/datagram.c:420
  skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:546
  skb_copy_datagram_msg include/linux/skbuff.h:4050 [inline]
  netlink_recvmsg+0x432/0x1610 net/netlink/af_netlink.c:1962
  sock_recvmsg_nosec net/socket.c:1046 [inline]
  sock_recvmsg+0x2c4/0x340 net/socket.c:1068
  __sys_recvfrom+0x35a/0x5f0 net/socket.c:2242
  __do_sys_recvfrom net/socket.c:2260 [inline]
  __se_sys_recvfrom net/socket.c:2256 [inline]
  __x64_sys_recvfrom+0x126/0x1d0 net/socket.c:2256
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
  pskb_expand_head+0x30f/0x19d0 net/core/skbuff.c:2253
  netlink_trim+0x2c2/0x330 net/netlink/af_netlink.c:1317
  netlink_unicast+0x9f/0x1260 net/netlink/af_netlink.c:1351
  nlmsg_unicast include/net/netlink.h:1144 [inline]
  nlmsg_notify+0x21d/0x2f0 net/netlink/af_netlink.c:2610
  rtnetlink_send+0x73/0x90 net/core/rtnetlink.c:741
  rtnetlink_maybe_send include/linux/rtnetlink.h:17 [inline]
  tcf_add_notify net/sched/act_api.c:2048 [inline]
  tcf_action_add net/sched/act_api.c:2071 [inline]
  tc_ctl_action+0x146e/0x19d0 net/sched/act_api.c:2119
  rtnetlink_rcv_msg+0x1737/0x1900 net/core/rtnetlink.c:6595
  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6613
  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
  netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
  netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
  __sys_sendmsg net/socket.c:2667 [inline]
  __do_sys_sendmsg net/socket.c:2676 [inline]
  __se_sys_sendmsg net/socket.c:2674 [inline]
  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
  __nla_put lib/nlattr.c:1041 [inline]
  nla_put+0x1c6/0x230 lib/nlattr.c:1099
  tcf_skbmod_dump+0x23f/0xc20 net/sched/act_skbmod.c:256
  tcf_action_dump_old net/sched/act_api.c:1191 [inline]
  tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1227
  tcf_action_dump+0x1fd/0x460 net/sched/act_api.c:1251
  tca_get_fill+0x519/0x7a0 net/sched/act_api.c:1628
  tcf_add_notify_msg net/sched/act_api.c:2023 [inline]
  tcf_add_notify net/sched/act_api.c:2042 [inline]
  tcf_action_add net/sched/act_api.c:2071 [inline]
  tc_ctl_action+0x1365/0x19d0 net/sched/act_api.c:2119
  rtnetlink_rcv_msg+0x1737/0x1900 net/core/rtnetlink.c:6595
  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2559
  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6613
  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
  netlink_unicast+0xf4c/0x1260 net/netlink/af_netlink.c:1361
  netlink_sendmsg+0x10df/0x11f0 net/netlink/af_netlink.c:1905
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
  __sys_sendmsg net/socket.c:2667 [inline]
  __do_sys_sendmsg net/socket.c:2676 [inline]
  __se_sys_sendmsg net/socket.c:2674 [inline]
  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable opt created at:
  tcf_skbmod_dump+0x9d/0xc20 net/sched/act_skbmod.c:244
  tcf_action_dump_old net/sched/act_api.c:1191 [inline]
  tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1227

Bytes 188-191 of 248 are uninitialized
Memory access of size 248 starts at ffff888117697680
Data copied to user address 00007ffe56d855f0

Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20240403130908.93421-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_skbmod.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -239,13 +239,13 @@ static int tcf_skbmod_dump(struct sk_buf
 	struct tcf_skbmod *d = to_skbmod(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_skbmod_params  *p;
-	struct tc_skbmod opt = {
-		.index   = d->tcf_index,
-		.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&d->tcf_bindcnt) - bind,
-	};
+	struct tc_skbmod opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+	opt.index   = d->tcf_index;
+	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&d->tcf_bindcnt) - bind;
 	spin_lock_bh(&d->tcf_lock);
 	opt.action = d->tcf_action;
 	p = rcu_dereference_protected(d->skbmod_p,



