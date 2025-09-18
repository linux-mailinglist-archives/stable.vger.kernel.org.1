Return-Path: <stable+bounces-165909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC0B195FF
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7580D1894212
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AFA21A43D;
	Sun,  3 Aug 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXPm3tAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252A204592;
	Sun,  3 Aug 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256074; cv=none; b=oiHvnChzRC7fO+eOCS+Nr84fmCYdres/YCfmC9NAt8fPmZ/7KoKyByFT3NNXzwOJ4/6nNbSig5DQBibQLRqG3cdqEGP3mQBALUOwAD7/G2/PzwonRTA+ja4fb9xXe9pkfboDb5ydjwzCnbdUoSjKqrc58B3RBD3LwHK6844D7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256074; c=relaxed/simple;
	bh=jY7DzFbg9JcGe8zSCwlKRviOSwbJDR5I7rw+jOSA23A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRO0tz43UuXwXSyFkgOGmdumvWdUlF0c5XRgKEJ6doXhln9vaIvXNWY2IcQof4vLX9pg3hbRlsbKdCJ81Tsmcqd+rLnC26OhewVHkR9GC+JWT3sF1BF9gZjSgkLO++DlG6WFTD6o86B9z+rt9IqvcnQRjE1rNIf76ZbI+EOYhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXPm3tAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17F4C4CEEB;
	Sun,  3 Aug 2025 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256074;
	bh=jY7DzFbg9JcGe8zSCwlKRviOSwbJDR5I7rw+jOSA23A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXPm3tADJqMQXlM16q68oTxcXGLIO3g/N2+gZZirqK0DtlbmptgiEiNRw5rd2U3Wj
	 X//ZpoW3qFWTfZthg1wa+dy3cfJWzkb7QJkEkMNNMxaBuiyZcNmxCr5oxAC+v3yrjg
	 UVPSENGD62spBFQuhGEGe9G1yxAbmHu+rM7g+4Fa3w81q5an12JPy72r4PX45BJ7IM
	 2HUGM5twfacM38PlvFMkOd/xpJeUAkO68ry3PEF+IFwDajkPMmfMVyQS5BejAehnuk
	 RlQkU8rTMiiZZPI86Xqv63lz+QiqdzbR14cMN9Aza52Eaf+P51nK6SaXYtPHcJEBvm
	 OgLNsTo1lIR7g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rong Zhang <ulin0208@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 18/23] fs/ntfs3: correctly create symlink for relative path
Date: Sun,  3 Aug 2025 17:20:25 -0400
Message-Id: <20250803212031.3547641-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212031.3547641-1-sashal@kernel.org>
References: <20250803212031.3547641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Rong Zhang <ulin0208@gmail.com>

[ Upstream commit b1e9d89408f402858c00103f9831b25ffa0994d3 ]

After applying this patch, could correctly create symlink:

ln -s "relative/path/to/file" symlink

Signed-off-by: Rong Zhang <ulin0208@gmail.com>
[almaz.alexandrovich@paragon-software.com: added cpu_to_le32 macro to
rs->Flags assignment]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Bug Fix for User-Facing Functionality**: The commit fixes a
   specific bug where creating relative symlinks in NTFS3 filesystems
   would fail. The commit message clearly states it fixes the ability to
   run `ln -s "relative/path/to/file" symlink`, which is a basic
   filesystem operation that users expect to work correctly.

2. **Small and Contained Change**: The fix is relatively small and well-
   contained within the NTFS3 symlink creation code. The changes are
   limited to:
   - Adding an `is_absolute` parameter to `ntfs_reparse_bytes()`
     function
   - Modifying buffer size calculations based on whether the path is
     absolute or relative
   - Setting the `SYMLINK_FLAG_RELATIVE` flag correctly in `rs->Flags`
   - Conditionally adding the Windows path decoration (`\??\`) only for
     absolute paths

3. **Clear Root Cause**: The original code always treated symlinks as
   absolute paths by:
   - Always setting `rs->Flags = 0` (line 1125 in original), which means
     absolute path
   - Always adding 4 extra characters for the `\??\` prefix in buffer
     calculations
   - Always decorating paths with `\??\` prefix regardless of path type

4. **Minimal Risk of Regression**: The changes are straightforward:
   - The fix correctly identifies absolute paths by checking if the
     second character is ':' (Windows drive letter format)
   - It properly sets `SYMLINK_FLAG_RELATIVE` (value 1) for relative
     paths using `cpu_to_le32()` for endianness
   - Buffer calculations and path decorations are adjusted accordingly

5. **No Architectural Changes**: This is purely a bug fix that corrects
   the handling of relative symlinks. It doesn't introduce new features
   or change any fundamental behavior of the filesystem.

6. **Important for Interoperability**: NTFS3 is used for compatibility
   with Windows filesystems. Having broken relative symlink support
   impacts users who need to share filesystems between Linux and
   Windows, making this an important functionality fix.

The commit follows stable kernel rules by being a clear bug fix with
minimal changes and low risk of introducing new issues. The fact that
the maintainer added the proper endianness conversion (`cpu_to_le32`)
shows careful attention to correctness.

 fs/ntfs3/inode.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index af7c0cbba74e..0150a2210209 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1130,10 +1130,10 @@ int inode_write_data(struct inode *inode, const void *data, size_t bytes)
  * Number of bytes for REPARSE_DATA_BUFFER(IO_REPARSE_TAG_SYMLINK)
  * for unicode string of @uni_len length.
  */
-static inline u32 ntfs_reparse_bytes(u32 uni_len)
+static inline u32 ntfs_reparse_bytes(u32 uni_len, bool is_absolute)
 {
 	/* Header + unicode string + decorated unicode string. */
-	return sizeof(short) * (2 * uni_len + 4) +
+	return sizeof(short) * (2 * uni_len + (is_absolute ? 4 : 0)) +
 	       offsetof(struct REPARSE_DATA_BUFFER,
 			SymbolicLinkReparseBuffer.PathBuffer);
 }
@@ -1146,8 +1146,11 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	struct REPARSE_DATA_BUFFER *rp;
 	__le16 *rp_name;
 	typeof(rp->SymbolicLinkReparseBuffer) *rs;
+	bool is_absolute;
 
-	rp = kzalloc(ntfs_reparse_bytes(2 * size + 2), GFP_NOFS);
+	is_absolute = (strlen(symname) > 1 && symname[1] == ':');
+
+	rp = kzalloc(ntfs_reparse_bytes(2 * size + 2, is_absolute), GFP_NOFS);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1162,7 +1165,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 		goto out;
 
 	/* err = the length of unicode name of symlink. */
-	*nsize = ntfs_reparse_bytes(err);
+	*nsize = ntfs_reparse_bytes(err, is_absolute);
 
 	if (*nsize > sbi->reparse.max_size) {
 		err = -EFBIG;
@@ -1182,7 +1185,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 
 	/* PrintName + SubstituteName. */
 	rs->SubstituteNameOffset = cpu_to_le16(sizeof(short) * err);
-	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + 8);
+	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + (is_absolute ? 8 : 0));
 	rs->PrintNameLength = rs->SubstituteNameOffset;
 
 	/*
@@ -1190,16 +1193,18 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	 * parse this path.
 	 * 0-absolute path 1- relative path (SYMLINK_FLAG_RELATIVE).
 	 */
-	rs->Flags = 0;
+	rs->Flags = cpu_to_le32(is_absolute ? 0 : SYMLINK_FLAG_RELATIVE);
 
-	memmove(rp_name + err + 4, rp_name, sizeof(short) * err);
+	memmove(rp_name + err + (is_absolute ? 4 : 0), rp_name, sizeof(short) * err);
 
-	/* Decorate SubstituteName. */
-	rp_name += err;
-	rp_name[0] = cpu_to_le16('\\');
-	rp_name[1] = cpu_to_le16('?');
-	rp_name[2] = cpu_to_le16('?');
-	rp_name[3] = cpu_to_le16('\\');
+	if (is_absolute) {
+		/* Decorate SubstituteName. */
+		rp_name += err;
+		rp_name[0] = cpu_to_le16('\\');
+		rp_name[1] = cpu_to_le16('?');
+		rp_name[2] = cpu_to_le16('?');
+		rp_name[3] = cpu_to_le16('\\');
+	}
 
 	return rp;
 out:
-- 
2.39.5


