Return-Path: <stable+bounces-135323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D5A98D9D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90E83A1EA2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74185280A5B;
	Wed, 23 Apr 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xlOv3maH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3227FD49;
	Wed, 23 Apr 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419621; cv=none; b=Lqv/L6UveQcX/PPIxQyeS0Y9IwjMLkxxDE6kcKsX1rdSr+YEqt2YdufSTIJgKJSf2u3iTuGOk5PN2/BiENpiP0ZhGFx5P779t3bhG5eNyRbTxZzUtwL/E9GXzgowS/rWl4W8MUiEiP7HnWqBMttMp0lyGesgua5i/9yJVe25j1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419621; c=relaxed/simple;
	bh=d7ydaI9PKSELcpVrR0K4JutRTBxfU0T3R1NOS2rKnSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrFV60V7B8KEJNzyo/VDow0JD1Nehkx/2HU5XW6KQbdVIlBxAYzBMMWxiM9MK8nRtEJqQZ0ISnXrxv6bal5UUaY4Z1P4nXk0etq7SbApj3mH3k6/B61GdL7AZA1g6zEmFcrAjwA+2bFMfqChRF1lanDEyCIMKqjFLs2ByBbFloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xlOv3maH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C370C4CEE2;
	Wed, 23 Apr 2025 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419620;
	bh=d7ydaI9PKSELcpVrR0K4JutRTBxfU0T3R1NOS2rKnSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xlOv3maHhnR11mQh1DWLjL8edGY7J/bUg1Zrb2IaIqHabG2NaVrt7I+Bik8hfrRLe
	 5ehb69a1cgG3JRbGgY3tmSzC2Ph21vgjdYqa8nsiMRMDyERiGICmHt5AE6s7/gWJrM
	 3l8iPq1vlF07nVZr8qSZZV6qbf3Da4uQIz4tX/Y8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 023/223] ALSA: hda/realtek: Workaround for resume on Dell Venue 11 Pro 7130
Date: Wed, 23 Apr 2025 16:41:35 +0200
Message-ID: <20250423142618.060842327@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 8c2fa44132e8cd1b05c77a705adb8d1f5a5daf3f ]

It was reported that the headphone output on Dell Venue 11 Pro 7130
becomes mono after PM resume.  The cause seems to be the BIOS setting
up the codec COEF 0x0d bit 0x40 wrongly by some reason, and restoring
the original value 0x2800 fixes the problem.

This patch adds the quirk entry to perform the COEF restore.

Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219697
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1235686
Link: https://patch.msgid.link/20250130123301.8996-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: b5458fcabd96 ("ALSA: hda/realtek - Fixed ASUS platform headset Mic issue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4ae987731a152..b660bbfc6b0cc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7597,6 +7597,16 @@ static void alc287_fixup_lenovo_thinkpad_with_alc1318(struct hda_codec *codec,
 	spec->gen.pcm_playback_hook = alc287_alc1318_playback_pcm_hook;
 }
 
+/*
+ * Clear COEF 0x0d (PCBEEP passthrough) bit 0x40 where BIOS sets it wrongly
+ * at PM resume
+ */
+static void alc283_fixup_dell_hp_resume(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_INIT)
+		alc_write_coef_idx(codec, 0xd, 0x2800);
+}
 
 enum {
 	ALC269_FIXUP_GPIO2,
@@ -7899,6 +7909,7 @@ enum {
 	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
 	ALC233_FIXUP_MEDION_MTL_SPK,
 	ALC294_FIXUP_BASS_SPEAKER_15,
+	ALC283_FIXUP_DELL_HP_RESUME,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -10237,6 +10248,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc294_fixup_bass_speaker_15,
 	},
+	[ALC283_FIXUP_DELL_HP_RESUME] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc283_fixup_dell_hp_resume,
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -10297,6 +10312,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05f4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0604, "Dell Venue 11 Pro 7130", ALC283_FIXUP_DELL_HP_RESUME),
 	SND_PCI_QUIRK(0x1028, 0x0615, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x062c, "Dell Latitude E5550", ALC292_FIXUP_DELL_E7X),
-- 
2.39.5




