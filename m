Return-Path: <stable+bounces-124618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580AA64663
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 09:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C2188D3F1
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A01221726;
	Mon, 17 Mar 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QfbizwVI"
X-Original-To: stable@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B4221560
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201831; cv=none; b=uhjD+iI88UVtnrM2wyeshuuxQhHcHxX+gE9aD2qXXhRuAf5kvgHoZ9wL6aQ9hvi15+3jtMtrg+KrDG0f+8/4EelSdOsUBql3F3NtxhGJeAheWO1gdfEYcwOXPwZ7pgYa8uaFyHsMZj9Htj8RA88BMV+AnxtRvp5OD/tetxjk77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201831; c=relaxed/simple;
	bh=M5U8yZkupMeJdPdceKmOgq2WYT0m/JGyRhiZdENwz7w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtN82duWtiNPlWouDwbvYn7h8bcvKG5cV3icnm6EOhHAgLWLGeSyirDjfSSgOFPZXEOVcOudwpf/jS2j3/cWfFT+FGPlfoCOZzIbr05uS/iYsuAIFyACKbGgMr4xYTZAEgeaFfynPMP6eAuMITZAnltmQQO17HvQINYlb0gO8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QfbizwVI; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742201818; x=1742461018;
	bh=M5U8yZkupMeJdPdceKmOgq2WYT0m/JGyRhiZdENwz7w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QfbizwVIcKZ/djyY5dCadCCdZREpY9rPouBlQPWaj6L77qp02dU9KUf/yrUyR39YU
	 rGSJACajpYvF8zRW75VFeZFSguyALfwVpSPaLr54ZT8KRbRBKswY9OxEoIeHFNdJIq
	 1PDAOjtOjvB6vhF10XBERHBwUPj3FPhCEL+4DzCN+6KlGWwVWfM0fZpHEb3k4Gsc1N
	 NiLbIeehl/AbyptxxshPlIxhmpGEbTps3jqPAZuVVb+omc4/nsmJKSFss2uD+zHMfd
	 o1/lXfNFi2q+VfjU76UvAiOmGKoEJp/riFnDOspxBYancvToeUlupaisp+xdDOyc4I
	 trq0cepAzfSoA==
Date: Mon, 17 Mar 2025 08:56:53 +0000
To: tiwai@suse.com
From: Dhruv Deshpande <dhrv.d@proton.me>
Cc: alsa-devel@alsa-project.org, Dhruv Deshpande <dhrv.d@proton.me>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx
Message-ID: <20250317085621.45056-1-dhrv.d@proton.me>
In-Reply-To: <875xk8f3ue.wl-tiwai@suse.de>
References: <20250317083319.42195-1-dhrv.d@proton.me> <875xk8f3ue.wl-tiwai@suse.de>
Feedback-ID: 76774272:user:proton
X-Pm-Message-ID: 1612640222e7ed998a44cd39718ca1c7f14ef6b7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The mute LED on this HP laptop uses ALC236 and requires a quirk to function=
.
This patch enables the existing quirk for the device.

Tested on my laptop and the LED behaviour works as intended.

Cc: stable@vger.kernel.org
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



