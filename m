Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7878AAA4
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjH1KXx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjH1KXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066C95
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EC96399A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016EFC433C7;
        Mon, 28 Aug 2023 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218206;
        bh=XyR3yJ5gMjW+wMkk01IXk98sbdbTupWSZvAZXgGcH3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCFSIbQMgO8+RIYpE45oTJva1Kd+HnbLPTAqqmJu79Bk0GwA2qydeVX0nMZd0sitC
         mcr2oT9DQ8VpFjeB582A+5xWmfkWQ5Z+rjkYzzH89GSXchLkUE0/F0Qg5BY0E/XJpg
         1eFAUzt5HRJrQ8SGQ0bTQXHtITXGtxj9g7OyIRbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Woody Suwalski <terraluna977@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.4 107/129] PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus
Date:   Mon, 28 Aug 2023 12:13:06 +0200
Message-ID: <20230828101200.916376784@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Mammedov <imammedo@redhat.com>

commit cc22522fd55e257c86d340ae9aedc122e705a435 upstream.

40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
changed acpiphp hotplug to use pci_assign_unassigned_bridge_resources()
which depends on bridge being available, however enable_slot() can be
called without bridge associated:

  1. Legitimate case of hotplug on root bus (widely used in virt world)

  2. A (misbehaving) firmware, that sends ACPI Bus Check notifications to
     non existing root ports (Dell Inspiron 7352/0W6WV0), which end up at
     enable_slot(..., bridge = 0) where bus has no bridge assigned to it.
     acpihp doesn't know that it's a bridge, and bus specific 'PCI
     subsystem' can't augment ACPI context with bridge information since
     the PCI device to get this data from is/was not available.

Issue is easy to reproduce with QEMU's 'pc' machine, which supports PCI
hotplug on hostbridge slots. To reproduce, boot kernel at commit
40613da52b13 in VM started with following CLI (assuming guest root fs is
installed on sda1 partition):

  # qemu-system-x86_64 -M pc -m 1G -enable-kvm -cpu host \
        -monitor stdio -serial file:serial.log           \
        -kernel arch/x86/boot/bzImage                    \
        -append "root=/dev/sda1 console=ttyS0"           \
        guest_disk.img

Once guest OS is fully booted at qemu prompt:

  (qemu) device_add e1000

(check serial.log) it will cause NULL pointer dereference at:

  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
  {
    struct pci_bus *parent = bridge->subordinate;

  BUG: kernel NULL pointer dereference, address: 0000000000000018

   ? pci_assign_unassigned_bridge_resources+0x1f/0x260
   enable_slot+0x21f/0x3e0
   acpiphp_hotplug_notify+0x13d/0x260
   acpi_device_hotplug+0xbc/0x540
   acpi_hotplug_work_fn+0x15/0x20
   process_one_work+0x1f7/0x370
   worker_thread+0x45/0x3b0

The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with following
sequence:

  1. Suspend to RAM
  2. Wake up with the same backtrace being observed:
  3. 2nd suspend to RAM attempt makes laptop freeze

Fix it by using __pci_bus_assign_resources() instead of
pci_assign_unassigned_bridge_resources() as we used to do, but only in case
when bus doesn't have a bridge associated (to cover for the case of ACPI
event on hostbridge or non existing root port).

That lets us keep hotplug on root bus working like it used to and at the
same time keeps resource reassignment usable on root ports (and other 1st
level bridges) that was fixed by 40613da52b13.

Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
Link: https://lore.kernel.org/r/20230726123518.2361181-2-imammedo@redhat.com
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Tested-by: Woody Suwalski <terraluna977@gmail.com>
Tested-by: Michal Koutný <mkoutny@suse.com>
Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/acpiphp_glue.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_s
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
+		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_s
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
+					if (pci_is_root_bus(bus))
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		pci_assign_unassigned_bridge_resources(bus->self);
+		if (pci_is_root_bus(bus))
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+		else
+			pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);


