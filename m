Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4EE7DD424
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjJaRHH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbjJaRGx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029DE26A9
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:05:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3856DC433C8;
        Tue, 31 Oct 2023 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771937;
        bh=iNMpPscJsCivXBqN3j1gWa3UDJSrgwy6CqpoSVMauOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBxtcJC2QNGb73oOCVhT/czCCla+XB+01hujqr5bk+fCQNJYXacEl6Rx9B5cS+cE5
         5WUXS8+IKiptjDlfagCSI9NwvyCHx9EMZWOk/gnWu+590hpbi7dhHiPcJ7U/05yBGK
         g+8W6S8k/0mO9t9YgVpcrLrjLialVNOINRETjmCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.1 71/86] misc: fastrpc: Free DMA handles for RPC calls with no arguments
Date:   Tue, 31 Oct 2023 18:01:36 +0100
Message-ID: <20231031165920.764253709@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit 206484303892a2a36c0c3414030ddfef658a4e70 upstream.

The FDs for DMA handles to be freed is updated in fdlist by DSP over
a remote call. This holds true even for remote calls with no
arguments. To handle this, get_args and put_args are needed to
be called for remote calls with no arguments also as fdlist
is allocated in get_args and FDs updated in fdlist is freed
in put_args.

Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013122007.174464-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1036,6 +1036,7 @@ static int fastrpc_put_args(struct fastr
 		}
 	}
 
+	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
@@ -1100,11 +1101,9 @@ static int fastrpc_internal_invoke(struc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (ctx->nscalars) {
-		err = fastrpc_get_args(kernel, ctx);
-		if (err)
-			goto bail;
-	}
+	err = fastrpc_get_args(kernel, ctx);
+	if (err)
+		goto bail;
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
@@ -1128,14 +1127,12 @@ static int fastrpc_internal_invoke(struc
 	if (err)
 		goto bail;
 
-	if (ctx->nscalars) {
-		/* make sure that all memory writes by DSP are seen by CPU */
-		dma_rmb();
-		/* populate all the output buffers with results */
-		err = fastrpc_put_args(ctx, kernel);
-		if (err)
-			goto bail;
-	}
+	/* make sure that all memory writes by DSP are seen by CPU */
+	dma_rmb();
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
+	if (err)
+		goto bail;
 
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {


