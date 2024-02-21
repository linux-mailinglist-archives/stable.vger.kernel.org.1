Return-Path: <stable+bounces-22566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515D85DCA4
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4661B1C235D1
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE07B3F2;
	Wed, 21 Feb 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xK4E/GPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F578B50;
	Wed, 21 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523747; cv=none; b=YF5S2yZuyFoAYVaL2xYUJTOzbVced0iYdzpkWJ52h68IPoi/W+aoedt14uPtVwWwpv9asi0Cj0y0/0w1nciPMT2C05/l/xfv6ZEIIq4rDjXx4AsH2TF+c7RcqHABwZCA0Q5jHyQFksUt2Ov9kBbphlpUrWrndWJ4nkZ3DDu4Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523747; c=relaxed/simple;
	bh=56vBSNVEWgNdohf+gouTSSlbDZ9Is4xtpTTCU9Q7jW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRKZwXEHpYU0tDRWwFdlGwLPh+FZ8HJPda2/GBlXoKCrUtG1d/8shQZC8kCofkN6bF8yIJJtzlOgeMBhZajL9+ZUHqhBlKnkSw3pbUDS64HcKHMjWQKb762UVEH3SUewoNs6AR+Gl1zTr3+xwlQYVhRc/8Za8pZf736v6KcND+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xK4E/GPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4987FC43390;
	Wed, 21 Feb 2024 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523747;
	bh=56vBSNVEWgNdohf+gouTSSlbDZ9Is4xtpTTCU9Q7jW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xK4E/GPTeQTRC882//VWVjHGrHrax8sb4TxrGZBOAJJjbf3NU+lRh1EJ30K0T4Mdo
	 GSeUSFN1j7ukW8onNSS2nfeoCwHwTPv0fnoULRvThAt29k3xlCOVnUWUnd0LyEhyEO
	 pOfpyV+HLFsioJ7Qu/Q6wsZM6uXEFHGoFiz4XyCY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+2a7024e9502df538e8ef@syzkaller.appspotmail.com
Subject: [PATCH 5.10 046/379] llc: make llc_ui_sendmsg() more robust against bonding changes
Date: Wed, 21 Feb 2024 14:03:45 +0100
Message-ID: <20240221125956.280524413@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit dad555c816a50c6a6a8a86be1f9177673918c647 ]

syzbot was able to trick llc_ui_sendmsg(), allocating an skb with no
headroom, but subsequently trying to push 14 bytes of Ethernet header [1]

Like some others, llc_ui_sendmsg() releases the socket lock before
calling sock_alloc_send_skb().
Then it acquires it again, but does not redo all the sanity checks
that were performed.

This fix:

- Uses LL_RESERVED_SPACE() to reserve space.
- Check all conditions again after socket lock is held again.
- Do not account Ethernet header for mtu limitation.

[1]

skbuff: skb_under_panic: text:ffff800088baa334 len:1514 put:14 head:ffff0000c9c37000 data:ffff0000c9c36ff2 tail:0x5dc end:0x6c0 dev:bond0

 kernel BUG at net/core/skbuff.c:193 !
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6875 Comm: syz-executor.0 Not tainted 6.7.0-rc8-syzkaller-00101-g0802e17d9aca-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : skb_panic net/core/skbuff.c:189 [inline]
 pc : skb_under_panic+0x13c/0x140 net/core/skbuff.c:203
 lr : skb_panic net/core/skbuff.c:189 [inline]
 lr : skb_under_panic+0x13c/0x140 net/core/skbuff.c:203
sp : ffff800096f97000
x29: ffff800096f97010 x28: ffff80008cc8d668 x27: dfff800000000000
x26: ffff0000cb970c90 x25: 00000000000005dc x24: ffff0000c9c36ff2
x23: ffff0000c9c37000 x22: 00000000000005ea x21: 00000000000006c0
x20: 000000000000000e x19: ffff800088baa334 x18: 1fffe000368261ce
x17: ffff80008e4ed000 x16: ffff80008a8310f8 x15: 0000000000000001
x14: 1ffff00012df2d58 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : e28a51f1087e8400
x8 : e28a51f1087e8400 x7 : ffff80008028f8d0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800082b78714
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000089
Call trace:
  skb_panic net/core/skbuff.c:189 [inline]
  skb_under_panic+0x13c/0x140 net/core/skbuff.c:203
  skb_push+0xf0/0x108 net/core/skbuff.c:2451
  eth_header+0x44/0x1f8 net/ethernet/eth.c:83
  dev_hard_header include/linux/netdevice.h:3188 [inline]
  llc_mac_hdr_init+0x110/0x17c net/llc/llc_output.c:33
  llc_sap_action_send_xid_c+0x170/0x344 net/llc/llc_s_ac.c:85
  llc_exec_sap_trans_actions net/llc/llc_sap.c:153 [inline]
  llc_sap_next_state net/llc/llc_sap.c:182 [inline]
  llc_sap_state_process+0x1ec/0x774 net/llc/llc_sap.c:209
  llc_build_and_send_xid_pkt+0x12c/0x1c0 net/llc/llc_sap.c:270
  llc_ui_sendmsg+0x7bc/0xb1c net/llc/af_llc.c:997
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  sock_sendmsg+0x194/0x274 net/socket.c:767
  splice_to_socket+0x7cc/0xd58 fs/splice.c:881
  do_splice_from fs/splice.c:933 [inline]
  direct_splice_actor+0xe4/0x1c0 fs/splice.c:1142
  splice_direct_to_actor+0x2a0/0x7e4 fs/splice.c:1088
  do_splice_direct+0x20c/0x348 fs/splice.c:1194
  do_sendfile+0x4bc/0xc70 fs/read_write.c:1254
  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
  __se_sys_sendfile64 fs/read_write.c:1308 [inline]
  __arm64_sys_sendfile64+0x160/0x3b4 fs/read_write.c:1308
  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: aa1803e6 aa1903e7 a90023f5 94792f6a (d4210000)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+2a7024e9502df538e8ef@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240118183625.4007013-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/llc/af_llc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 01e26698285a..f9785150bfcc 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -927,14 +927,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  */
 static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
+	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	int flags = msg->msg_flags;
 	int noblock = flags & MSG_DONTWAIT;
+	int rc = -EINVAL, copied = 0, hdrlen, hh_len;
 	struct sk_buff *skb = NULL;
+	struct net_device *dev;
 	size_t size = 0;
-	int rc = -EINVAL, copied = 0, hdrlen;
 
 	dprintk("%s: sending from %02X to %02X\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
@@ -954,22 +955,29 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		if (rc)
 			goto out;
 	}
-	hdrlen = llc->dev->hard_header_len + llc_ui_header_len(sk, addr);
+	dev = llc->dev;
+	hh_len = LL_RESERVED_SPACE(dev);
+	hdrlen = llc_ui_header_len(sk, addr);
 	size = hdrlen + len;
-	if (size > llc->dev->mtu)
-		size = llc->dev->mtu;
+	size = min_t(size_t, size, READ_ONCE(dev->mtu));
 	copied = size - hdrlen;
 	rc = -EINVAL;
 	if (copied < 0)
 		goto out;
 	release_sock(sk);
-	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
+	skb = sock_alloc_send_skb(sk, hh_len + size, noblock, &rc);
 	lock_sock(sk);
 	if (!skb)
 		goto out;
-	skb->dev      = llc->dev;
+	if (sock_flag(sk, SOCK_ZAPPED) ||
+	    llc->dev != dev ||
+	    hdrlen != llc_ui_header_len(sk, addr) ||
+	    hh_len != LL_RESERVED_SPACE(dev) ||
+	    size > READ_ONCE(dev->mtu))
+		goto out;
+	skb->dev      = dev;
 	skb->protocol = llc_proto_type(addr->sllc_arphrd);
-	skb_reserve(skb, hdrlen);
+	skb_reserve(skb, hh_len + hdrlen);
 	rc = memcpy_from_msg(skb_put(skb, copied), msg, copied);
 	if (rc)
 		goto out;
-- 
2.43.0




