Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A181755497
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGPUcI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjGPUcD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46CE50
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56A8C60EC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BA6C433C7;
        Sun, 16 Jul 2023 20:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539517;
        bh=v3uoKLAFWR7SZ3ecXz9TRugcQinx8YxXLTJKhTbqA5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/ykWBdHZbcMptni3NJh01boKahF+JXPtGh6K81aamvmhRZkkBRlhlvDrizb1vBmB
         5v0btMqz3zdBLpZJvZXoKxdOmJad9r4dO7uPwZXtMfwrCWmhNkoRj8wyHUu3f+c/RC
         ySdLReJa5LDVbe/i7rsXKqIfQO2AXy36T6/0WBOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/591] svcrdma: Prevent page release when nothing was received
Date:   Sun, 16 Jul 2023 21:42:54 +0200
Message-ID: <20230716194924.790971948@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 53a7cb2f6c07d..6da6608985ce9 100644
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



