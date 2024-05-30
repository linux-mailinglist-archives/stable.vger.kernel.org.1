Return-Path: <stable+bounces-47747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F58D54A0
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B57B285EAE
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68A17E44B;
	Thu, 30 May 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9UqJAGL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362E18756D;
	Thu, 30 May 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104780; cv=none; b=Ne3Xyqx/L30cnUis7qLD1gokPJ2RUZ9VJzqR4MwATwGqH5eCpScyknYxZE7U+HuAtX7XSXYoCSSMpa3WcO45i4iqguP6IJWOMoaTWUi/nd3QvSXLE8On13kKzPrICHWRPmTb+x/GwyAMI8Zb/JlvmDT4gAqvwGw3dA/IhVC+qAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104780; c=relaxed/simple;
	bh=AwNvfL1n3s6QB00grzo2ycXopnu/luQ3BEwAs3glqiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnxMDv3euIF/HbhWeZoqSgGiP+bw/6rKgNII+0wUmEHa894m4kWqKlI32SUVvJh/ig6ZZunJyRSUohB+snwIbQroxz2Orbf9HrDeLh8T04nq1Bb1Z6LYH/l+P7+4mrCrMJ4i4JtiiRXhchRoeBfjHEPZEAhIEChYCU0KHjNEZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9UqJAGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1BC2BBFC;
	Thu, 30 May 2024 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717104779;
	bh=AwNvfL1n3s6QB00grzo2ycXopnu/luQ3BEwAs3glqiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=g9UqJAGLRpjXw6mkvE/sH2b4iE+H7+Xz0fHrHPCDmHeHWPcrAuAedR/ApVZPza+cb
	 zgO1WXO+7ABaj04bVYP6844+MZxXNeZP6/qEruoTgQaxaKgTF4Eqg3LbzvpknbdK/x
	 rjm5u27QbAQv8yq5kwflo/7La5XYX+tXH3jOQ55uZztsyl43tb8SunKOQgCxDPHFa+
	 /RNviw3W21ohsjvBbiE0KbmSeNQ3/h0oKSDNVZ8YueQSYzy6joiSrJOW8FKL4am2n9
	 /ldXz6HAAbfqO/cEipSD71r9QEz+cFBu9t+eJ1ARkOsQrBbUoBjo/97GMKT0f5RLIh
	 pI0+IDGN8dHPA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org,
	Doru Iorgulescu <doru.iorgulescu1@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3 SSD
Date: Thu, 30 May 2024 23:32:44 +0200
Message-ID: <20240530213244.562464-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=cassel@kernel.org; h=from:subject; bh=AwNvfL1n3s6QB00grzo2ycXopnu/luQ3BEwAs3glqiQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIiPtS83nlw1uoP0xavvfpcv+GvUdK//GOqTxV8yz5HH Jtk952/tqOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATWdvFyPAqY4lktv53wfTf Rle3TH4XMKVnW/pk+cMcymxCMY/1ousZGTYZ5qz7lPNvg6DvZXkZocyi2WuNzr2ZlrdkYUl8vrf OOlYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
dropped the board_ahci_low_power board type, and instead enables LPM if:
-The AHCI controller reports that it supports LPM (Partial/Slumber), and
-CONFIG_SATA_MOBILE_LPM_POLICY != 0, and
-The port is not defined as external in the per port PxCMD register, and
-The port is not defined as hotplug capable in the per port PxCMD
 register.

Partial and Slumber LPM states can either be initiated by HIPM or DIPM.

For HIPM (host initiated power management) to get enabled, both the AHCI
controller and the drive have to report that they support HIPM.

For DIPM (device initiated power management) to get enabled, only the
drive has to report that it supports DIPM. However, the HBA will reject
device requests to enter LPM states which the HBA does not support.

The problem is that AMD Radeon S3 SSD drives do not handle low power modes
correctly. The problem was most likely not seen before because no one
had used this drive with a AHCI controller with LPM enabled.

Add a quirk so that we do not enable LPM for this drive, since we see
command timeouts if we do (even though the drive claims to support DIPM).

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Reported-by: Doru Iorgulescu <doru.iorgulescu1@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f35aab81a0a..6c4b69d34aa1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4155,6 +4155,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM },
 
+	/* AMD Radeon devices with broken LPM support */
+	{ "R3SL240G",			NULL,	ATA_HORKAGE_NOLPM },
+
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
-- 
2.45.1


