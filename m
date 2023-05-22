Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5B70C677
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjEVTS2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjEVTST (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE191133
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44FB86220F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A50C433D2;
        Mon, 22 May 2023 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783095;
        bh=B9KSQCS0Fy9hpycfceqSGWAbANUL51JhjRQBPAsEmTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpPPVH0/a5qzFye4qCggD8waDrVO+m7aKKtwTWBT2sGP9o1I8yWnGKO/b7mYiXW5T
         9Tk7tj/46Jrky2RswguOY4r+a2046B8IAaQ4SLuz3mrLY1nDIEp3gcElc9ow06Zdms
         JERW642EOwqPWIWxBks7uZ3PEvKOMliHAkAPmWq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 137/203] SUNRPC: Remove svc_rqst::rq_xprt_hlen
Date:   Mon, 22 May 2023 20:09:21 +0100
Message-Id: <20230522190358.760319499@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 983084b2672c593959e3148d6a17c8b920797dde ]

Clean up: This field is now always set to zero.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 948f072ada23 ("SUNRPC: always free ctxt when freeing deferred request")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h              |  2 --
 include/trace/events/sunrpc.h           |  3 +--
 net/sunrpc/svc_xprt.c                   | 10 ++++------
 net/sunrpc/svcsock.c                    |  2 --
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  1 -
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 045f34add206f..664a54e330af3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -246,7 +246,6 @@ struct svc_rqst {
 	void *			rq_xprt_ctxt;	/* transport specific context ptr */
 	struct svc_deferred_req*rq_deferred;	/* deferred request we are replaying */
 
-	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
@@ -386,7 +385,6 @@ struct svc_deferred_req {
 	size_t			daddrlen;
 	void			*xprt_ctxt;
 	struct cache_deferred_req handle;
-	size_t			xprt_hlen;
 	int			argslen;
 	__be32			args[];
 };
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index d49426c0444c9..f09bbb6c918e2 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1928,8 +1928,7 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 
 	TP_fast_assign(
 		__entry->dr = dr;
-		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
-						       (dr->xprt_hlen>>2)));
+		__entry->xid = be32_to_cpu(*(__be32 *)dr->args);
 		__assign_sockaddr(addr, &dr->addr, dr->addrlen);
 	),
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 139ef1951a0e8..5da8e87979f15 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1212,7 +1212,6 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->addrlen = rqstp->rq_addrlen;
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
-		dr->xprt_hlen = rqstp->rq_xprt_hlen;
 		dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
 
 		/* back up head to the start of the buffer and copy */
@@ -1241,22 +1240,21 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	trace_svc_defer_recv(dr);
 
 	/* setup iov_base past transport header */
-	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
+	rqstp->rq_arg.head[0].iov_base = dr->args;
 	/* The iov_len does not include the transport header bytes */
-	rqstp->rq_arg.head[0].iov_len = (dr->argslen<<2) - dr->xprt_hlen;
+	rqstp->rq_arg.head[0].iov_len = dr->argslen << 2;
 	rqstp->rq_arg.page_len = 0;
 	/* The rq_arg.len includes the transport header bytes */
-	rqstp->rq_arg.len     = dr->argslen<<2;
+	rqstp->rq_arg.len     = dr->argslen << 2;
 	rqstp->rq_prot        = dr->prot;
 	memcpy(&rqstp->rq_addr, &dr->addr, dr->addrlen);
 	rqstp->rq_addrlen     = dr->addrlen;
 	/* Save off transport header len in case we get deferred again */
-	rqstp->rq_xprt_hlen   = dr->xprt_hlen;
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
 	svc_xprt_received(rqstp->rq_xprt);
-	return (dr->argslen<<2) - dr->xprt_hlen;
+	return dr->argslen << 2;
 }
 
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index a28a6820852b2..9a0a27d1199f5 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -250,8 +250,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	ssize_t len;
 	size_t t;
 
-	rqstp->rq_xprt_hlen = 0;
-
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
 	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 387a5da09dafb..f760342861694 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -826,7 +826,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_err;
 	if (ret == 0)
 		goto out_drop;
-	rqstp->rq_xprt_hlen = 0;
 
 	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
 		goto out_backchannel;
-- 
2.39.2



