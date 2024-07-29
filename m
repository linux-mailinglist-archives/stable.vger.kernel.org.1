Return-Path: <stable+bounces-62395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24E93EF15
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8A2844B6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E161EB2C;
	Mon, 29 Jul 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jt+wx3sg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106D12C559
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239629; cv=none; b=nxX0XPecplJpwcr8kPNo8KR3q12hcUrA64cYsr4sZaOmL5BrSuLpRgcsYR14MRR7dEF8zt/LKkssQAZUwWAVk8Dor8hoHYxupGl71tS19n4+GBnUexFZYARNjzaOoXuKCiq3teU1Q7QXgpFHJjN0BhWjqOiEQxaL3jVPHKhwvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239629; c=relaxed/simple;
	bh=D2DGEsf1YQQI4o3Hz2OdhyJz5wk2oHKAfaFV+nrDCBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nx13ejm7+t2nd1OgmRpSOxv4/61TMoZ8EW0+HXFFgypMnWxU+ZnEz7b1sLnOsJDLxrQp+A76hSAIsy6BLgxvLkiNvrW95yJU5wGLI5Bkn/PEobbIYVHVbfYZZ20amev7OHE8d5ryoLv2pI+jxYbMtjFSTq63Vr0CkZY62JjNQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jt+wx3sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC8CC32786;
	Mon, 29 Jul 2024 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239629;
	bh=D2DGEsf1YQQI4o3Hz2OdhyJz5wk2oHKAfaFV+nrDCBM=;
	h=Subject:To:Cc:From:Date:From;
	b=jt+wx3sg+fz5LIowttDdZ6p6+aLU2vkgoWuGfPhuOmbunQuW+rtH9LLDmxpeH3GUm
	 iWV27WNo1NRaa98vk63ddMJSLqfTydIuBV1iV0yQ/UVcbnzaVblB9DYmySSBlH/8Jk
	 o4wJTe1c682OW5wQDf063QX2zBhb1iB7kZpG5Zgk=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Do not overwrite valid sense data when" failed to apply to 5.15-stable tree
To: ipylypiv@google.com,cassel@kernel.org,dlemoal@kernel.org,hare@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:53:43 +0200
Message-ID: <2024072943-backup-snaking-6c85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 97981926224afe17ba3e22e0c2b7dd8b516ee574
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072943-backup-snaking-6c85@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

97981926224a ("ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1")
38dab832c3f4 ("ata: libata-scsi: Fix offsets for the fixed format sense data")
ff8072d589dc ("ata: libata: remove references to non-existing error_handler()")
3ac873c76d79 ("ata: libata-core: fix when to fetch sense data for successful commands")
18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
eafe804bda7b ("scsi: ata: libata: Set read/write commands CDL index")
df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
673b2fe6ff1d ("scsi: ata: libata-scsi: Add support for CDL pages mode sense")
62e4a60e0cdb ("scsi: ata: libata: Detect support for command duration limits")
bc9af4909406 ("ata: libata: Fix FUA handling in ata_build_rw_tf()")
4d2e4980a528 ("ata: libata: cleanup fua support detection")
7574a8377c7a ("ata: libata-scsi: do not overwrite SCSI ML and status bytes")
87aab3c4cd59 ("ata: libata: move NCQ related ATA_DFLAGs")
876293121f24 ("ata: scsi: rename flag ATA_QCFLAG_FAILED to ATA_QCFLAG_EH")
b83ad9eec316 ("ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()")
3d8a3ae3d966 ("ata: libata: fix commands incorrectly not getting retried during NCQ error")
4cb7c6f1ef96 ("ata: make use of ata_port_is_frozen() helper")
cb6e73aaadff ("ata: libata-eh: Remove the unneeded result variable")
066de3b9d93b ("ata: libata-core: Simplify ata_build_rw_tf()")
e00923c59e68 ("ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97981926224afe17ba3e22e0c2b7dd8b516ee574 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Tue, 2 Jul 2024 02:47:30 +0000
Subject: [PATCH] ata: libata-scsi: Do not overwrite valid sense data when
 CK_COND=1

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

Additionally, always set SAM_STAT_CHECK_CONDITION when CK_COND=1 because
SAT specification mandates that SATL shall return CHECK CONDITION if
the CK_COND bit is set.

The ATA PASS-THROUGH handling logic in ata_scsi_qc_complete() is hard
to read/understand. Improve the readability of the code by moving checks
into self-explanatory boolean variables.

Cc: stable@vger.kernel.org # 4.19+
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20240702024735.1152293-3-ipylypiv@google.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a0c68b0a00c4..a9d2a1cf4c3d 100644
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
@@ -1632,26 +1647,32 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
-	int need_sense = (qc->err_mask != 0) &&
-		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
+	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
+	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
-	 * generate because the user forced us to [CK_COND =1], a check
+	 * generate because the user forced us to [CK_COND=1], a check
 	 * condition is generated and the ATA register values are returned
 	 * whether the command completed successfully or not. If there
-	 * was no error, we use the following sense data:
+	 * was no error, and CK_COND=1, we use the following sense data:
 	 * sk = RECOVERED ERROR
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
-	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense))
-		ata_gen_passthru_sense(qc);
-	else if (need_sense)
+	if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
+		if (!have_sense)
+			ata_gen_passthru_sense(qc);
+		ata_scsi_set_passthru_sense_fields(qc);
+		if (is_ck_cond_request)
+			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
-	else
+	} else {
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
+	}
 
 	ata_qc_done(qc);
 }
@@ -2590,14 +2611,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
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


