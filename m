Return-Path: <stable+bounces-74765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721D973155
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CDB1C255ED
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107B1917DC;
	Tue, 10 Sep 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSb3CmZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09218FC80;
	Tue, 10 Sep 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962764; cv=none; b=D/XjYGNrRf4H5GdBFe8o5BERf+gXUbMY30PiL5oxyDymJodVMZ8kbRtgHCqhZ5z/fUeHTgTVEoDTLt067sf4ask7Rmv0VZyOizbk45ds51t0QvBo7aSkLonXYUfdHHqb81gn8LB1De8gTTdhpm47AWLSeBXXvKeo2ci+fm/0Qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962764; c=relaxed/simple;
	bh=9TtQciSNZ/10ZAtPAOuPF5TwtGYq3hkVnf337ltGnkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMXWPHV149IT48ssheb3SBw53x2U8Kl7jPoADnGWdo6G2GOaZXOcdYCYeDRAIbmBeI7ygwoqaksFyzvkdvpWEr47LBprL97l01XrGyqIRJXcigDTkawsdUuKthltZr6biE1tW2ZvwxHxyVkbRHp1iSJjjeVyHOxT2PbUWeDSbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSb3CmZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653EAC4CEC6;
	Tue, 10 Sep 2024 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962763;
	bh=9TtQciSNZ/10ZAtPAOuPF5TwtGYq3hkVnf337ltGnkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSb3CmZiko22CXK23VpUVHIsP6JDcq4piSqU54Z+XY/cQQM0KdTIRzIrVB8LqXwfm
	 ceUrr54q0IIchDGSUPFPt/83HaZCEHnIoGfZuMJ54wHv527sYJAL2Q7RTDDxDYZmui
	 784KDiz6/kAHe9jlA2YFe8Pib78Tc7lsnEwYIx1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maximilien Perreault <maximilienperreault@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 008/192] ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx
Date: Tue, 10 Sep 2024 11:30:32 +0200
Message-ID: <20240910092558.254385461@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilien Perreault <maximilienperreault@gmail.com>

commit 47a9e8dbb8d4713a9aac7cc6ce3c82dcc94217d8 upstream.

The mute LED on this HP laptop uses ALC236 and requires a quirk to function. This patch enables the existing quirk for the device.

Signed-off-by: Maximilien Perreault <maximilienperreault@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240904031013.21220-1-maximilienperreault@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9717,6 +9717,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fd, "HP Laptop 14-dq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),



