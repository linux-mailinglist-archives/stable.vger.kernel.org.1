Return-Path: <stable+bounces-7666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38348175AE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D541283D49
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B64236F;
	Mon, 18 Dec 2023 15:37:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E493D564
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdaa16ada8so351589a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913841; x=1703518641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OSKeLFKxl4hunacr0u+kyoJmlOrdb4eXUJqsOfAHlg=;
        b=cfERvWC835NPz5BjwFMrMECadpsemdo5MVKr3Z9kV0rvY15+E5OT3as/xO0P05Ud3H
         EbNDV3FHZtBjyq+iEaJj5/uP77VdukzjC2SvZgRpr8VP1VYUuZLAXuALSa/n/oCoST7l
         r9fFBqrFEe+t2mygHyKdsAeShQSs8D4CcbU7SS56OJEwSbChw60wzFG1RdFuke1Z4meF
         lHo6xFIIpyk6WJOKhPnigUR4Dhw5DUtZnNQMQP4NuvqBUjiHrROXFW6mdfz6tJ4IkfAR
         J/L8Qk9InVgYvqkw5Vak7NYvdmy4laKIoupHNQ8whYYlzrC6bRhTl5lXwWfz/wuPkLzz
         lumw==
X-Gm-Message-State: AOJu0YxP+VCYpThXQO1/H6cJk6kWZcgL+t9yrTGpDSP9bZK0y33Z9pH5
	4T2ogAv/sc7unONTo/SZjF0=
X-Google-Smtp-Source: AGHT+IFFUN2ObRjSJ85uww0rpr8qhd40iY0vxToxUJGCKe3I5kSKTwIGmrd/8QsvaEepHlhQ5U2G4g==
X-Received: by 2002:a17:90b:e8f:b0:28b:44a9:cfcb with SMTP id fv15-20020a17090b0e8f00b0028b44a9cfcbmr1267197pjb.39.1702913840620;
        Mon, 18 Dec 2023 07:37:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:20 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 037/154] ksmbd: smbd: handle multiple Buffer descriptors
Date: Tue, 19 Dec 2023 00:32:57 +0900
Message-Id: <20231218153454.8090-38-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit ee1b0558965909872775183dc237cdf9f8eddaba ]

Make ksmbd handle multiple buffer descriptors
when reading and writing files using SMB direct:
Post the work requests of rdma_rw_ctx for
RDMA read/write in smb_direct_rdma_xmit(), and
the work request for the READ/WRITE response
with a remote invalidation in smb_direct_writev().

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c        |   5 +-
 fs/ksmbd/transport_rdma.c | 164 ++++++++++++++++++++++++--------------
 2 files changed, 107 insertions(+), 62 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d26af17f383c..dd0ced5d191f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6210,11 +6210,8 @@ static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
 				le32_to_cpu(desc[i].length));
 		}
 	}
-	if (ch_count != 1) {
-		ksmbd_debug(RDMA, "RDMA multiple buffer descriptors %d are not supported yet\n",
-			    ch_count);
+	if (!ch_count)
 		return -EINVAL;
-	}
 
 	work->need_invalidate_rkey =
 		(Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index ca853433e4b4..95c5c2f749e1 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -206,7 +206,9 @@ struct smb_direct_recvmsg {
 struct smb_direct_rdma_rw_msg {
 	struct smb_direct_transport	*t;
 	struct ib_cqe		cqe;
+	int			status;
 	struct completion	*completion;
+	struct list_head	list;
 	struct rdma_rw_ctx	rw_ctx;
 	struct sg_table		sgt;
 	struct scatterlist	sg_list[0];
@@ -1317,6 +1319,16 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 	return ret;
 }
 
+static void smb_direct_free_rdma_rw_msg(struct smb_direct_transport *t,
+					struct smb_direct_rdma_rw_msg *msg,
+					enum dma_data_direction dir)
+{
+	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+			    msg->sgt.sgl, msg->sgt.nents, dir);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	kfree(msg);
+}
+
 static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
 			    enum dma_data_direction dir)
 {
@@ -1325,19 +1337,14 @@ static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
 	struct smb_direct_transport *t = msg->t;
 
 	if (wc->status != IB_WC_SUCCESS) {
+		msg->status = -EIO;
 		pr_err("read/write error. opcode = %d, status = %s(%d)\n",
 		       wc->opcode, ib_wc_status_msg(wc->status), wc->status);
-		smb_direct_disconnect_rdma_connection(t);
+		if (wc->status != IB_WC_WR_FLUSH_ERR)
+			smb_direct_disconnect_rdma_connection(t);
 	}
 
-	if (atomic_inc_return(&t->rw_credits) > 0)
-		wake_up(&t->wait_rw_credits);
-
-	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
-			    msg->sg_list, msg->sgt.nents, dir);
-	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
 	complete(msg->completion);
-	kfree(msg);
 }
 
 static void read_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1356,75 +1363,116 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 				unsigned int desc_len,
 				bool is_read)
 {
-	struct smb_direct_rdma_rw_msg *msg;
-	int ret;
+	struct smb_direct_rdma_rw_msg *msg, *next_msg;
+	int i, ret;
 	DECLARE_COMPLETION_ONSTACK(completion);
-	struct ib_send_wr *first_wr = NULL;
-	u32 remote_key = le32_to_cpu(desc[0].token);
-	u64 remote_offset = le64_to_cpu(desc[0].offset);
+	struct ib_send_wr *first_wr;
+	LIST_HEAD(msg_list);
+	char *desc_buf;
 	int credits_needed;
+	unsigned int desc_buf_len;
+	size_t total_length = 0;
+
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return -ENOTCONN;
+
+	/* calculate needed credits */
+	credits_needed = 0;
+	desc_buf = buf;
+	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+		desc_buf_len = le32_to_cpu(desc[i].length);
+
+		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
+		desc_buf += desc_buf_len;
+		total_length += desc_buf_len;
+		if (desc_buf_len == 0 || total_length > buf_len ||
+		    total_length > t->max_rdma_rw_size)
+			return -EINVAL;
+	}
+
+	ksmbd_debug(RDMA, "RDMA %s, len %#x, needed credits %#x\n",
+		    is_read ? "read" : "write", buf_len, credits_needed);
 
-	credits_needed = calc_rw_credits(t, buf, buf_len);
 	ret = wait_for_rw_credits(t, credits_needed);
 	if (ret < 0)
 		return ret;
 
-	/* TODO: mempool */
-	msg = kmalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
-		      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
-	if (!msg) {
-		atomic_add(credits_needed, &t->rw_credits);
-		return -ENOMEM;
-	}
+	/* build rdma_rw_ctx for each descriptor */
+	desc_buf = buf;
+	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
+			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
-	msg->sgt.sgl = &msg->sg_list[0];
-	ret = sg_alloc_table_chained(&msg->sgt,
-				     get_buf_page_count(buf, buf_len),
-				     msg->sg_list, SG_CHUNK_SIZE);
-	if (ret) {
-		atomic_add(credits_needed, &t->rw_credits);
-		kfree(msg);
-		return -ENOMEM;
-	}
+		desc_buf_len = le32_to_cpu(desc[i].length);
 
-	ret = get_sg_list(buf, buf_len, msg->sgt.sgl, msg->sgt.orig_nents);
-	if (ret <= 0) {
-		pr_err("failed to get pages\n");
-		goto err;
-	}
+		msg->t = t;
+		msg->cqe.done = is_read ? read_done : write_done;
+		msg->completion = &completion;
 
-	ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
-			       msg->sg_list, get_buf_page_count(buf, buf_len),
-			       0, remote_offset, remote_key,
-			       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	if (ret < 0) {
-		pr_err("failed to init rdma_rw_ctx: %d\n", ret);
-		goto err;
+		msg->sgt.sgl = &msg->sg_list[0];
+		ret = sg_alloc_table_chained(&msg->sgt,
+					     get_buf_page_count(desc_buf, desc_buf_len),
+					     msg->sg_list, SG_CHUNK_SIZE);
+		if (ret) {
+			kfree(msg);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = get_sg_list(desc_buf, desc_buf_len,
+				  msg->sgt.sgl, msg->sgt.orig_nents);
+		if (ret < 0) {
+			sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+			kfree(msg);
+			goto out;
+		}
+
+		ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
+				       msg->sgt.sgl,
+				       get_buf_page_count(desc_buf, desc_buf_len),
+				       0,
+				       le64_to_cpu(desc[i].offset),
+				       le32_to_cpu(desc[i].token),
+				       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		if (ret < 0) {
+			pr_err("failed to init rdma_rw_ctx: %d\n", ret);
+			sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+			kfree(msg);
+			goto out;
+		}
+
+		list_add_tail(&msg->list, &msg_list);
+		desc_buf += desc_buf_len;
 	}
 
-	msg->t = t;
-	msg->cqe.done = is_read ? read_done : write_done;
-	msg->completion = &completion;
-	first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
-				   &msg->cqe, NULL);
+	/* concatenate work requests of rdma_rw_ctxs */
+	first_wr = NULL;
+	list_for_each_entry_reverse(msg, &msg_list, list) {
+		first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
+					   &msg->cqe, first_wr);
+	}
 
 	ret = ib_post_send(t->qp, first_wr, NULL);
 	if (ret) {
-		pr_err("failed to post send wr: %d\n", ret);
-		goto err;
+		pr_err("failed to post send wr for RDMA R/W: %d\n", ret);
+		goto out;
 	}
 
+	msg = list_last_entry(&msg_list, struct smb_direct_rdma_rw_msg, list);
 	wait_for_completion(&completion);
-	return 0;
-
-err:
+	ret = msg->status;
+out:
+	list_for_each_entry_safe(msg, next_msg, &msg_list, list) {
+		list_del(&msg->list);
+		smb_direct_free_rdma_rw_msg(t, msg,
+					    is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
 	atomic_add(credits_needed, &t->rw_credits);
-	if (first_wr)
-		rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
-				    msg->sg_list, msg->sgt.nents,
-				    is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
-	kfree(msg);
+	wake_up(&t->wait_rw_credits);
 	return ret;
 }
 
-- 
2.25.1


