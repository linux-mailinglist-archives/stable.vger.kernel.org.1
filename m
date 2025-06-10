Return-Path: <stable+bounces-152313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553BAD3DE4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC2D18827D3
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25FF235BE5;
	Tue, 10 Jun 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aglApJOm"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2091.outbound.protection.outlook.com [40.92.22.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE52327A7;
	Tue, 10 Jun 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570639; cv=fail; b=UbC6u20981xS7PgvY7pi/Y3KIy7uNWPt31ugaD0ldWlIHj9/K/1W0XAfBSxvRrHxGBvy6cKHc9SWLxwXqq2iXJ+yLXMAwSyO27P3dIO1++rb+HhYk7Qij1h8FbcwOlJpeuLwqJx9jArGoV8zs58GneCNdpBu/P+xW5TkGlQV+Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570639; c=relaxed/simple;
	bh=7DFEAFyxNgdFm6dgtQW9h4e3rpI7LuG5oPrzoTOFajA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AROlWFPpGIIsut9/8+NwNZlaxggWbF4Psk6w13xoNC9XPSaW9kgJpAyfRTh5+zDXNZvSS+vBsECsoJVM4TfXiWCHioYur75LC8C5BGJoYfVVVJNEmfJBuJ9i+F5xIGfjLzfOMF3QZCtL3myg2HW4Cq14RrqpDXKKjD3CwIU82a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aglApJOm; arc=fail smtp.client-ip=40.92.22.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfv7Wvp4g3lyt/EITwb0/GMBiFQMWgUCep8iOvstiftRu5QToEuL9Ncw/zuDKQiphEmAuUvKb4rIjBpLv7xc9nQojfHBIcnKDBhGptEC1arfv8kFLWgIXezOdjk1g+TDdFDQuAD9cqDGGeUM55Fu+m3MRdlwEnKSF+zorqeCgQ/sCiAt3meBXNHaYU6d/8p4c8fz+rVas/yXojDl+FpE4ZQNzvTXUMVTo2fgKJM/6oTkYB6sKQL+XameZe29zjFchrTSsThBccSFanj/2FgynJZ5NchiNkYaKTisudfLZvQxqTErsz/rwSpNh4xup1ZDrJEHshucvqgDxknB0/Cd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf6J9tB/VDPfZ/DEq87owthBZ3Atp6vpFNGnC23eYP0=;
 b=WAvjzZlZwJRzInE7csFg64wf9fn2POrk3V1Q3XYznkT3laQ02zfF5QAbM1QS8JnIOWS8JaX1Xzy37fs/5PYaEmsjzIDlBg8sKfaRR/n+iTpi0y+3six/CzmbooWNPXHfxpcmeF9gkQ1i4S9yU6IcntopsTfPn2I698Hc6Xuwxw2Z0m+uUTkWYASVL64RiI5K07my0AkVegD6PhPYs12qrJNGnrGrudKG/22jFdA0QeRFRt4uQtunzqjqL6SRPp4ZvoXq5hAD+K28z7P2vXFJwGUEHuQjbQEbzYtLtz+PHFUJ+Pk+RPGK3ieKemSPheSssuKJ/GK8OCqoB0+sU9fVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf6J9tB/VDPfZ/DEq87owthBZ3Atp6vpFNGnC23eYP0=;
 b=aglApJOm7vSSFKGVUjlHgHrSN016AlOPanBfCCvzewNSpd6aKBDJ0kCqPAMqM+09l+Sw+pXMivD/5AUbYX7cAGyewMtg0t21mf3011E09rcef+VQjOmF/Q/fYZglJe1pmkMEiSNEVM2iX3L/tsfGH3TGW9Hp3xKi/z8Ii+S+a/5/XfNbgPQ7dwA0tE3nZcA+lzlAp3md9ABFYHfP5VhGIZbE5JxtEBaTH+m/Brfy82nNluWxiffyjDVbq/A6FlMtrjmoplM5yN4C3L+2YgObK5R7EVtfhyxL9uygFzMt1urlMwgx2eYBUgVamFuqovg4xpT4yvPCke6wZIImGM9/aA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9986.namprd02.prod.outlook.com (2603:10b6:610:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:50:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Tue, 10 Jun 2025
 15:50:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
Subject: RE: Patch "Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
 guests" has been added to the 6.15-stable tree
Thread-Topic: Patch "Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
 guests" has been added to the 6.15-stable tree
Thread-Index: AQHb2gFAsj6wbjNrgkW7em1Xqz5dpbP8iiXg
Date: Tue, 10 Jun 2025 15:50:33 +0000
Message-ID:
 <SN6PR02MB4157B1CBF121FF4BB19631AAD46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250610121439.1555063-1-sashal@kernel.org>
In-Reply-To: <20250610121439.1555063-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9986:EE_
x-ms-office365-filtering-correlation-id: 5affa826-8ed5-4cdd-a915-08dda836892f
x-ms-exchange-slblob-mailprops:
 yzXCV5TiOCoGdMF1Xm10jHLF8khqh2nhRXZUPXq3EK6yRc9K2M7ybM2CUtESYtUf8WjMxc3wEZRMiCtiNFsiSqDhewIp3lVWyKI4lB2CgFhEwZl/FquSg0LVROBucpHlew4JyS0Az7kHkPKoJfTeMYk0rvczlHp6nKBPsGB36aMaHRHtzdU/c+pEVsuKsFdlKNe7yeJJgwPtJEkXcPG7RDa5pjJ34Rt0lECqUUSMRdmwdmDxxn9jgdTrMmsELToWfRIKTykV33dWdHU1JS4dtHBSQr993CwCK3h89mb+nhc7SzZ5NZv63AtsHAwc3jPkOtTr2Wciox/ExTbWqp2WXDpGK/igYc/OZSOJfTIE42Ep154th9Ufw9Glym9JKGFUTsiErriBP/gLr5HrkY78nCaGvLymDCbYwWv3qr+NQ/zyF29NB3KuSrTxxrr2mQfpHa9+xEB+K/BRNX7DwLpMg0fjNYNfGcckZ49M6Bq/Md0dpMPWQflG4n5Do7o+As/MAs0NR4UMStNJ9WIl+L6MYb1G22zXPqAv7jnD3KzNQr6csN0NEBUeYq8IEs7kiUmYlqwJptlOToObzz5DijFtUXWwLg9A2Un26MmW9geq2V0eaYyOLL52IKMf5FxtAsisYRSftGe/AWvPXtMlj2e9RtZqoc9U8XlBziqud9j++Uiyyvq2Mfu16RFjY4f+v99/WM1yUf9c/yHWTaKyij1hEfYE9v6OdgPDxyBkQ8fOf6781+H8Oq/yBYLpKJbY/WKV6NEBAJptKwpCRZjulysaYsr+OCe4Lcc2BPM408vJRvnELfk8jTzrC00SPHuBiEz3DgPFbuv87HIWMszbvz1sH5snDqsd3/drN7VqN/RC9eqyLhOJrgExBHWfTts8WyJHnM+V5ieJXqc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|19110799006|8060799009|8062599006|4302099013|3412199025|440099028|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NpfFIX9mlC04YwbhIWNknZucOUSntq3RWW7GvdeidY+E3h9lElyEWjB1RXpV?=
 =?us-ascii?Q?/d+b0mGrZijMPLh5cDA5boYWbYWiVdwkOdAkGIDwr0NIIyJTtf/NbBLrugOt?=
 =?us-ascii?Q?qDdi/xC/qyVuhONcRvZ5q5VDrV39GrPyIteIVFxRvK1VvxbjgTT6qsudmCQn?=
 =?us-ascii?Q?bks7Azs17WWR8H8KQfD/TwdO0zgSI2HYEbrojX6DowqFOBYgdvny7VItUcYx?=
 =?us-ascii?Q?Qjv2m/vR2zbWtDNgnXwMcPSB1OE1EQrTbI7LMyNdcGPk67rqHEy3ohAOr9i/?=
 =?us-ascii?Q?AAZKOhszWP+VCDAKtpF9wbN/4W/zs6xt+kqpGyPhdXZyEoySB5g1yzuVLO94?=
 =?us-ascii?Q?juMiZhIXkCdpsaRVv7hhFTinkGfoOwMc2SqFYWZw7EOGTEkvaVTMbiSvk8MK?=
 =?us-ascii?Q?LpXOmb7ph1UlmzTTIjf44JjAZAQK6fiVZaXafotHJxtllXqbDrAHhGliNWh/?=
 =?us-ascii?Q?QfRAuzV8qqEuGwlL6NL19tZpZJeB9wTvaN/8uG5FFPbs1iaXiUwpLo+x+b3i?=
 =?us-ascii?Q?9GagFFCu9QSrU1HH1RXbxQYXFkTChphONvd/sWvJLPcJP6dGyvfmgIdPsiad?=
 =?us-ascii?Q?iTZjM4ie7zxnmAMQoVTRYQCGXTDqzoVakDCG7cGNHle7yqTtUAtUflnOSUd9?=
 =?us-ascii?Q?FdUExFdlF9FEw2rf6JPFbPqtXC0PtdA8GS4qE+LpYrJA5wkn14xq8fua1JN+?=
 =?us-ascii?Q?MSo4CSTmPH8cazF4E/BtIF0WJ2RTrD1g28XmUMwivsiXcxPCVW0VoPYe2gEI?=
 =?us-ascii?Q?mb1/OmTHjzDUAe6R0RWCcJPaQE/RPy34KR9rxO6EekUJP9O8K+0a8Hhsok8v?=
 =?us-ascii?Q?F055wXEsxJT74Og+tKcSa0AALbbmZReFkReyMkbdy2K+i8zj46FAYGq1XNap?=
 =?us-ascii?Q?7Ygk+9WX4GOTAX58EgzJ+WoJzFbaykd2eMdEBQMrghI+YZYFolqtmMjrVpcE?=
 =?us-ascii?Q?MdjyJvqKBEvYapuOV1rgP+e6ChQqRBr5c4/sc+19YD69aDLPzq9y7/Slheh0?=
 =?us-ascii?Q?/ehaEWnVmUgSfgd9OmRgQq2BxJcpr90st0KH+gvMTjRpRaDgKj7QotWVewFf?=
 =?us-ascii?Q?KxLfqmyXRuCg/QJXrcxSA1zOVH+HC7zLKTkTBgrL6GlYjLjZmBbY6IOtkcGK?=
 =?us-ascii?Q?t3WdA1P00MLYwTsZUvd9VmmTd/iPeBZ9Vny0IW+uxX0nuBkhDN9bTPOwKnTE?=
 =?us-ascii?Q?8+iQ7ZetOJBvsp76U3kaw0nKBg+dyvP38tVM9w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sKXkYvUv7x0Nz5g6m0zJFWx/4mtm9gmWUwE8AP3crWPE/caYp1yzdEmZ8ivW?=
 =?us-ascii?Q?CY2KhBgNK5QDqIbknacFmzI7C8Mr475kY5ERwxCcGW6uB2i2N+oSLx6fybMs?=
 =?us-ascii?Q?zS1i6bSqozHC6CJOxjCYWe8Yqkim6gxMz04Qc0Spbv4fy2ANyc2LnftoFxls?=
 =?us-ascii?Q?bRkTtwyIjKLAM81Mkpni22djO009nzI00uQr7z8L+eRTWOT7GTgrQv2GhJip?=
 =?us-ascii?Q?oM/TjzZ9p9cwmYIL+ouTRKS6PFneVZ78isYBKIumcLElNkwPdhQJVyP4/Rbq?=
 =?us-ascii?Q?r3GR60z6/NIYJcBrtlWthXJAZvjyyQnkYEa1hn3ZXyQdKBUCvTSr8Pi2/cJL?=
 =?us-ascii?Q?Vk8NTy6twmKMUjzVcv+JndflHc0OLnJzkUkhpd+Px2Dg37KBRoJpIHGH9Fwp?=
 =?us-ascii?Q?12GaVevktCyaoB/2MknGMQhg9vyE3gKt1/w9RYAUFI5bxGwX3AxbR+J43VWz?=
 =?us-ascii?Q?8m1Ajuhz97xoiqK6ob6r6tatAVjki2F+cy2GbKtjaCkGS6k++k+bls6b9xQQ?=
 =?us-ascii?Q?GyaboXZ0+D68TTLmMCmGeugL6PmOENZ/i7tY2uvd5+h6pIbTrTE54YRGngb7?=
 =?us-ascii?Q?OCkxGBjkJYXRem+nu6rF5A6rc1FwC1Xep0JEpegBLM8otomoeT1gLzMWqegM?=
 =?us-ascii?Q?C6n6aIZR7oVuZ66OngfbSdmprczE3+xTRBvsmykLo5/u+R7lDSoRdV2uJ9i/?=
 =?us-ascii?Q?T24Q61SN3/Ti9LPNHNvPhJGqtaGg8dLY++jtqhkHWBdYUWorjWNPlwQTV6BX?=
 =?us-ascii?Q?KtyBqaVFhxNE7ArLS3midnN2qH/O9PAA5Kbyygvk4bhIFZt4td7iAx0GuGi8?=
 =?us-ascii?Q?yWd2CJKF2S6HnPYmy1z0GClUxUJflan2iW3PWt+wR46WUVgoQV4IyuB1zfhK?=
 =?us-ascii?Q?3Yb8u8FLOmv3XIXJJGXZaxQUJw7LLOZGx0/qzReppJ9gMVpULoa0bx96N+DS?=
 =?us-ascii?Q?CsZDaRswGyU2CErNwDiqXNEHP7JirOMqWXKH5P2aVC9mN8UWuRy/dBYIQ0SE?=
 =?us-ascii?Q?8g4pSR7CZHYaTdFDhrdgSx3d7dSXQZ6uEh4y43CDCNUPoAgxk+KCYUT98+Vk?=
 =?us-ascii?Q?DWONDxNb1ls4sii71xOxRghYelg7dWCos06FFNkJ3O+PN4a/+k9kh+zgM8xO?=
 =?us-ascii?Q?lX4yLd/FG0PMbKbsQkm7KdbHc2I2/Wu+7pysB3HDQs/1zfR0MSWvQTcy3hzS?=
 =?us-ascii?Q?pR8s17uKr3H+fUPErKhL6Fe1pffA/dgrg71k2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affa826-8ed5-4cdd-a915-08dda836892f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 15:50:33.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9986

From: Sasha Levin <sashal@kernel.org>
>
> This is a note to let you know that I've just added the patch titled
>
>     Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
>
> to the 6.15-stable tree which can be found at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
>
> The filename of the patch is:
>      drivers-hv-always-select-config_sysfb-for-hyper-v-gu.patch
> and it can be found in the queue-6.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please DO NOT backport this patch to ANY stable trees, at least
not at the moment. It is causing a config problem that we're trying
to work out. Once the resolution is decided upon, we can figure out
what to backport.

Thanks,

Michael Kelley

>
>
>
> commit 9766859ee9884c35dde0411df167a06452fee3ce
> Author: Michael Kelley <mhklinux@outlook.com>
> Date:   Mon May 19 21:01:43 2025 -0700
>
>     Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
>
>     [ Upstream commit 96959283a58d91ae20d025546f00e16f0a555208 ]
>
>     The Hyper-V host provides guest VMs with a range of MMIO addresses
>     that guest VMBus drivers can use. The VMBus driver in Linux manages
>     that MMIO space, and allocates portions to drivers upon request. As
>     part of managing that MMIO space in a Generation 2 VM, the VMBus
>     driver must reserve the portion of the MMIO space that Hyper-V has
>     designated for the synthetic frame buffer, and not allocate this
>     space to VMBus drivers other than graphics framebuffer drivers. The
>     synthetic frame buffer MMIO area is described by the screen_info data
>     structure that is passed to the Linux kernel at boot time, so the
>     VMBus driver must access screen_info for Generation 2 VMs. (In
>     Generation 1 VMs, the framebuffer MMIO space is communicated to
>     the guest via a PCI pseudo-device, and access to screen_info is
>     not needed.)
>
>     In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
>     the VMBus driver's access to screen_info is restricted to when
>     CONFIG_SYSFB is enabled. CONFIG_SYSFB is typically enabled in kernels
>     built for Hyper-V by virtue of having at least one of CONFIG_FB_EFI,
>     CONFIG_FB_VESA, or CONFIG_SYSFB_SIMPLEFB enabled, so the restriction
>     doesn't usually affect anything. But it's valid to have none of these
>     enabled, in which case CONFIG_SYSFB is not enabled, and the VMBus dri=
ver
>     is unable to properly reserve the framebuffer MMIO space for graphics
>     framebuffer drivers. The framebuffer MMIO space may be assigned to
>     some other VMBus driver, with undefined results. As an example, if
>     a VM is using a PCI pass-thru NVMe controller to host the OS disk,
>     the PCI NVMe controller is probed before any graphics devices, and th=
e
>     NVMe controller is assigned a portion of the framebuffer MMIO space.
>     Hyper-V reports an error to Linux during the probe, and the OS disk
>     fails to get setup. Then Linux fails to boot in the VM.
>
>     Fix this by having CONFIG_HYPERV always select SYSFB. Then the
>     VMBus driver in a Gen 2 VM can always reserve the MMIO space for the
>     graphics framebuffer driver, and prevent the undefined behavior. But
>     don't select SYSFB when building for HYPERV_VTL_MODE as VTLs other
>     than VTL 0 don't have a framebuffer and aren't subject to the issue.
>     Adding SYSFB in such cases is harmless, but would increase the image
>     size for no purpose.
>
>     Fixes: a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
>     Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>     Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>     Link:
> https://lore.kernel.org/st
> able%2F20250520040143.6964-1-
> mhklinux%2540outlook.com&data=3D05%7C02%7C%7C516ef64661c145eb315d08dda818=
61
> 51%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C638851544842065319%7CUn
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DFZnrM9REMICW=
p
> JqW88gD7CxeTwcztS2y8%2B8GqHNtF3E%3D&reserved=3D0
>     Link:
> https://lore.kernel.org/r%25
> 2F20250520040143.6964-1-
> mhklinux%40outlook.com&data=3D05%7C02%7C%7C516ef64661c145eb315d08dda81861=
51
> %7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C638851544842081386%7CUnkn
> own%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dj%2F5AvOlxwTKf=
VUL
> vmNr%2FZliwRVrd9rSlVECyFGqFErE%3D&reserved=3D0
>     Signed-off-by: Wei Liu <wei.liu@kernel.org>
>     Message-ID: <20250520040143.6964-1-mhklinux@outlook.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 6c1416167bd2e..724fc08a73e70 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,6 +9,7 @@ config HYPERV
>       select PARAVIRT
>       select X86_HV_CALLBACK_VECTOR if X86
>       select OF_EARLY_FLATTREE if OF
> +     select SYSFB if !HYPERV_VTL_MODE
>       help
>         Select this option to run Linux as a Hyper-V client operating
>         system.

