Return-Path: <stable+bounces-8108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD8181A490
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F0E28C54B
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504ED46439;
	Wed, 20 Dec 2023 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pjSYmVTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C740BF5;
	Wed, 20 Dec 2023 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F24C433C8;
	Wed, 20 Dec 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088930;
	bh=KXy2jqle5TRpsDH5dnvqXAebxDqJ+8/JIB4pGaLTwPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjSYmVTazVEIs1poFj47riUm9zurYQk+T2uynox9BeenB/a/mmpPT1pIw8e+hC5fr
	 lbkQD/3H8uDT3cAFzrZiV8H+5oGnTg/XegFt2mNquSLS1SfgdRQccUfMYQAL6s769s
	 G7+yKCGnKnc4Yrx46u0j7ixkBpi24r5XliATwIM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Coverity Scan <scan-admin@coverity.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 093/159] ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
Date: Wed, 20 Dec 2023 17:09:18 +0100
Message-ID: <20231220160935.701811489@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 48b47f0caaa8a9f05ed803cb4f335fa3a7bfc622 ]

Uninitialized rd.delegated_inode can be used in vfs_rename().
Fix this by setting rd.delegated_inode to NULL to avoid the uninitialized
read.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -743,6 +743,7 @@ retry:
 	rd.new_dir		= new_path.dentry->d_inode,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);



