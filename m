Return-Path: <stable+bounces-44014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2838C50CD
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F317AB21013
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3158615E;
	Tue, 14 May 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RagUqntG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26184D39;
	Tue, 14 May 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683700; cv=none; b=NhbN+2/1WwLAvOuZFUNO/odohepPBs/b8Mw2N8iAefhgtd5BWo7l8d/LHbJeGF204XsnTbPw9WQJse3nBEFUwwAjOsGjWhuQd7AmrmHduTPkNKfr2NQ21ycMdvbtQ0ETTG5QcPowY07ISU7UYjvkRAwtY1jlAwlkopLzlvxs3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683700; c=relaxed/simple;
	bh=K/MYq9neioHiQf2Sjw/2B2Q6uTicAq1SiDz9BO1KL5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ljv8lXB0IK2aEDpAlclWN5NGRcFpSP4R7NkAnIT4P3+NR6vax5XEcyNHs/uWNsDLSpEgJm6IIRyYc0ceQmzFylrYT+eaUc/BJw7hWl7ePuODCBoFbFJTwtB5LWe3FrJ2X70cgnq6uFzM10DTeymup8uZnNs0b2p9XEjK/0VuIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RagUqntG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17DBC2BD10;
	Tue, 14 May 2024 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683700;
	bh=K/MYq9neioHiQf2Sjw/2B2Q6uTicAq1SiDz9BO1KL5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RagUqntGDVlwBEm2ftPoefNVqaJqjIcVEpsSwxv+tCyww7154U+urcofWE8mDOBWD
	 HGOLTYZULFanQCDGgxr1PeUI7oKOWFugkFF+cNBaFMWiqP3gfMpJzMYSFKB5dhfDHP
	 JMEAYnZZJNiSL3hFT9EwCgRKX2Lum2WEh/r1ppQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aman Dhoot <amandhoot12@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.8 259/336] ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU
Date: Tue, 14 May 2024 12:17:43 +0200
Message-ID: <20240514101048.394469119@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

From: Aman Dhoot <amandhoot12@gmail.com>

commit 2d5af3ab9e6f1cf1468b2a5221b5c1f7f46c3333 upstream.

This patch simply add SND_PCI_QUIRK for HP Laptop 15-da3001TU to fixed
mute led of laptop.

Signed-off-by: Aman Dhoot <amandhoot12@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/CAMTp=B+3NG65Z684xMwHqdXDJhY+DJK-kuSw4adn6xwnG+b5JA@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9934,6 +9934,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),



