Return-Path: <stable+bounces-75084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004CD9732D9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A411C2402D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE8819148A;
	Tue, 10 Sep 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfNVfaTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BE18CBE6;
	Tue, 10 Sep 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963703; cv=none; b=HhI3fxskV21cU6IpvXTOz+2d+AlgAp2674sqMb6LtfvnnU19kCOvd+/UAoh6w+tF7wVxzN9Ai6zIQtV4f5kBfaHr51d4M79dlUJA6naNwadVjTIWhIspmsd+x+c9L0RKHy7WWx+nkYB9svB83N1x43ObKdlFpPGDFbxRI86nBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963703; c=relaxed/simple;
	bh=sQo+SnXnpUC+UCRBvR3DPr6IULJ5pJqg1CCurDVDJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJGxmBBsOOtzv+3C2qXSiCzBPhvA17KIrKBNyKKgDKMIUGBJDV1P4f7HKRkG9EoXFRhU3+CHJsB8DOUKPqaGXawNOng+2v75v8OI/XPqU8iCI43FrF6CiHHpqHWPXc5oN6T8cVaZtLvbGFHLiCHBq8LSQO+YSXQq6bfJJn4Wj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfNVfaTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CDFC4CEC3;
	Tue, 10 Sep 2024 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963702;
	bh=sQo+SnXnpUC+UCRBvR3DPr6IULJ5pJqg1CCurDVDJxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfNVfaTspjlvMBe0fRrKcI1iMbIhFYoiVLqVEIGc3bN5K1VKacRwx+4bxeURPzoMx
	 D6CXNIwOhyIRCYgpo4l/5LzgNxyrE3gNhlkrZjufDQdtxaGBBTADvdt2uHTpNxISbS
	 31uEzM5YAu6/WgsvwvKivHe7nJjVSoMmECmjz+lk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 120/214] can: bcm: Remove proc entry when dev is unregistered.
Date: Tue, 10 Sep 2024 11:32:22 +0200
Message-ID: <20240910092603.686648893@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 76fe372ccb81b0c89b6cd2fec26e2f38c958be85 ]

syzkaller reported a warning in bcm_connect() below. [0]

The repro calls connect() to vxcan1, removes vxcan1, and calls
connect() with ifindex == 0.

Calling connect() for a BCM socket allocates a proc entry.
Then, bcm_sk(sk)->bound is set to 1 to prevent further connect().

However, removing the bound device resets bcm_sk(sk)->bound to 0
in bcm_notify().

The 2nd connect() tries to allocate a proc entry with the same
name and sets NULL to bcm_sk(sk)->bcm_proc_read, leaking the
original proc entry.

Since the proc entry is available only for connect()ed sockets,
let's clean up the entry when the bound netdev is unregistered.

[0]:
proc_dir_entry 'can-bcm/2456' already registered
WARNING: CPU: 1 PID: 394 at fs/proc/generic.c:376 proc_register+0x645/0x8f0 fs/proc/generic.c:375
Modules linked in:
CPU: 1 PID: 394 Comm: syz-executor403 Not tainted 6.10.0-rc7-g852e42cc2dd4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:proc_register+0x645/0x8f0 fs/proc/generic.c:375
Code: 00 00 00 00 00 48 85 ed 0f 85 97 02 00 00 4d 85 f6 0f 85 9f 02 00 00 48 c7 c7 9b cb cf 87 48 89 de 4c 89 fa e8 1c 6f eb fe 90 <0f> 0b 90 90 48 c7 c7 98 37 99 89 e8 cb 7e 22 05 bb 00 00 00 10 48
RSP: 0018:ffa0000000cd7c30 EFLAGS: 00010246
RAX: 9e129be1950f0200 RBX: ff1100011b51582c RCX: ff1100011857cd80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffd400000000000f R09: ff1100013e78cac0
R10: ffac800000cd7980 R11: ff1100013e12b1f0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ff1100011a99a2ec
FS:  00007fbd7086f740(0000) GS:ff1100013fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200071c0 CR3: 0000000118556004 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 proc_create_net_single+0x144/0x210 fs/proc/proc_net.c:220
 bcm_connect+0x472/0x840 net/can/bcm.c:1673
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x5d2/0x690 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x8f/0x100 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fbd708b0e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff8cd33f08 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbd708b0e5d
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000040
R10: 0000000000000040 R11: 0000000000000246 R12: 00007fff8cd34098
R13: 0000000000401280 R14: 0000000000406de8 R15: 00007fbd70ab9000
 </TASK>
remove_proc_entry: removing non-empty directory 'net/can-bcm', leaking at least '2456'

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240722192842.37421-1-kuniyu@amazon.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a2fd68d1149b..8c039638b196 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1423,6 +1423,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
+#if IS_ENABLED(CONFIG_PROC_FS)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+#endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
 			notify_enodev = 1;
-- 
2.43.0




