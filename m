Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81C7D35C9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJWLvy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjJWLvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:51:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA031D7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:51:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF6C433C7;
        Mon, 23 Oct 2023 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061903;
        bh=hN+mRGYYDi+Efp6Nh2ze41eCw8AgeMXdFerRWjHBd94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSp7F/P/m/DkR2IMnFViyHh8ckv0jz8mrmY2mScHvwD1y3IM99kNdpNcVrTq9DL36
         zuiJdqT9SLaH6vRjZDnd0kOVsCfz9S1PsArNUW4bEeYjCOSZ978ZVr1o57zqEg/emI
         qdraltGDGPcE7OHnxEGrFKHfMcM+N8U5bJ9/KVxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.10 183/202] ACPI: irq: Fix incorrect return value in acpi_register_gsi()
Date:   Mon, 23 Oct 2023 12:58:10 +0200
Message-ID: <20231023104831.802812747@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil V L <sunilvl@ventanamicro.com>

commit 0c21a18d5d6c6a73d098fb9b4701572370942df9 upstream.

acpi_register_gsi() should return a negative value in case of failure.

Currently, it returns the return value from irq_create_fwspec_mapping().
However, irq_create_fwspec_mapping() returns 0 for failure. Fix the
issue by returning -EINVAL if irq_create_fwspec_mapping() returns zero.

Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
Cc: 4.11+ <stable@vger.kernel.org> # 4.11+
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
[ rjw: Rename a new local variable ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/irq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -52,6 +52,7 @@ int acpi_register_gsi(struct device *dev
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	unsigned int irq;
 
 	if (WARN_ON(!acpi_gsi_domain_id)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
@@ -63,7 +64,11 @@ int acpi_register_gsi(struct device *dev
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
-	return irq_create_fwspec_mapping(&fwspec);
+	irq = irq_create_fwspec_mapping(&fwspec);
+	if (!irq)
+		return -EINVAL;
+
+	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 


