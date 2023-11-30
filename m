Return-Path: <stable+bounces-3349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12177FF535
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB51B20EB3
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A254F9C;
	Thu, 30 Nov 2023 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wosYh3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A054F8F;
	Thu, 30 Nov 2023 16:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFB0C433C8;
	Thu, 30 Nov 2023 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361607;
	bh=ALmLbIr387FD4rWyYbUlxQbVOOkauqdO3Z2jvE4QIpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0wosYh3vF0gMtrEisdSj80Q0VIzzqh8h8WdMauZpExBc96xz+xHraZnkldGEtOk2T
	 ksxnRioueUw2anEq0weJ9yMx/i7HLR89Xw2ivFamdx+VIKT4icgEu3aNhfIlyzL5Li
	 2yRU6VsxXZ6JztsBzaTWqOCxFdUOezkLz6eN1JKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/112] cifs: distribute channels across interfaces based on speed
Date: Thu, 30 Nov 2023 16:22:16 +0000
Message-ID: <20231130162143.162505927@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

[ Upstream commit a6d8fb54a515f0546ffdb7870102b1238917e567 ]

Today, if the server interfaces RSS capable, we simply
choose the fastest interface to setup a channel. This is not
a scalable approach, and does not make a lot of attempt to
distribute the connections.

This change does a weighted distribution of channels across
all the available server interfaces, where the weight is
a function of the advertised interface speed.

Also make sure that we don't mix rdma and non-rdma for channels.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: fa1d0508bdd4 ("cifs: account for primary channel in the interface list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_debug.c | 16 ++++++++
 fs/smb/client/cifsglob.h   |  2 +
 fs/smb/client/sess.c       | 84 +++++++++++++++++++++++++++++++-------
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 9a0ccd87468ea..16282ecfe17a7 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -279,6 +279,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
 	struct cifs_server_iface *iface;
+	size_t iface_weight = 0, iface_min_speed = 0;
+	struct cifs_server_iface *last_iface = NULL;
 	int c, i, j;
 
 	seq_puts(m,
@@ -542,11 +544,25 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 					   "\tLast updated: %lu seconds ago",
 					   ses->iface_count,
 					   (jiffies - ses->iface_last_update) / HZ);
+
+			last_iface = list_last_entry(&ses->iface_list,
+						     struct cifs_server_iface,
+						     iface_head);
+			iface_min_speed = last_iface->speed;
+
 			j = 0;
 			list_for_each_entry(iface, &ses->iface_list,
 						 iface_head) {
 				seq_printf(m, "\n\t%d)", ++j);
 				cifs_dump_iface(m, iface);
+
+				iface_weight = iface->speed / iface_min_speed;
+				seq_printf(m, "\t\tWeight (cur,total): (%zu,%zu)"
+					   "\n\t\tAllocated channels: %u\n",
+					   iface->weight_fulfilled,
+					   iface_weight,
+					   iface->num_channels);
+
 				if (is_ses_using_iface(ses, iface))
 					seq_puts(m, "\t\t[CONNECTED]\n");
 			}
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index e55f49e278a2e..b8d1c19f67714 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -969,6 +969,8 @@ struct cifs_server_iface {
 	struct list_head iface_head;
 	struct kref refcount;
 	size_t speed;
+	size_t weight_fulfilled;
+	unsigned int num_channels;
 	unsigned int rdma_capable : 1;
 	unsigned int rss_capable : 1;
 	unsigned int is_active : 1; /* unset if non existent */
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 61cc7c415491e..65545e65f1eb6 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -164,7 +164,9 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	int left;
 	int rc = 0;
 	int tries = 0;
+	size_t iface_weight = 0, iface_min_speed = 0;
 	struct cifs_server_iface *iface = NULL, *niface = NULL;
+	struct cifs_server_iface *last_iface = NULL;
 
 	spin_lock(&ses->chan_lock);
 
@@ -192,21 +194,11 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	/*
-	 * Keep connecting to same, fastest, iface for all channels as
-	 * long as its RSS. Try next fastest one if not RSS or channel
-	 * creation fails.
-	 */
-	spin_lock(&ses->iface_lock);
-	iface = list_first_entry(&ses->iface_list, struct cifs_server_iface,
-				 iface_head);
-	spin_unlock(&ses->iface_lock);
-
 	while (left > 0) {
 
 		tries++;
 		if (tries > 3*ses->chan_max) {
-			cifs_dbg(FYI, "too many channel open attempts (%d channels left to open)\n",
+			cifs_dbg(VFS, "too many channel open attempts (%d channels left to open)\n",
 				 left);
 			break;
 		}
@@ -214,17 +206,35 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		spin_lock(&ses->iface_lock);
 		if (!ses->iface_count) {
 			spin_unlock(&ses->iface_lock);
+			cifs_dbg(VFS, "server %s does not advertise interfaces\n",
+				      ses->server->hostname);
 			break;
 		}
 
+		if (!iface)
+			iface = list_first_entry(&ses->iface_list, struct cifs_server_iface,
+						 iface_head);
+		last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
+					     iface_head);
+		iface_min_speed = last_iface->speed;
+
 		list_for_each_entry_safe_from(iface, niface, &ses->iface_list,
 				    iface_head) {
+			/* do not mix rdma and non-rdma interfaces */
+			if (iface->rdma_capable != ses->server->rdma)
+				continue;
+
 			/* skip ifaces that are unusable */
 			if (!iface->is_active ||
 			    (is_ses_using_iface(ses, iface) &&
-			     !iface->rss_capable)) {
+			     !iface->rss_capable))
+				continue;
+
+			/* check if we already allocated enough channels */
+			iface_weight = iface->speed / iface_min_speed;
+
+			if (iface->weight_fulfilled >= iface_weight)
 				continue;
-			}
 
 			/* take ref before unlock */
 			kref_get(&iface->refcount);
@@ -241,10 +251,21 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 				continue;
 			}
 
-			cifs_dbg(FYI, "successfully opened new channel on iface:%pIS\n",
+			iface->num_channels++;
+			iface->weight_fulfilled++;
+			cifs_dbg(VFS, "successfully opened new channel on iface:%pIS\n",
 				 &iface->sockaddr);
 			break;
 		}
+
+		/* reached end of list. reset weight_fulfilled and start over */
+		if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
+			list_for_each_entry(iface, &ses->iface_list, iface_head)
+				iface->weight_fulfilled = 0;
+			spin_unlock(&ses->iface_lock);
+			iface = NULL;
+			continue;
+		}
 		spin_unlock(&ses->iface_lock);
 
 		left--;
@@ -263,8 +284,10 @@ int
 cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 {
 	unsigned int chan_index;
+	size_t iface_weight = 0, iface_min_speed = 0;
 	struct cifs_server_iface *iface = NULL;
 	struct cifs_server_iface *old_iface = NULL;
+	struct cifs_server_iface *last_iface = NULL;
 	int rc = 0;
 
 	spin_lock(&ses->chan_lock);
@@ -284,13 +307,34 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	spin_unlock(&ses->chan_lock);
 
 	spin_lock(&ses->iface_lock);
+	if (!ses->iface_count) {
+		spin_unlock(&ses->iface_lock);
+		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
+		return 0;
+	}
+
+	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
+				     iface_head);
+	iface_min_speed = last_iface->speed;
+
 	/* then look for a new one */
 	list_for_each_entry(iface, &ses->iface_list, iface_head) {
+		/* do not mix rdma and non-rdma interfaces */
+		if (iface->rdma_capable != server->rdma)
+			continue;
+
 		if (!iface->is_active ||
 		    (is_ses_using_iface(ses, iface) &&
 		     !iface->rss_capable)) {
 			continue;
 		}
+
+		/* check if we already allocated enough channels */
+		iface_weight = iface->speed / iface_min_speed;
+
+		if (iface->weight_fulfilled >= iface_weight)
+			continue;
+
 		kref_get(&iface->refcount);
 		break;
 	}
@@ -306,10 +350,22 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		cifs_dbg(FYI, "replacing iface: %pIS with %pIS\n",
 			 &old_iface->sockaddr,
 			 &iface->sockaddr);
+
+		old_iface->num_channels--;
+		if (old_iface->weight_fulfilled)
+			old_iface->weight_fulfilled--;
+		iface->num_channels++;
+		iface->weight_fulfilled++;
+
 		kref_put(&old_iface->refcount, release_iface);
 	} else if (old_iface) {
 		cifs_dbg(FYI, "releasing ref to iface: %pIS\n",
 			 &old_iface->sockaddr);
+
+		old_iface->num_channels--;
+		if (old_iface->weight_fulfilled)
+			old_iface->weight_fulfilled--;
+
 		kref_put(&old_iface->refcount, release_iface);
 	} else {
 		WARN_ON(!iface);
-- 
2.42.0




