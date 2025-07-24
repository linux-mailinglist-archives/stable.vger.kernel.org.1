Return-Path: <stable+bounces-164696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820CB112DC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7588B1899377
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB82EE61D;
	Thu, 24 Jul 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="t8KtA2RU";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="Dqf9Ugbb"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D642EE969
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391493; cv=none; b=D0AQBQL5QhYKJzrn8x2W3QOtwLsXXyO7mfHZp0wNzWGHKKsKxuou1XUflsydAtvsY11lIWfdDWsVLjMeZsc3ulN6/Irq8UHi8zv7im2gHkGsoG7DwjEQzB6B4NKpthIvWZq2Kr6f7s99Fomd5CyqlGMmwBizcJ1MG92zl1aA9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391493; c=relaxed/simple;
	bh=kPLRNSydlzHC9QbqM2fGWTepgluqgtSVkRAiz/qpfvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nK0TfT4cZU/lBLUabb4JhoHmBuH5DqKBVyTVcYieFhv5tJ50Up44Lh9w4EExeSZzxM0LsKCe4PFM+NFCW2TGBhvxwVWeDobKs+lGJfSW0o4FF0DV8Jwtna41ozB8P41bz5+gFcBX0KMG+0Umuskx0JLRRRPCGioRU6UAcgTcDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=t8KtA2RU; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=Dqf9Ugbb; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753391483; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=2JsRL/sU7gjCVQskAJOyJPP7Hoszso9kA5c3YVUXfRQ=;
 b=t8KtA2RUwAWpHGnRFzSkgkmsKXRQpZtPpPFDztIt6v9OCios7iu56N6Odk6O+gUbxRj97
 HT8ITwu8FMjHGoae+gnIPX3+uKh98yVRNjzJNNkfNwzNF4LcqMfK/kTcLQvbe2KHrBRtYgv
 TrWX3ptExPezVfilFM/jTX5fu01sHEDOnhKH29yRAlltHzZT4urR37m92EyUZuCvTrY7fGV
 THiI16qqoli0W5GyZJ8NZXRJ0lI3H/DzCvXVbuANOuUt6vAGlEiaBGsutilvHPTuvhzmXGW
 0iQyZvlADoynAATYYnhIBKoMcB32Mnye83uUDdzS5eVm+KdAM1hbzuvUwvxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753391483; h=from : subject :
 to : message-id : date;
 bh=2JsRL/sU7gjCVQskAJOyJPP7Hoszso9kA5c3YVUXfRQ=;
 b=Dqf9Ugbbo40t7fzx18jhNWAnmJEUT67NdFh+e4akB8OCeCyKFYAw45WDy6WOGtpJTutMr
 GhQH2tUQntCsfWtbOEQQYChji++CAHo7BJvdxh3kWSe3xybBQkPA3s0jsgLMaSfyJcFU7xr
 /LP/Aj8p0ExL4aAdTOOZWYBkjm+ZImgnimm8bcageJTzCG+raG5tUZhM79AJbS+FJPaI8KN
 0vnmj4hThcPdTFIdTOvwxN4o1xoF1D7VMdNZvOELMMvx/O5sj4A0KtnGnU8cMovdukKzKJw
 qZQEt/3Uech4o437x0cSmfEkYUVOb+Ww73eALz92xGqt1EtggPvl7WjeyI7g==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uf3De-FnQW0hPlgfz-iQGq;
	Thu, 24 Jul 2025 21:11:14 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 00:07:56 +0300
Message-ID: <20250724210756.61453-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s1IhQhYw_2
X-smtpcorp-track: AtXC14SDy7-W.BHX3K5ANUOBC.5V7R8gWpU7t

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r1xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2627e2f49..9656e6ebb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10874,6 +10874,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.50.1


