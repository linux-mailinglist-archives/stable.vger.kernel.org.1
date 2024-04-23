Return-Path: <stable+bounces-41228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A348AFAD0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3569C1F29748
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5714A63C;
	Tue, 23 Apr 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzEPpMmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1A143C5F;
	Tue, 23 Apr 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908765; cv=none; b=t/ZDSnfkBzMCn7mUlNWrwUjmfLtw4pkbRiNn8P/NNHqEtukqBWsnJMDDrHCnTOoQ3iy7iU9y7HNcGji4QPapgM9QBiIi9em3dhxOLDYgrx+fYhQ0qV22SVgaBYEGg8LDl+2K+P86GK1mYXqTnFI/eDEvv17zLsYNJk6+hVo86qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908765; c=relaxed/simple;
	bh=wYyBywTJzTpLzlrYIHHu4i586AWslnQN6xsGRXChDNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5wGwnkQzTMbR2euyLJmOAhk6dt5Mx//sYfv4lPRXGF+9DG0Lgbz3WVb7iJL6pZ3a8k7unfOAm2bRUPv9aHRhXiF9iHPcWOUNAAShSVlMvP1OIJhhxxiisDMCd/KXzE5OVsP2vJCXKN8Yh8sR9IgA+T0+cpJ3Z4cAg928+dhQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzEPpMmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D24C4AF08;
	Tue, 23 Apr 2024 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908765;
	bh=wYyBywTJzTpLzlrYIHHu4i586AWslnQN6xsGRXChDNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wzEPpMmjufIRDjVEl7mtp6+5zDq4FktIIFNPcsQbxIugz7/PaqYMsk/Z/0UkVC+nc
	 VDwtsFTBBnlYKYi4jCD17h5WY1oN/qjKjtIb3flsFb6u+ZsqTlgJs+I9U92+qWWlD3
	 k8n90yIcnzhsPHBHQWvJ3S+pbHfKmUnv6o+/L53E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 139/141] ksmbd: clear RENAME_NOREPLACE before calling vfs_rename
Date: Tue, 23 Apr 2024 14:40:07 -0700
Message-ID: <20240423213857.731684068@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

commit 4973b04d3ea577db80c501c5f14e68ec69fe1794 upstream.

File overwrite case is explicitly handled, so it is not necessary to
pass RENAME_NOREPLACE to vfs_rename.

Clearing the flag fixes rename operations when the share is a ntfs-3g
mount. The latter uses an older version of fuse with no support for
flags in the ->rename op.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -746,10 +746,15 @@ retry:
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



