Return-Path: <stable+bounces-158193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862EAE576F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45990444688
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90528223DE5;
	Mon, 23 Jun 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kz0dUSz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC7B676;
	Mon, 23 Jun 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717713; cv=none; b=c/YfKyzJSMrQWwqaY7RCZkedthCTyF7AYIHRsvVtr6BAKNMNWtqmOmn1uY/l954uU/mYkiXthjRcfqxDaCuJ9flQnhmtiCu/58bV5Jxezycz7+/jKUxYoAMJshodOWE39xNa6EW6B3Utg2iH3VOldNUKUcvwGGsHalZeDx0sJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717713; c=relaxed/simple;
	bh=ZgC5wGFHMplepCDG/roHt0LvTynJYQAG5a8eKuuwpSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqmrBLy8os7XJqVe0RnRrkkp59cmEYuP02+Yv1FrxKzH+aD1tz+doHld4tF6WsWN4YA+H1+H8z+pgo3ZCw91ouG6AUK9f25sX+5P9BH42C7roq43pPHghIBzk1uwDwBFSHw5EvPglR4a8eyHatDTTvBbPdymLourtT4Ktbw4N8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kz0dUSz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893DEC4CEEA;
	Mon, 23 Jun 2025 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717712;
	bh=ZgC5wGFHMplepCDG/roHt0LvTynJYQAG5a8eKuuwpSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kz0dUSz5yoqKZD+cVxMdlM1oqAgDkq6iAmybWNOn1IRgMBTvDi7zpE6XvaEAj71jo
	 qA20ZfNj1W4aIParcTZio+/kcudRH4pXpA/pwIArsnibEdYfCjVOnfyE9hwA8nZM3J
	 EgHTFB6af8SJCEjE/uC+kzv5dTzThX/ILRQ38I3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 483/508] atm: atmtcp: Free invalid length skb in atmtcp_c_send().
Date: Mon, 23 Jun 2025 15:08:48 +0200
Message-ID: <20250623130656.946176464@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 2f370ae1fb6317985f3497b1bb80d457508ca2f7 ]

syzbot reported the splat below. [0]

vcc_sendmsg() copies data passed from userspace to skb and passes
it to vcc->dev->ops->send().

atmtcp_c_send() accesses skb->data as struct atmtcp_hdr after
checking if skb->len is 0, but it's not enough.

Also, when skb->len == 0, skb and sk (vcc) were leaked because
dev_kfree_skb() is not called and sk_wmem_alloc adjustment is missing
to revert atm_account_tx() in vcc_sendmsg(), which is expected
to be done in atm_pop_raw().

Let's properly free skb with an invalid length in atmtcp_c_send().

[0]:
BUG: KMSAN: uninit-value in atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 vcc_sendmsg+0xd7c/0xff0 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 vcc_sendmsg+0xb40/0xff0 net/atm/common.c:628
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5798 Comm: syz-executor192 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(undef)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250616182147.963333-2-kuni1840@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/atmtcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index 96bea1ab1eccf..ff558908897f3 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,9 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		goto done;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
-- 
2.39.5




