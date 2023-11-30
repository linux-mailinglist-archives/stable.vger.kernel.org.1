Return-Path: <stable+bounces-3352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0AD7FF537
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB41F20F69
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691DC54FA4;
	Thu, 30 Nov 2023 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyosVhHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411D495C2;
	Thu, 30 Nov 2023 16:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A692BC433C8;
	Thu, 30 Nov 2023 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361615;
	bh=bn0Fbkba7wBGuWFF2c4LdJwqGMe0AA5aXghQyoxogZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyosVhHHOJlr41tzW/7TQOpCZfdAp4W0Cnz6Qzv+ot/P6sOUzGQF21u0lTn7BPuax
	 lU7uKJptpud/TliJ57Vf5PZCLVDSqxD7tPw9KZMLys7aJ7zfyuEp37OQN0S9ox8YHE
	 XU5yonu7tb8nqi+9XHWFKSzwjEXpVPVQwi+O3v+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitalii Torshyn <vitaly.torshyn@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/112] ALSA: hda: ASUS UM5302LA: Added quirks for cs35L41/10431A83 on i2c bus
Date: Thu, 30 Nov 2023 16:22:19 +0000
Message-ID: <20231130162143.250679684@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Vitalii Torshyn <vitaly.torshyn@gmail.com>

[ Upstream commit 6ae90e906aed727759b88eb2b000fcdc8fcd94a3 ]

Proposed patch fixes initialization of CSC3551 on the UM5302LA laptop.
Patching DSDT table is not required since ASUS did added _DSD entry.
Nothing new introduced but reused work started by Stefan B.

Currently there is no official firmware available for 10431A83 on
cirrus git unfortunately.
For testing used 104317f3 (which is also seems on i2c bus):

$ cd /lib/firmware/cirrus/ && \
for fw in $(find ./ -name '*104317f3*'); do newfw=$(echo $fw | sed 's/104317f3/10431a83/g'); echo echo "$fw -> $newfw"; ln -s $f $newfw; done

With the patch applied to 6.6.0 and obviously symlinks to 104317F3 FW,
speakers works and to my susrprise they sound quite good and loud
without distortion.

Probably confirmation from cirrus team is needed on firmware.

Signed-off-by: Vitalii Torshyn <vitaly.torshyn@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218119
Link: https://lore.kernel.org/r/CAHiQ-bCMPpCJ8eOYAaVVoqGkFixS1qTgSS4xfbZvL4oZV9LYew@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 61cbc08fdb04 ("ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 14fc4191fe77f..60e99389bcdcd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7366,6 +7366,7 @@ enum {
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
 	ALC2XX_FIXUP_HEADSET_MIC,
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
+	ALC294_FIXUP_CS35L41_I2C_2,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9495,6 +9496,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC289_FIXUP_DUAL_SPK
 	},
+	[ALC294_FIXUP_CS35L41_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9864,6 +9869,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.42.0




