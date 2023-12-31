Return-Path: <stable+bounces-9036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CE8209F5
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F921F2167E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78D17C2;
	Sun, 31 Dec 2023 07:13:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54917C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce2170b716so3476049a12.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006830; x=1704611630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbSM58gqAmOIrIexSrfIJvAeoG5XyRoAqldQllqk9jw=;
        b=BsALfvz861dqPZXHieb3bqNj6bqQYoEfE07VNdgnrZWmcbiDE3/vTEpHBZvCnxft57
         7Pu90To70CbkOEIp8zQq0UyjvzSqd/79uoCr/EHF0v6VJD4vJwULgrUImwKJD1De3qSr
         F8/Zp/VCL3gBE+SBXw4J8gaMnJvT4R28Y1WZ4mVNggPnyQkN8ABHrQ5LFnCXQdth76yS
         wzYxQY+6cYzuHgSXdixNCA6khW7B2HucZ6m0swaYGTLo43O5YouWZVe6oXXjL09hoxK8
         EDHZR2sjGw0SbE7Ljz3S8K0z95uPjC5ye+Vfq1nAnQetVKp2LRC48g4KYj+1H1A++GAH
         721Q==
X-Gm-Message-State: AOJu0YyWyXQHLqFCqx5FdSkab1rbJfU9FouvllhGJOArBn9v6hd6l4w5
	B7d09yFv5x3FdcL2yx0pPkI=
X-Google-Smtp-Source: AGHT+IHnujpGz9w5d5xmW7tJnSWwRucegw9nCnpf1oEgy6axuu3cw7irM9o5p3Rvw598WdrHEi5qFg==
X-Received: by 2002:a05:6a20:6309:b0:196:58be:c939 with SMTP id h9-20020a056a20630900b0019658bec939mr4248118pzf.64.1704006829698;
        Sat, 30 Dec 2023 23:13:49 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:13:49 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 02/73] ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data encryption for this share
Date: Sun, 31 Dec 2023 16:12:21 +0900
Message-Id: <20231231071332.31724-3-linkinjeon@kernel.org>
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

[ Upstream commit 37ba7b005a7a4454046bd8659c7a9c5330552396 ]

Currently, SMB2_SESSION_FLAG_ENCRYPT_DATA is always set session setup
response. Since this forces data encryption from the client, there is a
problem that data is always encrypted regardless of the use of the cifs
seal mount option. SMB2_SESSION_FLAG_ENCRYPT_DATA should be set according
to KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION flags, and in case of
KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF, encryption mode is turned off for
all connections.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_netlink.h |  1 +
 fs/smb/server/smb2ops.c       | 10 ++++++++--
 fs/smb/server/smb2pdu.c       |  8 +++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index ce866ff159bf..fb8b2d566efb 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -74,6 +74,7 @@ struct ksmbd_heartbeat {
 #define KSMBD_GLOBAL_FLAG_SMB2_LEASES		BIT(0)
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
 #define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF	BIT(3)
 
 /*
  * IPC request for ksmbd server startup
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index ab23da2120b9..e401302478c3 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -247,8 +247,9 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
-	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
@@ -271,6 +272,11 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3f4f6b038565..f5a46b683163 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -935,7 +935,7 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 		return;
 	}
 
-	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION))
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF)
 		return;
 
 	for (i = 0; i < cph_cnt; i++) {
@@ -1544,7 +1544,8 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 			return -EINVAL;
 		}
 		sess->enc = true;
-		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
 		/*
 		 * signing is disable if encryption is enable
 		 * on this session
@@ -1630,7 +1631,8 @@ static int krb5_authenticate(struct ksmbd_work *work,
 			return -EINVAL;
 		}
 		sess->enc = true;
-		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
 		sess->sign = false;
 	}
 
-- 
2.25.1


