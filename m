Return-Path: <stable+bounces-101594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37759EED66
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8971888817
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC75222D55;
	Thu, 12 Dec 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+C8FgtU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4D2210F8;
	Thu, 12 Dec 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018106; cv=none; b=BxvXrpJAHeoCEmdfqhTk2UNpvWspaPkkmpQ1h5HS6c0lEzI4rQCfkZI9iv0tOzvr4EUkHojqwLwpxrEkmfRGd2BEp+UCVV4snLIxyyksxxiTjuRziTKbNBElHhGBsNRVoeSDKElNHrXCmrDcUwXzzIohCc4XZsk0uReb7eBkGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018106; c=relaxed/simple;
	bh=9Tv/VtahN434ADT669FYKYntB7ycu9qCXkM3Vr2uvSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcXPPAp8VAOXy7EHJZ96UFordA29YoihlQ6SJuagKTZ3CuGLkAzoywNbzOSWcjxA7xFPfbgz2z5iin+aFk4oWJ6BfuNcrI96BJu1Zg5XnWD4cKHnvV/mLorlvc7Fk0rnSsukGhEsjFiuTAOtcs3El6G8cgIKt4PxFCVisiB9VEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+C8FgtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E59C4CED0;
	Thu, 12 Dec 2024 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018106;
	bh=9Tv/VtahN434ADT669FYKYntB7ycu9qCXkM3Vr2uvSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+C8FgtUgO2p6ZxtXLJFcd2VRd79j0ZAtYxKvMrPorpJmnhnW6KL/RazdsOE4pEJ9
	 Cf3rQVu6/Lb+vOWIQTA6EtcEXytc7/gB+VQMsZK+6XScw7DeyXWWfMr2W/ljx15MM0
	 HHY8nBMRvNMw+IXZXlcOX+djgsplAf2sINMPmIYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keita Aihara <keita.aihara@sony.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 200/356] mmc: core: Add SD card quirk for broken poweroff notification
Date: Thu, 12 Dec 2024 15:58:39 +0100
Message-ID: <20241212144252.522861689@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keita Aihara <keita.aihara@sony.com>

[ Upstream commit cd068d51594d9635bf6688fc78717572b78bce6a ]

GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 report that
they support poweroff notification and cache, but they are not working
correctly.

Flush Cache bit never gets cleared in sd_flush_cache() and Poweroff
Notification Ready bit also never gets set to 1 within 1 second from the
end of busy of CMD49 in sd_poweroff_notify().

This leads to I/O error and runtime PM error state.

I observed that the same card manufactured on 01/2024 works as expected.

This problem seems similar to the Kingston cards fixed with
commit c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
Canvas Go Plus from 11/2019") and should be handled using quirks.

CID for the problematic card is here.
12345641535443002000000145016200

Manufacturer ID is 0x12 and defined as CID_MANFID_GIGASTONE as of now,
but would like comments on what naming is appropriate because MID list
is not public and not sure it's right.

Signed-off-by: Keita Aihara <keita.aihara@sony.com>
Link: https://lore.kernel.org/r/20240913094417.GA4191647@sony.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/card.h   | 7 +++++++
 drivers/mmc/core/quirks.h | 9 +++++++++
 drivers/mmc/core/sd.c     | 2 +-
 include/linux/mmc/card.h  | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d978..8476754b1b170 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -82,6 +82,7 @@ struct mmc_fixup {
 #define CID_MANFID_SANDISK_SD   0x3
 #define CID_MANFID_ATP          0x9
 #define CID_MANFID_TOSHIBA      0x11
+#define CID_MANFID_GIGASTONE    0x12
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
@@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
 }
+
+static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 92905fc46436d..89b512905be14 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -25,6 +25,15 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
 		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
 
+	/*
+	 * GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 never
+	 * clear Flush Cache bit and set Poweroff Notification Ready bit.
+	 */
+	_FIXUP_EXT("ASTC", CID_MANFID_GIGASTONE, 0x3456, 2022, 2,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
+		   EXT_CSD_REV_ANY),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 240469a881a27..f02c3e5eb5c85 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1118,7 +1118,7 @@ static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
 	card->ext_power.rev = reg_buf[0] & 0xf;
 
 	/* Power Off Notification support at bit 4. */
-	if (reg_buf[1] & BIT(4))
+	if ((reg_buf[1] & BIT(4)) && !mmc_card_broken_sd_poweroff_notify(card))
 		card->ext_power.feature_support |= SD_EXT_POWER_OFF_NOTIFY;
 
 	/* Power Sustenance support at bit 5. */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b12eebc5586d..afa575e362a47 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -296,6 +296,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
+#define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.43.0




