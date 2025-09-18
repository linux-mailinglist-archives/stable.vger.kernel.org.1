Return-Path: <stable+bounces-168745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73547B23688
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C869F7B1A80
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76242C21E3;
	Tue, 12 Aug 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W47rt5qM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F102FA0DB;
	Tue, 12 Aug 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025196; cv=none; b=plYP1C5AhFxL4sNaGhL/yotzYGefM4tq5F9+9jsXTMKZnzlCCGpfdB7r/tVTt413qN4YtrpVvg38AY2oOa+EXvZBc3SbPtCTh2Ghq8SL9Pwg2BquG4ENZ4rQYGa55Q7paasKiwaRBxF18g8r5wegig3u83yW0RuqDBYGxHQtbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025196; c=relaxed/simple;
	bh=Le93czWbIHytp509ZcADNRVhEfL86hMW0eeYJRCsVyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAq6taS84atDBDLxg3k6rJCZwq+gjJRm3UkueiikNURQT78LHruWgAn4zXcmhdZ5OIJSM6p+GnX5VMi2caoYcjbRhrhnSeWc/aa/YBtZS2td9MR/CZB5KZsFN4idX+Xe59HmpGmfe1UsJD0TXsEbt9SQecaJcMdCPSEDAEmnlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W47rt5qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1707C4CEF0;
	Tue, 12 Aug 2025 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025196;
	bh=Le93czWbIHytp509ZcADNRVhEfL86hMW0eeYJRCsVyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W47rt5qM4NcZ2L/FTA6bOhDsLLLvY3KrodbN77KOrqdkvwOxubrSsXFzq3N+udyPW
	 u1vgWl+QfM1YpF4nwDbB68eyOV+xKnV8NZrc47BSTjsQ+7xjpE+hBkOapasO2fJFfp
	 vhfOy1ydXOFRuL3RbPAYjHdbf7wK9wV3daDO8jzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 564/627] smb: client: remove separate empty_packet_queue
Date: Tue, 12 Aug 2025 19:34:19 +0200
Message-ID: <20250812173453.344371487@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit 24b6afc36db748467e853e166a385df07e443859 ]

There's no need to maintain two lists, we can just
have a single list of receive buffers, which are free to use.

It just added unneeded complexity and resulted in
ib_dma_unmap_single() not being called from recv_done()
for empty keepalive packets.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_debug.c |  6 ++--
 fs/smb/client/smbdirect.c  | 62 +++-----------------------------------
 fs/smb/client/smbdirect.h  |  4 ---
 3 files changed, 7 insertions(+), 65 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 3fdf75737d43..d1acde844326 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -432,10 +432,8 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 			server->smbd_conn->receive_credit_target);
 		seq_printf(m, "\nPending send_pending: %x ",
 			atomic_read(&server->smbd_conn->send_pending));
-		seq_printf(m, "\nReceive buffers count_receive_queue: %x "
-			"count_empty_packet_queue: %x",
-			server->smbd_conn->count_receive_queue,
-			server->smbd_conn->count_empty_packet_queue);
+		seq_printf(m, "\nReceive buffers count_receive_queue: %x ",
+			server->smbd_conn->count_receive_queue);
 		seq_printf(m, "\nMR responder_resources: %x "
 			"max_frmr_depth: %x mr_type: %x",
 			server->smbd_conn->responder_resources,
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index e99e783f1b0e..0ab490c0a9b0 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -13,8 +13,6 @@
 #include "cifsproto.h"
 #include "smb2proto.h"
 
-static struct smbd_response *get_empty_queue_buffer(
-		struct smbd_connection *info);
 static struct smbd_response *get_receive_buffer(
 		struct smbd_connection *info);
 static void put_receive_buffer(
@@ -23,8 +21,6 @@ static void put_receive_buffer(
 static int allocate_receive_buffers(struct smbd_connection *info, int num_buf);
 static void destroy_receive_buffers(struct smbd_connection *info);
 
-static void put_empty_packet(
-		struct smbd_connection *info, struct smbd_response *response);
 static void enqueue_reassembly(
 		struct smbd_connection *info,
 		struct smbd_response *response, int data_length);
@@ -393,7 +389,6 @@ static bool process_negotiation_response(
 static void smbd_post_send_credits(struct work_struct *work)
 {
 	int ret = 0;
-	int use_receive_queue = 1;
 	int rc;
 	struct smbd_response *response;
 	struct smbd_connection *info =
@@ -409,18 +404,9 @@ static void smbd_post_send_credits(struct work_struct *work)
 	if (info->receive_credit_target >
 		atomic_read(&info->receive_credits)) {
 		while (true) {
-			if (use_receive_queue)
-				response = get_receive_buffer(info);
-			else
-				response = get_empty_queue_buffer(info);
-			if (!response) {
-				/* now switch to empty packet queue */
-				if (use_receive_queue) {
-					use_receive_queue = 0;
-					continue;
-				} else
-					break;
-			}
+			response = get_receive_buffer(info);
+			if (!response)
+				break;
 
 			response->type = SMBD_TRANSFER_DATA;
 			response->first_segment = false;
@@ -511,7 +497,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 				response,
 				data_length);
 		} else
-			put_empty_packet(info, response);
+			put_receive_buffer(info, response);
 
 		if (data_length)
 			wake_up_interruptible(&info->wait_reassembly_queue);
@@ -1115,17 +1101,6 @@ static int smbd_negotiate(struct smbd_connection *info)
 	return rc;
 }
 
-static void put_empty_packet(
-		struct smbd_connection *info, struct smbd_response *response)
-{
-	spin_lock(&info->empty_packet_queue_lock);
-	list_add_tail(&response->list, &info->empty_packet_queue);
-	info->count_empty_packet_queue++;
-	spin_unlock(&info->empty_packet_queue_lock);
-
-	queue_work(info->workqueue, &info->post_send_credits_work);
-}
-
 /*
  * Implement Connection.FragmentReassemblyBuffer defined in [MS-SMBD] 3.1.1.1
  * This is a queue for reassembling upper layer payload and present to upper
@@ -1174,25 +1149,6 @@ static struct smbd_response *_get_first_reassembly(struct smbd_connection *info)
 	return ret;
 }
 
-static struct smbd_response *get_empty_queue_buffer(
-		struct smbd_connection *info)
-{
-	struct smbd_response *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->empty_packet_queue_lock, flags);
-	if (!list_empty(&info->empty_packet_queue)) {
-		ret = list_first_entry(
-			&info->empty_packet_queue,
-			struct smbd_response, list);
-		list_del(&ret->list);
-		info->count_empty_packet_queue--;
-	}
-	spin_unlock_irqrestore(&info->empty_packet_queue_lock, flags);
-
-	return ret;
-}
-
 /*
  * Get a receive buffer
  * For each remote send, we need to post a receive. The receive buffers are
@@ -1257,10 +1213,6 @@ static int allocate_receive_buffers(struct smbd_connection *info, int num_buf)
 	spin_lock_init(&info->receive_queue_lock);
 	info->count_receive_queue = 0;
 
-	INIT_LIST_HEAD(&info->empty_packet_queue);
-	spin_lock_init(&info->empty_packet_queue_lock);
-	info->count_empty_packet_queue = 0;
-
 	init_waitqueue_head(&info->wait_receive_queues);
 
 	for (i = 0; i < num_buf; i++) {
@@ -1294,9 +1246,6 @@ static void destroy_receive_buffers(struct smbd_connection *info)
 
 	while ((response = get_receive_buffer(info)))
 		mempool_free(response, info->response_mempool);
-
-	while ((response = get_empty_queue_buffer(info)))
-		mempool_free(response, info->response_mempool);
 }
 
 /* Implement idle connection timer [MS-SMBD] 3.1.6.2 */
@@ -1383,8 +1332,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
 
 	log_rdma_event(INFO, "free receive buffers\n");
 	wait_event(info->wait_receive_queues,
-		info->count_receive_queue + info->count_empty_packet_queue
-			== sp->recv_credit_max);
+		info->count_receive_queue == sp->recv_credit_max);
 	destroy_receive_buffers(info);
 
 	/*
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 75b3f491c3ad..ea04ce8a9763 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -110,10 +110,6 @@ struct smbd_connection {
 	int count_receive_queue;
 	spinlock_t receive_queue_lock;
 
-	struct list_head empty_packet_queue;
-	int count_empty_packet_queue;
-	spinlock_t empty_packet_queue_lock;
-
 	wait_queue_head_t wait_receive_queues;
 
 	/* Reassembly queue */
-- 
2.39.5




