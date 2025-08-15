Return-Path: <stable+bounces-169733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDBB282EC
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037C4189C495
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAB2C0F9F;
	Fri, 15 Aug 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rKoEpCHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886F2C0F91
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271612; cv=none; b=kthOSTfEnNzWDh3RpTX23zWQ8KAsJpLM5yLdlIAjXzvf+quCAMTFgyzFkfSPVj0l0pELb0Ld0GEEN2EqvhvrL5z+NGbxuyGeyipQnC1TzzFHNX/BmqzSHFtn/qusZDGY9aLy+8vMZ43CoPeWyko4YdrJVPo2FjuH6WsyXXw2adU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271612; c=relaxed/simple;
	bh=stREAgnMdAP+nZLwyWVupLdAeRXCNUIIw+dQyqm9kr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HhupwCCXkCG4r6/ldiLcgsyta/gc+BMwiWGc05DzU12WfNCqi54NJplAMXwp7fRF28TDKeqgucG8G0UZoM3trevFNI+YpW114rIZF8d3QCr0PATxcTxOZcGKlYQjC2hSnY01nCXOoWNuGMLTGmnF0Rz2oCEnW5DLJvm0Rm4TxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rKoEpCHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7A0C4CEEB;
	Fri, 15 Aug 2025 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755271611;
	bh=stREAgnMdAP+nZLwyWVupLdAeRXCNUIIw+dQyqm9kr0=;
	h=Subject:To:Cc:From:Date:From;
	b=rKoEpCHIMO35IEKr6Xn1CfZ+X2O+cAQzUNIksr8Fb/L6oYVs4Ht5g68rNwLUqMr50
	 kFv0XIaKAxe50btpjUiO9IBex06gl4md+74C5GjYJzCvd/33FiK3PPE2+fEOp02V5Q
	 qtidaiOahgH0dzuqZp4NsrTuTTOCYnFmFM9X0vYs=
Subject: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on retry" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,superman.xpt@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 17:26:48 +0200
Message-ID: <2025081548-whoops-aneurism-c7b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081548-whoops-aneurism-c7b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41b70df5b38bc80967d2e0ed55cc3c3896bba781 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 12 Aug 2025 08:30:11 -0600
Subject: [PATCH] io_uring/net: commit partial buffers on retry

Ring provided buffers are potentially only valid within the single
execution context in which they were acquired. io_uring deals with this
and invalidates them on retry. But on the networking side, if
MSG_WAITALL is set, or if the socket is of the streaming type and too
little was processed, then it will hang on to the buffer rather than
recycle or commit it. This is problematic for two reasons:

1) If someone unregisters the provided buffer ring before a later retry,
   then the req->buf_list will no longer be valid.

2) If multiple sockers are using the same buffer group, then multiple
   receives can consume the same memory. This can cause data corruption
   in the application, as either receive could land in the same
   userspace buffer.

Fix this by disallowing partial retries from pinning a provided buffer
across multiple executions, if ring provided buffers are used.

Cc: stable@vger.kernel.org
Reported-by: pt x <superman.xpt@gmail.com>
Fixes: c56e022c0a27 ("io_uring: add support for user mapped provided buffer ring")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index dd96e355982f..d69f2afa4f7a 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -494,6 +494,15 @@ static int io_bundle_nbufs(struct io_async_msghdr *kmsg, int ret)
 	return nbufs;
 }
 
+static int io_net_kbuf_recyle(struct io_kiocb *req,
+			      struct io_async_msghdr *kmsg, int len)
+{
+	req->flags |= REQ_F_BL_NO_RECYCLE;
+	if (req->flags & REQ_F_BUFFERS_COMMIT)
+		io_kbuf_commit(req, req->buf_list, len, io_bundle_nbufs(kmsg, len));
+	return IOU_RETRY;
+}
+
 static inline bool io_send_finish(struct io_kiocb *req, int *ret,
 				  struct io_async_msghdr *kmsg,
 				  unsigned issue_flags)
@@ -562,8 +571,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 			kmsg->msg.msg_controllen = 0;
 			kmsg->msg.msg_control = NULL;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -674,8 +682,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1071,8 +1078,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		}
 		if (ret > 0 && io_net_retry(sock, flags)) {
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return IOU_RETRY;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1218,8 +1224,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1500,8 +1505,7 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 			zc->len -= ret;
 			zc->buf += ret;
 			zc->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1571,8 +1575,7 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 
 		if (ret > 0 && io_net_retry(sock, flags)) {
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;


