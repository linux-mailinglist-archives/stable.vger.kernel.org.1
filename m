Return-Path: <stable+bounces-46490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033388D06D5
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF01F222BA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABA160795;
	Mon, 27 May 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOA9a2bH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7C16078C;
	Mon, 27 May 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825144; cv=none; b=K5OYpyiJlCriHjtwKYaobCuEgBpk45uc5sE5HyOuCCwee7BkAgWQRW3mQj9OrmrghzJ8ILqrEyUQKGEC1ZeLQ1+bBCJz6g9hjA6Xl/PNNwZTWMEN9YSccusehhn13m+0ogHhfiqK5Irjo7scX+0pG3ovZO7J12TttiiFlkXBBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825144; c=relaxed/simple;
	bh=Uw/jG0+a9tEHJL9dTJcMFEL3Q4gIgVpYsUkUrZO5OCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpN41i87u1Kqau/5oQwZ93+4H+sLql1xTvdKe/88TBDYVzaw3UJ2SBKdNq1QGnWpeFHGQx+g/QrJThYj6AAUr9pokQ322Pr/PgKuTtn+vUSSLYhN+5b1i+EtsKIT0AHUBZPi488AyEPEMbvfgXfbit+v5XO1NoOE31L42PS+Z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOA9a2bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DFDC32781;
	Mon, 27 May 2024 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825144;
	bh=Uw/jG0+a9tEHJL9dTJcMFEL3Q4gIgVpYsUkUrZO5OCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOA9a2bHNed94ooQDVy3JVg9WuQvC6y/bXD4yqzREipMhVPRsR0duNKgkcPMaVqvd
	 Mk0dNyebjn6C4mpzaTrlef30dCOlwZF64CQit2ErGhH/oQw77yAM7JAFMwOTgrJTVM
	 8PeUROIEVyl+YBzAPuEDscyJ4FS8mEVRd0N/a6pdAzH7rjT+OcpP1pxFVRO1bYuPQ3
	 wwIseC/8zbvlQSQRXntPmtB2vm5Eas1tXPPoVlgEun0JJWBjOTJ6dnGPj9R2G3THDq
	 pT7GQ0ECwLFLMRuBBx1csPymQZzYAk+EnfceaGBd1lvOT03m6PLOQ1OeaZTfIYGH+S
	 ARN1OncVkbnRQ==
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
Subject: [PATCH AUTOSEL 6.9 15/23] ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
Date: Mon, 27 May 2024 11:50:16 -0400
Message-ID: <20240527155123.3863983-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 875e0cd59758a3d636ce94936287787514305095 ]

Add 4 laptops using CS35L41 HDA.
None of these laptops have _DSD, so require entries in property
configuration table for cs35l41_hda driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20240411110813.330483-4-sbinding@opensource.cirrus.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b29739bd330b1..cee387aa458f4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10148,6 +10148,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdf, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10168,6 +10170,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c47, "HP EliteBook 840 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c48, "HP EliteBook 860 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c49, "HP Elite x360 830 2-in-1 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c4d, "HP Omen", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8c4e, "HP Omen", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c4f, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c50, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c51, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0


