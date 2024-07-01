Return-Path: <stable+bounces-56273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ADD91E901
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75760B215CD
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7E171641;
	Mon,  1 Jul 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCdmzE9d"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11C171069
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863890; cv=none; b=J2qs35Dh6/ZcXpaXrnvppW5iN26vH//zole6F+tS4fhCNDcpL1ik3+N0Ez03TmOEyl+0ZeoOHWTFKrOlVfSvPJ5BVPIDsQF1OJZD3cpGRwib4udvlmdrmwmXdul8DakGsi1Yot+l3LIQB47zw3Pl2YC7udZq6tTTxm3QGlADQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863890; c=relaxed/simple;
	bh=ZLjYMaL8Qyi9TVUaRicQazbm16gA30cvYVELDgT010w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMLWEjVbi4ER6fyt1yRKPAIzObGlIMYJgtKs+Sslo0WdVrEDP23aUtwAvo1c9xGt0OoKge8Mlyxs/Jah1nBTH4csVuCCNBCrSq+V44Q26w9ceQY6FTpE1aO8BAuyDqS+4VhOzwYVC6HDYWV6JqjvNG4GrOTfhFi9yBqqM0Ny7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCdmzE9d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f8a1b2969so61795837b3.3
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863888; x=1720468688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hpsMKkbWsm8xFwmpkpRI0G9chARJ4LR35R5atPcFvU=;
        b=MCdmzE9dPXnrId4NjSEtwGrKRXRI5bzz6t6TD1rL9BmIetsDJvKesMgn9Tr2ImszqR
         vJ7qZ1jkyw1ivPvkyTm5r5XqEg8WkTgAzkfUE3cGTuqrFmbEbIXHDS3+SzdxcKr14/fu
         cCCaAO4xGFki304NmHlcsBXcfev30Ka32pcFRWh4Am9AL2kx67JVSacX7irVP9Tkt7Ef
         I+8zAcMNw1IcZHNYqHXrjt6LRGinQbLlF8ae5/l8Hl2MbdS0PbKT08hN0oJqV6i5EnO/
         j2aWUGMpO6L+gKbCFm+Ov98QdQFIaaWo2/kZmSKE7WEL0pJknwQqXl/jUlsLPJK4v4xW
         Zptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863888; x=1720468688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hpsMKkbWsm8xFwmpkpRI0G9chARJ4LR35R5atPcFvU=;
        b=pC64SDATMbgnpsu7eGrI5QSjW0caM8CrJo48KHfVF88Y91Nkazyxj9suNGJxBlk01b
         8a6iTaQPUTO+iJzNtc2QxAp0EeK1QHKxqjU3+eKF2JSk8qnvkwOh8t3/Yk9qlqHhJ6JX
         Dl5VW8ax+yR5tgWJyns2i36AYN4u44eOFxs4InZXBataMSfq6IMfabeYkRK6IPb0DL32
         3HUt7uZOG3J13A9YOV1kBhv1X7IiB4q6KsgeYxQz0YT0sFoeRTQMpJSu8HBN6SawSSRr
         ja4sB2DAAwoWWrf94zppl1aknUVsdhcZhSYPICuJIlOZnoTcco1iBoacIlMnkzgaEO2a
         AIBw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqJQPlrhatuTfabyvikjdlRGT8c7wF0WyCInEIrY2Mx/uHFe/xPcvm7iQDMipLueXp0SdzkVIZbldh43P8fR5a2zBb+9m
X-Gm-Message-State: AOJu0YyXFwbX4SHmjzzAfKzsyPE1o3Wan7L0tPTagrkoY2wI8OTBJ49M
	m6kxSq+BVAI2vFsOhmK/0A3Tf0ttdPnFRJlPAfgrDX+hhes6/KMSAcZo7ro6PSZK/xPbvzDZNQf
	nH0/MPKCsqQ==
X-Google-Smtp-Source: AGHT+IFjzwVH/lDbFP6+5t+gbN7tDyJ7ZS3m5w81CUiAeq010hfBfbhybTg1/Btd5srp4wcEbmWfqUUz0u9acg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:d1a:b0:62d:1142:83a5 with SMTP
 id 00721157ae682-64c77ca3b5dmr940657b3.8.1719863887691; Mon, 01 Jul 2024
 12:58:07 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:52 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-3-ipylypiv@google.com>
Subject: [PATCH v4 2/8] ata: libata-scsi: Do not overwrite valid sense data
 when CK_COND=1
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Current ata_gen_passthru_sense() code performs two actions:
1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
2. Populates "ATA Status Return sense data descriptor" / "Fixed format
   sense data" with ATA taskfile fields.

The problem is that #1 generates sense data even when a valid sense data
is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
a separate function allows us to generate sense data only when there is
no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).

As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
which states that we don't want to translate taskfile registers into
sense descriptors for ATAPI.

Cc: stable@vger.kernel.org # 4.19+
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 72 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9e44ad4c2de..26b1263f5c7c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -230,6 +230,80 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
 				   SCSI_SENSE_BUFFERSIZE, information);
 }
 
+/**
+ *	ata_scsi_set_passthru_sense_fields - Set ATA fields in sense buffer
+ *	@qc: ATA PASS-THROUGH command.
+ *
+ *	Populates "ATA Status Return sense data descriptor" / "Fixed format
+ *	sense data" with ATA taskfile fields.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->result_tf;
+	unsigned char *sb = cmd->sense_buffer;
+
+	if ((sb[0] & 0x7f) >= 0x72) {
+		unsigned char *desc;
+		u8 len;
+
+		/* descriptor format */
+		len = sb[7];
+		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
+		if (!desc) {
+			if (SCSI_SENSE_BUFFERSIZE < len + 14)
+				return;
+			sb[7] = len + 14;
+			desc = sb + 8 + len;
+		}
+		desc[0] = 9;
+		desc[1] = 12;
+		/*
+		 * Copy registers into sense buffer.
+		 */
+		desc[2] = 0x00;
+		desc[3] = tf->error;
+		desc[5] = tf->nsect;
+		desc[7] = tf->lbal;
+		desc[9] = tf->lbam;
+		desc[11] = tf->lbah;
+		desc[12] = tf->device;
+		desc[13] = tf->status;
+
+		/*
+		 * Fill in Extend bit, and the high order bytes
+		 * if applicable.
+		 */
+		if (tf->flags & ATA_TFLAG_LBA48) {
+			desc[2] |= 0x01;
+			desc[4] = tf->hob_nsect;
+			desc[6] = tf->hob_lbal;
+			desc[8] = tf->hob_lbam;
+			desc[10] = tf->hob_lbah;
+		}
+	} else {
+		/* Fixed sense format */
+		sb[0] |= 0x80;
+		sb[3] = tf->error;
+		sb[4] = tf->status;
+		sb[5] = tf->device;
+		sb[6] = tf->nsect;
+		if (tf->flags & ATA_TFLAG_LBA48)  {
+			sb[8] |= 0x80;
+			if (tf->hob_nsect)
+				sb[8] |= 0x40;
+			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
+				sb[8] |= 0x20;
+		}
+		sb[9] = tf->lbal;
+		sb[10] = tf->lbam;
+		sb[11] = tf->lbah;
+	}
+}
+
 static void ata_scsi_set_invalid_field(struct ata_device *dev,
 				       struct scsi_cmnd *cmd, u16 field, u8 bit)
 {
@@ -837,10 +911,8 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
  *	ata_gen_passthru_sense - Generate check condition sense block.
  *	@qc: Command that completed.
  *
- *	This function is specific to the ATA descriptor format sense
- *	block specified for the ATA pass through commands.  Regardless
- *	of whether the command errored or not, return a sense
- *	block. Copy all controller registers into the sense
+ *	This function is specific to the ATA pass through commands.
+ *	Regardless of whether the command errored or not, return a sense
  *	block. If there was no error, we get the request from an ATA
  *	passthrough command, so we use the following sense data:
  *	sk = RECOVERED ERROR
@@ -875,63 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		 */
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
-
-	if ((sb[0] & 0x7f) >= 0x72) {
-		unsigned char *desc;
-		u8 len;
-
-		/* descriptor format */
-		len = sb[7];
-		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
-		if (!desc) {
-			if (SCSI_SENSE_BUFFERSIZE < len + 14)
-				return;
-			sb[7] = len + 14;
-			desc = sb + 8 + len;
-		}
-		desc[0] = 9;
-		desc[1] = 12;
-		/*
-		 * Copy registers into sense buffer.
-		 */
-		desc[2] = 0x00;
-		desc[3] = tf->error;
-		desc[5] = tf->nsect;
-		desc[7] = tf->lbal;
-		desc[9] = tf->lbam;
-		desc[11] = tf->lbah;
-		desc[12] = tf->device;
-		desc[13] = tf->status;
-
-		/*
-		 * Fill in Extend bit, and the high order bytes
-		 * if applicable.
-		 */
-		if (tf->flags & ATA_TFLAG_LBA48) {
-			desc[2] |= 0x01;
-			desc[4] = tf->hob_nsect;
-			desc[6] = tf->hob_lbal;
-			desc[8] = tf->hob_lbam;
-			desc[10] = tf->hob_lbah;
-		}
-	} else {
-		/* Fixed sense format */
-		sb[0] |= 0x80;
-		sb[3] = tf->error;
-		sb[4] = tf->status;
-		sb[5] = tf->device;
-		sb[6] = tf->nsect;
-		if (tf->flags & ATA_TFLAG_LBA48)  {
-			sb[8] |= 0x80;
-			if (tf->hob_nsect)
-				sb[8] |= 0x40;
-			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				sb[8] |= 0x20;
-		}
-		sb[9] = tf->lbal;
-		sb[10] = tf->lbam;
-		sb[11] = tf->lbah;
-	}
 }
 
 /**
@@ -1634,6 +1649,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	u8 *cdb = cmd->cmnd;
 	int need_sense = (qc->err_mask != 0) &&
 		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
+	int need_passthru_sense = (qc->err_mask != 0) ||
+		(qc->flags & ATA_QCFLAG_SENSE_VALID);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1645,13 +1662,16 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense))
-		ata_gen_passthru_sense(qc);
-	else if (need_sense)
+	    ((cdb[2] & 0x20) || need_passthru_sense)) {
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
+			ata_gen_passthru_sense(qc);
+		ata_scsi_set_passthru_sense_fields(qc);
+	} else if (need_sense) {
 		ata_gen_ata_sense(qc);
-	else
+	} else {
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
+	}
 
 	ata_qc_done(qc);
 }
@@ -2590,14 +2610,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	/* handle completion from EH */
 	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 
-		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
-			/* FIXME: not quite right; we don't want the
-			 * translation of taskfile registers into a
-			 * sense descriptors, since that's only
-			 * correct for ATA, not ATAPI
-			 */
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
 			ata_gen_passthru_sense(qc);
-		}
 
 		/* SCSI EH automatically locks door if sdev->locked is
 		 * set.  Sometimes door lock request continues to
-- 
2.45.2.803.g4e1b14247a-goog


