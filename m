Return-Path: <stable+bounces-127166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921AAA76941
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DE716B448
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1A229B36;
	Mon, 31 Mar 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJWFfwFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBA21CFEF;
	Mon, 31 Mar 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432839; cv=none; b=AxAlVzfyUV2kT+5PeYtoXm+HGa2nhsWBMmjC4zJTR4albJYE4fL2Pp6xq32oPSompPLquZXLQRbj0P9LXzmOpkbceVhcChr8RG9DMohAEhSFY1UUNxxW9jS/aQRpbVhuzDT9V3fPQ1MYT+QIufIY6R3gXiQlYDKsGOzZ4m9LXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432839; c=relaxed/simple;
	bh=K3UQOvgFhX7bBubHcCv+Ov3Z4uv1xZwQ6p00LlLBhpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gu7wciZdB6eXhrbr0LiKD2fSwULRZvWX4iUeOjt3lA/wu136bBIPnXtg0Mo/5CLUb714FIL9O4aWSoLuYObAyvct3VQrMMc99Mq1cCbIPFs78dzFosiiiAw326TSbNiQPLeha0Z3YA71zPxqHEcACYql5CjMH1ePvB+23dXBDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJWFfwFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8435C4CEE3;
	Mon, 31 Mar 2025 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432839;
	bh=K3UQOvgFhX7bBubHcCv+Ov3Z4uv1xZwQ6p00LlLBhpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJWFfwFXhtMAYIN3TMySafT/PmPWhotuosowOW4OZyiirGxs+VP39rxbBomU6LxaD
	 Zs0LN3h79TEh0e95/GZT4rMa6BwnHFRKY9G7dlSFGclTy4/jj7IFT0BnoVCpemSgJt
	 QKJhATGNWwsr4nBBHBldv7t73qgA6BwRktYbXfIIwFtPaOVT+2Exv9tEB8z8ZmOo9Q
	 2NedLw39a7HNRjwcHF8Xf9Atm/iGFYXM/Zy8sy3GlevN7jzu3A0rH6x1FxkMBVZzF/
	 brkp5KKTnxvkvMLeuu6JTfHiQ5RQ0u/xJlyQLpFDG8RED/wvF/yhfcPV6MxjmIbs2s
	 YZUuJj5UkTiTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Chiu <chris.chiu@canonical.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 25/27] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
Date: Mon, 31 Mar 2025 10:52:43 -0400
Message-Id: <20250331145245.1704714-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Chris Chiu <chris.chiu@canonical.com>

[ Upstream commit 78f4ca3c6f6fd305b9af8c51470643617df85e11 ]

More HP EliteBook with Realtek HDA codec ALC3247 with combined CS35L56
Amplifiers need quirk ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250321104914.544233-2-chris.chiu@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 283ccffcab068..41ecda04af300 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10699,6 +10699,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.39.5


