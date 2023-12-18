Return-Path: <stable+bounces-7729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781948175FA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076DE1F250FC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C1572054;
	Mon, 18 Dec 2023 15:40:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8A49883
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b6da5ecccso1167034a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914045; x=1703518845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIHoxK6hOopViXYB3SA/EJ4r1FD/KiHyt9Zd2064yes=;
        b=IxhflNcLTonEL12c9nJ4h+tUh4ERgaD6bEbbk+Ezd7Wp5Vy0xNjvBesT8nNTVHNV7k
         Szw9tTRjY/+ovbv0pfAvTpTOVH3b93ZY/zJczxTLa3oMvF+8AaLA7SpZsmC+qxNyvorv
         AfC9ozn7t8/FL3/CZLuHjRSy34+JgrMWxMfU0WIADubXkUvBJfCaJJ1y3CL8yCWy7UBB
         UjEfL8dIw4qBNB4BeqPyeUj/nuXyy7vSOM6jrh+SC7IfSGY1SLVUJyPURVYFHj2ZyIvl
         UeSztmbbNyZkbzqQLmz+qoLmjIm5k75QHq5Oc/D4VJWtJc+NfmVqJM9fIfdHaYww8KXx
         n3Yg==
X-Gm-Message-State: AOJu0YwO4LhOTIgZc3/n0lvwngA2c3qmJ1VcspQTyNDvOaWqM2JExGdx
	CVe0Gl5NcPdv7/SnZHRcG7qiZ2JUmeA=
X-Google-Smtp-Source: AGHT+IFpPkkW5FsZbWZpxUkFIVxFdQ9OT9LHYnzRxaEeOeVlzNXipoXUxrsJERB4PXn5p4PqeT8bfQ==
X-Received: by 2002:a17:90b:e89:b0:28b:3c7e:70dd with SMTP id fv9-20020a17090b0e8900b0028b3c7e70ddmr2429618pjb.6.1702914045399;
        Mon, 18 Dec 2023 07:40:45 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chih-Yen Chang <cc85nod@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 101/154] ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
Date: Tue, 19 Dec 2023 00:34:01 +0900
Message-Id: <20231218153454.8090-102-linkinjeon@kernel.org>
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

[ Upstream commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 ]

The length field of netbios header must be greater than the SMB header
sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.

If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
In the function `get_smb2_cmd_val` ksmbd will read cmd from
`rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
detector to print the following error message:

[    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
[    7.205423] Read of size 2 at addr ffff8880062d8b50 by task ksmbd:42632/248
...
[    7.207125]  <TASK>
[    7.209191]  get_smb2_cmd_val+0x45/0x60
[    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
[    7.209712]  ksmbd_server_process_request+0x72/0x160
[    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
[    7.212280]  kthread+0x160/0x190
[    7.212762]  ret_from_fork+0x1f/0x30
[    7.212981]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 4a9672d3ef49..c3c8b64a4adc 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -294,6 +294,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -350,6 +353,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -377,6 +383,12 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;
-- 
2.25.1


