Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F117ECF7A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjKOTso (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjKOTsn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B2B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593CCC433C7;
        Wed, 15 Nov 2023 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077719;
        bh=2yu1O77oVX65xeyt0HNIuhcxJruVQOqElDSj7tozYbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM6LTbWdDNsumEkemAznkJUIbosiVOjiCloOXfET9lskEG4xd4TUEsqc9mdjx7WCV
         VEm/JTyiuROOJVujFSlSsVWaGDr3/Bxkehvk9E7AflH4dvRdTlYOUI7btaSR9vq9xM
         /U/u30OH3T5nI35w8V20gmJUDWuMgBB3Q/K7MxNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 477/603] usb: host: xhci-plat: fix possible kernel oops while resuming
Date:   Wed, 15 Nov 2023 14:17:02 -0500
Message-ID: <20231115191645.451285413@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit a5f928db59519a15e82ecba4ae3e7cbf5a44715a ]

If this driver enables the xHC clocks while resuming from sleep, it calls
clk_prepare_enable() without checking for errors and blithely goes on to
read/write the xHC's registers -- which, with the xHC not being clocked,
at least on ARM32 usually causes an imprecise external abort exceptions
which cause kernel oops.  Currently, the chips for which the driver does
the clock dance on suspend/resume seem to be the Broadcom STB SoCs, based
on ARM32 CPUs, as it seems...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 8bd954c56197 ("usb: host: xhci-plat: suspend and resume clocks")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20231019102924.2797346-19-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 28218c8f18376..b93161374293b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -458,23 +458,38 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	int ret;
 
 	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
-		clk_prepare_enable(xhci->clk);
-		clk_prepare_enable(xhci->reg_clk);
+		ret = clk_prepare_enable(xhci->clk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(xhci->reg_clk);
+		if (ret) {
+			clk_disable_unprepare(xhci->clk);
+			return ret;
+		}
 	}
 
 	ret = xhci_priv_resume_quirk(hcd);
 	if (ret)
-		return ret;
+		goto disable_clks;
 
 	ret = xhci_resume(xhci, PMSG_RESUME);
 	if (ret)
-		return ret;
+		goto disable_clks;
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
+
+disable_clks:
+	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
+		clk_disable_unprepare(xhci->clk);
+		clk_disable_unprepare(xhci->reg_clk);
+	}
+
+	return ret;
 }
 
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
-- 
2.42.0



