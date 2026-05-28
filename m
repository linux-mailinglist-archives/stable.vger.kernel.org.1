Return-Path: <stable+bounces-255066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAxrJ4N2GGo8kQgAu9opvQ
	(envelope-from <stable+bounces-255066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:08:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FC5F56AB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33FED3166021
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA203F787B;
	Thu, 28 May 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RBnCRQud"
X-Original-To: stable@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B603F888F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986794; cv=none; b=ms8t9KIihfQrKBp1lmo8EpSaDUjmMDHv7l+HDCFQKAojZL17ewGfICBU5ba3qqMFNMpIuFQ162u8NSVfD/qckbgwgX9TZ51kjgaDf0O9oXgTiPMQKLoWoE07s89decyTo39R3MvyXCI1QNvqcvuiJeDkpyMBGSBrB+DQ92Ffdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986794; c=relaxed/simple;
	bh=zK3X7wA08oXzEAzQeQddwtdlz9RVepIGMUvH3ngJHxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4tkfrc389JOMuyOlqu2hGhMYQ4/m96YA/zE5xtgO36Ki3XhlkO4k6cXvkvVywwUegX5Tb4yF4SE3lqTlB9xUJspalRZ6JALsYVshPR+2akqMexYsg9m8+ITPmfEjyqppmrNKvsplUw/quLBzjoVXoYWQtRvzeo9ecAFAlIO9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RBnCRQud; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779986782; x=1780245982;
	bh=dGKkbNDql+vqJ68vmugDD47PP1fWqvAci8ua5n4B4Lo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RBnCRQud4/5XsmyACYM5q295J6ZLjWQfk9tmH+NTd8oIr9J4gfhOAkYvzOR7x9xEO
	 yjHbBjczNtscc3yiE/Wdewo9Q6gCwZfNUH2HTZ86yIdvdnQI0uaLWPhyNY6QCg/x44
	 VTdTdmbVDe1IV2WdjzxBafvNOnqoer0rdRuFlAolYvr8CLpesKpLEiXICvRX1psF8t
	 BGKojoLXaB9UstWUvu6D6ot+WKeIHECF+5wckl3Q4UGCG7w5doL1RUYT3w0F9oIWNe
	 gLhwb6DPD2mJwzurcJcNiDRsvB/2mfF1qGBwcfDF7h5ASraAdbPH6+NOe/M6Dx/D9E
	 vNHcaeudSxm2Q==
Date: Thu, 28 May 2026 16:46:15 +0000
To: Hongling Zeng <zenghongling@kylinos.cn>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, kees@kernel.org, dan.carpenter@linaro.org, lukeyang.dev@gmail.com, linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpib: fmh_gpib: Fix resource leaks in fmh_gpib_attach_impl
Message-ID: <LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGqlz493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=@protonmail.com>
In-Reply-To: <20260528015028.12802-1-zenghongling@kylinos.cn>
References: <20260528015028.12802-1-zenghongling@kylinos.cn>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 1936884bd5ff52f6fcd5388be70fe5051bf14b84
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org,linaro.org,vger.kernel.org,126.com];
	TAGGED_FROM(0.00)[bounces-255066-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.karol.piatkowski@protonmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[protonmail.com]
X-Rspamd-Queue-Id: 603FC5F56AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hongling Zeng,

On Thursday, May 28th, 2026 at 03:50, Hongling Zeng <zenghongling@kylinos.c=
n> wrote:

> The fmh_gpib_attach_impl() function has multiple resource leaks in its
> error handling paths. When any initialization step fails, the function
> returns early without properly releasing previously acquired resources.
>=20
> Fix by adding proper error handling labels and cleanup code that releases
> resources in the reverse order they were acquired.
>=20
> Fixes: 8e4841a0888c7 ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB d=
river")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
> Suggested-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@pro=
tonmail.com>
>=20
> ---
> Changes in v2:
>  - Fixed unnecessary retval assignments in early error returns
>  - Removed extra newline
>  - Kept e_priv->irq assignment after request_irq() succeeds,as suggested =
by Dominik Karol
> ---
>  drivers/gpib/fmh_gpib/fmh_gpib.c | 37 +++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh=
_gpib.c
> index fcafdc02ea2e..404379cd1565 100644
> --- a/drivers/gpib/fmh_gpib/fmh_gpib.c
> +++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
> @@ -1418,7 +1418,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *=
board, const struct gpib_boar
>  =09=09=09=09     resource_size(e_priv->gpib_iomem_res));
>  =09if (!nec_priv->mmiobase) {
>  =09=09dev_err(board->dev, "Could not map I/O memory\n");
> -=09=09return -ENOMEM;
> +=09=09retval =3D -ENOMEM;
> +=09=09goto err_release_gpib_region;
>  =09}
>  =09dev_dbg(board->dev, "iobase %pr remapped to %p\n",
>  =09=09e_priv->gpib_iomem_res, nec_priv->mmiobase);
> @@ -1426,34 +1427,39 @@ static int fmh_gpib_attach_impl(struct gpib_board=
 *board, const struct gpib_boar
>  =09res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos=
");
>  =09if (!res) {
>  =09=09dev_err(board->dev, "Unable to locate mmio resource for gpib dma p=
ort\n");
> -=09=09return -ENODEV;
> +=09=09retval =3D -ENODEV;
> +=09=09goto err_iounmap_gpib;
>  =09}
>  =09if (request_mem_region(res->start,
>  =09=09=09       resource_size(res),
>  =09=09=09       pdev->name) =3D=3D NULL) {
>  =09=09dev_err(board->dev, "cannot claim registers\n");
> -=09=09return -ENXIO;
> +=09=09retval =3D -ENXIO;
> +=09=09goto err_iounmap_gpib;
>  =09}
>  =09e_priv->dma_port_res =3D res;
>  =09e_priv->fifo_base =3D ioremap(e_priv->dma_port_res->start,
>  =09=09=09=09    resource_size(e_priv->dma_port_res));
>  =09if (!e_priv->fifo_base) {
>  =09=09dev_err(board->dev, "Could not map I/O memory for fifos\n");
> -=09=09return -ENOMEM;
> +=09=09retval =3D -ENOMEM;
> +=09=09goto err_release_dma_region;
>  =09}
>  =09dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=3D%ld\n",
>  =09=09(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
>  =09=09(unsigned long)resource_size(e_priv->dma_port_res));
>=20
>  =09irq =3D platform_get_irq(pdev, 0);
> -=09if (irq < 0)
> -=09=09return -EBUSY;
> +=09if (irq < 0) {
> +=09=09retval =3D -EBUSY;
> +=09=09goto err_iounmap_fifo;
> +=09}
>  =09retval =3D request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->na=
me, board);
>  =09if (retval) {
>  =09=09dev_err(board->dev,
>  =09=09=09"cannot register interrupt handler err=3D%d\n",
>  =09=09=09retval);
> -=09=09return retval;
> +=09=09goto err_iounmap_fifo;
>  =09}
>  =09e_priv->irq =3D irq;
>=20
> @@ -1461,7 +1467,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *=
board, const struct gpib_boar
>  =09=09e_priv->dma_channel =3D dma_request_slave_channel(board->dev, "rxt=
x");
>  =09=09if (!e_priv->dma_channel) {
>  =09=09=09dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n"=
);
> -=09=09=09return -EIO;
> +=09=09=09retval =3D -EIO;
> +=09=09=09goto err_free_irq;
>  =09=09}
>  =09}
>  =09/*
> @@ -1473,6 +1480,20 @@ static int fmh_gpib_attach_impl(struct gpib_board =
*board, const struct gpib_boar
>  =09=09fifo_max_burst_length_mask;
>=20
>  =09return fmh_gpib_init(e_priv, board, handshake_mode);
> +
> +err_free_irq:
> +=09free_irq(e_priv->irq, board);
> +err_iounmap_fifo:
> +=09iounmap(e_priv->fifo_base);
> +err_release_dma_region:
> +=09release_mem_region(e_priv->dma_port_res->start,
> +=09=09=09=09resource_size(e_priv->dma_port_res));
> +err_iounmap_gpib:
> +=09iounmap(nec_priv->mmiobase);
> +err_release_gpib_region:
> +=09release_mem_region(e_priv->gpib_iomem_res->start,
> +=09=09=09=09resource_size(e_priv->gpib_iomem_res));
> +=09return retval;

I see a problem with this patch.

fmh_gpib_attach_impl is called from fmh_gpib_attach_holdoff_(all|end), and =
these
are passed as attach through fmh_gpib_(unaccel_)interface. The only place w=
here
I see attach is called, is in common/iblib.c, in ibonline function. If atta=
ch
fails (that is, returns with -errno), detach is called (fmh_gpib_detach for
this case), where a proper cleanup is performed.

If we release the resources in attach and not clear corresponding e_priv fi=
elds,
we will fail badly in detach, as we do double free/unmap and use after free=
.
Clearing e_priv fields will result in having two competing cleanup routines=
,
and I don't like that idea - let's have one proper cleanup in one place. Th=
e
only way to keep this approach would be to rewrite the core gpib logic for
attach/detach, and I don't know if it's worth the effort - probably not.

Thanks,
Dominik Karol

>  }
>=20
>  int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const struct g=
pib_board_config *config)
> --
> 2.25.1
>=20
> 

