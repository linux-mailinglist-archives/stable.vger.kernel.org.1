Return-Path: <stable+bounces-158616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C31AE8CF0
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 20:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE9B161A19
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F55F2820CB;
	Wed, 25 Jun 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PwISmq5X"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E811805E;
	Wed, 25 Jun 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877272; cv=none; b=BdzJC+WrzmNdMsj6NU2VqtSfeJ11dHpNFWGK8+LtZABUkM5shfnTqpwT0aKDnqJAQZrKaWP6M9BALkJD0jOjsAmwz1F4Vyir8JZeJxkqRaqRVaDf5mjc/F6iI5tBRh/XoCTDsKYILNb5GQtRPn4sf0IO59kHMeh4d3U0IJuFICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877272; c=relaxed/simple;
	bh=PdylM+KmiPKbbch0SA3L2OCwnVUpRwEBgFHXvyRwVSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuuXzsCAQ9+J/ukoObZjt8mTwkEwURuoVY9Nxb0UyvvxDZyKbRMGqwCOLOpwMZEXFqdg4ELXjjk2YyrCRQhr2/udn/nl7SRcwH/COvcE8766VM+udgh9wXPBeuxHX5xnRmh/uujfkpLHC8s6YQQ7RKL3LgOb6OZ6FR1ltslmjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PwISmq5X; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JH5zpr5foFUyaO0HBGLaaCm7laliOv0IKrYZUM7Ho6s=; b=PwISmq5XVkAhTYcnjD4EAoP+q5
	c4RUu0WBS3zfmcntFWu6xqIF3p7CGEa4MGUteF15zwrI3JjQZMr9F1a6E26vQ4QLD1mvhRF3Bg7Kf
	M3LB1Xsp1r9gWEQlhfP6d3c85bzLMtVh9pUpe4sTOjlUqBNVrmDfza65Z6yfzpJ8yNhVpqSyLgMuy
	QfgJM9a/2xxwUbSfaQ+fVQwt9zqu0PFXd1rFHyBMI2IOyhl9GHqU5SEd8lxdbLkkhA5OTJvYwsuV8
	TMMGbG1dR1Y0NNaZm/DVAn5RJgRmbeOEcLoIUEoauoB61n4JNwRi1W00rvufQPByl43q0X7OKLN4J
	CATH49rg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uUV9p-003KTb-J6; Wed, 25 Jun 2025 18:47:42 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 9D053BE2DE0; Wed, 25 Jun 2025 20:47:40 +0200 (CEST)
Date: Wed, 25 Jun 2025 20:47:40 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Igor Tamara <igor.tamara@gmail.com>, 1108069@bugs.debian.org
Cc: stable@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [regression] Builtin recognized  microphone Asus X507UA does not
 record
Message-ID: <aFxETAn3YKNZqpXL@eldamar.lan>
References: <175038697334.5297.17990232291668400728.reportbug@donsam>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zXGIuObp+/EcMWqu"
Content-Disposition: inline
In-Reply-To: <175038697334.5297.17990232291668400728.reportbug@donsam>
X-Debian-User: carnil


--zXGIuObp+/EcMWqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Igor,

[For context, there was a regression report in Debian at
https://bugs.debian.org/1108069]

On Thu, Jun 19, 2025 at 09:36:13PM -0500, Igor Tamara wrote:
> Package: src:linux
> Version: 6.12.32-1
> Severity: normal
> Tags: a11y
> 
> Dear Maintainer,
> 
> The builtin microphone on my Asus X507UA does not record, is
> recognized and some time ago it worked on Bookworm with image-6.1.0-31,
> newer images are able to record when appending snd_hda_intel.model=1043:1271
> to the boot as a workaround.
> 
> The images that work with the boot option appended are, but not without
> it are:
> 
> linux-image-6.15-amd64
> linux-image-6.12.32-amd64 
> linux-image-6.1.0-37-amd64
> linux-image-6.1.0-0.a.test-amd64-unsigned_6.1.129-1a~test_amd64.deb 
> referenced by https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1100928
> Also compiled from upstream 6.12.22 and 6.1.133 with the same result
> 
> The image linux-image-6.1.0-31-amd64 worked properly, the problem was
> introduced in 129 and the result of the bisect was
> 
> d26408df0e25f2bd2808d235232ab776e4dd08b9 is the first bad commit
> commit d26408df0e25f2bd2808d235232ab776e4dd08b9
> Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> Date:   Wed Jan 29 00:54:15 2025 +0800
> 
>     ALSA: hda: Fix headset detection failure due to unstable sort
>     
>     commit 3b4309546b48fc167aa615a2d881a09c0a97971f upstream.
>     
>     The auto_parser assumed sort() was stable, but the kernel's sort() uses
>     heapsort, which has never been stable. After commit 0e02ca29a563
>     ("lib/sort: optimize heapsort with double-pop variation"), the order of
>     equal elements changed, causing the headset to fail to work.
>     
>     Fix the issue by recording the original order of elements before
>     sorting and using it as a tiebreaker for equal elements in the
>     comparison function.
>     
>     Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda_auto_parser.c")
>     Reported-by: Austrum <austrum.lab@gmail.com>
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219158
>     Tested-by: Austrum <austrum.lab@gmail.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>     Link: https://patch.msgid.link/20250128165415.643223-1-visitorckw@gmail.com
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  sound/pci/hda/hda_auto_parser.c | 8 +++++++-
>  sound/pci/hda/hda_auto_parser.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> I'm attaching the output of alsa-info_alsa-info.sh script
> 
> Please let me know if I can provide more information.

Might you be able to try please the attached patch to see if it fixes
the issue?

Regards,
Salvatore

--zXGIuObp+/EcMWqu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ALSA-hda-realtek-Fix-built-in-mic-on-ASUS-VivoBook-X.patch"

From da92704b8bce54678c46501260efee50de16058f Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Wed, 25 Jun 2025 20:41:28 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

The built-in mic of ASUS VivoBook X507UAR is broken recently by the fix
of the pin sort. The fixup ALC256_FIXUP_ASUS_MIC_NO_PRESENCE is working
for addressing the regression, too.

Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2e1618494c20..3613ed0aa683 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11026,6 +11026,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606WA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1264, "ASUS UM5606KA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1e10, "ASUS VivoBook X507UAR", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e1f, "ASUS Vivobook 15 X1504VAP", ALC2XX_FIXUP_HEADSET_MIC),
-- 
2.50.0


--zXGIuObp+/EcMWqu--

