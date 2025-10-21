Return-Path: <stable+bounces-188329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF52BF66A9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC6E542941
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A42F8BFC;
	Tue, 21 Oct 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzFOPIPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507612D5C97
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048967; cv=none; b=uiRIc8hZcCiygOvOIuO+1x7HiP5NXv2wHcV0AehkzevaFlZfWuCOk6+krZu6d34soBS0lBl2l/JQD+iXr38I2WEpEmCJwv90M46Qq3/w5USSjxD8aCdarZPNpYGviInfgJnX1GKZxJExSRd1qRDWVOyHNKRJl9Jnmwzzxxi9B80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048967; c=relaxed/simple;
	bh=afZ9LYjd3nXPgO7A1CJ8B6ceDU96mc91oikI4RgUCjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guaR0EitosMxkPYtBN5DNu3Iyx/a35KjC3Y2q36rumM1RF5vI7jybvsxMCCYMsWIrldVig66CfSEk0xE60Ll1DA8A/LiJc1u+3E0da3mFm0kBTtV01LxDCaG3sxXCVIVPA6vFur+UmOCsUmsuHz+8jBRpF1HeiXTAY6NxdUNVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzFOPIPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BD9C2BC87
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761048966;
	bh=afZ9LYjd3nXPgO7A1CJ8B6ceDU96mc91oikI4RgUCjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZzFOPIPe/CIJyCZzZS5xDCOU6fb9z5+niTUJu2f8nz3yhyIuvbfquK4urojZ6W7RK
	 QI61caoK/RX3VirzOJ975dczZ65ziZVmC+yyPjsoPBE5iYBfWFKHbQHN3zs4IO7R5s
	 ZLt2HMJ2uYxOq//IBo6TRnQratgTnDvrfaviDON5U9nb8Z/y6K2f8o648lEGTX11X2
	 rxsYOU2RFX8YkazroUHdo7g4fmAS9fFqU7SkdZJ0JIy3UpzQrp2rjgogt0LXDPPWkx
	 HtYrpl3MftltAZmMXxsQL5Sxn/zSsdNyYdHCx9qXuLBVEBaKxVGjqetnM9CfTqcffJ
	 yImIwoc6dhvmA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9329152a12.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 05:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnUgIXSaKZ69i2MB++rK8EM8roU1mgAzB/r40RL0Kn2+sLsD2Z7prVGNC6W+zK6+m6IeI6Cw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuDWGUJg6qCh29hcjPmdvm/jCXAYZxWh2shUCxEwZVa8QVL6b
	6vhmuURxIfsYzLRuF4+NvifEte76i224vz53H7bJe5IGY7STxrFhyEbOeqtP8K2zxfu92X0aLwN
	VwUsJpbp3ROnZffyDqBj/VG6S0RnY1hc=
X-Google-Smtp-Source: AGHT+IEehxa0VVriHcp2h3pPnTDlb8T/F5FMqzRVzT7FPHkMVaKDIi/rjGcv9KvbFvUKwGOelOx0U0eBViPra1u4cao=
X-Received: by 2002:a05:6402:440f:b0:63b:fbd9:3d9c with SMTP id
 4fb4d7f45d1cf-63c1f66c82dmr15228151a12.15.1761048965319; Tue, 21 Oct 2025
 05:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021092825.822007-1-xry111@xry111.site>
In-Reply-To: <20251021092825.822007-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 21 Oct 2025 20:15:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5e-U+nxHkSjE_3_PcoOuaHTqJWnYm9OZXVwuWvh3N5ZQ@mail.gmail.com>
X-Gm-Features: AS18NWBcCXTydL281tEwc29bBx_Sgj2MfqdSDFPAw33oyAwgRfjsz5gyo8nMyNs
Message-ID: <CAAhV-H5e-U+nxHkSjE_3_PcoOuaHTqJWnYm9OZXVwuWvh3N5ZQ@mail.gmail.com>
Subject: Re: [PATCH] acpica: Work around bogus -Wstringop-overread warning
 since GCC 11
To: Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org, 
	Saket Dumbre <saket.dumbre@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:28=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> When ACPI_MISALIGNMENT_NOT_SUPPORTED, GCC can produce a bogus
> -Wstringop-overread warning, see https://gcc.gnu.org/PR122073.
>
> To me it's very clear that we have a compiler bug here, thus just
> disable the warning.
>
> Cc: stable@vger.kernel.org
> Fixes: a9d13433fe17 ("LoongArch: Align ACPI structures if ARCH_STRICT_ALI=
GN enabled")
> Link: https://lore.kernel.org/all/899f2dec-e8b9-44f4-ab8d-001e160a2aed@ro=
eck-us.net/
> Link: https://github.com/acpica/acpica/commit/abf5b573
> Co-developed-by: Saket Dumbre <saket.dumbre@intel.com>
> Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  drivers/acpi/acpica/tbprint.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.=
c
> index 049f6c2f1e32..e5631027f7f1 100644
> --- a/drivers/acpi/acpica/tbprint.c
> +++ b/drivers/acpi/acpica/tbprint.c
> @@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address addre=
ss,
>  {
>         struct acpi_table_header local_header;
>
> +#pragma GCC diagnostic push
> +#if defined(__GNUC__) && __GNUC__ >=3D 11
> +#pragma GCC diagnostic ignored "-Wstringop-overread"
> +#endif
> +
>         if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
>
>                 /* FACS only has signature and length fields */
> @@ -143,4 +148,5 @@ acpi_tb_print_table_header(acpi_physical_address addr=
ess,
>                            local_header.asl_compiler_id,
>                            local_header.asl_compiler_revision));
>         }
> +#pragma GCC diagnostic pop
>  }
> --
> 2.51.1
>

