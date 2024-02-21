Return-Path: <stable+bounces-22567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F085DCA5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59A01C2355D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362017BAFB;
	Wed, 21 Feb 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/gvPXrw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879476C99;
	Wed, 21 Feb 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523751; cv=none; b=OoYwOG57yZYAwbaMzurYx+3voHWvvEU/meroEJ5vJg1EHOm568cIDJ1o3KmHfcDB0q3wn/sCdKrHubtW/lb4CGHLn4Wx84ZtrDJZh1JVIKE2br89calzO60VzToqA666AHWs1ZFlKw3rot2NF/pnDkrc76NLti1pFvpNTAd1KtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523751; c=relaxed/simple;
	bh=6SzqibfRuwOLqpwTfFEtWbWBfPNK07vDl39BtvPtg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQtv78JmlLA2GHEM3Fv9KV/j8V7TbDlyplv3VNx4ISqeSc+1JrD82NaW8qyGKZacszyeTEsFGLK9Y/MDlf33LcgQUG3b5JtD4bIlteWRjbib0haeD/CDKeVyA0pITzOuoq30txTCJn5mJDzRAsNxIU2AIcCkd+D1Q/LnIYcdJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/gvPXrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208E6C433C7;
	Wed, 21 Feb 2024 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523750;
	bh=6SzqibfRuwOLqpwTfFEtWbWBfPNK07vDl39BtvPtg7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/gvPXrwDXTFCbCUnvisixY8m6NwXDuyqgLmLOiWA6NJ/OQUuJvjXGqPgT3wfZtuD
	 GzBq3K8+1jLXyoSPdL4lbhO/qdOeDSKY8MwBACmEsW3e6sycA/ftksYk4dG7ZwbL4v
	 U+idmQqerOFBsaWZ2qTxMAhI5+KBX8CqLGayTtrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/379] llc: Drop support for ETH_P_TR_802_2.
Date: Wed, 21 Feb 2024 14:03:46 +0100
Message-ID: <20240221125956.310245207@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e3f9bed9bee261e3347131764e42aeedf1ffea61 ]

syzbot reported an uninit-value bug below. [0]

llc supports ETH_P_802_2 (0x0004) and used to support ETH_P_TR_802_2
(0x0011), and syzbot abused the latter to trigger the bug.

  write$tun(r0, &(0x7f0000000040)={@val={0x0, 0x11}, @val, @mpls={[], @llc={@snap={0xaa, 0x1, ')', "90e5dd"}}}}, 0x16)

llc_conn_handler() initialises local variables {saddr,daddr}.mac
based on skb in llc_pdu_decode_sa()/llc_pdu_decode_da() and passes
them to __llc_lookup().

However, the initialisation is done only when skb->protocol is
htons(ETH_P_802_2), otherwise, __llc_lookup_established() and
__llc_lookup_listener() will read garbage.

The missing initialisation existed prior to commit 211ed865108e
("net: delete all instances of special processing for token ring").

It removed the part to kick out the token ring stuff but forgot to
close the door allowing ETH_P_TR_802_2 packets to sneak into llc_rcv().

Let's remove llc_tr_packet_type and complete the deprecation.

[0]:
BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
 __llc_lookup_established+0xe9d/0xf90
 __llc_lookup net/llc/llc_conn.c:611 [inline]
 llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
 __netif_receive_skb_one_core net/core/dev.c:5527 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5641
 netif_receive_skb_internal net/core/dev.c:5727 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5786
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
 tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable daddr created at:
 llc_conn_handler+0x53/0x1360 net/llc/llc_conn.c:783
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206

CPU: 1 PID: 5004 Comm: syz-executor994 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023

Fixes: 211ed865108e ("net: delete all instances of special processing for token ring")
Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240119015515.61898-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/llc_pdu.h | 6 ++----
 net/llc/llc_core.c    | 7 -------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 49aa79c7b278..581cd37aa98b 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,8 +262,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
+	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
 /**
@@ -275,8 +274,7 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
+	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
 /**
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 64d4bef04e73..4900a27b5176 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -135,22 +135,15 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
-static struct packet_type llc_tr_packet_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_TR_802_2),
-	.func = llc_rcv,
-};
-
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
-	dev_add_pack(&llc_tr_packet_type);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
 	dev_remove_pack(&llc_packet_type);
-	dev_remove_pack(&llc_tr_packet_type);
 }
 
 module_init(llc_init);
-- 
2.43.0




