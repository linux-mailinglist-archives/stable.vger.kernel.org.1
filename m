Return-Path: <stable+bounces-76140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA6978FEA
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC582843F1
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35081CEABF;
	Sat, 14 Sep 2024 10:20:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2122.outbound.protection.partner.outlook.cn [139.219.146.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEC1CE702;
	Sat, 14 Sep 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309205; cv=fail; b=nq4DRxBPaAWyDk2HgS7b6RUbLxd0oQOkT2M3mNZwnKUnJFFY4d0y0dsFhmsBao62UR17sUzKSJiUOJ/dxmmNhq+abT6E8lfy9iY+zju6O2GzssGjj9QgtFQ/O7FfJnfx9Q29EfVOUgh6KWgjglK592ZOYeHepCVXRoCnDDp0wEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309205; c=relaxed/simple;
	bh=blhs5CAKilsO70C6WEWS6BJCin9unRwXrf5H3a9lGZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKFNzosI+RxbcFAhmPva2amh5uPs98vWD/entFFMwkmlYJ6aZrsVRNhRVtfoT5TJAdMpbfbYLBVuitx5YnqRipImUbp4+i/CsPiegI+qWO5Jy9RTOXVtbq1s6ctqw5Dl0N5H2P2L53K+ueJ/XyAX+JDgvnMxAZjZzdJmCdP83/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg8TNf7bLbQKwwaikODJDnNuDyRXBvwxTNJCK1xA+oO8mpUmUVofygWkyKf2Zu9omHrCow06WXM+08o3R5MesUk7Pgw8s1BMC4bJbmk+SIFLi1qvcZjAK19x/N/kdef1r0A5PgWbGyA2hplai111nN1Fb/09J5rijHSvVHypFwHpwwTyWbfOE1VWhUgDNmkuVBHoojWfTpGyuV2GgUww0+/7QSvZqRfccVg3DnyqCrVP1teuKTcumd3YAPbrFR57GcDy7K5/FiWAt5qzqZ/yaSgpzd0PU824nOi0gjRTNjxtCkYGBBhi3jZGxE094B770fB0GQ5Fe98NPhUEbWISJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoz46TKX5G5IgBxfwO5XZC0wJephqd5LjC0r8OxwMgw=;
 b=XmtAkg6PyW1eOW4mKIYTo4/eD149dPWCbC+PPdTn0YYtxxEhrhWzCQ1BG4PgE1ZXaCV6IWg5Um8vOMOtNcltfNdwHmU9D+L9d6g/Eny4XCANWzucnZvMWDZAUWrJGsKhwwjFnEsKJZTgzxOWM3gCDylSAS2nNjo4VZGR8dcOdxfRKeBcN2nu1a6xMfV30m4299W2R3IMWAl+7U5LwxK2KatcSx1ZNz18zcdzLo5fr2dTSr7rR0VynbrqnOpXrr9zcS18nA8O1wK0QSWtSU/DdP+SEOKmMa/fpahX4I8vjBCEBXFkj6BBIYH8LnAA/1pOajdz1mRqurms9sZ7m+MPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Sat, 14 Sep
 2024 10:04:44 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7962.021; Sat, 14 Sep 2024 10:04:43 +0000
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
Thread-Index: AQHbBebciFlAlMvb90WBGNGztNgBK7JW3EkggAAecgCAAAPPgIAACPsAgAAFxiA=
Date: Sat, 14 Sep 2024 10:04:43 +0000
Message-ID:
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
In-Reply-To: <2024091445-underwent-rearview-24be@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1113:EE_
x-ms-office365-filtering-correlation-id: b96609c0-922c-4627-aaca-08dcd4a4a810
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700018;
x-microsoft-antispam-message-info:
 6daP5ZEDehCuhGQr/hLRYsjKNdsrZ/Y1JZM/jiwJrutwHfs6U+dc4J2kZtvLT6TiQQOLeeOwK6knyGj+z9BnKVfhcJI3ilfZI3xFj8RyJaxHdy0uTk9l4jyu1HsD/u2E27LRW8sIZEyyiUNH+Fswh9o+k2U/7F5xhLxoutnisyk5ZSI/3GHwAZH2VPT/YIVSOAUcj7sQGQYvGzv3qp1Z6z5KEq9ZnhDR8LE8qEk86+QD1vHgsol3DAe8skIF/xkuthmqWz4gmrwXGXmnJnIZYjwvRmXuIfCL5xmE9/U1+RHlOx+70sT2/9r6nfNjzrubGbupYRgO9dvee0it/ht88USnSn2vvpGl2aHQ73Bo3Wjha+7Yq0P5ekGXPdvJMkxDhHGg3KWPtNKub2xkGqTmSShB5zJeYabo9oNHIbjYEwoAr+LIf6e7tGkHUeK8m9GmdKBhA+b/wnFLHZbcAoq6ZfYxvEPLnEEhc4R4jLGGDq+tRuoelbtOH7V0fAnsgY2r8POlcs31YMWBxwgEme4W1izEpYjeeOrPbD7fyVdxpbLlmmOoAvBU3JsbvR5hoytPDWy3DR9PU9lb9CNXHHECP2KBNgm0a6P3lhkmTgDHB00vlbKsOVCNx80gRPAec3Pd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aPIn757XZTnxY1E5DBPmSaklsfCDrvczLgjgZ+9JV9LzQ0MD6BHHYEJovpHB?=
 =?us-ascii?Q?OgSvWFVTz1QeKlVeBlmiQhpdeeYlZGDLFFpHwd9WeZVFpu5lDzx+WJ7KlFJi?=
 =?us-ascii?Q?poXKAtpMECyLJUVnbZp1cd86GKiQ7r5zGliDD7ENwnWioz1mvBc07/boSck8?=
 =?us-ascii?Q?4ZAU4r9DxvxJielZcMVbZdUgoxcvxVw61jF+ybSvsIwQ5KUBYGuCI26eko6c?=
 =?us-ascii?Q?JpoBWvVLx2jSvMP9Eo3V6v9XE+c7ybhaxS0g5DTe1EWG4xyupuR1SNUXO5MK?=
 =?us-ascii?Q?QTMGPrcd1IS4eWQZc9HGE0GlVNeCQSGc/4d2vV1rEknZ9YRi3GFuZWbgqu3A?=
 =?us-ascii?Q?PBcYrBeCq9/aV0AEz1j5Olb0TVoJLxaHI8H20oJGpPYQMmL5zokfdsSHOnrh?=
 =?us-ascii?Q?T2mQ/ZYsn1w6ZcpZPwjEovjWYm1pdgEwl0TK5o9w8mHTCoHZ00lVEOWShpPv?=
 =?us-ascii?Q?6DdSVWUB+Ux/6HjyhdHpCqOH4sO1Irl1pvN2+8YaZTMlgUVRgQdUdgWBCKcI?=
 =?us-ascii?Q?wfnDRgvb/oo3Aivdgx3spSbp/JwXIZLyHBhGdNzzwNAHHQclsry3QC/peznV?=
 =?us-ascii?Q?1x3X1ACKghMg6ZVs47AS6VPhDc+RG2X+OP+OapqtvGflyZ6/RTwDJqLQ9MnO?=
 =?us-ascii?Q?3gMK/zwVyeUvoRpFk93KcSF/HuPQFJdFx25fuAu2J1+Yw9rd7o9iRKbvMmUv?=
 =?us-ascii?Q?5sbvXyNXN33nvonAhyu3VKvQhLMSaDZbrzDif2F8KoE4kteDpOxaXamw5hpB?=
 =?us-ascii?Q?7XpLjrwE2YqEndLPf3s470u4PSaC7P3+mu+k6+V8Q2GgY849Ee8QyvXhTIlh?=
 =?us-ascii?Q?kW57y9zy7Vmh8lveQWS0uU0Z5vrC47xYZS0fgq8iScLw/cIyAH46+Hi3CrkC?=
 =?us-ascii?Q?2ZapichJ3EBzyed7mA+/fqUGE5hLu6whB+pjqx0VUHQ2iGVis6sZ34/ynuNU?=
 =?us-ascii?Q?xy6IroxSx7nSDByF0OYqLuJyBV2GGUYmRUp822ZFyAOov7IeMjm6Y7xjg3q7?=
 =?us-ascii?Q?53pP7tqBKgFNtHm7u29R48QpSlt9aQKRyRBy6oxzMy+WWfwQkFWfd4Gn+nua?=
 =?us-ascii?Q?1I/FNC6WH9ku7rrUQ9YQQFrlg5UJZ+waG2R8G2PpvP7m1BDTr6LwsLLVCro3?=
 =?us-ascii?Q?hjBF+ikuxJnwdGM+cDaIYvzMXiAsCF1k9KVCNFFWN5F8dmk4dAxdQbUlkgXG?=
 =?us-ascii?Q?++mRpa/zfbysLMGVZn8yr/pf7G+Hw0EzznkD70/ot/+LbfsGaG7EBIXqEBAD?=
 =?us-ascii?Q?sgKrkl4N776s+mqrnSlFDyiQhOe2SodsCpL4i3xE9LyaXSvAUWQ1HbnV83oP?=
 =?us-ascii?Q?RZo3EEOuDfNggpuEI8vrVRJYGbAWc/VMDq84W2LjF5f91qK8tinJF8wU6Ngz?=
 =?us-ascii?Q?rk/VzPCSJV6+YrGGQViIiPuaqLA+69RsuxmCbEY47/m4FgMLqP57xSp15wvm?=
 =?us-ascii?Q?OfHhbZcFXTlxzas5lxqJ5z8xQUJKUF5bHeORe3u1sftfxENoP2YBYe93P0Nj?=
 =?us-ascii?Q?FM17DRtLVOitit/5oXbKbEPqLs7IvdhWCKOYtYtV5xM4AqRlKmGZcUFQek6r?=
 =?us-ascii?Q?ib1qtJfvkTsS5fB2VumrBP5XBx1Qtu7hKYhXj/4P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b96609c0-922c-4627-aaca-08dcd4a4a810
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 10:04:43.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Sa4IMwllL/ME++fyNBTHuRZVwLdRXMIVp/2jwis+3i1t9PWVdC5tCsuAm+WH1K4P3NPu3jqpoEYehjc2/hmdsLFRtzbRIQVvoAu+HbxoW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1113

On 14/09/2024 17:37, Greg KH wrote:
>=20
> On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> > On 14/09/2024 16:51, Greg KH wrote:
> > >
> > > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > > >
> > > > > This is a note to let you know that I've just added the patch
> > > > > titled
> > > > >
> > > > >     riscv: dts: starfive: jh7110-common: Fix lower rate of
> > > > > CPUfreq by setting PLL0 rate to 1.5GHz
> > > > >
> > > > > to the 6.10-stable tree which can be found at:
> > > > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable=
-
> > > > > queue.git;a=3Dsummary
> > > > >
> > > > > The filename of the patch is:
> > > > >      riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > > > > and it can be found in the queue-6.10 subdirectory.
> > > > >
> > > > > If you, or anyone else, feels it should not be added to the
> > > > > stable tree, please let <stable@vger.kernel.org> know about it.
> > > > >
> > > >
> > > > Hi Sasha,
> > > >
> > > > This patch only has the part of DTS without the clock driver patch[=
1].
> > > > [1]:
> > > > https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@star
> > > > five
> > > > tech.com/
> > > >
> > > > I don't know your plan about this driver patch, or maybe I missed i=
t.
> > > > But the DTS changes really needs the driver patch to work and you
> > > > should add
> > > the driver patch.
> > >
> > > Then why does the commit say:
> > >
> > > > >     Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling
> > > > > for
> > > > > JH7110 SoC")
> > >
> > > Is that line incorrect?
> > >
> >
> > No, this patch can also fix the problem.
> > In that patchset, the patch 2 depended on patch 1,  so I added the Fixe=
s tag in
> both patches.
>=20
> What is the commit id of the other change you are referring to here?
>=20

This commit id is the bug I'm trying to fix. The Fixes tag need to add it.

Thanks,
Xingyu Wu

