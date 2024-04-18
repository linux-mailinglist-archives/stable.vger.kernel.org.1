Return-Path: <stable+bounces-40177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17E8A98D2
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566B3B23104
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8615F412;
	Thu, 18 Apr 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NdqBehYG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23815ECDA
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440293; cv=none; b=RTjlpoVap02lbt16lt/fx9cJrQx/l6oq4B7ShF6bJGZhMqiZ+s1J9SeaJN68+UU5pXWONtkKvnixpfc/0NRBKCYqsfM7neoHw2xxSElkI6x63O6hmxm5zZnveOCkVkHsnjwzXYrQr7vAyw0VoD30Gw5UpCB4ZQyZJKRqNplmQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440293; c=relaxed/simple;
	bh=yPdetuRBjXUV0x/T5+LWombu6Cj3dX6RWAGOI9ScLmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnkrHyPRt2Ot496zNz0hQTNCr2FCipb6aHKq7NQPMRPZOXV4NS0bNYdxGnaG46A8Jihr46N+G8iLLYu6OTruhCLGeyGKg6Mjee3XeEUhwkIreDbeD6o6rk8QnKzPoEtPvRNl+4kYXJb5VFewr8ty0KEWtfCVdgL+qWVxV3B5X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NdqBehYG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61500da846fso5001247b3.1
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713440291; x=1714045091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPdetuRBjXUV0x/T5+LWombu6Cj3dX6RWAGOI9ScLmc=;
        b=NdqBehYGc1RdDeyJCpdGKdih36i2dSIuKfTCKDZxlt2+uH8bYxX88R58bo0UeAFaqZ
         pxsGjlYcUXzfyAjFFXWLwUaWQxFfrv73KtmndIMg56+FQPB0vp31QVDgTB8PHGySaJDH
         Ff43+OLgL2I7jm437PG25dKNzYPFCmbYJMT/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440291; x=1714045091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPdetuRBjXUV0x/T5+LWombu6Cj3dX6RWAGOI9ScLmc=;
        b=CmswcuvH7naKnfUqAGDxmRyJS+pyg12Yt1EphpEAiIRNwoTk+mPRFOM3JlzNOijZFO
         5kuxIe350tbrLPbaaHl7XzquOnVDMqfzR8O1UZhccQU1dr4h6lXg2eXNtgJrP/Q/q8v4
         p7BIsf0WhFyzQIr0VQh9iySFpGFHvJNaQxP4qipCvkec1mesoyVHnZPLX2RejdJob0pI
         AazqIqPacX7IVtaHe75ouhOgCOcicdOVGj9N+cQxqcYD47QW7B474IWrT6WMhjr2QS8N
         jZmkYO+L8UFCjKx+qVDFyj60oJX2hYF6NLuuUbRgVhYHUm4wfatd0HaG42oG+AWDdt1W
         rJKA==
X-Forwarded-Encrypted: i=1; AJvYcCWM4lg5kYjPNESySFkWBJcFowYuBxXTcH3Dz5Pdna3P3bdOi3LVaDaHiV5w/op4943uJIgknPJ63gZP2tw/1zEGv4HIM7YL
X-Gm-Message-State: AOJu0YyvyJE/mly8taBN0u7W/hVAmlgv7tgUR5x6nCXyBH00OEapP+MQ
	sI7Mtg0ssSTbAqK5ao5wuNA1bdCx9AeHcRnqjBIrvyrCaWmdcmbOOJ7BL6/M3TaUzsnklUjtXay
	19jUolw2x9wO4D1uBLkZ4UczNQgHxtBZ1Y2yA
X-Google-Smtp-Source: AGHT+IHTuymQ0vgyDlw5dewCasXVGfKomv0l6oG6Wss9goffKnGy27+0iGN2IAupwVsZY/T8ZT6sq+P7rk7bBO337k0=
X-Received: by 2002:a05:690c:700a:b0:61a:b0bc:934c with SMTP id
 jf10-20020a05690c700a00b0061ab0bc934cmr2704594ywb.3.1713440290952; Thu, 18
 Apr 2024 04:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408155605.1398631-1-zack.rusin@broadcom.com>
 <843fdfa2-348b-410e-8ff1-84ab86cac17d@amd.com> <CABQX2QMtTB9iiQuce36dnk6eO1Xcsm+Xt3vc1Nk93TGD+TtV9w@mail.gmail.com>
 <5ca415e9-fb3e-4d81-b385-71e8780a1399@amd.com> <CABQX2QMaF6e6o4Ewg6sExfaEZMXRaUrNHNYUCAYG3+44P=7epQ@mail.gmail.com>
In-Reply-To: <CABQX2QMaF6e6o4Ewg6sExfaEZMXRaUrNHNYUCAYG3+44P=7epQ@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 18 Apr 2024 07:38:00 -0400
Message-ID: <CABQX2QNbbM-frtkVwYWZytUAqP0t0gyyd_tZc_s0bDxu+MaFUg@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: Print the memory decryption status just once
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Ian Forbes <ian.forbes@broadcom.com>, Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping on this one. If we don't want the "_once" then I can quickly
prepare a patch that just removes the logging altogether, because
while useful it's polluting up the kernel logs too much right now so
getting a fix in for 6.9 for this would be great.

z

On Mon, Apr 8, 2024 at 1:46=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> Sorry, apologies to everyone. By accident I replied off the list.
> Redoing it now on the list. More below.
>
> On Mon, Apr 8, 2024 at 12:10=E2=80=AFPM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 08.04.24 um 18:04 schrieb Zack Rusin:
> > > On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> Am 08.04.24 um 17:56 schrieb Zack Rusin:
> > >>> Stop printing the TT memory decryption status info each time tt is =
created
> > >>> and instead print it just once.
> > >>>
> > >>> Reduces the spam in the system logs when running guests with SEV en=
abled.
> > >> Do we then really need this in the first place?
> > > Thomas asked for it just to have an indication when those paths are
> > > being used because they could potentially break things pretty bad. I
> > > think it is useful knowing that those paths are hit (but only once).
> > > It makes it pretty easy for me to tell whether bug reports with peopl=
e
> > > who report black screen can be answered with "the kernel needs to be
> > > upgraded" ;)
> >
> > Sounds reasonable, but my expectation was rather that we would print
> > something on the device level.
> >
> > If that's not feasible for whatever reason than printing it once works
> > as well of course.
>
> TBH, I think it's pretty convenient to have the drm_info in the TT
> just to make sure that when drivers request use_dma_alloc on SEV
> systems TT turns decryption on correctly, i.e. it's a nice sanity
> check when reading the logs. But if you'd prefer it in the driver I
> can move this logic there as well.
>
> z

