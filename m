Return-Path: <stable+bounces-124616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0058A645A3
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D483A4DB8
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354B21CC64;
	Mon, 17 Mar 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ObN1J4iZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A721B8F7
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200459; cv=none; b=RkTXs1KqDZXthPu7sXNKW7F7DwogDDkHjm64ri7FCOjpB1HzLjTmEx48syF0b8UMVLzobq40lZYJG1fFB2qjt+qXcol7dwqVwJAgmNoDcsUMATmUDIk37Z5C5DzTd/rGjb0pTLLoIhbAXK2YxNMDI0a42HuyU2qO8AH11/SYjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200459; c=relaxed/simple;
	bh=hIZWXYMKWTfTI4Ku8ZKFYn+onVLQdLgszEGMeUHIaNo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hAb8OeAVTeI6hFVyz+EVgUyeSttkt0MHIJTvAHTBoqBe0FCwY8HmtOv/etK+55iaVgZzYCKGChJtPi62olobhs/s27NAQfalvPb9dHORkfqiHyd+ft1As44QvG4BaT1l93evB6vx7uFuboMPM9Qdsqs/X4F1odN/cQhLgar/csU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ObN1J4iZ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742200439; x=1742459639;
	bh=hIZWXYMKWTfTI4Ku8ZKFYn+onVLQdLgszEGMeUHIaNo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ObN1J4iZjKY+SVVzINBq2bMZS53GY3ak8Xitew7BsJZMdYfyZkRz8J5eGWKWiRtHT
	 ffp0GrA5sKzQfy8ivB63leTpL0zmot94xekDO6y4PzVf24MXZMuGQVGg/Btq/dYFLA
	 GGyx9rbhNgl2kEO6Eb4EK4cz1a+FKJ7pI6pxR/eeK55Az+GguXu9D4EEwoCrJ1ATWE
	 zMmKUfkgPFBIqbQsxd9IpuUNhpPY3Ul7rbQQrlO9lkaM5nQqfTyLYESvvL9bGDjQTF
	 J1KPI9TVscKrmUWtLuIvR/XwWF9gAeMHppepb/1OY/apctpQAKwlJH28NGFzWZ7FfO
	 +8CFRtdjlfU2g==
Date: Mon, 17 Mar 2025 08:33:53 +0000
To: tiwai@suse.com
From: Dhruv Deshpande <dhrv.d@proton.me>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, Dhruv Deshpande <dhrv.d@proton.me>
Subject: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx The mute LED on this HP laptop uses ALC236 and requires a quirk to function. This patch enables the existing quirk for the device.
Message-ID: <20250317083319.42195-1-dhrv.d@proton.me>
Feedback-ID: 76774272:user:proton
X-Pm-Message-ID: 2d5d4fb9449516412bcce8dadefd406d8b054991
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Dhruv Deshpande <dhrv.d@proton.me>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a84857a3c2bf..c0b97c29bf89 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10519,6 +10519,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP=
_HP_SPECTRE_X360_EB1),
 =09SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP=
_HP_SPECTRE_X360_EB1),
 =09SND_PCI_QUIRK(0x103c, 0x881d, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_=
MUTE_LED_COEFBIT2),
+=09SND_PCI_QUIRK(0x103c, 0x881e, "HP Laptop 15s-du3xxx", ALC236_FIXUP_HP_M=
UTE_LED_COEFBIT2),
 =09SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285=
_FIXUP_HP_GPIO_LED),
 =09SND_PCI_QUIRK(0x103c, 0x8847, "HP EliteBook x360 830 G8 Notebook PC", A=
LC285_FIXUP_HP_GPIO_LED),
 =09SND_PCI_QUIRK(0x103c, 0x884b, "HP EliteBook 840 Aero G8 Notebook PC", A=
LC285_FIXUP_HP_GPIO_LED),
--=20
2.48.1



