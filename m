Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12577F1751
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjKTPat (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjKTPas (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:30:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65BA7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:30:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D86C433C9;
        Mon, 20 Nov 2023 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494244;
        bh=JCfBUlAWtvrJEBuwN0gErhlK1V+6JBLOBOPXUt5lDQc=;
        h=Subject:To:Cc:From:Date:From;
        b=CL0A799TjUK0mByR1YKRTMjZfyvfxUTzGId4srGfO/HP/Z/JhPHCpZjNUS/IKxWDM
         /Xo6a4l1cL2MtkwjAlbfh1fDYDRqoNNd4/FNVywI8u+YmXt7MLjP1DWPiUEeOKmkMv
         LrACIZfZqBcJCc1k1j2Clq858Hwvse3MVLOPRm/o=
Subject: FAILED: patch "[PATCH] mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of" failed to apply to 6.1-stable tree
To:     victor.shih@genesyslogic.com.tw, adrian.hunter@intel.com,
        kai.heng.geng@canonical.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:30:41 +0100
Message-ID: <2023112041-creasing-democrat-d805@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 85dd3af64965c1c0eb7373b340a1b1f7773586b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112041-creasing-democrat-d805@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

85dd3af64965 ("mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER")
f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85dd3af64965c1c0eb7373b340a1b1f7773586b0 Mon Sep 17 00:00:00 2001
From: Victor Shih <victor.shih@genesyslogic.com.tw>
Date: Tue, 7 Nov 2023 17:57:41 +0800
Subject: [PATCH] mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of
 AER

Due to a flaw in the hardware design, the GL9755 replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9755
PCI config. Therefore, the replay timer timeout must be masked.

Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2")
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231107095741.8832-3-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d83261e857a5..044b4704d5bb 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -152,6 +152,9 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
+#define PCI_GLI_9755_CORRERR_MASK				0x214
+#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -770,6 +773,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	value &= ~PCI_GLI_9755_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
+	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+
 	gl9755_wt_off(pdev);
 }
 

