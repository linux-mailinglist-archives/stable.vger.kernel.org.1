Return-Path: <stable+bounces-68828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B64D953430
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891931C252D1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E31AC426;
	Thu, 15 Aug 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m0uL15hs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8051ABED3;
	Thu, 15 Aug 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731792; cv=none; b=Q2GnpNnsEk58/w0bdm8eKCimvWqJd7PlOqB+dOR5xeqczJOKDcGgm1WW5UGm3mP5Js/AdP1mJoOtS17QrSf8eT7YQ3cV7Isld7zVb5qA4NwIvAvHVKYBYzd4m23SD7lgZq4Ki5dlOZdGXqdPzf8WaosCRTJAb0n/Ihmkn7klIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731792; c=relaxed/simple;
	bh=XLl9PlepAm/h6B9VNZncIcwl6uryvU4WtAMb9oQT+xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgHqBaCFLCORdy0k3PM/mKNxdoLzUYQVk3DaXGt8D1pWrZyxhKTnBUavHCfqDoLA4VKfKUpDDCaVWVExYC0PCAWff4m7CMtZHSwHhgmKP3eDl7//n+OTb6neB6diyGKhbkmIeqMj6kq37PuiruipL6d8xwH2HumKiFDnofcT54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m0uL15hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86176C4AF0C;
	Thu, 15 Aug 2024 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731791;
	bh=XLl9PlepAm/h6B9VNZncIcwl6uryvU4WtAMb9oQT+xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0uL15hsZGt0322VcBv5aJpYLnx5yGj7u3l7BtKD9N7KJz7Fl4lRaubpdO35SGFYB
	 /hBYjNwROKea6xt8yEUeEOB0TasbjexlCPcGoc/IVcU8TbYIqgZgqKpvM/BUzU6Gn2
	 k0zj82j0RG2SEu+Ipo3FTH/Jd2KeQBb8ilVFiCks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 240/259] scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
Date: Thu, 15 Aug 2024 15:26:13 +0200
Message-ID: <20240815131912.040286210@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 8d161d6075b78..1bc23e8ee748a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2371,6 +2371,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
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
@@ -2417,7 +2433,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
@@ -2561,7 +2577,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
-- 
2.43.0




