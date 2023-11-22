Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC327F5135
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 21:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjKVUIJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 15:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVUIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 15:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689F92
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 12:08:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB8C433C7;
        Wed, 22 Nov 2023 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700683684;
        bh=GUi9R8fXvXWFqumBsaqw/323Pfpfj/rGYKsuAWXqm5U=;
        h=Subject:To:Cc:From:Date:From;
        b=ye1ANp5DlWRkafZIb+wRRxQ7esc9dioSNucV8OZMeU1DL85LQx2KYqqgAk6lnpW2n
         xQ8+8Iz61dby6Nmmh1tOivt7kat5xvPo8n2NvldT3tPzu8Ie5e+B/QXAbBHuXSdQul
         d5gUx1Jgk8rYD/RaXfLESGrHk/1gKPGrxvnScgbQ=
Subject: FAILED: patch "[PATCH] PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e" failed to apply to 5.10-stable tree
To:     lukas@wunner.de, CSchroeder@sonifi.com, bhelgaas@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 20:07:58 +0000
Message-ID: <2023112258-saddlebag-vantage-48b3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c9260693aa0c1e029ed23693cfd4d7814eee6624
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112258-saddlebag-vantage-48b3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c9260693aa0c ("PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card")
26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
ae9813db1dc5 ("PCI: Add quirks to generate device tree node for Xilinx Alveo U50")
74df14cd301a ("of: unittest: add node lifecycle tests")
e87cacadebaf ("of: overlay: rename overlay source files from .dts to .dtso")
5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root Ports")
3cc30140dbe2 ("Merge tag 'pci-v5.19-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9260693aa0c1e029ed23693cfd4d7814eee6624 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 21 Sep 2023 16:23:34 +0200
Subject: [PATCH] PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e
 card

Commit ac91e6980563 ("PCI: Unify delay handling for reset and resume")
shortened an unconditional 1 sec delay after a Secondary Bus Reset to 100
msec for PCIe (per PCIe r6.1 sec 6.6.1).  The 1 sec delay is only required
for Conventional PCI.

But it turns out that there are PCIe devices which require a longer delay
than prescribed before first config space access after reset recovery or
resume from D3cold:

Chad reports that a "VideoPropulsion Torrent QN16e" MPEG QAM Modulator
"raises a PCI system error (PERR), as reported by the IPMI event log, and
the hardware itself would suffer a catastrophic event, cycling the server"
unless the longer delay is observed.

The card is specified to conform to PCIe r1.0 and indeed only supports Gen1
speed (2.5 GT/s) according to lspci.  PCIe r1.0 sec 7.6 prescribes the same
100 msec delay as PCIe r6.1 sec 6.6.1:

  To allow components to perform internal initialization, system software
  must wait for at least 100 ms from the end of a reset (cold/warm/hot)
  before it is permitted to issue Configuration Requests

The behavior of the Torrent QN16e card thus appears to be a quirk.  Treat
it as such and lengthen the reset delay for this specific device.

Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
Link: https://lore.kernel.org/r/47727e792c7f0282dc144e3ec8ce8eb6e713394e.1695304512.git.lukas@wunner.de
Reported-by: Chad Schroeder <CSchroeder@sonifi.com>
Closes: https://lore.kernel.org/linux-pci/DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com/
Tested-by: Chad Schroeder <CSchroeder@sonifi.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # v5.4+

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..91a15d79c7c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+/*
+ * Devices known to require a longer delay before first config space access
+ * after reset recovery or resume from D3cold:
+ *
+ * VideoPropulsion (aka Genroco) Torrent QN16e MPEG QAM Modulator
+ */
+static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
+{
+	pdev->d3cold_delay = 1000;
+}
+DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);

