Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48079AE10
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjIKV3v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbjIKO6X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:58:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5C1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:58:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4B6C433C7;
        Mon, 11 Sep 2023 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444299;
        bh=9ocj7Xj0s+Kj1Ssl8povNNDUQ1NFf26VbHKwakryLSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFnrUp4T7t30otiS5es4g1SBTQZZAgNvcwEPE7TOtOhwt7niaSnWa8GEJH+KTsRMx
         NKjstpON2uG3OGV2Adc+w1dD9iVAjcA338IvVnsKsCadznFfz5IZt/uEWeW/imgpjz
         EEJmJ63V3ZO/C51C0Dh0CGRj+kdaqeQCD9zj0v84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feiyang Chen <chenfeiyang@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6.4 681/737] PCI/PM: Only read PCI_PM_CTRL register when available
Date:   Mon, 11 Sep 2023 15:49:00 +0200
Message-ID: <20230911134709.559541460@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feiyang Chen <chenfeiyang@loongson.cn>

commit 5694ba13b004eea683c6d4faeb6d6e7a9636bda0 upstream.

For a device with no Power Management Capability, pci_power_up() previously
returned 0 (success) if the platform was able to put the device in D0,
which led to pci_set_full_power_state() trying to read PCI_PM_CTRL, even
though it doesn't exist.

Since dev->pm_cap == 0 in this case, pci_set_full_power_state() actually
read the wrong register, interpreted it as PCI_PM_CTRL, and corrupted
dev->current_state.  This led to messages like this in some cases:

  pci 0000:01:00.0: Refused to change power state from D3hot to D0

To prevent this, make pci_power_up() always return a negative failure code
if the device lacks a Power Management Capability, even if non-PCI platform
power management has been able to put the device in D0.  The failure will
prevent pci_set_full_power_state() from trying to access PCI_PM_CTRL.

Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
Link: https://lore.kernel.org/r/20230824013738.1894965-1-chenfeiyang@loongson.cn
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: stable@vger.kernel.org	# v5.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1200,6 +1200,10 @@ static int pci_dev_wait(struct pci_dev *
  *
  * On success, return 0 or 1, depending on whether or not it is necessary to
  * restore the device's BARs subsequently (1 is returned in that case).
+ *
+ * On failure, return a negative error code.  Always return failure if @dev
+ * lacks a Power Management Capability, even if the platform was able to
+ * put the device in D0 via non-PCI means.
  */
 int pci_power_up(struct pci_dev *dev)
 {
@@ -1216,9 +1220,6 @@ int pci_power_up(struct pci_dev *dev)
 		else
 			dev->current_state = state;
 
-		if (state == PCI_D0)
-			return 0;
-
 		return -EIO;
 	}
 
@@ -1276,8 +1277,12 @@ static int pci_set_full_power_state(stru
 	int ret;
 
 	ret = pci_power_up(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		if (dev->current_state == PCI_D0)
+			return 0;
+
 		return ret;
+	}
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;


