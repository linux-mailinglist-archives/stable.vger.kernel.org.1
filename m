Return-Path: <stable+bounces-110448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35981A1C867
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C91652BE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022F154C1D;
	Sun, 26 Jan 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtU/9Y1N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E14A01;
	Sun, 26 Jan 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901561; cv=none; b=cLrP3giNJS0haHsh0ESWFhiW5Tuu2wQRuU9XsocYWUXfPKo2ukaRQT2vGctIFGcuE5I2lS6SX0JrFkOqpxAXZy6Nx4iC/GSPbHrelVYZE9bH9i0RGqzvl29atgQcJYd2BjmsNh56DPT9KgK7C9h4KnTirjRU/7kLPZhSAfGd6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901561; c=relaxed/simple;
	bh=r9jWrJo0ys4LMCpA+l8+62ZIwRdxoDRE9SL/3hnuLgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEavvWa8fQFA86oHbKPP8LL/Eqep9aPaPFzMHwSXaHM+E1W2cVkbL2USXuu1L8lI7YhxklWqTd5mamPUFr5yc3cNo3fMTtNEwQmOGox0VkgZIG78C2FMOeK0rMZ2u/kPCNbad8c5aQZxeB50DZxmTum4Oyu0XWp+A8YAt+VJAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtU/9Y1N; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441904a42so6533221a91.1;
        Sun, 26 Jan 2025 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737901559; x=1738506359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9jWrJo0ys4LMCpA+l8+62ZIwRdxoDRE9SL/3hnuLgA=;
        b=MtU/9Y1NeXmKbQwTO1DjTJdrIgxHgabnoJ1NUbaH4SCaXdWbjcU8M1E4IZ3Olu29sc
         5/eXC6F3RSV8jJsyNX+jrcn9TgR2xIgSPmHRbdhYPgASvvq2fzSeasl+gSFp+hFlTQM0
         3ewG78S79QNbE6YJJ7itBAUb3boMZzAqKFceFeQcgJAP+fxr8RJ2Ix4Dz9A5cwMnGCdB
         pU50pUqPcIveozQZ29e2Dp5Pwf2yVXF3+piUV0ZX6/vRAZgSpsnE+OKBe7SH7UrScjAi
         Do+OhwiLm3JzHExqBmctwJYh0AbAZa/Hr7RrN92hvBSKRd02VPC272HKzBxks87/i4Rt
         qr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737901559; x=1738506359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9jWrJo0ys4LMCpA+l8+62ZIwRdxoDRE9SL/3hnuLgA=;
        b=kD2x1M2hL+vce+J4lKjoxfD2Pn82grh4zMa5apk1S0KIXGhGNFiyGsltVBET0NIFTL
         bEQkmSsD+Z1qd8J3ByWtg19V7b/rEbt2zawRh9H3RfaUqvPNdrP1zBTCrxjCKbukpbNe
         MgOWe9zpUulUUnK4KJMKntWe9oelrucdKuew4p14IHZrU6a77mVe59sVYZZ3V7F3ms9m
         anDdd1CgdFr6g02KN7NUXFwsdGl3if6tXkmjTar5gt8Gyodi7yCM/7kyLzulJMZFqobx
         +gGs1XPABimfNuUt3BypMgsXKPNyTrguCn8NVb88gHhMnC0luND6FYQC6RbJ3WGOgaJM
         8clw==
X-Forwarded-Encrypted: i=1; AJvYcCWXN51UY0C25fWZNHz3DKfc4/QfIJ45kA4ZlPxNXIUboY9OfasJl2aqm7ZE1Nyowc24JS9V1vf/SEpO@vger.kernel.org, AJvYcCXUeOlx0aUzT1xFi1wa77thTRZY80sABjXoGwf6h4Eyz7S0ww/uq1imJX5DheaD+wojVcCP/L1P@vger.kernel.org, AJvYcCXtxiqM2l0dMtl2M6kYr/SC7dS5aQU5CyvPD1iisFLorVnCW+e5k4eP1pK2hCEw1x0//nx5j0iU7624Z3ou@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zv9dY54W2Rqyu6rUnI0641ktD6XjIiI5Cznv3RziKC/yXcfl
	4dXNqWCVj1v7HSWHpceEqp1WGWu6A5fDZ2pA2tBNtbEiMLpYYfZYiIlr2eSqP1kZgoRJtOTtupv
	knsVeOPebdjEZLt+WlLuyGhR0788=
X-Gm-Gg: ASbGncuwdyTsst41fHnvpC5BRtftFZ7BDLDHD9e31RNBJFN8FHEwGqfuGbQK4q3Ekuo
	4ZFHA/0Fw+PW1mcJEC4iSdYaHgGMG2mesg4Midr3KCOG/5wFWqvpmpamHF+z1/cI=
X-Google-Smtp-Source: AGHT+IFCMAGeAvzXbplXZVHFkq1g5vwQ0LnfRTn5h/6gVwZzfoyS5OmGbeTKmVHjY8WesWHIziGC/YKDnNh34NFn2HA=
X-Received: by 2002:a17:90b:3bc3:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2f782d97961mr54700905a91.30.1737901559583; Sun, 26 Jan 2025
 06:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org> <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org> <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
In-Reply-To: <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Sun, 26 Jan 2025 17:25:47 +0300
X-Gm-Features: AWEUYZnFxTE3h5oGlTFfsjDcS8qwqMXrYDcf3-wEwsf_JzPpTAfdudBkbVsUmp0
Message-ID: <CAP1tNvTRER=QzC29Udw4ffOetVECWV+MfZ2o-mbUFvuZ0_i-Kw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Alexey Charkov <alchark@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello.

> > > I think it's actually better to accept the approach in Alexander's
> > > patch, because the whole thing applies to other Rockchip SoCs as well,
> > > not just to the RK3588(S).
> >
> > Anyway, I've just tried it after including the changes below, and
> > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> > pinctrls under tsadc, the driver still doesn't seem to be triggering a
> > PMIC reset. Weird. Any thoughts welcome.
>
> I found the culprit. "otpout" (or "default" if we follow Alexander's
> suggested approach) pinctrl state should refer to the &tsadc_shut_org
> config instead of &tsadc_shut - then the PMIC reset works.

Great, I'll use this in v2.

Thanks!

