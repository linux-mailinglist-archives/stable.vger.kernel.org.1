Return-Path: <stable+bounces-52963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925390CF7B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF131C230F6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B213AD07;
	Tue, 18 Jun 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WfCYN+NY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97013AA47;
	Tue, 18 Jun 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714926; cv=none; b=Kjq6VXmvrYF9ybe1O8L3nCFJvI95estvfkbh4N82xYs6g4HeCJeox4Dv5/VEaCyJLxMJjuLgXdMUy0JZNikSk9H+N/E93X/e/Y0CUr7j1toifzj6TS6Sbx0ezUxrtDCuDKM469XWKeE9tLK/Z7Dwy13t78fisjOGGIteEr4qHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714926; c=relaxed/simple;
	bh=4MEC/viT+axgbkHAI9CRd+CaKuRBKec7QyrWqKOwJng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOiCQJ82WMnZ65iVqxHhl+FWReZZN4Rqeo2pvNGkScuLH8qksAJFIZK/qmFbzZL9apuDPG2rj+Thx4lV6cMzXidREPFUXKaLdh+TfQBosFcRsmwC8zIzh3lEriotNvmi8+BjB4+ob6oHGxrLEDe6bPMZ0HTp88wNU7VgpicidOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WfCYN+NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FB1C3277B;
	Tue, 18 Jun 2024 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714926;
	bh=4MEC/viT+axgbkHAI9CRd+CaKuRBKec7QyrWqKOwJng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfCYN+NYPX9YcBpwpT4qShoc4VPvTNg7HXlnhZIJBJSjtKyoTsUjLrI8fWDtjwO83
	 rPek+MGb3KfYzm+7Nv5KouDzfZ3tZDlYl0IpUNqtOiYeW1Kgx9n+ilNTjmTfQ8gpCZ
	 XU3Y2sporkjWnw+pHTXhdrFSjwnOQsF810wgMHgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 134/770] SUNRPC: Display RPC procedure names instead of proc numbers
Date: Tue, 18 Jun 2024 14:29:47 +0200
Message-ID: <20240618123412.448677989@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 89ff87494c6e4b32ea7960d0c644efdbb2fe6ef5 ]

Make the sunrpc trace subsystem trace events easier to use.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/sunrpc.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 8220369ee6105..200978b94a0b9 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1578,6 +1578,7 @@ TRACE_EVENT(svc_process,
 		__field(u32, vers)
 		__field(u32, proc)
 		__string(service, name)
+		__string(procedure, rqst->rq_procinfo->pc_name)
 		__string(addr, rqst->rq_xprt ?
 			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
@@ -1587,13 +1588,16 @@ TRACE_EVENT(svc_process,
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
 		__assign_str(service, name);
+		__assign_str(procedure, rqst->rq_procinfo->pc_name);
 		__assign_str(addr, rqst->rq_xprt ?
 			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
 
-	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%u",
+	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
 			__get_str(addr), __entry->xid,
-			__get_str(service), __entry->vers, __entry->proc)
+			__get_str(service), __entry->vers,
+			__get_str(procedure)
+	)
 );
 
 DECLARE_EVENT_CLASS(svc_rqst_event,
@@ -1849,6 +1853,7 @@ TRACE_EVENT(svc_stats_latency,
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(unsigned long, execute)
+		__string(procedure, rqst->rq_procinfo->pc_name)
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
@@ -1856,11 +1861,13 @@ TRACE_EVENT(svc_stats_latency,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
 							 rqst->rq_stime));
+		__assign_str(procedure, rqst->rq_procinfo->pc_name);
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x execute-us=%lu",
-		__get_str(addr), __entry->xid, __entry->execute)
+	TP_printk("addr=%s xid=0x%08x proc=%s execute-us=%lu",
+		__get_str(addr), __entry->xid, __get_str(procedure),
+		__entry->execute)
 );
 
 DECLARE_EVENT_CLASS(svc_deferred_event,
-- 
2.43.0




