Return-Path: <stable+bounces-177908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88FB46755
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254A9562CA2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42051FBEA2;
	Fri,  5 Sep 2025 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za7oiTdt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41326A0C6
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116437; cv=none; b=R9bR8v5pJasLDCAPdldDWvbMWbV3LYXW9IqnWFq22ZPKH6hQ5q4jskGZM6fJO4ga9yRgPJeDc6XwnSkQ2vpcU2A/oXtxpT6OCobIJJzf1Q35dCRRi7qjIURZQyQSx7tZfKZDKFSjPsLWQV0D5N0mSnj8hqzWBqf1JeGsNgW5/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116437; c=relaxed/simple;
	bh=4VVKtUBCTQiq2e+Ev8+RZA008vPyG3HwjRW+Qhm1U2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9iDm6IXKsUT3g5WOet/4hZ2AhWsYdBW4D0qt92WeUzVFyx3ka7M4gLLncu5KZ4/gwjCcfHxL4+PkNDLy6Sx4zBmXkQImlZ1/X4FWzpnt81tj6GH0xnUrVJm6on8/PGB0ge33lGfY/L4fbQgWOB7KTlkVerz1WAlx1qa4UwY4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za7oiTdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FA5C4CEF1;
	Fri,  5 Sep 2025 23:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116437;
	bh=4VVKtUBCTQiq2e+Ev8+RZA008vPyG3HwjRW+Qhm1U2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za7oiTdt8KIHXAMzoZmcBnFvTn8ih+vAUtpUbGldJU0VaQvJ2fmVHFXXNbO85sgj4
	 TMGvFGnN+wLhLenNzgOIle7Xf90jjb0zzf0kuFw0imcpOkHzkZQG9khDOBaYP0Guwk
	 4TnGu5toEW4ANpSL64Z1aaoXuPSEndogPDNR0LgUMDnA25zLuuRrc4A/F7w5NgTsho
	 5k+GkurxcDoTq7IIe+8O/rmBg03sQ1Ycnw+DGhfx/L0COvc2/XW/KmbGz3mtj9ngNT
	 AimN8j35ljBy+iDV7QOK61ngrGshVZ5SJsAgK2DgT2r+4TLMOps4bxhjcvtLiDC2rb
	 aMV8CaVtMR+cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Chiu <chris.chiu@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup
Date: Fri,  5 Sep 2025 19:53:54 -0400
Message-ID: <20250905235354.3584137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052421-diffusion-untimely-a099@gregkh>
References: <2025052421-diffusion-untimely-a099@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Chiu <chris.chiu@canonical.com>

[ Upstream commit f709b78aecab519dbcefa9a6603b94ad18c553e3 ]

New HP ZBook with Realtek HDA codec ALC3247 needs the quirk
ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520132101.120685-1-chris.chiu@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3d12c489ba1e3..f9f4a914de6e5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8390,6 +8390,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89aa, "HP EliteBook 630 G9", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.50.1


