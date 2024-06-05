Return-Path: <stable+bounces-48089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0A8FCC3C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529A2292E31
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E91B3F2D;
	Wed,  5 Jun 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQLonXI3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249681B3F31;
	Wed,  5 Jun 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588485; cv=none; b=CvFkoXtxjSUV0gNJjmxvyKOXOZOK70Hr/oDlhL4SyRau0uQ4omoE/KFkRJ/fBz4hiWKkCEmmMSiarSkohIIeKgkN0UZJW2Wn1SKIsS+31V6W8zApdyX0cMdq0kf72uT0W650t7k6kM+LjKl9PpCZCdyKHqwXHryFvJ5TWlLiJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588485; c=relaxed/simple;
	bh=fjvJY+jDj+VRWLNeYheSJjo7RC0CvRgYbsQoviL+v/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFqWz3zXx3IznJG3EYYIdALNWabxmqS0GFVRVvcjk+VKwM+jvyCf+AgseNt1q59PbH/C5DuO+m4jFZQD2W7ftlJSbnoN4afnRDCkyIU83ut4QV/+nLU8ccCsctbWFr94xK7nHZqgGqZaktRDWqNdNbMTPj5/0i7cx5eON6dYPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQLonXI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC6CC3277B;
	Wed,  5 Jun 2024 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588484;
	bh=fjvJY+jDj+VRWLNeYheSJjo7RC0CvRgYbsQoviL+v/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=AQLonXI3VgSkp404filO/yP6DHcjq+pL2U6Euv+2kAMH8X2Zq7qL4CgwP6AW7zb5w
	 Hsdi3XXBkTLXlWyRz+eFkZjWoj4MHgcSL31tSPuvNwTVxZk0OZ6MQjp/ehXenSNman
	 2QVQ5Hl6WQoqtlNxnENoJOgBT+jSN0pzIAB9JYCBeBzSrSzOP0aWBZONxQfyuFZTUc
	 nWcoxgusWD5/YewxlT5+MHEwvbJg6X+Co85B9kxG2RhzqyufkodjHm8sQ1tnxGZ4Lb
	 VNCQmVaWV0hFnqrDPe/iiVzLnqkUmILko4ovEmhrR8XT3U+L6wi7wI770Xcb+ya3ca
	 iGF4y3BZ33z1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 1/7] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:54:30 -0400
Message-ID: <20240605115442.2964376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 9a74d60f61dba..f73b2b9445acd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1713,8 +1713,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


