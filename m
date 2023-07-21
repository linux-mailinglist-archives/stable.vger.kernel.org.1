Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63775D3D1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGUTOu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGUTOt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690013583
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C96A861D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB236C433C7;
        Fri, 21 Jul 2023 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966884;
        bh=yYrIhPktRi9FlzJUhDsXFVnuxjLa4jXBu8Cp6uIws8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aHru+mu0/fOpWNdeE4KljHnXKNpqAwFhP3ukivNCCjLNFnPLRWoqRYEszlPRg/0L
         BwtCqp5APNffcWVrXLRky+9HBnz5xyzmtkNzhCUC9sy7fYR3MBbmjjHNc+7Sado5wb
         TuIRABLcoqPs4K9+yuj073yFs32uuTzCOa0K2CIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Igor Mammedov <imammedo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5.15 473/532] PCI: acpiphp: Reassign resources on bridge if necessary
Date:   Fri, 21 Jul 2023 18:06:17 +0200
Message-ID: <20230721160640.172320404@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Igor Mammedov <imammedo@redhat.com>

commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 upstream.

When using ACPI PCI hotplug, hotplugging a device with large BARs may fail
if bridge windows programmed by firmware are not large enough.

Reproducer:
  $ qemu-kvm -monitor stdio -M q35  -m 4G \
      -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
      -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
      disk_image

 wait till linux guest boots, then hotplug device:
   (qemu) device_add qxl,bus=rp1

 hotplug on guest side fails with:
   pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
   pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
   pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
   pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
   pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
   pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
   pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
   pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
   pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
   pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
   qxl 0000:01:00.0: enabling device (0000 -> 0003)
   Unable to create vram_mapping
   qxl: probe of 0000:01:00.0 failed with error -12

However when using native PCIe hotplug
  '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
it works fine, since kernel attempts to reassign unused resources.

Use the same machinery as native PCIe hotplug to (re)assign resources.

Link: https://lore.kernel.org/r/20230424191557.2464760-1-imammedo@redhat.com
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/hotplug/acpiphp_glue.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -489,7 +489,6 @@ static void enable_slot(struct acpiphp_s
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
-		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -503,12 +502,10 @@ static void enable_slot(struct acpiphp_s
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					__pci_bus_size_bridges(dev->subordinate,
-							       &add_list);
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);


