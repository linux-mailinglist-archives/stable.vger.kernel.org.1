Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E5775DEE
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjHILmY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHILmY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEE1FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29DB9636CF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38006C433C9;
        Wed,  9 Aug 2023 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581342;
        bh=0Rupoy606xFUvlKDC53dfEa4XJfVfhbgWbRcaTlSyEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0q39lO2amCFexG4ly7bSX9nlL/72eXOTpFgJkFVbl6oLvmmyETVAx7BC4zViWELz4
         cSlFQQWlb3ZyP+/rOw9HxYkhBUrIN1Amdxa9DMqaaBa9bXe6aSS7LKu1vUCMCME9Zs
         hBLv8/DwpUhnLmcskclpf5iqJtyVBrVfzEWXKhV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 192/201] PM: sleep: wakeirq: fix wake irq arming
Date:   Wed,  9 Aug 2023 12:43:14 +0200
Message-ID: <20230809103650.257248160@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 8527beb12087238d4387607597b4020bc393c4b4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/power.h   |  1 +
 drivers/base/power/wakeirq.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 0eb7f02b3ad59..922ed457db191 100644
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
index a6d53f0173d35..aea690c64e394 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -317,8 +317,10 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE)) {
 		enable_irq(wirq->irq);
+		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
+	}
 }
 
 /**
@@ -339,8 +341,10 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
 		return;
 
-	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED) {
+		wirq->status &= ~WAKE_IRQ_DEDICATED_ENABLED;
 		disable_irq_nosync(wirq->irq);
+	}
 }
 
 /**
@@ -379,7 +383,7 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 
 	if (device_may_wakeup(wirq->dev)) {
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -402,7 +406,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !pm_runtime_status_suspended(wirq->dev))
+		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }
-- 
2.40.1



