Return-Path: <stable+bounces-37010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0189C355
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B601B2D5D4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002F71B3D;
	Mon,  8 Apr 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6jATZYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5516F53D;
	Mon,  8 Apr 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582991; cv=none; b=AHDhIGS88dc6WFOvAIYSD3U8kciYBJ09dkV6Wx9MW6Rr+aThSHcdYnFkjm7GXrG+d7NxfWY2wqrhhxg3Y6Ds3N4UaVq+6dJ5YQMt9qXZhFKOD4kuhQ0TsDg1cW1vGKEgj89E4Y8WTPCsticRouZbwin+YT4AvqsCe32INcx3svs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582991; c=relaxed/simple;
	bh=i6Eo2ORGPegMabQrBuMKdXJVXsIMg+26e/kHmLas5iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni5yq/OciH1lWzt00GpU2XZT6V6fn5bB2nbZ7DuBQ5WpJIiZDkIR3EvO1vQnScvYBubsXnWj6h0/FQSQigMsqnvytNNlDYj2HAM1poPZIS+1D2BcBwBBCKx2Og+zmE2hw5l4xX0Idh6MdD+vZYFctSNWR/izEv4smdPX9PpnUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6jATZYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88531C433C7;
	Mon,  8 Apr 2024 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582990;
	bh=i6Eo2ORGPegMabQrBuMKdXJVXsIMg+26e/kHmLas5iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6jATZYYiQeTm16CDq0fWf13iPKLLLC3xIo5siifkW9OIZm1Vzx9njDL/1Ca8ye7o
	 SU6ZLqM8fTgAdNe+fxTD+piweD9YFWyUdRowCwHb8sHuw2Xltb63fUDfOocf1v6/kG
	 deWESgBBKpr4VvIbxKJJKqxK/vckIuH7sMig1YrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 196/690] SUNRPC: Tracepoints should display tk_pid and cl_clid as a fixed-size field
Date: Mon,  8 Apr 2024 14:51:02 +0200
Message-ID: <20240408125406.661229120@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit b4776a341ec05e809d21e98db5ed49dbdc81d5d8 ]

For certain special cases, RPC-related tracepoints record a -1 as
the task ID or the client ID. It's ugly for a trace event to display
4 billion in these cases.

To help keep SUNRPC tracepoints consistent, create a macro that
defines the print format specifiers for tk_pid and cl_clid. At some
point in the future we might try tk_pid with a wider range of values
than 0..64K so this makes it easier to make that change.

RPC tracepoints now look like this:

<...>-1276  [009]   149.720358: rpc_clnt_new:         client=00000005 peer=[192.168.2.55]:20049 program=nfs server=klimt.ib

<...>-1342  [004]   149.921234: rpc_xdr_recvfrom:     task:0000001a@00000005 head=[0xff1242d9ab6dc01c,144] page=0 tail=[(nil),0] len=144
<...>-1342  [004]   149.921235: xprt_release_cong:    task:0000001a@00000005 snd_task:ffffffff cong=256 cwnd=16384
<...>-1342  [004]   149.921235: xprt_put_cong:        task:0000001a@00000005 snd_task:ffffffff cong=0 cwnd=16384

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h                 |  9 ++--
 fs/nfs/nfstrace.h                  |  6 ++-
 include/trace/events/rpcgss.h      | 18 +++++---
 include/trace/events/rpcrdma.h     | 42 +++++++++--------
 include/trace/events/sunrpc.h      | 74 ++++++++++++++++++------------
 include/trace/events/sunrpc_base.h | 18 ++++++++
 6 files changed, 108 insertions(+), 59 deletions(-)
 create mode 100644 include/trace/events/sunrpc_base.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index bcd18e96b44fa..39a45bb7d4311 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -9,6 +9,7 @@
 #define _TRACE_NFS4_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/sunrpc_base.h>
 
 TRACE_DEFINE_ENUM(EPERM);
 TRACE_DEFINE_ENUM(ENOENT);
@@ -696,8 +697,8 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
 			__entry->expected = expected;
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x operation=%u, expected=%u",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x operation=%u, expected=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__entry->op, __entry->expected
 		)
@@ -731,8 +732,8 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 			__entry->error = error;
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x error=%ld (%s) operation=%u",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x error=%ld (%s) operation=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			-__entry->error, show_nfsv4_errors(__entry->error),
 			__entry->op
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 589f32fdbe637..69fa637a4aba8 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,6 +11,8 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+#include <trace/events/sunrpc_base.h>
+
 #define nfs_show_file_type(ftype) \
 	__print_symbolic(ftype, \
 			{ DT_UNKNOWN, "UNKNOWN" }, \
@@ -1359,8 +1361,8 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x %sv%d %s error=%ld (%s)",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x %sv%d %s error=%ld (%s)",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__get_str(program), __entry->version,
 			__get_str(procedure), -__entry->error,
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b2a2672e66322..3ba63319af3cd 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -13,6 +13,8 @@
 
 #include <linux/tracepoint.h>
 
+#include <trace/events/sunrpc_base.h>
+
 /**
  ** GSS-API related trace events
  **/
@@ -99,7 +101,7 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
 		__entry->maj_stat = maj_stat;
 	),
 
-	TP_printk("task:%u@%u maj_stat=%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " maj_stat=%s",
 		__entry->task_id, __entry->client_id,
 		__entry->maj_stat == 0 ?
 		"GSS_S_COMPLETE" : show_gss_status(__entry->maj_stat))
@@ -332,7 +334,8 @@ TRACE_EVENT(rpcgss_unwrap_failed,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u", __entry->task_id, __entry->client_id)
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
+		__entry->task_id, __entry->client_id)
 );
 
 TRACE_EVENT(rpcgss_bad_seqno,
@@ -358,7 +361,8 @@ TRACE_EVENT(rpcgss_bad_seqno,
 		__entry->received = received;
 	),
 
-	TP_printk("task:%u@%u expected seqno %u, received seqno %u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " expected seqno %u, received seqno %u",
 		__entry->task_id, __entry->client_id,
 		__entry->expected, __entry->received)
 );
@@ -386,7 +390,7 @@ TRACE_EVENT(rpcgss_seqno,
 		__entry->seqno = rqst->rq_seqno;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x seqno=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x seqno=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno)
 );
@@ -418,7 +422,8 @@ TRACE_EVENT(rpcgss_need_reencode,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno, __entry->seq_xmit,
 		__entry->ret ? "" : "un")
@@ -452,7 +457,8 @@ TRACE_EVENT(rpcgss_update_slack,
 		__entry->verfsize = auth->au_verfsize;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->auth, __entry->rslack, __entry->ralign,
 		__entry->verfsize)
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index de41954995926..28ea73bba4e78 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -14,7 +14,9 @@
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/tracepoint.h>
 #include <rdma/ib_cm.h>
+
 #include <trace/events/rdma.h>
+#include <trace/events/sunrpc_base.h>
 
 /**
  ** Event classes
@@ -279,7 +281,8 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u pos=%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " pos=%u %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->pos, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -326,7 +329,8 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->length, (unsigned long long)__entry->offset,
 		__entry->handle,
@@ -387,7 +391,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("task:%u@%u mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->mr_id, __entry->nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -630,9 +635,9 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s task:%u@%u",
-		__get_str(addr), __get_str(port),
-		__entry->task_id, __entry->client_id
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " peer=[%s]:%s",
+		__entry->task_id, __entry->client_id,
+		__get_str(addr), __get_str(port)
 	)
 );
 
@@ -693,7 +698,8 @@ TRACE_EVENT(xprtrdma_marshal,
 		__entry->wtype = wtype;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: hdr=%u xdr=%u/%u/%u %s/%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x hdr=%u xdr=%u/%u/%u %s/%s",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->hdrlen,
 		__entry->headlen, __entry->pagelen, __entry->taillen,
@@ -723,7 +729,7 @@ TRACE_EVENT(xprtrdma_marshal_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -750,7 +756,7 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -785,7 +791,7 @@ TRACE_EVENT(xprtrdma_post_send,
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
 
-	TP_printk("task:%u@%u cq.id=%u cid=%d (%d SGE%s) %s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " cq.id=%u cid=%d (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
 		__entry->cq_id, __entry->completion_id,
 		__entry->num_sge, (__entry->num_sge == 1 ? "" : "s"),
@@ -820,7 +826,7 @@ TRACE_EVENT(xprtrdma_post_send_err,
 		__entry->rc = rc;
 	),
 
-	TP_printk("task:%u@%u cq.id=%u rc=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " cq.id=%u rc=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->cq_id, __entry->rc
 	)
@@ -932,7 +938,7 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d",
 		__entry->task_id, __entry->client_id, __entry->status
 	)
 );
@@ -1120,7 +1126,7 @@ TRACE_EVENT(xprtrdma_reply,
 		__entry->credits = credits;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x credits=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x credits=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->credits
 	)
@@ -1156,7 +1162,7 @@ TRACE_EVENT(xprtrdma_err_vers,
 		__entry->max = be32_to_cpup(max);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x versions=[%u, %u]",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x versions=[%u, %u]",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->min, __entry->max
 	)
@@ -1181,7 +1187,7 @@ TRACE_EVENT(xprtrdma_err_chunk,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1207,7 +1213,7 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
 		__entry->procedure = be32_to_cpup(procedure);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x procedure=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x procedure=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->procedure
 	)
@@ -1239,7 +1245,7 @@ TRACE_EVENT(xprtrdma_fixup,
 		__entry->taillen = rqst->rq_rcv_buf.tail[0].iov_len;
 	),
 
-	TP_printk("task:%u@%u fixup=%lu xdr=%zu/%u/%zu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " fixup=%lu xdr=%zu/%u/%zu",
 		__entry->task_id, __entry->client_id, __entry->fixup,
 		__entry->headlen, __entry->pagelen, __entry->taillen
 	)
@@ -1289,7 +1295,7 @@ TRACE_EVENT(xprtrdma_mrs_zap,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
 		__entry->task_id, __entry->client_id
 	)
 );
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f09bbb6c918e2..68ae89c9a1c20 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,6 +14,8 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
+#include <trace/events/sunrpc_base.h>
+
 TRACE_DEFINE_ENUM(SOCK_STREAM);
 TRACE_DEFINE_ENUM(SOCK_DGRAM);
 TRACE_DEFINE_ENUM(SOCK_RAW);
@@ -78,7 +80,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
@@ -114,7 +117,7 @@ DECLARE_EVENT_CLASS(rpc_clnt_class,
 		__entry->client_id = clnt->cl_clid;
 	),
 
-	TP_printk("clid=%u", __entry->client_id)
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER, __entry->client_id)
 );
 
 #define DEFINE_RPC_CLNT_EVENT(name)					\
@@ -158,7 +161,8 @@ TRACE_EVENT(rpc_clnt_new,
 		__assign_str(server, server);
 	),
 
-	TP_printk("client=%u peer=[%s]:%s program=%s server=%s",
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER
+		  " peer=[%s]:%s program=%s server=%s",
 		__entry->client_id, __get_str(addr), __get_str(port),
 		__get_str(program), __get_str(server))
 );
@@ -206,7 +210,8 @@ TRACE_EVENT(rpc_clnt_clone_err,
 		__entry->error = error;
 	),
 
-	TP_printk("client=%u error=%d", __entry->client_id, __entry->error)
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER " error=%d",
+		__entry->client_id, __entry->error)
 );
 
 
@@ -248,7 +253,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 		__entry->status = task->tk_status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->status)
 );
@@ -288,7 +293,7 @@ TRACE_EVENT(rpc_request,
 		__assign_str(procname, rpc_proc_name(task));
 	),
 
-	TP_printk("task:%u@%u %sv%d %s (%ssync)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " %sv%d %s (%ssync)",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version,
 		__get_str(procname), __entry->async ? "a": ""
@@ -348,7 +353,8 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 		__entry->flags = task->tk_flags;
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d action=%ps",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " flags=%s runstate=%s status=%d action=%ps",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -400,7 +406,8 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 		__assign_str(q_name, rpc_qname(q));
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d timeout=%lu queue=%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " flags=%s runstate=%s status=%d timeout=%lu queue=%s",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -436,7 +443,7 @@ DECLARE_EVENT_CLASS(rpc_failure,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
 		__entry->task_id, __entry->client_id)
 );
 
@@ -478,7 +485,8 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%d server=%s xid=0x%08x %sv%d %s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " server=%s xid=0x%08x %sv%d %s",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->xid, __get_str(progname), __entry->version,
 		__get_str(procname))
@@ -538,7 +546,8 @@ TRACE_EVENT(rpc_buf_alloc,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u callsize=%zu recvsize=%zu status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " callsize=%zu recvsize=%zu status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->callsize, __entry->recvsize, __entry->status
 	)
@@ -567,7 +576,8 @@ TRACE_EVENT(rpc_call_rpcerror,
 		__entry->rpc_status = rpc_status;
 	),
 
-	TP_printk("task:%u@%u tk_status=%d rpc_status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " tk_status=%d rpc_status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->tk_status, __entry->rpc_status)
 );
@@ -607,7 +617,8 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->execute = ktime_to_us(execute);
 	),
 
-	TP_printk("task:%u@%d xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->backlog, __entry->rtt, __entry->execute)
@@ -651,8 +662,8 @@ TRACE_EVENT(rpc_xdr_overflow,
 			__entry->version = task->tk_client->cl_vers;
 			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 		} else {
-			__entry->task_id = 0;
-			__entry->client_id = 0;
+			__entry->task_id = -1;
+			__entry->client_id = -1;
 			__assign_str(progname, "unknown");
 			__entry->version = 0;
 			__assign_str(procedure, "unknown");
@@ -668,8 +679,8 @@ TRACE_EVENT(rpc_xdr_overflow,
 		__entry->len = xdr->buf->len;
 	),
 
-	TP_printk(
-		"task:%u@%u %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->requested, __entry->p, __entry->end,
@@ -727,8 +738,8 @@ TRACE_EVENT(rpc_xdr_alignment,
 		__entry->len = xdr->buf->len;
 	),
 
-	TP_printk(
-		"task:%u@%u %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->offset, __entry->copied,
@@ -917,7 +928,8 @@ TRACE_EVENT(rpc_socket_nospace,
 		__entry->remaining = rqst->rq_slen - transport->xmit.offset;
 	),
 
-	TP_printk("task:%u@%u total=%u remaining=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " total=%u remaining=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->total, __entry->remaining
 	)
@@ -1042,8 +1054,8 @@ TRACE_EVENT(xprt_transmit,
 		__entry->status = status;
 	),
 
-	TP_printk(
-		"task:%u@%u xid=0x%08x seqno=%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x seqno=%u status=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->seqno, __entry->status)
 );
@@ -1082,8 +1094,8 @@ TRACE_EVENT(xprt_retransmit,
 		__assign_str(procname, rpc_proc_name(task));
 	),
 
-	TP_printk(
-		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->ntrans, __entry->timeout
@@ -1140,7 +1152,8 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 			__entry->snd_task_id = -1;
 	),
 
-	TP_printk("task:%u@%u snd_task:%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " snd_task:" SUNRPC_TRACE_PID_SPECIFIER,
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id)
 );
@@ -1192,7 +1205,9 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 	),
 
-	TP_printk("task:%u@%u snd_task:%u cong=%lu cwnd=%lu%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " snd_task:" SUNRPC_TRACE_PID_SPECIFIER
+		  " cong=%lu cwnd=%lu%s",
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id, __entry->cong, __entry->cwnd,
 			__entry->wait ? " (wait)" : "")
@@ -1230,7 +1245,7 @@ TRACE_EVENT(xprt_reserve,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1319,7 +1334,8 @@ TRACE_EVENT(rpcb_getport,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%u server=%s program=%u version=%u protocol=%d bind_version=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " server=%s program=%u version=%u protocol=%d bind_version=%u",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->program, __entry->version, __entry->protocol,
 		__entry->bind_version
@@ -1349,7 +1365,7 @@ TRACE_EVENT(rpcb_setport,
 		__entry->port = port;
 	),
 
-	TP_printk("task:%u@%u status=%d port=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d port=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->status, __entry->port
 	)
diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/sunrpc_base.h
new file mode 100644
index 0000000000000..588557d07ea82
--- /dev/null
+++ b/include/trace/events/sunrpc_base.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Oracle and/or its affiliates.
+ *
+ * Common types and format specifiers for sunrpc.
+ */
+
+#if !defined(_TRACE_SUNRPC_BASE_H)
+#define _TRACE_SUNRPC_BASE_H
+
+#include <linux/tracepoint.h>
+
+#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_TASK_SPECIFIER \
+	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
+
+#endif /* _TRACE_SUNRPC_BASE_H */
-- 
2.43.0




