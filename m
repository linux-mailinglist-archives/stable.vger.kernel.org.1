Return-Path: <stable+bounces-47036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609F8D0C4F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055E5B218AB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F315FA91;
	Mon, 27 May 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W9Hx7m/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17912168C4;
	Mon, 27 May 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837501; cv=none; b=cmIDfNz0OY5EtGYubruZHqvuqkIiaFblDksUtJm7ZnKHzfKryTXduNVHEzTktZ6R5FGBlo5mVpk/hogMla3XoOLRyBlXxu8+NSL7TkxC9k4brZE9qeGzkDcXYeNdkCQkctkL0rRiQr8TjQFGIkaeKz9EDp8cVbN/QnJQzKrNaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837501; c=relaxed/simple;
	bh=P8HEcHgVlQyot1oyKLDmqfWyErb5O57HTIXCFl2JITY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxixzHo6wtEv3Polhc19Yc7Y2hH8olxzhsi1NhMWgbW1DHjdD88kr014BHKNqin+GxP4MhhW0q9glhZKl4/rktvHikjps+72Cq5syiEWa87Puvcb1d3y8P9fqPtSErV/ykPUnrf+Xq7pUY7DplBEhGoT+YAZgHj4Lurl+NW/4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W9Hx7m/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A556BC2BBFC;
	Mon, 27 May 2024 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837501;
	bh=P8HEcHgVlQyot1oyKLDmqfWyErb5O57HTIXCFl2JITY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9Hx7m/mxsRGfIXzFpTV3DhRfwiNRcmbHSCgW2hvCiLvb6Lg72quUBuYndmkxCGN1
	 kpkpUs3uVBiF/B/OY+Xxg1qVn09byXd1fVz3IsCUXZ9rPrs1OvJLqzd55bmgXrkwcS
	 JPlovo//g1/SURDcNL4JE94Yx5rL/3+DMeT/NIwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Chi <andy.chi@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.8 034/493] ALSA: hda/realtek: fix mute/micmute LEDs dont work for ProBook 440/460 G11.
Date: Mon, 27 May 2024 20:50:36 +0200
Message-ID: <20240527185629.636982383@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Chi <andy.chi@canonical.com>

commit b3b6f125da2773cbc681316842afba63ca9869aa upstream.

HP ProBook 440/460 G11 needs ALC236_FIXUP_HP_GPIO_LED quirk to
make mic-mute/audio-mute working.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240523061832.607500-1-andy.chi@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10089,8 +10089,11 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8d, "HP ProBook 440 G11", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8e, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c90, "HP EliteBook 640", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),



