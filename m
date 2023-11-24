Return-Path: <stable+bounces-1417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA417F7F8C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEABA1C214CE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2A3306F;
	Fri, 24 Nov 2023 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLXQLj/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A392FC4E;
	Fri, 24 Nov 2023 18:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F8C433C7;
	Fri, 24 Nov 2023 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851346;
	bh=toMttqYUlldSm2cP7xYmVjaNgn8OxRIa8wCkfoLOUh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLXQLj/1jGgaitJzkmAbXd3Jvhccu7ncBN0h2HDmus+Ex1E6p693RnYHLTg/8P4Nz
	 tTdOVBPvkDmuSOSYPVxrS0Rac6kxOEcEeQIvtzKaBqAnL+H6S9M+8oXfpFdq0UJf9F
	 9zwBVTXua+QSUCn9GhtmmcOkLsMfZoEDV66tqslw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Micah Veilleux <micah.veilleux@iba-group.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 387/491] smb3: fix touch -h of symlink
Date: Fri, 24 Nov 2023 17:50:23 +0000
Message-ID: <20231124172036.224972124@linuxfoundation.org>
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

commit 475efd9808a3094944a56240b2711349e433fb66 upstream.

For example:
      touch -h -t 02011200 testfile
where testfile is a symlink would not change the timestamp, but
      touch -t 02011200 testfile
does work to change the timestamp of the target

Suggested-by: David Howells <dhowells@redhat.com>
Reported-by: Micah Veilleux <micah.veilleux@iba-group.com>
Closes: https://bugzilla.samba.org/show_bug.cgi?id=14476
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1191,6 +1191,7 @@ const char *cifs_get_link(struct dentry
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };



