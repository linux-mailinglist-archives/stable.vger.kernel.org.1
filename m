Return-Path: <stable+bounces-89134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E989B3DEF
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E851C2108E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF71F4265;
	Mon, 28 Oct 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfRDIAEW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AB1E1C2E
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155329; cv=none; b=tMUN8m76rwao0F1xG0RKZSbJhWFSzQYZbqVIH0d4ZtwbCvat7M35OXPlf4ArsgQA79Q5LR9J1qD4BRjaIDf4Ge9kI9W4PfZsrmQD8utEqYhAFPHArHz3wDAzF+1GPgsIS3WHiR2jKc2ZgrMwZmYSU1sWa9B583L2mWeV7dPUY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155329; c=relaxed/simple;
	bh=AYLSk03sy13DZ5QB/3NhRsbKu0MswGH4SuUJv0OP7+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrk42krbHM0MBb4Q8lytWRBp3HQNcbl+JsEUayG8SlXI2WqSNsgHSVKDFXwaqyEEFexc4G59gQMWjgUYD9OyO6RVAnt/WO4v3yCU/SJ+hL8/rePsMDqbHEB3/Clg8S4cLzh87Fga4htmPByYw9/39A/VdBKG6qJHDotrA4W4O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfRDIAEW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso44709761fa.0
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730155325; x=1730760125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYLSk03sy13DZ5QB/3NhRsbKu0MswGH4SuUJv0OP7+4=;
        b=bfRDIAEW7ksPV7ZbNmx9y6gqRW0pc0T91RiNs6NJJZv6kBSYoRbCD6rC6aHwMKONb7
         r/xqaRSJ3SU2OWunqIznozosSDBbbGnY/cAbSlgcEJrCF/35UC8vik8hiW/aVtA2aeLd
         MuiL+GPkN8qSoWEbj73a9sQ5e3afvHDDbdpCSk8Khz9Ha9FF7DuHNxVm9b8C66JPuz76
         WtAgzXDEa4jzc6uPvn5gXqtb5plfOK9PXUayuR4u/LyZxMINthpABxhd8//X3LI9iXck
         ZJYi5JXK7JjGvnsXa3HuoboRN+GMgoYylDDd3TxW+dR/GsosSK19oPqTCI5ZVZTw8wH2
         0dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155325; x=1730760125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYLSk03sy13DZ5QB/3NhRsbKu0MswGH4SuUJv0OP7+4=;
        b=F3G0jSrvAW99dNZymfWCvlnzMGBVeMzZ//qPL9UbgdMOMQPyj8OE8nq58GE9nCUniM
         bZU62GvvqtoQp+WE0uNN9oQ8pxKuCpYjyT+9H5hXPWrccRR4iDPHsyrPpGa7b9ZKMGld
         D9hXVQXcl4jWXfcw1zNb7nkNaIqCJheTbvlZvUHyeeBEiFs5THUZaKwSdMuzJ4mH0ZQZ
         lML9YmxcURiyy6Iqx98vKqHoYhgxIEWr8B81kcyfhxqCZwapl496uQJQ1FAF6VKqkrzw
         b76eVFq6q9MiWS2nrfKgvjqhprPESmIbia/wMfl/NBr5tEhxKvMQUQv0SpJ4xQimq716
         D4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXqeeh3iloGemR7v/FX5ZmAG/3BNJiJVXmEgYlUUAmO2cOU4+87uwpZOKmzCDdWCNa2nqTBVrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5v9zMN4GoAd4IVa248bgFJ66FkRdSaRqT4uv9HSarjllspa0
	4li4iPEquG9Ejqdy3v9cZlvvYiqyJOAZwYsegvSBCI4q6t/wFR2bu4YNnZr6DjYWmR0HImrG4Pk
	gnnSW5ONRensRRAwBD5iMWTuaWvdjmYKgDwN6YQ==
X-Google-Smtp-Source: AGHT+IEg8JVfjXJd/ucT4jDduwHOoGxeFrwMNbyZhgEQKzFwgAbPlV0NnwUmDCq5NLL+EdCc1bSUIXxZA8jFl12JEHM=
X-Received: by 2002:a2e:b895:0:b0:2fa:d354:1435 with SMTP id
 38308e7fff4ca-2fcbddfa6admr39806201fa.0.1730155324821; Mon, 28 Oct 2024
 15:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-comments-in-switch-to-v1-0-7280d09671a8@linaro.org> <20241028-comments-in-switch-to-v1-1-7280d09671a8@linaro.org>
In-Reply-To: <20241028-comments-in-switch-to-v1-1-7280d09671a8@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:41:53 +0100
Message-ID: <CACRpkdbo=raavMALT4JtFG7L_kT5dDdH=E1KGCG3Nu5L5NahOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: entry: Do a dummy read from VMAP shadow
To: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:39=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> When switching task, in addition to a dummy read from the new
> VMAP stack, also do a dummy read from the VMAP stack's
> corresponding KASAN shadow memory to sync things up in
> the new MM context.
>
> Cc: stable@vger.kernel.org
> Fixes: a1c510d0adc6 ("ARM: implement support for vmap'ed stacks")
> Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b=
098de9db6d@foss.st.com/
> Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This patch is already in the patch tracker in it's final form.

This was not supposed to go with the other patch, apologies.

Only patch 2/2 is new material.

Yours,
Linus Walleij

