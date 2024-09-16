Return-Path: <stable+bounces-76532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B497A7F8
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B21C259E4
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E315C146;
	Mon, 16 Sep 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="erybvQEg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08215AAC8
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516386; cv=none; b=c4MUywtxv/cKJ4lyFP9punAoGwZmn+G7bvl9dP+pBToKQ4rBDecCXCGfvsdZx+v4zQGKRXe/t8TFphfOjG1IbqJAhWlB0ll3clVJj2h9xdN5FdMtqCbAytmpRRWOz0iE+fhqY9rkoCPzKpoltmHsDIdfT8Bcy71pdTGVjNLouU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516386; c=relaxed/simple;
	bh=MA2ipLhTcZA7vIZAwQ9F3rY4FTOpS7BrXQ7wWgPpTtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TeFFIFKiDMqt+yuOW5LcXfjE+Krn46xy8eyYi9bGaEp6pgciUTp0n1CpMVnSppMxJ21HfxLLSL7Uk4UYP5PfMdQ39OPwzUtoD2wohdijjsT4c2bvN2ekVW+9klzXuObyTkQHi0o4LUVDJHjPGsg452xtj0qBNYhE5Hn3/rsVHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=erybvQEg; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1726516383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MA2ipLhTcZA7vIZAwQ9F3rY4FTOpS7BrXQ7wWgPpTtE=;
	b=erybvQEgDQPumf0de4VEzDxfBBlI0Q1u+B2Rb4/HksKur0l58EZshwStPM16bglrDRpRgl
	VmkeVgI8kDsceDsQ/qb8HUTiBx0y9UzgyP57D+c7NXkef3tIDEOV2Sc0y8uuGoQByp5IQQ
	dGoE1Y6diSiVRVCEIk+9Tu7geoMAr5E=
Received: from g7t16451g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512--iqLqW0tM3GD7IwAkHPVfg-1; Mon, 16 Sep 2024 15:53:02 -0400
X-MC-Unique: -iqLqW0tM3GD7IwAkHPVfg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 659EF6000CBF;
	Mon, 16 Sep 2024 19:53:00 +0000 (UTC)
Received: from niko-jammy.localdomain (unknown [15.52.90.21])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id F32DC18;
	Mon, 16 Sep 2024 19:52:55 +0000 (UTC)
From: nikolai.afanasenkov@hp.com
To: tiwai@suse.com
Cc: perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolai Afanasenkov <nikolai.afanasenkov@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8
Date: Mon, 16 Sep 2024 13:50:42 -0600
Message-Id: <20240916195042.4050-1-nikolai.afanasenkov@hp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Nikolai Afanasenkov <nikolai.afanasenkov@hp.com>

The HP Elite mt645 G8 Mobile Thin Client uses an ALC236 codec
and needs the ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk
to enable the mute and micmute LED functionality.

This patch adds the system ID of the HP Elite mt645 G8
to the `alc269_fixup_tbl` in `patch_realtek.c`
to enable the required quirk.

Cc: stable@vger.kernel.org
Signed-off-by: Nikolai Afanasenkov <nikolai.afanasenkov@hp.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 452c6e7c20e2..5ad5a901f9b6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10396,6 +10396,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LE=
D),
 =09SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI=
_2_HP_GPIO_LED),
 =09SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI=
_2_HP_GPIO_LED),
+=09SND_PCI_QUIRK(0x103c, 0x8caf, "HP Elite mt645 G8 Mobile Thin Client", A=
LC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 =09SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC2=
45_FIXUP_HP_X360_MUTE_LEDS),
 =09SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2)=
,
 =09SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2)=
,
--=20
2.34.1


