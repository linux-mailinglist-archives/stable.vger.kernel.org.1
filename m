Return-Path: <stable+bounces-256604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLrvAep7GWr3wwgAu9opvQ
	(envelope-from <stable+bounces-256604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:43:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7F601C6E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400F8303457E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57A332EAD;
	Fri, 29 May 2026 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RFuxUPv+"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7773DB317;
	Fri, 29 May 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054912; cv=fail; b=Q3/mD8ABiec8ahcBaC7BVMmkxWMZDt3oos4neJiWBH65TexTkArjI2fAiWjOMT3H8U6dFI1RbKfITpWDFfdgORBb+ieT+Z4ZQT2NKunYsIPLSvvCV32UJt00KeppqyfcCgO3XyK8y0cQV+mnUY6VtJ/3u+l5HQyW2bzfgFKr6wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054912; c=relaxed/simple;
	bh=+WPiQ0V0WmRyhXLD6LZru35UImrMRwQpOu8ANr8cCSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oeZ4LcGC3EDrZj76ZYehfqf1JNzQvHEKsjHP7r1oWDgFRQx3RmEewakqqU8dJnvn6x/NO1bNrPpTnGI4XkjQcbAjXdVPzYJyan8CaZmpbsduB3bC4i3q0OdMB/tVaxEqOtdhojx/CZiEkuSg41tRGJzd5/nnTd1maG/FF3EgoyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RFuxUPv+; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y31Jsk9y4IDwxA0ZOEiLJHYH9rHdv4f4g1ZBQgZIjPrLpHJ21wREuSX6T7vuFqJ6fkg94VqpKISJc2OWPiO9cFeLfvhtrJgdH6Q1vWTAO2FvdL9yDH5tl5yj5ytupnzPeIlm1k65YkPVJnVkf8MKz51e0kMGfoXkPvQcPhLc54gfkoYdW2tpIufVVLYfU+SSpdC4U0srLDb/doXEt4v+LF8s8OJGDbN5DA5W0+LUA50F9YhaZt09NbSxGFf1uENhA0/7u9Xbc4s/lmENqJHwOoLoAiM0QYcuCB4hP1sfQSrCZVMz83r7Qm81eKdYlX3TJ0Bw3KRvddfBWoxXQFEPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hInrqHjBg7z/n9KhlwfRg9vIne9TyAKckq8s2VowQno=;
 b=n0DFjPW7r6uNrYgjMP4lDAxft2YtptCRYks/diaYM2qRXqznqy5d0E+cjR2fOEsnuW3xvlyZRNtD0ghW9Sk6S6gX4dYVw2XerCJ85ftVjUai3y8xZjwi7+Z4SvOVt9KScE4/Y99yimv5bkKkPNcQ607V7cVHeYQAkm+mI6gNS8sQAyJ1qqjMqb/j5vXlKHKXPo0Rmob06ibFPHtOXDURjPubebvzlpVjUnd7hnrFojwQGXqy4uAsbifF0yjYr267veUDL4bqZSjCNX9RbsocS3DDmpeL3EnUvdsb+anmNqEQhDGTO+rxyRobxOhHoorvZ8CkEiYEQXnGQ3oxFljlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hInrqHjBg7z/n9KhlwfRg9vIne9TyAKckq8s2VowQno=;
 b=RFuxUPv+uVXw4w5UWBUDbRN3vbi2w0i8Pv85HwzB2doPUpD4QFx5ZauMmgzGkZdP9+Z+K/F+3JpJvSeUZBymJgur43sL8PTMgWceL4UUIcjD7c3mKNSdFe9Olss4DzC2dLwUwJoilNwAqXOO6xl9EP31F5uOb6Cgwu1JluMpfWI5PGO0HZGX3+nngGfhMJhrgMIhRCC2IZUHW1+jzvPAcuTwJW7TF5XQUpbiMVLVtufBsdzRFErxWI068XVM9DvL8r1wcs4ovnxr+ErBaTap7RAHalu6+fbj/M8XQ8FcUqBzkLOI/D2fcsxp1SPg7imJHeRl/rOxhtvoYVqsf9f56A==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by GV1PR04MB9197.eurprd04.prod.outlook.com (2603:10a6:150:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:41:43 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Fri, 29 May 2026
 11:41:43 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>, "Xiubo.Lee@gmail.com"
	<Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>,
	"nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chancel Liu (OSS)"
	<chancel.liu@oss.nxp.com>
Subject: RE: Re: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Topic: Re: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Index: AQHc72AfURLdifOC3Uyxaha2zeOCbA==
Date: Fri, 29 May 2026 11:41:43 +0000
Message-ID:
 <AM9PR04MB8353DA21759A12509CDED8BDE3162@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260529085020.3727790-1-chancel.liu@nxp.com>
 <c5591024-0d8e-4c41-9e35-56689fa94731@kernel.org>
In-Reply-To: <c5591024-0d8e-4c41-9e35-56689fa94731@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|GV1PR04MB9197:EE_
x-ms-office365-filtering-correlation-id: 81ececaa-64d4-490a-7e6e-08debd774184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ArS3wuXfipSbVK/JIKxJEENJJKLVMNALALJkM0FnX8GMfosLqCJiPQc79Um8GO+exyq3j+Tv4Itk3ED9Lma+KsWZEB9yzh+24AAB2kQbQVXXyytUPpfwhqZpFvtbpAinf1ToKgMuju3MbhXtSLej1KAKkZyMWHDA1A/sQi1rGNzrY6vgy9uK9BlvSmChKDlS7qHvYyqfvHlMTMGiOWCRuQISikxrLiy/10RSxd4xEx2KmXM36iNTtq5zkHh9WpjKyPGNYL2HKrpIkhuWCbWxZ+mHfYTHJJ5wHrRExDS1Goa8W0zvA/9lNF4lINJWWCCpw2SPziZQsnAXL1Nw0VDEyFie/KyJdfgaONB9JInpNt7LUF19vgz9GGG2KIjU2yXAacDbapDjSWXLMcTqyU+Jk1cdk+CPKUz0K4vvTwy9sAXr1HnlXeVU3INXynJBu8Eu3Yvz71P7Vz2wom/O/7HQ0jX+4L5hiui9s331rxBTXLdSwjCvQcBZ+ekJm03xU3Dq2FEjAbK1TYPEK39dBqH2zpjbeQ7BbaP326vSgloAHckiRiAQ11YsT6poOJEt52xumYyycl64DRk6El7AEg9cBdVgQVhw8WLEMlkejhpwXhu5EVATxgThlSE+okqJDoK+TitUzBoF5tyLBqPs1MoKncBf05DfCpfbzYFVvKsrLCRBrGJOLryBTFOSZiwcNOXsLt/1+DmxWLdqdSxNqsT2G6xqN4tV/cQpnbWSC8EhD6fLq7HmtzKyMN7COccZoAwT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6hs13INWDHxibtKh0YXjfJS89LAMlXHp5btXY3QqTYk3Uqz0ly3u+kxph4gK?=
 =?us-ascii?Q?liTOQ/JbOH6TmXyWLmn4sOL42eAIbxTLvKv7pc41iCfJlabasi6KKsf9ZpWY?=
 =?us-ascii?Q?/DZt+s/GeKIZcbQpcaapVi5AvfvZbBpnj/cKmGHX+gMjNqn0nZ4XPfwW217J?=
 =?us-ascii?Q?RXMF/5Mr12b+E4kfMtpD6vfdI88z7J2hxveM2Gc75xsjvrRy5HKIRBBUVGyq?=
 =?us-ascii?Q?6d2AegXyds79FTHZHSVI84LP9cTqYsyUrz4CbRFplNMEF35MSP8s+eAsNJ0B?=
 =?us-ascii?Q?5NOVX2zMFaBXKjlaiud0QNTpIV+lnSoxaq6mIbp9ACS0OftQCqnEUaIiLreG?=
 =?us-ascii?Q?owsdXoHnoLTWKzQaNLkFiNp8LqSsM40IJxFIHjCrl5yB6qQERTB5weI4MRtm?=
 =?us-ascii?Q?ivL24HG7HWAdxGqLyK95pYtYJfqRxb1rDi3DnXd/dmtzJzOMruIqGbs4Tk68?=
 =?us-ascii?Q?7bNIOmPnHpUgazpG4x87ABa6/O59VSRhzMeYdiltBabqHJZZgrsPVP2wXmFY?=
 =?us-ascii?Q?qvtUp0nG6Ijnp1CaSN0YRn882+usY9F/QL4bgANf0qGxOMH5JEoYFtTbKFm7?=
 =?us-ascii?Q?MPyPmZAiGtYOW0VOGFya8O+N+fGUmMAonJOPdIywNfiWLCA5EgPMr4pmj3oR?=
 =?us-ascii?Q?FRDGdYMjknnJTx9JUkxZqbIci8/u+QX5W157TkgYNOpkB6hSbXlLqHw9yA9u?=
 =?us-ascii?Q?9OKB4TxbHvgTreNQ2YT3/+eeId8iqbFgnSlkN2NO0xv6u1waNGHQprqT4uR+?=
 =?us-ascii?Q?uzH1MU5ILQhyoof1YD7qZSRj4KsLHPR5R+Hs2iI96EpPVFddFQRz+ZT380TU?=
 =?us-ascii?Q?aUUK5ifZC0sXo+3OKxeGkm97yS0lr8RoxFRzmEADcD4F8Q6DVtEMbUD2oczM?=
 =?us-ascii?Q?xxH3ZosXVPB4rJYZJq4quDD9iyZfFEwQ4hlc+YYrglFPSAkhJsAQ1JOFlh1o?=
 =?us-ascii?Q?JTu+X2yKX4G+cWwOD1E3Sz4dC7lxYeaf/pQwyRiT81uetgInoniAmzjCeoeG?=
 =?us-ascii?Q?7I47ZkxwzHZ6EWw2ZareqyDMKuWVVCqWXp8Lq63swYlk+lCVJvlCNQ1IDALi?=
 =?us-ascii?Q?joKtpIY08UzeGQT7HlXl0ZtZ/0xPBm4zQjdbDuIW7k3Mnh2CG6fNINIyuKNS?=
 =?us-ascii?Q?/dG4wirot/g5ZpXSrmtQmlK8br5bCU1jK3EDGbnVMM/7yj+maDmAfTDBXHPV?=
 =?us-ascii?Q?8Zo+AHOmr3ycy0ws/KrrKOYyEMgsh/mQZEHg+E5eSJRKCT8VUi4BgxXfr4XV?=
 =?us-ascii?Q?zvj7KJ+S2Qtf3pTgNXgYmTLosWe+QSmrmv+Glt+XB8DcyPVoHTs4WwJlLTWC?=
 =?us-ascii?Q?o9hy/9eLSzcc6dHozdqj/W5rTpTmrcgT1Rzc650kZguIq+S9AC6oQVKGJDoG?=
 =?us-ascii?Q?xYhE2WMj9kWrDgt8bCcgFKHIZYC9jkJvvbQ3UGmOpaNjNsFtxUeg9Cw8OB4s?=
 =?us-ascii?Q?5i+njIspcDUWQt6hCtvrO2ed3LSdq4IIeJlUaC/hFQcfcrMeImzmFDf4Do1o?=
 =?us-ascii?Q?Y+gRUnBlQ/J6SnRhRBXcmzb/h1AuEHVoiAUz0MrhCq/F4E2LGgh6/B1d4B+x?=
 =?us-ascii?Q?uk2IytUFcfZbJDP/pW+AdqvnSB0a+qT+lLTfyRadedmlV/2od3HjO0V9X0eW?=
 =?us-ascii?Q?RD7M/WmjDKbve31vNc7HUX5lefs2mB1qy8XeG48Oz0eceLB2/TkXhq52SB3q?=
 =?us-ascii?Q?DsRgZl91smvqe9zgdm9pcXYzgzSgVTwz7lm+tWNlNNhf1An0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ececaa-64d4-490a-7e6e-08debd774184
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 11:41:43.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04xG/ycYN6S9pLSvYFLod4FMlhkFg8PJ61reP5rJDG2eYrOUeJ9gPdwh8x/qgUYOqMcwUvnRxJchJQnZqjjpMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9197
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256604-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chancel.liu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 71E7F601C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > When configuring 32 slots TDM (channels =3D=3D slots =3D=3D 32), the xM=
R (Mask
> > Register) write used:
> > ~0UL - ((1 << min(channels, slots)) - 1)
> >
> > The literal '1' is a signed 32-bit int. Shifting it by 32 positions is
> > undefined behaviour which may set this register to 0xFFFFFFFF, masking
> > all 32 slots.
> >
> > Use 1ULL so the shift is carried out in 64 bits. For 32 slots this
> > produces a zero mask after truncation to the 32-bit register:
> > ~0ULL - ((1ULL << 32) - 1)
> >    =3D 0xFFFFFFFFFFFFFFFF - (0x100000000 - 1)
> >    =3D 0xFFFFFFFFFFFFFFFF - 0xFFFFFFFF
> >    =3D 0xFFFFFFFF00000000
> >    -> Truncates to 0x00000000
> > Behaviour for fewer than 32 slots is unchanged.
>=20
> Why not use macro GENMASK_U32() instead ?
>

Thanks for this reminder. OK, I will switch to the clearer and safer
GENMASK_U32() macro:
	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
		     ~GENMASK_U32(min(channels, slots) - 1, 0));

Regards,=20
Chancel Liu

> >
> > Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel
> > enable bits")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> > ---
> >   sound/soc/fsl/fsl_sai.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c index
> > d6dd95680892..821e3bd51b6e 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
> >                                  FSL_SAI_CR4_FSD_MSTR,
> > FSL_SAI_CR4_FSD_MSTR);
> >
> >       regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> > -                  ~0UL - ((1 << min(channels, slots)) - 1));
> > +                  ~0ULL - ((1ULL << min(channels, slots)) - 1));
> >
> >       return 0;
> >   }


