Return-Path: <stable+bounces-48023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D28FCB58
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C53A28B0C5
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636A194A6B;
	Wed,  5 Jun 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKQilBLX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F16194A64;
	Wed,  5 Jun 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588264; cv=none; b=TAhg/ptyyoItH/5rjaDWJe4SX0RAJtY4fHWgoZLuNzcHq/8z05B5w5/W1seYKGfKZfrI0jSa0FYAZBEw/dfYFRdoFCUKc9Da0QkQe4GLBBRnzN/D/6uWAHL/fUQwvyrNL4tRGGDYWdGUCW6hIdbzC4zSoYPudzddBe2wuEYLP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588264; c=relaxed/simple;
	bh=hb/sR4c2mafWsXSHwE7mGDPp0HyJ844pMJnKXtg6Lqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV1u0Dl2cLU+zubJKrGuhjBJjZbkis9vNFo5PYnuFmyrAog+/3r4n1PQ1qUrdrVwNowYq1r2F2x0dtz+zf3Fzws0SAXXKmTrDlzq1Ghsc/ulHb7kS/vZOTMWQU4pEmIpBNL5HDkJ5klQAth1Lhx+TpBUTPj1gIIGXCIon2lTJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKQilBLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD74C32786;
	Wed,  5 Jun 2024 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588264;
	bh=hb/sR4c2mafWsXSHwE7mGDPp0HyJ844pMJnKXtg6Lqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKQilBLXTvdqMuPiQdNlxclkD+CfxO739OFljMTbP8I3aKvBUugMVOFzGhlxmGd/V
	 RpCCxhGPS5ZUI29dFy0siwNjsy/4H/Rk75YkB7a9G2NIgj1UEgtIT22BQ8E2bMH2jb
	 LPNxLfPRu7xQE7HihQwm4BkTn4yOON/NxxtR2TxJyAUG0ZJmuThsW4W+QlXSBGolNt
	 ET1U3JAgPuN3VBCdTJuhpPJFm5P2jcP+7M0BuNu3q5i8fmbrxOaBMgvcyS2WNgyEHe
	 aqQsgyjAhwcf9tSgkxgtuYld7vDMa7ItKeZmkAP0cAw1V5VgjGVJykur7oPg/w+/4f
	 Ot4C28lVXAChA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.8 02/24] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:50:12 -0400
Message-ID: <20240605115101.2962372-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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
index 4ba613ed3a179..67bedd5b69cc1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2193,8 +2193,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


