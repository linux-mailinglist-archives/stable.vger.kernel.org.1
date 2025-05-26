Return-Path: <stable+bounces-146363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951AAC3EEB
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E1A167BD5
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1A01EF080;
	Mon, 26 May 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="UwD5NFQ6"
X-Original-To: stable@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005954739;
	Mon, 26 May 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260216; cv=none; b=NGm7am5DJ7M3fLni9/IOdkCu+5uLptqmqQE3R5z1lqyPtf5Viitbv/ccUNp382TcvDFDijqfJ3rhY/fa+mUEYnRAw4Ps7Hy1d6kmVkHIW9mUI/HwBjz+RS8QGUiv7yZltP31m1wM38OP/yyAlAVGQgHcFCVypiPXclKxEU6Yl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260216; c=relaxed/simple;
	bh=07Mhf4LYRIjXadV0OBDIBgbJCAUXaGxnQeu1fT+3/lA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJ0stoGYLniqBZCql/UpuyUmhrV/UpWu9gwg9k1lRoCBPS9T5nVT89oVSiQqRHO/FzXMeQ8916ZeENC6kLmxPKHCa+v2hdJbj4RTu/F4tCAZT5rvPcYZYGSokSswPb0/7gFgLQ75g99HK+3rOAiiVVVD3WQ+gjJwSuw8zMTy7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=UwD5NFQ6; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1748260215; x=1779796215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07Mhf4LYRIjXadV0OBDIBgbJCAUXaGxnQeu1fT+3/lA=;
  b=UwD5NFQ6GTrVx35JlSeX9qXxeJsK5A/BgDET5cAlnwYQ8gyoJCb0tm/m
   /j4NWGot+ovB2/9hDb7daH4Vzz/bQds81nml3qWFiYIVd1lwGjjkUHI/P
   0XvqxX9ySIxP7jkvGi70kbHyDx9Go1m1Frii31z1lZCZdb8hYYF/lHYsU
   3L4o3zAFuN0SlpYvYNTDKm68Ha++11lGLxnvjm7YyuQYVM6d/6Bwx2u/5
   kU8Lr+YXlrQ3NPMpHb4qsRFu15u/l9rIwBjvS8bDaP2EPC5gwhubdhjCo
   jHTIwpJhVpOtXcISlMDsBkFw2TZK+03xPpafGVpt94wsGsRc4arD86+M8
   w==;
X-CSE-ConnectionGUID: wiuVTGf+RkC6su7VXASd6w==
X-CSE-MsgGUID: JldjmfavSiaFEfXQfQhp5Q==
X-IronPort-AV: E=Sophos;i="6.15,315,1739808000"; 
   d="scan'208";a="83074110"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2025 19:50:08 +0800
IronPort-SDR: 68344722_MrJ9rbUAI+7wDOGY0LbBZ3FIPCSWOJaibq6fNeG4nIqGtMR
 ljgUaW8tWGZ4V1Hw95dht2uSqhMemuyk0X56FFQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2025 03:49:06 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2025 04:50:06 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
Date: Mon, 26 May 2025 14:44:45 +0300
Message-Id: <20250526114445.675548-1-avri.altman@sandisk.com>
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
Changes in v2:
 - rebase on latest next
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


