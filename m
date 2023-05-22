Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4370C7DA
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjEVTc7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjEVTco (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CB10DB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE8D6292E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16709C433EF;
        Mon, 22 May 2023 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783947;
        bh=8qu6K+i9N8Zi0ZgS21Lh/mGCUWvKfqq+DFgY6BTse/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cu5RHpUGD8Mw8ItAtZVsxXvYljgiMUjsyLZYoRG4S/NcF+wGEJSCyCuI8YwQugRWc
         hhesa/eq4OuC9VTndtrsYEMPY9SNSrncGxqRl1lUDcrd1WxMlEZWNaD89RvqyLDYQQ
         +27bEFgX2keIDh2ZJ0ff+rzBGHapalVzDu19zJEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 215/292] tun: Fix memory leak for detached NAPI queue.
Date:   Mon, 22 May 2023 20:09:32 +0100
Message-Id: <20230522190411.332971668@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 82b2bc279467c875ec36f8ef820f00997c2a4e8e ]

syzkaller reported [0] memory leaks of sk and skb related to the TUN
device with no repro, but we can reproduce it easily with:

  struct ifreq ifr = {}
  int fd_tun, fd_tmp;
  char buf[4] = {};

  fd_tun = openat(AT_FDCWD, "/dev/net/tun", O_WRONLY, 0);
  ifr.ifr_flags = IFF_TUN | IFF_NAPI | IFF_MULTI_QUEUE;
  ioctl(fd_tun, TUNSETIFF, &ifr);

  ifr.ifr_flags = IFF_DETACH_QUEUE;
  ioctl(fd_tun, TUNSETQUEUE, &ifr);

  fd_tmp = socket(AF_PACKET, SOCK_PACKET, 0);
  ifr.ifr_flags = IFF_UP;
  ioctl(fd_tmp, SIOCSIFFLAGS, &ifr);

  write(fd_tun, buf, sizeof(buf));
  close(fd_tun);

If we enable NAPI and multi-queue on a TUN device, we can put skb into
tfile->sk.sk_write_queue after the queue is detached.  We should prevent
it by checking tfile->detached before queuing skb.

Note this must be done under tfile->sk.sk_write_queue.lock because write()
and ioctl(IFF_DETACH_QUEUE) can run concurrently.  Otherwise, there would
be a small race window:

  write()                             ioctl(IFF_DETACH_QUEUE)
  `- tun_get_user                     `- __tun_detach
     |- if (tfile->detached)             |- tun_disable_queue
     |  `-> false                        |  `- tfile->detached = tun
     |                                   `- tun_queue_purge
     |- spin_lock_bh(&queue->lock)
     `- __skb_queue_tail(queue, skb)

Another solution is to call tun_queue_purge() when closing and
reattaching the detached queue, but it could paper over another
problems.  Also, we do the same kind of test for IFF_NAPI_FRAGS.

[0]:
unreferenced object 0xffff88801edbc800 (size 2048):
  comm "syz-executor.1", pid 33269, jiffies 4295743834 (age 18.756s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace:
    [<000000008c16ea3d>] __do_kmalloc_node mm/slab_common.c:965 [inline]
    [<000000008c16ea3d>] __kmalloc+0x4a/0x130 mm/slab_common.c:979
    [<000000003addde56>] kmalloc include/linux/slab.h:563 [inline]
    [<000000003addde56>] sk_prot_alloc+0xef/0x1b0 net/core/sock.c:2035
    [<000000003e20621f>] sk_alloc+0x36/0x2f0 net/core/sock.c:2088
    [<0000000028e43843>] tun_chr_open+0x3d/0x190 drivers/net/tun.c:3438
    [<000000001b0f1f28>] misc_open+0x1a6/0x1f0 drivers/char/misc.c:165
    [<000000004376f706>] chrdev_open+0x111/0x300 fs/char_dev.c:414
    [<00000000614d379f>] do_dentry_open+0x2f9/0x750 fs/open.c:920
    [<000000008eb24774>] do_open fs/namei.c:3636 [inline]
    [<000000008eb24774>] path_openat+0x143f/0x1a30 fs/namei.c:3791
    [<00000000955077b5>] do_filp_open+0xce/0x1c0 fs/namei.c:3818
    [<00000000b78973b0>] do_sys_openat2+0xf0/0x260 fs/open.c:1356
    [<00000000057be699>] do_sys_open fs/open.c:1372 [inline]
    [<00000000057be699>] __do_sys_openat fs/open.c:1388 [inline]
    [<00000000057be699>] __se_sys_openat fs/open.c:1383 [inline]
    [<00000000057be699>] __x64_sys_openat+0x83/0xf0 fs/open.c:1383
    [<00000000a7d2182d>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<00000000a7d2182d>] do_syscall_64+0x3c/0x90 arch/x86/entry/common.c:80
    [<000000004cc4e8c4>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

unreferenced object 0xffff88802f671700 (size 240):
  comm "syz-executor.1", pid 33269, jiffies 4295743854 (age 18.736s)
  hex dump (first 32 bytes):
    68 c9 db 1e 80 88 ff ff 68 c9 db 1e 80 88 ff ff  h.......h.......
    00 c0 7b 2f 80 88 ff ff 00 c8 db 1e 80 88 ff ff  ..{/............
  backtrace:
    [<00000000e9d9fdb6>] __alloc_skb+0x223/0x250 net/core/skbuff.c:644
    [<000000002c3e4e0b>] alloc_skb include/linux/skbuff.h:1288 [inline]
    [<000000002c3e4e0b>] alloc_skb_with_frags+0x6f/0x350 net/core/skbuff.c:6378
    [<00000000825f98d7>] sock_alloc_send_pskb+0x3ac/0x3e0 net/core/sock.c:2729
    [<00000000e9eb3df3>] tun_alloc_skb drivers/net/tun.c:1529 [inline]
    [<00000000e9eb3df3>] tun_get_user+0x5e1/0x1f90 drivers/net/tun.c:1841
    [<0000000053096912>] tun_chr_write_iter+0xac/0x120 drivers/net/tun.c:2035
    [<00000000b9282ae0>] call_write_iter include/linux/fs.h:1868 [inline]
    [<00000000b9282ae0>] new_sync_write fs/read_write.c:491 [inline]
    [<00000000b9282ae0>] vfs_write+0x40f/0x530 fs/read_write.c:584
    [<00000000524566e4>] ksys_write+0xa1/0x170 fs/read_write.c:637
    [<00000000a7d2182d>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<00000000a7d2182d>] do_syscall_64+0x3c/0x90 arch/x86/entry/common.c:80
    [<000000004cc4e8c4>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: cde8b15f1aab ("tuntap: add ioctl to attach or detach a file form tuntap device")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 65706824eb828..7c8db8f6f661e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1971,6 +1971,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		int queue_len;
 
 		spin_lock_bh(&queue->lock);
+
+		if (unlikely(tfile->detached)) {
+			spin_unlock_bh(&queue->lock);
+			rcu_read_unlock();
+			err = -EBUSY;
+			goto free_skb;
+		}
+
 		__skb_queue_tail(queue, skb);
 		queue_len = skb_queue_len(queue);
 		spin_unlock(&queue->lock);
@@ -2506,6 +2514,13 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (tfile->napi_enabled) {
 		queue = &tfile->sk.sk_write_queue;
 		spin_lock(&queue->lock);
+
+		if (unlikely(tfile->detached)) {
+			spin_unlock(&queue->lock);
+			kfree_skb(skb);
+			return -EBUSY;
+		}
+
 		__skb_queue_tail(queue, skb);
 		spin_unlock(&queue->lock);
 		ret = 1;
-- 
2.39.2



