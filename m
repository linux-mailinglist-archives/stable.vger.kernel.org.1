Return-Path: <stable+bounces-159063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183BAAEE911
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E43E0EAB
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F0291166;
	Mon, 30 Jun 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9vJKWvj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451C1E1DE5;
	Mon, 30 Jun 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317290; cv=none; b=dj+T5xgP9vE4sDCQICzgGZ+JfFdk8AbtRilN0MGiZbbzLc+Os0n84Og0O/wu7LuPZlflGUOs4ahVJQxyeFptGST4XCQxKgLBbJ/ElppvV213+obCAt0/ov+ch9g6/+UEnbwbqjytNf9i3NcIFw9mpVJsvMYUpiVZjtXlSky9V1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317290; c=relaxed/simple;
	bh=8zDI5eg1xCj4UNvSVi3WGsd8SiJ229IvQ1So/hTgjGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cr6LzQsA0foB5M+RqH/dm6RuAe+mCs2SIGUl2E9/QCZjvS+ZAy8QYr0vE9DuFBFU59giTAuJSljvNuJ0tEQTsi5pvioD9PKlQk/rjEl+bh2sju7GmmXRdbSI37tafljyXaSBIAjnTYUqnkHU8z7zOYB48cPPE1t8NzIgF6wuZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9vJKWvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E9C4CEE3;
	Mon, 30 Jun 2025 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317290;
	bh=8zDI5eg1xCj4UNvSVi3WGsd8SiJ229IvQ1So/hTgjGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9vJKWvjqvFnErhh8dqZCXmGBwjh+iSH4NquVyO+5ttskB2OshNiTVuEZxkIuy//3
	 LylXmtZIxde3ORE2hmqYnLT9rXyLHflXTHCh+MTzve26vV7K3dXzbiI0/9UJk9WJAj
	 v/5MYgpdnI8WhAecpg8P3TnF5KT+y3T2Z2C5s5NkhrG/mk0MEPoUnDAUGiifJbb1aj
	 j2Tmi97NItpIbbgoXBfdUtZqoReH+NEdcAlAlGIrJi+H8p21ZOlkMwue5jdsRywPtT
	 dwzHKMvs3PhzrpuygDTlW7dkyqgaPWo2aTT6627D7m2HNWYW8EHwZfooKA14bpRz5R
	 0JB2H+m2jsKwA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yasmin Fitzgerald <sunoflife1.git@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com
Subject: [PATCH AUTOSEL 6.1 04/10] ALSA: hda/realtek - Enable mute LED on HP Pavilion Laptop 15-eg100
Date: Mon, 30 Jun 2025 16:47:11 -0400
Message-Id: <20250630204718.1359222-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204718.1359222-1-sashal@kernel.org>
References: <20250630204718.1359222-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.142
Content-Transfer-Encoding: 8bit

From: Yasmin Fitzgerald <sunoflife1.git@gmail.com>

[ Upstream commit 68cc9d3c8e44afe90e43cbbd2960da15c2f31e23 ]

The HP Pavilion Laptop 15-eg100 has Realtek HDA codec ALC287.
It needs the ALC287_FIXUP_HP_GPIO_LED quirk to enable the mute LED.

Signed-off-by: Yasmin Fitzgerald <sunoflife1.git@gmail.com>
Link: https://patch.msgid.link/20250621053832.52950-1-sunoflife1.git@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Hardware enablement fix**: The commit adds a single line to the
   `alc269_fixup_tbl[]` quirk table to enable mute LED functionality on
   the HP Pavilion Laptop 15-eg100:
  ```c
  SND_PCI_QUIRK(0x103c, 0x898a, "HP Pavilion 15-eg100",
  ALC287_FIXUP_HP_GPIO_LED),
  ```

2. **Minimal and contained change**: This is a one-line addition that
   only affects the specific hardware identified by PCI subsystem ID
   (0x103c, 0x898a). There are no side effects on other systems.

3. **Uses established fixup**: The `ALC287_FIXUP_HP_GPIO_LED` fixup is
   already well-established in the kernel and used by other HP Pavilion
   models including:
   - HP Pavilion 15-eh1xxx (0x103c, 0x88d0)
   - HP Pavilion Aero Laptop 13-be0xxx (0x103c, 0x8919)
   - HP Pavilion 14-ec1xxx (0x103c, 0x8a0f)

4. **Fixes user-visible functionality**: Without this quirk, users of
   the HP Pavilion Laptop 15-eg100 would have a non-functional mute LED,
   which is an important visual feedback mechanism for audio state.

5. **Consistent with stable backport precedent**: All five similar
   historical commits that enabled mute LED functionality for HP laptops
   were backported to stable:
   - "Enable Mute LED on HP Laptop 14s-fq1xxx" (YES)
   - "Enable Mute LED on HP Laptop 14-fq0xxx" (YES)
   - "fix mute led of the HP Pavilion 15-eh1xxx series" (YES) - notably
     uses the same ALC287_FIXUP_HP_GPIO_LED
   - "Enable Mute LED on HP Laptop 15s-eq2xxx" (YES)
   - "Enable Mute LED on HP 255 G8" (YES)

6. **No risk of regression**: The change only applies to a specific
   hardware configuration and cannot affect other systems. The fixup
   mechanism is mature and the specific fixup being applied is already
   proven on other HP models.

This is a textbook example of a hardware enablement quirk that should be
backported to stable kernels to ensure users of the HP Pavilion Laptop
15-eg100 have properly functioning hardware across all supported kernel
versions.

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3cacdbcb0d3ea..3f3a89ea2c2ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9995,6 +9995,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x897d, "HP mt440 Mobile Thin Client U74", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
+	SND_PCI_QUIRK(0x103c, 0x898a, "HP Pavilion 15-eg100", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8991, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
-- 
2.39.5


