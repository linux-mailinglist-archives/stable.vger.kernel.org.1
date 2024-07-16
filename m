Return-Path: <stable+bounces-59605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD8932AE3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1581F21081
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DFDF9E8;
	Tue, 16 Jul 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwajEb3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C61B641;
	Tue, 16 Jul 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144352; cv=none; b=erZCYdfVrYvoF2JEeBLtnyVmIQnUZM+wAi2pnkNQENOpfaoRhWsh084xuJkQ0q54q+gI19iEvlNrL203k43p7vkyHr4TR4cHG1h9YTZFcf2ivKBu/kOxCtrXlKr1JMnih2plOUu2jc6xHKnBnnW20nymHysbLwwmQ6yUt0ZTrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144352; c=relaxed/simple;
	bh=DFd90lUEnmHnAaxLU73gTQaEwTgrlakKuJzcvC/eR2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzGqtJVUSzJrQOyUZj39H4EpRFoO1HpyAt75g7cC8cJ80szCFFyGe9pTJzS68/GAwXIcGfR3C2floiEpexAThLd+TO6ABH3JqgPmT+zWoJ1U1zWXuEIz3/nKlQLrymWFRL6SqCb6QJPaRKWcEJhUIWL+WDMm7c41CYW+XDFPdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwajEb3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D2C4AF0D;
	Tue, 16 Jul 2024 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144351;
	bh=DFd90lUEnmHnAaxLU73gTQaEwTgrlakKuJzcvC/eR2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwajEb3/MiX5+xW85URcnOU8tR04RhLG9H5Omm76TCLlN+s185lB5UIzXFweIPXtc
	 ITWDrAQdiINWL/eNcR8fD39I64sClSEBAPzAzCQGCMWkqtXWJEuFGiR/eq7tiTe3HH
	 VSaTQj4Utd0DEHGvb5jUunSBW16SMxxsTmZswOVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian-Hong Pan <jhp@endlessos.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 43/78] ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897
Date: Tue, 16 Jul 2024 17:31:15 +0200
Message-ID: <20240716152742.304489615@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
References: <20240716152740.626160410@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jhp@endlessos.org>

[ Upstream commit 45e37f9ce28d248470bab4376df2687a215d1b22 ]

JP-IK LEAP W502 laptop's headset mic is not enabled until
ALC897_FIXUP_HEADSET_MIC_PIN3 quirk is applied.

Here is the original pin node values:

0x11 0x40000000
0x12 0xb7a60130
0x14 0x90170110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x03211020
0x1c 0x411111f0
0x1d 0x4026892d
0x1e 0x411111f0
0x1f 0x411111f0

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Link: https://lore.kernel.org/r/20240520055008.7083-2-jhp@endlessos.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bf9a4d5f8555d..2c0bfdfcf6410 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9909,6 +9909,7 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
 	ALC897_FIXUP_UNIS_H3C_X500S,
+	ALC897_FIXUP_HEADSET_MIC_PIN3,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -10355,10 +10356,18 @@ static const struct hda_fixup alc662_fixups[] = {
 			{}
 		},
 	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 }, /* use as headset mic */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x9087, "ECS", ALC662_FIXUP_ASUS_MODE2),
+	SND_PCI_QUIRK(0x1019, 0x9859, "JP-IK LEAP W502", ALC897_FIXUP_HEADSET_MIC_PIN3),
 	SND_PCI_QUIRK(0x1025, 0x022f, "Acer Aspire One", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0241, "Packard Bell DOTS", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0308, "Acer Aspire 8942G", ALC662_FIXUP_ASPIRE),
-- 
2.43.0




