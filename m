Return-Path: <stable+bounces-56994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4A925B4E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D63CB23D89
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B603418308B;
	Wed,  3 Jul 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kFSrt4dj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451C137910;
	Wed,  3 Jul 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003517; cv=none; b=OD9Gc+Ikn4ON5Gh5lQqRiDeHg9Ix243ix6l3ogmxO4hPTlrvPJYrFz4wNhzClUl/BFkWSOIQJpf6XC0ntCv9z/6et2zHIKeVRVdxR6NKzmlYUyvoqeeFnC2yBcz0jJSZGz22wKVuSS2pZC7S7rQJPBVOkJD0IXzbnVOakmPlw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003517; c=relaxed/simple;
	bh=bHPPR1Synyuwu2jRKVIEoAh77MAjuyy/Y6DnwvL5qFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tww9aHr2CyL1FhYhRMwIScvNb+SsEwP2MdI+lYuAk1VNsne5yjSKpkn7QQBhgJgenfHvOD4wDoRL7HBlLg085+K17P5k81JI1qndJHuTpV34/dI2+S7dyBniZd5ba2JjZjX7Q+2vJCiLlX+tTYhnyr+ejL9BNJ7G17m/xYQ6IJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kFSrt4dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC24EC2BD10;
	Wed,  3 Jul 2024 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003517;
	bh=bHPPR1Synyuwu2jRKVIEoAh77MAjuyy/Y6DnwvL5qFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFSrt4djE+KF8wCrmsV/D+/Q359ljltkiYhLMjEPhDr8+sowwwh5fvnIJw1mh7a6Z
	 vBOV+DvXYw3R7UllUzV3Orx3+fE4Ecqx8Wq8YKmIXO5rzEjpFvEZGiaV1ZCj+1ww82
	 M24dFPg9Dz18RCh1mpYnS0oxUSqFJyJpBvu2JS78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/139] xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
Date: Wed,  3 Jul 2024 12:39:31 +0200
Message-ID: <20240703102833.236520407@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d46401052c2d5614da8efea5788532f0401cb164 ]

ip6_dst_idev() can return NULL, xfrm6_get_saddr() must act accordingly.

syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc2-syzkaller-00383-gb8481381d4e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker
 RIP: 0010:xfrm6_get_saddr+0x93/0x130 net/ipv6/xfrm6_policy.c:64
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 00 00 00 4c 8b ab d8 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 6d 00 e8 ca 13 47 01 48 b8 00
RSP: 0018:ffffc90000117378 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807b079dc0 RCX: ffffffff89a0d6d7
RDX: 0000000000000000 RSI: ffffffff89a0d6e9 RDI: ffff88807b079e98
RBP: ffff88807ad73248 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff88807b079dc0 R11: 0000000000000007 R12: ffffc90000117480
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4586d00440 CR3: 0000000079042000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  xfrm_get_saddr net/xfrm/xfrm_policy.c:2452 [inline]
  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2481 [inline]
  xfrm_tmpl_resolve+0xa26/0xf10 net/xfrm/xfrm_policy.c:2541
  xfrm_resolve_and_create_bundle+0x140/0x2570 net/xfrm/xfrm_policy.c:2835
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3070 [inline]
  xfrm_lookup_with_ifid+0x4d1/0x1e60 net/xfrm/xfrm_policy.c:3201
  xfrm_lookup net/xfrm/xfrm_policy.c:3298 [inline]
  xfrm_lookup_route+0x3b/0x200 net/xfrm/xfrm_policy.c:3309
  ip6_dst_lookup_flow+0x15c/0x1d0 net/ipv6/ip6_output.c:1256
  send6+0x611/0xd20 drivers/net/wireguard/socket.c:139
  wg_socket_send_skb_to_peer+0xf9/0x220 drivers/net/wireguard/socket.c:178
  wg_socket_send_buffer_to_peer+0x12b/0x190 drivers/net/wireguard/socket.c:200
  wg_packet_send_handshake_initiation+0x227/0x360 drivers/net/wireguard/send.c:40
  wg_packet_handshake_send_worker+0x1c/0x30 drivers/net/wireguard/send.c:51
  process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
  process_scheduled_works kernel/workqueue.c:3312 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
  kthread+0x2c1/0x3a0 kernel/kthread.c:389
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240615154231.234442-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_policy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index a1dfe4f5ed3a4..086f34d2051a1 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -60,12 +60,18 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
+	struct inet6_dev *idev;
 
 	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
-	dev = ip6_dst_idev(dst)->dev;
+	idev = ip6_dst_idev(dst);
+	if (!idev) {
+		dst_release(dst);
+		return -EHOSTUNREACH;
+	}
+	dev = idev->dev;
 	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
 	dst_release(dst);
 	return 0;
-- 
2.43.0




