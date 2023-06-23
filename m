Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5A73B399
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjFWJax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFWJaw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:30:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2717F9D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6980619B0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30E3C433C0;
        Fri, 23 Jun 2023 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512650;
        bh=iJ8sHTACoT5cvsT902mQAbnTXHwzn/wOV0ZduiAHmi0=;
        h=Subject:To:Cc:From:Date:From;
        b=yKX51q72yjCp5qS0swC4xBA8rc2vmzQW4lgeh/zieKbCc6NimVyzWIGPNHWOSgxEv
         vivm4RNK2rB0n5CQRCVsmfLuJHIDXJX/ORzCwr1m0sG6RJjTGLS2fXMXp2xy99R7VC
         9U5xcjMhUD3LTvPBTQ9IsS91zqAhO+Va/tHTVtHw=
Subject: FAILED: patch "[PATCH] mptcp: fix possible divide by zero in recvmsg()" failed to apply to 5.15-stable tree
To:     pabeni@redhat.com, cpaasch@apple.com, kuba@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:30:47 +0200
Message-ID: <2023062346-annoying-sublime-7ac7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0ad529d9fd2bfa3fc619552a8d2fb2f2ef0bce2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062346-annoying-sublime-7ac7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ad529d9fd2bfa3fc619552a8d2fb2f2ef0bce2e Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Jun 2023 18:24:19 +0200
Subject: [PATCH] mptcp: fix possible divide by zero in recvmsg()

Christoph reported a divide by zero bug in mptcp_recvmsg():

divide error: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 19978 Comm: syz-executor.6 Not tainted 6.4.0-rc2-gffcc7899081b #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__tcp_select_window+0x30e/0x420 net/ipv4/tcp_output.c:3018
Code: 11 ff 0f b7 cd c1 e9 0c b8 ff ff ff ff d3 e0 89 c1 f7 d1 01 cb 21 c3 eb 17 e8 2e 83 11 ff 31 db eb 0e e8 25 83 11 ff 89 d8 99 <f7> 7c 24 04 29 d3 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 60
RSP: 0018:ffffc90000a07a18 EFLAGS: 00010246
RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000040000
RDX: 0000000000000000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000000000ffd7 R08: ffffffff820cf297 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff8103d1a0 R12: 0000000000003f00
R13: 0000000000300000 R14: ffff888101cf3540 R15: 0000000000180000
FS:  00007f9af4c09640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33824000 CR3: 000000012f241001 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 __tcp_cleanup_rbuf+0x138/0x1d0 net/ipv4/tcp.c:1611
 mptcp_recvmsg+0xcb8/0xdd0 net/mptcp/protocol.c:2034
 inet_recvmsg+0x127/0x1f0 net/ipv4/af_inet.c:861
 ____sys_recvmsg+0x269/0x2b0 net/socket.c:1019
 ___sys_recvmsg+0xe6/0x260 net/socket.c:2764
 do_recvmmsg+0x1a5/0x470 net/socket.c:2858
 __do_sys_recvmmsg net/socket.c:2937 [inline]
 __se_sys_recvmmsg net/socket.c:2953 [inline]
 __x64_sys_recvmmsg+0xa6/0x130 net/socket.c:2953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f9af58fc6a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f9af4c08cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000006bc050 RCX: 00007f9af58fc6a9
RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000f00 R11: 0000000000000246 R12: 00000000006bc05c
R13: fffffffffffffea8 R14: 00000000006bc050 R15: 000000000001fe40
 </TASK>

mptcp_recvmsg is allowed to release the msk socket lock when
blocking, and before re-acquiring it another thread could have
switched the sock to TCP_LISTEN status - with a prior
connect(AF_UNSPEC) - also clearing icsk_ack.rcv_mss.

Address the issue preventing the disconnect if some other process is
concurrently performing a blocking syscall on the same socket, alike
commit 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting").

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 86f8a7621aff..ee357700b27b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3082,6 +3082,12 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
 	 * msk->firstsocket lock).
@@ -3148,6 +3154,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);

