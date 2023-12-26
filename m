Return-Path: <stable+bounces-8578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008F81E6FD
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AFDB21835
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF04E1A5;
	Tue, 26 Dec 2023 10:54:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BA4E1A9
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso1233121a12.1
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588049; x=1704192849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGh/5NxuNs0h69ng/7wR9n+ZMBByWOXDMLJt8zLjMbY=;
        b=X56E2ZuM3okt+YNppqF5pIzBQvJjMcqpPo0bSycFh15u1QZ+qogH/GhIohvWayk9hb
         KIJ6wXOVgEu4gz+b2J2Z5Tbud1AZMhw4U/BPwmmmEEB9lr2blvDYn0WiMMe69Rno9LZz
         O/FzWhQ+HD2qHyIlwferhvnZEs7RTbyhgR2k8jkH6Kj6u/D8iQqXOM3SNuk5yMT895wI
         kDzMo7AMTaMccNAJlVnf04wKw5C49GXCoS5T/DNx2F7y6Fj13GcMkCJ3pFEDZqeEbs3J
         jGMJwBBpbmhkw2FAPxbZGnmapOJA3LJVC22FZtTE/52ZzKy50hEYza4JHTMuOfPqKfiq
         27sg==
X-Gm-Message-State: AOJu0YwquRVwLjl/EjRi7vte1qpiHjo7Q8B/YWJG8Jp2D1IJBuC2BYPP
	RxnEs+zuK++aYkRpj3cBtV4=
X-Google-Smtp-Source: AGHT+IFqGc2mQTxyDRrzj/Txx9vOidvyzSQs+2BCrJxsiYxKkaGZOzOAqPfyI0GT9b6iW3y5lVnFnw==
X-Received: by 2002:a05:6a20:6296:b0:195:2770:5b7e with SMTP id o22-20020a056a20629600b0019527705b7emr1884833pze.119.1703588049116;
        Tue, 26 Dec 2023 02:54:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:08 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 3/8] ksmbd: set v2 lease capability
Date: Tue, 26 Dec 2023 19:53:28 +0900
Message-Id: <20231226105333.5150-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 18dd1c367c31d0a060f737d48345747662369b64 ]

Set SMB2_GLOBAL_CAP_DIRECTORY_LEASING to ->capabilities to inform server
support directory lease to client.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 4 ----
 fs/ksmbd/smb2ops.c | 9 ++++++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index ed639b7b6509..24716dbe7108 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1105,10 +1105,6 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
-	/* not support directory lease */
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return 0;
-
 	opinfo = alloc_opinfo(work, pid, tid);
 	if (!opinfo)
 		return -ENOMEM;
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index 9138e1c29b22..c69943d96565 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -222,7 +222,8 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
@@ -246,7 +247,8 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
@@ -271,7 +273,8 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
-- 
2.25.1


