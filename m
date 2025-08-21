Return-Path: <stable+bounces-172043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C241B2F981
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40C2A4E60B5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAB3218B6;
	Thu, 21 Aug 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiGPoEN4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EB3218A9
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781726; cv=none; b=iWxe+kx2ZgyFUycokP+wOReeHSwKpgu+Z5Tpdzk/RNGGrEsRhFkX3Y6uSx3DTR58sWvu7Qi9y68Qtlr+ZhhIZPC64+on8jp5I+5YgkzoYAICabD3SbuPM1pU1EnKkYSUF8LvX/1KmrCuovMeH0cdkU6VnT/VKfgUiQ0sKIEmgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781726; c=relaxed/simple;
	bh=y2mVLCEKxa73ANTvfFUXGYl2y3TOXRgcvZhVTStT7ys=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKJx/eK7RjWkA+/89l9oGDhQOaNwJ1ydNMGJwjyCbRtxtlUMlrvOF3G8llgKy85y5xgV5VBv2t6yEnvi3B8XB3zJW7inMzHKJtgZgX6sHqbrI/38GTTQJ7z5hnJfR4ujFuhT69SdNjzyfEa8joFdAAm2LngRNtleoY4aY/RSGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiGPoEN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3430C16AAE;
	Thu, 21 Aug 2025 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781725;
	bh=y2mVLCEKxa73ANTvfFUXGYl2y3TOXRgcvZhVTStT7ys=;
	h=Subject:To:Cc:From:Date:From;
	b=KiGPoEN4LeH8qC9kq5Wz8VkBI/bapqjFXB5MCFzsCbu68t7R11nQ4HM/69HdIrmmO
	 4fdehManzDcUVItc2QFxW8jE5cGoLDRvL2um6ge1Xae6wUSel3XHgaoU8DyaqPZll+
	 bwL/daVP7IOxsvkFCh8yF6yxi8PR5E9m8AmHcmHo=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Return aborted command when missing sense" failed to apply to 6.6-stable tree
To: dlemoal@kernel.org,hare@suse.de,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:08:34 +0200
Message-ID: <2025082134-stuck-legend-2edb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d2be9ea9a75550a35c5127a6c2633658bc38c76b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082134-stuck-legend-2edb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2be9ea9a75550a35c5127a6c2633658bc38c76b Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Tue, 29 Jul 2025 19:37:12 +0900
Subject: [PATCH] ata: libata-scsi: Return aborted command when missing sense
 and result TF

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

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9b16c0f553e0..57f674f51b0c 100644
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
 
@@ -992,8 +994,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
-			    "missing result TF: can't generate sense data\n");
-		return;
+			    "Missing result TF: reporting aborted command\n");
+		goto aborted;
 	}
 
 	/* Use ata_to_sense_error() to map status register bits
@@ -1004,13 +1006,15 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
-	} else {
-		/* Could not decode error */
-		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
-			     tf->status, qc->err_mask);
-		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
+
+	/* Could not decode error */
+	ata_dev_warn(dev,
+		"Could not decode error 0x%x, status 0x%x (err_mask=0x%x)\n",
+		tf->error, tf->status, qc->err_mask);
+aborted:
+	ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 }
 
 void ata_scsi_sdev_config(struct scsi_device *sdev)


