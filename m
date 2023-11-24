Return-Path: <stable+bounces-136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD27F7332
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FB5B210F6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C5200DA;
	Fri, 24 Nov 2023 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oohSfJJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12513200B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931A9C433C7;
	Fri, 24 Nov 2023 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700827009;
	bh=+8M9S6UZvEKwXaDnHGlLNySgu9Zs7CIBRoG6hpwAZj8=;
	h=Subject:To:Cc:From:Date:From;
	b=oohSfJJlJ6ea74TwBefqh9M3yNNTmUTEYqI/lC7FK0cdA4BQj/IMBkE8R+RyWhZoP
	 PSlcmzUFI5M1Sjah2ou6joekXXp74ex7JSo/qg0Ait6F1jRWqXdmF+NOg0dmS7zH2j
	 EG1mgC/FpniapBs4xf2pXuE0Gi+ro/e6KROvQlaI=
Subject: FAILED: patch "[PATCH] cifs: fix leak of iface for primary channel" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:56:34 +0000
Message-ID: <2023112434-hexagon-sector-8318@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 29954d5b1e0d67a4cd61c30c2201030c97e94b1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112434-hexagon-sector-8318@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

29954d5b1e0d ("cifs: fix leak of iface for primary channel")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29954d5b1e0d67a4cd61c30c2201030c97e94b1e Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Tue, 14 Nov 2023 04:54:12 +0000
Subject: [PATCH] cifs: fix leak of iface for primary channel

My last change in this area introduced a change which
accounted for primary channel in the interface ref count.
However, it did not reduce this ref count on deallocation
of the primary channel. i.e. during umount.

Fixing this leak here, by dropping this ref count for
primary channel while freeing up the session.

Fixes: fa1d0508bdd4 ("cifs: account for primary channel in the interface list")
Cc: stable@vger.kernel.org
Reported-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 57c2a7df3457..f896f60c924b 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2065,6 +2065,12 @@ void __cifs_put_smb_ses(struct cifs_ses *ses)
 		ses->chans[i].server = NULL;
 	}
 
+	/* we now account for primary channel in iface->refcount */
+	if (ses->chans[0].iface) {
+		kref_put(&ses->chans[0].iface->refcount, release_iface);
+		ses->chans[0].server = NULL;
+	}
+
 	sesInfoFree(ses);
 	cifs_put_tcp_session(server, 0);
 }


