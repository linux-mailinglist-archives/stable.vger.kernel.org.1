Return-Path: <stable+bounces-71533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE08964B9B
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9434A1F21418
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F41B143E;
	Thu, 29 Aug 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBuMJgjh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579621B0117
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948653; cv=none; b=YfDI39BIlzfhFea+yxC+7/oxhN2U85DzoYRQnkRRgIjiy/uokkhxegNwPy1pu1ie5azcZokHKbb7r/luvpoXoEBvSFY+zU8uUIhiHjZFc8fiVSUJXpfOpyisEh14oijmBq8PGv3cq39CZgF80URuxmp7G0s7jWRCC3+Pf8vLpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948653; c=relaxed/simple;
	bh=f7k2RFFNI4rYawBKgZ9GVW3htA3KUVzIjVPTHpETdKc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ky1dbwIWLkQ1kUGMp6Uf3vhZpGk97cONjiYycEs45reJiKxOEPFVdd9JyaGKtAxXLttYDaOEsEFwtzSkjD1soOd77x0s6qM5KqpMqbZyY4C/pQ84rCuNDbmn/LZVQv18llj/QjJLGMeLaVq8lE9/D1Jnnw2lQpAYYjfYYRfWsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBuMJgjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF5EC4CEC1;
	Thu, 29 Aug 2024 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948652;
	bh=f7k2RFFNI4rYawBKgZ9GVW3htA3KUVzIjVPTHpETdKc=;
	h=Subject:To:Cc:From:Date:From;
	b=FBuMJgjhtmNM4rfeR2jdD9sNz8M5L/J0psfQlGGXP6gp+nDyICHqvdzS5i1Kd1Ifg
	 YsJo0uclXfvL40948nhO4yA/59/1VB4XeEaIg6yf0zkqtPjW39A8e017mIM/L3G89u
	 4FN/coGMazFcYLPdXCRNu1LRbbyZNUlurtKQeDp8=
Subject: FAILED: patch "[PATCH] smb/client: fix rdma usage in smb2_async_writev()" failed to apply to 6.10-stable tree
To: metze@samba.org,dhowells@redhat.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 29 Aug 2024 18:24:09 +0200
Message-ID: <2024082909-everyday-familiar-e920@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 017d1701743657fbfaea74397727a9d2b81846b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082909-everyday-familiar-e920@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

017d17017436 ("smb/client: fix rdma usage in smb2_async_writev()")
b608e2c31878 ("smb/client: remove unused rq_iter_size from struct smb_rqst")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 017d1701743657fbfaea74397727a9d2b81846b7 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Wed, 21 Aug 2024 16:31:39 +0200
Subject: [PATCH] smb/client: fix rdma usage in smb2_async_writev()

rqst.rq_iter needs to be truncated otherwise we'll
also send the bytes into the stream socket...

This is the logic behind rqst.rq_npages = 0, which was removed in
"cifs: Change the I/O paths to use an iterator rather than a page list"
(d08089f649a0cfb2099c8551ac47eef0cc23fdf2).

Cc: stable@vger.kernel.org
Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 63a2541d4a05..2d7e6c42cf18 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4913,6 +4913,13 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	if (rc)
 		goto out;
 
+	rqst.rq_iov = iov;
+	rqst.rq_iter = wdata->subreq.io_iter;
+
+	rqst.rq_iov[0].iov_len = total_len - 1;
+	rqst.rq_iov[0].iov_base = (char *)req;
+	rqst.rq_nvec += 1;
+
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
@@ -4924,6 +4931,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	req->WriteChannelInfoOffset = 0;
 	req->WriteChannelInfoLength = 0;
 	req->Channel = SMB2_CHANNEL_NONE;
+	req->Length = cpu_to_le32(io_parms->length);
 	req->Offset = cpu_to_le64(io_parms->offset);
 	req->DataOffset = cpu_to_le16(
 				offsetof(struct smb2_write_req, Buffer));
@@ -4943,7 +4951,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	 */
 	if (smb3_use_rdma_offload(io_parms)) {
 		struct smbd_buffer_descriptor_v1 *v1;
-		size_t data_size = iov_iter_count(&wdata->subreq.io_iter);
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
 		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->subreq.io_iter,
@@ -4952,9 +4959,10 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 			rc = -EAGAIN;
 			goto async_writev_out;
 		}
+		/* For RDMA read, I/O size is in RemainingBytes not in Length */
+		req->RemainingBytes = req->Length;
 		req->Length = 0;
 		req->DataOffset = 0;
-		req->RemainingBytes = cpu_to_le32(data_size);
 		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
 		if (need_invalidate)
 			req->Channel = SMB2_CHANNEL_RDMA_V1;
@@ -4966,30 +4974,22 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		v1->offset = cpu_to_le64(wdata->mr->mr->iova);
 		v1->token = cpu_to_le32(wdata->mr->mr->rkey);
 		v1->length = cpu_to_le32(wdata->mr->mr->length);
+
+		rqst.rq_iov[0].iov_len += sizeof(*v1);
+
+		/*
+		 * We keep wdata->subreq.io_iter,
+		 * but we have to truncate rqst.rq_iter
+		 */
+		iov_iter_truncate(&rqst.rq_iter, 0);
 	}
 #endif
-	iov[0].iov_len = total_len - 1;
-	iov[0].iov_base = (char *)req;
 
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 1;
-	rqst.rq_iter = wdata->subreq.io_iter;
 	if (test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
 		smb2_set_replay(server, &rqst);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (wdata->mr)
-		iov[0].iov_len += sizeof(struct smbd_buffer_descriptor_v1);
-#endif
-	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
-		 io_parms->offset, io_parms->length, iov_iter_count(&rqst.rq_iter));
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	/* For RDMA read, I/O size is in RemainingBytes not in Length */
-	if (!wdata->mr)
-		req->Length = cpu_to_le32(io_parms->length);
-#else
-	req->Length = cpu_to_le32(io_parms->length);
-#endif
+	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
+		 io_parms->offset, io_parms->length, iov_iter_count(&wdata->subreq.io_iter));
 
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->subreq.len,


