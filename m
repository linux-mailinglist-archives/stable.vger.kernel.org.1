Return-Path: <stable+bounces-135614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C7A98F4B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7918E0163
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACEF280A5C;
	Wed, 23 Apr 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1MSyjzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E871EFFB9;
	Wed, 23 Apr 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420387; cv=none; b=S8jawJSudyJRAGXwKOxMO6tB/8KRb5GFOCihz81yNWCjD45eERYR6VlDLhXuhmAKmn9eTKHUpDmLC9CQhxrGdDKTvUm2wEQAme6iPEizBlT9yd+XIfr5X8x/Odr/Hu2whoLrlkZYr6aBRL+D77OpAoxQmKRJdOtmn9S3jxVprjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420387; c=relaxed/simple;
	bh=0ljgJqRiW+9doTZasziQoxkeleH7VGxu9hpHClHLF1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+n3zW9qM7b3MVX0GeRNnRZZZ9EHcXHkb2eIv+aGR1lLOkLi6P3s83ZEEAwgPoZRMAKXjCqYmWuYG+ZCZzZf0BA9g5pChLbNr067CERIU7tkMKVgex4/LIhYHPnygATrnu0LhQuniv4iTAkE+FlUUGCw4tfUdpcG6P3xMT+28L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1MSyjzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01978C4CEE2;
	Wed, 23 Apr 2025 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420387;
	bh=0ljgJqRiW+9doTZasziQoxkeleH7VGxu9hpHClHLF1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1MSyjzzBcQL/mQwcROrN5c/HXuM4q2arvwoX4xw+rqh8Cm0ooPBOWJTe8nLnpQ4N
	 vqdADtzrPmIkBE/AL+3rB9eRjbO7mp4DuI7zUX7zdevVK1E1o9heHVmjocf79e5Mw3
	 PZ8oClFoKePnfA5y8auums5gI9IWLcpzsXXglC88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 127/223] Revert "smb: client: fix TCP timers deadlock after rmmod"
Date: Wed, 23 Apr 2025 16:43:19 +0200
Message-ID: <20250423142622.272057595@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 95d2b9f693ff2a1180a23d7d59acc0c4e72f4c41 upstream.

This reverts commit e9f2517a3e18a54a3943c098d2226b245d488801.

Commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock after
rmmod") is intended to fix a null-ptr-deref in LOCKDEP, which is
mentioned as CVE-2024-54680, but is actually did not fix anything;
The issue can be reproduced on top of it. [0]

Also, it reverted the change by commit ef7134c7fc48 ("smb: client:
Fix use-after-free of network namespace.") and introduced a real
issue by reviving the kernel TCP socket.

When a reconnect happens for a CIFS connection, the socket state
transitions to FIN_WAIT_1.  Then, inet_csk_clear_xmit_timers_sync()
in tcp_close() stops all timers for the socket.

If an incoming FIN packet is lost, the socket will stay at FIN_WAIT_1
forever, and such sockets could be leaked up to net.ipv4.tcp_max_orphans.

Usually, FIN can be retransmitted by the peer, but if the peer aborts
the connection, the issue comes into reality.

I warned about this privately by pointing out the exact report [1],
but the bogus fix was finally merged.

So, we should not stop the timers to finally kill the connection on
our side in that case, meaning we must not use a kernel socket for
TCP whose sk->sk_net_refcnt is 0.

The kernel socket does not have a reference to its netns to make it
possible to tear down netns without cleaning up every resource in it.

For example, tunnel devices use a UDP socket internally, but we can
destroy netns without removing such devices and let it complete
during exit.  Otherwise, netns would be leaked when the last application
died.

However, this is problematic for TCP sockets because TCP has timers to
close the connection gracefully even after the socket is close()d.  The
lifetime of the socket and its netns is different from the lifetime of
the underlying connection.

If the socket user does not maintain the netns lifetime, the timer could
be fired after the socket is close()d and its netns is freed up, resulting
in use-after-free.

Actually, we have seen so many similar issues and converted such sockets
to have a reference to netns.

That's why I converted the CIFS client socket to have a reference to
netns (sk->sk_net_refcnt == 1), which is somehow mentioned as out-of-scope
of CIFS and technically wrong in e9f2517a3e18, but **is in-scope and right
fix**.

Regarding the LOCKDEP issue, we can prevent the module unload by
bumping the module refcount when switching the LOCKDDEP key in
sock_lock_init_class_and_name(). [2]

For a while, let's revert the bogus fix.

Note that now we can use sk_net_refcnt_upgrade() for the socket
conversion, but I'll do so later separately to make backport easy.

Link: https://lore.kernel.org/all/20250402020807.28583-1-kuniyu@amazon.com/ #[0]
Link: https://lore.kernel.org/netdev/c08bd5378da647a2a4c16698125d180a@huawei.com/ #[1]
Link: https://lore.kernel.org/lkml/20250402005841.19846-1-kuniyu@amazon.com/ #[2]
Fixes: e9f2517a3e18 ("smb: client: fix TCP timers deadlock after rmmod")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |   36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -987,13 +987,9 @@ clean_demultiplex_info(struct TCP_Server
 	msleep(125);
 	if (cifs_rdma_enabled(server))
 		smbd_destroy(server);
-
 	if (server->ssocket) {
 		sock_release(server->ssocket);
 		server->ssocket = NULL;
-
-		/* Release netns reference for the socket. */
-		put_net(cifs_net_ns(server));
 	}
 
 	if (!list_empty(&server->pending_mid_q)) {
@@ -1041,7 +1037,6 @@ clean_demultiplex_info(struct TCP_Server
 		 */
 	}
 
-	/* Release netns reference for this server. */
 	put_net(cifs_net_ns(server));
 	kfree(server->leaf_fullpath);
 	kfree(server->hostname);
@@ -1717,8 +1712,6 @@ cifs_get_tcp_session(struct smb3_fs_cont
 
 	tcp_ses->ops = ctx->ops;
 	tcp_ses->vals = ctx->vals;
-
-	/* Grab netns reference for this server. */
 	cifs_set_net_ns(tcp_ses, get_net(current->nsproxy->net_ns));
 
 	tcp_ses->sign = ctx->sign;
@@ -1851,7 +1844,6 @@ smbd_connected:
 out_err_crypto_release:
 	cifs_crypto_secmech_release(tcp_ses);
 
-	/* Release netns reference for this server. */
 	put_net(cifs_net_ns(tcp_ses));
 
 out_err:
@@ -1860,10 +1852,8 @@ out_err:
 			cifs_put_tcp_session(tcp_ses->primary_server, false);
 		kfree(tcp_ses->hostname);
 		kfree(tcp_ses->leaf_fullpath);
-		if (tcp_ses->ssocket) {
+		if (tcp_ses->ssocket)
 			sock_release(tcp_ses->ssocket);
-			put_net(cifs_net_ns(tcp_ses));
-		}
 		kfree(tcp_ses);
 	}
 	return ERR_PTR(rc);
@@ -3131,20 +3121,20 @@ generic_ip_connect(struct TCP_Server_Inf
 		socket = server->ssocket;
 	} else {
 		struct net *net = cifs_net_ns(server);
+		struct sock *sk;
 
-		rc = sock_create_kern(net, sfamily, SOCK_STREAM, IPPROTO_TCP, &server->ssocket);
+		rc = __sock_create(net, sfamily, SOCK_STREAM,
+				   IPPROTO_TCP, &server->ssocket, 1);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
-		/*
-		 * Grab netns reference for the socket.
-		 *
-		 * It'll be released here, on error, or in clean_demultiplex_info() upon server
-		 * teardown.
-		 */
-		get_net(net);
+		sk = server->ssocket->sk;
+		__netns_tracker_free(net, &sk->ns_tracker, false);
+		sk->sk_net_refcnt = 1;
+		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+		sock_inuse_add(net, 1);
 
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
@@ -3158,10 +3148,8 @@ generic_ip_connect(struct TCP_Server_Inf
 	}
 
 	rc = bind_socket(server);
-	if (rc < 0) {
-		put_net(cifs_net_ns(server));
+	if (rc < 0)
 		return rc;
-	}
 
 	/*
 	 * Eventually check for other socket options to change from
@@ -3198,7 +3186,6 @@ generic_ip_connect(struct TCP_Server_Inf
 	if (rc < 0) {
 		cifs_dbg(FYI, "Error %d connecting to server\n", rc);
 		trace_smb3_connect_err(server->hostname, server->conn_id, &server->dstaddr, rc);
-		put_net(cifs_net_ns(server));
 		sock_release(socket);
 		server->ssocket = NULL;
 		return rc;
@@ -3207,9 +3194,6 @@ generic_ip_connect(struct TCP_Server_Inf
 	if (sport == htons(RFC1001_PORT))
 		rc = ip_rfc1001_connect(server);
 
-	if (rc < 0)
-		put_net(cifs_net_ns(server));
-
 	return rc;
 }
 



