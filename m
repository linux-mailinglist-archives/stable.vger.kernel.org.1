Return-Path: <stable+bounces-217992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBPpBV4cnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:47:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F418CF02
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DD7D3093BCE
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57433C511;
	Tue, 24 Feb 2026 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyTjVHaw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAE226D00
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969626; cv=none; b=N5mywYdfCyIbVKDXN09PkJknWqHwY0DA+6DL7Sa53dWfATUdMCq8GO4EFeK6Zp6dBCHhnYjLSdflAY/gsF8l+a5skclCuC1uRpHg2SqISTjA/nMwlnNc4zcwUFoDgRzdqR4CvKZtvjd0WyA3yn5JRaIVyKf+A/m99i8NSKamtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969626; c=relaxed/simple;
	bh=6MxFsYQFuNrhGtFDC1RgM6Sk4nBEzv0PLz7C0W4vNpI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NT7j0RhAl8CUL1XqY/SHBpX2ejKqzN+lE8+CixQiJyyWFdIj0ok9uV9wXUdDjgeX4ZoMyQsMX8hybnckGjXO/iLyf1WWvbqLAOfpzH4v28mjs7+bDG6bxoXFzDonu4rCW5Ylv2V5dX+LOFn6MIyzL19pUSn2j2TpOsw3jmd8PeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyTjVHaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B9DC116D0;
	Tue, 24 Feb 2026 21:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969626;
	bh=6MxFsYQFuNrhGtFDC1RgM6Sk4nBEzv0PLz7C0W4vNpI=;
	h=Subject:To:Cc:From:Date:From;
	b=zyTjVHawk8Q1mnA6jl/5sBgmzentc2RUoEReiZqWqdABdAh8vdN7AS38UfQUP5j7B
	 sgIXiYW8L47dOMeWUEwq7GJIOZ1VJTPyRO005LH4Vd4xaG6vKITIhewozHYY5f0g/9
	 s538K3L292dFwMI4nZF31UVkoE8RFIdoeeDF3pwY=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: avoid Non-NCQ command starvation" failed to apply to 5.10-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,ipylypiv@google.com,john.g.garry@oracle.com,martin.petersen@oracle.com,yangxingui@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:46:59 -0800
Message-ID: <2026022459-backdrop-employee-9e12@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217992-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,oracle.com:email,gregkh:email,huawei.com:email]
X-Rspamd-Queue-Id: 857F418CF02
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0ea84089dbf62a92dc7889c79e6b18fc89260808
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022459-backdrop-employee-9e12@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ea84089dbf62a92dc7889c79e6b18fc89260808 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 17 Dec 2025 16:40:48 +0900
Subject: [PATCH] ata: libata-scsi: avoid Non-NCQ command starvation

When a non-NCQ command is issued while NCQ commands are being executed,
ata_scsi_qc_issue() indicates to the SCSI layer that the command issuing
should be deferred by returning SCSI_MLQUEUE_XXX_BUSY.  This command
deferring is correct and as mandated by the ACS specifications since
NCQ and non-NCQ commands cannot be mixed.

However, in the case of a host adapter using multiple submission queues,
when the target device is under a constant load of NCQ commands, there
are no guarantees that requeueing the non-NCQ command will be executed
later and it may be deferred again repeatedly as other submission queues
can constantly issue NCQ commands from different CPUs ahead of the
non-NCQ command. This can lead to very long delays for the execution of
non-NCQ commands, and even complete starvation for these commands in the
worst case scenario.

Since the block layer and the SCSI layer do not distinguish between
queueable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
implementation must ensure forward progress for non-NCQ commands in the
presence of NCQ command traffic. This is similar to what SAS HBAs with a
hardware/firmware based SAT implementation do.

Implement such forward progress guarantee by limiting requeueing of
non-NCQ commands from ata_scsi_qc_issue(): when a non-NCQ command is
received and NCQ commands are in-flight, do not force a requeue of the
non-NCQ command by returning SCSI_MLQUEUE_XXX_BUSY and instead return 0
to indicate that the command was accepted but hold on to the qc using
the new deferred_qc field of struct ata_port.

This deferred qc will be issued using the work item deferred_qc_work
running the function ata_scsi_deferred_qc_work() once all in-flight
commands complete, which is checked with the port qc_defer() callback
return value indicating that no further delay is necessary. This check
is done using the helper function ata_scsi_schedule_deferred_qc() which
is called from ata_scsi_qc_complete(). This thus excludes this mechanism
from all internal non-NCQ commands issued by ATA EH.

When a port deferred_qc is non NULL, that is, the port has a command
waiting for the device queue to drain, the issuing of all incoming
commands (both NCQ and non-NCQ) is deferred using the regular busy
mechanism. This simplifies the code and also avoids potential denial of
service problems if a user issues too many non-NCQ commands.

Finally, whenever ata EH is scheduled, regardless of the reason, a
deferred qc is always requeued so that it can be retried once EH
completes. This is done by calling the function
ata_scsi_requeue_deferred_qc() from ata_eh_set_pending(). This avoids
the need for any special processing for the deferred qc in case of NCQ
error, link or device reset, or device timeout.

Reported-by: Xingui Yang <yangxingui@huawei.com>
Reported-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: bdb01301f3ea ("scsi: Add host and host template flag 'host_tagset'")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Tested-by: Igor Pylypiv <ipylypiv@google.com>
Tested-by: Xingui Yang <yangxingui@huawei.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b96105481784..e888f2445692 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5644,6 +5644,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
+	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -6256,6 +6257,10 @@ static void ata_port_detach(struct ata_port *ap)
 		}
 	}
 
+	/* Make sure the deferred qc work finished. */
+	cancel_work_sync(&ap->deferred_qc_work);
+	WARN_ON(ap->deferred_qc);
+
 	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f4c9541d1910..72a22b6c9682 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -918,6 +918,12 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
 
 	ap->pflags |= ATA_PFLAG_EH_PENDING;
 
+	/*
+	 * If we have a deferred qc, requeue it so that it is retried once EH
+	 * completes.
+	 */
+	ata_scsi_requeue_deferred_qc(ap);
+
 	if (!fastdrain)
 		return;
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index be620bc04584..e7898bf56308 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1658,8 +1658,77 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
 	done(cmd);
 }
 
+void ata_scsi_deferred_qc_work(struct work_struct *work)
+{
+	struct ata_port *ap =
+		container_of(work, struct ata_port, deferred_qc_work);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * If we still have a deferred qc and we are not in EH, issue it. In
+	 * such case, we should not need any more deferring the qc, so warn if
+	 * qc_defer() says otherwise.
+	 */
+	qc = ap->deferred_qc;
+	if (qc && !ata_port_eh_scheduled(ap)) {
+		WARN_ON_ONCE(ap->ops->qc_defer(qc));
+		ap->deferred_qc = NULL;
+		ata_qc_issue(qc);
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
+void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ap->deferred_qc;
+	struct scsi_cmnd *scmd;
+
+	lockdep_assert_held(ap->lock);
+
+	/*
+	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
+	 * do not try to be smart about what to do with this deferred command
+	 * and simply retry it by completing it with DID_SOFT_ERROR.
+	 */
+	if (!qc)
+		return;
+
+	scmd = qc->scsicmd;
+	ap->deferred_qc = NULL;
+	ata_qc_free(qc);
+	scmd->result = (DID_SOFT_ERROR << 16);
+	scsi_done(scmd);
+}
+
+static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ap->deferred_qc;
+
+	lockdep_assert_held(ap->lock);
+
+	/*
+	 * If we have a deferred qc, then qc_defer() is defined and we can use
+	 * this callback to determine if this qc is good to go, unless EH has
+	 * been scheduled.
+	 */
+	if (!qc)
+		return;
+
+	if (ata_port_eh_scheduled(ap)) {
+		ata_scsi_requeue_deferred_qc(ap);
+		return;
+	}
+	if (!ap->ops->qc_defer(qc))
+		queue_work(system_highpri_wq, &ap->deferred_qc_work);
+}
+
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
@@ -1689,6 +1758,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	}
 
 	ata_qc_done(qc);
+
+	ata_scsi_schedule_deferred_qc(ap);
 }
 
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -1698,6 +1769,16 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	if (!ap->ops->qc_defer)
 		goto issue;
 
+	/*
+	 * If we already have a deferred qc, then rely on the SCSI layer to
+	 * requeue and defer all incoming commands until the deferred qc is
+	 * processed, once all on-going commands complete.
+	 */
+	if (ap->deferred_qc) {
+		ata_qc_free(qc);
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	}
+
 	/* Check if the command needs to be deferred. */
 	ret = ap->ops->qc_defer(qc);
 	switch (ret) {
@@ -1716,6 +1797,18 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	}
 
 	if (ret) {
+		/*
+		 * We must defer this qc: if this is not an NCQ command, keep
+		 * this qc as a deferred one and report to the SCSI layer that
+		 * we issued it so that it is not requeued. The deferred qc will
+		 * be issued with the port deferred_qc_work once all on-going
+		 * commands complete.
+		 */
+		if (!ata_is_ncq(qc->tf.protocol)) {
+			ap->deferred_qc = qc;
+			return 0;
+		}
+
 		/* Force a requeue of the command to defer its execution. */
 		ata_qc_free(qc);
 		return ret;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 89dd0ae2b991..9b4e578ad07e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -166,6 +166,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
 		struct ata_device *dev);
 int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
+void ata_scsi_deferred_qc_work(struct work_struct *work);
+void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
 
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index aa88244f3d83..d612d4c1660a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -899,6 +899,9 @@ struct ata_port {
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
 
+	struct work_struct	deferred_qc_work;
+	struct ata_queued_cmd	*deferred_qc;
+
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
 


