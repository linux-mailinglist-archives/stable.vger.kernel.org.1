Return-Path: <stable+bounces-47745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F938D5498
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1973284660
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2F18130D;
	Thu, 30 May 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtccERbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C317DE23;
	Thu, 30 May 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104445; cv=none; b=kgb5O23FTP2eSkKPEeMej9C8fedklh1nITvOhFvx1buPle408vGXaoJstuALxS13lcnVv+7VzBt0B33glYytPjSDq4uJeVApAxNN/urhiaatXWQUEEbB3hfR2d3zdYU9LVEC6Xgs1/8VTS8MzsrwEPPr6Z2hJJJ2LKhz8e6gxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104445; c=relaxed/simple;
	bh=z3EFeAVFEvon7UNZm7t0dEY75VpCgY2+r8WzPLjUNms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba8G2Ltp/1g1V1P/9KGvGVRfT1zJMuh4UxA3+dsdgrsZ+rV25QvuIO1TOq1wr0/rv5J0Dr/+fgLYYMnbCj8VuvIMm8f2G6ZU38mwP0SuerN+8VnuNRoo6z8pX65ijlIG6Kw2SHueIi+acjB269HEOSu5L3rfYYIDxV1GNra8HbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtccERbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50391C2BBFC;
	Thu, 30 May 2024 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717104445;
	bh=z3EFeAVFEvon7UNZm7t0dEY75VpCgY2+r8WzPLjUNms=;
	h=From:To:Cc:Subject:Date:From;
	b=TtccERbNFibTFDA+4WXIYXXCnyuXMcNbn6rKgoYAr2MAIrsjA1N0/Ig4K8V68sLWw
	 VlR0t84wmBDk2orjuDQo244U1iwxISit9SnRjpJ134ufFc8ROSQPqpcQ7TrTdEnDHk
	 p9lGgZR1wokem6K7aQobf8eOMgIu86IlAtRrtg0vtqrVh0LiWAawKAefWwyqVeXvxj
	 QNVTqKvK2WVFGtaWhzlH1EpGh4o0wVu3rNQV84gvJ13hS0S6HomVhEC2RL8oHfkDXM
	 FFGm3ExpnI8vm8N8G9z4LT1hLRIGIczVHy1c8MfjMAobe8wXbxs5MIAePyx1Px91Uo
	 KcJFQ/aqaAreg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org,
	Tim Teichmann <teichmanntim@outlook.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
Date: Thu, 30 May 2024 23:27:04 +0200
Message-ID: <20240530212703.561517-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3191; i=cassel@kernel.org; h=from:subject; bh=z3EFeAVFEvon7UNZm7t0dEY75VpCgY2+r8WzPLjUNms=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIi3qvrO7QsFd8t/6+KqcH0w5oo6xuNevN79v9wn+ksW qjJV2vbUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIkweDH8U8p+eyyxtkzHQP7W xBPiO1/0Ln3IXHxq/Yr8tpmbeBMM9jMyLF7+bIZ89tf/En93XHG8a7Y5/EnBTF9TF/3m34f0X3w JYwUA
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

The problem is that Apacer AS340 drives do not handle low power modes
correctly. The problem was most likely not seen before because no one
had used this drive with a AHCI controller with LPM enabled.

Add a quirk so that we do not enable LPM for this drive, since we see
command timeouts if we do (even though the drive claims to support DIPM).

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Closes: https://lore.kernel.org/linux-ide/87bk4pbve8.ffs@tglx/
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

 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f35aab81a0a..25b400f1c3de 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4155,6 +4155,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM },
 
+	/* Apacer models with LPM issues */
+	{ "Apacer AS340*",		NULL,	ATA_HORKAGE_NOLPM },
+
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
-- 
2.45.1


