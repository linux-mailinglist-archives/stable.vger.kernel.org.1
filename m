Return-Path: <stable+bounces-47746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A98D549B
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 23:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD0FB21C00
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261418130D;
	Thu, 30 May 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg6JppDM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686E17DE23;
	Thu, 30 May 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104505; cv=none; b=SS4Jc2ndsdqfN75Vj75C4UDFVA/4Vu6fYH8K89jQAsWNNAbyU7zOOjoiYyeXBJymrWKYWjpolcoBsyNt40cikkSci/XILwYMgTdlcQ+ENr/SgABQCiV+w6bI+xSGKlEkgCnPFFoTtl1tN9Ci1ehDFuyAnUSyghLoYb6W0Qg5gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104505; c=relaxed/simple;
	bh=jjMzEFuLY/AR0JpYDTZzcGiJdd/1fmLINWIO+0P0MQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Spgl5r1lLgH2AaY8qIuqKPriuMXzSgoUQWFBYj9aIrqBXE/D8OqLc6tOObJ99OidHeG+jQ2lAtfNqDSF64IsGAWME4WrOJx9C1sqdB7HAILALa29FF6KHOMLA31VNaujOnnY6xBhEkEiKuX3bjOzZ1QhltlAM6soOEeKdgZAsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg6JppDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1D2C2BBFC;
	Thu, 30 May 2024 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717104505;
	bh=jjMzEFuLY/AR0JpYDTZzcGiJdd/1fmLINWIO+0P0MQA=;
	h=From:To:Cc:Subject:Date:From;
	b=gg6JppDMzOvIDUYPBEPQXXvD70Mcl+gP3gsGzcnlo0SdIjSF7+s+xIVKpZs2KYig7
	 +EJBx/M+j9YTeNwCf7UbVhFigVnLeFZGwHR7gC6Sf4bx62mPEC+aoPdpUKKzHopBNe
	 9/rwmqqpRmgajp1XfaYJVSY5lRxoJb9KDTMoAYUC5G6BJnQi4GRKandmdM9blyFMGi
	 mDldOJJ1afq7sbk7Q0esfVq1qKbR33Sgu0orY0Xj+S5VdSXAEOJgN1vEfGeJVfjvzU
	 Bax1YnLusJ5G64ZPzK1Yk1jvBcRSZqIZeOz4INlhbkbUH+MS/3RwODz4vtohtflD54
	 ryEnoEduOz1Pw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org,
	Aarrayy <lp610mh@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial CT240BX500SSD1
Date: Thu, 30 May 2024 23:28:17 +0200
Message-ID: <20240530212816.561680-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3296; i=cassel@kernel.org; h=from:subject; bh=jjMzEFuLY/AR0JpYDTZzcGiJdd/1fmLINWIO+0P0MQA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIi3hdMV/Gytbuhd3mXQpP5g7Xf9ld5MJmaPQixOJHqe Fe2K/9jRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbyU4eR4e2mY9mS2ZaVz/ms Mp40mv87GNVzZ4pbnSvb3AgJZuZyV0aGLXIHJ3jqK93dYt+Y1iamwfDbrGqqkvf5GaI/VdVWG85 gBgA=
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

The problem is that Crucial CT240BX500SSD1 drives do not handle low power
modes correctly. The problem was most likely not seen before because no
one had used this drive with a AHCI controller with LPM enabled.

Add a quirk so that we do not enable LPM for this drive, since we see
command timeouts if we do (even though the drive claims to support DIPM).

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Reported-by: Aarrayy <lp610mh@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
On the system reporting this issue, the HBA supports SALP (HIPM) and
LPM states Partial and Slumber.

This drive only supports DIPM but not HIPM, however, that should not
matter, as a DIPM request from the device still has to be acked by the
HBA, and according to AHCI 1.3.1, section 5.3.2.11 P:Idle, if the link
layer has negotiated to low power state based on device power management
request, the HBA will jump to state PM:LowPower.

In PM:LowPower, the HBA will automatically request to wake the link
(exit from Partial/Slumber) when a new command is queued (by writing to
PxCI). Thus, there should be no need for host software to request an
explicit wakeup (by writing PxCMD.ICC to 1).

Therefore, even with only DIPM supported/enabled, we shouldn't see command
timeouts with the current code. Also, only enabling only DIPM (by
modifying the AHCI driver) with another drive (which support both DIPM
and HIPM), shows no errors. Thus, it seems like the drive is the problem.

 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f35aab81a0a..b0ce621fe2a1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4136,8 +4136,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
 	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
 
-	/* Crucial BX100 SSD 500GB has broken LPM support */
+	/* Crucial devices with broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
+	{ "CT240BX500SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.45.1


