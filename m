Return-Path: <stable+bounces-107418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B71A02BC2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE0188684C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5901DE883;
	Mon,  6 Jan 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFtaEDsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23A1DED4F;
	Mon,  6 Jan 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178403; cv=none; b=SEwi8Ch5h6FVqVEasyZ3+YLtnaxri1/tg/MhiENWZvF6vw1Yzu4QlM6HyatZ5IQ7/rzCKuQwgjfuG7L4oYzBNOq10NquBnIDWGdjaZbNDmoUtuS8HlCYJTtITDTyzuItSG1M2anuULcxmqZZfofSQUz4GYcF47dNX+xWQ5XtW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178403; c=relaxed/simple;
	bh=cqJolVxgOaZVe/5eyIs9pcbTYbEvv5WyvNpJhEC8uMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMEo+YLjL78nIMdcE7l8bDUveG8LA/4/MadveuIR8xhDQcrnMN4tVC7lRIeb9MEZ220TduJKknaS+l3u2io/iWlE7KVro4qP1k2e2z137kC7mlNO4wRKAZ5a1pPxGLkZheGqnYnmQ4FljuHmmnOk/doqHPk/DH9OuBAjwxad+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFtaEDsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0029EC4CED2;
	Mon,  6 Jan 2025 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178403;
	bh=cqJolVxgOaZVe/5eyIs9pcbTYbEvv5WyvNpJhEC8uMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFtaEDsigw0iX7FeQY0hCveyF5Kq2H2bpSrTsmkIQ5sKAKs9fPReqeLYfH2Fbq54A
	 fCygEp59W/So3PK2CFhjDeCsvC+mIqq3niCcvJJSlHLTV4GiaafghLPIM4VB1AJdIU
	 9nI1PgN7izY+fvAN1di8icQ/BjLPAC9u/65XmjYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Marushkin <hfggklm@gmail.com>,
	Ilya Shchipletsov <rabbelkin@mail.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 106/138] netrom: check buffer length before accessing it
Date: Mon,  6 Jan 2025 16:17:10 +0100
Message-ID: <20250106151137.244399498@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Shchipletsov <rabbelkin@mail.ru>

[ Upstream commit a4fd163aed2edd967a244499754dec991d8b4c7d ]

Syzkaller reports an uninit value read from ax25cmp when sending raw message
through ieee802154 implementation.

=====================================================
BUG: KMSAN: uninit-value in ax25cmp+0x3a5/0x460 net/ax25/ax25_addr.c:119
 ax25cmp+0x3a5/0x460 net/ax25/ax25_addr.c:119
 nr_dev_get+0x20e/0x450 net/netrom/nr_route.c:601
 nr_route_frame+0x1a2/0xfc0 net/netrom/nr_route.c:774
 nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 raw_sendmsg+0x654/0xc10 net/ieee802154/socket.c:299
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
 sock_alloc_send_skb include/net/sock.h:1884 [inline]
 raw_sendmsg+0x36d/0xc10 net/ieee802154/socket.c:282
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5037 Comm: syz-executor166 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================

This issue occurs because the skb buffer is too small, and it's actual
allocation is aligned. This hides an actual issue, which is that nr_route_frame
does not validate the buffer size before using it.

Fix this issue by checking skb->len before accessing any fields in skb->data.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
Link: https://patch.msgid.link/20241219082308.3942-1-rabbelkin@mail.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9269b5e69b9a..8e15a0c96614 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -751,6 +751,12 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	int ret;
 	struct sk_buff *skbn;
 
+	/*
+	 * Reject malformed packets early. Check that it contains at least 2
+	 * addresses and 1 byte more for Time-To-Live
+	 */
+	if (skb->len < 2 * sizeof(ax25_address) + 1)
+		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
 	nr_dest = (ax25_address *)(skb->data + 7);
-- 
2.39.5




