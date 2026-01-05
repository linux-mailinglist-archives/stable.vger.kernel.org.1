Return-Path: <stable+bounces-204851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB10CF4D1B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C8B306D71F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26531A812;
	Mon,  5 Jan 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CrVgFhhv"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6382EB5A1
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631659; cv=none; b=PjJwHQPhcQlehm8wMCcfYYrtcslGpVNU9Bsci4GAMTfR8ADOSpFTEgNtwktWDJk2znwDX3DAocgr2xuI8eJDJBd6g/pPFPSwl/AB+1FkSkRlp15N0Dvps6ZPD18n6xYeaoGKlXBFqN7544CYuanGULyaB4+CXMn5nqjjEQYeqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631659; c=relaxed/simple;
	bh=vE2794D/W5nXp6ET7kX4Q6YdPOCF+MHDmWXCqJjspZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We3g5TcqjcqCtu06A5FI6b2BcdoanBM2syvath31K+mziuydV+DyLrnx0hY8ELHYw0MGfbuStoEh9wDiMudPv/b6x2Xht4+iPpMAPBDLva5da9sHlb6Z6G51ognB2ZCEls5fCiDG9Hq4V1JBvrNYSFVh/gqWS9V/tj1VFDnhX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CrVgFhhv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CF0D81A266A;
	Mon,  5 Jan 2026 16:47:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5DA160726;
	Mon,  5 Jan 2026 16:47:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45C4F103C85A3;
	Mon,  5 Jan 2026 17:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767631654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JmLOwaSunIUgS2Z/jJqnNxJyucJfx1rdYcUihadJ/Rs=;
	b=CrVgFhhvlFnNvSnbbB0/ay71UP/pnNtJBSNYSJ99FPwNee9kUJygGlzSg3UY2gO8W1u2Jh
	+Jhf/d0DUZN9ud9CAhSd2B1nXgi8ECJGer24/Uz3lADe+JUkl7fY/oeEFrFtBYPYQau0/l
	tZt67x1sQmkB6/Db5+Ha1Bh4KAZqtsIQNPQmqOvLlEOK2sWfVYDOTohEKRzuZnR8+3lyGW
	Ec3HmxbOEgpIe2p9RTTp50P/QJsKP/umNF0nVtoXa/27dP20LNluMkr7yYHQ+Ith63QPx0
	8ywmLHuhlOh6kE6AMAz07wNUf3j5h4tRFrf3jz+0d3EDAXFqHcuNBOCF9bXigg==
Date: Mon, 5 Jan 2026 17:47:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dianders@chromium.org, luca.ceresoli@bootlin.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case
 of failed probe" failed to apply to 6.12-stable tree
Message-ID: <20260105174732.47163620@kmaincent-XPS-13-7390>
In-Reply-To: <2026010512-flame-zips-0374@gregkh>
References: <2026010529-certainty-unguided-7d41@gregkh>
	<20260105154701.5bc5d143@kmaincent-XPS-13-7390>
	<2026010512-flame-zips-0374@gregkh>
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

On Mon, 5 Jan 2026 17:30:39 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jan 05, 2026 at 03:47:01PM +0100, Kory Maincent wrote:
> > On Mon, 05 Jan 2026 14:26:29 +0100
> > <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >=20
> > > To reproduce the conflict and resubmit, you may use the following
> > > commands: =20
> >=20
> > No conflict on my side on current linux-6.12.y.
> > Have you more informations? =20
>=20
> Did you try building it?  I don't remember why this failed, sorry.

Yes, and I didn't face any errors.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

