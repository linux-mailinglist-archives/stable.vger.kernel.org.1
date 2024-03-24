Return-Path: <stable+bounces-30035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD80888916
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6EB25AE9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C324F6EF;
	Sun, 24 Mar 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo6e4r+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980F2081DE;
	Sun, 24 Mar 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321538; cv=none; b=Mi0Ba9hcCCECAVywXXJvdF9oUTN+K1ygLKJcUEz2Ay4OQODDiuXWbH7t5NunQARHAgijWLLzjPK9kErBqCDgIUEwEFQewcGTSp7i3WQwSEUIor6LY1xTxUziPo7T4cjjqtF4ELsOKf07uHlVnhZi2dc8AysAr87xHltR6BY73Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321538; c=relaxed/simple;
	bh=wIy1ReAnJ6KkGpuEl6h0vgRVgJgCpUexnLvJ/Gt3G4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZykxDVXaLGVD8hLkAbnhfT/IyXOND9K7YggVty6EHMg84X6LEKEEHQ+I9Hq2SAUstm9EX0hvP9jaQYSDwfcFHo6koNMPDjT+p+gfIzZV4/dbbAZd3III/YSSXU/tTlAB9Nk289ocQYXlIUq2UcUeGVnbi9BtblkP840zMGDTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo6e4r+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41071C433C7;
	Sun, 24 Mar 2024 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321537;
	bh=wIy1ReAnJ6KkGpuEl6h0vgRVgJgCpUexnLvJ/Gt3G4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo6e4r+uRAJcjGzRCn+KfuZokHdtV+lPcVkTV+5H5a0uyIdhetMFVq/GMvgZOXusl
	 1YtVlvuLNRzZdN8qiKc/+sYTpGKDd3DMdxnGHC2TAM+qCTdcLHpfnk7/nyBsympNQX
	 C1Xr32JnixJ4EZwdVSGDpnAshOL8mBVH22WVtGt3FOmQWF16xu5RgbbG6lX6oxpXOK
	 BBxw8bHCKeHDzHxuhRxKQH6HkN6vf6G0i148RDa5UYGdIT1rHorAY6CGsdktoejxmq
	 j6V8qy8MJASYXBGFm2ziAGo0owm2rLQcATqBT+hPEyb2Jeci6hbpHUsgbqL/gJ46DC
	 welDHHdYl5I5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.6 265/638] pstore: inode: Only d_invalidate() is needed
Date: Sun, 24 Mar 2024 18:55:02 -0400
Message-ID: <20240324230116.1348576-266-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit a43e0fc5e9134a46515de2f2f8d4100b74e50de3 ]

Unloading a modular pstore backend with records in pstorefs would
trigger the dput() double-drop warning:

  WARNING: CPU: 0 PID: 2569 at fs/dcache.c:762 dput.part.0+0x3f3/0x410

Using the combo of d_drop()/dput() (as mentioned in
Documentation/filesystems/vfs.rst) isn't the right approach here, and
leads to the reference counting problem seen above. Use d_invalidate()
and update the code to not bother checking for error codes that can
never happen.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 904863dbf5327..7dbbf3b6d98d3 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -306,7 +306,6 @@ int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
 	struct dentry *root;
-	int rc = 0;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -316,11 +315,8 @@ int pstore_put_backend_records(struct pstore_info *psi)
 		list_for_each_entry_safe(pos, tmp, &records_list, list) {
 			if (pos->record->psi == psi) {
 				list_del_init(&pos->list);
-				rc = simple_unlink(d_inode(root), pos->dentry);
-				if (WARN_ON(rc))
-					break;
-				d_drop(pos->dentry);
-				dput(pos->dentry);
+				d_invalidate(pos->dentry);
+				simple_unlink(d_inode(root), pos->dentry);
 				pos->dentry = NULL;
 			}
 		}
@@ -328,7 +324,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 
 	inode_unlock(d_inode(root));
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.43.0


