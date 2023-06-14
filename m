Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0087727016
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjFGVEb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjFGVEO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA2269E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC330649B5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E279FC4339B;
        Wed,  7 Jun 2023 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171833;
        bh=5WEHDuXc/p9pp7CkIBIeWXP9GfEXv/bA9ptD3xA86F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pN3HlKriQ8YbXUO/cxjecMTp9q6Km+cQ3fC6nP47xqFUQC1bkXEe6EZUoU40N5Yoj
         0a45Jy1l6AvMcErWGOoTdZbAVHxzXUASx/AY8L7eyGxY2TsZk4R15GOmXYCqMvWEed
         tr1s9OjVi3OvAHXMvZUEpLKTlTvaDyuA1ITadzeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.15 151/159] scsi: dpt_i2o: Do not process completions with invalid addresses
Date:   Wed,  7 Jun 2023 22:17:34 +0200
Message-ID: <20230607200908.601935843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

adpt_isr() reads reply addresses from a hardware register, which
should always be within the DMA address range of the device's pool of
reply address buffers.  In case the address is out of range, it tries
to muddle on, converting to a virtual address using bus_to_virt().

bus_to_virt() does not take DMA addresses, and it doesn't make sense
to try to handle the completion in this case.  Ignore it and continue
looping to service the interrupt.  If a completion has been lost then
the SCSI core should eventually time-out and trigger a reset.

There is no corresponding upstream commit, because this driver was
removed upstream.

Fixes: 67af2b060e02 ("[SCSI] dpt_i2o: move from virt_to_bus/bus_to_virt ...")
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/Kconfig   |    2 +-
 drivers/scsi/dpt_i2o.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -460,7 +460,7 @@ config SCSI_MVUMI
 
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on SCSI && PCI && VIRT_TO_BUS
+	depends on SCSI && PCI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -56,7 +56,7 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Dri
 #include <linux/mutex.h>
 
 #include <asm/processor.h>	/* for boot_cpu_data */
-#include <asm/io.h>		/* for virt_to_bus, etc. */
+#include <asm/io.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -1865,7 +1865,7 @@ static irqreturn_t adpt_isr(int irq, voi
 		} else {
 			/* Ick, we should *never* be here */
 			printk(KERN_ERR "dpti: reply frame not from pool\n");
-			reply = (u8 *)bus_to_virt(m);
+			continue;
 		}
 
 		if (readl(reply) & MSG_FAIL) {


