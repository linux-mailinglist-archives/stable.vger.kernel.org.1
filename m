Return-Path: <stable+bounces-58858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DF92C0D3
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D828BC51
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17814185626;
	Tue,  9 Jul 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtRWwcNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EED18561F;
	Tue,  9 Jul 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542289; cv=none; b=W4Q+xL/41hUSJ2Rh0dCdzCM9swvzIwCrv7uFsvVOxfrXqils53jxOBHUhLVIMhfF13a5HZMa7iIHbzEotIsnQOVzRMfDvDOREvQwutfFeDiEDNGzSfTaiwN1Bsc1EkE2dpYPe9ZG/IDTy5Cy1VJOqL38TbjyMpeBJ7TXAPWKAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542289; c=relaxed/simple;
	bh=8U5v1m5rZ0L42VGyLhuGxEADB+vuJWzhfX6CvvNOFPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibSYFT5L8WiroEStYGPz1sh2GmyJs/g0mH9LzNpb5eBq3TCYaVXsMOJnoRKe4FjTXv/JsmVMS9jM/yFkuehsFlRGl802FqG3B0lTCXYia/+MuteINcezoWjGbIX4F5tmNyPZUH2J632bV3kPKOMdUR0NiahaZRnwoXMpe7GKl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtRWwcNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B2FC4AF07;
	Tue,  9 Jul 2024 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542289;
	bh=8U5v1m5rZ0L42VGyLhuGxEADB+vuJWzhfX6CvvNOFPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtRWwcNxy4hqLaaYTrPgY+C4ZFI+NHGGrC8L1zlgsL8bfcdf0ycSwF2xnPqvHpz/J
	 9a9gLgMMeDfsU5Ik7pXz/YEKE+I5hrmnE04Jrt4BzzGC1R/qHhSJoxCpcr9wdUbXop
	 yoSNKfIkDuNuRA2QCUozaEiHVNjrtEUIh7zaZz8KOg+GLuYN/PbgF6HcZJC0VziB69
	 5A8fG+1sjssiQPkfQ5I58UZUYjFnuP6y38psXrnIZO9LZz3nbxlhnZBZ1T2gOGm4/X
	 xX3Id5rFC9IKBNA4+RslGWuW3HogGdgQLiWZdWN0NYPkUIhwYqr1x3v5NHsd5N29ub
	 vnh9ENMn3BQlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aivaz Latypov <reichaivaz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 23/27] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx
Date: Tue,  9 Jul 2024 12:23:37 -0400
Message-ID: <20240709162401.31946-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
Content-Transfer-Encoding: 8bit

From: Aivaz Latypov <reichaivaz@gmail.com>

[ Upstream commit 1d091a98c399c17d0571fa1d91a7123a698446e4 ]

This HP Laptop uses ALC236 codec with COEF 0x07 controlling
the mute LED. Enable existing quirk for this device.

Signed-off-by: Aivaz Latypov <reichaivaz@gmail.com>
Link: https://patch.msgid.link/20240625081217.1049-1-reichaivaz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60866e8e1d961..42c98ac3e68c2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9696,6 +9696,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0


