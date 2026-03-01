Return-Path: <stable+bounces-221355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB1oNniVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E25611CA7E3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25D463014924
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B328466C;
	Sun,  1 Mar 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNE6+1zC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AA13B7AE;
	Sun,  1 Mar 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328057; cv=none; b=XMYvt92BFy2mACPrIHkDUV5d+BT/bCcvtNqmrxJfnboA9pNDPtTLWynZrRd4rJw6Ugtrlx7VV2jRgqtgeh9UhHrtsdoLkWjAaKZAMmqkbFwXc4QX7KVJ357DjcqCTgTB6gwaML0HjFjmq7SuMt2Y9YbXFzIHCfx+EjFFGW+m7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328057; c=relaxed/simple;
	bh=cTZwzoYEyNmdTE8Fx3uMuA9KPPnLYN+y6/2f9VH6GOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHnFoc64hePIsowWpCMQoRPT7/fYnGiCHmmxmcVf8buh2LCf7VqraLgceCDiBpHcjZSzPh+1wV1pbg8NxdFxpMSn07XkT1auc+wojoS00gNAvfFLtcL/FKJcSrihc0l5yFy/MkCwT/uBnPDl/oUijyHg5N2t7oF4UMX6ErKbtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNE6+1zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B08C19421;
	Sun,  1 Mar 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328057;
	bh=cTZwzoYEyNmdTE8Fx3uMuA9KPPnLYN+y6/2f9VH6GOU=;
	h=From:To:Cc:Subject:Date:From;
	b=GNE6+1zCyLb4uIfuqo2CG2SeHk96zTYQiCOjsLp8Q7rTHlv9L16cAjNDGUZ/YDnMf
	 BZextUJ9BZJyvR1G7MHMOahve7k1iaMdpjSH/LmlzQaYuC91R94g6sXXPmxem5T6MZ
	 SotMLDh3D5+DrbmadD8Rko7SQ32wMLPpJpNlFwu5tcScoV2YUJ32yRsjhbUZ9Sj2qA
	 IUR5X1jsQMQKPBD+Qpx7M9tkwaMVim1GSLhX5qGEky59ujt5CV2AmBXi5DBZcwKWlp
	 BYkk7gZIg4aZpOwlwifnuVTDPvwfp6om8use82eL+wRAtk+no08RGerOe2nv07ZWim
	 RozKZNV+VsOZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dlemoal@kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	linux-ide@vger.kernel.org
Subject: FAILED: Patch "ata: libata-scsi: refactor ata_scsi_translate()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:20:54 -0500
Message-ID: <20260301012055.1676676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221355-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E25611CA7E3
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bb3a8154b1a1dc2c86d037482c0a2cf9186829ed Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 17 Dec 2025 14:05:25 +0900
Subject: [PATCH] ata: libata-scsi: refactor ata_scsi_translate()

Factor out of ata_scsi_translate() the code handling queued command
deferral using the port qc_defer callback and issuing the queued
command with ata_qc_issue() into the new function ata_scsi_qc_issue(),
and simplify the goto used in ata_scsi_translate().
While at it, also add a lockdep annotation to check that the port lock
is held when ata_scsi_translate() is called.

No functional changes.

Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 81 ++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d388a4ff9ae44..be620bc045848 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1691,6 +1691,42 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	ata_qc_done(qc);
 }
 
+static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	int ret;
+
+	if (!ap->ops->qc_defer)
+		goto issue;
+
+	/* Check if the command needs to be deferred. */
+	ret = ap->ops->qc_defer(qc);
+	switch (ret) {
+	case 0:
+		break;
+	case ATA_DEFER_LINK:
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		break;
+	case ATA_DEFER_PORT:
+		ret = SCSI_MLQUEUE_HOST_BUSY;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		ret = SCSI_MLQUEUE_HOST_BUSY;
+		break;
+	}
+
+	if (ret) {
+		/* Force a requeue of the command to defer its execution. */
+		ata_qc_free(qc);
+		return ret;
+	}
+
+issue:
+	ata_qc_issue(qc);
+
+	return 0;
+}
+
 /**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@dev: ATA device to which the command is addressed
@@ -1714,66 +1750,49 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
  *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY if the command
- *	needs to be deferred.
+ *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY or SCSI_MLQUEUE_HOST_BUSY if the
+ *	command needs to be deferred.
  */
 static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
 {
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
-	int rc;
 
+	lockdep_assert_held(ap->lock);
+
+	/*
+	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
+	 * have nothing further to do when allocating a qc fails.
+	 */
 	qc = ata_scsi_qc_new(dev, cmd);
 	if (!qc)
-		goto err_mem;
+		return 0;
 
 	/* data is present; dma-map it */
 	if (cmd->sc_data_direction == DMA_FROM_DEVICE ||
 	    cmd->sc_data_direction == DMA_TO_DEVICE) {
 		if (unlikely(scsi_bufflen(cmd) < 1)) {
 			ata_dev_warn(dev, "WARNING: zero len r/w req\n");
-			goto err_did;
+			cmd->result = (DID_ERROR << 16);
+			goto done;
 		}
 
 		ata_sg_init(qc, scsi_sglist(cmd), scsi_sg_count(cmd));
-
 		qc->dma_dir = cmd->sc_data_direction;
 	}
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
 	if (xlat_func(qc))
-		goto early_finish;
-
-	if (ap->ops->qc_defer) {
-		if ((rc = ap->ops->qc_defer(qc)))
-			goto defer;
-	}
-
-	/* select device, send command to hardware */
-	ata_qc_issue(qc);
+		goto done;
 
-	return 0;
-
-early_finish:
-	ata_qc_free(qc);
-	scsi_done(cmd);
-	return 0;
+	return ata_scsi_qc_issue(ap, qc);
 
-err_did:
+done:
 	ata_qc_free(qc);
-	cmd->result = (DID_ERROR << 16);
 	scsi_done(cmd);
-err_mem:
 	return 0;
-
-defer:
-	ata_qc_free(qc);
-	if (rc == ATA_DEFER_LINK)
-		return SCSI_MLQUEUE_DEVICE_BUSY;
-	else
-		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
 /**
-- 
2.51.0





