Return-Path: <stable+bounces-4193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26362804674
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54D6280F09
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAC79F2;
	Tue,  5 Dec 2023 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jgNrV7Fw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C36FAF;
	Tue,  5 Dec 2023 03:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F327C433C8;
	Tue,  5 Dec 2023 03:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746872;
	bh=8yMqmgwWMJ5cGNvXA2Goi44++eCKehhXedtGJLOj3YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgNrV7FwyGx0kL3BeICDB5Cm4ImNo9gYuz29bOXj1qpESMlCYncAtOCY1hjQc05eG
	 eRolQOKBoCmLRPFUIwpRMQhKS75VX5AjH/f2ee4lCn3sr8BCodQgW9ElylOCcGabn/
	 Euh7TJuQZ/PPLCpkOVB9LP2EOA/JADfvdQV9nvh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Micah Veilleux <micah.veilleux@iba-group.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 51/71] smb3: fix touch -h of symlink
Date: Tue,  5 Dec 2023 12:16:49 +0900
Message-ID: <20231205031520.835105563@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 475efd9808a3094944a56240b2711349e433fb66 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ef1a43f4bd663..7c9e5ed1644b0 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -970,6 +970,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
-- 
2.42.0




