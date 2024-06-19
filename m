Return-Path: <stable+bounces-53822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17B90E8DC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8D51C212D5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8B132132;
	Wed, 19 Jun 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv0q9/h2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987E13211E;
	Wed, 19 Jun 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794779; cv=none; b=QQOi5eLLmY+T0agM+BtZHMBj7sNVlgHdZjYUGeS1mLiJXy6W+S7rmX4eoCvFntiZIYEvjhGGIC+PhYY9pcpJJZIq4V/7msPOWg8/U0JXEuRBOsml0E+Qh6fMBe3HaaxLqe6kQPIs+2n+vep7JI41k7TXJkE/JnBxo+ufCPY6Da8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794779; c=relaxed/simple;
	bh=BExqSwzjA+fciZYpFKo7ougXR8LWzOaXC2TldKO7j2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVqcs0jlV3AZCVUEl3GeocTuDJy4lkLZrNNqGOJJvDWb7E8yeB6oMvY3mK1vUYRmJh6V2xDxUzH/c26pjhv/Mw6Xl7lEF+NSqEzTe0AEuBLt+PYKEKysSieYGUAMPJofCNp8pCRB90eH6UF2qi8VlK02ZQW4b6qDCC0N9kbgmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv0q9/h2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cc148159dso2360318e87.0;
        Wed, 19 Jun 2024 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718794776; x=1719399576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqNPLNV/phq08wqrDpKBw62bWYUWvlN1FEBdphcgyZ8=;
        b=dv0q9/h24tqKsPri65ftAz3uMoluz6ddy0EA3qNT/o5YJqR3C0ZzALE+6CMSMxzmQV
         UhK7l4XX62IixoqNGL4T5c6142zQEF6/qhfOyGrwn6wpjtO/tYaGr1ulzsVCR+s5q3bw
         +2rIBmk+wDj3WLbRg2WGacgkpm4qkC9wPXQOkn5Dm21WRSCI5fkKo5or34FlvU+/2k0z
         2bC80V3lsO7W+RVsw0qvHwDnhtSIsKUtt48+KZ4hjWHyqWtmoRtZBD3uys+2hgUAltNP
         NouuE3MHA30hd64KX0bclsFpoV+T4KKqISQ5LGDFQ5yfgxpwlAmSBJyMPoktS3ldA9lB
         wIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794776; x=1719399576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqNPLNV/phq08wqrDpKBw62bWYUWvlN1FEBdphcgyZ8=;
        b=c/QdBs8F18+R2gbu4NeG3biU5SRnDw501vX0DK9Zxlq5sfvnVAaNSzUfmerVKy7Bdi
         4BoNVThpJz79GDTEBc16THb+LhI+DmD03pcyaoQUSlc45X7kLAuBWyHHS+m7J358Ol2Q
         An3P3YO0tBx5Nz/UVEwwktcJt5cGY414m3/XF9tdGVOgZ4WqYFgIGrFpBNcJ+sgS1Df1
         8sncdQPQ7iez6Flw8l8PFKwQFiwwV8KV12PbU1IrjbmXHoxcEL3mG99hrw2UAlzBKLKN
         g55H6JXIxA26iFLndJphaoICdDxBX/k5mybD2uz7iAwSrJYusNZhkUV3fOiTJZlK89Z6
         sf8g==
X-Gm-Message-State: AOJu0YydS42h4uFxh78+5eySLMvq/oCusx9o+ialsuoZFAkzxcaaMhkH
	mkmm+P5DSaqj3IqPg+0o0wAo1E2Rs5Js6AYKueCf8TDk72u6/GR3crmFSnDPE3w=
X-Google-Smtp-Source: AGHT+IERLNBeQ1AbPpPP7jOYcwoL68WBRtNt2+f3lA9xTCWJjg2eu2p5zzI0ylJsHcIgAgW4DZNlyw==
X-Received: by 2002:a05:6512:6c2:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ccaa881femr2046835e87.42.1718794776032;
        Wed, 19 Jun 2024 03:59:36 -0700 (PDT)
Received: from fedora.. (cpdnat87.usal.es. [212.128.135.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bd8sm224010455e9.32.2024.06.19.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:59:35 -0700 (PDT)
From: =?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
To: linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org,
	tiwai@suse.de,
	=?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
Date: Wed, 19 Jun 2024 12:59:32 +0200
Message-ID: <20240619105932.29124-1-pablocpascual@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.

---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..f9223fedf8e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10525,6 +10525,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3882, "Lenovo Yoga Pro 7 14APH8", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3891, "Lenovo Yoga Pro 7 14AHP9", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
-- 
2.45.2


