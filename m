Return-Path: <stable+bounces-94857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162769D72CA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4BDB34209
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF241E048E;
	Sun, 24 Nov 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBmzHub4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F91E048B;
	Sun, 24 Nov 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452833; cv=none; b=hwhBfTSG9K/RC2KAOP6YvES7pAccVw+MsFYg4VySkRgsk1iw5PExrHA3dAifd0cT42RDWDbsx/YNiS16dIUBT+Mqp7o0Parm5YPKkJJQi3cYlJZ6SSDbmnTMWC14Ee+mhSWPTGZszIdBRI1M67zOf8qh4p1YtOczcF6GN2zYSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452833; c=relaxed/simple;
	bh=6m2CTCNzPg0XbtGgBJfDOnjFyJqT/MXdb6At/jzNSAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvvKVUhORjg1ffMephbQncyWi28xM8vieJru7bNTl+llBJeD3w88qG5cfjL9+r8mVnJh02pl1KkaYR54SRuNM31Sg9eq8tvxCDtozO+WHrn9sQutU1LSdaAzYdkM0JIJ0HaANTXBDV728tm0qwDp5M61pPG3Q0Sf6x8K7k0wZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBmzHub4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84B5C4CECC;
	Sun, 24 Nov 2024 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452833;
	bh=6m2CTCNzPg0XbtGgBJfDOnjFyJqT/MXdb6At/jzNSAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBmzHub4zxXURPHpBykrUegEs6/9G/5OUaRQtggMrsjH51IUb3jJ45VccFN/zSr3/
	 5RE2sNsxEoyQOtL8j0zd4em96O5Yf47bEXE80QIllt4cxnYKJO8MnYtGhZgt6h2M5W
	 3cIGjgn7nEQ7Wzt/QVQ6DNOyiE/qCQka4VgQG1vBtMxYhVTV5qGKEkQcpO9jON/2Mo
	 V8AGTDhcXfbzPihQJFfwAfDwHgQBE1Ass4oeTw53iJ4JEazLbxn9MzsDZx1A6Ioymw
	 9Q9xRAUCBKhzdXhdZtG9ZoQjNPWs1A2Ckjce5f5h0XwS7u+FLYrkETVTL5daKTbdQk
	 CAm96ZswWqgkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keita Aihara <keita.aihara@sony.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	adrian.hunter@intel.com,
	avri.altman@wdc.com,
	dsimic@manjaro.org,
	jonathan@raspberrypi.com,
	victor.shih@genesyslogic.com.tw,
	ricardo@marliere.net,
	cw9316.lee@samsung.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/16] mmc: core: Add SD card quirk for broken poweroff notification
Date: Sun, 24 Nov 2024 07:52:27 -0500
Message-ID: <20241124125311.3340223-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125311.3340223-1-sashal@kernel.org>
References: <20241124125311.3340223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

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


