Return-Path: <stable+bounces-2341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F827F83C4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF534B26AC9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1235F1A;
	Fri, 24 Nov 2023 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="of0z5X7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81731748;
	Fri, 24 Nov 2023 19:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367AAC433C8;
	Fri, 24 Nov 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853643;
	bh=0EX7k71m/Vy/DkiKf/WDxXhaXzFVQmt1z6F9x3QcP0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=of0z5X7cPjOlrW+M28cexgE8k+bmWwSISIMBdEmrJjCNkDurP33k5gLoihejT5kxA
	 uA3a//TWOtti+stfuMqwI/+hjwOlerU4Goe60xaKBNZ2PTAYo4Yq3MUGs0bNUJbBE1
	 iiRKw7EOmFkBv3ksPnn209C8lEolthnPPsdHLlxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 236/297] ALSA: hda/realtek - Add Dell ALC295 to pin fall back table
Date: Fri, 24 Nov 2023 17:54:38 +0000
Message-ID: <20231124172008.450349642@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -9963,22 +9963,6 @@ static const struct snd_hda_pin_quirk al
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
@@ -10022,6 +10006,9 @@ static const struct snd_hda_pin_quirk al
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),



