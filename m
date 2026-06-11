Return-Path: <stable+bounces-262705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkVHBD25Kmo1vwMAu9opvQ
	(envelope-from <stable+bounces-262705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:33:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89D6725C8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=g3rNdNo1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262705-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262705-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90A5315BCC4
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376D3EB10D;
	Thu, 11 Jun 2026 13:32:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167940D57C;
	Thu, 11 Jun 2026 13:32:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184776; cv=none; b=WFmMxV/EaWxfHUDcqiXSjr0FyceRE/metFkXCwg/wT4TGwZUsc0yISZhdTy2bbmNYLduxmbQtLytzswKQSczEJ42QyZhLJGjP/sa61faV6zJErZwHAkk7GKvddIUAYW3L4cx4jOUXUtyRkKTn8dBNGunfwkC8BDcaf+bGg5bCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184776; c=relaxed/simple;
	bh=aAUIfoeB922EjpETo28UDuNkRtVHZL8vk/eG5Ayv0bQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q8aUEgkONYVRd8ufVh1RkCbPIWgvAZBMIeGQJqrSslPVjVBo+3H7bzG2nx4tU0OJ2PAH1LwDKcKlidnnViZagNo/0tI1CCbmUyHDK9VzAsg3fxCVIxDyoT4STGgfSqbl0ufUo8/zwcd/qKlBiFVBAsv/3elPtyXNGoPxS/ngcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g3rNdNo1; arc=none smtp.client-ip=113.46.200.220
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/bIB0l/jYMMTpucxs3QWzKVYPY3EBurRt7wmrGdoY6M=;
	b=g3rNdNo1r7KHDOHpO16wEv374RGl3AjqTQvF/ZwqkCYFQ/Owzr7mFm5mWS/PadJlWRxXsrvwL
	efIGyI0naSWBsbOs2/HoAG5l4QfSdrze+MA1dHm/Q2aKHyZxMqVyaVSa/ieaZARwBqltIOVL8S4
	ktdTBCLXVqFVanoKdEugJtU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gbk040zShz12LD7;
	Thu, 11 Jun 2026 21:24:52 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 2960140670;
	Thu, 11 Jun 2026 21:32:43 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Jun
 2026 21:32:42 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Jon Maloy <jmaloy@redhat.com>
CC: <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Xue
	<ying.xue@windriver.com>, Tuong Lien <tuong.t.lien@dektech.com.au>,
	<netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH net] tipc: restrict socket queue dumps in enqueue tracepoints
Date: Thu, 11 Jun 2026 21:56:47 +0800
Message-ID: <20260611135647.3666727-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262705-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[lixiasong1@huawei.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:tuong.t.lien@dektech.com.au,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:yuehaibing@huawei.com,m:zhangchangzhong@huawei.com,m:weiyongjun1@huawei.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F89D6725C8

tipc_sk_enqueue() runs with sk->sk_lock.slock held while the socket is
owned by user context. The spinlock protects the backlog queue in this
path, but it does not serialize against the socket owner consuming or
purging sk_receive_queue.

KASAN reported:

  CPU: 14 UID: 0 PID: 1050 Comm: tipc3 Not tainted 7.1.0-rc6+ #126 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
    <TASK>
    dump_stack_lvl+0x76/0xa0 lib/dump_stack.c:123
    print_report+0xce/0x5b0 mm/kasan/report.c:482
    kasan_report+0xc6/0x100 mm/kasan/report.c:597
    __asan_report_load4_noabort+0x14/0x30 mm/kasan/report_generic.c:380
    tipc_skb_dump+0x1327/0x16f0 net/tipc/trace.c:73
    tipc_list_dump+0x208/0x2e0 net/tipc/trace.c:187
    tipc_sk_dump+0xaf6/0xd60 net/tipc/socket.c:3996
    trace_event_raw_event_tipc_sk_class+0x312/0x5a0 net/tipc/trace.h:188
    tipc_sk_rcv+0xb1d/0x1d50 net/tipc/socket.c:2497
    tipc_node_xmit+0x1c3/0x1440 net/tipc/node.c:1689
    __tipc_sendmsg+0x97a/0x1440 net/tipc/socket.c:1512
    tipc_sendmsg+0x52/0x80 net/tipc/socket.c:1400
    sock_sendmsg+0x2f6/0x3e0 net/socket.c:825
    splice_to_socket+0x7f9/0x1010 fs/splice.c:884
    do_splice+0xe21/0x2330 fs/splice.c:936
    __do_splice+0x153/0x260 fs/splice.c:1431
    __x64_sys_splice+0x150/0x230 fs/splice.c:1616
    x64_sys_call+0xeb5/0x2790 arch/x86/entry/syscall_64.c:41
    do_syscall_64+0xf3/0x620 arch/x86/entry/syscall_64.c:63
    entry_SYSCALL_64_after_hwframe+0x76/0x7e arch/x86/entry/entry_64.S:130
  RIP: 0033:0x71624e8aafe2
  Code: 08 0f 85 71 3a ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
  RSP: 002b:0000716157ffed68 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
  RAX: ffffffffffffffda RBX: 0000716157fff6c0 RCX: 000071624e8aafe2
  RDX: 000000000000005f RSI: 0000000000000000 RDI: 0000000000000066
  RBP: 0000716157ffed90 R08: 0000000000008000 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff00
  R13: 0000000000000021 R14: 0000000000000000 R15: 00007fff89799c40
    </TASK>

The TIPC_DUMP_ALL tracepoints in tipc_sk_enqueue() also dump
sk_receive_queue and can therefore dereference skbs that the socket
owner has already dequeued or freed. Restrict these dumps to
TIPC_DUMP_SK_BKLGQ, which matches the queue protected by the held
spinlock.

Keep the change limited to the enqueue path, where the unsafe queue dump
is reachable while the socket is owned by user context.

Fixes: 01e661ebfbad ("tipc: add trace_events for tipc socket")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/tipc/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f..6b761003bcd1 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2452,17 +2452,17 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
-			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
 		}
 
-		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL, "err_overload!");
+		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_SK_BKLGQ, "err_overload!");
 		/* Overload => reject message back to sender */
 		onode = tipc_own_addr(sock_net(sk));
 		sk_drops_inc(sk);
 		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
-			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_SK_BKLGQ,
 					      "@sk_enqueue!");
 			__skb_queue_tail(xmitq, skb);
 		}
-- 
2.34.1


