Return-Path: <stable+bounces-183236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9339BB748E
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61E4189AE9B
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110641F1302;
	Fri,  3 Oct 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="BHSFxpYR"
X-Original-To: stable@vger.kernel.org
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7542A80;
	Fri,  3 Oct 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503964; cv=none; b=pI99U/70bddG57Lv3ICQ7oK4PrRgBigHj+gZHhNk/rYA/RqhppC/nBfv8AIdiIX8LudwKdeqQArBKfURUJ/lgptzNvayK0XqCuS6kGTXUfOz6Ibq5OOy8VptywHm+UGK16UetsHkB2W5VBEawuBepigBQixj0ru0CeaoU+/7VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503964; c=relaxed/simple;
	bh=cn0SYSGCQ2+nQxPGi29l1O7Jzqnaq/TOCJCC5GcD0DI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvdncEcOzIfnSKL82Jh35HovEI6I5ua9u4w1n6tNhvmIYWsYButiY/WV8a6o/fwxZb3XvYkLpx1EVykFzT94IuMK+XpUeWKZbw5BzBHX/l9s3n2RvKfn77eEW2IBOcuil0XVslIMMpcLf47wPNC74/WynzkBkmK0edQH6+Le624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=BHSFxpYR; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=cn0SYSGCQ2+nQxPGi29l1O7Jzqnaq/TOCJCC5GcD0DI=; b=BHSFxpYRrZaskkN+ZrVjDyRAe9
	rIn3FLDwiZsq9xLJEWGL295e3sd9rQNXlf6SeZk4lqMXV97IbuwWfcKKBLHwyaR6/io3duR9LClEv
	yblSLfuRS7aqF4UbDIaAtms+PWuhaSVn1zoV7sMrLElmN7t3xtlVyFY4WmwmmbBDN2oU=;
Received: from [62.217.191.191] (helo=[192.168.1.230])
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <puleglot@puleglot.ru>)
	id 1v4hDW-00000002sKk-2srK;
	Fri, 03 Oct 2025 17:57:06 +0300
Message-ID: <265839123283304ede6b391bd92340adf77ad0f4.camel@tsoy.me>
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
From: Alexander Tsoy <alexander@tsoy.me>
To: Serge SIMON <serge.simon@gmail.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, Takashi Iwai
	 <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Date: Fri, 03 Oct 2025 17:57:05 +0300
In-Reply-To: <CAMBK1_Sw8nVSN3Z7WtHYyJ2xWUNVYNcx26UKFx5hy+xQrO=bHA@mail.gmail.com>
References: 
	<CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
	 <2024011723-freeness-caviar-774c@gregkh>
	 <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
	 <bf07c1bc-b38e-4672-9bb0-24c16054569a@leemhuis.info>
	 <CAMBK1_Sw8nVSN3Z7WtHYyJ2xWUNVYNcx26UKFx5hy+xQrO=bHA@mail.gmail.com>
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

=D0=92 =D0=9F=D1=82, 03/10/2025 =D0=B2 15:20 +0200, Serge SIMON =D0=BF=D0=
=B8=D1=88=D0=B5=D1=82:
> Hello,
>=20
> I still encounter this issue (and every month i test the latest
> kernel, each time with the same results) :
> - i do have an ASUS B560-I WIFI (ITX) motherboard with a S/PDIF
> output
> - everything was working flawlessly until (and including) kernel
> 6.6.10, and that S/PDIF output was perfectly detected (under GNOME
> SHELL, etc.)
> - starting from kernel 6.7.0 (and newest ones, including 6.16.10
> tested today) the S/PDIF output it NOT detected anymore at boot time
> by the kernel (so is not selectable any more under GNOME SHELL or
> COSMIC, etc.)
>=20
> With old kernel (example :
> https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-gistfi=
le1-txt
> )
> :
>=20
> % cat /proc/asound/pcm
>=20
> 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
> 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
> 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
> 01-03: HDMI 0 : HDMI 0 : playback 1
> 01-07: HDMI 1 : HDMI 1 : playback 1
> 01-08: HDMI 2 : HDMI 2 : playback 1
> 01-09: HDMI 3 : HDMI 3 : playback 1
>=20
>=20
> With kernels >=3D 6.7.0 (example :
> https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-dmesg-=
6-12-6-log
> )
> :

Did you disable intel iGPU somehow? Try to add snd_hda_core.gpu_bind=3D0
to the kernel cmdline.
>=20

