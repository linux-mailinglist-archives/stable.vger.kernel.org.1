Return-Path: <stable+bounces-36082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF64899B07
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579451C21802
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72B1553AB;
	Fri,  5 Apr 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGPBZY+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6113A416
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313660; cv=none; b=HQVvrstLQk7RsgWDUloGx7JwULn7/ZNkpizrhQihhOMKBWZHd06Gdnrm20bJRFj1fWuw0D8/y5kpnQMnSSyT5zBgGi69Xi4hlqjmbtoP693twuxl87jgnYH2nqSb1C2TPgt85EBBYIZ6tOZHYflk71N3+LfeCXHbmtz/MD+G3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313660; c=relaxed/simple;
	bh=/O7HIr2cRkbO+GGREY6X5oa5+iyRk5zgQjK9BAZZpFA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DfEiyuyUtWgHwx4TIeSTCEe+lSMZHIr8FCG60fAqI8p7iEQ0aTfYlpQ7EjT1Fh/ZJKhaT1hvERM+J+g5Yj7huuZgTCm6Nhj9mB6jIsSsiriomLc6vHYbH3vTOThvyn0eBD8UiZCZGxAriv0Lfw69pCcBxwsQRcXWvTmKU8uuQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGPBZY+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31911C43394;
	Fri,  5 Apr 2024 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712313659;
	bh=/O7HIr2cRkbO+GGREY6X5oa5+iyRk5zgQjK9BAZZpFA=;
	h=Subject:To:Cc:From:Date:From;
	b=MGPBZY+MqXQXqux6Px+HgdScMGZ7uTA9k6E3WDvg2rIvOeuUescFqgR1wJgJWXHPV
	 XjHOXI5Bjr40dJ+YiH2akN1nYnZBWGzTB2qF55mCWsJN0mYZ8kFrn+Px8D0P/qbwL8
	 MGwLs6r3mc5h4c4bqH7dEVOxlILk9nOW2Amz9Fns=
Subject: FAILED: patch "[PATCH] erspan: make sure erspan_base_hdr is present in skb->head" failed to apply to 4.19-stable tree
To: edumazet@google.com,kuba@kernel.org,lorenzo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:40:48 +0200
Message-ID: <2024040548-singing-itunes-347d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 17af420545a750f763025149fa7b833a4fc8b8f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040548-singing-itunes-347d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17af420545a750f763025149fa7b833a4fc8b8f0 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 11:22:48 +0000
Subject: [PATCH] erspan: make sure erspan_base_hdr is present in skb->head

syzbot reported a problem in ip6erspan_rcv() [1]

Issue is that ip6erspan_rcv() (and erspan_rcv()) no longer make
sure erspan_base_hdr is present in skb linear part (skb->head)
before getting @ver field from it.

Add the missing pskb_may_pull() calls.

v2: Reload iph pointer in erspan_rcv() after pskb_may_pull()
    because skb->head might have changed.

[1]

 BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
 BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2756 [inline]
 BUG: KMSAN: uninit-value in ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
 BUG: KMSAN: uninit-value in gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
  pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
  pskb_may_pull include/linux/skbuff.h:2756 [inline]
  ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
  gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
  ip6_protocol_deliver_rcu+0x1d4c/0x2ca0 net/ipv6/ip6_input.c:438
  ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
  ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
  dst_input include/net/dst.h:460 [inline]
  ip6_rcv_finish+0x955/0x970 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ipv6_rcv+0xde/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5652
  netif_receive_skb_internal net/core/dev.c:5738 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb63/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3804 [inline]
  slab_alloc_node mm/slub.c:3845 [inline]
  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
  __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
  alloc_skb include/linux/skbuff.h:1318 [inline]
  alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
  tun_alloc_skb drivers/net/tun.c:1525 [inline]
  tun_get_user+0x209a/0x69e0 drivers/net/tun.c:1846
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb63/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5045 Comm: syz-executor114 Not tainted 6.9.0-rc1-syzkaller-00021-g962490525cff #0

Fixes: cb73ee40b1b3 ("net: ip_gre: use erspan key field for tunnel lookup")
Reported-by: syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000772f2c0614b66ef7@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/20240328112248.1101491-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 7b16c211b904..57ddcd8c62f6 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -280,8 +280,13 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  tpi->flags | TUNNEL_NO_KEY,
 					  iph->saddr, iph->daddr, 0);
 	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
+
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		iph = ip_hdr(skb);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
 					  tpi->flags | TUNNEL_KEY,
 					  iph->saddr, iph->daddr, tpi->key);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ca7e77e84283..c89aef524df9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -528,6 +528,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+		return PACKET_REJECT;
+
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;


