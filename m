Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9E73B3D4
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWJmK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjFWJmJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75E1A3
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731C1619DA
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8270CC433C8;
        Fri, 23 Jun 2023 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687513326;
        bh=i2pymgD8btgxK1FvbMqZyZiczKkJyWL9GdX3yPUxbsg=;
        h=Subject:To:Cc:From:Date:From;
        b=S/kZSwfK738tMdv03HSGOVJ+XQhFgfe5vd+tgagWeGFH3e0eOQjpw9Xy82gmZlnnr
         PHNw4tH2nPga3CVlwQyiF8BYNsOdfcEq290umohNEI5HEc4W1WmEg5YyIhnrVzxMhq
         jvRh3vDRNkC85v1osfTJIsYTALItFI8wB8uwGNhg=
Subject: FAILED: patch "[PATCH] mmc: meson-gx: fix deferred probing" failed to apply to 6.1-stable tree
To:     s.shtylyov@omp.ru, neil.armstrong@linaro.org,
        ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:42:04 +0200
Message-ID: <2023062303-crazily-recent-78b0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b8ada54fa1b83f3b6480d4cced71354301750153
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062303-crazily-recent-78b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8ada54fa1b83f3b6480d4cced71354301750153 Mon Sep 17 00:00:00 2001
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Date: Sat, 17 Jun 2023 23:36:12 +0300
Subject: [PATCH] mmc: meson-gx: fix deferred probing

The driver overrides the error codes and IRQ0 returned by platform_get_irq()
to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the error
codes upstream.  Since commit ce753ad1549c ("platform: finally disallow IRQ0
in platform_get_irq() and its ilk") IRQ0 is no longer returned by those APIs,
so we now can safely ignore it...

Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230617203622.6812-3-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f90b0fd8d8b0..ee9a25b900ae 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1186,8 +1186,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return -EINVAL;
+	if (host->irq < 0)
+		return host->irq;
 
 	cd_irq = platform_get_irq_optional(pdev, 1);
 	mmc_gpio_set_cd_irq(mmc, cd_irq);

