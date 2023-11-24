Return-Path: <stable+bounces-899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196167F7D0C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE99BB21535
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9434197;
	Fri, 24 Nov 2023 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qtZLnOqB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BA39FE9;
	Fri, 24 Nov 2023 18:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AD0C433C8;
	Fri, 24 Nov 2023 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850055;
	bh=jHkZKopmUPOHfPMmLj0GfUYSj7ZY/b+9OCdm82SK7ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtZLnOqBImzX6X1VRzKDiBk9P4Lo/sKFCpPap5UuTxh4sub+zlAuI1hQl4srZUafa
	 dyeG4ps3//oe8apzhh5xOc1ni9eSVrYSjQ0w1dVpjsj9J7TnR1/pBcddWMmC7eeTcw
	 +EtveICa1FIRJ8BvMqi9ixEaCmMgVUp28LqmKNkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 427/530] cifs: do not reset chan_max if multichannel is not supported at mount
Date: Fri, 24 Nov 2023 17:49:53 +0000
Message-ID: <20231124172041.070034151@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

commit 6e5e64c9477d58e73cb1a0e83eacad1f8df247cf upstream.

If the mount command has specified multichannel as a mount option,
but multichannel is found to be unsupported by the server at the time
of mount, we set chan_max to 1. Which means that the user needs to
remount the share if the server starts supporting multichannel.

This change removes this reset. What it means is that if the user
specified multichannel or max_channels during mount, and at this
time, multichannel is not supported, but the server starts supporting
it at a later point, the client will be capable of scaling out the
number of channels.

Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/sess.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -186,7 +186,6 @@ int cifs_try_adding_channels(struct cifs
 	}
 
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
-		ses->chan_max = 1;
 		spin_unlock(&ses->chan_lock);
 		cifs_server_dbg(VFS, "no multichannel support\n");
 		return 0;



