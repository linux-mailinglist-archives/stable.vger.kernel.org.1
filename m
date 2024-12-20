Return-Path: <stable+bounces-105440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C769F9791
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC22163FEF
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ABF220684;
	Fri, 20 Dec 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I30OjKCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A521A95D;
	Fri, 20 Dec 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714711; cv=none; b=fhcv5Nstf6AJe12qOgBJFQth1SRmeE0qTqEDjFaxzPixjSygvKTXrbKCBJsAoX5VL5SolS7/YPxuyio/Tlhgjsb4FoX6DaB+kWlaVyBBByH77SU9FgwbeYwNVhNpvUb/URmqBxpEEJK+2xzNAiQ6PZVGyB5/5tUKpgk90149e/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714711; c=relaxed/simple;
	bh=/WuPFagjL6ddtIFK+BIu5jU20oVJp0MMnfC2FJyFbp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfCo8PolC1tZ8a3yNhmKlVqoCzvYLcG4NYdWJd1o50kxbjfwt9s3aIvGF822XFfB4m9VEMU/vytnx7eWJjSYpPzhx4UZhwbtipCldY3bNtMqAp36kOBHNtgmv9p1N7g4w3368rNIw8nXqCk04CjVNpjTzifbQjrF8QDXfl1Voc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I30OjKCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398FDC4CEE1;
	Fri, 20 Dec 2024 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714710;
	bh=/WuPFagjL6ddtIFK+BIu5jU20oVJp0MMnfC2FJyFbp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I30OjKCXTZ7ZFFs9W7BI8bkYYgCWEL7UhrJz3xrPwfBkzxCpkBKQD38xWNo18VoZK
	 DDQ763V0V62pOaUigj2/TeTrqKn18Yq10/AKE6ZJyT0/YuH6oQbehIRXCaJUZhZja+
	 /lAmvIUXs/ERkiOlWd1ePAF4vjzUGXCsC0x+423qA/YBtmwBm5EeolFHHi1v371WsC
	 GXzW0wwo0ef0mzX8Rs1rg7ws5y1nFq2lSwejqHi2s28WCc87a3Qkcd/he/9vAzR+5l
	 xMBXEmcv7NDOKURoVl78llhXgqTXWIwCm8/LVIVprl8kxxB/VYEUzIMg1FjDpUkOpo
	 PVNSNTzZsATNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/29] ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD audio
Date: Fri, 20 Dec 2024 12:11:09 -0500
Message-Id: <20241220171130.511389-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 1b452c2de5555d832cd51c46824272a44ad7acac ]

Introduces necessary quirks to enable audio functionality on the
ASUS Zen AIO 27 Z272SD_A272SD:
- configures verbs to activate internal speakers and headphone jack.
- implements adjustments for headset microphone functionality.

The speaker and jack configurations were derived from a dump of
the working Windows driver, while the headset microphone
functionality was fine-tuned through experimental testing.

Link: https://lore.kernel.org/all/CAGGMHBOGDUnMewBTrZgoBKFk_A4sNF4fEXwfH9Ay8SNTzjy0-g@mail.gmail.com/T/
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://patch.msgid.link/20241205210306.977634-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 973671e0cdb0..5b518a44b78a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7704,6 +7704,7 @@ enum {
 	ALC274_FIXUP_HP_MIC,
 	ALC274_FIXUP_HP_HEADSET_MIC,
 	ALC274_FIXUP_HP_ENVY_GPIO,
+	ALC274_FIXUP_ASUS_ZEN_AIO_27,
 	ALC256_FIXUP_ASUS_HPE,
 	ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK,
 	ALC287_FIXUP_HP_GPIO_LED,
@@ -9505,6 +9506,26 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc274_fixup_hp_envy_gpio,
 	},
+	[ALC274_FIXUP_ASUS_ZEN_AIO_27] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xc420 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0249 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4a },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x202b },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x62 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xa007 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6b },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5060 },
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC2XX_FIXUP_HEADSET_MIC,
+	},
 	[ALC256_FIXUP_ASUS_HPE] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10614,6 +10635,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
+	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.39.5


