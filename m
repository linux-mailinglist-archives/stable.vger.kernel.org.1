Return-Path: <stable+bounces-90031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343A9BDCBB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF3A1C2304C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A2217677;
	Wed,  6 Nov 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy/rJP+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2376217672;
	Wed,  6 Nov 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859245; cv=none; b=r8f26KvjhgUOzCtwDku7wwyIq6s59KlUu5phE5Nk1i8Vt36OWir/7a/uVHSLXhIU8tJiMId5qj6YzLdGj6vKQA9a6iac6yjm/vZRqGvY+aHyVK6QOv5MEYdF9bNoM0NVQoCXXTmwGvwApl17+7eet76al+Ak9lyvcrPNFX8LnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859245; c=relaxed/simple;
	bh=awAMHUsjXU/AB9Oyd2ktBDh7vHPbVZBObDDy9zLfnNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1G2MpefzcIZVPzMtZKNJ4UZz3txIpRflSM1CDiUHJKlDLqqTYBM9zZxn70Nm9QUvOeTIM4FHjwPbC8RrCMIMgfpRq4op/u7u3qM/TPVs2PAPitcgEiWRcco4BGCCBUVZW/9qM2URU1UrPza13csz2SuzFENEnw/ytqOj47sJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy/rJP+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECEDC4CECF;
	Wed,  6 Nov 2024 02:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859245;
	bh=awAMHUsjXU/AB9Oyd2ktBDh7vHPbVZBObDDy9zLfnNI=;
	h=From:To:Cc:Subject:Date:From;
	b=gy/rJP+SLvhzaJ6V7H/fLfHeWIA1OIZ01DpWTI4lEMWUJRwr1XRx/j48ozB441rPx
	 F7YWOlzOqGRDwHCU67O8wc+yemrYdpoOoZW3Q1avX/svXTH9H1RovwkdWySHuJYDWL
	 oj1Z5wa+TrVai95kqwYPdKbjuFowmQ5eFPLPpCyMnKYG3b2TPUtChUV9nxrRsT6g1p
	 6/+PL7QU/RSxDB/JT8JAYU7qyVetiGdazIZUDoIPiTivheKptIRb6xlm/mw5g41P09
	 /NNNQr4PAvz6F9uyI8tZKdVVpaIj00He2dogL47DWTHxtMBLq+BQra69Z8zmvgA+tp
	 idCvF+pzcR+PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3" failed to apply to v5.4-stable tree
Date: Tue,  5 Nov 2024 21:14:02 -0500
Message-ID: <20241106021402.183999-1-sashal@kernel.org>
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

The patch below does not apply to the v5.4-stable tree.
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





