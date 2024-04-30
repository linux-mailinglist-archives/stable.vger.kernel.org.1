Return-Path: <stable+bounces-42537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2878B737D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A1C1F23FD3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82112D1EA;
	Tue, 30 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIgfgU3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA917592;
	Tue, 30 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475983; cv=none; b=S9lwS62/2nK6tFKKFQWfqXfD0QHKpUvKiY70lFly71hHDuudli92BQDb8Wg4BK7E7XuN8yXP+at80WhyF+5KtR4UmPYT1N94nw/bM93DKxyR6SgVfD9JQmfy/i/jgWNm6ReXXlZlarTbTsTYKL5v8FUQR9/cvzwnxB95zjMVovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475983; c=relaxed/simple;
	bh=fl1ZbdRvPVVe1BgFd1B8kuOgNo4CMgv0xR9jVL+T22k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAF4FobA223w8rHoNXm00sOcaY7tRDGPeNrk8DbQ8TRKhfeiQjLKl9X+/Ax/F6JnNqrAO0mjhvvX4Dy8zQGoNffo82KmQtjY9lXiARcge/LtXhe95Ip0ysblqT38yNgJf/TrwYiu1u3XG1DJQfZh/YCv0M/uvSyywIe/LB10AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIgfgU3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90645C2BBFC;
	Tue, 30 Apr 2024 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475983;
	bh=fl1ZbdRvPVVe1BgFd1B8kuOgNo4CMgv0xR9jVL+T22k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIgfgU3DXufmmmTG6in8zoMRKeJxIJT8BAPBVMzTTCh75rpLScE6CX0KjE3xxcM73
	 AL7yjv7swKc3w6kepfR7Vy01yp76vq3Wcwjorp+H3oz+FDevFHzHdDmc7rnYagwVrl
	 3+WthWbzBlIXIfl+ukMr5CT3bM/e9hwHu6SmZAqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yick Xie <yick.xie@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 79/80] udp: preserve the connected status if only UDP cmsg
Date: Tue, 30 Apr 2024 12:40:51 +0200
Message-ID: <20240430103045.743086530@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yick Xie <yick.xie@gmail.com>

commit 680d11f6e5427b6af1321932286722d24a8b16c1 upstream.

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    5 +++--
 net/ipv6/udp.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1139,16 +1139,17 @@ int udp_sendmsg(struct sock *sk, struct
 
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
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1479,9 +1479,11 @@ do_udp_sendmsg:
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, &fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1493,7 +1495,6 @@ do_udp_sendmsg:
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);



