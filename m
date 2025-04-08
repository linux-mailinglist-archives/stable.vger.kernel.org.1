Return-Path: <stable+bounces-129735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E49A80137
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E783BB593
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12498268FE7;
	Tue,  8 Apr 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U7SUTN+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432022424C;
	Tue,  8 Apr 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111839; cv=none; b=sCQ05vN8/jZeK2e340+FO+aeDlNgRpzTeSs5S36AfjplsV76nZoa56g2azUeTx30jsNf1jzIKdUqq53vvHj2o4lIICog/TGUToCqsIXrFXMNM8HG5MsA36/vNMDFw79EnIw0hlde37s5wAApoJQzT3r7+aHUMo3CR5euYDc8bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111839; c=relaxed/simple;
	bh=kqyQxIXFhoxFsuwXfOp+/RKd7GaHvbIHQ7M3uAVYT2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ3UOE4YlBLEU+0TChdzQDmL7UwHL8slkH80MmJtqDAM+T9J/JUoj6Uesr+bJCDYWNbStQDh6pTYT6CKp4Oh2clOAM0dT68pILLecofichRbv39arygobXHYINkWyQ3G0uks98+qRbL+rPq5QvWeujHj8CRyuBaaj2bDhyE/x80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U7SUTN+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2183AC4CEE5;
	Tue,  8 Apr 2025 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111839;
	bh=kqyQxIXFhoxFsuwXfOp+/RKd7GaHvbIHQ7M3uAVYT2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7SUTN+Mm4PRmTEs9WIjRRgLyNseRGrT6FUnVfvulgaQODP2DJ73Wqz4pUDaa7IhJ
	 c5T4wRUVEeKDN7v1i1yRzFn669pjNNeBUV1drLCdl/AX8hNupFlXcTx9/BJSlVZkGy
	 oFzLZEIyt0qfsIgbDoH4Q+5UiPJScmPXod3h6OGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Zhaolong <wangzhaolong1@huawei.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 552/731] smb: client: Fix netns refcount imbalance causing leaks and use-after-free
Date: Tue,  8 Apr 2025 12:47:29 +0200
Message-ID: <20250408104927.116328955@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Zhaolong <wangzhaolong1@huawei.com>

[ Upstream commit 4e7f1644f2ac6d01dc584f6301c3b1d5aac4eaef ]

Commit ef7134c7fc48 ("smb: client: Fix use-after-free of network
namespace.") attempted to fix a netns use-after-free issue by manually
adjusting reference counts via sk->sk_net_refcnt and sock_inuse_add().

However, a later commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock
after rmmod") pointed out that the approach of manually setting
sk->sk_net_refcnt in the first commit was technically incorrect, as
sk->sk_net_refcnt should only be set for user sockets. It led to issues
like TCP timers not being cleared properly on close. The second commit
moved to a model of just holding an extra netns reference for
server->ssocket using get_net(), and dropping it when the server is torn
down.

But there remain some gaps in the get_net()/put_net() balancing added by
these commits. The incomplete reference handling in these fixes results
in two issues:

1. Netns refcount leaks[1]

The problem process is as follows:

```
mount.cifs                        cifsd

cifs_do_mount
  cifs_mount
    cifs_mount_get_session
      cifs_get_tcp_session
        get_net()  /* First get net. */
        ip_connect
          generic_ip_connect /* Try port 445 */
            get_net()
            ->connect() /* Failed */
            put_net()
          generic_ip_connect /* Try port 139 */
            get_net() /* Missing matching put_net() for this get_net().*/
      cifs_get_smb_ses
        cifs_negotiate_protocol
          smb2_negotiate
            SMB2_negotiate
              cifs_send_recv
                wait_for_response
                                 cifs_demultiplex_thread
                                   cifs_read_from_socket
                                     cifs_readv_from_socket
                                       cifs_reconnect
                                         cifs_abort_connection
                                           sock_release();
                                           server->ssocket = NULL;
                                           /* Missing put_net() here. */
                                           generic_ip_connect
                                             get_net()
                                             ->connect() /* Failed */
                                             put_net()
                                             sock_release();
                                             server->ssocket = NULL;
          free_rsp_buf
    ...
                                   clean_demultiplex_info
                                     /* It's only called once here. */
                                     put_net()
```

When cifs_reconnect() is triggered, the server->ssocket is released
without a corresponding put_net() for the reference acquired in
generic_ip_connect() before. it ends up calling generic_ip_connect()
again to retry get_net(). After that, server->ssocket is set to NULL
in the error path of generic_ip_connect(), and the net count cannot be
released in the final clean_demultiplex_info() function.

2. Potential use-after-free

The current refcounting scheme can lead to a potential use-after-free issue
in the following scenario:

```
 cifs_do_mount
   cifs_mount
     cifs_mount_get_session
       cifs_get_tcp_session
         get_net()  /* First get net */
           ip_connect
             generic_ip_connect
               get_net()
               bind_socket
	         kernel_bind /* failed */
               put_net()
         /* after out_err_crypto_release label */
         put_net()
         /* after out_err label */
         put_net()
```

In the exception handling process where binding the socket fails, the
get_net() and put_net() calls are unbalanced, which may cause the
server->net reference count to drop to zero and be prematurely released.

To address both issues, this patch ties the netns reference counting to
the server->ssocket and server lifecycles. The extra reference is now
acquired when the server or socket is created, and released when the
socket is destroyed or the server is torn down.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=219792

Fixes: ef7134c7fc48 ("smb: client: Fix use-after-free of network namespace.")
Fixes: e9f2517a3e18 ("smb: client: fix TCP timers deadlock after rmmod")
Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 73f93a35eeddb..cb14a6828c501 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -300,6 +300,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 			 server->ssocket->flags);
 		sock_release(server->ssocket);
 		server->ssocket = NULL;
+		put_net(cifs_net_ns(server));
 	}
 	server->sequence_number = 0;
 	server->session_estab = false;
@@ -3123,8 +3124,12 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		/*
 		 * Grab netns reference for the socket.
 		 *
-		 * It'll be released here, on error, or in clean_demultiplex_info() upon server
-		 * teardown.
+		 * This reference will be released in several situations:
+		 * - In the failure path before the cifsd thread is started.
+		 * - In the all place where server->socket is released, it is
+		 *   also set to NULL.
+		 * - Ultimately in clean_demultiplex_info(), during the final
+		 *   teardown.
 		 */
 		get_net(net);
 
@@ -3140,10 +3145,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	}
 
 	rc = bind_socket(server);
-	if (rc < 0) {
-		put_net(cifs_net_ns(server));
+	if (rc < 0)
 		return rc;
-	}
 
 	/*
 	 * Eventually check for other socket options to change from
@@ -3189,9 +3192,6 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (sport == htons(RFC1001_PORT))
 		rc = ip_rfc1001_connect(server);
 
-	if (rc < 0)
-		put_net(cifs_net_ns(server));
-
 	return rc;
 }
 
-- 
2.39.5




