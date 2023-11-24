Return-Path: <stable+bounces-142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13C7F7339
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D239AB21325
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA0200DA;
	Fri, 24 Nov 2023 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/isPony"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986D200B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77B5C433C7;
	Fri, 24 Nov 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700827121;
	bh=FRg5A16Z6WAtXLU6tbO5vkgzJJF5+wpQD/TliltYFCM=;
	h=Subject:To:Cc:From:Date:From;
	b=N/isPonyXm7t0mtdFF2BgRy/KMeFwTAtFMWcoAwhaAWuUtyxSA1Cd0YVsRtVY94zm
	 HmSgCmjZD+ZlNYn2tFDZ2SzWjOMieY0TLJ28PEecsmFRWXo2wqhTGssl2xVREnyN/I
	 q406je8lYZ+r+LOWTSMK9xTtHFZTBvsBFLSC0hpU=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - Add Dell ALC295 to pin fall back table" failed to apply to 5.4-stable tree
To: kailang@realtek.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:58:38 +0000
Message-ID: <2023112438-sizably-prudishly-ce00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4b21a669ca21ed8f24ef4530b2918be5730114de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112438-sizably-prudishly-ce00@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

4b21a669ca21 ("ALSA: hda/realtek - Add Dell ALC295 to pin fall back table")
9e43342b464f ("ALSA: hda/realtek - Enable headset mic of ASUS GL503VM with ALC295")
14425f1f521f ("ALSA: hda/realtek: Add quirk for Samsung Notebook")
24164f434dc9 ("ALSA: hda/realtek - Add HP new mute led supported for ALC236")
431e76c3edd7 ("ALSA: hda/realtek - Add supported new mute Led for HP")
f5a88b0accc2 ("ALSA: hda/realtek: Enable mute LED on an HP system")
8b33a134a9cc ("ALSA: hda/realtek - Enable the headset of ASUS B9450FA with ALC294")
76f7dec08fd6 ("ALSA: hda/realtek - Add Headset Button supported for ThinkPad X1")
54a6a7dc107d ("ALSA: hda/realtek - Add quirk for the bass speaker on Lenovo Yoga X1 7th gen")
48e01504cf53 ("ALSA: hda/realtek - Enable the bass speaker of ASUS UX431FLC")
e79c22695abd ("ALSA: hda/realtek - Add Bass Speaker and fixed dac for bass speaker")
d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo Carbon X1 7th gen")
436e25505f34 ("ALSA: hda/realtek - Enable internal speaker of ASUS UX431FLC")
aed8c7f40882 ("ALSA: hda/realtek - Move some alc256 pintbls to fallback table")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b21a669ca21ed8f24ef4530b2918be5730114de Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Fri, 10 Nov 2023 15:16:06 +0800
Subject: [PATCH] ALSA: hda/realtek - Add Dell ALC295 to pin fall back table

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

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 669ae3d6e447..d689f0050aae 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10821,22 +10821,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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
@@ -10880,6 +10864,9 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x19, 0x40000000},
+		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),


