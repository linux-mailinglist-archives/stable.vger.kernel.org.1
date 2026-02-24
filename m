Return-Path: <stable+bounces-217988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFt7KFIcnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:46:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2718CEF0
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F343038A4A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879C335BBB;
	Tue, 24 Feb 2026 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTo9nX9y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4ED226D00
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969598; cv=none; b=JVL7NF7ptJpOEDMWiYRqaXg/WoF36W+7Na9xJl7esgEqpe0ATaT9J3jNkl9LyQI1S2U9ZnFkFjsg+qlAOA9tY3YuMVOVOFTlUp1xHdadx7aSc4mIsmacP4S952HLUl67paCcYvoru+sZ+avh8zs3K/VzlS+4So3B+QSw4C8ymo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969598; c=relaxed/simple;
	bh=mYJxsJFjXbKaixZTEeuVXuGzFBsYj5iuhV7Mmw5qgpY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JkH7x4GvCHdLyKvLVBBGT2LiIub8bkmuzwSLGHr3oENHAMl6t/j+s7nrtafZG2zn6azcKKWFrchLrI4MKEdMOdyYwpzeWOingViVeyGQL7Ok6YTT5PrMVcTeHCJ66yVmJ7GRI4DAzizCrc3nmrx3vBxlyas1DLEyFLSLhMO4W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTo9nX9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBC9C116D0;
	Tue, 24 Feb 2026 21:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969597;
	bh=mYJxsJFjXbKaixZTEeuVXuGzFBsYj5iuhV7Mmw5qgpY=;
	h=Subject:To:Cc:From:Date:From;
	b=MTo9nX9y5d5TpllkMBf9z41kfhhDLFMDcWSRuZVnCgjQaNZc/SKhpT4ETotGh1vRp
	 SXqw1+rUZChdT4qJM3uP4yIcPkcpHWajRc9CxG/PbuQFuFDFaMateGzPUSloIVvCjn
	 xsU0j3Xu+KaYoeIo0OA8JRbB0S69PdaHN758eu9k=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: refactor ata_scsi_translate()" failed to apply to 5.15-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,ipylypiv@google.com,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:46:31 -0800
Message-ID: <2026022431-await-dinginess-62b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217988-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 06C2718CEF0
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bb3a8154b1a1dc2c86d037482c0a2cf9186829ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022431-await-dinginess-62b0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

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

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d388a4ff9ae4..be620bc04584 100644
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
+		goto done;
 
-	if (ap->ops->qc_defer) {
-		if ((rc = ap->ops->qc_defer(qc)))
-			goto defer;
-	}
+	return ata_scsi_qc_issue(ap, qc);
 
-	/* select device, send command to hardware */
-	ata_qc_issue(qc);
-
-	return 0;
-
-early_finish:
+done:
 	ata_qc_free(qc);
 	scsi_done(cmd);
 	return 0;
-
-err_did:
-	ata_qc_free(qc);
-	cmd->result = (DID_ERROR << 16);
-	scsi_done(cmd);
-err_mem:
-	return 0;
-
-defer:
-	ata_qc_free(qc);
-	if (rc == ATA_DEFER_LINK)
-		return SCSI_MLQUEUE_DEVICE_BUSY;
-	else
-		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
 /**


