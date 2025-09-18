Return-Path: <stable+bounces-169498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E888B25A9A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 06:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3167F3A1298
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E321CA10;
	Thu, 14 Aug 2025 04:51:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438B4315F
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147112; cv=none; b=ZahkxbVLp6v5MPVMuNwahX2HMQiNHdNgR51uInbyl+hvFsP/bHHCoyD/k0uU9Wsauq0p2+A0rz0ZzHqvpJvqUaJl8hpUoSjDKFFdeTZMxnqBd8P6pQ3zBPtEGHwMB+lHi5l8ADKBdSYBUc8PV552zxT2W2qghoj54b33XI2T8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147112; c=relaxed/simple;
	bh=y43RuC84WlEmck6Cx8s6Lt3xDcUdMzWJcAG5xfw7g9Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tvUiUK+NnG0EFtGkng7+0O1XqzXWu7twsphITij5hNSSNPG8BEwjZihCjuSTV7ya291sTSig2TfeoRl/ZeVrgnvQOVWw4sDS90TWSWXBHInsl3NsnLK3r4MS2ewoJFiG92wF/Wtj9h/tEvKsVW5SQNBpYt8x5oIc9vyCIcDf7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 14 Aug 2025 13:51:40 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.126 with ESMTP; 14 Aug 2025 13:51:40 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	He Zhe <zhe.he@windriver.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Chanho Min <chanho.min@lge.com>
Subject: [PATCH] cifs: Fix UAF in cifs_demultiplex_thread()
Date: Thu, 14 Aug 2025 13:51:25 +0900
Message-Id: <20250814045125.14518-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

commit d527f51331cace562393a8038d870b3e9916686f upstream.

There is a UAF when xfstests on cifs:

  BUG: KASAN: use-after-free in smb2_is_network_name_deleted+0x27/0x160
  Read of size 4 at addr ffff88810103fc08 by task cifsd/923

  CPU: 1 PID: 923 Comm: cifsd Not tainted 6.1.0-rc4+ #45
  ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report+0xad/0x130
   kasan_check_range+0x145/0x1a0
   smb2_is_network_name_deleted+0x27/0x160
   cifs_demultiplex_thread.cold+0x172/0x5a4
   kthread+0x165/0x1a0
   ret_from_fork+0x1f/0x30
   </TASK>

  Allocated by task 923:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_slab_alloc+0x54/0x60
   kmem_cache_alloc+0x147/0x320
   mempool_alloc+0xe1/0x260
   cifs_small_buf_get+0x24/0x60
   allocate_buffers+0xa1/0x1c0
   cifs_demultiplex_thread+0x199/0x10d0
   kthread+0x165/0x1a0
   ret_from_fork+0x1f/0x30

  Freed by task 921:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x40
   ____kasan_slab_free+0x143/0x1b0
   kmem_cache_free+0xe3/0x4d0
   cifs_small_buf_release+0x29/0x90
   SMB2_negotiate+0x8b7/0x1c60
   smb2_negotiate+0x51/0x70
   cifs_negotiate_protocol+0xf0/0x160
   cifs_get_smb_ses+0x5fa/0x13c0
   mount_get_conns+0x7a/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

The UAF is because:

 mount(pid: 921)               | cifsd(pid: 923)
-------------------------------|-------------------------------
                               | cifs_demultiplex_thread
SMB2_negotiate                 |
 cifs_send_recv                |
  compound_send_recv           |
   smb_send_rqst               |
    wait_for_response          |
     wait_event_state      [1] |
                               |  standard_receive3
                               |   cifs_handle_standard
                               |    handle_mid
                               |     mid->resp_buf = buf;  [2]
                               |     dequeue_mid           [3]
     KILL the process      [4] |
    resp_iov[i].iov_base = buf |
 free_rsp_buf              [5] |
                               |   is_network_name_deleted [6]
                               |   callback

1. After send request to server, wait the response until
    mid->mid_state != SUBMITTED;
2. Receive response from server, and set it to mid;
3. Set the mid state to RECEIVED;
4. Kill the process, the mid state already RECEIVED, get 0;
5. Handle and release the negotiate response;
6. UAF.

It can be easily reproduce with add some delay in [3] - [6].

Only sync call has the problem since async call's callback is
executed in cifsd process.

Add an extra state to mark the mid state to READY before wakeup the
waitter, then it can get the resp safely.

Cc: stable@vger.kernel.org # 5.4
Fixes: ec637e3ffb6b ("[CIFS] Avoid extra large buffer allocation (and memcpy) in cifs_readpages")
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[fs/cifs was moved to fs/smb/client since
38c8a9a52082 ("smb: move client and server files to common directory fs/smb").
We apply the patch to fs/cifs with some minor context changes.]
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
[ chanho: Backported to v5.4.y ]
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsglob.h  |  1 +
 fs/cifs/transport.c | 34 +++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 5f545a240afa6..19107b77f8c00 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1722,6 +1722,7 @@ static inline bool is_retryable_error(int error)
 #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
 #define   MID_RESPONSE_MALFORMED 0x10
 #define   MID_SHUTDOWN		 0x20
+#define   MID_RESPONSE_READY 0x40 /* ready for other process handle the rsp */
 
 /* Flags */
 #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index fc237b920f231..d0bc90746fa64 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -47,6 +47,8 @@
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 	wake_up_process(mid->callback_data);
 }
 
@@ -99,7 +101,8 @@ void _cifs_mid_q_entry_release(struct kref *refcount)
 	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
 		server->ops->handle_cancelled_mid(midEntry->resp_buf, server);
 
@@ -730,7 +733,8 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	int error;
 
 	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
+				    midQ->mid_state != MID_RESPONSE_RECEIVED);
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -882,7 +886,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 
 	spin_lock(&GlobalMid_Lock);
 	switch (mid->mid_state) {
-	case MID_RESPONSE_RECEIVED:
+	case MID_RESPONSE_READY:
 		spin_unlock(&GlobalMid_Lock);
 		return rc;
 	case MID_RETRY_NEEDED:
@@ -980,6 +984,9 @@ cifs_compound_callback(struct mid_q_entry *mid)
 	credits.instance = server->reconnect_instance;
 
 	add_credits(server, &credits, mid->optype);
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 }
 
 static void
@@ -1143,7 +1150,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
@@ -1164,7 +1172,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_RECEIVED) {
+		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
@@ -1341,7 +1349,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
 		spin_lock(&GlobalMid_Lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = DeleteMidQEntry;
 			spin_unlock(&GlobalMid_Lock);
@@ -1358,7 +1367,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	    midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
@@ -1478,13 +1487,15 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 
@@ -1514,7 +1525,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
 			spin_lock(&GlobalMid_Lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = DeleteMidQEntry;
 				spin_unlock(&GlobalMid_Lock);
@@ -1532,7 +1544,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;

