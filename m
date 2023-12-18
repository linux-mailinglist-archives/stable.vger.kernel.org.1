Return-Path: <stable+bounces-7667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05C8175B0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBED2B24663
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7623D566;
	Mon, 18 Dec 2023 15:37:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261E3A1D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28abb389323so1225938a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913844; x=1703518644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l60G1jeJMLajjuLWt97lShP0ylNBO+4788H8PsZVBM=;
        b=XbA9o5ToY5uufCLIMs0SHcz4SJSyO2dTl8C564Y8gNj/GQh0duyh2rt6KM1jDSKB9A
         1zXSjmqV5iRDETFE01nPZzHbedIp/sGd1sX2wN+n/msRhlONkvPtRU9Lr5Ujlz98Bhew
         arM7Mqk7xkURSk+pkUAXylxC6pozzE0bGbrjDH2iijpey3mTVFKKHRrEaYDj2rmntHPl
         90cFkPN7jpIRmX6Jy2P5Wk8j4F9wBxuoom5QG3P/EiJiBG/8H2dLezkfD4CXRqY2lpim
         fml+PxuJC1jsvtaO40grSmcmcibBzeSm3F/uenvqCyyu1bhb6AHpOgtnZcJvOzWW1tMk
         9y/A==
X-Gm-Message-State: AOJu0YzJX28qrjAqXV2IsfMc0wo8p7w2fg0nNkPiaFANWJsf0E1AYpiH
	XqoPFcK8oONPta8Nn65s9H2Pc3a5afY=
X-Google-Smtp-Source: AGHT+IHHp9i/QUABxCbeeHZLCylZu6Tt3J+B78RObxI05ZbVF/DsvcbziCmzzZKD5TmnNUzPdeCsZw==
X-Received: by 2002:a17:90a:7e11:b0:286:7f0d:6254 with SMTP id i17-20020a17090a7e1100b002867f0d6254mr7275448pjl.63.1702913843558;
        Mon, 18 Dec 2023 07:37:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 038/154] ksmbd: fix wrong smbd max read/write size check
Date: Tue, 19 Dec 2023 00:32:58 +0900
Message-Id: <20231218153454.8090-39-linkinjeon@kernel.org>
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

[ Upstream commit 7a84399e1ce3f5f2fbec3e7dd93459ba25badc2f ]

smb-direct max read/write size can be different with smb2 max read/write
size. So smb2_read() can return error by wrong max read/write size check.
This patch use smb_direct_max_read_write_size for this check in
smb-direct read/write().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c        | 39 +++++++++++++++++++++++++--------------
 fs/ksmbd/transport_rdma.c |  5 +++++
 fs/ksmbd/transport_rdma.h |  2 ++
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index dd0ced5d191f..85afa551b11b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6252,6 +6252,8 @@ int smb2_read(struct ksmbd_work *work)
 	size_t length, mincount;
 	ssize_t nbytes = 0, remain_bytes = 0;
 	int err = 0;
+	bool is_rdma_channel = false;
+	unsigned int max_read_size = conn->vals->max_read_size;
 
 	WORK_BUFFERS(work, req, rsp);
 	if (work->next_smb2_rcv_hdr_off) {
@@ -6268,6 +6270,11 @@ int smb2_read(struct ksmbd_work *work)
 
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
 	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		is_rdma_channel = true;
+		max_read_size = get_smbd_max_read_write_size();
+	}
+
+	if (is_rdma_channel == true) {
 		unsigned int ch_offset = le16_to_cpu(req->ReadChannelInfoOffset);
 
 		if (ch_offset < offsetof(struct smb2_read_req, Buffer)) {
@@ -6299,9 +6306,9 @@ int smb2_read(struct ksmbd_work *work)
 	length = le32_to_cpu(req->Length);
 	mincount = le32_to_cpu(req->MinimumCount);
 
-	if (length > conn->vals->max_read_size) {
+	if (length > max_read_size) {
 		ksmbd_debug(SMB, "limiting read size to max size(%u)\n",
-			    conn->vals->max_read_size);
+			    max_read_size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -6333,8 +6340,7 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "nbytes %zu, offset %lld mincount %zu\n",
 		    nbytes, offset, mincount);
 
-	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
-	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+	if (is_rdma_channel == true) {
 		/* write data to the client using rdma channel */
 		remain_bytes = smb2_read_rdma_channel(work, req,
 						      work->aux_payload_buf,
@@ -6495,8 +6501,9 @@ int smb2_write(struct ksmbd_work *work)
 	size_t length;
 	ssize_t nbytes;
 	char *data_buf;
-	bool writethrough = false;
+	bool writethrough = false, is_rdma_channel = false;
 	int err = 0;
+	unsigned int max_write_size = work->conn->vals->max_write_size;
 
 	WORK_BUFFERS(work, req, rsp);
 
@@ -6505,8 +6512,17 @@ int smb2_write(struct ksmbd_work *work)
 		return smb2_write_pipe(work);
 	}
 
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1 ||
 	    req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+		is_rdma_channel = true;
+		max_write_size = get_smbd_max_read_write_size();
+		length = le32_to_cpu(req->RemainingBytes);
+	}
+
+	if (is_rdma_channel == true) {
 		unsigned int ch_offset = le16_to_cpu(req->WriteChannelInfoOffset);
 
 		if (req->Length != 0 || req->DataOffset != 0 ||
@@ -6541,12 +6557,9 @@ int smb2_write(struct ksmbd_work *work)
 		goto out;
 	}
 
-	offset = le64_to_cpu(req->Offset);
-	length = le32_to_cpu(req->Length);
-
-	if (length > work->conn->vals->max_write_size) {
+	if (length > max_write_size) {
 		ksmbd_debug(SMB, "limiting write size to max size(%u)\n",
-			    work->conn->vals->max_write_size);
+			    max_write_size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -6554,8 +6567,7 @@ int smb2_write(struct ksmbd_work *work)
 	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
 		writethrough = true;
 
-	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+	if (is_rdma_channel == false) {
 		if (le16_to_cpu(req->DataOffset) <
 		    offsetof(struct smb2_write_req, Buffer)) {
 			err = -EINVAL;
@@ -6579,8 +6591,7 @@ int smb2_write(struct ksmbd_work *work)
 		/* read data from the client using rdma channel, and
 		 * write the data.
 		 */
-		nbytes = smb2_write_rdma_channel(work, req, fp, offset,
-						 le32_to_cpu(req->RemainingBytes),
+		nbytes = smb2_write_rdma_channel(work, req, fp, offset, length,
 						 writethrough);
 		if (nbytes < 0) {
 			err = (int)nbytes;
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 95c5c2f749e1..f36c7626af0c 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -220,6 +220,11 @@ void init_smbd_max_io_size(unsigned int sz)
 	smb_direct_max_read_write_size = sz;
 }
 
+unsigned int get_smbd_max_read_write_size(void)
+{
+	return smb_direct_max_read_write_size;
+}
+
 static inline int get_buf_page_count(void *buf, int size)
 {
 	return DIV_ROUND_UP((uintptr_t)buf + size, PAGE_SIZE) -
diff --git a/fs/ksmbd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
index e7b4e6790fab..77aee4e5c9dc 100644
--- a/fs/ksmbd/transport_rdma.h
+++ b/fs/ksmbd/transport_rdma.h
@@ -57,11 +57,13 @@ int ksmbd_rdma_init(void);
 void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
+unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
 static inline int ksmbd_rdma_destroy(void) { return 0; }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
+static inline unsigned int get_smbd_max_read_write_size(void) { return 0; }
 #endif
 
 #endif /* __KSMBD_TRANSPORT_RDMA_H__ */
-- 
2.25.1


