Return-Path: <stable+bounces-181999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1462BAAC1C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 01:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2115C1920EE1
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49223506F;
	Mon, 29 Sep 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sign1ugM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D31DED49
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188894; cv=none; b=jG8Np3bi3lQdRUu7CHRlgWChFo99IGary4nr0edGw5AwWCWBM/GrF2MGUB/+RA6NZQjVeNUoyii8d51+qNm8kHia2bf6YvlR4jorzPyz/d9ldZ/we6J1N5k09VANRlnPmX68RrHT2g6LZSuz4SZHex/tp0j37ObkGWKhgM29apI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188894; c=relaxed/simple;
	bh=KGGO/c4iwGbuNioarw8Fkcgaz8f8/ESRsoXID/0Vbpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Um/qbkLZUX97xdKNGgiT2N/VgMqf7krqbD8NxKLDWMJOE7hV9rxzca2zj11pY7imE1Z0k0j9MDG+5gbE6p0pHTlcjE40mfWMKuvR3GdwtwKEf0J3sMB2Wbw0kRjyHY0mAqRifXmZRgP4S4K5/y1Ztd5UdFUKHw3edqjjr+QicN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sign1ugM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1928245241.0
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759188892; x=1759793692; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFiL7tvxh1E8ppfUCLvnfmPCueA9DAsnng1eogfHRMo=;
        b=Sign1ugM4Df6Arli0EsdPdwH5NzJJbY/nEuZjLUA3XfgFUbzz3gTWWQeZJLOtamWuE
         aqP1vY1rZiBfEo3gy9aoHZGX0kn0BacTm3JJYClYpHtILk5F13Kzn+KjyxIkYSwNfQzr
         OKIFe9aauJ7GC8ISwv/SgkALEaU41p4vhS1vIalBuJ8cNBaEMUmjH7teSKO0zpZ06byZ
         yQQHzIwzeYaJBka1Vg7Ajd0+TDfrvWf/M4hV3joHlX7Ktisdbi49xWz4j5D1HdEgeYbz
         kGT0PgKVztE6tot9McpgNscCgzgn4PUgCvEK19oJwN7SSk5CWVhnuLGsNB6C+Xo88mtH
         t2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759188892; x=1759793692;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wFiL7tvxh1E8ppfUCLvnfmPCueA9DAsnng1eogfHRMo=;
        b=BN6ovrlpShaGiTxdmlw9DbRLxSdKz0pl1xh6NlThkATOe9iTTlqbkJQxO3lRYPIvP0
         o3XhSnZk3AMo99udMDMTYQ7a0SYCRNyhm+w0kUfXvr0Gr+3MG5FcBtzPBnVQnsDjTcyk
         qu4DrNwiXAnagJ0x2s3cIVeIgk7fPvgzBdjfutgXoqLa4yTSNLyqigXVrkKMw1zKx2j8
         OENzRtAmAngHE7WB9K1rlQWzaJ5HfeK8pwxZd6c9aVQ3DeYG1xU6Elh+32uOYIdgmgrN
         cy7C2NjrxmQTWZbvWjE0BGXAZaR8qtDhBX/dCJBMuGk8qdyeN+StTd3wg4xSWyhR6j0R
         Gqqg==
X-Forwarded-Encrypted: i=1; AJvYcCUcYhd4e64ZZC5eMun9zr8+3Wh5YpIl+nILnd3RCubuxMSayJKX6BwuT6ZgvXgKoVRPuT4Ayr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9aFdz+8CxJ2roIjAJ24/RwlpbzYwTZsSlQCNhMknZUZAKxSw
	q5OrKTcVeJ8O0QJs++HBfdQahysUZHZDhDL9VEf26u5EuXZqssR4dxFK
X-Gm-Gg: ASbGnctN8wJKmhFAwhclA3CpnHU163jB6AzzTyVdI9ptwo5CTb0+jBAmEeefWTo4IOU
	W0AbYryyk+1BBRJgplhFnGQCLdu8zlRo4IMRK5x0LSmL3F1kKi4wbDK/MpHOBSOWnwr/9GOCsY+
	dxyVVTjtpQVVmN5QYRkJ0SHil6NB9o4h0hkL9qcad0UYmPePLgPBmDaiTzN3FzeLfz8YJiV+vYa
	j7oIO/LWCY/T3RVetqioRrG8MiJvOIPYrv6M4g/eU1o0LIicNK+WaRhDz7SKCGZo2gjg7JRTvoB
	SxOG+Xs30cpRT7vZDR4T7gH5uJ4Za//x8gMXad3xtc+026630vLwOJSi7fXP757MwEITaGS7bvY
	DSBSOWjjJy1x0bfzUqVreFekeL801+aUqNV+VtIA=
X-Google-Smtp-Source: AGHT+IGNT4CaODm9AxqpmbifcaCr9nrgDOnLfemEictGIa2Tp7pNkJNdPA5rCN1cnR+7ZsfJc38lHw==
X-Received: by 2002:a05:6102:50a0:b0:5a4:138d:b13c with SMTP id ada2fe7eead31-5acd2b17270mr7054801137.29.1759188891810;
        Mon, 29 Sep 2025 16:34:51 -0700 (PDT)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916db3be313sm2665732241.20.2025.09.29.16.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 16:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 18:34:50 -0500
Message-Id: <DD5OEZAR3061.I5SI8XGJ0HHG@gmail.com>
Subject: Re: [PATCH v3] platform/x86: alienware-wmi-wmax: Add AWCC support
 to Dell G15 5530
From: "Kurt Borja" <kuurtb@gmail.com>
To: "tr1x_em" <admin@trix.is-a.dev>, <platform-driver-x86@vger.kernel.org>
Cc: <Dell.Client.Kernel@dell.com>, <kuurtb@gmail.com>, <hansg@kernel.org>,
 <ilpo.jarvinen@linux.intel.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250925034010.31414-1-admin@trix.is-a.dev>
In-Reply-To: <20250925034010.31414-1-admin@trix.is-a.dev>

On Wed Sep 24, 2025 at 10:40 PM -05, tr1x_em wrote:
> Makes alienware-wmi load on G15 5530 by default
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Saumya <admin@trix.is-a.dev>

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> ---
>  drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pla=
tform/x86/dell/alienware-wmi-wmax.c
> index 31f9643a6..3b25a8283 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -209,6 +209,14 @@ static const struct dmi_system_id awcc_dmi_table[] _=
_initconst =3D {
>  		},
>  		.driver_data =3D &g_series_quirks,
>  	},
> +	{
> +		.ident =3D "Dell Inc. G15 5530",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5530"),
> +		},
> +		.driver_data =3D &g_series_quirks,
> +	},
>  	{
>  		.ident =3D "Dell Inc. G16 7630",
>  		.matches =3D {
> --
> 2.51.0


--=20
 ~ Kurt


