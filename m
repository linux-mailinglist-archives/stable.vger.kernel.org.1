Return-Path: <stable+bounces-4428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E7804771
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE14D1C20E31
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713A8BF8;
	Tue,  5 Dec 2023 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNBxbeVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4156FB1;
	Tue,  5 Dec 2023 03:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A6C433C9;
	Tue,  5 Dec 2023 03:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747518;
	bh=3OqhL9HCaJyMELEuXlzifuPheHyixgdAxpV47+NuMeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNBxbeVxZSMtL1Y6oqndh2BCutUO3H8+0m4Y2gJ3IW13ay2PihClNFbq+czeCKjOG
	 hlXTEn4phGZ97Txjaa0pJj2IDWX5gqLzWJdKT/YdSOZ3ai06ZmnfgDzMlLL/JB0tx3
	 LvX7ZmHW8G5iM/KrJzdmsN7mvTbmkIF4Dk945vXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Micah Veilleux <micah.veilleux@iba-group.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 105/135] smb3: fix touch -h of symlink
Date: Tue,  5 Dec 2023 12:17:06 +0900
Message-ID: <20231205031537.361029879@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 0d8d7b57636f7..b87d6792b14ad 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1076,6 +1076,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
-- 
2.42.0




