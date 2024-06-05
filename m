Return-Path: <stable+bounces-48119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A48FCC93
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5500E1F22115
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2D19AD5A;
	Wed,  5 Jun 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id9ZnfoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2B19AD50;
	Wed,  5 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588586; cv=none; b=dCU2WGJC1K62EJpmLaiNs8+/vgIz1woykfTOwWcZ/GMsALaEqO1NGjrUk99QLiRmw5I7r5YCE1J+U+lRK8HJSjxe3bmzpzcwicIPRkK2bCgvo08MCU/ABLmNXU9pMY2j7i0WgTB7RxNpXR5t9uuMR3i59upjxLt8peRmNsKYUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588586; c=relaxed/simple;
	bh=AgC8t1bH71gJClga1+YVxhKXREwCLrjqi6MxdEj0f68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA2C5LcFQYVySglPo/Wcs5h0WRbZBE8mjIT8abvKH47PFeG7dXNcxPHzkn2HAvIPWcJIS3/pwQDVkM+bTuLprRSij516yzfBwBAGD+5nSMD6GiTFgnQDHXz9mTnZ7yZoVHUKLZldqXtvEPUGaYiHdcNysLmMjzeYsuyMHUNFWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id9ZnfoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF689C3277B;
	Wed,  5 Jun 2024 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588586;
	bh=AgC8t1bH71gJClga1+YVxhKXREwCLrjqi6MxdEj0f68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Id9ZnfoJnD+52pY5DMqkKvKl4AIowpsCgRQlZzLKUmNC4/cK08m5RcSpc9SJBQ5l0
	 vruH7Ke6K4Y43RpFs4CKIvbJ4PxSnlIRYWzplKSyz4o/QWGF8KmgQskIvsISX1LWqv
	 +YrcSmKOGFor/OU8/0RO3IHF4TH5/g5WGAJItaTmCLJe0ws+HqjjmESkgvkwplXVPI
	 wkJgHiyJ3q4cUK+la7FtkfGTAMzEMGODAiEMHI6QsGFWbApy/PZZAHXnaEXXumo0Mf
	 +VNCf9DBTb6X2O7HPkWcIBSdgD/nZ3Wz0U35zA+cZb7awb8Eyu1K/QRj1OI0JyvIqU
	 MlLhHS3zRIxqA==
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
Subject: [PATCH AUTOSEL 6.6 3/4] ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897
Date: Wed,  5 Jun 2024 07:56:15 -0400
Message-ID: <20240605115619.2965224-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115619.2965224-1-sashal@kernel.org>
References: <20240605115619.2965224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 47e404bde4241..41a86c050745e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11760,6 +11760,7 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
 	ALC897_FIXUP_UNIS_H3C_X500S,
+	ALC897_FIXUP_HEADSET_MIC_PIN3,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -12206,10 +12207,18 @@ static const struct hda_fixup alc662_fixups[] = {
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


