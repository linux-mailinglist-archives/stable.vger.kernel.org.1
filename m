Return-Path: <stable+bounces-69266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF897953F2D
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 03:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755091F24842
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAA729CFE;
	Fri, 16 Aug 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgacoNso"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7944AEE6
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773416; cv=none; b=bG0EZEWaqxO2gOC9kJbTAzXQwIt1iE5dM+5wR1y2boDS2PlA5bmWDz7iAO0SvNQk6zWxKHIh/+V7MePXKVbeOnd4veGMnIaxoBFRl3YHufu8lOLkU4BD61LXd4B5i2P1vmtvMGNaECcY8Q9wTWIiSd1uTstxohiksqtxs1czgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773416; c=relaxed/simple;
	bh=xJDx/MLKp7yzOS0c4b90+3aVs9d+yiU+8kqmSzvYf5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBFNv2iD2pH7XOYd8H8bkjI1MIfGs5NQ+uq7//xjMe3ZR6KDIxBDq0MYtSP6CumQ/8nL6RlDDrllZkqoJiUzlfT6cjg6fZ/fgWvxFKkNc/ie7HiN1Wur1nCJyLa+pue5NoZ6MLUJ+N9xflRzkAWa/X98OngXQHRig83k1DLF30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgacoNso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB25DC32786
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723773416;
	bh=xJDx/MLKp7yzOS0c4b90+3aVs9d+yiU+8kqmSzvYf5g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JgacoNsodXim+eNuwnj9Kya54yLMGHq0ESIEtQ24lf/EbrNww2USP6vopDz6bOTOB
	 6ufG8sJBnbDN2AJnzMO5FMZfr7CRfrSpN/GErptZbYMrLdc8f/q75vmLIeSm5xWSHP
	 Ff4EIJKUXvMp/6Jjv0jCWt9A1pH0fu8hN0kNRjKWML44CjkaTK3Y5a5PsPQ6u9OcPV
	 +yFxIK/8NLesZIG4lm2BHENrbVR7awhWuPo4Lk9I0nDtJzVeIPEbi5sl4aNOQDid8y
	 CMpnM0W0gtKNanI+3kyEbrTl+4IHIR5qJWucKYMKQU0OIni7Obygyen9ciA+B1HjfS
	 h4wlr/cWRAW9g==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
Date: Fri, 16 Aug 2024 10:56:54 +0900
Message-ID: <20240816015654.448057-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081112-idly-qualify-80f3@gregkh>
References: <2024081112-idly-qualify-80f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5 upstream.

Some firmware versions of the 9600 series SAS HBA byte-swap the REPORT
ZONES command reply buffer from ATA-ZAC devices by directly accessing the
buffer in the host memory. This does not respect the default command DMA
direction and causes IOMMU page faults on architectures with an IOMMU
enforcing write-only mappings for DMA_FROM_DEVICE DMA driection (e.g. AMD
hosts).

scsi 18:0:0:0: Direct-Access-ZBC ATA      WDC  WSH722020AL W870 PQ: 0 ANSI: 6
scsi 18:0:0:0: SATA: handle(0x0027), sas_addr(0x300062b2083e7c40), phy(0), device_name(0x5000cca29dc35e11)
scsi 18:0:0:0: enclosure logical id (0x300062b208097c40), slot(0)
scsi 18:0:0:0: enclosure level(0x0000), connector name( C0.0)
scsi 18:0:0:0: atapi(n), ncq(y), asyn_notify(n), smart(y), fua(y), sw_preserve(y)
scsi 18:0:0:0: qdepth(32), tagged(1), scsi_level(7), cmd_que(1)
sd 18:0:0:0: Attached scsi generic sg2 type 20
sd 18:0:0:0: [sdc] Host-managed zoned block device
mpt3sas 0000:41:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xfff9b200 flags=0x0050]
mpt3sas 0000:41:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xfff9b300 flags=0x0050]
mpt3sas_cm0: mpt3sas_ctl_pre_reset_handler: Releasing the trace buffer due to adapter reset.
mpt3sas_cm0 fault info from func: mpt3sas_base_make_ioc_ready
mpt3sas_cm0: fault_state(0x2666)!
mpt3sas_cm0: sending diag reset !!
mpt3sas_cm0: diag reset: SUCCESS
sd 18:0:0:0: [sdc] REPORT ZONES start lba 0 failed
sd 18:0:0:0: [sdc] REPORT ZONES: Result: hostbyte=DID_RESET driverbyte=DRIVER_OK
sd 18:0:0:0: [sdc] 0 4096-byte logical blocks: (0 B/0 B)

Avoid such issue by always mapping the buffer of REPORT ZONES commands
using DMA_BIDIRECTIONAL (read+write IOMMU mapping). This is done by
introducing the helper function _base_scsi_dma_map() and using this helper
in _base_build_sg_scmd() and _base_build_sg_scmd_ieee() instead of calling
directly scsi_dma_map().

Fixes: 471ef9d4e498 ("mpt3sas: Build MPI SGL LIST on GEN2 HBAs and IEEE SGL LIST on GEN3 HBAs")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20240719073913.179559-3-dlemoal@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
(cherry picked from commit 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5)
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2803b475dae6..0886177d6530 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2496,6 +2496,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
 	_base_add_sg_single_ieee(paddr, sgl_flags, 0, 0, -1);
 }
 
+static inline int _base_scsi_dma_map(struct scsi_cmnd *cmd)
+{
+	/*
+	 * Some firmware versions byte-swap the REPORT ZONES command reply from
+	 * ATA-ZAC devices by directly accessing in the host buffer. This does
+	 * not respect the default command DMA direction and causes IOMMU page
+	 * faults on some architectures with an IOMMU enforcing write mappings
+	 * (e.g. AMD hosts). Avoid such issue by making the report zones buffer
+	 * mapping bi-directional.
+	 */
+	if (cmd->cmnd[0] == ZBC_IN && cmd->cmnd[1] == ZI_REPORT_ZONES)
+		cmd->sc_data_direction = DMA_BIDIRECTIONAL;
+
+	return scsi_dma_map(cmd);
+}
+
 /**
  * _base_build_sg_scmd - main sg creation routine
  *		pcie_device is unused here!
@@ -2542,7 +2558,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0) {
 		sdev_printk(KERN_ERR, scmd->device,
 		 "scsi_dma_map failed: request for %d bytes!\n",
@@ -2690,7 +2706,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0) {
 		sdev_printk(KERN_ERR, scmd->device,
 			"scsi_dma_map failed: request for %d bytes!\n",
-- 
2.45.2


