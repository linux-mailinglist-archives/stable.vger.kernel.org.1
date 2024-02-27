Return-Path: <stable+bounces-24550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C086951A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F4D28F806
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249F13DB9B;
	Tue, 27 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzK81a+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F313B791;
	Tue, 27 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042330; cv=none; b=Ii8wv41NM4IQowrb6Xu904aa0S9NJxjdWMtHnKYPKdcipbYQ0EaPguBvggJJ87I7DOMINu6Ngibg9F4+1CyWRcS+be7hankGCKmp0jlV2523ylgHM4fno8nGOJzkI5xy8ZeXbo0BRTv3aMz0Fwfi+hL/1fxpuqdngBGWTvnMYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042330; c=relaxed/simple;
	bh=XQ84bRRKd/6gGfLLHaDrLiTkNKVvCX69jjNIw7yZ1mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sarMKDtzPcRgNGc2j4I7u3vxbSb+cqUbercGQo6jwijpU3l9DuMhXzJlqQJ8SE3niKUVesZ7hlteb1sxgqnETr8U9d67b5F+IQhNQKEOmLHSNcYBLQGHoX4mfNdo78nx+brqRwESdGtlLy9cbE4l69Cj9c7BEok+cXWthOij/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzK81a+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12CBC433F1;
	Tue, 27 Feb 2024 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042330;
	bh=XQ84bRRKd/6gGfLLHaDrLiTkNKVvCX69jjNIw7yZ1mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yzK81a+Aq3sp9sV8RFgK3EQ31oXh18gRkqVRHqeaV2C3omFthOeAhU6INJx82LwPr
	 phqTe10kWTj2zjodu3pYVtT5ypXMiBMSeqCljazfPdMl/26VwY/8bOTFNif7j3fwHI
	 z8AlmQqD7DK7zAhHTcQmb1CGuvGNaQygOQTzBUsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Bjoern Doebel <doebel@amazon.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 257/299] arp: Prevent overflow in arp_req_get().
Date: Tue, 27 Feb 2024 14:26:08 +0100
Message-ID: <20240227131633.981002822@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit a7d6027790acea24446ddd6632d394096c0f4667 ]

syzkaller reported an overflown write in arp_req_get(). [0]

When ioctl(SIOCGARP) is issued, arp_req_get() looks up an neighbour
entry and copies neigh->ha to struct arpreq.arp_ha.sa_data.

The arp_ha here is struct sockaddr, not struct sockaddr_storage, so
the sa_data buffer is just 14 bytes.

In the splat below, 2 bytes are overflown to the next int field,
arp_flags.  We initialise the field just after the memcpy(), so it's
not a problem.

However, when dev->addr_len is greater than 22 (e.g. MAX_ADDR_LEN),
arp_netmask is overwritten, which could be set as htonl(0xFFFFFFFFUL)
in arp_ioctl() before calling arp_req_get().

To avoid the overflow, let's limit the max length of memcpy().

Note that commit b5f0de6df6dc ("net: dev: Convert sa_data to flexible
array in struct sockaddr") just silenced syzkaller.

[0]:
memcpy: detected field-spanning write (size 16) of single field "r->arp_ha.sa_data" at net/ipv4/arp.c:1128 (size 14)
WARNING: CPU: 0 PID: 144638 at net/ipv4/arp.c:1128 arp_req_get+0x411/0x4a0 net/ipv4/arp.c:1128
Modules linked in:
CPU: 0 PID: 144638 Comm: syz-executor.4 Not tainted 6.1.74 #31
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
RIP: 0010:arp_req_get+0x411/0x4a0 net/ipv4/arp.c:1128
Code: fd ff ff e8 41 42 de fb b9 0e 00 00 00 4c 89 fe 48 c7 c2 20 6d ab 87 48 c7 c7 80 6d ab 87 c6 05 25 af 72 04 01 e8 5f 8d ad fb <0f> 0b e9 6c fd ff ff e8 13 42 de fb be 03 00 00 00 4c 89 e7 e8 a6
RSP: 0018:ffffc900050b7998 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803a815000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8641a44a RDI: 0000000000000001
RBP: ffffc900050b7a98 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 203a7970636d656d R12: ffff888039c54000
R13: 1ffff92000a16f37 R14: ffff88803a815084 R15: 0000000000000010
FS:  00007f172bf306c0(0000) GS:ffff88805aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f172b3569f0 CR3: 0000000057f12005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 arp_ioctl+0x33f/0x4b0 net/ipv4/arp.c:1261
 inet_ioctl+0x314/0x3a0 net/ipv4/af_inet.c:981
 sock_do_ioctl+0xdf/0x260 net/socket.c:1204
 sock_ioctl+0x3ef/0x650 net/socket.c:1321
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18e/0x220 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x37/0x90 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x7f172b262b8d
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f172bf300b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f172b3abf80 RCX: 00007f172b262b8d
RDX: 0000000020000000 RSI: 0000000000008954 RDI: 0000000000000003
RBP: 00007f172b2d3493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f172b3abf80 R15: 00007f172bf10000
 </TASK>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Bjoern Doebel <doebel@amazon.de>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240215230516.31330-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/arp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 9456f5bb35e5d..0d0d725b46ad0 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1125,7 +1125,8 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 	if (neigh) {
 		if (!(READ_ONCE(neigh->nud_state) & NUD_NOARP)) {
 			read_lock_bh(&neigh->lock);
-			memcpy(r->arp_ha.sa_data, neigh->ha, dev->addr_len);
+			memcpy(r->arp_ha.sa_data, neigh->ha,
+			       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
 			r->arp_flags = arp_state_to_flags(neigh);
 			read_unlock_bh(&neigh->lock);
 			r->arp_ha.sa_family = dev->type;
-- 
2.43.0




