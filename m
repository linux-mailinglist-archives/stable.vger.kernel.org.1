Return-Path: <stable+bounces-172313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A71B30F72
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBCEAC6568
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F92E6136;
	Fri, 22 Aug 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aafrRXOw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60B2E6138
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845106; cv=none; b=e83stoLfaQQx4I856zqsFgBHEFHlU6reKT2d9+o+CzzbjwXqjFPIr7hJvw6cNmVcVXO4FJp8BEBFKJYwhsjOP1XodDbsU4wd4ytYyS/DQ02ChUUxfy3r/So9D33YgFq09LQyCbT4OalCdgupKfPj0DVMRYWP7RWYOtK7/eI94uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845106; c=relaxed/simple;
	bh=fR7D1D13Jc4tSwyAaMxowAjstd9X2F2VpGt0cC5x6iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZZn9vO43HBthd5vVHzs8aTpGz6YUmU+WKQ+1c6BMTgZcinoN9zc4XTrLlnHtiEoLIspzeBMCUZNk1dpMGvWj5nWuTro8xc4/nN7zH8uvE3D/tV9Sfn9tg+djKmCwYbp2mJ+iKY/Tsm95fWsuZTrm1TRZaAhdmCvOPDdz7y2/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aafrRXOw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755845105; x=1787381105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fR7D1D13Jc4tSwyAaMxowAjstd9X2F2VpGt0cC5x6iI=;
  b=aafrRXOwO67fcQ0AaK3hSytsndgknm7KUl7wYkoNAgFa3dxNS4vv8TpJ
   jJh42ESZmHU1bKsv60LOJj/5vlKtQyQh4lu7eoxlZgmetqIgrobq8xuxe
   uwPpi8sMWPsKkde2FpBDbDgBoxXaChjXCz8olL0BOI4Oag0986Mwjv0DX
   Ggo5KPoavtJ3v+hvUGSBjjJPB6ku49uZ5VxnrqFymapx4Tn1lN7hW7wiV
   UyWw+Q7uZTFaiKXsEnZ269lofBQJf6AMJ0uhl++Q8U1hb1T1pajZdevMj
   zTDXez1Q0goL2mFs82oCCTin8IAeUGwqdKzrBpD6m8ui89ORE0O9oiqEg
   Q==;
X-CSE-ConnectionGUID: lFAEzMhGStaamZbj3UWPEg==
X-CSE-MsgGUID: N8ND4v0EQAuLcBTrsHF6ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80748147"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80748147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:45:04 -0700
X-CSE-ConnectionGUID: R3spbsXlTjeajaFGRjFawQ==
X-CSE-MsgGUID: Dn7fHumcTTmh9JiRWZjpnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173906060"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.245.244.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:45:02 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Martin K Petersen <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Archana Patni <archana.patni@intel.com>
Subject: [PATCH 5.15.y 1/2] scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers
Date: Fri, 22 Aug 2025 09:44:26 +0300
Message-ID: <20250822064427.139229-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

From: Archana Patni <archana.patni@intel.com>

commit 4428ddea832cfdb63e476eb2e5c8feb5d36057fe upstream.

UFSHCD core disables the UIC completion interrupt when issuing UIC
hibernation commands, and re-enables it afterwards if it was enabled to
start with, refer ufshcd_uic_pwr_ctrl(). For Intel MTL-like host
controllers, accessing the register to re-enable the interrupt disrupts
the state transition.

Use hibern8_notify variant operation to disable the interrupt during the
entire hibernation, thereby preventing the disruption.

Fixes: 4049f7acef3e ("scsi: ufs: ufs-pci: Add support for Intel MTL")
Cc: stable@vger.kernel.org
Signed-off-by: Archana Patni <archana.patni@intel.com>
Link: https://lore.kernel.org/r/20250723165856.145750-2-adrian.hunter@intel.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd-pci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
index 0920530a72d2..11071c132c1d 100644
--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -203,6 +203,32 @@ static int ufs_intel_lkf_apply_dev_quirks(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufs_intel_ctrl_uic_compl(struct ufs_hba *hba, bool enable)
+{
+	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+
+	if (enable)
+		set |= UIC_COMMAND_COMPL;
+	else
+		set &= ~UIC_COMMAND_COMPL;
+	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
+}
+
+static void ufs_intel_mtl_h8_notify(struct ufs_hba *hba,
+				    enum uic_cmd_dme cmd,
+				    enum ufs_notify_change_status status)
+{
+	/*
+	 * Disable UIC COMPL INTR to prevent access to UFSHCI after
+	 * checking HCS.UPMCRS
+	 */
+	if (status == PRE_CHANGE && cmd == UIC_CMD_DME_HIBER_ENTER)
+		ufs_intel_ctrl_uic_compl(hba, false);
+
+	if (status == POST_CHANGE && cmd == UIC_CMD_DME_HIBER_EXIT)
+		ufs_intel_ctrl_uic_compl(hba, true);
+}
+
 #define INTEL_ACTIVELTR		0x804
 #define INTEL_IDLELTR		0x808
 
@@ -476,6 +502,7 @@ static struct ufs_hba_variant_ops ufs_intel_mtl_hba_vops = {
 	.init			= ufs_intel_mtl_init,
 	.exit			= ufs_intel_common_exit,
 	.hce_enable_notify	= ufs_intel_hce_enable_notify,
+	.hibern8_notify		= ufs_intel_mtl_h8_notify,
 	.link_startup_notify	= ufs_intel_link_startup_notify,
 	.resume			= ufs_intel_resume,
 	.device_reset		= ufs_intel_device_reset,
-- 
2.48.1


