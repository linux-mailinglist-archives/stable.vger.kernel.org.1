Return-Path: <stable+bounces-12330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221A835613
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0286A2823AA
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9D374C9;
	Sun, 21 Jan 2024 14:31:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D333CE6
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847479; cv=none; b=pxVoX9xqX9iInn2nhlspd27+nGs0LRvNkKu97lc5VsDXfhfYR984ap2rvotjfRNTp0jF+4bb8ApFGeryPfSh5SEi57dToDoBJK9nPI4ia83tt6DF/fkAc3O1yBX3c4KedRSQxrur2jfhMC9v+jkxh2KoH1kgWyLseK2L15hq5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847479; c=relaxed/simple;
	bh=GMVBTC3qaS0pp3eJRifhsCzMl9hyshvsU+q5W6DIJF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YO+N/4G5BGDrUt+A13A3otzh2Uy/X27K41QsCjyZbtxuIdGx/iEFFaG8iwNzmXTs62TCS2rxOYmkwIYaP24yBRrk8mS2pWZ0WyERi4h8ghu72k5PjpDrngbWuckM2/h9KQ9OcrAraLb04yrChTHe/MkpwyxVkMHmV6za+rPzvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so864794a12.0
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847477; x=1706452277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U3ZMtUezmZZ5VYiirR1X9ZOQKnk9gaLr3tFMepwDHE=;
        b=SqQliyPWXbdkCLXJWZe7hRx/EAH5ktwR1oOmyt4Y8GStWpbsjHfdC/hBE76E6LgrH8
         b8y/lIlDjUvxp1xGeZ5JwbvGh+gTQD9vRFVMoTs35jWAepThR+RqzqXn39Ouo9Qqi4by
         GeoFCOXmr+V/c4QxWPVIReXolWldDL1XomiqxW7XH5cVZkHhD59ZhIolcnzyoOiSZN19
         UStfC6Bl+Dji88VRcMP7RrjWv+vPi4GJa+MdhgcbGZURTHVPTSTExUp23zDKbje5Xy6S
         i34Ri1IuSu6B9hlXSGJMPLQudUAjCyQ6JFOUrzSzY1cf1BbPrj8TcVTQwVlY/jolHoh+
         +00w==
X-Gm-Message-State: AOJu0YyV3WrV8sj8cIPtl2HwjkJKd9z8mxS/xTSSCyTaU8MEu83Sof0C
	tfi+iSCX7yIZPPmLxevVl+tU/ZfUiZoVAmKDnFsUzB+jt0wesigm
X-Google-Smtp-Source: AGHT+IGADE29rtRTGXuXwHMysc7Jf3akaCTJ5tnnCTQ7OBJhtG/iRh71keZPp0Ns4q6IuLKdXcp2fg==
X-Received: by 2002:a17:902:e548:b0:1d7:51e8:7cdc with SMTP id n8-20020a170902e54800b001d751e87cdcmr98078plf.124.1705847477077;
        Sun, 21 Jan 2024 06:31:17 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 05/11] ksmbd: don't allow O_TRUNC open on read-only share
Date: Sun, 21 Jan 2024 23:30:32 +0900
Message-Id: <20240121143038.10589-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d592a9158a112d419f341f035d18d02f8d232def ]

When file is changed using notepad on read-only share(read_only = yes in
ksmbd.conf), There is a problem where existing data is truncated.
notepad in windows try to O_TRUNC open(FILE_OVERWRITE_IF) and all data
in file is truncated. This patch don't allow  O_TRUNC open on read-only
share and add KSMBD_TREE_CONN_FLAG_WRITABLE check in smb2_set_info().

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 5975a2bc471f..4d6663ab3d03 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2969,7 +2969,7 @@ int smb2_open(struct ksmbd_work *work)
 					    &may_flags);
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
-		if (open_flags & O_CREAT) {
+		if (open_flags & (O_CREAT | O_TRUNC)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			rc = -EACCES;
@@ -5946,12 +5946,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
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
 
@@ -5971,12 +5965,6 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
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
 
@@ -6038,7 +6026,7 @@ int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
 	struct smb2_set_info_rsp *rsp;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
@@ -6058,6 +6046,13 @@ int smb2_set_info(struct ksmbd_work *work)
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
-- 
2.25.1


