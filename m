Return-Path: <stable+bounces-45133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DAB8C61D1
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88531C20B8C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A947F6B;
	Wed, 15 May 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lIE9Oqmi"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756744C67;
	Wed, 15 May 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758661; cv=none; b=uYo7osPvl8vzr4gjRONvXa4RAQDLD/yXelRpFVM6iUeyoyoOAJLFIq0MWzw/rZ7NP79ZMTPG79K2xnrezTaD6Eetu50uWEBJ0lZZCZXtPBX3wsEgJro4Hv7BQReA4/IELjiybcdqwdxpUyM5wTHOgaA65AXWbgdzLopmpZT5yA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758661; c=relaxed/simple;
	bh=NOt/mRBBSu0+0vOPFEiRbcM9nRdzNiEC3mK1YfMPFuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lglGdJcvelA2B89KXbt1Dzotd9sLqTKeubHYIF7ZRo2RCgtaVwgr97WrC7EXLX5TKYU2a5d67yljJ3IKxyLMilnpAoie0mzZ4toRL4HSPpzP2h/CE62idDbJNTWlv3LLuYfyjMp/xU+BxivlBKWr5/aDEWBNumBFdC7yiOUf8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lIE9Oqmi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fd945712128d11efb92737409a0e9459-20240515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pq9e80lON3BhRVoD9nhx9lAtIIWCejaV+x33Z/cxgAU=;
	b=lIE9OqmiUtCVlRnVemUdisPmc7l9laHMphUSofJUXrbOYN/tfCOrhRN/hCqJHaU7DTVOHjanpRuDVrzgG/Et2UlbV/XZdXDFJultEwtpOCuxUN+ZjhvkG2QphWd648+FN4k/pHqvRCaGcMTAZoizQ8xDw1emr++zXaOFGW85pE8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:97b5caac-d385-4dce-945c-58e4568209cd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:df9ee083-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: fd945712128d11efb92737409a0e9459-20240515
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 369985097; Wed, 15 May 2024 15:37:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 15 May 2024 15:37:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 15 May 2024 15:37:27 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"yenchia . chen" <yenchia.chen@mediatek.com>, "David S. Miller"
	<davem@davemloft.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sasha Levin
	<sashal@kernel.org>, Simon Horman <horms@kernel.org>, Zhengchao Shao
	<shaozhengchao@huawei.com>, Pedro Tammela <pctammela@mojatatu.com>, "Ryosuke
 Yasuoka" <ryasuoka@redhat.com>, Thomas Graf <tgraf@suug.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5.15 2/2] netlink: annotate data-races around sk->sk_err
Date: Wed, 15 May 2024 15:36:38 +0800
Message-ID: <20240515073644.32503-3-yenchia.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.131400-8.000000
X-TMASE-MatchedRID: B4VcMIpPJ80Rj//xa6LvPpRrnSy7UTtbKx5ICGp/WtHMcZL/toKwUkrQ
	UCy1ylPSAPcZ9zzfLcIv7hNVwd55efuyoboeSVFgTb17VOdIjbvwq1JQ5xF4kkYvSDWdWaRhzTO
	MdSL65dE+pUh4aRsT8NseKHBzEjWEkKjL2IOi2LCXIjSc2qlF9V3KZkFy4YZELi8ZclgvHlpZzl
	8EYQ5IaIW41t/bx9voj544a0UVEb2XKs94NAOH8p4CIKY/Hg3Am4n49vyf9XFKdDgyPBo71yq2r
	l3dzGQ1NSaQQEldMgqmSHBo/u5geQuOoM9Ul2SnBc7tWkpxW0LdJINzPCIf61dBVVovJ3TSNzbL
	S7IGtHHBIEfdl1Dl4xaNTUyr3lsN/GNoswKabLcXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9W
	gDXVPCok0oJvJCVSkQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.131400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	39C47996367777646C92F12D7CAC304752903E36B1A15F34117C76253C3414C22000:8

From: Eric Dumazet <edumazet@google.com>

syzbot caught another data-race in netlink when
setting sk->sk_err.

Annotate all of them for good measure.

BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg

write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
__sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
__do_sys_recvfrom net/socket.c:2247 [inline]
__se_sys_recvfrom net/socket.c:2243 [inline]
__x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0x00000016

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231003183455.3410550-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>
---
 net/netlink/af_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 56ba8a6396ca..216445dd44db 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -352,7 +352,7 @@ static void netlink_overrun(struct sock *sk)
 	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
 		if (!test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
-			sk->sk_err = ENOBUFS;
+			WRITE_ONCE(sk->sk_err, ENOBUFS);
 			sk_error_report(sk);
 		}
 	}
@@ -1591,7 +1591,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 		goto out;
 	}
 
-	sk->sk_err = p->code;
+	WRITE_ONCE(sk->sk_err, p->code);
 	sk_error_report(sk);
 out:
 	return ret;
@@ -2006,7 +2006,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
-			sk->sk_err = -ret;
+			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
 		}
 	}
@@ -2442,7 +2442,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 
 	skb = nlmsg_new(payload + tlvlen, GFP_KERNEL);
 	if (!skb) {
-		NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
+		WRITE_ONCE(NETLINK_CB(in_skb).sk->sk_err, ENOBUFS);
 		sk_error_report(NETLINK_CB(in_skb).sk);
 		return;
 	}
-- 
2.18.0


