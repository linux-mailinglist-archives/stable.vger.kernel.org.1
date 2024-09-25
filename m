Return-Path: <stable+bounces-77150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE098592E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CCAB24C59
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250E19AA57;
	Wed, 25 Sep 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG67k09I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0B19B3C1;
	Wed, 25 Sep 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264310; cv=none; b=RK0qbSCmc1NpKTNFpOj5klPNGH/v+h5B/hn08zxhLgstBEyq8muVsI77l5dPnqUvPiBrjpNch95v28F4jpfkvnk3HlqUh/irmQJo+JcTUL4AAx6uKLl5AF2dDpnOJCxiimwEQhlVq7rnfIAl37vLsYAhE8XfMygggeZXYrasubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264310; c=relaxed/simple;
	bh=qkuWKdSeaJAjaMLFstU1DucU5PUzHwJ+w/H+9SM5DpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH1zQa5CggNfQy7i8TCbGGn+S7alPDy9kZ5wDtOVfRbxT85zPSqYSZv2iWe4FGGPQ6By5s5SxocnW6P7+C2WTGO4VALaSa/S0j29Y8GM8OrPmr9LaOWjbSBEU7aCOyQwwn3cYkPN72uWCem2UOF10CdXUEUbxbaoX/3ck4InxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG67k09I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7FC4CEC3;
	Wed, 25 Sep 2024 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264310;
	bh=qkuWKdSeaJAjaMLFstU1DucU5PUzHwJ+w/H+9SM5DpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RG67k09Ic7yZh7K3XojGtnV6/7uuypmm96q7P7dgs9MZ//zvaQwxztFls/H/OACy6
	 7qB5sOF2E+7WDpyGOFQTTtGUyfxYX5Kh9GHbRi6keyyQR0pEdOXn8MJTmrif95hHn6
	 Aa3eX6FiJtWH2tku/qNEyPj5FfM0Y6dKvdQesjIwFSgAzdmzHYyLB0gXIc1A28NC7i
	 uP7NfuCXH6tv106nL03QQzore4oInKH/ikdyx98joTIKxYpixskEH7sBHa0q7uLHKt
	 DKMOfbiuBmZtasj1cpQEfHeL/GSzaZTf/KAbVOif4T2lOMm1GK9+g5d+OzMQW9PFAq
	 jjyjpWacMPgZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 052/244] nvme-tcp: sanitize TLS key handling
Date: Wed, 25 Sep 2024 07:24:33 -0400
Message-ID: <20240925113641.1297102-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 363895767fbfa05891b0b4d9e06ebde7a10c6a07 ]

There is a difference between TLS configured (ie the user has
provisioned/requested a key) and TLS enabled (ie the connection
is encrypted with TLS). This becomes important for secure concatenation,
where the initial authentication is run on an unencrypted connection
(ie with TLS configured, but not enabled), and then the queue is reset to
run over TLS (ie TLS configured _and_ enabled).
So to differentiate between those two states store the generated
key in opts->tls_key (as we're using the same TLS key for all queues),
the key serial of the resulting TLS handshake in ctrl->tls_pskid
(to signal that TLS on the admin queue is enabled), and a simple
flag for the queues to indicated that TLS has been enabled.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c  |  1 -
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c |  4 +--
 drivers/nvme/host/tcp.c   | 53 +++++++++++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 983909a600adb..a6fb1359a7e14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4678,7 +4678,6 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e01b1332d245a..313a4f978a2cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -377,7 +377,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
-	struct key *tls_key;
+	key_serial_t tls_pskid;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ba05faaac562d..72675b59a7a73 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -670,9 +670,9 @@ static ssize_t tls_key_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (!ctrl->tls_key)
+	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f0..b305873e588e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,6 +165,7 @@ struct nvme_tcp_queue {
 
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			tls_enabled;
 	struct ahash_request	*rcv_hash;
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
@@ -213,7 +214,21 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
-static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
+/*
+ * Check if the queue is TLS encrypted
+ */
+static inline bool nvme_tcp_queue_tls(struct nvme_tcp_queue *queue)
+{
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		return 0;
+
+	return queue->tls_enabled;
+}
+
+/*
+ * Check if TLS is configured for the controller.
+ */
+static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 {
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
@@ -368,7 +383,7 @@ static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 {
-	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+	return !nvme_tcp_queue_tls(queue) &&
 		nvme_tcp_queue_has_pending(queue);
 }
 
@@ -1427,7 +1442,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
@@ -1439,7 +1454,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
@@ -1587,7 +1602,10 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 			 qid, pskid);
 		queue->tls_err = -ENOKEY;
 	} else {
-		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_enabled = true;
+		if (qid == 0)
+			ctrl->ctrl.tls_pskid = key_serial(tls_key);
+		key_put(tls_key);
 		queue->tls_err = 0;
 	}
 
@@ -1768,7 +1786,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
+	if (nvme_tcp_tls_configured(nctrl) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1829,6 +1847,8 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
+	/* Stopping the queue will disable TLS */
+	queue->tls_enabled = false;
 	mutex_unlock(&queue->queue_lock);
 }
 
@@ -1925,16 +1945,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (nvme_tcp_tls(ctrl)) {
+	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
-		else
+		else {
 			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
 						      ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
-		if (!pskid) {
-			dev_err(ctrl->device, "no valid PSK found\n");
-			return -ENOKEY;
+			if (!pskid) {
+				dev_err(ctrl->device, "no valid PSK found\n");
+				return -ENOKEY;
+			}
 		}
 	}
 
@@ -1957,13 +1978,14 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
-	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
+	if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
 		dev_err(ctrl->device, "no PSK negotiated\n");
 		return -ENOKEY;
 	}
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
-				key_serial(ctrl->tls_key));
+				ctrl->tls_pskid);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2144,6 +2166,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
+	if (ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
+			ctrl->tls_pskid);
+		ctrl->tls_pskid = 0;
+	}
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-- 
2.43.0


