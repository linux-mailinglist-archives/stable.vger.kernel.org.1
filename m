Return-Path: <stable+bounces-58891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E192C13D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576CE1F22F59
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71DD1A909B;
	Tue,  9 Jul 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvP29ST5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318A1A9095;
	Tue,  9 Jul 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542401; cv=none; b=Gnjmo5OlMJxXNm1kIS6ixr9Ok/Zg9uLyNwOd8Qs7LA9E8Uyu2pGNfzZZmzgx2gxBlAWUCs7khOCVTBFlufU8fXbggIK0/NDKBu7Wv2KM02vDJh9Tf/8p5duHJNQBAIUruylrYAWyW6i+6fhhHmGFuMK/KvmGszFCOGdOGCqOBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542401; c=relaxed/simple;
	bh=qj7SBq03F6aLvx/dM3zP92TWWvrZx7QfCcHSMdZ4pN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glDD63capdj6OtXt5ky4p7PX9FUEE+S38UINWuDsdlXIMo+L2Tp+XumuLvJE1lCCpuykRvsB+fM3149sSzJZFcGxFRQxHvuZk5wUKFX+VaOvMK1L987qtSP3oWJdMKp3zye8DcKUS0oEhKfNrE4ykEvXCmiSoLxmEFW4wce4+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvP29ST5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8916CC4AF07;
	Tue,  9 Jul 2024 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542401;
	bh=qj7SBq03F6aLvx/dM3zP92TWWvrZx7QfCcHSMdZ4pN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvP29ST5dS30d0b2/7d9aVfN9ZawyfE5Weviu9dHfo5T9hLU+7Jd1MlNhO/ujLzcS
	 7u2mwIAijIhGaGlYSUhWNNln/mNGOdp/QHkxTQDLU7yMUmIhiiT1DO11SynuXF+dYG
	 D6SMkBS5ErjVO0n1NvJ4lTYSj4n8VsSIt11BJABp8uCLDketIFW1dlnhjoUyUMbcOA
	 gK9A1fCYClMqya1K9aZWtiRoQfGoTb84WY1XqR2qZNnt/mqhiz1vLBerdG8pY+w3BZ
	 tdDOgCzbDlDgutT4n2muFePnanDZzuEEUrbqkgWRzFylrSsAJXSWgbfKw2VtezSbV9
	 ThKI1k1mWU9Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aivaz Latypov <reichaivaz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/14] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx
Date: Tue,  9 Jul 2024 12:25:56 -0400
Message-ID: <20240709162612.32988-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 4af8094938059..7fb1b828b7af1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9091,6 +9091,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0


