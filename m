Return-Path: <stable+bounces-61841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395793CF7C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0023B2099A
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9DC1369B1;
	Fri, 26 Jul 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kd7v8zvS"
X-Original-To: stable@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F71862A
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982114; cv=none; b=P7mvAE0fNBQPHPMuNWJJJv4xvDepUsVmNYyTXfgBjLX+dmq6d2K2djR2RtMmSC1JtaJ2n5eY7B2FrTUM+oBBahZWC/DiGu7D4hbTUjke7qXm/HSHETxQr6+FmdnGtTMTiX3CptIP5ZEZ+GnfqbuOSf9MfVPXYVsYmLHrOfvdP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982114; c=relaxed/simple;
	bh=lcLXhIITqFgsUuQseBCejR6CqPby/KcEvX7k5t46WJY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLVsw444V84xZznbQKQm2Op85dPgHlBhrPwAG+wuTa/o8kfiMvOrU9g9jCI5h1dMODHlEcdeCEa3szOvnnSqSu2T8lYyuFtirV4YHllgrluP40Tf8921MOqlHVa7bAekUIcrKUlSlZF/GpHY1A1Oc0vJEPtKQQY0oFuQTWwgxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kd7v8zvS; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721982110; x=1722241310;
	bh=lcLXhIITqFgsUuQseBCejR6CqPby/KcEvX7k5t46WJY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kd7v8zvSsnc76pSQmwDG74YBKhhNDyfEXb6var4nMveM/CK+i944qKBGh8zEZrHOD
	 6PUnzCjba2jBAHF/S4JcKo5kTBCcbnSh6eWldHDMD8nElgrzW8IZjwI9sW6gS8AaSz
	 OIKCMqZFE4DosmKvCHgUUxG2/dhAcEQUhWqhCo/Ew09fSNa68Gs4Mcndd24i1Wa7vs
	 2lDcOzw/6n/BpHdNW7iaOlVsna6uC7azOdR/VowucIsOaIBWvYDGAlfQIMgBUnKJ01
	 7sMKTl29auDb2fpp/t/oQVR2+4tP3S92P6coj6YhMcNNMUgU50z5G4EnqWguvmO7yD
	 zhJcr6a3HqBmg==
Date: Fri, 26 Jul 2024 08:21:47 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com>
In-Reply-To: <2024072633-easel-erasure-18fa@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com> <2024072633-easel-erasure-18fa@gregkh>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 3a4083b4d5a76ccb4769dc73b5aae8b590891950
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_muHcFkLmeSPF6z1PDHiFsETa5Jyzfpm1ucSoHvstyBg"

This is a multi-part message in MIME format.

--b1_muHcFkLmeSPF6z1PDHiFsETa5Jyzfpm1ucSoHvstyBg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 26th, 2024 at 10:49, Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> On Fri, Jul 26, 2024 at 07:25:21AM +0000, Jari Ruusu wrote:
> > Fixes: upstream fd7eea27a3ae "Compiler Attributes: Add __uninitialized =
macro"
> > Signed-off-by: Jari Ruusu jariruusu@protonmail.com
>=20
> Please submit this in a format in which we can apply it, thanks!

Protonmail seems to involuntarily inject mime-poop to outgoing mails.
Sorry about that. For the time being, the best I can do is to re-send
the patch as gzipped attachment.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

--b1_muHcFkLmeSPF6z1PDHiFsETa5Jyzfpm1ucSoHvstyBg
Content-Type: application/gzip; name=gcc4-fix-for-5.10.223-rc1.diff.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=gcc4-fix-for-5.10.223-rc1.diff.gz

H4sICK9Jo2YCA2djYzQtZml4LWZvci01LjEwLjIyMy1yYzEuZGlmZgCVkM1qAkEQhO/zFA25KJPd
NRiiHpSFFUSICkLOzcSZdRvGXpkfDHl6RwQNEsimDw0FVR9UZVkGeUG8s1GbwhLHr2LXHo5kjUMV
gqPPGIzPm3zzPhdSym5uUZaQDUfPbyDTH0FZCngCbWpiA4iLqnrFRvl7BhG5ZZ8U7xHhfoMuQfSK
KdC3QaW1M94nRC+51x8VrpbrzTbp2RTG/f/BIl+9+nfcpC/kX7jIdIEpm3j6VqxDqVpZGxrXxn3z
Y48OwZNy/DgiwEsKGtZUizNAQ5o08gEAAA==

--b1_muHcFkLmeSPF6z1PDHiFsETa5Jyzfpm1ucSoHvstyBg--


