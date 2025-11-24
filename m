Return-Path: <stable+bounces-196702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9304C80C24
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35D70347E67
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DA1DF970;
	Mon, 24 Nov 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14XOc76U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73431DE3AC
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990648; cv=none; b=ZRvBny4MNQbrkhFXjXRCDmrMhaRXmnjIy8DnzgcL4CeZtIupCFKYIP4oCu6uIjebhvOivgspc1h/kpsGA7xPoxcLCG0owkF2Y4RM1K3qgA0NVUAv2Ef0NINSr3ZZ2B96nDw4BfnUgM8Ka/4Tj8vfeE26McLEbCGIiB7v4T69ThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990648; c=relaxed/simple;
	bh=9y2Pmlbo86fcNFdPIThObxzcLa2+CqpYDDFrSgvSCYY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jBrdXjiIrd2Ol+mbENrgkTA/ntD+9xh4GFpwfX0aWaw0FcWNv3rtqvmn0kV5i5Lxg9oGzVz40Dueimrjdg3g82+27nZ7oeZPiuTj3LnJSDiVZ2Htvl4V4e6KOyLnS7ChijXvOaKt35eh7Ll9lFKjJTcEK5k1Jb8X3ObVUbd12kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14XOc76U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C8FC4CEF1;
	Mon, 24 Nov 2025 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990646;
	bh=9y2Pmlbo86fcNFdPIThObxzcLa2+CqpYDDFrSgvSCYY=;
	h=Subject:To:Cc:From:Date:From;
	b=14XOc76UI7Cg7W+md5LO57IFiiID5bBF1GZC3z2v8DEf1L3VYtShD0QhPBGMeeP3b
	 +xrkletOywaBqcVF951JqxqCzHgefTLU8feX2NmW9J/yy8jdjN5fwVAjhTOKPzrMs2
	 gJNuVYh6hTxjYWw+e8N1fHqxJo9hwZjgtINfZ0dA=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Fix system suspend for a security locked" failed to apply to 5.4-stable tree
To: cassel@kernel.org,dlemoal@kernel.org,hare@suse.de,martin.petersen@oracle.com,qwelias@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:24:03 +0100
Message-ID: <2025112403-stalemate-unbuckled-dda5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b11890683380a36b8488229f818d5e76e8204587
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112403-stalemate-unbuckled-dda5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b11890683380a36b8488229f818d5e76e8204587 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 19 Nov 2025 15:13:14 +0100
Subject: [PATCH] ata: libata-scsi: Fix system suspend for a security locked
 drive

Commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status
handling") fixed ata_to_sense_error() to properly generate sense key
ABORTED COMMAND (without any additional sense code), instead of the
previous bogus sense key ILLEGAL REQUEST with the additional sense code
UNALIGNED WRITE COMMAND, for a failed command.

However, this broke suspend for Security locked drives (drives that have
Security enabled, and have not been Security unlocked by boot firmware).

The reason for this is that the SCSI disk driver, for the Synchronize
Cache command only, treats any sense data with sense key ILLEGAL REQUEST
as a successful command (regardless of ASC / ASCQ).

After commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error()
status handling") the code that treats any sense data with sense key
ILLEGAL REQUEST as a successful command is no longer applicable, so the
command fails, which causes the system suspend to be aborted:

  sd 1:0:0:0: PM: dpm_run_callback(): scsi_bus_suspend returns -5
  sd 1:0:0:0: PM: failed to suspend async: error -5
  PM: Some devices failed to suspend, or early wake event detected

To make suspend work once again, for a Security locked device only,
return sense data LOGICAL UNIT ACCESS NOT AUTHORIZED, the actual sense
data which a real SCSI device would have returned if locked.
The SCSI disk driver treats this sense data as a successful command.

Cc: stable@vger.kernel.org
Reported-by: Ilia Baryshnikov <qwelias@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220704
Fixes: cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status handling")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3fb84f690644..434774e71fe6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -992,6 +992,13 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		return;
 	}
 
+	if (ata_id_is_locked(dev->id)) {
+		/* Security locked */
+		/* LOGICAL UNIT ACCESS NOT AUTHORIZED */
+		ata_scsi_set_sense(dev, cmd, DATA_PROTECT, 0x74, 0x71);
+		return;
+	}
+
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
 			    "Missing result TF: reporting aborted command\n");
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 792e10a09787..c9013e472aa3 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -566,6 +566,7 @@ struct ata_bmdma_prd {
 #define ata_id_has_ncq(id)	((id)[ATA_ID_SATA_CAPABILITY] & (1 << 8))
 #define ata_id_queue_depth(id)	(((id)[ATA_ID_QUEUE_DEPTH] & 0x1f) + 1)
 #define ata_id_removable(id)	((id)[ATA_ID_CONFIG] & (1 << 7))
+#define ata_id_is_locked(id)	(((id)[ATA_ID_DLF] & 0x7) == 0x7)
 #define ata_id_has_atapi_AN(id)	\
 	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
 	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \


