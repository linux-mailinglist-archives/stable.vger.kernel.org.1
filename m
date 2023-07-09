Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA374C239
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGILSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGILSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583CB5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C09960BEA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641BC433C8;
        Sun,  9 Jul 2023 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901489;
        bh=wFVCP8xLdTVwR7tZEWX5SG3VupPhy39YBsBy+xjiscs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4oFR6yIwMB//ro887sBcvRyF1OsMeQ508YjlJpAK0jEo0bwR8YOspuakbDKknKSH
         drIkxnnn4lJlN6lCs7oqQGIlOwse4tBAWCPGmVqZYmI+LQatlCCy8X3BL1qd2/s6b0
         NmKd/OA0Dhh1QG1X1UKUgDfRp+6PivgkQqhYoi48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 031/431] svcrdma: Prevent page release when nothing was received
Date:   Sun,  9 Jul 2023 13:09:39 +0200
Message-ID: <20230709111451.827225621@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit baf6d18b116b7dc84ed5e212c3a89f17cdc3f28c ]

I noticed that svc_rqst_release_pages() was still unnecessarily
releasing a page when svc_rdma_recvfrom() returns zero.

Fixes: a53d5cb0646a ("svcrdma: Avoid releasing a page in svc_xprt_release()")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a22fe7587fa6f..70207d8a318a4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -796,6 +796,12 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svc_rdma_recv_ctxt *ctxt;
 	int ret;
 
+	/* Prevent svc_xprt_release() from releasing pages in rq_pages
+	 * when returning 0 or an error.
+	 */
+	rqstp->rq_respages = rqstp->rq_pages;
+	rqstp->rq_next_page = rqstp->rq_respages;
+
 	rqstp->rq_xprt_ctxt = NULL;
 
 	ctxt = NULL;
@@ -819,12 +825,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 
-	/* Prevent svc_xprt_release from releasing pages in rq_pages
-	 * if we return 0 or an error.
-	 */
-	rqstp->rq_respages = rqstp->rq_pages;
-	rqstp->rq_next_page = rqstp->rq_respages;
-
 	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;
-- 
2.39.2



