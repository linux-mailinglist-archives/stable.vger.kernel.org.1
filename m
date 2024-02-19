Return-Path: <stable+bounces-20548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12485A7BF
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311B21F248CA
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B039840;
	Mon, 19 Feb 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXzT30XR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322193D3A3;
	Mon, 19 Feb 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357494; cv=none; b=tNqbPK3ITKkWqt42MBib8A7I8hdhSf/kradwxcmUAxAhkTJGcT/K/E7d+M+JbxJGrQyYrUae+vamV3oqro1Eb2HgJr+KsvBW9gUF51nL1yllKmfQzTlpegMLhyddbk6AYmgI+85U5i912CL5UI61CY2zXh5fSU6Q1f4iQ9MwZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357494; c=relaxed/simple;
	bh=ymzRlFyp/2HaC7FHdi6ZCw93T8piafpeNNnhxbc2Hk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txA8fCLF6A80SPoZJxeK4TMP4vsEdGD2iIdpv8eLOm8QnNX4LfB49+pBAyorypbNf8JsYODvLgNlmgm+8X6aOUYkLivRVBbD9C1phgQRtwx2AMon630mcKHXdtlrPdoL+1HOH/fjUdl7r+PeSVKqNSqsAoi6J0KQcHp6IB3bIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXzT30XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04046C433F1;
	Mon, 19 Feb 2024 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708357493;
	bh=ymzRlFyp/2HaC7FHdi6ZCw93T8piafpeNNnhxbc2Hk0=;
	h=From:To:Cc:Subject:Date:From;
	b=XXzT30XR3xaEK9W0t0Cex/vZQgYnsSgX8yJcfyzZHcaCXeCdMxewxS5pR1bMH9VbI
	 zWTjJI2l0Zfqm2hxnraWBY1hJafJ9Xho3jBkRC8z0aSVaGAA9UkzztsuwRLHUjdI/Q
	 bz8WsOOC1GRH4zSwst+HfQpFsCQBxZ5jf2XZyM9yL+XV/ZQdR0O78U/ZWE7mRGPxJY
	 VBMBC15/H12mSKFtiXrhJa7vXzbeT15injLBtAKMFDcOjsXqZ/EwmvBI/sZlv0BtBi
	 IR0K/JPDomPh/QqY3+59zcYmlTigjIUvBRd1RbtdtSGYD6NA8hR2f8IxzfmweImetd
	 hYBc0xbqpiHoA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org,
	Niklas Cassel <niklas.cassel@wdc.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata-core: Do not call ata_dev_power_set_standby() twice
Date: Mon, 19 Feb 2024 16:44:30 +0100
Message-ID: <20240219154431.1294581-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

For regular system shutdown, ata_dev_power_set_standby() will be
executed twice: once the scsi device is removed and another when
ata_pci_shutdown_one() executes and EH completes unloading the devices.

Make the second call to ata_dev_power_set_standby() do nothing by using
ata_dev_power_is_active() and return if the device is already in
standby.

Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V1: Move the function instead of using a forward declaration.

 drivers/ata/libata-core.c | 59 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d9f80f4f70f5..be3412cdb22e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
 	return true;
 }
 
+static bool ata_dev_power_is_active(struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	ata_tf_init(dev, &tf);
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol = ATA_PROT_NODATA;
+	tf.command = ATA_CMD_CHK_POWER;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	if (err_mask) {
+		ata_dev_err(dev, "Check power mode failed (err_mask=0x%x)\n",
+			    err_mask);
+		/*
+		 * Assume we are in standby mode so that we always force a
+		 * spinup in ata_dev_power_set_active().
+		 */
+		return false;
+	}
+
+	ata_dev_dbg(dev, "Power mode: 0x%02x\n", tf.nsect);
+
+	/* Active or idle */
+	return tf.nsect == 0xff;
+}
+
 /**
  *	ata_dev_power_set_standby - Set a device power mode to standby
  *	@dev: target device
@@ -2017,8 +2044,9 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	/* If the device is already sleeping, do nothing. */
-	if (dev->flags & ATA_DFLAG_SLEEPING)
+	/* If the device is already sleeping or in standby, do nothing. */
+	if ((dev->flags & ATA_DFLAG_SLEEPING) ||
+	    !ata_dev_power_is_active(dev))
 		return;
 
 	/*
@@ -2046,33 +2074,6 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 			    err_mask);
 }
 
-static bool ata_dev_power_is_active(struct ata_device *dev)
-{
-	struct ata_taskfile tf;
-	unsigned int err_mask;
-
-	ata_tf_init(dev, &tf);
-	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
-	tf.protocol = ATA_PROT_NODATA;
-	tf.command = ATA_CMD_CHK_POWER;
-
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
-	if (err_mask) {
-		ata_dev_err(dev, "Check power mode failed (err_mask=0x%x)\n",
-			    err_mask);
-		/*
-		 * Assume we are in standby mode so that we always force a
-		 * spinup in ata_dev_power_set_active().
-		 */
-		return false;
-	}
-
-	ata_dev_dbg(dev, "Power mode: 0x%02x\n", tf.nsect);
-
-	/* Active or idle */
-	return tf.nsect == 0xff;
-}
-
 /**
  *	ata_dev_power_set_active -  Set a device power mode to active
  *	@dev: target device
-- 
2.43.2


