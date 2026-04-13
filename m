Return-Path: <stable+bounces-236531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FCbJuYZ3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B713EF13B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B52B30B45BA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD42FE056;
	Mon, 13 Apr 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SybrNnLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C142EBB8C;
	Mon, 13 Apr 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097146; cv=none; b=TNP+QJMMT/NmRKtTPIbI5G2XQ3j7fCbBQkKBRyZyYdCy2GQzVSM/Z3zMWB4IMiEQ9AgNL434gFC7lhI7aYKcm9OXS+fq0akCsCxFSeiOHqbFHwVlA/ekivOKwBz2ihsXqiYiDjZr6KWamQSnMwiXPUnCFrcjXDGP4W+3/GGWH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097146; c=relaxed/simple;
	bh=4dd0AKGdWbbvDdsLDG59xjxbB1CfRKuNiL57bfJ3PeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biLcdQmqz/FddBRL9SAtEidWGYQxVJ3F1cmPR22Mnv2tvuXnFokM5aDkCz7tRqh8z7BJhMY2KGwwGIV1Z5KFJs1VkbhpBsXX2MUh1cS5rpkMpkf2WHki6U0xbyn83N3S03+ISsvri2khcbNepJTX9vqimg4s6La+X8D6L7J/lqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SybrNnLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183F9C2BCAF;
	Mon, 13 Apr 2026 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097146;
	bh=4dd0AKGdWbbvDdsLDG59xjxbB1CfRKuNiL57bfJ3PeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SybrNnLsBPIt7T4d2yBekwYXzO9YedUtp4RQCwNoETxZY3JnWXaKFJksxH6zWDjPL
	 b2Yj5vUA08vieWpI24SURfTu0AFGVR7WNwp3oz1wx5ZN+Lmp8Ok1KlBT4l46KuHAKE
	 J5OJ6v7HX4Va+8dBMvvQbIVd0nVsIWBB6+mV9ijM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 016/570] scsi: ata: Call scsi_done() directly
Date: Mon, 13 Apr 2026 17:52:27 +0200
Message-ID: <20260413155831.024715273@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236531-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,wdc.com:email]
X-Rspamd-Queue-Id: 06B713EF13B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 58bf201dfc032eadbb31eaf817b467bed17f753d ]

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Link: https://lore.kernel.org/r/20211007202923.2174984-4-bvanassche@acm.org
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: bb3a8154b1a1 ("ata: libata-scsi: refactor ata_scsi_translate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-sata.c |  2 +-
 drivers/ata/libata-scsi.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 7cacb2bfc3608..bac569736c937 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1276,7 +1276,7 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
-		cmd->scsi_done(cmd);
+		scsi_done(cmd);
 	}
 	return rc;
 }
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f91b88073232d..b57027206ae1e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -634,7 +634,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 	qc = ata_qc_new_init(dev, scsi_cmd_to_rq(cmd)->tag);
 	if (qc) {
 		qc->scsicmd = cmd;
-		qc->scsidone = cmd->scsi_done;
+		qc->scsidone = scsi_done;
 
 		qc->sg = scsi_sglist(cmd);
 		qc->n_elem = scsi_sg_count(cmd);
@@ -643,7 +643,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 			qc->flags |= ATA_QCFLAG_QUIET;
 	} else {
 		cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
-		cmd->scsi_done(cmd);
+		scsi_done(cmd);
 	}
 
 	return qc;
@@ -1750,14 +1750,14 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 
 early_finish:
 	ata_qc_free(qc);
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 	DPRINTK("EXIT - early finish (good or error)\n");
 	return 0;
 
 err_did:
 	ata_qc_free(qc);
 	cmd->result = (DID_ERROR << 16);
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 err_mem:
 	DPRINTK("EXIT - internal\n");
 	return 0;
@@ -4068,7 +4068,7 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
 		scmd->cmd_len, scsi_op, dev->cdb_len);
 	scmd->result = DID_ERROR << 16;
-	scmd->scsi_done(scmd);
+	scsi_done(scmd);
 	return 0;
 }
 
@@ -4110,7 +4110,7 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 		rc = __ata_scsi_queuecmd(cmd, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
-		cmd->scsi_done(cmd);
+		scsi_done(cmd);
 	}
 
 	spin_unlock_irqrestore(ap->lock, irq_flags);
@@ -4239,7 +4239,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 	}
 
-	cmd->scsi_done(cmd);
+	scsi_done(cmd);
 }
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
-- 
2.51.0




