Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4A719DDF
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjFAN0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjFAN0p (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42113E
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 475B7644B9
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB82C433D2;
        Thu,  1 Jun 2023 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625982;
        bh=YsUGUmfh8lwUOFVPujmwwMPA/1hDGBrd/FNL2A2jY2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMK4SOa6s5dWUBjhfGQYFSx5rGDIJdNrwygf71rjYlsb9S44TpzlO6ytH42yIazUk
         Zc9kUM2h90UkgCUbIqHvmqygpIQ5z3C0ySh7Z+xaxXqa522BHlTjOI6T90R0GniAc+
         iLBkz3GOcrj48TB75r0TLnNgAclFWhGAJ6JF9e9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, William Findlay <will@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 29/45] bpf, sockmap: Pass skb ownership through read_skb
Date:   Thu,  1 Jun 2023 14:21:25 +0100
Message-Id: <20230601131940.007484698@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 78fa0d61d97a728d306b0c23d353c0e340756437 ]

The read_skb hook calls consume_skb() now, but this means that if the
recv_actor program wants to use the skb it needs to inc the ref cnt
so that the consume_skb() doesn't kfree the sk_buff.

This is problematic because in some error cases under memory pressure
we may need to linearize the sk_buff from sk_psock_skb_ingress_enqueue().
Then we get this,

 skb_linearize()
   __pskb_pull_tail()
     pskb_expand_head()
       BUG_ON(skb_shared(skb))

Because we incremented users refcnt from sk_psock_verdict_recv() we
hit the bug on with refcnt > 1 and trip it.

To fix lets simply pass ownership of the sk_buff through the skb_read
call. Then we can drop the consume from read_skb handlers and assume
the verdict recv does any required kfree.

Bug found while testing in our CI which runs in VMs that hit memory
constraints rather regularly. William tested TCP read_skb handlers.

[  106.536188] ------------[ cut here ]------------
[  106.536197] kernel BUG at net/core/skbuff.c:1693!
[  106.536479] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  106.536726] CPU: 3 PID: 1495 Comm: curl Not tainted 5.19.0-rc5 #1
[  106.537023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.16.0-1 04/01/2014
[  106.537467] RIP: 0010:pskb_expand_head+0x269/0x330
[  106.538585] RSP: 0018:ffffc90000138b68 EFLAGS: 00010202
[  106.538839] RAX: 000000000000003f RBX: ffff8881048940e8 RCX: 0000000000000a20
[  106.539186] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff8881048940e8
[  106.539529] RBP: ffffc90000138be8 R08: 00000000e161fd1a R09: 0000000000000000
[  106.539877] R10: 0000000000000018 R11: 0000000000000000 R12: ffff8881048940e8
[  106.540222] R13: 0000000000000003 R14: 0000000000000000 R15: ffff8881048940e8
[  106.540568] FS:  00007f277dde9f00(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[  106.540954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.541227] CR2: 00007f277eeede64 CR3: 000000000ad3e000 CR4: 00000000000006e0
[  106.541569] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  106.541915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  106.542255] Call Trace:
[  106.542383]  <IRQ>
[  106.542487]  __pskb_pull_tail+0x4b/0x3e0
[  106.542681]  skb_ensure_writable+0x85/0xa0
[  106.542882]  sk_skb_pull_data+0x18/0x20
[  106.543084]  bpf_prog_b517a65a242018b0_bpf_skskb_http_verdict+0x3a9/0x4aa9
[  106.543536]  ? migrate_disable+0x66/0x80
[  106.543871]  sk_psock_verdict_recv+0xe2/0x310
[  106.544258]  ? sk_psock_write_space+0x1f0/0x1f0
[  106.544561]  tcp_read_skb+0x7b/0x120
[  106.544740]  tcp_data_queue+0x904/0xee0
[  106.544931]  tcp_rcv_established+0x212/0x7c0
[  106.545142]  tcp_v4_do_rcv+0x174/0x2a0
[  106.545326]  tcp_v4_rcv+0xe70/0xf60
[  106.545500]  ip_protocol_deliver_rcu+0x48/0x290
[  106.545744]  ip_local_deliver_finish+0xa7/0x150

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Reported-by: William Findlay <will@isovalent.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: William Findlay <will@isovalent.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230523025618.113937-2-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c   | 2 --
 net/ipv4/tcp.c     | 1 -
 net/ipv4/udp.c     | 7 ++-----
 net/unix/af_unix.c | 7 ++-----
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f81883759d381..4a3dc8d272957 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1183,8 +1183,6 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	int ret = __SK_DROP;
 	int len = skb->len;
 
-	skb_get(skb);
-
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6c7c666554ced..01ea2705deea9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1772,7 +1772,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
 		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
 		used = recv_actor(sk, skb);
-		consume_skb(skb);
 		if (used < 0) {
 			if (!copied)
 				copied = used;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c605d171eb2d9..8aaae82e78aeb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1813,7 +1813,7 @@ EXPORT_SYMBOL(__skb_recv_udp);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 try_again:
 	skb = skb_recv_udp(sk, MSG_DONTWAIT, &err);
@@ -1832,10 +1832,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 EXPORT_SYMBOL(udp_read_skb);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 29c6083a37daf..9383afe3e570b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2553,7 +2553,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 	mutex_lock(&u->iolock);
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
@@ -2561,10 +2561,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (!skb)
 		return err;
 
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 
 /*
-- 
2.39.2



