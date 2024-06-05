Return-Path: <stable+bounces-48067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7738FCBF6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AC4B21A14
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4C194130;
	Wed,  5 Jun 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqntjj3t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43299192B6A;
	Wed,  5 Jun 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588416; cv=none; b=OJTq5qEPyI0rihLRZQoQluFf4qdbFPxHy7XsNMhZ4xKexRRdASZskKBr+2E1ve2vUYrHhitNLem/9lYGo+GCyiwJQVzhTAx5zSKM2LsngZlv3TY9F10cFFb3bfaDnxWET3GpZBkH/Ij9tL/MjEY73Cq4FKATZ24Q3dDR9GzJc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588416; c=relaxed/simple;
	bh=M4hUo4Sz5eXhFIXqPo6FLTorE27s5v5OULPRV+E2nas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OA2HYqS+twFsX8zFgGTA7OM5TUa410fWthRQybR4GvtcwKsHELbO3RVyvV0HUfLofkDQqzEIjBALPNPNQezJwczDpa8XUmYVoBpJQDynGYgLYXuDuwBnJw/94AZs3Zri3lPFWDml902FqZbX20LWBkT7YM/vizcuQxM9YwDObO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqntjj3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E4DC3277B;
	Wed,  5 Jun 2024 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588415;
	bh=M4hUo4Sz5eXhFIXqPo6FLTorE27s5v5OULPRV+E2nas=;
	h=From:To:Cc:Subject:Date:From;
	b=Iqntjj3tXzsb5UX6gQEZst4eldgvzHKzusRrS03IgvxkiTyX3Yg1qIuixf64iHTth
	 BAa7cbyziLitNYJnnge6wrgNR4SJWTZBDLZXOmQB1unNBASGi1wxakKOJ8cfZWFBY/
	 z9kT/919ikCP7l2T/qkXcvMFYTrBD2jrJ53qPqm9zJy6YVqGnJ6JXnj5Muecf8xvEE
	 IaD+yGXdsogn+u813Pi7qi31MDd910VXKIIwsiZwuZOIeaDPHKhf3YHANBcKBNC02c
	 wgIc3Xjrn1CRXubKGDY2M90284k/BLQkBwpyVu6RfYv9NpeloK/wIfQZvd15uGHcWX
	 4Z5cDv3vM+BFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 01/12] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:53:06 -0400
Message-ID: <20240605115334.2963803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index c529ce5d986cc..f496622921843 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2092,8 +2092,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


