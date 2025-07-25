Return-Path: <stable+bounces-164743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF78B1205B
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8908F1C880D5
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F22BDC33;
	Fri, 25 Jul 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="WhvRBhEF";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="iEA7KqKm"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4723504D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455090; cv=none; b=CPuVkaAAs5zrxKpbRElcCuUuQWyxpAb03N4y9kOToBz9wEL9sYNO+hlKQFuhYWXDq/JCNhd6Q9Z5TfekbNTqU8zevZZfrmijC3blA1unWRd81BpX3uMNGPIVAF9d7SZZIrIJz+jHhqzEbZimc/Bo5TXfF+B2m+g/R59IoJ4MSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455090; c=relaxed/simple;
	bh=woIP6dtlEzDY0l3M0VQ4FGnewBR2yOUwHMm735zXzLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gi5TV86oAWsJOtTRjXPy2yu20V6CL/4D2ioEwaDZeUJxnYh6bT+YIoj9NoGCd0brgVbTjKOvk/M3JLzlvRc3Arne7Zduj2VRs/DMQdIGtJ/yzPsyvWPLDnQsbrJq06PPgG2Uqz7psSB/Ny83WM9TNKPG0j2ohjxNs068rV1Bb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=WhvRBhEF; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=iEA7KqKm; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753455086; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=WhvRBhEFvkuPnoYlRSp4kWLPqxIdJL1zhbuju7f1SNbhMf2R7yTmyOrWYr8fKlQfLdqlW
 H0kXI4oa/uzv+GGHUuq7nOCl8o2dW0uLnpjNZWryjAVd4DhFvfeI3xNXx+Q5fqakPP3QgXD
 kSB1pc4BFYn5PmNruVwc/RrkyKfyKrpl1C6ZPXA7C2ZfWGTF3qHLECDh5TyK+b+AgUzHWrV
 Ks0iDBNkLgINjUvXdBrGW4BaHBf92YiX+BCTzUg3DDpB7RE0+BBDMHsE7AWv3luZRbH48N0
 8lNlzoweGLep8Wzx832IZDR7rhWs3H6tlAbYJLbUj6e0cELQs77M98HywFfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753455086; h=from : subject :
 to : message-id : date;
 bh=1GYi97gw+l8m43s+LjoRWyK8qB47vHIEsv3nJylYdBM=;
 b=iEA7KqKmyYzOQhynOfCXJbBjAWxCXYx4KBfeFUtY95D+OrS83m+uqqfbZg6IJRkX+hmVc
 PprGgi2KSBppGyVcpK7qyBWX6Q4OkFh4uUSfatrAP7uvnBb77AVs25bnd/JMGihfHkJPWBn
 jNESO88atqQ9sNQ2bHm5Kbx0ZQknt2snE+0DYc5aD/LfU32XpHpaxCGbdaMfgoPqHMkszjL
 UN9XMDvB0nHWi4mNv3ZLRSQH7M+xUbRXe7G6ZpOutQazSC3+QM1eDEyvI31gSPWClG0KsEs
 fMarNcgtgPdVJtgeHPPd9EOL+6BGzfdZdJ9w0ZBpkFeyahcPzOIVnW8UFtvA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJlS-4o5NDgrj2KV-jQC2;
	Fri, 25 Jul 2025 14:51:15 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:49:12 +0300
Message-ID: <20250725144911.49708-2-edip@medip.dev>
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
X-smtpcorp-track: jiILS1_8Ao0n.A7CL6AEnS85E.g_yrgQ7zxQz

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r1xxx Laptop. The LED behaviour works
as intended.

v2:
- adapt the HD-audio code changes and rebase on for-next branch of tiwai/sound.git
- link to v1: https://lore.kernel.org/linux-sound/20250724210756.61453-2-edip@medip.dev/

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 05019fa73..33ef08d25 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6580,6 +6580,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c99, "HP Victus 16-r1xxx (MB 8C99)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8c9c, "HP Victus 16-s1xxx (MB 8C9C)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.50.1


