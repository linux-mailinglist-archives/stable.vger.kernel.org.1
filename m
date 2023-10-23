Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5F7D312C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjJWLG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjJWLG3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBFED6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA42AC433C7;
        Mon, 23 Oct 2023 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059186;
        bh=AIDhhDnb4lk77JkIUY3qK4XCcI46H9qlioIvSx+Sbd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSsiK4qMuxOSdubtbRJR90YxlyFVR2y83QbBcLijxq64xhmYptFEzKku63l73hB67
         TlBgSc2VWionb/gHuKpa+MC/YlDBjA7I+GNcw31hSeVXTYWmjLYBLqQc2NfSwcxdTM
         B3nL0TSTUjCDv3Fo1y1xJsQDOsDaJrOkFOxmk71A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 066/241] tcp: Fix listen() warning with v4-mapped-v6 address.
Date:   Mon, 23 Oct 2023 12:54:12 +0200
Message-ID: <20231023104835.512862017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 8702cf12e6ba91616a72d684e90357977972991b upstream.

syzbot reported a warning [0] introduced by commit c48ef9c4aed3 ("tcp: Fix
bind() regression for v4-mapped-v6 non-wildcard address.").

After the cited commit, a v4 socket's address matches the corresponding
v4-mapped-v6 tb2 in inet_bind2_bucket_match_addr(), not vice versa.

During X.X.X.X -> ::ffff:X.X.X.X order bind()s, the second bind() uses
bhash and conflicts properly without checking bhash2 so that we need not
check if a v4-mapped-v6 sk matches the corresponding v4 address tb2 in
inet_bind2_bucket_match_addr().  However, the repro shows that we need
to check that in a no-conflict case.

The repro bind()s two sockets to the 2-tuples using SO_REUSEPORT and calls
listen() for the first socket:

  from socket import *

  s1 = socket()
  s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
  s1.bind(('127.0.0.1', 0))

  s2 = socket(AF_INET6)
  s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
  s2.bind(('::ffff:127.0.0.1', s1.getsockname()[1]))

  s1.listen()

The second socket should belong to the first socket's tb2, but the second
bind() creates another tb2 bucket because inet_bind2_bucket_find() returns
NULL in inet_csk_get_port() as the v4-mapped-v6 sk does not match the
corresponding v4 address tb2.

  bhash2[] -> tb2(::ffff:X.X.X.X) -> tb2(X.X.X.X)

Then, listen() for the first socket calls inet_csk_get_port(), where the
v4 address matches the v4-mapped-v6 tb2 and WARN_ON() is triggered.

To avoid that, we need to check if v4-mapped-v6 sk address matches with
the corresponding v4 address tb2 in inet_bind2_bucket_match().

The same checks are needed in inet_bind2_bucket_addr_match() too, so we
can move all checks there and call it from inet_bind2_bucket_match().

Note that now tb->family is just an address family of tb->(v6_)?rcv_saddr
and not of sockets in the bucket.  This could be refactored later by
defining tb->rcv_saddr as tb->v6_rcv_saddr.s6_addr32[3] and prepending
::ffff: when creating v4 tb2.

[0]:
WARNING: CPU: 0 PID: 5049 at net/ipv4/inet_connection_sock.c:587 inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Modules linked in:
CPU: 0 PID: 5049 Comm: syz-executor288 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
Code: 7c 24 08 e8 4c b6 8a 01 31 d2 be 88 01 00 00 48 c7 c7 e0 94 ae 8b e8 59 2e a3 f8 2e 2e 2e 31 c0 e9 04 fe ff ff e8 ca 88 d0 f8 <0f> 0b e9 0f f9 ff ff e8 be 88 d0 f8 49 8d 7e 48 e8 65 ca 5a 00 31
RSP: 0018:ffffc90003abfbf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888026429100 RCX: 0000000000000000
RDX: ffff88807edcbb80 RSI: ffffffff88b73d66 RDI: ffff888026c49f38
RBP: ffff888026c49f30 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9260f200
R13: ffff888026c49880 R14: 0000000000000000 R15: ffff888026429100
FS:  00005555557d5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025754000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_csk_listen_start+0x155/0x360 net/ipv4/inet_connection_sock.c:1256
 __inet_listen_sk+0x1b8/0x5c0 net/ipv4/af_inet.c:217
 inet_listen+0x93/0xd0 net/ipv4/af_inet.c:239
 __sys_listen+0x194/0x270 net/socket.c:1866
 __do_sys_listen net/socket.c:1875 [inline]
 __se_sys_listen net/socket.c:1873 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1873
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a5bce3af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1a1c79e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a5bce3af9
RDX: 00007f3a5bce3af9 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3a5bd565f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Fixes: c48ef9c4aed3 ("tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.")
Reported-by: syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71e724675ba3958edb31
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20231010013814.70571-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_hashtables.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -148,8 +148,14 @@ static bool inet_bind2_bucket_addr_match
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family)
-		return false;
+	if (sk->sk_family != tb2->family) {
+		if (sk->sk_family == AF_INET)
+			return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
+				tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+
+		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
+			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
+	}
 
 	if (sk->sk_family == AF_INET6)
 		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
@@ -799,19 +805,7 @@ static bool inet_bind2_bucket_match(cons
 	    tb->l3mdev != l3mdev)
 		return false;
 
-#if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
-				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
-
-		return false;
-	}
-
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-#endif
-	return tb->rcv_saddr == sk->sk_rcv_saddr;
+	return inet_bind2_bucket_addr_match(tb, sk);
 }
 
 bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const struct net *net,


