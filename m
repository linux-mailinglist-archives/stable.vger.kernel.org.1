Return-Path: <stable+bounces-60079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C889932D49
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336FB1F23F7C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104419DFB3;
	Tue, 16 Jul 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkpbV2E2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4019AD59;
	Tue, 16 Jul 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145791; cv=none; b=QhJflwcDPmy4Ls3hkDhW2YrMP9aFxZKiG4hRJ/5k0aJQfejIzTB9jS9m40uo/MvJ3bRpg3i0H6rLiUZafqqIpDFFU/fddfz1Rt9NPg61Lmn+w8qBwzdklbdlnJYc+kkneUGGV8JwZfoAQgKzSMFECLohr3b2Q2lg6yA5SI/ncqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145791; c=relaxed/simple;
	bh=Fzy700Mzo0dA09UzHVRlW978PUPkF+sJDkF6N2Dtuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIEcE4H6Jc91Zw98O16SOFMXIOJ5Wz0q0aNBhsQqiI6AXpiQjt9DwJYX2EZSQVuJCqmu2jT4O7xOTrbC0Cxj1LrfLiwyQXV3/zRlB/K9YiPZlGhS8yIUwOYZhvJEfO9mCOB5imGkVFD7wjp2SfSmJKK+poffSO2rvmZspjg+aV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkpbV2E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D990C116B1;
	Tue, 16 Jul 2024 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145790;
	bh=Fzy700Mzo0dA09UzHVRlW978PUPkF+sJDkF6N2Dtuz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkpbV2E2OIPhXwBitIm3gcLdTmVkeClydfwloQCsjoLr7V6EzaEN+htJY/o4snhn4
	 1UrPdxiOGG4VsvoKzP1edQDQTlvDkGw95bSlC0oPWAboC/elGS5y+rpMYm0J3/1vIk
	 8RkeNKute7XLjFAY7YuwnG6JHvDEME8yif0d7dVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal.kopec@3mdeb.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 084/121] ALSA: hda/realtek: add quirk for Clevo V5[46]0TU
Date: Tue, 16 Jul 2024 17:32:26 +0200
Message-ID: <20240716152754.559289875@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Kopeć <michal.kopec@3mdeb.com>

commit e1c6db864599be341cd3bcc041540383215ce05e upstream.

Apply quirk to fix combo jack detection on a new Clevo model: V5[46]0TU

Signed-off-by: Michał Kopeć <michal.kopec@3mdeb.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240701111010.1496569-1-michal.kopec@3mdeb.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10182,6 +10182,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb022, "Clevo NH77D[DC][QW]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),



