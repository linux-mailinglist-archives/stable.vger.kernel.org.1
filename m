Return-Path: <stable+bounces-1398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDC7F7F74
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211A6282550
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03433E9;
	Fri, 24 Nov 2023 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pkV0IRrS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAF381D4;
	Fri, 24 Nov 2023 18:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844BAC433C9;
	Fri, 24 Nov 2023 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851298;
	bh=Keg6QM6ocVnuX/ebAY0HvLRwKdZjDGHhmUHzOMHYGyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkV0IRrS8NwIOobAO4pwVZt7VaAw6sMzK4ghoaKd0Ekk8cBYYKi81vv8x+pm62bSN
	 xzCfP6nH5pCZBvR1gcm2pw28yRoFnIwhJFo0wIHcoOpeZ2XKIYFKkEvt7CfxdsxmF7
	 /HaUfv42cSYx2ZrONuO8OPnxiPICK2wSJIdOpbEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 393/491] cifs: reconnect helper should set reconnect for the right channel
Date: Fri, 24 Nov 2023 17:50:29 +0000
Message-ID: <20231124172036.413785221@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit c3326a61cdbf3ce1273d9198b6cbf90965d7e029 upstream.

We introduced a helper function to be used by non-cifsd threads to
mark the connection for reconnect. For multichannel, when only
a particular channel needs to be reconnected, this had a bug.

This change fixes that by marking that particular channel
for reconnect.

Fixes: dca65818c80c ("cifs: use a different reconnect helper for non-cifsd threads")
Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -156,13 +156,14 @@ cifs_signal_cifsd_for_reconnect(struct T
 	/* If server is a channel, select the primary channel */
 	pserver = CIFS_SERVER_IS_CHAN(server) ? server->primary_server : server;
 
-	spin_lock(&pserver->srv_lock);
+	/* if we need to signal just this channel */
 	if (!all_channels) {
-		pserver->tcpStatus = CifsNeedReconnect;
-		spin_unlock(&pserver->srv_lock);
+		spin_lock(&server->srv_lock);
+		if (server->tcpStatus != CifsExiting)
+			server->tcpStatus = CifsNeedReconnect;
+		spin_unlock(&server->srv_lock);
 		return;
 	}
-	spin_unlock(&pserver->srv_lock);
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {



