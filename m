Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC16FC43D
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEIKvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjEIKvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 06:51:48 -0400
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 03:51:45 PDT
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B954B1
        for <stable@vger.kernel.org>; Tue,  9 May 2023 03:51:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 03BA710189CBF;
        Tue,  9 May 2023 12:44:32 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C83A8603E119;
        Tue,  9 May 2023 12:44:31 +0200 (CEST)
X-Mailbox-Line: From 8811bdb978f819b519ef33e9f536422453311bea Mon Sep 17 00:00:00 2001
Message-Id: <8811bdb978f819b519ef33e9f536422453311bea.1683628574.git.lukas@wunner.de>
In-Reply-To: <0296a234ed04adfec0f256b24fae929f6a268509.1683628574.git.lukas@wunner.de>
References: <0296a234ed04adfec0f256b24fae929f6a268509.1683628574.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 9 May 2023 12:41:10 +0200
Subject: [PATCH 5.4.y 2/2] PCI: pciehp: Fix AB-BA deadlock between reset_lock
 and device_lock
To:     stable@vger.kernel.org
Cc:     Anatoli.Antonovitch@amd.com, alex.williamson@redhat.com,
        amichon@kalrayinc.com, andrey2805@gmail.com, ashok.raj@intel.com,
        bhelgaas@google.com, dstein@hpe.com, ian.may@canonical.com,
        michael.haeuptle@hpe.com, mika.westerberg@linux.intel.com,
        rahul.kumar1@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        wangxiongfeng2@huawei.com, zhangjialin11@huawei.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit f5eff5591b8f9c5effd25c92c758a127765f74c1 upstream.

In 2013, commits

  2e35afaefe64 ("PCI: pciehp: Add reset_slot() method")
  608c388122c7 ("PCI: Add slot reset option to pci_dev_reset()")

amended PCIe hotplug to mask Presence Detect Changed events during a
Secondary Bus Reset.  The reset thus no longer causes gratuitous slot
bringdown and bringup.

However the commits neglected to serialize reset with code paths reading
slot registers.  For instance, a slot bringup due to an earlier hotplug
event may see the Presence Detect State bit cleared during a concurrent
Secondary Bus Reset.

In 2018, commit

  5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset")

retrofitted the missing locking.  It introduced a reset_lock which
serializes a Secondary Bus Reset with other parts of pciehp.

Unfortunately the locking turns out to be overzealous:  reset_lock is
held for the entire enumeration and de-enumeration of hotplugged devices,
including driver binding and unbinding.

Driver binding and unbinding acquires device_lock while the reset_lock
of the ancestral hotplug port is held.  A concurrent Secondary Bus Reset
acquires the ancestral reset_lock while already holding the device_lock.
The asymmetric locking order in the two code paths can lead to AB-BA
deadlocks.

Michael Haeuptle reports such deadlocks on simultaneous hot-removal and
vfio release (the latter implies a Secondary Bus Reset):

  pciehp_ist()                                    # down_read(reset_lock)
    pciehp_handle_presence_or_link_change()
      pciehp_disable_slot()
        __pciehp_disable_slot()
          remove_board()
            pciehp_unconfigure_device()
              pci_stop_and_remove_bus_device()
                pci_stop_bus_device()
                  pci_stop_dev()
                    device_release_driver()
                      device_release_driver_internal()
                        __device_driver_lock()    # device_lock()

  SYS_munmap()
    vfio_device_fops_release()
      vfio_device_group_close()
        vfio_device_close()
          vfio_device_last_close()
            vfio_pci_core_close_device()
              vfio_pci_core_disable()             # device_lock()
                __pci_reset_function_locked()
                  pci_reset_bus_function()
                    pci_dev_reset_slot_function()
                      pci_reset_hotplug_slot()
                        pciehp_reset_slot()       # down_write(reset_lock)

Ian May reports the same deadlock on simultaneous hot-removal and an
AER-induced Secondary Bus Reset:

  aer_recover_work_func()
    pcie_do_recovery()
      aer_root_reset()
        pci_bus_error_reset()
          pci_slot_reset()
            pci_slot_lock()                       # device_lock()
            pci_reset_hotplug_slot()
              pciehp_reset_slot()                 # down_write(reset_lock)

Fix by releasing the reset_lock during driver binding and unbinding,
thereby splitting and shrinking the critical section.

Driver binding and unbinding is protected by the device_lock() and thus
serialized with a Secondary Bus Reset.  There's no need to additionally
protect it with the reset_lock.  However, pciehp does not bind and
unbind devices directly, but rather invokes PCI core functions which
also perform certain enumeration and de-enumeration steps.

The reset_lock's purpose is to protect slot registers, not enumeration
and de-enumeration of hotplugged devices.  That would arguably be the
job of the PCI core, not the PCIe hotplug driver.  After all, an
AER-induced Secondary Bus Reset may as well happen during boot-time
enumeration of the PCI hierarchy and there's no locking to prevent that
either.

Exempting *de-enumeration* from the reset_lock is relatively harmless:
A concurrent Secondary Bus Reset may foil config space accesses such as
PME interrupt disablement.  But if the device is physically gone, those
accesses are pointless anyway.  If the device is physically present and
only logically removed through an Attention Button press or the sysfs
"power" attribute, PME interrupts as well as DMA cannot come through
because pciehp_unconfigure_device() disables INTx and Bus Master bits.
That's still protected by the reset_lock in the present commit.

Exempting *enumeration* from the reset_lock also has limited impact:
The exempted call to pci_bus_add_device() may perform device accesses
through pcibios_bus_add_device() and pci_fixup_device() which are now
no longer protected from a concurrent Secondary Bus Reset.  Otherwise
there should be no impact.

In essence, the present commit seeks to fix the AB-BA deadlocks while
still retaining a best-effort reset protection for enumeration and
de-enumeration of hotplugged devices -- until a general solution is
implemented in the PCI core.

Link: https://lore.kernel.org/linux-pci/CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM
Link: https://lore.kernel.org/linux-pci/20200615143250.438252-1-ian.may@canonical.com
Link: https://lore.kernel.org/linux-pci/ce878dab-c0c4-5bd0-a725-9805a075682d@amd.com
Link: https://lore.kernel.org/linux-pci/ed831249-384a-6d35-0831-70af191e9bce@huawei.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215590
Fixes: 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset")
Link: https://lore.kernel.org/r/fef2b2e9edf245c049a8c5b94743c0f74ff5008a.1681191902.git.lukas@wunner.de
Reported-by: Michael Haeuptle <michael.haeuptle@hpe.com>
Reported-by: Ian May <ian.may@canonical.com>
Reported-by: Andrey Grodzovsky <andrey2805@gmail.com>
Reported-by: Rahul Kumar <rahul.kumar1@amd.com>
Reported-by: Jialin Zhang <zhangjialin11@huawei.com>
Tested-by: Anatoli Antonovitch <Anatoli.Antonovitch@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # v4.19+
Cc: Dan Stein <dstein@hpe.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Alex Michon <amichon@kalrayinc.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..ad12515a4a12 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,7 +63,14 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_bus_add_devices(parent);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
  out:
 	pci_unlock_rescan_remove();
@@ -104,7 +111,15 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+
+		/*
+		 * Release reset_lock during driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
+		down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
-- 
2.39.2

