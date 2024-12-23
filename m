Return-Path: <stable+bounces-105856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389349FB20F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A766162E9E
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97F1AF0C7;
	Mon, 23 Dec 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stJdBmEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F313BC0C;
	Mon, 23 Dec 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970373; cv=none; b=U5aFdAhhMqka3NpmmihHtiHb1GpA3rZznMFvannABV5/I9vFex8oBXlyZoZg4eccFKiuQT5HB9wCjgsx6lH/UA/mueanTgWT0TO+orizKy6AEpryZdiGDggtiXLKB3DwfCbaxfWK1KbvgAu6XoktcPkcSn+7RD9U31V7n69tVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970373; c=relaxed/simple;
	bh=dnamsOZ1a4ood85k0QaR8KF4nwpHN2z+9CLm7SFjweA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCuCviIpCS/t4GxWJWQggAbZJeZ2+YaHIiBzU1yarF/uuDVIuzyDFflDDSqAbGJN1TzWgxcAgfr/OXfKl9DN/1hyyiEOJKivU21C2QgKUEemGAM7PbABdELo1Ao3CA3GnNibtm5qztllPLN++AKlZh3qIyLyQzC25dsHUlHN1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stJdBmEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BCC4CED3;
	Mon, 23 Dec 2024 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970373;
	bh=dnamsOZ1a4ood85k0QaR8KF4nwpHN2z+9CLm7SFjweA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stJdBmEHLqIN+cFvUTz9KOyT6vpLiv+ENMLh5K7pCDxXt9OsY+m5HVm53/GKp5COn
	 5dm7sJq7z4Hp1kniWZUihnCxQdDhVcibMEX3gEZPBVO6fxdDO5UEjlmOyJcnG7W4Dr
	 Vr+DfqCJlio/lDGpvxBPfAR8O3o1K06jMEy5lDJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 062/116] net: tun: fix tun_napi_alloc_frags()
Date: Mon, 23 Dec 2024 16:58:52 +0100
Message-ID: <20241223155401.971447327@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
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

commit 429fde2d81bcef0ebab002215358955704586457 upstream.

syzbot reported the following crash [1]

Issue came with the blamed commit. Instead of going through
all the iov components, we keep using the first one
and end up with a malformed skb.

[1]

kernel BUG at net/core/skbuff.c:2849 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6230 Comm: syz-executor132 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
 RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_cow_data+0x2da/0xcb0 net/core/skbuff.c:5284
  tipc_aead_decrypt net/tipc/crypto.c:894 [inline]
  tipc_crypto_rcv+0x402/0x24e0 net/tipc/crypto.c:1844
  tipc_rcv+0x57e/0x12a0 net/tipc/node.c:2109
  tipc_l2_rcv_msg+0x2bd/0x450 net/tipc/bearer.c:668
  __netif_receive_skb_list_ptype net/core/dev.c:5720 [inline]
  __netif_receive_skb_list_core+0x8b7/0x980 net/core/dev.c:5762
  __netif_receive_skb_list net/core/dev.c:5814 [inline]
  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
  gro_normal_list include/net/gro.h:515 [inline]
  napi_complete_done+0x2b5/0x870 net/core/dev.c:6256
  napi_complete include/linux/netdevice.h:567 [inline]
  tun_get_user+0x2ea0/0x4890 drivers/net/tun.c:1982
  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2057
 do_iter_readv_writev+0x600/0x880
  vfs_writev+0x376/0xba0 fs/read_write.c:1050
  do_writev+0x1b6/0x360 fs/read_write.c:1096
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/675b61aa.050a0220.599f4.00bb.GAE@google.com/T/#u
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20241212222247.724674-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1487,7 +1487,7 @@ static struct sk_buff *tun_napi_alloc_fr
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
-		const struct iovec *iov = iter_iov(it);
+		const struct iovec *iov = iter_iov(it) + i;
 		size_t fragsz = iov->iov_len;
 		struct page *page;
 		void *frag;



