Return-Path: <stable+bounces-183310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D0BB7E3A
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 20:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946DD4EE3D9
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A81F1534;
	Fri,  3 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="hBpXDHu/"
X-Original-To: stable@vger.kernel.org
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FD18B0F;
	Fri,  3 Oct 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516361; cv=none; b=DBfGo3e0wVZotR+69rXzLXwzcUI3qhgXCk/WgrYRfA4+S0RF49aOMKFcKw41AnqIQd3YTwY/WSO2mLz7UUi4NyFnTDCgmNrVVOAGlQHt7AlmlS2PD9sQwdvOrBnGXN7FS0Gky5ZuPFvFl+viB3kqXjpJtOZL1Li01yVS2uwNuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516361; c=relaxed/simple;
	bh=6LsdkFJMNUtByb9/erKdoNDV5/jm+WUpU8rtXMC9o8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIF5QNXFL2e3046L7Zbhu+kjYmJkLS7gGL2UP8QvFXJLcbaurDd8GoD3PAR7el10I0F7minoyILHxN2GAk611TU9kPLnrN5AXXvZxWDNsKRaXnWig6zddFFDkRssiQocShTmIKv/p3Mi17e2/4KbzhiSf9wo1ivx1yCVKD5OCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=hBpXDHu/; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=6LsdkFJMNUtByb9/erKdoNDV5/jm+WUpU8rtXMC9o8o=; b=hBpXDHu/N/HZJWBUJDkF6EPa45
	EJlIUt1HFcYufkCTFdi/KYEO1HN1Ibi4BlmGQzOZR48iV94/uA4l8RjzESmKzHohQXc7Ee45/1RBu
	Tp8P4rm5sAbCYlm/BOC6cIGUx/bFj1B+/scbh6BZTr5KwEi+7ZKayCRNpXRBSUaruZnQ=;
Received: from [62.217.191.191] (helo=[192.168.1.230])
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <puleglot@puleglot.ru>)
	id 1v4ka2-000000000Fd-49GA;
	Fri, 03 Oct 2025 21:32:35 +0300
Message-ID: <8254efed415d6e7faee6b04b88993e7ff35ef8af.camel@tsoy.me>
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
From: Alexander Tsoy <alexander@tsoy.me>
To: Serge SIMON <serge.simon@gmail.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, Takashi Iwai
	 <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Date: Fri, 03 Oct 2025 21:32:33 +0300
In-Reply-To: <265839123283304ede6b391bd92340adf77ad0f4.camel@tsoy.me>
References: 
	<CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
		 <2024011723-freeness-caviar-774c@gregkh>
		 <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
		 <bf07c1bc-b38e-4672-9bb0-24c16054569a@leemhuis.info>
		 <CAMBK1_Sw8nVSN3Z7WtHYyJ2xWUNVYNcx26UKFx5hy+xQrO=bHA@mail.gmail.com>
	 <265839123283304ede6b391bd92340adf77ad0f4.camel@tsoy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: puleglot@puleglot.ru

=D0=92 =D0=9F=D1=82, 03/10/2025 =D0=B2 17:57 +0300, Alexander Tsoy =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> =D0=92 =D0=9F=D1=82, 03/10/2025 =D0=B2 15:20 +0200, Serge SIMON =D0=BF=D0=
=B8=D1=88=D0=B5=D1=82:
> > Hello,
> >=20
> > I still encounter this issue (and every month i test the latest
> > kernel, each time with the same results) :
> > - i do have an ASUS B560-I WIFI (ITX) motherboard with a S/PDIF
> > output
> > - everything was working flawlessly until (and including) kernel
> > 6.6.10, and that S/PDIF output was perfectly detected (under GNOME
> > SHELL, etc.)
> > - starting from kernel 6.7.0 (and newest ones, including 6.16.10
> > tested today) the S/PDIF output it NOT detected anymore at boot
> > time
> > by the kernel (so is not selectable any more under GNOME SHELL or
> > COSMIC, etc.)
> >=20
> > With old kernel (example :
> > https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-gist=
file1-txt
> > )
> > :
> >=20
> > % cat /proc/asound/pcm
> >=20
> > 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
> > 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
> > 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
> > 01-03: HDMI 0 : HDMI 0 : playback 1
> > 01-07: HDMI 1 : HDMI 1 : playback 1
> > 01-08: HDMI 2 : HDMI 2 : playback 1
> > 01-09: HDMI 3 : HDMI 3 : playback 1
> >=20
> >=20
> > With kernels >=3D 6.7.0 (example :
> > https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-dmes=
g-6-12-6-log
> > )
> > :
>=20
> Did you disable intel iGPU somehow? Try to add
> snd_hda_core.gpu_bind=3D0
> to the kernel cmdline.
>=20

Ah, I see:
...
vfio_pci: add [8086:4c8a[ffffffff:ffffffff]] class 0x000000/00000000
...

You probably passthrough the GPU to VM so the i915 driver is not loaded
on the host. Thus you really need snd_hda_core.gpu_bind=3D0 kernel
option. This is a consequence of the following series:
https://lore.kernel.org/all/20231009115437.99976-1-maarten.lankhorst@linux.=
intel.com/

