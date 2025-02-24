Return-Path: <stable+bounces-118865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C32A41D0F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3BE7A2DC1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40D26FA7E;
	Mon, 24 Feb 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb7VwFf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C725A332;
	Mon, 24 Feb 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396005; cv=none; b=Yz1AHd2KPSWqeRwiLxV366MLXinrWxaubM0m9pD2TCdkAft+cQh40sJrao4eBZZLJvycOK8ho8QbXw74L5WRkPTpW+dsDkqnArlwKTeyu7QXAlheNtBCm0OuhgNoX+p/knfwYUoR9tZlGwfORZkkKr1yKhNe5cv0dT78IEsa1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396005; c=relaxed/simple;
	bh=ZBg8wnELctbgjiFZj8U2NhYREpSLnnZqoP9XNpQE+qA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNqNEv0quzWuo3UNC5u5P8oWR0xanivfKHEKmhcqxDnecgKcvl4b7yoxmIdtmQkJxJz/FVsi2Bdisd0LQAuD72kbH0RR4tYWbovxtU2MXkLY3YeEHJ4YvtRhHtekr11dNySp5WHKpbsuWNGoBWjIh5Nz7JjNTnZ55awtZb/e8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb7VwFf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54EC4CED6;
	Mon, 24 Feb 2025 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396004;
	bh=ZBg8wnELctbgjiFZj8U2NhYREpSLnnZqoP9XNpQE+qA=;
	h=From:To:Cc:Subject:Date:From;
	b=Kb7VwFf7JklZ6SD/Ry5ybQS4v8I2j+QF5zs6KGkPvhKe2aY5um9KeMOYcd+K0yfQ9
	 pM/IAJre3L/D+vJF7EdZDH8B4gD8JKg9vbsMSGhN7OX9z3EQZ/OqdwodSfQyFdttQ9
	 ciITHTQKmBIyJBhMbwHZBukxwx2GlElTPICXMdQwiWuiVdA4QyhOrePX1zB1+ghF3f
	 LQ4EvJBd1PYaMkm23xufcpuHFia6HDH6ynsGqCflWlkQr7Xjmy0xm/cvI7hZFKzkbj
	 IsOH5qc4cJ44QeoVib2I0O4hHk3Ff2h2SHMx+Jp/3al9wAC/mrqZzGRnCA/teOCVFd
	 LGoldztolgHeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/12] ALSA: hda/realtek: Limit mic boost on Positivo ARN50
Date: Mon, 24 Feb 2025 06:19:49 -0500
Message-Id: <20250224112002.2214613-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

[ Upstream commit 76b0a22d4cf7dc9091129560fdc04e73eb9db4cb ]

The internal mic boost on the Positivo ARN50 is too high.
Fix this by applying the ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine
to limit the gain.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Link: https://patch.msgid.link/20250201143930.25089-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 183c8a587acfe..748e84ec100aa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10246,6 +10246,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
-- 
2.39.5


