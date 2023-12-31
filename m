Return-Path: <stable+bounces-9062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43A820A0F
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787C6282F44
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353B17D3;
	Sun, 31 Dec 2023 07:15:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C717C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so3107491b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006922; x=1704611722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug3pLOP+ypn0JG89lZi/3zvN36HoYWWy5Q0xufULUUk=;
        b=LYVtE8P/EJFBAwv+YK+m1fwwPu0ueeqpF3o+/6brz+p7i4Joz9RyMycSzQAk6OoO0V
         qO8DegBV2DHY4WopCvXdN14QxMTMEcFHQPYCfGRtjdFposnLPxvPBKXbVN4I1/GT3y58
         Js/+nSYvhc9HuxzMLnCVYTJTKjoIkLjCHlP88cd6LTEO3RwZpxW/rzOEuBnM+k9LT2F8
         neJ2wER5XmvpvsXzhf64zG5EuDp9HP0UILM2QweGAgRBlo8T6QCjJE2IXtmZTXjJDRvQ
         log2D4MR+M0zNeaIlWuS2r4/FcrBPglSSHcd2bHA7iS6P+JLCukzXdH9ER7JJCA9ZPYm
         ai8Q==
X-Gm-Message-State: AOJu0YxFnx+ksRmwh3wVipyiBt3HfoxPFf/Zul09i+2G3bbFEmXsx8m8
	IOcx94ccmSBcYMWSP78e5LQ=
X-Google-Smtp-Source: AGHT+IFwD16mM0nBef4kbQ+mQ1AkCUd+NfAteCOuD3/uy6Oge3jc+j2jthfQOBBPxrmjBenbDDacrA==
X-Received: by 2002:a05:6a20:7483:b0:196:c984:c739 with SMTP id p3-20020a056a20748300b00196c984c739mr1432114pzd.52.1704006921958;
        Sat, 30 Dec 2023 23:15:21 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:21 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 28/73] ksmbd: use kvzalloc instead of kvmalloc
Date: Sun, 31 Dec 2023 16:12:47 +0900
Message-Id: <20231231071332.31724-29-linkinjeon@kernel.org>
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

[ Upstream commit 81a94b27847f7d2e499415db14dd9dc7c22b19b0 ]

Use kvzalloc instead of kvmalloc.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c       | 8 ++++----
 fs/smb/server/transport_ipc.c | 4 ++--
 fs/smb/server/vfs.c           | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e8d2c6fc3f37..10d51256858f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -543,7 +543,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		sz = large_sz;
 
-	work->response_buf = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+	work->response_buf = kvzalloc(sz, GFP_KERNEL);
 	if (!work->response_buf)
 		return -ENOMEM;
 
@@ -6120,7 +6120,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		work->aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL | __GFP_ZERO);
+			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
 		if (!work->aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
@@ -6277,7 +6277,7 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 		    fp->filp, offset, length);
 
-	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	work->aux_payload_buf = kvzalloc(length, GFP_KERNEL);
 	if (!work->aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
@@ -6428,7 +6428,7 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 	int ret;
 	ssize_t nbytes;
 
-	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	data_buf = kvzalloc(length, GFP_KERNEL);
 	if (!data_buf)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 40c721f9227e..b49d47bdafc9 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -229,7 +229,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvmalloc(msg_sz, GFP_KERNEL | __GFP_ZERO);
+	msg = kvzalloc(msg_sz, GFP_KERNEL);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -268,7 +268,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			       entry->type + 1, type);
 		}
 
-		entry->response = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+		entry->response = kvzalloc(sz, GFP_KERNEL);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 178bcd4d0b20..d05d2d1274b0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -437,7 +437,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	}
 
 	if (v_len < size) {
-		wbuf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+		wbuf = kvzalloc(size, GFP_KERNEL);
 		if (!wbuf) {
 			err = -ENOMEM;
 			goto out;
@@ -854,7 +854,7 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	if (size <= 0)
 		return size;
 
-	vlist = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	vlist = kvzalloc(size, GFP_KERNEL);
 	if (!vlist)
 		return -ENOMEM;
 
-- 
2.25.1


