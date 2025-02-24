Return-Path: <stable+bounces-119396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86609A42A16
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B18188E02E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B426463B;
	Mon, 24 Feb 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nYVbeJGb"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A8261396;
	Mon, 24 Feb 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418680; cv=fail; b=r08cv4NV2U7WMrz8bPGELv3pyM3FkoIWwkYGFyz09+KxNfo6te+4eunJFh7HuUHSACiE5+PS5HlIYZLUQOIb468Amx2dP6azWnCBwnbC/+RdOpzIWc05cGU23L9xE/zT9B0++qOtWUq/GNx3rpr+hZRFAB/wE0oyx3DCLZQiYwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418680; c=relaxed/simple;
	bh=kjmaXUGWsz9lNLkOqXHABwZCz92jL2zn4ZANQ0IERE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQBQ6B04E4dv4IMvB68pyp4mNATFp/pedlL+Ar2FfPq8W6MOozZnDepUG6rJ9UbL0FwlGduQJKHfBBhlKFhKJyn7RDs/O6D8CKz9viL9X5M08iT7uLsxGAiixXMUqqb02ZykzoKPeFs1SywPL2DAu1qRtkBH2p5yW6HegOhJFVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nYVbeJGb; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdP/mduNaz7BJlCuovawPYDvEIEq4vHSCj3oEYZYuw56BmUzFkoarq/bnRMrDZuPhPZ0BRVcBIyvhwG2FIHlrCI7UppRAOEtcT5cFy5MRE1NiYKkfLvdpfTJrPWxq8IxWPBhU3nFS5MhsA7o5AwFYNW5HEWm6G84oi6U+/4kPDzjjPYv5+poO7g/wvW2GQdqPONclseYD7iAkLIQW2LpfjlQFN+yqiKQOIAsI30K/WlYgxJVySTt29QJYnbQu8HZ9wgLg5mTyy3UhDKvtXhV/yoi9jK32XeM35Jr009pwIK8XTEIgX0KRUjstpNRJsDGpzpUM0yjqqS17mQn2mpJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjmaXUGWsz9lNLkOqXHABwZCz92jL2zn4ZANQ0IERE8=;
 b=O3qotCwPFbaXiCFd++oe5Ynj8t9dFEnokhuRrUXOglldE7pZXae4gzD0jRiavy7cfJ+8WziaFV/Pukih9icz2dLq1DYcnmHyFREeJjo3noH6nuxFfENToY9gSLZh8bTiHv9wZb2WtyeTuKNwjlIpHWzZh7CWEl0jMH1lG91/jLfDxjhjauUl2A5C120AJD3+y6U1s8OO8KMOfbiY0Vn6drnPDxxKbZBvqI3FbJf9oFoXvKUmxltPD8yAEEfAB0eu3P6FVqIP1inLO3DRraXV70YzAVhGeTUVdwG+1Det2DJG5n6Y5sHNUPVtaFTgqhFUss0TgzxIV90kMJ/70x6AsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjmaXUGWsz9lNLkOqXHABwZCz92jL2zn4ZANQ0IERE8=;
 b=nYVbeJGbUFoJATMWMIlDzY3GcRIsrN8YlAHHBS4vUkiQB6bS+uAXgM+Zdn0/HSgdoIjJhIF/X0ACBssLpwtE1fdGpPtUJn1Fa4X8h1n4kHjwzlPs/DAUohcPSZ6oebS7UObsSstHGUNwZr23ncLSFhsjxXfLmYISppKiJvNGo6wN9HlZw7myS5YoB3tOJJ5KQ5X9Wq8dngvJFedn+eyOiYs27zSY2VlxzUEbH/BScgyLY0RKcRgNWjmRf5Kxb0PfcWlN8Xh76nSV79UzLjZVKWoRbzxVUkROqp4kM1CViaaJkrHw1n+zT2qGyrSAqcuHDAZYBnDB0u8KO3q2Eq/kHA==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DU2PR04MB8885.eurprd04.prod.outlook.com (2603:10a6:10:2e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:37:56 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Mon, 24 Feb 2025
 17:37:56 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 net 8/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v3 net 8/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Index: AQHbhq+DC+FF33kNKkeEEoWJE1TZRbNWt6og
Date: Mon, 24 Feb 2025 17:37:55 +0000
Message-ID:
 <AS8PR04MB8849EC201E817D3D6219522E96C02@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-9-wei.fang@nxp.com>
In-Reply-To: <20250224111251.1061098-9-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DU2PR04MB8885:EE_
x-ms-office365-filtering-correlation-id: 48673373-7720-48b8-c1f2-08dd54f9f929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xfHuoYS1Xk7S5mOpH88n1xPctSEUlFEbyKWdVUwZ00nUiYaH+Sgc5I63QkNj?=
 =?us-ascii?Q?x8gv+0KsEG9M35nE/IvWEnItY7xjTWvHGaC/IRjs2fuLvw+bReziss7ls7gG?=
 =?us-ascii?Q?ti3afdn5QlgKnTmbtToGEgi9xLpk7EcD4mv2GdZ++TJ7O6ZeHQ5pbN0wUYy0?=
 =?us-ascii?Q?S9lLAlWb9P+6PZsKC48Z9AGeLGc7Rt0Em/0WQ0WvhxoVmCJtkeEvTY4KbV9G?=
 =?us-ascii?Q?kKcFEtZUZowt7KLpkvr6C6GsN/Dp2J/bNRfzg2vY3VTxKRzAG4cclvmU32nC?=
 =?us-ascii?Q?qvJuKZcbaz5PeuBUDRlUClKr2LsO3aHE+EPHPCiEXnHTe+WYTLLicn181XQm?=
 =?us-ascii?Q?LxoSrY5r6pLTHhu1HYDpsKEEXnMmHYQPXeCnVOPDBo9m6u78H1bIHQTVkLkF?=
 =?us-ascii?Q?Ww4Z2HYGP81vDJU0XJ1E2vvBlQxe5AcIZu3Wpp9C6zlFIBLNl27Knot6mEE9?=
 =?us-ascii?Q?Yl/LPW4wmE+Vajnh/7TLDZsxVRXsoNBrkSO2lBkifY/byfNflchf1ypSO4Gt?=
 =?us-ascii?Q?nc3cUKvFWuU5puWCaWHLhNbU7zw37iCsCP1qPAIfdIcEj8CsDompmjM9iGT8?=
 =?us-ascii?Q?vJiyanCSRoOFwaUC063W8P74+7qgRbmlvLKgu4j+sBuQA3Rt6yFVTxzAntF+?=
 =?us-ascii?Q?5wHGbOR2ZG6//kJJjN0PZUkxZSruAWXK+WhPwe11FJxOPLacMaZU8Hh8B4BC?=
 =?us-ascii?Q?0VdSenVq1EStOkPtwqs1e5HX0KjDyqm27dKk0+9xBsw/SuRgPf5MnOk4RzRe?=
 =?us-ascii?Q?mfAekfODWgaxcLjnwBl/I7GlWlQvLkBLyeqfLIEV2JTPsn4aVGq+Svp2JBjv?=
 =?us-ascii?Q?4WMi5WqV4eXDNqjGaj2u6S1QegwjWVmGBBPgz/Fbx8HLqvC5B3e/tWhTTp6E?=
 =?us-ascii?Q?cZMAwsyn8pNNLEeicqtKPgxI54XZ42hNBERQp8aS6/mK5GbrgJJQ8OVwKbJs?=
 =?us-ascii?Q?01Bwb5H4XyFlBlL0/KjRCm7kQsZ0KVOD2sNwtPiZXifIzkOZKDmc/Hf771ZV?=
 =?us-ascii?Q?KwKVe6tIFKmj37sMIkN8vH+MhnHh9nFXLwpz//Cj9j6pvq9bB8x6L1ydOGnp?=
 =?us-ascii?Q?zwXzoMvMvtFRTHAUlqp2gyQqWSRein0+NIhdN6z8Mp4jmaJlYe/nFNUMG5mZ?=
 =?us-ascii?Q?DzdUzlXDtrD4kHvj6PjzeaZUEMp2rGGIzqsYNfSgGtiotPoiVjOKpJWWofSR?=
 =?us-ascii?Q?9JjMii9Fj4N6knathGvaUSClGHwfOxvRcTMtrvr7pBS0Ax4bfVmeXp+RANJW?=
 =?us-ascii?Q?rXtpCcFYhzc01CjRkScx1WcVHNUSOcpG5rqX3DYODEJeKZZDJQ8UrHJoAiSM?=
 =?us-ascii?Q?NH0P4wppTnYOgb6scKYELgNloqd5Ta0zETYMIlKqM9+K0tfttyTFlumz4jxj?=
 =?us-ascii?Q?xAmDMmM2LrVO23Qw3xvlOFPFW2dTo+kEGpsDZ4yVnJKLC/e8pZVC4bssV101?=
 =?us-ascii?Q?3wgeIXnq3wi3racy30ewRvP2vh0OBOjY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pCfPt73ohCw/K9yXAkM9HwVawa0e/jmGRy9p9BBIfBNgG1CVTLPgQs+0aJGt?=
 =?us-ascii?Q?CIKinC9kYeEJKXb9uNuDh/dwhwZTMqKsqJhaNbI5fThHqJij2sOfJxTtN6nx?=
 =?us-ascii?Q?v5iffoxihyfJNxUto28nWEFp+Je+onSiu4o8op7l7U6SJM3NfRX99ZdN2BG2?=
 =?us-ascii?Q?gB5tc3pgr2thny2kX4XnnWldeB0txkSYlHHrJzP5c8c9rhdJvSIW+2Z3Pc73?=
 =?us-ascii?Q?xehkDFk8UNiTZDh9J/vcYZ8MHo/GcCeOsf1e1OCgCG6NxRWoi/d2GZvd9D8Z?=
 =?us-ascii?Q?XZEvtZtnCTKr4PlvIoLjSOxVBv4xqHbR7V5lzTpnY5Z//ugzMviYFkPIMp7I?=
 =?us-ascii?Q?xFrxFd4arxO19kJ8hthPOVa/raE22Xir0Q59YRAfj6Yey23+YQl3s3gZjO0c?=
 =?us-ascii?Q?8fQ8W+rtHfZhwTt6ASHArm9xkLcNZwfhHMzXZoojRoLirqaWy9MQ5dMetUMj?=
 =?us-ascii?Q?n6icpwRq6pQYQZB+Str1mCzzbmJchIlt5ahDj4DufL3u3PTQjkME9/ecFAel?=
 =?us-ascii?Q?OW/XCv8pGT3hAV2tAGNHEEsCfDxV8Ez/b6pH/ClXR2VKM3laBZfYwJmF7EcI?=
 =?us-ascii?Q?EegQxyPlbWqPIe2FDecTfdZqRj9OZwMVMJbSHleGWM3OTCqKosHZ+tb0R9G/?=
 =?us-ascii?Q?dech6HjIHaoWOsdGP0Wi0awadup3QTKty4gAI+A4GkOvx2531jO+1CisA0Im?=
 =?us-ascii?Q?1PKQj1Twc5IvLv0wVIS3NiEpViNhasKfE9g0WKoK5HYEPBVP5bPkCMj3d6eu?=
 =?us-ascii?Q?WO1D2jwkRf1aCLYKB4zyUIne19slFuRtIqHpznCNw0TGZ3hACTNJcmFSOqky?=
 =?us-ascii?Q?IwvehAWLwAfqNtxM/pAqv3RWrP2R7XG2DSR4wb0TaOZH2q8e1yV0LbLiy42E?=
 =?us-ascii?Q?I0A9BT3Wo4IoyUaUK/JxuFs8UOnF88WkPgCbOuIB1DFXdOTq/xZBqn0kInp9?=
 =?us-ascii?Q?X9LSCuCDx/qrekw8fUKzeAqXd8WzV2UV6Eby3tj++x75Fy3xPcW4rpEIgrEW?=
 =?us-ascii?Q?gpYWO64Y059r0jmvRgJK/m94BC6WlGhQCflxAn5hB0gn0Yr91SH8HtvH8Gad?=
 =?us-ascii?Q?klSQWzXdQY/CHoa1pqqkdam930EynwePZqWI+jQ1S7iyKXuKMShpePYVfUSE?=
 =?us-ascii?Q?iF8o43mapFdh+rnxwbxcZoWXfyon7Es+bY2afZlBg6hBFXnE7o5kjyOhjtcy?=
 =?us-ascii?Q?6WUPJ8+K+xmdwWELv2ml+ipD1ZtT9TEvcGx7Nw/9UHuKa7NvJdoup61rWjPa?=
 =?us-ascii?Q?YIpS9l5lJNy7Oymr28/9qlrMjYrQIUwprhLpcvJESXiKLaMdlwkCtUDAi2Eg?=
 =?us-ascii?Q?W4NGEOvKdyU3vj+csWwFr5+wQ4gyeAT2h8GCuz00cPoNWj41ZwsT+kNDjaCC?=
 =?us-ascii?Q?2hWQ4jSx9wDaWuKeMgNn6j6U1ZUuMtscTxsp8aIIiNXv7BcOinLfaZ9a0e/d?=
 =?us-ascii?Q?HL35vCl9xeZt0vkg2LdGckn9EAPhtiF3yMYbqftlbB61SjhD5T6c8NyL9whK?=
 =?us-ascii?Q?oWqHD3bOBC3WlDv3dY1E56/ERWK0Pgn0E9bzopcw9U23p9tY45kiGOFbe5mM?=
 =?us-ascii?Q?1068Fv5wqgHDnReNooNwJTY9xlB/LD6ZGiOxElsR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48673373-7720-48b8-c1f2-08dd54f9f929
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 17:37:56.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEIZ5SLCHQgOqsImeXyDYk1gxe2ep3xGgPrrEs7IgwE88e7Zhnx92p5y7tQuf2I1ENP6zZIt464PSLI61U58Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8885

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, February 24, 2025 1:13 PM
[...]
> Subject: [PATCH v3 net 8/8] net: enetc: fix the off-by-one issue in
> enetc_map_tx_tso_buffs()
>=20
> There is an off-by-one issue for the err_chained_bd path, it will free
> one more tx_swbd than expected. But there is no such issue for the
> err_map_data path. To fix this off-by-one issue and make the two error
> handling consistent, the increment of 'i' and 'count' remain in sync
> and enetc_unwind_tx_frame() is called for error handling.
>=20
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

