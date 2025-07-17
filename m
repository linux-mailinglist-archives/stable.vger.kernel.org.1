Return-Path: <stable+bounces-163291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDCAB092D1
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7316D7BB6A8
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569962FE327;
	Thu, 17 Jul 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wus+2daK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF2FD89C
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772145; cv=none; b=IZUcQrut9fnl6RcvAjRnwn2D+GTKvXyT3UKLh/I3633XbjRYDcJ6j/3ODp6dxOoSMlA8Oo3CHLhijl9R1CgjlQx7kwQGH57tgxvlhkVkkG3DFt1QOsW6sfwxuubLzt2nRP7zDNQQ1fw0znxvFOcPhvECW/jTiy870FrxfOFba0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772145; c=relaxed/simple;
	bh=8cnDzIJzgTRiwG8fdIIPSgdAcu9mXSKSEJFj9fWFySQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S97qy3a3kYHP1uBzP4SwYm96XMLLW7TUTC7oin7KT38QVKwAhNsx3mS+Ayd7+Q3Z8+UfRITFP2aP9QuxLCtKK1TUu3aKxVQLxGXM9VwKuaQtn1xWMzPArYz26yIZq6Rr3/7gGw9WONNol5H2xmguwsmeUqODw88+cjiY4Oc3NkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wus+2daK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752772143; x=1784308143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8cnDzIJzgTRiwG8fdIIPSgdAcu9mXSKSEJFj9fWFySQ=;
  b=Wus+2daK8Q80HGxa6hNIZSoR0Nif85bv8lOuk3hpoL4L/ln/hCA1K33B
   Dn9BJ/CwAYJkBAGqGl/SIWm9OLMNE85IwGGqTFJlx1EKDxltg/PiziJxS
   6o5N+RcXjyfDjZyTCdLYlUAquNLykAuXqAOipug4MMhAi+/cgXFOTazcp
   MyQD2Hy+nyXoSs5SVdHh2zd7e7JYZ2DnVXbFWZGPtYtEnX+wxRORDrzeJ
   jH1cP2Sslv5+4n4gs+riFlMuSUr7qnAzTNSQ9/K/UvIN466aNK9Hk/tRr
   ozVSJayqh1o8oRcuV2jNfo5qxkQUTqR4JfpHmF9NLWQ6DNmUIsqJxYdSO
   A==;
X-CSE-ConnectionGUID: ov208DO7TB+VlsmvHU02TA==
X-CSE-MsgGUID: LOUYRRn8Rw638WrnS53q3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66407738"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66407738"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:09:02 -0700
X-CSE-ConnectionGUID: oGXGu0n3RpqJB0VQfHk3jw==
X-CSE-MsgGUID: yvSkEszkSjq9HF5GlCONsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="163384075"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.223.204])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jul 2025 10:09:00 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Date: Thu, 17 Jul 2025 18:06:38 +0100
Message-ID: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

[ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]

The 4xxx drivers hardcode the ring to service mapping. However, when
additional configurations where added to the driver, the mappings were
not updated. This implies that an incorrect mapping might be reported
through pfvf for certain configurations.

This is a backport of the upstream commit with modifications, as the
original patch does not apply cleanly to kernel v6.1.x. The logic has
been simplified to reflect the limited configurations of the QAT driver
in this version: crypto-only and compression.

Instead of dynamically computing the ring to service mappings, these are
now hardcoded to simplify the backport.

Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: <stable@vger.kernel.org> # 6.1.x
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Tested-by: Ahsan Atta <ahsan.atta@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    | 13 +++++++++++++
 drivers/crypto/qat/qat_common/adf_accel_devices.h |  1 +
 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h  |  6 ++++++
 drivers/crypto/qat/qat_common/adf_init.c          |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index fda5f699ff57..65b52c692add 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -297,6 +297,18 @@ static char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num)
 	return NULL;
 }
 
+static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
+{
+	switch (get_service_enabled(accel_dev)) {
+	case SVC_CY:
+		return ADF_GEN4_DEFAULT_RING_TO_SRV_MAP;
+	case SVC_DC:
+		return ADF_GEN4_DEFAULT_RING_TO_SRV_MAP_DC;
+	}
+
+	return 0;
+}
+
 static u32 uof_get_ae_mask(struct adf_accel_dev *accel_dev, u32 obj_num)
 {
 	switch (get_service_enabled(accel_dev)) {
@@ -353,6 +365,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->uof_get_ae_mask = uof_get_ae_mask;
 	hw_data->set_msix_rttable = set_msix_default_rttable;
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
+	hw_data->get_ring_to_svc_map = get_ring_to_svc_map;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
 	hw_data->enable_pm = adf_gen4_enable_pm;
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index ad01d99e6e2b..7993d0f82dea 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -176,6 +176,7 @@ struct adf_hw_device_data {
 	void (*get_arb_info)(struct arb_info *arb_csrs_info);
 	void (*get_admin_info)(struct admin_info *admin_csrs_info);
 	enum dev_sku_info (*get_sku)(struct adf_hw_device_data *self);
+	u16 (*get_ring_to_svc_map)(struct adf_accel_dev *accel_dev);
 	int (*alloc_irq)(struct adf_accel_dev *accel_dev);
 	void (*free_irq)(struct adf_accel_dev *accel_dev);
 	void (*enable_error_correction)(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
index 4fb4b3df5a18..5e653ec755e6 100644
--- a/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/qat/qat_common/adf_gen4_hw_data.h
@@ -95,6 +95,12 @@ do { \
 		   ADF_RING_BUNDLE_SIZE * (bank) + \
 		   ADF_RING_CSR_RING_SRV_ARB_EN, (value))
 
+#define ADF_GEN4_DEFAULT_RING_TO_SRV_MAP_DC \
+	(COMP << ADF_CFG_SERV_RING_PAIR_0_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_1_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_2_SHIFT | \
+	 COMP << ADF_CFG_SERV_RING_PAIR_3_SHIFT)
+
 /* Default ring mapping */
 #define ADF_GEN4_DEFAULT_RING_TO_SRV_MAP \
 	(ASYM << ADF_CFG_SERV_RING_PAIR_0_SHIFT | \
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 2e3481270c4b..49f07584f8c9 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -95,6 +95,9 @@ int adf_dev_init(struct adf_accel_dev *accel_dev)
 		return -EFAULT;
 	}
 
+	if (hw_data->get_ring_to_svc_map)
+		hw_data->ring_to_svc_map = hw_data->get_ring_to_svc_map(accel_dev);
+
 	if (adf_ae_init(accel_dev)) {
 		dev_err(&GET_DEV(accel_dev),
 			"Failed to initialise Acceleration Engine\n");
-- 
2.50.0


