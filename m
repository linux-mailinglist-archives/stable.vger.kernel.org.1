Return-Path: <stable+bounces-62391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437DE93EF0F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647211C21B7C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470E12C522;
	Mon, 29 Jul 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9UXizMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772384A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239568; cv=none; b=YdqV+GthEzVQLLwyQ3iKiqYN1r5dfRA5GiTpZANmOCbIia6XFfnyFNDVo6SlJU3G771f8GMFaTtl6vLptNu1LAwDareOLYRAA0OkJsLblNkr2HD2+OurZuDJsD9d+pL5SxmLbkI+MDL8SD5MaEd1LQ6+KLX5jlzh1C2kvINWQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239568; c=relaxed/simple;
	bh=pQNfZH6YfpDIDgft75M1T0Jrh8qhbG9WZk+x0CVpyko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eaEM9UWO3eu01U44OsB42KesWpPMYByRcQxmAu8FEqFA0vPH4xAdkZb9Js6zH5Feb4663kE+6yKq/DCFVs8I0XFZBQi0ftrdALIwnVM0WcNPeEaZNd2e1b91oO0jClMGSz3afQNig4uhm0ckmMZrNBvDIEHX95EJ1YEbJwBB+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9UXizMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63831C32786;
	Mon, 29 Jul 2024 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239567;
	bh=pQNfZH6YfpDIDgft75M1T0Jrh8qhbG9WZk+x0CVpyko=;
	h=Subject:To:Cc:From:Date:From;
	b=L9UXizMYkAIUA/jgkpjZPneA+eN0G/DG9Fbp6hJvPWfeYDHkUCkrpY9Dm+PaHa6BJ
	 Bm7B+mM5B+pWqsudMwdJrOkTRXsCkjfjQQgHaXCTvwID9wr/AZwMUN0h66a6FHWoyx
	 dCz97d2ZToZJW5uh0F3X4LkxYFtEbONi/QAmVKls=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Fix offsets for the fixed format sense data" failed to apply to 6.1-stable tree
To: ipylypiv@google.com,akshatzen@google.com,cassel@kernel.org,hare@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:52:44 +0200
Message-ID: <2024072944-swoosh-muster-ccde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 38dab832c3f4154968f95b267a3bb789e87554b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072944-swoosh-muster-ccde@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


