Return-Path: <stable+bounces-1394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB97F7F6E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33152824EA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B534189;
	Fri, 24 Nov 2023 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrvpaH5+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1633CC7;
	Fri, 24 Nov 2023 18:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10A3C433C8;
	Fri, 24 Nov 2023 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851289;
	bh=pm6b3LyfdndFWMDSDREORDBdhOuLQGKbKthJCXtc3Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zrvpaH5+I6mMqHsddWBzC0PRAV2qdn8KXj215TPSpL1z0OPk33GA5m8JIf/RfC5sb
	 wHCO1FCzEvd6wd4FuAOuhe1LdCQnoV5RYuCie1H+7HickQvwh08ls1l4pNUhTS9HdE
	 CA8o6mNmnnKPD3cRX4NaPnwRVT8q7ntQCPt4IJ8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 389/491] smb3: fix caching of ctime on setxattr
Date: Fri, 24 Nov 2023 17:50:25 +0000
Message-ID: <20231124172036.289386254@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 5923d6686a100c2b4cabd4c2ca9d5a12579c7614 upstream.

Fixes xfstest generic/728 which had been failing due to incorrect
ctime after setxattr and removexattr

Update ctime on successful set of xattr

Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/xattr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -150,10 +150,13 @@ static int cifs_xattr_set(const struct x
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 			goto out;
 
-		if (pTcon->ses->server->ops->set_EA)
+		if (pTcon->ses->server->ops->set_EA) {
 			rc = pTcon->ses->server->ops->set_EA(xid, pTcon,
 				full_path, name, value, (__u16)size,
 				cifs_sb->local_nls, cifs_sb);
+			if (rc == 0)
+				inode_set_ctime_current(inode);
+		}
 		break;
 
 	case XATTR_CIFS_ACL:



