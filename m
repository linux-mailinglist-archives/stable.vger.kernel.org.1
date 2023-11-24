Return-Path: <stable+bounces-1423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87747F7F92
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84124282520
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CD33090;
	Fri, 24 Nov 2023 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WebwGu9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB033CC2;
	Fri, 24 Nov 2023 18:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB8BC433C7;
	Fri, 24 Nov 2023 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851361;
	bh=BS+08XHBEddB4/hxG1qZ0sn1zFzjPtumJyu3vIfyDsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WebwGu9imjlAxjDaIaLRRjiC259qdI9Mf0jTPf0R/BY0gc3Skr9Iu8q7pFUOZvmEM
	 9a3t3LOeBP8ZrTLzG9G+25OV0Mp48HAVrUJA5fWsAuyA4oIndbohoOv2QNoewT9N7B
	 ZSJI1TaPqj6DQBJX+jpJ2wDWeB0ravs2daOE1C38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.5 418/491] f2fs: set the default compress_level on ioctl
Date: Fri, 24 Nov 2023 17:50:54 +0000
Message-ID: <20231124172037.164404042@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit f5f3bd903a5d3e3b2ba89f11e0e29db25e60c048 upstream.

Otherwise, we'll get a broken inode.

 # touch $FILE
 # f2fs_io setflags compression $FILE
 # f2fs_io set_coption 2 8 $FILE

[  112.227612] F2FS-fs (dm-51): sanity_check_compress_inode: inode (ino=8d3fe) has unsupported compress level: 0, run fsck to fix

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/file.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4006,6 +4006,15 @@ static int f2fs_ioc_set_compress_option(
 	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
 	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
 	F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
+	/* Set default level */
+	if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_ZSTD)
+		F2FS_I(inode)->i_compress_level = F2FS_ZSTD_DEFAULT_CLEVEL;
+	else
+		F2FS_I(inode)->i_compress_level = 0;
+	/* Adjust mount option level */
+	if (option.algorithm == F2FS_OPTION(sbi).compress_algorithm &&
+	    F2FS_OPTION(sbi).compress_level)
+		F2FS_I(inode)->i_compress_level = F2FS_OPTION(sbi).compress_level;
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!f2fs_is_compress_backend_ready(inode))



