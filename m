Return-Path: <stable+bounces-94840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF479D6F93
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2292161BD5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753C1DEFE0;
	Sun, 24 Nov 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ID7zVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A711DE3C6;
	Sun, 24 Nov 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452728; cv=none; b=kUXyueYyyZp7/kAqKgEy+ljZpQQZGHG+1cQGrqFIGHR5+gap+aO5d4eBxg2OISDaova5JwZ1Y7jx//qIvIVHN0a7KbU0LG/K4y/UEYYj2M6mqNiNrS5oK/037RbadWnTKJktRQMA7mCw/L+CeP5I9stFc3RW5YA5Ni3iNoP9U6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452728; c=relaxed/simple;
	bh=3DL02EasfiKr1QlDtH+9gNdvyvXleLoam1XqnLsZtRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqTLztpr1SzNTdOl2caa51IhgRkOUk7vagROOkS8VsyTSuC2DmfTVBefFCL00c1wWsK174KFdHZowt7dJyHbzZDtIWviCNiOO45PIwfNMnwjl2Tnb/fky0//p88pgBs2eK/s92KuRbmm1IEHgInWrK4d8wNg8IeLeDeJCtVdmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ID7zVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24401C4CECC;
	Sun, 24 Nov 2024 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452728;
	bh=3DL02EasfiKr1QlDtH+9gNdvyvXleLoam1XqnLsZtRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9ID7zVYXd9P7Y9prA0rlmjttSpz7cOoz3qqM+434A9DA7FGLyH7zv4yRQeT97SF7
	 3eOjxeBuN+JZOnFRaihWC7QB9Mp2huuxhH1tZyQ3HXGyfjdL7JKQFCxWOj7I8hoZiF
	 Rwdx6NFHGYncs8SVUsMnBRE5UOCxdw9oqQCcKjQ9/JEppKROy8mC0EuLzRruNmf5Jp
	 Ven2RuY8KVTfB3BBPXX/KmjJLPvlquUfI25C5bqYaSLxTzMuY9bDH8Lx2JSdxppFFZ
	 y4CICrijlG6S5eUZ/rmphIjZMmticiQMJdrgsAU3iVTuCVu576QnIYVYkjsD3Jhzv0
	 obOMCY/zg3EAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keita Aihara <keita.aihara@sony.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	adrian.hunter@intel.com,
	avri.altman@wdc.com,
	jonathan@raspberrypi.com,
	dsimic@manjaro.org,
	ricardo@marliere.net,
	victor.shih@genesyslogic.com.tw,
	cw9316.lee@samsung.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 12/20] mmc: core: Add SD card quirk for broken poweroff notification
Date: Sun, 24 Nov 2024 07:50:42 -0500
Message-ID: <20241124125124.3339648-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125124.3339648-1-sashal@kernel.org>
References: <20241124125124.3339648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index ee37ad14e79ee..0ec550ad56513 100644
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
index f34407cc27888..543446392776f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -294,6 +294,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
+#define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.43.0


