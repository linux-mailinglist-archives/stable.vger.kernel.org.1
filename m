Return-Path: <stable+bounces-88105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4489AEC62
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C7C2836E2
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B521F818B;
	Thu, 24 Oct 2024 16:39:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF01F4724;
	Thu, 24 Oct 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787984; cv=none; b=HHH2zsvgAgC4AbkU64cLt/lZJxlOn0BR1qvvnMWXNcWMXbqqwkfQeoHgI6UG8jADYL2lZKjW/YCWjC0H6YZ6JpXmvfCytKyVCM3zBqMsxPW0hAfb1Ihfcf+Cp3sM3ObVjgc4IKDef8pd2QJS6cixuLwGFTZp6WX6a4hsgjHUVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787984; c=relaxed/simple;
	bh=eYoarrAnoFZTdpgB6MlucG/L7CPP5HALIOby9tWYAxg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxvp5QAt7UEAGJ3X81yA1QoKmDCHf83/gYFzOqmRDO0Gk7BOOZaOTj5MukfZHSvsslGPrux+Lv5bcqSjdKhQluDfy8dC7OjVqgPOZavZnH5C/uiZpWcxtQTT2dNDOmHnU+44jzZfcKzFe/Bfbs/HgDKBRhDTTgQWmvQvXd99IzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZBSG0w1Vz6K9K7;
	Fri, 25 Oct 2024 00:38:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D569140390;
	Fri, 25 Oct 2024 00:39:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 18:39:38 +0200
Date: Thu, 24 Oct 2024 17:39:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Gregory Price <gourry@gourry.net>,
	<stable@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <20241024173937.00003d80@Huawei.com>
In-Reply-To: <671a7384ec43f_10e5929493@dwillia2-xfh.jf.intel.com.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
	<20241024104237.000067f9@Huawei.com>
	<671a7384ec43f_10e5929493@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 24 Oct 2024 09:19:17 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Tue, 22 Oct 2024 18:43:24 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  =20
> > > When the CXL subsystem is built-in the module init order is determined
> > > by Makefile order. That order violates expectations. The expectation =
is
> > > that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> > > the race cxl_mem will find the enabled CXL root ports it needs and if
> > > cxl_acpi loses the race it will retrigger cxl_mem to attach via
> > > cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> > > enabled immediately upon cxl_acpi_probe() return. That in turn can on=
ly
> > > happen in the CONFIG_CXL_ACPI=3Dy case if the cxl_port object appears
> > > before the cxl_acpi object in the Makefile.
> > >=20
> > > Fix up the order to prevent initialization failures, and make sure th=
at
> > > cxl_port is built-in if cxl_acpi is also built-in.
> > >=20
> > > As for what contributed to this not being found earlier, the CXL
> > > regression environment, cxl_test, builds all CXL functionality as a
> > > module to allow to symbol mocking and other dynamic reload tests.  As=
 a
> > > result there is no regression coverage for the built-in case.
> > >=20
> > > Reported-by: Gregory Price <gourry@gourry.net>
> > > Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> > > Tested-by: Gregory Price <gourry@gourry.net>
> > > Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver") =20
> >=20
> > I don't like this due to likely long term fragility, but any other =20
>=20
> Please be specific about the fragility and how is this different than
> any other Makefile order fragility, like the many cases in
> drivers/Makefile/, or patches fixing up initcall order?

Sure, I don't like any of them ;) Mostly was having a grumpy day
rather than suggesting a change in this.

>=20
> Now, an argument can be made that there are too many CXL sub-objects and
> more can be merged into a monolithic cxl_core object. The flipside of
> that is reduced testability, at least via symbol mocking techniques.
> Just look at the recent case where the fact that
> drivers/cxl/core/region.c is built into cxl_core.o rather than its own
> cxl_region.o object results in an in-line code change to support
> cxl_test [1]. There are tradeoffs.
Absolutely agree.=20
>=20
> > solution is probably more painful.  Long term we should really get
> > a regression test for these ordering issues in place in one of
> > the CIs. =20
>=20
> The final patch in this series does improve cxl_test's ability to catch
> regressions in module init order, and that ordering change did uncover a
> bug. The system works! =F0=9F=98=85
That was indeed good to see!
>=20
> Going further the test mode that is needed, in addition to QEMU
> emulation and cxl_test interface mocking, is kunit or similar [2]
> infrastructure for some function-scope unit tests.
>=20
> [1]: http://lore.kernel.org/20241022030054.258942-1-lizhijian@fujitsu.com
> [2]: http://lore.kernel.org/170795677066.3697776.12587812713093908173.stg=
it@ubuntu
>=20
Yeah, we have a long way to go on testing (common problem!)

Jonathan


