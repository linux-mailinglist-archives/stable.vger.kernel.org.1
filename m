Return-Path: <stable+bounces-50998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BD0906DD8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6345E1C20E49
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538514535B;
	Thu, 13 Jun 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Slf3eTdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8056144D3F;
	Thu, 13 Jun 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280006; cv=none; b=lwTVzVu4V9KuBKseQq2p+prE7SHnk4p+fP0dRvOzk5HlVCxE3CRp13fjZpbgLUOPx5lkZHgYSYf3I6j/ydR48MHCCzvC+fR+yVoCqCUJB2kBTXGvs2YprbexEPbFW5+AwzbMMV/GU/Pz1hnKs6MJ5bUAcQQHu1g3d5Kqu8lnyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280006; c=relaxed/simple;
	bh=/ZobPwk1Al2Xz42+Wjhptx5p+kIKlRnE/mYn/TnkcHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKZiv1qc7Kions7OIWZdLEAQEh8n2WKwk71m8JdY0zXGtVLF94Vl0aBj/RCROoQ/Vu7P56bxPtlktfOWjSgPUGSCwt+CMQwa/wCBk5/3LN90WmZTkuPZxENhATK7xZrlq119hzLa/R0P9XAoqkvNhq3q7woKXbeMLQiJM6HPAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Slf3eTdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06DC2BBFC;
	Thu, 13 Jun 2024 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280005;
	bh=/ZobPwk1Al2Xz42+Wjhptx5p+kIKlRnE/mYn/TnkcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Slf3eTdk0BKAF41cqqx/6Q5XYODLRmDn7C4XVM5i0n4bSKJHpkVROr/hBgjrdeALU
	 AQW42lxmzPURdsLMkr6gpgOt/bbRZN6C2jBYZbgZIYGdLGgoXZebDZ/XM4JskXmDz7
	 VPkiK74p0G1ya/aBSo1FzVLBQMkWmDV++48YO84s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 110/202] ovl: remove upper umask handling from ovl_create_upper()
Date: Thu, 13 Jun 2024 13:33:28 +0200
Message-ID: <20240613113232.007208207@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index fe88ac18ad934..1cf1006678588 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -295,9 +295,6 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	struct dentry *newdentry;
 	int err;
 
-	if (!attr->hardlink && !IS_POSIXACL(udir))
-		attr->mode &= ~current_umask();
-
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 	newdentry = ovl_create_real(udir,
 				    lookup_one_len(dentry->d_name.name,
-- 
2.43.0




