Return-Path: <stable+bounces-165114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECAB15290
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3C3BB418
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E87F237163;
	Tue, 29 Jul 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Vt6bm1Jf";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="EFNNKK+C"
X-Original-To: stable@vger.kernel.org
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B422FDE8
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813184; cv=none; b=Psx4zkDLKebCav2C2/zSa4tbwU9KIOjP6YCmTCQg0SFr2qw6IYp0hwQY9xUwsiBifmTcfWxJT8PDcaOk4LvOAAs2S/WxNV3UP25yNM993dVrxVMRZDdLXMJQnsNCLYoYoS3tgDskI8bWYc6VwlXHOj94CFVLuiBPIMDUGcCBSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813184; c=relaxed/simple;
	bh=sA4RPjAxM05RQekn/x6/fjnGX99Zklg8NEEyvJ7D9tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGConz0LFEYFmPDqkiVwitFynaA0ef7+MjlHgPcIvsINbdjRHFSvAr7reR6iodmOQmxYa3xCnqNz7ZMOzJhvwqF9nKCOKoW9NkrYeohHH8PXxsqey9iyn7CnF07IGp9XpirsG/eapxqunqznbtAlRWhhf9GfrjNVHWHXjWlsZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Vt6bm1Jf; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=EFNNKK+C; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753813174; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Qjq7ANPEafKeVIOcRRoL6S8s3iv7vnOx3qEiXVCnF9A=;
 b=Vt6bm1JfIaZlmxDA6X2we3Xfm8GwiAcK7CdrOQTccAO/mtpKA55VtUYv6Hm3lKKx2Nihq
 oPhSExpTk3452fA6RFV0KwNtnuKqX9SWBTcdMlHdo/LAQFHNXgnw2ReEE3601H0UV7aq6ZH
 wuLQ1w9jrLnhs6NOxCI5cM4lutKtMCrGLE5+h8Twl+/Kl9GgV1CupsY6OFr2nSX9G/6Z/up
 qTtuPtbWxG3v+UfTPQjlLDhSPIveOngg67PKFlX9Oz9fhKq8rcFpr38Grm90MNOa7W6GZxq
 WDdJilliBo8rOhkVzqDYyTWx6Zed6RjwWnxkcn/8DtfnQ5d61xX6LGDSybJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753813174; h=from : subject :
 to : message-id : date;
 bh=Qjq7ANPEafKeVIOcRRoL6S8s3iv7vnOx3qEiXVCnF9A=;
 b=EFNNKK+CG5UnvLGQ7UNwTlybQIhyQdAshriFycYwMKfqDFsIKvC2XxBXlHc3kFu3OsrPU
 29ijliuzyKJWprkj6UhRBQQixJqc5CM1QEpD1BvaFCRj8OT+HFBrWaDtwvHm+iEZ75QQL1r
 7k8nFe+/y5A8MXSWhpOsfs72bNu8JB72Evcto3zEs8y/OIdw0CUlODMYL2RS0V19CEd2YJK
 J362MlqjPKfky7kl1DpB7MGrbYt5goBPSG7DMQUBNFFfHH1J/FzFvlpeYvo5LJp/JZuW1uq
 QGQodBYxkQxUovAdZ3iD1se96nHAkVMZpzZkFX/Uc7QFYKtb65jKmuFQFqfg==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ugov1-FnQW0hPr2KU-NS42;
	Tue, 29 Jul 2025 18:19:22 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-s0xxx
Date: Tue, 29 Jul 2025 21:18:48 +0300
Message-ID: <20250729181848.24432-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s11F8cfyv-
X-smtpcorp-track: F2pDJ3oSLYMr.lgjBK-aMDN6B.Lq0IUAIS2t_

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-S0063NT Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 05019fa732..77322ff8a6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6528,6 +6528,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8bd4, "HP Victus 16-s0xxx (MB 8BD4)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bde, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bdf, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


