Return-Path: <stable+bounces-165115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09587B15296
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 20:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCA3BC4F7
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C623496F;
	Tue, 29 Jul 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="lQOrmGYj";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="AJI3FRAo"
X-Original-To: stable@vger.kernel.org
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5C238152
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813201; cv=none; b=Z3FHKZXvzqpRmt6EVGIx3xftrx3PNMmvn7CxCD7RaJSn0p7TCWE1j/g/YXRRcVNs4EooRvm21biYMyKsXRyF/xhT2AurAfSRMgu3Ia0s1AEMbnE8UgJ0ttlyCY4F17NbVkELjExynMMhZ32tI+ZogQqsQMTTRb7woGtCmKbD38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813201; c=relaxed/simple;
	bh=8cZ8iZ8qtV7gGNyVIsY/ItajFVHqRLfZExe/pKoKmuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvGDikV7khM91c2gt9zgUdlUMgNK90cS3X2wgmFugdN3FuwXppNFN5e8AncWakALXHEP4ePlLCPIaTZQU2wKw3vo76kMNwl7RWsbjSqCu+JjzvqXEKRWwQPq0Yct2bvPXa2c2Cdx2Lvw/OVlhv1XIXOzW6DJ5fE8hjnHwETJpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=lQOrmGYj; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=AJI3FRAo; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753813195; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=W62LCwnhZ9/NUInAK1TZuyBIe4Xaetrqj46TOlKwxq0=;
 b=lQOrmGYjmoNc61ARoToOBFA1zO4rRVzi2ozoljTNJkaN4jb3AOtbEPy2aAMruYh0Utn3M
 ny4hCGwDE55qiy7DLMJVjlsLpoTVwID/p3FyYi4XDjlFUVC4SSD/trUtwqaqY863AOSCF8N
 28igqzWCKyILDi52ZsYpNg2S96n/s3fmfIDZ6w8tAGYUckbZReFc5ueoF8NZnwRymb96xqW
 +6yZlr0Fvk0p4/QWv8KdxT7mzSJYaH0l962B/4zErw7Qqd8OTeQGW127xzQdv0OogIaVX5e
 1OcocgW0deHQcTEcuD18TMyB1clA/7WeGV0HzaRgzyDFnkhtYUiym9Lpp67w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753813195; h=from : subject :
 to : message-id : date;
 bh=W62LCwnhZ9/NUInAK1TZuyBIe4Xaetrqj46TOlKwxq0=;
 b=AJI3FRAodUpOAPstQzmAqujyEowsK3foHxnhz8LrvcBDHh0G16K1RqQYwTgwDMaNbICRw
 TkllPuOlTDKLBWtVHyGF768M8ZhcdKXKP0y45MPw/H5iTdyguYi6PwadvghK4atyXb6w6je
 oeb+a1LhH1vN4grsDqAs5nkac2MRgH6QQ5sK+vxt2gZ171Jo2BWw+1zps5fa7aXn8pFeEk+
 33zfcz+Zu7u44ZAWK9ITCoYQ3FRTdVvzda9b7wWyl2+r2ShsHyLPIYhL2md2xs8H1n/1QOF
 I+Efx3wwBhjODuN2Kh9D8UN3hetFxswy/TO5itk1/gNB1S55weuHJKr2x+wQ==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ugovR-FnQW0hPr2KU-OeZJ;
	Tue, 29 Jul 2025 18:19:47 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek - Fix mute LED for HP Victus 16-d1xxx (MB 8A26)
Date: Tue, 29 Jul 2025 21:18:50 +0300
Message-ID: <20250729181848.24432-4-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729181848.24432-2-edip@medip.dev>
References: <20250729181848.24432-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sDUZirJ3h6
X-smtpcorp-track: Ub2-AKIo5UUM.K5CkOJkNbBUm.NA87tgGtE2d

From: Edip Hazuri <edip@medip.dev>

My friend have Victus 16-d1xxx with board ID 8A26, the existing quirk
for Victus 16-d1xxx wasn't working because of different board ID

Tested on Victus 16-d1015nt Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 77322ff8a6..d0f1d01bfa 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6470,6 +6470,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a26, "HP Victus 16-d1xxx (MB 8A26)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a28, "HP Envy 13", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a29, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


