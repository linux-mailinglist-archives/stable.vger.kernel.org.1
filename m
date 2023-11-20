Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89E7F1744
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjKTP2m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjKTP2l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:28:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB4A7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:28:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2577C433C7;
        Mon, 20 Nov 2023 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494117;
        bh=BYo/tPmf6OvSuZ/FdCjMPjfcsCY9yfisQu+Zn2vnTs0=;
        h=Subject:To:Cc:From:Date:From;
        b=Gj6MKP1GuIXbPqA3Pnz0e66le2uj5L/DSzAZLisFXqMvnpYwftAFvsYQNmSOzgtvm
         zRzTdIbQE57QspO+opQZfilhNc73IsEf+6pxBFc2fkIF/jvmLvF4wGSDEfPvHOSOSl
         vXHWKxl0UJW+HYCH+9cLjvRPK+gUxVuBLE+H0Fx8=
Subject: FAILED: patch "[PATCH] x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and" failed to apply to 5.10-stable tree
To:     mario.limonciello@amd.com, bhelgaas@google.com,
        iain@orangesquash.org.uk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:28:24 +0100
Message-ID: <2023112024-timing-octane-cc05@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7d08f21f8c6307cb05cabb8d86e90ff6ccba57e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112024-timing-octane-cc05@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
606012dddebb ("PCI: Fix up L1SS capability for Intel Apollo Lake Root Port")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d08f21f8c6307cb05cabb8d86e90ff6ccba57e9 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 4 Oct 2023 09:49:59 -0500
Subject: [PATCH] x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and
 Phoenix USB4

Iain reports that USB devices can't be used to wake a Lenovo Z13 from
suspend.  This occurs because on some AMD platforms, even though the Root
Ports advertise PME_Support for D3hot and D3cold, wakeup events from
devices on a USB4 controller don't result in wakeup interrupts from the
Root Port when amd-pmc has put the platform in a hardware sleep state.

If amd-pmc will be involved in the suspend, remove D3hot and D3cold from
the PME_Support mask of Root Ports above USB4 controllers so we avoid those
states if we need wakeups.

Restore D3 support at resume so that it can be used by runtime suspend.

This affects both AMD Rembrandt and Phoenix SoCs.

"pm_suspend_target_state == PM_SUSPEND_ON" means we're doing runtime
suspend, and amd-pmc will not be involved.  In that case PMEs work as
advertised in D3hot/D3cold, so we don't need to do anything.

Note that amd-pmc is technically optional, and there's no need for this
quirk if it's not present, but we assume it's always present because power
consumption is so high without it.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Link: https://lore.kernel.org/r/20231004144959.158840-1-mario.limonciello@amd.com
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[bhelgaas: commit log, move to arch/x86/pci/fixup.c, add #includes]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e3ec02e6ac9f..f347c20247d3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -3,9 +3,11 @@
  * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 #include <linux/vgaarb.h>
 #include <asm/amd_nb.h>
 #include <asm/hpet.h>
@@ -904,3 +906,60 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
+
+#ifdef CONFIG_SUSPEND
+/*
+ * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
+ * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
+ * Root Ports don't generate wakeup interrupts for USB devices.
+ *
+ * When suspending, remove D3hot and D3cold from the PME_Support advertised
+ * by the Root Port so we don't use those states if we're expecting wakeup
+ * interrupts.  Restore the advertised PME_Support when resuming.
+ */
+static void amd_rp_pme_suspend(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+
+	/*
+	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
+	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
+	 *
+	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
+	 * sleep state, but we assume amd-pmc is always present.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_ON)
+		return;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
+				    PCI_PM_CAP_PME_SHIFT);
+	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
+}
+
+static void amd_rp_pme_resume(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	u16 pmc;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp->pm_cap)
+		return;
+
+	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
+	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
+}
+/* Rembrandt (yellow_carp) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
+/* Phoenix (pink_sardine) */
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
+#endif /* CONFIG_SUSPEND */

