Return-Path: <stable+bounces-3409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1237FF57D
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395251F20F49
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1554FA6;
	Thu, 30 Nov 2023 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqvAtBC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94354BFB;
	Thu, 30 Nov 2023 16:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF88C433C7;
	Thu, 30 Nov 2023 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361759;
	bh=7BjuZ7i+uy/NaLtd+jOOPW/XVrrF20uZiAI+bbEsXow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqvAtBC/4qDmtAz76ImGv7yin6grextGrMqFLgSAlFAt9tIdUhfmIpuHEAbjL7yBI
	 s/eZpC4t6JMtwVsNrewxxwbGviWWL0YZpaADPWzktsuWGHKMWIJ5Hm9eBeHgZAhX9F
	 K3tpOAmfLsGHgki+EKjl4R7Bj0W6VGRA3oq+oEEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 36/82] cifs: account for primary channel in the interface list
Date: Thu, 30 Nov 2023 16:22:07 +0000
Message-ID: <20231130162137.100409651@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit fa1d0508bdd4a68c5e40f85f635712af8c12f180 ]

The refcounting of server interfaces should account
for the primary channel too. Although this is not
strictly necessary, doing so will account for the primary
channel in DebugData.

Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c    | 28 ++++++++++++++++++++++++++++
 fs/smb/client/smb2ops.c |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 33e724545c5b4..634035bcb9347 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -288,6 +288,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *iface = NULL;
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
+	struct sockaddr_storage ss;
 	int rc = 0;
 
 	spin_lock(&ses->chan_lock);
@@ -306,6 +307,10 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 	spin_unlock(&ses->chan_lock);
 
+	spin_lock(&server->srv_lock);
+	ss = server->dstaddr;
+	spin_unlock(&server->srv_lock);
+
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
@@ -319,6 +324,16 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
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
@@ -345,6 +360,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
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
@@ -367,6 +389,12 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
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
index 2c1898803279a..4cc56e4695fbc 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -752,6 +752,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
 	unsigned int ret_data_len = 0;
 	struct network_interface_info_ioctl_rsp *out_buf = NULL;
 	struct cifs_ses *ses = tcon->ses;
+	struct TCP_Server_Info *pserver;
 
 	/* do not query too frequently */
 	if (ses->iface_last_update &&
@@ -776,6 +777,11 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_
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
-- 
2.42.0




