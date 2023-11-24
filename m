Return-Path: <stable+bounces-133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E957F732E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77A51C20DAB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004CB20303;
	Fri, 24 Nov 2023 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WoQrqjnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835F200DA
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41018C433C7;
	Fri, 24 Nov 2023 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700827001;
	bh=UcBv/v1elHATxxz7zJxe5MMkNAW1HG3pMNz4YrSfhck=;
	h=Subject:To:Cc:From:Date:From;
	b=WoQrqjnNgDir4merOylf71aGAPtNDr6ft4lT8Uxb0CdogOy7GkQ19fJLJsAUOi75F
	 CunlDnhRWxdSaof8WPIfluCkPF8KV72QCC4yBisbpi0FfqwdPq8pGcsT2fwCbwkjl0
	 dYslXf0+uxjJTFKecGOqj01VEDVqyDORe4Z6UMUA=
Subject: FAILED: patch "[PATCH] cifs: account for primary channel in the interface list" failed to apply to 4.19-stable tree
To: sprasad@microsoft.com,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:56:26 +0000
Message-ID: <2023112425-basket-curling-bb37@gregkh>
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
git cherry-pick -x fa1d0508bdd4a68c5e40f85f635712af8c12f180
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112425-basket-curling-bb37@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

fa1d0508bdd4 ("cifs: account for primary channel in the interface list")
a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
05844bd661d9 ("cifs: print last update time for interface list")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
f391d6ee002e ("cifs: Use after free in debug code")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa1d0508bdd4a68c5e40f85f635712af8c12f180 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Tue, 14 Mar 2023 11:14:58 +0000
Subject: [PATCH] cifs: account for primary channel in the interface list

The refcounting of server interfaces should account
for the primary channel too. Although this is not
strictly necessary, doing so will account for the primary
channel in DebugData.

Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 336b64d93e41..e716d046fb5f 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -303,6 +303,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *iface = NULL;
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
+	struct sockaddr_storage ss;
 	int rc = 0;
 
 	spin_lock(&ses->chan_lock);
@@ -321,6 +322,10 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 	spin_unlock(&ses->chan_lock);
 
+	spin_lock(&server->srv_lock);
+	ss = server->dstaddr;
+	spin_unlock(&server->srv_lock);
+
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
@@ -334,6 +339,16 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
 	/* then look for a new one */
 	list_for_each_entry(iface, &ses->iface_list, iface_head) {
+		if (!chan_index) {
+			/* if we're trying to get the updated iface for primary channel */
+			if (!cifs_match_ipaddr((struct sockaddr *) &ss,
+					       (struct sockaddr *) &iface->sockaddr))
+				continue;
+
+			kref_get(&iface->refcount);
+			break;
+		}
+
 		/* do not mix rdma and non-rdma interfaces */
 		if (iface->rdma_capable != server->rdma)
 			continue;
@@ -360,6 +375,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}
 
+	if (!chan_index && !iface) {
+		cifs_dbg(FYI, "unable to get the interface matching: %pIS\n",
+			 &ss);
+		spin_unlock(&ses->iface_lock);
+		return 0;
+	}
+
 	/* now drop the ref to the current iface */
 	if (old_iface && iface) {
 		cifs_dbg(FYI, "replacing iface: %pIS with %pIS\n",
@@ -382,6 +404,12 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 			old_iface->weight_fulfilled--;
 
 		kref_put(&old_iface->refcount, release_iface);
+	} else if (!chan_index) {
+		/* special case: update interface for primary channel */
+		cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
+			 &iface->sockaddr);
+		iface->num_channels++;
+		iface->weight_fulfilled++;
 	} else {
 		WARN_ON(!iface);
 		cifs_dbg(FYI, "adding new iface: %pIS\n", &iface->sockaddr);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 601e7a187f87..a959ed2c9b22 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -756,6 +756,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
 	unsigned int ret_data_len = 0;
 	struct network_interface_info_ioctl_rsp *out_buf = NULL;
 	struct cifs_ses *ses = tcon->ses;
+	struct TCP_Server_Info *pserver;
 
 	/* do not query too frequently */
 	if (ses->iface_last_update &&
@@ -780,6 +781,11 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
 	if (rc)
 		goto out;
 
+	/* check if iface is still active */
+	pserver = ses->chans[0].server;
+	if (pserver && !cifs_chan_is_iface_active(ses, pserver))
+		cifs_chan_update_iface(ses, pserver);
+
 out:
 	kfree(out_buf);
 	return rc;


