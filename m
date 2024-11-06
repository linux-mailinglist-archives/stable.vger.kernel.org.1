Return-Path: <stable+bounces-90002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDA9BDC72
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A31C22F5A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E41DFDB1;
	Wed,  6 Nov 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsSkzrqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB61CCB20;
	Wed,  6 Nov 2024 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859144; cv=none; b=F96n9vcn9moYitHzIY8RnQQQZ+L/UeyhRV+h++kT4C/kzfc35bN3dPvX58Fp8hfq6tULshO+63o4+uZo9rszFWy34hvRpKLlsJczpquTdvL7rt1sHIR66+AEZX0eBnHvubl8lRxmuU00G0Wi3Anmst1zEl4bDQ/QLcmZgepz3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859144; c=relaxed/simple;
	bh=AjXCfrn7RrWu+H8LhKHN9yNxpkeQpsDBUXdW/5Q9KkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdBA4VY7m/6PZastgWQeCMlFP6UCC5m7uHxY+2O/SnYy9rrUhInnxq3in32M3j9ltOsMRuZVvXW8E+KYV2jOW5dIGa8D0tKJ8laJiUdeL49pk3c9qjxnSb897VMMLNBk7rcveDZLLd3yZQakVeuP8uSUeeIWXoSxTJMXWLJ/gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsSkzrqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B6BC4CECF;
	Wed,  6 Nov 2024 02:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859143;
	bh=AjXCfrn7RrWu+H8LhKHN9yNxpkeQpsDBUXdW/5Q9KkE=;
	h=From:To:Cc:Subject:Date:From;
	b=FsSkzrqDk2gFIOpfrmt+STDk7oKhZVaB1Z9yvZ7oxuIiwqSo4AVzj3is3QyeB48nJ
	 aanMMB3D8JagwyyyXCCb+n4u1m2amABGMsGXKPgqEuCNYzAF8aEdZfa0f937VEUkN7
	 zTC1L3BYLjO/8ufp0VJIssUGAZMBgQgxta5lUGTAv3mGjAFAPCef9/3qzx2z7PC4YM
	 nNsxsRUDmMW1Klk3yMjrds39eJXYdPHbfc9jz/Wk2Vi0mZqZrSAyTHncjllK1POVT+
	 M8QuvNVnt1xcn1PzSRZ+HCgbE0j52y4KgyEfiOgEBMKgAvKnnjHo1ZqJd23s3Qqfs6
	 ioablpHxHdHvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:12:20 -0500
Message-ID: <20241106021221.182853-1-sashal@kernel.org>
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

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0b04fbe886b4274c8e5855011233aaa69fec6e75 Mon Sep 17 00:00:00 2001
From: Christoffer Sandberg <cs@tuxedo.de>
Date: Tue, 29 Oct 2024 16:16:52 +0100
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3

Quirk is needed to enable headset microphone on missing pin 0x19.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20241029151653.80726-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7f4926194e50f..e06a6fdc0bab7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10750,6 +10750,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x1404, "Clevo N150CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x14a1, "Clevo L141MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x2624, "Clevo L240TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x28c1, "Clevo V370VND", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.43.0





