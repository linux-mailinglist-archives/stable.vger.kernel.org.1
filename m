Return-Path: <stable+bounces-189882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E0C0B0F2
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 390F334A242
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84C29D26E;
	Sun, 26 Oct 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="WYkTegLe"
X-Original-To: stable@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276821E32D7;
	Sun, 26 Oct 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506222; cv=none; b=PW28P8jeYhRxAIW9JbsZIV5ZCT/OJeCaVLQLXymOvTkl4ul3h1HT9rSyy3154Ebk3TDCFwEEoPWVKT7tJeQ99vdsxD4nHmEGMTeyyOBu3tjGGFTjgCs5ySQC5Et0L+ePCRGkHKsmxYwtZtjKoa6bVqYbMiicura6DgngF8dtEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506222; c=relaxed/simple;
	bh=YXde7+UsHLF6n7NW69QBA4zgPmtQPc910e24TkKeDT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KooZUJhW5hzWvVAQ2iRZEW5rXCzP9Uq2AC+DYxLIRj83UG0wMy29n1fTRvllixGJRUx+wRARUfhHFBrcSUmc3BSgy2ByEE300foP3ix90TWhPQOijv5l7mDpA2X1jT6aAy9LEQQ9JmqzyTBG2UqtvWxqfPWYrRWrdOmKncfQIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=WYkTegLe; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 87583464CB;
	Sun, 26 Oct 2025 21:16:50 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id C4DA3464C8;
	Sun, 26 Oct 2025 21:16:49 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2F6B0201869;
	Sun, 26 Oct 2025 21:16:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761506208;
	bh=7p8O7caPGGWl9GQYBs68jELwmH/dvG2c3Cr5mouahpE=; h=From:To:Subject;
	b=WYkTegLeNeO7JeKFiFvEFu/f3pWnwsIpnfXA4KTL8L87BaZkRbzlUelYUoz67/MvV
	 7fmSRUOuZ0qmrAmI7TBa+uBJOfyn+yX4AEyy0b01MK5SEJOECGKlP09JiwVOUWNibK
	 T2GKsmWLSnJLCZTib7blTb/Sr2n01kw+z1p1Xl6Gh4xK6H4VHxIjsoGCV0h9QnoZjJ
	 p9swp9eh+lpukG7vXQNfa4uZ2nkmxO4k2N7IZ7+FuO2e+LLBxbanC6Cm/lZW61x5ft
	 pkcpY7UavM+vBzH2XGI8SOjNOv8qWqzp+YnS4h4Ei4Elob1X6HL8G9vQVfjFDgj9Ni
	 zlg6qTpEgOfJw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Baojun Xu <baojun.xu@ti.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
Date: Sun, 26 Oct 2025 20:16:35 +0100
Message-ID: <20251026191635.2447593-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026191635.2447593-1-lkml@antheas.dev>
References: <20251026191635.2447593-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176150620881.1168891.15055458453884595140@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
projects. While these projects work without a quirk, adding it increases
the output volume significantly.

Cc: stable@vger.kernel.org # 6.17
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8ad5febd822a..d1ad84eee6d1 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6713,6 +6713,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
-- 
2.51.1



