Return-Path: <stable+bounces-76627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8D97B708
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 05:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE22928403E
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA1381C7;
	Wed, 18 Sep 2024 03:09:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F72557A;
	Wed, 18 Sep 2024 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628998; cv=fail; b=MIA9R/o8eDTDxF5UP8eRfLWisyuUUwFld1py8pWTlWe8PiTJXBS9UEAz1/TSYvJM2L+TkYaZaQ6e0IRN2rBQQLBjk4uO//JJLwJITPiQQlbKEN8xnJcV+j1ZpylOq1s94sMGMdNGhzFJ4/pV16tZBwbtRI194n6nYhvul0X6Nbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628998; c=relaxed/simple;
	bh=hLUbOvU4pO6cTVDPhnlfdbD990Gc+X7zmxLdcrrr2p0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgEtHMvtwsi6AMTZDWr0Rbteem0SXhXNCdO5JHM/YNtaUGkA4Td6EzQH7NWUdqai2mzwDnwBjpIKgAz6kj3dNoTlohdciH0Sv2gTQYuimu1HvAWsrCQ50bRjQiL2DzdYwNddiEgMVGIwvhfUCF5n21xEweGRPE5JtsnpOFQU900=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO1F3G8O0z01Hsfva/Ptq07aAEaJLHXCm9czv+kmFW8PemHz4P1kbRbXodkzzuou/OUx4VojMze3mBRFvstPpLk3KsFeHJyKwAVw/H27F2IYfHHzCHN+/0g41tHfb0U8EETLeJaViyODsa1rPNAyo3UUjI97rFex8MtC5KIr8OvNwtj4XTb+XtUIraUQTray8bQqBirYzWAA0KbZNbLGKAXHodH3vUoeJegLkb7wQVe9AXynV47rD6t3gY5aNIB4gOSaNjgRdMlxm2r8aMbVgItZcIlwj30sMqzIYYj9kpXqRXQi8c6AhdsNG8NvV86zZ7KhSwSJJCmVPIyTm4121g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toSm00GLCfjR13AMqe0WCIZpYhkZYCPzydTmwv3ITzI=;
 b=Gky1qhO60tkLPUTAvXyTVY2X0sqjAF1KLCP6bxSe4suHNpDFmw4uea681Tcy0JLpjXe5G4BfnO33Cecuk7mXAlcBgtz4Y+U1fl4bc27P1I4hH1RrJ1aLo9Iny0UoRLWqD95RwXZQP0XO5U4WPQIApbCokTOcS08ixUjLcyU+wBGn1nkf+hsq6jscPIn59jpDKgg/69ByIeTGq6n9zULO9az4iKvFulV5klVA4Af7RXSi56DtpBQECyF0D1n0uDpA+BO5v0LCy0sV/ZzYmrkjuxcq+yocmwDusFUt1D+uQ5VD/VtgTmS5xAKZsuH9JlIecksE60qhg7vX6aEDAmUDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1065.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Wed, 18 Sep
 2024 02:54:57 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7962.021; Wed, 18 Sep 2024 02:54:57 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Greg KH <greg@kroah.com>, Ron Economos <re@w6rz.net>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, Sasha
 Levin <sashal@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Conor
 Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng
	<hal.feng@starfivetech.com>
Subject: RE: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Thread-Topic: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Thread-Index:
 AQHbBebciFlAlMvb90WBGNGztNgBK7JW3EkggAAecgCAAAPPgIAACPsAgAAFxiCAAAm4gIABwcqAgAAbs4CAAAJ1gIAD2eKg
Date: Wed, 18 Sep 2024 02:54:57 +0000
Message-ID:
 <NTZPR01MB0956C27D2BE2076D5B45DFFC9F622@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>
 <2024091501-dreamland-driveway-e0c3@gregkh>
 <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>
 <2024091557-contents-mobster-f2c3@gregkh>
In-Reply-To: <2024091557-contents-mobster-f2c3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1065:EE_
x-ms-office365-filtering-correlation-id: a4c49393-5718-433b-bfe6-08dcd78d47c2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 udRWfcvApgTPM3MaxHT7tLRT0BJVbTYASWBn+II9g27ac+ZT6JWUz2UlGWAhDEXTH95MZwUAvsKDYC95ez1+/th7R+iLLeGrUAWiKD2iRTt02c00F3QxpJax+AfLfVNlpN8oGmiFXNWJfvBgArg+KyajgdTDTQbC8jXF+EE7KPza+e8xq0QmTk+5ifodpRVl+rWeUqxjn9xGJMdb5XZSJ/kQuhIE7JOwHUZb9RGOEtGKr+q9ZtqwRYEh4+3znNOV6DOzuS6KLAsXxuyCyHUQPwrgQm87OdTKMB3JfahRGD3NoBOXBxEgYfnV6JzGNefhTjxYjQAQXky5E6Q7GCLdm2OBrQoaDBx8ZkXwUQ4rH5LpSy58bNZTNsiNRyC8AOKTepoFLzC/EZWaTVIWd98icSXDaMm/DmAA+/kvl4wCHuqA+1zR9ux8z5jadKDUcBOq7IbbP/DhxBu10DsMsG181sa0CPSU5SrGVNwUAYH0D79t2kILcKmL5mReUWCnTYnzypZ/owvzIpnjGLwNcyVFfQJYOhzXu8Phutn4MCtLZmXz9IrcnLKKvcDeatpC1TyiymfauEfkYQmOTCODHiN9ffF0/QUe5BoGLwRyzRaWVKU6wsanM7u6+aBHs1xvE8no
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g91m5+eLLwayFe8SrOaIAD4Yo1/YLdFWhO3iHrf/jzAfD1y6XbDcodaTCw2j?=
 =?us-ascii?Q?zUiUzOgMw8dF0g0Z9Z1OIQBh242MVDDy3OWNNskxTCvdGnuW+pSM+ySaRevb?=
 =?us-ascii?Q?CMJF5B5FTGqf0oi5oZx9XVvy56r/gPPEpBibIdS9UfRNYJREwpvwLsh3Ojbu?=
 =?us-ascii?Q?2bC/q1STiQIbGA6T1ygd5qMOtT/Em8d3/UW1cVoJcQMH/hJu1fHiXOuePsLm?=
 =?us-ascii?Q?0lE5j4hSj2QaaARsxPfUh7ZXHDSbXhh7HtTfdNogYQjXdVmtzpN7cJqPkEw5?=
 =?us-ascii?Q?M+lv7Kh9QVf7gF81skyd5S3g701bU/pADAX1cFSUTdNYvnk3ejAy4dX+pV//?=
 =?us-ascii?Q?K13/gnpXBJrpClDG2y3fife8cn1DzvSzHMRSpYiqFzQnusW6EhpZ3on6NMVN?=
 =?us-ascii?Q?Z0cduPqtvnJzXF/USseeRnkzzFPuUxGgu7ZTiPrwDkEZBG70i+7ann6pR1LJ?=
 =?us-ascii?Q?YGHWPm4t0wFwm94GjKONCCSmMDMhggCjV9Ex+AV7dXVsuQMPJTnQE4OEt615?=
 =?us-ascii?Q?E9qchEiEvtGFlzRUvJKp1tW5BFVX02JGYehj0Nqw6OOy8OgsQG1KUzJghdt6?=
 =?us-ascii?Q?psteV7MWBxcQAxGr3vQ60kBDUKmUPiUNReKMdt56FCdTmIXDMThYmyEvUzwB?=
 =?us-ascii?Q?BORzDDPNyzhiTukvsQOqAWMCLhxe/sSxnJ4ia05UrKq60QhKyCpXPJ3J8l8N?=
 =?us-ascii?Q?VfRIaZ91VP60tP43ZKSULTKCBgou7mqJ4EnRNYZh6LATcZRBMQmv3ea7owvX?=
 =?us-ascii?Q?Qm/Wk6WXiKIiY7pBehTe+hCzb6dF2Ge5XuxnvP4ziNQVp5lju3/woWNkXoZw?=
 =?us-ascii?Q?vMHF+A3JlFjumyXeYnRVH6BkNo6GFZE9tWRFaS97C8rL1kYF1mbx4u4xVfRC?=
 =?us-ascii?Q?vSMgRVr2qyO/Ysh+VwXjFJ2IoMnJxH6+LU3kios3snzcXeMtAnWrB7+0/THe?=
 =?us-ascii?Q?gfDy/MxmfRoud9/CPYSDCAOxNRUt9SHfXDOkHZQWFljqU1OuH1pQQHU/kIxA?=
 =?us-ascii?Q?NZPOgbGHeHeOBInT1zDS/JzxZW5k9DppbnPyDTINYbfe9DqivL/KBpvlouFD?=
 =?us-ascii?Q?7gfPQbS/tMOeEwIU/L4mLKk3KpNCp6ZolmjJ57ZfgXXzVqIlaPEySZFQEGkq?=
 =?us-ascii?Q?J7QC7UBvnZrdSVcmaVlIywEdr/fjUhMecqFcTOU5vbXZZ36iUBOC8Py/5A7L?=
 =?us-ascii?Q?L+f7bOITef00RkDecvsnLS1F7fQait6vlszfXvpiCD8IRXbPDwqzMhtcwxhc?=
 =?us-ascii?Q?eZTihuisdndCp5yuBhyYy4c1nX40NOIDrX8Qz5+EKpPEv81KbWO9O4QUBdXF?=
 =?us-ascii?Q?nOScbf5NW19IIYK8dN/bALuEC4ickexHvSg3vD7rpJVydYtV9HJfxTFriK53?=
 =?us-ascii?Q?NnJTgYn6zFZuleMKfpxTApYGO4nZg0SZ2Fnw99IuAVK+Ak1YKqjwRxF/X6SJ?=
 =?us-ascii?Q?ckif3RUVNiWvlpvtQcZ+YuGFMPkzgl6CWshUFmpMc33uVFw7X09QCHD7GVGw?=
 =?us-ascii?Q?LWdg08330nCiUWw9yX4sWUjseh7AC0rk7C76zLmOGeHH/+WzGztqnH9jG5WJ?=
 =?us-ascii?Q?o+6vWz3mNmfnQj8d5V0rczw9E5XhTJcLTDKUTVn1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c49393-5718-433b-bfe6-08dcd78d47c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 02:54:57.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vq1/bWFXKJ5MNaHGUIhanIPWzOjRFlM0kp9RTlegUb2nOZLSbDUJ5UAuIA1L/ycrpdD81G+RVxNwTgAHWau1A2RZARyUi0eTCzGn+Fu5hCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1065

On 9/15/24 23:10 AM, Greg KH wrote:
>=20
> On Sun, Sep 15, 2024 at 08:01:33AM -0700, Ron Economos wrote:
> > On 9/15/24 6:22 AM, Greg KH wrote:
> > > On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
> > > > On 9/14/24 3:04 AM, Xingyu Wu wrote:
> > > > > On 14/09/2024 17:37, Greg KH wrote:
> > > > > > On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> > > > > > > On 14/09/2024 16:51, Greg KH wrote:
> > > > > > > > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > > > > > > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > > > > > > > > This is a note to let you know that I've just added
> > > > > > > > > > the patch titled
> > > > > > > > > >
> > > > > > > > > >       riscv: dts: starfive: jh7110-common: Fix lower
> > > > > > > > > > rate of CPUfreq by setting PLL0 rate to 1.5GHz
> > > > > > > > > >
> > > > > > > > > > to the 6.10-stable tree which can be found at:
> > > > > > > > > >
> > > > > > > > > > http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/=
s
> > > > > > > > > > table-
> > > > > > > > > > queue.git;a=3Dsummary
> > > > > > > > > >
> > > > > > > > > > The filename of the patch is:
> > > > > > > > > >
> > > > > > > > > > riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.p
> > > > > > > > > > atch and it can be found in the queue-6.10
> > > > > > > > > > subdirectory.
> > > > > > > > > >
> > > > > > > > > > If you, or anyone else, feels it should not be added
> > > > > > > > > > to the stable tree, please let <stable@vger.kernel.org>=
 know
> about it.
> > > > > > > > > >
> > > > > > > > > Hi Sasha,
> > > > > > > > >
> > > > > > > > > This patch only has the part of DTS without the clock dri=
ver
> patch[1].
> > > > > > > > > [1]:
> > > > > > > > > https://lore.kernel.org/all/20240826080430.179788-2-xing
> > > > > > > > > yu.wu@star
> > > > > > > > > five
> > > > > > > > > tech.com/
> > > > > > > > >
> > > > > > > > > I don't know your plan about this driver patch, or maybe =
I missed it.
> > > > > > > > > But the DTS changes really needs the driver patch to
> > > > > > > > > work and you should add
> > > > > > > > the driver patch.
> > > > > > > >
> > > > > > > > Then why does the commit say:
> > > > > > > >
> > > > > > > > > >       Fixes: e2c510d6d630 ("riscv: dts: starfive: Add
> > > > > > > > > > cpu scaling for
> > > > > > > > > > JH7110 SoC")
> > > > > > > > Is that line incorrect?
> > > > > > > >
> > > > > > > No, this patch can also fix the problem.
> > > > > > > In that patchset, the patch 2 depended on patch 1,  so I
> > > > > > > added the Fixes tag in
> > > > > > both patches.
> > > > > >
> > > > > > What is the commit id of the other change you are referring to =
here?
> > > > > >
> > > > > This commit id is the bug I'm trying to fix. The Fixes tag need t=
o add it.
> > > > >
> > > > > Thanks,
> > > > > Xingyu Wu
> > > > >
> > > > I think Greg is looking for this:
> > > >
> > > > commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
> > > >
> > > > clk: starfive: jh7110-sys: Add notifier for PLL0 clock
> > > That commit is already in the following releases:
> > > 	6.6.51 6.10.10
> > > so what are we supposed to be doing here?
> > >
> > > confused,
> > >
> > > greg k-h
> > >
> > Sorry, I didn't check to see if it was already in releases. So the
> > 6.10 queue is fine as is.
> >
> > However, these two patches go together, so the 6.6 queue should also
> > have
> > 61f2e8a3a94175dbbaad6a54f381b2a505324610 "riscv: dts: starfive:
> > jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz=
"
> > added to it.
>=20
> Given that the file arch/riscv/boot/dts/starfive/jh7110-common.dtsi is no=
t in the
> 6.6.y kernel tree, are you sure about this?  If so, where should it be ap=
plied to
> instead?
>=20

Hi Greg,

How about this patch[1] which I sent earlier about DTS?
[1]: https://lore.kernel.org/all/20240507065319.274976-3-xingyu.wu@starfive=
tech.com/

This patch is based on older kernel without the file (jh7110-common.dtsi) a=
nd has been tested to work.

Best regards,
Xingyu Wu

