Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF6775D5A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjHILgd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjHILgc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149031FFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90AF6352F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6312C433C7;
        Wed,  9 Aug 2023 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580991;
        bh=k7/hkVGP6UcjzypddqUKrV+Gaju3YZtSySciLE2E0cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjgyPqtzsOadcMavpKIjAB2Rf3x9vWBsOQcRrjqZoIzKkVYQ8z9emvcgzBOOLYa5U
         N9ouKFYtAEZ6ags6M3ERl704NcBNb+pqwGvkgwM62ClEAvCD8y7WvEMwasqIPTC/Hq
         9oeaEtYuOgjp/m9KIMH8Pv67baiW49iJ2AGnX1nU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.10 067/201] serial: qcom-geni: drop bogus runtime pm state update
Date:   Wed,  9 Aug 2023 12:41:09 +0200
Message-ID: <20230809103646.076519547@linuxfoundation.org>
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

commit 4dd8752a14ca0303fbdf0a6c68ff65f0a50bd2fa upstream.

The runtime PM state should not be changed by drivers that do not
implement runtime PM even if it happens to work around a bug in PM core.

With the wake irq arming now fixed, drop the bogus runtime PM state
update which left the device in active state (and could potentially
prevent a parent device from suspending).

Fixes: f3974413cf02 ("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup")
Cc: 5.6+ <stable@vger.kernel.org> # 5.6+
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/qcom_geni_serial.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1468,13 +1468,6 @@ static int qcom_geni_serial_probe(struct
 		goto err;
 	}
 
-	/*
-	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
-	 * enabled/disabled from dev_pm_arm_wake_irq during system
-	 * suspend/resume respectively.
-	 */
-	pm_runtime_set_active(&pdev->dev);
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,


