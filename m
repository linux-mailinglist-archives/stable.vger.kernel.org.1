Return-Path: <stable+bounces-205091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF386CF8D46
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E789330D2C23
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD731283B;
	Tue,  6 Jan 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CThrL6m/"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F030F95B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710145; cv=none; b=D1zMbbmVXzx85RCIm4rd/V4dlFIETKbNcaRecf9xWutmGe5/r2pGJcOPrgzfoQA3YxalvbymH6XrQrpxFIjxHV81VD+6HpZGVqRiKwPzj8/QBDKDlMdktIKBRcshUF2HHQ4uXamoi7PXZjzl28LH6FZxCEuGM9/Nwyj1urR92mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710145; c=relaxed/simple;
	bh=2g0arGsCZS+agmJlzhw9RVi7pA48B0o0QCSrw7QaI24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvazyvX/sa/KwPvTVVHZzMCnNn4uskENOs+O3OAOItzVOFOKMAwNQyoNkgOawbisjPq4dpWZ0+aafZHGWrsnaT2QnemjeazB6aIoqa70KFXmBHJQ30CuxfrzZyMgo36i4qve3M+LX+a+01WTbAEyv3OMCCnpIBLiuY76JbHx1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CThrL6m/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C68AE1A26A1
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:35:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99E5360739;
	Tue,  6 Jan 2026 14:35:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB75D103C81A4;
	Tue,  6 Jan 2026 15:35:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767710137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GPXBG+K7kv9gnhWYjUJagnLMTxYyWguUJrYhQLKaAoE=;
	b=CThrL6m/Ln7UlqIAlk7mtYdrgF4xs9rETt3Qy7sZix3RwUyIZMJt2ftkpipKQCEaRu2IbG
	J4ctgsvB3d1+1REUu9tm5REuw/Pf++jpfox/pL6qICoZ7L06aQyNSXxBAEAF8CMAZ3Qcem
	fTqSwY2YjUPznqtVygEeUN0vsqL6xMOTiIbPKG20fiY49kLhC+uZPUfeZMq9jia4YPjGmh
	PW8EjndMtSTYYexEh59/DjQaga+KoyXIKMkKsnsxhu5cPgmzYqk34o5T9H5PheTMgE+f2v
	BU/Y1srizL9f+4jPP0j44sgnnOKvo31vUFLwjAOIpVwS0PQQ6G+czChpbDJrfA==
Date: Tue, 6 Jan 2026 15:35:35 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dianders@chromium.org, luca.ceresoli@bootlin.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case
 of failed probe" failed to apply to 6.12-stable tree
Message-ID: <20260106153535.40819ba3@kmaincent-XPS-13-7390>
In-Reply-To: <2026010623-sierra-delay-cd63@gregkh>
References: <2026010529-certainty-unguided-7d41@gregkh>
	<20260105154701.5bc5d143@kmaincent-XPS-13-7390>
	<2026010512-flame-zips-0374@gregkh>
	<20260105174732.47163620@kmaincent-XPS-13-7390>
	<2026010623-sierra-delay-cd63@gregkh>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 6 Jan 2026 15:20:15 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jan 05, 2026 at 05:47:32PM +0100, Kory Maincent wrote:
> > On Mon, 5 Jan 2026 17:30:39 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Mon, Jan 05, 2026 at 03:47:01PM +0100, Kory Maincent wrote: =20
> > > > On Mon, 05 Jan 2026 14:26:29 +0100
> > > > <gregkh@linuxfoundation.org> wrote:
> > > >    =20
> > > > > The patch below does not apply to the 6.12-stable tree.
> > > > > If someone wants it applied there, or to any other stable or long=
term
> > > > > tree, then please email the backport, including the original git
> > > > > commit id to <stable@vger.kernel.org>.
> > > > >=20
> > > > > To reproduce the conflict and resubmit, you may use the following
> > > > > commands:   =20
> > > >=20
> > > > No conflict on my side on current linux-6.12.y.
> > > > Have you more informations?   =20
> > >=20
> > > Did you try building it?  I don't remember why this failed, sorry. =20
> >=20
> > Yes, and I didn't face any errors. =20
>=20
> Fails due to other stable patches in the queue in this same area:
> 	Applying drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch
> to linux-6.12.y Applying patch
> drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch patching file
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c patching file
> drivers/gpu/drm/tilcdc/tilcdc_drv.c Hunk #1 succeeded at 171 (offset -1
> lines). Hunk #2 succeeded at 218 (offset -1 lines).
> 	Hunk #3 succeeded at 311 (offset -1 lines).
> 	Hunk #4 succeeded at 322 (offset -1 lines).
> 	Hunk #5 FAILED at 371.
> 	1 out of 5 hunks FAILED -- rejects in file
> drivers/gpu/drm/tilcdc/tilcdc_drv.c patching file
> drivers/gpu/drm/tilcdc/tilcdc_drv.h Patch
> drm-tilcdc-fix-removal-actions-in-case-of-failed-probe.patch does not app=
ly
> (enforce with -f)
>=20
> Care to rebase on the next release and send it then?

Ok for me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

