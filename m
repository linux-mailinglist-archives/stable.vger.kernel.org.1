Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041AD78AB0D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjH1K1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjH1K1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896A12F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AA662FAD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA54C433C8;
        Mon, 28 Aug 2023 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218415;
        bh=eLxH5kyjdUPXsZS4wV7n/BXNOG5ktZYkyy8K1kTBePY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6ziPXAcA+zLqcV9LXfUkLws07BkObXv8XFcODUieogAaZ42/qeGVfB/eVRcn+ph/
         j8x0qM8l4mjr4bG//12kLUJuY6TJjULYPPXrWZ7fS9Hr7DV4WiKuo1yt1+5N0j6un/
         tg+37ekSnjoQHkScZoELz9hlfhNiYZY9k8ctaWag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Igor Mammedov <imammedo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/129] PCI: acpiphp: Reassign resources on bridge if necessary
Date:   Mon, 28 Aug 2023 12:12:53 +0200
Message-ID: <20230828101156.251632236@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Mammedov <imammedo@redhat.com>

[ Upstream commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/acpiphp_glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 3d8844e7090a8..0c1ae63c6dbc4 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -496,7 +496,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
-		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -510,12 +509,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
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
-- 
2.40.1



