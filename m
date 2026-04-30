Return-Path: <stable+bounces-241974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFZ4Hu+v8mk+tgEAu9opvQ
	(envelope-from <stable+bounces-241974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:27:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF249BFEA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7463F3029E62
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E52609FD;
	Thu, 30 Apr 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNJFKg0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD1227B94;
	Thu, 30 Apr 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512423; cv=none; b=QCZzWZMkuSu2Ypz8CeZ/6glHG5/6fhG71OMWdrDD7ko7CrRLCO5/mudjKcfpp51FFC+TKwZL88WgmksdUsojnQScZb0XNfu052U9xnSMuUBuM0AtGjNNWljUhXbJh2dpqveyCxcKmZ3VwP0+kH6jSgwFKrEszgC3w84PVXOlzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512423; c=relaxed/simple;
	bh=OQClfIllpvjb88x1YwOMzh+Yc6xI81J2AsvPmhkrUcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eB9INLgO8kgewcX3nOPk/LBGxbxwVEah1Y0Fl+Sh5f+UNuLLk1SEPRdEXaWw02Ntj/IM3/572kdM/Ubz2QR1d9oai1tmPvmgO/LvmUIB9uNyYjfNH0BqUcuhtPqlrsfNPyhFp60f/+WxHzOIbYrA6hJ3T5kJ+3UKlWhAZZtxjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNJFKg0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB002C19425;
	Thu, 30 Apr 2026 01:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512423;
	bh=OQClfIllpvjb88x1YwOMzh+Yc6xI81J2AsvPmhkrUcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNJFKg0Vhcrr3OWAB0rM2asrt9S92vjKJONZ1VMNrfo2gE/ZZ0+cprJpMwW3XFbOv
	 fJBs9reV25ahLQW4DMS8+fxy/PmVXi3/DNBIJJlv2XDx7tDEdIoJ7QuJCE4JGy+hG4
	 MDTsQB6UE4HBuKwinyWmDKs2Pan2kUAEbcgl4xvv+scHEziVwnI6ThrMLcnBA9wy1s
	 JakrRwV+WCjCCWIWkbTSTdGtoQHIURyPJ1Xzn1oT6lNlHxaJ2XVTQHgr5+CWsCMkfk
	 skpeLwM4sgjfKeNISI5XmO0xlM7Ux54TvxH3L/Wy8w8DE3TghciRLcYhK8GDqXXAjE
	 yt84HDeDuyWPA==
Date: Wed, 29 Apr 2026 18:27:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Yibo Dong
 <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <20260429182701.28edde72@kernel.org>
In-Reply-To: <CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
References: <20260428030826.47509-1-enelsonmoore@gmail.com>
	<20260429175421.014bb28f@kernel.org>
	<CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1DAF249BFEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241974-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 18:13:46 -0700 Ethan Nelson-Moore wrote:
> On Wed, Apr 29, 2026 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > I'm having second thoughts about this. I'm worried users will come to
> > expect that drivers are marked as BROKEN until such time that they
> > can be considered a sufficiently complete replacement for an OOT /
> > vendor driver. This will be highly subjective. =20
>=20
> I understand your concern, but there is precedent for doing this when
> the driver doesn't work at all.
>=20
> The ntsync driver was marked as broken in commit f5b335dc025c ("misc:
> ntsync: mark driver as "broken" to prevent from building") until it
> was fully merged. The BROKEN dependency was then removed in commit
> c301e1fefc2d ("ntsync: No longer depend on BROKEN.")

ntsync is mere 1.2kLoC, that's 10x smaller than typical networking
driver these days, and even (slightly) smaller than rnpgbe(!)

Most in-tree networking drivers play constant catch-up with the OOT
version so they are never "fully merged".

> If it were my decision, I would remove BROKEN from this driver once it
> supports a stable network connection, and perhaps also once it
> survives suspends and resumes, since that is expected in modern
> desktop use cases. I think that is a fairly objective reading of the
> word BROKEN.

That'd require us to know if the device is going to be used on
desktop because for datacenter NICs suspend/resume does not matter.

> It might also be a good idea to agree on expected uses of
> CONFIG_BROKEN and document them in init/Kconfig.
> Currently it says:
>   This option allows you to choose whether you want to try to
>   compile (and fix) old drivers that haven't been updated to
>   new infrastructure.
> which does not fully encompass what it is used for.

Maybe it was written in simpler times, maybe the help message was
aspirational to begin with..

