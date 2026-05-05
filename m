Return-Path: <stable+bounces-244086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA8zNo7H+WkwEAMAu9opvQ
	(envelope-from <stable+bounces-244086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:33:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF204CB6D3
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08CC1300BB8F
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7133C182;
	Tue,  5 May 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G95MBjD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222A401A30
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977219; cv=none; b=Ek5Z1ESQcsVTvtgDGWDqmdgeWTqMe3yyJZJL1jA01mwbDs8utLO3EUn8xA3DlVVJ/NH71mbO+Wpks5nFBguBPkk3Lc+3qYYJjAZVuA8oipEJiveChu+jkRCJlJSs0Mmh9tQ0TxuK4mLMwXHDaFsGDH6neA7sIEzAWKK2vCMJozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977219; c=relaxed/simple;
	bh=0N95fGubilpI8uEquGocxbr8SKCFrEoKrzEXat/KUi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPPwxFhmfJLkglCUvUZX+qllqEoT1UeG75IQD89HzSx5BPLsLUiaW1P25lR3xLVnJnlESp/YmpyshfAj5nitw5bDSMw9wnuCLyb2aYC7/nQEZL7OUSJDHHIatsHCQKlgsSXUrozJ45g1bd9S2BeueJY7Lc8H/pe55CSUXwv1VoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G95MBjD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4C0C2BCB4;
	Tue,  5 May 2026 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977218;
	bh=0N95fGubilpI8uEquGocxbr8SKCFrEoKrzEXat/KUi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G95MBjD2o/sIDWgBDmBKA8pVqFvZbM9/+4TMd9V8GRPXhkxUo0n90To4SOcN9iQ5x
	 la9iOWEpfVLEgtpzAm1IS1rvr58f49NrmWUEVVuO/aI211LxoQEQv7wy3vyUUvjOVO
	 Gf9mfNz4S7g2VAPLQawHh8uOaaDupJ7zjBmD6hz0V9r8ADieOlFc/HeiWC+i6U36PZ
	 cgSRJSMIcozJspPYxSIRdnGZjupVd99kcbvnQ7uYRkjuMKsPklthyBw6APE/s5HwFU
	 yUDASRfEcnm+T/qCzsxgOGzk9iU+Jbhtgv5Znh348vXtPslGqv9E0lur0FTttHdoB4
	 QQZ76TNr8esOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] crypto: qat - fix firmware loading failure for GEN6 devices
Date: Tue,  5 May 2026 06:33:30 -0400
Message-ID: <20260505103330.596817-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505103330.596817-1-sashal@kernel.org>
References: <2026050339-trapped-replace-1e60@gregkh>
 <20260505103330.596817-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DF204CB6D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244086-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:email]

From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>

[ Upstream commit e7dcb722bb75bb3f3992f580a8728a794732fd7a ]

QAT GEN6 hardware requires a minimum 3 us delay during the acceleration
engine reset sequence to ensure the hardware fully settles.
Without this delay, the firmware load may fail intermittently.

Add a delay after placing the AE into reset and before clearing the reset,
matching the hardware requirements and ensuring stable firmware loading.
Earlier generations remain unaffected.

Fixes: 17fd7514ae68 ("crypto: qat - add qat_6xxx driver")
Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_accel_engine.c     | 7 +++++++
 .../crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h | 1 +
 drivers/crypto/intel/qat/qat_common/qat_hal.c              | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
index 4b5d0350fc2ef..4abbf8ade6270 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2014 - 2020 Intel Corporation */
+#include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "adf_cfg.h"
@@ -162,8 +163,14 @@ int adf_ae_stop(struct adf_accel_dev *accel_dev)
 static int adf_ae_reset(struct adf_accel_dev *accel_dev, int ae)
 {
 	struct adf_fw_loader_data *loader_data = accel_dev->fw_loader;
+	unsigned long reset_delay;
 
 	qat_hal_reset(loader_data->fw_loader);
+
+	reset_delay = loader_data->fw_loader->chip_info->reset_delay_us;
+	if (reset_delay)
+		fsleep(reset_delay);
+
 	if (qat_hal_clr_reset(loader_data->fw_loader))
 		return -EFAULT;
 
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
index 6887930c7995e..e74cafa95f1cc 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_loader_handle.h
@@ -27,6 +27,7 @@ struct icp_qat_fw_loader_chip_info {
 	int mmp_sram_size;
 	bool nn;
 	bool lm2lm3;
+	u16 reset_delay_us;
 	u32 lm_size;
 	u32 icp_rst_csr;
 	u32 icp_rst_mask;
diff --git a/drivers/crypto/intel/qat/qat_common/qat_hal.c b/drivers/crypto/intel/qat/qat_common/qat_hal.c
index 614400e7bb0ac..b4b75da68c200 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_hal.c
@@ -20,6 +20,7 @@
 #define RST_CSR_QAT_LSB			20
 #define RST_CSR_AE_LSB			0
 #define MC_TIMESTAMP_ENABLE		(0x1 << 7)
+#define MIN_RESET_DELAY_US		3
 
 #define IGNORE_W1C_MASK ((~(1 << CE_BREAKPOINT_BITPOS)) & \
 	(~(1 << CE_CNTL_STORE_PARITY_ERROR_BITPOS)) & \
@@ -713,8 +714,10 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 		handle->chip_info->wakeup_event_val = 0x80000000;
 		handle->chip_info->fw_auth = true;
 		handle->chip_info->css_3k = true;
-		if (handle->pci_dev->device == PCI_DEVICE_ID_INTEL_QAT_6XXX)
+		if (handle->pci_dev->device == PCI_DEVICE_ID_INTEL_QAT_6XXX) {
 			handle->chip_info->dual_sign = true;
+			handle->chip_info->reset_delay_us = MIN_RESET_DELAY_US;
+		}
 		handle->chip_info->tgroup_share_ustore = true;
 		handle->chip_info->fcu_ctl_csr = FCU_CONTROL_4XXX;
 		handle->chip_info->fcu_sts_csr = FCU_STATUS_4XXX;
-- 
2.53.0


