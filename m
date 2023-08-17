Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384C577F7FC
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbjHQNoF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351618AbjHQNny (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:43:54 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CE2D4A
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:43:51 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 713C72F2022F; Thu, 17 Aug 2023 13:43:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
        by air.basealt.ru (Postfix) with ESMTPSA id A327F2F20233;
        Thu, 17 Aug 2023 13:43:39 +0000 (UTC)
From:   Alexander Ofitserov <oficerovas@altlinux.org>
To:     oficerovas@altlinux.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     stable@vger.kernel.org
Subject: [PATCH RESEND 1/3] i2c: i801: Add support for Intel Alder Lake PCH
Date:   Thu, 17 Aug 2023 16:43:34 +0300
Message-Id: <20230817134336.965020-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20230817134336.965020-1-oficerovas@altlinux.org>
References: <20230817134336.965020-1-oficerovas@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Add PCI ID of SMBus controller on Intel Alder Lake PCH-P and PCH-M

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 drivers/i2c/busses/i2c-i801.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 45682d30d70567..8ca530ef3ba6f6 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -72,6 +72,8 @@
  * Jasper Lake (SOC)		0x4da3	32	hard	yes	yes	yes
  * Comet Lake-V (PCH)		0xa3a3	32	hard	yes	yes	yes
  * Alder Lake-S (PCH)		0x7aa3	32	hard	yes	yes	yes
+ * Alder Lake-P (PCH)		0x51a3	32	hard	yes	yes	yes
+ * Alder Lake-M (PCH)		0x54a3	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -228,6 +230,8 @@
 #define PCI_DEVICE_ID_INTEL_TIGERLAKE_H_SMBUS		0x43a3
 #define PCI_DEVICE_ID_INTEL_ELKHART_LAKE_SMBUS		0x4b23
 #define PCI_DEVICE_ID_INTEL_JASPER_LAKE_SMBUS		0x4da3
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_P_SMBUS		0x51a3
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_M_SMBUS		0x54a3
 #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_S_SMBUS		0x7aa3
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS		0x8c22
@@ -1080,6 +1084,8 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TIGERLAKE_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_JASPER_LAKE_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_S_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_P_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ALDER_LAKE_M_SMBUS) },
 	{ 0, }
 };
 
@@ -1769,6 +1775,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_JASPER_LAKE_SMBUS:
 	case PCI_DEVICE_ID_INTEL_EBG_SMBUS:
 	case PCI_DEVICE_ID_INTEL_ALDER_LAKE_S_SMBUS:
+	case PCI_DEVICE_ID_INTEL_ALDER_LAKE_P_SMBUS:
+	case PCI_DEVICE_ID_INTEL_ALDER_LAKE_M_SMBUS:
 		priv->features |= FEATURE_BLOCK_PROC;
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
-- 
2.33.8

