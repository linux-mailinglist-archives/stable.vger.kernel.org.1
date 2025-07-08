Return-Path: <stable+bounces-161033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26DFAFD316
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4363B188EFC9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6CC2E0911;
	Tue,  8 Jul 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KPvR8vkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691E1DB127;
	Tue,  8 Jul 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993405; cv=none; b=FGUNEKMTWGi1/E5a5Q/wjFOtXx8ceYcPvKjWLhislxWLDsFRbzKmMExp0DF+FO0Qd30imiT8VuGdNHWFMjM3FBivVqOpn6V6x2YxXMkixiAAqnK3t6oMn3Un/J1kTrgmIPERVcLBytl24/PgOqIzpicVUiadMdo7lHQImtPOLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993405; c=relaxed/simple;
	bh=wKlwLETcekS7MH/Zc2cmKt26RtJWUzXdK36LC2Jzp2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR44dE8Z4pHuRCqsJz3/pNNMigoU8bBUFsVe5bRf/F9hC/90LtaOdfSrRXWiCZF3xsx7j6W6+3oqhBNYiE07FJGJA3Pr5vztI1RzqJUHcmQCtfNaJM88Mh6lKrtPs4ZR4BiAxzGzib+3CQSAoTE3YpMJBLRLKUtNCfs+4/OCvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KPvR8vkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703C3C4CEED;
	Tue,  8 Jul 2025 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993404;
	bh=wKlwLETcekS7MH/Zc2cmKt26RtJWUzXdK36LC2Jzp2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPvR8vkZkt+7DYN98FJTdgINzRfqyTM3pM5QQTr1WDMd1jKOYHvDJgrZvU+B+CW4Q
	 Zf6AimRG0NLbuEg3THEcJsVFS63mBn/PoD98hLTSj02+0yjl94OgombQ23/buCwBdK
	 t1Zlsb7kay6Tg6TdOCdhnzupbvWzpQ7Hmy/t68Vk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 062/178] NFSv4/flexfiles: Fix handling of NFS level errors in I/O
Date: Tue,  8 Jul 2025 18:21:39 +0200
Message-ID: <20250708162238.298961055@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 38074de35b015df5623f524d6f2b49a0cd395c40 ]

Allow the flexfiles error handling to recognise NFS level errors (as
opposed to RPC level errors) and handle them separately. The main
motivator is the NFSERR_PERM errors that get returned if the NFS client
connects to the data server through a port number that is lower than
1024. In that case, the client should disconnect and retry a READ on a
different data server, or it should retry a WRITE after reconnecting.

Reviewed-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 118 ++++++++++++++++++-------
 1 file changed, 84 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index df48074605967..4bea008dbebd7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1105,6 +1105,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 }
 
 static int ff_layout_async_handle_error_v4(struct rpc_task *task,
+					   u32 op_status,
 					   struct nfs4_state *state,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
@@ -1115,34 +1116,42 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
-	switch (task->tk_status) {
-	case -NFS4ERR_BADSESSION:
-	case -NFS4ERR_BADSLOT:
-	case -NFS4ERR_BAD_HIGH_SLOT:
-	case -NFS4ERR_DEADSESSION:
-	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
-	case -NFS4ERR_SEQ_FALSE_RETRY:
-	case -NFS4ERR_SEQ_MISORDERED:
+	switch (op_status) {
+	case NFS4_OK:
+	case NFS4ERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFS4ERR_BADSESSION:
+	case NFS4ERR_BADSLOT:
+	case NFS4ERR_BAD_HIGH_SLOT:
+	case NFS4ERR_DEADSESSION:
+	case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+	case NFS4ERR_SEQ_FALSE_RETRY:
+	case NFS4ERR_SEQ_MISORDERED:
 		dprintk("%s ERROR %d, Reset session. Exchangeid "
 			"flags 0x%x\n", __func__, task->tk_status,
 			clp->cl_exchange_flags);
 		nfs4_schedule_session_recovery(clp->cl_session, task->tk_status);
-		break;
-	case -NFS4ERR_DELAY:
+		goto out_retry;
+	case NFS4ERR_DELAY:
 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
 		fallthrough;
-	case -NFS4ERR_GRACE:
+	case NFS4ERR_GRACE:
 		rpc_delay(task, FF_LAYOUT_POLL_RETRY_MAX);
-		break;
-	case -NFS4ERR_RETRY_UNCACHED_REP:
-		break;
+		goto out_retry;
+	case NFS4ERR_RETRY_UNCACHED_REP:
+		goto out_retry;
 	/* Invalidate Layout errors */
-	case -NFS4ERR_PNFS_NO_LAYOUT:
-	case -ESTALE:           /* mapped NFS4ERR_STALE */
-	case -EBADHANDLE:       /* mapped NFS4ERR_BADHANDLE */
-	case -EISDIR:           /* mapped NFS4ERR_ISDIR */
-	case -NFS4ERR_FHEXPIRED:
-	case -NFS4ERR_WRONG_TYPE:
+	case NFS4ERR_PNFS_NO_LAYOUT:
+	case NFS4ERR_STALE:
+	case NFS4ERR_BADHANDLE:
+	case NFS4ERR_ISDIR:
+	case NFS4ERR_FHEXPIRED:
+	case NFS4ERR_WRONG_TYPE:
 		dprintk("%s Invalid layout error %d\n", __func__,
 			task->tk_status);
 		/*
@@ -1155,6 +1164,11 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		pnfs_destroy_layout(NFS_I(inode));
 		rpc_wake_up(&tbl->slot_tbl_waitq);
 		goto reset;
+	default:
+		break;
+	}
+
+	switch (task->tk_status) {
 	/* RPC connection errors */
 	case -ENETDOWN:
 	case -ENETUNREACH:
@@ -1174,27 +1188,56 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		fallthrough;
+		break;
 	default:
-		if (ff_layout_avoid_mds_available_ds(lseg))
-			return -NFS4ERR_RESET_TO_PNFS;
-reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
-			task->tk_status);
-		return -NFS4ERR_RESET_TO_MDS;
+		break;
 	}
+
+	if (ff_layout_avoid_mds_available_ds(lseg))
+		return -NFS4ERR_RESET_TO_PNFS;
+reset:
+	dprintk("%s Retry through MDS. Error %d\n", __func__,
+		task->tk_status);
+	return -NFS4ERR_RESET_TO_MDS;
+
+out_retry:
 	task->tk_status = 0;
 	return -EAGAIN;
 }
 
 /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
 static int ff_layout_async_handle_error_v3(struct rpc_task *task,
+					   u32 op_status,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
 					   u32 idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
+	switch (op_status) {
+	case NFS_OK:
+	case NFSERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFSERR_ACCES:
+	case NFSERR_BADHANDLE:
+	case NFSERR_FBIG:
+	case NFSERR_IO:
+	case NFSERR_NOSPC:
+	case NFSERR_ROFS:
+	case NFSERR_STALE:
+		goto out_reset_to_pnfs;
+	case NFSERR_JUKEBOX:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		goto out_retry;
+	default:
+		break;
+	}
+
 	switch (task->tk_status) {
 	/* File access problems. Don't mark the device as unavailable */
 	case -EACCES:
@@ -1218,6 +1261,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 	}
+out_reset_to_pnfs:
 	/* FIXME: Need to prevent infinite looping here. */
 	return -NFS4ERR_RESET_TO_PNFS;
 out_retry:
@@ -1228,6 +1272,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 }
 
 static int ff_layout_async_handle_error(struct rpc_task *task,
+					u32 op_status,
 					struct nfs4_state *state,
 					struct nfs_client *clp,
 					struct pnfs_layout_segment *lseg,
@@ -1246,10 +1291,11 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 	switch (vers) {
 	case 3:
-		return ff_layout_async_handle_error_v3(task, clp, lseg, idx);
-	case 4:
-		return ff_layout_async_handle_error_v4(task, state, clp,
+		return ff_layout_async_handle_error_v3(task, op_status, clp,
 						       lseg, idx);
+	case 4:
+		return ff_layout_async_handle_error_v4(task, op_status, state,
+						       clp, lseg, idx);
 	default:
 		/* should never happen */
 		WARN_ON_ONCE(1);
@@ -1302,6 +1348,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
+	case NFS4ERR_PERM:
 		break;
 	case NFS4ERR_NXIO:
 		ff_layout_mark_ds_unreachable(lseg, idx);
@@ -1334,7 +1381,8 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 		trace_ff_layout_read_error(hdr, task->tk_status);
 	}
 
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1507,7 +1555,8 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 		trace_ff_layout_write_error(hdr, task->tk_status);
 	}
 
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1556,8 +1605,9 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 		trace_ff_layout_commit_error(data, task->tk_status);
 	}
 
-	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
-					   data->lseg, data->ds_commit_index);
+	err = ff_layout_async_handle_error(task, data->res.op_status,
+					   NULL, data->ds_clp, data->lseg,
+					   data->ds_commit_index);
 
 	trace_nfs4_pnfs_commit_ds(data, err);
 	switch (err) {
-- 
2.39.5




