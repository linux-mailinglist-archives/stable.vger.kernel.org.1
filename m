Return-Path: <stable+bounces-92019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4899C2E5F
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87C62822E9
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53319D8A7;
	Sat,  9 Nov 2024 16:02:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D79199FAF;
	Sat,  9 Nov 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168173; cv=none; b=FDWizjAulEt4r6U1SWs6DEwUGG75TML8B2NfkSF+J0IXAifvKnEPp4QdUXob8vfGNX6j+jJ9F1IsgXrDu10QBvaktWgb0oD0qkBi8V2KEIYCN1Es6aX0ieV7cXE8TmhClYKfGSzITlOjoT3O4hDwMDnxdjo+mAmwCNXwuXzyJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168173; c=relaxed/simple;
	bh=JNRz9V8zybDxy33qe+xTMatn1D6PMQo1GuPUrhcHyiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwf+Yq23/KHZkLQQ+zPIjCtnCvKybFqyq7BbhlWXzoYhKRtmwmPVYF5NEo8o5KWNzmGrzOi3pUMHO/nDHxEGMSYnm68d/iJEWV6suOPNjt6W7bJ7nYxltKCApba3u8KO/x3SYncGKtl+D/PC2fozopJGhGzKNRj9285kTo2gb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso24929991fa.0;
        Sat, 09 Nov 2024 08:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731168167; x=1731772967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oenLxzEzs2z/WFco/RA5EkTJEBkKi12h1iB/gMJYaSM=;
        b=da0X7umIZrUmfMo6X3qHsUFL4jX32tQKv754R8BH3O9vyJb4WkBx53toCxTs735YJj
         rNcPXIF0TiLr7mIpifSUxqj37WTQWSa0HzoezzlZSnfoGfyOqWyTE11+YYmMibtQta37
         1adwuQ4x7pCJZ9AW7dnME2LF6r61BzFtpjHFq+x9z4EeTfeZe6vcQamKqzbLxOLuYicU
         nVEGoNuEZFCuvSVMy0Reo4OoS7UJqZxbpymAJv6CDi2VLrCMP3CLGfhKPo13ZrtyRXgQ
         HyWt7piDirSELlLw662snweAZ9PhNSQx0wUrpip4YW+PuJ4U0NdNQnIDp9CZldzNZLTJ
         GfJg==
X-Forwarded-Encrypted: i=1; AJvYcCUY004uK6LTj7Flcn4ag+kjMeO2aNiRT5FDyGa/9iUxd0rtxvyUP6KYcmH4HDvcu3Dhlkd2D/S8@vger.kernel.org, AJvYcCUupsluQF/15+TwgiSVz3H1Qg6M1IWoXIHnRG2Hz//zIoEeX4SQ4nJ3szoOI4mL6kNg28HJfASaDVY=@vger.kernel.org, AJvYcCXgP8J9I0dYyKfnSn99IB3ZCn1RFcDRVvVKdp1w6vdeG2gpfPg+Ti30pm0onaF2DNT75Z/f6raT1OIYRKxr@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUUPLgajCiCIvnVZ1JKT4dzZ8jzpz+AN1DUi9+YAiOBHTmXG+
	AIbSbLKygcmjIuZJVuat0aq9DAFf08kFwiqALRATgtkJ0KH9rxJLhk6pGVi3
X-Google-Smtp-Source: AGHT+IEfz11JC21zkfudHGxEFyu8e5vhguXPZfIRM56UqOvqL0a2jDY87J4ZaWsFdrWNpPzfF6IXYg==
X-Received: by 2002:a05:6512:3da9:b0:52e:7448:e137 with SMTP id 2adb3069b0e04-53d862cd128mr2832464e87.6.1731168167182;
        Sat, 09 Nov 2024 08:02:47 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8c826610sm207543e87.266.2024.11.09.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:02:45 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so26452931fa.2;
        Sat, 09 Nov 2024 08:02:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFP9BfT3TGwVFdKGlIqriI7fz0LWFXRfqTkltRWHDXSBZyYEEesyNrnCjWyuN2GFxnjxlead8Jbfk=@vger.kernel.org, AJvYcCV2wzEblIMCcaj8xixwEqPJSthoySo3xQrEsLCDLmnNGVEyCv3urLmhgPG8raHOCIUpQkKPhrck@vger.kernel.org, AJvYcCX5mFzho/e1z+zaGBZMfAXn/0H18FohKqeeHv08nFO1GyrXSebHYA+tuYyYZRXpLA8fLWjI/djJWV70eRra@vger.kernel.org
X-Received: by 2002:a2e:bea8:0:b0:2fa:d84a:bd8f with SMTP id
 38308e7fff4ca-2ff2028a865mr26875221fa.30.1731168162943; Sat, 09 Nov 2024
 08:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
In-Reply-To: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 10 Nov 2024 00:02:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v663xMyiEx4BpPkuRew9t8fAgbz6EENEj--8Y57E87Lgcg@mail.gmail.com>
Message-ID: <CAGb2v663xMyiEx4BpPkuRew9t8fAgbz6EENEj--8Y57E87Lgcg@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: a100: enable MMC clock reparenting
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yangtao Li <frank@allwinnertech.com>, Maxime Ripard <mripard@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 8:38=E2=80=AFAM Cody Eksal <masterr3c0rd@epochal.que=
st> wrote:
>
> While testing the MMC nodes proposed in [1], it was noted that mmc0/1
> would fail to initialize, with "mmc: fatal err update clk timeout" in
> the kernel logs. A closer look at the clock definitions showed that the M=
MC
> MPs had the "CLK_SET_RATE_NO_REPARENT" flag set. No reason was given for
> adding this flag in the first place, and its original purpose is unknown,
> but it doesn't seem to make sense and results in severe limitations to MM=
C
> speeds. Thus, remove this flag from the 3 MMC MPs.
>
> [1] https://msgid.link/20241024170540.2721307-10-masterr3c0rd@epochal.que=
st
>
> Fixes: fb038ce4db55 ("clk: sunxi-ng: add support for the Allwinner A100 C=
CU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

You should still keep the version number from the original series if
resending or increment it if changes were made.

ChenYu

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-a100.c
> index bbaa82978716..a59e420b195d 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
> @@ -436,7 +436,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "=
mmc0", mmc_parents, 0x830,
>                                           24, 2,        /* mux */
>                                           BIT(31),      /* gate */
>                                           2,            /* post-div */
> -                                         CLK_SET_RATE_NO_REPARENT);
> +                                         0);
>
>  static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents,=
 0x834,
>                                           0, 4,         /* M */
> @@ -444,7 +444,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "=
mmc1", mmc_parents, 0x834,
>                                           24, 2,        /* mux */
>                                           BIT(31),      /* gate */
>                                           2,            /* post-div */
> -                                         CLK_SET_RATE_NO_REPARENT);
> +                                         0);
>
>  static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents,=
 0x838,
>                                           0, 4,         /* M */
> @@ -452,7 +452,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "=
mmc2", mmc_parents, 0x838,
>                                           24, 2,        /* mux */
>                                           BIT(31),      /* gate */
>                                           2,            /* post-div */
> -                                         CLK_SET_RATE_NO_REPARENT);
> +                                         0);
>
>  static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0=
);
>  static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0=
);
> --
> 2.47.0
>
>

