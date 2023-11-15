Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331F7ED63D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjKOVwm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343700AbjKOUzn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BFE6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364CC4E778;
        Wed, 15 Nov 2023 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081737;
        bh=EmkcRes27Bsk8roBatumesIFEilwOM69hp/G+SmaXME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7EPr9Oltdcrz2kkr/vW6OlSVbvlRF780vmX5PRaY+YOly66jnMLx1OXk/o2saQDF
         S8jc+uUUO6Gjqugm9qokFUQxgD7sTM0WLjBG8hoJCemNOZBGierM4DEB/vD3os/pY0
         9mxrYRj2H5nH8LK4dc7LQtJAqKv4qGMX26T2hp8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 094/191] crypto: qat - mask device capabilities with soft straps
Date:   Wed, 15 Nov 2023 15:46:09 -0500
Message-ID: <20231115204650.213350779@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 7b07ed5042c5d21467af5aa055f2b49b2e661a83 ]

Enable acceleration engines (AEs) and accelerators based on soft straps
and fuses. When looping with a number of AEs or accelerators, ignore the
ones that are disabled.

This patch is based on earlier work done by Conor McLoughlin.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 4e4e2ed22d50 ("crypto: qat - increase size of buffers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  | 34 +++++++++++++++----
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h  |  1 +
 drivers/crypto/qat/qat_c3xxx/adf_drv.c        |  6 ++--
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |  4 +--
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c      |  4 +--
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    | 34 +++++++++++++++----
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.h    |  1 +
 drivers/crypto/qat/qat_c62x/adf_drv.c         |  6 ++--
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       |  4 +--
 drivers/crypto/qat/qat_c62xvf/adf_drv.c       |  4 +--
 .../crypto/qat/qat_common/adf_accel_devices.h |  5 +--
 drivers/crypto/qat/qat_common/qat_hal.c       | 27 ++++++++-------
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   | 20 +++++++----
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c     |  4 +--
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |  4 +--
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c   |  4 +--
 16 files changed, 109 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index aee494d3da529..4b2f5aa833919 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -17,15 +17,33 @@ static struct adf_hw_device_class c3xxx_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) >> ADF_C3XXX_ACCELERATORS_REG_OFFSET &
-		ADF_C3XXX_ACCELERATORS_MASK;
+	u32 straps = self->straps;
+	u32 fuses = self->fuses;
+	u32 accel;
+
+	accel = ~(fuses | straps) >> ADF_C3XXX_ACCELERATORS_REG_OFFSET;
+	accel &= ADF_C3XXX_ACCELERATORS_MASK;
+
+	return accel;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) & ADF_C3XXX_ACCELENGINES_MASK;
+	u32 straps = self->straps;
+	u32 fuses = self->fuses;
+	unsigned long disabled;
+	u32 ae_disable;
+	int accel;
+
+	/* If an accel is disabled, then disable the corresponding two AEs */
+	disabled = ~get_accel_mask(self) & ADF_C3XXX_ACCELERATORS_MASK;
+	ae_disable = BIT(1) | BIT(0);
+	for_each_set_bit(accel, &disabled, ADF_C3XXX_MAX_ACCELERATORS)
+		straps |= ae_disable << (accel << 1);
+
+	return ~(fuses | straps) & ADF_C3XXX_ACCELENGINES_MASK;
 }
 
 static u32 get_num_accels(struct adf_hw_device_data *self)
@@ -109,11 +127,13 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
 	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_C3XXX_PMISC_BAR];
+	unsigned long accel_mask = hw_device->accel_mask;
+	unsigned long ae_mask = hw_device->ae_mask;
 	void __iomem *csr = misc_bar->virt_addr;
 	unsigned int val, i;
 
 	/* Enable Accel Engine error detection & correction */
-	for (i = 0; i < hw_device->get_num_aes(hw_device); i++) {
+	for_each_set_bit(i, &ae_mask, GET_MAX_ACCELENGINES(accel_dev)) {
 		val = ADF_CSR_RD(csr, ADF_C3XXX_AE_CTX_ENABLES(i));
 		val |= ADF_C3XXX_ENABLE_AE_ECC_ERR;
 		ADF_CSR_WR(csr, ADF_C3XXX_AE_CTX_ENABLES(i), val);
@@ -123,7 +143,7 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 	}
 
 	/* Enable shared memory error detection & correction */
-	for (i = 0; i < hw_device->get_num_accels(hw_device); i++) {
+	for_each_set_bit(i, &accel_mask, ADF_C3XXX_MAX_ACCELERATORS) {
 		val = ADF_CSR_RD(csr, ADF_C3XXX_UERRSSMSH(i));
 		val |= ADF_C3XXX_ERRSSMSH_EN;
 		ADF_CSR_WR(csr, ADF_C3XXX_UERRSSMSH(i), val);
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
index 8b5dd2c94ebfa..94097816f68ae 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
@@ -18,6 +18,7 @@
 #define ADF_C3XXX_SMIAPF1_MASK_OFFSET (0x3A000 + 0x30)
 #define ADF_C3XXX_SMIA0_MASK 0xFFFF
 #define ADF_C3XXX_SMIA1_MASK 0x1
+#define ADF_C3XXX_SOFTSTRAP_CSR_OFFSET 0x2EC
 /* Error detection and correction */
 #define ADF_C3XXX_AE_CTX_ENABLES(i) (i * 0x1000 + 0x20818)
 #define ADF_C3XXX_AE_MISC_CONTROL(i) (i * 0x1000 + 0x20960)
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index ed0e8e33fe4b3..da6e880269881 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -126,10 +126,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
 	pci_read_config_dword(pdev, ADF_DEVICE_FUSECTL_OFFSET,
 			      &hw_data->fuses);
+	pci_read_config_dword(pdev, ADF_C3XXX_SOFTSTRAP_CSR_OFFSET,
+			      &hw_data->straps);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 	/* If the device has no acceleration engines then ignore it. */
 	if (!hw_data->accel_mask || !hw_data->ae_mask ||
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index 9709f29b64540..26b13973f9ac9 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -11,12 +11,12 @@ static struct adf_hw_device_class c3xxxiov_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
 	return ADF_C3XXXIOV_ACCELERATORS_MASK;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
 	return ADF_C3XXXIOV_ACCELENGINES_MASK;
 }
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
index ea932b6c4534f..067ca5e17d387 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -119,8 +119,8 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_init_hw_data_c3xxxiov(accel_dev->hw_device);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 
 	/* Create dev top level debugfs entry */
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 844ad5ed33fcd..c0b5751e96821 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -22,15 +22,33 @@ static struct adf_hw_device_class c62x_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) >> ADF_C62X_ACCELERATORS_REG_OFFSET &
-			  ADF_C62X_ACCELERATORS_MASK;
+	u32 straps = self->straps;
+	u32 fuses = self->fuses;
+	u32 accel;
+
+	accel = ~(fuses | straps) >> ADF_C62X_ACCELERATORS_REG_OFFSET;
+	accel &= ADF_C62X_ACCELERATORS_MASK;
+
+	return accel;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) & ADF_C62X_ACCELENGINES_MASK;
+	u32 straps = self->straps;
+	u32 fuses = self->fuses;
+	unsigned long disabled;
+	u32 ae_disable;
+	int accel;
+
+	/* If an accel is disabled, then disable the corresponding two AEs */
+	disabled = ~get_accel_mask(self) & ADF_C62X_ACCELERATORS_MASK;
+	ae_disable = BIT(1) | BIT(0);
+	for_each_set_bit(accel, &disabled, ADF_C62X_MAX_ACCELERATORS)
+		straps |= ae_disable << (accel << 1);
+
+	return ~(fuses | straps) & ADF_C62X_ACCELENGINES_MASK;
 }
 
 static u32 get_num_accels(struct adf_hw_device_data *self)
@@ -119,11 +137,13 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
 	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_C62X_PMISC_BAR];
+	unsigned long accel_mask = hw_device->accel_mask;
+	unsigned long ae_mask = hw_device->ae_mask;
 	void __iomem *csr = misc_bar->virt_addr;
 	unsigned int val, i;
 
 	/* Enable Accel Engine error detection & correction */
-	for (i = 0; i < hw_device->get_num_aes(hw_device); i++) {
+	for_each_set_bit(i, &ae_mask, GET_MAX_ACCELENGINES(accel_dev)) {
 		val = ADF_CSR_RD(csr, ADF_C62X_AE_CTX_ENABLES(i));
 		val |= ADF_C62X_ENABLE_AE_ECC_ERR;
 		ADF_CSR_WR(csr, ADF_C62X_AE_CTX_ENABLES(i), val);
@@ -133,7 +153,7 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 	}
 
 	/* Enable shared memory error detection & correction */
-	for (i = 0; i < hw_device->get_num_accels(hw_device); i++) {
+	for_each_set_bit(i, &accel_mask, ADF_C62X_MAX_ACCELERATORS) {
 		val = ADF_CSR_RD(csr, ADF_C62X_UERRSSMSH(i));
 		val |= ADF_C62X_ERRSSMSH_EN;
 		ADF_CSR_WR(csr, ADF_C62X_UERRSSMSH(i), val);
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
index 88504d2bf30d5..a2e2961a21022 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
@@ -19,6 +19,7 @@
 #define ADF_C62X_SMIAPF1_MASK_OFFSET (0x3A000 + 0x30)
 #define ADF_C62X_SMIA0_MASK 0xFFFF
 #define ADF_C62X_SMIA1_MASK 0x1
+#define ADF_C62X_SOFTSTRAP_CSR_OFFSET 0x2EC
 /* Error detection and correction */
 #define ADF_C62X_AE_CTX_ENABLES(i) (i * 0x1000 + 0x20818)
 #define ADF_C62X_AE_MISC_CONTROL(i) (i * 0x1000 + 0x20960)
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index d8e7c9c255903..3da697a566ad7 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -126,10 +126,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &accel_pci_dev->revid);
 	pci_read_config_dword(pdev, ADF_DEVICE_FUSECTL_OFFSET,
 			      &hw_data->fuses);
+	pci_read_config_dword(pdev, ADF_C62X_SOFTSTRAP_CSR_OFFSET,
+			      &hw_data->straps);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 	/* If the device has no acceleration engines then ignore it. */
 	if (!hw_data->accel_mask || !hw_data->ae_mask ||
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 5e6909d6cfc65..ff5a57824eca4 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -11,12 +11,12 @@ static struct adf_hw_device_class c62xiov_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
 	return ADF_C62XIOV_ACCELERATORS_MASK;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
 	return ADF_C62XIOV_ACCELENGINES_MASK;
 }
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
index 6200ad448b119..51ea88c0b17d7 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -119,8 +119,8 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_init_hw_data_c62xiov(accel_dev->hw_device);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 
 	/* Create dev top level debugfs entry */
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 06952ece53d91..411a505e1f59f 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -104,8 +104,8 @@ struct adf_etr_ring_data;
 
 struct adf_hw_device_data {
 	struct adf_hw_device_class *dev_class;
-	u32 (*get_accel_mask)(u32 fuse);
-	u32 (*get_ae_mask)(u32 fuse);
+	u32 (*get_accel_mask)(struct adf_hw_device_data *self);
+	u32 (*get_ae_mask)(struct adf_hw_device_data *self);
 	u32 (*get_sram_bar_id)(struct adf_hw_device_data *self);
 	u32 (*get_misc_bar_id)(struct adf_hw_device_data *self);
 	u32 (*get_etr_bar_id)(struct adf_hw_device_data *self);
@@ -131,6 +131,7 @@ struct adf_hw_device_data {
 	const char *fw_name;
 	const char *fw_mmp_name;
 	u32 fuses;
+	u32 straps;
 	u32 accel_capabilities_mask;
 	u32 instance_id;
 	u16 accel_mask;
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/qat/qat_common/qat_hal.c
index b40e81e0088f0..76d8470651b85 100644
--- a/drivers/crypto/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/qat/qat_common/qat_hal.c
@@ -346,11 +346,12 @@ static void qat_hal_put_wakeup_event(struct icp_qat_fw_loader_handle *handle,
 
 static int qat_hal_check_ae_alive(struct icp_qat_fw_loader_handle *handle)
 {
+	unsigned long ae_mask = handle->hal_handle->ae_mask;
 	unsigned int base_cnt, cur_cnt;
 	unsigned char ae;
 	int times = MAX_RETRY_TIMES;
 
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		base_cnt = qat_hal_rd_ae_csr(handle, ae, PROFILE_COUNT);
 		base_cnt &= 0xffff;
 
@@ -384,6 +385,7 @@ int qat_hal_check_ae_active(struct icp_qat_fw_loader_handle *handle,
 
 static void qat_hal_reset_timestamp(struct icp_qat_fw_loader_handle *handle)
 {
+	unsigned long ae_mask = handle->hal_handle->ae_mask;
 	unsigned int misc_ctl;
 	unsigned char ae;
 
@@ -393,7 +395,7 @@ static void qat_hal_reset_timestamp(struct icp_qat_fw_loader_handle *handle)
 		SET_GLB_CSR(handle, MISC_CONTROL, misc_ctl &
 			    (~MC_TIMESTAMP_ENABLE));
 
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		qat_hal_wr_ae_csr(handle, ae, TIMESTAMP_LOW, 0);
 		qat_hal_wr_ae_csr(handle, ae, TIMESTAMP_HIGH, 0);
 	}
@@ -438,6 +440,7 @@ static int qat_hal_init_esram(struct icp_qat_fw_loader_handle *handle)
 #define SHRAM_INIT_CYCLES 2060
 int qat_hal_clr_reset(struct icp_qat_fw_loader_handle *handle)
 {
+	unsigned long ae_mask = handle->hal_handle->ae_mask;
 	unsigned int ae_reset_csr;
 	unsigned char ae;
 	unsigned int clk_csr;
@@ -464,7 +467,7 @@ int qat_hal_clr_reset(struct icp_qat_fw_loader_handle *handle)
 		goto out_err;
 
 	/* Set undefined power-up/reset states to reasonable default values */
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		qat_hal_wr_ae_csr(handle, ae, CTX_ENABLES,
 				  INIT_CTX_ENABLE_VALUE);
 		qat_hal_wr_indr_csr(handle, ae, ICP_QAT_UCLO_AE_ALL_CTX,
@@ -570,10 +573,11 @@ static void qat_hal_enable_ctx(struct icp_qat_fw_loader_handle *handle,
 
 static void qat_hal_clear_xfer(struct icp_qat_fw_loader_handle *handle)
 {
+	unsigned long ae_mask = handle->hal_handle->ae_mask;
 	unsigned char ae;
 	unsigned short reg;
 
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		for (reg = 0; reg < ICP_QAT_UCLO_MAX_GPR_REG; reg++) {
 			qat_hal_init_rd_xfer(handle, ae, 0, ICP_SR_RD_ABS,
 					     reg, 0);
@@ -585,6 +589,7 @@ static void qat_hal_clear_xfer(struct icp_qat_fw_loader_handle *handle)
 
 static int qat_hal_clear_gpr(struct icp_qat_fw_loader_handle *handle)
 {
+	unsigned long ae_mask = handle->hal_handle->ae_mask;
 	unsigned char ae;
 	unsigned int ctx_mask = ICP_QAT_UCLO_AE_ALL_CTX;
 	int times = MAX_RETRY_TIMES;
@@ -592,7 +597,7 @@ static int qat_hal_clear_gpr(struct icp_qat_fw_loader_handle *handle)
 	unsigned int savctx = 0;
 	int ret = 0;
 
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		csr_val = qat_hal_rd_ae_csr(handle, ae, AE_MISC_CONTROL);
 		csr_val &= ~(1 << MMC_SHARE_CS_BITPOS);
 		qat_hal_wr_ae_csr(handle, ae, AE_MISC_CONTROL, csr_val);
@@ -613,7 +618,7 @@ static int qat_hal_clear_gpr(struct icp_qat_fw_loader_handle *handle)
 		qat_hal_wr_ae_csr(handle, ae, CTX_SIG_EVENTS_ACTIVE, 0);
 		qat_hal_enable_ctx(handle, ae, ctx_mask);
 	}
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		/* wait for AE to finish */
 		do {
 			ret = qat_hal_wait_cycles(handle, ae, 20, 1);
@@ -654,6 +659,8 @@ int qat_hal_init(struct adf_accel_dev *accel_dev)
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	struct adf_bar *misc_bar =
 			&pci_info->pci_bars[hw_data->get_misc_bar_id(hw_data)];
+	unsigned long ae_mask = hw_data->ae_mask;
+	unsigned int csr_val = 0;
 	struct adf_bar *sram_bar;
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
@@ -689,9 +696,7 @@ int qat_hal_init(struct adf_accel_dev *accel_dev)
 	/* create AE objects */
 	handle->hal_handle->upc_mask = 0x1ffff;
 	handle->hal_handle->max_ustore = 0x4000;
-	for (ae = 0; ae < ICP_QAT_UCLO_MAX_AE; ae++) {
-		if (!(hw_data->ae_mask & (1 << ae)))
-			continue;
+	for_each_set_bit(ae, &ae_mask, ICP_QAT_UCLO_MAX_AE) {
 		handle->hal_handle->aes[ae].free_addr = 0;
 		handle->hal_handle->aes[ae].free_size =
 		    handle->hal_handle->max_ustore;
@@ -714,9 +719,7 @@ int qat_hal_init(struct adf_accel_dev *accel_dev)
 	}
 
 	/* Set SIGNATURE_ENABLE[0] to 0x1 in order to enable ALU_OUT csr */
-	for (ae = 0; ae < handle->hal_handle->ae_max_num; ae++) {
-		unsigned int csr_val = 0;
-
+	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		csr_val = qat_hal_rd_ae_csr(handle, ae, SIGNATURE_ENABLE);
 		csr_val |= 0x1;
 		qat_hal_wr_ae_csr(handle, ae, SIGNATURE_ENABLE, csr_val);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index b975c263446db..6a0d01103136f 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -24,15 +24,19 @@ static struct adf_hw_device_class dh895xcc_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) >> ADF_DH895XCC_ACCELERATORS_REG_OFFSET &
-			  ADF_DH895XCC_ACCELERATORS_MASK;
+	u32 fuses = self->fuses;
+
+	return ~fuses >> ADF_DH895XCC_ACCELERATORS_REG_OFFSET &
+			 ADF_DH895XCC_ACCELERATORS_MASK;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
-	return (~fuse) & ADF_DH895XCC_ACCELENGINES_MASK;
+	u32 fuses = self->fuses;
+
+	return ~fuses & ADF_DH895XCC_ACCELENGINES_MASK;
 }
 
 static u32 get_num_accels(struct adf_hw_device_data *self)
@@ -131,11 +135,13 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_device = accel_dev->hw_device;
 	struct adf_bar *misc_bar = &GET_BARS(accel_dev)[ADF_DH895XCC_PMISC_BAR];
+	unsigned long accel_mask = hw_device->accel_mask;
+	unsigned long ae_mask = hw_device->ae_mask;
 	void __iomem *csr = misc_bar->virt_addr;
 	unsigned int val, i;
 
 	/* Enable Accel Engine error detection & correction */
-	for (i = 0; i < hw_device->get_num_aes(hw_device); i++) {
+	for_each_set_bit(i, &ae_mask, GET_MAX_ACCELENGINES(accel_dev)) {
 		val = ADF_CSR_RD(csr, ADF_DH895XCC_AE_CTX_ENABLES(i));
 		val |= ADF_DH895XCC_ENABLE_AE_ECC_ERR;
 		ADF_CSR_WR(csr, ADF_DH895XCC_AE_CTX_ENABLES(i), val);
@@ -145,7 +151,7 @@ static void adf_enable_error_correction(struct adf_accel_dev *accel_dev)
 	}
 
 	/* Enable shared memory error detection & correction */
-	for (i = 0; i < hw_device->get_num_accels(hw_device); i++) {
+	for_each_set_bit(i, &accel_mask, ADF_DH895XCC_MAX_ACCELERATORS) {
 		val = ADF_CSR_RD(csr, ADF_DH895XCC_UERRSSMSH(i));
 		val |= ADF_DH895XCC_ERRSSMSH_EN;
 		ADF_CSR_WR(csr, ADF_DH895XCC_UERRSSMSH(i), val);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index ecb4f6f20e22b..d7941bc2bafd6 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -128,8 +128,8 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			      &hw_data->fuses);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 	/* If the device has no acceleration engines then ignore it. */
 	if (!hw_data->accel_mask || !hw_data->ae_mask ||
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index fc4cf141b1dea..7930e4c7883db 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -11,12 +11,12 @@ static struct adf_hw_device_class dh895xcciov_class = {
 	.instances = 0
 };
 
-static u32 get_accel_mask(u32 fuse)
+static u32 get_accel_mask(struct adf_hw_device_data *self)
 {
 	return ADF_DH895XCCIOV_ACCELERATORS_MASK;
 }
 
-static u32 get_ae_mask(u32 fuse)
+static u32 get_ae_mask(struct adf_hw_device_data *self)
 {
 	return ADF_DH895XCCIOV_ACCELENGINES_MASK;
 }
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
index 737508ded37b4..29999da716cc9 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -119,8 +119,8 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adf_init_hw_data_dh895xcciov(accel_dev->hw_device);
 
 	/* Get Accelerators and Accelerators Engines masks */
-	hw_data->accel_mask = hw_data->get_accel_mask(hw_data->fuses);
-	hw_data->ae_mask = hw_data->get_ae_mask(hw_data->fuses);
+	hw_data->accel_mask = hw_data->get_accel_mask(hw_data);
+	hw_data->ae_mask = hw_data->get_ae_mask(hw_data);
 	accel_pci_dev->sku = hw_data->get_sku(hw_data);
 
 	/* Create dev top level debugfs entry */
-- 
2.42.0



