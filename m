Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD577F7FF
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbjHQNoG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351620AbjHQNny (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:43:54 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5C2724
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:43:52 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 02C8A2F20231; Thu, 17 Aug 2023 13:43:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
        by air.basealt.ru (Postfix) with ESMTPSA id B43322F20237;
        Thu, 17 Aug 2023 13:43:39 +0000 (UTC)
From:   Alexander Ofitserov <oficerovas@altlinux.org>
To:     oficerovas@altlinux.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org
Subject: [RESEND 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices IDs
Date:   Thu, 17 Aug 2023 16:43:35 +0300
Message-Id: <20230817134336.965020-3-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20230817134336.965020-1-oficerovas@altlinux.org>
References: <20230817134336.965020-1-oficerovas@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Intel Alder Lake PCH has the same LPSS as Intel Broxton.
Add the new IDs to the list of supported devices.

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 drivers/mfd/intel-lpss-pci.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 2d7c588ef1edaa..dc0292aa2e6e42 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -277,6 +277,32 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4dea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4deb), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&spt_info },
+	/* ADL-P */
+	{ PCI_VDEVICE(INTEL, 0x51a8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x51a9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x51c5), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51c6), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51c7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x51e8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51e9), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51eb), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&bxt_info },
+	/* ADL-M */
+	{ PCI_VDEVICE(INTEL, 0x54a8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54a9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x54c5), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54c6), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54c7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54e8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54e9), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54ea), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54eb), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&bxt_info },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5aac), (kernel_ulong_t)&apl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x5aae), (kernel_ulong_t)&apl_i2c_info },
@@ -293,6 +319,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* ADL-S */
+	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7acc), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7acd), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7ace), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7acf), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7adc), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.33.8

