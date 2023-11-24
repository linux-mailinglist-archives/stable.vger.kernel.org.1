Return-Path: <stable+bounces-124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845677F7324
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A861E1C20D06
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E901F95A;
	Fri, 24 Nov 2023 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOHOz0Um"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9450200B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7780C433CA;
	Fri, 24 Nov 2023 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700826951;
	bh=Zu+zuyP4vDMJyXwIPgvQ+tjeFRIHtdScR9muRuxoGVA=;
	h=Subject:To:Cc:From:Date:From;
	b=IOHOz0UmMhV8Kydkwq9e+cAI/OlYyjALUrQgWlf9COOFipcM3bUI3d1X1300UsQaB
	 mGE6OhScI4i3hdTb67OkcJ52ijo/eEXbwGTIJ7S52nY94XuKaxfwZ56hGx93npjwxL
	 c9d/6nD64blc+rYOZ04tTnKjLC3lXRHxHQXAlgDI=
Subject: FAILED: patch "[PATCH] cifs: do not pass cifs_sb when trying to add channels" failed to apply to 6.5-stable tree
To: sprasad@microsoft.com,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:55:48 +0000
Message-ID: <2023112448-stage-undusted-f935@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 9599d59eb8fc0c0fd9480c4f22901533d08965ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112448-stage-undusted-f935@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

9599d59eb8fc ("cifs: do not pass cifs_sb when trying to add channels")
69a4e06c0e7b ("smb: client: reduce stack usage in cifs_try_adding_channels()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9599d59eb8fc0c0fd9480c4f22901533d08965ee Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Mon, 6 Nov 2023 16:22:11 +0000
Subject: [PATCH] cifs: do not pass cifs_sb when trying to add channels

The only reason why cifs_sb gets passed today to cifs_try_adding_channels
is to pass the local_nls field for the new channels and binding session.
However, the ses struct already has local_nls field that is setup during
the first cifs_setup_session. So there is no need to pass cifs_sb.

This change removes cifs_sb from the arg list for this and the functions
that it calls and uses ses->local_nls instead.

Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index c1f71c6be7e3..eed8dbb6b2fb 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -610,7 +610,7 @@ void cifs_free_hash(struct shash_desc **sdesc);
 
 struct cifs_chan *
 cifs_ses_find_chan(struct cifs_ses *ses, struct TCP_Server_Info *server);
-int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
+int cifs_try_adding_channels(struct cifs_ses *ses);
 bool is_server_using_iface(struct TCP_Server_Info *server,
 			   struct cifs_server_iface *iface);
 bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *iface);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 3ff82f0aa00e..947e3c362beb 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3564,7 +3564,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	ctx->prepath = NULL;
 
 out:
-	cifs_try_adding_channels(cifs_sb, mnt_ctx.ses);
+	cifs_try_adding_channels(mnt_ctx.ses);
 	rc = mount_setup_tlink(cifs_sb, mnt_ctx.ses, mnt_ctx.tcon);
 	if (rc)
 		goto error;
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index e716d046fb5f..fe45ccfdc802 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -24,7 +24,7 @@
 #include "fs_context.h"
 
 static int
-cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
+cifs_ses_add_channel(struct cifs_ses *ses,
 		     struct cifs_server_iface *iface);
 
 bool
@@ -172,7 +172,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
 }
 
 /* returns number of channels added */
-int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
+int cifs_try_adding_channels(struct cifs_ses *ses)
 {
 	struct TCP_Server_Info *server = ses->server;
 	int old_chan_count, new_chan_count;
@@ -255,7 +255,7 @@ int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
 			kref_get(&iface->refcount);
 
 			spin_unlock(&ses->iface_lock);
-			rc = cifs_ses_add_channel(cifs_sb, ses, iface);
+			rc = cifs_ses_add_channel(ses, iface);
 			spin_lock(&ses->iface_lock);
 
 			if (rc) {
@@ -458,7 +458,7 @@ cifs_ses_find_chan(struct cifs_ses *ses, struct TCP_Server_Info *server)
 }
 
 static int
-cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
+cifs_ses_add_channel(struct cifs_ses *ses,
 		     struct cifs_server_iface *iface)
 {
 	struct TCP_Server_Info *chan_server;
@@ -537,7 +537,7 @@ cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 	 * This will be used for encoding/decoding user/domain/pw
 	 * during sess setup auth.
 	 */
-	ctx->local_nls = cifs_sb->local_nls;
+	ctx->local_nls = ses->local_nls;
 
 	/* Use RDMA if possible */
 	ctx->rdma = iface->rdma_capable;
@@ -583,7 +583,7 @@ cifs_ses_add_channel(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 
 	rc = cifs_negotiate_protocol(xid, ses, chan->server);
 	if (!rc)
-		rc = cifs_setup_session(xid, ses, chan->server, cifs_sb->local_nls);
+		rc = cifs_setup_session(xid, ses, chan->server, ses->local_nls);
 
 	mutex_unlock(&ses->session_mutex);
 


