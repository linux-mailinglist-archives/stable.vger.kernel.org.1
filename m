Return-Path: <stable+bounces-66380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D367294E20E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AD2812F2
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98614C586;
	Sun, 11 Aug 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBAk3xD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EF7F6
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391846; cv=none; b=UTa1nZO/kTzSfM4wpa0PaW4GxojUEdwkKnWwmsCc5YyKKXj3NbB0wbZ0CMxai2vGY0hsB1d2m2lqhNuK969ZyjGd6SvTrjabXDjjrDonjrD7UXRsc7M0XSmp3NnNdNC53DkXK9O2FrQLj2bGo94rccmn3jMcX52SXHwkh3Q0o3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391846; c=relaxed/simple;
	bh=02ewbHgBBSsLt+jx8I7kVMW/O81DUXtc7HTMM2xIcqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sxgwKF3lfa2YROr2ei8Tj/7TaMQSEtUyaR7Y40K+EtOfv3fJHn0K7H1iDQAmub/OyrV8TtitgOx0syRQKl0bklZPEjwfLh+SyhN5wzvo4jinZnMG9f1ypmLcCeD33w3DPET6Yyx0KWU8MGWTEBCj4Fe7N+qqW9YSGdAn6MtAV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBAk3xD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5281C32786;
	Sun, 11 Aug 2024 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723391845;
	bh=02ewbHgBBSsLt+jx8I7kVMW/O81DUXtc7HTMM2xIcqw=;
	h=Subject:To:Cc:From:Date:From;
	b=EBAk3xD9ywNrKSCq+aLPwPlzkIrry5KdKcZ+NlZt3hgmYX9oPVM+CCb6ANJ9t+Fxd
	 ity4ro7moDrV0AhsrR7XNCHO9eHdIPCTpiUlJjtHCi8QWo12alMS2wDy4eaPzYLaM2
	 qcohuzvOcppqy3+ujlkDwHeMO4k6BAYQfu2ff020=
Subject: FAILED: patch "[PATCH] scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES" failed to apply to 5.4-stable tree
To: dlemoal@kernel.org,hch@lst.de,johannes.thumshirn@wdc.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 11 Aug 2024 17:57:14 +0200
Message-ID: <2024081113-creamed-unleaded-c696@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081113-creamed-unleaded-c696@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

82dbb57ac8d0 ("scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES")
0c25422d34b4 ("scsi: mpt3sas: Remove scsi_dma_map() error messages")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Fri, 19 Jul 2024 16:39:12 +0900
Subject: [PATCH] scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES

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

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1092497563b2..c8fb965a6bf0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2671,6 +2671,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
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
@@ -2717,7 +2733,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
@@ -2861,7 +2877,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 


