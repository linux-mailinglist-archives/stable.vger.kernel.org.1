Return-Path: <stable+bounces-155331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCDAE3ACA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A763188521B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5162192E3;
	Mon, 23 Jun 2025 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="sLhqgFiZ"
X-Original-To: stable@vger.kernel.org
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B823B0;
	Mon, 23 Jun 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671672; cv=none; b=TZp9OnSSiPlbEuQUdSaj1bLeNU8ldWoBZiS7p+JS1jpFXjv6fmjjNPqWcdTXAFD+1bgO6Nx9t231hOhQtI6GzVeZjO+VEQ+INTawhTlQGXAnX0Dl2oQCmy28ldFnWmqPJIJUpXaajKx5jIYaeRWsjkq3SND6HgUpUSTq6Yr6shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671672; c=relaxed/simple;
	bh=BwJm+0ENa935xRL7dXx302SmtpFL0P2DqD3scehu6WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvcmgig1SdD4c5RRMysOxBdZXogB/V5sELXtRp2N4+fikD8P/SQ0w+/SlJaCcwbK/fiyrdSpgLPpJ2j0r60AEDS94Nr9iUjw45CS6ew2sZdE8PcjfLYYaD2H1etQEGQATCc2ESrj6KCddI2JTUz8SpwvD1a9N59fCkAOWcV0zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=sLhqgFiZ; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id D2125440242;
	Mon, 23 Jun 2025 12:31:55 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1750671115;
	bh=BwJm+0ENa935xRL7dXx302SmtpFL0P2DqD3scehu6WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sLhqgFiZcJISa68ATcz9tShQKzw7d5hrONv1+tv9N0xSWbwfsYvidBFxdtdILjsGN
	 owCdjhmCYIRgaNs5D3SA1mylaf20D8gHGmUGorWAjOf5kttKzVBGPkyauEUlE2QJhO
	 YlL4REHjr0naMXgdoPGzEOsbmyZxkYCB3JYcWDhmEJyr+DFxuN6qNdtJqmt06zrFzK
	 RUg4UtNhrVhOtu5RSXmN27cIv0aKTDzaJXXnS9feEOR9K3Ksc1A68BSD6Iy0vJPs5k
	 dwIqxsyoqk2i8ZOfjB61OeuVhCXkIMd4H+Ro3M/6V1VAA02GSXxbZxm+dof55tNtRu
	 sQV10oFZB1Nyg==
From: Baruch Siach <baruch@tkos.co.il>
To: Steffen =?utf-8?Q?B=C3=A4tz?= <steffen@innosonix.de>
Cc: stable@vger.kernel.org,  Srinivas Kandagatla <srini@kernel.org>,  Shawn
 Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  Dmitry Baryshkov <lumag@kernel.org>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: imx-ocotp: fix MAC address byte length
In-Reply-To: <20250623084351.1734037-1-steffen@innosonix.de> ("Steffen
 =?utf-8?Q?B=C3=A4tz=22's?=
	message of "Mon, 23 Jun 2025 10:43:45 +0200")
References: <20250623084351.1734037-1-steffen@innosonix.de>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 23 Jun 2025 12:33:05 +0300
Message-ID: <87ldpikdke.fsf@tarshish>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

On Mon, Jun 23 2025, Steffen B=C3=A4tz wrote:
> The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
> extension of the "mac-address" cell from 6 to 8 bytes due to word_size
> of 4 bytes.
>
> Thus, the required byte swap for the mac-address of the full buffer lengt=
h,
> caused an trucation of the read mac-address.
> From the original address 70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14
>
> After swapping only the first 6 bytes, the mac-address is correctly passed
> to the upper layers.
>
> Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
> ---
> v2:
> - Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
>  drivers/nvmem/imx-ocotp-ele.c | 2 ++
>  drivers/nvmem/imx-ocotp.c     | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index ca6dd71d8a2e..3af7968f5a34 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -119,6 +119,8 @@ static int imx_ocotp_cell_pp(void *context, const cha=
r *id, int index,
>=20=20
>  	/* Deal with some post processing of nvmem cell data */
>  	if (id && !strcmp(id, "mac-address"))
> +		if (bytes > 6)
> +			bytes =3D 6;

Maybe better use ETH_ALEN instead of magic number?

baruch

>  		for (i =3D 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);
>=20=20
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 79dd4fda0329..63e9974d9618 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -228,6 +228,8 @@ static int imx_ocotp_cell_pp(void *context, const cha=
r *id, int index,
>=20=20
>  	/* Deal with some post processing of nvmem cell data */
>  	if (id && !strcmp(id, "mac-address"))
> +		if (bytes > 6)
> +			bytes =3D 6;
>  		for (i =3D 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

