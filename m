Return-Path: <stable+bounces-136600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9724A9B14C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A484C1946240
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102A17A5BD;
	Thu, 24 Apr 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G80N5tvn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA95695
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505738; cv=none; b=BM5rUyQYIAUIuchHVeSDuF8tgRBoeRy+BYzCT5dDpR8qblrBfe6bZOMM1kBnAVHyFL+Oe1P0974GefsSqB9amtRSJ1ouPtCjr2rd9uz6KF7WlXsqC7do8iPSsE06wMlFrOkeiwvO+WBU8TAiN/JGRSMMVQU7NinMt+RjK7+9ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505738; c=relaxed/simple;
	bh=UHl+XX/F8hJZnBWFkUpJ38M7oDxoy6qRhuLkFMmJKk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I9PdI7n5mw04cy2BMMWQ3nicRzBV4+6WYy0Eqh2Q3NOPbhcYhUnxbFp2YC6keLxUurwUogUJS5Z2hkyhpmBcLi4FPWxcmlmSCgVTAb4v8wgVd0q2/gWV0ovtvCg4rM4Umb+A2OjvhDLiuWd/LIeVRMYYuuLvCe98lbCCch6ZWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G80N5tvn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac34257295dso191112166b.2
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505735; x=1746110535; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W/F26MRUEjSYB+z3kdF4iWIGCG+FK31/UPEd0LtuJHQ=;
        b=G80N5tvnk5d6OGX8PTlQiZc86vkDVeZTIeAIACgSxf9yq0qxIOFhx3HBUtJ+MUI3lB
         1uoApbjrnFdi0lL7AhrfWIA1BvfKN7dbRpvLGRZkHsf0KlhpmLgfCym4ebd9tguofxe6
         Xp4tPrgXSXSg4I2JcMTh4OY6vvTUY9fIl9ECE8SmNaqCEp9jJgu58D+/jo1ztsB3kX9i
         JNRvuZFunLbyQW/j/38CnxccCHzCPXTkKNvAVvFz6b8xONI2CcXMwgdPKLSWkAd00QqM
         3NCNBbvxxYxo6P9S0CLPNPZYlpptApe+tuWNDyYDCsPlzEm7ctPBD3+8fqZxYbX3XT9U
         YG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505735; x=1746110535;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/F26MRUEjSYB+z3kdF4iWIGCG+FK31/UPEd0LtuJHQ=;
        b=k0nbTOPErbYLFFi6Bds1wMhyByPPqjqGZnlXEmYn+OMz6rv6QNQNzmCQEakRysRETH
         L9712itvwnfXB/3dWUKnzCT2gvWim2elnaUgujmhJrBrqou/E/x+MESUQ37BJRnRYyeC
         +g3e01WGoeDnG1xPxOIFxKbV0qgZD8rwNPiQG6ei8oL6VFvo/+AkCTvYgPdY6OCzerZx
         OuDG7L13B/hSTdTUm+/Y0f7d977glt3OoJ9y7nNQmW90exuB6PmatkkGzGSEsONurKcz
         vbba+eaJ+Nb28cT19vjukWP6SynurRvlADDqr1ugRpOLIvibpy6vQSABpQHszKxhIoRf
         9gPg==
X-Gm-Message-State: AOJu0YyCyoLEX5wW6cfqrDB8vHCT9TyPYkIKmxyYRcb7LL9vSjCIHX+0
	LC9uM8WFxEF5XpqKBHn+KDEHumlH96Y/gdFT/L2CjHObCfe6dBKw
X-Gm-Gg: ASbGnctlrHN8gUzzI1C/sGHRlcq2myPfF1+BO3TZ4nQwnE55beOY2Hky02Ed3HGFF7q
	uWRTsZwdeTm/0ni6Iehgk2pjBbLZrDwWC8XU1khDcUVn6ZjGbqWsOimrpiWOlPOaZEt8jN3AIwi
	jjmhb2OKlU0BggnWRpyTFjjw3zt5TacxUplGNrHc04GsOsJLrpcABRwpqCuykV0mbDTQXpdiUXA
	62LeyKCvYhAZm9hpSp7+45Qm79upmO/MOoY29ZhEycREQaB9N19g2nLrMI0HpCSmQeOAGuOa9A8
	pVGfZ3TFxthvf1DQ/4q21vSe+eKnF6Ij925NFcMkjcjNDEtRM9upJbhP3l5B2BYxGHw1vLiYYg=
	=
X-Google-Smtp-Source: AGHT+IGIZ2w1oKuOSKkjzFDDnfQiJ0g/WuJIxWSl+vK3nC+p8SRn0TVSSWGGGrM7amN+jJOjykwbyQ==
X-Received: by 2002:a17:907:94d6:b0:ac7:3916:327d with SMTP id a640c23a62f3a-ace57429337mr257524566b.60.1745505734846;
        Thu, 24 Apr 2025 07:42:14 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59bbdf12sm116712266b.88.2025.04.24.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:42:14 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 79898BE2DE0; Thu, 24 Apr 2025 16:42:13 +0200 (CEST)
Date: Thu, 24 Apr 2025 16:42:13 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Subject: Please apply commit 8983dc1b66c0 ("ALSA: hda/realtek: Fix built-in
 mic on another ASUS VivoBook model") to v6.1.y (and v6.6.y)
Message-ID: <aApNxe237XfXGLS-@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

As per subject, can you please apply commit 8983dc1b66c0 ("ALSA:
hda/realtek: Fix built-in mic on another ASUS VivoBook model") to
v6.1.y?

The commit fixes 3b4309546b48 ("ALSA: hda: Fix headset detection
failure due to unstable sort"), which is in 6.14-rc1 *but* it got
backported to other stable series as well: 6.1.129, 6.6.78, 6.12.14
and 6.13.3.

While 8983dc1b66c0 got then backported down to 6.12.23, 6.13.11 and
and 6.14.2 it was not backported further down, the reason is likely
the commit does not apply cleanly due to context changes in the struct
hda_quirk alc269_fixup_tbl (as some entries are missing in older
series).

For context see as well:
https://lore.kernel.org/linux-sound/Z95s5T6OXFPjRnKf@eldamar.lan
https://lore.kernel.org/linux-sound/Z_aq9kkdswrGZRUQ@eldamar.lan/
https://bugs.debian.org/1100928

Can you please apply it down for 6.1.y?

Attached is a manual backport of the change in case needed.

Regards,
Salvatore

From 336110525d8a24cd8bbc4cfe61c2aaf6aee511d4 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 2 Apr 2025 09:42:07 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix built-in mic on another ASUS VivoBook
 model

[ Upstream commit 8983dc1b66c0e1928a263b8af0bb06f6cb9229c4 ]

There is another VivoBook model which built-in mic got broken recently
by the fix of the pin sort.  Apply the correct quirk
ALC256_FIXUP_ASUS_MIC_NO_PRESENCE to this model for addressing the
regression, too.

Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Closes: https://lore.kernel.org/Z95s5T6OXFPjRnKf@eldamar.lan
Link: https://patch.msgid.link/20250402074208.7347-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[Salvatore Bonaccorso: Update for context change due to missing other
quirk entries in the struct snd_pci_quirk alc269_fixup_tbl]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 93e8990c23bc..61b48f2418bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10071,6 +10071,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1c80, "ASUS VivoBook TP401", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
-- 
2.49.0


