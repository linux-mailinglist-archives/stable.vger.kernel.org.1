Return-Path: <stable+bounces-270391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0WMObY7RmrWMQsAu9opvQ
	(envelope-from <stable+bounces-270391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A63556F5D09
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HxDuEocg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270391-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270391-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0F393078864
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39E47DD64;
	Thu,  2 Jul 2026 10:04:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519747DD62;
	Thu,  2 Jul 2026 10:04:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986689; cv=none; b=KS9bSOZ+zTOOckSpy+ilEMporMX4kWV83jtNPnJlRQU1T8ttbT0aoxJANIpBOn3a3GifYsvYI1ZapLwHAcmVSa+ZBrD+NMaiqlPrldMpzlSr8kuNk8vLogrpGcrNrPMVi2aui6uQDvClfr31TtBAoHs7+nRqzZ7f5qC4kxu20Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986689; c=relaxed/simple;
	bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nranW1GWdzQuV5jWqR9+RacVh2ZghOJhXlX2trVd3UYQipN9VNQlhtjExUlye3MorQnekAoUvZwZxT0rpoX3x9AJPe+3dPxGzHTV7WqPfSFnj2Uc7RpVfX2Z75Nf+AJqzktolLWahFdlr4oH3nsWH0pSFAgJuHFEV/vVB1kblCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxDuEocg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1E1F000E9;
	Thu,  2 Jul 2026 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986687;
	bh=7MolXIuFQCcEw6yux0O93RhUgjvcHpLOfWblU4nHW8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxDuEocgJ3cV0esalapJsMfCJ/kiZWX9cVhDXlDGWQ0SR0vF6ws8LmpClIDUtyMh3
	 Ex9APq6eEKQSCPIqd2NyNB/TvV6tD1GUve4U9Rf5o4b/GM3DOWEr2SiAXahg55jANW
	 NnYgsm2zHWsZMkrWeL6Rn+Hr7ZEIuYywI3z7CXD/hwx79FuMvKHcHoRqkjMYDlVeyf
	 hyxQQw4yCbDsfhW2uUkfMgQr5ui8NvP9/JGddpaWPvTdfxPhNRdycMIdvG3I7BK+m9
	 CrL9QwCqJZwkZfesnncX1BIR5O9ctRNafvKK64cxS7PM2WFjzeXdWZZ+J4e1NpOi3z
	 7Qzo7iXrcAxDQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shaun Tancheff <shaun@tancheff.com>,
	Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 1/2] ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
Date: Thu,  2 Jul 2026 12:04:12 +0200
Message-ID: <20260702100410.2039383-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702100410.2039383-4-cassel@kernel.org>
References: <20260702100410.2039383-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4442; i=cassel@kernel.org; h=from:subject; bh=L6oSNd7GV2jSHo+ihp6kJpgSCebZhaMLZbUN60878YM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLczOf/ZVd4avNSMGLeiZCDpVtWs0Xur3DOydJ+vuZE8 EnmAy/iO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARPWuG/4FZ0a762o15b/7q rXiYurlwwi+ro4pPSjWLCuZM22aw+jDDX6nLTX7+CpPO3zGcbqP1+fnqVrdb4gfcdqT+nfal739 kPRcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270391-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:cassel@kernel.org,m:shaun@tancheff.com,m:tj@kernel.org,m:hare@kernel.org,m:stable@vger.kernel.org,m:linux-ide@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A63556F5D09

ata_scsi_write_same_xlat() translates a SCSI WRITE SAME command with the
UNMAP bit set into an ATA DATA SET MANAGEMENT TRIM command.  The TRIM
descriptor is built by ata_format_dsm_trim_descr() into the 2048-byte
ata_scsi_rbuf staging buffer, and the number of bytes copied is compared
against the logical sector size by the caller:

	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
	if (size != len)		/* len == sdp->sector_size */
		goto invalid_param_len;

ata_format_dsm_trim_descr() clamps the copy length to ATA_SCSI_RBUF_SIZE
(2048).  On a device whose logical sector size exceeds that (e.g. a 4Kn
device, where sector_size == 4096) the function can never return more than
2048, while the caller expects it to return sector_size.  The comparison
therefore always fails, so every TRIM is rejected with "Parameter list
length error" and WARN_ON() splats on each attempt.  TRIM / discard is
thus completely broken on such devices.

The descriptor was incorrectly sized from the logical sector size.  A DSM
TRIM payload is a list of 512-byte pages, each holding up to
ATA_MAX_TRIM_RNUM (64) LBA Range Entries, and is independent of the logical
sector size.  The Block Limits VPD page already advertises a single such
page as the maximum WRITE SAME length (65535 * ATA_MAX_TRIM_RNUM logical
blocks), so the block layer never sends a request that needs more than one
page.

Emit exactly one 512-byte page, independent of the logical sector size,
and transfer only that page (COUNT == 1).  For a 512-byte-sector device
this is unchanged; devices with larger logical sectors now work instead of
failing every TRIM.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Fixes: ef2d7392c4ec ("libata: SCT Write Same / DSM Trim")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..429b03a08071 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3447,17 +3447,13 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
 					u64 sector, u32 count)
 {
-	struct scsi_device *sdp = cmd->device;
-	size_t len = sdp->sector_size;
+	size_t len = ATA_SECT_SIZE;
 	size_t r;
 	__le64 *buf;
 	u32 i = 0;
 	unsigned long flags;
 
-	WARN_ON(len > ATA_SCSI_RBUF_SIZE);
-
-	if (len > ATA_SCSI_RBUF_SIZE)
-		len = ATA_SCSI_RBUF_SIZE;
+	BUILD_BUG_ON(ATA_SECT_SIZE > ATA_SCSI_RBUF_SIZE);
 
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 	buf = ((void *)ata_scsi_rbuf);
@@ -3492,13 +3488,11 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct scsi_cmnd *scmd = qc->scsicmd;
-	struct scsi_device *sdp = scmd->device;
-	size_t len = sdp->sector_size;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
-	const u32 trmax = len >> 3;
+	const u32 trmax = ATA_MAX_TRIM_RNUM;
 	u32 size;
 	u16 fp;
 	u8 bp = 0xff;
@@ -3542,13 +3536,13 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 
 	/*
-	 * size must match sector size in bytes
-	 * For DATA SET MANAGEMENT TRIM in ACS-2 nsect (aka count)
-	 * is defined as number of 512 byte blocks to be transferred.
+	 * The TRIM descriptor is a single 512-byte page, which is the maximum
+	 * WRITE SAME length advertised in the Block Limits VPD page. For DATA
+	 * SET MANAGEMENT TRIM the COUNT field (aka nsect) is the number of
+	 * 512-byte blocks to be transferred.
 	 */
-
 	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
-	if (size != len)
+	if (size != ATA_SECT_SIZE)
 		goto invalid_param_len;
 
 	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
@@ -3574,6 +3568,12 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		     ATA_TFLAG_WRITE;
 
 	ata_qc_set_pc_nbytes(qc);
+	/*
+	 * The DSM TRIM payload is a single 512-byte page, which may be smaller
+	 * than the WRITE SAME data-out buffer (one logical block); only
+	 * transfer that page so the length matches the COUNT field.
+	 */
+	qc->nbytes = size;
 
 	return 0;
 
-- 
2.55.0


