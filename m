Return-Path: <stable+bounces-261014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCxON11DJWpHFQIAu9opvQ
	(envelope-from <stable+bounces-261014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6EB64F5BE
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="vf/kSX2n";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261014-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261014-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A0CE300AEC1
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53D2E7F0A;
	Sun,  7 Jun 2026 10:09:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA2285CAE;
	Sun,  7 Jun 2026 10:09:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826971; cv=none; b=TddSOzMgXeN6uBWXB+u7QM9+1/vm3EBlPukg836nmDK9qKyxe0UKGyq/NoX9PLXgZ80tGXdHuS8ffoCRUmWO83G/je710+2unMpnt83+2fWwLnH0xkZHF5A1oiXT466L8ovgq1GS4UBIRcbXp+yfc96/DFX9P+tGF+/gO53jFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826971; c=relaxed/simple;
	bh=Dz9r5pkspURZiJ/XJ+Yn0ISsgtYQT+3T6s61w7A4/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNT+Bc5VuZvCAVKfV7aGJa4p4c3wXxKRsq4TJjam8PXnArAaPJcHHxAMa7cBwE520GV1G1yzQDWd8dRX/WvZA/rSK6mOYlMgiOzwyFx8Os+56gv/lzSCl4FJO/qfy+OmZMLIdQLhiuSaGTudZA+klyXoH102itLD8doBQm59ehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vf/kSX2n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAF91F00893;
	Sun,  7 Jun 2026 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826970;
	bh=HTGYa15dyeNXwLNuF3zvWOQ2YdbmzCxxRxmBxOkFRts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vf/kSX2nJ7jqRqhQHK5DGjDxb0xuyGEW4NPprnilWhSAHQP+eBfq5PuECm2wNCqsQ
	 aKVnNglTqeK4ZnSKhig6Fa9D95/WskOE3hoIsihlpJJKPpUW9IRTGXw1/BpaX7epVo
	 HREQ5v6LcE8NfJbCe3NIfBjLlsDisxyrATIiiPMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jeffery <djeffery@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 027/315] scsi: core: Run queues for all non-SDEV_DEL devices from scsi_run_host_queues
Date: Sun,  7 Jun 2026 11:56:54 +0200
Message-ID: <20260607095728.497218331@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261014-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:djeffery@redhat.com,m:bvanassche@acm.org,m:martin.petersen@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F6EB64F5BE

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Jeffery <djeffery@redhat.com>

[ Upstream commit 7205b58702273baf21d6ba7992e6ba15852325f7 ]

While a SCSI host is in a recovery state, scsi_mq_requeue_cmd() will not
set the requeue list for a requeued command to be kicked in the future.
The expectation is a call to scsi_run_host_queues() will kick all SCSI
devices once the recovery state is cleared.

However, scsi_run_host_queues() uses shost_for_each_device() which uses
scsi_device_get() and so will ignore devices in a partially removed
state like SDEV_CANCEL. But these devices may also have requeued
requests, leaving their requests stuck from not being kicked and causing
the removal process of the device to hang.

scsi_run_host_queues() needs to run against more devices than the macro
shost_for_each_device() allows. Instead of using the too limiting
scsi_device_get() state checks, only ignore devices in SDEV_DEL state or
when unable to acquire a reference. Attempt to run the queues for all
other devices when scsi_run_host_queues() is called.

Fixes: 8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")
Signed-off-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260515180941.9698-1-djeffery@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7ddb73cd6d9fe5..3f7ba6d3987f15 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -572,10 +572,33 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
 void scsi_run_host_queues(struct Scsi_Host *shost)
 {
-	struct scsi_device *sdev;
+	struct scsi_device *sdev, *prev = NULL;
+	unsigned long flags;
 
-	shost_for_each_device(sdev, shost)
+	spin_lock_irqsave(shost->host_lock, flags);
+	__shost_for_each_device(sdev, shost) {
+		/*
+		 * Only skip devices so deep into removal they will never need
+		 * another kick to their queues. Thus scsi_device_get() cannot
+		 * be used as it would skip devices in SDEV_CANCEL state which
+		 * may need a queue kick.
+		 */
+		if (sdev->sdev_state == SDEV_DEL ||
+		    !get_device(&sdev->sdev_gendev))
+			continue;
+		spin_unlock_irqrestore(shost->host_lock, flags);
+
+		if (prev)
+			put_device(&prev->sdev_gendev);
 		scsi_run_queue(sdev->request_queue);
+
+		prev = sdev;
+
+		spin_lock_irqsave(shost->host_lock, flags);
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
+	if (prev)
+		put_device(&prev->sdev_gendev);
 }
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
-- 
2.53.0




