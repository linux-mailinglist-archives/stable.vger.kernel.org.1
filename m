Return-Path: <stable+bounces-56200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415B91D812
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 08:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FE81F214D0
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E543AD2;
	Mon,  1 Jul 2024 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nnnIcND5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2E36126
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815109; cv=none; b=mx27Z7Gx8bPbvNtAiCEL6paWEmU3pnBEInzK6ViUieP62qKhQstRSbOOKOugfprVynNNlO/Taewlb7s2V9cbmt6F5c+9zmqD3MgpLuMX9rpytrMU4/FAw0Q2qh408z0TKclKGq1pJ7KiNDOUenAdHweiZWqOmBdR56f3J5Iue7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815109; c=relaxed/simple;
	bh=qQ1oDu/HyXSwWoljZ9mELVEKsc2uOOL270z4IXtxTe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnuI3fr9K+CEY1pHsxDOsgpnOkBeRheaghJq6J1mLCcWzDJtI7us3z7pHreJAO90m7UkhawP+g2HJyctVqmGBMgN8PVT76IFRoyyQNh5ElaeSV+HAH7PPXCAMYgbBryhA7B2ZopRGl5c9pAWoguJfGV3O4t5Lj6hrx8a42NlHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nnnIcND5; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3B7873F328;
	Mon,  1 Jul 2024 06:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719814499;
	bh=F5WXNYQh9orxVIo4BObH4SSThEcqE1kduuP9j2LZOAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=nnnIcND5LRcxfgotAZ1rk/H2GYBomJjNyKsdFSh6mdCvwA5JrY3tvZs33ZcOpBzDu
	 ygpolnL3Xu6OeRbx6mDH4LBynOlrHqAG6ko4PCJta+UuDzioZ1Wkj4ierOQ350kRrh
	 jzCfsgRjfZuoCf5/Ddp+Zq/YmkLaDdAPyDkTIeMgndIBnqJSpREAJj7MKfxdqUqrNz
	 bCpqeGGc+80RfUZWl60gdONqANF/LBw23IuEMF9pVfYPrTBUxywrlzaue6mF0Iuxpe
	 mZv3X0RqiM8ZM0xSk6hqLeKnwtW35eAoviNDSWULr7caPCli/ZkxcJqjPv701bJhQ/
	 6j8EpdYtf361g==
From: Dirk Su <dirk.su@canonical.com>
To: dirk.su@canonical.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1][SRU][Noble] ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook 645/665 G11
Date: Mon,  1 Jul 2024 14:14:52 +0800
Message-Id: <20240701061452.34515-2-dirk.su@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701061452.34515-1-dirk.su@canonical.com>
References: <20240701061452.34515-1-dirk.su@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2071296

HP EliteBook 645/665 G11 needs ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to
make mic-mute/audio-mute working.

Signed-off-by: Dirk Su <dirk.su@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240626021437.77039-1-dirk.su@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index af641c628c0d..b92e43fbed6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10055,6 +10055,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c7c, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c7d, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c7e, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c7f, "HP EliteBook 645 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c80, "HP EliteBook 645 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c81, "HP EliteBook 665 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.34.1


