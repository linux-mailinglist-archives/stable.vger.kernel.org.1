Return-Path: <stable+bounces-173226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1EB35BFE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228593B0202
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489A343D6C;
	Tue, 26 Aug 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqzmZi2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7934320F;
	Tue, 26 Aug 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207697; cv=none; b=rXwRU0BWrPiBbpXeC6BA8tBeDGzHI9/RZAV32b/K/iS9BMGhcP6cNZ2SHJ5wgIxuwd3AFhSKN0aDLJjXUwkSOKAntjubbw99yO+tJOle/ilPrZOmAZ0G698iapLWf0BESibuTd40uyQeBJhhfNvATUJN+SoT89tKQA9FwOEsS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207697; c=relaxed/simple;
	bh=E/tVS9LmXIZQI3FAwGdbznoapdEt+sMQiYVTMSwhYYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgrcGl95N1f2tL50UcH/IPjjuZbwMuh+5tiQ7WcpDcSqrr1zWo/XA2QAo4liC1S336izaKFDdCWTI9G3kzp1vvJB7ydLAaKHBUuDdqKoUC6A+JOYZoemVBNvphrPlRXSfcehBr06OEnwp394tVcxsRnuF2bQNM5cXfnRYN6t9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqzmZi2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87415C4CEF1;
	Tue, 26 Aug 2025 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207695;
	bh=E/tVS9LmXIZQI3FAwGdbznoapdEt+sMQiYVTMSwhYYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqzmZi2YpY1bnsYF2hIw4JlVIO88XnsYiEq6SdIAmTjqRNecKSDn2Y08LGzMnCxPy
	 tBdLehLaxK5eHU3/ETw6pw2BEeAqise5uHxymYpM3Kli5qSi/7kbpdZwaQXH6UdFMQ
	 lNvVyjjHlHN+EkEtEV6uc4B0iKxw0o/Ev3aOd4ss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.16 251/457] ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6
Date: Tue, 26 Aug 2025 13:08:55 +0200
Message-ID: <20250826110943.565080924@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>

commit eafae0fdd115a71b3a200ef1a31f86da04bac77f upstream.

The HP EliteBook x360 830 G6 and HP EliteBook 830 G6 have
Realtek HDA codec ALC215. It needs the ALC285_FIXUP_HP_GPIO_LED
quirk to enable the mute LED.

Cc: <stable@vger.kernel.org>
Signed-off-by: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>
Link: https://patch.msgid.link/20250815095814.75845-1-evgeniyharchenko.dev@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10662,6 +10662,8 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8548, "HP EliteBook x360 830 G6", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x854a, "HP EliteBook 830 G6", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),



