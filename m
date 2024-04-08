Return-Path: <stable+bounces-36951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E238E89C2BA
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52870B29926
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D77CF3E;
	Mon,  8 Apr 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqeTAEks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A57CF29;
	Mon,  8 Apr 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582819; cv=none; b=PMiRWcPUeV8RYK0UEjfzTibwbVvPFOuuk4WPoOIFlQgUJg9ZXhVvqs+giB0O0lAoh40V9sJ5lyvoPwYanEkc3lIVTW+Y2YM/zVgWe+YjZyipP+C26Y7f8VfCtddNxjDkbOlkJqkVzr5RvcQar0dDosxxp3izXcXOnERGCoH+b9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582819; c=relaxed/simple;
	bh=JnYKibvqKlRk8W4kl05t2HWcTsiZNZauwN57XoWOaRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHFfdNkaJV8vSaLTnFKd1qwXNcnPaNEECWjaN6tFA8K+y6wTpU1JzhutFhS3WLeBfYl/KQT2de1nNQf8SlDW8HopB73Lrwov8SRHNYdPOA0Ln1S8ck3Sc8fRdUoHB6KPfC/6q6D5slCy39LmSowGW7lW+6YBTE0tU2NJ2LmgfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqeTAEks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2049C433F1;
	Mon,  8 Apr 2024 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582819;
	bh=JnYKibvqKlRk8W4kl05t2HWcTsiZNZauwN57XoWOaRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqeTAEksuzIK5PCj9XFHaqgjvU03GmKgvdv8cecXUlyVtdMdCvl2yl7vUMB94tOEY
	 9XKuDwPut/9W/QkuLzGIHkvb4KZwGmm0h2fMHbhKllnfbCWAeQzKqBRlh4RAjoN8Mr
	 uPjOvtT9XQesW9/MjqMqs1rnoY5hYeFgbZEuKl7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 178/690] fanotify: Support null inode event in fanotify_dfid_inode
Date: Mon,  8 Apr 2024 14:50:44 +0200
Message-ID: <20240408125406.010089812@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 12f47bf0f0990933d95d021d13d31bda010648fd ]

FAN_FS_ERROR doesn't support DFID, but this function is still called for
every event.  The problem is that it is not capable of handling null
inodes, which now can happen in case of superblock error events.  For
this case, just returning dir will be enough.

Link: https://lore.kernel.org/r/20211025192746.66445-14-krisman@collabora.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c620b4f6fe123..397ee623ff1e8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -452,7 +452,7 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
 		return dir;
 
-	if (S_ISDIR(inode->i_mode))
+	if (inode && S_ISDIR(inode->i_mode))
 		return inode;
 
 	return dir;
-- 
2.43.0




