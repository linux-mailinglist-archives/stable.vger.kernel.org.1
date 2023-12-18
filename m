Return-Path: <stable+bounces-7694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EC8175D4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574F31C24E30
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD525BFB5;
	Mon, 18 Dec 2023 15:38:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEA5A86A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo497836a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913931; x=1703518731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkz+m/NHYTykloz0KCKD28mssqnQQt2HNF6sWjzSZiA=;
        b=NVaZNXUXhtqhWfW+n/rB4BGa4mlHTbXeXUxzgwz1tpKIR5NG+uSOM30uZ++12y470g
         HEo1Mimh1C8SqtMFRDpVwUDKzPFlkkI+Aw8tUlrhfz5rzvtjVkJsxpnHT32newtkyWc+
         u4PyniEbI5TsOs1zmejblIJxPi3xyG1mg+LnvQsy3Xwh+YnrTkEApPm+ZFHt+/kkiZFe
         xfaJKBtN8l7+WaDjIsB49n9tHqYt9bJX7JiIbntuKdonrmijvm2zVJ5TWMwQPumGfooQ
         yDMzZ0O6gnsjqeoGBcL/ddxWYC79F/2gfID3OR+a6T6SjkAIAJnL6JujX/qQPS1yZgyb
         279Q==
X-Gm-Message-State: AOJu0YyCYixzSMhHvKPXBXzdGkRToL47PlyZNMHJmmVsYSvlNOd6LQ0/
	874r7fDPtnyPr7XI1FYu/tqY1Kxsdtg=
X-Google-Smtp-Source: AGHT+IFN3aJh+t7JrM7LimO5jDsoieD3TNAhYB3Vbd6jd8kiG+0ZF/1uiv9O8UhhKk6ajvZbG4aeDg==
X-Received: by 2002:a17:90a:5797:b0:286:6cc1:5fde with SMTP id g23-20020a17090a579700b002866cc15fdemr6904434pji.97.1702913931306;
        Mon, 18 Dec 2023 07:38:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 065/154] ksmbd: set SMB2_SESSION_FLAG_ENCRYPT_DATA when enforcing data encryption for this share
Date: Tue, 19 Dec 2023 00:33:25 +0900
Message-Id: <20231218153454.8090-66-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
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
 fs/ksmbd/ksmbd_netlink.h |  1 +
 fs/ksmbd/smb2ops.c       | 10 ++++++++--
 fs/ksmbd/smb2pdu.c       |  8 +++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index dd760c78af7b..fb9626383f86 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -74,6 +74,7 @@ struct ksmbd_heartbeat {
 #define KSMBD_GLOBAL_FLAG_SMB2_LEASES		BIT(0)
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
 #define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF	BIT(3)
 
 /*
  * IPC request for ksmbd server startup
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index f0a5b704f301..9138e1c29b22 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -248,8 +248,9 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
-	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
@@ -272,6 +273,11 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 5868dcbb8062..a40c737ae280 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -934,7 +934,7 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 		return;
 	}
 
-	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION))
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF)
 		return;
 
 	for (i = 0; i < cph_cnt; i++) {
@@ -1538,7 +1538,8 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 			return -EINVAL;
 		}
 		sess->enc = true;
-		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
 		/*
 		 * signing is disable if encryption is enable
 		 * on this session
@@ -1629,7 +1630,8 @@ static int krb5_authenticate(struct ksmbd_work *work)
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


