Return-Path: <stable+bounces-4971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE114809C93
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7649C1F21077
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47A63DD;
	Fri,  8 Dec 2023 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grMw9MAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30263AD;
	Fri,  8 Dec 2023 06:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D6C433C8;
	Fri,  8 Dec 2023 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702018051;
	bh=aVwOp1aJPsPh7+HlQ/vujBgUZmjHqe7FfCfwGE1YeZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grMw9MAilAqZVJpURavXBJKJpCfqFYqXS/93nfol1/6O4gqg8/TbHPtjeINDoQ3XL
	 5o0UXU39UnthFKO8a/M6TZ5cd9D5f/5lIVWYHc3xDCUI9NjoTSRfNEWfr6eNmHJFAM
	 G40GKVqdEDQ2ZeQYF3wiWqFQCn6t9VlU2zUH/HPM=
Date: Fri, 8 Dec 2023 07:47:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Message-ID: <2023120849-catalog-pretzel-ee8f@gregkh>
References: <20231205183249.651714114@linuxfoundation.org>
 <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>

On Thu, Dec 07, 2023 at 02:00:06AM +0300, Alexey Khoroshilov wrote:
> On 05.12.2023 22:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.203 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> It seems something is seriously broken in this release.
> 
> There are patches already applied in 5.10.202 that are in 5.10.203-rc3
> transformed in some strange way, e.g.
> 
> Neil Armstrong <narmstrong@baylibre.com>
>     tty: serial: meson: retrieve port FIFO size from DT
> 
> 
> commit 980c3135f1ae6fe686a70c8ba78eb1bb4bde3060 in 5.10.202
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index d06653493f0e..78bda91a6bf1 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -728,6 +728,7 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>  {
>         struct resource *res_mem, *res_irq;
>         struct uart_port *port;
> +       u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>         int ret = 0;
> 
>         if (pdev->dev.of_node)
> @@ -755,6 +756,8 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         if (!res_irq)
>                 return -ENODEV;
> 
> +       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +
>         if (meson_ports[pdev->id]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n",
> pdev->id);
>                 return -EBUSY;
> @@ -784,7 +787,7 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         port->type = PORT_MESON;
>         port->x_char = 0;
>         port->ops = &meson_uart_ops;
> -       port->fifosize = 64;
> +       port->fifosize = fifosize;
> 
>         meson_ports[pdev->id] = port;
>         platform_set_drvdata(pdev, port);
> 
> vs.
> 
> commit 71feab929585232694b4f2fb7d70abde4edc581e in 5.10.203-rc3
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index bb66a3f06626..c44ab21a9b7d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -765,6 +765,8 @@ static int meson_uart_probe(struct platform_device
> *pdev)
>         of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
>         has_rtscts = of_property_read_bool(pdev->dev.of_node,
> "uart-has-rtscts");
> 
> +       of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +
>         if (meson_ports[pdev->id]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n",
> pdev->id);
>                 return -EBUSY;
> 
> 
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 
> 
> 
> See also:
> 
> Qu Huang <qu.huang@linux.dev>
>     drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL
> 
> Axel Lin <axel.lin@ingics.com>
>     i2c: sun6i-p2wi: Prevent potential division by zero
> 
> Takashi Iwai <tiwai@suse.de>
>     media: imon: fix access to invalid resource for the second interface
> 
> 
> Also there is a strange pair:
> 
> Patrick Thompson <ptf@google.com>
>     net: r8169: Disable multicast filter for RTL8168H and RTL8107E
> 
> Heiner Kallweit <hkallweit1@gmail.com>
>     Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"
> 

Ok, I dropped all of these and manually verified that there were no
other duplicates.  thanks for catching them and letting us know.


greg k-h

