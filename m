Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC878AD5C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjH1Kr2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjH1KrN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C46CCD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35F36426B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7AAC433C8;
        Mon, 28 Aug 2023 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219617;
        bh=npAqKZtj7eaXUoCLlUm0yQOcBQ3GvCENoaOS0MaTaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUNM/rF6YSZINabexB2DmJnIsV7DmtT2MQQ3egjZpRc/sfRuD39aLGx/JddY3cgsA
         12NYxdSefWhtCzti5XE683uO2dVG8KG+SxVW0Dl5Rop9j1vISQ/vOt2VucwzXfbrQ1
         7CEHzRSOOTPktQVBvuv7bl9xadZ+6dVqzPsjDEBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 03/84] xprtrdma: Remap Receive buffers after a reconnect
Date:   Mon, 28 Aug 2023 12:13:20 +0200
Message-ID: <20230828101149.273545815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 895cedc1791916e8a98864f12b656702fad0bb67 ]

On server-initiated disconnect, rpcrdma_xprt_disconnect() was DMA-
unmapping the Receive buffers, but rpcrdma_post_recvs() neglected
to remap them after a new connection had been established. The
result was immediate failure of the new connection with the Receives
flushing with LOCAL_PROT_ERR.

Fixes: 671c450b6fe0 ("xprtrdma: Fix oops in Receive handler after device removal")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/verbs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 338b06de86d16..d015576f3081a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -972,9 +972,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
-	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
-		goto out_free_regbuf;
-
 	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rep->rr_rdmabuf),
 		     rdmab_length(rep->rr_rdmabuf));
 	rep->rr_cqe.done = rpcrdma_wc_receive;
@@ -987,8 +984,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	list_add(&rep->rr_all, &r_xprt->rx_buf.rb_all_reps);
 	return rep;
 
-out_free_regbuf:
-	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 out_free:
 	kfree(rep);
 out:
@@ -1425,6 +1420,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 			rep = rpcrdma_rep_create(r_xprt, temp);
 		if (!rep)
 			break;
+		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
+			rpcrdma_rep_put(buf, rep);
+			break;
+		}
 
 		trace_xprtrdma_post_recv(rep);
 		rep->rr_recv_wr.next = wr;
-- 
2.40.1



