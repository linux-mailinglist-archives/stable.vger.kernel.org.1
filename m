Return-Path: <stable+bounces-119889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04028A490AF
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DAB188F994
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461601AE01B;
	Fri, 28 Feb 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL7zljev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744554648
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718808; cv=none; b=ounQ4vV1nQ9woN0ppaVxjEBC9RpHrtI5SpxJ1UpxcWUxv22wNWp7Zf9ChGMHduCBMOY4AWYnZ44GidW0hozKrASj5KGaGtb1P1PZPBLZIl0vtcXojp8FQSq47C7E1Jgg7jW/Monvur8KugudVjswrEEF883U6dnIyEuGjreRUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718808; c=relaxed/simple;
	bh=kRi2AfZgU8VSYcVvKNIJo4IDAJBNFYcotQBhoT+sW04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5J7Nrd1DYtwv9i37FMxqv6Y2+jxswt31sDpyW7Y4W0jFLna7cHzX4CbwJfyoFXOkDGRosaZMl7ncEuBE0zUTRZjkbte39RRYo5piwn8uMmSelccQBUsgPtxKmSPIEjA0m2OiTazKHz7KvLSbAzeXZtahaEfsfkMgKray8yjF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL7zljev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EAAC4CED6;
	Fri, 28 Feb 2025 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718807;
	bh=kRi2AfZgU8VSYcVvKNIJo4IDAJBNFYcotQBhoT+sW04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL7zljevWQcE13ELbJlDsjQjB1kFSRQPU9Pa5pI/aGWDCI8dPnx7PvnroZKxtYFki
	 DZohEBq6C9rvQw3ce8eGstk9LZrg/WRtuRQvVUzvrqw3ERooOZf8Z4/luM83sdgmWr
	 FvVrQbH4pQwP0He3YUHBzcXbhjD97xaVwn5536N+9xkk1bwQQe+JcXKxQaEzq3v8oQ
	 BzpJImaZ0AdigyPP8Grm0miG6HjxTtNgQB5YNPg5uW1ktSxc9F+H7lsQqis3un156O
	 a6kdHlb0t1p8/OT4uookNsD4mFptV+az0cfHOS9YLxNi8AC75Nq6tM1ir2lZBPMjK6
	 hhVLyy1pUf+nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	adrienverge@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix microphone regression on ASUS N705UD
Date: Thu, 27 Feb 2025 23:56:22 -0500
Message-Id: <20250227193111-dc41d39b05333aec@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226135515.24219-1-adrienverge@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: c6557ccf8094ce2e1142c6e49cd47f5d5e2933a8

Status in newer kernel trees:
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c6557ccf8094c ! 1:  09b2f4d39b8aa ALSA: hda/realtek: Fix microphone regression on ASUS N705UD
    @@ Commit message
         Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
         Tested-by: Adrien Vergé <adrienverge@gmail.com>
         Signed-off-by: Adrien Vergé <adrienverge@gmail.com>
    -    Link: https://patch.msgid.link/20250226135515.24219-1-adrienverge@gmail.com
    -    Signed-off-by: Takashi Iwai <tiwai@suse.de>
     
      ## sound/pci/hda/patch_realtek.c ##
     @@ sound/pci/hda/patch_realtek.c: static const struct hda_quirk alc269_fixup_tbl[] = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c	(rejected hunks)
@@ -10656,7 +10656,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c	(rejected hunks)
@@ -10656,7 +10656,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c	(rejected hunks)
@@ -10656,7 +10656,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c	(rejected hunks)
@@ -10656,7 +10656,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),

