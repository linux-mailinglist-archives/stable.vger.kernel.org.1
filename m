Return-Path: <stable+bounces-95027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12219D7352
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A38B669A1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BCE1D1E74;
	Sun, 24 Nov 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWmad7xr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52C1D0E27;
	Sun, 24 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455756; cv=none; b=VjLxUKBCG4j/ufhhVOuMdD2IVfBq+Xp79Xe2FhF+UuruIAUnmRH/zOclQeO00sfTOl8kPp69/XclJcudMJVNu16MEkYvavTmmP9uK5UDLviz+zkKQIk6GN0e0qeA2NCK/0x+/5CehyUBoYkmMSj/QnLo0j/SASVnzUTh2r/JkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455756; c=relaxed/simple;
	bh=kAmesRA6DX/38zulmfZzoQXn0SUInPhfVYwWEiE2AqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPqODwbik9hyQ2Q7ksM4e5oo0LrWMoEc8+tRkB5KbG/t1iMSDuomLOV2rTjVbgS+zWhZNDRNO8G5tXUttU+DhA8qbs9hegBeup/CWTiaNjCHxgPbfHFVCiAGuX8P7s8xSYPzxhUKd1TdH2K/wagA6kLel5y1GDY8SuQUGwsHrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWmad7xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767DBC4CECC;
	Sun, 24 Nov 2024 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455755;
	bh=kAmesRA6DX/38zulmfZzoQXn0SUInPhfVYwWEiE2AqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWmad7xrzvF5OQrdVNp4kaTnMo0tUkwMjykv9qON314rIaO9sVNbnIBF2rXC5S22i
	 0A0bgRKGbaMHm6dn8SFSDvrgW7VMN2QDjl5P2j6bo8cuUFApNTqAz7MGzEIg1SKuIz
	 +klCsEmk7rR5Wq2rBjbqUlgqqhAFFBLO5HRnwWop01AFcEKCf0qf/NhVpi1FAWgTY/
	 SUZNVjWjxfcmc+5+ISY+QpqE6hmHQKUY6qe3v1UKV+Mgko913T9UMVEdXXnAfDm6pG
	 UXs7T0PMTG3FQZjwgBv8r4Y2jswMPyBZ6WmMYmz2Om3+uk9NJ/qU+5W6UU7cUaEHz3
	 bMR5d6XFTFlYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	bo.liu@senarytech.com,
	kovalev@altlinux.org,
	cs@tuxedo.de,
	me@oldherl.one,
	songxiebing@kylinos.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 24/87] ALSA: hda/conexant: Use the new codec SSID matching
Date: Sun, 24 Nov 2024 08:38:02 -0500
Message-ID: <20241124134102.3344326-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 1f55e3699fc9ced72400cdca39fe248bf2b288a2 ]

Now we can perform the codec ID matching primarily, and reduce the
conditional application of the quirk for conflicting PCI SSID between
System76 and Tuxedo devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20241008120233.7154-3-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index b0a291762ec28..7e72df3306259 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -828,23 +828,6 @@ static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{}
 };
 
-/* pincfg quirk for Tuxedo Sirius;
- * unfortunately the (PCI) SSID conflicts with System76 Pangolin pang14,
- * which has incompatible pin setup, so we check the codec SSID (luckily
- * different one!) and conditionally apply the quirk here
- */
-static void cxt_fixup_sirius_top_speaker(struct hda_codec *codec,
-					 const struct hda_fixup *fix,
-					 int action)
-{
-	/* ignore for incorrectly picked-up pang14 */
-	if (codec->core.subsystem_id == 0x278212b3)
-		return;
-	/* set up the top speaker pin */
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
-		snd_hda_codec_set_pincfg(codec, 0x1d, 0x82170111);
-}
-
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -1009,8 +992,11 @@ static const struct hda_fixup cxt_fixups[] = {
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = cxt_fixup_sirius_top_speaker,
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x82170111 },
+			{ }
+		},
 	},
 };
 
@@ -1109,8 +1095,8 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
-	SND_PCI_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
-	SND_PCI_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
+	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
+	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
 };
 
-- 
2.43.0


