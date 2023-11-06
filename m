Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7197E255F
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjKFNbN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjKFNbL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:31:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F97100
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:31:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30460C433C8;
        Mon,  6 Nov 2023 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277468;
        bh=D+TY+m+MYIWzhvOBcLdtrA40ZBACI+MTMD/YjzoyGWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKZeYJPShmiL1UlPKrZJYgB5IAPSEBTAgA/nNJecrYcXbVd4ykR25Od6nXT9zMGme
         Is4b8EZTWCmamYd+Xziw0j8jE27k1ycfzb/cOT0WoS9agSFV1xiwbwZEQ6odE5rmXi
         5rNrVybKKhvABfSOp9IFqt8DKemJPUiri3nrCzbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.10 33/95] misc: fastrpc: Clean buffers on remote invocation failures
Date:   Mon,  6 Nov 2023 14:04:01 +0100
Message-ID: <20231106130305.926933443@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -993,11 +993,6 @@ static int fastrpc_internal_invoke(struc
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
@@ -1007,6 +1002,11 @@ static int fastrpc_internal_invoke(struc
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


