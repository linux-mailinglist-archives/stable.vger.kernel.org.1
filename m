Return-Path: <stable+bounces-177894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3CFB46457
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF09188DDE0
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D227990C;
	Fri,  5 Sep 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLA/Wvyg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91F2AF00
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102825; cv=none; b=ZnOwSxvv6MAfJ0jE+sov83DbMq+UH/7GV43uX9nYrfoPt0DzopW6kIqlhFjFQtU7MdGacTMu+/iAis+bEDkqgh305bHdQDjY1ji60UpfWQwvEYIp+pvocmKUal0GnsZ9poZRUAd2mTh4SYZaqBVDBY1PpxG6ry2+Ta57V6morwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102825; c=relaxed/simple;
	bh=HHmgNk1XnY3VRbd0cm3FY5Zl7/UxW1hQkq21P0zhlu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUJT0I2Ps1RL0K4THAWq4/wPcPjJqWM+4TfR/3DT0RbJEKgBF6vK3qsWwW5P1c//ruXe0mFxbxwDiSAKZkNMyqFaMALWHfZjWAxRLL9JAJTnyHnxHgkibos3E+jCQptM4IuygPUgZnh/BSkZnhTTAdsFlGXlIDHlKN/Y5SZXbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLA/Wvyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2CDC4CEF7;
	Fri,  5 Sep 2025 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102824;
	bh=HHmgNk1XnY3VRbd0cm3FY5Zl7/UxW1hQkq21P0zhlu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLA/Wvygj+rp5MFB1hRnIQVeuW0uZ1LxoMXwN1ZPeqyh5CYMI2dt24l0P0m4WFOXU
	 hBIzDJcNhQIJQiDJGGj9TScljIZHEXhdXkm2zOFA4ifNf8X2daZt3tIIx/5Ex1VIcR
	 TnQsYau3MiXD+s2NoCXxg0hjEwsZDCRoSrXF4VWu+v9iOrueY48GQIsKduCpbU5IT7
	 1cMjCwE2OGVYr4v3GtKLRa3g/PK5GP3QuqO3RrCn9G39UlvWEC4n+uEFD/MJ9Azdu8
	 +JictyxKX0sex8xSoHWiwh+mnfDOBwnidmvLSIdYqQWrl4SnR3xdcnEgidzAemCXaH
	 OjEPOKP70b/9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Chiu <chris.chiu@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup
Date: Fri,  5 Sep 2025 16:07:01 -0400
Message-ID: <20250905200701.3390803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052415-poncho-unisexual-124a@gregkh>
References: <2025052415-poncho-unisexual-124a@gregkh>
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
index fa1519254c3de..ed2f49d3acc6b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10093,6 +10093,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


