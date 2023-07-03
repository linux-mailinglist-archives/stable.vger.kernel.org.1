Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6597462F7
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGCS4V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGCS4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA36E70
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 315A460FFA
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482B7C433C7;
        Mon,  3 Jul 2023 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410575;
        bh=T/z3z9Cy2GaRs/lQZd/kAdGK6oAqnBvP8x2nftK6uhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qi0Ow2s+/96YnfiD/6x9Jgw6qUKRA1ECGxPB8uYX7+BmkOAZDR9l5JTcX6qunBWz
         rNmy5+10xMIKh5fF7FNYbJGFmyCq+7uuH0floqeICqzffS8POBAB506EAK9w/Z/go+
         kS8vZCMDUp3AfZZNJHpI04LfzQhDYmMc3rSRT06E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6.3 04/13] PCI/ACPI: Call _REG when transitioning D-states
Date:   Mon,  3 Jul 2023 20:54:14 +0200
Message-ID: <20230703184519.327987756@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
References: <20230703184519.206275653@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 112a7f9c8edbf76f7cb83856a6cb6b60a210b659 upstream.

ACPI r6.5, sec 6.5.4, describes how AML is unable to access an
OperationRegion unless _REG has been called to connect a handler:

  The OS runs _REG control methods to inform AML code of a change in the
  availability of an operation region. When an operation region handler is
  unavailable, AML cannot access data fields in that region.  (Operation
  region writes will be ignored and reads will return indeterminate data.)

The PCI core does not call _REG at any time, leading to the undefined
behavior mentioned in the spec.

The spec explains that _REG should be executed to indicate whether a
given region can be accessed:

  Once _REG has been executed for a particular operation region, indicating
  that the operation region handler is ready, a control method can access
  fields in the operation region. Conversely, control methods must not
  access fields in operation regions when _REG method execution has not
  indicated that the operation region handler is ready.

An example included in the spec demonstrates calling _REG when devices are
turned off: "when the host controller or bridge controller is turned off
or disabled, PCI Config Space Operation Regions for child devices are
no longer available. As such, ETH0’s _REG method will be run when it
is turned off and will again be run when PCI1 is turned off."

It is reported that ASMedia PCIe GPIO controllers fail functional tests
after the system has returning from suspend (S3 or s2idle). This is because
the BIOS checks whether the OSPM has called the _REG method to determine
whether it can interact with the OperationRegion assigned to the device as
part of the other AML called for the device.

To fix this issue, call acpi_evaluate_reg() when devices are transitioning
to D3cold or D0.

[bhelgaas: split pci_power_t checking to preliminary patch]
Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#reg-region
Link: https://lore.kernel.org/r/20230620140451.21007-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-acpi.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *
 	return false;
 }
 
+static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
+{
+	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
+	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				    ACPI_ADR_SPACE_PCI_CONFIG, val);
+	if (ret)
+		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
+			enable ? "connect" : "disconnect", ret);
+}
+
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1074,6 +1084,9 @@ int acpi_pci_set_power_state(struct pci_
 		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
 				PM_QOS_FLAGS_ALL)
 			return -EBUSY;
+
+		/* Notify AML lack of PCI config space availability */
+		acpi_pci_config_space_access(dev, false);
 	}
 
 	error = acpi_device_set_power(adev, state_conv[state]);
@@ -1083,6 +1096,15 @@ int acpi_pci_set_power_state(struct pci_
 	pci_dbg(dev, "power state changed by ACPI to %s\n",
 	        acpi_power_state_string(adev->power.state));
 
+	/*
+	 * Notify AML of PCI config space availability.  Config space is
+	 * accessible in all states except D3cold; the only transitions
+	 * that change availability are transitions to D3cold and from
+	 * D3cold to D0.
+	 */
+	if (state == PCI_D0)
+		acpi_pci_config_space_access(dev, true);
+
 	return 0;
 }
 


