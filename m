Return-Path: <stable+bounces-160512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E3EAFCF19
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA13E5818F4
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947A2E540A;
	Tue,  8 Jul 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="do6yXHnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A22BE042
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988184; cv=none; b=YIJSf7A33/iBkCT6umgsq8YkOjl0AiYu5CdTsAhbVzKn33VCu5rtWRP5eHaFrRGVMiMZvDVXXf9xY34o3xrKDNklYtezPLSKkxNL1zOcogJFMSRZqC9THhZcV8QAn2Wq8j/nrWeZq0fjgm3muHePTQbiubymv5dNB8icoqUprXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988184; c=relaxed/simple;
	bh=sN2V4A4EXoxQSGo/+8tPa1ZlCiI7z419q41WbjwPi9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UCZOVsY73S62T/1jIpVK7CA6Z3jweWwkN6B7Fv0aDto6p8Kp7m3VvzNQRYmqJOqlJSKnNdbQoTmSx2Rae93PT9W7Hwb4eUwUce/oQso11vxHdSCTe8rSlp6RLEjDae30JnQX+4AwjDDlUXWiSnoAQ5tlZhXEGMZV7SQxFgbObnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=do6yXHnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2510C4CEED;
	Tue,  8 Jul 2025 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751988184;
	bh=sN2V4A4EXoxQSGo/+8tPa1ZlCiI7z419q41WbjwPi9o=;
	h=Subject:To:Cc:From:Date:From;
	b=do6yXHnx9NIn0nuLgdIDZ1Q55rXNSi3qVlwroAsIjked5m/xZbI0IwaSUR5o0JRSo
	 bvVxwyWAazhQzN0MVw1C52lRgWEhPVy89gUl5BqxVIhdLr42QFki/EtF59OLsj2Sa2
	 rQy3Jkz252yBHsxxfIk6l+uxzM25MaYsggcKijEg=
Subject: FAILED: patch "[PATCH] cifs: all initializations for tcon should happen in" failed to apply to 6.6-stable tree
To: sprasad@microsoft.com,pc@manguebit.org,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:23:01 +0200
Message-ID: <2025070801-extended-myspace-c081@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 74ebd02163fde05baa23129e06dde4b8f0f2377a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070801-extended-myspace-c081@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74ebd02163fde05baa23129e06dde4b8f0f2377a Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Mon, 30 Jun 2025 23:09:34 +0530
Subject: [PATCH] cifs: all initializations for tcon should happen in
 tcon_info_alloc

Today, a few work structs inside tcon are initialized inside
cifs_get_tcon and not in tcon_info_alloc. As a result, if a tcon
is obtained from tcon_info_alloc, but not called as a part of
cifs_get_tcon, we may trip over.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 66093fa78aed..045227ed4efc 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -136,6 +136,7 @@ extern int SendReceiveBlockingLock(const unsigned int xid,
 			struct smb_hdr *out_buf,
 			int *bytes_returned);
 
+void smb2_query_server_interfaces(struct work_struct *work);
 void
 cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 				      bool all_channels);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 685c65dcb8c4..484b677143fd 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -97,7 +97,7 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	return rc;
 }
 
-static void smb2_query_server_interfaces(struct work_struct *work)
+void smb2_query_server_interfaces(struct work_struct *work)
 {
 	int rc;
 	int xid;
@@ -2880,20 +2880,14 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->max_cached_dirs = ctx->max_cached_dirs;
 	tcon->nodelete = ctx->nodelete;
 	tcon->local_lease = ctx->local_lease;
-	INIT_LIST_HEAD(&tcon->pending_opens);
 	tcon->status = TID_GOOD;
 
-	INIT_DELAYED_WORK(&tcon->query_interfaces,
-			  smb2_query_server_interfaces);
 	if (ses->server->dialect >= SMB30_PROT_ID &&
 	    (ses->server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
 		/* schedule query interfaces poll */
 		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
 				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 	}
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	INIT_DELAYED_WORK(&tcon->dfs_cache_work, dfs_cache_refresh);
-#endif
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcon->tcon_list, &ses->tcon_list);
 	spin_unlock(&cifs_tcp_ses_lock);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index e77017f47084..da23cc12a52c 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -151,6 +151,12 @@ tcon_info_alloc(bool dir_leases_enabled, enum smb3_tcon_ref_trace trace)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
 #endif
+	INIT_LIST_HEAD(&ret_buf->pending_opens);
+	INIT_DELAYED_WORK(&ret_buf->query_interfaces,
+			  smb2_query_server_interfaces);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_DELAYED_WORK(&ret_buf->dfs_cache_work, dfs_cache_refresh);
+#endif
 
 	return ret_buf;
 }


