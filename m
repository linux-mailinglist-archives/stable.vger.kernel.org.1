Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4A7DD55D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376520AbjJaRtx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376538AbjJaRtx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D092
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB231C433C8;
        Tue, 31 Oct 2023 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774589;
        bh=yiOoJ7ydYquGz6eaw+4nfl7uWufnIbCGB5OqtFmOrcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlRCwJ64VQMZ+ToJe9nRleZVnTu7IlMM/LnrGLCcB0Kx7uodmq9svT+qmWa+VC/qU
         qM7uTNC9UCcnW59NDrrGdDdlX/DF6QpHTRd91yhPkl58iiM9yjlDNoK+K3uCC9oKaw
         UMfEYUEFlrAixIiknzJq2N+Jm9bPuUJ5UfQlCsGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.5 096/112] misc: fastrpc: Free DMA handles for RPC calls with no arguments
Date:   Tue, 31 Oct 2023 18:01:37 +0100
Message-ID: <20231031165904.322289993@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1090,6 +1090,7 @@ static int fastrpc_put_args(struct fastr
 		}
 	}
 
+	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
@@ -1156,11 +1157,9 @@ static int fastrpc_internal_invoke(struc
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
@@ -1184,14 +1183,12 @@ static int fastrpc_internal_invoke(struc
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


