Return-Path: <stable+bounces-158652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62395AE94EF
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 06:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87FD3B339F
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 04:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB13214A6A;
	Thu, 26 Jun 2025 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBo0FHw2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03C1B6CE3;
	Thu, 26 Jun 2025 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750911826; cv=none; b=NhyaCmNV4jWhldvYaC8rguk7U1tFDqf2KOjV0cnr080ffyCXHnDrXGBgi9YkmqslEtBHhU/7RJHzK3pnaRd/C4gWupmyh61EpKQXDR6+aSngS5ajlclI+J7dj2LyUaAvNKMiD2QciMJ2wJNFr5M5m6ufh9SVcYK7qN9NVmowO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750911826; c=relaxed/simple;
	bh=cz2aWXUXQOfWcUuVEO4CX1S9xXJROjvEWS/iAdZvR+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSgJPvB/RLCeClrg53amy5YStOjfjvuIEmw9HebuyOMj9lf6QYL78RtTGb2AjIJz1+rqznL+8tekZ6331UDV2WaQwF6oDfOZfNuXbmzi8LVq9LZ4Px//OZp5l8jBnkLT1O7ee+2LQ2vaMnpcljQ/Fg8DhrJM/tRZWqwWJ0/crUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBo0FHw2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso587399f8f.1;
        Wed, 25 Jun 2025 21:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750911822; x=1751516622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oj2bHcDJgl9+S/n++0foFhyzvZT95ROYb1zT6UU809Y=;
        b=QBo0FHw2k9wVPK3ExzDUAoCKkl5JlDGbbpPygih441Ymko6Z0Am8K0VxJAaC0B6btj
         njUCAMz7Uff1E777cX5CMhj4dDfWZO+E4AbJ7N/z/IlD17jSCmQfNt+eiliRXVPpKZOq
         1GPPAeHwKomtYVi2AaLgpDidwV2+EP06mUKnPmP50HQn0wB74owm7niYNYVkBvpEMN/5
         Mwm6GB6rc9GJDbUzW3spSJmoirN7oeoblmxm9ewGicdolGeGX7hpyLujgHiby17I0GW7
         nboVIxy+3IzO9G86tlUmLTpQpEzmyMfATwyNq9YKF768wPK3ZmQbKv/Eg3ImafBM4l0e
         KEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750911822; x=1751516622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj2bHcDJgl9+S/n++0foFhyzvZT95ROYb1zT6UU809Y=;
        b=TLyvYDd7K5sm4ab+I1sghFQCxe+xrg3kMaMwe6iuKWKa+RKDKTMFYn807ow/wgdEBq
         JcMl21SSxckZmPj7Dp2qZvg2Yd5fCRtudKC6EG0+XWgzQDx04G/CwjIu6IUUEqc9AyFD
         y+dKOMdG1iY+y3IeUMyl3b2Lmfn512ifZ/RUynZ3rZDpnB1x8bAyvgoleiFJLd2vGqCM
         9lddhBNlTFdgakKJMFhWs1Us1R1D9wMB2GYpCcnfYHkjo+QFgjo3lC49rZJgAY1nMCtw
         F2LFIOccZ30ZjYgeBOrtOL55xE2qgZ2XuvLxBDDKoEvcZNTQxkJ6p9LvruQvqYafmWlk
         otgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCdyzlv4EbcDPipzZW9cI/XOlEXBL83uPUT4LzrAZdf6nAyygjy0JUiokkvqKH/WeyZYaKCG5l53GfOLQ=@vger.kernel.org, AJvYcCX7QTTWK8opU3H6fgAgt2rhfRc7A7tAn7n5cUwCXMH0injkNKau4S/Cc1RUkszkdgci01YjxUqT@vger.kernel.org, AJvYcCXdhdsDO4uuskIPw5UJ2YyTonmxuU5GVPUfVEeq+em8SrR/PLuxZvxgFPcNXrzdszH9iNEopFwzwBChDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9fqGmYBadDOaidkesuoV1yiqIY9FZ2WdLBT42VJHbWkv9XC9
	o7Ub/VuUYq4JyRMlNtBKNJz2d5S5LfZtsWcZJrHsJUzyLgFO5iHep16t
X-Gm-Gg: ASbGncunJzcyMiihg3MaAzWb8qmzHGN+otcx0iobBGb/ZCecqNGsFBz9td2qFHbeByG
	Sx4TTU0TOuG9K/q+29GaOuThTrQMHAJBG9XM8nUFvHNSw5SIFdQUu+E4iTlXCcjVw7KjnDm35oY
	iZdlhreN3U8t2gF1y8UxmCwhwGhPFt3qMexdgrVJNkrhuZvceeawQDVAY0VQWZ+kig3sTm6Ou8Y
	GjMAQmhB6vF4az5/Qb9RxHfKGMZ0OoqGtGQ+bmMblQqX5lZWIQwfcxoWQ0mbBPXIP6Yx+NAFl+b
	YAEnJuXojsyXqtnmnXe6C9H2m4pJeU0wPwubp/lqdx5OoNdRR6mDqxgkNgk1zA9BRdgew/Six16
	1R8fQiY3Q5ubkzA+iM+E=
X-Google-Smtp-Source: AGHT+IHTsihSVjoZLBKB2N//2zd9+ve+PLW8mT7KIvjOqTvwdEAJ7QNUheJCicqy4U0rK1I1Ko3+KA==
X-Received: by 2002:a05:6000:23c8:b0:3a5:26fd:d450 with SMTP id ffacd0b85a97d-3a6ed6510famr3156090f8f.47.1750911822082;
        Wed, 25 Jun 2025 21:23:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6fa2sm37449565e9.27.2025.06.25.21.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 21:23:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 93CFEBE2DE0; Thu, 26 Jun 2025 06:23:40 +0200 (CEST)
Date: Thu, 26 Jun 2025 06:23:40 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Igor =?iso-8859-1?Q?T=E1mara?= <igor.tamara@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Cc: 1108069@bugs.debian.org, stable@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [regression] Builtin recognized microphone Asus X507UA does not
 record
Message-ID: <aFzLTJg8MN5evbYL@eldamar.lan>
References: <175038697334.5297.17990232291668400728.reportbug@donsam>
 <aFxETAn3YKNZqpXL@eldamar.lan>
 <CADdHDco7_o=4h_epjEAb92Dj-vUz_PoTC2-W9g5ncT2E0NzfeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/RjsshRd9QdLJZs8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADdHDco7_o=4h_epjEAb92Dj-vUz_PoTC2-W9g5ncT2E0NzfeQ@mail.gmail.com>


--/RjsshRd9QdLJZs8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Igor,

On Wed, Jun 25, 2025 at 07:54:42PM -0500, Igor Támara wrote:
> Hi Salvatore,
> 
> 
> El mié, 25 jun 2025 a las 13:47, Salvatore Bonaccorso
> (<carnil@debian.org>) escribió:
> >
> > Hi Igor,
> >
> > [For context, there was a regression report in Debian at
> > https://bugs.debian.org/1108069]
> >
> > On Thu, Jun 19, 2025 at 09:36:13PM -0500, Igor Tamara wrote:
> > > Package: src:linux
> > > Version: 6.12.32-1
> > > Severity: normal
> > > Tags: a11y
> > >
> > > Dear Maintainer,
> > >
> > > The builtin microphone on my Asus X507UA does not record, is
> > > recognized and some time ago it worked on Bookworm with image-6.1.0-31,
> > > newer images are able to record when appending snd_hda_intel.model=1043:1271
> > > to the boot as a workaround.
> > >
> > > The images that work with the boot option appended are, but not without
> > > it are:
> > >
> > > linux-image-6.15-amd64
> > > linux-image-6.12.32-amd64
> > > linux-image-6.1.0-37-amd64
> > > linux-image-6.1.0-0.a.test-amd64-unsigned_6.1.129-1a~test_amd64.deb
> > > referenced by https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1100928
> > > Also compiled from upstream 6.12.22 and 6.1.133 with the same result
> > >
> > > The image linux-image-6.1.0-31-amd64 worked properly, the problem was
> > > introduced in 129 and the result of the bisect was
> > >
> > > d26408df0e25f2bd2808d235232ab776e4dd08b9 is the first bad commit
> > > commit d26408df0e25f2bd2808d235232ab776e4dd08b9
> > > Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Date:   Wed Jan 29 00:54:15 2025 +0800
> > >
> > >     ALSA: hda: Fix headset detection failure due to unstable sort
> > >
> > >     commit 3b4309546b48fc167aa615a2d881a09c0a97971f upstream.
> > >
> > >     The auto_parser assumed sort() was stable, but the kernel's sort() uses
> > >     heapsort, which has never been stable. After commit 0e02ca29a563
> > >     ("lib/sort: optimize heapsort with double-pop variation"), the order of
> > >     equal elements changed, causing the headset to fail to work.
> > >
> > >     Fix the issue by recording the original order of elements before
> > >     sorting and using it as a tiebreaker for equal elements in the
> > >     comparison function.
> > >
> > >     Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda_auto_parser.c")
> > >     Reported-by: Austrum <austrum.lab@gmail.com>
> > >     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219158
> > >     Tested-by: Austrum <austrum.lab@gmail.com>
> > >     Cc: stable@vger.kernel.org
> > >     Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > >     Link: https://patch.msgid.link/20250128165415.643223-1-visitorckw@gmail.com
> > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > >  sound/pci/hda/hda_auto_parser.c | 8 +++++++-
> > >  sound/pci/hda/hda_auto_parser.h | 1 +
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > I'm attaching the output of alsa-info_alsa-info.sh script
> > >
> > > Please let me know if I can provide more information.
> >
> > Might you be able to try please the attached patch to see if it fixes
> > the issue?
> >
> 
> I recompiled and the mic is recording without issues when running on
> 6.1.133 and 6.12.32

Thanks for the confirmation! Takashi, can you apply the proposed
change (slightly improved in attached variant to add Reported-by and
Closes tags), hopefully getting it into required stable series?

Regards,
Salvatore

--/RjsshRd9QdLJZs8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ALSA-hda-realtek-Fix-built-in-mic-on-ASUS-VivoBook-X.patch"

From 7c4babc48b76582656da31e51cda8c1efdd38be3 Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Wed, 25 Jun 2025 20:41:28 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

The built-in mic of ASUS VivoBook X507UAR is broken recently by the fix
of the pin sort. The fixup ALC256_FIXUP_ASUS_MIC_NO_PRESENCE is working
for addressing the regression, too.

Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Reported-by: Igor Tamara <igor.tamara@gmail.com>
Closes: https://bugs.debian.org/1108069
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


--/RjsshRd9QdLJZs8--

