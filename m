Return-Path: <stable+bounces-81217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527849926BA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B031C22250
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44D188728;
	Mon,  7 Oct 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3NP2d2e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA7125BA;
	Mon,  7 Oct 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288760; cv=none; b=YvZzzx3XP06xF242HRbtmzvHjI9fNBvlM0tMvxiZj74S9rPV05NPobsN5Yq5EYPhWUc/JQV5fM81Si4eGpVL+i8jQ7OY5nB5mS/JvQ86rcLYbGQYcQDEu2AY2LP+IUH6DsZBgpVyLLuJbrz2r0n5hO+t15ljfWdfVUZFEU5Khxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288760; c=relaxed/simple;
	bh=DQVwkoRIgL8UJm8NCB27MRhflsVRuGICAaTNssZviZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g4EW40h+CZFyf4sW75b2cKq3H9FtztgrwjDDfP/ZCZmtsHiMdOIxfo2Kxu//AiGjL8suPXRJNkEw0XMW8nOF+1odW+mJAJcjFRUfbph4Ok3sfUtf2btDUZTX93M7ThBAQfQxi0/hXjfCZVWw/y/c+tcyR/Yl0vEIFPH7CdK4g8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3NP2d2e; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so5964200a12.2;
        Mon, 07 Oct 2024 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728288757; x=1728893557; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bP7+WnRgKS8Y9xY8Z0wXxP8X7E8K6aXgN1VH5WOGnLs=;
        b=A3NP2d2e79Qy/IiMBFUImdwof9y6MxpJAMpEXjN6RcGMVxIO5Yi9jXmSgxsxhYpYh8
         TDz/Gt1mIa85IMpV3INPG2RuRtqoGXBZnDlMSUj3J9WtfcOtNKGggCCshUZu8iqDsrYk
         OQOvjWoA6ZVF1F+IzkX/DK/EcdoXrhh5ZTVZUocoHIo4NaHpn8Zoqc063fDAuT3SVFB3
         UFLfO6o7FghQ4YtpvarFU/tvAC5ouhHqjkMeSl6L0MT4xlzFTTdD4PJMWupoPsbkk4qS
         UyD7uAjN+qqLoPVjMpB1QCDZFnK/Gp72jkwC6EjWvc4gyH1fT2z+vQOvzXCMDqmyKHs6
         KdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728288757; x=1728893557;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP7+WnRgKS8Y9xY8Z0wXxP8X7E8K6aXgN1VH5WOGnLs=;
        b=XnTdLritn6d4csEOMApiT4mMmIBR8HZGjNRJNG59bq3Xceeplz3URjtIaHtTZ2de6C
         nF1sAg70QLK74JpjmIPsWg1dLHoTZ1675O/QlZwaQWSZZQX7W/QlxnziJQaJo+e6rDPO
         P/Pcr6PknWtkx11NgEChSzMUc831aXyVjHsxuAN4oZAxX186A9gJULirjhRLyDlQejmC
         UvJxBhFKhoq8p7HkSN1Q0gTWCf/O5bMGVPyKdG+35yA90yrQsPu3Q6W4gG7NYwvHd4z2
         Zy02bsvG1K+Sdh+u4umaXy5KF1okkyqBFGgQiCL35jlDNvWC3EzUK7MckKpOicTGrmBK
         TJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjmkOjophMx4wKJt7XI6slhH0iBq4IxXn5Qk/4eUSya4HQ5wOqwhZ9G1A6IpnBcpjh6wm+umIt@vger.kernel.org, AJvYcCX6fE0LGjTB7ly7bUOZrbfZfUN5y5PPEXvElaJiY1rOawDem5MIrekUb2nW524hdEj1TRjAMlp4T8iYGwE=@vger.kernel.org, AJvYcCXiItGVIK7D8sOAPIR0glEY+ZzQ7qOJQVAJgjyFCBNIQA7PFyQs3GegEjsib1IvPIkSUUkkT5gqL3rp12c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQF8QT4B2gKVLp1bipb2eNVI6bin0AD2xXMyn0TrGUA9KqIVl
	4EB0B/i/lrtbptZI11U4VbQHqOnbjCKaRWZPxR5B5iqo09GBadSu
X-Google-Smtp-Source: AGHT+IEykYxqXoYAhLTiaAatQMKb3ZNjmkzBVWNHk/YhG+9R7BMikzWwvtQyBjYx7/diRhDrQmslhw==
X-Received: by 2002:a17:907:3e13:b0:a99:3ed0:58ad with SMTP id a640c23a62f3a-a993ed0b560mr698403966b.64.1728288757385;
        Mon, 07 Oct 2024 01:12:37 -0700 (PDT)
Received: from [127.0.1.1] (83-215-114-114.dyn.cablelink.at. [83.215.114.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994d5745e2sm173661866b.23.2024.10.07.01.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:12:37 -0700 (PDT)
From: Benjamin Bara <bbara93@gmail.com>
Date: Mon, 07 Oct 2024 10:12:30 +0200
Subject: [PATCH] Revert "ASoC: tegra: machine: Handle component name
 prefix"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-tegra-dapm-v1-1-bede7983fa76@skidata.com>
X-B4-Tracking: v=1; b=H4sIAO2XA2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNz3ZLU9KJE3ZTEglzd1DRLM8skizRzM6NEJaCGgqLUtMwKsGHRsbW
 1AI4oEGZcAAAA
X-Change-ID: 20241007-tegra-dapm-ef969b8f762a
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Bara <benjamin.bara@skidata.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

From: Benjamin Bara <benjamin.bara@skidata.com>

This reverts commit f82eb06a40c86c9a82537e956de401d497203d3a.

Tegra is adding the DAPM of the respective widgets directly to the card
and therefore the DAPM has no component. Without the component, the
precondition for snd_soc_dapm_to_component() fails, which results in
undefined behavior. Use the old implementation, as we cannot have a
prefix without component.

Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
Original Link:
https://lore.kernel.org/all/20231023095428.166563-18-krzysztof.kozlowski@linaro.org/
---
 sound/soc/tegra/tegra_asoc_machine.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 775ce433fdbfdbcff4d09d078dbb0e65c0b15b60..bc16f805f52c41d6cb983380ee0ac40944531e52 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -81,23 +81,19 @@ static int tegra_machine_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct tegra_machine *machine = snd_soc_card_get_drvdata(dapm->card);
 
-	if (!snd_soc_dapm_widget_name_cmp(w, "Int Spk") ||
-	    !snd_soc_dapm_widget_name_cmp(w, "Speakers"))
+	if (!strcmp(w->name, "Int Spk") || !strcmp(w->name, "Speakers"))
 		gpiod_set_value_cansleep(machine->gpiod_spkr_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!snd_soc_dapm_widget_name_cmp(w, "Mic Jack") ||
-	    !snd_soc_dapm_widget_name_cmp(w, "Headset Mic"))
+	if (!strcmp(w->name, "Mic Jack") || !strcmp(w->name, "Headset Mic"))
 		gpiod_set_value_cansleep(machine->gpiod_ext_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!snd_soc_dapm_widget_name_cmp(w, "Int Mic") ||
-	    !snd_soc_dapm_widget_name_cmp(w, "Internal Mic 2"))
+	if (!strcmp(w->name, "Int Mic") || !strcmp(w->name, "Internal Mic 2"))
 		gpiod_set_value_cansleep(machine->gpiod_int_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!snd_soc_dapm_widget_name_cmp(w, "Headphone") ||
-	    !snd_soc_dapm_widget_name_cmp(w, "Headphone Jack"))
+	if (!strcmp(w->name, "Headphone") || !strcmp(w->name, "Headphone Jack"))
 		gpiod_set_value_cansleep(machine->gpiod_hp_mute,
 					 !SND_SOC_DAPM_EVENT_ON(event));
 

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241007-tegra-dapm-ef969b8f762a

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>


