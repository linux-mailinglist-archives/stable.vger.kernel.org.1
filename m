Return-Path: <stable+bounces-8627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80681F780
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A8F1C209B7
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9AA6FBA;
	Thu, 28 Dec 2023 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kLG7mx4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F663DB
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 11:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6453BC433C8;
	Thu, 28 Dec 2023 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703761496;
	bh=TOvBY+kZ/gzpksBgL4FXIpndruZTTBiSPvbSAJPqAuQ=;
	h=Subject:To:Cc:From:Date:From;
	b=kLG7mx4jq/DSHjPe7oFuj1kZtR/S0BfUkxoYEkgvmhULpaLmt0J3EvquyJBXiBD9z
	 WRRIIbHG8Za0xRo/Kxnz8XRrruTAK//dOooGHtKhEhtB0P/54kLB33q58efVmrSX87
	 6BV2RVR+EN1TEgKNxLyypzKHlx3rKI1pveqGhYDY=
Subject: FAILED: patch "[PATCH] Bluetooth: af_bluetooth: Fix Use-After-Free in" failed to apply to 4.14-stable tree
To: v4bel@theori.io,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 11:04:46 +0000
Message-ID: <2023122845-pancake-handyman-652b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 2e07e8348ea454615e268222ae3fc240421be768
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122845-pancake-handyman-652b@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

2e07e8348ea4 ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg")
f4b41f062c42 ("net: remove noblock parameter from skb_recv_datagram()")
42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
30ffd5332e06 ("can: isotp: return -EADDRNOTAVAIL when reading from unbound socket")
c5755214623d ("mctp: tests: Add key state tests")
62a2b005c6d6 ("mctp: tests: Rename FL_T macro to FL_TO")
1e5e9250d422 ("mctp: Add input reassembly tests")
8892c0490779 ("mctp: Add route input to socket tests")
b504db408c34 ("mctp: Add packet rx tests")
161eba50e183 ("mctp: Add initial test structure and fragmentation test")
833ef3b91de6 ("mctp: Populate socket implementation")
4d8b9319282a ("mctp: Add neighbour implementation")
889b7da23abf ("mctp: Add initial routing framework")
583be982d934 ("mctp: Add device handling and netlink interface")
60fc63981693 ("mctp: Add sockaddr_mctp to uapi")
2c8e2e9aec79 ("mctp: Add base packet definitions")
8f601a1e4f8c ("mctp: Add base socket/protocol definitions")
bc49d8169aa7 ("mctp: Add MCTP base")
29df44fa52b7 ("af_unix: Implement ->read_sock() for sockmap")
fe0bdbde0756 ("net: add pf_family_names[] for protocol family")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e07e8348ea454615e268222ae3fc240421be768 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <v4bel@theori.io>
Date: Sat, 9 Dec 2023 05:55:18 -0500
Subject: [PATCH] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg

This can cause a race with bt_sock_ioctl() because
bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
and then frees it without holding lock_sock.
A use-after-free for a skb occurs with the following flow.
```
bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
bt_sock_ioctl() -> skb_peek()
```
Add lock_sock to bt_sock_recvmsg() to fix this issue.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 336a76165454..b93464ac3517 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -309,11 +309,14 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	lock_sock(sk);
+
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			return 0;
+			err = 0;
 
+		release_sock(sk);
 		return err;
 	}
 
@@ -343,6 +346,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
+	release_sock(sk);
+
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 


