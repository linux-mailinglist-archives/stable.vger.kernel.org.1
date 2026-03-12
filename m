Return-Path: <stable+bounces-225206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CzgAsMjs2mASgAAu9opvQ
	(envelope-from <stable+bounces-225206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:36:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC027951F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF72321BEF5
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5DA37DE88;
	Thu, 12 Mar 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RyKElg36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EB2F1FED;
	Thu, 12 Mar 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347357; cv=none; b=dHZZHkfouOlnJWsA1MgnvJhajXthvnihoyHiqc05sb3ROFM+l4VNCsewYSV0TB1tXT28QwCMI4QWhyQ7seegU2IlqUmFM9OCBAiujFysmVGGiUEUclp4FBdwM251K34iJt29cB6wCpByXiJqklEbxUiqwLw11mmzT5KLD3MRlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347357; c=relaxed/simple;
	bh=KXZtLDFNEeic1/ccQV3AtwcQfqqsv5pa2cFOHCrTfzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDsNDIgZoF8F3mjS3GjSE7qv60/VrBzhYfT05HT5T8sVlUZzOBEM1v1hpsFQ0tIce9LZix4K0gSaYL+EjvDrWJtElJgU3y0ILdgEmic4NjGqYB2EMhtkHXPvaDpRkyL6S8r2dFdcjx2phPaknA0C4cao5Va2b5BtGontagJHPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RyKElg36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F95C4CEF7;
	Thu, 12 Mar 2026 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347356;
	bh=KXZtLDFNEeic1/ccQV3AtwcQfqqsv5pa2cFOHCrTfzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyKElg36ec+YgoGO+vmrVzMP/wSuET0AQNrycqeRwGiMrexKHkqDy8eM+cfL4VC3P
	 ounI/MngudQb+Ji58NTsWutSL2bQKUPIA07J/zfSp0m4IJ8JUrA185Y1DfiU14hWOv
	 zRcIjued5x6ONX8LQRvMl6lRomd2XlYLMQMMlL9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH 6.12 263/265] ata: libata-eh: correctly handle deferred qc timeouts
Date: Thu, 12 Mar 2026 21:10:50 +0100
Message-ID: <20260312201027.850997470@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-225206-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,1f77b8ca15336fff21ff];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 87AC027951F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit eddb98ad9364b4e778768785d46cfab04ce52100 upstream.

A deferred qc may timeout while waiting for the device queue to drain
to be submitted. In such case, since the qc is not active,
ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
which frees the qc. But as the port deferred_qc field still references
this finished/freed qc, the deferred qc work may eventually attempt to
call ata_qc_issue() against this invalid qc, leading to errors such as
reported by UBSAN (syzbot run):

UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
 ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fix this by checking if the qc of a timed out SCSI command is a deferred
one, and in such case, clear the port deferred_qc field and finish the
SCSI command with DID_TIME_OUT.

Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-eh.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -642,12 +642,28 @@ void ata_scsi_cmd_error_handler(struct S
 		set_host_byte(scmd, DID_OK);
 
 		ata_qc_for_each_raw(ap, qc, i) {
-			if (qc->flags & ATA_QCFLAG_ACTIVE &&
-			    qc->scsicmd == scmd)
+			if (qc->scsicmd != scmd)
+				continue;
+			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
+			    qc == ap->deferred_qc)
 				break;
 		}
 
-		if (i < ATA_MAX_QUEUE) {
+		if (qc == ap->deferred_qc) {
+			/*
+			 * This is a deferred command that timed out while
+			 * waiting for the command queue to drain. Since the qc
+			 * is not active yet (deferred_qc is still set, so the
+			 * deferred qc work has not issued the command yet),
+			 * simply signal the timeout by finishing the SCSI
+			 * command and clear the deferred qc to prevent the
+			 * deferred qc work from issuing this qc.
+			 */
+			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
+			ap->deferred_qc = NULL;
+			set_host_byte(scmd, DID_TIME_OUT);
+			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+		} else if (i < ATA_MAX_QUEUE) {
 			/* the scmd has an associated qc */
 			if (!(qc->flags & ATA_QCFLAG_EH)) {
 				/* which hasn't failed yet, timeout */



