Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463B97DAC65
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjJ2MUr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2MUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Oct 2023 08:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9891
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 05:20:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D01C433C8;
        Sun, 29 Oct 2023 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698582044;
        bh=03nbzUKLL07L+9ycfj5c5hTlcidDLCNzeAkYCQyKfbc=;
        h=Subject:To:Cc:From:Date:From;
        b=pmjPS0BJbpgsjsLs8yGjs5Iweceri4VbLLOJM8uYliJvFMSUNDpZage6W8dm/Cu+9
         9mNcyH/PrfLfRMigs66wB0lIkfaAFo2NE3YJofGz7qYJNzYkJQk/m+sY8AScGxAiFR
         UBxs92YiKjpgiByxkuhh98TKO2Fbr7Ez8Ug7n9q4=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Clean buffers on remote invocation failures" failed to apply to 5.4-stable tree
To:     quic_ekangupt@quicinc.com, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:20:39 +0100
Message-ID: <2023102939-grit-elitism-fb36@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8093591d1e372d700fe65423e7315a8ecf721b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102939-grit-elitism-fb36@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c8093591d1e372d700fe65423e7315a8ecf721b Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
Date: Fri, 13 Oct 2023 13:20:06 +0100
Subject: [PATCH] misc: fastrpc: Clean buffers on remote invocation failures

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

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a52701c1b018..3cdc58488db1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1176,11 +1176,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		err = wait_for_completion_interruptible(&ctx->work);
 	}
 
-	if (err)
-		goto bail;
-
-	/* Check the response from remote dsp */
-	err = ctx->retval;
 	if (err)
 		goto bail;
 
@@ -1191,6 +1186,11 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
 bail:
 	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
 		/* We are done with this compute context */

