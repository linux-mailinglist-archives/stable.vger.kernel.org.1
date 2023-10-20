Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4597D16F1
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJTU1J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJTU1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:27:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D2D65
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:27:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856FC433C9;
        Fri, 20 Oct 2023 20:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833623;
        bh=AT/7dokR97wjprYDPslKgdJz7TezcXL7uYboD1zj6VA=;
        h=Subject:To:Cc:From:Date:From;
        b=BjYDVZ2cjuBXi0fNBh7tCRzhYTmPALl7BWW27ZyUSWD/5+2HhIzaeo93uVEYZcBqN
         3Ic4fHP4DGgT44yFdi4BHNQwASHmE9cbNpLCsqme524im0Ik3HfG8aFyr6Iz532kzC
         7QZh/PXDryGA1q0z8lnJGr2YnZdE7qL7ZwxlD4nQ=
Subject: FAILED: patch "[PATCH] tun: prevent negative ifindex" failed to apply to 4.14-stable tree
To:     edumazet@google.com, jasowang@redhat.com, kuba@kernel.org,
        syzkaller@googlegroups.com, willemb@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:26:52 +0200
Message-ID: <2023102052-enlarging-trough-a5f5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x cbfbfe3aee718dc4c3c837f5d2463170ee59d78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102052-enlarging-trough-a5f5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbfbfe3aee718dc4c3c837f5d2463170ee59d78c Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 18:08:51 +0000
Subject: [PATCH] tun: prevent negative ifindex

After commit 956db0a13b47 ("net: warn about attempts to register
negative ifindex") syzbot is able to trigger the following splat.

Negative ifindex are not supported.

WARNING: CPU: 1 PID: 6003 at net/core/dev.c:9596 dev_index_reserve+0x104/0x210
Modules linked in:
CPU: 1 PID: 6003 Comm: syz-executor926 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dev_index_reserve+0x104/0x210
lr : dev_index_reserve+0x100/0x210
sp : ffff800096a878e0
x29: ffff800096a87930 x28: ffff0000d04380d0 x27: ffff0000d04380f8
x26: ffff0000d04380f0 x25: 1ffff00012d50f20 x24: 1ffff00012d50f1c
x23: dfff800000000000 x22: ffff8000929c21c0 x21: 00000000ffffffea
x20: ffff0000d04380e0 x19: ffff800096a87900 x18: ffff800096a874c0
x17: ffff800084df5008 x16: ffff80008051f9c4 x15: 0000000000000001
x14: 1fffe0001a087198 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d41c9bc0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800091763d88 x4 : 0000000000000000 x3 : ffff800084e04748
x2 : 0000000000000001 x1 : 00000000fead71c7 x0 : 0000000000000000
Call trace:
dev_index_reserve+0x104/0x210
register_netdevice+0x598/0x1074 net/core/dev.c:10084
tun_set_iff+0x630/0xb0c drivers/net/tun.c:2850
__tun_chr_ioctl+0x788/0x2af8 drivers/net/tun.c:3118
tun_chr_ioctl+0x38/0x4c drivers/net/tun.c:3403
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:871 [inline]
__se_sys_ioctl fs/ioctl.c:857 [inline]
__arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
__invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 11348
hardirqs last enabled at (11347): [<ffff80008a716574>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last enabled at (11347): [<ffff80008a716574>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (11348): [<ffff80008a627820>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last enabled at (11138): [<ffff8000887ca53c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last enabled at (11138): [<ffff8000887ca53c>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
softirqs last disabled at (11136): [<ffff8000887ca41c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (11136): [<ffff8000887ca41c>] release_sock+0x3c/0x1b0 net/core/sock.c:3518

Fixes: fb7589a16216 ("tun: Add ability to create tun device with given index")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/r/20231016180851.3560092-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 89ab9efe522c..afa5497f7c35 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3073,10 +3073,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int carrier;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
+	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
@@ -3132,7 +3133,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EFAULT;
 		if (copy_from_user(&ifindex, argp, sizeof(ifindex)))
 			goto unlock;
-
+		ret = -EINVAL;
+		if (ifindex < 0)
+			goto unlock;
 		ret = 0;
 		tfile->ifindex = ifindex;
 		goto unlock;

