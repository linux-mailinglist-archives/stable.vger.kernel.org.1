Return-Path: <stable+bounces-36359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E289BCEA
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171621C2080C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC052F86;
	Mon,  8 Apr 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9OBtNQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE152F82
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571614; cv=none; b=WDtW6cCufFoZsNnbt4umIgCZNX7s9jaEr0FpoULH1sjmG/FJU6jnMBmiE0gVCOO46itTmMnGJX0DhydAu5++uljr20qnYikboFP7CFUTIOXijg3w5+qVjjeNEToDGMi36ZLaxzwdsYUYcrBBtK6u7q9Mg8QJq2wT3oZENsCBj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571614; c=relaxed/simple;
	bh=guYI6qHlVnHQUYQqQOy7S1wGpGNWxVXEvydsgBBYGZk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dbxq/yigmwLM2iD7m37/E8Yn2pieMAyfi2x3w5zajXasmudDbE2NbnA9iXvKGwxhZ+B8/QoJv07PE5U8dib4XuTlwKEkXgFW5T/IQj846NZif7ImXLF+MbsWc97Ouk2cA7s+zYSJ3+FrsC5pCdmCOTOk5DPTWC6NCtPjiIqK6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9OBtNQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA255C433F1;
	Mon,  8 Apr 2024 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571614;
	bh=guYI6qHlVnHQUYQqQOy7S1wGpGNWxVXEvydsgBBYGZk=;
	h=Subject:To:Cc:From:Date:From;
	b=k9OBtNQ57Z3MDI5HVr1A5+lvqkOVJ0VXJY32twyqUgJDPCB1Esaj4VHixew4QleJP
	 m5P/SS00OND5lyrcQtnquJpAaDNQdB4muC0lrGXXl7pFEtYi4hTBbKBEnC1DNrsnYQ
	 TJdPDoC0grJ2HOA30tCQldkl/U5ZGuvc8esvo4nU=
Subject: FAILED: patch "[PATCH] smb: client: refresh referral without acquiring refpath_lock" failed to apply to 6.6-stable tree
To: pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:20:11 +0200
Message-ID: <2024040810-corporate-splinter-3a5f@gregkh>
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
git cherry-pick -x 0a05ad21d77a188d06481c36d6016805a881bcc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040810-corporate-splinter-3a5f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0a05ad21d77a ("smb: client: refresh referral without acquiring refpath_lock")
062a7f0ff46e ("smb: client: guarantee refcounted children from parent session")
d8392c203e84 ("smb3: show beginning time for per share stats")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a05ad21d77a188d06481c36d6016805a881bcc0 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Mon, 1 Apr 2024 22:44:07 -0300
Subject: [PATCH] smb: client: refresh referral without acquiring refpath_lock

Avoid refreshing DFS referral with refpath_lock acquired as the I/O
could block for a while due to a potentially disconnected or slow DFS
root server and then making other threads - that use same @server and
don't require a DFS root server - unable to make any progress.

Cc: stable@vger.kernel.org # 6.4+
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 0552a864ff08..11c8efecf7aa 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -1172,8 +1172,8 @@ static bool is_ses_good(struct cifs_ses *ses)
 	return ret;
 }
 
-/* Refresh dfs referral of tcon and mark it for reconnect if needed */
-static int __refresh_tcon(const char *path, struct cifs_ses *ses, bool force_refresh)
+/* Refresh dfs referral of @ses and mark it for reconnect if needed */
+static void __refresh_ses_referral(struct cifs_ses *ses, bool force_refresh)
 {
 	struct TCP_Server_Info *server = ses->server;
 	DFS_CACHE_TGT_LIST(old_tl);
@@ -1181,10 +1181,21 @@ static int __refresh_tcon(const char *path, struct cifs_ses *ses, bool force_ref
 	bool needs_refresh = false;
 	struct cache_entry *ce;
 	unsigned int xid;
+	char *path = NULL;
 	int rc = 0;
 
 	xid = get_xid();
 
+	mutex_lock(&server->refpath_lock);
+	if (server->leaf_fullpath) {
+		path = kstrdup(server->leaf_fullpath + 1, GFP_ATOMIC);
+		if (!path)
+			rc = -ENOMEM;
+	}
+	mutex_unlock(&server->refpath_lock);
+	if (!path)
+		goto out;
+
 	down_read(&htable_rw_lock);
 	ce = lookup_cache_entry(path);
 	needs_refresh = force_refresh || IS_ERR(ce) || cache_entry_expired(ce);
@@ -1218,19 +1229,17 @@ static int __refresh_tcon(const char *path, struct cifs_ses *ses, bool force_ref
 	free_xid(xid);
 	dfs_cache_free_tgts(&old_tl);
 	dfs_cache_free_tgts(&new_tl);
-	return rc;
+	kfree(path);
 }
 
-static int refresh_tcon(struct cifs_tcon *tcon, bool force_refresh)
+static inline void refresh_ses_referral(struct cifs_ses *ses)
 {
-	struct TCP_Server_Info *server = tcon->ses->server;
-	struct cifs_ses *ses = tcon->ses;
+	__refresh_ses_referral(ses, false);
+}
 
-	mutex_lock(&server->refpath_lock);
-	if (server->leaf_fullpath)
-		__refresh_tcon(server->leaf_fullpath + 1, ses, force_refresh);
-	mutex_unlock(&server->refpath_lock);
-	return 0;
+static inline void force_refresh_ses_referral(struct cifs_ses *ses)
+{
+	__refresh_ses_referral(ses, true);
 }
 
 /**
@@ -1271,25 +1280,20 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 	 */
 	cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
 
-	return refresh_tcon(tcon, true);
+	force_refresh_ses_referral(tcon->ses);
+	return 0;
 }
 
 /* Refresh all DFS referrals related to DFS tcon */
 void dfs_cache_refresh(struct work_struct *work)
 {
-	struct TCP_Server_Info *server;
 	struct cifs_tcon *tcon;
 	struct cifs_ses *ses;
 
 	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
 
-	for (ses = tcon->ses; ses; ses = ses->dfs_root_ses) {
-		server = ses->server;
-		mutex_lock(&server->refpath_lock);
-		if (server->leaf_fullpath)
-			__refresh_tcon(server->leaf_fullpath + 1, ses, false);
-		mutex_unlock(&server->refpath_lock);
-	}
+	for (ses = tcon->ses; ses; ses = ses->dfs_root_ses)
+		refresh_ses_referral(ses);
 
 	queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
 			   atomic_read(&dfs_cache_ttl) * HZ);


