Return-Path: <stable+bounces-7746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D4817616
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406D6B24431
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CF740B3;
	Mon, 18 Dec 2023 15:41:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A974092
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso632681a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914098; x=1703518898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6hqRU/cFw/MG4nB7qNZHYWLJ/fiWmzZ4nkKvVX1lhQ=;
        b=UhYuYgupjrGHdb6h8WDzo3T5Oo2f7QIbcWxYBlqkjcSsLKgndM0A1yBZbgUHMXx4nM
         T+Q3asPOmsP3g5hwPu0qhV9QYYueKm16HoEKpaU1VcIW/n+9mdIwxMLe25+9U2b4E9Ry
         Bd+LEAu1ykcfg/kQTBGLZsd9lI6fGIxIEIi46RJTqysoJI+Cu6U+jDIvS6Aw1rFmjwIk
         cz3daqhYCnlZuyV7KbRX+uuVosoBaF6X5JZgBovhvO59Q0nyd/HWCBM1N4rdqHkBm2et
         kuMamB0rl+LBn/6SvMFfTlzrZ1qAlNbqskLQpzhKU6Udo3MGrkUJomJaUMd5aRfL/aio
         OQGw==
X-Gm-Message-State: AOJu0YzRngJksKAa7DU+Qn42jOkhypBJpLHRkurlj4p9BB5AJB9ofKQt
	/ihAHksTO8BJ3rl6g4F/ris=
X-Google-Smtp-Source: AGHT+IEEZmnzLxYGB1NthORADdTFQCBo5rYX2PaA6/pIJDmvuqv1sEy3IU6G69bkAsq4x82kJOnEPw==
X-Received: by 2002:a17:90a:2b09:b0:28a:fdc6:7635 with SMTP id x9-20020a17090a2b0900b0028afdc67635mr3193346pjc.38.1702914097751;
        Mon, 18 Dec 2023 07:41:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 117/154] ksmbd: fix out of bounds in init_smb2_rsp_hdr()
Date: Tue, 19 Dec 2023 00:34:17 +0900
Message-Id: <20231218153454.8090-118-linkinjeon@kernel.org>
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

[ Upstream commit 536bb492d39bb6c080c92f31e8a55fe9934f452b ]

If client send smb2 negotiate request and then send smb1 negotiate
request, init_smb2_rsp_hdr is called for smb1 negotiate request since
need_neg is set to false. This patch ignore smb1 packets after ->need_neg
is set to false.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21541
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/server.c     |  7 ++++++-
 fs/ksmbd/smb_common.c | 19 +++++++++++--------
 fs/ksmbd/smb_common.h |  2 +-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 14df83c20557..0c0db2e614ef 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -286,6 +286,7 @@ static void handle_ksmbd_work(struct work_struct *wk)
 static int queue_ksmbd_work(struct ksmbd_conn *conn)
 {
 	struct ksmbd_work *work;
+	int err;
 
 	work = ksmbd_alloc_work_struct();
 	if (!work) {
@@ -297,7 +298,11 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	work->request_buf = conn->request_buf;
 	conn->request_buf = NULL;
 
-	ksmbd_init_smb_server(work);
+	err = ksmbd_init_smb_server(work);
+	if (err) {
+		ksmbd_free_work_struct(work);
+		return 0;
+	}
 
 	ksmbd_conn_enqueue_request(work);
 	atomic_inc(&conn->r_count);
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index f7c907143834..c13616857927 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -388,26 +388,29 @@ static struct smb_version_cmds smb1_server_cmds[1] = {
 	[SMB_COM_NEGOTIATE_EX]	= { .proc = smb1_negotiate, },
 };
 
-static void init_smb1_server(struct ksmbd_conn *conn)
+static int init_smb1_server(struct ksmbd_conn *conn)
 {
 	conn->ops = &smb1_server_ops;
 	conn->cmds = smb1_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb1_server_cmds);
+	return 0;
 }
 
-void ksmbd_init_smb_server(struct ksmbd_work *work)
+int ksmbd_init_smb_server(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	__le32 proto;
 
-	if (conn->need_neg == false)
-		return;
-
 	proto = *(__le32 *)((struct smb_hdr *)work->request_buf)->Protocol;
+	if (conn->need_neg == false) {
+		if (proto == SMB1_PROTO_NUMBER)
+			return -EINVAL;
+		return 0;
+	}
+
 	if (proto == SMB1_PROTO_NUMBER)
-		init_smb1_server(conn);
-	else
-		init_smb3_11_server(conn);
+		return init_smb1_server(conn);
+	return init_smb3_11_server(conn);
 }
 
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index 1db027e730e9..c4978579c541 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -474,7 +474,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn);
 
 int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count);
 
-void ksmbd_init_smb_server(struct ksmbd_work *work);
+int ksmbd_init_smb_server(struct ksmbd_work *work);
 
 struct ksmbd_kstat;
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,
-- 
2.25.1


