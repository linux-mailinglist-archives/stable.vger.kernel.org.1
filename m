Return-Path: <stable+bounces-45443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E18C9EE7
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A8A285DAC
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272A13666E;
	Mon, 20 May 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="1wO7K28E"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4A182DF;
	Mon, 20 May 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215997; cv=none; b=FKhnoGV707mwsiquVOQI15rZV+F380oMd4um80yMV8zrc+cs2SaemP40EVjE5WNL4vXuDSUeNfwkZ0b2uKLXKFbPa2h0V1ZnU9x13NZXhRaBnzwt8tr+b932QhJihrq/rAKu6xjydwyyI5NMXlZV3SlMP4pykRs6axHdeov/8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215997; c=relaxed/simple;
	bh=zv+HW79T1Yvt5Bx0CuWVlQt4BunkONpK9r3/Q08QBwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riMnFJ2qk6C+MVXLRXYXvr+gfEwVlGW18VmrzMKGfvL3mGp41ofhJ5YsVw+H86SWZrlFaS0iVvZbWjM8ybHtfSJUeG6CY+/HWn0JtZD8oYpWsBD33FaJEJ34ZjF7TobxIqQ7ECYLe+0xeD0RPp+Jz91K/eDuGaVE1RAFB+MTzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=1wO7K28E; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716215964; x=1716820764; i=christian@heusel.eu;
	bh=E6KOZeFRaKRuuf5cGm79uMfaPx/NoIu23yMygQh1ZGw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=1wO7K28E0m6W70ZjQLee4fP2vH1fPgGK9sdr+N85Iotr4c+b0kYg8RwgA759+caI
	 BgIkDrp0/X+LMZgrGELDqQUw4OfcwkVakfE+uB+NLGYLhw8t3JbphReg1OhmsQNSO
	 /JZrpBuU4fAmKmkd534NDxfckjKc7cqGfVyzshVe16NwQ3vOgEPgNgan84PFvZYmB
	 TCoUVdRMZJKuymUK/1oG5tkbgzp28Z+whSgJf0X9f9BsHeKRy77jQXb2kHFSQdr/C
	 MA5Pus/JqYJIpvlwM4ZgXUBS36iKUw1Nwoc6vBKz/YWsGtvnJcvrtf788+I7u8pLH
	 ekTJ70QGtnmam+ppKw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MrQ2R-1svrit0eP9-00oUVS; Mon, 20
 May 2024 16:39:24 +0200
Date: Mon, 20 May 2024 16:39:18 +0200
From: Christian Heusel <christian@heusel.eu>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Gia <giacomo.gio@gmail.com>, linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, kernel@micha.zone, Mario Limonciello <mario.limonciello@amd.com>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	linux-usb@vger.kernel.org, Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>, 
	Sanath S <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nnrhtthi7s6ib27g"
Content-Disposition: inline
In-Reply-To: <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
X-Provags-ID: V03:K1:ZNg9RlicgXQ+fJDKfEZ5jsZNNWXsZ+vHdy5LUYK7F/BjaX76F8n
 CztXD7MHswvHJChbEGmq92f8y+zdoPomr0JqrTzQHeuBPEkZcjf03xcubzeKQ2rycj8Yqkd
 QOZTf8enFoEcXxsm3pFr4bI9lbMigjNcPYrN/Jc+vplgcz4n2M1KhIoBSysdjsjwQ8RXutL
 vNB/Bfk9xswX5tnwx93JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VY+TMUEmLjk=;QdvI0unuQ9pdWhUd3kNBbvuQeTc
 l2D6xhUNnzF39PgRdXd/Ej6xACAbqNDzpnMqtciJZCdDBTUfCXCQOHgI3WOwuO0WpQidep5J7
 WtFSTbNhTJE79wc7lnQnAEfeYWEHdA0tc68TkbZ6IcA5opr4OVvzRtUdGhiD7S1fzze1IeMZ4
 2TsQSB/h2NcReoMCzXYKwaewjp7MIc9BWqckNPs8aztnrJTh22esCbqa2TqPxzj9SQPv+qOkJ
 bt0cniOAV62N64RiPMFdka11BuA81CiQVsPcYwhsrVoEYJmAbmRkiTdfLL1f+U02L+BqPlHCV
 1u5OqGInMoq0j+09AcT/4jemxj2pJf92wgcokmvCPprLEYdSXcc6GNlnkdQF0s1SM41NivmSw
 qrD0q8+I5vIJ6iP3RAm2AQny6M1zIj/2rQG5wvVbwVTpucoEF5JMqyofd6Rt0WmKADiSm5pv3
 rSdRoVhggXu7i4paiyv0VvrrGtwH9LaFJkIAMHxJW83LamJSeNjuwZJ+vtU0algZm2SXeOFUq
 hyQPAyUtwIehuA8ywhmlbWxFxtW2SyIELXcH5t3Vaf4GFp/NFsDIUM4sJ2z1xwocBmKRV+mQh
 7vs2582fTSNBOEp2MoxsCSr//nHvmdVxLPFXsAAn/aVESpBpAoJxJSi/eDPZOvP33lvNLbAUw
 zZOi6riqGqrxUGL/2oSEXtPeeq1xPtPdsPIcyv6sNODsvsemXj7u7dJEgrHYNjoQJ4Nb6Op5Z
 WyAXjeZwX3mz/lIKsMihzSaf44igNOgtOGi6ruh07fR0Ujtd2K4AiE=


--nnrhtthi7s6ib27g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing Mario, who asked for the two suspected commits to be backported]
>=20
> On 06.05.24 14:24, Gia wrote:
> > Hello, from 6.8.7=3D>6.8.8 I run into a similar problem with my Caldigit
> > TS3 Plus Thunderbolt 3 dock.
> >=20
> > After the update I see this message on boot "xHCI host controller not
> > responding, assume dead" and the dock is not working anymore. Kernel
> > 6.8.7 works great.

We now have some further information on the matter as somebody was kind
enough to bisect the issue in the [Arch Linux Forums][0]:

    cc4c94a5f6c4 ("thunderbolt: Reset topology created by the boot firmware=
")

This is a stable commit id, the relevant mainline commit is:

    59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware=
")

The other reporter created [a issue][1] in our bugtracker, which I'll
leave here just for completeness sake.

Reported-by: Benjamin B=F6hmke <benjamin@boehmke.net>
Reported-by: Gia <giacomo.gio@gmail.com>
Bisected-by: Benjamin B=F6hmke <benjamin@boehmke.net>

The person doing the bisection also offered to chime in here if further
debugging is needed!

Also CC'ing the Commitauthors & Subsystem Maintainers for this report.

Cheers,
Christian

[0]: https://bbs.archlinux.org/viewtopic.php?pid=3D2172526
[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/48

#regzbot introduced: 59a54c5f3dbd
#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/li=
nux/-/issues/48

--nnrhtthi7s6ib27g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZLYJYACgkQwEfU8yi1
JYUkEg/8DdCQQF3fVww6+qQQk9N0w3n9lodAQQfqdrq3GCnk3iE3JT9jcQ4hh9B1
DIqw50/t7YqpuYSDI4T4RsbNbEj8MPUR45CgVhkcM8PJtlGpmsGqmGLkHV5rl8NS
MFUwiRnJAAETTdmEkS78eX8U9/jXO+Y8IJkFQ8kkDfboIc64TOQTBnAA1WPFNnWO
GEN8AsF5gajc76to2zaqsOtXe/+w6w5fPRpj2Tt1vjujzb3PWvhU0Jh/HtffyOQr
V8FZyhHsUiNo7/jUwFwKOxkSRXmqFUvhmVA7sa/YlSPxanKJ0k1d3Tbq/gr/Xh49
Ay4ul8sqX02YNShxN4zYTH/+Mn58wDdBPD3tYqYg70rCLtDwnlYDqgBh+Nldx0tW
t5PY3At3XKKaIL5/bkrfTkQmC+kVDFG9V8lHUozWxEFNsgz5IhPeuucpxVarqw+9
wiCipYL8Wu9x5C7Mbd5xVahE1oF18iPb0EIt0dMZD8xc2sJcWDoPxhLIbofDKhUR
m38xhfy5ysaD6YpR5ZGt9XP1Lvm6L3lSBYz3M324/Cm6iXGhFytRZpY3b3L8PRcJ
JieEq5CIlhimB5Z5vNYkxv+sqGC629DxPIEyDQUfAe1ebfjUBtHx4tgSU3p9rAXF
7sjyZlvdnmS2TDg0KIXemMjqbLD7LkjIFZTeXe88Kx1kZVHSUsU=
=Va6n
-----END PGP SIGNATURE-----

--nnrhtthi7s6ib27g--

