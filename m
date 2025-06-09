Return-Path: <stable+bounces-152000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DDAD1986
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD507A4E7D
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056827FB3D;
	Mon,  9 Jun 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Y9ZR/iZx";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="PgpLn95b"
X-Original-To: stable@vger.kernel.org
Received: from e3i282.smtp2go.com (e3i282.smtp2go.com [158.120.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3A246768
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456248; cv=none; b=D2Q//54GmhuFub04lUhT8KrMRQNruaSj5oGuESk0yR9Xa6lBI1ivMTIPlqtY/DtsZEayfwVww9NMcd1iTYDdk/yC6+UXqnN4zv/7jyrSzfuV1+GAg5FgUFDidneT6sJs/p5IvgQ8Uo3UtGPxgFcv5Ia69QiFjH8nO/yRCnKL334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456248; c=relaxed/simple;
	bh=7VIXiVnLp6xUMZfeU9BYhxVdq25YMhx1Vl2EPXeFzSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKE1JkdOm01xQKu7D6hSqZpXfvwgNGGnNoBY/CIZODfto7F09nH8gMwaZM2VCU7jDCoj7frgsbLJSWAlDY+Eqf6OVmIW8HrgjivNhjVsEc6K+S+7xdJmUThpAU30UgcepdO2uHZUXmjN0oCWXYFBLkBz02DrFcV/11C1rhqIzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Y9ZR/iZx; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=PgpLn95b; arc=none smtp.client-ip=158.120.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1749456237; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=OAD1I4lKD9GurTiefje3GPSgP3drA15uqZbSTFtnYlY=;
 b=Y9ZR/iZxs3PTdYmMzlQ7NC8rMrI9PUH+YMZIi/XySugGlpQlZzVxc1bdF9jseE3o/1XSE
 TYoRlr9OQwSh/PoYap6wQznsw+3zGHTTSpREd0tLaUwYiK6jkhftKeojVNLNKAJLldeoN82
 2r4pRioY8s3b610O2oNHVCUsWoZmdHtK5AtYbGbLienedKl2uPXae0KI4x5wS9zrSdTZN/m
 lLQNJkdMEScRDv5i5gIOd8oW8D87v6nQEehe5/t3qMqfrSljgoZ0XfakMkUs67itDac+bzQ
 sPD9AxFOTsxkTXDaYFpmgMEuKIIofqvLP06QiY9vJijng2DypXSO2CKhd6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1749456237; h=from : subject :
 to : message-id : date;
 bh=OAD1I4lKD9GurTiefje3GPSgP3drA15uqZbSTFtnYlY=;
 b=PgpLn95bqK/GhxZviIO97og4ErULY+hr3MPaVdMB5NM8/AwMP1xiaatVX4xWWmseQBupR
 7jTosGoSegjEqoRRDe02YmhH0ppC/pimMdtIv0YZdAI5mYIyUQ/JrJAtryvHR467BSMOPYU
 TfaJ43Yv7Mvi369gVWxl7L0XcfvMODiEDQ0wtFvmBjxBsT/11qWffq1TYfCfvME9w3ajBH+
 ltHyJIZaNMDZoKZcoq4b5RSPQils27pg5jgCojSAPmXAVSDx3GmfUmu9loIlrpJD/0sM3R5
 rqvK0vCKIiFee7LfymdR4ndFdLYO5+dPbSF1fq83yJYqeCRSexJC9aMJ9r0Q==
Received: from [10.152.250.198] (helo=localhost.localdomain)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uOXU0-FnQW0hPmmyb-hAwU;
	Mon, 09 Jun 2025 08:03:52 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek - Add mute LED support for HP Victus 16-s1xxx and HP Victus 15-fa1xxx
Date: Mon,  9 Jun 2025 10:59:44 +0300
Message-ID: <20250609075943.13934-2-edip@medip.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sVoHSOn4rB
X-smtpcorp-track: JoOBMPqWbl0I.dugwOn4Dn8o5.wJ0CzwbIxmz

From: Edip Hazuri <edip@medip.dev>

The mute led on those laptops is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the devices.

Tested on my Victus 16-s1011nt Laptop and my friend's Victus 15-fa1xxx. The LED behaviour works as intended.

v2:
- add new entries according to (PCI) SSID order
- link to v1: https://lore.kernel.org/linux-sound/20250607105051.41162-1-edip@medip.dev/#R


Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cd0d7ba73..c70bee626 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10787,6 +10787,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10840,6 +10841,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.49.0


