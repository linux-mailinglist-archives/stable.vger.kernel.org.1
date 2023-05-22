Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079770C8F8
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjEVToB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjEVTn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D45132
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 457CC62241
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D23C433D2;
        Mon, 22 May 2023 19:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784617;
        bh=0GXFjYVqZ0PZmO9tVgTtfCagheAJigcdVsSQDV6JnJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmodJkTli3VhxyjdrgEt6BVTjgWunxAQe4nwAzfjBWVY5AXo0+UEQe/xEAYe49+Wf
         ohySqQTJoV2z1asoGlvCMOD8f16jtDeOr0MHn2LN45TChxGzgOdsnhoBzHbeN7bdFa
         q0GQ6/zSsa/yofnTpvNQmNvwLJtGURvzLM6Ehiwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 141/364] Bluetooth: hci_bcm: Fall back to getting bdaddr from EFI if not set
Date:   Mon, 22 May 2023 20:07:26 +0100
Message-Id: <20230522190416.298675543@linuxfoundation.org>
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

[ Upstream commit 0d218c3642b9ccf71f44987cd03c19320f3bd918 ]

On some devices the BCM Bluetooth adapter does not have a valid bdaddr set.

btbcm.c currently sets HCI_QUIRK_INVALID_BDADDR to indicate when this is
the case. But this requires users to manual setup a btaddr, by doing e.g.:

btmgmt -i hci0 public-addr 'B0:F1:EC:82:1D:B3'

Which means that Bluetooth will not work out of the box on such devices.
To avoid this (where possible) hci_bcm sets: HCI_QUIRK_USE_BDADDR_PROPERTY
which tries to get the bdaddr from devicetree.

But this only works on devicetree platforms. On UEFI based platforms
there is a special Broadcom UEFI variable which when present contains
the devices bdaddr, just like how there is another UEFI variable which
contains wifi nvram contents including the wifi MAC address.

Add support for getting the bdaddr from this Broadcom UEFI variable,
so that Bluetooth will work OOTB for users on devices where this
UEFI variable is present.

This fixes Bluetooth not working on for example Asus T100HA 2-in-1s.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 47 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 43e98a598bd9a..de2ea589aa49b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+#include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/dmi.h>
@@ -34,6 +35,43 @@
 /* For kmalloc-ing the fw-name array instead of putting it on the stack */
 typedef char bcm_fw_name[BCM_FW_NAME_LEN];
 
+#ifdef CONFIG_EFI
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	efi_guid_t guid = EFI_GUID(0x74b00bd9, 0x805a, 0x4d61, 0xb5, 0x1f,
+				   0x43, 0x26, 0x81, 0x23, 0xd1, 0x13);
+	bdaddr_t efi_bdaddr, bdaddr;
+	efi_status_t status;
+	unsigned long len;
+	int ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	len = sizeof(efi_bdaddr);
+	status = efi.get_variable(L"BDADDR", &guid, NULL, &len, &efi_bdaddr);
+	if (status != EFI_SUCCESS)
+		return -ENXIO;
+
+	if (len != sizeof(efi_bdaddr))
+		return -EIO;
+
+	baswap(&bdaddr, &efi_bdaddr);
+
+	ret = btbcm_set_bdaddr(hdev, &bdaddr);
+	if (ret)
+		return ret;
+
+	bt_dev_info(hdev, "BCM: Using EFI device address (%pMR)", &bdaddr);
+	return 0;
+}
+#else
+static int btbcm_set_bdaddr_from_efi(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -87,9 +125,12 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
-		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
-			    &bda->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		/* Try falling back to BDADDR EFI variable */
+		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
+			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
+				    &bda->bdaddr);
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		}
 	}
 
 	kfree_skb(skb);
-- 
2.39.2



