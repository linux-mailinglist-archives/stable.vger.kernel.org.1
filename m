Return-Path: <stable+bounces-41703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B568B5883
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313511C23309
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD383548F3;
	Mon, 29 Apr 2024 12:27:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC2481C7;
	Mon, 29 Apr 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393632; cv=none; b=n47b9p6eHOspqiLPv7JoZyjIySlHLPsHy6WOpCXwVZ/w5i5+5luBr0/GzapKNjNDdExVHV5UtHNutIHdQXAj4+7Fs+FazXmLrINxnHA6odhxAAmcJzXlebFr3BNlBPwZofNDiAjkzPSzZ1rmcXub0vNG3RowzCOG1lWWOPmbcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393632; c=relaxed/simple;
	bh=g8mDcI191VZGONoFRk2nklSwNOUOogRSRrz02QDuBeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tl96h2lBmKUmZQXXMfTnLjmmb3UVUZxBYfJGrR4p26D7iNomLRx7K7pEcKRR3RzWWPMKSQefDtS99CUEzLlfThEDitqVPWB1kb3fvn9OPJiAuybnqZhsKuDah8GjPKEFNn8mcbd9yJ6DDRv3RgyDUwmQfVILfiTjKVIPOusii8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VSjDR05PhzwVJL;
	Mon, 29 Apr 2024 20:23:51 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 536F3180065;
	Mon, 29 Apr 2024 20:27:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 20:27:06 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,4.19 1/2] tcp: Clean up kernel listener's reqsk in inet_twsk_purge()
Date: Mon, 29 Apr 2024 20:32:23 +0800
Message-ID: <20240429123224.2730596-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429123224.2730596-1-shaozhengchao@huawei.com>
References: <20240429123224.2730596-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 740ea3c4a0b2e326b23d7cdf05472a0e92aa39bc upstream

Eric Dumazet reported a use-after-free related to the per-netns ehash
series. [0]

When we create a TCP socket from userspace, the socket always holds a
refcnt of the netns.  This guarantees that a reqsk timer is always fired
before netns dismantle.  Each reqsk has a refcnt of its listener, so the
listener is not freed before the reqsk, and the net is not freed before
the listener as well.

OTOH, when in-kernel users create a TCP socket, it might not hold a refcnt
of its netns.  Thus, a reqsk timer can be fired after the netns dismantle
and access freed per-netns ehash.

To avoid the use-after-free, we need to clean up TCP_NEW_SYN_RECV sockets
in inet_twsk_purge() if the netns uses a per-netns ehash.

[0]: https://lore.kernel.org/netdev/CANn89iLXMup0dRD_Ov79Xt8N9FM0XdhCHEN05sf3eLwxKweM6w@mail.gmail.com/

BUG: KASAN: use-after-free in tcp_or_dccp_get_hashinfo
include/net/inet_hashtables.h:181 [inline]
BUG: KASAN: use-after-free in reqsk_queue_unlink+0x320/0x350
net/ipv4/inet_connection_sock.c:913
Read of size 8 at addr ffff88807545bd80 by task syz-executor.2/8301

CPU: 1 PID: 8301 Comm: syz-executor.2 Not tainted
6.0.0-syzkaller-02757-gaf7d23f9d96a #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 09/22/2022
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
tcp_or_dccp_get_hashinfo include/net/inet_hashtables.h:181 [inline]
reqsk_queue_unlink+0x320/0x350 net/ipv4/inet_connection_sock.c:913
inet_csk_reqsk_queue_drop net/ipv4/inet_connection_sock.c:927 [inline]
inet_csk_reqsk_queue_drop_and_put net/ipv4/inet_connection_sock.c:939 [inline]
reqsk_timer_handler+0x724/0x1160 net/ipv4/inet_connection_sock.c:1053
call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
__run_timers kernel/time/timer.c:1768 [inline]
run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
__do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
invoke_softirq kernel/softirq.c:445 [inline]
__irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1107
</IRQ>

Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20221012145036.74960-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[shaozhengchao: resolved conflicts in 5.10]
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv4/inet_timewait_sock.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 88c5069b5d20..0ab4e0e28baf 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -267,8 +267,21 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
-			if (sk->sk_state != TCP_TIME_WAIT)
+			if (sk->sk_state != TCP_TIME_WAIT) {
+				/* A kernel listener socket might not hold refcnt for net,
+				 * so reqsk_timer_handler() could be fired after net is
+				 * freed.  Userspace listener and reqsk never exist here.
+				 */
+				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
+					     hashinfo->pernet)) {
+					struct request_sock *req = inet_reqsk(sk);
+
+					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+				}
+
 				continue;
+			}
+
 			tw = inet_twsk(sk);
 			if ((tw->tw_family != family) ||
 				refcount_read(&twsk_net(tw)->count))
-- 
2.34.1


