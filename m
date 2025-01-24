Return-Path: <stable+bounces-110368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BBA1B25D
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058F6188F569
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D11DB134;
	Fri, 24 Jan 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/CNhJT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4821D6DC8;
	Fri, 24 Jan 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709790; cv=none; b=XBhZzR/6x4kfQzAyGz+XBFwjqvSuRnF+CVp69GLQMo3j8AVoIJwJwPaRTblRWDWzVHH9HRfAaEa8+z1Ag5SUt5XvH+vbqq6Ple/7S+tCKcffhVyT3N7y4WOjW2OJU2cYoDHgfh+RZ7SCvTEKE+WqClnAjuZpAhW7Nhkszm0r7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709790; c=relaxed/simple;
	bh=6ODapJhhQGi6PIhN0lVMoDCWGSUnfR1hVh+dZ2hFuZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hC1xDd71QhNH7gJEX436otrjLusFx7hfna+IBAM4+jFYJ4CWwYbtSWWHOoYZ79JeysX0/AZGZ38EzcxCEyYhnvOwhym59c+tAa7gUZBWDFuYW0brqwB1s/NkhC50Re97SNeTdLEoqmMrqn+o7UR+rcVulkPUMqlrNo/YlXe/puU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/CNhJT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93AC4CEE7;
	Fri, 24 Jan 2025 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737709789;
	bh=6ODapJhhQGi6PIhN0lVMoDCWGSUnfR1hVh+dZ2hFuZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/CNhJT1iq1VYsG5Y2ZI8HFz67jLp/v0T6K+8uGnhtITcpn7w55gY+nNXFi1PUGHY
	 l2drx1RXWkDsIIi1BCW3GplM8xyKT6x9jvnK/utNeFTjjCzM8jdxSmHSOdczFlrx2b
	 6E+gGqSBwvPb1Qwz+cKoOI1oyv5M0mGn54CK/AUArIOyU/n4NRxMIMqx5Ji1aLJ8bM
	 02XRZ6Nx2xU1yMlsOWCamUbqdTR8xROse9WOfTKyrKty0xBpRg9bRTXYGjVnumg80n
	 YYZNm+PB9WGgPQbnBYrRQX7VNzDaVgjflgFpXSsBMs5BZ/buTxOJJkUABZpy4HUGJ8
	 8o/D3FdiyZsMw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso332440666b.0;
        Fri, 24 Jan 2025 01:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/NGjLfwS4iqCUa0gMCorbWcLlv7cd/10uEuN4bujb22vh8Q1gUnBgDLArNM+8PUX5sWUaQFfMn/SYSF0=@vger.kernel.org, AJvYcCXUy2Zg9AVq5f8hUKKCFX9H8IppLCbGbFkBU5LAuBwkqzQg8zgrcjYEyDB0xY6+8SUpkqCaeNur@vger.kernel.org, AJvYcCXY8U6uMD1SfQLUilR+u05ZJ7raDcIpuRXwFYx0Iyn/IeVDm6+Zj2eIalFGkcuWU3EY4i5hz9V1@vger.kernel.org
X-Gm-Message-State: AOJu0YytdVesI8eFU92vzT27o2H9/QhNwpkDHbqEdPmnD9XDOI3vsTqm
	OEVbgjyX94BiohXILqqEplAjSkuvQoXOKZyecXpc0RxgZhXQoXlNvsmw0dcwPoZoyiSVY1gyXKc
	I3fL6xPOTIKpWJ1reDOxpam9pcS4=
X-Google-Smtp-Source: AGHT+IGTuAf8HhxS55jC5emGy1X+8qNgDIgPU/o1SgJWkl820wvVBBoCo7jL58E2K6QC878sjf/FnZgeOx4+ewldUuc=
X-Received: by 2002:a17:907:7fa4:b0:ab6:511d:8908 with SMTP id
 a640c23a62f3a-ab6511d8af9mr1112359566b.40.1737709787937; Fri, 24 Jan 2025
 01:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121093703.2660482-1-chenhuacai@loongson.cn> <20250122133450.GI390877@kernel.org>
In-Reply-To: <20250122133450.GI390877@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 24 Jan 2025 17:09:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4=FQbZakx_=V-qcoWuBzbVyL31qmStNS9OFt-49w20bw@mail.gmail.com>
X-Gm-Features: AWEUYZlq08fDdXgdubKEAY1DJZk-M0VOQOeQI5in40fIJ5XHXxgmvkwOvdPO5R4
Message-ID: <CAAhV-H4=FQbZakx_=V-qcoWuBzbVyL31qmStNS9OFt-49w20bw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Set correct {tx,rx}_fifo_size
To: Simon Horman <horms@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chong Qiao <qiaochong@loongson.cn>, Feiyang Chen <chenfeiyang@loongson.cn>, 
	Yanteng Si <si.yanteng@linux.dev>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 9:34=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> + Feiyang Chen, Yanteng Si, Alexandre Torgue, Maxime Coquelin, Serge Semi=
n,
>   linux-arm-kernel
>
> On Tue, Jan 21, 2025 at 05:37:03PM +0800, Huacai Chen wrote:
> > Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> > zero. This means dwmac-loongson doesn't support changing MTU, so set th=
e
> > correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by channe=
l
> > counts).
> >
> > Note: the Fixes tag is not exactly right, but it is a key commit of the
> > dwmac-loongson series.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ad72f783de06827a1f ("net: stmmac: Add multi-channel support")
> > Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Thanks, this change looks good to me.
> And I agree that MTU setting cannot succeed without it.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> Some process notes regarding Networking patches to keep
> in mind for next time.
>
> 1. Please set the target tree. In this case, as this is a fix
>    for code present in net. In general, otherwise it would be net-next.
>
>    Subject: [PATCH net] ...
>
> 2. Please generate a CC list using
>
>    ./scripts/get_maintainer.pl this.patch
>
>    The b4 tool can help with this.
>
> Link: https://docs.kernel.org/process/maintainer-netdev.html
OK, thanks.

Huacai
>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index bfe6e2d631bd..79acdf38c525 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -574,6 +574,9 @@ static int loongson_dwmac_probe(struct pci_dev *pde=
v, const struct pci_device_id
> >       if (ret)
> >               goto err_disable_device;
> >
> > +     plat->tx_fifo_size =3D SZ_16K * plat->tx_queues_to_use;
> > +     plat->rx_fifo_size =3D SZ_16K * plat->rx_queues_to_use;
> > +
> >       if (dev_of_node(&pdev->dev))
> >               ret =3D loongson_dwmac_dt_config(pdev, plat, &res);
> >       else
> > --
> > 2.47.1
> >
> >

