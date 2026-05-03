Return-Path: <stable+bounces-242665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGuAMi4192nQdQIAu9opvQ
	(envelope-from <stable+bounces-242665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:44:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9F4B5552
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 218883006F0A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517023112DA;
	Sun,  3 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtXmMAHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9440DFA3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808682; cv=none; b=s2whmvsLAnlHlLDB47MzCRqBBk66tP0vMfXD+lC9qXeFoGOHrhY+JKmKex7mWVMra89Z8NciOLn8IyWuLTxGGQkwusllkjBZ6qGAAcv1KtBJDrKDcB+R/cp/hLfjhoe7C0kau5mNkyPquDrevIHzH9wuYiSKiNFRnzvyP/ebUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808682; c=relaxed/simple;
	bh=3W5sIhfkQy/RRM71z/OJ4D6V7Yx9+4amOUXFFPRQWoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AsVGjFErWegkZzR1n7eiATgeDK7UC1KeggX/yCjWyk9NRGX6EVb1lEkp5p9rXvlrlROA4AgRznhImdWMhTBcSW4qg6/cIKICufH6enMfioSwHA5tdqvTVwUl36W9V3OT5cd4391ZSsXk4pDJdBoFgtMIbht6IFeG6629mAwVlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtXmMAHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851A7C2BCB4;
	Sun,  3 May 2026 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808681;
	bh=3W5sIhfkQy/RRM71z/OJ4D6V7Yx9+4amOUXFFPRQWoM=;
	h=Subject:To:Cc:From:Date:From;
	b=QtXmMAHjUqWyqFB2DbXbJKgQCruXBtq+8fzoro7EgRpD9mfn1iLic48HKhPoj6Stf
	 Qxc+hF5W+NW7iBuM0CYsMSUyKPE4JnnUblphDfOCS/LPYK+yp+JiUhEMMIYVi4r5+F
	 7hq/gBSHjlo3g40pATtUsEPryFk3r0H/tOU/P/zQ=
Subject: FAILED: patch "[PATCH] crypto: qat - fix firmware loading failure for GEN6 devices" failed to apply to 7.0-stable tree
To: suman.kumar.chakraborty@intel.com,andriy.shevchenko@intel.com,giovanni.cabiddu@intel.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:44:39 +0200
Message-ID: <2026050339-tumble-sponge-5d2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EE9F4B5552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242665-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,intel.com:email,gregkh:email]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x e7dcb722bb75bb3f3992f580a8728a794732fd7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050339-tumble-sponge-5d2f@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7dcb722bb75bb3f3992f580a8728a794732fd7a Mon Sep 17 00:00:00 2001
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Date: Thu, 5 Mar 2026 08:58:59 +0000
Subject: [PATCH] crypto: qat - fix firmware loading failure for GEN6 devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c b/drivers/crypto/intel/qat/qat_common/adf_accel_engine.c
index f9f1018a2823..09d4f547e082 100644
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
index 6887930c7995..e74cafa95f1c 100644
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
index 0f5a2690690a..1c3d1311f1c7 100644
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


