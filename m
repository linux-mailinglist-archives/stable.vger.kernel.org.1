Return-Path: <stable+bounces-189784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1075C0A9F3
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D21D3A306C
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CB2DC763;
	Sun, 26 Oct 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyAgXBYQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19242D7DCD
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488795; cv=none; b=TZi85CdXCQ8q4llA88k9Xs4NptHlUlK+XyJh3+WfsmwMPjWlED3z0qa/AOH4rEAdgMeNdDh27we/l8lws0hR6VE/1eC5h/P08DthJp9dXpqNpB2zjXfuVUfIAP+pr4M/pxWchxfAVCPJBl+GEp6rpcXOkdEoVZpOW0p7xhZ9hHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488795; c=relaxed/simple;
	bh=Sd5Z8XBouxgXMc92eepyYjOK2699mRtmqM4yqu9OO04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y+DOfPITaEFnC0n/TM8E2NIXd2kPvDyP8SMfRwTY+sg7zYFbPatFf2389MhacZrfHchPuETizov3+N1ht+JKoBjIkdGNvGKyFLaj1r/aP0Z1LvSth8sLFBzYzY2cgfdAUOjqTi47q9uZVj59+pcZyF94ImEAM4BZzAoxlL5E958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyAgXBYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9EC4CEE7;
	Sun, 26 Oct 2025 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488795;
	bh=Sd5Z8XBouxgXMc92eepyYjOK2699mRtmqM4yqu9OO04=;
	h=Subject:To:Cc:From:Date:From;
	b=NyAgXBYQx0fEBkD5b6rdV+K1woG8GMCBYtVHye2kaYV05K4de/SvkkH7aVWIIdW6S
	 cW+1kudN6L7HleYbD9C5XE7O4o7EpvMJ9EVIWWGzejp8Y4Qad1/tXROTeWOCw3wUBv
	 OUqmICUYEdPpXmiPZk2HZ6z6A3Fs+vJi+70Lye4c=
Subject: FAILED: patch "[PATCH] smb: client: allocate enough space for MR WRs and" failed to apply to 6.1-stable tree
To: metze@samba.org,linkinjeon@kernel.org,longli@microsoft.com,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:26:14 +0100
Message-ID: <2025102614-trustful-rancidity-1b04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e607ef686ab95fbcb0dfd16f49aea7918be626e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102614-trustful-rancidity-1b04@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e607ef686ab95fbcb0dfd16f49aea7918be626e1 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 16 Oct 2025 12:54:21 +0200
Subject: [PATCH] smb: client: allocate enough space for MR WRs and
 ib_drain_qp()

The IB_WR_REG_MR and IB_WR_LOCAL_INV operations for smbdirect_mr_io
structures should never fail because the submission or completion queues
are too small. So we allocate more send_wr depending on the (local) max
number of MRs.

While there also add additional space for ib_drain_qp().

This should make sure ib_post_send() will never fail
because the submission queue is full.

Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Fixes: cc55f65dd352 ("smb: client: make use of common smbdirect_socket_parameters")
Cc: stable@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 49e2df3ad1f0..b1218ea4aa8b 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1767,6 +1767,7 @@ static struct smbd_connection *_smbd_get_connection(
 	struct smbdirect_socket *sc;
 	struct smbdirect_socket_parameters *sp;
 	struct rdma_conn_param conn_param;
+	struct ib_qp_cap qp_cap;
 	struct ib_qp_init_attr qp_attr;
 	struct sockaddr_in *addr_in = (struct sockaddr_in *) dstaddr;
 	struct ib_port_immutable port_immutable;
@@ -1838,6 +1839,25 @@ static struct smbd_connection *_smbd_get_connection(
 		goto config_failed;
 	}
 
+	sp->responder_resources =
+		min_t(u8, sp->responder_resources,
+		      sc->ib.dev->attrs.max_qp_rd_atom);
+	log_rdma_mr(INFO, "responder_resources=%d\n",
+		sp->responder_resources);
+
+	/*
+	 * We use allocate sp->responder_resources * 2 MRs
+	 * and each MR needs WRs for REG and INV, so
+	 * we use '* 4'.
+	 *
+	 * +1 for ib_drain_qp()
+	 */
+	memset(&qp_cap, 0, sizeof(qp_cap));
+	qp_cap.max_send_wr = sp->send_credit_target + sp->responder_resources * 4 + 1;
+	qp_cap.max_recv_wr = sp->recv_credit_max + 1;
+	qp_cap.max_send_sge = SMBDIRECT_SEND_IO_MAX_SGE;
+	qp_cap.max_recv_sge = SMBDIRECT_RECV_IO_MAX_SGE;
+
 	sc->ib.pd = ib_alloc_pd(sc->ib.dev, 0);
 	if (IS_ERR(sc->ib.pd)) {
 		rc = PTR_ERR(sc->ib.pd);
@@ -1848,7 +1868,7 @@ static struct smbd_connection *_smbd_get_connection(
 
 	sc->ib.send_cq =
 		ib_alloc_cq_any(sc->ib.dev, sc,
-				sp->send_credit_target, IB_POLL_SOFTIRQ);
+				qp_cap.max_send_wr, IB_POLL_SOFTIRQ);
 	if (IS_ERR(sc->ib.send_cq)) {
 		sc->ib.send_cq = NULL;
 		goto alloc_cq_failed;
@@ -1856,7 +1876,7 @@ static struct smbd_connection *_smbd_get_connection(
 
 	sc->ib.recv_cq =
 		ib_alloc_cq_any(sc->ib.dev, sc,
-				sp->recv_credit_max, IB_POLL_SOFTIRQ);
+				qp_cap.max_recv_wr, IB_POLL_SOFTIRQ);
 	if (IS_ERR(sc->ib.recv_cq)) {
 		sc->ib.recv_cq = NULL;
 		goto alloc_cq_failed;
@@ -1865,11 +1885,7 @@ static struct smbd_connection *_smbd_get_connection(
 	memset(&qp_attr, 0, sizeof(qp_attr));
 	qp_attr.event_handler = smbd_qp_async_error_upcall;
 	qp_attr.qp_context = sc;
-	qp_attr.cap.max_send_wr = sp->send_credit_target;
-	qp_attr.cap.max_recv_wr = sp->recv_credit_max;
-	qp_attr.cap.max_send_sge = SMBDIRECT_SEND_IO_MAX_SGE;
-	qp_attr.cap.max_recv_sge = SMBDIRECT_RECV_IO_MAX_SGE;
-	qp_attr.cap.max_inline_data = 0;
+	qp_attr.cap = qp_cap;
 	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	qp_attr.qp_type = IB_QPT_RC;
 	qp_attr.send_cq = sc->ib.send_cq;
@@ -1883,12 +1899,6 @@ static struct smbd_connection *_smbd_get_connection(
 	}
 	sc->ib.qp = sc->rdma.cm_id->qp;
 
-	sp->responder_resources =
-		min_t(u8, sp->responder_resources,
-		      sc->ib.dev->attrs.max_qp_rd_atom);
-	log_rdma_mr(INFO, "responder_resources=%d\n",
-		sp->responder_resources);
-
 	memset(&conn_param, 0, sizeof(conn_param));
 	conn_param.initiator_depth = sp->initiator_depth;
 	conn_param.responder_resources = sp->responder_resources;


