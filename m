Return-Path: <stable+bounces-62392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748293EF10
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2031F21494
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD9A12C522;
	Mon, 29 Jul 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcFT31h4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45384A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239577; cv=none; b=D8+5fR0HCFRl/2G0q4g77UzxyiDple60j7oIjliWwwkK5mLu59SJ1mSfk9J31sCamvcSSUpjIpiQ8ydBM6DijmW1lQc6IwE2wPKjnQYOmn6AAwWkmntf+OKYh68JdaOUJbUP51eGz7FxapTpQU2NvwOZc4xEtQG+HObM/Aluehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239577; c=relaxed/simple;
	bh=bQ1Fh9z/52UEu35diltq0zVTbueaURcrGWsVjyPN5R4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UDJSMB71ieEf8a4Pz3zjet46SOA91oRscVIp9yr0U68EBaudYDowTZif00JBa46CYtpX4jHPz6gICcgZle48AtHhotraosMb7V7MgW7xUzx3QOQQAaW06MRi0gd0ovnjJRglxIRt+3KYIg709fbMEfpal0vE/AVEy4TwCqYu5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcFT31h4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C76C32786;
	Mon, 29 Jul 2024 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239577;
	bh=bQ1Fh9z/52UEu35diltq0zVTbueaURcrGWsVjyPN5R4=;
	h=Subject:To:Cc:From:Date:From;
	b=VcFT31h49mLyz0ogfG5b0HW4+PCQPu9DPAyJ02tO+LVIBUV5tgb17mboatb/wmXXQ
	 qvjfgiSXLpuOqkn7fThwxxfLHJH4K00mGxQljhTKWV1Zg3MA1YPBubL3CsBHUqiSNa
	 BWefAHlSBwMJ33PoQgQqqvA23di3QUoliUkTCol4=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Fix offsets for the fixed format sense data" failed to apply to 5.15-stable tree
To: ipylypiv@google.com,akshatzen@google.com,cassel@kernel.org,hare@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:52:46 +0200
Message-ID: <2024072945-crept-keg-f9ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 38dab832c3f4154968f95b267a3bb789e87554b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072945-crept-keg-f9ef@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

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
87aab3c4cd59 ("ata: libata: move NCQ related ATA_DFLAGs")
876293121f24 ("ata: scsi: rename flag ATA_QCFLAG_FAILED to ATA_QCFLAG_EH")
b83ad9eec316 ("ata: libata-eh: Cleanup ata_scsi_cmd_error_handler()")
3d8a3ae3d966 ("ata: libata: fix commands incorrectly not getting retried during NCQ error")
4cb7c6f1ef96 ("ata: make use of ata_port_is_frozen() helper")
cb6e73aaadff ("ata: libata-eh: Remove the unneeded result variable")
066de3b9d93b ("ata: libata-core: Simplify ata_build_rw_tf()")
e00923c59e68 ("ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE")
fa82cabb8883 ("doc: admin-guide: Update libata kernel parameters")
2c33bbdac28c ("ata: libata-core: Allow forcing most horkage flags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38dab832c3f4154968f95b267a3bb789e87554b0 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Tue, 2 Jul 2024 02:47:29 +0000
Subject: [PATCH] ata: libata-scsi: Fix offsets for the fixed format sense data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
indicate that the INFORMATION field contains valid information.

INFORMATION
===========

SAT-5 Table 212 — "Fixed format sense data INFORMATION field for the ATA
PASS-THROUGH commands" defines the following format:

+------+------------+
| Byte |   Field    |
+------+------------+
|    0 | ERROR      |
|    1 | STATUS     |
|    2 | DEVICE     |
|    3 | COUNT(7:0) |
+------+------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
field starts at byte 3 in sense buffer resulting in the following offsets
for the ATA PASS-THROUGH commands:

+------------+-------------------------+
|   Field    |  Offset in sense buffer |
+------------+-------------------------+
| ERROR      |  3                      |
| STATUS     |  4                      |
| DEVICE     |  5                      |
| COUNT(7:0) |  6                      |
+------------+-------------------------+

COMMAND-SPECIFIC INFORMATION
============================

SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
field for ATA PASS-THROUGH" defines the following format:

+------+-------------------+
| Byte |        Field      |
+------+-------------------+
|    0 | FLAGS | LOG INDEX |
|    1 | LBA (7:0)         |
|    2 | LBA (15:8)        |
|    3 | LBA (23:16)       |
+------+-------------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that
the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
in sense buffer resulting in the following offsets for
the ATA PASS-THROUGH commands:

Offsets of these fields in the fixed sense format are as follows:

+-------------------+-------------------------+
|       Field       |  Offset in sense buffer |
+-------------------+-------------------------+
| FLAGS | LOG INDEX |  8                      |
| LBA (7:0)         |  9                      |
| LBA (15:8)        |  10                     |
| LBA (23:16)       |  11                     |
+-------------------+-------------------------+

Reported-by: Akshat Jain <akshatzen@google.com>
Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20240702024735.1152293-2-ipylypiv@google.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cdf29b178ddc..a0c68b0a00c4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
-	unsigned char *desc = sb + 8;
 	u8 sense_key, asc, ascq;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -877,7 +876,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
 
-	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
+	if ((sb[0] & 0x7f) >= 0x72) {
+		unsigned char *desc;
 		u8 len;
 
 		/* descriptor format */
@@ -916,21 +916,21 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		}
 	} else {
 		/* Fixed sense format */
-		desc[0] = tf->error;
-		desc[1] = tf->status;
-		desc[2] = tf->device;
-		desc[3] = tf->nsect;
-		desc[7] = 0;
+		sb[0] |= 0x80;
+		sb[3] = tf->error;
+		sb[4] = tf->status;
+		sb[5] = tf->device;
+		sb[6] = tf->nsect;
 		if (tf->flags & ATA_TFLAG_LBA48)  {
-			desc[8] |= 0x80;
+			sb[8] |= 0x80;
 			if (tf->hob_nsect)
-				desc[8] |= 0x40;
+				sb[8] |= 0x40;
 			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				desc[8] |= 0x20;
+				sb[8] |= 0x20;
 		}
-		desc[9] = tf->lbal;
-		desc[10] = tf->lbam;
-		desc[11] = tf->lbah;
+		sb[9] = tf->lbal;
+		sb[10] = tf->lbam;
+		sb[11] = tf->lbah;
 	}
 }
 


