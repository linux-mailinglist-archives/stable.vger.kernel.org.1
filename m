Return-Path: <stable+bounces-32550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0A88DFB7
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 13:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A029B2261F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A50140E2E;
	Wed, 27 Mar 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/wEybWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E76140399;
	Wed, 27 Mar 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541427; cv=none; b=G7jC0ne9ZsqfkaL/+MFQPsNpWSJxVE2r86/vCILcH9kxSLl2t/obw1Os3W/j1jJn1aZJo2Xr7cJLOiJyJaWiaSXjQXSTgWNEn4wPZ5ESJatyVQcSPy+4lDE6yqK6zhX9eI1XZ1k6yLmzWsq4lJzY12K/wfSpKDfgrelTv7of34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541427; c=relaxed/simple;
	bh=Y2Z2ZR3fiSQfzSRc2diJb2S5rTn0C/g2LEO9b5VHaK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcca3YqtGkDkz/E1mwqYuEDv1mJQZj2GcWZ8kb4NbLDQZ8cabtVQ5QQAuuhCuVEhVTJfslB3+Vt/APdzTg7L3bO4SI/O2Fchn17azQDmCj0XG4m4AgDPbiyhFZ0GLCuPDnb2ecE5mn6WV+KnJlEbnrkvBrObqg/P55qYb8qZghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/wEybWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1332BC433F1;
	Wed, 27 Mar 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541427;
	bh=Y2Z2ZR3fiSQfzSRc2diJb2S5rTn0C/g2LEO9b5VHaK4=;
	h=From:To:Cc:Subject:Date:From;
	b=I/wEybWOqSdZPsCxa3lRcujgyxTLFp0XgV89oV3g+v96ylhMFcPgVr5bBmqiSJOss
	 PERjWNnBYRSa+EopMUwGm6AnzhMZIi8iF9Ceqc7f3xIl3UlFnAiUcO2lzeRcwUzCU2
	 K4dFSXipBsMCVr4Du1ytr1BFLWq7fKR4giLAcGuBqidNEzAX2Fm1zxLAae5FI1ZGlg
	 a2IbSpDTC85+XQ15hnfwyPjxUGN1tEXyz9TA1Yhcw/5himd3QNBI/RWzO2kRkvvYc1
	 SyywQlAlARw/5dr1z6ebjNODR0Nnj4MSLTMbF/dEmW4fUCW0I+dthIbKwL40C4uDSK
	 RmhoQDZqn2QMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	faetalize@proton.me
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on some HP models" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:25 -0400
Message-ID: <20240327121026.2827950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 300ab0dfbf3903f36b4456643d8201438e6553b1 Mon Sep 17 00:00:00 2001
From: Valentine Altair <faetalize@proton.me>
Date: Tue, 12 Mar 2024 14:42:00 +0000
Subject: [PATCH] ALSA: hda/realtek - ALC236 fix volume mute & mic mute LED on
 some HP models

Some HP laptops have received revisions that altered their board IDs
and therefore the current patches/quirks do not apply to them.
Specifically, for my Probook 440 G8, I have a board ID of 8a74.
It is necessary to add a line for that specific model.

Signed-off-by: Valentine Altair <faetalize@proton.me>
Cc: <stable@vger.kernel.org>
Message-ID: <kOqXRBcxkKt6m5kciSDCkGqMORZi_HB3ZVPTX5sD3W1pKxt83Pf-WiQ1V1pgKKI8pYr4oGvsujt3vk2zsCE-DDtnUADFG6NGBlS5N3U4xgA=@proton.me>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f92b19a58501..b6cd13b1775d9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9870,6 +9870,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
+	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0





