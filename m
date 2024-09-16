Return-Path: <stable+bounces-76530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84897A7CC
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5917CB225B0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BD15B560;
	Mon, 16 Sep 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="WDKuDLMM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0B15921D
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514837; cv=none; b=F1oAdKZCmJ7Nf0FDmuAvNLalnq/9buCQJmiHo/ALN2ocK+I4kHc7q1g8gpwr6HVwvynXsZe8oIO3RuHEm4iNpr4vqv87+FxdN/8z60BZjPrERJRHFkeN8RDWtVrvDg9trVt5/hVZZP/ATlgYBfa/SzeXeYpDiZBMRjBng0foTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514837; c=relaxed/simple;
	bh=MA2ipLhTcZA7vIZAwQ9F3rY4FTOpS7BrXQ7wWgPpTtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FWk+GqZYpugcvxdpj8fXeklDFBZoGolajqt/VQEIcGYytrCTAMfpCL5+yOydXG6u4m6I6g7W6OaevX1ZHCqEnPJKJaWc8W+e/PGXn+rmK3m/ljDHrzQC5xwPDQsZ7tuw9NAuyLeXmTgfp3u2F/ruJokRgO8exq6pe2f6P05p6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=WDKuDLMM; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1726514833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MA2ipLhTcZA7vIZAwQ9F3rY4FTOpS7BrXQ7wWgPpTtE=;
	b=WDKuDLMMxVEVn85RO97sLsZgggmXbXH1jDaKtrNTHaMKopcUxEBQlYDa+hy6DVt6FMsfiT
	M6LX7c7rLRP6HS0G0RpFnhKH8zWTHdSejefTf/5kVo310gwlreK6bo0T1EqEYjC7h3N7uR
	y+VMYHnix+TqWNBQ205TZKAc2oOHmnM=
Received: from g7t16451g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-oPleO0YMPci8afcKhvXddg-1; Mon, 16 Sep 2024 15:27:12 -0400
X-MC-Unique: oPleO0YMPci8afcKhvXddg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 0F10B6000CA2
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 19:27:12 +0000 (UTC)
Received: from niko-jammy.localdomain (unknown [15.52.90.21])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 0B93518;
	Mon, 16 Sep 2024 19:27:10 +0000 (UTC)
From: nikolai.afanasenkov@hp.com
To: alexandru.gagniuc@hp.com
Cc: eniac-xw.zhang@hp.com,
	nikolai.afanasenkov@hp.com,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8
Date: Mon, 16 Sep 2024 13:26:48 -0600
Message-Id: <20240916192648.3918-1-nikolai.afanasenkov@hp.com>
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


