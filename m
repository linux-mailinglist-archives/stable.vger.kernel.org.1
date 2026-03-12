Return-Path: <stable+bounces-225207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLP+F0Yjs2mASgAAu9opvQ
	(envelope-from <stable+bounces-225207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:34:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 976E727946B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B76BC3068204
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54137DE84;
	Thu, 12 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvuSS1jq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F59373BE0;
	Thu, 12 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347360; cv=none; b=fhxp0tgoVZvqzrcT+KVpMWTIJk4X1/13IbbhFMqJHTnUsDTFmnONL0Stpht6IO7GiQUllD2hDypTTC2InwaaAQCevh7egQbQ3imNdP9zC1Q/oZWtMKAGFExOcwrInRiBuCB4vCDVSzhZSNA4z4sR+kKULx48BLZvKx5yqyDI4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347360; c=relaxed/simple;
	bh=iZ8IEbV+gWNjLYXrvZB0rHfem8YAop3PEA3jcZRPyOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlP18Ir9owsjbRC62ZobRV2vlngu/HOoTxrGME627LZJZTTma61jhgLrh1ggLzUyRfVQ8aBk7DS6H9L0U3UUIm63WMwykt44kbYW6l3wCjr1t0bDuCq0nJ8VXqqFE2a/mq5ireZLOeZmKe5bf3JDnLXGi8MUe+MFDVIT3G8VfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvuSS1jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22FBC4CEF7;
	Thu, 12 Mar 2026 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347360;
	bh=iZ8IEbV+gWNjLYXrvZB0rHfem8YAop3PEA3jcZRPyOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvuSS1jqlMvSJBdW0QBgsurcMbP7U36lxEn2i0jAEYKa4TASOKoyuOF+OmNhGozmo
	 QFjyez5hNrMx3Apm0tamqs2XoSL1i5EWhN+RmRWj6nvx6KKWZlXRwy2534bUjVXWX8
	 VBlEa5CffWVf1krLFWSCT3HQZ/Iawbm9+reF4VFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com,
	Igor Pylypiv <ipylypiv@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.12 264/265] ata: libata: cancel pending work after clearing deferred_qc
Date: Thu, 12 Mar 2026 21:10:51 +0100
Message-ID: <20260312201027.890051962@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225207-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bcaf842a1e8ead8dfb89];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 976E727946B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit aac9b27f7c1f2b2cf7f50a9ca633ecbbcaf22af9 upstream.

Syzbot reported a WARN_ON() in ata_scsi_deferred_qc_work(), caused by
ap->ops->qc_defer() returning non-zero before issuing the deferred qc.

ata_scsi_schedule_deferred_qc() is called during each command completion.
This function will check if there is a deferred QC, and if
ap->ops->qc_defer() returns zero, meaning that it is possible to queue the
deferred qc at this time (without being deferred), then it will queue the
work which will issue the deferred qc.

Once the work get to run, which can potentially be a very long time after
the work was scheduled, there is a WARN_ON() if ap->ops->qc_defer() returns
non-zero.

While we hold the ap->lock both when assigning and clearing deferred_qc,
and the work itself holds the ap->lock, the code currently does not cancel
the work after clearing the deferred qc.

This means that the following scenario can happen:
1) One or several NCQ commands are queued.
2) A non-NCQ command is queued, gets stored in ap->deferred_qc.
3) Last NCQ command gets completed, work is queued to issue the deferred
   qc.
4) Timeout or error happens, ap->deferred_qc is cleared. The queued work is
   currently NOT canceled.
5) Port is reset.
6) One or several NCQ commands are queued.
7) A non-NCQ command is queued, gets stored in ap->deferred_qc.
8) Work is finally run. Yet at this time, there is still NCQ commands in
   flight.

The work in 8) really belongs to the non-NCQ command in 2), not to the
non-NCQ command in 7). The reason why the work is executed when it is not
supposed to, is because it was never canceled when ap->deferred_qc was
cleared in 4). Thus, ensure that we always cancel the work after clearing
ap->deferred_qc.

Another potential fix would have been to let ata_scsi_deferred_qc_work() do
nothing if ap->ops->qc_defer() returns non-zero. However, canceling the
work when clearing ap->deferred_qc seems slightly more logical, as we hold
the ap->lock when clearing ap->deferred_qc, so we know that the work cannot
be holding the lock. (The function could be waiting for the lock, but that
is okay since it will do nothing if ap->deferred_qc is not set.)

Reported-by: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-eh.c   |    1 +
 drivers/ata/libata-scsi.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -661,6 +661,7 @@ void ata_scsi_cmd_error_handler(struct S
 			 */
 			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
 			ap->deferred_qc = NULL;
+			cancel_work(&ap->deferred_qc_work);
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
 		} else if (i < ATA_MAX_QUEUE) {
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1712,6 +1712,7 @@ void ata_scsi_requeue_deferred_qc(struct
 
 	scmd = qc->scsicmd;
 	ap->deferred_qc = NULL;
+	cancel_work(&ap->deferred_qc_work);
 	ata_qc_free(qc);
 	scmd->result = (DID_SOFT_ERROR << 16);
 	scsi_done(scmd);



