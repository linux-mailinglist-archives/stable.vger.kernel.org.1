Return-Path: <stable+bounces-89986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A629BDC4A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659D6B23894
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48DD1DE2DE;
	Wed,  6 Nov 2024 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8EeS7DN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD41192D7B;
	Wed,  6 Nov 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859088; cv=none; b=OxAFvnW2+iW1kzoHk6Vu5joWSFtnqsc/PiqIxy0Z3ucX7UHnk6Rps5PV0DfhrYCvL+DzSPZ/j91KtEQlIIpIY9bDmgVwKY0z/jtDur9eUOtNgKSsrEtwLP06IMcd1g5rYvl/hB245/A5poIwZLgKIBfbd+i9oHmVYGtGM+UXosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859088; c=relaxed/simple;
	bh=HQGCYKn60bg17irKNbi6Q0Yj920UUZNaiJaxuZuxlJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxgGGTTz/YN3LKDBY5FnHODlxotSqmshlKhZ1NjqpupMxTCx+oZYzk0vIhnMTrNLZbjmWzh8nwzr3nk7GJzAMoxJQPbkLGd4IP4aRc1ecj4UfXhldc4HlxUaYi/HXnPTmyfSRTVadoDu0wOlzAwxJeOhofPXioc8NzacHEEo/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8EeS7DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18079C4CECF;
	Wed,  6 Nov 2024 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859087;
	bh=HQGCYKn60bg17irKNbi6Q0Yj920UUZNaiJaxuZuxlJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=c8EeS7DNx9O6bb2Xu7p4yTPPC3C3t8bRfxUfUe7S+AWlhGdJUDmTHqbWaDOnjvRIu
	 p/fRr1eiuiAl8neovKDQwNV5jezLwsiUrxLrXGEa+hbcUup9polGDY1iCaW6B6+69q
	 g+8I8tc1wlKew9+WEfYVgPq9UH+qTQDl/TpV/n+fNYgO0QwazQN+K1FsxWOCUFfsRR
	 0csilP7McpPlHPgoskHdm/N8kCn1E2Lb3jrH2Mu8nH1vgsC4pj/DR9SU3d7OhVGULh
	 Tp9QlkdQyrZz5mfiQqISfrfo49VJsdy/9h3AbJjclnvaIaTMMjCdcJaGKGQ7KFKq98
	 nTZ/qgpx65gKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:11:23 -0500
Message-ID: <20241106021124.182205-1-sashal@kernel.org>
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

The patch below does not apply to the v6.1-stable tree.
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





