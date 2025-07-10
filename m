Return-Path: <stable+bounces-161572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218FB00368
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B11883C01
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D52586C8;
	Thu, 10 Jul 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="G4yE/SNL";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="TusmlQ2g"
X-Original-To: stable@vger.kernel.org
Received: from e3i282.smtp2go.com (e3i282.smtp2go.com [158.120.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCD82899
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154423; cv=none; b=GOKxoeOkUqdtqX7b+91bCY6Ckj3kKXYIf6H8C/mFe6GYXdTKXVtk/qFq00xRoYpAoawshk3LXPmzSrzTBTNK5zxBs0PMzW8/wahnn1LNuu8b6eQFjSU9w+daITLtU3uXL/ryeOj9o8NZrVn3s2yemut/RkhJjHGO6m9gkUS0gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154423; c=relaxed/simple;
	bh=M7l6/QLIPUoglGrfdye4yiQdtH9sXmYpR0Yv55tKrto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5IA60oA4LYmQUYQFZdolClbhnyYIMnJRoSczCdZJgkQbDiW0ndK1owBg7RPZpiC3srE2ZsMuyJd0+tu68Tuc1P4onAkopuCx46ju9tPZJVZg49Zq/WmlM9NGZBG0uCLBrioD6qfTR8RDtAUft3fcx37ja4NnbPjetfhDlpuMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=G4yE/SNL; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=TusmlQ2g; arc=none smtp.client-ip=158.120.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752153510; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=vsPjCCPZRDftl844wyMwpzELOqTezWUQYA1LB69ZyMk=;
 b=G4yE/SNLr8BAGcqjHtH6mlmaIwPLpe5OKf69q9OyYF6HlhnmlpT5pcA1i2s9XlQzhDrUe
 SyfyVWrVjH1IRCr72LCYI8vuCAJOulfgSlI8GV5lw50aajUid1DudOR+LkTvcnZ6QfUPdZz
 K88zoXMTI0RTqENkMF7bhZfRV5dQ2B8n2HHqmcAtc1PKe5cpu3Vd6phGaqHFu2QgFdGh8hT
 7P1RznjoO1GiypucrMlAkbgrdYLWKFQOtJtCNNuENQg4PRCfDd/2NZxU/FW0GIscdit5/Pe
 Cik9mBwBfJrLy81jWIzBrzvvUrquVT/Ay6du/hT6eaG1LU+O74lxOUsYcIwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1752153510; h=from : subject :
 to : message-id : date;
 bh=vsPjCCPZRDftl844wyMwpzELOqTezWUQYA1LB69ZyMk=;
 b=TusmlQ2gjfXqE9TlbIih8sKHnhk2eaf5LjNnVBYqv5MWxlgv0CMse27WKCZ+ckgdVP9OI
 f1BT+IcQQ4yIHuwCTfoJSAz2V6uIeZqFeK1X+fb9OaEO9XnSueKSenrhkbnT1dO3fxOOiwx
 VNSKyMIIfeAT0nI/8sZYXZuBszJoFdzbn67Qwan8eAOncjEXdevl0JsaDvDF7byktt4zSu7
 Yvx44DzCFLWh6dgZu13Y/KjISNfYXzxXoHKzQx+rbcZ7Er8icEohaOyJeXDwSetOUrKZrgY
 yn384jefVLRHsEVer6GSCWV70evGdgBAXPDUTe/zuyAbJ9GUZpoJgKwgBglA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uZrAQ-4o5NDgrsm8D-h6lg;
	Thu, 10 Jul 2025 13:18:26 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx
Date: Thu, 10 Jul 2025 16:18:12 +0300
Message-ID: <20250710131812.27509-1-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sasdnPZ66u
X-smtpcorp-track: bcK5NAWFqeUd.3SthsYtiPHjZ.6u2eHgbJvIn

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on Victus 16-r0xxx Laptop. The LED behaviour works
as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 060db37ea..132cef8fa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10814,6 +10814,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


