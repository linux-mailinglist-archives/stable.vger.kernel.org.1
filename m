Return-Path: <stable+bounces-270427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +fceCftcRmr/RgsAu9opvQ
	(envelope-from <stable+bounces-270427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:43:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 855676F7CC7
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:43:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=wa8Geehd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270427-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270427-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975EB30730D3
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5AD478E3A;
	Thu,  2 Jul 2026 12:38:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007926ED40;
	Thu,  2 Jul 2026 12:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995925; cv=none; b=LWPA1Hog9CzYdbgKkBSWXBmSo/CQduXU5Jz59g90dBOpYhSlciIWgDcr2zroI/A6IpmtA+DTeAwObDxhx9/hRvor8HiXRmmLn4YJcHrEFcgMcyMq9pjnNjQlnF5k0SOseKo3gEJuY2HjJsoj5eCRrfHS7kc6Y0Z/NmU0rsh1bLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995925; c=relaxed/simple;
	bh=sFKBSdGs6U8VmnH0Vwsy5UTVUBPubwlrpxWzEIWh67w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crHCgXT0p9T5W4D4e+qlbEXvt4kspTi7tdaU1OvhpM9M6tnTgDSWPFdj4KuxAngBqQonOa2vgPC4DTEVDCXtw9li3YY2Ga83ny8PNrLQVzSJwjRcpc13LoJ36EcKX5owv6mdGfY/S/oZJhlARle2f2ss6hBHAvIyRNEVpmhrBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wa8Geehd; arc=none smtp.client-ip=115.124.30.112
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782995920; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lKI7fmOaYipG31xvygjbfgJ816qdaKPkIEG+rDNU3b4=;
	b=wa8GeehdL7tRyP1h+w3MLBGUD9dI8pG5gMJmjEJ7czpji0gVCGOvqfwmStM9vbY8f+L4yceL2E5LD5peIsgw1zGqGInagZQeGy4fd+o9OHnz8qrpRTl5k1nzL4UMEI+W/A/NIRZ4a58wSzFRbqiLaFN5cL4KIjwCRvKTt1g/0a4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6En153_1782995919;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6En153_1782995919 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:38:40 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Thu,  2 Jul 2026 20:38:39 +0800
Message-Id: <20260702123839.100640-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,grimberg.me,nvidia.com,linuxfoundation.org,syr.edu,gmail.com,kernel.org,linux.alibaba.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270427-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:gregkh@linuxfoundation.org,m:skumar47@syr.edu,m:kumar.shivam43666@gmail.com,m:kbusch@kernel.org,m:dust.li@linux.alibaba.com,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kumarshivam43666@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 855676F7CC7

From: Chaitanya Kulkarni <kch@nvidia.com>

commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.

nvmet_tcp_handle_icreq() updates queue->state after sending an
Initialization Connection Response (ICResp), but it does so without
serializing against target-side queue teardown.

If an NVMe/TCP host sends an Initialization Connection Request
(ICReq) and immediately closes the connection, target-side teardown
may start in softirq context before io_work drains the already
buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
reference under state_lock.

If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
allows a later socket state change to re-enter teardown and issue a
second kref_put() on an already released queue.

The ICResp send failure path has the same problem. If teardown has
already moved the queue to DISCONNECTING, a send error can still
overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
window for a second teardown path to drop the queue reference.

Fix this by serializing both post-send state transitions with
state_lock and bailing out if teardown has already started.

Use -ESHUTDOWN as an internal sentinel for that bail-out path rather
than propagating it as a transport error like -ECONNRESET. Keep
nvmet_tcp_socket_error() setting rcv_state to NVMET_TCP_RECV_ERR before
honoring that sentinel so receive-side parsing stays quiesced until the
existing release path completes.

Fixes: c46a6465bac2 ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Reported-by: Shivam Kumar <skumar47@syr.edu>
Tested-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ context diff adaptation: drop `queue->state = NVMET_TCP_Q_FAILED` since
 the enum introduced in 6.7, 675b453e0241 ("nvmet-tcp: enable TLS handshake
 upcall" ]
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 drivers/nvme/target/tcp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index edcc0662c3e5..4bd82e9b113f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -345,6 +345,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)

 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 {
+	/*
+	 * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
+	 * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
+	 * already been consumed and queue teardown has started.
+	 *
+	 * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
+	 * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
+	 * cancels it, the queue must not keep that old receive state.
+	 * Otherwise the next nvmet_tcp_io_work() run can reach
+	 * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
+	 *
+	 * That is why queue->rcv_state needs to be updated before we return.
+	 */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (queue->nvme_sq.ctrl)
 		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
@@ -888,10 +901,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-	if (ret < 0)
+	if (ret < 0) {
+		spin_lock_bh(&queue->state_lock);
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+			spin_unlock_bh(&queue->state_lock);
+			return -ESHUTDOWN;
+		}
+		spin_unlock_bh(&queue->state_lock);
 		return ret; /* queue removal will cleanup */
+	}

+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+		spin_unlock_bh(&queue->state_lock);
+		/* Tell nvmet_tcp_socket_error() teardown is in progress. */
+		return -ESHUTDOWN;
+	}
 	queue->state = NVMET_TCP_Q_LIVE;
+	spin_unlock_bh(&queue->state_lock);
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
 }
--
2.47.3


