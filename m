Return-Path: <stable+bounces-48127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C58FCCAB
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1071F253A9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24319B595;
	Wed,  5 Jun 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu7DhHYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EC1BF90D;
	Wed,  5 Jun 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588624; cv=none; b=V5z0HprLtFEe4wuO/OfhImf/OJY4hYv/X02URB7K5XocY1DWzhd/heZc3pINzqgjxCxnsRmXNw+sLy6nyYIKHYlgQnJ+CtmXJR0JIge7HgF6bwf6BLF8ErYj1nGSjzu/VAJNbWdCMmydvFQib5W2ad4SMRNMwGI5TlGbUqLM8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588624; c=relaxed/simple;
	bh=vMDKIc6lLj1EO9UYlCbUb/5oXBZKBAl4dXREvt/KAd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGSt2GoB/M4YwWeKyioRPX198BrCUd26dAnf1CBj8JXSk6ROdOEySH8qrckBaJN/2rZ2fGsceZ4BmQxHijhFYbVtuRXU51AwISK2Tjo1lY9tLN2YYkJU+HeBPjtPwOKvTufvhrAnTG3Fg1lIyRCqXbUrS0jGqTidwhr/FCMDEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu7DhHYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0665C3277B;
	Wed,  5 Jun 2024 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588624;
	bh=vMDKIc6lLj1EO9UYlCbUb/5oXBZKBAl4dXREvt/KAd4=;
	h=From:To:Cc:Subject:Date:From;
	b=qu7DhHYG628qEo6baKNOhR9F3PGPT9kyb2QoDYSDUqe62+Hz2QoXZeLodkVGrQqc6
	 HK2x3izib4BqXmf3bb2Ed+AB8RQWgNE8JHeTUp8NGaAElffLfuHeAblRDQvqXDEoOp
	 oEABpWpp9QRopiJM+Qo5nn47D/5fmLw10daD7lD7jJDnirOdbksg5Py2A7ildSSRoY
	 /xs2EYqilIXZ1sWBkhdqwQnDFSJziKDu/L9cSXpl16kw/uUYLuBp4d+dvRmZLTu96a
	 Kr9628FrOQmaDtlE7yB8pEWIMXJsuI9KYonOAqcRyRZOt81MsgXLf0xbozXPSLLJxG
	 6HF4bpE85C3lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4] ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897
Date: Wed,  5 Jun 2024 07:56:56 -0400
Message-ID: <20240605115701.2965523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
Content-Transfer-Encoding: 8bit

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


