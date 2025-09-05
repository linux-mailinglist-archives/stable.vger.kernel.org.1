Return-Path: <stable+bounces-177880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA14B46309
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA55E1184
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD11B0437;
	Fri,  5 Sep 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmRjjAGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5D315D54
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098880; cv=none; b=WYiqP2hgWgffKndRJrRmL4l2ofVIJNr1PMtQR9+KrQt6g2FtEdrBpAWAdOISXG/GBmdmQ2Zi+OSK2FCLraIo81eDnwZAPUfATR3o37bgbA+QhfLqtmQRMIBLCDEjiONiiAsvqi1R1ilEER+Zc060nW34Hvao5k1tkaGMZdrpTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098880; c=relaxed/simple;
	bh=WdjjjTOTojafY49WcO7g79sS8XGoXqLbiy/U124V4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9J5k535G8B9m+fFdq0VKGlOKxfPQXGOEpISEaq+4FDepiuoeMn7Ds9kL+j1MN/DWMHBovfL0gGc5oIE7tFdrD8xRZuEx15M8+fIOROKZ3NOXTKpMxdRZ32j+m7/y4MLZhAAz6wjRzd0W7XHYG3cnucNKJYE4aoWRHwfqGlA+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmRjjAGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C18C4CEF1;
	Fri,  5 Sep 2025 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098879;
	bh=WdjjjTOTojafY49WcO7g79sS8XGoXqLbiy/U124V4aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmRjjAGBI4xDXe0uD9LHrHyP597DH3S9dCo2COBjN+yt2+RWf42V2lqAjjOoEjeSH
	 DwNr4qbSYiV7tw25NK+l4a1SR5unVrAkSAYFGuxuh/6fbX1cnaA2zaOXbOak2K7sr/
	 tjtghBI1XZ2asSAZPhKwSz32LfO9Ue0iblsZnjq0C9ktPfA3WRsC81gA3P3Xxb2vh4
	 1W7oezkxeYGt3a4xJbWeXp7iOuzYKWe71lXFyTb+HyEZ9LMUKfnPpjZdl5plo0klxn
	 SNjZDmZl70n9dm8Z9TJW0m7N/cPcJR25DWmvfWXnmLOtqaZNzkHcnFbefUdAy27D8Z
	 oe0Qt2YE2Lqcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA
Date: Fri,  5 Sep 2025 15:01:16 -0400
Message-ID: <20250905190116.3314799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052430-aching-oval-a807@gregkh>
References: <2025052430-aching-oval-a807@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 7150d57c370f9e61b7d0e82c58002f1c5a205ac4 ]

Add support for HP Agusta.

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520124757.12597-1-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d4bc80780a1f9..e4cef382f7aa6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10249,6 +10249,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


