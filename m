Return-Path: <stable+bounces-145833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A22ABF4E0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91114A0FE5
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55A26FD8B;
	Wed, 21 May 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="eHq7U6ax"
X-Original-To: stable@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572226FD8D;
	Wed, 21 May 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832021; cv=none; b=tEU1dqUwV2zDPH8bS+6VbZlwQB8YqHu2la9GiSh95OmwjXFAxXljcSHSfPlrvG8tWgRuqW+yUK3Rwr9Y7inv/VqHf1/jG7VuVH4iB47i/TMm6EVqQ8yyCMXS0iOGM3lQf/bPmgdrqXLC769rj6qqUWEQi+I89DiD+pqx//n/CPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832021; c=relaxed/simple;
	bh=S742c3peeJQHm86+s66gSTwef+VkJOCaiUZ+BG1R2hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=czYF7Icuc/nxfAT5tjGNd1ApjEKoohhhIvy8ZFR8To5m2uDNo7KPRNNbjhZIwBWxnttTWF8mNMq2NxIvipnG7l3y+3Do//9wellWI+Z/eX8avkMKX7MEqMMCUeSxxupFiN5cdQbD2m9EeBm0S4t624CNMxAatxFZ2V/Uc/jaHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=eHq7U6ax; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1747832019; x=1779368019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S742c3peeJQHm86+s66gSTwef+VkJOCaiUZ+BG1R2hs=;
  b=eHq7U6axh0rnT/Li7NgXz5Py4TRCX9biQsZC15r9BzRVXw2+n2SFLm0O
   hzPMc1Uj1Ljhw0+97Xj7i6c1GSWYwZenFkeSjS8IhfOJANtOex8ioxMJ+
   Vyq3kfOVB8WKdpkXc0/3+mfJsF+8bhdzdtTMQc7wyAv25h3MQrN7QKLq5
   RcY1kI8SiTaU87sZBj6o3a7RXXW7iaDhDnbW9hoZZmO93XeeivDJ35ooR
   AFnB2YCHGHB3emaXHqJsTc3oEcSuo72KJZx3dUIA2V7fW8Sg0jXGVRUYs
   DXutoRiPcTxuQQEjFFq7NjD//7mwu+nl1l5PRdBnju5D/GhuoLJzwu49y
   Q==;
X-CSE-ConnectionGUID: v0RV1nXsQSm59eRgbltNJA==
X-CSE-MsgGUID: ygw/yh9OTeKdoAFal0Tmpw==
X-IronPort-AV: E=Sophos;i="6.15,303,1739808000"; 
   d="scan'208";a="84726615"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2025 20:53:33 +0800
IronPort-SDR: 682dbe86_fLr9avrVQp5o0m1t0wz46Iy7a2f65kid+vxk3h7W7PIX4lf
 M8nQXOtrdf6zFhkoZSZljjKOt7JxyyzfW7UF5LA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2025 04:52:38 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2025 05:53:31 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
Date: Wed, 21 May 2025 15:48:20 +0300
Message-Id: <20250521124820.554493-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the BROKEN_SD_DISCARD quirk for certain SanDisk SD cards from the
`mmc_blk_fixups[]` to `mmc_sd_fixups[]`. This ensures the quirk is
applied earlier in the device initialization process, aligning with the
reasoning in [1]. Applying the quirk sooner prevents the kernel from
incorrectly enabling discard support on affected cards during initial
setup.

[1] https://lore.kernel.org/all/20240820230631.GA436523@sony.com

Fixes: 07d2872bf4c8 ("mmc: core: Add SD card quirk for broken discard")
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/quirks.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 7f893bafaa60..c417ed34c057 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
 		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
 
+	/*
+	 * Some SD cards reports discard support while they don't
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
+		  MMC_QUIRK_BROKEN_SD_DISCARD),
+
 	END_FIXUP
 };
 
@@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
-	/*
-	 * Some SD cards reports discard support while they don't
-	 */
-	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
-		  MMC_QUIRK_BROKEN_SD_DISCARD),
-
 	END_FIXUP
 };
 
-- 
2.25.1


