Return-Path: <stable+bounces-165098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C7B15185
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B0C17F899
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A612980A4;
	Tue, 29 Jul 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bosvO+Ut"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6E22759C
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807272; cv=none; b=nQSm3iXZZnvrkZF9wE32o4qS7kZJOB7uZQHGV/SYw/RyFNkgQm0KYIKQ2Oew8qpWVBQ/y3FOv0/WLsnbdnei6DVn25+TouQcFzmnEng1Qfy4khabyGjC5DZpMZqW8wnmVa88JoTIYWDDXgD4C34bkTYjStnzZijHGdGBD28nlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807272; c=relaxed/simple;
	bh=luTvMt4XQl3Uby1WIEv1Xd/Xht+Vjsiz2+KO/rI/JyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBCubbk5V9soRcs5L1nBvsT2ap4V9VDvYBbCKBOhN6TNByQLfkDsqTlcJHieyw2/QAgDmI5rCuuFobJ+Ybm+art2haCqhrwQ9zwMvTGtKoMb9b3Tt7DSWzp11/RuBkJyaSgdNSsXSXe2f9oGnq/eP8jn8T/UkyfQq0XKOOOXxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bosvO+Ut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753807269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0M4h6g0I6U3fqh7cyPhH+dOB/h2Zb4UVTFQSQiijyg=;
	b=bosvO+UtDIf0jO4FR/u/kaIWvbgfGcBkoIO9NtXwYzkP0PPwgS+kA/wAeVk7GX8+7OFAX5
	igCDDw59J7JpUf8DZKXDQtdeoD4oL2+lMqRs9+tqd/YPYZm8hJPtPEIpKyJsFUXnwd3Z+f
	jNV68/yGbvPqc975RLqsJrpnCpjaKLQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-scOgWq66Ohepxm0dpXBfLA-1; Tue,
 29 Jul 2025 12:41:06 -0400
X-MC-Unique: scOgWq66Ohepxm0dpXBfLA-1
X-Mimecast-MFC-AGG-ID: scOgWq66Ohepxm0dpXBfLA_1753807264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CAF918001D5;
	Tue, 29 Jul 2025 16:41:04 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1840630001B1;
	Tue, 29 Jul 2025 16:41:01 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hare@suse.de
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Stable@vger.kernel.org
Subject: [PATCH 3/4] nvme: fix handling of tls alerts
Date: Tue, 29 Jul 2025 12:40:22 -0400
Message-Id: <20250729164023.46643-4-okorniev@redhat.com>
In-Reply-To: <20250729164023.46643-1-okorniev@redhat.com>
References: <20250729164023.46643-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


