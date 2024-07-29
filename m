Return-Path: <stable+bounces-62500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDC93F4CB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B229F280EC6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EE145FF4;
	Mon, 29 Jul 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wQ6spZoa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5D143752
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254595; cv=none; b=hUWZ0kGto9finkC0hHV+UZfhHp3qOaBA2OfqNiOpvX5gCnivkao7MN1fRLqbsPk55GA2+96jz6hW9wi+r3WBtGTuhbxfLWtFKp1pV5bt2js4zjmryUUOlYNGOxXA31rMWmGuMccraSBDHubhlHFoblWoiSzynSSJ/T53ugek6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254595; c=relaxed/simple;
	bh=1QxdFpIeNYTZyCYkLkOQKyguFgY5TxKztxe1v1Y64JA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xg3F8TKdlALGCnr2f4+yx7zArurrDX5bi62r8arHToAsMbxvC7Mx180Tg+pkNOgjTdwZFXWILBAzgJwaCFE7vdZYzwalyHbN3bzjKsgEDGufN/+tHPYuDQv2vdJJKbXeVBbiW1gk2oLEd+behjiSP8bMjWmkDsyYI2YKZoj92T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wQ6spZoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F49C32786;
	Mon, 29 Jul 2024 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722254595;
	bh=1QxdFpIeNYTZyCYkLkOQKyguFgY5TxKztxe1v1Y64JA=;
	h=Subject:To:Cc:From:Date:From;
	b=wQ6spZoar8A31z0uJ4bxb/WqHzzuNVvUAmljt0ZJqgf07X54yMBG1hoW9xDEBpFPg
	 kAyJWicFCwV656bPRNhZYK4ECFThxckc5WlvwvTj6DFkSXQ75g6+kugvMTOsMmJyWn
	 ShMYw1O/mF2PZZt8YLBWFHdbEAIoQzkWq3c2s3y8=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models" failed to apply to 6.1-stable tree
To: luke@ljones.dev,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:03:03 +0200
Message-ID: <2024072902-kooky-velocity-3391@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e6e18021ddd0dc5af487fb86b6d7c964e062d692
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072902-kooky-velocity-3391@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e6e18021ddd0 ("ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models")
2be46155d792 ("ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp")
0bfe105018bd ("ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR")
24b6332c2d4f ("ALSA: hda: Add Lenovo Legion 7i gen7 sound quirk")
b5cb53fd3277 ("ALSA: hda/tas2781: add fixup for Lenovo 14ARB7")
ba7053b4b4a4 ("ALSA: hda: Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie")
d110858a6925 ("ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low")
ee694e7db47e ("ALSA: hda: cs35l41: Support additional Dell models without _DSD")
2b35b66d82dc ("ALSA: hda: cs35l41: Support additional ASUS Zenbook 2023 Models")
b257187bcff4 ("ALSA: hda: cs35l41: Support additional ASUS Zenbook 2022 Models")
b592ed2e1d78 ("ALSA: hda: cs35l41: Support additional ASUS ROG 2023 models")
8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")
f01b371b0794 ("ALSA: hda: cs35l41: Use reset label to get GPIO for HP Zbook Fury 17 G9")
447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
93dc18e11b1a ("ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED")
581523ee3652 ("ALSA: hda: cs35l41: Override the _DSD for HP Zbook Fury 17 G9 to correct boost type")
3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
ef4ba63f12b0 ("ALSA: hda: cs35l41: Support systems with missing _DSD properties")
a32e0834df76 ("Merge tag 'asoc-v6.6-early' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6e18021ddd0dc5af487fb86b6d7c964e062d692 Mon Sep 17 00:00:00 2001
From: "Luke D. Jones" <luke@ljones.dev>
Date: Tue, 23 Jul 2024 13:12:24 +1200
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models

Adjust quirks for 0x3a20, 0x3a30, 0x3a50 to match the 0x3a60. This
set has now been confirmed to work with this patch.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Fixes: 811dd426a9b1 ("ALSA: hda/realtek: Add quirks for Asus ROG 2024 laptops using CS35L41")
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240723011224.115579-1-luke@ljones.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c3a86a99f8c6..462194bf6954 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10359,10 +10359,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
-	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
+	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),


