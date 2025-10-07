Return-Path: <stable+bounces-183554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C1BC27D2
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65563A53BD
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4022D4F9;
	Tue,  7 Oct 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuYFB5zv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A620E31C
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864819; cv=none; b=SuA+ZTIlBJEQ9zperdwtYL7o6PQSztTNx+PVHUvi8kK8HndiY5w+B1jhdJEeZl9WHn5gX8SZ+3F+fpbRw74hxt3PYPXGBkxVRQDil1uITCJhn66mVAjAcKgIihXShheHSRBvMnzkar9bp1zEob+vJdLvPbJGA6j172zzcleLpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864819; c=relaxed/simple;
	bh=EiImG7GpvLr04lXxcmldheIyewvjHETXWh8n7xAqUho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlqN4WyzaIiN52c2AOhrcwPmlL8BahVRvROZRs54nGvNE+omGucXBPNOcVJ10d+gfzq9WG3uNMPdHXzFu1RhldvzQacRc899b6vEM21SgrnNGXbs7Uy7IbQDtV9xvRv9KMdK3kam82ixFphZZwlzyUuuM16n7GCjgD7yM1+hJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OuYFB5zv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-73f20120601so80216867b3.2
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759864817; x=1760469617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyvVzqRAZ+jJPuuow0tWhdGCSI6e0A8fiu8e4y33sz4=;
        b=OuYFB5zvbyOqeF9sc6vVd6/KWcmPH+yeGN9vbYOb3bh4vyJwc31wYX1Dkxd1Jb/Td8
         evmdoI6tXcWqHPzZhz6ye/H2exkmk3dv867W0kdqifxa7ZkAbN9DU7OVhDBkVQFhVbu3
         BNEQOGMpBj68fhyofiN2m3HIiq7+tMT1MjZwD8YIrw6+RVWej8BNSl4V6RwESGmYKhBq
         BlnG0C8dtzZccNXVEM9g06lCZm5XvguDn53Cn4qw9NBW/FhnDyfbCgT/cpqJRCczkX4i
         HrRtt07YpRNnW0fwfbjg7cnGAbqVSQgfGY9QoEZx9w2LmnQGCgIRiZgbHRvFlSI6PLX5
         GXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864817; x=1760469617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyvVzqRAZ+jJPuuow0tWhdGCSI6e0A8fiu8e4y33sz4=;
        b=Z9DR5KqQV9ddsDI1qczpinwWU8zqapCYOvF6Ir2dgQ9kkfcqL/KNSgXmQRcPSS74gZ
         FnL7IxVZFYYiNJZFYN37FvoyGoasX4n4XCLSFRnSDkctXyUmqy7jXaWcahp1DtTn5wQw
         jq2lDIM1MinxXybVyZMA+vqea7iKgStvKE+p9mZPAllYXrC/S0dZ5CfvrBjhkr59TP/0
         f/6CiTg6DCjxOJtYVJS6vJBxLp2m4TQJz5kOYcQp3/JHn2brTm690Z1qnVWJbBeuFTgL
         ksIzk9+C9nWnbMqlgsQCEOcnrVBKsFSPybJ7iYQzIJV0z3arQlZIyLFqCYWDBFx1WOI0
         qbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH1hE6noQ5Jb6Oj9nXX6UjDMmTNfCYEKrvi94KKeQAF2eIlhUQngHCdhsMHAX3YXqLxMCn7uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oijv7uqIjOHznGSKNDpOQgzPZDotF8fiv3TK25g4KDQJHRHv
	MX6JjOQdbn51bgEBLQcHbDjbKXuhOFAd37iz/gknBtl2ZPGLt4fzTFQjHvQioKTrpYj9q+OsKIi
	TRdX04yxaUC+fSEmNjBlAOV/SGTIdB1tLyq3CBb0jdQ==
X-Gm-Gg: ASbGnctdKepH9ECOn+emn3jjqtr07r4V/mYrdRx83fFqofjCjnEn6oDGmnE84+2ifN6
	7NKbewiyyx1vYVHmjM8oVXIkFzT6qckXCYqEqFQyi/VPiTrQX1QK2BksdkdGWQc45WlDtFk06X4
	4aBtPe8ZnZ6VdjcYDbMJYWw4wNeHfE8oXF42yClHtzXPeWSZFw5fJ9v0kjAySDXyGicHI6fn4pO
	XXJgwi6Jxmpq9iDc6DGtiSQUFNcBw3MbnDmwEHOpdPn
X-Google-Smtp-Source: AGHT+IEcS4H3ART7XbkyRLcIVlRN9ttSIKXOMErrDhYI7itdbz36cK6980ngyigAxI0SbIW7DumJI/JYvN83SQijQyM=
X-Received: by 2002:a05:690e:c8:b0:622:7517:af78 with SMTP id
 956f58d0204a3-63ccb85338fmr715381d50.13.1759864815549; Tue, 07 Oct 2025
 12:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 7 Oct 2025 14:20:03 -0500
X-Gm-Features: AS18NWCtEcLGJeO6dNMCbDSRSbiDXW6f_hsYoSbqLJrQg-Tj2Vl72UtnnpoTtMI
Message-ID: <CAPLW+4mT+BcK+sLTenaNP7T3iFF1yXj4kziSYiJx2gOYV2NSWg@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:07=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
>
> Update the code accordingly.
>
> Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend wit=
h UDC bound (E850+)")
> CC: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index a88ba95bdc8f539dd8d908960ee2079905688622..1c8bf80119f11e2cd2f07c829=
986908c150688ac 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1823,7 +1823,7 @@ static int exynos5_usbdrd_orien_sw_set(struct typec=
_switch_dev *sw,
>                 phy_drd->orientation =3D orientation;
>         }
>
> -       clk_bulk_disable(phy_drd->drv_data->n_clks, phy_drd->clks);
> +       clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->cl=
ks);
>
>         return 0;
>  }
>
> ---
> base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
> change-id: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
>

