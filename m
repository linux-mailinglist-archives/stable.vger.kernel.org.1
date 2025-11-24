Return-Path: <stable+bounces-196796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB23C82717
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01504E1007
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C22D663B;
	Mon, 24 Nov 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbI5H4y5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9C257852
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017516; cv=none; b=CtKbsTFtddFFcNfAsE33wr4t4FPyA5ZwPVt2Pzatmia4Qml+7ahSXCYAbBIC51SSX6h9j4QaD73P3zl21H25kBanLw3VE1HlSuZ5t3pFtCV4IC34pGBcda3AckyzojPbS7ywaQypViagRUrbZMUhtsZyGnCRCRJEyBnnvXnFSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017516; c=relaxed/simple;
	bh=6BFNjZe8ORTR3sVnxgEjAoGriWJrUk47wmMEOvjSAC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaZHsQBe+I4/Y6vJCOiObSKTaCUC9jOyL+Fn7lxW3+oEPA71Iey8p53tz7qeoOsEkAEMXKKg22jQqp8j+qt328vRCB+6Pt76XAyFcpgLbYVElskd2ThpMqH4LnRZzGaz+R+SLtOxt5IiOTWJsixQV1wBn11jnal2NmO7yACvumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RbI5H4y5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b98983baeacso2285906a12.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764017514; x=1764622314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6idQiT/Lk41XT3er1JulNtEcFMX7tPcBFqFIy23wX4=;
        b=RbI5H4y5Kkm62wlHUY7vIW818Qmhzvbs88DzRjblNlHNuyqrJP5iiTXW01bu2Q5g7O
         uNT0DQD45FrvHiifq+LahipKcs/k6Toh7bYEffeozhj4fiO+rWYi7YExVnOa/AbswWQW
         7mdBckDyDa7Rur/xwmehfC4xWG2apCE8UYLF92/RKUuaxlQL1dmnYQT1M8QnXuLE0DOG
         W1+7kS+GqHx0OV/a3L6yAKxmGcW3Fjof1Y//7F/9mdymDHhXo4rySw3MAKNEBITeC74A
         ANM5C+SW+hcTorRl/SeNmcvc0yP27lU8efnUeHao1CVczDgVgaKoGEqUwS8V0kZy3kbJ
         YI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764017514; x=1764622314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6idQiT/Lk41XT3er1JulNtEcFMX7tPcBFqFIy23wX4=;
        b=FTxqE1Uo9xW67ok2PMk+SHxGsX+s+el5saskb0P50/BNiP4pj/wVcc0cXugg2e7EQM
         44965q7/yfhu1qlpUvF9dvWUxIWAnpXIuKPBNoyD1AcOJ7+9uxtSm6dBj4n0EkuxdmfI
         8usjXMBbfy2bEhO8+SqaIBSglM1vOgX+XiH9RGEoGHz9W1uNAsamXZ8sPoPmOXLPqyLC
         rY0nq6W/34xm238MlhyhyQ1pCAn+TEfRu5Jxw/BaiMVuTIjN8iMFBihzkv+Ej5wK2sA5
         1BoZY9eLUrUIrcIYu5yNGeHZEltA76DoHNn9q+VlcjmJKbTdyL/2DYxVfrcLvTsmuvlo
         9Jaw==
X-Forwarded-Encrypted: i=1; AJvYcCWn5eGo+SqG/JNxQL+EMASH4NnVXoKRoNTgRPFw9BHzAA8fC/TVIw8MwmtbXhpP7pW+Fevc7eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmLn+xTYMnt3+qoZhTwGsIUNCcDv1ReT+1KUeW6GDp6SgWQmr
	2aco4G/MTBoJZM+ytQIZVp6M6uW8sB+L47RzJRB1DkLr7e4HQz1f15zaHPJmJ8inHqQEqJLpFkJ
	HYSDaye+RY9nQtscNhXqYh11cXlYBErD1idRH4G3JoA==
X-Gm-Gg: ASbGncs5cXLmkjDcoVaSiWea3bJWZ1vjWZmKftg9k7+sJFlLxk+q8WhvEJ5cZ5+3FYF
	lYow8mEBG/HEBf4SAKRUTOc8mBDjarNu0mz3waziqCJ2A1DD+WxDalb7kgJnfxrBJmRknTrsJt2
	p/lxuu8gfEMFsk7MeE/jCuuEfyqYUVrF8neIkMbbQSf32slTn0d+ZMgkvCc3NkQ5kuZ/cVWtck5
	AibI7Pj/tQtcpY6rPY8xJ7zh2jQPKBtUzii/6iVHewfdnDEF9uUTF9VeBMiZQ+zXpgohJdpv7hU
	m4fy4eo+iPhDPyu2EL+moKo8GgtW0w==
X-Google-Smtp-Source: AGHT+IFjLWT6yOg2hi2wu5H1G4MoFcdeFYH0BRB30KFAuwP0u2IagJSBzMzfwB9OaD6Hyztv/D0RJutCW3MA+Q+DdWM=
X-Received: by 2002:a05:7301:4586:b0:2a6:9d86:48a8 with SMTP id
 5a478bee46e88-2a7195c9662mr7982342eec.17.1764017513591; Mon, 24 Nov 2025
 12:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
In-Reply-To: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 24 Nov 2025 14:51:42 -0600
X-Gm-Features: AWmQ_bkR6_YnQmKNQToJOLZtI9vyDFo3HYMS0rYpoLLIQEjyJTPF_i9DJ12NbWk
Message-ID: <CAPLW+4k=My6np3uKoRmODDVbUekTs+yDdBbwoH_Ba743sRQTRg@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: exynos-clkout: Assign .num before accessing .hws
To: Nathan Chancellor <nathan@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
	Jochen Sprickerhof <jochen@sprickerhof.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:11=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero. This
> occurs in exynos_clkout_probe() due to .num being assigned after .hws[]
> has been accessed:
>
>   UBSAN: array-index-out-of-bounds in drivers/clk/samsung/clk-exynos-clko=
ut.c:178:18
>   index 0 is out of range for type 'clk_hw *[*]'
>
> Move the .num initialization to before the first access of .hws[],
> clearing up the warning.
>
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __cou=
nted_by")
> Reported-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Closes: https://lore.kernel.org/aSIYDN5eyKFKoXKL@eldamar.lan/
> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/clk/samsung/clk-exynos-clkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsun=
g/clk-exynos-clkout.c
> index 5f1a4f5e2e59..5b21025338bd 100644
> --- a/drivers/clk/samsung/clk-exynos-clkout.c
> +++ b/drivers/clk/samsung/clk-exynos-clkout.c
> @@ -175,6 +175,7 @@ static int exynos_clkout_probe(struct platform_device=
 *pdev)
>         clkout->mux.shift =3D EXYNOS_CLKOUT_MUX_SHIFT;
>         clkout->mux.lock =3D &clkout->slock;
>
> +       clkout->data.num =3D EXYNOS_CLKOUT_NR_CLKS;
>         clkout->data.hws[0] =3D clk_hw_register_composite(NULL, "clkout",
>                                 parent_names, parent_count, &clkout->mux.=
hw,
>                                 &clk_mux_ops, NULL, NULL, &clkout->gate.h=
w,
> @@ -185,7 +186,6 @@ static int exynos_clkout_probe(struct platform_device=
 *pdev)
>                 goto err_unmap;
>         }
>
> -       clkout->data.num =3D EXYNOS_CLKOUT_NR_CLKS;
>         ret =3D of_clk_add_hw_provider(clkout->np, of_clk_hw_onecell_get,=
 &clkout->data);
>         if (ret)
>                 goto err_clk_unreg;
>
> ---
> base-commit: b6430552c8cd95e90bb842ce2f421e7a5381859f
> change-id: 20251124-exynos-clkout-fix-ubsan-bounds-error-93071375ec78
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
>

