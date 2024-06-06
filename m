Return-Path: <stable+bounces-48372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BF8FE8B8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B2283E94
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE0197A93;
	Thu,  6 Jun 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCvVO5R4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5B196C72;
	Thu,  6 Jun 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682928; cv=none; b=mIYnC9kLxsnaNX2Yb0fpFxOaJsQ4aItLqDmntWf4Ch0DIpUmuxm8cPzsYq0NBlAinbOST7qaPHozkb+gCqEWZIWOpgY66v3gjHuFU66B8MxywFhoyZ2F8qlH0u4e1PXUQ2JocZndRmSLuCeK6h/ApybegPuFnISBKA3xaN99E6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682928; c=relaxed/simple;
	bh=prpWGQFYYVwxg+h2czJrDelcz5w53gEVPaqWoyOMAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6uNY2p+tY+VHXk6fGkUameHK1DiWfqhBnZug1vfTBiHT0UiiFPgTL8veRuJmhmvvqNwE7GPa7FgFVFvtlznwQ81uNfBNVd14VRotXRcXILNCB3lLCi+j14acllHdhyQAfooW18hD5/ULQsXwlvNfb3saw6ledoygz1wDIlgynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCvVO5R4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E79C32781;
	Thu,  6 Jun 2024 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682927;
	bh=prpWGQFYYVwxg+h2czJrDelcz5w53gEVPaqWoyOMAWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCvVO5R4su9YBqsox5rger7TIrY+05KwhDI29ZAuAdfss8SwzteOTn/cxRI1El9Om
	 osT1IPHWKaKQWRuueqJPAlchpaBL4Cc9eCxeJy9S12+vuWnDANfrDfiPFKVoTqacT4
	 4xqYmIX+P2zvE06eEEhbxX6q3e63s19aAL5lNk7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 072/374] ovl: remove upper umask handling from ovl_create_upper()
Date: Thu,  6 Jun 2024 16:00:51 +0200
Message-ID: <20240606131654.266014017@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index 0f8b4a719237c..02d89a285d0dc 100644
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




