Return-Path: <stable+bounces-251118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLn1BoHtDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-251118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B740593681
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C006B310B67F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C063F23D5;
	Wed, 20 May 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARoQ4aKu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA87370D54;
	Wed, 20 May 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297145; cv=none; b=e5/SLBFSJwhJ5kLn9IylxPkdH9fwojGYjgfsKPe9s7VT7ITh/Bj6U0guUjUp281vUvBtnbMEasIswam7/jMaxRgeJUg7ALEhZahCb1Ex+f3NA+TeUtPYGqcLaYYEcMBgGnAcztb/GKkWOY1QuZvrqoY5kLImpsmHxeOP+aa/c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297145; c=relaxed/simple;
	bh=snW4Cjbpy32Dp3M/1G+hpiY71wZlIqu0rFBWCeb0GBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDT0aIaWc9UXAJjN/ep76oHcw/eRi7MvU8+oe3XJ2lR38KzDwCyGVGbvJEU/TToMfequ51I3g9rXWblRgwHGsRCqoUjrpC0UcumMZX7cj632/hi4fD5qbBPNFE8XFBrbtZ9NLUaCe6kIuTm4mx2xiuvxn3fQQe0bx+u83oGuPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARoQ4aKu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634C41F000E9;
	Wed, 20 May 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297143;
	bh=epcKdMHUzS4cDPuW1IWO6QuUJ11bbwS3vFRQgbQW+Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARoQ4aKuf+bwKMHS4Y/po4ZPFsnBubCbX2xbfXI/A6xa9iXuKJD/gywZqv17X4mKJ
	 Y1BZ6eUkiPnu99T8e1YeBFUseQ/L/TVWg4yTIBYNMMHn7KW2FbyxtwGw9r4GBOPHkf
	 qE7XgJ6nJkqDGT2/NmhqBeEbV/+IAVQY7xexF4OA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 1067/1146] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
Date: Wed, 20 May 2026 18:21:57 +0200
Message-ID: <20260520162212.379164809@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251118-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8B740593681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Pylypiv <ipylypiv@google.com>

[ Upstream commit 8ebf408e7d463eee02c348a3c8277b95587b710d ]

Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
during resets or NCQ failures. This deferral logic completed commands
with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.

However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
to zero. This causes the mid-layer to fail the command immediately
instead of retrying, even though the command was never actually issued
to the hardware.

Switch to DID_REQUEUE to ensure these commands are inserted back into
the request queue regardless of retry limits.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3b65df914ebbe..cd607911d7248 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1692,7 +1692,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	/*
 	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
 	 * do not try to be smart about what to do with this deferred command
-	 * and simply retry it by completing it with DID_SOFT_ERROR.
+	 * and simply requeue it by completing it with DID_REQUEUE.
 	 */
 	if (!qc)
 		return;
@@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	ap->deferred_qc = NULL;
 	cancel_work(&ap->deferred_qc_work);
 	ata_qc_free(qc);
-	scmd->result = (DID_SOFT_ERROR << 16);
+	scmd->result = (DID_REQUEUE << 16);
 	scsi_done(scmd);
 }
 
-- 
2.53.0




