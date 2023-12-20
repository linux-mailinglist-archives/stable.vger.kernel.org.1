Return-Path: <stable+bounces-8138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E581A4B2
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD51F24EF9
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3B495F5;
	Wed, 20 Dec 2023 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXOcmRye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD840C04;
	Wed, 20 Dec 2023 16:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102CDC433C8;
	Wed, 20 Dec 2023 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703089020;
	bh=XIRT19rmLV4/ZcXtM3MxSFG+br3nk5Tg/BX8XMQWf8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXOcmRye2jSc6s0JSnGcwqK6x7StC2EpEXDAcqd/LSlUXK+gww2cidqlP28lMzdop
	 d/mMMDFy8for7UXEsaYRca+1eB+0RrjmixYO35/j4j/xB4Fo5G48B39OPh+DdPJyvk
	 sFXR75yxARX7bIchJA+pUVPoP+AqgvNCV7Ho/qDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 141/159] ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
Date: Wed, 20 Dec 2023 17:10:06 +0100
Message-ID: <20231220160937.907720032@linuxfoundation.org>
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

[ Upstream commit 3354db668808d5b6d7c5e0cb19ff4c9da4bb5e58 ]

Fix argument list that the kdoc format and script verified in
ksmbd_vfs_setxattr().

fs/smb/server/vfs.c:929: warning: Function parameter or member 'path'
not described in 'ksmbd_vfs_setxattr'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/vfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -919,7 +919,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_n
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @user_ns:	user namespace
- * @dentry:	dentry to set XATTR at
+ * @path:	path of dentry to set XATTR at
  * @attr_name:	xattr name for setxattr
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value



