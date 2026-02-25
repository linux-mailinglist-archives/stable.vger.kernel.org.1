Return-Path: <stable+bounces-219694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBW7NCRQn2n+ZwQAu9opvQ
	(envelope-from <stable+bounces-219694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:40:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6319CC5D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7A9A30131AD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ACD3EDAD6;
	Wed, 25 Feb 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL3SSOQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C01395D94
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048414; cv=none; b=ieyvOFK1lITpFLkFLhvPKHhS5fDimEhzl0mKYQouGms+dq82SZweqwaiJNJGP0Tcl8aGq2+SjzTHuXA5N1VKnGtT+Ur0IF3BI9FDjDJRFXReCTA5MkncgHYQFBBGhqK7KWQn5GPKLBL5SsnIG91U9lIV8noFrTQzsv6+quHN4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048414; c=relaxed/simple;
	bh=v+DBBvh1HCvJuaprTinq8MLNgZeg2LmLu3CCm1vA5SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8KBQyDcqQEhXnDLASzfzeddXlnGYQP2YoB/KRC9a/pBJ2H9LWgex7mJi0b7oE4/nUMMxingYG2DmCxk+oR1MYsGHeSNasjlc1NkqO06+95wrg6op++J/imujH1GEWk8sqSvLgN+DOsQ7NAIfjVHxJxVEJuRZTr+F6+1t4b0vpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL3SSOQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CEEC116D0;
	Wed, 25 Feb 2026 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048413;
	bh=v+DBBvh1HCvJuaprTinq8MLNgZeg2LmLu3CCm1vA5SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL3SSOQ/Yuse8n4Iz3/1p1Di17mhBUYyF9ajvFfOxzje+YDhc0IrOxDaKUW0fYiua
	 bIKDxp8AqCJ0hfO8+/JtZLnSmHG/pdqHuTbuSQMEKBGqmT4UXyLYCagjv2cYn/kNO/
	 cD9R2d7H1CmfbzDxt7aG3lEmJ15AkdA06HlSufKtRu3vYjVmIzUslRCYMGJ3y99tcb
	 FTKU0YgzgKuWCekOj1ajqONIExQwWLfiUSoKFlOYa6hb1kdlLH4Rrf5/hp/Pw8Oadv
	 P3Yw96+RHOPirFP8yV1AQdbZjKIWT7sJvj7Yn76iwO7u49lJ2Aq0V5AtXBgUQiJA/X
	 fs6PiCAfZou8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ata: libata: remove pointless VPRINTK() calls
Date: Wed, 25 Feb 2026 14:40:10 -0500
Message-ID: <20260225194011.1015550-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022431-quote-freefall-2523@gregkh>
References: <2026022431-quote-freefall-2523@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-219694-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C4F6319CC5D
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
index 107c28ec23b8a..9be577e7c357c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4461,8 +4461,6 @@ static void ata_sg_clean(struct ata_queued_cmd *qc)
 
 	WARN_ON_ONCE(sg == NULL);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
-
 	if (qc->n_elem)
 		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
 
@@ -4494,7 +4492,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	if (n_elem < 1)
 		return -1;
 
-	VPRINTK("%d sg elements mapped\n", n_elem);
 	qc->orig_n_elem = qc->n_elem;
 	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index d5c97dba2dd41..6a7334fb9a03b 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1258,8 +1258,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	int rc = 0;
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	if (likely(ata_dev_enabled(ap->link.device)))
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 655be7e96dfcb..d6b83614d798f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1296,8 +1296,6 @@ static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len;
 
-	VPRINTK("six-byte command\n");
-
 	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
 	lba |= ((u64)cdb[2]) << 8;
 	lba |= ((u64)cdb[3]);
@@ -1323,8 +1321,6 @@ static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("ten-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 24;
 	lba |= ((u64)cdb[3]) << 16;
 	lba |= ((u64)cdb[4]) << 8;
@@ -1352,8 +1348,6 @@ static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 	u64 lba = 0;
 	u32 len = 0;
 
-	VPRINTK("sixteen-byte command\n");
-
 	lba |= ((u64)cdb[2]) << 56;
 	lba |= ((u64)cdb[3]) << 48;
 	lba |= ((u64)cdb[4]) << 40;
@@ -1707,8 +1701,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	struct ata_queued_cmd *qc;
 	int rc;
 
-	VPRINTK("ENTER\n");
-
 	qc = ata_scsi_qc_new(dev, cmd);
 	if (!qc)
 		goto err_mem;
@@ -1739,7 +1731,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
-	VPRINTK("EXIT\n");
 	return 0;
 
 early_finish:
@@ -1897,8 +1888,6 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		2
 	};
 
-	VPRINTK("ENTER\n");
-
 	/* set scsi removable (RMB) bit per ata bit, or if the
 	 * AHCI port says it's external (Hotplug-capable, eSATA).
 	 */
@@ -2309,8 +2298,6 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	u8 dpofua, bp = 0xff;
 	u16 fp;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (scsicmd[0] == MODE_SENSE);
 	ebd = !(scsicmd[1] & 0x8);      /* dbd bit inverted == edb */
 	/*
@@ -2428,8 +2415,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	log2_per_phys = ata_id_log2_per_physical_sector(dev->id);
 	lowest_aligned = ata_id_logical_sector_offset(dev->id, log2_per_phys);
 
-	VPRINTK("ENTER\n");
-
 	if (args->cmd->cmnd[0] == READ_CAPACITY) {
 		if (last_lba >= 0xffffffffULL)
 			last_lba = 0xffffffff;
@@ -2496,7 +2481,6 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
  */
 static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
 {
-	VPRINTK("ENTER\n");
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
 	return 0;
@@ -2596,8 +2580,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
-	VPRINTK("ENTER, err_mask 0x%X\n", err_mask);
-
 	/* handle completion from new EH */
 	if (unlikely(qc->ap->ops->error_handler &&
 		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
@@ -3732,8 +3714,6 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	u8 buffer[64];
 	const u8 *p = buffer;
 
-	VPRINTK("ENTER\n");
-
 	six_byte = (cdb[0] == MODE_SELECT);
 	if (six_byte) {
 		if (scmd->cmd_len < 5) {
@@ -4032,26 +4012,6 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
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
@@ -4139,8 +4099,6 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 
 	spin_lock_irqsave(ap->lock, irq_flags);
 
-	ata_scsi_dump_cdb(ap, cmd);
-
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
 		rc = __ata_scsi_queuecmd(cmd, dev);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b71ea4a680b01..88bce10775afb 100644
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


