Return-Path: <stable+bounces-8061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189BE81A45D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CBD1F22490
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1F4B151;
	Wed, 20 Dec 2023 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAsDkx69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8011A4B138;
	Wed, 20 Dec 2023 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A71C433C8;
	Wed, 20 Dec 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088801;
	bh=gvpB2jPLDvjnbzXzsmWuNsevI0sya5LlYeaoJDBnTBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAsDkx69o6VztcHniZOenEYfbI0Sj2JXU0Fm7Js5eEQTf93uzikU8d7vF1ZnBCeUF
	 KPh/SwHhitTN+tL7bfzKuZ3KaW1aukBOEefGLSYgFPxpG2pK/f1v0shVLH8mRFsOfp
	 NFkfclAn6jgvKqRjmIvVArSGDUxJWod8YhmnoNSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 034/159] ksmbd: smbd: introduce read/write credits for RDMA read/write
Date: Wed, 20 Dec 2023 17:08:19 +0100
Message-ID: <20231220160932.873418693@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit ddbdc861e37c168cf2fb8a7b7477f5d18b4daf76 ]

SMB2_READ/SMB2_WRITE request has to be granted the number
of rw credits, the pages the request wants to transfer
/ the maximum pages which can be registered with one
MR to read and write a file.
And allocate enough RDMA resources for the maximum
number of rw credits allowed by ksmbd.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/transport_rdma.c |  118 +++++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 48 deletions(-)

--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -82,8 +82,6 @@ static int smb_direct_max_receive_size =
 
 static int smb_direct_max_read_write_size = SMBD_DEFAULT_IOSIZE;
 
-static int smb_direct_max_outstanding_rw_ops = 8;
-
 static LIST_HEAD(smb_direct_device_list);
 static DEFINE_RWLOCK(smb_direct_device_lock);
 
@@ -147,10 +145,12 @@ struct smb_direct_transport {
 	atomic_t		send_credits;
 	spinlock_t		lock_new_recv_credits;
 	int			new_recv_credits;
-	atomic_t		rw_avail_ops;
+	int			max_rw_credits;
+	int			pages_per_rw_credit;
+	atomic_t		rw_credits;
 
 	wait_queue_head_t	wait_send_credits;
-	wait_queue_head_t	wait_rw_avail_ops;
+	wait_queue_head_t	wait_rw_credits;
 
 	mempool_t		*sendmsg_mempool;
 	struct kmem_cache	*sendmsg_cache;
@@ -383,7 +383,7 @@ static struct smb_direct_transport *allo
 	t->reassembly_queue_length = 0;
 	init_waitqueue_head(&t->wait_reassembly_queue);
 	init_waitqueue_head(&t->wait_send_credits);
-	init_waitqueue_head(&t->wait_rw_avail_ops);
+	init_waitqueue_head(&t->wait_rw_credits);
 
 	spin_lock_init(&t->receive_credit_lock);
 	spin_lock_init(&t->recvmsg_queue_lock);
@@ -989,18 +989,19 @@ static int smb_direct_flush_send_list(st
 }
 
 static int wait_for_credits(struct smb_direct_transport *t,
-			    wait_queue_head_t *waitq, atomic_t *credits)
+			    wait_queue_head_t *waitq, atomic_t *total_credits,
+			    int needed)
 {
 	int ret;
 
 	do {
-		if (atomic_dec_return(credits) >= 0)
+		if (atomic_sub_return(needed, total_credits) >= 0)
 			return 0;
 
-		atomic_inc(credits);
+		atomic_add(needed, total_credits);
 		ret = wait_event_interruptible(*waitq,
-					       atomic_read(credits) > 0 ||
-						t->status != SMB_DIRECT_CS_CONNECTED);
+					       atomic_read(total_credits) >= needed ||
+					       t->status != SMB_DIRECT_CS_CONNECTED);
 
 		if (t->status != SMB_DIRECT_CS_CONNECTED)
 			return -ENOTCONN;
@@ -1021,7 +1022,19 @@ static int wait_for_send_credits(struct
 			return ret;
 	}
 
-	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits);
+	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits, 1);
+}
+
+static int wait_for_rw_credits(struct smb_direct_transport *t, int credits)
+{
+	return wait_for_credits(t, &t->wait_rw_credits, &t->rw_credits, credits);
+}
+
+static int calc_rw_credits(struct smb_direct_transport *t,
+			   char *buf, unsigned int len)
+{
+	return DIV_ROUND_UP(get_buf_page_count(buf, len),
+			    t->pages_per_rw_credit);
 }
 
 static int smb_direct_create_header(struct smb_direct_transport *t,
@@ -1337,8 +1350,8 @@ static void read_write_done(struct ib_cq
 		smb_direct_disconnect_rdma_connection(t);
 	}
 
-	if (atomic_inc_return(&t->rw_avail_ops) > 0)
-		wake_up(&t->wait_rw_avail_ops);
+	if (atomic_inc_return(&t->rw_credits) > 0)
+		wake_up(&t->wait_rw_credits);
 
 	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
 			    msg->sg_list, msg->sgt.nents, dir);
@@ -1369,8 +1382,10 @@ static int smb_direct_rdma_xmit(struct s
 	struct ib_send_wr *first_wr = NULL;
 	u32 remote_key = le32_to_cpu(desc[0].token);
 	u64 remote_offset = le64_to_cpu(desc[0].offset);
+	int credits_needed;
 
-	ret = wait_for_credits(t, &t->wait_rw_avail_ops, &t->rw_avail_ops);
+	credits_needed = calc_rw_credits(t, buf, buf_len);
+	ret = wait_for_rw_credits(t, credits_needed);
 	if (ret < 0)
 		return ret;
 
@@ -1378,7 +1393,7 @@ static int smb_direct_rdma_xmit(struct s
 	msg = kmalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
 		      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
 	if (!msg) {
-		atomic_inc(&t->rw_avail_ops);
+		atomic_add(credits_needed, &t->rw_credits);
 		return -ENOMEM;
 	}
 
@@ -1387,7 +1402,7 @@ static int smb_direct_rdma_xmit(struct s
 				     get_buf_page_count(buf, buf_len),
 				     msg->sg_list, SG_CHUNK_SIZE);
 	if (ret) {
-		atomic_inc(&t->rw_avail_ops);
+		atomic_add(credits_needed, &t->rw_credits);
 		kfree(msg);
 		return -ENOMEM;
 	}
@@ -1423,7 +1438,7 @@ static int smb_direct_rdma_xmit(struct s
 	return 0;
 
 err:
-	atomic_inc(&t->rw_avail_ops);
+	atomic_add(credits_needed, &t->rw_credits);
 	if (first_wr)
 		rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
 				    msg->sg_list, msg->sgt.nents,
@@ -1648,11 +1663,19 @@ out_err:
 	return ret;
 }
 
+static unsigned int smb_direct_get_max_fr_pages(struct smb_direct_transport *t)
+{
+	return min_t(unsigned int,
+		     t->cm_id->device->attrs.max_fast_reg_page_list_len,
+		     256);
+}
+
 static int smb_direct_init_params(struct smb_direct_transport *t,
 				  struct ib_qp_cap *cap)
 {
 	struct ib_device *device = t->cm_id->device;
-	int max_send_sges, max_pages, max_rw_wrs, max_send_wrs;
+	int max_send_sges, max_rw_wrs, max_send_wrs;
+	unsigned int max_sge_per_wr, wrs_per_credit;
 
 	/* need 2 more sge. because a SMB_DIRECT header will be mapped,
 	 * and maybe a send buffer could be not page aligned.
@@ -1664,25 +1687,31 @@ static int smb_direct_init_params(struct
 		return -EINVAL;
 	}
 
-	/*
-	 * allow smb_direct_max_outstanding_rw_ops of in-flight RDMA
-	 * read/writes. HCA guarantees at least max_send_sge of sges for
-	 * a RDMA read/write work request, and if memory registration is used,
-	 * we need reg_mr, local_inv wrs for each read/write.
+	/* Calculate the number of work requests for RDMA R/W.
+	 * The maximum number of pages which can be registered
+	 * with one Memory region can be transferred with one
+	 * R/W credit. And at least 4 work requests for each credit
+	 * are needed for MR registration, RDMA R/W, local & remote
+	 * MR invalidation.
 	 */
 	t->max_rdma_rw_size = smb_direct_max_read_write_size;
-	max_pages = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
-	max_rw_wrs = DIV_ROUND_UP(max_pages, SMB_DIRECT_MAX_SEND_SGES);
-	max_rw_wrs += rdma_rw_mr_factor(device, t->cm_id->port_num,
-			max_pages) * 2;
-	max_rw_wrs *= smb_direct_max_outstanding_rw_ops;
+	t->pages_per_rw_credit = smb_direct_get_max_fr_pages(t);
+	t->max_rw_credits = DIV_ROUND_UP(t->max_rdma_rw_size,
+					 (t->pages_per_rw_credit - 1) *
+					 PAGE_SIZE);
+
+	max_sge_per_wr = min_t(unsigned int, device->attrs.max_send_sge,
+			       device->attrs.max_sge_rd);
+	wrs_per_credit = max_t(unsigned int, 4,
+			       DIV_ROUND_UP(t->pages_per_rw_credit,
+					    max_sge_per_wr) + 1);
+	max_rw_wrs = t->max_rw_credits * wrs_per_credit;
 
 	max_send_wrs = smb_direct_send_credit_target + max_rw_wrs;
 	if (max_send_wrs > device->attrs.max_cqe ||
 	    max_send_wrs > device->attrs.max_qp_wr) {
-		pr_err("consider lowering send_credit_target = %d, or max_outstanding_rw_ops = %d\n",
-		       smb_direct_send_credit_target,
-		       smb_direct_max_outstanding_rw_ops);
+		pr_err("consider lowering send_credit_target = %d\n",
+		       smb_direct_send_credit_target);
 		pr_err("Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
 		       device->attrs.max_cqe, device->attrs.max_qp_wr);
 		return -EINVAL;
@@ -1717,7 +1746,7 @@ static int smb_direct_init_params(struct
 
 	t->send_credit_target = smb_direct_send_credit_target;
 	atomic_set(&t->send_credits, 0);
-	atomic_set(&t->rw_avail_ops, smb_direct_max_outstanding_rw_ops);
+	atomic_set(&t->rw_credits, t->max_rw_credits);
 
 	t->max_send_size = smb_direct_max_send_size;
 	t->max_recv_size = smb_direct_max_receive_size;
@@ -1725,12 +1754,10 @@ static int smb_direct_init_params(struct
 
 	cap->max_send_wr = max_send_wrs;
 	cap->max_recv_wr = t->recv_credit_max;
-	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
+	cap->max_send_sge = max_sge_per_wr;
 	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
 	cap->max_inline_data = 0;
-	cap->max_rdma_ctxs =
-		rdma_rw_mr_factor(device, t->cm_id->port_num, max_pages) *
-		smb_direct_max_outstanding_rw_ops;
+	cap->max_rdma_ctxs = t->max_rw_credits;
 	return 0;
 }
 
@@ -1823,7 +1850,8 @@ static int smb_direct_create_qpair(struc
 	}
 
 	t->send_cq = ib_alloc_cq(t->cm_id->device, t,
-				 t->send_credit_target, 0, IB_POLL_WORKQUEUE);
+				 smb_direct_send_credit_target + cap->max_rdma_ctxs,
+				 0, IB_POLL_WORKQUEUE);
 	if (IS_ERR(t->send_cq)) {
 		pr_err("Can't create RDMA send CQ\n");
 		ret = PTR_ERR(t->send_cq);
@@ -1832,8 +1860,7 @@ static int smb_direct_create_qpair(struc
 	}
 
 	t->recv_cq = ib_alloc_cq(t->cm_id->device, t,
-				 cap->max_send_wr + cap->max_rdma_ctxs,
-				 0, IB_POLL_WORKQUEUE);
+				 t->recv_credit_max, 0, IB_POLL_WORKQUEUE);
 	if (IS_ERR(t->recv_cq)) {
 		pr_err("Can't create RDMA recv CQ\n");
 		ret = PTR_ERR(t->recv_cq);
@@ -1862,17 +1889,12 @@ static int smb_direct_create_qpair(struc
 
 	pages_per_rw = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
 	if (pages_per_rw > t->cm_id->device->attrs.max_sgl_rd) {
-		int pages_per_mr, mr_count;
-
-		pages_per_mr = min_t(int, pages_per_rw,
-				     t->cm_id->device->attrs.max_fast_reg_page_list_len);
-		mr_count = DIV_ROUND_UP(pages_per_rw, pages_per_mr) *
-			atomic_read(&t->rw_avail_ops);
-		ret = ib_mr_pool_init(t->qp, &t->qp->rdma_mrs, mr_count,
-				      IB_MR_TYPE_MEM_REG, pages_per_mr, 0);
+		ret = ib_mr_pool_init(t->qp, &t->qp->rdma_mrs,
+				      t->max_rw_credits, IB_MR_TYPE_MEM_REG,
+				      t->pages_per_rw_credit, 0);
 		if (ret) {
 			pr_err("failed to init mr pool count %d pages %d\n",
-			       mr_count, pages_per_mr);
+			       t->max_rw_credits, t->pages_per_rw_credit);
 			goto err;
 		}
 	}



