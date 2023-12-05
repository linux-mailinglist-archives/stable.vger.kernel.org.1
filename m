Return-Path: <stable+bounces-4255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D938046BA
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BE2817BA
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C43B8BF8;
	Tue,  5 Dec 2023 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9Si/7Mm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855CA59;
	Tue,  5 Dec 2023 03:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D4FC433C8;
	Tue,  5 Dec 2023 03:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747052;
	bh=xhlNzFLljCQMPDzzI6dmmmvT/prNJPHSrTwsUpNSEco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9Si/7MmBvd+bZK9QsDHZyV1aLvhQl1NO3nPIGBDuonvHr8woN/MULBlE7yPa5k5I
	 fgEaXAG1g3OWQbTy3bYmeTBMAzoNlPAI2NIqibcUahmCGg0NhkoCg5kjTuYeM+JTmO
	 8zByYCSD7wXEyX7bi2nzY152URHlpjg1oiuPQbyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 017/107] scsi: Change SCSI device boolean fields to single bit flags
Date: Tue,  5 Dec 2023 12:15:52 +0900
Message-ID: <20231205031532.726332545@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 6371be7aeb986905bb60ec73d002fc02343393b4 upstream.

Commit 3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop
management") changed the single bit manage_start_stop flag into 2 boolean
fields of the SCSI device structure. Commit 24eca2dce0f8 ("scsi: sd:
Introduce manage_shutdown device flag") introduced the manage_shutdown
boolean field for the same structure. Together, these 2 commits increase
the size of struct scsi_device by 8 bytes by using booleans instead of
defining the manage_xxx fields as single bit flags, similarly to other
flags of this structure.

Avoid this unnecessary structure size increase and be consistent with the
definition of other flags by reverting the definitions of the manage_xxx
fields as single bit flags.

Fixes: 3cc2ffe5c16d ("scsi: sd: Differentiate system and runtime start/stop management")
Fixes: 24eca2dce0f8 ("scsi: sd: Introduce manage_shutdown device flag")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20231120225631.37938-2-dlemoal@kernel.org
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c  |    4 ++--
 drivers/firewire/sbp2.c    |    6 +++---
 include/scsi/scsi_device.h |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1087,8 +1087,8 @@ int ata_scsi_dev_config(struct scsi_devi
 		 * and resume and shutdown only. For system level suspend/resume,
 		 * devices power state is handled directly by libata EH.
 		 */
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
 	}
 
 	/*
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1519,9 +1519,9 @@ static int sbp2_scsi_slave_configure(str
 	sdev->use_10_for_rw = 1;
 
 	if (sbp2_param_exclusive_login) {
-		sdev->manage_system_start_stop = true;
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_system_start_stop = 1;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
 	}
 
 	if (sdev->type == TYPE_ROM)
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -167,19 +167,19 @@ struct scsi_device {
 	 * power state for system suspend/resume (suspend to RAM and
 	 * hibernation) operations.
 	 */
-	bool manage_system_start_stop;
+	unsigned manage_system_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for runtime device suspand and resume operations.
 	 */
-	bool manage_runtime_start_stop;
+	unsigned manage_runtime_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for system shutdown (power off) operations.
 	 */
-	bool manage_shutdown;
+	unsigned manage_shutdown:1;
 
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */



