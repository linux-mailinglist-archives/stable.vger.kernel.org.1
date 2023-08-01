Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786D76A8A8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjHAGF4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHAGF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 02:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7619AA
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 23:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6C161474
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF07EC433C8;
        Tue,  1 Aug 2023 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869953;
        bh=4Sh09EsaOjgbhkyLNkerOloXI7zB8TiUMfOLkYOoP20=;
        h=Subject:To:Cc:From:Date:From;
        b=u38G/iDXsTXUTrDjzv5rCRDGbrPKvRvqhjQooESsYUCFmtclWV2U1fha83u8pAGuY
         XkjLCz6pxwf696W1W5gX43nKLW/VbiZCiBaQvCvvynMFKGQRSK0yOgLasiI01n2TbC
         QY3UBJ0xXVXpdFtuF54NNPeSC6IIrfxsGPftzuuk=
Subject: FAILED: patch "[PATCH] PM: sleep: wakeirq: fix wake irq arming" failed to apply to 5.4-stable tree
To:     johan+linaro@kernel.org, rafael.j.wysocki@intel.com,
        stable@vger.kernel.org, tony@atomide.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 08:05:46 +0200
Message-ID: <2023080146-gallows-railroad-57e4@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8527beb12087238d4387607597b4020bc393c4b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080146-gallows-railroad-57e4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
259714100d98 ("PM / wakeirq: support enabling wake-up irq after runtime_suspend called")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8527beb12087238d4387607597b4020bc393c4b4 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 13 Jul 2023 16:57:39 +0200
Subject: [PATCH] PM: sleep: wakeirq: fix wake irq arming

The decision whether to enable a wake irq during suspend can not be done
based on the runtime PM state directly as a driver may use wake irqs
without implementing runtime PM. Such drivers specifically leave the
state set to the default 'suspended' and the wake irq is thus never
enabled at suspend.

Add a new wake irq flag to track whether a dedicated wake irq has been
enabled at runtime suspend and therefore must not be enabled at system
suspend.

Note that pm_runtime_enabled() can not be used as runtime PM is always
disabled during late suspend.

Fixes: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 0eb7f02b3ad5..922ed457db19 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -29,6 +29,7 @@ extern u64 pm_runtime_active_time(struct device *dev);
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
 					 WAKE_IRQ_DEDICATED_MANAGED | \
 					 WAKE_IRQ_DEDICATED_REVERSE)
+#define WAKE_IRQ_DEDICATED_ENABLED	BIT(3)
 
 struct wake_irq {
 	struct device *dev;
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index d487a6bac630..afd094dec5ca 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -314,8 +314,10 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE)) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
@@ -336,8 +338,10 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED) {
+		wirq->status &= ~WAKE_IRQ_DEDICATED_ENABLED;
 		disable_irq_nosync(wirq->irq);
+	}
 }
 
 /**
@@ -376,7 +380,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -399,7 +403,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }

