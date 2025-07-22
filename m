Return-Path: <stable+bounces-164259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A87B0DDDF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BA07B6166
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824EC2ED847;
	Tue, 22 Jul 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQiqmdyk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90A2E9EDD;
	Tue, 22 Jul 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193770; cv=none; b=UX6aN3ZoxIUiH6GIRrgQdNvdL5AfWl6abOLV6JopqETIojW/pk60vVTIBiTgjDxoS6BlROfblpj1b7N/HjHzPw5ajT8HzEEXL5wUIpqG4auKg6VFNAYBeVNFUHoYhuk9E25jmqCa0CpiLXW9TzeoqCJT0u3OCqxHDjxgL7+29tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193770; c=relaxed/simple;
	bh=iITBG4IDTyDSDflmc0oyVM/TkNorC7VyUPvrLQpnNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9CNdZk5TMSdoY9dqgATeZu0yadJVGyoqluYqZQ+LZC72o2plQZi4pLBLdjVvlYm2nTIg0NYkWb+5dM/U3iB8i4Dlcxaj8WxuEM1ss4lT3rLawUUgWRRM5I5tdV2ELlsOf268Wrgug56rVCUiKixxGZRelJ1Kce5vF87hgL4O/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQiqmdyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A220C4CEEB;
	Tue, 22 Jul 2025 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193770;
	bh=iITBG4IDTyDSDflmc0oyVM/TkNorC7VyUPvrLQpnNJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQiqmdykrxe7UYvx9IOPHLcw2HmTGiS9cKHSYuzHoBOEWKGn73rq6Z1WiB9cc8Wr2
	 1wo96Fzb2dxIF47Ww7lEZSyHhXRQHPAVFsQ8dB55Vwt+QDhzvDCGbhRgpZSRCDGxd2
	 IVJLirjhxS/NheYJEavKu0oDbrQAKzvjcBNri2RI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Meetakshi Setiya <meetakshisetiyaoss@gmail.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 180/187] smb: client: make use of common smbdirect_socket_parameters
Date: Tue, 22 Jul 2025 15:45:50 +0200
Message-ID: <20250722134352.475187692@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit cc55f65dd352bdb7bdf8db1c36fb348c294c3b66 upstream.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_debug.c |   21 ++++++----
 fs/smb/client/smb2ops.c    |   14 ++++--
 fs/smb/client/smbdirect.c  |   91 ++++++++++++++++++++++++++-------------------
 fs/smb/client/smbdirect.h  |   10 ----
 4 files changed, 77 insertions(+), 59 deletions(-)

--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -362,6 +362,10 @@ static int cifs_debug_data_proc_show(str
 	c = 0;
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
+#ifdef CONFIG_CIFS_SMB_DIRECT
+		struct smbdirect_socket_parameters *sp;
+#endif
+
 		/* channel info will be printed as a part of sessions below */
 		if (SERVER_IS_CHAN(server))
 			continue;
@@ -383,6 +387,7 @@ static int cifs_debug_data_proc_show(str
 			seq_printf(m, "\nSMBDirect transport not available");
 			goto skip_rdma;
 		}
+		sp = &server->smbd_conn->socket.parameters;
 
 		seq_printf(m, "\nSMBDirect (in hex) protocol version: %x "
 			"transport status: %x",
@@ -390,18 +395,18 @@ static int cifs_debug_data_proc_show(str
 			server->smbd_conn->socket.status);
 		seq_printf(m, "\nConn receive_credit_max: %x "
 			"send_credit_target: %x max_send_size: %x",
-			server->smbd_conn->receive_credit_max,
-			server->smbd_conn->send_credit_target,
-			server->smbd_conn->max_send_size);
+			sp->recv_credit_max,
+			sp->send_credit_target,
+			sp->max_send_size);
 		seq_printf(m, "\nConn max_fragmented_recv_size: %x "
 			"max_fragmented_send_size: %x max_receive_size:%x",
-			server->smbd_conn->max_fragmented_recv_size,
-			server->smbd_conn->max_fragmented_send_size,
-			server->smbd_conn->max_receive_size);
+			sp->max_fragmented_recv_size,
+			sp->max_fragmented_send_size,
+			sp->max_recv_size);
 		seq_printf(m, "\nConn keep_alive_interval: %x "
 			"max_readwrite_size: %x rdma_readwrite_threshold: %x",
-			server->smbd_conn->keep_alive_interval,
-			server->smbd_conn->max_readwrite_size,
+			sp->keepalive_interval_msec * 1000,
+			sp->max_read_write_size,
 			server->smbd_conn->rdma_readwrite_threshold);
 		seq_printf(m, "\nDebug count_get_receive_buffer: %x "
 			"count_put_receive_buffer: %x count_send_empty: %x",
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -504,6 +504,9 @@ smb3_negotiate_wsize(struct cifs_tcon *t
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
+		struct smbdirect_socket_parameters *sp =
+			&server->smbd_conn->socket.parameters;
+
 		if (server->sign)
 			/*
 			 * Account for SMB2 data transfer packet header and
@@ -511,12 +514,12 @@ smb3_negotiate_wsize(struct cifs_tcon *t
 			 */
 			wsize = min_t(unsigned int,
 				wsize,
-				server->smbd_conn->max_fragmented_send_size -
+				sp->max_fragmented_send_size -
 					SMB2_READWRITE_PDU_HEADER_SIZE -
 					sizeof(struct smb2_transform_hdr));
 		else
 			wsize = min_t(unsigned int,
-				wsize, server->smbd_conn->max_readwrite_size);
+				wsize, sp->max_read_write_size);
 	}
 #endif
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
@@ -552,6 +555,9 @@ smb3_negotiate_rsize(struct cifs_tcon *t
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
+		struct smbdirect_socket_parameters *sp =
+			&server->smbd_conn->socket.parameters;
+
 		if (server->sign)
 			/*
 			 * Account for SMB2 data transfer packet header and
@@ -559,12 +565,12 @@ smb3_negotiate_rsize(struct cifs_tcon *t
 			 */
 			rsize = min_t(unsigned int,
 				rsize,
-				server->smbd_conn->max_fragmented_recv_size -
+				sp->max_fragmented_recv_size -
 					SMB2_READWRITE_PDU_HEADER_SIZE -
 					sizeof(struct smb2_transform_hdr));
 		else
 			rsize = min_t(unsigned int,
-				rsize, server->smbd_conn->max_readwrite_size);
+				rsize, sp->max_read_write_size);
 	}
 #endif
 
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -320,6 +320,8 @@ static bool process_negotiation_response
 		struct smbd_response *response, int packet_length)
 {
 	struct smbd_connection *info = response->info;
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smbdirect_negotiate_resp *packet = smbd_response_payload(response);
 
 	if (packet_length < sizeof(struct smbdirect_negotiate_resp)) {
@@ -349,20 +351,20 @@ static bool process_negotiation_response
 
 	atomic_set(&info->receive_credits, 0);
 
-	if (le32_to_cpu(packet->preferred_send_size) > info->max_receive_size) {
+	if (le32_to_cpu(packet->preferred_send_size) > sp->max_recv_size) {
 		log_rdma_event(ERR, "error: preferred_send_size=%d\n",
 			le32_to_cpu(packet->preferred_send_size));
 		return false;
 	}
-	info->max_receive_size = le32_to_cpu(packet->preferred_send_size);
+	sp->max_recv_size = le32_to_cpu(packet->preferred_send_size);
 
 	if (le32_to_cpu(packet->max_receive_size) < SMBD_MIN_RECEIVE_SIZE) {
 		log_rdma_event(ERR, "error: max_receive_size=%d\n",
 			le32_to_cpu(packet->max_receive_size));
 		return false;
 	}
-	info->max_send_size = min_t(int, info->max_send_size,
-					le32_to_cpu(packet->max_receive_size));
+	sp->max_send_size = min_t(u32, sp->max_send_size,
+				  le32_to_cpu(packet->max_receive_size));
 
 	if (le32_to_cpu(packet->max_fragmented_size) <
 			SMBD_MIN_FRAGMENTED_SIZE) {
@@ -370,18 +372,18 @@ static bool process_negotiation_response
 			le32_to_cpu(packet->max_fragmented_size));
 		return false;
 	}
-	info->max_fragmented_send_size =
+	sp->max_fragmented_send_size =
 		le32_to_cpu(packet->max_fragmented_size);
 	info->rdma_readwrite_threshold =
-		rdma_readwrite_threshold > info->max_fragmented_send_size ?
-		info->max_fragmented_send_size :
+		rdma_readwrite_threshold > sp->max_fragmented_send_size ?
+		sp->max_fragmented_send_size :
 		rdma_readwrite_threshold;
 
 
-	info->max_readwrite_size = min_t(u32,
+	sp->max_read_write_size = min_t(u32,
 			le32_to_cpu(packet->max_readwrite_size),
 			info->max_frmr_depth * PAGE_SIZE);
-	info->max_frmr_depth = info->max_readwrite_size / PAGE_SIZE;
+	info->max_frmr_depth = sp->max_read_write_size / PAGE_SIZE;
 
 	return true;
 }
@@ -689,6 +691,7 @@ out1:
 static int smbd_post_send_negotiate_req(struct smbd_connection *info)
 {
 	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_send_wr send_wr;
 	int rc = -ENOMEM;
 	struct smbd_request *request;
@@ -704,11 +707,11 @@ static int smbd_post_send_negotiate_req(
 	packet->min_version = cpu_to_le16(SMBDIRECT_V1);
 	packet->max_version = cpu_to_le16(SMBDIRECT_V1);
 	packet->reserved = 0;
-	packet->credits_requested = cpu_to_le16(info->send_credit_target);
-	packet->preferred_send_size = cpu_to_le32(info->max_send_size);
-	packet->max_receive_size = cpu_to_le32(info->max_receive_size);
+	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
+	packet->preferred_send_size = cpu_to_le32(sp->max_send_size);
+	packet->max_receive_size = cpu_to_le32(sp->max_recv_size);
 	packet->max_fragmented_size =
-		cpu_to_le32(info->max_fragmented_recv_size);
+		cpu_to_le32(sp->max_fragmented_recv_size);
 
 	request->num_sge = 1;
 	request->sge[0].addr = ib_dma_map_single(
@@ -800,6 +803,7 @@ static int smbd_post_send(struct smbd_co
 		struct smbd_request *request)
 {
 	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_send_wr send_wr;
 	int rc, i;
 
@@ -831,7 +835,7 @@ static int smbd_post_send(struct smbd_co
 	} else
 		/* Reset timer for idle connection after packet is sent */
 		mod_delayed_work(info->workqueue, &info->idle_timer_work,
-			info->keep_alive_interval*HZ);
+			msecs_to_jiffies(sp->keepalive_interval_msec));
 
 	return rc;
 }
@@ -841,6 +845,7 @@ static int smbd_post_send_iter(struct sm
 			       int *_remaining_data_length)
 {
 	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	int i, rc;
 	int header_length;
 	int data_length;
@@ -868,7 +873,7 @@ wait_credit:
 
 wait_send_queue:
 	wait_event(info->wait_post_send,
-		atomic_read(&info->send_pending) < info->send_credit_target ||
+		atomic_read(&info->send_pending) < sp->send_credit_target ||
 		sc->status != SMBDIRECT_SOCKET_CONNECTED);
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
@@ -878,7 +883,7 @@ wait_send_queue:
 	}
 
 	if (unlikely(atomic_inc_return(&info->send_pending) >
-				info->send_credit_target)) {
+				sp->send_credit_target)) {
 		atomic_dec(&info->send_pending);
 		goto wait_send_queue;
 	}
@@ -917,7 +922,7 @@ wait_send_queue:
 
 	/* Fill in the packet header */
 	packet = smbd_request_payload(request);
-	packet->credits_requested = cpu_to_le16(info->send_credit_target);
+	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
 
 	new_credits = manage_credits_prior_sending(info);
 	atomic_add(new_credits, &info->receive_credits);
@@ -1017,16 +1022,17 @@ static int smbd_post_recv(
 		struct smbd_connection *info, struct smbd_response *response)
 {
 	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_recv_wr recv_wr;
 	int rc = -EIO;
 
 	response->sge.addr = ib_dma_map_single(
 				sc->ib.dev, response->packet,
-				info->max_receive_size, DMA_FROM_DEVICE);
+				sp->max_recv_size, DMA_FROM_DEVICE);
 	if (ib_dma_mapping_error(sc->ib.dev, response->sge.addr))
 		return rc;
 
-	response->sge.length = info->max_receive_size;
+	response->sge.length = sp->max_recv_size;
 	response->sge.lkey = sc->ib.pd->local_dma_lkey;
 
 	response->cqe.done = recv_done;
@@ -1274,6 +1280,8 @@ static void idle_connection_timer(struct
 	struct smbd_connection *info = container_of(
 					work, struct smbd_connection,
 					idle_timer_work.work);
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 
 	if (info->keep_alive_requested != KEEP_ALIVE_NONE) {
 		log_keep_alive(ERR,
@@ -1288,7 +1296,7 @@ static void idle_connection_timer(struct
 
 	/* Setup the next idle timeout work */
 	queue_delayed_work(info->workqueue, &info->idle_timer_work,
-			info->keep_alive_interval*HZ);
+			msecs_to_jiffies(sp->keepalive_interval_msec));
 }
 
 /*
@@ -1300,6 +1308,7 @@ void smbd_destroy(struct TCP_Server_Info
 {
 	struct smbd_connection *info = server->smbd_conn;
 	struct smbdirect_socket *sc;
+	struct smbdirect_socket_parameters *sp;
 	struct smbd_response *response;
 	unsigned long flags;
 
@@ -1308,6 +1317,7 @@ void smbd_destroy(struct TCP_Server_Info
 		return;
 	}
 	sc = &info->socket;
+	sp = &sc->parameters;
 
 	log_rdma_event(INFO, "destroying rdma session\n");
 	if (sc->status != SMBDIRECT_SOCKET_DISCONNECTED) {
@@ -1349,7 +1359,7 @@ void smbd_destroy(struct TCP_Server_Info
 	log_rdma_event(INFO, "free receive buffers\n");
 	wait_event(info->wait_receive_queues,
 		info->count_receive_queue + info->count_empty_packet_queue
-			== info->receive_credit_max);
+			== sp->recv_credit_max);
 	destroy_receive_buffers(info);
 
 	/*
@@ -1437,6 +1447,8 @@ static void destroy_caches_and_workqueue
 #define MAX_NAME_LEN	80
 static int allocate_caches_and_workqueue(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	char name[MAX_NAME_LEN];
 	int rc;
 
@@ -1451,7 +1463,7 @@ static int allocate_caches_and_workqueue
 		return -ENOMEM;
 
 	info->request_mempool =
-		mempool_create(info->send_credit_target, mempool_alloc_slab,
+		mempool_create(sp->send_credit_target, mempool_alloc_slab,
 			mempool_free_slab, info->request_cache);
 	if (!info->request_mempool)
 		goto out1;
@@ -1461,13 +1473,13 @@ static int allocate_caches_and_workqueue
 		kmem_cache_create(
 			name,
 			sizeof(struct smbd_response) +
-				info->max_receive_size,
+				sp->max_recv_size,
 			0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!info->response_cache)
 		goto out2;
 
 	info->response_mempool =
-		mempool_create(info->receive_credit_max, mempool_alloc_slab,
+		mempool_create(sp->recv_credit_max, mempool_alloc_slab,
 		       mempool_free_slab, info->response_cache);
 	if (!info->response_mempool)
 		goto out3;
@@ -1477,7 +1489,7 @@ static int allocate_caches_and_workqueue
 	if (!info->workqueue)
 		goto out4;
 
-	rc = allocate_receive_buffers(info, info->receive_credit_max);
+	rc = allocate_receive_buffers(info, sp->recv_credit_max);
 	if (rc) {
 		log_rdma_event(ERR, "failed to allocate receive buffers\n");
 		goto out5;
@@ -1505,6 +1517,7 @@ static struct smbd_connection *_smbd_get
 	int rc;
 	struct smbd_connection *info;
 	struct smbdirect_socket *sc;
+	struct smbdirect_socket_parameters *sp;
 	struct rdma_conn_param conn_param;
 	struct ib_qp_init_attr qp_attr;
 	struct sockaddr_in *addr_in = (struct sockaddr_in *) dstaddr;
@@ -1515,6 +1528,7 @@ static struct smbd_connection *_smbd_get
 	if (!info)
 		return NULL;
 	sc = &info->socket;
+	sp = &sc->parameters;
 
 	sc->status = SMBDIRECT_SOCKET_CONNECTING;
 	rc = smbd_ia_open(info, dstaddr, port);
@@ -1541,12 +1555,12 @@ static struct smbd_connection *_smbd_get
 		goto config_failed;
 	}
 
-	info->receive_credit_max = smbd_receive_credit_max;
-	info->send_credit_target = smbd_send_credit_target;
-	info->max_send_size = smbd_max_send_size;
-	info->max_fragmented_recv_size = smbd_max_fragmented_recv_size;
-	info->max_receive_size = smbd_max_receive_size;
-	info->keep_alive_interval = smbd_keep_alive_interval;
+	sp->recv_credit_max = smbd_receive_credit_max;
+	sp->send_credit_target = smbd_send_credit_target;
+	sp->max_send_size = smbd_max_send_size;
+	sp->max_fragmented_recv_size = smbd_max_fragmented_recv_size;
+	sp->max_recv_size = smbd_max_receive_size;
+	sp->keepalive_interval_msec = smbd_keep_alive_interval * 1000;
 
 	if (sc->ib.dev->attrs.max_send_sge < SMBDIRECT_MAX_SEND_SGE ||
 	    sc->ib.dev->attrs.max_recv_sge < SMBDIRECT_MAX_RECV_SGE) {
@@ -1561,7 +1575,7 @@ static struct smbd_connection *_smbd_get
 
 	sc->ib.send_cq =
 		ib_alloc_cq_any(sc->ib.dev, info,
-				info->send_credit_target, IB_POLL_SOFTIRQ);
+				sp->send_credit_target, IB_POLL_SOFTIRQ);
 	if (IS_ERR(sc->ib.send_cq)) {
 		sc->ib.send_cq = NULL;
 		goto alloc_cq_failed;
@@ -1569,7 +1583,7 @@ static struct smbd_connection *_smbd_get
 
 	sc->ib.recv_cq =
 		ib_alloc_cq_any(sc->ib.dev, info,
-				info->receive_credit_max, IB_POLL_SOFTIRQ);
+				sp->recv_credit_max, IB_POLL_SOFTIRQ);
 	if (IS_ERR(sc->ib.recv_cq)) {
 		sc->ib.recv_cq = NULL;
 		goto alloc_cq_failed;
@@ -1578,8 +1592,8 @@ static struct smbd_connection *_smbd_get
 	memset(&qp_attr, 0, sizeof(qp_attr));
 	qp_attr.event_handler = smbd_qp_async_error_upcall;
 	qp_attr.qp_context = info;
-	qp_attr.cap.max_send_wr = info->send_credit_target;
-	qp_attr.cap.max_recv_wr = info->receive_credit_max;
+	qp_attr.cap.max_send_wr = sp->send_credit_target;
+	qp_attr.cap.max_recv_wr = sp->recv_credit_max;
 	qp_attr.cap.max_send_sge = SMBDIRECT_MAX_SEND_SGE;
 	qp_attr.cap.max_recv_sge = SMBDIRECT_MAX_RECV_SGE;
 	qp_attr.cap.max_inline_data = 0;
@@ -1654,7 +1668,7 @@ static struct smbd_connection *_smbd_get
 	init_waitqueue_head(&info->wait_send_queue);
 	INIT_DELAYED_WORK(&info->idle_timer_work, idle_connection_timer);
 	queue_delayed_work(info->workqueue, &info->idle_timer_work,
-		info->keep_alive_interval*HZ);
+		msecs_to_jiffies(sp->keepalive_interval_msec));
 
 	init_waitqueue_head(&info->wait_send_pending);
 	atomic_set(&info->send_pending, 0);
@@ -1971,6 +1985,7 @@ int smbd_send(struct TCP_Server_Info *se
 {
 	struct smbd_connection *info = server->smbd_conn;
 	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smb_rqst *rqst;
 	struct iov_iter iter;
 	unsigned int remaining_data_length, klen;
@@ -1988,10 +2003,10 @@ int smbd_send(struct TCP_Server_Info *se
 	for (i = 0; i < num_rqst; i++)
 		remaining_data_length += smb_rqst_len(server, &rqst_array[i]);
 
-	if (unlikely(remaining_data_length > info->max_fragmented_send_size)) {
+	if (unlikely(remaining_data_length > sp->max_fragmented_send_size)) {
 		/* assertion: payload never exceeds negotiated maximum */
 		log_write(ERR, "payload size %d > max size %d\n",
-			remaining_data_length, info->max_fragmented_send_size);
+			remaining_data_length, sp->max_fragmented_send_size);
 		return -EINVAL;
 	}
 
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -69,15 +69,7 @@ struct smbd_connection {
 	spinlock_t lock_new_credits_offered;
 	int new_credits_offered;
 
-	/* Connection parameters defined in [MS-SMBD] 3.1.1.1 */
-	int receive_credit_max;
-	int send_credit_target;
-	int max_send_size;
-	int max_fragmented_recv_size;
-	int max_fragmented_send_size;
-	int max_receive_size;
-	int keep_alive_interval;
-	int max_readwrite_size;
+	/* dynamic connection parameters defined in [MS-SMBD] 3.1.1.1 */
 	enum keep_alive_status keep_alive_requested;
 	int protocol;
 	atomic_t send_credits;



