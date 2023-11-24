Return-Path: <stable+bounces-931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A447F7D33
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95447B21432
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16BF34197;
	Fri, 24 Nov 2023 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KaciRygz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AC33CFD;
	Fri, 24 Nov 2023 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F362C433C8;
	Fri, 24 Nov 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850137;
	bh=AcX/6OJRfWAhtJ0m9hoqSkv1j67DsCC4zRF/kBh2NQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaciRygzg9BD7jHH96jlyiQH80aZBKjenVBMJw0YGNzN+cd4HdiThxKv4tzmft5cC
	 wWL85AcTHJiaS5kVIhtcKNpt1w8CPL4wK/puyICMIWKQowYJoOi27GsV17t0T26QSA
	 2nSbzX2DV98bBPWGbVfR0KwVl1yAd14VSf0lgv+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 434/530] ALSA: hda/realtek - Add Dell ALC295 to pin fall back table
Date: Fri, 24 Nov 2023 17:50:00 +0000
Message-ID: <20231124172041.291231660@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 4b21a669ca21ed8f24ef4530b2918be5730114de upstream.

Add ALC295 to pin fall back table.
Remove 5 pin quirks for Dell ALC295.
ALC295 was only support MIC2 for external MIC function.
ALC295 assigned model "ALC269_FIXUP_DELL1_MIC_NO_PRESENCE" for pin
fall back table.
It was assigned wrong model. So, let's remove it.

Fixes: fbc571290d9f ("ALSA: hda/realtek - Fixed Headphone Mic can't record on Dell platform")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/7c1998e873834df98d59bd7e0d08c72e@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10735,22 +10735,6 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x14, 0x90170110},
-		{0x21, 0x04211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
-		{0x14, 0x90170110},
-		{0x21, 0x04211030}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS,
-		{0x17, 0x21014020},
-		{0x18, 0x21a19030}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS,
-		{0x17, 0x21014040},
-		{0x18, 0x21a19050}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170110}),
@@ -10794,6 +10778,9 @@ static const struct snd_hda_pin_quirk al
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),



