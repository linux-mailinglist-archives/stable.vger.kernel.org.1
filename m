Return-Path: <stable+bounces-194955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A892AC64054
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21D55341BDB
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4D287507;
	Mon, 17 Nov 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="qfaA63eN"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3D24729A;
	Mon, 17 Nov 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382071; cv=none; b=asgKnJA+aLETzz+EBXNEF/sQk353O1+bjWapOyqkEJOIj0/dMmsa6ufUHC1xmyVoP2Z5ZzcrkaBuJDVG6BZzm/p5g7glkZwLDy14j2/VANiEwH1dkTmSpF+AhbOVuWSYlqKLPhqA6i9wR4Sh0AFHWrZVf0uAQeGQAWRj+VgO02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382071; c=relaxed/simple;
	bh=8jKSmHS95dTjMHcoA/Eb57z/ZXmfWP4rEHKQBz7NL/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XC0Tr+g/2+I5OHial1bacPl4QnzjYhxqj7dyvyetIecKeRyjaHyqJjXKYPTQM2RmJEJsHbAVDtEkdfB/fK9TRmWqyAwdNaPrtxC3v+G+MDomvb47q2xMPhGsh4oBi9zTXnuQrqECmU1OhJSCVQy/aucRoJ+gK0VdSnx5Huf/0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=qfaA63eN; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1763381597;
	bh=8jKSmHS95dTjMHcoA/Eb57z/ZXmfWP4rEHKQBz7NL/4=;
	h=From:To:Cc:Subject:Date:From;
	b=qfaA63eNAJYYM9xQs3iOT6xtmtSWOvaSsWL/+GqRlXj3eUhRJZ1hVtjSiIYJm/sAQ
	 EDaviV/fLJ3bXVjUFpXAtxiqVOm5GWrfAktw3xDImb6Re420uPOyET3ntPWx361Onj
	 TfcgiFDi0xCV6q+5mlEpwlClL4zJSfYKM5Hm4wTgBlVjOMbOMH8APhTCXvjBcz/a/9
	 eAPqb8q8Rzk9tMkfNao/PCFa08hLuR9W6pHPoxsI3bMgHZfOXg4YNFGJo0zUnj3S+s
	 TflmoxGOesK4aU24Nkdv1VWnNWmcwV311kKs7PAyUfI7QPRafVMoXY7qTzj2+foHxe
	 JLmYgqfjkCiuA==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id D9C3C1FA5B;
	Mon, 17 Nov 2025 15:13:17 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Mon, 17 Nov 2025 15:13:13 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru.astracloud.ru (rbta-msk-lt-302690.astralinux.ru [10.198.51.247])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4d967q3y9JzSgqV;
	Mon, 17 Nov 2025 15:12:38 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jaska Uimonen <jaska.uimonen@intel.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10] ASoC: SOF: Intel: hda: Fix potential buffer overflow by snprintf()
Date: Mon, 17 Nov 2025 15:12:03 +0300
Message-Id: <20251117121203.9811-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/17 11:46:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: adiupina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 76 0.3.76 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198143 [Nov 17 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/17 08:57:00 #27937168
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/17 11:47:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Takashi Iwai <tiwai@suse.de>

commit 94c1ceb043c1a002de9649bb630c8e8347645982 upstream.

snprintf() returns the would-be-filled size when the string overflows
the given buffer size, hence using this value may result in the buffer
overflow (although it's unrealistic).

This patch replaces with a safer version, scnprintf() for papering
over such a potential issue.

Fixes: 29c8e4398f02 ("ASoC: SOF: Intel: hda: add extended rom status dump to error log")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20220801165420.25978-4-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
Backport fix for CVE-2022-50050
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b4cc72483137..1d879c2b81e1 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -437,7 +437,7 @@ static void hda_dsp_dump_ext_rom_status(struct snd_sof_dev *sdev)
 
 	for (i = 0; i < HDA_EXT_ROM_STATUS_SIZE; i++) {
 		value = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_SRAM_REG_ROM_STATUS + i * 0x4);
-		len += snprintf(msg + len, sizeof(msg) - len, " 0x%x", value);
+		len += scnprintf(msg + len, sizeof(msg) - len, " 0x%x", value);
 	}
 
 	sof_dev_dbg_or_err(sdev->dev, hda->boot_iteration == HDA_FW_BOOT_ATTEMPTS,
-- 
2.30.2


