Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0A75BE46
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGUGIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGUGHz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1892
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A42B612B3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521BCC433C8;
        Fri, 21 Jul 2023 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919672;
        bh=Rk5Xnw5Z48SOspIcU3Ip0x3b16bkJ+6abGZGgkk9XwI=;
        h=Subject:To:Cc:From:Date:From;
        b=pEv4D2OzXVdraqUHn12SlFJS97NyONR6NNkIeDjU1l7yUNHz5iNAN1rVnjK3zxSqw
         IE6FjUzLdK5u41zOjHzx2oxbEJJaox6ZUHNhzmtwnWr0hEY51SKdSJqgJ7xnrWUKqA
         aM3oMaCQl3lYRNam5uixHnqesaRHBFGBqf7h6IDA=
Subject: FAILED: patch "[PATCH] hwrng: imx-rngc - fix the timeout for init and self check" failed to apply to 4.19-stable tree
To:     martin@kaiser.cx, herbert@gondor.apana.org.au
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:07:41 +0200
Message-ID: <2023072141-paprika-silica-45b7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d744ae7477190967a3ddc289e2cd4ae59e8b1237
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072141-paprika-silica-45b7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d744ae747719 ("hwrng: imx-rngc - fix the timeout for init and self check")
f086fd1e4344 ("hwrng: imx-rngc - simplify interrupt mask/unmask")
3acd9ea9331c ("hwrng: imx-rngc - use automatic seeding")
47a1f8e8b363 ("hwrng: imx-rngc - fix an error path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d744ae7477190967a3ddc289e2cd4ae59e8b1237 Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin@kaiser.cx>
Date: Thu, 15 Jun 2023 15:49:59 +0100
Subject: [PATCH] hwrng: imx-rngc - fix the timeout for init and self check

Fix the timeout that is used for the initialisation and for the self
test. wait_for_completion_timeout expects a timeout in jiffies, but
RNGC_TIMEOUT is in milliseconds. Call msecs_to_jiffies to do the
conversion.

Cc: stable@vger.kernel.org
Fixes: 1d5449445bd0 ("hwrng: mx-rngc - add a driver for Freescale RNGC")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 1a6a5dd0a5a1..e5a9dee615c8 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -110,7 +110,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	imx_rngc_irq_mask_clear(rngc);
 	if (!ret)
 		return -ETIMEDOUT;
@@ -182,9 +182,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			goto err;

