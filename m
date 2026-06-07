Return-Path: <stable+bounces-261105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGw6DyBGJWq7FgIAu9opvQ
	(envelope-from <stable+bounces-261105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBF64F8FD
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KQVLsIjs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261105-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261105-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F13304DCA0
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D282308F0A;
	Sun,  7 Jun 2026 10:14:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531041E98EF;
	Sun,  7 Jun 2026 10:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827278; cv=none; b=JwzF2RKE6LKzxspsnt0FPyzkNrYWIKAJZnk0/PggXF4N7JofYwr6AtuwzMbx1SHN8rZbiFHSoGk4r88sPgUR+rStSbF2ldBaUv939BpffPs9/0YtpANOJgVqDtuiND/qG19RlUeBoQ2cYmRgZu3RpDRuvmW/SpWM4wIZidfis3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827278; c=relaxed/simple;
	bh=nvbPHC8ueSV6EACXFlU6UqvEmVWixrQQ5TiBKKiwEog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIpoQ5nKDsnFbHbg7usXc2ydOWiCrp2qhKRKX0yEfE2fDn2E5BfpINthk0XMVHcLGcbZr2M3Wn4fpEQ2LZzlcWcvXuqeN7Ij+r5LWH27jsP+8mnT7FSMvohLHI9tqHHVbkMj8Pdj8H+cojKCSlHW0rIwuVr6eE0mDB0Iy+/c9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQVLsIjs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D011F00893;
	Sun,  7 Jun 2026 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827277;
	bh=on1HTev623nBBxHa6f2SN4L28R27jIEL44LwpdejuZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQVLsIjs57Y0qmfdsjV9zIqpP7EOSUXLZG9EUoVtNFv3ciYsdXrDM82XhRnJPEXjF
	 B6Ae4hF6JFkcMK+8PC2girQB37FRddxYxAT+gY9W2XQ4VcPCPuokpdlsuM3xjDyulI
	 mmbegYRuNvylTL3oYzFoCQSePdLqBMXxdUX1nhFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jeffery <djeffery@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 041/307] scsi: core: Run queues for all non-SDEV_DEL devices from scsi_run_host_queues
Date: Sun,  7 Jun 2026 11:57:18 +0200
Message-ID: <20260607095729.204061798@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261105-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:djeffery@redhat.com,m:bvanassche@acm.org,m:martin.petersen@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2FBF64F8FD

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 55717fd3234be2..d63d10d53a2aad 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -569,10 +569,33 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
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




