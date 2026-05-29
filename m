Return-Path: <stable+bounces-256649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB29GL23GWpByggAu9opvQ
	(envelope-from <stable+bounces-256649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:58:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58A6052D8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1C2F31080ED
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDEA362136;
	Fri, 29 May 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZdLzrXnS"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C8341650
	for <stable@vger.kernel.org>; Fri, 29 May 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068946; cv=none; b=HgHf6M4I337RUaOJL3fh1KebQJBsGPq/pFwL4D/mW8qWXRISDEu/P8WAPPRJMPjoNPhECtcd/XHsv0qWbV8/3Ye5qbul7DORTiEUwsxRpaGEvTw4323ssjs6HPL0KKa9zK8czGVA1in8uGR1ysdRoIENV3fJXM3RcLjB36fcLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068946; c=relaxed/simple;
	bh=nPuQErVlCcplBGtSdE6L3fia/dws+Ss8NuaYx0Fkzg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfxVe75Hu9eXgLwW3uQLM3ufzeyEplK9e5xfAtwR+O3rRooKWalP26zmEK/5gXvsXbWPXl/PUDzKPEcwwPCc6SBja70nF8LFvXn7fIdwsWPDlm3eho6RTavLjgzxFFEm5IWyOlIJIaXh+hO2hlC7YGIlHh77Vx2/XaOWStkn4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ZdLzrXnS; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1780068936; x=1780328136;
	bh=fHYlwqlVaVltquCgam1/QKCg/hyL4nw1BVAZI9s2Y6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZdLzrXnSB6JD/jKsdLi4r2ZzPXMfPbHJjo1hh3lb0mjgLORdk0g4yfFYm9a7tpS60
	 myhT0/Sev7h+DhlqN+FqhnEmhkMAhAfEw72m+8hp1GEkGXa5dce0kaB5l81hLtN3AB
	 Kj+LQDclAnEPcgPwaKxddDGwOSbWKFpLV4MMDCQgAjuVxrtw+Xh/JMWaxzpW9FjRZR
	 H9hDfbGD6q8vqEO+Jc9daayo29d4vYeeZGK8X6gD2AVXhISQ2HBzCum8eA9jFi+0Nk
	 2p8lCiywJqzyaJ1400zQsAwgEUtCNGsnUPLG3T4xKrvDtGvAPIyUdtxpT6XW0Nv4xm
	 fNAZG/jTZS63g==
Date: Fri, 29 May 2026 15:35:27 +0000
To: Hongling Zeng <zhongling0719@126.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, dpenkler@gmail.com, gregkh@linuxfoundation.org, kees@kernel.org, dan.carpenter@linaro.org, lukeyang.dev@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpib: fmh_gpib: Fix resource leaks in fmh_gpib_attach_impl
Message-ID: <yxAGQyh_8PkhaNOpgZPE4tAHL6Kv1Aw9c8DPFDeuZGUcwWgaho99uSL8j67MnB9vHaqOoXcOXAlrv5FgZDcSKd1RoAtrdDU3cUEVbzuktp4=@protonmail.com>
In-Reply-To: <6A192ABC.6010500@126.com>
References: <20260528015028.12802-1-zenghongling@kylinos.cn> <LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGqlz493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=@protonmail.com> <6A192ABC.6010500@126.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 97d95d0ca23f92369cece324fc690906ac014d97
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256649-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[126.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kylinos.cn,gmail.com,linuxfoundation.org,kernel.org,linaro.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.karol.piatkowski@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 0A58A6052D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hongling Zeng,

On Friday, May 29th, 2026 at 07:57, Hongling Zeng <zhongling0719@126.com> w=
rote:

>    Hi Dominik Karol,
>=20
>    Thanks for the analysis. You're right about the double-free issue.
>=20
>    However, there's still a real leak : when dma_fifos resource
>    lookup fails, the previously allocated gpib_iomem_res leaks because
>    dma_port_res isn't assigned yet, so detach() won't clean it up.
>=20
>    Minimal fix: cleanup only before field assignment:
> ```c
>    if (!res) {
>        dev_err(board->dev, "Unable to locate mmio resource for gpib dma
> port\n");
>        release_mem_region(e_priv->gpib_iomem_res->start,
>                          resource_size(e_priv->gpib_iomem_res));

I assume you're talking about the following code:

```
res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
if (!res) {
=09dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n"=
);
=09return -ENODEV;
}
if (request_mem_region(res->start,
=09=09       resource_size(res),
=09=09       pdev->name) =3D=3D NULL) {
=09dev_err(board->dev, "cannot claim registers\n");
=09return -ENXIO;
}
e_priv->dma_port_res =3D res;
```

Earlier in the fmh_gpib_attach_impl we have the following memory region req=
uest:

```
if (request_mem_region(res->start,
=09=09       resource_size(res),
=09=09       pdev->name) =3D=3D NULL) {
=09dev_err(board->dev, "cannot claim registers\n");
=09return -ENXIO;
}
e_priv->gpib_iomem_res =3D res;
```

I see that requested memory region is indeed saved in e_priv->gpib_iomem_re=
s,
and cleaned up in fmh_gpib_detach that is called on failed attach:

```
if (e_priv->gpib_iomem_res)
=09release_mem_region(e_priv->gpib_iomem_res->start,
=09=09=09   resource_size(e_priv->gpib_iomem_res));
```

I don't really see a leak there.

Thanks,
Dominik Karol

>        return -ENODEV;
>    }
>=20
>    This fixes the leak while avoiding double-free. Acceptable approach?
>=20
>    Best regards,
>    Hongling Zeng
>=20
>=20
> =E5=9C=A8 2026=E5=B9=B405=E6=9C=8829=E6=97=A5 00:46, Dominik Karol Pi=
=C4=85tkowski =E5=86=99=E9=81=93:
> > Hi Hongling Zeng,
> >
> > On Thursday, May 28th, 2026 at 03:50, Hongling Zeng <zenghongling@kylin=
os.cn> wrote:
> >
> >> The fmh_gpib_attach_impl() function has multiple resource leaks in its
> >> error handling paths. When any initialization step fails, the function
> >> returns early without properly releasing previously acquired resources=
.
> >>
> >> Fix by adding proper error handling labels and cleanup code that relea=
ses
> >> resources in the reverse order they were acquired.
> >>
> >> Fixes: 8e4841a0888c7 ("staging: gpib: Add Frank Mori Hess FPGA PCI GPI=
B driver")
> >> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@=
protonmail.com>
> >>
> >> ---
> >> Changes in v2:
> >>   - Fixed unnecessary retval assignments in early error returns
> >>   - Removed extra newline
> >>   - Kept e_priv->irq assignment after request_irq() succeeds,as sugges=
ted by Dominik Karol
> >> ---
> >>   drivers/gpib/fmh_gpib/fmh_gpib.c | 37 +++++++++++++++++++++++++-----=
--
> >>   1 file changed, 29 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/=
fmh_gpib.c
> >> index fcafdc02ea2e..404379cd1565 100644
> >> --- a/drivers/gpib/fmh_gpib/fmh_gpib.c
> >> +++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
> >> @@ -1418,7 +1418,8 @@ static int fmh_gpib_attach_impl(struct gpib_boar=
d *board, const struct gpib_boar
> >>   =09=09=09=09     resource_size(e_priv->gpib_iomem_res));
> >>   =09if (!nec_priv->mmiobase) {
> >>   =09=09dev_err(board->dev, "Could not map I/O memory\n");
> >> -=09=09return -ENOMEM;
> >> +=09=09retval =3D -ENOMEM;
> >> +=09=09goto err_release_gpib_region;
> >>   =09}
> >>   =09dev_dbg(board->dev, "iobase %pr remapped to %p\n",
> >>   =09=09e_priv->gpib_iomem_res, nec_priv->mmiobase);
> >> @@ -1426,34 +1427,39 @@ static int fmh_gpib_attach_impl(struct gpib_bo=
ard *board, const struct gpib_boar
> >>   =09res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_f=
ifos");
> >>   =09if (!res) {
> >>   =09=09dev_err(board->dev, "Unable to locate mmio resource for gpib d=
ma port\n");
> >> -=09=09return -ENODEV;
> >> +=09=09retval =3D -ENODEV;
> >> +=09=09goto err_iounmap_gpib;
> >>   =09}
> >>   =09if (request_mem_region(res->start,
> >>   =09=09=09       resource_size(res),
> >>   =09=09=09       pdev->name) =3D=3D NULL) {
> >>   =09=09dev_err(board->dev, "cannot claim registers\n");
> >> -=09=09return -ENXIO;
> >> +=09=09retval =3D -ENXIO;
> >> +=09=09goto err_iounmap_gpib;
> >>   =09}
> >>   =09e_priv->dma_port_res =3D res;
> >>   =09e_priv->fifo_base =3D ioremap(e_priv->dma_port_res->start,
> >>   =09=09=09=09    resource_size(e_priv->dma_port_res));
> >>   =09if (!e_priv->fifo_base) {
> >>   =09=09dev_err(board->dev, "Could not map I/O memory for fifos\n");
> >> -=09=09return -ENOMEM;
> >> +=09=09retval =3D -ENOMEM;
> >> +=09=09goto err_release_dma_region;
> >>   =09}
> >>   =09dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=3D%ld=
\n",
> >>   =09=09(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
> >>   =09=09(unsigned long)resource_size(e_priv->dma_port_res));
> >>
> >>   =09irq =3D platform_get_irq(pdev, 0);
> >> -=09if (irq < 0)
> >> -=09=09return -EBUSY;
> >> +=09if (irq < 0) {
> >> +=09=09retval =3D -EBUSY;
> >> +=09=09goto err_iounmap_fifo;
> >> +=09}
> >>   =09retval =3D request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev=
->name, board);
> >>   =09if (retval) {
> >>   =09=09dev_err(board->dev,
> >>   =09=09=09"cannot register interrupt handler err=3D%d\n",
> >>   =09=09=09retval);
> >> -=09=09return retval;
> >> +=09=09goto err_iounmap_fifo;
> >>   =09}
> >>   =09e_priv->irq =3D irq;
> >>
> >> @@ -1461,7 +1467,8 @@ static int fmh_gpib_attach_impl(struct gpib_boar=
d *board, const struct gpib_boar
> >>   =09=09e_priv->dma_channel =3D dma_request_slave_channel(board->dev, =
"rxtx");
> >>   =09=09if (!e_priv->dma_channel) {
> >>   =09=09=09dev_err(board->dev, "failed to acquire dma channel \"rxtx\"=
.\n");
> >> -=09=09=09return -EIO;
> >> +=09=09=09retval =3D -EIO;
> >> +=09=09=09goto err_free_irq;
> >>   =09=09}
> >>   =09}
> >>   =09/*
> >> @@ -1473,6 +1480,20 @@ static int fmh_gpib_attach_impl(struct gpib_boa=
rd *board, const struct gpib_boar
> >>   =09=09fifo_max_burst_length_mask;
> >>
> >>   =09return fmh_gpib_init(e_priv, board, handshake_mode);
> >> +
> >> +err_free_irq:
> >> +=09free_irq(e_priv->irq, board);
> >> +err_iounmap_fifo:
> >> +=09iounmap(e_priv->fifo_base);
> >> +err_release_dma_region:
> >> +=09release_mem_region(e_priv->dma_port_res->start,
> >> +=09=09=09=09resource_size(e_priv->dma_port_res));
> >> +err_iounmap_gpib:
> >> +=09iounmap(nec_priv->mmiobase);
> >> +err_release_gpib_region:
> >> +=09release_mem_region(e_priv->gpib_iomem_res->start,
> >> +=09=09=09=09resource_size(e_priv->gpib_iomem_res));
> >> +=09return retval;
> > I see a problem with this patch.
> >
> > fmh_gpib_attach_impl is called from fmh_gpib_attach_holdoff_(all|end), =
and these
> > are passed as attach through fmh_gpib_(unaccel_)interface. The only pla=
ce where
> > I see attach is called, is in common/iblib.c, in ibonline function. If =
attach
> > fails (that is, returns with -errno), detach is called (fmh_gpib_detach=
 for
> > this case), where a proper cleanup is performed.
> >
> > If we release the resources in attach and not clear corresponding e_pri=
v fields,
> > we will fail badly in detach, as we do double free/unmap and use after =
free.
> > Clearing e_priv fields will result in having two competing cleanup rout=
ines,
> > and I don't like that idea - let's have one proper cleanup in one place=
. The
> > only way to keep this approach would be to rewrite the core gpib logic =
for
> > attach/detach, and I don't know if it's worth the effort - probably not=
.
> >
> > Thanks,
> > Dominik Karol
> >
> >>   }
> >>
> >>   int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const stru=
ct gpib_board_config *config)
> >> --
> >> 2.25.1
> >>
> >>
>=20
> 

