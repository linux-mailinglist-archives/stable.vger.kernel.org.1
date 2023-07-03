Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DBB7462E8
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGCSzp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGCSzo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1810CA
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B17360D3A
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8358AC433C8;
        Mon,  3 Jul 2023 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410536;
        bh=Vig3yXTY/3fQPPXHqx9Afeb8HKK2wLzEmx7gDQSJSx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRR8MptXfjkY6pj5k7qjGHLFEuZpMoOpxfiPI7+9lm6Oxdl5are/DNkyw+2m7wIUA
         /rS22JHsRzfolm4uahdm51HzahTwWfwz6qmol9EFREDxTemIf3jkIVcwU72K6yIfKv
         Pp0WSmnSLs7DtQAIf6Y9WmmM35ll8mcJhcTPlAu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.4 03/13] PCI/ACPI: Validate acpi_pci_set_power_state() parameter
Date:   Mon,  3 Jul 2023 20:54:04 +0200
Message-ID: <20230703184519.365460952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.261119397@linuxfoundation.org>
References: <20230703184519.261119397@linuxfoundation.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

commit 5557b62634abbd55bab7b154ce4bca348ad7f96f upstream.

Previously acpi_pci_set_power_state() assumed the requested power state was
valid (PCI_D0 ... PCI_D3cold).  If a caller supplied something else, we
could index outside the state_conv[] array and pass junk to
acpi_device_set_power().

Validate the pci_power_t parameter and return -EINVAL if it's invalid.

Link: https://lore.kernel.org/r/20230621222857.GA122930@bhelgaas
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-acpi.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1053,32 +1053,37 @@ int acpi_pci_set_power_state(struct pci_
 		[PCI_D3hot] = ACPI_STATE_D3_HOT,
 		[PCI_D3cold] = ACPI_STATE_D3_COLD,
 	};
-	int error = -EINVAL;
+	int error;
 
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
 		return -ENODEV;
 
 	switch (state) {
-	case PCI_D3cold:
-		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
-				PM_QOS_FLAGS_ALL) {
-			error = -EBUSY;
-			break;
-		}
-		fallthrough;
 	case PCI_D0:
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
+	case PCI_D3cold:
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	if (!error)
-		pci_dbg(dev, "power state changed by ACPI to %s\n",
-		        acpi_power_state_string(adev->power.state));
+	if (state == PCI_D3cold) {
+		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+				PM_QOS_FLAGS_ALL)
+			return -EBUSY;
+	}
+
+	error = acpi_device_set_power(adev, state_conv[state]);
+	if (error)
+		return error;
+
+	pci_dbg(dev, "power state changed by ACPI to %s\n",
+	        acpi_power_state_string(adev->power.state));
 
-	return error;
+	return 0;
 }
 
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)


