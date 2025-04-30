Return-Path: <stable+bounces-139119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6161AA4571
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3918E3A7B41
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57B21B9C2;
	Wed, 30 Apr 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="OiO2CgW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A84217734
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001730; cv=none; b=nYl49l/9a73Xd2K7FUT+f3H1ZKl/68xjK9u6R1Mg3DuC1M/3wuYTAs7aQca46tiGv/m8hrOGq8wgx7nG9dBgIvy2FUCMXooTMSd7CvkxU8ZTEC3sRR0K0WQ5qBHrqp9QmO5TXuqsfGpuhzxD+Wu9uN52yhIWvJ0t+RLM2SFaz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001730; c=relaxed/simple;
	bh=pH0oqBFzXr7dxaa6fyvrd+LLrjaVdoyq6r4ZmuQseF0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AaRkEsA4zwHoSkgk4zss0WnzYfBq1k4lbezGwMxPCcoIWBfZjBU38CPRGRjDN6uVrgQhFVBcCTp9XSzTZxu6cnipPECZRnWVo+AqFWPXxU61D+Kf/l+mEZRNzMbaYTkAGzezViQjxmfD7iZ8SnGJhXFGDxu1Qmn1Ro0UIBFi+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=OiO2CgW8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3106217268dso65748471fa.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1746001726; x=1746606526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6lPqXLo5Wb4FjmQISWv1/W8649m7XVXX1Bcf7rCMT1I=;
        b=OiO2CgW8iu5CCKeSmS3PlKZ+n3xjB4FpmGZ/szRw0QJi8A+YcL0FYUJrTLEgosdX4F
         d2jIHVcqMDFx8tXKCMTNLxGOgHXxJzDe1Lu5A+HD3aOZY2YteujoRH75Q6yRlSADpr7D
         FVLvx40vp6KiwdNYybuP9Ljyfgcf+knyPL9/g0CFVT89u3k15c5uis1NnJR4mUXlSJko
         zeE595klz/aoX3G/7dxfmk/okb1P8e+2elx9oIXR/mq9UO4aBbBncJUmdhGS9w45ZlXo
         EuU2szghJEATSCEJv63JZTzcijBR1Lt3hkO0CBfuP4aaNjdxIZd+FPqtMVe6/dGanA2S
         2EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001726; x=1746606526;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lPqXLo5Wb4FjmQISWv1/W8649m7XVXX1Bcf7rCMT1I=;
        b=YQWKjnOvhuERZVFH5q91ONuRubxDfWV+UBN8KTOWIOMXiX9Wg2PkRUfZ3Mp6ZqHVX3
         +N3Mw96f2NXrOlsx4h0tt5L5Fo61vxJLEreUK1/yndB55cOi4qCz3s37aR+TjLhKKC5X
         i5+LJOXcsAq8iuu3l5dZe1rVKQq7zUza0kx+TxaM/qiGqZ6f1k62XrVvZJ7iq0wyEhh5
         37b3ZZ4Za2AdBxy/SjfyE2L9UJHFxQ2zmEt8SwUPbOe57P5LEWJk8q0skw7XkOlnWDdK
         4PdjV1RyXWktTwNwiWDUBDjF/SefJoQO6eoD4nGa2iLLBM6DR5Svgr/FW83t39kF8Jba
         /PkA==
X-Forwarded-Encrypted: i=1; AJvYcCXzT7ujMxuMvgaQmO7buymxtxIPiDoNhv4fhOQhibvkgNYvnIyvTJorbo42FNJPsSNZ6dyLJXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiZ+GR7vyYubAU5AtVAmI/3ljydvLNMgw7Zd5KxqBG3+brmGn
	jzWeJzlN3oQuph0obalsuwo6Dx9708gGvL13eYFrPz9YJASzpX7c9n+KMQRh9ir0tKe4VI8aj+i
	xeYW/8iQP+YfpZLRMhsXUD/bV4iVWIgGqz5lr1A==
X-Gm-Gg: ASbGnctaDNN0+8kcp6+CibALE0lH1l18AJvlOL/xWYovJlPGjfd+znntR4vcZteTdRX
	/p+tqT9Oe1kSpeYvuM/U8ee4OSA2IoTb2DB21JJI2e/P/n+0/vRStzwgSEOZF8mMFS/BtbRyd2t
	KkRGwTSNhyOJCQQkT8txPIbwLYUAyOGFd2cO1Y
X-Google-Smtp-Source: AGHT+IHm9LGcwO5UfIgmOPoA/NZWU0YUuagpPN/FMkVDaPR9suXAlBToMbxCmPA+26NwR16zuoPZt7Fpu/vyInDHLes=
X-Received: by 2002:a05:651c:1542:b0:30b:ee78:79d2 with SMTP id
 38308e7fff4ca-31e6bb7963amr7026571fa.36.1746001726243; Wed, 30 Apr 2025
 01:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ezra Khuzadi <ekhuzadi@uci.edu>
Date: Wed, 30 Apr 2025 01:28:35 -0700
X-Gm-Features: ATxdqUHlLjGvyjp1aDqcwzw1xdWYY187ti4MPUlvYdIVpJ5MANTZwWt-gw4LJKI
Message-ID: <CAPXr0uxh0c_2b2-zJF=N8T6DfccfyvOQRX0X0VO24dS7YsxzzQ@mail.gmail.com>
Subject: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx

Add subsystem ID 0x86e5 for HP Spectre x360 15-eb0xxx so that
ALC285_FIXUP_HP_SPECTRE_X360_EB1 (GPIO amp-enable, mic-mute LED and
pinconfigs) is applied.

Tested on HP Spectre x360 15-eb0043dx (Vendor 0x10ec0285, Subsys 0x103c86e5)
with legacy HDA driver and hda-verb toggles:

  $ cat /proc/asound/card0/codec#0 \
      | sed -n -e '1,5p;/Vendor Id:/p;/Subsystem Id:/p'
  Codec: Realtek ALC285
  Vendor Id: 0x10ec0285
  Subsystem Id: 0x103c86e5

  $ dmesg | grep -i realtek
  [    5.828728] snd_hda_codec_realtek ehdaudio0D0: ALC285: picked fixup
        for PCI SSID 103c:86e5

Signed-off-by: Ezra Khuzadi <ekhuzadi@uci.edu>

---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 877137cb09ac..82ad105e7fa9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10563,6 +10563,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
   SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
+  SND_PCI_QUIRK(0x103c, 0x86e5, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),

