Return-Path: <stable+bounces-219684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GiRJyM7n2m5ZQQAu9opvQ
	(envelope-from <stable+bounces-219684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:10:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669219C0D3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37594302FE7C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37F2EBB9E;
	Wed, 25 Feb 2026 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tajbrrXL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD52EA168
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043039; cv=none; b=hQGH3GCCIjVcfMNGLghW3sX/FV+dNduCXYZimt4FhvnmViTwhQ3q/oZCqgPLf5/3+3X0CjiL5vof9cG20KKAd4uhuTX0Wy3yUB7q9vWwRAlibYZWB7Si97w/5W0U1s9twEAs/xKajPNtLFBbd/6JIKBhORxXG16IK7yTQL9SctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043039; c=relaxed/simple;
	bh=HD0fGLuHDPU5/XG10TgrXmK+2InQoQ/xngGdb2Tp2do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2U6VrpxVeK4brt9HZtPCptswnCMkGplE5i5zTlu51psAUFq1b4OCYpgtp+Dis3++jiZrRdH0xcnOJZGqChx7yeeG0vjn/NXIjtzWviJyugbKSDxroRgmxx/dNxfFkRkp1APsY0QS6ZEEbhsHF5xzTwVKov+yLgU7x1Xhj6NBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tajbrrXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A336DC19422;
	Wed, 25 Feb 2026 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043039;
	bh=HD0fGLuHDPU5/XG10TgrXmK+2InQoQ/xngGdb2Tp2do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tajbrrXL8kyR5kA6HKc0kXBj00s7HRP+LLSojLTWHftUEsstQN+fJF8fAW5BLRc34
	 PP+GIukhzBKAzuH68CRF3fR3YueSTjdCeG1r0f5LCiOQGiqDV+Y5pcHB2Uq+laV5oR
	 asvKELAlJlHrhCN4v14qNXajGHsrqgkxXTOR7+Sf2cuNNJrydgVRREV+r4iweRhX8Z
	 eoY4pw9LaiJ8PgrCvzMU35tsoi1Yl1jAdJStT6HkONpPlLiS7veNgsNZPCT9ZBtzgj
	 8IuKJN5uRQ2YY/g1/QYc02PexwvZBLVTbXNK32qDM0gZVYBRYPJRu+h1AN+9a9tF7A
	 kvaK9+it3IkDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ata: libata: remove pointless VPRINTK() calls
Date: Wed, 25 Feb 2026 13:10:33 -0500
Message-ID: <20260225181034.910635-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225181034.910635-1-sashal@kernel.org>
References: <2026022431-await-dinginess-62b0@gregkh>
 <20260225181034.910635-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219684-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 4669219C0D3
X-Rspamd-Action: no action

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit e1553351d747cbcd62db01d579dff916edcc782c ]

Most of the information is already covered by tracepoints
(if not downright pointless), so remove the VPRINTK() calls.
And while we're at it, remove ata_scsi_dump_cdb(), too,
as this information can be retrieved from scsi tracing.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: bb3a8154b1a1 ("ata: libata-scsi: refactor ata_scsi_translate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c |  3 ---
 drivers/ata/libata-sata.c |  2 --
 drivers/ata/libata-scsi.c | 42 ---------------------------------------
 drivers/ata/libata-sff.c  |  4 ----
 drivers/ata/libata.h      |  1 -
 5 files changed, 52 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3df057d381a73..acc78416be8ee 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4486,8 +4486,6 @@ static void ata_sg_clean(struct ata_queued_cmd *qc)
 
 	WARN_ON_ONCE(sg == NULL);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
-
 	if (qc->n_elem)
 		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
 
@@ -4519,7 +4517,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	if (n_elem < 1)
 		return -1;
 
-	VPRINTK("%d sg elements mapped\n", n_elem);
 	qc->orig_n_elem = qc->n_elem;
 	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index bac569736c937..be41c2a715545 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1270,8 +1270,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	int rc = 0;
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	if (likely(ata_dev_enabled(ap->link.device)))
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 22c45bc64a95e..4fd8fcab5f972 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1302,8 +1302,6 @@ static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len;
 
-	VPRINTK("six-byte command\n");
-
 	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
 	lba |= ((u64)cdb[2]) << 8;
 	lba |= ((u64)cdb[3]);
@@ -1329,8 +1327,6 @@ static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("ten-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 24;
 	lba |= ((u64)cdb[3]) << 16;
 	lba |= ((u64)cdb[4]) << 8;
@@ -1358,8 +1354,6 @@ static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("sixteen-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 56;
 	lba |= ((u64)cdb[3]) << 48;
 	lba |= ((u64)cdb[4]) << 40;
@@ -1709,8 +1703,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	struct ata_queued_cmd *qc;
 	int rc;
 
-	VPRINTK("ENTER\n");
-
 	qc = ata_scsi_qc_new(dev, cmd);
 	if (!qc)
 		goto err_mem;
@@ -1741,7 +1733,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
-	VPRINTK("EXIT\n");
 	return 0;
 
 early_finish:
@@ -1854,8 +1845,6 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		2
 	};
 
-	VPRINTK("ENTER\n");
-
 	/* set scsi removable (RMB) bit per ata bit, or if the
 	 * AHCI port says it's external (Hotplug-capable, eSATA).
 	 */
@@ -2266,8 +2255,6 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	u8 dpofua, bp = 0xff;
 	u16 fp;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (scsicmd[0] == MODE_SENSE);
 	ebd = !(scsicmd[1] & 0x8);      /* dbd bit inverted == edb */
 	/*
@@ -2385,8 +2372,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	log2_per_phys = ata_id_log2_per_physical_sector(dev->id);
 	lowest_aligned = ata_id_logical_sector_offset(dev->id, log2_per_phys);
 
-	VPRINTK("ENTER\n");
-
 	if (args->cmd->cmnd[0] == READ_CAPACITY) {
 		if (last_lba >= 0xffffffffULL)
 			last_lba = 0xffffffff;
@@ -2453,7 +2438,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
  */
 static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
 {
-	VPRINTK("ENTER\n");
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
 	return 0;
@@ -2549,8 +2533,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
-	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
-
 	/* handle completion from new EH */
 	if (unlikely(qc->ap->ops->error_handler &&
 		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
@@ -3684,8 +3666,6 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	u8 buffer[64];
 	const u8 *p = buffer;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (cdb[0] == MODE_SELECT);
 	if (six_byte) {
 		if (scmd->cmd_len < 5) {
@@ -3984,26 +3964,6 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	return NULL;
 }
 
-/**
- *	ata_scsi_dump_cdb - dump SCSI command contents to dmesg
- *	@ap: ATA port to which the command was being sent
- *	@cmd: SCSI command to dump
- *
- *	Prints the contents of a SCSI command via printk().
- */
-
-void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd)
-{
-#ifdef ATA_VERBOSE_DEBUG
-	struct scsi_device *scsidev = cmd->device;
-
-	VPRINTK("CDB (%u:%d,%d,%lld) %9ph\n",
-		ap->print_id,
-		scsidev->channel, scsidev->id, scsidev->lun,
-		cmd->cmnd);
-#endif
-}
-
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
@@ -4089,8 +4049,6 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 
 	spin_lock_irqsave(ap->lock, irq_flags);
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
 		rc = __ata_scsi_queuecmd(cmd, dev);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 8409e53b7b7a0..ab1fe23810707 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -888,8 +888,6 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 	if (unlikely(!bytes))
 		goto atapi_check;
 
-	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
-
 	if (unlikely(__atapi_pio_bytes(qc, bytes)))
 		goto err_out;
 	ata_sff_sync(ap); /* flush */
@@ -2614,7 +2612,6 @@ static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 
 			prd[pi].addr = cpu_to_le32(addr);
 			prd[pi].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
 			sg_len -= len;
@@ -2674,7 +2671,6 @@ static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
 				prd[++pi].addr = cpu_to_le32(addr + 0x8000);
 			}
 			prd[pi].flags_len = cpu_to_le32(blen);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
 			sg_len -= len;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index bf71bd9e66cd8..d71fffe48495f 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -150,7 +150,6 @@ extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
 void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
-void ata_scsi_dump_cdb(struct ata_port *ap, struct scsi_cmnd *cmd);
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
 
 /* libata-eh.c */
-- 
2.51.0


