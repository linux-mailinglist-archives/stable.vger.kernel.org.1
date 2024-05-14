Return-Path: <stable+bounces-44941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585198C5511
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E681B283088
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE943AD1;
	Tue, 14 May 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTOs7cFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FC33985;
	Tue, 14 May 2024 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687622; cv=none; b=N8IGAgcDiib9Lm360mGMLKYGD1SR0PuSTsjI6jegvi83hCaKs20XHMLNeVjmouHApu5sMAtkY8ZwAWkCRkis68mAHd4dHcPLGCQO5dLdWh5gQgdaalaOWguh3u0GMaQd+atZEOzdZB08VyWQKA9BA0w+b7762UNi0kNQIzrIggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687622; c=relaxed/simple;
	bh=wcXQjd9zSzcWnRTRWxyNSfl92WZNOa88yRyyujJOgts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRXGaxSWDZR435X0XnKbq3NDLJadmQODLSg45zAy01zuu58KNgHpNTDuOhQwwde++IkB2cn8ldGCL4IaooqHt9XqLug0PmhtKPnnTGCFmmaAg1+VJ1hRnlwGLiBvNSathJaz1w7lczv4mvmREG6wmOJvjJN7Xn5DToPosIgFH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTOs7cFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E0C2BD10;
	Tue, 14 May 2024 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687621;
	bh=wcXQjd9zSzcWnRTRWxyNSfl92WZNOa88yRyyujJOgts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTOs7cFsZWnX4zQR6ocl8q/+hA4KM+P2rUPZiYlRA3kokoBWFhmKap99GLTuKLKMF
	 /kOtCaHiH4tLAK7QhDPJh2tC8auphghX6riuPv55r+FJeOEGQNLpzxbuHg2eeirzWZ
	 La0US+ATDkBEM5B/KUvNnMoRoIbIVgPqOtatgqWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 006/168] ksmbd: clear RENAME_NOREPLACE before calling vfs_rename
Date: Tue, 14 May 2024 12:18:24 +0200
Message-ID: <20240514101006.925339935@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 4973b04d3ea577db80c501c5f14e68ec69fe1794 ]

File overwrite case is explicitly handled, so it is not necessary to
pass RENAME_NOREPLACE to vfs_rename.

Clearing the flag fixes rename operations when the share is a ntfs-3g
mount. The latter uses an older version of fuse with no support for
flags in the ->rename op.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/vfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 173a488bfeee4..7afb2412c4d43 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -745,10 +745,15 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out4;
 	}
 
+	/*
+	 * explicitly handle file overwrite case, for compatibility with
+	 * filesystems that may not support rename flags (e.g: fuse)
+	 */
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
 		err = -EEXIST;
 		goto out4;
 	}
+	flags &= ~(RENAME_NOREPLACE);
 
 	if (old_child == trap) {
 		err = -EINVAL;
-- 
2.43.0




