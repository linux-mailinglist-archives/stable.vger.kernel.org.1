Return-Path: <stable+bounces-56199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28191D79D
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 07:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159501C22213
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548B17BD9;
	Mon,  1 Jul 2024 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AXI39UAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74A23A0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812789; cv=none; b=QOiI+68PNZ21uT/MeVP9ZINTD3pnCsGG9Q+QwDnNQNzlm8T0XIs7Q5eB1Yfug8mVXuXIXwYFssjtPoBWT8bVyt0pQjC8rjzVcJv9td9LESOV8/KasYy7q89ysI/7xlt8Fjggo/9UFgaF26pt/Se92N5uWn+vbhLOr/buSWU1zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812789; c=relaxed/simple;
	bh=Y5gUTAYYE7D6bIFahmuhUVQrQOQQCKJVeHO/25tDj9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onM4QogYzDNabJHfr0ej7gUSUGqitE+LldZZlbeIKWLx7bpuhA25F7YcZWjatzq5/hPV7IufA9mDlS5RlF8ofUD4aVbuAJAH5P93O38RaeRPyg0MtKgODnXolJYXYy27EzeohMdS+qpbj221EIVPDJFRRnt6dx9yQIkLvXwQhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AXI39UAU; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ABC593F216;
	Mon,  1 Jul 2024 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719812779;
	bh=P3dE/iZsUyagRUEXuQdzyVha7Xs9GuwrqaT1+fQXsEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AXI39UAUCTF/MY2BK67Lvv2+Y/mBqJuL/5brPxPtyxBT5McxQmbPxoyW1JhRhZGrO
	 LfJ/WzeqKm741arhh3bxdq4gQbwvHci9DztSY9X+8l6w3RXL+TCY55AmRLxAQZAYIr
	 IKxbBHFSbD/eVO2YGTmoI/RwVcD5h/aOdFTrU6FQk+SZJMHsymIc8eZtzfiPVJ4hUn
	 rQkr/b/R3vnAI+YsYXxrIC3ypdJyHYa9vxSn0iedxk3Wh0OEJG1B0D6VyNvRTDD4Ka
	 ZqLYY76FPK1YCA9OZm9X+x6on7NBahPEN4fCLuPU+aUAsx5n3ZCSqw3uhYKQtjmOTa
	 CIeLhFrQTnuWQ==
From: Dirk Su <dirk.su@canonical.com>
To: 
Cc: dirk.su@canonical.com,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/1] ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook 645/665 G11.
Date: Mon,  1 Jul 2024 13:45:18 +0800
Message-Id: <20240701054518.32567-2-dirk.su@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701054518.32567-1-dirk.su@canonical.com>
References: <20240701054518.32567-1-dirk.su@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


