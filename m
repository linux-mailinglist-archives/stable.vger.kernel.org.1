Return-Path: <stable+bounces-45132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B88C61CE
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E3A283CB0
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CD4437D;
	Wed, 15 May 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QVrXSJBe"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595A446A9;
	Wed, 15 May 2024 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758658; cv=none; b=ixNdNVI5Uzek/a/XVrp0PgrCP17DcMTIOVb4c9n+e07VOk5Dr4mphvIGXVPdyucS9aRVatsSqosDGcl32KV4CK/mmWd0neroRJsKLK83/TNmIhHKy2WbSswm9XlWDTMKlFK0csxwpD4hbcUxcdCaRJQyAU8/QISZzjkTqSVgq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758658; c=relaxed/simple;
	bh=bEsm0BbBd0A7B3bKfe/HOWTX8J9AFW5GwUZfH8pzidE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7oMpJglQRO7eiyREKwaQwyh6jxcNDWyuJu2471FNHJIPAXwmyayqN8E/WvuQBiIXSkRdAb01x5v9pxvPA3qnPl10HiYbY1O/KYz0hNEFSZDsje1UBf9f+UpXrORux9B8QUF9RvZ9aa+jWrLKtxlvNLsPoILraPwsAdSSAwLj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QVrXSJBe; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f8460486128d11ef8065b7b53f7091ad-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7aeri6oYG4BXYXoTQ2cZONHGAN6C/zuDSGpOZpExbAw=;
	b=QVrXSJBegMdpAiH/FpiwRNO6CWpftak62qh65/YTVsENLL+2zAmZBmQUUIwWUKv2PQ/kDibHg9IfCRYXszll+xzP03W/5Ib41++2nkG33HeTgp2FPgqYpkM1covTaP1IIoCcvCex1KTtJDWWBJ5+9+cEfpX8mGGVr58Bf3aJLQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7c88c58a-e253-4fe5-be09-35a6985de4e1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:729ee083-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f8460486128d11ef8065b7b53f7091ad-20240515
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 995212172; Wed, 15 May 2024 15:37:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 00:37:22 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 15:37:22 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"yenchia . chen" <yenchia.chen@mediatek.com>, "David S. Miller"
	<davem@davemloft.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sasha Levin
	<sashal@kernel.org>, Simon Horman <horms@kernel.org>, Ryosuke Yasuoka
	<ryasuoka@redhat.com>, Zhengchao Shao <shaozhengchao@huawei.com>, Pedro
 Tammela <pctammela@mojatatu.com>, Thomas Graf <tgraf@suug.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5.15 1/2] netlink: annotate lockless accesses to nlk->max_recvmsg_len
Date: Wed, 15 May 2024 15:36:37 +0800
Message-ID: <20240515073644.32503-2-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240515073644.32503-1-yenchia.chen@mediatek.com>
References: <20240515073644.32503-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Eric Dumazet <edumazet@google.com>

syzbot reported a data-race in data-race in netlink_recvmsg() [1]

Indeed, netlink_recvmsg() can be run concurrently,
and netlink_dump() also needs protection.

[1]
BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg

read to 0xffff888141840b38 of 8 bytes by task 23057 on cpu 0:
netlink_recvmsg+0xea/0x730 net/netlink/af_netlink.c:1988
sock_recvmsg_nosec net/socket.c:1017 [inline]
sock_recvmsg net/socket.c:1038 [inline]
__sys_recvfrom+0x1ee/0x2e0 net/socket.c:2194
__do_sys_recvfrom net/socket.c:2212 [inline]
__se_sys_recvfrom net/socket.c:2208 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2208
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff888141840b38 of 8 bytes by task 23037 on cpu 1:
netlink_recvmsg+0x114/0x730 net/netlink/af_netlink.c:1989
sock_recvmsg_nosec net/socket.c:1017 [inline]
sock_recvmsg net/socket.c:1038 [inline]
____sys_recvmsg+0x156/0x310 net/socket.c:2720
___sys_recvmsg net/socket.c:2762 [inline]
do_recvmmsg+0x2e5/0x710 net/socket.c:2856
__sys_recvmmsg net/socket.c:2935 [inline]
__do_sys_recvmmsg net/socket.c:2958 [inline]
__se_sys_recvmmsg net/socket.c:2951 [inline]
__x64_sys_recvmmsg+0xe2/0x160 net/socket.c:2951
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000000 -> 0x0000000000001000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 23037 Comm: syz-executor.2 Not tainted 6.3.0-rc4-syzkaller-00195-g5a57b48fdfcb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023

Fixes: 9063e21fb026 ("netlink: autosize skb lengthes")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230403214643.768555-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>
---
 net/netlink/af_netlink.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 82df02695bbd..56ba8a6396ca 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1935,7 +1935,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	int noblock = flags & MSG_DONTWAIT;
-	size_t copied;
+	size_t copied, max_recvmsg_len;
 	struct sk_buff *skb, *data_skb;
 	int err, ret;
 
@@ -1968,9 +1968,10 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 #endif
 
 	/* Record the max length of recvmsg() calls for future allocations */
-	nlk->max_recvmsg_len = max(nlk->max_recvmsg_len, len);
-	nlk->max_recvmsg_len = min_t(size_t, nlk->max_recvmsg_len,
-				     SKB_WITH_OVERHEAD(32768));
+	max_recvmsg_len = max(READ_ONCE(nlk->max_recvmsg_len), len);
+	max_recvmsg_len = min_t(size_t, max_recvmsg_len,
+				SKB_WITH_OVERHEAD(32768));
+	WRITE_ONCE(nlk->max_recvmsg_len, max_recvmsg_len);
 
 	copied = data_skb->len;
 	if (len < copied) {
@@ -2219,6 +2220,7 @@ static int netlink_dump(struct sock *sk)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	size_t max_recvmsg_len;
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
@@ -2241,8 +2243,9 @@ static int netlink_dump(struct sock *sk)
 	cb = &nlk->cb;
 	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
 
-	if (alloc_min_size < nlk->max_recvmsg_len) {
-		alloc_size = nlk->max_recvmsg_len;
+	max_recvmsg_len = READ_ONCE(nlk->max_recvmsg_len);
+	if (alloc_min_size < max_recvmsg_len) {
+		alloc_size = max_recvmsg_len;
 		skb = alloc_skb(alloc_size,
 				(GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) |
 				__GFP_NOWARN | __GFP_NORETRY);
-- 
2.18.0


