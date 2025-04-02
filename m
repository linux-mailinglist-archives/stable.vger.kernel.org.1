Return-Path: <stable+bounces-127384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12ECA78928
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77937169253
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DE233152;
	Wed,  2 Apr 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="h7yTh8CD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8220E6E3
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580222; cv=none; b=NoN7rtEdMm3qMlPlRe7AhanUpxQHiYjR5ixBXrn+qJxRKryjI03y30nuKJd1mgDjJdfb8nkAjNYZwoD1pYD2psGdiHL/nTw7u1WWJ2i2uLZBanbgnHKMuAtuttsb2MhywD9DBzbLdRBPArWmvhW7J6j8iExRse0qpUuATsPi5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580222; c=relaxed/simple;
	bh=DFiJTeZqTd2Uq0TWu5dyYjkzHlq2zXnn61BPwTA7QbM=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=u3STfumRodzajIACN2PVQa+hekgm+u5flu1COXPLF/Ob+u4Xt/hxbU3HfmDtQg6VXifMjHk1qFG/M4WFlN7HXb1yzmRiVIUHRZ/CeHwuPuUncmDsgzmSULN6NVpM8RnhT2MrTG6NsBHwm+KCqRmqL8fi5XoxzgWdYFmODI4MOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=h7yTh8CD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so949825566b.0
        for <stable@vger.kernel.org>; Wed, 02 Apr 2025 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1743580215; x=1744185015; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKDjK7/cGQVqlmazW5nW2G2BmxO/bmfZfWURFvcSEyc=;
        b=h7yTh8CD59KlUb3wxqD9zj+g6Fiz9EGgfMnNhBtmd/pH6YumPUKiubWge5RVnLts1I
         tMuFtsOSPpLcyQE6DFoBBtGHoKi1fhT1HqXWX549JC1wXJ+BAHX+VJ+UpHmYNCYpbSWI
         Phz4LRXu9LwnyZ422pNBkX0dyG/s2B1GqqHckj8yNoJk4eNjoYc2hI1SENnEsiUMXspn
         w0k1gk3X0Cf9IV0SYwGoiTxJuCglRjnZ/nPyNF3ac6ppMjuVAxsHhQcBoETbh3J9/QfA
         NRFzNKai6uF9FVuEql6ujgZM76MmGmptkaJye+HyOtLg/AKiYDXpTLX4rL/bsiFBUsH3
         LpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580215; x=1744185015;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKDjK7/cGQVqlmazW5nW2G2BmxO/bmfZfWURFvcSEyc=;
        b=sLY049lcbS++sfL0F1lUAc2VdHqqdx1KZrswt8RpIda7Ta5P5rInbfS/c023Y1cWz0
         B4nDwRnaoBxZ3gAiGZ2Y3+IYus662xvghVD9+Jc2fZ0YU1QXPnasS6XwWq+SjI0zBScU
         gjNQmRuHFDwbYVOHQk5DmWnAScsrnrnUhn+jMeNexppscR6sAjrjapQDvXewKF7gReXN
         rzH6KqJyvmkvI4wNZl85Fo+fRifKJX7CnrvOeyCRd2uv4VcIXqirnt0ebk4fBkR+kgnW
         FkGl/1ujEER4guVrrkugrrTh8R62zxBTaiI4sxbIfAW0KPCz3nHsMGyio1nL6Dpyr6BM
         gPlQ==
X-Gm-Message-State: AOJu0YzCjuv5yBfeKpOgfP6C2ILwv9CcI2lmjZYoOUNmZMTnOWQWiiI6
	5Cg+OKBXBi5fca1chnLGcQDFiX6FOwBcSayKQbCgZ3hvtzQCW39aeLTBb437iYjDCps1mUhy7oG
	TQrzTYrEJ4kDzYHTTJamNm4h+VWmQpbQ5UDzXA1rBgIzrwl/d3Q==
X-Gm-Gg: ASbGnctNrw6V9StKwR6XQnT74Qbs5MvrgQbBmpGc3L98YFNv2Rxgwyd+lUGeaZ060Un
	PmkPCr+1Mw0/ecqmBu1RLvHfJJj1zCWF2sxNFAw1HA3iotrZCkqkLdQciDo9w4tgTjkkZYgAm1p
	rhHZaqNTJvs6S23jSx67xNhnsPFQ==
X-Google-Smtp-Source: AGHT+IG/+DPpY28O+N0BsjclwE987nrJhgZFrgxIHuFTVpgalj3mhJIbOw0peKIYmXuLUBAbXU61Sr9xbPyW7l/MVJk=
X-Received: by 2002:a17:907:7293:b0:ac3:8537:904e with SMTP id
 a640c23a62f3a-ac738c21aa3mr1149249766b.49.1743580214574; Wed, 02 Apr 2025
 00:50:14 -0700 (PDT)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Apr 2025 03:50:14 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Apr 2025 03:50:14 -0400
X-Gm-Features: AQ5f1Jp-1vFLZLN53WSjaBw--DwjVYe3CtQiPtUg7W7lpBvLu6GtOhtLV8JQU8k
Message-ID: <CABtds-2+RYQdJ_y0pP7tm9mVBJBHOUWSEtGXPNdt+mLi+3fpDw@mail.gmail.com>
Subject: [PATCH] sound/pci: Add fixup for Star Labs laptops
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 427d5b100dee0c5c3a09e3e1ad095b06ebe33a8b Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Apr 2025 08:31:04 +0100
Subject: [PATCH] sound/pci: Add fixup for Star Labs laptops

For all Star Labs boards that use Realtek cards, select
ALC269_FIXUP_LIMIT_INT_MIC_BOOST to mitigate noise when the fans are
active.

Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4fe681ec3cb..d75b09f962f9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10921,10 +10921,12 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7",
ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
+	SND_PCI_QUIRK(0x10ec, 0x10d0, "StarLabs Kaby Lake Laptop",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board",
ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100",
ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
 	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400",
ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x10ec, 0x1200, "StarLabs Comet/Tiger Lake Laptop",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board",
ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board",
ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board",
ALC295_FIXUP_CHROME_BOOK),
@@ -11238,6 +11240,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air",
ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1e50, 0x7007, "StarLabs Alder Lake Laptop",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1e50, 0x7038, "StarLabs Meteor Lake
Laptop",ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player",
ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL",
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.45.2

