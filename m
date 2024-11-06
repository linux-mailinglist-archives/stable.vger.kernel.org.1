Return-Path: <stable+bounces-90201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F399BE727
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8681F2493B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429B1DF252;
	Wed,  6 Nov 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/Xoxz/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBB1D5AD7;
	Wed,  6 Nov 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895068; cv=none; b=fdH4PboHGWN90VI05NQ1wC/f0SgiMMheD7FO/L+fynCMerJ5BOe3U4FlwP0uELWpq9UUsr9hl6TonkFbDAZCTIrjyyINI9pemUI//kMulRq06xTc7Pqa9bJ3z2b9TZBQZP398FYQQ6/g3Z7AFbgTBWBjClmJSoNvMGUwSjSkrs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895068; c=relaxed/simple;
	bh=PSzCCoNDsfZIuuMCBt46opMlN1EK/pzTzYQ1HbxT1H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvb46o/CIX332KKlnCKmiIcmGSdOjOmsTBMy+e2FwmNctgd6p9ys3IPK2Ka+M8fPFJfylmJXHZeD25RCH+Cgnq5ffNlOYOPBb/MwMVpP6WIyktatSuJhlNWifR7pecT+W4Zo8uCgrU9OOyB1dANpMWniFUx5FkGtGNJWy+CcLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/Xoxz/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA32C4CECD;
	Wed,  6 Nov 2024 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895068;
	bh=PSzCCoNDsfZIuuMCBt46opMlN1EK/pzTzYQ1HbxT1H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/Xoxz/zFyaA6hE6k11b5FT8gHKbM5m7FXtr9Wk6vF5Uxf9a7UV2c42Iy29gKjfUx
	 fshQvyyUIZvEAN8V0UN2D0ZaLPwVyGPc7p60byNLp2sqPmAMMvlJw8jh7LUf478XIO
	 DO9tor+SY0XekKTaSc3+aTgRM5eHpBYbOCyqpR5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/350] jfs: fix out-of-bounds in dbNextAG() and diAlloc()
Date: Wed,  6 Nov 2024 12:59:46 +0100
Message-ID: <20241106120322.321530837@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit e63866a475562810500ea7f784099bfe341e761a ]

In dbNextAG() , there is no check for the case where bmp->db_numag is
greater or same than MAXAG due to a polluted image, which causes an
out-of-bounds. Therefore, a bounds check should be added in dbMount().

And in dbNextAG(), a check for the case where agpref is greater than
bmp->db_numag should be added, so an out-of-bounds exception should be
prevented.

Additionally, a check for the case where agno is greater or same than
MAXAG should be added in diAlloc() to prevent out-of-bounds.

Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 fs/jfs/jfs_imap.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 893bc59658dad..1128bcdf5024a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -200,7 +200,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag) {
+	if (!bmp->db_numag || bmp->db_numag >= MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -665,7 +665,7 @@ int dbNextAG(struct inode *ipbmap)
 	 * average free space.
 	 */
 	for (i = 0 ; i < bmp->db_numag; i++, agpref++) {
-		if (agpref == bmp->db_numag)
+		if (agpref >= bmp->db_numag)
 			agpref = 0;
 
 		if (atomic_read(&bmp->db_active[agpref]))
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 9893cb6b8a756..1e9a3ec4bfa84 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1375,7 +1375,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
 	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
-	if (agno < 0 || agno > dn_numag)
+	if (agno < 0 || agno > dn_numag || agno >= MAXAG)
 		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
-- 
2.43.0




