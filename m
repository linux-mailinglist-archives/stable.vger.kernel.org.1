Return-Path: <stable+bounces-90003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782E9BDC74
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41531283C26
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4B1CDA17;
	Wed,  6 Nov 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs7Oqyle"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36C1DFE13;
	Wed,  6 Nov 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859147; cv=none; b=gKqbxlOZHRFdSvTB7CoP09TnTGSVEzwYKyNpP8/8DfJ19ElJDb9YvYyZUnJukfJooURSvVDUDzRnrX4C7spEe1L/mdiUDzPj+f5C+QtPau3F/p9VUmvYaldme1628Lzz9ZNF/faddDf1X6BZfYCzvQv23qqP/aSzDzt3c90qlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859147; c=relaxed/simple;
	bh=XOeEXsZhF4rKJbwML285L6h93Hbso1f8douDtD5yYWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6R4+PLz+Ye6uy6GzVLDGu/xe1DBD8LRopcRtamr1xtUkXD5fD/tqVzTZiDUlvIuGqzX2vokvVn3m5KzHFgGY4ISlp4VuBwmyQ5rSW0vl6uO3BoSFrrFoJ1qmnoxY8GNyomzdXML/gDTO67r+RuVTtLLmBWmh+nechuqtHcw3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs7Oqyle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54376C4CECF;
	Wed,  6 Nov 2024 02:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859147;
	bh=XOeEXsZhF4rKJbwML285L6h93Hbso1f8douDtD5yYWY=;
	h=From:To:Cc:Subject:Date:From;
	b=qs7Oqyle6KHAirhPW51RiznfE8VNlseMetWgM65++QjmbuBCiIN+3dGr5SCyDND6F
	 I0LHCgbPDQvEm7dtQvF+q4Kd5iVMpvppPJBa7Deqzm0tL84XCKDpEzIwSq9U8JAUuq
	 C/8ekWvyXIO44HCyIif3MWIaQhoRAVxK/oDEd+O6MpIL57GvgBO5+PpVGDriEV03ps
	 uwqY2gohqWr6DpW0dKsQlRuPeUc16l0FilPiWWFFlAfMYoXEQxXemPNocEYBtB0Zot
	 eM7RuhGpJGxjgVWq1HvEI0Ds/7FyW83P2ug0yzZAXuVXSCdWUxzRzdlvL1hdUEiO5z
	 5ccuVFnQG5M6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:12:24 -0500
Message-ID: <20241106021224.182890-1-sashal@kernel.org>
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

The patch below does not apply to the v5.10-stable tree.
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





