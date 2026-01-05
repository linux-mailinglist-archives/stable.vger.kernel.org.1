Return-Path: <stable+bounces-204589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB9CF2566
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 09:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2683830393DC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8593043CE;
	Mon,  5 Jan 2026 08:05:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD2302CBA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600351; cv=none; b=bVe+uB5KqYAeRVDAta9fY2s8IuRyRdxFacEnkWJ2eyggDzIT0pYZ53mDjzkgs9rH3V2rXinrtmSa2OqNPL9En3nOlWJxxVKxJlNI6CA/+B7RJSpU2cLLVm4v6KMO+V+cHsbwxi03g2BsfQtIvxDRlFRao4GIVR0MTmvf5klD+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600351; c=relaxed/simple;
	bh=/kkrDWKwEAISKjg8kGuMGkPZqvVQNKylwE/mpcG/1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdExW05pvR+E05XIKug0UEVSvaV9IpVo3XcspNmwzHGcvZlMNH7ZOTBEv1XyMdnkUNbV/dasZ7zclgMEVZOVnO6dt+0joYZs+94oXc2ms8k05VGHnUPb1VPFo6HUk+ofHOJnMQFJQEnyAlEYENdAxGMqmb1fy2lZjGj+VVgs86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b637c00ea0c11f0a38c85956e01ac42-20260105
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c7f6e2dd-c6c6-4f91-93c4-5bd72b447c7e,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:c3486fa224c6fb3bd2750ab86e58c15a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|898,TC:nil,Content:0|15|50,EDM
	:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b637c00ea0c11f0a38c85956e01ac42-20260105
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2041298973; Mon, 05 Jan 2026 16:00:31 +0800
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	syzkaller@googlegroups.com,
	edumazet@google.com,
	kuba@kernel.org,
	jiangyunshui@kylinos.cn
Subject: [PATCH 5.4.y] net: hsr: avoid possible NULL deref in skb_clone()
Date: Mon,  5 Jan 2026 16:00:25 +0800
Message-ID: <20260105080025.1441005-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2026010511-wrist-squiggly-afad@gregkh>
References: <2026010511-wrist-squiggly-afad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d8b57135fd9ffe9a5b445350a686442a531c5339 ]

Changes from upstream:
Modify the logic of frame_get_stripped_skb() instead of
hsr_get_untagged_frame because the 5.4 kernel API has not
been updated yet. Keep the core logic identical to upstream
commit d8b57135fd9f.

syzbot got a crash [1] in skb_clone(), caused by a bug
in hsr_get_untagged_frame().

When/if create_stripped_skb_hsr() returns NULL, we must
not attempt to call skb_clone().

While we are at it, replace a WARN_ONCE() by netdev_warn_once().

[1]
general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 1 PID: 754 Comm: syz-executor.0 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:skb_clone+0x108/0x3c0 net/core/skbuff.c:1641
Code: 93 02 00 00 49 83 7c 24 28 00 0f 85 e9 00 00 00 e8 5d 4a 29 fa 4c 8d 75 7e 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 84 c0 0f 85 9e 01 00 00
RSP: 0018:ffffc90003ccf4e0 EFLAGS: 00010207

RAX: dffffc0000000000 RBX: ffffc90003ccf5f8 RCX: ffffc9000c24b000
RDX: 000000000000000f RSI: ffffffff8751cb13 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000000000f0 R09: 0000000000000140
R10: fffffbfff181d972 R11: 0000000000000000 R12: ffff888161fc3640
R13: 0000000000000a20 R14: 000000000000007e R15: ffffffff8dc5f620
FS: 00007feb621e4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feb621e3ff8 CR3: 00000001643a9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
hsr_get_untagged_frame+0x4e/0x610 net/hsr/hsr_forward.c:164
hsr_forward_do net/hsr/hsr_forward.c:461 [inline]
hsr_forward_skb+0xcca/0x1d50 net/hsr/hsr_forward.c:623
hsr_handle_frame+0x588/0x7c0 net/hsr/hsr_slave.c:69
__netif_receive_skb_core+0x9fe/0x38f0 net/core/dev.c:5379
__netif_receive_skb_one_core+0xae/0x180 net/core/dev.c:5483
__netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5599
netif_receive_skb_internal net/core/dev.c:5685 [inline]
netif_receive_skb+0x12f/0x8d0 net/core/dev.c:5744
tun_rx_batched+0x4ab/0x7a0 drivers/net/tun.c:1544
tun_get_user+0x2686/0x3a00 drivers/net/tun.c:1995
tun_chr_write_iter+0xdb/0x200 drivers/net/tun.c:2025
call_write_iter include/linux/fs.h:2187 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x9e9/0xdd0 fs/read_write.c:584
ksys_write+0x127/0x250 fs/read_write.c:637
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Cc: stable@vger.kernel.org
Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20221017165928.2150130-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 net/hsr/hsr_forward.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7073724fdfa6..5c1b9cd6dd52 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -115,8 +115,17 @@ static struct sk_buff *create_stripped_skb(struct sk_buff *skb_in,
 static struct sk_buff *frame_get_stripped_skb(struct hsr_frame_info *frame,
 					      struct hsr_port *port)
 {
-	if (!frame->skb_std)
-		frame->skb_std = create_stripped_skb(frame->skb_hsr, frame);
+	if (!frame->skb_std) {
+		if (frame->skb_hsr)
+			frame->skb_std =
+				create_stripped_skb(frame->skb_hsr, frame);
+		else
+			netdev_warn_once(port->dev,
+				"Unexpected frame received in hsr_get_untagged_frame()\n");
+
+		if (!frame->skb_std)
+			return NULL;
+	}
 	return skb_clone(frame->skb_std, GFP_ATOMIC);
 }
 
-- 
2.47.1


