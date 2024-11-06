Return-Path: <stable+bounces-90017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00E9BDC99
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BED6281D02
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A1618FDB4;
	Wed,  6 Nov 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV5b2Gz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE71D2B1A;
	Wed,  6 Nov 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859196; cv=none; b=XjjiFTZsiShnkDRoJQP1Hubrd4fWVKs3DTqUBOeLfNqReT0KuRM6Uk3T9V1wsUW1ZJvvbhmkW1NFtl9sv4VAnJt+JMOeaX6PAvBK1V4YvMJT1RARhp4382Ax7Ipu/NPI4Fdp4E1sqtha7bNsRfcUN5TpTzXc4m/oFJ5aLT3u5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859196; c=relaxed/simple;
	bh=PPBKVJZgss6Z9t7HP0L3S6xMxGlsPB2dfiHwGoN9kuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyQJWuUFyAYeodtStuDbZSiQM6Att40gnE+P0s1h6CRXGinMiG+mZ2+/gvHhjdllPdvIKdwEA2gK+8tILwCOqR6ALRIWIthnmOUU9lRisiGX6EZm9rtZQqodqR+UIZHWP0ohVmILGUEPfC6/WFgdIpSlM8SvzKFWtqs9YTaUMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV5b2Gz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324FBC4CECF;
	Wed,  6 Nov 2024 02:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859196;
	bh=PPBKVJZgss6Z9t7HP0L3S6xMxGlsPB2dfiHwGoN9kuM=;
	h=From:To:Cc:Subject:Date:From;
	b=UV5b2Gz7rmJS14LiSWBDYjEplkOLQYWOKLbMBDvthJr/hnrlW1ftRRp1adN8uLXjH
	 HxmJ8sbByZd5ReT2MXIGDApBxXconsopUIAHMF2Cjom/cQWunXanThS0mR9RNvo5MM
	 eICUAMRPltLFz9DmrzWJqvGsVz6pyM/oAISWDE0sCUgZLPYnFIJLns2b0h78aZUP5p
	 znOTWG0vRjsCiIeFmj++qXnIFCNBmCm3xJZcIh+wSrH1fbdsr/Z7uLES6LauBlDnVz
	 P5GFkyAJ9BC7GSt0z7YauO+5C1kF5EMxBWmZCXrgFs2NIBmhqc51j1eR3/Hlj40xc2
	 Yvk90TIDQM8EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:13:13 -0500
Message-ID: <20241106021313.183445-1-sashal@kernel.org>
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





