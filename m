Return-Path: <stable+bounces-16985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E2840F55
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEACA283E2D
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB215DBA6;
	Mon, 29 Jan 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twi4hD1u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78715DBA3;
	Mon, 29 Jan 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548425; cv=none; b=HaMTHryVt6sUKOq+moPZnTvStdPfCuBE8cS7e4yPhut9G5RGJIfW5HVkPm+blwPoHgiiBsdd2MuknFLeIyg2DDkcerqBae9t/UX6b1p1cw8OEg0jcNW4wp4GGj1JqOcRsl9YMFpTr69RgjOni0iu9Rmhhe3/ytzwjjqlO5eF49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548425; c=relaxed/simple;
	bh=PEovLWOKy4kMooVNWNPP2mXGPtyHzQ7LTU7If9lRAEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc7GoHucAK55eYUOsfMjvQLTQX8OMwDnpKT5nmmXGk5wD1McWT4V0URkoZqBCICGdGp+mBcbiZmmSHmReQ3ldb4Uf8i8MuucNI63d3+X6LfSa+1qkyB8L8vFBVY3V6Xy0UbtoaLIFiCNzxSwb3bpE1qKtNEMkG/x/GaVVov7LeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twi4hD1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7061C433F1;
	Mon, 29 Jan 2024 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548424;
	bh=PEovLWOKy4kMooVNWNPP2mXGPtyHzQ7LTU7If9lRAEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twi4hD1uuJUPczz/qaLRwoyIhpqTlPXUHcIT5WB/LQd2+Qc0whFb/PjbPCVFTfCiM
	 CHnjvL2//ATLy1oHFJq8ZBkMLN7b/texjpbtqzkIAaY71/5FroMf9kK7VCU+V6JhnA
	 r665hx/IamQiJw2Lu91tjXaQ/7561LeB33itTGmw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/331] cifs: handle when server stops supporting multichannel
Date: Mon, 29 Jan 2024 09:01:28 -0800
Message-ID: <20240129170015.658373408@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit ee1d21794e55ab76505745d24101331552182002 ]

When a server stops supporting multichannel, we will
keep attempting reconnects to the secondary channels today.
Avoid this by freeing extra channels when negotiate
returns no multichannel support.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 78e727e58e54 ("cifs: update iface_last_update on each query-and-update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifsproto.h |  2 ++
 fs/smb/client/connect.c   | 10 ++++++
 fs/smb/client/sess.c      | 64 ++++++++++++++++++++++++++++-----
 fs/smb/client/smb2pdu.c   | 76 ++++++++++++++++++++++++++++++++++++++-
 fs/smb/client/transport.c |  2 +-
 6 files changed, 145 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index e3ef8eee68d1..5e32c79f03a7 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -659,6 +659,7 @@ struct TCP_Server_Info {
 	bool noautotune;		/* do not autotune send buf sizes */
 	bool nosharesock;
 	bool tcp_nodelay;
+	bool terminate;
 	unsigned int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 4a28cff87038..c00f84420559 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -647,6 +647,8 @@ cifs_chan_needs_reconnect(struct cifs_ses *ses,
 bool
 cifs_chan_is_iface_active(struct cifs_ses *ses,
 			  struct TCP_Server_Info *server);
+void
+cifs_disable_secondary_channels(struct cifs_ses *ses);
 int
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c0b1f30eecd7..f43f51f2d1c1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -215,6 +215,14 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
+		/*
+		 * if channel has been marked for termination, nothing to do
+		 * for the channel. in fact, we cannot find the channel for the
+		 * server. So safe to exit here
+		 */
+		if (server->terminate)
+			break;
+
 		/* check if iface is still active */
 		spin_lock(&ses->chan_lock);
 		if (!cifs_chan_is_iface_active(ses, server)) {
@@ -252,6 +260,8 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 			spin_lock(&tcon->tc_lock);
 			tcon->status = TID_NEED_RECON;
 			spin_unlock(&tcon->tc_lock);
+
+			cancel_delayed_work(&tcon->query_interfaces);
 		}
 		if (ses->tcon_ipc) {
 			ses->tcon_ipc->need_reconnect = true;
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 650a3ec9e6e5..2ce1b7571371 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -290,6 +290,60 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	return new_chan_count - old_chan_count;
 }
 
+/*
+ * called when multichannel is disabled by the server.
+ * this always gets called from smb2_reconnect
+ * and cannot get called in parallel threads.
+ */
+void
+cifs_disable_secondary_channels(struct cifs_ses *ses)
+{
+	int i, chan_count;
+	struct TCP_Server_Info *server;
+	struct cifs_server_iface *iface;
+
+	spin_lock(&ses->chan_lock);
+	chan_count = ses->chan_count;
+	if (chan_count == 1)
+		goto done;
+
+	ses->chan_count = 1;
+
+	/* for all secondary channels reset the need reconnect bit */
+	ses->chans_need_reconnect &= 1;
+
+	for (i = 1; i < chan_count; i++) {
+		iface = ses->chans[i].iface;
+		server = ses->chans[i].server;
+
+		if (iface) {
+			spin_lock(&ses->iface_lock);
+			kref_put(&iface->refcount, release_iface);
+			ses->chans[i].iface = NULL;
+			iface->num_channels--;
+			if (iface->weight_fulfilled)
+				iface->weight_fulfilled--;
+			spin_unlock(&ses->iface_lock);
+		}
+
+		spin_unlock(&ses->chan_lock);
+		if (server && !server->terminate) {
+			server->terminate = true;
+			cifs_signal_cifsd_for_reconnect(server, false);
+		}
+		spin_lock(&ses->chan_lock);
+
+		if (server) {
+			ses->chans[i].server = NULL;
+			cifs_put_tcp_session(server, false);
+		}
+
+	}
+
+done:
+	spin_unlock(&ses->chan_lock);
+}
+
 /*
  * update the iface for the channel if necessary.
  * will return 0 when iface is updated, 1 if removed, 2 otherwise
@@ -589,14 +643,10 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 
 out:
 	if (rc && chan->server) {
-		/*
-		 * we should avoid race with these delayed works before we
-		 * remove this channel
-		 */
-		cancel_delayed_work_sync(&chan->server->echo);
-		cancel_delayed_work_sync(&chan->server->reconnect);
+		cifs_put_tcp_session(chan->server, 0);
 
 		spin_lock(&ses->chan_lock);
+
 		/* we rely on all bits beyond chan_count to be clear */
 		cifs_chan_clear_need_reconnect(ses, chan->server);
 		ses->chan_count--;
@@ -606,8 +656,6 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 		 */
 		WARN_ON(ses->chan_count < 1);
 		spin_unlock(&ses->chan_lock);
-
-		cifs_put_tcp_session(chan->server, 0);
 	}
 
 	kfree(ctx->UNC);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 288f22050c20..f1977987ae74 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -164,6 +164,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	struct nls_table *nls_codepage = NULL;
 	struct cifs_ses *ses;
 	int xid;
+	struct TCP_Server_Info *pserver;
+	unsigned int chan_index;
 
 	/*
 	 * SMB2s NegProt, SessSetup, Logoff do not have tcon yet so
@@ -224,6 +226,12 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 			return -EAGAIN;
 		}
 	}
+
+	/* if server is marked for termination, cifsd will cleanup */
+	if (server->terminate) {
+		spin_unlock(&server->srv_lock);
+		return -EHOSTDOWN;
+	}
 	spin_unlock(&server->srv_lock);
 
 again:
@@ -242,12 +250,24 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		 tcon->need_reconnect);
 
 	mutex_lock(&ses->session_mutex);
+	/*
+	 * if this is called by delayed work, and the channel has been disabled
+	 * in parallel, the delayed work can continue to execute in parallel
+	 * there's a chance that this channel may not exist anymore
+	 */
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsExiting) {
+		spin_unlock(&server->srv_lock);
+		mutex_unlock(&ses->session_mutex);
+		rc = -EHOSTDOWN;
+		goto out;
+	}
+
 	/*
 	 * Recheck after acquire mutex. If another thread is negotiating
 	 * and the server never sends an answer the socket will be closed
 	 * and tcpStatus set to reconnect.
 	 */
-	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsNeedReconnect) {
 		spin_unlock(&server->srv_lock);
 		mutex_unlock(&ses->session_mutex);
@@ -284,6 +304,53 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	rc = cifs_negotiate_protocol(0, ses, server);
 	if (!rc) {
+		/*
+		 * if server stopped supporting multichannel
+		 * and the first channel reconnected, disable all the others.
+		 */
+		if (ses->chan_count > 1 &&
+		    !(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
+			if (SERVER_IS_CHAN(server)) {
+				cifs_dbg(VFS, "server %s does not support " \
+					 "multichannel anymore. skipping secondary channel\n",
+					 ses->server->hostname);
+
+				spin_lock(&ses->chan_lock);
+				chan_index = cifs_ses_get_chan_index(ses, server);
+				if (chan_index == CIFS_INVAL_CHAN_INDEX) {
+					spin_unlock(&ses->chan_lock);
+					goto skip_terminate;
+				}
+
+				ses->chans[chan_index].server = NULL;
+				spin_unlock(&ses->chan_lock);
+
+				/*
+				 * the above reference of server by channel
+				 * needs to be dropped without holding chan_lock
+				 * as cifs_put_tcp_session takes a higher lock
+				 * i.e. cifs_tcp_ses_lock
+				 */
+				cifs_put_tcp_session(server, 1);
+
+				server->terminate = true;
+				cifs_signal_cifsd_for_reconnect(server, false);
+
+				/* mark primary server as needing reconnect */
+				pserver = server->primary_server;
+				cifs_signal_cifsd_for_reconnect(pserver, false);
+
+skip_terminate:
+				mutex_unlock(&ses->session_mutex);
+				rc = -EHOSTDOWN;
+				goto out;
+			} else {
+				cifs_server_dbg(VFS, "does not support " \
+					 "multichannel anymore. disabling all other channels\n");
+				cifs_disable_secondary_channels(ses);
+			}
+		}
+
 		rc = cifs_setup_session(0, ses, server, nls_codepage);
 		if ((rc == -EACCES) && !tcon->retry) {
 			mutex_unlock(&ses->session_mutex);
@@ -3863,6 +3930,13 @@ void smb2_reconnect_server(struct work_struct *work)
 	/* Prevent simultaneous reconnects that can corrupt tcon->rlist list */
 	mutex_lock(&pserver->reconnect_mutex);
 
+	/* if the server is marked for termination, drop the ref count here */
+	if (server->terminate) {
+		cifs_put_tcp_session(server, true);
+		mutex_unlock(&pserver->reconnect_mutex);
+		return;
+	}
+
 	INIT_LIST_HEAD(&tmp_list);
 	INIT_LIST_HEAD(&tmp_ses_list);
 	cifs_dbg(FYI, "Reconnecting tcons and channels\n");
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index d553b7a54621..4f717ad7c21b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1023,7 +1023,7 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 	spin_lock(&ses->chan_lock);
 	for (i = 0; i < ses->chan_count; i++) {
 		server = ses->chans[i].server;
-		if (!server)
+		if (!server || server->terminate)
 			continue;
 
 		/*
-- 
2.43.0




