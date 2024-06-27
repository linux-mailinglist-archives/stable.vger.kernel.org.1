Return-Path: <stable+bounces-55922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49491A035
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87808283F9B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C14374D4;
	Thu, 27 Jun 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGLI+EBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399C2F41;
	Thu, 27 Jun 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472637; cv=none; b=ZFcgP12bJJbQsgOHfndZV5d1P98l7T0/J/34TeXtfr6jAzD6V47MwXjVgeuPsqSbYVe6pNHgH2h0tw7PoCEmjEwLoRAJuA33NOY70/he3LKQy6V2eZbsdG/WSVmkQOqPd0kO4T1+83eh4uKTLWHhZs1GRRogqpdWf9tn79owJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472637; c=relaxed/simple;
	bh=1SaMfD2tmbpfNXEkMAGBWpGso//fdIqXP6/GKH5prbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PB2zaGb7NUYRRRXZJFc+SQcVkKSPMwz/HhqId0ADC4UnsGksAT3yjtr4yLhFa05NhL7gHgDws4SzX4xpBDVvKzKVkYJ/YZOzW68zhvIuAPYzgJKiN8sh5xgHMxEFAYmFqF+aVCo/S1YFSoOgRp5MdH/FR/rwB70PDXPpLYOaagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGLI+EBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A4C2BBFC;
	Thu, 27 Jun 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472636;
	bh=1SaMfD2tmbpfNXEkMAGBWpGso//fdIqXP6/GKH5prbg=;
	h=From:To:Cc:Subject:Date:From;
	b=mGLI+EBlhln9XA+39mawyx16KBTyQ4k7eF6f/HqJXaqGmsvFObWROwbURkrjeqIdZ
	 11MZwSFmAwgPBgvoZB1hCbIiwO9Gy449O98IoL3e6jb1PM+ACTKj1bEIvn9CKMGycz
	 RYMaL+X0VoyI0VMW8dO8W1zIqwtMhjwwDKFhKa7fQhCggdL44xdGeP3cNoI5Jh+ojD
	 OIfrz9CLlcM2bzvyh8QRLQfe1/I1Uf5lvec/Fp+b63AUqwrhkXdoerxwuDXMYbB3Vq
	 lU0D0Rju9+6uhr8QeT1BjsEXJkYUr3ijVcjQVnRuevb+K4HhIRk4QXvy7yJcJsQXI+
	 0/p+px7G0kr2Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to wait dio completion
Date: Thu, 27 Jun 2024 15:17:11 +0800
Message-Id: <20240627071711.1563420-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should wait all existing dio write IOs before block removal,
otherwise, previous direct write IO may overwrite data in the
block which may be reused by other inode.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 76a6043caf27..f2d0e0de775f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1056,6 +1056,13 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1892,6 +1899,12 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (ret)
 		goto out;
 
+	/*
+	 * wait for inflight dio, blocks should be removed after IO
+	 * completion.
+	 */
+	inode_dio_wait(inode);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.40.1


