Return-Path: <stable+bounces-53828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8690E908
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7921F22A9B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2F1369AC;
	Wed, 19 Jun 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9CkMy+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1B136657;
	Wed, 19 Jun 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795472; cv=none; b=lNUE8R0VXdKrflrhcDW2mbA7O3onHUNsRs68aE0eORQKMxjYLEA+U7AmFNX2VnaK6QqM7A1IgiS6AZD9+4DCY5Gh7VLYBcYX0h3dVzOkh9uW+XIt49llyrFFkzMgNWMf/1M5BfsKQpQFirTqSHXCtS+7oJ3lpOyeZsCnBc118kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795472; c=relaxed/simple;
	bh=qu/6XJuVrIq1Rby1Rnvig3vrO5OB9OEs0ydj0+XBU1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QEmvYiHDBbidkPPrjZY+3Z5t+fa8eLqxvPSqZQOGsaEhzPMb4j0hvm3+Bn1B5yHYKH9jfjRV7QMbEmlZz0ZYcYVDwwA0ucRtCdGlgIS2Lw+wzIbZSaxQfASc5hEbFnBx4zIn6u+hN0oIEvAQEl62AsYmj4HABlbuXPIdIMQE/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9CkMy+U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f275c7286so5758627f8f.2;
        Wed, 19 Jun 2024 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718795469; x=1719400269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUi8PJoQrIhJDe0DZMXJyq4ZXY0L5Yc5X576T+WDdbw=;
        b=K9CkMy+ULGx0PuJT4+gVa8upsI+yVRdLC4QTbmV18ietAnlvmAakvWoUdnPpL4/TQv
         9SE/xM8fmJ7DlvtybyD0LOHno87/0pOZDUM0EDi9m1jHABbYyfpk4QdPi3zZcmWwURec
         jPqvwBoh/G1fYhiN3yZUx6eudHta5inMKKUSYaloKW6Rbvy1Fo8Dm9DUDt/g4xSgzIeu
         S99aP6DOWFdVEHihClgYckSjlk0Dat2ym0H4e7/U0+29rvPvW8gn8Ed9OotpvqfBRfvk
         zb9JV7GJIMRvjphKNFlBMlpzTv1RNEb0bhuBcF/vR43WpQ+ShZ5QI3ueBXfDeR6iOCvP
         LUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795469; x=1719400269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUi8PJoQrIhJDe0DZMXJyq4ZXY0L5Yc5X576T+WDdbw=;
        b=NJSUa1qIE8R0+ntUECXKF30prYZRIsoz9St4HWeA6b1oLaOjlGSKbuBoM9aJSlcs2f
         LjeDHoMkB/ElW2p8hxupDxQuoMHaTWKXwY4+LIx8zxtvIYzglYZAT9jeAS/T+8YglbHz
         cdMc6TMac7WJNUjYFKFuofk39j88wctGmxcccqMpIZeVY/qR3b+LA4xospkzUkKEPtue
         iJSZcWXlM8sND2dtiaSAXm2epNeT3ucjet3OhsUe1kmTuxWNCRoHEWdI0CMUOVQ9ldyQ
         NEqPROOKAK7qTaaEaAQJ2NJw90YiC8hU92nryw48ros8+r7ohKq1JifgQ9LHtU07t60+
         o1Yg==
X-Gm-Message-State: AOJu0YxOwO0ysFnURqYByRAobcJwIaEA60o4pshV+uIVBRpcP0/UL2qK
	8r63uPcaxGy59GN8I2yArj4CvBwCvVyYnwZBXrK8pjsGms8sd4E6/u1NoNyYu3U=
X-Google-Smtp-Source: AGHT+IGuVipVwnEXUszWur3qCZRffHrEigsB1Ut5ZhbSDF0a7CCuGyPhAOgI3NUc+o7EJt8m6Eh73g==
X-Received: by 2002:a5d:4563:0:b0:362:590c:84cf with SMTP id ffacd0b85a97d-363177a3caemr1649024f8f.24.1718795468837;
        Wed, 19 Jun 2024 04:11:08 -0700 (PDT)
Received: from fedora.. (cpdnat87.usal.es. [212.128.135.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c707sm16962838f8f.36.2024.06.19.04.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:11:08 -0700 (PDT)
From: =?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
To: linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org,
	tiwai@suse.de,
	=?UTF-8?q?Pablo=20Ca=C3=B1o?= <pablocpascual@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
Date: Wed, 19 Jun 2024 13:11:05 +0200
Message-ID: <20240619111105.34300-1-pablocpascual@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20231207182035.30248-1-tiwai@suse.de/
Signed-off-by: Pablo Caño <pablocpascual@gmail.com>
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


