Return-Path: <stable+bounces-115125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D372FA33E4B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A31692E6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7672063E1;
	Thu, 13 Feb 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4UojPQA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33C205E35
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446946; cv=none; b=eW1/i3XgVKuqcQIueEkChGNf+aXbqzq+co8IX6Qzgio+kMMKSX14SWd6PamLZfByEvkeITUCQJmzoUsmzAzjxBjm5lmFZfRHYxTOBqEeh9shCD5YSuJ1ZrRU/6AQt3ewZgES++uwtDUDm7sQcbYo/vjLMl5yOEu1VUoju4N/1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446946; c=relaxed/simple;
	bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj2y/2vJQwoPYIT/xWYUqjw/G8hBzkjgyr1GwVkICIzx7iFP7hjmf6zyEqJPUNoo7kKLd/yz0pDUC1kMe3qqJHM645xIxljviRJ0f7u37bz8sb8koBe1Cl1z7IPhz/73Badn6a6eWWX5jbrN6nIojPCeqbFvElMSQnt8YI1O0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4UojPQA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-308e3bd8286so8280651fa.1
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 03:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739446933; x=1740051733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
        b=v4UojPQAMD2fWxiPP8mzpzQHfDscFWzdBQ3r1lj7WRb7CBo7hPB2beE0NmjP2llnvy
         6UC6zwgC/UqOO6V8UVQ+xRZXurNfn75l/b67DTR+lQZkcSj8TXf27Hd4XRAsJdrenQzT
         7MMq5OTjEDRzNMid6IewJ/siDJ4dJP94MLZ1DOqqNJ/zOyf6gNDQIGdwKsV0M9pv/JaH
         oVb7S3ia97p+9AXyP6nJ1pzJjz312qC7d5WLJf4S5p9y3q29IpGTycNRmRfdebRoAqwW
         CS4mOb+7izxfRUrJG8BEvphqqRgOi3ycJLx53e2ylyHaLEaCTFfS7s50ojE1TzE6TId1
         4YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446933; x=1740051733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
        b=SzM5SF3j5gxJJbPP8iGNSfOOI7ih76/VB63kQ9ygNS/Bm/44/ddYz/XbV2rPoUZgiq
         fANXIj7+WnlIUkIbHbjru914qT9/hX1FplKOmIgWVpwPquqk42rM/zucvZc6Yjujqv7V
         jjTX18EANIm3mR2Cm+kQEJl/7deFR7oBCVscDkHujNvz3syV314X/YKlbg48uPLD6NEE
         oNvl7JkxTSJyUD1w4+jSVUPk3QeQcwNpj0u9DOT9NlnvAWvF7k9JsNVgwpwsFDB6Aern
         R5u41KmqFwUi1ojH+o4FkgfL2Lj8IG/Wjg7sBjkek4c0BtXrR/qXHtSSwCFYheYbOAC1
         z4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx0Oh1AoFyzaBdGSaPROXNy8TiTxjYBv/HrOjh+qsBqzicF/UInLEYonHfcTSUMDe7/wgMMGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkaqHbAL/SMbBgWgzj9PMsEWIGYWtGezqE79JxLp/hGC0nKFh
	gqSEIV7dQmidHu1dVA7bgxKDPZgrNOaSPGmcaKfgm4yqVw2zoEwYsWvHeU+cJaHT7PegShJJ/us
	dzdDDCvai7Ua7ksqsYdmK0lttPaqLupsRFMwldQ==
X-Gm-Gg: ASbGncs/IrePlSuNoxT45uRLfr8tJx1mCxi2b82cjtdSxS0q/hXiO9C7ChSgOWN1sLy
	OeK3OZml15ASX7+DAawiZdMSXK6Vg51Y7axmw9lAyp5bw00Z9GDrVDsWdGe8OIoZK6LXQhFXs
X-Google-Smtp-Source: AGHT+IFVHA1GVeEKScMhYxf6Sfu4AeJhCGGmNc0XDmJ4H8gjxLKVfGQw8pEnoDX3laoXTfatQUM407vchatoIxg0pdQ=
X-Received: by 2002:a2e:8a8a:0:b0:308:e956:67d with SMTP id
 38308e7fff4ca-30914801652mr2362081fa.4.1739446932739; Thu, 13 Feb 2025
 03:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927135306.857617-1-hugo@hugovil.com> <f9b0cc53-00ae-4390-9ff9-1dac0c0804ba@linaro.org>
 <20240930110537.dbbd51824c2bb68506e2f678@hugovil.com> <16bd6bc2-8f10-4b99-9903-6e9f0f8778d8@linaro.org>
 <20250204124615.4d7a308633a15fc17b2215cb@hugovil.com>
In-Reply-To: <20250204124615.4d7a308633a15fc17b2215cb@hugovil.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 12:42:00 +0100
X-Gm-Features: AWEUYZneNXsSWxPyTfgj14jjDig6RDBsUd0vsFJ1m0e682t0ZDeQHJQZeQ9X-9I
Message-ID: <CACRpkda+jac_7KKQDs3UcfODP6kK3W03Q3KtVOCjRV+wo=M8=g@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: neil.armstrong@linaro.org, Jagan Teki <jagan@edgeble.ai>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:46=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Mon, 30 Sep 2024 18:24:44 +0200
> neil.armstrong@linaro.org wrote:

> > OK then:
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> Hi Neil,
> it seems this patch was never applied/picked-up?

We have some soft rule that the reviewer and committer should be
two different people. So if I do this:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think Neil will apply it.

Yours,
Linus Walleij

