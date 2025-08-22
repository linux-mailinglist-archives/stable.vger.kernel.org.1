Return-Path: <stable+bounces-172239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851BB30BEB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 04:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C203B4177
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B619E97A;
	Fri, 22 Aug 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxjZWt8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C9198A11
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830240; cv=none; b=IjM70wkaV9a6CWjOCqL32ajGiLJ1Cr8ScqSugl7K/9ofknwhK2RxA9Qu6S18Qq6OdCo7JEoEUbc4SYHaE6rjY4D4r4vVQIvd89dASpAk7sv9ieNB9Jz6EmX6l47vRlydiXJUFfhmwimHUVckLQYjGU06TJhJM74CcS/TWQ7rPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830240; c=relaxed/simple;
	bh=i7zlrhw5uPmdIPrWmVRgEjGFtuz7abUlJGjvOrbUsbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmyRLdSfogTTacSsjbqRhLERvyU3cIlf42x+YKIt/dQa8MDrp/eY6MF9RHA6dQqkmXsNngZMdnaRadn89QRvwJjh+aZL5H0QvtypCntjd6oS25JT2MENdTRvvIn1dAKBUyNVLAxWIivEYrj14z9fQCXrTstsLHtgsOr4R/nwZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxjZWt8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85398C4CEED
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755830239;
	bh=i7zlrhw5uPmdIPrWmVRgEjGFtuz7abUlJGjvOrbUsbA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bxjZWt8UtMcc24Hxwj6/poN1KhIEiOTGt57JpH5owJQC6YjqCCGYK182raTc5CJ6+
	 vwSpW8nr/sVhQ8BysbsKK14/YpEaFW2xiY4J8XB4ppp6+xmUKMQM3rh67iOpaQ2RNF
	 XftcSVw8VoOO8pBv347TmhzB/2fn/LDVdI3x7L2nl8NUftwsiovs7Ha9cxojigNDhJ
	 8focsF8MkBER1+a9mRD5yKSuxlZeNrmgNr2Jz3/TjXtS2KejU15H3g+yVtyLU8fyCg
	 xwh1bKDKVKEe02OIyzA43paZI69T5B0pEcudnok3LSjovESnu9oq581O+AAMJUmmZ/
	 424kP5OeaXvrw==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] ata: libata-scsi: Return aborted command when missing sense and result TF
Date: Fri, 22 Aug 2025 11:34:31 +0900
Message-ID: <20250822023431.157645-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082133-excursion-pacifist-92a4@gregkh>
References: <2025082133-excursion-pacifist-92a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d2be9ea9a75550a35c5127a6c2633658bc38c76b upstream.

ata_gen_ata_sense() is always called for a failed qc missing sense data
so that a sense key, code and code qualifier can be generated using
ata_to_sense_error() from the qc status and error fields of its result
task file. However, if the qc does not have its result task file filled,
ata_gen_ata_sense() returns early without setting a sense key.

Improve this by defaulting to returning ABORTED COMMAND without any
additional sense code, since we do not know the reason for the failure.
The same fix is also applied in ata_gen_passthru_sense() with the
additional check that the qc failed (qc->err_mask is set).

Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-scsi.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1660f46dc08b..d07189c99404 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -938,6 +938,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
 			    "missing result TF: can't generate ATA PT sense data\n");
+		if (qc->err_mask)
+			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
 
@@ -995,8 +997,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
-			    "missing result TF: can't generate sense data\n");
-		return;
+			    "Missing result TF: reporting aborted command\n");
+		goto aborted;
 	}
 
 	/* Use ata_to_sense_error() to map status register bits
@@ -1007,19 +1009,20 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
-	} else {
-		/* Could not decode error */
-		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
-			     tf->status, qc->err_mask);
-		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
-		return;
-	}
 
-	block = ata_tf_read_block(&qc->result_tf, dev);
-	if (block == U64_MAX)
+		block = ata_tf_read_block(&qc->result_tf, dev);
+		if (block != U64_MAX)
+			scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE,
+						   block);
 		return;
+	}
 
-	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
+	/* Could not decode error */
+	ata_dev_warn(dev,
+		"Could not decode error 0x%x, status 0x%x (err_mask=0x%x)\n",
+		tf->error, tf->status, qc->err_mask);
+aborted:
+	ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 }
 
 void ata_scsi_sdev_config(struct scsi_device *sdev)
-- 
2.50.1


