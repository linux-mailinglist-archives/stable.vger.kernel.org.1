Return-Path: <stable+bounces-195176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C3BC6F403
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE1E3363DFE
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8512366DB0;
	Wed, 19 Nov 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Veoae62b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819F34DCCE;
	Wed, 19 Nov 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561603; cv=none; b=qjJdbzWCNYKSx8BIYd8U11sG3M27tYeaLbJBjH82o4vil5a3Uk5tNdnW/0gsjuw6WAMh3VqfCIjTWgyL092ukktV6EtxlGjMshM40oaSkQAkHI1ni3PReYq+4jzNqcE3pMvZes8n1XuXml06BY0HSBgANxqp950JkLTxcIzKamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561603; c=relaxed/simple;
	bh=nae6qsLFLDMdnEE17YXfp84fUPXLIf5WWvAocXs9fJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6exIxA+jLMU9qhCiPPR+K41frTWBXsaB9U/EYENPRibw4w3mCpKPhXvfFh6X6Bh4+niHi1ksyeDirErZFI+6lv1AtBaunxDbtd0Sko0ZaWxdhLimhik2EGBXSU1VGfSut/y7Z6EZ8q+PAkBJe1ylvGipxMQw96ykzx6w4XwoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Veoae62b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B0C19425;
	Wed, 19 Nov 2025 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561603;
	bh=nae6qsLFLDMdnEE17YXfp84fUPXLIf5WWvAocXs9fJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=Veoae62b4FMwWPAaUVkOUDe4ZXgXXHvBktpxLFbrURy20ibV7IvWeOxiIi9Y8rchh
	 8sJPQW9ptDkOTaVjyCUt042A2rE7ububclBlxf5Uu5qn42438w/YeekhAVvEGHJ1m4
	 WZ96vg9cOQj9hTS9zTEdCpB96bIjPSHfBwXy0c5GPfjxqzCMPCA1TF+i9sQycoFb8w
	 XGfZdpB7mmN2iS58n3Jt5kDF/D4qeUgnQc6LTmrI7xGIDL+pUJ1WBOKTbdvayxGuhF
	 fWWppT8oA/WGCUgSQaodfdU2PpU6/3SVWCme2wO7cV6Gv7E80ukoqqeSjrGoqfwgs4
	 YXZEE7rtMMk8Q==
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Ilia Baryshnikov <qwelias@gmail.com>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH 1/2] ata: libata-scsi: Fix system suspend for a security locked drive
Date: Wed, 19 Nov 2025 15:13:14 +0100
Message-ID: <20251119141313.2220084-3-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=cassel@kernel.org; h=from:subject; bh=nae6qsLFLDMdnEE17YXfp84fUPXLIf5WWvAocXs9fJ8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJlL1Su+XSV3fbc9q+LbTpiL2VYdHI07P9mamgb9Zl96 /mHs1d+6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE9rUx/K8yqopalsAnMVHx emBhYLmdKPdGsXUsrc2uklnXfk237WBkeNp6TaW6/F1D+pPUzecb5TKOR6yTlljxcGVy4dV1IWc fsAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 +++++++
 include/linux/ata.h       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b43a3196e2be..58efa88e4882 100644
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
-- 
2.51.1


