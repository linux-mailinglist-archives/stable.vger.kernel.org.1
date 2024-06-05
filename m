Return-Path: <stable+bounces-47996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174E8FCAE5
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02B6B23C33
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C34194123;
	Wed,  5 Jun 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9cbWHgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0D19309C;
	Wed,  5 Jun 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588172; cv=none; b=leBGGHxBKZXqgI5nhmY/TAGV2NS1LelvmHgt3v2zVM20fzSKyUKHnTXnN4mV3ST3lzRDpNmtg0YIFyw7veqhILlA5xxupbvGm6wcilseT0cwzoQL1q6Z9MAmj6RtUVHizD7xjX+isgrJo68Avsyq+MHQXoPiffzDFu0plwPqQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588172; c=relaxed/simple;
	bh=eV6sMHKwD9VA0h9HbtB16fn0ZR00vEFh0Zl0/uBJR/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZISjISTEblYVjM8GR9/jlhyKZblPlLzrDCk/HxmtH++GRi/wYuYT6fSZVPWu42GXBSzkgxrWmbgKBMcgak+ocQZEZiDTGoqMrQUSjvxxphifCh/fRl/d7FnIriu1amfW7HpnIJNdyDAhEBjDRSNEpzP3EPRy+CKcLWJQWQOSnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9cbWHgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE39CC32781;
	Wed,  5 Jun 2024 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588171;
	bh=eV6sMHKwD9VA0h9HbtB16fn0ZR00vEFh0Zl0/uBJR/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9cbWHgpGnMDApaTwYBlpzh6/WyXGAkXpoXH7oDMhQmJJ6r6lSLDzJTmiDdI2UMFb
	 /NW81+7BaKCcd8I+LCgHHDO+Dt6HNFSJ5fTpVI2yuobZg9EJ4599zkV41tJ0HkiDgd
	 jH3CygmjBKdKJ+2d2CWPM1m6/cumL0b2H9lX5UKSwLPFLA1A6Jsdz8eLRwHTO0byHV
	 B5Ws9ivvcVu2a4CKRcwtGpnEaGKQNl4WURUbwQQVfSlkJTyCvSURIVhAN2KD8tOQAu
	 K17vFVFsyF+e++tIxJnWfFfIS1fC2zuPAN6pPNq4sBB/Ox/hh3azIfRSi3NlB9HPYS
	 Grtuk7VtMVIYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.9 03/28] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:48:32 -0400
Message-ID: <20240605114927.2961639-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Yunlei He <heyunlei@oppo.com>

[ Upstream commit ac5eecf481c29942eb9a862e758c0c8b68090c33 ]

In f2fs_remount, SB_INLINECRYPT flag will be clear and re-set.
If create new file or open file during this gap, these files
will not use inlinecrypt. Worse case, it may lead to data
corruption if wrappedkey_v0 is enable.

Thread A:                               Thread B:

-f2fs_remount				-f2fs_file_open or f2fs_new_inode
  -default_options
	<- clear SB_INLINECRYPT flag

                                          -fscrypt_select_encryption_impl

  -parse_options
	<- set SB_INLINECRYPT again

Signed-off-by: Yunlei He <heyunlei@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a4bc26dfdb1af..e4c795a711f0f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2132,8 +2132,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


