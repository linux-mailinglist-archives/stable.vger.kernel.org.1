Return-Path: <stable+bounces-94924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D689D7469
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B24B3FA80
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDC818FDDE;
	Sun, 24 Nov 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px5MLmHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221F18FDB2;
	Sun, 24 Nov 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455287; cv=none; b=kLrQ8xaDUIFhaFUgfd9BTnYmIG1f2MXco2IqPZNr+8wmDG96uXdMYMOtKMR2bGWIGgwV1UeFq4iIRboJkYk73bpRJvQ1j9VGkt2fwwYnZXuQLwbFGUnWi+g0Zs7D27X+J7vjieJ3M4IalDrIFdVK9ZYhiBZHcvk4Xdr9+fdDJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455287; c=relaxed/simple;
	bh=lyjZaKqKxE0QGe0Zyc488hG25GxgRMhCPmH4RClICXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUZB8W879FM/fikA8E3R21Pv4mz9xLHM7OYDJUawXsbhftCqUgjr9VGTo833SkROPLSDEmriBkHRMEtjLn440dhg79rwqnWweC07ZJrFoIedETdPF6WsYn47HZHRLFtwfi/ExGlCLfOJY8KWusYJPOrh6zM5Cnkh+MhyMle9WTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px5MLmHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752BC4CECC;
	Sun, 24 Nov 2024 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455286;
	bh=lyjZaKqKxE0QGe0Zyc488hG25GxgRMhCPmH4RClICXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Px5MLmHJX1hBH8bQo6VfIquXT6j+dUr7epgV/iuz1v5VXhKHtevDCCjU7CEV1/Nzk
	 VYBcFp6HekJDjYquqpSpc87t7RQ1jAs6s4HKn18/AbIP4jZ8a3e6Ls2w10VUZsFCaq
	 U3n84vCHuNGEmm7KMMB8OjzWOKGuG/IX4PvfNEaxSMdHnCOTA4GNM8H7mdn5zejNQD
	 Y2znlffi5pTCpPBRj98SIZj7aSY89umksDegy2XJ1pw/+UNQT4ogydORgzBTquoDPu
	 P9LDsPewAg44GsXsVTia8wss7LJHJTzr7XQ0DPi2XTH9oryawIP99s/+gxCXdp+CS4
	 CelGjX2QpLB0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	bo.liu@senarytech.com,
	kovalev@altlinux.org,
	me@oldherl.one,
	jaroslaw.janik@gmail.com,
	songxiebing@kylinos.cn,
	cs@tuxedo.de,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 028/107] ALSA: hda/conexant: Use the new codec SSID matching
Date: Sun, 24 Nov 2024 08:28:48 -0500
Message-ID: <20241124133301.3341829-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 4df30976b73a2..2e9f817b948eb 100644
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


