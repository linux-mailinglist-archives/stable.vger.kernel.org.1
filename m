Return-Path: <stable+bounces-104349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CF9F3240
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713FE1888C93
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14F205E10;
	Mon, 16 Dec 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="q5XFQIzS"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CED1C8FD7;
	Mon, 16 Dec 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358035; cv=none; b=c3AJPJZn6mhw5MRlIts/Ik2bpw2/xHu41AW01tkN2rIgmG+GWk2gTpzCBOk1aX8Si0NOLdfHKPckrV9z7mDbEqpJEFHIAEJ3d7lHG/Aqy0zZ08rie+DbT/YsDAVF//dU+wU58B25nfC58yVEq2ngLjEk2nB9dsMcb8u8LeXVIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358035; c=relaxed/simple;
	bh=sIxqEiFmEYrpgSwxi1Bzxd/FniKoAgSBJy7igxpN6gs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OHhce2MMYH5LfNxQ8+5t+e5Fad6qCOlFnZgrOg5uWQaBt8S6FVFjFmBQQqPv8wxjs8vHcdkx1p+DYUgo3/N+N588APIiX31ptclrrgyuS/+l+rH7DKBsnqHUcDM2faQQoXZbZ5XqTS/g/aNXTOJ9F4SUXYgVHL8NU+g9Vft4RrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=q5XFQIzS; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from rainloop.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id D49F44076735;
	Mon, 16 Dec 2024 14:07:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D49F44076735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1734358023;
	bh=sIxqEiFmEYrpgSwxi1Bzxd/FniKoAgSBJy7igxpN6gs=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=q5XFQIzSRKUl8W+q16i50PxBo/6YR/y1h5hHzEulk3VW9UfOT1mDWgSXL3fZQGdhX
	 ujq32HCkFvhYYxdsiv3DwZ4Tk+0J7IUVw6b1mgKTD1w4zZzfhAu/gXqbgDYBww8P2i
	 x5cKEnDYTtR80NiSIP8xpMwI9G2YI0Gi3fnN4+jU=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 14:07:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: mordan@ispras.ru
Message-ID: <0a4227dd3582ddd4da13d152ab20854e@ispras.ru>
Subject: Re: [PATCH] usb: phy-tahvo: fix call balance for tu->ick handling
 routines
To: "Dan Carpenter" <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 "=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=" <u.kleine-koenig@baylibre.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Felipe Balbi"
 <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Fedor Pchelkin" <pchelkin@ispras.ru>,
 "Alexey Khoroshilov" <khoroshilov@ispras.ru>, "Vadim Mutilin"
 <mutilin@ispras.ru>, stable@vger.kernel.org
In-Reply-To: <f60184a1-fe12-4a7f-bbbb-e6191f673df4@stanley.mountain>
References: <f60184a1-fe12-4a7f-bbbb-e6191f673df4@stanley.mountain>

Thank you very much for reporting this issue. I will fix it in patch v2.=
=0AThanks, Vitalii=0A=0A=0ADecember 16, 2024 2:53 AM, "Dan Carpenter" <da=
n.carpenter@linaro.org> wrote:=0A=0A> Hi Vitalii,=0A> =0A> kernel test ro=
bot noticed the following build warnings:=0A> =0A> https://git-scm.com/do=
cs/git-format-patch#_base_tree_information]=0A> =0A> url:=0A> https://git=
hub.com/intel-lab-lkp/linux/commits/Vitalii-Mordan/usb-phy-tahvo-fix-call=
-balance-for-tu-=0A> ck-handling-routines/20241209-232934=0A> base: https=
://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing=0A>=
 patch link: https://lore.kernel.org/r/20241209152604.1918882-1-mordan@is=
pras.ru=0A> patch subject: [PATCH] usb: phy-tahvo: fix call balance for t=
u->ick handling routines=0A> config: alpha-randconfig-r072-20241215=0A> (=
https://download.01.org/0day-ci/archive/20241215/202412150530.f03D8q1a-lk=
p@intel.com/config)=0A> compiler: alpha-linux-gcc (GCC) 14.2.0=0A> =0A> I=
f you fix the issue in a separate patch/commit (i.e. not just a new versi=
on of=0A> the same patch/commit), kindly add following tags=0A> | Reporte=
d-by: kernel test robot <lkp@intel.com>=0A> | Reported-by: Dan Carpenter =
<dan.carpenter@linaro.org>=0A> | Closes: https://lore.kernel.org/r/202412=
150530.f03D8q1a-lkp@intel.com=0A> =0A> smatch warnings:=0A> drivers/usb/p=
hy/phy-tahvo.c:347 tahvo_usb_probe() warn: passing zero to 'PTR_ERR'=0A> =
=0A> vim +/PTR_ERR +347 drivers/usb/phy/phy-tahvo.c=0A> =0A> 9ba96ae5074c=
9f Aaro Koskinen 2013-12-06 341=0A> 9ba96ae5074c9f Aaro Koskinen 2013-12-=
06 342 mutex_init(&tu->serialize);=0A> 9ba96ae5074c9f Aaro Koskinen 2013-=
12-06 343=0A> 125b175df62ecc Vitalii Mordan 2024-12-09 344 tu->ick =3D de=
vm_clk_get_enabled(&pdev->dev,=0A> "usb_l4_ick");=0A> 125b175df62ecc Vita=
lii Mordan 2024-12-09 345 if (!IS_ERR(tu->ick)) {=0A> ^=0A> This typo bre=
aks the driver.=0A> =0A> 125b175df62ecc Vitalii Mordan 2024-12-09 346 dev=
_err(&pdev->dev, "failed to get and enable=0A> clock\n");=0A> 125b175df62=
ecc Vitalii Mordan 2024-12-09 @347 return PTR_ERR(tu->ick);=0A> 125b175df=
62ecc Vitalii Mordan 2024-12-09 348 }=0A> 9ba96ae5074c9f Aaro Koskinen 20=
13-12-06 349=0A> 9ba96ae5074c9f Aaro Koskinen 2013-12-06 350 /*=0A> 9ba96=
ae5074c9f Aaro Koskinen 2013-12-06 351 * Set initial state, so that we ge=
nerate kevents only=0A> on state changes.=0A> 9ba96ae5074c9f Aaro Koskine=
n 2013-12-06 352 */=0A> 9ba96ae5074c9f Aaro Koskinen 2013-12-06 353 tu->v=
bus_state =3D retu_read(rdev, TAHVO_REG_IDSR) &=0A> TAHVO_STAT_VBUS;=0A> =
9ba96ae5074c9f Aaro Koskinen 2013-12-06 354=0A> 860d2686fda7e4 Chanwoo Ch=
oi 2015-07-01 355 tu->extcon =3D devm_extcon_dev_allocate(&pdev->dev,=0A>=
 tahvo_cable);=0A> =0A> --=0A> 0-DAY CI Kernel Test Service=0A> https://g=
ithub.com/intel/lkp-tests/wiki

