Return-Path: <stable+bounces-178967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23293B49B65
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 23:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1752D4E035B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E162DCF57;
	Mon,  8 Sep 2025 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlQEe33R"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC592DAFBA
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365426; cv=none; b=tiafVuQUdSB+TvS4K7LupPy2eQqd0rZlkatV4TrR1STpGc3FnH/vlgeB7vVOYvREiJcIbUCchuLdN48WIGmHeICXE3hCThkoDAxTOK/v6pFkg7YQgVJE1PDhdt3wsSm3iSfBvJzWvRJ0gvTqAf44/q0F942iCNXAlLjr3JSwbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365426; c=relaxed/simple;
	bh=qy3RayiwfBU1/zuQfXQ+IdwaYW5zap/grmBI6ndAc0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEiM8z0orOYdK/ein2aBue/LplDibsAaSYx1LY8K4MTknb5Lb3kRncmu5TmB5THgxgbM+NjhXWYM8kt7bRB7lwAxG2ksI2nQUz3E/tXTaIw+88GAUb+RA3etYy2N1Uz7cNUWYsfFOrv9XEr2Cwami9L83n7VOD3BJVMqo/SDIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlQEe33R; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336c86796c0so39542471fa.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757365423; x=1757970223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy3RayiwfBU1/zuQfXQ+IdwaYW5zap/grmBI6ndAc0k=;
        b=BlQEe33RIgCtJiDnzcPdrQWY1FWMn+GP6czPsmG4gyF/MCbHQ4mtN4YtkMVYBxu3dj
         gZmCC57E0tCwmnJKd5r3e8OMgv0NlSj/ONlAN84qhYWErssml+bpykluv3lj0F6xYWOe
         QLCZmutQgbm2OQ4/SA0ULt9BwtV2f5YEu7ab+9fPNRcxwW5tU98WAwm1LDZcRBeCjI9U
         wa2Mx1H/jKUuMNdOAQODc0TJO/SGg5FOe7mc7hn9SO2L0ydnR2cZKvVR2yIKIUY2YUQy
         ZnLiwkVGyj4qJtuS2B54clhWbAE6BlB031FLanbXHzajwF/lcYE/TsxdB0wbaQ1HwxWK
         haxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365423; x=1757970223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy3RayiwfBU1/zuQfXQ+IdwaYW5zap/grmBI6ndAc0k=;
        b=jooHkL2JOrhwxiSCBx+LY25OhmbgM2OVz2dZDMd1iKq2clVcb6ljQ0CpmWw4YAZvYW
         lKTF0SN3TYnYZ0CGzf6MdDPsMn4w6GDBNFTKfjRRuBtHR1yvnEIm6hIGriQjuo1qlMbt
         2cTr9DWCz7meoaR3a8FqYtkp9MXGPXkt29ksQa5o2Fkbdb5Gfc1LD1OLwMnitA+zH7Ao
         UIaBdoeKK85NskXGDM4Pf3WkQvJtkoKot6pdY5aC+/7Yd7Mt736KovdPao4Al5d5x9n7
         csxiDqcKzUnHTdVoRQ5O5V8Bc3JtlbtAOXNONTGbVIroPXR1PH2cIUTVR2zgimGkffOd
         pGDA==
X-Forwarded-Encrypted: i=1; AJvYcCWddPLV5VU6TM3OAyyJfvJP4UE7IqncbVvJUJhvP+Y17tuhZOLVSEojww4STFmXdTt6hRScQ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGDhpHLDAJg5k849/bm9b0YJEZIe+i9mhMHeLGxisKeeQsiBw
	E09wfn8W8KGWn7xGCiPjBdvZfVa9AsSQU6WIw59rbQqZHtXEFgeIwsg6uj+/riP1mIwJngiDEsC
	d2gbGBj0hx8mQrUxmyc5ADtgymMHI8NjQgRtmRDlI/g==
X-Gm-Gg: ASbGncuk+EL6w40oCO2CgP7t93vz72JLLdqe2q9EiRfGIf8vwYp6krNMBlSJ3poq+lA
	oQDfkMjEN6k4FgxiMyZdHBG7mQDeS74ZU/N5OWDSZ6kHZygQwYRRJGATl7D77KgVjDKFNf+Dtik
	P/+80V9WN7L+nP9AyXURGKA2j9iiEGRJJmLXosd7I7tYXhqkz0XNZFXy1qxpfYpkecaA3EixrDa
	YcK8gVQqeF+NMAWLQ==
X-Google-Smtp-Source: AGHT+IH8+J/vFeWhw9eoYEb1/3GvltvNA5l3205lsYcHvwWXC67kAnznt4uB6zdL3+zg2WYqt7lJoZenJW0OZDDgeRI=
X-Received: by 2002:a05:651c:4358:20b0:336:d915:cc5c with SMTP id
 38308e7fff4ca-33b4fe4da4bmr23851571fa.3.1757365422821; Mon, 08 Sep 2025
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908113723.31559-1-ansuelsmth@gmail.com> <583981f9-b2ed-45fe-a327-4fd8218dc23e@lunn.ch>
 <68bf16e5.df0a0220.2e182c.b822@mx.google.com> <d1bc3887-5b88-4fb9-8f89-4b520427ccdc@lunn.ch>
 <68bf2b2d.050a0220.7d5a6.b11c@mx.google.com>
In-Reply-To: <68bf2b2d.050a0220.7d5a6.b11c@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 23:03:31 +0200
X-Gm-Features: Ac12FXzsPzr9I2HjnC5t_HYUtDe_Oo71i-LHOVM3Q5owLY6JPkPWVDiLSF9uLf4
Message-ID: <CACRpkdYuT0x3JSFWHMF5thH0UyNF1Cse+W9joE12yQ0iAAXjuw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: airoha: fix wrong MDIO function bitmaks
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:14=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> The usage of GPIO might be confusing but this is just to instruct the
> SoC to not mess with those 2 PIN and as Benjamin reported it's also an
> Errata of 7581. The FORCE_GPIO_EN doesn't set them as GPIO function
> (that is configured by a different register) but it's really to actually
> ""enable"" those lines.
>
> Normally the SoC should autodetect this by HW but it seems AN7581 have
> problem with this and require this workaround to force enable the 2 pin.

In reply to Andrews comment I copied the two above paragraphs into the
commit message in the applied patch.

Yours,
Linus Walleij

