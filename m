Return-Path: <stable+bounces-208066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E779D11D70
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3983630204A7
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9982C11D0;
	Mon, 12 Jan 2026 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIF4qtnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DC26CE2C
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213186; cv=none; b=lBaSnLDTNaMAhbarUA2/QyhOM8Q1SPlZBtbm6CqbGwxy0XK+mvbVm4BmI66JTPtVYYKFU6jFi1yKzz5BbEbYsnuyibg6WuZO0lNGwMf2aEU3b00SbnkGIBMmqrDwprEnw7mPH3PTa+QGOZOTZ+qwTzPzEDih4sdI2dzPQ0w+nLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213186; c=relaxed/simple;
	bh=mpHsurIEdPYadW7Lg59kWmOqVjn5Iy9JXKIzI3XTzwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYjXKD0z8XCmyiIV5AHCTFSouHM0dIO5uKkEcuTv+21IHTqZF1xydgjAcF3tpHtr4ZLrhYe28J/de8ot6mZsyAgQU5mLc7tQX7TbsTe6rwzZOp5fo0/jgQBRucIwz1A5KDSZ0ocamtN+EGqlL8iAkQBLbpqvveJOonVWthr2JCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIF4qtnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767D6C4AF09
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768213186;
	bh=mpHsurIEdPYadW7Lg59kWmOqVjn5Iy9JXKIzI3XTzwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OIF4qtndwhx6ox5Dstf3eWBqEChLy4I+W1/ukObSQF+azRkOpCHvdrAKbUZoNa7Uu
	 U4SeqAwR9ixOQ6y7TbaWD+/s97Uu34fb4t9BKU+9/cDDj+lF+kjhi5RcsayJEqgfNF
	 sLmBnj149FwiXdZ4pPXR1PvZgFWBSXBQmNyedSztPMbIuhTeS8627AJfU9RGz9J865
	 kxF3wE4qq5tIRx7MRHysPKoHn0LR0i6XmPTlekD+uMrKiJtt8NBEG2rovhtTA8uDk9
	 E9PwjWslVwo1U2NnqDHlP7d1WpcRwoKxxcaEpavJCvNKJE7WP8RZWlBSWyHylNzTQk
	 NzoFkjkCzHRzA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b679cff1fso4957572e87.0
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 02:19:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtnvYQzy8qs93afEU7S4oKtUE9G0r3LGgdtAIy+zZBs3Y3OQ/UyIT8CcInzl/1CdXAVnf4R0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGqwDmGExsNeRxDh3PSex5VhIJxsTKX4+AQTE5oPzdqzb6ROb
	l7VIJPi4aixO6LZUpcDDgZUjUQ43gjZ+Wd7Q+15XRuLm4NJWQ5ptnkSdTtpIclKNbNtWfXRfCNQ
	oGKXd/x3mtfs2O7lnusm/BikbaOnP3B0LYy3NugS49w==
X-Google-Smtp-Source: AGHT+IHo9rVqAqhcFHs842IBMT+s6LC5/G+sijW81Ea7j00kAiP5igS6gSAeyVrTz+vJ5rvuADq+k9q5s0GllwUPRBI=
X-Received: by 2002:a05:6512:3b91:b0:59b:794b:6d6f with SMTP id
 2adb3069b0e04-59b794b6e03mr4097051e87.42.1768213185034; Mon, 12 Jan 2026
 02:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 12 Jan 2026 11:19:32 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdX3Ba57bSe_+ZeE3HNLJW3TAH-WmUmdmU16br3ooEcRA@mail.gmail.com>
X-Gm-Features: AZwV_Qj7IcXNTs9Rm4bkdhhuuaDkqzUsmZQwB0PwXU40MQ3jXenpAGgQ0nc1m60
Message-ID: <CAMRc=MdX3Ba57bSe_+ZeE3HNLJW3TAH-WmUmdmU16br3ooEcRA@mail.gmail.com>
Subject: Re: [PATCH] reset: gpio: suppress bind attributes in sysfs
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 10:47=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> This is a special device that's created dynamically and is supposed to
> stay in memory forever. We also currently don't have a devlink between
> it and the actual reset consumer. Suppress sysfs bind attributes so that
> user-space can't unbind the device because - as of now - it will cause a
> use-after-free splat from any user that puts the reset control handle.
>
> Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/reset/reset-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
> index e5512b3b596b..626c4c639c15 100644
> --- a/drivers/reset/reset-gpio.c
> +++ b/drivers/reset/reset-gpio.c
> @@ -111,6 +111,7 @@ static struct auxiliary_driver reset_gpio_driver =3D =
{
>         .id_table       =3D reset_gpio_ids,
>         .driver =3D {
>                 .name =3D "reset-gpio",
> +               .suppress_bind_attrs =3D true,
>         },
>  };
>  module_auxiliary_driver(reset_gpio_driver);
> --
> 2.51.0
>
>

Hi Phillipp!

This is now reviewed by Krzysztof, can you pick it up, please?

Bartosz

