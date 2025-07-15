Return-Path: <stable+bounces-162522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3CB05E60
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1787502325
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630E2E9EC3;
	Tue, 15 Jul 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTFDkQH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F52E3B00;
	Tue, 15 Jul 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586777; cv=none; b=qTMiw4ucTboXd06Ifbq/s8j7Gzg5y7m1YqX8Fp8+zM7ADMRc8mO9lz/voGvRNbUxJ41eqHvxN9iXnPERsY61p9JPVtZTPI5Ql4Avl1P0LM8z7P4F8IETDH+FyvOIXU40G8mtmvWERa7abr6wInPENmqVCJw7rXdVG8L1823Gbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586777; c=relaxed/simple;
	bh=ZTN3evC7DAwg0y0v18xzUB1QGicEaRmhKKSmMLQ3JD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obBEdg1uyRRKsslFyArMpGn9kzKDX9AXGGYtnht/YFrnu/clOalh4m9xzTpkQNPK9J+3fNcNh+HwUYb05z/epKTqhKNBbTUsEFHok9lMOFzfDMMTntLAwEWmxkQ4k6ZO7WHroF+ipuWuQpdvtMlH3v+oC/Yw7kMIuyu8Z0eeo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTFDkQH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9CBC4CEE3;
	Tue, 15 Jul 2025 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586777;
	bh=ZTN3evC7DAwg0y0v18xzUB1QGicEaRmhKKSmMLQ3JD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTFDkQH6VIvkFc/ii9NeDiHNvxAsrGYWvEHCOKSNNypBwj41ikLhydqg9BRCSBjRo
	 yiv/FzsKdos7YFNPgacoT+gObyLjxFrK3UxvaFNPAP3sWPK3gTaqLZZ3AxFQgIX0TO
	 xNP9h26VDjUik7uGQSlLlxEZ+CmG2RoDK4kEXldw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com,
	Yue Haibing <yuehaibing@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 044/192] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
Date: Tue, 15 Jul 2025 15:12:19 +0200
Message-ID: <20250715130816.618971948@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 22fc46cea91df3dce140a7dc6847c6fcf0354505 ]

atmarpd_dev_ops does not implement the send method, which may cause crash
as bellow.

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000d3cf778 EFLAGS: 00010246
RAX: 1ffffffff1910dd1 RBX: 00000000000000c0 RCX: dffffc0000000000
RDX: ffffc9000dc82000 RSI: ffff88803e4c4640 RDI: ffff888052cd0000
RBP: ffffc9000d3cf8d0 R08: ffff888052c9143f R09: 1ffff1100a592287
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff92001a79f00
R13: ffff888052cd0000 R14: ffff88803e4c4640 R15: ffffffff8c886e88
FS:  00007fbc762566c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000041f1b000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vcc_sendmsg+0xa10/0xc50 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmmsg+0x227/0x430 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/682f82d5.a70a0220.1765ec.0143.GAE@google.com/T
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250705085228.329202-1-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/clip.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index a30c5a2705455..f7a5565e794ef 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -632,8 +632,16 @@ static void atmarpd_close(struct atm_vcc *vcc)
 	module_put(THIS_MODULE);
 }
 
+static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	atm_return_tx(vcc, skb);
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
 static const struct atmdev_ops atmarpd_dev_ops = {
-	.close = atmarpd_close
+	.close = atmarpd_close,
+	.send = atmarpd_send
 };
 
 
-- 
2.39.5




