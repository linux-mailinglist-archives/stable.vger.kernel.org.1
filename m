Return-Path: <stable+bounces-33060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397F88FA71
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39432A64EE
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389157882;
	Thu, 28 Mar 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNoneo1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CB24219
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616066; cv=none; b=EBmTsVihKc/DYXeRVXoBbbPmYMBGTzbuPUDCX1b8gAW8ewMKuG3ErbdfJ/n7AFZgfEna4kdPOFOkpilwsKfCViIR6e8X8Jrnq/bxzeIL4Xy05KXA8LJmZfBWKsCMYrANQGHtZ4RIAwFFEyYS5gZAgBW05LPeet9xGYPE6B3ulA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616066; c=relaxed/simple;
	bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otYPgbkwgFs0FhCgp4uSckEaQbIifIjXzwJXghDNLCIf92cQAHjIHa9MxgXqyr+HM6DOKzdx7sBa6Ko5q2Fsr1qATVYrfo4eZs2QWa0Yfixshf584RexTng1lZEH61HxxvfX2EWuaRtC1LKYusex8+H4wDBfH6oA1qcQVBFOppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNoneo1F; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso487945276.1
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616064; x=1712220864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
        b=DNoneo1Fj7zxFNbuc1qOPhyZp9+J7zHtQekpPFAJ3CeYrDzuNHbQgwA23vg0Kk9ooe
         yOAoTW8c4t2NXfP0nEgvJi+SZ18ir4Dgr9fe+DHXCAP3n7/AaGKV3AsBWMMquF8Zgghd
         o0AzPSDsf3NJWdl66zGG7IrJ+B08oWzdKVK9J2pld50CtKW89T3VhxfuU8ES6CPcPTZf
         z2JgCdioQM2GPJDc1xi7ttW1u99efaGaGR1D0DA4A3FkXJdlGhsDR37/hMXrV9vMfWj0
         YlzWlB80g3HATl7Bj1Op7N99uFka7E+uhpPKA9xJv3HCzJEAiOGPay7t4sULypRI1nMl
         st8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616064; x=1712220864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlwj5ZaYYOcJu8Ok+9hC2v+Yow7saE1lH0jHScZMQDI=;
        b=sRMOFAmdrFiXasCzcX065Mr7ylqMG/CdR1ly2UYaDFH64rGjWxOzIGMT8Db/0zI0CP
         9sfmQAddQ3WVZzVKCdGKXfS4S88UeMXJwk8hn1twJrzjECTsLT6JiZP5KdgA0xKpRlqZ
         PEvo43HV2e0XTrFXl0CNQiyvC+8Ko8FtoTiAgJiIokE3BVsm/J9BmKgQ+A1Ax1d/Ch7i
         wUK7rdIQetjehCeN8hfbUUXK3ywXf7Ibcuj3AAU0L2epvG2wh9Zs+1QNwFzO9p8ijOFa
         YrCywz5oFwrCDHuJF3E3gDLXTzELKW99dpp4icvqI7aa5XqDNgMCBTsU1dMB2u5GL7LB
         tiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2mZcMYgYmvDT1CtrINhhVILKwOaEydAY3TB3YW6+mwqk6Ri6GPieIt8QY5/igp295FbS8t26PQ1QPh0nSFXdD/4RbbWH
X-Gm-Message-State: AOJu0Yyd6sL5IjAgMpo9KgAaMVtj/zkukT90cHefn/KraqWFvGEyshX0
	1pYK6cB74o5xdI13Hzj4YEdMlPz7hzkCYrx7BQx/QHNmMgN0DIQcR1orjhLnJyQPbV7yabpql74
	VtfLti1432nUNrgRYczcQFR22mf5Z77HHiYz3dQ==
X-Google-Smtp-Source: AGHT+IFnSUR451w83koEnu6t0GdD86PwzKI9rPf82IN5plnY7aRqaMs5krZhIPZHIsEN9OJjmvCgwSqZqXhh5e+ePjs=
X-Received: by 2002:a5b:748:0:b0:dcc:32cb:cb3b with SMTP id
 s8-20020a5b0748000000b00dcc32cbcb3bmr2632651ybq.44.1711616064245; Thu, 28 Mar
 2024 01:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325090242.14281-1-brgl@bgdev.pl>
In-Reply-To: <20240325090242.14281-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:54:13 +0100
Message-ID: <CACRpkdZf5-QR0aU+jhqpsCbNbD+57TN6Yq_Naq8JoLSWSsM8kw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: cdev: sanitize the label before requesting the interrupt
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:02=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When an interrupt is requested, a procfs directory is created under
> "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> the request_irq() variants.
>
> What follows is that the string must not contain the "/" character or
> the procfs mkdir operation will fail. We don't have such constraints for
> GPIO consumer labels which are used verbatim as interrupt labels for
> GPIO irqs. We must therefore sanitize the consumer string before
> requesting the interrupt.
>
> Let's replace all "/" with ":".
>
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a=
726754@gmx.net/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Good work on this one!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

