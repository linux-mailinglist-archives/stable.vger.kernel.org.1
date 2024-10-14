Return-Path: <stable+bounces-84475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F099D05D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2711C22318
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC91AE877;
	Mon, 14 Oct 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGfYnqCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B31AE001;
	Mon, 14 Oct 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918139; cv=none; b=p92CTnC1O8p8MbZYCnFOE5U9+cQjWSjQJmI5B+dDfJ0rnuqfeF/uj0DMo5V6CURfoVpCEnnGYPw3IH/By5ctNQ5dajujtLWv+RuWoN35KsZWilZX4YTcOqp8l7/1OZXU1bd5Gb9zXx0IMotuF2SHfADjmV5TBAPBACoFLw0O/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918139; c=relaxed/simple;
	bh=9ez7sSbeJy7CP7zY+LH2UBEJ0RopvE3pt9VfarurDhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PccK8yCrXVEem22IVwCQ8ZEOEtsgnJEK6BSyOpuKZ/lexwWCDM5lPgGj+WuJaaJqd2Rg60pPYfVJgPWPlKul3iZWasVLpHlwDbRiOxQ8bXB/uMFQsa88GT703Z1Qj2vxuqGv0yBd2xHbi5PpXRJDcCbNlSHQZpDJ2HWzhPYZagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGfYnqCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A4C4CEC3;
	Mon, 14 Oct 2024 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918139;
	bh=9ez7sSbeJy7CP7zY+LH2UBEJ0RopvE3pt9VfarurDhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGfYnqCpfuMEedJ44ZcraO6XoRc4Vx3PketCrN3fUTfmC6qzKAbHh+qcsXlDYWexO
	 ugdfSBsw4kRDXfs7fy7H5J8DNZZcCtArzJqjmagVAv4fQtejpiTggcPbKygD1+AVnN
	 b2SSqQcmAdsIDGFyUFGKVabfyuEG+j4pzBGhJE0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 235/798] f2fs: remove unneeded check condition in __f2fs_setxattr()
Date: Mon, 14 Oct 2024 16:13:09 +0200
Message-ID: <20241014141227.152874183@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit bc3994ffa4cf23f55171943c713366132c3ff45d ]

It has checked return value of write_all_xattrs(), remove unneeded
following check condition.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: aaf8c0b9ae04 ("f2fs: reduce expensive checkpoint trigger frequency")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 0862dfbe6a5d6..6ee71a2faa75f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -772,7 +772,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (!error && S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
 same:
-- 
2.43.0




