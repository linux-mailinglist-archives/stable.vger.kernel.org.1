Return-Path: <stable+bounces-164742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B31B12035
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A86C1CE13DC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7831E833D;
	Fri, 25 Jul 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="TC5WQ0Gw";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="SomZo1Us"
X-Original-To: stable@vger.kernel.org
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5641E5701
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454309; cv=none; b=E+fN4kPnhUdI2OSFJio/+3qrlySxMphWGXB0NmC70YK02C1b03Z+kd9MRfQlWzoac49tnFHUhJ1VgONhOtw7zge63yHilp1B5YWSJS+1Oaoe6EZylliaazgMr9S4aPIv4nR5qLo0R28iOIoNV7qS5F/1cRh1LuAuHdfy+FJLp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454309; c=relaxed/simple;
	bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=oLhDgEkDDUrfQ6ITrBog/0+3qt2JXc3bUdKFVB8PxDVVPS/Ck8x1xvkgVahxfMk/AEr0YvjKOjmvGv8AxqyX6u/NXrw+AzCpT/5enliNS6K1SC83otm2aMAOpo3Jnvnc2Lv8EfnWv94WSvz1giKa8z7IW/NvDuTbOEZwUYEVAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=TC5WQ0Gw; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=SomZo1Us; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753454305; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
 b=TC5WQ0Gwpsr7MT+zYPHDAM5aoTq5taXlMLuVV7OA7Ua81IzvIMhU41+1P5adtGGOxxjR0
 QCHY7I9jlc9/tBzvgf2LIYP6/8ovY1+WmOXk9KUV82X3G+IdV80k1nHETTo1FRA/PE8N/eO
 +FRYd5wTrnIXH7/VsIoVUjmYo/4vKIHpxXyMGmNYj2SMDeFwwi5aGHLJKsB9Hjb5bl815y5
 2JMt+hJhPmxsQZWQGI22SEgSXcWmKsNF6bhIqVNfeHDutN5AgywnL+VZspXG8aKi6mhxZw5
 EMLsxciJtSd81ZE8XDTVGFPVvCuehBIZsIJnG1PKqd498zQOPKN+80bzQp3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753454305; h=from : subject :
 to : message-id : date;
 bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
 b=SomZo1Us258zlepHfastUyxbGYiQiR2LFuD/HgzlKWm5M0eYRDA/l5QvFP3an1OLd/py2
 RQTWFdN9RGaiusfOPbKALxPsM3Y152on0u2i/ErdTRbLcfXZoUbGIOsmPfXqG8AWOsxJroj
 N4N+IIXfnx2V6LMqEJvOu8vo6+L80KrYziKqb8kUJ77+K/VgFqNzHxLF+yys4u10F+2oFPl
 DQ3PLuT2Z7Esv50JsWMiMzvPrCePfF/Ij3VE6SY50rsxnq8uXY5q3DR3+CtgZ3EeNhnhuzS
 eoQThUYGQyrp0LYXbxvA7CWp3tbWx7sbKUrS9kVj2YVDJsdcvj/VKFKk8Eqg==
Received: from [10.152.250.198] (helo=vilez.localnet)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJYy-FnQW0hPs3bB-1ILi;
	Fri, 25 Jul 2025 14:38:20 +0000
From: Edip Hazuri <edip@medip.dev>
To: tiwai@suse.de
Reply-To: 87a54skajh.wl-tiwai@suse.de
Cc: edip@medip.dev, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:38:10 +0300
Message-ID: <5951329.DvuYhMxLoT@vilez>
In-Reply-To: <87a54skajh.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sR_qNS80Cz
X-smtpcorp-track: -E4u5F9OPOXa.ZorUvqixB_Fy.fPih-QXB2mx

On Friday, July 25, 2025 10:13:38=E2=80=AFAM GMT+03:00 Takashi Iwai wrote:
> On Thu, 24 Jul 2025 23:07:56 +0200,
>=20
> edip@medip.dev wrote:
> > From: Edip Hazuri <edip@medip.dev>
> >=20
> > The mute led on this laptop is using ALC245 but requires a quirk to work
> > This patch enables the existing quirk for the device.
> >=20
> > Tested on Victus 16-r1xxx Laptop. The LED behaviour works
> > as intended.
> >=20
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Edip Hazuri <edip@medip.dev>
>=20
> The HD-audio code was relocated and split to different files recently
> (for 6.17 kernel), e.g. this Realtek codec is now located in
> sound/hda/codecs/realtek/alc269.c.
>=20
> As I already closed the changes for 6.16 and it'll be put for
> 6.17-rc1, could you rebase on for-next branch of sound.git tree and
> resubmit?
>=20
>=20
> thanks,
>=20
> Takashi
Hi

I'll rebase and resubmit it as soon as possible
Thank you



