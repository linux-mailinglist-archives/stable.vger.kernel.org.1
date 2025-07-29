Return-Path: <stable+bounces-165102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D2B1519D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6125442F0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD96226D1E;
	Tue, 29 Jul 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho2+bTC3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD2220F4C
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807625; cv=none; b=Patfz5bW1L16VJ3Q9yb730IfUSLYpNP3Srjja5uCqi/c4c5mmm6rOxv+dbUor6xv1B/YxMjpRInvuWo1DUJCIK1aTmp44H8YB1hBjlqXLHj2D8VNvXijH8rCYWZgyQx/Or5GNRk+3loMHGQj/spossGLkQDGYF0ATZNNklpwJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807625; c=relaxed/simple;
	bh=luTvMt4XQl3Uby1WIEv1Xd/Xht+Vjsiz2+KO/rI/JyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8xnhXTREnXPQ32bUHbYj4ccI2mPL358bFe27gTQpQwR+lCInkqx3tpUVjdB+t3Vghv5StpdpbYOVrXab6DHbfAXEoA1xr7li1cAnIidNMsFOryZKzhBnY/hFGazsjiw4hkFBUGilr409E5Ize4PbxyfEFg8oqAchlez9fzgzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho2+bTC3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753807622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0M4h6g0I6U3fqh7cyPhH+dOB/h2Zb4UVTFQSQiijyg=;
	b=ho2+bTC3m9/Jpw87AVyewJCzK+JYiHqwj2D1vFGs2OeU9S6EtzwaZbhGO/ofYFXX34HqdU
	JDcNRt4UWgQnOnOVqoQ1vD7WW6iAeiiNs5HnXsrnLNtVXBF6MHLsKcXE7LiBh3LiMiqJuQ
	ZFoU/K6m0mZzCi7Z2CPg9cxnOrrDVlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-rC7vkQxHOuWK3ns5t1O8cQ-1; Tue,
 29 Jul 2025 12:47:01 -0400
X-MC-Unique: rC7vkQxHOuWK3ns5t1O8cQ-1
X-Mimecast-MFC-AGG-ID: rC7vkQxHOuWK3ns5t1O8cQ_1753807620
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E00819560B1
	for <Stable@vger.kernel.org>; Tue, 29 Jul 2025 16:47:00 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CBDC18003FC;
	Tue, 29 Jul 2025 16:46:58 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: smayhew@redhat.com
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Stable@vger.kernel.org
Subject: [PATCH 3/4] nvme: fix handling of tls alerts
Date: Tue, 29 Jul 2025 12:46:48 -0400
Message-Id: <20250729164649.46703-4-okorniev@redhat.com>
In-Reply-To: <20250729164649.46703-1-okorniev@redhat.com>
References: <20250729164649.46703-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Revert kvec msg iterator before trying to process a TLS alert
when possible.

In nvmet_tcp_try_recv_data(), it's assumed that no msg control
message buffer is set prior to sock_recvmsg(). If no control
message structure is setup, kTLS layer will read and process
TLS data record types. As soon as it encounters a TLS control
message, it would return an error. At that point, we setup a kvec
backed control buffer and read in the control message such as
a TLS alert. Msg can advance the kvec pointer as a part of the
copy process thus we need to revert the iterator before calling
into the tls_alert_recv.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 drivers/nvme/target/tcp.c | 48 +++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 688033b88d38..cf3336ddc9a3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1218,18 +1219,47 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->cmd;
 	int len, ret;
+	union {
+		struct cmsghdr cmsg;
+		u8 buf[CMSG_SPACE(sizeof(u8))];
+	} u;
+	u8 alert[2];
+	struct kvec alert_kvec = {
+		.iov_base = alert,
+		.iov_len = sizeof(alert),
+	};
+	struct msghdr msg = {
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
 
 	while (msg_data_left(&cmd->recv_msg)) {
+		/* assumed that cmg->recv_msg's control buffer is not setup
+		 */
+		WARN_ON_ONCE(cmd->recv_msg.msg_controllen > 0);
+
 		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
+		if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
+			cmd->recv_msg.msg_flags &= ~(MSG_CTRUNC | MSG_EOF);
+			if (len == 0 || len == -EIO) {
+				iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec,
+					      1, alert_kvec.iov_len);
+				len = sock_recvmsg(cmd->queue->sock, &msg,
+						   MSG_DONTWAIT);
+				if (len > 0 &&
+				    tls_get_record_type(cmd->queue->sock->sk,
+					    &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+					iov_iter_revert(&msg.msg_iter, len);
+					ret = nvmet_tcp_tls_record_ok(cmd->queue,
+							&msg, u.buf);
+					if (ret < 0)
+						return ret;
+				}
+			}
+		}
 		if (len <= 0)
 			return len;
-		if (queue->tls_pskid) {
-			ret = nvmet_tcp_tls_record_ok(cmd->queue,
-					&cmd->recv_msg, cmd->recv_cbuf);
-			if (ret < 0)
-				return ret;
-		}
 
 		cmd->pdu_recv += len;
 		cmd->rbytes_done += len;
@@ -1267,6 +1297,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1453,10 +1484,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		c->recv_msg.msg_control = c->recv_cbuf;
-		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
-	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1736,6 +1763,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
+	iov_iter_revert(&msg.msg_iter, len);
 	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 	if (ret < 0)
 		return ret;
-- 
2.47.1


