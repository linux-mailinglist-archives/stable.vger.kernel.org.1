Return-Path: <stable+bounces-76139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188E978FB9
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF16B2354A
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C11CEAB2;
	Sat, 14 Sep 2024 09:57:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2111.outbound.protection.partner.outlook.cn [139.219.146.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC43149;
	Sat, 14 Sep 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307850; cv=fail; b=r7/SORhnZbpasGVQ01j/5IudEXnIi4t2vEJuhvEdUzPpPTMZteQIIbVKbEVVyQ/uy+iZtrCyCthQ32H15SnN2TkXSszWynY2Sex2GFq7glxIASaFrLWKPS1ib+xcQxDbAynpPDIT9UVXp4R8CeH2ELGpLfnAayqkixXXE2swHkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307850; c=relaxed/simple;
	bh=ezBu/Xy0NAbafd2hFuhIpoWrVHqvYElg6gRfd+tSgM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUZZNsdshqGpfaiERpYh1cTWh9MaK4K+v3T0NZ3/YSFcgTAV/Hx4VsMKfFVkLuNu7K9rgqDb/vdTDhHS1ZB0sURHpYp/7coNXKOxIZIFf1YdRh3UZ2nnoZFiqxsGL69uomOp+JnA6LE/W3Ar6qtUOASua0fk69+8DpeQrjNBcSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuV8PjEzj7GhpmAcE6taMOaGbhdprA0VHFlFYhiNyII7W5Wod+G5NYKB0zZ9x475q1GvVZwWOwncUoaH3ZdK3XETwOdfogHBEiI9y/f+GsD/bl5JvsmzrVvOo7IvTlIRKAbIpKDfAbJHZ/8HfHWVSdL2fKKeXIueW3mvjXfTzPTq6tJxcBZrvUCB3+JZ6R1WbOCFY4MNgNO8fY6J/Bkj1tCuE0+M/PXq9BLH6RAQqIxPrKFvjskWjBUSl4TwxxH2i2N3POe47KqPIfn1d+2bIUGMDcIQIax+FF1U8l843NluQd2h0KozdC5lDTqZ7X6DfOb9Fp13ZXbmM+Mhck4uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+tsL9mS8j26yl66sqifeAKILtFhAJvsEGwsu139ZQo=;
 b=eKM2TI/f7PGAnvysXv7Zd4oPXe36plg/95UIODkMgV5DDTt0YGPyr5yXOZCJ/cFETnt5h8eRx6U+2774YrWEngebZ5KS1l6bIHd+MQ9IUpNILvq/Y9Sknn7TNO7h1Xo7U9JpX9z8aNweqbZosciWPhXreZVv/cf1qBygaeM60aRb62OQUBCLFu97V94kd1xb2dD01G2QQc5Qq+gGfWR36Gig0ZlfiApawVe5goFGZvZKs9qTCK3jvi8ktgHWQArwYXHiU7vhe3yI+sWJhE4JDB96rYRTnrFPvIOwv6YyZ1qHRKSBLzJqNXhl63Wy+yzK1pTNNHZktrpiKezhtoe6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1084.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sat, 14 Sep
 2024 09:24:44 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7962.021; Sat, 14 Sep 2024 09:24:44 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Greg KH <greg@kroah.com>
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
Thread-Index: AQHbBebciFlAlMvb90WBGNGztNgBK7JW3EkggAAecgCAAAPPgA==
Date: Sat, 14 Sep 2024 09:24:44 +0000
Message-ID:
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
In-Reply-To: <2024091451-partake-dyslexia-e238@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1084:EE_
x-ms-office365-filtering-correlation-id: 6234c0d2-a49c-4fc3-104c-08dcd49f11fb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 imDYJyhW2maJTZ7tZ9g3Ah4rhUPZxGKeFVQITQBcYuM1ANjAezMh2XWq51vz5RFhdqKK9TNJZvGMZvfxP7y6j9mpl0EzMcXQwcjusk7qMsSuuGhrJIbtvVwmPwMOcbx1upQpA+j/s9eV0RmFA8XACIUjUl1LEI02zJ4PZpsqa2evfKt/GQ2483gXmZ1hd9cwL08HuS3AiWL3/5wMpM+roWDuypwm2oWSyJNV4jBT6s23ByBZFcrN1lZbmhBmxxlmcSyB7yWq3cHZqfzZzbvhKgMqBVbS1Ee+h0YuCXnJXNoDTVx2tRGVSCodVJAfTWzq5cJ0Ue/e65cmPS6HUVmKEiDQPR0LmhITP8o9EkylyzBaJA1B18TQwEcGn/5R7BgpA86NORNuZrrgYq0d/0nWMNaan0tQ4el4XUd8MC3Ab8wq3NVTrrIvrYFbovE5h7OJQca70/3ErGRSTAO8ZLYQJTS5f2diJSzs4jBeqh4Oz2j698+J2dLvuaPlfsIeg6jRRTAi5rPk12cIXdUGzWNJheXG2WQKq/oCeoBbugtfgQAVDR2Mf1TqasAIyeUah6c+I3+x5mwRW6a3ZnShiYy47DRAbeg0jKCp8Sg92wTw0j1a/Fz5WzCBkmKDC1RekQBw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nSn88mGI+L1xNj7h/VdXPOpIb4haoncqAdzC+mmlzEp7hFzN6Du9rzsKsInK?=
 =?us-ascii?Q?Y7YGQqGf7K6K7BnC088CuQSyDhx+D5hYE2BAV/KQBlK9RAga4hsfQOKvfNMt?=
 =?us-ascii?Q?AZK740CRT0InrZ5/QKDufaqqKM9j9l3y7kVps5eJNA58nMq/hflESibStDVg?=
 =?us-ascii?Q?vpgJeMHPlP1h5lKxI3e5MW/dW6FIvmfLtUYRVCWsOAcOoJUiDEltg6W3Xwks?=
 =?us-ascii?Q?8Pxm5ZCJjJFPVKD2vJEsr4ErRanM1ZggrcPOn74VBz5unNk5N+tfrXK5UDRd?=
 =?us-ascii?Q?iQfkX0gzKxIr2nQWuXgtTumC5bCy8hXWadWdMgOO6FVJf1h2KVngT6UMDynr?=
 =?us-ascii?Q?DpPbcYkhMcfsRWhw71w5RQc6QmYfdwyRmRWotx/oY7NaKovxr0AQ+nOsNzWT?=
 =?us-ascii?Q?P8+QuRa9lIXfcoTvMxRiqaWtnLGwXoCLtpdbSYJhyw7bCbKJO3743PmN1oxF?=
 =?us-ascii?Q?wBf4AVhHRb9i9uXL0Av3rWleKIOj7G4XLsRmn9AKKihlOO1Yc+37prfp433e?=
 =?us-ascii?Q?TFdrIoYi1Keatd74P7Nwt7r0jQy66qZU02Qqje+RriREypkOuBBPc8SUORoV?=
 =?us-ascii?Q?SpZK4on6HX7uCGhBbQiZIjcTtDSnS1XNdWVJz8Fzix3kP4BUpe2M5PEwSQUy?=
 =?us-ascii?Q?PTvQ/qYI28n93OuZuBY+IHJXr+t1QsDuOUTeeP6PEh0BsSRAJrbhks7nTj4x?=
 =?us-ascii?Q?LJ9degBDNany6ORTm1lXKEPkUZREAZimUWBZYTKqto85LFlr6tfujeN0aDui?=
 =?us-ascii?Q?Y98bvIg/+Dwz5QwoulJ51wlzkgO5gnByh27t1CkNJ21B2G29xnB0Jia2YhNy?=
 =?us-ascii?Q?cO6rYnnoJ2vkEaL7wfsfAT6vqVKm4swSaXjszf8durLHzvObP6mMWv/75ZeC?=
 =?us-ascii?Q?lxoBYgHgDYR9spJNVjkqiLAQ3pJGAVa1ZHzqOGelcmzL3chaXR1XP60H2EJ/?=
 =?us-ascii?Q?bGCOuO70WA2v9WjndKM9zhw1u96iEODaAomXRm8ygi9oFjXx9fkE9nig298u?=
 =?us-ascii?Q?yvK7+TS1JAM87VF1X3h2dzzjfE2p00EGyzKfn2FuFqBVldB41/cN20Hep4K9?=
 =?us-ascii?Q?tKHgvb8nSrQEI/9xmHEAnBk9mrLIApwiGATOLuW+hoPFiCby37WJEBl1sP+k?=
 =?us-ascii?Q?d/nY2fZ5zevEv97FsHJ0orRqTdMrdWTLJSuKWahi4vlwURUMyqAdUsgYrXI0?=
 =?us-ascii?Q?ZLdTsuCf7iVoKq4YUjAJ2LgvqopeBg/CW8LOO/3F7lYoaalIrj7kSWcXpRnH?=
 =?us-ascii?Q?tWzi8UD90Gc/J2kka/67CpYx5nrK1uJeap9RSTY6fcc2xbt3BzltUxSVf4If?=
 =?us-ascii?Q?xxkeycSr3+BTm7nTU4tIXGkxv4rmSQHcfAg8QRNJAPdEzOjXNGH8KlJylvRK?=
 =?us-ascii?Q?DvVBN3/QiX5jpmN2arKgfOYZgEGmeLbhFtUqzs5Qso9C4x4oVh6FpeuRsz2p?=
 =?us-ascii?Q?z142NY4ttOaMFMMVkr9nutjl9418u9GfIZbiWNme5hdO+Jws+Tv/2Es9C26q?=
 =?us-ascii?Q?VcyIjYbY1qrvfY4K8kB6E1OeLDUA/JZVqRWS7rjTjshFsr+v13CurUj1y1sJ?=
 =?us-ascii?Q?dVvH9Bc/eGCfNpwqgEiwcxnR4Pn4FPH3J+DnZctR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6234c0d2-a49c-4fc3-104c-08dcd49f11fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 09:24:44.6106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpiE9umPL+znKLCoHuGsmz3X+ocDXiHF6syruKGdMik+kQoZV0dTtP/KZa4mu5du3FxSjfYqsPZLJZMZDeiBZJTPRf5myr/NpGGCfUJWd7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1084

On 14/09/2024 16:51, Greg KH wrote:
>=20
> On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > On 13/09/2024 22:12, Sasha Levin wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq
> > > by setting PLL0 rate to 1.5GHz
> > >
> > > to the 6.10-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> > > queue.git;a=3Dsummary
> > >
> > > The filename of the patch is:
> > >      riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > > and it can be found in the queue-6.10 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable
> > > tree, please let <stable@vger.kernel.org> know about it.
> > >
> >
> > Hi Sasha,
> >
> > This patch only has the part of DTS without the clock driver patch[1].
> > [1]:
> > https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@starfive
> > tech.com/
> >
> > I don't know your plan about this driver patch, or maybe I missed it.
> > But the DTS changes really needs the driver patch to work and you shoul=
d add
> the driver patch.
>=20
> Then why does the commit say:
>=20
> > >     Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for
> > > JH7110 SoC")
>=20
> Is that line incorrect?
>=20

No, this patch can also fix the problem.
In that patchset, the patch 2 depended on patch 1,  so I added the Fixes ta=
g in both patches.

Thanks,
Xingyu Wu

