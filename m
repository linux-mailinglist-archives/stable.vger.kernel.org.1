Return-Path: <stable+bounces-7737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9181760A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0632281419
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936717347E;
	Mon, 18 Dec 2023 15:41:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF573491
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28b406a0fbfso2460677a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914067; x=1703518867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytebfzW2DTWSmQi7mVyQCUBUNnBRmlYPrldActRMgbM=;
        b=H1aDlhy9qQmfhF6U04iQ8/QOfO3GaBCEn0WT3P33CHfx7NX3FAGOiR3EfEHMmKlnOY
         PMVfjbZ0pFCL2gZvzgG1Vtq/3s4SXt+5rx4kB8bQhI0MnGZei+wWfwd9fle4qYey5B44
         CfwjcA4e6wAK22St2cLfIWWjU6YdGgeuzgXVq4Mm7XvdhsmTAOGubvjp44M5xvajiv/3
         4DEqyhZicPK75OBD6KqNbCvKyIKhfJ1rYdMoeoem/3Jq6L0ER2Ms4nlrrtjoVB8Zn2cW
         ALNWFA0M5O1gaUaLuUOyvKtx3NH+nAD0w+kCPly1GC+pNHLHTulgrQHS6u03OfLbTvRp
         nu7Q==
X-Gm-Message-State: AOJu0YxUzQ2oVhZF87qi1KoX50S8irpFnY6TkteiHRML9QbvfcQI/Ae9
	BEFsv6lffxzNEe58FhRwdPs=
X-Google-Smtp-Source: AGHT+IGXSmh9qLRYNRMFopil6yDm0CdFuarw8qJvm1v/w5jiJsVO/N7JWv3LPpAirwuNvrKJcHL7hQ==
X-Received: by 2002:a17:90a:e554:b0:28b:4669:3cd1 with SMTP id ei20-20020a17090ae55400b0028b46693cd1mr1668558pjb.96.1702914067442;
        Mon, 18 Dec 2023 07:41:07 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:07 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 108/154] ksmbd: use kvzalloc instead of kvmalloc
Date: Tue, 19 Dec 2023 00:34:08 +0900
Message-Id: <20231218153454.8090-109-linkinjeon@kernel.org>
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

[ Upstream commit 81a94b27847f7d2e499415db14dd9dc7c22b19b0 ]

Use kvzalloc instead of kvmalloc.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c       | 8 ++++----
 fs/ksmbd/transport_ipc.c | 4 ++--
 fs/ksmbd/vfs.c           | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f31cc130f2c5..151249bdfe2b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -544,7 +544,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		sz = large_sz;
 
-	work->response_buf = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+	work->response_buf = kvzalloc(sz, GFP_KERNEL);
 	if (!work->response_buf)
 		return -ENOMEM;
 
@@ -6104,7 +6104,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		work->aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL | __GFP_ZERO);
+			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
 		if (!work->aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
@@ -6261,7 +6261,7 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 		    fp->filp, offset, length);
 
-	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	work->aux_payload_buf = kvzalloc(length, GFP_KERNEL);
 	if (!work->aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
@@ -6410,7 +6410,7 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 	int ret;
 	ssize_t nbytes;
 
-	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	data_buf = kvzalloc(length, GFP_KERNEL);
 	if (!data_buf)
 		return -ENOMEM;
 
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index a8313eed4f10..9560c704033e 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -228,7 +228,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvmalloc(msg_sz, GFP_KERNEL | __GFP_ZERO);
+	msg = kvzalloc(msg_sz, GFP_KERNEL);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -267,7 +267,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			       entry->type + 1, type);
 		}
 
-		entry->response = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+		entry->response = kvzalloc(sz, GFP_KERNEL);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 540c14741194..2b938ebdfd2a 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -436,7 +436,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	}
 
 	if (v_len < size) {
-		wbuf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+		wbuf = kvzalloc(size, GFP_KERNEL);
 		if (!wbuf) {
 			err = -ENOMEM;
 			goto out;
@@ -853,7 +853,7 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	if (size <= 0)
 		return size;
 
-	vlist = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	vlist = kvzalloc(size, GFP_KERNEL);
 	if (!vlist)
 		return -ENOMEM;
 
-- 
2.25.1


