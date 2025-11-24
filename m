Return-Path: <stable+bounces-196790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C8C82493
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31B3E341DFA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481482D8375;
	Mon, 24 Nov 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr1eEru1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1C2D94A3
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012037; cv=none; b=iAkT2GphZyIkzftTgsc0XBgDpTPVCow+LE4IDXO+YGykrVM1oxPE4fQbL9/QkcNZ+gCku3IHZtrXNPHQGNfL9x94RCH+R2EWmVYwan+bkd2RhZk5nHzd1p6xZvlBZ8hvyALE4tbnwFbc4ScjuOQNyyXVNcp71KpGZXGIUI4aZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012037; c=relaxed/simple;
	bh=bcRhmBqJk0QPOV/Virkas3sFf7oI1S+BQy4HYpPfn9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0PGzvrTa+glClcfcVPVYOfLTrd9+PK0LidaTmbmJ9JTiPHCJ5X6w/OEZeLXjWVs7nEKHsQAKS+L9WlZB0Aw7QLu5xnf9Oik+gvyitXWlviOu9JvZo+mb+OU/+p7sryQiTIRUhK39Mt9T7ca1gTbOxrPnwz02xxQVpCC5Y4z3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr1eEru1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAABAC4CEF1;
	Mon, 24 Nov 2025 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012036;
	bh=bcRhmBqJk0QPOV/Virkas3sFf7oI1S+BQy4HYpPfn9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sr1eEru1HyEejNoc4tPNrRfYfqZa+12mvmwJng4pkFQdYWUB1ZsAqB5GY3PUUjKpI
	 ntllpTlbCkkKyqqZoIS8qscCD0Xjql5dCzz+44zuwO7xKdlaactZKRKqCZdfIKtewV
	 wS++EQjc4+LJCp10hqGmJdNybi6Da4hWjZ87NnNs+pQ3zn7wAruZMrLq5dPqBwdqB+
	 b25iungziQSpCuztU+o5Y+tP8wjx2ph8thgAgKgB4JvPwiL0K6c12GPxKedRnDqUYa
	 dIzTdZVd5KK7bH+O3flU6knV+g/6racmpGx0aaWhL+vsopqenTBSdAKFgr1QB6eDFt
	 Ogx2wUIk74l8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Ilia Baryshnikov <qwelias@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ata: libata-scsi: Fix system suspend for a security locked drive
Date: Mon, 24 Nov 2025 14:20:34 -0500
Message-ID: <20251124192034.3511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112403-stalemate-unbuckled-dda5@gregkh>
References: <2025112403-stalemate-unbuckled-dda5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit b11890683380a36b8488229f818d5e76e8204587 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 8 ++++++++
 include/linux/ata.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 35c87e7e4ddf8..c0a22c74472d9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1179,6 +1179,14 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (ata_id_is_locked(dev->id)) {
+		/* Security locked */
+		/* LOGICAL UNIT ACCESS NOT AUTHORIZED */
+		ata_scsi_set_sense(dev, cmd, DATA_PROTECT, 0x74, 0x71);
+		return;
+	}
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 6d2d31b03b4de..7e8d690df254b 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -557,6 +557,7 @@ struct ata_bmdma_prd {
 #define ata_id_has_ncq(id)	((id)[ATA_ID_SATA_CAPABILITY] & (1 << 8))
 #define ata_id_queue_depth(id)	(((id)[ATA_ID_QUEUE_DEPTH] & 0x1f) + 1)
 #define ata_id_removable(id)	((id)[ATA_ID_CONFIG] & (1 << 7))
+#define ata_id_is_locked(id)	(((id)[ATA_ID_DLF] & 0x7) == 0x7)
 #define ata_id_has_atapi_AN(id)	\
 	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
 	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
-- 
2.51.0


