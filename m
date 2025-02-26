Return-Path: <stable+bounces-119674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE9EA4616B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817983AD042
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F921E0BC;
	Wed, 26 Feb 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K05hIEVf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1622EE5;
	Wed, 26 Feb 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578210; cv=none; b=VioS7ibbhBcNlJaAT/vpyxRo/0snDhhqNuOZp5OhNnLGoo3jZmYWEnEmPntUWDZRqEwJhjiG8pL0/HRbgoFp8Sdx+J4PpR5ITA1NXeSXNuodzWWeCAuivf6nEVAc9vFX1OjaNhsfnEa+BM9lT+O4pFokzmmNorK6FBc04Hp0vOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578210; c=relaxed/simple;
	bh=xLApNdjWQ4KRERmyEa8v+pqECrHbj6oX7g6m845DTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PWzBo7nmlShWq3lRU0bPVV8CS7eXT7AZJsxn0T87ZMMWdmFLVd5nsL/1Gvs/ygFZuZNjgu03Ez4x1Oa+bdK+JzgahHPLx+4z3UB2xMqrjAvUWXBd/cs6X12V6FUistE9JpzowUBzB5uwYtxL6H4YJuvdCuYcxEcSc5JKftKm54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K05hIEVf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso43432245e9.0;
        Wed, 26 Feb 2025 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740578207; x=1741183007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLBcLYAUEEJtPk7aexes/iel8Kg1Zz6U1ofbl7NXVd8=;
        b=K05hIEVfTOfo2CC3VlQCR5Pmntwe+za7/fcBKUkj+zghKEc8RArg7mF7N4FQfYv1qQ
         KFchXByGZT4hIqRuzw1B7wXJbIShX+tulWRfGN9+rYPmTsXrbszX6hIJzWWg1T7rJI13
         +yvsT1EjrMXLvuwqAgANNWlyeu0dBf1wxBjr6JQht7k6ktw4d1bSfrkvx3kObMfhEpfa
         9opNlXp+W7nwRNW8qHSCzFrYMQHzjO0oHM8C4TOBuwlSQ/dJN4QgBaK5iacqW8bM01g7
         pY7DDbfXscDcnSGJEvPxZ5d2s8V4oCrDy66AawObCJuKkmRbrWbiKhF3nrj1KQI4vFB0
         0Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578207; x=1741183007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLBcLYAUEEJtPk7aexes/iel8Kg1Zz6U1ofbl7NXVd8=;
        b=W6aIaZrJw/5/lpyRXVk3wmPxE/kX7mBZLo58hMTClY6dulrk0DHv8AMa9SH1ekYXRu
         OLPQjSLgkfmXwmuN44J9L+Iq/RAQEpjHwGFeluzMJ42Y018NHUubxzblyZvZg0yP9xK/
         eeLfdY/mgh5KVoqnCaXKF76oO60XJwGWkXqQb7GeOyS03xV1MQPLtfrsjlyI1129d9Ma
         xAxpdOulXCLqFqIrrpmlwMNndvKZ0camNlg7WA+xcEDj0fEY88ORGZ0w5XubqZVvZosP
         H1kLLwO6S5ZBmN8+pqGO38qbUTEO3Hb/I+jpI0cJ/P7n/6St3ptJQsfFoVPpCDcAQ/ZN
         a66A==
X-Forwarded-Encrypted: i=1; AJvYcCWXRehgAGh3IQz1j6bp8IVdqEMf4YthG/GKrQDGJJTi/gnQb47Bmjm4JsModbCycv7QyRu0t8Wg@vger.kernel.org, AJvYcCXDaxspQTbfQ8CdDWAmf5n+5TjME5i4bQBvkZJ9HCCTB4hwHCe8Hc/heVYgid3EYCA5wDM4gA2YPlBD+Ok=@vger.kernel.org, AJvYcCXp/TKbmHtkwgY59EcFdAyVJdLpQn7nw1QiYr/GUE9OSIPLDGHyi6YQuiTUcF3nZONtw/DbWBNcYviwWGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxre3713GRj31KaHM6UNyTUJb2fQKM8qtG8KTBfdbmDFr1zyijU
	9CsHy777RV/cr8b4mXS+uTTVFPh372fXX0V4/y7NGbpst1hzjcwB
X-Gm-Gg: ASbGncvPj1v9H6euUbjfjOEAdWXvrjBrEQBQPTxElMTOsQT5TbMk6gTTI8+gEB2H8Re
	rJFQWYLqd67OAiHESg6wHZvfMTsQpbsZEQw4NKn3f3hP/INrHGzGVwadvUegqP2jcvlskEasjsH
	jtgS8CTILE89/qTz2bd6pIMvrRo6q81kUJcsu1b9wD30ilq59zIY7xmQyHMFZJuDur0wt/Ei42w
	jUFstkeLTfKCijdEoxLgCWGjFSlxdR7eAPBOx7wR1dRxMfprNmCz8xc2A3Gmh+FqJb+qVKt6Qco
	hUcrQK5nZPnVW7Zv5u7A++JnUkXnwtHWGox0ODeswTaVxZ9ilHugnH4iQU4a/hyDXz5tx9AoqBS
	YaA==
X-Google-Smtp-Source: AGHT+IEcaG42hm1M4DeIg13bxZaCubKXi8JgmCH5B4XKyuqtjyyh+TfBNwfNvKbUqdkw6bzG+yKHrA==
X-Received: by 2002:a05:600c:1ca7:b0:439:8185:4ad3 with SMTP id 5b1f17b1804b1-43ab0f72b36mr58211405e9.27.1740578207163;
        Wed, 26 Feb 2025 05:56:47 -0800 (PST)
Received: from localhost.localdomain (211.252.11.109.rev.sfr.net. [109.11.252.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532d86sm23088645e9.14.2025.02.26.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:56:46 -0800 (PST)
From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	=?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix microphone regression on ASUS N705UD
Date: Wed, 26 Feb 2025 14:55:15 +0100
Message-ID: <20250226135515.24219-1-adrienverge@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes a regression introduced a few weeks ago in stable kernels
6.12.14 and 6.13.3. The internal microphone on ASUS Vivobook N705UD /
X705UD laptops is broken: the microphone appears in userspace (e.g.
Gnome settings) but no sound is detected.
I bisected it to commit 3b4309546b48 ("ALSA: hda: Fix headset detection
failure due to unstable sort").

I figured out the cause:
1. The initial pins enabled for the ALC256 driver are:
       cfg->inputs == {
         { pin=0x19, type=AUTO_PIN_MIC,
           is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x1a, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
2. Since 2017 and commits c1732ede5e8 ("ALSA: hda/realtek - Fix headset
   and mic on several ASUS laptops with ALC256") and 28e8af8a163 ("ALSA:
   hda/realtek: Fix mic and headset jack sense on ASUS X705UD"), the
   quirk ALC256_FIXUP_ASUS_MIC is also applied to ASUS X705UD / N705UD
   laptops.
   This added another internal microphone on pin 0x13:
       cfg->inputs == {
         { pin=0x13, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x19, type=AUTO_PIN_MIC,
           is_headset_mic=1, is_headphone_mic=0, has_boost_on_pin=1 },
         { pin=0x1a, type=AUTO_PIN_MIC,
           is_headset_mic=0, is_headphone_mic=0, has_boost_on_pin=1 } }
   I don't know what this pin 0x13 corresponds to. To the best of my
   knowledge, these laptops have only one internal microphone.
3. Before 2025 and commit 3b4309546b48 ("ALSA: hda: Fix headset
   detection failure due to unstable sort"), the sort function would let
   the microphone of pin 0x1a (the working one) *before* the microphone
   of pin 0x13 (the phantom one).
4. After this commit 3b4309546b48, the fixed sort function puts the
   working microphone (pin 0x1a) *after* the phantom one (pin 0x13). As
   a result, no sound is detected anymore.

It looks like the quirk ALC256_FIXUP_ASUS_MIC is not needed anymore for
ASUS Vivobook X705UD / N705UD laptops. Without it, everything works
fine:
- the internal microphone is detected and records actual sound,
- plugging in a jack headset is detected and can record actual sound
  with it,
- unplugging the jack headset makes the system go back to internal
  microphone and can record actual sound.

Cc: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Chris Chiu <chris.chiu@canonical.com>
Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Tested-by: Adrien Vergé <adrienverge@gmail.com>
Signed-off-by: Adrien Vergé <adrienverge@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 224616fbec4f..456dfa2b4b4b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10656,7 +10656,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


