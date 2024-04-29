Return-Path: <stable+bounces-41686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7AE8B574C
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F535B22891
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67828535A9;
	Mon, 29 Apr 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7nfugSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E6535A2
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392035; cv=none; b=jmJMW+O7aSzHP2wtV8t9+Fm6ObautsyesEWbPtkTJ4jMY2TUkXb+ouyncedpVURJsihEf/YuLFxg03Z16ydwRDXUqESIDETp3DiU1b406hZqDgpJZa+ll+xgN15Le90EAHjiLYf2Uh8+Cn8k3xemMWZluMMZy4gqUUj9oaMpavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392035; c=relaxed/simple;
	bh=moe0K2Hw+W/o9uPidgUXJ6QJvgp0PWGEey+4jEBL26E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mqmjopE7zx66sUkjcVDDThlk27+B+hYvFZhHTAkEoZzkfLj0PaTpstavhqdtNHXaAIEcEofHDSsWgIbIo32FovAVeJabbtSeUj4WS0nWCoOc/FBuTQiP4pDdpwPUpn9OrFKoesXIbYQZV3uniC4uN4w9gyudtEhGl4BbOipMP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7nfugSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49823C113CD;
	Mon, 29 Apr 2024 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714392034;
	bh=moe0K2Hw+W/o9uPidgUXJ6QJvgp0PWGEey+4jEBL26E=;
	h=Subject:To:Cc:From:Date:From;
	b=p7nfugSPZtDmm60+VYkO3FYhbUPD99UiesYiGR7VpaFZ1MeeVl+AqQpNhPIMjEfJF
	 JfR9pYvblv+qgrKxTtpGnrsGctoAAfrqVoBlSUipefoLz5MHq4iNqBxrsL8i1q8J++
	 79FnlEsvBU3r9IUrHcpVaqjq970F4NycOotDEGj0=
Subject: FAILED: patch "[PATCH] udp: preserve the connected status if only UDP cmsg" failed to apply to 4.19-stable tree
To: yick.xie@gmail.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 14:00:25 +0200
Message-ID: <2024042925-enrich-charbroil-ce36@gregkh>
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
git cherry-pick -x 680d11f6e5427b6af1321932286722d24a8b16c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042925-enrich-charbroil-ce36@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

680d11f6e542 ("udp: preserve the connected status if only UDP cmsg")
5298953e742d ("udp6: don't make extra copies of iflow")
42dcfd850e51 ("udp6: allow SO_MARK ctrl msg to affect routing")
3df98d79215a ("lsm,selinux: pass flowi_common instead of flowi to the LSM hooks")
e94ee171349d ("xfrm: Use correct address family in xfrm_state_find")
5eff06902394 ("ipv4: fill fl4_icmp_{type,code} in ping_v4_sendmsg")
6abde0b24122 ("crypto/chtls: IPv6 support for inline TLS")
ed52f2c608c9 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 680d11f6e5427b6af1321932286722d24a8b16c1 Mon Sep 17 00:00:00 2001
From: Yick Xie <yick.xie@gmail.com>
Date: Fri, 19 Apr 2024 01:06:10 +0800
Subject: [PATCH] udp: preserve the connected status if only UDP cmsg

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02bf011d4a6..420905be5f30 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1123,16 +1123,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b1dd7f51249..1a4cccdd40c9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1474,9 +1474,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1488,7 +1490,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);


