Return-Path: <stable+bounces-8605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B520C81EE2C
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F812833A8
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A92CCD1;
	Wed, 27 Dec 2023 10:26:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95842C867
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so614372b3a.2
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672797; x=1704277597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGh/5NxuNs0h69ng/7wR9n+ZMBByWOXDMLJt8zLjMbY=;
        b=VE0gKJ8+6+8jvlMfzevXEPRJMKL4JTxY8G/fPRPlTtx5dXdMiGS+dwCLSIJ418OP/8
         vPY8yzKqF4J90sezlp6D6cO6VvgJd1jdZekzQNkPg1KYZ0I/pqPCVSs76ENy+3SxytC+
         rCejcMS1SKGCAVlnax2WuMQOk35iNlIKRnpo8VSkiEKcHFh1ialiaOeESFH84OhIvvkh
         KzH0dMcujTuG7rsWa+6aoKKGaLTipcFmZPuBsPNgXODeBqREnKEVB8sJXuyw3t1boCEG
         3Hk8PCGozKgkMB/Pm4tTYxDLqnnVRdJD0rXHHBxrAjXWbA3vEaTHw7vT3WYYRTl/wGo5
         io5Q==
X-Gm-Message-State: AOJu0Yw35pEg7hod3/B3ljPfmNz3xtgkhBji/trKZhvr0XTTWjdyMCzB
	vtibTagTR+qnM8xBkex5aSg=
X-Google-Smtp-Source: AGHT+IHiOoXTj9JD0JnNitDenccSBwS/lcjlGJ8Ovaeo2kyJGoRa4cZ1gofK0LIESN0cw+9lusBaVA==
X-Received: by 2002:a05:6a00:92a9:b0:6d9:b14e:1094 with SMTP id jw41-20020a056a0092a900b006d9b14e1094mr2244907pfb.16.1703672797152;
        Wed, 27 Dec 2023 02:26:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 3/8] ksmbd: set v2 lease capability
Date: Wed, 27 Dec 2023 19:26:00 +0900
Message-Id: <20231227102605.4766-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
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


