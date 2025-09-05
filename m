Return-Path: <stable+bounces-177883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628EB46370
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CBB3AC6BB
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8B1F61C;
	Fri,  5 Sep 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjPbcTj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56643315D3E
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099792; cv=none; b=Hqtgk93l1fFW2qn/N+mGwVCqnPDNGfoqXMquriGzglAQmA9m0HBZPd4f8htslFuAdmSgAZbnkFL8aR60N28vVLmS0daxPp1uqa61XgiraW/Nk6n3S3L3JcC8y8nH+SoSvYMwnJFSrlkd7vbtOBShZPE8Zl0G3y1SoeAsldUPIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099792; c=relaxed/simple;
	bh=CKnrg49nAEc3h5evHs0apMBTM59w5/OiLyTiiE8EGMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnBMkKwrYWKYGvKR72M8PytEdkn7Lt4GJqIoXcc83hLJAeZ7W2MQ9SghKD1gq+FMN9KeA/7ODEqfV/XXlW9roQJuIOrHFjGkXuk1hte+oZMQb6nSwQme4wkKf/Ev8K6QHIXaVqeCbXQJClOC5v43LCzMmayGUxa5wwCpOQTAxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjPbcTj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750BFC4CEF8;
	Fri,  5 Sep 2025 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099792;
	bh=CKnrg49nAEc3h5evHs0apMBTM59w5/OiLyTiiE8EGMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjPbcTj9CFoZVlPqwj5tEREhsKbRH1lm3EkPSOcp0tKXYtQd1U2Dtc6eub6m7HypP
	 5Y+fpsV8J7DEAS5E8AGTQ3bdw6OSj1XjnwoJ48mT/hcw4k2LoLxdxKhdZSiORULWOn
	 3paBdM1wtoN+KLouwrPjUhxk890+DAN/OvVGEL4IeskSK+TmkLXupMznQSU62SF+18
	 VfnlnXGbXHCKQ8LDBz9pYKPEVbAwFkFannL2pv6NxSK1Po3GMAfAEEe0OdZlEwL3zl
	 VbWLzOF5vDLsdHghZVX1adeFGibuwZFrOzjkj7F0L5smAWKB0wJg77RpCESQ3RdEQh
	 EYkmkoVo4IFiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA
Date: Fri,  5 Sep 2025 15:16:29 -0400
Message-ID: <20250905191629.3318536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052430-fable-scratch-0fa5@gregkh>
References: <2025052430-fable-scratch-0fa5@gregkh>
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
index fa1519254c3de..8fee7f26abb66 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10093,6 +10093,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


