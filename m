Return-Path: <stable+bounces-41683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E608B5747
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12566284024
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF053383;
	Mon, 29 Apr 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0HXp8/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB4D5A2
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392022; cv=none; b=YGkCGRqj/gayaEdkx11sIN/yRxEg9ElETrlFZPX2Go/NXWJtvDnz+sp/P5BJVzX9gdK2LLKOTKkIyhTjm37zKsnsCLSSpTwAFjknWc2tuXgBVVnrZu5SL0FvTtSN04kuWv8U6D3nUzAJgqZgXAZbAWR6+CfNF9ojbIP74OnUTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392022; c=relaxed/simple;
	bh=BogNmqbqDmyYAqTpUvtTwJ3cHF2NLsMqeQN6qGV85YI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D4HOdmYtn7FAhlW9oe6VjBpmF5vHSOnqqhb3ZcZoMBTA6JXlsO6PXVugBOgGuOxAgjoDusDcJsgWkdRay3OyoeBUoRwy09bClJlFLicE8bcfZ8QKpC9zFUBAltVxNGDDWAYq64GKMJR+qLfkNYHk3r3NeVUddsyBkQWf+rzPIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0HXp8/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CAC113CD;
	Mon, 29 Apr 2024 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714392022;
	bh=BogNmqbqDmyYAqTpUvtTwJ3cHF2NLsMqeQN6qGV85YI=;
	h=Subject:To:Cc:From:Date:From;
	b=q0HXp8/SFuKPWu1eiTfpNgXT4a8kpvtKCEhMLWHztewdehgzlOfwr+3LJh4jYpxCC
	 GO+Q1lINMy11/azAtIUnUkFzbdMClj4O4Azwxoo9ri7RrbwMtWor3Rdf6Gs+lxr93v
	 yEtNUht3lPDDA82S4+VIKvG3qdj6ZQ++usVHpGCc=
Subject: FAILED: patch "[PATCH] udp: preserve the connected status if only UDP cmsg" failed to apply to 5.15-stable tree
To: yick.xie@gmail.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 14:00:19 +0200
Message-ID: <2024042919-strobe-squatted-ad63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 680d11f6e5427b6af1321932286722d24a8b16c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042919-strobe-squatted-ad63@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

680d11f6e542 ("udp: preserve the connected status if only UDP cmsg")
5298953e742d ("udp6: don't make extra copies of iflow")
42dcfd850e51 ("udp6: allow SO_MARK ctrl msg to affect routing")

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


