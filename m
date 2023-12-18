Return-Path: <stable+bounces-7720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5788175F0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEFF1C2425E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685471448;
	Mon, 18 Dec 2023 15:40:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815E49883
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28ba05b28adso400612a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914016; x=1703518816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSeHaT52u0rfJ6jX6xvipB6Q+7h6KRMSQGRXB7xNw4k=;
        b=TpbhVALJMnBNuaesmZvfI5yiZEqitA+597jvH7sT/+lV0zjy/ULxeV6BYGCusRzVaj
         /dLoIzHQ8XveJDa/J1vynlIXWUijbq6DdQHK5P/Z9FVF14QQN1ISW7LJYPqkuaNLGkjE
         0O9eqzveSzEerH1Q5lLB6M+LyshVxHz6wW4rLSgGtilwdsG/rniC2jriX53haPGOct6x
         vGqSEkjuXiG1H8YnVv2d7r+t6Me4sukGQYtD83aXCf/xYH069UX+yu+XeNQgW5bm/l/e
         i0DE7CQQzHTcKeSBL6hCXNnHylRh+5A/69vyVubcwpKgipnKk+uAMVrrpADdZT48ziuu
         rIZQ==
X-Gm-Message-State: AOJu0YxMjyBjW6lKZuQV+/FUEOzINe+f30e2Vzr156jviKO1F8Fbmbji
	hvat1xrlE81BFRrA9s0hepU=
X-Google-Smtp-Source: AGHT+IEO1E493uM2I0QeTnxFqcCYe3+Qyewl5ouBobqpfsWUhv/WA3OlqruCO7ZxD1KlWA07gCCwpg==
X-Received: by 2002:a17:90a:c70d:b0:28b:6f03:68a9 with SMTP id o13-20020a17090ac70d00b0028b6f0368a9mr740208pjt.83.1702914016375;
        Mon, 18 Dec 2023 07:40:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:15 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 092/154] ksmbd: fix racy issue under cocurrent smb2 tree disconnect
Date: Tue, 19 Dec 2023 00:33:52 +0900
Message-Id: <20231218153454.8090-93-linkinjeon@kernel.org>
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

[ Upstream commit 30210947a343b6b3ca13adc9bfc88e1543e16dd5 ]

There is UAF issue under cocurrent smb2 tree disconnect.
This patch introduce TREE_CONN_EXPIRE flags for tcon to avoid cocurrent
access.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20592
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/tree_connect.c | 10 +++++++++-
 fs/ksmbd/mgmt/tree_connect.h |  3 +++
 fs/ksmbd/smb2pdu.c           |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index aa9c138d5851..f07a05f37651 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -109,7 +109,15 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 						  unsigned int id)
 {
-	return xa_load(&sess->tree_conns, id);
+	struct ksmbd_tree_connect *tcon;
+
+	tcon = xa_load(&sess->tree_conns, id);
+	if (tcon) {
+		if (test_bit(TREE_CONN_EXPIRE, &tcon->status))
+			tcon = NULL;
+	}
+
+	return tcon;
 }
 
 struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 0f97ddc1e39c..700df36cf3e3 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -14,6 +14,8 @@ struct ksmbd_share_config;
 struct ksmbd_user;
 struct ksmbd_conn;
 
+#define TREE_CONN_EXPIRE		1
+
 struct ksmbd_tree_connect {
 	int				id;
 
@@ -25,6 +27,7 @@ struct ksmbd_tree_connect {
 
 	int				maximal_access;
 	bool				posix_extensions;
+	unsigned long			status;
 };
 
 struct ksmbd_tree_conn_status {
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 99f61aae0c95..c492e7f73a7e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2083,11 +2083,12 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
-	if (!tcon) {
+	if (!tcon || test_and_set_bit(TREE_CONN_EXPIRE, &tcon->status)) {
 		struct smb2_tree_disconnect_req *req =
 			smb2_get_msg(work->request_buf);
 
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
 		return 0;
-- 
2.25.1


