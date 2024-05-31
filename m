Return-Path: <stable+bounces-47785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E978D614C
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D971C2218F
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3A1581EB;
	Fri, 31 May 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAqR2LNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A129A0;
	Fri, 31 May 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157256; cv=none; b=mUbhwCkgyP7HHGlooEByOsm87J5JjpCOExJ2ZSAt0yIOnIgeK8R/PE+suJSHl096eSnr0a9IH1z8UjrgjQbf3v3cGb8X929KsE1ldo8n2g4kB1LW7O600wdhhRPIsmFAdGx5bQ8Ogxm69KoCfwyP16TSJmVWzwkBq2JYaW0mRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157256; c=relaxed/simple;
	bh=bFRiN8uxWumnVjMvefevotAEPlcwC9xHBjw/n3xbE3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/THRcOrTjYF7gaRCXucHACZVmfvvI+uZF722xi7MUuYCwbhKXcBw6HLvy/r52JUnZ8vugCRSZtQdRgcpbInJ4wFd7Os0jq/CMAcedAUKhH5yWtRwEGIyBTaRrUul43OiyqfEHo++yHFVema7VlDOcwFoOvR9rM9lIoIhY0ZggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAqR2LNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E44C116B1;
	Fri, 31 May 2024 12:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717157255;
	bh=bFRiN8uxWumnVjMvefevotAEPlcwC9xHBjw/n3xbE3c=;
	h=From:To:Cc:Subject:Date:From;
	b=UAqR2LNQzifSGlcFiKjv4yGKaGQYvcnpe4cK7hIQVlQBFidtlzt/419J7rqrqPK/5
	 jgZyUDDlJ7k/HIF9MEB+LZ9wwvuPAIUh0Z21w7U5sOhX74f8xrSFehJLS4h9145Z2K
	 hrCEUEcnKT7WkI0YJ4NhIoqb6rz4pKRE/0ZsifnEbnS5PGlleczGLNUUkeZlZK30a+
	 Qv9ukWEUYg6ZMn/bJIVWr8xUqIJJ5Pg8Pk8mTVXpmRrgtgq4dH96XH0XQcgzSjNEVX
	 VeJnvD/4OOSbq81MWHcM6/zWBFcjdcPpR6QEfdoshifP8GJQ3v/m0JpEAoE/TI1bOx
	 35OFaPaZup3og==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>
Cc: stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Do not enable LPM if no LPM states are supported by the HBA
Date: Fri, 31 May 2024 14:07:11 +0200
Message-ID: <20240531120711.660691-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; i=cassel@kernel.org; h=from:subject; bh=bFRiN8uxWumnVjMvefevotAEPlcwC9xHBjw/n3xbE3c=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIi9+Znih+p/vx8+csrVuoir25F1WbsDNdyKHlXdaPMW 6EoaXlCRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYi9ZeRYd93XkmpzGDN+YFn Es+LCn1Qy11edmJlTzP7pQK/7PPNCxgZOsxe9OjFnMhcaN2/97TW4TT1TTPafqxk4bzM2/tL1es PPwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

LPM consists of HIPM (host initiated power management) and DIPM
(device initiated power management).

ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
supports it.

However, DIPM will be enabled as long as the device supports it.
The HBA will later reject the device's request to enter a power state
that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
initiated by the device).

For a HBA that doesn't support any LPM states, simply don't set a LPM
policy such that all the HIPM/DIPM probing/enabling will be skipped.

Not enabling HIPM or DIPM in the first place is safer than relying on
the device following the AHCI specification and respecting the NAK.
(There are comments in the code that some devices misbehave when
receiving a NAK.)

Performing this check in ahci_update_initial_lpm_policy() also has the
advantage that a HBA that doesn't support any LPM states will take the
exact same code paths as a port that is external/hot plug capable.

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
We have not received any bug reports with this.
The devices that were quirked recently all supported both Partial and
Slumber.
This is more a defensive action, as it seems unnecessary to enable DIPM
in the first place, if the HBA doesn't support any LPM states.

 drivers/ata/ahci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 07d66d2c5f0d..214de08de642 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1735,6 +1735,12 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if (ap->pflags & ATA_PFLAG_EXTERNAL)
 		return;
 
+	/* If no LPM states are supported by the HBA, do not bother with LPM */
+	if ((ap->host->flags & ATA_HOST_NO_PART) &&
+	    (ap->host->flags & ATA_HOST_NO_SSC) &&
+	    (ap->host->flags & ATA_HOST_NO_DEVSLP))
+		return;
+
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
-- 
2.45.1


