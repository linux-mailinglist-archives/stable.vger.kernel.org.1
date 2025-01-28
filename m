Return-Path: <stable+bounces-110958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA4A2088C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8E168112
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011F19CD13;
	Tue, 28 Jan 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU2v8UIV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BC19340D;
	Tue, 28 Jan 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060220; cv=none; b=E15hRM4Zu5J6Ub3H2wcFBgGhKv6DOdvtRVZTEY0ZT91ZKloqeYDMu+DvXIvJ9O6PTQtpOsDKt/3sOO4rsT+OyTHISWIczN3ALQzjRoeisdSPeQw7qLOvc/JGasdoHwEp9z8bZwLyv4rlNQP8f9GGkaiW/iuquSrCBK+eXhQ2OZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060220; c=relaxed/simple;
	bh=2veFNGdTL1atZAhB2vrZxwxXadzUoQya1iQSnNw0RO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzE0WhFq6jpVtO2E0wJlGdwNmzcAz3qoj4C0SHAJdX+ZqgyDhVnFVypb3x9fENrIisJSUOXWbVeTAGLJBYd/1T1/7QRuhtvZXjPzuiRinoLPMRw5jB3cyl2A69m2okfQ5MRqM67a6OKxW6Cv9Yvwvm9bjtlgSIb0dE8L6meYxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU2v8UIV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679eacf2c5so52876761cf.0;
        Tue, 28 Jan 2025 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738060215; x=1738665015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2veFNGdTL1atZAhB2vrZxwxXadzUoQya1iQSnNw0RO8=;
        b=DU2v8UIVHvrdHZKnwMiYzrFwg2OBQ+tVBMyvd3ypfDcXeK1B6b51WR8/MzcpbspA8f
         N+2anIpkTTfu2l0+IvfyQkJCGuDHVEZnim24zkhD+P54T3C6tgLKlZ8stXGE9Z8oruqu
         XZQEatCQIxaolt/6l/RFQWDOC1+01bUcV1smaEx6e0b+EriaK8IYGk2VA7rhoQ3sx6og
         TSJzPp3Tz2zuTkvQB3Myon+mBmkXhv96b2PRabaDBJ4IwJOsYbD8m21FC+bi1PUywO9R
         TK7vGffxtzcBFbilqQ1EXtKxMbZ/ri8/hu7qoShfqvgCwIzbGgjFAa4JUYFa6lk+vAAl
         T9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738060215; x=1738665015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2veFNGdTL1atZAhB2vrZxwxXadzUoQya1iQSnNw0RO8=;
        b=rEmkTyEwe0/cQg5qmWdbPx27Ub6HQYHcE+k/1CPdgFcF2hH0KYN3RRDixYExGv9Dt8
         cT/4Sk7/3zUXauk+V7RnQFjavoamz7I9tNupqJ0m4uHjT8bFQ0lFq9HJOrLogH0ASsbi
         AWKhRb3UMr6k1TS6P5wodMeWECXUeWmNv6D9ftIcRN39mr0hUWsgCbtZII4yQulYdMDn
         XRwYNZHkxHU0VMS95zQ3bw86LsooVS779XK2OX7xnZLY7uERKTOGgGpI8fqg0tW134Ve
         27xNOOHG180/920ncqOmpYhv8SRLoSeQfKzRAdVIurkOyvtwcTOjZBIbwlebtAXW3amv
         tG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjvZdu2F0GVFsYqsezxtBtcVjf7e5jWd1nxcDh7Xce5ITdlREONNM90I+oUrVsp0hqAZWrAUmr@vger.kernel.org, AJvYcCVjnBoGnHFrUVNMBvtMxo/XMRdXr+pFb4EXR6dLtJpksOpP9KRGcQ0/PVf1bV8hn1FP4guxcHuAVxmr@vger.kernel.org, AJvYcCXBYvUXJovPnrJouaH+LQMHV7aBxTH9R5jGTTt4WEPogCEFYfmCD902GDEKN5hzi6x1quV9m0yV99joqWxr@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjX7qeMtus9mCkP+OyZpTbkkXx+0BbgniYPxg4rRceMSikI92
	x3/80ChEi4PHh9kCB3zcIiMnLsltUwfAvHxfJE624qwdV8TnKMKnQdwpdR/uNVTj6ww/zh/F67n
	RVRJ/a0aqtL8Oykn+iwVSjjqtMjs=
X-Gm-Gg: ASbGncuJdYvgSaaUJPKlAC1OV4WR9m725PJpI79v1aEW63yO0f2OO4SEKekLb1WBBEa
	XvIGjTMxZ4iVaORHEWRNP96/GyMoDanE5MQtV/RNCgVxjkfTJBK3AOqv4RRCjDqMbq6F7iSOf
X-Google-Smtp-Source: AGHT+IFptAPSbmWwcq0EvSGs9/WQk9gEFjx4eFpUlVUg+jaJrVO+3/mHFzqrzQpEkuhDpBlIt/Oq38oTIAXUASFu73U=
X-Received: by 2002:a05:622a:2d5:b0:467:87df:851a with SMTP id
 d75a77b69052e-46e12a56380mr637928261cf.12.1738060214750; Tue, 28 Jan 2025
 02:30:14 -0800 (PST)
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
 <CAP1tNvTRER=QzC29Udw4ffOetVECWV+MfZ2o-mbUFvuZ0_i-Kw@mail.gmail.com> <b57d8a834f5c07e37e0e7ee74346c700@manjaro.org>
In-Reply-To: <b57d8a834f5c07e37e0e7ee74346c700@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 28 Jan 2025 14:30:03 +0400
X-Gm-Features: AWEUYZkFoDxmRPVn24plApRoTji5kgp1WG-euAKTrUa39_3kburtp9GexnHZUNs
Message-ID: <CABjd4YwCH93-=Cqck5TiuJoTUkYbRh0495J6w=J8t93oHdt43g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 1:24=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexander,
>
> On 2025-01-26 15:25, Alexander Shiyan wrote:
> >> > > I think it's actually better to accept the approach in Alexander's
> >> > > patch, because the whole thing applies to other Rockchip SoCs as w=
ell,
> >> > > not just to the RK3588(S).
> >> >
> >> > Anyway, I've just tried it after including the changes below, and
> >> > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
> >> > pinctrls under tsadc, the driver still doesn't seem to be triggering=
 a
> >> > PMIC reset. Weird. Any thoughts welcome.
> >>
> >> I found the culprit. "otpout" (or "default" if we follow Alexander's
> >> suggested approach) pinctrl state should refer to the &tsadc_shut_org
> >> config instead of &tsadc_shut - then the PMIC reset works.
> >
> > Great, I'll use this in v2.
>
> Please, let's wait with the v2 until I go through the whole thing again

I, for one, would welcome a v2 that could be tested and confirmed
working with and without driver changes. Especially given that:
 - the changes are pretty small
 - hardware docs say nothing about the difference between TSADC_SHUT
vs. TSADC_SHUT_ORG, except that one is config #2 and the other is
config #1
 - none of the source trees I looked at seem to enable PMIC based
resets on any RK3588-based boards, so these pinctrl configs appear to
have never been tested in the wild for RK3588*

So trying and testing seems to be the only way to understand the best
way forward. Unless, of course, someone from Rockchip can comment on
how the hardware works with TSADC_SHUT vs. TSADC_SHUT_ORG.

Best regards,
Alexey

> which I expected to have done already, but had some other "IRL stuff"
> that
> introduced a delay.

