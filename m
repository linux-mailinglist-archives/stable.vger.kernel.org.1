Return-Path: <stable+bounces-90045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E29BDCE0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FD21C2312A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500F219C98;
	Wed,  6 Nov 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtVFlk+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA46191F9C;
	Wed,  6 Nov 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859295; cv=none; b=bumGWstkCIg2+JPSNFqk+rDT9sultz3SgoiPamzfwfoCvFHv0tHXIZPU0mQrs42/RpXk/zrpIMNc93OL/oWsnegVQBLCyeZlIywIvFhkHyRivh/CBacYvwr1gZpxptCUA9dqBmt3bpn3rZvRbRB3NKKoJ5OB+DsnDyc7y82/png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859295; c=relaxed/simple;
	bh=x/WkULtpgcu+7wn+mbnUIATgu5kHvQQi4ewRNtvfbmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJzZgZe68mHMYn3sIzOH8K63YfFEjgvFbu30gJXxBdx6lBvF3/1Ga0/tOMvne7nYqgisU/K7QlMX2R+DjeQJ8e3ILsBNuHuXitSUdmnH7n/QoZ2qL4/l6pbYOl85oNxo+FBz7oX0x9qBZq7LZrbyt/T63HgwluZcUZtRpkq1ZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtVFlk+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE0C4CECF;
	Wed,  6 Nov 2024 02:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859295;
	bh=x/WkULtpgcu+7wn+mbnUIATgu5kHvQQi4ewRNtvfbmA=;
	h=From:To:Cc:Subject:Date:From;
	b=jtVFlk+n58LCuoZdUsAbVYksnz8OM0IqhUjYa7XstJYxkn7djA4ScQ1X6i8QzTP+6
	 9fMCum1zDPJnhK/8a9V7MIrAgx71B7eTT0byYCHWDEsTghIT/lwxTBc/AUSdH9j/tE
	 X6gm39tpFGjqtVBhDQJzcUcB/wZKsQaXDVCt0DAUaZymXwxbrBSVF8MrThttvAhMXp
	 IV72iTrRyOWEKIOLd29rfLjexFEr5E2ZPGczr/vW/TdTVFvm+D1MTbjYoiqCBucWjn
	 jgKRnKM+v/M1znZ2CW6IzxtOlQfL7xkSO8yx4xKeQAeGz5aBRedGuA49LtMbIkDTBQ
	 OuAekNrd8iMqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cs@tuxedo.de
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:51 -0500
Message-ID: <20241106021451.184554-1-sashal@kernel.org>
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





