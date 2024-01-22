Return-Path: <stable+bounces-13612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1A837D1B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E171C2865A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DAB55C12;
	Tue, 23 Jan 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZMZcLyEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F855C09;
	Tue, 23 Jan 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969795; cv=none; b=dWnXxqOgd9UhLz/9Y/hqeJgRQfAcJ+q4fr8bmZv0H0IY8mWBn10Z359/g7kG3CcvvAJnVDcfrQZIdM8QIyckosDhE6vmVzHxwR62Fy79fQw6+wWJZXMG6fwR2CrPd1M1j/nORu1lM2J33Q3k7V7b650CscYDQ+eilID/AGT8a8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969795; c=relaxed/simple;
	bh=sQHw0GcVo/iUGzCE4qy94qzGrPJQigaSu/kXepFtLbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfzsoqF0RiZDD/Z6CLB5XJXbaCwraoiHK2VfHwOHL6FZGJbi67J4jFfqIDoWYhBm6l9TFrrpOyTvR4CTN/PqJ4ly19WN94bDK3Zz8IAkRx0Y9UW/Dr0OlRNF7nHfquceceQ5u+rrYzXF4W1YaIlGoFd0enf662KdY5K+jZ2snoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZMZcLyEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB20DC433F1;
	Tue, 23 Jan 2024 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969795;
	bh=sQHw0GcVo/iUGzCE4qy94qzGrPJQigaSu/kXepFtLbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMZcLyEEp6AoDRFtBh245RJ8YtyovlriitqvBgS0P9lzMQHUaAN6JRgT4i9lGwutF
	 gf315ubEkzpoHiHDHXcQ2i9Y2di0TUk1jOFx3DdIvaDJgNwPIM6Ib+uojHfPbcO1JC
	 kRDUReaHiPnM1jfq+SZ3aYcdqqVKePV6mzONYJ1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yo-Jung Lin <leo.lin@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.7 420/641] ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP ZBook
Date: Mon, 22 Jan 2024 15:55:24 -0800
Message-ID: <20240122235831.139996076@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yo-Jung Lin <leo.lin@canonical.com>

commit b018cee7369896c7a15bfdbe88f168f3dbd8ba27 upstream.

On some HP ZBooks, the audio LEDs can be enabled by
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF. So use it accordingly.

Signed-off-by: Yo-Jung Lin <leo.lin@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240116020722.27236-1-leo.lin@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9943,6 +9943,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),



