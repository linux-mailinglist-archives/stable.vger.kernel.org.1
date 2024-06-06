Return-Path: <stable+bounces-49573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6F8FEDDB
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99B21C24435
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAE1BE247;
	Thu,  6 Jun 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aF6E0lmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DA1BE23E;
	Thu,  6 Jun 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683533; cv=none; b=TiZq0mLcnk+5xEuu/FXzPgmVAH01hcgxbxCLgsHx+MmNE+ion57V+kUaXLX72a0txMPc9ZjYVfEhOUwaCKWFj9Kfb31XnrXsti3xXF8wNQxmDlr1Sge5VYzjJUF61QnTQf/4TxvBuCI+ZfBX9KQBozOhBtKNsO1JFx7CFFwjWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683533; c=relaxed/simple;
	bh=CeAPyAFkKgLrrRdsAd1O+xR9TDYlw4+gOvnX5gWkd94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2bUzDKlcR1VZMGHbNgo8g2UrfGKdEpqFMeMQbeoa2f6FDT4ydD4n4TgZVIAfnvp1ibdFJrEmkbVAaqtAYN8nWMf8PQV1FxRTM4A98K1lnZoLI0NFddUFffLzs2wkL4xo6HjDY3lL17/txTnKz9Qu8clJZK1YXGKuONFVJHsVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aF6E0lmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFFAC2BD10;
	Thu,  6 Jun 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683533;
	bh=CeAPyAFkKgLrrRdsAd1O+xR9TDYlw4+gOvnX5gWkd94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aF6E0lmpLcAY9A1Ew4Pdr0WN2Y9EICYPP+RUtbIvQ0wvQS/O5hnq99qnbjJnL/xpa
	 MvPnkuDZFkYnrEl+MBsPLkW/OyT7MrDQ5D+4f3PmSf2pCmuOC0kH2yRjfDNUEizQ7P
	 nBJw/hX7bpsiXgDa6R09oj0fxnIjZzzK+Z4MJL0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 473/744] ovl: remove upper umask handling from ovl_create_upper()
Date: Thu,  6 Jun 2024 16:02:25 +0200
Message-ID: <20240606131747.625419319@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 096802748ea1dea8b476938e0a8dc16f4bd2f1ad ]

This is already done by vfs_prepare_mode() when creating the upper object
by vfs_create(), vfs_mkdir() and vfs_mknod().

No regressions have been observed in xfstests run with posix acls turned
off for the upper filesystem.

Fixes: 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 033fc0458a3d8..54602f0bed8be 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -327,9 +327,6 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	struct dentry *newdentry;
 	int err;
 
-	if (!attr->hardlink && !IS_POSIXACL(udir))
-		attr->mode &= ~current_umask();
-
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 	newdentry = ovl_create_real(ofs, udir,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
-- 
2.43.0




