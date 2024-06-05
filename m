Return-Path: <stable+bounces-48109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18E8FCC74
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206001F21458
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CF19A2A4;
	Wed,  5 Jun 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTqvJ8mg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E219A298;
	Wed,  5 Jun 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588556; cv=none; b=p1DpjLs8l7hHGS+GahyRQrZfIAj1i8esZVnpVNhlXoi6Qt0sZARMwX/3hsvQ0RxJ0LX8+XY7do5cmIsYyd4axA8B5AWhkMQaFW/w3d0Q8rm/SMSuV0JPuHmnWJxhdRwwweit0FebjDhWOiG1A0yiX4JHMZ+V7Kt00/JUtippLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588556; c=relaxed/simple;
	bh=zbTJHocCvoBjx9tqS0o9JPLudaYJMj27DQNL55qJzxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdpS2kEyRDdZ+iCslu3knDjEcBXNkreb6B2pqd5j76X6a6shEuZi0MlFkiZtBVFgUl41wmItBAflpoU08Fofec/5ehrpWURto4AHfeEASDRwLaId+jBKKRHJE6quqI5kOpqxEdBQofV4E0mPB+STF1fmjRK9gqRuSt/5lWpYX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTqvJ8mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2945C3277B;
	Wed,  5 Jun 2024 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588556;
	bh=zbTJHocCvoBjx9tqS0o9JPLudaYJMj27DQNL55qJzxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTqvJ8mgx+NLX3tKe5/NwcVtkJJjTLBssw/Z97jDfHZoqwXPkKBZUsJUNnHhg4Dxk
	 0B0ulWuDKZDrSFi6aE4Uu19BKPBb7zNxT/gdANxb9htLUAWuXHV/rsAnSfieQOMEU6
	 Crq4G5Y1TDtg/fL3WpDFRw7rAnEAKrC1GbkKY8uBB68JtTn7PsLJIdnBjTVY3NSYDi
	 bhtu9IHwvNYtX19gSbxkRITxC62Cvt8Babi+vIH8RTb4VVfbLQaJa8yH8FiGajs49h
	 yG1RXNlupJ1RZIk12QCIeeyTWHV0aAeDETSPWbmQW0eSGVZTtym5/S2hLkwSVh6DQM
	 yryv2Axj9EDWA==
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
Subject: [PATCH AUTOSEL 6.9 5/6] ALSA: hda/realtek: Enable headset mic of JP-IK LEAP W502 with ALC897
Date: Wed,  5 Jun 2024 07:55:40 -0400
Message-ID: <20240605115545.2964850-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115545.2964850-1-sashal@kernel.org>
References: <20240605115545.2964850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index b29739bd330b1..abc664c8c496b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12013,6 +12013,7 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
 	ALC897_FIXUP_UNIS_H3C_X500S,
+	ALC897_FIXUP_HEADSET_MIC_PIN3,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -12459,10 +12460,18 @@ static const struct hda_fixup alc662_fixups[] = {
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


