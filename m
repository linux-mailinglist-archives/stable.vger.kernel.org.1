Return-Path: <stable+bounces-163304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F3B09672
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074E94E35C0
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2A2264AE;
	Thu, 17 Jul 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="LY53013X";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="ERkrhQUn"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFE1FCD1F
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788557; cv=none; b=bJ1Oz5cgRUx3KaLacIHBEoi1xXtr5Jdx8A0Dsudgaz6HOhBmPPDt0SlqYTu5JqEikGByUzyclbZttmgFLqN2HSfqawcyV7qAAzPDAjHJmFK1ezno3hrhklieMkwxJHYQUSvHTTfx0JDnEZ8HryGLze1xkevUg6CLaL1OZBd6ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788557; c=relaxed/simple;
	bh=mrddjCmvTYA6t5LbBy2FRPclddGvQ0AOTV6IHAyiYqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKDf5sQ2bRR/M2/b4Eylc52XO4z6AoQG91ujoPs2i63RYKPP7Ttm2umOwu35W/sSXuagTNgnPPdqjBYdWgJ/RCc9RcRlf3pOqgHvtpMNjiiXbhLwQASb8xnLG+tw4uzZpYENtZ1jHhUbtE6v0f1m639ytUshvmDE1LykZCjW/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=LY53013X; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=ERkrhQUn; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752787644; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Gfv0VoGpjGNOQhpz6loWxFeC3SOK7lyMb9kShZPEDbc=;
 b=LY53013XBvG4ccajQv7vtQji55D96VMmhyb3N0/NyNVHAcz39x48xXaM1TAuzwxhZ2jDw
 Bu+ESMP74PTLeA1whbHv79hmRTLBDdBnfSOWID2bUjn+jCAmjLXr94uTU5qcpdYO2u2aG8m
 SDOwgZT08+gLiZSCPGiCEezkY1r/ndr3Ln3zg/dIHbfpyxpRY4IwOWWeh9JEv2CNpkmVPuD
 eYvKMZKS77aHdeZGCbJBIn7258WbzQfuUEEtFAKmpnZZPepr26qABTC2KzfSy1Y6vSUsohx
 MkeGSELxEmd3aVjFfnYDxSmsKmGdWNJwo2tpz62CFKwjsyt9ftanY7p3nHwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1752787644; h=from : subject :
 to : message-id : date;
 bh=Gfv0VoGpjGNOQhpz6loWxFeC3SOK7lyMb9kShZPEDbc=;
 b=ERkrhQUnfnajPFOQ1yIq+SL29Q4r5dr309chEhJbLniTPLdC0qRaaCd4SLdM/dlhY4MMx
 NZ5j2Xnq32o0r16+bETiIRHJygJXlU9jDzOnLbpcGd7IzZVwSE7GnftjIR1WA/Yszg+xAwD
 LZaoBmGQz6OnlY3mgPdj10Rwdi3dzkpmojYJcNcoNelv+DfeXrx2OwpKapw93NaBZXGU5s6
 ldYn7UE7F+lplh6dIZ20/F6/tWPIyBbeeQDvq/QxhO4MQaCzTruvyNPDse/oI7y8NclAolK
 SjWZYpOOUbbMhfJqOlcx+9lR5fl3DHbILwBbL4LxdBdFaD6EC6pgIDk3jlXw==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ucW8O-FnQW0hPoI3G-gXXB;
	Thu, 17 Jul 2025 21:27:20 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa0xxx
Date: Fri, 18 Jul 2025 00:26:26 +0300
Message-ID: <20250717212625.366026-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854supEO3aMoK
X-smtpcorp-track: CmkOden_mKP5.onXYv1lHKpNa.2xmTNg3CmA9

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on my Victus 15-fa0xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37ea..5cac18cff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10769,6 +10769,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
-- 
2.50.1


