Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6F7E24D2
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKFNZi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjKFNZg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779BEBF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA333C433CA;
        Mon,  6 Nov 2023 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277133;
        bh=PvdMV7OzsuJPdduEfdY4Ujd0CbtvQ/nUdqxhHPOELsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ps/q5RUyWFeqCcweiLdBW1PmqtbGHL6iO7r/YUOImsWIPl02C8NsXJYTAzuClhDlS
         cJ5//J0yN8GJncQ58ThJhbin35TMKJLX1MXLXB7LEFOg+hwzc2blBI2/8NbgCLyJlv
         3qKKLnjHtt/kja+HkiHlumdjKwoNjP1i6nnRxvDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.15 049/128] misc: fastrpc: Clean buffers on remote invocation failures
Date:   Mon,  6 Nov 2023 14:03:29 +0100
Message-ID: <20231106130311.337204999@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit 1c8093591d1e372d700fe65423e7315a8ecf721b upstream.

With current design, buffers and dma handles are not freed in case
of remote invocation failures returned from DSP. This could result
in buffer leakings and dma handle pointing to wrong memory in the
fastrpc kernel. Adding changes to clean buffers and dma handles
even when remote invocation to DSP returns failures.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231013122007.174464-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -995,11 +995,6 @@ static int fastrpc_internal_invoke(struc
 	if (err)
 		goto bail;
 
-	/* Check the response from remote dsp */
-	err = ctx->retval;
-	if (err)
-		goto bail;
-
 	if (ctx->nscalars) {
 		/* make sure that all memory writes by DSP are seen by CPU */
 		dma_rmb();
@@ -1009,6 +1004,11 @@ static int fastrpc_internal_invoke(struc
 			goto bail;
 	}
 
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
 		/* We are done with this compute context */


