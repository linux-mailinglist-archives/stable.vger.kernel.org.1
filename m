Return-Path: <stable+bounces-48047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700F8FCBAF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A01C1C23790
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA53DABF7;
	Wed,  5 Jun 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfF9nxJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15CC1A3BB5;
	Wed,  5 Jun 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588348; cv=none; b=XNcNLCzyCLuL3pdJwA7VD7kJa5QdrCbHcndxfVoWyNM3lFIJRuedguiX7MGOibRO3m/nvELYAOKOgmLTJcGI543wZXZ+VJs7b/hEjqPfKawfzF+mOdDoMwK5Dt/usshnmLoniNmcG5TP4sHBlYy5Ol1nrnFa1H1NVn3PUioQ8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588348; c=relaxed/simple;
	bh=U6mbqeSfWwgxSCsUcir+acuWxHuovKizLuJkAoTPduE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZdQ8FXTcGX8XF1tw6LUQ5vmlE1E0/p9hdMXi5WPUMgw9h6OxBoggcov+IYzwlky0sPRGbApTcoRIhSnph6itKdQJ3EtGOaVd3zVqMMccLYheLow9zspKUe5ZGVABPYvI4ibsyDI+nkYR9BtmcuT5G4x1jPC9kBgQrq3N6ggBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfF9nxJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13CFC32781;
	Wed,  5 Jun 2024 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588348;
	bh=U6mbqeSfWwgxSCsUcir+acuWxHuovKizLuJkAoTPduE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfF9nxJ8QFG6EgUCXSBpu3TZXaIdt6Y6QMAo7HeRATkNNZGQtQwOdSCYpvpLeeoqm
	 d0gFgP67dH3nVvr94bo4QDL8IwvYDej6gxHjTX72YWPufH302fvs3oSoqrnZt5JdW/
	 1JBuL0I21mMSChgBn709UYA/fP6YK588A34T0sNhUlLUU5E824EQBIcje6Z3r5Xs/J
	 WQdVm1TohZepwzbFP8oYUHMvZysIMyICdmgTp38qHoCmq8glq3pslsBOJB5DSf6Sva
	 1nkznMmFLYrg/aTHkchaB8unwd455mmXomZxf5UFSERbvPh4ThCJ87Bkql62l8n/D6
	 Zel4gAWQIELgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlei He <heyunlei@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 02/20] f2fs: remove clear SB_INLINECRYPT flag in default_options
Date: Wed,  5 Jun 2024 07:51:45 -0400
Message-ID: <20240605115225.2963242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index ab437022ea56f..5d294c8a025ca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2186,8 +2186,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0


