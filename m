Return-Path: <stable+bounces-151833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BECAD0D01
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2137E18929A8
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143352206B5;
	Sat,  7 Jun 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="PTog1a1Y";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="T4tHarSX"
X-Original-To: stable@vger.kernel.org
Received: from e3i282.smtp2go.com (e3i282.smtp2go.com [158.120.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3264219319
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294391; cv=none; b=nurDtnlwISXXZicDEE2rr9J9zZxjpL5Nmh4OXFMTg+aH7FRhlEjRbZtwRcfr92ejHylDwKvhKSDlPf0CaSgCRpawF/8sUdIV6BWEWNQWot++F3qe3FncVTzphAhKWsFEkQA2/ZAe3TUmM9oGqhUgWqhGRmZmyMUlnAQHP/VQsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294391; c=relaxed/simple;
	bh=nX74YXxYtHkzOexVkzDImxaKm+7hvrwPVrhY5bNpSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3So3x9hs72oHH7GyhBhKG31L4D4RojihlqoKJ2YZRDVQsbA7X1kPR/lrmuNnJdgx+/HDjzfOzSiCiZN6mXamp02OfiOJpD7g175ilfEYqFDQz2vLh186TnB0mGAUpzETYVnAYEg+/QLYV3kKLTyFURAtnGTCC3wVMnOC8SV+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=PTog1a1Y; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=T4tHarSX; arc=none smtp.client-ip=158.120.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1749293476; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=hOyF5qcsGk+wcyGuqz+JA3xcq8KlJ65GJ3VjxNyRqCA=;
 b=PTog1a1YYX59+s4SurKQrqlMuWeHG/nJWrFtJyx8HyQDI9N8RnSPu0NpQXnSW2AdsOy3a
 vgCgplL5i1TY/8b8s7TaZjoT/UfESQUjhxuVXYznzks84lTxEA1ZElzXDdKBq3cNwPkQi/F
 vMqAXEaW1gueIN+DBHG3ZmCgue/L73CrADcTFQIGYHsNMS156nFV2IJnQvG10hE9kRGHk5W
 PFR69ps/3DkUKAvQDbi3onaFgWlFYX+sLkqENFViqbBAVQ8mvTw1tfVzGtU1th79FCcTdkv
 vYRS371d2t1/10ua5UsXza9fxc8TQyakMzjM8KhEjMkAyOohZG12eaRoQZkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1749293476; h=from : subject :
 to : message-id : date;
 bh=hOyF5qcsGk+wcyGuqz+JA3xcq8KlJ65GJ3VjxNyRqCA=;
 b=T4tHarSXTvoCi/LcnarHE0qSaVl9QQV4+9lYhijeTs5tpms+MwZ0YKykYz0REY4qYAB4N
 yFHRDjy6tx+W7Uhog+lTBCusxJU8P5T+yJVy3aVsttGF7/hTvqyCfPLZMvDIiGFZKtuZnIv
 K+KT0M2Y8fjzhZf0datOooye+5g42Llo8dB7POwz+rSKyVsWKzwvpfD67c22pv/+NkHy6Ux
 M+n+TzKmnHOr8ctljUyY8BJQ5r5oN/BSfZ6ngyvrYWFOmroxWwX4T9sHj7vZe1iP+PbSv+F
 /ktBEbBrtDJ8DrdSiUXtB0GPDeN0RlUBAvvYFSsF9iKxxx+hsCo0vbyh29+Q==
Received: from [10.152.250.198] (helo=localhost.localdomain)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uNr8l-4o5NDgrtezB-jxvq;
	Sat, 07 Jun 2025 10:51:08 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 16-s1xxx and HP Victus 15-fa1xxx
Date: Sat,  7 Jun 2025 13:50:51 +0300
Message-ID: <20250607105051.41162-1-edip@medip.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sdbwEFunTN
X-smtpcorp-track: WLmjEf6Xfq5Z.lJrLy3cuhkLN.Tdmj6wx-LsL

From: Edip Hazuri <edip@medip.dev>

The mute led on those laptops is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the devices.

Tested on my Victus 16-s1011nt Laptop and my friend's Victus 15-fa1xxx. The LED behaviour works as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cd0d7ba73..1e07da9c6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10733,6 +10733,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10805,6 +10806,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre x360 2-in-1 Laptop 16-aa0xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8c17, "HP Spectre 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c21, "HP Pavilion Plus Laptop 14-ey0XXX", ALC245_FIXUP_HP_X360_MUTE_LEDS),
+	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c30, "HP Victus 15-fb1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c46, "HP EliteBook 830 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c47, "HP EliteBook 840 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.49.0


