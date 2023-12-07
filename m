Return-Path: <stable+bounces-4926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE3808AE5
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD11282E42
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE62381A8;
	Thu,  7 Dec 2023 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbZu5YQ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAA2D7A4
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F247C433C8;
	Thu,  7 Dec 2023 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701960204;
	bh=ZB2DauAIH9sieCvspymkqF88MIq6wzjcMQoKXrlFZrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbZu5YQ1UgWnVOJqGNP7exbnBaqWJIH47N3tl+XPxKNZhx42XAVuRQ+6+ZcSMwCQh
	 Lk4SGrACSHqBQsnu3C0BJOjG5am+V3xo6ybS1H4wLUFFugYrsLQxPc8MnO7n1bl4AC
	 o+EvC4K+KYqTK1Hj6JglxfcMMe6u1rvL8iAWPD3YJI4BpVUiuApPaEVFVxrtz0MO8t
	 mIvKVSnk3jCUKpnNWu4IT/i7mnx/9mAWJDuJJuQotyHQVnOOuR4CAeBBSvshOTQqsb
	 4DdoklGU/kLFq6/5fWsPk6Cds091W55hwY7aL/7gWQv2XCd1DF+eA/MxylHxgaZYW6
	 TX9HoWvIW8rZA==
Date: Thu, 7 Dec 2023 15:43:20 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bus: moxtet: Add spi device table
Message-ID: <20231207154320.4bd7d7a0@dellmb>
In-Reply-To: <20231128213536.3764212-3-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
	<20231128213536.3764212-3-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov 2023 22:35:05 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The moxtet module fails to auto-load on. Add a SPI id table to
> allow it to do so.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org
>=20
> ---
>=20
> (no changes since v1)
>=20
>  drivers/bus/moxtet.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 48c18f95660a..e384fbc6c1d9 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
>  	mutex_destroy(&moxtet->lock);
>  }
> =20
> +static const struct spi_device_id moxtet_spi_ids[] =3D {
> +	{ "moxtet" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
> +
>  static const struct of_device_id moxtet_dt_ids[] =3D {
>  	{ .compatible =3D "cznic,moxtet" },
>  	{},
> @@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver =3D {
>  		.name		=3D "moxtet",
>  		.of_match_table =3D moxtet_dt_ids,
>  	},
> +	.id_table	=3D moxtet_spi_ids,
>  	.probe		=3D moxtet_probe,
>  	.remove		=3D moxtet_remove,
>  };

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

