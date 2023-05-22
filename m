Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545C70C9F4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjEVTx3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjEVTx2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFBC95
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEBC762136
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E8C433EF;
        Mon, 22 May 2023 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785206;
        bh=QrT6yHN1YKQQilyQkgDo4uxXBuryL+F+8q2gUGqTnqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A70cGGoRZcvyu8x8rVQTclg4fiwdAbwJmzsn7HoUBDqKB98AidGvbuD2nrUK5IQfD
         Ip6K/RtxfGtr3ZeQWjsxjn6j9dOOp0t9KsOYjNV2dieDhxTu4rkww/LkGD2brJWzOF
         JRc9z/myqLHWQMDFX9Vnw0yArwUHB0LK0aLMXQTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix <nimrod4garoa@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.3 316/364] wifi: brcmfmac: Check for probe() id argument being NULL
Date:   Mon, 22 May 2023 20:10:21 +0100
Message-Id: <20230522190420.675315841@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 60fc756fc8e6954a5618eecac73b255d651602e4 upstream.

The probe() id argument may be NULL in 2 scenarios:

1. brcmf_pcie_pm_leave_D3() calling brcmf_pcie_probe() to reprobe
   the device.

2. If a user tries to manually bind the driver from sysfs then the sdio /
   pcie / usb probe() function gets called with NULL as id argument.

1. Is being hit by users causing the following oops on resume and causing
wifi to stop working:

BUG: kernel NULL pointer dereference, address: 0000000000000018
<snip>
Hardware name: Dell Inc. XPS 13 9350/0PWNCR, BIDS 1.13.0 02/10/2020
Workgueue: events_unbound async_run_entry_fn
RIP: 0010:brcmf_pcie_probe+Ox16b/0x7a0 [brcmfmac]
<snip>
Call Trace:
 <TASK>
 brcmf_pcie_pm_leave_D3+0xc5/8x1a0 [brcmfmac be3b4cefca451e190fa35be8f00db1bbec293887]
 ? pci_pm_resume+0x5b/0xf0
 ? pci_legacy_resume+0x80/0x80
 dpm_run_callback+0x47/0x150
 device_resume+0xa2/0x1f0
 async_resume+0x1d/0x30
<snip>

Fix this by checking for id being NULL.

In the PCI and USB cases try a manual lookup of the id so that manually
binding the driver through sysfs and more importantly brcmf_pcie_probe()
on resume will work.

For the SDIO case there is no helper to do a manual sdio_device_id lookup,
so just directly error out on a NULL id there.

Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
Reported-by: Felix <nimrod4garoa@gmail.com>
Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230510141856.46532-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |    5 +++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   |   11 +++++++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    |   11 +++++++++++
 3 files changed, 27 insertions(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1039,6 +1039,11 @@ static int brcmf_ops_sdio_probe(struct s
 	struct brcmf_sdio_dev *sdiodev;
 	struct brcmf_bus *bus_if;
 
+	if (!id) {
+		dev_err(&func->dev, "Error no sdio_device_id passed for %x:%x\n", func->vendor, func->device);
+		return -ENODEV;
+	}
+
 	brcmf_dbg(SDIO, "Enter\n");
 	brcmf_dbg(SDIO, "Class=%x\n", func->class);
 	brcmf_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2378,6 +2378,9 @@ static void brcmf_pcie_debugfs_create(st
 }
 #endif
 
+/* Forward declaration for pci_match_id() call */
+static const struct pci_device_id brcmf_pcie_devid_table[];
+
 static int
 brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -2388,6 +2391,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, c
 	struct brcmf_core *core;
 	struct brcmf_bus *bus;
 
+	if (!id) {
+		id = pci_match_id(brcmf_pcie_devid_table, pdev);
+		if (!id) {
+			pci_err(pdev, "Error could not find pci_device_id for %x:%x\n", pdev->vendor, pdev->device);
+			return -ENODEV;
+		}
+	}
+
 	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
 
 	ret = -ENOMEM;
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1331,6 +1331,9 @@ brcmf_usb_disconnect_cb(struct brcmf_usb
 	brcmf_usb_detach(devinfo);
 }
 
+/* Forward declaration for usb_match_id() call */
+static const struct usb_device_id brcmf_usb_devid_table[];
+
 static int
 brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
@@ -1342,6 +1345,14 @@ brcmf_usb_probe(struct usb_interface *in
 	u32 num_of_eps;
 	u8 endpoint_num, ep;
 
+	if (!id) {
+		id = usb_match_id(intf, brcmf_usb_devid_table);
+		if (!id) {
+			dev_err(&intf->dev, "Error could not find matching usb_device_id\n");
+			return -ENODEV;
+		}
+	}
+
 	brcmf_dbg(USB, "Enter 0x%04x:0x%04x\n", id->idVendor, id->idProduct);
 
 	devinfo = kzalloc(sizeof(*devinfo), GFP_ATOMIC);


