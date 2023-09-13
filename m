Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCF79F1BA
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjIMTIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTIY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F851999
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:08:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7F4C433C7;
        Wed, 13 Sep 2023 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632099;
        bh=1Zpa7MiWkjsTT4qwVnt1LNmo0deFbcUSw5wYzkUX2jM=;
        h=Subject:To:Cc:From:Date:From;
        b=WmtmAELIeLl4lwPViTsfpwjwJFgqQDngAdqN4sn9ZB60WvCx6XguGGXt9Q9wx5k77
         KAs3ioec8ueVbH+4J9Hoa4j2cQxDS9BgMoUs+gnuIEHYF+1TwjiF3AsplHYnw0oQDB
         nTcVWLQxf24kO4JMfaTks8AAE7sBqI3Hirus96ao=
Subject: FAILED: patch "[PATCH] pinctrl: cherryview: fix address_space_handler() argument" failed to apply to 4.19-stable tree
To:     raag.jadav@intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:08:07 +0200
Message-ID: <2023091307-reimburse-afraid-436c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
git cherry-pick -x d5301c90716a8e20bc961a348182daca00c8e8f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091307-reimburse-afraid-436c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d5301c90716a ("pinctrl: cherryview: fix address_space_handler() argument")
3ea2e2cabd2d ("pinctrl: cherryview: Switch to use struct intel_pinctrl")
8a8285707780 ("pinctrl: cherryview: Move custom community members to separate data struct")
0e2d769d4b4e ("pinctrl: cherryview: Drop stale comment")
293428f93260 ("pinctrl: cherryview: Re-use data structures from pinctrl-intel.h (part 3)")
bfc8a4baec93 ("pinctrl: cherryview: Convert chv_writel() to use chv_padreg()")
99fd6512278e ("pinctrl: cherryview: Introduce helpers to IO with common registers")
4e7293e3a2a3 ("pinctrl: cherryview: Introduce chv_readl() helper")
3dbf1ee6abbb ("pinctrl: cherryview: Add missing spinlock usage in chv_gpio_irq_handler")
36ad7b24486a ("pinctrl: cherryview: Re-use data structures from pinctrl-intel.h (part 2)")
b9a19bdbc843 ("pinctrl: cherryview: Pass irqchip when adding gpiochip")
bd90633a5c54 ("pinctrl: cherryview: Add GPIO <-> pin mapping ranges via callback")
82d9beb4b7f7 ("pinctrl: cherryview: Split out irq hw-init into a separate helper function")
8ae93b5ed9be ("pinctrl: cherryview: Missed type change to unsigned int")
e58e177392b9 ("pinctrl: cherryview: Allocate IRQ chip dynamic")
17d49c6258e6 ("pinctrl: cherryview: Fix spelling mistake in the comment")
3c2edc36a774 ("Merge tag 'pinctrl-v5.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5301c90716a8e20bc961a348182daca00c8e8f0 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raag.jadav@intel.com>
Date: Tue, 22 Aug 2023 12:53:40 +0530
Subject: [PATCH] pinctrl: cherryview: fix address_space_handler() argument

First argument of acpi_*_address_space_handler() APIs is acpi_handle of
the device, which is incorrectly passed in driver ->remove() path here.
Fix it by passing the appropriate argument and while at it, make both
API calls consistent using ACPI_HANDLE().

Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")
Cc: stable@vger.kernel.org
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 55a42dbf97b6..81ee949b946d 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1649,7 +1649,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	struct intel_community_context *cctx;
 	struct intel_community *community;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct intel_pinctrl *pctrl;
 	acpi_status status;
 	unsigned int i;
@@ -1717,7 +1716,7 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	status = acpi_install_address_space_handler(adev->handle,
+	status = acpi_install_address_space_handler(ACPI_HANDLE(dev),
 					community->acpi_space_id,
 					chv_pinctrl_mmio_access_handler,
 					NULL, pctrl);
@@ -1734,7 +1733,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
 	const struct intel_community *community = &pctrl->communities[0];
 
-	acpi_remove_address_space_handler(ACPI_COMPANION(&pdev->dev),
+	acpi_remove_address_space_handler(ACPI_HANDLE(&pdev->dev),
 					  community->acpi_space_id,
 					  chv_pinctrl_mmio_access_handler);
 

