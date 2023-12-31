Return-Path: <stable+bounces-9102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A3B820A38
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AE71C214DB
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B717C3;
	Sun, 31 Dec 2023 07:17:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD017C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da202aa138so1869659b3a.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007059; x=1704611859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71BMVEHusEun2Occ2fXe4v6HV1Sd0+BM9EJjpCHSnQk=;
        b=kJ9X6pzCgzsao6aeu2ElZ+1GGhgrNjvl4yZ9YeJWDehESZpeT6N/2Yucxg5RUSXIA+
         057aAG2nfWf/JEam8r9Fybp1IskAlOeA6bcsuPrhTc7HQfjh/r1kpoi5045cf3Nu9z6O
         KgKVd3zCkY9xIBvCGyLcVeqIu5A77nXE+H2m+H/ZogWZzBDNoDEndqkkh9rr3pFkEU8Q
         4N+O/5wqPEDIdm0qcFIC8SRGklGCvisriGbgoeuXTJGgDyzyA92ARlss3e7RsHmoF5Tw
         rUAJyBS0uYDSSEHkkqV7mwPKuxWDRdJCIj7WDrY4RhZRpSI46ahNZVVS24fBNHQ608PS
         bK/w==
X-Gm-Message-State: AOJu0Yxy4pV/NIiD+w23/1emAbmBP3Eg0R6b7wg1xEBZmkbrVBycdsPM
	aPSJ2vZ/KDAbn5dXKPkVR/0=
X-Google-Smtp-Source: AGHT+IF/yEWoj7MXZ7p/QPeCCH6FmZyYz8Bbn1OkRhPI+Hl3UeN+BBSCsgbwAWPF5hoU8GnjgAjwfw==
X-Received: by 2002:a05:6a21:a59b:b0:196:4761:3f4a with SMTP id gd27-20020a056a21a59b00b0019647613f4amr7347585pzc.123.1704007058858;
        Sat, 30 Dec 2023 23:17:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:38 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 68/73] ksmbd: set v2 lease capability
Date: Sun, 31 Dec 2023 16:13:27 +0900
Message-Id: <20231231071332.31724-69-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/oplock.c  | 4 ----
 fs/smb/server/smb2ops.c | 9 ++++++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 037316c78506..7346cbfbff6b 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
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
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index e401302478c3..535402629655 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -221,7 +221,8 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
@@ -245,7 +246,8 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
@@ -270,7 +272,8 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
-- 
2.25.1


