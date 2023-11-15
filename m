Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF57ED583
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjKOVHc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjKOVHZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F40D4E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F4AC4E683;
        Wed, 15 Nov 2023 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081471;
        bh=hPh1dHgtXXEKg053Yq+XZHx+PlCbHNf3ZLIzsybjJGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gd/zhkv6L+RUPpYKzKx0ZsdXEQRACzdDpJNafiYQDndE66lVcMQBhcHP3xzs1ROjb
         LXUNRzEE2KH3oduTyiVpSM3gZs9YW2Qnt3lw1GbdmNJAQ8uOUb9+qDE7vXCRJkF5zV
         yC6Z3G/TZ13gAakZRAeJApgAVVS2ccjxNY0NbKr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Prinke <michael.prinke@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Lijun Pan <lijun.pan@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/244] dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers
Date:   Wed, 15 Nov 2023 15:36:06 -0500
Message-ID: <20231115203558.804086352@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fenghua Yu <fenghua.yu@intel.com>

[ Upstream commit 88928addeec577386e8c83b48b5bc24d28ba97fd ]

idxd sub-drivers belong to bus dsa_bus_type. Thus, dsa_bus_type must be
registered in dsa bus init before idxd drivers can be registered.

But the order is wrong when both idxd and idxd_bus are builtin drivers.
In this case, idxd driver is compiled and linked before idxd_bus driver.
Since the initcall order is determined by the link order, idxd sub-drivers
are registered in idxd initcall before dsa_bus_type is registered
in idxd_bus initcall. idxd initcall fails:

[   21.562803] calling  idxd_init_module+0x0/0x110 @ 1
[   21.570761] Driver 'idxd' was unable to register with bus_type 'dsa' because the bus was not initialized.
[   21.586475] initcall idxd_init_module+0x0/0x110 returned -22 after 15717 usecs
[   21.597178] calling  dsa_bus_init+0x0/0x20 @ 1

To fix the issue, compile and link idxd_bus driver before idxd driver
to ensure the right registration order.

Fixes: d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone")
Reported-by: Michael Prinke <michael.prinke@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Lijun Pan <lijun.pan@intel.com>
Tested-by: Lijun Pan <lijun.pan@intel.com>
Link: https://lore.kernel.org/r/20230924162232.1409454-1-fenghua.yu@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index a1e9f2b3a37cc..817ffa95a9b11 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,12 +1,12 @@
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
+obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
+idxd_bus-y := bus.o
+
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
 idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
-obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
-idxd_bus-y := bus.o
-
 obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
 idxd_compat-y := compat.o
-- 
2.42.0



