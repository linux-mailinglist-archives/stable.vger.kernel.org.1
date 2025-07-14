Return-Path: <stable+bounces-161821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB671B03A4E
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BC6189C69E
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B623C518;
	Mon, 14 Jul 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vB3Vcde1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757352376EF
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483988; cv=none; b=ERfjUkmkcqIKm0+wIhWDagkaWIStMr0dVDnMSKNfkmRTa2PvzO++H+Y6O2PQJVI8SWJkjBb1zx7JDqa/WsG5DSDnmcm1MXzapquykZ7BZzKlsfKyetvpbpRM1HK3UnpnBH7Um+U12R8hCUn7apSDIWpazpeFQMCqPjL1Wu85PDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483988; c=relaxed/simple;
	bh=59pczhRIz4hXv0UvsGmtD+MzETX7CLs15QG6edInaY4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xe5nC9zlQCpJltxzZ6oPqG1iJP15b41X1FN37zllrathr3fYNU97Oeh6LwsZjqs6nHv+L18NnLJYpU+IycRdUs95JxtWvhNRR2gadHIgzZQRmP7yDrA9oKfXyMzTu75dnFEOtk+pRpYme0XAb513CG52sCUFLnFuhuyJcX29Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vB3Vcde1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2658C4CEF4;
	Mon, 14 Jul 2025 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752483988;
	bh=59pczhRIz4hXv0UvsGmtD+MzETX7CLs15QG6edInaY4=;
	h=Subject:To:Cc:From:Date:From;
	b=vB3Vcde1gWkltBtMJ+nsj0HpsMOkTMESlE7UsdqelH3CKJ1OX0borJQSWVLUShZpi
	 FfiHXOwyGJ49h7yNbudXMnKolZ8UjWOkmrvyc8/upBbQRXTszn83OzrO9x5oOjj3m7
	 N3ANfXt0rQminqIJ7TgRHCZZDLgqiC96xgdbYEBU=
Subject: FAILED: patch "[PATCH] ksmbd: fix a mount write count leak in" failed to apply to 5.15-stable tree
To: viro@zeniv.linux.org.uk,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Jul 2025 11:06:24 +0200
Message-ID: <2025071424-payroll-posh-4e3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 277627b431a0a6401635c416a21b2a0f77a77347
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071424-payroll-posh-4e3e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 277627b431a0a6401635c416a21b2a0f77a77347 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 6 Jul 2025 02:26:45 +0100
Subject: [PATCH] ksmbd: fix a mount write count leak in
 ksmbd_vfs_kern_path_locked()

If the call of ksmbd_vfs_lock_parent() fails, we drop the parent_path
references and return an error.  We need to drop the write access we
just got on parent_path->mnt before we drop the mount reference - callers
assume that ksmbd_vfs_kern_path_locked() returns with mount write
access grabbed if and only if it has returned 0.

Fixes: 864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 0f3aad12e495..d3437f6644e3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1282,6 +1282,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
 		if (err) {
+			mnt_drop_write(parent_path->mnt);
 			path_put(path);
 			path_put(parent_path);
 		}


