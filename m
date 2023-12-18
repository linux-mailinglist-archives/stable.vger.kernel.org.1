Return-Path: <stable+bounces-7731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2FA8175FF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321E21C25052
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE373466;
	Mon, 18 Dec 2023 15:40:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D472050
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo500672a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914048; x=1703518848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjRYiFsENv4ZauoTZFchJJ9011SBqLXpie8XaFW69TA=;
        b=rZsFy0Gh8iQ4+RdGz4II1WbnuDbxo/HinHlYemfpgefJvT1OxfPh8rsSs0pUVbRph8
         jsHUoQcMErWpjOsCY5idwdfEgvMxVzWGvXPqL1TlfRt4NcamnSPa9QOun/AVuZ/igetT
         GwZk3y0gcGkh8OcWTGokz93IZrF7Ig25+/wiLh54wdKORxwdqi5rrpOScZTCfEVW1ibL
         O9UBaXXjVe8zx2nNGAb6p4xO4Kg3z1SdfGbgYvNkG3dozphYBcNFy8veDpOO7XrfbxMB
         zx3uYO7oPWDmS43a4NkxuaT4B6Rafjanaerfxatrg2vyLUJQXFnLh0c0LzWXdfdLEsSQ
         fexA==
X-Gm-Message-State: AOJu0YxfkcUm7DCo5blo2Eq/b/xVTdgp+SubwIYF2izi+gXa6a4++2ri
	1zP4IS60aZi6Nex7P2f98tc=
X-Google-Smtp-Source: AGHT+IH+xi6uz7xriqyCSK4n16GGV/zI7/21ESZ+iChzLayvUUlBdohc+5jbTwEeR1pbNNf5jJpVhw==
X-Received: by 2002:a17:90b:3708:b0:28b:336c:3255 with SMTP id mg8-20020a17090b370800b0028b336c3255mr1921686pjb.12.1702914048516;
        Mon, 18 Dec 2023 07:40:48 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:48 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chih-Yen Chang <cc85nod@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 102/154] ksmbd: validate smb request protocol id
Date: Tue, 19 Dec 2023 00:34:02 +0900
Message-Id: <20231218153454.8090-103-linkinjeon@kernel.org>
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

[ Upstream commit 1c1bcf2d3ea061613119b534f57507c377df20f9 ]

This patch add the validation for smb request protocol id.
If it is not one of the four ids(SMB1_PROTO_NUMBER, SMB2_PROTO_NUMBER,
SMB2_TRANSFORM_PROTO_NUM, SMB2_COMPRESSION_TRANSFORM_ID), don't allow
processing the request. And this will fix the following KASAN warning
also.

[   13.905265] BUG: KASAN: slab-out-of-bounds in init_smb2_rsp_hdr+0x1b9/0x1f0
[   13.905900] Read of size 16 at addr ffff888005fd2f34 by task kworker/0:2/44
...
[   13.908553] Call Trace:
[   13.908793]  <TASK>
[   13.908995]  dump_stack_lvl+0x33/0x50
[   13.909369]  print_report+0xcc/0x620
[   13.910870]  kasan_report+0xae/0xe0
[   13.911519]  kasan_check_range+0x35/0x1b0
[   13.911796]  init_smb2_rsp_hdr+0x1b9/0x1f0
[   13.912492]  handle_ksmbd_work+0xe5/0x820

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c |  5 +++--
 fs/ksmbd/smb2pdu.h    |  1 +
 fs/ksmbd/smb_common.c | 14 +++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index c3c8b64a4adc..99ea5f1b324d 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -364,8 +364,6 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
-			break;
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -383,6 +381,9 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (!ksmbd_smb_request(conn))
+			break;
+
 		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index a774889e0aa5..e1d0849ee68f 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -109,6 +109,7 @@
 
 #define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe) /* 'B''M''S' */
 #define SMB2_TRANSFORM_PROTO_NUM cpu_to_le32(0x424d53fd)
+#define SMB2_COMPRESSION_TRANSFORM_ID cpu_to_le32(0x424d53fc)
 
 #define SMB21_DEFAULT_IOSIZE	(1024 * 1024)
 #define SMB3_DEFAULT_IOSIZE	(4 * 1024 * 1024)
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 1c69811610dc..d937e2f45c82 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -158,7 +158,19 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	return conn->request_buf[0] == 0;
+	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+
+	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		pr_err_ratelimited("smb2 compression not support yet");
+		return false;
+	}
+
+	if (*proto != SMB1_PROTO_NUMBER &&
+	    *proto != SMB2_PROTO_NUMBER &&
+	    *proto != SMB2_TRANSFORM_PROTO_NUM)
+		return false;
+
+	return true;
 }
 
 static bool supported_protocol(int idx)
-- 
2.25.1


