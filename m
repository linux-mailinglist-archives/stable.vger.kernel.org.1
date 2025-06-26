Return-Path: <stable+bounces-158650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF97AE9388
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 02:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8E83B4893
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF318FC80;
	Thu, 26 Jun 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K74KYAbu"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013801494A9;
	Thu, 26 Jun 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899296; cv=none; b=rBRZQUxVNUQ1/VDW77zL+e0xRVZakyqdk/g37t6+yVj+FBlCXMsPjDeRpOtznjpN/sYXg6JzBcHHKNLKBxe35f0rpCUGNRtGAUCrXh+7BWRxPDsHzKOpUBbdzifQRZz0NMlnkVLwgAP1bwhFbiLWwMefqbah8YjAsWOqKdZf8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899296; c=relaxed/simple;
	bh=9/v899sjDZPrW1UB99mD3F+dd81w7HeCELfpdkfQqus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMmiovW+fdF37HEmm9bZbFPKGvKttIe2zQu7v4Sb3unOJxrTx4abdA507kMvdAJrSsYNAa521KXqYDhG5Ru7WCo0vQODZ93QWqjNys85I4ankZXGCe29Vmk6z+fH8jEC/araPtF+vAxlGFh8Okp4/DPmJsSJb2r5WRmBILEReao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K74KYAbu; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso2366255ab.2;
        Wed, 25 Jun 2025 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750899294; x=1751504094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xlua2bBZpnuY8yUpTwsazELVSXrkboThh5oafk32JNI=;
        b=K74KYAbuv8Hp4m9i8EiKJL/2+l4SCrfV+LpOexDuawY0if9pG9fK1OyGfopJ5d/rik
         Eld3+US7SzipWJi4DHoShx6sCh0mxa0nAUjwsvJ0obJWV2xirOitae9ZHjsDiK30GhYl
         ejFxUeFrOBMBRsuSixRR5hdgERpHyIvRNLh0rEAn67O7FV2zisyWjXDo+ukKEr8lwlkv
         WIJwtHTPq1stvtmfoiG0yG+WpPBcBjZTIyV0CK4MkQW4frylaleS0Wp9hMo2aufRZx8k
         W6C7HVxsJ6xe29IxLaDrGHjYTdt5BG3gY6lcST38Zp7U8oqPCDjWsD4M4jbX/aN8DE5y
         RTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750899294; x=1751504094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xlua2bBZpnuY8yUpTwsazELVSXrkboThh5oafk32JNI=;
        b=jep1D0E5y+n5G5690yXEsZ/t3lCaxCcP+Nb+hRx/+LgCS0TRsEFvabWQZOvrxc4NfG
         eQIOMLFET1GX3Pz63X72cmyFtqMqNrBBdLoPX8HdDuM88xB27TJ27X5otCNtiSFfqvCU
         qjz4Fjnw7giDIc6pVInG7eDn921/f2rr50ikJUEDHDATxfMelHZDzAEKdUO1XJ8bNABS
         7zNIf+4I4ooAShIJDoz0NNXEqqDyvGpNG/P5tB91YECu/kEBxuLQUVgDtNjwyGj+Tezt
         tcepspgvWlR+tQRQBtwFsjaLx9LF98DwAiwQxQbbYvwNNyLgoSbxrq8pWW+a0pJqtMZ0
         Vd+g==
X-Forwarded-Encrypted: i=1; AJvYcCU65vV/K8M+L55PYlyYkx+MGz80AZe06Jj59lkHpZ64PWPv5YiIOWIk8wv2+bH5drZqJE/CiUJs@vger.kernel.org, AJvYcCW6MpQmPKgjdAOXbJFPzO2MPhiDimClHpndyl8F29l9oXdBRj4TCdlvmtTq6tbDYNvxSDLuuFus52Gcggo=@vger.kernel.org, AJvYcCWPJ93/x/5XDL4ZIQRFLjnOWsilmmDhfJWwljnfKP6R0x5MAAMhKPKiD/ZRWIZcEQR+tx1/iRS6nyxyYnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAXlUmLGhUcp/fxcufZfDN5z6z6WmXHCShdE2iCCe9gktDTz4
	67eEYQ2sjp3kR10FwA8deCX4W1JMR1iWA9cUBFdw71Re8FS5Vv53XtFUwGuHZ24Wyo2pRAW7qsP
	dJCM9oa5XtO2uV7QRrrE6AiOrUB1ni7mBceJT
X-Gm-Gg: ASbGncuZ0N6USYnuju/byMErHrDRCBZPb0sCdyjszmdmHY1l+VHy049sow+TS7aanjb
	DR/C0OI1da0b7vk/WdlKxMuew16Aeq7veBVyJj3fYkkyyqOMToAQHHnpn58KUeTgWFy30CE0qEG
	ZcSNgPSgO2MylR8XK9aJza2GSb004axpA94LhGFH37STo=
X-Google-Smtp-Source: AGHT+IEM4Zu/NqEgMAR7cpVTqhvAeYd78ecZvEroVaZEKTVRACwfsA80W5BqWfT3uKhyoat30h3E6QDKK7+WKc3Tkzk=
X-Received: by 2002:a05:6e02:3089:b0:3dd:b4b5:5c9f with SMTP id
 e9e14a558f8ab-3df329f1560mr66113975ab.19.1750899293867; Wed, 25 Jun 2025
 17:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175038697334.5297.17990232291668400728.reportbug@donsam> <aFxETAn3YKNZqpXL@eldamar.lan>
In-Reply-To: <aFxETAn3YKNZqpXL@eldamar.lan>
Reply-To: igor.tamara@gmail.com
From: =?UTF-8?B?SWdvciBUw6FtYXJh?= <igor.tamara@gmail.com>
Date: Wed, 25 Jun 2025 19:54:42 -0500
X-Gm-Features: Ac12FXyhUNTguzUHacxLK76dRQjlt-OizyMS50oa56X2hY7EZu30xOtT7OiAHRc
Message-ID: <CADdHDco7_o=4h_epjEAb92Dj-vUz_PoTC2-W9g5ncT2E0NzfeQ@mail.gmail.com>
Subject: Re: [regression] Builtin recognized microphone Asus X507UA does not record
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1108069@bugs.debian.org, stable@vger.kernel.org, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Salvatore,


El mi=C3=A9, 25 jun 2025 a las 13:47, Salvatore Bonaccorso
(<carnil@debian.org>) escribi=C3=B3:
>
> Hi Igor,
>
> [For context, there was a regression report in Debian at
> https://bugs.debian.org/1108069]
>
> On Thu, Jun 19, 2025 at 09:36:13PM -0500, Igor Tamara wrote:
> > Package: src:linux
> > Version: 6.12.32-1
> > Severity: normal
> > Tags: a11y
> >
> > Dear Maintainer,
> >
> > The builtin microphone on my Asus X507UA does not record, is
> > recognized and some time ago it worked on Bookworm with image-6.1.0-31,
> > newer images are able to record when appending snd_hda_intel.model=3D10=
43:1271
> > to the boot as a workaround.
> >
> > The images that work with the boot option appended are, but not without
> > it are:
> >
> > linux-image-6.15-amd64
> > linux-image-6.12.32-amd64
> > linux-image-6.1.0-37-amd64
> > linux-image-6.1.0-0.a.test-amd64-unsigned_6.1.129-1a~test_amd64.deb
> > referenced by https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D11009=
28
> > Also compiled from upstream 6.12.22 and 6.1.133 with the same result
> >
> > The image linux-image-6.1.0-31-amd64 worked properly, the problem was
> > introduced in 129 and the result of the bisect was
> >
> > d26408df0e25f2bd2808d235232ab776e4dd08b9 is the first bad commit
> > commit d26408df0e25f2bd2808d235232ab776e4dd08b9
> > Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Date:   Wed Jan 29 00:54:15 2025 +0800
> >
> >     ALSA: hda: Fix headset detection failure due to unstable sort
> >
> >     commit 3b4309546b48fc167aa615a2d881a09c0a97971f upstream.
> >
> >     The auto_parser assumed sort() was stable, but the kernel's sort() =
uses
> >     heapsort, which has never been stable. After commit 0e02ca29a563
> >     ("lib/sort: optimize heapsort with double-pop variation"), the orde=
r of
> >     equal elements changed, causing the headset to fail to work.
> >
> >     Fix the issue by recording the original order of elements before
> >     sorting and using it as a tiebreaker for equal elements in the
> >     comparison function.
> >
> >     Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda=
_auto_parser.c")
> >     Reported-by: Austrum <austrum.lab@gmail.com>
> >     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219158
> >     Tested-by: Austrum <austrum.lab@gmail.com>
> >     Cc: stable@vger.kernel.org
> >     Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >     Link: https://patch.msgid.link/20250128165415.643223-1-visitorckw@g=
mail.com
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> >  sound/pci/hda/hda_auto_parser.c | 8 +++++++-
> >  sound/pci/hda/hda_auto_parser.h | 1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > I'm attaching the output of alsa-info_alsa-info.sh script
> >
> > Please let me know if I can provide more information.
>
> Might you be able to try please the attached patch to see if it fixes
> the issue?
>

I recompiled and the mic is recording without issues when running on
6.1.133 and 6.12.32

Thank you everyone for all your hard work.

> Regards,
> Salvatore


--
http://igor.tamarapatino.org

