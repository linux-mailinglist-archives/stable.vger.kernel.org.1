Return-Path: <stable+bounces-48080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCC8FCC1E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B41C20891
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081441974F6;
	Wed,  5 Jun 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcHBSNID"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57E1974E6;
	Wed,  5 Jun 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588457; cv=none; b=ktgFv148a1ejUQaJWQO26/GbAAOvLNZlQeGoV+XVcivjObEfa+zgpchHFg5JDP5S++wytotVdRSsauSF7e1w8OTx942XWt8UQUKe+a01+rJoL56tNlO6/esA5RiEifa6Yeo9AZdNACV5t/Na6om6Upjvei5SKmsqfdgNc2je5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588457; c=relaxed/simple;
	bh=a/4zziXLEH7ScUQ841dFu6fDUaravSz8cdlQEliR3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORXAYF0THcIo9oIjvqWcfGCHgnIeag74/edYUtQJ6YGZWa3Wel0YesP1aClUpzUlIsILmgD4xE+3PnYD+4ziYxPKWKpSTrNWr0A9kTvVp5Qx1U5wGoJowhmkvJPm12OzZkBFBH7lsio5hxksgjR4sjAksst4bmc64FiAMZKAqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcHBSNID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E04C3277B;
	Wed,  5 Jun 2024 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588457;
	bh=a/4zziXLEH7ScUQ841dFu6fDUaravSz8cdlQEliR3Pc=;
	h=From:To:Cc:Subject:Date:From;
	b=kcHBSNIDSCLOarWPvFPw/55kP515WYoAGr5zEI+03pGnZZaNWjbBmRTaAckx5QMN7
	 zf2DAI+4hVfLk/bUU9wNVgEjp+J5vYG1pJNror/xXgxyHPfMhR7SVTg2R+O4wPQU60
	 xPj2u3dG7YeaLPo+MsUxSX9E3EgzkeH3Ide+eJrj2b7Ku/ZSn9gxQ8tEG/CPMjCiQM
	 z8mg4qqX8tcA2QrLBnfV7L2c7SoC/2xF2GubW1CY1YADo9GJrkQ5TxjLdaXf0VN/1I
	 GzQDnQ+EzLV225TKUAGQOUcI5rnAp8ki72pZlixNBWE3v+F/tSfANtJkYFZFsWihkW
	 XlKfihSkSYilg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 1/9] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:53:59 -0400
Message-ID: <20240605115415.2964165-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index df1e5496352c2..706d7adda3b22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2068,8 +2068,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


