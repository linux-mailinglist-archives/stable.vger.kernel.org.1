Return-Path: <stable+bounces-83662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625EB99BE66
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9446C1C218F2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5613CFA3;
	Mon, 14 Oct 2024 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvtwkQqX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493413C8F6;
	Mon, 14 Oct 2024 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878258; cv=none; b=ulLv+pDlFZjHRFo5h2x5sHYgIKK8A9BUvzwBhAmBCmhsunM7yNyrnS09Rc9BNOt3pmLknG2Sza7w2do6ruVxpjPEPJBekl4z9Vi2ExUHn6Cmtm/CLkiDhg340LBrNaaxLGKWYi9138bVASvWYKR5WIpZVVZm6ougV5t9JK2Gh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878258; c=relaxed/simple;
	bh=z9OcayBpwyiIHOpmDyR4u03iynSDQHl0Sk5wNPpXcoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp75UIKoWZZipRNUC/XwMdDDoDsatdbb3Pw1+LkOavVL35F/LArSY/KD88XSNeyujm/MRU9oTF0nAqNGLNf8GPf7eYEK549Fxt8l3QfX2o/RcdJCpfqvmn0r6aghHOoYzAopOvUw1MrUaYX81kX02bAlM2GUPJUomxErprySTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvtwkQqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDC1C4CED0;
	Mon, 14 Oct 2024 03:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878258;
	bh=z9OcayBpwyiIHOpmDyR4u03iynSDQHl0Sk5wNPpXcoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvtwkQqXVfG/SGOMiH9HvqA2qR6e5CL/lK63ETvWKyIyVFmlC0lUyeN56P6qD6RhC
	 8/jR9T/QRzV0yUcBa/p2jJneydhjhDqrZJYzI1jQO/Gyp7McPfgc8zFXjFe4S/Ze23
	 ca71UVHmMbmuNyr6tRGAEExVYnW1k+s+4R87PQJWMM2ULxxqaIDSS3iuXLcPByi9Am
	 lPCo9nDHPyGYOf57QBtMQec1vln7X6k4MCOOKa1vbfmVOVt4+qG/JSrD25ylNey/H3
	 ICCrg11xqvp8x1Feo28XN0OxEGe2cCWaiD1IKUV2Jrnv2E4MpAYSvX17qXnpWjj+Ow
	 5Qux6dn+b91xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 04/20] fs/ntfs3: Stale inode instead of bad
Date: Sun, 13 Oct 2024 23:57:06 -0400
Message-ID: <20241014035731.2246632-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9 ]

Fixed the logic of processing inode with wrong sequence number.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 6b0bdc474e763..56b6c4c6f528f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -536,11 +536,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
-- 
2.43.0


