Return-Path: <stable+bounces-249642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNQeKLOUDGp1jAUAu9opvQ
	(envelope-from <stable+bounces-249642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:49:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A7582A16
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAC6B3030EAD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A834ADD96;
	Tue, 19 May 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eczbGY5r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E932B116;
	Tue, 19 May 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208626; cv=none; b=D8pU2Su6guyngI6skJIdeR8vIBYTkJdcjmkQKeopixTR/fkqzxecZru5F/gnz2Ne+CYCatAQ4CIirprRCJ1E5QycbB63J/7+FX58BJywM1YGJIPZc1ek1rQ4Q6uaEumhtANyCRltxmdQbttERdUHk5m0sjpbYBZcSphdaWOrMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208626; c=relaxed/simple;
	bh=Gdghk+MZjnZXo8YtnLWvMk2Ms40s8zJKGg4lYjsfmnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9Lmxt0zTrdGlHHtlrWq7zSjDCjhLhn+jXVG1nNijY93xNPbKYjagGu27VmcySLI+fPbkDcx7bDqLXZroiSoRDidrVcTdh/76ZveeTl3loY8TvQJrNIxKEUujc2fUFU9yBkXdlYmK9pU44YWXj1Bh+NTjku55s5e7sYopzMMCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eczbGY5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A85C2BCB3;
	Tue, 19 May 2026 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208626;
	bh=Gdghk+MZjnZXo8YtnLWvMk2Ms40s8zJKGg4lYjsfmnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eczbGY5rwwuA6NkuR0zLT4BxSVMLXhAeCAovn6xlS40A1E5weEDhNloEkQ8OndkGF
	 LNdXnow0ihFXy7L+p/6DYGrqqu1nvt0RSyGDa0wEWBXRQHX90pLcqvie8GvSDGki1V
	 x+/9wXIDy9oBTClXlNcd4GK51d+vVHF7qepuafEA+EkbXCpDx5MiCOGStyMnV69oq2
	 EnKY8cwgKHD8aK5sHbPfxqoobU2vQ4/uUO7taJHsUa/Em2DBKUGX0dO0lDnfRv/wWf
	 iYA/kfSDKBgjyUDt8yO+iYqMNVLPASQtk0kZphEQAqEu/eGm6iGXI3Mbfg58Y7NJkW
	 eK3d1Ftogl86w==
Date: Tue, 19 May 2026 18:37:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: "ipylypiv@google.com" <ipylypiv@google.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Wiese <charon56@proton.me>
Subject: stable backport request: [PATCH v2] ata: libata-scsi: fix requeue of
 deferred ATA PASS-THROUGH commands
Message-ID: <agyRrnU_Oyh79_d8@ryzen>
References: <-LfISXRga4ryMCYwCMNrhBwgNW6mZ9xx8AWX-Y7B0WwEyZr_8BHlTEgNarxj36MY0Yu-79B93UH7ISr1OmMrRqAbO_LYmZjUgtkE0MoxB5M=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hV/uP8JWeTuWMGxa"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <-LfISXRga4ryMCYwCMNrhBwgNW6mZ9xx8AWX-Y7B0WwEyZr_8BHlTEgNarxj36MY0Yu-79B93UH7ISr1OmMrRqAbO_LYmZjUgtkE0MoxB5M=@proton.me>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C89A7582A16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hV/uP8JWeTuWMGxa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, May 16, 2026 at 10:53:02AM +0000, Christoph Wiese wrote:
> (my orginal email was html formated, sorry about that)
> 
> Hi Niklas,
> 
> I notice you already flagged this for backporting to 7.0 stable. Please also include 6.12.y - the buggy parent commit 0ea84089dbf6 was backported to 6.12.77 as 5d61a38a60e6, and the bug reproduces there.
> 
> Symptom: parallel sedutil-cli --setLockingRange against multiple ATA OPAL SEDs causes one random drive per invocation to receive a zero-length TRUSTED RECEIVE response ("One or more header fields have 0 length / Session start failed rc = 136"). The OPAL session is opened on the drive by the TRUSTED SEND but the matching TRUSTED RECEIVE is failed at the SCSI mid-layer (scmd->allowed == 0 for SG_IO), leaving an orphan session that only a cold power cycle clears.
> 
> Bisect on Debian's 6.12.y kernel (which carries 5d61a38a60e6 unmodified): 6.12.74 works, 6.12.86 broken. I've been running 8ebf408 locally as a cherry-pick on 6.12.88 for ~24h; six OPAL SEDs unlock cleanly on every boot.
> 
> Thanks for the fix.

Dear stable maintainers,

Could you please help with backporting commit 8ebf408e7d46 ("ata:
libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands")

to the relevant stable kernels?

It gets a conflict when cherry-picking, so I have attached a version
that can be applied without conflicts.


Kind regards,
Niklas

--hV/uP8JWeTuWMGxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ata-libata-scsi-fix-requeue-of-deferred-ATA-PASS-THR.patch

From b80ea77afafdc0205abd9026a6ced59f618dbd62 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Sun, 12 Apr 2026 08:36:37 -0700
Subject: [PATCH] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH
 commands

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
(cherry picked from commit 8ebf408e7d463eee02c348a3c8277b95587b710d)
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3b65df914ebb..cd607911d724 100644
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
2.54.0


--hV/uP8JWeTuWMGxa--

