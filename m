Return-Path: <stable+bounces-240097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOziFNRB52no5QEAu9opvQ
	(envelope-from <stable+bounces-240097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:22:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D745B438C0A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBEE9301648D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACB3A5E69;
	Tue, 21 Apr 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EibBHsu1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D753A1E6C
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763332; cv=none; b=kGdfTPO08AfAoycvA+kUsZdVvG7yLCdxbJ/ZOHTrUecK4GTfk/8tf4/XtdVxoWghkKFyRepF384iMrYfzZfwqKP1z+SJfmHz88WAw2gJws2G+zlH/AESpLvWYV1ANYuao8WK8LZomtmm9LqJYuS/mX499jUbnrIrBGUFqVri8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763332; c=relaxed/simple;
	bh=9M2AwKbS17ofIRC1yKJnKMvxXvh5B8dm90olGnxKxtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXQG8wTaJXiVklzhBMFOucV/Ww4/uphMYEM4s4E8rbcWTdN8+Kx/rNdWJpbhX7gzZ8hxri2707xyvmTb2ZfmMlCRl/9uwhXpTlCw8E9f6qHHPhiL+iwELxbU8j9aY7dwOyHACzeqIg3BI538hxYg5LGw3Ph9J6tRobrAEhKtm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EibBHsu1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so63664515e9.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776763329; x=1777368129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvcy9Cm0dO+sAARuv9TtsO6nBbvdmETJEWlG1mdfgCM=;
        b=EibBHsu1C/pw/ErK4XR8MIh4YKAFk8DmH9ISDGWZsQF2+yuJYWj7aITj1DT1AEQpqF
         N6Ol+XN5ujTBSaonnVzTnL7Hk0aiLniYYU82UZXOqgy7KNJAe33UhhTKLIyEq6aq329O
         /Lv4YvhWreiYOO/rt3LUsnKE+1DaY6MdMoCD4qNUA6YYdbbuYAfnx/WlJ1paX0sjn4cw
         C2BgTXW4JEDL+MhgK+3yAfupIY8NzVLPCjPBC0VYFoblwiSPeC0u9lhRPB2xGLutzVn1
         WyBoNTskMZQlYqpx06YNEhxPLAXH0CiQ/cm4vjjLhzva4K6XofpMZU8adCSBGe0Tm5d3
         YDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763329; x=1777368129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvcy9Cm0dO+sAARuv9TtsO6nBbvdmETJEWlG1mdfgCM=;
        b=qnwxAYhGlYeyi7OXYWSt+o1MYDdX2OksD31LEiDYi/TnDauPUu9b637G0JqTDNCxgL
         zM9M+HwFZlhpxeM1jwKdwoz8PF75S3/sxnZFdmFW0Ky5gx1LivYjeUc5uEZ2XpArkeKT
         Xj4sOgjQC+6nrkI5B04kNH0+uDndTs7Rf6kwsA2SAhtC05fcLsx/njpxNQ1CsgXZTTU7
         DO2uHB0VHGkv7Kvq4dSN93ZXyMDBzoXEykNToh5psXVyeSpEY6NM2IfkxDyj+7sLrU6k
         l8iRrEjd9WBv1tk4zZgR4/xGRL8IFdHkDT7w/5zkjsG9YLCjXobK56zBJsnRpFZcSTeU
         cxpw==
X-Forwarded-Encrypted: i=1; AFNElJ/6ta4EFiO7/XTCHDrBOAjlz0FLryAzI2pCO4vEPHtpPeD7s0i4zfiBQ1I9Vajf4esQFiNWc2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3jhmVubNAd7pgNoITX+LwJLpIv/1t9QMXHp8ULHxduccNuqW
	WnbZu2YNQfQQXQRxlDtTIWgRLoe+Cg0rHlFgcBAJ4DvPQ1ZV/PG9XB6a
X-Gm-Gg: AeBDieu7mRU6lkuO1YK8BQWFG/Ta97Lbwn4ZTlBpoa6H8mXclHysxzylsbK3ZyMYMeG
	6SlRfLIAj1IiVDcpcEpIrEXM297KzI5In6gG+6YTwbwgSHQrwCnTPIZpNYVApxlVdT62JdHzAJT
	onHfa9SolzuMmv48StoGL82ECdHxWxZEZ7uMH1mHkPEKpKcjznqTXqR9KpvIGyPI5j4kPd0pXiV
	N3ZQhRQVCsWcqzjC8pr+rgX5BaqV2DW89di9WI41obbltRiMe8Axkny0rqrOnEU9tBrQqcwOegz
	sywfbI5yMI//Sg93qyC4heiRvjYwD3bBUvrLR51AEZXzD8NXmZ+aDNxVRLXJIIF6f/C7j9Agb3B
	Ngm9S7yHVkA6V+BjM7Oz3FK197KDq07F2w2bBiIqoffz374sFHBLFm8LHiyIPdPvE4MHngCOOme
	c2cZAKuFOguIPTXLHOXlKXRKfHnDhJmdovC8Ec/ttCYoc9EoxcH9EmVSotyJNPtlv8LbwM1Oh51
	yIzLV6pzycx6zZosgU2uFCQ
X-Received: by 2002:a05:600c:621b:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-488fb742e74mr282120695e9.9.1776763329023;
        Tue, 21 Apr 2026 02:22:09 -0700 (PDT)
Received: from Friday (dsl-197-245-177-193.voxdsl.co.za. [197.245.177.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm587522455e9.3.2026.04.21.02.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:22:08 -0700 (PDT)
From: Spencer Payton <spayton681@gmail.com>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Spencer Payton <spayton681@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa2xxx
Date: Tue, 21 Apr 2026 11:21:44 +0200
Message-ID: <20260421092144.27099-1-spayton681@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421084918.14685-1-spayton681@gmail.com>
References: <20260421084918.14685-1-spayton681@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240097-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spayton681@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D745B438C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mute LED on this laptop uses ALC245 but requires a quirk to work.
This patch enables the existing ALC245_FIXUP_HP_MUTE_LED_COEFBIT
quirk for the device.

Tested on my Victus 15-fa2xxx (PCI SSID 103c:8dcd).
The LED behaviour works as intended.

Cc: stable@vger.kernel.org
Signed-off-by: Spencer Payton <spayton681@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8087eaaf1..f0ad1e989 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7164,6 +7164,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_DMIC),
+	SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
-- 
2.53.0


