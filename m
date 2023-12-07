Return-Path: <stable+bounces-4925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FF808AE4
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2631D1F21323
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB01381A8;
	Thu,  7 Dec 2023 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3q88fnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC52D7A4
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 14:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECA8C433C7;
	Thu,  7 Dec 2023 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701960193;
	bh=GS0pkCiCklBA0a7xl7TBuU7N9iIAAufEGuz/4h4QpeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S3q88fnkCsJDZ+yihqdkttJ3GffGOnFsmkywke2kTkN4KViKKNJludWPdPrA290PK
	 P6IDDqLaELe5ah6+dl3/ULxe9DX5cOe+wx0PsDkDWjArS1IVF428O0Ii3ErtncLNhn
	 c4XaPpSIy2Nzfmt75id2nUPRRFExIeLhWxRPRWE51M1n5hVd3QB839qnf4RQu+v4P7
	 Gv7rHq13RNCDb4ZXJQDYzdGVNDR6e+TGtjxnVgL9PLdfLzfgdvBsNEraV7m84KLL1v
	 RoHxylIGPWKBZrxXpamPxteb7dcR/kYk6W8OjmCucvIS0L2ncrmXRgyjF4cfb6YpxO
	 +Z6DcWd9980xQ==
Date: Thu, 7 Dec 2023 15:43:09 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] bus: moxtet: Mark the irq as shared
Message-ID: <20231207154309.174a0753@dellmb>
In-Reply-To: <20231128213536.3764212-2-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
	<20231128213536.3764212-2-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov 2023 22:35:04 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The Turris Mox shares the moxtet IRQ with various devices on the board,
> so mark the IRQ as shared in the driver as well.
>=20
> Without this loading the module will fail with:
>   genirq: Flags mismatch irq 40. 00002002 (moxtet) vs. 00002080 (mcp7940x)
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org # v6.2+
> ---
>=20
> (no changes since v1)
>=20
>  drivers/bus/moxtet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 5eb0fe73ddc4..48c18f95660a 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -755,7 +755,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
>  	moxtet->irq.masked =3D ~0;
> =20
>  	ret =3D request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_f=
n,
> -				   IRQF_ONESHOT, "moxtet", moxtet);
> +				   IRQF_SHARED | IRQF_ONESHOT, "moxtet", moxtet);
>  	if (ret < 0)
>  		goto err_free;
> =20

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

