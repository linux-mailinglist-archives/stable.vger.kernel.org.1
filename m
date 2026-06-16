Return-Path: <stable+bounces-263525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0C8Cem+MGrzWwUAu9opvQ
	(envelope-from <stable+bounces-263525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:11:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A995168BA23
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:11:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263525-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263525-lists+stable=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 512A0303B4D1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058973C4B63;
	Tue, 16 Jun 2026 03:10:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A23C13FC;
	Tue, 16 Jun 2026 03:10:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579436; cv=fail; b=Y5LZQLlaA91nTrWd2aPTRHRbcHbH9lOg51kO+dXvU+1DxdjJDul1hFvyy+ROzDRLmXncuJ1k9/m2YbieEdiDL1aRx6bTGhKS2Hgao8f0TivmEaHtryMExIJBD3ApnERaIvYJDwqtSW9Jol7VUpD2xi/05cdYcxauGMStcDKrRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579436; c=relaxed/simple;
	bh=rxrTKdsv4TUoWrtaeOAciHMCFZEYCtL+W6NVeGouoXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHYpwS2IMHG9XRbs2Y6sf9AHB9hvh8G0R1Zm6hNn1sG1yvMClhWbj7R0MEUbNIFQYCjlX4fiQcs25dSjGCmzV9iH/YXE2YU+OHyJe/ZEhuVY7Cii9t+p9t0ftX+3pfhTmc2upxYjxCdiP+pMqXm968Hi5iH9XRmR7n5597LgMW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmwSdhUSN+/hyho+IJTkRdFXq2qQ/5QF+W0yi/W69ZKiG+r/E1WEFsKOjfr2xYExOAJthhXf93qaoJvV6A9/lCn7VbhJ7rEONFzkTetkTYv6YNAqpY1LtfacVbnMiCABmMxKKlX+OZ7Q9EIhDHzD4olyzmkurbEoP8+QVI9GDoZDxVHMp5Hn17vDsjvr0BQ/K4B1aAtO+oQvlbQggEb2L3k/spM/7rRgGOiW94H6E2l2d6pXzuU5IC5R8vYSMw4AvgdcbcG5OZYyM585uo/6QB+SyxHJlP+BpKEKC6C3+JG6EOs7x/X/Hedf/MbiiuZLX4U5jddtm7bFe09eV9PWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhdCLbD/v07tVLVNSqn0a0Wecq8ySVeLC9DP3XzYXBA=;
 b=cFrigMfY8/o87ELO4HvK6XOgtQnzthOgUsKqf/w8TeUjeaOVkr/oia9YeAg0UetB31hViqfiTlJMGuaR4GS4ru6QXx5icUrEezzNzBUYxloQ6c15VkVv4uQBFTpbqS2MN6eE+Q2o3orWY+UYEoG3zIDq+oYiD3K5+usSQcb7wvgFBdLZ9efHudSRtnwI7CcUDBO1eY7msdBUIEfdXP9TzFfsfXczt1c2UBenLdUPTQlXbcI5sB/xHvehxF2exM26+fPT4Ny4hAb5FXEWiHwSZDcIc0k7ozXzoBcMJqKyVjAxe4n71uZusHGC4tsxi9Js7PpNvRD0/pK6W8NcT/qKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1162.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:10:17 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0113.015; Tue, 16 Jun 2026 03:10:17 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "kernel@esmil.dk" <kernel@esmil.dk>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>
CC: "bmasney@redhat.com" <bmasney@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] clk: starfive: jh7110-isp: fix refcount leak in
 jh7110_ispcrg_probe()
Thread-Topic: [PATCH] clk: starfive: jh7110-isp: fix refcount leak in
 jh7110_ispcrg_probe()
Thread-Index: AQHc8+12EwOc4EKRQU6uqqmWYrh++bZAk3TQ
Date: Tue, 16 Jun 2026 03:10:17 +0000
Message-ID:
 <ZQ2PR01MB1307AD6833AC18B9B8279356E6E52@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260604064314.3772678-1-vulab@iscas.ac.cn>
In-Reply-To: <20260604064314.3772678-1-vulab@iscas.ac.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1162:EE_
x-ms-office365-filtering-correlation-id: 0087e3a0-2868-4b8b-8d25-08decb54cab2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 LXQsBHXDrzQkAmkEvinGk0LhMCqYg+at/45/rZx7acfPNs1b2WFS1emDqUUsVCavcdRLaPjpHXpUVCeEyri7/OZzqhgYB3HDhORtmsLG81Kv3tlR+kCPY6dsvhkx94YBF35FNLE2kyTobBPuKAF9+iHSsmj9nVndAS6A4u1LBLCYl1eVIbVyUG5knJ2re++bAPPYynZf5AyO8ZOIRtwFbsuXlVQrJe0CNFl6ZutH8W/puH/X9BC/5xPI9ser3edZ04E+CKZfGYZiFQdpDWXGV47ft8hR1ox5dNvLKxqtD43MNRG5EBHN6lwoSY+b/6XgTBjxbZ2N0GOYk1ZDKJ970QJGcGVhicFLPLQip0YXn74XjxQNJYsUg9GZET2gTTD8WQVd0WvTlRSHbu/lk3IzdYms4mvd06gmtppt9EuCWH41kQuhOWJGm2FNF/Kz1ccNlvqDVE29Xx8kreTlk0txChSqeY0H5DvUP1Wo9jiVC1M2oQY4g4U9LcGeOL/ZXLR//1fqZazjNGo4kl0CzN8im5NONzKZHPTF37uTDywjJTwDAMJ4JdeKSX8tRdQ+aESq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SNUpUFzYWGXwMfK7wNIb/+zh4yUneAZspE9H1e4jApqTN7ZlOqip20OhRFkl?=
 =?us-ascii?Q?trE3Bv4NBV5qq/kSkQ0BSt0J5/2EDr5qL5ex4tQPQl9ZO71Uw7RUE2rnk1Zc?=
 =?us-ascii?Q?H0rh0E76FY51A6eVtzP0XhvVwJGZgZXxXXLyuc/Tza0kRrEd5JNSj7eAI123?=
 =?us-ascii?Q?xqNxTJwbu+E4MicPGV8iYtHoZ5GkYjF6+ChucSRVVO8IpZPiFnHsrlVD2Ayw?=
 =?us-ascii?Q?hc+ompCZTOgB012UgzaUGBmwzA8+PLaEycwHYVDoaJ6tURmDC/BS9RRoYAJ9?=
 =?us-ascii?Q?Aix5FNh2cktBSlqqBrnspKroq+nGWMDRvLTFvfEC6hRwIi/t7kcrKRE6XRiB?=
 =?us-ascii?Q?Jvl8Gm82ho/h8lK+EvTkC912q9sZv43aHBOK0Thn4N8FYh1N0Dl02ZG3hUz1?=
 =?us-ascii?Q?87vFF7bzTGHU0oKfcwVeFtavSgfV5AP/b0OuyPzYeONBXs17UmKRKMzQp97V?=
 =?us-ascii?Q?BEJKKpCBpLwdJON4qErNkZc9EbrnITb18SJgdJGZn7sMFuo/aUqzxw5PY5f2?=
 =?us-ascii?Q?CVS+jVHHv2yY2Ku+D/Tsje92twQ5dXr4idggv3zNIThlj6M9moZhUDn9kLKH?=
 =?us-ascii?Q?s/AL/gcaYcHL8xsFrTWQLMbvV9caHlSTMda0dod+PMNrDe0Uu6Fso+0EfhLL?=
 =?us-ascii?Q?NYk4Q2/O7Dmj/CI038Jc4fFFBuY19+CZ2q+lozCP6Zkr3woNptCjPm196pjl?=
 =?us-ascii?Q?Tawly8Qh3LaRu3xpgl233CS7LqRekJHKwQzql8XNF6Omd8zk1kPPiD6uaP/a?=
 =?us-ascii?Q?Wqy4wSQXoTe/00HgLZ72NRkgCQDkDWN59PYI9Y7Zvm+SXBv+0HWAm7DrfYHF?=
 =?us-ascii?Q?VgiZ+fIi9x0a+Ztosu05BvreGdHknmcoO8oFOuVY/e10WaEE5TJjsOe+jPOJ?=
 =?us-ascii?Q?xXm3cNWmQ20ckOTv7w2INK13oqdw/SaaYSzypqjTZyomKHYZ5ovAdxkJtUb/?=
 =?us-ascii?Q?baYKdRvYyoxR50ZecRCOd/NwbEwO8Z1fId0CFXJafb5XJeOioBqK2uhnkGJa?=
 =?us-ascii?Q?QcqKy/QbvLfRdGIZmmXFEDjJ/vTu97McpvvAICf6A/+Dnsh+jT1RqtxtIdFI?=
 =?us-ascii?Q?yFef2vx0ZMk/hDTg2DndAv++PUp4N0NHcuEaGJAcVOL6v4VEw+iKI43wI1+R?=
 =?us-ascii?Q?So2ZCFD8rJKT07mPXZHJA8B5YXhxJ5HJVJMkQ2FYHAbpLoGwQUyoP/fKcqHS?=
 =?us-ascii?Q?wbJY4pn/SAs107IjNTCN0SOa675mAfpWCATcFT5fbMqktLB5J8ZQvZSt47V9?=
 =?us-ascii?Q?oaBxX1aYByLerGDNeqN7JhJo/X0hZ3s8xprMAOYptb6Gmr4pAlRAD9DM0vjB?=
 =?us-ascii?Q?tq/k4JMrJcNdPUgHvCsFPNMdEkw0HlL5s36PoOQ5qXK2YEpkraiU+YkMZauU?=
 =?us-ascii?Q?dbQ4kXXp9FV7rLZjO/u4AfpS9JmX6BMPTZ/2+ZwMjmzUROdZT3elhwbzEZhl?=
 =?us-ascii?Q?HQ31Hx5ng2jLXJcZ6WzKEpvVjObv49Q3p2GghA53y6Hvwmzt4Kxg3SqvQ44E?=
 =?us-ascii?Q?L5VM5I/gthMxXWdo0pRJDR2VTGqgojrNP7lc6pi619VsL1wVt9sIAh/Nqdhn?=
 =?us-ascii?Q?bJqRycUni/BcZG49twSuuqgyLds+NtP/57oF8ZQCOfNs+Y51BcQ2MYn//7vd?=
 =?us-ascii?Q?eRNtjX6nUf5PxupkUq5OF+adS/38QX70Jlg5s9MwRkhDiFbbjTz4l2ZCniFf?=
 =?us-ascii?Q?qv1DeJdcZtGBPLn9s3A/KLkUUmzCCaPkWDdADNGJbdN7hKYKhcSxaXHIWUGo?=
 =?us-ascii?Q?yZI9l9MErQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0087e3a0-2868-4b8b-8d25-08decb54cab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 03:10:17.1474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajkkL9PoGjt6iWONy9Mj1D7o/WdZxWR2MA66eOS0ka/J9+qlQGEym3WV5OXYuEuCZrCLPey5duDictO5pbreb1YdHTeuoqZAGPMq6OSwtek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:kernel@esmil.dk,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A995168BA23

> On 26.06.24 14:43, Wentao Liang wrote:
> In jh7110_ispcrg_probe(), the error path for pm_runtime_get_sync() failur=
e
> directly returns without releasing the runtime PM reference count. The ca=
ll to
> __pm_runtime_resume() increments the usage count unconditionally before
> attempting to resume, and does not decrement it on failure. Thus the leak=
ed
> reference makes it impossible to suspend the device later.
>=20
> All other error paths correctly jump to err_exit and call pm_runtime_put_=
sync().
> Fix this by replacing pm_runtime_get_sync() with pm_runtime_resume_and_ge=
t(),
> which properly balances the reference count on error.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 81279f5d0812 ("clk: starfive: Add StarFive JH7110 Image-Signal-Pro=
cess
> clock driver")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/clk/starfive/clk-starfive-jh7110-isp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> index f3fa069db193..c02c8b29a123 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> @@ -130,7 +130,7 @@ static int jh7110_ispcrg_probe(struct platform_device
> *pdev)
>=20
>  	/* enable power domain and clocks */
>  	pm_runtime_enable(priv->dev);
> -	ret =3D pm_runtime_get_sync(priv->dev);
> +	ret =3D pm_runtime_resume_and_get(priv->dev);
>  	if (ret < 0)
>  		return dev_err_probe(priv->dev, ret, "failed to turn on power\n");

Looks good. Keep it consistent with drivers/clk/starfive/clk-starfive-jh711=
0-vout.c.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

