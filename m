Return-Path: <stable+bounces-69167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2019535D0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62EC1C25224
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61D1A00CF;
	Thu, 15 Aug 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B84ekGpp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5462772A;
	Thu, 15 Aug 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732886; cv=none; b=MIyh/55g9pJs79tzzxyc5ootFyEQC9s6XwSuWdGw0d8nhtDVGVIjYRiYL0ahvdGJUEOtC82PqOdcOgDgejKKYOJzToVW+PLTRnFWUhfyp+qrQEQK68QGPXrcfIFUgR6Tm5AXZrNdEE9wsn3e2hknBiXjf+tIuUmLB7dYXHXZdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732886; c=relaxed/simple;
	bh=5S3gr/wR2W6Sg6O2FIpSCIVYHlzwGckUGeWSAWpL8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csjEW7EM2yTlA44cyvg2Vmhrowm2vmpY0Wt+L5LTCyB9vBa3Zo7n7saNPt3Pm67Y5d6rVOwQObWnjLt8lTBjmkERA+7YiycXS0EUyEzrV7JgstEaVdQyteaEzqvsfkGbHJIADQeVWPC3QqoC2KQexuPOrSK0SKpzvZ1A2Tza/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B84ekGpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F0C32786;
	Thu, 15 Aug 2024 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732886;
	bh=5S3gr/wR2W6Sg6O2FIpSCIVYHlzwGckUGeWSAWpL8f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B84ekGpppW4DSB4D2feHUdUcgG+wdSzD7GgVIbOvmID3MW4t0ionUKMgtAyEZVzIu
	 tkCdBBdp1NPlmzL/vl7SvJA61RVvQBcvs6nBvcQ0DKQsm+QITDvAWqdWR/Im2Bt52+
	 iidv+Kic+tSb8UtTX/XufbEgQ9nBZMAUX66NCveI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 315/352] scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
Date: Thu, 15 Aug 2024 15:26:21 +0200
Message-ID: <20240815131931.632244678@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index de4ec552799dd..53528711dac1f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2492,6 +2492,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
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
@@ -2538,7 +2554,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
@@ -2682,7 +2698,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
-- 
2.43.0




