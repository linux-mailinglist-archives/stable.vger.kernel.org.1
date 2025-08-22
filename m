Return-Path: <stable+bounces-172241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF3B30C10
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC4178CDC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F64223DEA;
	Fri, 22 Aug 2025 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlx4DWj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA5393DC6
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831208; cv=none; b=Y/MYAJAeICTfN7AqOqYCQxUUlW0/0lAM2Q1mFDzFC0MdQcLCPG9zo/AlSilRJ/UlOIuOvzj1kW8j5l5s/ns+4ffkLquQGvkG+3PBaQR2S903us5w0MD8ZW1BesqxuGG65zZE1ZN2rFgLQUI7LV0rnKD64KEH1AgQFK8DQLzdnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831208; c=relaxed/simple;
	bh=MfDxNsqCDjjIuzuWgwrRXOI5c/41+NgJ+S65aumOzow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxpnLMHGCKPjByihkOQQm9p4S0wsxPhewql8xPtvt3dlcngswnujN4WMwlzUC8TC3SYEtkAqJOcWRvCaheH/8qhwdV52icPLm4pgUek5Jl+VgEn39PCw9kUFeQHlp5729zfO/OnTAOInygqMtdQwTDYiDJcXoZ0Zb5+k93CrT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlx4DWj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87CC4CEEB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755831207;
	bh=MfDxNsqCDjjIuzuWgwrRXOI5c/41+NgJ+S65aumOzow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nlx4DWj96tO8BRTizctNeWUZFUtHJfwyZH8iO3rLizfmo7mLt2ItQezc6YkosS+Uk
	 SYy04iRo1XKRKZeyfGZLkauqLsDiF+eSfeeih4Ha1rFKzcmhryF6rHST+3ciyCuvcX
	 x3EacnaXDhPtXZH1qk3zIEi5NVnCB44h98lqfnkZEONhrQqBeuFdKz34K9GBpsqfvt
	 9u1+6eRgxwsBLTNU91/0sAx60Xdx1bXC9KqYmjpXE/hLCeFEzKS0zjYtgZhtrDvWQc
	 l3b8JqmN879SBj5kFJO6ae7w4IJLkpsWXQiXGmxe8y02VDDR7GXiu3po6EFO1B6tR+
	 QxNHvw60Q3aYw==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] ata: libata-scsi: Return aborted command when missing sense and result TF
Date: Fri, 22 Aug 2025 11:50:39 +0900
Message-ID: <20250822025039.244614-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082134-stuck-legend-2edb@gregkh>
References: <2025082134-stuck-legend-2edb@gregkh>
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
index 6a1460d35447..b5309e9904c0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -939,6 +939,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
 			    "missing result TF: can't generate ATA PT sense data\n");
+		if (qc->err_mask)
+			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
 
@@ -996,8 +998,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
-			    "missing result TF: can't generate sense data\n");
-		return;
+			    "Missing result TF: reporting aborted command\n");
+		goto aborted;
 	}
 
 	/* Use ata_to_sense_error() to map status register bits
@@ -1008,19 +1010,20 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
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


