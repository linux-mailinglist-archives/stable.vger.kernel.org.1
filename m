Return-Path: <stable+bounces-219683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIFSKSQ7n2m5ZQQAu9opvQ
	(envelope-from <stable+bounces-219683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:10:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A019C0DB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747243050402
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09662EB873;
	Wed, 25 Feb 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWBGk8mS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C702EA168
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043038; cv=none; b=aRBEqkMOVYMgQ8hbAZ450IpSHb0RmyqTUugbygr/05uI9CON2CnqfRSGCjEW2OTET+J48GHKAo/XNHlsrRuKIr6rW16VSnvpdZnSAEFk2yfGlvYeEFuwyKtG043i1wVBFG63Le69WHh9fY+tPCdyI2ZPk/1IIzeD/qeBwuA+ZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043038; c=relaxed/simple;
	bh=VOybiSiOqgl0DL8iNOHaGFQbezfiXrmJzR0s5s+UDyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGqPgDMj7B62Z0zR0s/TNin/Ygo4tV9fGYWGdT2hhn62n3uXpdV/QdgVVtK/tKldF+r6pFCnReA40e2RLcbrwJ/NVLaeocnPSFayIUgnwUaz2P7icvVnuk6azGISG2fgVFcYuBE+0tb+H9cDRc6/4Au1vcSNQGv4xf9Ms6dDpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWBGk8mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D97C19421;
	Wed, 25 Feb 2026 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043038;
	bh=VOybiSiOqgl0DL8iNOHaGFQbezfiXrmJzR0s5s+UDyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWBGk8mSFwq8/b1P3G87OVp3Y5spFOentJeJCIRKCSF4Od7RM/oEcF3rh05ujTf+E
	 6tyAAinkDapcPV4h6RgLom3cdrke26iCG3e5Nk/sAl33vrmLAx51LZmVgSWZG6TgLs
	 Od3FtCbIQoAvAGxc1K/Rm1NKBl1wLSp4MMgfYp8YCfZLWThHvgRuIITx9Ff5EWadTp
	 GnvK1qawBjE9+yRsSobrW+llUcjxBvhpK0RSpp/K25pgDMXMAiQHABRXRQSbzc+TU3
	 7a89iaUVTWQASAe+Zi3DqApHjqTTvm/kV9o6ZyqBddRWmJwzvSiu3Rt4xx1icF8XQ3
	 PhWLlk5O7/ZPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] ata: libata-scsi: drop DPRINTK calls for cdb translation
Date: Wed, 25 Feb 2026 13:10:32 -0500
Message-ID: <20260225181034.910635-2-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219683-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,hotplug_task.work:url]
X-Rspamd-Queue-Id: 2E4A019C0DB
X-Rspamd-Action: no action

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 1fe9fb71b2ffcedd794daacf4db2056a6cb5199e ]

Drop DPRINTK calls for cdb translation as they are already covered
by other traces, and also drop the DPRINTK calls in ata_scsi_hotplug().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: bb3a8154b1a1 ("ata: libata-scsi: refactor ata_scsi_translate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b57027206ae1e..22c45bc64a95e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1472,9 +1472,6 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 		head  = track % dev->heads;
 		sect  = (u32)block % dev->sectors + 1;
 
-		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
-			(u32)block, track, cyl, head, sect);
-
 		/* Check whether the converted CHS can fit.
 		   Cylinder: 0-65535
 		   Head: 0-15
@@ -1597,7 +1594,6 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 			goto invalid_fld;
 		break;
 	default:
-		DPRINTK("no-byte command\n");
 		fp = 0;
 		goto invalid_fld;
 	}
@@ -1751,7 +1747,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 early_finish:
 	ata_qc_free(qc);
 	scsi_done(cmd);
-	DPRINTK("EXIT - early finish (good or error)\n");
 	return 0;
 
 err_did:
@@ -1759,12 +1754,10 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	cmd->result = (DID_ERROR << 16);
 	scsi_done(cmd);
 err_mem:
-	DPRINTK("EXIT - internal\n");
 	return 0;
 
 defer:
 	ata_qc_free(qc);
-	DPRINTK("EXIT - defer\n");
 	if (rc == ATA_DEFER_LINK)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	else
@@ -2491,8 +2484,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	DPRINTK("ATAPI request sense\n");
-
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
 #ifdef CONFIG_ATA_SFF
@@ -2531,8 +2522,6 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	qc->complete_fn = atapi_sense_complete;
 
 	ata_qc_issue(qc);
-
-	DPRINTK("EXIT\n");
 }
 
 /*
@@ -2642,7 +2631,6 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-		DPRINTK("direction: write\n");
 	}
 
 	qc->tf.command = ATA_CMD_PACKET;
@@ -4065,8 +4053,6 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	return 0;
 
  bad_cdb_len:
-	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
-		scmd->cmd_len, scsi_op, dev->cdb_len);
 	scmd->result = DID_ERROR << 16;
 	scsi_done(scmd);
 	return 0;
@@ -4532,12 +4518,9 @@ void ata_scsi_hotplug(struct work_struct *work)
 		container_of(work, struct ata_port, hotplug_task.work);
 	int i;
 
-	if (ap->pflags & ATA_PFLAG_UNLOADING) {
-		DPRINTK("ENTER/EXIT - unloading\n");
+	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		return;
-	}
 
-	DPRINTK("ENTER\n");
 	mutex_lock(&ap->scsi_scan_mutex);
 
 	/* Unplug detached devices.  We cannot use link iterator here
@@ -4553,7 +4536,6 @@ void ata_scsi_hotplug(struct work_struct *work)
 	ata_scsi_scan_host(ap, 0);
 
 	mutex_unlock(&ap->scsi_scan_mutex);
-	DPRINTK("EXIT\n");
 }
 
 /**
-- 
2.51.0


