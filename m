Return-Path: <stable+bounces-118549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B19A3EDD9
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE2188F4F4
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E11D798E;
	Fri, 21 Feb 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+cwhfu3"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AC1FF7BE;
	Fri, 21 Feb 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125033; cv=fail; b=WkIdroZ5wR7Uyn78kYe5LysmDHKyQ3wqaouvfXJthptLBTvLsujYW06DlwCLh+QPAGRtix3xKJvJT63zh3YyC2UntVzQAt+9e3fLNAswUBaideLty9ptfft0MVZtsaMTz2j1VDC00LR9/5DTXVqmqe4KnRmjScMzP6FIrZvvLls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125033; c=relaxed/simple;
	bh=x2zG2YySkzp/W1+bKA1OFqFM8lmxVsdxH55Bjr1u0AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmrstErjiBMj4h4mycPHlZHkQTw5xH86sR6eh81UarobAPrljlEOFdUEKeKaiKZ+aECeqIY7Wh5v9kZjq2AUWdZn6YPSzOiObUfhXhmHgGR+ubf9FkmxFadptGBqHwDzToDqUEeNq8rUQiOxhwgDFM94GYnCsDyT+001KQzmgmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f+cwhfu3; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+K5n6YhyuyKbGRBKvTf6J6w+LV6mhgb/+T88/tYTDEu8i4pHKxuKWLWcqcrg/xxRoP0xD7OsG66hzSipKPvPa75USR3tBgCVd5fjUQvyJdgbktTXJJGK1xgCDtcINSMlTvBTUYVxtUvqoQnitI270srmEJs+scHt5s49J3mlNGWJfgRxab7eqnqKNNe+KhgCgyjN7O//4tagNYiLJzgqwPthhR/gd3+yJCfRGhT2+W2TURsw/xbP31DSik3ZPK8d+0usplpXOK+prZC8IEZYpCKcX9nVHMKyM/BEfA05lbPu1ht0LK/c8e5kL+uR1YiU8YSka2+NAxqGtU+/zFXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2zG2YySkzp/W1+bKA1OFqFM8lmxVsdxH55Bjr1u0AY=;
 b=I6SyJQdv+Cw1hD3eflY6ZssDC8x31uLQbj/IOLqt7CfxhtZq2UNI0emQTINCnZuAD3cQxV1SjosG0xIOwFDYTdYiCICt8S43cWHdZP+e9BwDwhsmtwPztYXO6ais+kQbwjcMsf/M6z38rASG6tqk4CwHkVGzdxHk74mFfKIPTu7aOUsFyRzC9zhzuQxbHiqgu13k2ZnVPsEfFT2nKb7Dgi3axu5JNZexA2eV1GSGaQaANSv7bOsKbi5Dt4OEDXgTrRTrKXj5ko84eGICozephz2l0glW0TJ+ZkCDNi/XXfYrzvRYWPRK1OMqg04DuJeOoLiQG7C7snIcbaHcjJ5tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2zG2YySkzp/W1+bKA1OFqFM8lmxVsdxH55Bjr1u0AY=;
 b=f+cwhfu3NBS4MfR5AfstAUZ0IcPXt9Y4nmeYXQsIv5HVISklzNRGxIJLYiBqi/HaxZzX9mEfSnh+GmtrfXdxiq+1ZxqyELGmfX2nnbJS0YAlwr1QCSA6GTWK8aiDsu6Hlp5viapAIZuSe/OUnxMi/m+Ho/QwcAa+lu7cmtfbhYn/EWohTLU1zC41+ftmImS6/tx0hc6Gphcg9gp2kHKVsZTFnqFpQlORjVbUcFxR9NxKanh1cIHFeHjzN93W99RrP1djceLhIKVNU2ifEDILskJ6yfPpgUacH87z909D0UoF7q0r80H5XJ9Rcgnnp0aBaw4yIvpewbfdBRe090fywg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 08:03:48 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Fri, 21 Feb 2025
 08:03:48 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Topic: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Index: AQHbgpN/wLtM4lMuwkuGi4ZYC/hIXbNQXDmAgACiP4CAAGZqcA==
Date: Fri, 21 Feb 2025 08:03:48 +0000
Message-ID:
 <AS8PR04MB88497C415FE73CCA84843CAC96C72@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM9PR04MB8323:EE_
x-ms-office365-filtering-correlation-id: 6469cb31-89d8-4b7b-b9cb-08dd524e4575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AYu5hP1650iPfZ4PoMPxfUKECVXy9A5gDZsngD1rU3jALXWoApzn6DrJlLIO?=
 =?us-ascii?Q?G/hHvTgJlascC4ppE8jvyf34cmpfgW5rs5WEVBG2zYMTFqEg2qpcTd7Or/eW?=
 =?us-ascii?Q?QaQq1BRyk3OmFq9b7Hp36FxRS+eNNoJLwxXFRzacfgELq9cet2uazX+f/Trk?=
 =?us-ascii?Q?oa51JsFhoqmLAyK3gkn3e5iT4WXnsTiP3A51bKpwSwUFZQyXFLSvRpZjZHGq?=
 =?us-ascii?Q?t9etFDXRO1dShMp1t671hn2VN9yIikcrY6vZctmKwPRIls7mb14JFF9ZSOdT?=
 =?us-ascii?Q?bGh76oOKimzG43cYv6cE6/G55o6q/iG9sgBjSxteMzVtIrQiAaxTlqPmHfCM?=
 =?us-ascii?Q?MH1bbD8YwdX5027bA4QXbW3FQPaDDLglMK7OTvtoNmPjQWkICAWe1wzKh+Ws?=
 =?us-ascii?Q?8y+Ai4g/dm8AmgcDHNUqfG3yOwgNn2bYKlFYCulr3tK2Ky5lUuH9369VwaPz?=
 =?us-ascii?Q?XLAYNu7pc5lduIEi31amJyRaF03bdQz14dciXPbzUaNFF4DFVwOAYyJ/SS0p?=
 =?us-ascii?Q?Hf3vDzsxxMCEqv4uYc9ACB4HOyTUU4moqL3qR06gishh/FfHPLJ1XDE0lPjt?=
 =?us-ascii?Q?a/gjD6O7cd/mN9vxAkV39O4knpszuYHIbXedVSXANZhtIJ17Kr9T6rbkG8iK?=
 =?us-ascii?Q?yJdwvIXGW51lCv/fwKQMUQdJL7ILlHbhDP/QmuD5Kek0MZ9igmE84g4xmmyP?=
 =?us-ascii?Q?y/sb4oi19BOHGkQK8dQfyygU2NVmZ4kiHFB+6ROM8mATQZr/dmh97TeEXhUL?=
 =?us-ascii?Q?q34lwSUUvKO96JfeQdTFL2JkcIy66iDBiKIGJ3+AXMSPw8LkRSKiV0yW9mTD?=
 =?us-ascii?Q?k3VQAnl4djAsK2Rylw07wVNIU5iuFBnP2vi0pcioY1EGlX9eRPDAz+v9YCUM?=
 =?us-ascii?Q?jswyrknESpegSCgQh8zaiNdv7Iq+14PRAF2RCExLH3hUzQd5tnm9+mqfkW6P?=
 =?us-ascii?Q?CbS3yfCOFc+BEFhXfPkCNmADLoceyjrvTX/GjqVfhXPkiSdzhcSjwMqnUpn4?=
 =?us-ascii?Q?NVSH3WYRvXVvJfj+LLH4scqVNfNAnObj6AexNWuPQmBDdJCjkl7/RcJAv13o?=
 =?us-ascii?Q?4fnd2NQ8Z4DLbdINP8kuWqMlzMVAC1rHF9ZksV0o/4wEmdHB6x4GwA57M4nR?=
 =?us-ascii?Q?tdY0XLvNLRcL9daDDgopWyPc7pCkuAAWZTFxISFRCSaWK2fjGTwNZYmK9qDn?=
 =?us-ascii?Q?Ij2aUdlPrcC24Et5MI1z+K2xwpxJ7TbSr6wjr8MFTY+TT3g3xw11UlySNHu3?=
 =?us-ascii?Q?TxY2BUrCTDVYMNo6Yazcn5Z2zhmbxUsetoFDfAaVZOUryx9+5t0h5ANzU64X?=
 =?us-ascii?Q?D1GyCnKG3lkfCVjFoG/m4YcoywFFUhkGmGihedcEHHULn2DlyzMOgfjLitgg?=
 =?us-ascii?Q?2OMdSY6Xp40Y9QDkcqY3YCoZqC89/AtvOo2FxWJeFQzVkd5NwsLFiPT8aKee?=
 =?us-ascii?Q?GentXG58IubCI/3znHlNStKOlujMT3NF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PSYJC/7iRD2di0J8QY9JJDO35VO0O6RzXvwpBsSzR/o03pmfdIgGHaQv2fu4?=
 =?us-ascii?Q?CumqpHK7q04ro6jSFX+Ebd+aB1FtLY2R6WwWzRnExJWxK23pWai9jc66KQhy?=
 =?us-ascii?Q?aZikXlIglhAHAoQOyduiaXimyCDZJV9FC2tHS/KUajSWxEgMONIoL1DwtopE?=
 =?us-ascii?Q?P8yNgfvSlsQ2D5RgM84QR4PelA16b/49Fb/8vVBsiZBfNN03L+tqXMMtvfTY?=
 =?us-ascii?Q?TLNwsOeLy90Qa0y5q033sTqK7OMnqTf5W3D9F67JRj+kz5iysgcdDcBjuptq?=
 =?us-ascii?Q?9s8/MQlt4Bdax+VEEl58JNy/+mQDOfOinI41zVOVeqThuF01hjysExJm/DmH?=
 =?us-ascii?Q?m6BVDQA0aY5jJpJmwlWFKur5sm36F/XglHUXgIH10LzsQ1hCApr3LxpjLUJ2?=
 =?us-ascii?Q?A+gkLW7mVUliI/xn9TjgXaXSrpQMFUXfblrR4gIyJPWT2s2Duq0Jjl64gqhr?=
 =?us-ascii?Q?zfh4cUahrWWvxXGdgtDPzPeQrbslApZk4U3acDQLQ2B/nqP5TkE4d6fmIljc?=
 =?us-ascii?Q?LgtJWAUI3vfn2K85Ej/B5Qkf46f/C0gJ6W7jsWx7NNyfvccLja89S0vvsKWC?=
 =?us-ascii?Q?KpvYz46bn3FcsDKOyc5DPlMzY/ZBd8NjNYm/niKCapWhifAA86nCLDSTJAP7?=
 =?us-ascii?Q?gl7NYoMyj5a2pmg0qApuUFWoxcKTNqD77j0uqg6xXKcLqUCJ8CBaeLxQDtfs?=
 =?us-ascii?Q?KY4ogxX6CmbzRvL2s2q+UGScGbwZq2DHCqaD5QP6+8idcZlbzdckgicNfCaf?=
 =?us-ascii?Q?LNBQtdKp6/rC/F9GP54sYHM+RfFzM7tvDPjvLwWF0N2oIn2QtL9jdyzgimLr?=
 =?us-ascii?Q?7DQqlWE3IK6nzqh9/b5RlZzOjR6Y7WsPOMh2ZVSMjP9OcnNP8dzrG+y3Ofly?=
 =?us-ascii?Q?CdL1c4giqSEizWil5fWZGv+zfi7Oey0MIM06KPHY/QnTgMP8PPqbclK9Uq+O?=
 =?us-ascii?Q?5R6WKUuJgMNIXFGYVzyScEdnQYCgQxpbj25VXldhY1sRdauJ+ckyKatCMpMy?=
 =?us-ascii?Q?3xDDqBnregyY2CC5vEdtmFgzXUOnjRzCmz3zroK3r9xydGgRyUjx5FXMmqh3?=
 =?us-ascii?Q?HJss3BZk1eVi2gzQ0SzQHS0UQ5YBzcKUrVl3Pb6lctqGXP00BAHCN1y94Tob?=
 =?us-ascii?Q?xSrLdenPH/9miqMzX+jy0J5NCvrD9TV+VM7Or2rG1tiAWJI8WNDXAAy+GhuF?=
 =?us-ascii?Q?zRkJO52pZw5h2aTQNUvUTbHGcdUfk1oUrlAGUjaba8GPohDj1pn8+84j2qJm?=
 =?us-ascii?Q?k9hFXedJrZVirMS7lOcoMWw5Eyac7fLdXS6Rtn6uyMpHXFTlGGnfwZKYrSr6?=
 =?us-ascii?Q?f9WSX5ugh7SWX+gFVI1vuatGzZGTnj1dRBN06ISr15etPfoNekf7hWAF/1Af?=
 =?us-ascii?Q?tBfKL7no+UP5L3h4Eo/uSlGEYBP16gHof5F9eX4P6aj0/KJJda+3H+rtqnn2?=
 =?us-ascii?Q?6533yPifTStotSZ8HFIREsZLnbMD41rFfxfNKs4zL3lUGdm3mFmyHCLuJPjK?=
 =?us-ascii?Q?d2p7DMV2BDqoPsCstEDrCgm036Tji+7jBAb9p7GcToVz0EV4MnFqq92RbUmP?=
 =?us-ascii?Q?GJx42pICKMP3bn6xqA/239oe0HGU0Gm/xZwMPhaa?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469cb31-89d8-4b7b-b9cb-08dd524e4575
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:03:48.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr0YYTDRUU4mp4tdBr49sq5LIoqP9BZQ6sm47ZA4k5A9L6JVO9+ij0ILfjZIxcyFjaeU5HJY6fRK3++pTKNC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, February 21, 2025 3:42 AM
> To: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Ioana Ciornei <ioana.ciornei@nxp.com>; Y.B. Lu
> <yangbo.lu@nxp.com>; michal.swiatkowski@linux.intel.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev=
;
> stable@vger.kernel.org
> Subject: RE: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistic=
s
>=20
> > I'm not sure "correct the statistics" is the best way to describe this
> > change. Maybe "keep track of correct TXBD count in
> > enetc_map_tx_tso_buffs()"?
>=20
> Hi Vladimir,
>=20
> Inspired by Michal, I think we don't need to keep the count variable, bec=
ause
> we already have index "i", we just need to record the value of the initia=
l i at the
> beginning. So I plan to do this optimization on the net-next tree in the =
future.
> So I don't think it is necessary to modify enetc_map_tx_tso_hdr().
>=20

And what if 'i' wraps around at least one time and becomes greater than the=
=20
initial 'i'? Instead of 'count' you would have to record the number of wrap=
s.
Even if not possible now in specific cases, there should be no limitation o=
n
whether 'i' can wrap around in the loop or not (i.e. maybe some users want =
to
try very small Tx rings etc.)

