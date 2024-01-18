Return-Path: <stable+bounces-12043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF374831775
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B380287DF3
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3522F06;
	Thu, 18 Jan 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TLrOATdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99D1B96D;
	Thu, 18 Jan 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575446; cv=none; b=k39vHatpC7yUKq6HfMNQK8Df/LSA73lIJiCIyysIbrUl7LZkfFmMQih2IaUZX6UBIGruK/dO5ZpmtMi1cEZgW7jfbEA4Lp3kI5i7HcqIfMlgMNuM/4ueul6U01nZJ3Cq2YWLizdST3HtsSMcJ2TDK8p3be3Hsz9bE/DvHZVjnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575446; c=relaxed/simple;
	bh=pD3Ff4N61INp0K/CRrXl6509sxd2Pyt4Y8O69Fx5Thg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=ERF7uJdezCkkUc/woLNwpCXquD6tN98btjB9vePXlm9+7Jfh0mVaHnesCC0YTrEvHHhEyUu7L1EQ94tSNwy3Krq+M3F3vKF22vNArExwGSLGNV+Eds+I1wlr87cow6JxlEOsYa6O2OxRfeQ3fBgxYwrnAxm3I1hLxXU5Y0t5WV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLrOATdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D170C433C7;
	Thu, 18 Jan 2024 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575446;
	bh=pD3Ff4N61INp0K/CRrXl6509sxd2Pyt4Y8O69Fx5Thg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLrOATdo9JKzVlkKd5DYpyQOv4lGejOfSNJ21AmTvA0FvFUkN1UXLhzLI6UdyHAXv
	 RLFWSqiYuk/oiGjYXgT10kwWpwDjtYD593tSqytZvJRfj7WLEj4rBAwSFgq9Ybmwza
	 XyQYSKCGmmN5WXMqDdxsEupIrX4kEyTnO+6az1Ts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 136/150] ksmbd: dont allow O_TRUNC open on read-only share
Date: Thu, 18 Jan 2024 11:49:18 +0100
Message-ID: <20240118104326.347205267@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit d592a9158a112d419f341f035d18d02f8d232def upstream.

When file is changed using notepad on read-only share(read_only = yes in
ksmbd.conf), There is a problem where existing data is truncated.
notepad in windows try to O_TRUNC open(FILE_OVERWRITE_IF) and all data
in file is truncated. This patch don't allow  O_TRUNC open on read-only
share and add KSMBD_TREE_CONN_FLAG_WRITABLE check in smb2_set_info().

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2971,7 +2971,7 @@ int smb2_open(struct ksmbd_work *work)
 					    &may_flags);
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-		if (open_flags & O_CREAT) {
+		if (open_flags & (O_CREAT | O_TRUNC)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			rc = -EACCES;
@@ -5943,12 +5943,6 @@ static int smb2_set_info_file(struct ksm
 	}
 	case FILE_RENAME_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_rename_info))
 			return -EINVAL;
 
@@ -5968,12 +5962,6 @@ static int smb2_set_info_file(struct ksm
 	}
 	case FILE_DISPOSITION_INFORMATION:
 	{
-		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-			ksmbd_debug(SMB,
-				    "User does not have write permission\n");
-			return -EACCES;
-		}
-
 		if (buf_len < sizeof(struct smb2_file_disposition_info))
 			return -EINVAL;
 
@@ -6035,7 +6023,7 @@ int smb2_set_info(struct ksmbd_work *wor
 {
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
@@ -6055,6 +6043,13 @@ int smb2_set_info(struct ksmbd_work *wor
 		rsp = smb2_get_msg(work->response_buf);
 	}
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		pr_err("User does not have write permission\n");
+		rc = -EACCES;
+		goto err_out;
+	}
+
 	if (!has_file_id(id)) {
 		id = req->VolatileFileId;
 		pid = req->PersistentFileId;



