Return-Path: <stable+bounces-119415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB1A42D30
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939E87A316F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0723BD1D;
	Mon, 24 Feb 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni8RGp/h"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF922DF9C
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427044; cv=none; b=uCdgaeIvHb7OBaqgNCp13FWktMgOQvHNCWzJXHrrKInSDnFGXOBCwKA2VteRB4Fh+5OSn68CTQxytFNhl627ox9SVOOHMd3o4hZAS7KP7l+rBZh2wl4SoYXKANI7Uu5fUGwQjWKYLiSemrpKYta+pq0RGYPHx8MW2esS/F+97ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427044; c=relaxed/simple;
	bh=CDuJLlzBuj/3fmoBDS8v5Wx3cO3oqtn/G5iAqHz7QEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF0oDJD9HyRuvyW+dBk+5C5serCKHmTgxmbIduz9jifZ9tTl8U9Jm9Y9dry3lknQr8ESNvusPHxI+vzkPRxsJu6BmqcE4yUV6/xjhswA/yR65ystKMmsw7u3ckCERYYYViM8k2Vqb65G7ZwmKcJFURzFQTw1lOgamglniNE45L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ni8RGp/h; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dad00b2e6so3916270276.3
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740427041; x=1741031841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJE0/sfBAYyFpeapvbHG+qTDD6Fu2nTNP3MAIEqRYyI=;
        b=Ni8RGp/hvPVh3Q+9+B1Dq0U5m+Ru1iLzppdooTNL7LGkz3WSnMgvXohMPGb1MAFzp4
         vW8EJCpb3r2KmFzEQsMPheW8QcjMPBIXJKvZ1+ath2LnTYeBDSmZjsf+DQx8oChnQZ4O
         VOs5OIxyce2UuPB1NF1Nqq6vSmmgSzsk4o2tmJOONYVgUhHnfJ4WC7dYIXazXphR4Cr3
         W+C9zuF2jlGY8eq2VtjJIW+zu/MfL9lZecnK+c/+iJk5xEpDsgCDPQr0b7s1ebu8gqCU
         z/FBIKnAfgHl2NnNsSnJtk7YWU8WtIQ0RQSmoS0/kqG/s7gMZurQa83Xk9qhgSOtME6k
         5D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427041; x=1741031841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJE0/sfBAYyFpeapvbHG+qTDD6Fu2nTNP3MAIEqRYyI=;
        b=eLI2j3Bu2YusPbgjuymt/J9jMnJUNMpkAXNQgi/CWMusWkDe1Np1XNJssflLNjW3R1
         gsA99aMMJW5xx3AjePtugMP9PUOKIFAOR3yk076f8OnQLKXtJTYWgeQAx5I1JtJgMvNi
         RbjV/wVRvDLtiER9y53/8IDdvhOzc1ExVCnPexMK8izahv0skCK5HmOdysBpzvaYM/tp
         irNuARyaH8vrKOmRM8TbfzF1c59eWlLJozp2AW972mQpvS/aYSiZcX5DUatiQ6NCIdz+
         KI3iOQBoEqLPuyAEPPnpeZjrk30wxGOGDzqqby3XNiFRVRslBwfqcMr8pv6yQCooJcWt
         g1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0afAswvRxYTnCM+0N0CqSjR4tzpluHzO8Zqohr74BWP6/i7uL+LGn5XXnGCkvBRIUa/ml4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYRJECHZL+gbcxn+a6Mqyu3Njv3re3p9JPfu6uC57cGwnTnr8
	K4oBvdLxqSJv7+S0D/FD9hiv0ITQZYFqGhAeuJKb9MPeq77YXalyrLp/tbsvr5HE2ykdFh8ibMG
	FQIgAWheKpAscY0RQ3LM1pEy/aoP2k/HmjWrk7A==
X-Gm-Gg: ASbGncvlxBeuUEoqBKDFwHBHRfK+fIQ4p8VHA/rm6b7MeoxR3+XFfZ+3OK5T9SKzErB
	GU6wqc4d8LNIetp1djLTg9ly9PKzeldaEfrLiS0WkSM7O40oV+Dc3FIOL4Mp+/2sq25qwQkk02s
	hYYGNJcysCIC+rG9w2w9IA6eBsLmW4qldGd36W2w==
X-Google-Smtp-Source: AGHT+IGELIDMwjIBCztxs5836xqFuRiiPvU5KI02gA1b7TYU46jeylRaYFpxIGIqNf/544TC+dFaH1RhudEr9sGkaEc=
X-Received: by 2002:a05:690c:6306:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6fbcc39206bmr131218317b3.33.1740427041314; Mon, 24 Feb 2025
 11:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142604.442289573@linuxfoundation.org> <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
In-Reply-To: <9a18b229-f8b7-4ce2-8fe0-4fabd7aa6bd2@sirena.org.uk>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 24 Feb 2025 20:57:10 +0100
X-Gm-Features: AWEUYZlQ4PohouoGz9euT-b3auLmwSPp2vyoSdlob91LHpZWlNyBUXX55Rfeoeg
Message-ID: <CACMJSeuQkzvi5j975bbb6gF=+NMz0Aw-X5xLXR=8rMUjeQUoZg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:52, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 03:33:50PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.13.5 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> This and 6.12 are broken on several platforms by "gpiolib: check the
> return value of gpio_chip::get_direction()", as reported upstream
> several drivers break the expectations that this commit has.
> 96fa9ec477ff60bed87e1441fd43e003179f3253 "gpiolib: don't bail out if
> get_direction() fails in gpiochip_add_data()" was merged upstream which
> makes this non-fatal, but it's probably as well to just not backport
> this to stable at all.

Agreed, this can be dropped. It never worked before so it's not a
regression fix.

Bartosz

