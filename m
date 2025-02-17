Return-Path: <stable+bounces-116576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55062A382C1
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533FE3AA6BE
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC3217723;
	Mon, 17 Feb 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="iWuF2D/t"
X-Original-To: stable@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47B18DB37;
	Mon, 17 Feb 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794559; cv=none; b=ETpaFMXgulKLHWqPP+tl+dJ8eKQCrN058Cft9smuq2TbW72EfudEn3WdeXdTX6NMoYQ46racRCl0NYKkNvm6ddDYfMCdjzbUyhg0MREyCJSPzAUhwOeCwmwgyQUNSzd8hWBbR7uqM+8qYyb/+jMI+OOHnAmq9PV5oXC2oHqOoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794559; c=relaxed/simple;
	bh=IUpcs5fuPv0MlqHTX1WqaxfwSXVbNE64n/vXBNN2vFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oXSV4dabLnOsxA2yhyRnMyFExYB7IEp+UAgpgTlqdX8zeuWityPeruAm8L4mX00b9Ggcd/tsR48LLMQo15+tcg9vkzKUdvSg68y6b675XgCvi0qB716M2OQNxs0CaTEB1A6pFzuts0QrK6hHlUIsHwY+LUq8KP5o6vPTKMowd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=iWuF2D/t; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=To:Subject:From:Date;
	bh=N29UVb7lsFIAUeKtfz7zQQ1tY8pSM+hJIbIL5FWIg6I=; b=iWuF2D/tIqz9lu7WQd1IKMPx/g
	98XTkVwpg0VIafwEjfl3c5jCOmSbN1SDL7aJz4s8o3tGWpv3Zh2uIgAntHOXoDrZXLK6/wkF8QDL6
	/TN+G/adWi0WXg7BeyAC16IQEHvcLxcp/OxWNSx2mRuydLEli1feK5uK0423NE5XcpWvcDhDcZADN
	VP6M9BvVHboj3xTt6a1dX9j9w6goy+tV+dXt7qYTgUvYHQ8X4MmQzBksLVpZQKOiiMcnc9qWa3/P/
	fibw9LPjf4kQK7sJgBtUsWUL2XOxkK5WBkk4WRvBaHzJavqxDCu7vRkQ1l4ZXdNGEf/8Etjzmsm72
	CY68dURg==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1tk02U-0054vQ-VP; Mon, 17 Feb 2025 12:15:55 +0000
Message-ID: <2fb55d48-6991-4a42-b591-4c78f2fad8d7@pelago.org.uk>
Date: Mon, 17 Feb 2025 12:15:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Veness <john-linux@pelago.org.uk>
Subject: [PATCH v2] ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute
 LED
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

Allows the LED on the dedicated mute button on the HP ProBook 450 G4
laptop to change colour correctly.

Signed-off-by: John Veness <john-linux@pelago.org.uk>
---
Re-submitted with correct tabs (I hope!)

 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4985e72b9..34874039a 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1090,6 +1090,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.48.1

