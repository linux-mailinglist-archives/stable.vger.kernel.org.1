Return-Path: <stable+bounces-84187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183B99CEC5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1541288691
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D71ABEA7;
	Mon, 14 Oct 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+6CbB3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC175809;
	Mon, 14 Oct 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917138; cv=none; b=ZDKPlf3sK8dON7ArnVDo8OI99LB4697cvVV/iSehHXtjNV+viUle/fd2NPFhps/hCctTNAue6iIcgVphOac7fBNQ+BFpwIV/WKf6X1X1ueHb3SCTsU1W3iroC/RjcKd1cpV+AbOLHTU0PECXtwC1FtEDcHu3y7Og9DxdVAltEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917138; c=relaxed/simple;
	bh=hhf5buNhR2ptnV4f5/Y7Jf86ghYvtj7hGnb48C2HlZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhYJF1GXi7YHKjp6vj/B8Jjb6ayhei00F4B7Vf3iOakjjKK0e2AaL4QExeprloz+LIPfcD8/fxrep7As/JI7T9CYsNjHrAxyYWo9aMiRahGXXWpPlX7rWf9MCZJvgXfkAmT19lhlr482DiwB0NaWwxLBI0TqGzRmsKCSXEazRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+6CbB3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E9EC4CEC3;
	Mon, 14 Oct 2024 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917138;
	bh=hhf5buNhR2ptnV4f5/Y7Jf86ghYvtj7hGnb48C2HlZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+6CbB3ddGCEUzjklIsmPUWAQe4KD40OC5J1tN1M0CaMGUcfOYqVasgTFxTQ0MSw0
	 oyucyOEs+jeCbIFMKVMj1OTo4rvosEt2Icq3/4yBe3okJok30oF5iYEvThB3oBoLga
	 3eRBtoavVwI62OeOF/5SMDeGJjhxo+2Ja9ELuq4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 162/213] ppp: fix ppp_async_encode() illegal access
Date: Mon, 14 Oct 2024 16:21:08 +0200
Message-ID: <20241014141049.294516646@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 40dddd4b8bd08a69471efd96107a4e1c73fabefc ]

syzbot reported an issue in ppp_async_encode() [1]

In this case, pppoe_sendmsg() is called with a zero size.
Then ppp_async_encode() is called with an empty skb.

BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
 BUG: KMSAN: uninit-value in ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
  ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
  ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
  ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
  ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
  pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
  sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
  __release_sock+0x1da/0x330 net/core/sock.c:3072
  release_sock+0x6b/0x250 net/core/sock.c:3626
  pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4092 [inline]
  slab_alloc_node mm/slub.c:4135 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4187
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
  alloc_skb include/linux/skbuff.h:1322 [inline]
  sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
  pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5411 Comm: syz.1.14 Not tainted 6.12.0-rc1-syzkaller-00165-g360c1f1f24c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241009185802.3763282-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index e94a4b08fd63b..7d9201ef925ff 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -541,7 +541,7 @@ ppp_async_encode(struct asyncppp *ap)
 	 * and 7 (code-reject) must be sent as though no options
 	 * had been negotiated.
 	 */
-	islcp = proto == PPP_LCP && 1 <= data[2] && data[2] <= 7;
+	islcp = proto == PPP_LCP && count >= 3 && 1 <= data[2] && data[2] <= 7;
 
 	if (i == 0) {
 		if (islcp)
-- 
2.43.0




