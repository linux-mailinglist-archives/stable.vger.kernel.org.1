Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D657ECC1B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjKOT07 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjKOT0n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A819E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA3FC433C7;
        Wed, 15 Nov 2023 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076399;
        bh=E9bnvL+ZVJfiS4d8mVoBsPBEtbrz95K5Yuh4g/QelZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWoZa2DkKcCzLZ4pu74LCKTLRcSeLW0RfggXqH/vqim7zajIvsDa4iWw4OQNp0dyB
         RTAYxC2o9DDjj+2NU4RDf0VhGLWznE/6/AfrtMQK99yE+TdFq4EKQ0nLN7Cwz3ShF5
         fMY7Zp/jYvbUHYU3FKN5pvk6smDPz5Os6ih/KUg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 250/550] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
Date:   Wed, 15 Nov 2023 14:13:54 -0500
Message-ID: <20231115191618.020258876@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

[ Upstream commit 2c269f42d0f382743ab230308b836ffe5ae9b2ae ]

Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
the table is filled. Then it disables INTx just before clearing MASKALL
bit. Currently this approach is rejected by xen-pciback.
According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).

Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
applies to three places:
 - checking currently enabled interrupts type,
 - transition to MSI/MSI-X - where INTx would be implicitly disabled,
 - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
   enabled, as device should consider INTx disabled anyway in that case

Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20231016131348.1734721-1-marmarek@invisiblethingslab.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
 .../xen/xen-pciback/conf_space_capability.c   |  8 ++++++-
 drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 059de92aea7d0..d47eee6c51435 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 	u16 val;
 	int ret = 0;
 
-	err = pci_read_config_word(dev, PCI_COMMAND, &val);
-	if (err)
-		return err;
-	if (!(val & PCI_COMMAND_INTX_DISABLE))
-		ret |= INTERRUPT_TYPE_INTX;
-
 	/*
 	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
 	 * bypassing the pci_*msi* functions, by the qemu.
@@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 		if (val & PCI_MSIX_FLAGS_ENABLE)
 			ret |= INTERRUPT_TYPE_MSIX;
 	}
+
+	/*
+	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
+	 * so check for INTx only when both are disabled.
+	 */
+	if (!ret) {
+		err = pci_read_config_word(dev, PCI_COMMAND, &val);
+		if (err)
+			return err;
+		if (!(val & PCI_COMMAND_INTX_DISABLE))
+			ret |= INTERRUPT_TYPE_INTX;
+	}
+
 	return ret ?: INTERRUPT_TYPE_NONE;
 }
 
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 097316a741268..1948a9700c8fa 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -236,10 +236,16 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
 		return PCIBIOS_SET_FAILED;
 
 	if (new_value & field_config->enable_bit) {
-		/* don't allow enabling together with other interrupt types */
+		/*
+		 * Don't allow enabling together with other interrupt type, but do
+		 * allow enabling MSI(-X) while INTx is still active to please Linuxes
+		 * MSI(-X) startup sequence. It is safe to do, as according to PCI
+		 * spec, device with enabled MSI(-X) shouldn't use INTx.
+		 */
 		int int_type = xen_pcibk_get_interrupt_type(dev);
 
 		if (int_type == INTERRUPT_TYPE_NONE ||
+		    int_type == INTERRUPT_TYPE_INTX ||
 		    int_type == field_config->int_type)
 			goto write;
 		return PCIBIOS_SET_FAILED;
diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 981435103af1a..fc03326459664 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -104,24 +104,9 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 		pci_clear_mwi(dev);
 	}
 
-	if (dev_data && dev_data->allow_interrupt_control) {
-		if ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE) {
-			if (value & PCI_COMMAND_INTX_DISABLE) {
-				pci_intx(dev, 0);
-			} else {
-				/* Do not allow enabling INTx together with MSI or MSI-X. */
-				switch (xen_pcibk_get_interrupt_type(dev)) {
-				case INTERRUPT_TYPE_NONE:
-					pci_intx(dev, 1);
-					break;
-				case INTERRUPT_TYPE_INTX:
-					break;
-				default:
-					return PCIBIOS_SET_FAILED;
-				}
-			}
-		}
-	}
+	if (dev_data && dev_data->allow_interrupt_control &&
+	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
+		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.42.0



