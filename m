Return-Path: <stable+bounces-158810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351CBAEC185
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5F5649A0
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 20:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C092ECD35;
	Fri, 27 Jun 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="vi13Vr9N";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="lgZvdzfO"
X-Original-To: stable@vger.kernel.org
Received: from e3i282.smtp2go.com (e3i282.smtp2go.com [158.120.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F672ECD1F
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057519; cv=none; b=GdZdN0qhezP6nIPKWbE02b3gk/N6Yr+nNauOBNGIrEIkd31TFA+sdfUT+8pfGBM5buUWmv+lHnJdJEdxO4ENsmyducCbnq6ayXqhyjAB+NUwZm3lphRtrUWkEwbu6Bus0OFJ84ZtYG1k/SYxaGjSvAVeX1U0bxqzA/BbYTECJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057519; c=relaxed/simple;
	bh=hnIQiztxMqZWdOo1P+htuYxmTRJegAPaInqW5mKJO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDlSgA6UssyvwxtHNYH719LS4Z44mdwn8VT+kMqnH3wwXB4lAVzU2U6gsgIIOPxE64CGUgRoU5e9M+RFKUSGaho7lNKd9ylGzuMXDE/VPNqrMx7zpeyTbMNztVLpQHaEQl9VX/H18rrmYbITYlWBzXSy1vKXEkNUpT3LBTGDD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=vi13Vr9N; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=lgZvdzfO; arc=none smtp.client-ip=158.120.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1751056606; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=TqdWV7/vA1rvF4B46py+BIoi1Rg8y4mycuMpMH6ZDBQ=;
 b=vi13Vr9NPMhOKmLQi06MTgpuUftt1t+syJlMHZUTC7yzvSkr29I4GUqc5IHXvr45hsOSJ
 fLiP98DpSkVdBonH9nHtyJwLkPk6+ph6be8yI5SgzgUm1OItLTOg/H3IKMwIQXM7xXMxu8v
 qeEXSrDhURXLXb5EyYFAFPU0AlX0DICTmeOJ0jsDIcBO+kBqcbGS2kIFuzdHYy9EgobIaiH
 ni+MecjNLLnl165T67ZCbeU4yTeYzMI//6qc0nzolIbslIYhgh/dIWsy5TsE+Mabl8gjNMv
 IveO0b9XSQzyH5wMd64eMaKuqAiU26P+wHoeD25kv8hNUWng7R1kgZSDFWUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1751056606; h=from : subject :
 to : message-id : date;
 bh=TqdWV7/vA1rvF4B46py+BIoi1Rg8y4mycuMpMH6ZDBQ=;
 b=lgZvdzfO6aWTo0/NBKQAdrvxMrnCflDXCUWUgdxI7bl8PzDIYLTabWQpmsrtUHhNlqyci
 ZGTfdGcMdiPSByGW0+D31s93zM1Npvrs8oGvqUrYLNRrjur/6HCmNNVWX+a9nCU7I3Z+vLq
 5eujiU4mS7dzqqb0GaBI9fsTlGd3aY6KS1QFnk/uHE9GjblCu44hz888xWfgR2zymx8DS02
 gr51PcR5ySafAIm42Ei8PXSaNIa+HTOG3DizoWVK4GeuUgO1aBQuyY1kiUOIv/e7o/d6S0G
 YZ6XFIPDiWQ5Rb7br92oXAK2eO35HwPDsw3Q7BgskMJFAZWJWtRaT6ySTQiw==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uVFoO-FnQW0hPsXUs-39tC;
	Fri, 27 Jun 2025 20:36:41 +0000
From: edip@medip.dev
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fb2xxx
Date: Fri, 27 Jun 2025 23:34:16 +0300
Message-ID: <20250627203415.56785-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sS8hnAP156
X-smtpcorp-track: hqnQodpysGgN.LNQv72zjzQYz.38XRhQgJ60Z

From: Edip Hazuri <edip@medip.dev>

The mute led on this laptop is using ALC245 but requires a quirk to work
This patch enables the existing quirk for the device.

Tested on my friend's Victus 15-fb2xxx Laptop. The LED behaviour works as intended.

Cc: <stable@vger.kernel.org>
Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5d6d01ecf..a33e8a654 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10881,6 +10881,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d07, "HP Victus 15-fb2xxx (MB 8D07)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8d18, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 14 G12", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.50.0


