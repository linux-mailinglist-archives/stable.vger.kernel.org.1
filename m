Return-Path: <stable+bounces-7675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33A8175B6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50D41F2121F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316914238B;
	Mon, 18 Dec 2023 15:37:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AC498AE
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b47d9ae0cso877450a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913872; x=1703518672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BsTnvIPZKUJfchH7CS7P1JocPd+Ln2sQlF4GfGE2lo=;
        b=Ra9BGMsxmj3EZv2j4iNf14+EB7uBEgqbyGf9JIWJf49P5Hxh/OtWtT49LmNp3GJuE3
         6PBX9F8I03uvmJkjPgo2ktlsvcIU4UxweOYKLbd68ZEWqqzYIh0NYMdaarMZsjjq+5m4
         YuSa5AN6+Zxew4NPpXwfcTBXUqhpyOts1djHbdMjmJOKaokEkZsj00+ONhZw+/CoEexs
         9qI87GcYmVm9zCRgS+4J8NGY8U7JgqBm5R1DyOld1Fs04NT8XDbgOOxQc4EBNEkBIJb1
         nS3SoAzuP+HYPjTByBTX7WmTpKgXdmV9wpOQ261R6rhiz/MFRzCfm9AzFHeR42w91JcW
         YKXA==
X-Gm-Message-State: AOJu0Yz74CALGVWEjNDfjsr82Gb3fhQHpeiDCmdvPGg4cqJP+PUpmeDY
	D8Tux1vdABt12OIhBviyARo=
X-Google-Smtp-Source: AGHT+IF/HSwBZcPtN9D5cnQNYMYKwsTQISTJ/hkbLzJ8jeg9Qf5Dl2GltWnGHtoDlTM74m9tFERP+A==
X-Received: by 2002:a17:90a:d701:b0:28b:5955:e14b with SMTP id y1-20020a17090ad70100b0028b5955e14bmr895249pju.52.1702913870356;
        Mon, 18 Dec 2023 07:37:50 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:49 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 046/154] ksmbd: request update to stale share config
Date: Tue, 19 Dec 2023 00:33:06 +0900
Message-Id: <20231218153454.8090-47-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Atte Heikkilä <atteh.mailbox@gmail.com>

[ Upstream commit 4963d74f8a6cc0eafd71d9ffc13e3a11ff1dd160 ]

ksmbd_share_config_get() retrieves the cached share config as long
as there is at least one connection to the share. This is an issue when
the user space utilities are used to update share configs. In that case
there is a need to inform ksmbd that it should not use the cached share
config for a new connection to the share. With these changes the tree
connection flag KSMBD_TREE_CONN_FLAG_UPDATE indicates this. When this
flag is set, ksmbd removes the share config from the shares hash table
meaning that ksmbd_share_config_get() ends up requesting a share config
from user space.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_netlink.h     |  2 ++
 fs/ksmbd/mgmt/share_config.c |  6 +++++-
 fs/ksmbd/mgmt/share_config.h |  1 +
 fs/ksmbd/mgmt/tree_connect.c | 14 ++++++++++++++
 fs/ksmbd/smb2pdu.c           |  1 +
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index fae859d59c79..17ad22808ee3 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -350,6 +350,7 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
 #define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
 #define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
+#define KSMBD_SHARE_FLAG_UPDATE		BIT(14)
 
 /*
  * Tree connect request flags.
@@ -365,6 +366,7 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_TREE_CONN_FLAG_READ_ONLY		BIT(1)
 #define KSMBD_TREE_CONN_FLAG_WRITABLE		BIT(2)
 #define KSMBD_TREE_CONN_FLAG_ADMIN_ACCOUNT	BIT(3)
+#define KSMBD_TREE_CONN_FLAG_UPDATE		BIT(4)
 
 /*
  * RPC over IPC.
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index 70655af93b44..c9bca1c2c834 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -51,12 +51,16 @@ static void kill_share(struct ksmbd_share_config *share)
 	kfree(share);
 }
 
-void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+void ksmbd_share_config_del(struct ksmbd_share_config *share)
 {
 	down_write(&shares_table_lock);
 	hash_del(&share->hlist);
 	up_write(&shares_table_lock);
+}
 
+void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	ksmbd_share_config_del(share);
 	kill_share(share);
 }
 
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 28bf3511763f..902f2cb1963a 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -64,6 +64,7 @@ static inline int test_share_config_flag(struct ksmbd_share_config *share,
 	return share->flags & flag;
 }
 
+void ksmbd_share_config_del(struct ksmbd_share_config *share);
 void __ksmbd_share_config_put(struct ksmbd_share_config *share);
 
 static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index dd262daa2c4a..97ab7987df6e 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -57,6 +57,20 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto out_error;
 
 	tree_conn->flags = resp->connection_flags;
+	if (test_tree_conn_flag(tree_conn, KSMBD_TREE_CONN_FLAG_UPDATE)) {
+		struct ksmbd_share_config *new_sc;
+
+		ksmbd_share_config_del(sc);
+		new_sc = ksmbd_share_config_get(share_name);
+		if (!new_sc) {
+			pr_err("Failed to update stale share config\n");
+			status.ret = -ESTALE;
+			goto out_error;
+		}
+		ksmbd_share_config_put(sc);
+		sc = new_sc;
+	}
+
 	tree_conn->user = sess->user;
 	tree_conn->share_conf = sc;
 	status.tree_conn = tree_conn;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 1c674a7b2b39..d87a051da11c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1985,6 +1985,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_SUCCESS;
 		rc = 0;
 		break;
+	case -ESTALE:
 	case -ENOENT:
 	case KSMBD_TREE_CONN_STATUS_NO_SHARE:
 		rsp->hdr.Status = STATUS_BAD_NETWORK_NAME;
-- 
2.25.1


