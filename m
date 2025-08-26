Return-Path: <stable+bounces-174403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88AB3636E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D142A75FD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE6321457;
	Tue, 26 Aug 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEAw+LXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7B23FC41;
	Tue, 26 Aug 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214297; cv=none; b=ZjcvGMKGpLNj3ape3n6iQPPe4v/JxPBKa+qgam6x8oSYsUmtwqDyNTAhoyPUigRt6IBqnghEaecOtwtBsOp71NC9AJ8iRP7GHNAUt3wGZcfpgAh3C1PpxuBKFzbqAYRUKAS2z8kaN3ERIF86tjECqN/4GJzDssPHhBOPZYm8jgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214297; c=relaxed/simple;
	bh=f8P+cyVPnC2ImrXEehcyugOIwfNedGvoQaaO5KLyajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0BIz8an4ZR+m9nezVvETPGiCCyf2MhCNlXGSlgyGyI/OgI3A39/VKcEKXyA4oe73iF9A9YZYQ45PSJFQQ/1CbqVQApM99anUs3YbUG2i3UQViEabmNeHiU4hjQgHUjKViEv2hMH+KZIK0b64wV+G7GX/FXjKv2T7ipTv7os0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEAw+LXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0021DC4CEF1;
	Tue, 26 Aug 2025 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214297;
	bh=f8P+cyVPnC2ImrXEehcyugOIwfNedGvoQaaO5KLyajo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEAw+LXM0Msb8wyymeI1wDaq9DbPMkf2qikQbC+rUGKVbqODRZC1lpivi6PIkTO4t
	 V8qls3aTKtPzCQZIZuLvzK6rpojpomMSJsH/ZbWa/nOTwlNdrYql4IrplHRtxHXiDx
	 +wxn9jQYX2fLRjHyE8ez5iklmFKenIFeAEp99IB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/482] smb/server: avoid deadlock when linking with ReplaceIfExists
Date: Tue, 26 Aug 2025 13:05:07 +0200
Message-ID: <20250826110932.158070922@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

[ Upstream commit d5fc1400a34b4ea5e8f2ce296ea12bf8c8421694 ]

If smb2_create_link() is called with ReplaceIfExists set and the name
does exist then a deadlock will happen.

ksmbd_vfs_kern_path_locked() will return with success and the parent
directory will be locked.  ksmbd_vfs_remove_file() will then remove the
file.  ksmbd_vfs_link() will then be called while the parent is still
locked.  It will try to lock the same parent and will deadlock.

This patch moves the ksmbd_vfs_kern_path_unlock() call to *before*
ksmbd_vfs_link() and then simplifies the code, removing the file_present
flag variable.

Signed-off-by: NeilBrown <neil@brown.name>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3e2cd22fb2bd..7943b2ee2a76 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5648,7 +5648,6 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path, parent_path;
-	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5681,11 +5680,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-	} else
-		file_present = true;
-
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
+	} else {
+		if (file_info->ReplaceIfExists) {
 			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
@@ -5693,21 +5689,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 					    link_name);
 				goto out;
 			}
-		}
-	} else {
-		if (file_present) {
+		} else {
 			rc = -EEXIST;
 			ksmbd_debug(SMB, "link already exists\n");
 			goto out;
 		}
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 	}
-
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
 		rc = -EINVAL;
 out:
-	if (file_present)
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
 	if (!IS_ERR(link_name))
 		kfree(link_name);
-- 
2.39.5




