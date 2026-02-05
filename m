Return-Path: <stable+bounces-214547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBW2AAzvhGkU6wMAu9opvQ
	(envelope-from <stable+bounces-214547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:27:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FDF6D6F
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29756301E3C2
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CC326D4D;
	Thu,  5 Feb 2026 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5X6RIDW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090212EAB6F;
	Thu,  5 Feb 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319619; cv=none; b=KpVxfQg0u09AEZlcOwl9T6o8KrbC0O1hnZtw/wuApjTXF7YfqzTZloDOcrFxAeGAADmKn0gFjk8sv9cX2h8N6hDPLKKt1hfOUQs/LnwlvzIYacKJfYkt8WGw3PXJK3xvZLc8KC8YCTnwfjC5TsuBbV+DiCmkn5InTAnkDKoRTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319619; c=relaxed/simple;
	bh=U4MKUfFI6DFpBMRrK587zNgEG4Th8lIO/6CXoEt2aMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAL88CUfKWudunUz0IqiYe072/3ZgO1ESEU8v6y2ygUrL/qK9IZXlbR5htctrJ3iUTacdyy2HHwaqSaus8JJDWkbSJAl/7EjYWmtN4qi5THGa/G2DjycZjzBrsAhBnUHp4ipZUr45FoxBgAlJr0BuIuXdkai6n1rwxJrOGZBfcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5X6RIDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CA3C4CEF7;
	Thu,  5 Feb 2026 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770319618;
	bh=U4MKUfFI6DFpBMRrK587zNgEG4Th8lIO/6CXoEt2aMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j5X6RIDWYLsTuF5XlVWpU13HyZPPz/wHyGcqmQ3X3N9MwQ6bM+l9ubhTxmOa60Mn6
	 V5S4nhCT/smAjtNWVhzfy63/UCr2Q2QRagzp0M2bHQo2dGW2VIcCnzVf5ZEEiHsxkO
	 JtlmK9cRSy74oGgT1u8RZdnxGNITP0FP4dtnxAyTyCb/7yqvUGurr2zC3JLlGP9oGO
	 Y8uXtpEjw28u/LIWBLZzTdsKUC4xfE/yBtWH1PMspUYVXferMBp3fxwx28VohOhunm
	 Bfw3xn3Af5hHUXUqXWnS8zmJo4f8uG62A2jYWRm/nIq7roBxvZ+s4o5EsTVEhYa9Fc
	 Wh/e1wsDwZdVg==
Date: Thu, 5 Feb 2026 19:26:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Remi Buisson
 <Remi.Buisson@tdk.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Message-ID: <20260205192649.4df4b110@jic23-huawei>
In-Reply-To: <FR3P281MB1757021D0A44A69C2940FC07CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com>
	<aYTDF9BNwzXmd2J8@smile.fi.intel.com>
	<FR3P281MB1757021D0A44A69C2940FC07CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214547-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Queue-Id: 572FDF6D6F
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 17:19:28 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >From:=C2=A0Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent:=C2=A0Thursday, February 5, 2026 17:19
> >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> >Cc:=C2=A0Remi Buisson <Remi.Buisson@tdk.com>; Jonathan Cameron <jic23@ke=
rnel.org>; David Lechner <dlechner@baylibre.com>; Nuno S=C3=A1 <nuno.sa@ana=
log.com>; Andy Shevchenko <andy@kernel.org>; Jonathan Cameron <Jonathan.Cam=
eron@huawei.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; li=
nux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; stable@vger.kern=
el.org <stable@vger.kernel.org>
> >Subject:=C2=A0Re: [PATCH] iio: imu: inv_icm45600: fix regulator put warn=
ing when probe fails
> >=C2=A0
> >On Thu, Feb 05, 2026 at 02:=E2=80=8A35:=E2=80=8A33PM +0100, Jean-Baptist=
e Maneyrol via B4 Relay wrote: > When the driver probe fails we encounter a=
 regulator put warning > because vddio regulator is not stopped before rele=
ase. The issue > comes from
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >ZjQcmQRYFpfptBannerEnd
> >On Thu, Feb 05, 2026 at 02:35:33PM +0100, Jean-Baptiste Maneyrol via B4 =
Relay wrote:
> > =20
> >> When the driver probe fails we encounter a regulator put warning
> >> because vddio regulator is not stopped before release. The issue
> >> comes from pm_runtime not already setup when core probe fails and
> >> the vddio regulator disable callback is called.
> >>=20
> >> Fix the issue by deleting pm_runtime check in the vddio regulator
> >> disable callback and handing over the vddio disable management to
> >> pm_runtime by deleting the disable remove action before setting up
> >> pm_runtime. =20
> >
> >...
> > =20
> >> +	/* hand over vddio management to pm_runtime */
> >> +	devm_remove_action(dev, inv_icm45600_disable_vddio_reg, st); =20
> >
> >First of all, note "remove" vs. "release". Have you tried to remove and =
insert
> >module several times? Does kmemleak happy about this? =20
>=20
> Hello Andy,
>=20
> remove is used on purpose, since we want to avoid disabling the vddio reg=
ulator
> here.
>=20
> The problem we are facing here is that vddio regulator disable is handle =
by 2
> different resource managements: manually with devm_ and with pm_runtime. =
It
> is needed because we want pm_runtime to be able to disable vddio when the=
 chip
> is suspended. And we also want to avoid the manual vddio disable during t=
he
> driver probe for code clarity. To prevent vddio regulator to be disabled =
2 times
> when the driver unloads, the manual vddio disable has a check on pm_runti=
me.
> But when there is an issue in probe (like chip not responding), the vddio
> disable callback is not working correctly because pm_runtime has not been=
 setup.

I'm curious that pm_runtime_status_suspend() returns true under those circu=
mstances.
ah. pm_runtime_init() does that.  It's a bit ugly but maybe a commented
extra all to pm_runtime_set_active() before registering the devm callback t=
o turn
the power off?

>=20
> The most easiest way to fix this is to remove the devm vddio disable when
> pm_runtime is setup to avoid any double free resources. pm_runtime will d=
isable
> vddio, thus there is no risk of resource leak.

This is making life rather complex.  Also what happens if runtime PM is not
configured into the kernel?

I'm really not keen on using devm then ripping it out again. That just
makes a mess of the ordering.

These devm / runtime pm interactions are rather unfortunate.

Jonathan



>=20
> Hope I'm clear enough.
>=20
> Thanks,
> JB
>=20
> >
> >Second, calling devm_*() for release resources is very exceptional situa=
tion.
> >This usually means that something is wrong to begin with in the probe.
> >
> >Can you find a better way without calling devm_*() for releasing resourc=
es?
> >
> >--=20
> >With Best Regards,
> >Andy Shevchenko
>  =20


