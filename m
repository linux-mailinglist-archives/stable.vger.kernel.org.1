Return-Path: <stable+bounces-46540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8B8D0780
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFAD1F2209C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EA16DEB1;
	Mon, 27 May 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF94oen7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9EB15F30B;
	Mon, 27 May 2024 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825458; cv=none; b=XVEQX5XsK7I8uTFoTv5Nl/mlzDrDfDTzxpg92TYXe8kg6jLtWH2B+TLmqREQ1t2phf+206gMozatkMfZxoVfWA/IPNTB8nRDBCIZXXKyjPj9/nVYUvLQPcA/FfjYHTNsQOLyXMInZJRkc8wWKV7rHwqt/zpPRRHI9Qvdfu5a5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825458; c=relaxed/simple;
	bh=4oVg1/Nu8RNb/3cMAUNF5l/nUCMGVH9Ix6xpXCVryVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX6IsNWsoqVcO8qY5FALzOlHywNAYnYKVkbmOj3iOTd+v+WliTdwczlYLFniKbxqJK0WJkQU3brU2/Pij+op8q4y0W171TohiWk0Ikn847yME38FJzC1LhsPF/HnNhOOYtNTkDuXezlH3aiTZfEiAjsZCoLFrPaRoOAfMDC3n8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF94oen7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A2C32781;
	Mon, 27 May 2024 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825457;
	bh=4oVg1/Nu8RNb/3cMAUNF5l/nUCMGVH9Ix6xpXCVryVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF94oen73MIwzk5v3TebDOjc/bb6kd8vA7CCPunmSrTSgp4U5pV4Du0FtF4AENj0w
	 JERPvgp28vrMEX65aZMwDZR1U4vZiX0fb9/7lUl/XEoAwHp5qUEBJMeh1p0kC+gt+R
	 nTTI5GI1uiENDbV7t10AmU7evbFuyWkdoledvNi3Jf/V3PybvIl8SrpCBNVUwJrJ5y
	 0+pbQFOsSbqHjk6DPbBhQCfGI4zViI9ULg39gcvdxevmFhwY1SMBav7cGWH6TUUK1v
	 oXFsDoiEUkGaFInd+PiADK+mwMa7BTQgFKaMeRyNGVX+2nzm9Ba82mPaoSBZr7n75t
	 Tg23GWJfBUxEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/11] ALSA: hda/realtek: Add quirks for Lenovo 13X
Date: Mon, 27 May 2024 11:56:43 -0400
Message-ID: <20240527155710.3865826-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155710.3865826-1-sashal@kernel.org>
References: <20240527155710.3865826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 25f46354dca912c84f1f79468fd636a94b8d287a ]

Add laptop using CS35L41 HDA.
This laptop does not have _DSD, so require entries in property
configuration table for cs35l41_hda driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Message-ID: <20240423162303.638211-3-sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f0b939862a2a6..37b92f2bb2075 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10076,6 +10076,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
+	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
-- 
2.43.0


