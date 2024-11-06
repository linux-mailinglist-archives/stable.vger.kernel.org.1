Return-Path: <stable+bounces-90032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7469BDCBF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07BA1F256BC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484B21790A;
	Wed,  6 Nov 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGMiLuFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD932178FB;
	Wed,  6 Nov 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859248; cv=none; b=YaC27Anaz9v9kfdl8UwMizbH0unF6TDh525qYjtLZKLgtFJl36kD0cpk/Kb+z4R/Kn4Yr1lIDia5VrPaiM1LINVgarspQCMdQZuEYbvLqfvPrgM70U7rhgsC/suF4bJGXXO9LueW3nE+IHZaw0F16ybI+E4Ach1Qv0RYFb6UHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859248; c=relaxed/simple;
	bh=2mhfFY4CusycLGFFB8qPHzk3yqF1Z1C+sLk7hcyqBts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqMlr8U+NHFi+ImcVcvHVZXKS7mEfQ8xvnAupeOHNpyT/HqSd+4oR0Yc//19Xwhz9j5VG8qmj+C+jabJOZpChis8N/UI9oT61EYtkazMOE/U9stftO6MVzLEexMI3+Nc3N3VuxzDvsEaLhnDuNxLpo+QvbHkVHc8l9LPslgT2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGMiLuFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7148AC4CECF;
	Wed,  6 Nov 2024 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859248;
	bh=2mhfFY4CusycLGFFB8qPHzk3yqF1Z1C+sLk7hcyqBts=;
	h=From:To:Cc:Subject:Date:From;
	b=LGMiLuFu8btgr5aq29CotXsDUN12q9RGgjx8Pi4ELR6UOpgNaxS2qpsT1VzDSF6Wp
	 k/CwPVU/CZhYOf2cGW3Fh3z6juP75NcM+guJ1X0I15FRD63SeS9XBIUQXGPotDHote
	 JrtshVJnaoajJUqi6evw5+hB4HYbT3gvrKFn0VH52ZRwQHDrkFmBngQC20XCxA8B+A
	 /poVDoifmdpNl5Pn4vJqoyVqB7cF493kVgJSxBt5q475rnX7Qlo3iYtBYqc9Ic6VDR
	 FeicJ8rgsVymAj6CaW4AI0/oYhuZV7L8pSUbQBzAcLsK8D7Wmq+wrcIIc+sizpNfOY
	 8zONbwtvO4SSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:05 -0500
Message-ID: <20241106021405.184036-1-sashal@kernel.org>
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

The patch below does not apply to the v4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e49370d769e71456db3fbd982e95bab8c69f73e8 Mon Sep 17 00:00:00 2001
From: Christoffer Sandberg <cs@tuxedo.de>
Date: Tue, 29 Oct 2024 16:16:53 +0100
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16
 Gen6 mb1

Quirk is needed to enable headset microphone on missing pin 0x19.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241029151653.80726-2-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e06a6fdc0bab7..571fa8a6c9e12 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11008,6 +11008,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
2.43.0





