Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78C77BDD44
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376731AbjJINJG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376831AbjJINJD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E5B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F15C433C9;
        Mon,  9 Oct 2023 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856940;
        bh=1rR7IWpq5wrNO1SoApJ0zJbyQ+FUa8PIiGaP6NS7O7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwdaW47y9MZg9tEYqZpBNodhOQ7HFiK1/XljykBL/Q5O3dlNV156QVdFopOkdjVQl
         LVehJrie+Q7xEOeZz+VYME64u5B9lZcIIQ3k0cYr2Cn8b5ldBm8GFEOZv0Qq/c2cX3
         pFvpZ4qIipD/sKS5RCpPkEE5AHpwEKtaTh2F+1aM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 6.5 042/163] PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume
Date:   Mon,  9 Oct 2023 15:00:06 +0200
Message-ID: <20231009130125.179194885@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit c82458101d5490230d735caecce14c9c27b1010c upstream.

Mark Blakeney reported that when suspending system with a Thunderbolt
dock connected and then unplugging the dock before resume (which is
pretty normal flow with laptops), resuming takes long time.

What happens is that the PCIe link from the root port to the PCIe switch
inside the Thunderbolt device does not train (as expected, the link is
unplugged):

  pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
  pcieport 0000:00:07.0: waiting 100 ms for downstream link
  pcieport 0000:01:00.0: not ready 1023ms after resume; giving up

However, at this point we still try to resume the devices below that
unplugged link:

  pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
  ...
  pcieport 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
  ...
  pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation

And this is the link from PCIe switch downstream port to the xHCI on the
dock:

  xhci_hcd 0000:03:00.0: not ready 65535ms after resume; giving up
  xhci_hcd 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
  xhci_hcd 0000:03:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)

This ends up slowing down the resume time considerably. For this reason
mark these devices as disconnected if the link above them did not train
properly.

Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
Link: https://lore.kernel.org/r/20230918053041.1018876-1-mika.westerberg@linux.intel.com
Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org	# v6.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a79c110c7e51..51ec9e7e784f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,7 +572,19 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
-	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
+	int ret;
+
+	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
+	if (ret) {
+		/*
+		 * The downstream link failed to come up, so mark the
+		 * devices below as disconnected to make sure we don't
+		 * attempt to resume them.
+		 */
+		pci_walk_bus(pci_dev->subordinate, pci_dev_set_disconnected,
+			     NULL);
+		return;
+	}
 
 	/*
 	 * When powering on a bridge from D3cold, the whole hierarchy may be
-- 
2.42.0



