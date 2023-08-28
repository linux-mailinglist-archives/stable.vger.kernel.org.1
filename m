Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D778AB04
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjH1K1E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjH1K0n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFBAB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEFAC63ADB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F1C433C7;
        Mon, 28 Aug 2023 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218399;
        bh=GuIajZ0UuwbPOgDfeET0jDlqV0TC1eKUf1JvdqNeRhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ms3riWn71fElEnHf/zlKu10k2N1o4ciNXdvU9I55/fnzZFZ+aDJSZebfFes7XnC6N
         tiMNm+xUPtYT0BzSlMZakIApNBWl5tqgWV9qaZNEDrsHkZjJ/6HPOr36k5QEMQ/ZJX
         G3bTOg+9ZjkHjxlp5KfQSxyIXlVfB4IZi28BfzXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH 4.19 073/129] af_unix: Fix null-ptr-deref in unix_stream_sendpage().
Date:   Mon, 28 Aug 2023 12:12:47 +0200
Message-ID: <20230828101156.024267548@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

Bing-Jhong Billy Jheng reported null-ptr-deref in unix_stream_sendpage()
with detailed analysis and a nice repro.

unix_stream_sendpage() tries to add data to the last skb in the peer's
recv queue without locking the queue.

If the peer's FD is passed to another socket and the socket's FD is
passed to the peer, there is a loop between them.  If we close both
sockets without receiving FD, the sockets will be cleaned up by garbage
collection.

The garbage collection iterates such sockets and unlinks skb with
FD from the socket's receive queue under the queue's lock.

So, there is a race where unix_stream_sendpage() could access an skb
locklessly that is being released by garbage collection, resulting in
use-after-free.

To avoid the issue, unix_stream_sendpage() must lock the peer's recv
queue.

Note the issue does not exist in 6.5+ thanks to the recent sendpage()
refactoring.

This patch is originally written by Linus Torvalds.

BUG: unable to handle page fault for address: ffff988004dd6870
PF: supervisor read access in kernel mode
PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
PREEMPT SMP PTI
CPU: 4 PID: 297 Comm: garbage_uaf Not tainted 6.1.46 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:kmem_cache_alloc_node+0xa2/0x1e0
Code: c0 0f 84 32 01 00 00 41 83 fd ff 74 10 48 8b 00 48 c1 e8 3a 41 39 c5 0f 85 1c 01 00 00 41 8b 44 24 28 49 8b 3c 24 48 8d 4a 40 <49> 8b 1c 06 4c 89 f0 65 48 0f c7 0f 0f 94 c0 84 c0 74 a1 41 8b 44
RSP: 0018:ffffc9000079fac0 EFLAGS: 00000246
RAX: 0000000000000070 RBX: 0000000000000005 RCX: 000000000001a284
RDX: 000000000001a244 RSI: 0000000000400cc0 RDI: 000000000002eee0
RBP: 0000000000400cc0 R08: 0000000000400cc0 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888003970f00
R13: 00000000ffffffff R14: ffff988004dd6800 R15: 00000000000000e8
FS:  00007f174d6f3600(0000) GS:ffff88807db00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff988004dd6870 CR3: 00000000092be000 CR4: 00000000007506e0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x1a/0x1f
 ? page_fault_oops+0xa9/0x1e0
 ? fixup_exception+0x1d/0x310
 ? exc_page_fault+0xa8/0x150
 ? asm_exc_page_fault+0x22/0x30
 ? kmem_cache_alloc_node+0xa2/0x1e0
 ? __alloc_skb+0x16c/0x1e0
 __alloc_skb+0x16c/0x1e0
 alloc_skb_with_frags+0x48/0x1e0
 sock_alloc_send_pskb+0x234/0x270
 unix_stream_sendmsg+0x1f5/0x690
 sock_sendmsg+0x5d/0x60
 ____sys_sendmsg+0x210/0x260
 ___sys_sendmsg+0x83/0xd0
 ? kmem_cache_alloc+0xc6/0x1c0
 ? avc_disable+0x20/0x20
 ? percpu_counter_add_batch+0x53/0xc0
 ? alloc_empty_file+0x5d/0xb0
 ? alloc_file+0x91/0x170
 ? alloc_file_pseudo+0x94/0x100
 ? __fget_light+0x9f/0x120
 __sys_sendmsg+0x54/0xa0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x69/0xd3
RIP: 0033:0x7f174d639a7d
Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 8a c1 f4 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 de c1 f4 ff 48
RSP: 002b:00007ffcb563ea50 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f174d639a7d
RDX: 0000000000000000 RSI: 00007ffcb563eab0 RDI: 0000000000000007
RBP: 00007ffcb563eb10 R08: 0000000000000000 R09: 00000000ffffffff
R10: 00000000004040a0 R11: 0000000000000293 R12: 00007ffcb563ec28
R13: 0000000000401398 R14: 0000000000403e00 R15: 00007f174d72c000
 </TASK>

Fixes: 869e7c62486e ("net: af_unix: implement stream sendpage support")
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reviewed-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/af_unix.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1984,6 +1984,7 @@ static ssize_t unix_stream_sendpage(stru
 
 	if (false) {
 alloc_skb:
+		spin_unlock(&other->sk_receive_queue.lock);
 		unix_state_unlock(other);
 		mutex_unlock(&unix_sk(other)->iolock);
 		newskb = sock_alloc_send_pskb(sk, 0, 0, flags & MSG_DONTWAIT,
@@ -2023,6 +2024,7 @@ alloc_skb:
 		init_scm = false;
 	}
 
+	spin_lock(&other->sk_receive_queue.lock);
 	skb = skb_peek_tail(&other->sk_receive_queue);
 	if (tail && tail == skb) {
 		skb = newskb;
@@ -2053,14 +2055,11 @@ alloc_skb:
 	refcount_add(size, &sk->sk_wmem_alloc);
 
 	if (newskb) {
-		err = unix_scm_to_skb(&scm, skb, false);
-		if (err)
-			goto err_state_unlock;
-		spin_lock(&other->sk_receive_queue.lock);
+		unix_scm_to_skb(&scm, skb, false);
 		__skb_queue_tail(&other->sk_receive_queue, newskb);
-		spin_unlock(&other->sk_receive_queue.lock);
 	}
 
+	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
 	mutex_unlock(&unix_sk(other)->iolock);
 


