Return-Path: <stable+bounces-223671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K9zIgPWrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:15:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F123A584
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B68300D9F7
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B493016F7;
	Mon,  9 Mar 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iKgJtsuP"
X-Original-To: stable@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB534D395
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065728; cv=fail; b=ShGC/M65UNzcxEPfD8cqfWbK612siS4Dny1uVKE9394q4Of/9GgRgYXcphGtzff0c9yKhxoDcD8rklaXCyjsZORANDlzWDKWQBKBEjYYE2jpsr+ICmqqmfLOwjcroA++PAZzL/Gw8K/oqDxt8L9dRQl/fSDjsEi42X1qCrJ97j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065728; c=relaxed/simple;
	bh=AG8PgEQNKqbmbZa+WeDEmri+J85KYNPpPbwR6vqFRfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+rooK9QY+DfdQZYXc/R+uD9FUJBX4horfdYOAduqoA/qp0MbCfT5oM6dlf/EiaShePmyGoJ7FXAwvA9Zf9JvBKf7iGF1p7BqVj4JmLU6PX1gI5d9e1kq/1Vadg2uWdsSjum35faX4a5yh8r2QTTG8hatdlnSdB/PQzHTmHEoIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iKgJtsuP; arc=fail smtp.client-ip=52.101.125.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm8f+qkuRm26hJbNF/L2S/rETkPVpYHRfaewPoRCqOanDD+6vcfIT0VxibXvZRZwZ8fte1gk/6Vf+CFSJlEIM9GUxzbRfdMBh5zrwQNdhq9wisAycdFBl2P5tgSUffWsEULCl2pVw57L3937U/6yDN9sNgQpU0jb2GaTcGpX20ZO20aq+eQm85DdF1WGTPQypnjLRg3nVHBr/t7tPk1Nvgz8Hh5mCZk93fp/lPKFS1f34SgD68gWM1wZbhJ3GDxn+2SpNCQn6I7L/vc/Mr6zRgyUXl5qVYBVPm+pRp8DU4R4BP3xrvmadQj6DKjWaU7/J4KEQpIHIKntZyw0ViU7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ3ZllEbxKULGqvVnGsPDK1P7ag97PEdN7K+lwEKA0c=;
 b=NG9KPfY2UA8gMHyg99sZ+ebPZZ3L47yJBmgI5ZSbGbHFXtvMvsMs5Trd5tm1dclamb0Cp5q2CevrXMo0KaG9mdb5W/sWFpO3RFd9qOAQbrFNBNAo/c9/I5VyG5Ld7y2tz6u0o85kI0gOzGXn5Og6lQoeEU9dgCbmZWQgakPkxg8W+HJY/OOjPRA8ssK3L1iUf0ZpPIVFVTc5vXoNAQAWEe68nbGcx3u9siM05tQGfAeLd6iL4q/JTx8o3pqYwHgHQSzo8b1AbABjwaWH5G6S54e9ZDP8eFR5z9RDQhESgRDcyinO46Dfwiqdi0YMpEtCVGpGk6ostV9yNLqRFV4VRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ3ZllEbxKULGqvVnGsPDK1P7ag97PEdN7K+lwEKA0c=;
 b=iKgJtsuPa8vsOqmkDA8XrEqup+TlmxIAcf5JdPieJc7IXh6L/Wo/JkDoBmmzDDo0ggurFBEAcmMpSDaKZvynn3ChPo1u+SZzyob5D12cz98R19oQuwlWC0r8WthqPoR+ymfZbNwUqHEMvsnkxHpKnYPrEbyNGD98MD+Ou1k4RsI=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TYYP301MB1112.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:152::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:15:23 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:15:20 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 6.18.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Thread-Topic: [PATCH 6.18.y 0/1] net: stmmmac: Fix lpi_intr_o interrupt storms
Thread-Index: AQHcr8qLoBQE9KyP1EWAqK4oG39j27WmPd4g
Date: Mon, 9 Mar 2026 14:15:20 +0000
Message-ID:
 <TY7P301MB19846DF51B88A6038881B113D379A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260306150502.23713-1-ovidiu.panait.rb@renesas.com>
 <2026030900-twitch-maternity-1792@gregkh>
In-Reply-To: <2026030900-twitch-maternity-1792@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TYYP301MB1112:EE_
x-ms-office365-filtering-correlation-id: 1cb82e08-08dd-4d64-dea3-08de7de64bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 uvuv3m9LuH9YRefl00h8y+VQSqHapoJ+5JYmFH3KTE6ZGCsr7Y7cpaUNaRZ8pe0dtDCSkuVJ4gU01Qp476GkfnVasUHIZQQfz7gCgKnTBr4NQZzkwy/6/wRwbuqafriXRRqaM2X68KkhhIB5yUV/WPiDc5inZP/Agegyr+ArgJrYrp+HNaHx3gMGpXKedHb2gJoSivLEb0DlsNe/wKT6R983D1/Dj4jq8/tPdlTH1eCAEUjimxOHlCNALMRTmt1yEEAAU6RDC4rDmaHDP2vsAo25LURPDGiaBbE/xbSC8SDUAedDuT7gApUF3/PDB+/OtT9MsRHXHabv/6HkmOTSniZogtInSHP6qA1J2fI6x0pwYAeZ6FhBfqxT7CQmIRWfy6Rouhtd4cdu8sYrCsC6qmAoh73MLF6yo79Ubg53Zi8iyLa5b8x4szZnJ0SWKGxeNaBNQAvZP40YIUUPSTTuVQjMN/8QgS5pvjTaLc6Cl17/l6EcCeB/HbRXWogUde0zurXkLS0yDpq/lqDNDUE0SBDThHKzzmw7tecJEBdiF9lolpH2YvfhDq1XPRskRNgWkMuacrS7GKaloVA7itwqirQff+H8NJhPP0MLQiInd4+3uZR5ttsRyogRbRJnuY1JHv+ZhQOdQzwnTe5/ne6ez6a6ABshkpl5vmogz4ZFeQ0GaIvC+wVEVo8F2N2VrrpTecyllzQ/jV7zpIMZXgKOIfBywlXYkF567aDLBaMIpbh2tJsWa29knHfs+l3Ho6S7POKNtnKYmtk6xr32fpUDjtH7XzLsBOXKPVwtIDICd48=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uVZNrH72WBvMyw5MPZ2mi/Cmy9BXHHzWVga7Ubw0YPwe+ampOoQDcPHlJ9+5?=
 =?us-ascii?Q?yFg6v7Gc5jGX0vF2eijQ8HWOLYXttziqkFKgaGAo3d1JkAYXZvheNo9tUDp4?=
 =?us-ascii?Q?cewnZPnzHTkRpM98VKnCVVdsWvBMp3vNC4i804SZF8fYx+EbrQI1mRDnYpTK?=
 =?us-ascii?Q?/1aniZwDdKpAj8hy1OJeDU8DzxA+Td59ecj+jt7Pz9140COSYckY5uVvcECH?=
 =?us-ascii?Q?Azs0ul0ZxcaqK6KiPOQDtknma6Oddh+ElLxEb6OlXJw+TLJY3ya91hJEPvWu?=
 =?us-ascii?Q?6OEeoCdDGBVNmDmze/nUMd5b88I2dzwghtr16i4zmZr4dJQIqxHy//SGBxA3?=
 =?us-ascii?Q?QsaBSY0tW9g7tVsJgVq5ShlLNU8YVcI1Km6/spB6g5/MnjRZ/BwuAeowN29D?=
 =?us-ascii?Q?jC74KdN53TYCDsdXAbjcU23/FCRpMXlIQUpBKI5bqhAeasYDHMo852zJvmj2?=
 =?us-ascii?Q?qg05S0OJfs+1/yCD1woZPfZycA1R3xiWScylF2xHFHlYcv3sErPbFf8YV+3J?=
 =?us-ascii?Q?6CGhBpJqKqWXKkbi0yfnLYszfyzQfRcnkGCAkAK7lyeMeTUVncUNdAXPf2Q2?=
 =?us-ascii?Q?ikSeXNVhzgJWNTM1zJQLbxtCFQmr517XlHMgHoa0oYGuDXxRbSa3TvTgAutl?=
 =?us-ascii?Q?Md/ADeAY8U+MnsWYUIS/m8oO3QX3jiJQOh1nbw8LapEOO5pRUrk2MUcg9sGP?=
 =?us-ascii?Q?Cu6JAWcKLPVEzVIryD2fwBqFfYP3Xf4ajr5CFEZhsyGFzxpVfLiWgza2FtIO?=
 =?us-ascii?Q?/lr36T45b25CWRkDWvXvptf8fgzVDuSgDnp4yRrctnkBGJGWfGAjoYJuKf2l?=
 =?us-ascii?Q?26BMhwRCgIIC+P8MqxTVW0an161vcLNJHhFS47WLxdEvUVCMn3c2tIvNdqm/?=
 =?us-ascii?Q?z7jl/Dnwk+tpwCCblnmHt+JxuumRz/17HRKntB/fOOjSCHmIVIdQHwvJXy24?=
 =?us-ascii?Q?jhc3vNHaLUCG9B0CcYbd2Y0XExmuCUTXs8WE5bsRMNsNPNh6H9D8hdTrHdRw?=
 =?us-ascii?Q?UH08DgfkA7IYuxn8yrs70+2JVaV9s+ZrLc0IZ4NWHPrQWhvh8bS+cY0/tNf/?=
 =?us-ascii?Q?QKWoCfSGYwhUhiAajJJqNapup1dCcKSO3Q27A2yKv1y+CBeEiwW2C90vXDD3?=
 =?us-ascii?Q?v9FMt9yS9C5mwL0N6bDE2KpUdoS1rISb/ie8yAp+l81EIRgJ5nGycTQt0bue?=
 =?us-ascii?Q?epPkj7iSpDngJ6ot28UqLQp/kNKmrqkOIUEWKBEegbvN8ydXFORcYO/3ILNg?=
 =?us-ascii?Q?Q8bEVmy67MNeEkeneaBPx/klcf8d8ML8CqvwD6i65gWb7X2+DmXPfLLwbTQn?=
 =?us-ascii?Q?YYM/fT5aYYQ8WjYGPGsnnjg76D4jqf71WjoA7yrpXZ8a+cEggZzTRSYWcMBz?=
 =?us-ascii?Q?54Ebqh3C9iV3b6pLl4ZNRMSZp+vY10E/fIHmTc1hSAKUOv6P+TVsteyrt6s3?=
 =?us-ascii?Q?6SQd2iF+Pb3w4Kvw+uxxQppr7w4WIZE/5kVqQjYnr5QYWD6CNgewkkuWAeNj?=
 =?us-ascii?Q?0wuBk4D6QPfcG5ylacFHrulkCxhD6Xy2H5Si+lFfJJmRpSDh2A/Wc7K5X8CX?=
 =?us-ascii?Q?jjVdbAR6ys6vh87fnRmxJKtPzsDgCWxb/oufvNoWYXbc0GVm17IDsAJZsXB6?=
 =?us-ascii?Q?RvvUM5fQRFrKX/6WX10wqNPCIDHNVt6o/5PsHUqOWWTZUZyrjYq5loeNaBtu?=
 =?us-ascii?Q?VX6mh/RoLikDBV6zLlmjhN2yPss4MgqvoeFDsNnyXSRxDlYvu+/jmYgSYN/7?=
 =?us-ascii?Q?Ml9oGBY/pGhjzcfixA0zFgB27DRDDWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb82e08-08dd-4d64-dea3-08de7de64bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 14:15:20.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wiOPxPPFz/ZbSDew4uBfGHEniA8FVRTWQa4eVZ7FCaUpISs+Zw9W4BfDTZXw8w4Rq3PE/Nktn4sBbQHGsmvINYq9Q9UmN5WWtMYJdkelgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP301MB1112
X-Rspamd-Queue-Id: 472F123A584
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223671-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,renesas.com:dkim]
X-Rspamd-Action: no action


Hi Greg,

>=20
> On Fri, Mar 06, 2026 at 03:05:01PM +0000, Ovidiu Panait wrote:
> > Backport upstream commit 14eb64db8ff0 ("net: stmmac: remove support
> > for lpi_intr_o"), to fix Ethernet interrupt storms on the Renesas RZ/V2=
H
> > and RZ/V2N platforms.
> >
> > The stmmac lpi_intr_o sideband signal is synchronous to the PHY RX
> clock,
> > which can be stopped by the link partner while the interrupt is still
> > asserted, causing an interrupt storm. Since the lpi_intr_o interrupt
> > serves no useful purpose and it causes issues, it was removed in
> mainline.
> >
> > Russell King (Oracle) (1):
> >   net: stmmac: remove support for lpi_intr_o
>=20
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
> >  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
> >  include/linux/stmmac.h                        |  1 -
> >  7 files changed, 59 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>=20
>=20
> What about 6.19.y?

Sorry, I missed this one. I just sent a backport for 6.19.y as well:
https://lore.kernel.org/stable/20260309141111.34678-1-ovidiu.panait.rb@rene=
sas.com/

Thanks,
Ovidiu=20

