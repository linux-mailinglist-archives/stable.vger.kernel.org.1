Return-Path: <stable+bounces-25294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9386A054
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 20:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF601C23376
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEB2D60B;
	Tue, 27 Feb 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rB8m1HS0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6842511F
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062696; cv=none; b=YFrgvK/L67W+OIvBViDaVIC/v7jvDW2LUJ/OYGuatpmLlSLkn/lZFAWNi8PPSI1vHajhMV0d+s51uV4FylPNri9GLKj0eJCZmyjrd0/lDTlaFO32jw8Q6PtGmiuB5DUnQFbZTgEnkyEHhM9h1cF79Lt+OkcvSzscHwXG8xVnKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062696; c=relaxed/simple;
	bh=uXGgIR6AlyuVRK/MpaWhS5RpNMdPXETDnhac0JBD9Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecXUq+6qXE3id3dEJz50f1GpAlPwgyavX6RN1jVs8N0VX865VoCvmMQWIa1+lGp1if30jwv3WXpDndWE62fZmqH1oO9ylETAAnm5mcQ7sgcEY13qBs3pDL7sM0CMj3amUfKXqORT1LYLDE+q8zugyrvTyTf4LeYtdFVyK72Nvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rB8m1HS0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4129a748420so11835e9.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 11:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709062693; x=1709667493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oshdnUJfJnWYqjpxJrbBngXlFKiFKoDWj+mV4FoHF3Y=;
        b=rB8m1HS0Uu0OLl4vqgIAu1pZrYLJtWm4SgPT+c+KeckLPLWCJBEO3+Yd36zGe5/arj
         qMOqrr4yK6v9c6oEuwkhgXJ6f8Pr5HiKRQu9Od5yZuUjcloS/HRaG/iOiu53Qs/ECXLD
         8vg5e1XYWMOBTuRUezl8OmVEekfVtZVZQJWRdQvRF6MtRdQM0zyFQKzvx3fuz6vAsCiG
         +ZyBZB1JMfijrRsm45841cqJ3L2jeoYmqCrtRCQsbT7nkJvFncFQZKDw2dBtcSIXGn6E
         Hubn0InxTjiOLSSQuYi8e2Ij9vmmDHbN0jzo+OXXkFD91M+S0PQxiljaZGcY4e2sfQ0D
         WEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062693; x=1709667493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oshdnUJfJnWYqjpxJrbBngXlFKiFKoDWj+mV4FoHF3Y=;
        b=UFCsHM68lD9Fv+jMZ9QUtRCpVxc2DkFqH8u3IV/ZQfvD1ELejLWKAMpt6tnXiYikII
         sBHOLbhCAKNWZPP1kgclF4SqoOzyR1xEO+jqHLhvTp4RWJ51T36m6PegWC5sX78p3cYU
         DjXnRSWzdJeGG2FN4dBX4gDpGpI7ntB8Y+P9V1l2kp0vt2l8LL/8BMIYKLJeWHfdCdiQ
         Bd2YqkesUM3V0eNMZk25WLzNrlxJxd6OEmr29vBDv/Hht4egyRhLPrZxW5ihCLe+fiXa
         BXUBqbUUehBGxY0laMvQ/h02bo/cn6ussBI6Fr56dQVgSLcRT7XrkmgSlA+iGSKJeUrc
         44sA==
X-Gm-Message-State: AOJu0Ywv/M0z1cA9ODBVnnUdkBodmbErzpplZ3+K1d7d4k+Y5vDlYRMV
	Ez/fzqo8KvevKMDLnIZtEPKIWcn9hejag4dFv0umGBVmW/QG5+6noENtMq+pxyz3zKp5dqi63wp
	Ee8/DhqT2GHYpQjWgABDXgKp/QI+pJytlfVw=
X-Google-Smtp-Source: AGHT+IGgE7pybhMGkAZbJpOdx6GdA8Gm2qtbM4A7vr/iWITTqkgKV0bwFGCof3F2RyX1iI9NK48sH3pjL4VfXaAkawU=
X-Received: by 2002:a05:600c:a3a3:b0:412:9829:2dd5 with SMTP id
 hn35-20020a05600ca3a300b0041298292dd5mr231716wmb.7.1709062692681; Tue, 27 Feb
 2024 11:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131552.864701583@linuxfoundation.org> <20240227131554.144760148@linuxfoundation.org>
In-Reply-To: <20240227131554.144760148@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 27 Feb 2024 11:38:01 -0800
Message-ID: <CANDhNCoGL7voc11QFt5rBXXibMSvDM2YxZ8ocV1fkGYh=Mm0nA@mail.gmail.com>
Subject: Re: [PATCH 5.4 39/84] driver core: Set deferred_probe_timeout to a
 longer default if CONFIG_MODULES is set
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-pm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Bjorn Andersson <bjorn.andersson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, John Stultz <john.stultz@linaro.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.4-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: John Stultz <john.stultz@linaro.org>
>
> [ Upstream commit e2cec7d6853712295cef5377762165a489b2957f ]
>
> When using modules, its common for the modules not to be loaded
> until quite late by userland. With the current code,
> driver_deferred_probe_check_state() will stop returning
> EPROBE_DEFER after late_initcall, which can cause module
> dependency resolution to fail after that.
>
> So allow a longer window of 30 seconds (picked somewhat
> arbitrarily, but influenced by the similar regulator core
> timeout value) in the case where modules are enabled.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Link: https://lore.kernel.org/r/20200225050828.56458-3-john.stultz@linaro=
.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/base/dd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This change ended up being reverted upstream in ce68929f07de

Is there some specific reason it got selected to be pulled into -stable?

thanks
-john

