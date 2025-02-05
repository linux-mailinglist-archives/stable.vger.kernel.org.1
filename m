Return-Path: <stable+bounces-113456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77D3A29239
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1377D16BF8C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D81FECCD;
	Wed,  5 Feb 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1l8o6Ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00B1FECB9;
	Wed,  5 Feb 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767024; cv=none; b=OaOS3JYsf4/OwXrtaqfhuRgFiW1C7I3IsXUT/0rWeCcuxveK/Tg9IZRWDtabUjeyUG2liQoFrnB5BUvGZZOTJfSUH6zuI4GQ+EjBmCl48D2SnF1bjwaSyYDn4K3rykjocGAtkuLuhaquLu6XenN79MfB5d6YGPJQWQQTDKVEdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767024; c=relaxed/simple;
	bh=dTVRz5MEBp7pz6rHn5nkdfc3fVPjFq/t3mX2msyw7KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkWHnmGY+DpDOiBueuaxCvE04QrH1uqU3jBc9lZvSJckwTB7rdH9L96s2lM94CRx+vXCIOlv0D3gm/DxgbCeLrOckM/DZUHDvu76KyD4BQsFyv5BNSldD+9aV15grEJlsrj+zhSStDHlSv+8RILJhSR3ua5DAjQi9yQKI/dN6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1l8o6Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43339C4CED1;
	Wed,  5 Feb 2025 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767023;
	bh=dTVRz5MEBp7pz6rHn5nkdfc3fVPjFq/t3mX2msyw7KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z1l8o6AyWOOueOdZ2D6qhAuCjrHIGDfIWAjceiZMFyRaQmj9978UVdEzAflcVRNfy
	 pppvQrGB7VDewpa14T94VjoqexXMpZmgsDFaSWzEOsIIjeK+CIkIvs0gG8X5QixIFR
	 5l74K9nuDQYyyhHv/mZuWlssIYSJ2taRVg4J9kfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 320/623] ALSA: hda/realtek - Fixed headphone distorted sound on Acer Aspire A115-31 laptop
Date: Wed,  5 Feb 2025 14:41:02 +0100
Message-ID: <20250205134508.463860023@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 5cb4e5b056772e341b590755a976081776422053 ]

Sound played through headphones is distorted.

Fixes: 34ab5bbc6e82 ("ALSA: hda/realtek - Add Headset Mic supported Acer NB platform")
Closes: https://lore.kernel.org/linux-sound/e142749b-7714-4733-9452-918fbe328c8f@gmail.com/
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/0a89b6c18ed94378a105fa61e9f290e4@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ad66378d7321a..2d523b53b3d73 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10158,6 +10158,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1360, "Acer Aspire A115", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x141f, "Acer Spin SP513-54N", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x142b, "Acer Swift SF314-42", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
-- 
2.39.5




