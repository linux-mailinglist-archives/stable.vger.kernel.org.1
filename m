Return-Path: <stable+bounces-169714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF5B27DAA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23AD7A5065
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F22FE043;
	Fri, 15 Aug 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6Ytgd+R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE62FDC38;
	Fri, 15 Aug 2025 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251914; cv=none; b=nXicTs1wqiW/Lcp2iMsq2gS7gAb1BYHDDOPWUBvtWOHBAzzWZUEwoSAMXqA2oy6F+CgsPsQAZK9sT0ZLPFVmdw44fk50UtnV6W4tFQNYiJ2iPH3CFyw8YKUF6IScE5JOiNJ6wBx661klVoPQGbdfB71KE9FsidQ7rvxVc3E+hNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251914; c=relaxed/simple;
	bh=T3fvT6cqiRtg8VkXda+nr0X098QvveYJ98jWMz10JgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6RcFC/yhpWi0OG/XG7LcAEky3dVaSW5x6S5rwH3ssHaLnu5xIpSMZ/YcpHwFMS2YghFmuUR/OvyKrMYn/Cixv62ifl0L+O3gsic//6pcWFEgVqgfEXdwxj8QU3jYQ2d+UJ9DkUFIYlkD1fehIcaX7LCm2gBGBYw6KxkLDpDVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6Ytgd+R; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb732eee6so319476966b.0;
        Fri, 15 Aug 2025 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755251911; x=1755856711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=defRDf7dOJ+KjDDaWE1Qxe1OYNCRXDIpIxdlBIOy/yQ=;
        b=C6Ytgd+RTzoK4wxN1W85RFVWH+UdNUIH616zV9t1j9T0SCLqPQIImCeynsg1hB4Pbb
         GWtCNCJ8rOjaPVfO2G/8Gay3m+IBDqqsquYGWPJdSVQQwYE8RdmnbsRSh9jkqR80laSB
         HxDY4sen4nXx3kPj0JXXN9z/bho6jj8TQxRMXyJOhMcpEBoBBzdxTMyX4xxoaHetXPJo
         tTLlpA5xAXnZ9u33dDwq8GYa7DuN/j3d7PgElpwLwk0WZI54+adW07oDKmuvcfudUG/G
         BFKO2FE/8XAm3wEK1cpp5op5UmW+Bw4hM3C17bGP5N7JR8OdfiNN1mcKs+ZCICEWiT1q
         OecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251911; x=1755856711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=defRDf7dOJ+KjDDaWE1Qxe1OYNCRXDIpIxdlBIOy/yQ=;
        b=VKhOxc9mv4RFxDIMMoNYWOaAMkuk+yE1eMjB0PlPICD6nXBFT9I4XxsQhcM2N60kjJ
         g8QXa/GrgRE37Yk/GGVTzaIWw2HgGGKH2oVuQ7BeQsDKLCmYON+4E7WM89qx1WSKlVIp
         1PkPxCoaDDQjbmzKLDBBOKoj3YlJ1u9BA8UZT4IqPjed2RXfwYTvn9IrmJtqHFrhoHVK
         2RQ8WaL7Sw9yXX9It7dtstc6stJ53aR32TnOGJVAVyUEO9NAlVzJXRQhMqqqrrKHwytA
         wANj3KCv87jPDhfhtYkFKorrA2uGuuzpGV/GIHkk7568wCftkQLoWjbBI3HtKS/xEKYb
         8QiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3zY9rE+t6wFjs6+S6EjwQb8DhTDOTcVN1W2l8X2CYpCYNd7OkReo+PHWQ+a7JG3dan5WKQU8w@vger.kernel.org, AJvYcCXJ8wlJ1TmHCevpbeaazrv1emU+KzF0/3luUjb2s3spsx8kXDN0hC8aQbuyeJgFNK3R4IAwvnnAiPHpydA=@vger.kernel.org, AJvYcCXLKhMbA4S63CIYZl300X4mrIQGyD7HzyORi7N5Sk0SzzYC2EpXhVpa2XOW2xLIghGRNTQR3mj4xgHQPG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySul3711GL72Cst5fIIekxEDywhSBe4nt7Itc7dhIZM8SDBTNh
	Y8WEu+4Ni6pf80UjsPVA8hxLRm4xV7RnhgaxkNN7Yu5KBZ8IUSB9Ee+2
X-Gm-Gg: ASbGncuJVP16uYYiPMYlCi8nU3KzEagGxwXpiLn9QDok4oANWjiP/rzOOw7gH8VNWwQ
	bBZMJGxcJI0zTVjRoolw5xPNX6QlqjLbhH1qQE9wRHh4KwYaMMSVCYPTMujZI8EeUj6h4Bf7Ps9
	xa6sYaNnOf+iPxz8CjrH/ju+nZK5sLO9U/e4IXY+QqKxiyyDnRE3F6LkrcQ3Hs6msMe1yUwK8fE
	LaUjYudr/1cNVkrr0NOE0WquUZTzWZ5V4oradN8uwQ/2VeR5ZEoBrXHH7SHwmbsrIfQkCg+Wt99
	DhTUFrs29BJ9zeEudokdlvLZPTkF9veFXbL1S11nrH3ugagAtZQAo5PH7yIjFpYDabNci1EygEO
	tsVAiTN/TDW94MCjIAB6zl/cPchM0rUKSAniut5Bbq2uq1YDii1LWrAnVQeEgsHrC77n2tzzAY8
	a8fQJD3cBBtR8=
X-Google-Smtp-Source: AGHT+IFVQzneXrv2zh8rAn9rwZO/YjjYao2qjx9GCbqCyb8eWubzJrNL+tLxC3FVmE6LOECxhvB5fQ==
X-Received: by 2002:a17:907:3e1a:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-afcdc1a3d54mr141098066b.20.1755251910891;
        Fri, 15 Aug 2025 02:58:30 -0700 (PDT)
Received: from evgeniy-hpelitebookx360830g6 (v1532649.hosted-by-vdsina.ru. [88.210.12.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d8asm112854766b.36.2025.08.15.02.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:58:30 -0700 (PDT)
From: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6
Date: Fri, 15 Aug 2025 12:58:14 +0300
Message-ID: <20250815095814.75845-1-evgeniyharchenko.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP EliteBook x360 830 G6 and HP EliteBook 830 G6 have
Realtek HDA codec ALC215. It needs the ALC285_FIXUP_HP_GPIO_LED
quirk to enable the mute LED.

Cc: <stable@vger.kernel.org>
Signed-off-by: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index e27a36e4e92a..bc82f48c69ce 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6368,6 +6368,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8548, "HP EliteBook x360 830 G6", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x854a, "HP EliteBook 830 G6", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.50.1


