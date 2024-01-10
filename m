Return-Path: <stable+bounces-10196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB38273A6
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3858281761
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FB64C602;
	Mon,  8 Jan 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qg3fqjEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B534121D;
	Mon,  8 Jan 2024 15:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C951C433CD;
	Mon,  8 Jan 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728288;
	bh=d6xaQmyUMhGtgjg8Uq7KF5eYxkU4hknwRGo4ahDEUeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg3fqjENcB0//10e4/lX0RbyT8T75Mv18oEHzyJtbKC6O7KaNQ/4/lceaHJA19zZI
	 UKCKsV8DfKfPUCMI84hm4axHLdwnirWn739nifWWwxoLf9HTQNT6+MvGDQoc28jbh5
	 FtGy80JCyVZFkNZHxv99cjvwRy5TkU8TH0Yy1oEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 009/150] cifs: cifs_chan_is_iface_active should be called with chan_lock held
Date: Mon,  8 Jan 2024 16:34:20 +0100
Message-ID: <20240108153511.668920042@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

commit 7257bcf3bdc785eabc4eef1f329a59815b032508 upstream.

cifs_chan_is_iface_active checks the channels of a session to see
if the associated iface is active. This should always happen
with chan_lock held. However, these two callers of this function
were missing this locking.

This change makes sure the function calls are protected with
proper locking.

Fixes: b54034a73baf ("cifs: during reconnect, update interface if necessary")
Fixes: fa1d0508bdd4 ("cifs: account for primary channel in the interface list")
Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    7 +++++--
 fs/smb/client/smb2ops.c |    7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -258,10 +258,13 @@ cifs_mark_tcp_ses_conns_for_reconnect(st
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
 		/* check if iface is still active */
-		if (!cifs_chan_is_iface_active(ses, server))
+		spin_lock(&ses->chan_lock);
+		if (!cifs_chan_is_iface_active(ses, server)) {
+			spin_unlock(&ses->chan_lock);
 			cifs_chan_update_iface(ses, server);
+			spin_lock(&ses->chan_lock);
+		}
 
-		spin_lock(&ses->chan_lock);
 		if (!mark_smb_session && cifs_chan_needs_reconnect(ses, server)) {
 			spin_unlock(&ses->chan_lock);
 			continue;
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -778,9 +778,14 @@ SMB3_request_interfaces(const unsigned i
 		goto out;
 
 	/* check if iface is still active */
+	spin_lock(&ses->chan_lock);
 	pserver = ses->chans[0].server;
-	if (pserver && !cifs_chan_is_iface_active(ses, pserver))
+	if (pserver && !cifs_chan_is_iface_active(ses, pserver)) {
+		spin_unlock(&ses->chan_lock);
 		cifs_chan_update_iface(ses, pserver);
+		spin_lock(&ses->chan_lock);
+	}
+	spin_unlock(&ses->chan_lock);
 
 out:
 	kfree(out_buf);



