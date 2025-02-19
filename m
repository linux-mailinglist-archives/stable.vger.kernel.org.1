Return-Path: <stable+bounces-118314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905AA3C682
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB42179ED4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9A126BFA;
	Wed, 19 Feb 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eczj9xDl"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B71B2190;
	Wed, 19 Feb 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987204; cv=fail; b=iiYpMfZpevUDXEeMIyoekg4TEmp8LiEkfKlb0CN1rPkSpjWbG8lUaIfIj4hrUH3qodhxuG032gsVUJ0bJU8WdJbSIJrIb8J66OQgE7s0eibyUYzpBny+k2SoE+9z3RIHsPHoekoEd6YWCiHn9xAJ7EuqZImIHpcP8qqJGHcNbAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987204; c=relaxed/simple;
	bh=FA20wUBUKyi6UZZnccjuXcQalKWnUpggHvGy12BvO8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4mGucf0DGscj43vvq5moN5F7txaWRJ5dqZnxn4naA3ulDt7+FzTycIo/+veag6mJhvuwcOaucfUJhdkwNfxXxOWJKyf2QtBrRlob1AItozH5NnZPLTedGnn+URB5XqjLs0F20CL9WLiTmYYS2JDyuVqG6wRTuxjMLNfzvpjo00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eczj9xDl; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjCP3y6TBkF73f7sBH0TdIPx1rtzmhyk/4MWXNHzLSjA19MwR31G2XT9n6nTdanBkGr5g1NSmnnQBIigrgEd5PNE2msSRi+4aCnWiPVaDGaF5OyoaMi0/35f+Nrgu+VA6G1gwX7YLd7xhcr0ftAw2n7J5Ay05P8Wj8pnKG4tB93X8yhN7ZjonfII8tIP3N79yVso8dwZ54O3EhP/kAm6mda9RVUuZu5BlZhckBFmx2kUTmeE5nszMJXGIiw5nM+/XpOSGFYgoA9taT6O3j1o/rWvTT7n4KP5O+f3ESORJbSx9IxiiqSLLEygfowv/KlOvFRQ318j276aRPQCRK4Cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/61dzS9iBj3g8HhbX/vMsc21BD8hli19wYKVNn3xBE=;
 b=ikLrCwTnOISUQuknOtn05QvUkSDzoDES/c5i+DjjLuPy0ShWvoNwsv8OqtQ1r88NT+LPdF5V583RnZeoAUEGOmyBo5IDNEcWS1uvU1KuM4OvkCAy+hNuGF23e8YPTc1wGnaWVCk84i+cZYxiVOtrevnunYgJ6AiPQVVD0b4nDaC77HvmEMWI+ESRv5UXjry46uOIVTKtBUpiEiyin20vZCZYSwIGG8Qvdp6KppFVQZqkmYFEL5aGOEKeMuDF+RLmVdYHZSIcIWdu9+Gg+HLMDc0MxcStVm4Orul3nFn0ofzc0miBDiH6BPrmiujape89kKjUXskKpvH9FEW/oyCabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/61dzS9iBj3g8HhbX/vMsc21BD8hli19wYKVNn3xBE=;
 b=Eczj9xDlgJeubPFpSVaGiUKS1ckQGRfx4QlTEFa6nZ22RqTyU99OfuywWsDqATBDEFX7658bwU2xi4pHbh0eAo9wxK/DRAnzvSEYHJtKVrGsRQFOS+lhBnoecnAthk9N0en8Y+Ih6CrBF0/mRnlsPb8jPrQzHmfSbgg4qAnYnQQ5lKnhm87cpRt7OQmJsH4q/CsYz/9ckY1oM60h/pcx4YIWzm1sxOEY+nsZ8ecoqUvqkPF6Qjem7xaXz99Wns93nZysVmBjNOAl61A6GnRrrUfcW5W9urrbeVlrdGpmi/SMfhsnjU2naHhHNqPQF0TTvmkMT+S2yOaH2eE4cq7MzQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM0PR04MB6915.eurprd04.prod.outlook.com (2603:10a6:208:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 17:46:39 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 17:46:39 +0000
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
Subject: RE: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Index: AQHbgpOU4gMYnZt/c0WSS3pD+9mhubNO3ySw
Date: Wed, 19 Feb 2025 17:46:39 +0000
Message-ID:
 <AS8PR04MB8849C3544A63C75E37D2079896C52@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
In-Reply-To: <20250219054247.733243-10-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM0PR04MB6915:EE_
x-ms-office365-filtering-correlation-id: d31ed512-88bf-45e2-3632-08dd510d5d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4JNftn6CXfdNe9d012vsUmScDJbntsm06Tpu3OdX5LLRVumpKS4nOgzDtmPc?=
 =?us-ascii?Q?fECHdQB48P/rPQNJyL3wKlMvk/duOJ/YcFcQ85ZCdYJsxweraSUWrybqRe64?=
 =?us-ascii?Q?l9MYhKthniusXmJBMcx+J+rNDzwsppOC+0/C/pJer7/oVKpPBXBpejq01ahp?=
 =?us-ascii?Q?jWrZDKZ7zDq6dvWJ73FfL7VXygVn9wKVS6kO1YP6vb+uhwtNS9Ez8LvgZYsE?=
 =?us-ascii?Q?7yCwTd1/48XumnwKHMwe0TMzteoMRidqTdZra+rRjpMg73F2i6p5gZ9LVjSG?=
 =?us-ascii?Q?uWG8Vx2NyG4KVgEWVSnUGaY3Q4IQoY6XZHVMjyTZxwBb4A0iUJ8kR4n4g86T?=
 =?us-ascii?Q?FU3IxhYKihVltSl+lh+opUaiC9uIt2fVIhqIJ1V7kynwdeQK3LbQI6d2YC5x?=
 =?us-ascii?Q?y7FKajgQu6AaN4iK+V9+DXxrrLAphyl830tKITd9h6O5WUOpJ48u2KrXcmGO?=
 =?us-ascii?Q?bEmjAMYmOQYHOWyTQDHtpEdhD62QS0+c4/qPo/HWY5VOB6L/dWAkKvSRA995?=
 =?us-ascii?Q?qwy3yyCGaN87P8N+PVgVNMu4V8Q5hymH6Fzm5QEqWvsoge+YQI7GPwdFLL4e?=
 =?us-ascii?Q?wBLa4MGBP74CXjKwOPkIcyVkDT69Qnvs6SpjTgZRcpawxD0r2rqI0oldM/ld?=
 =?us-ascii?Q?1qbo/G6PXNAJsXw+r2QEJwvGHvtfHCGukPILjK3QwEJuBKgFXHdcXCc6nhMS?=
 =?us-ascii?Q?ILvCv+nOM6rA7d+/zKhT7mHOXpy9bkhLe68NMztETAWB9gcd57xkVkZnCY9b?=
 =?us-ascii?Q?9YS5ccBfuX1C9whCoahAOTyM1/e6Ndo9QCOk+7t3LEP41LNz6OFgeys/CiHl?=
 =?us-ascii?Q?NtYC33npQgckw5gdyvczqXwzgZQL669FHHcBfcYHHdl7PgmafXNglUU0sxv+?=
 =?us-ascii?Q?kir2a6pIkgxCBLJMXtTz6G3kj2Ae4yzB3BFoBFwRJe6sSYNe5hwxTvHtmflQ?=
 =?us-ascii?Q?sXehwl/ajfM/2PsAue9b+Osc84tSKxh9sPxz5cmlBXdC8LoS8RNPWsa8Tyyf?=
 =?us-ascii?Q?MCMHJ7bNXc6m2Nn0ADx0KVV0uxRDjXHcFtH2hlnEwvM6CFKUHe2VgVLKZlX9?=
 =?us-ascii?Q?IO3Z+6H3gTbmihnBh4EiDGM86SssIdptB8Ns2bFWSM/kq1JL/RjfYarU3Xur?=
 =?us-ascii?Q?34lOV9dw2jm3X4rQISwC21YmHXIRI/TnbJUcXafJvQoCzfSP08iayP5waM2j?=
 =?us-ascii?Q?AOaFwIAbZll5efsJK0pJOGeglqdlbqFQ4k9y3Vfo72Z2fesht4dzVN5u+Qlc?=
 =?us-ascii?Q?hA/sR1npTf6FdTTZhCiJCpj+vzgeaK8OKeWWY+rKh13UmFRcrHQy1MRTjbAE?=
 =?us-ascii?Q?DXbJ14eeQOvHjXH/kf9H3VObpO3gqsMKloMmefxwuLjrODxXAczlCUvk9qIF?=
 =?us-ascii?Q?YMlFbW6pUraJsWJx42+YbWyxcQeqiqjv2z5fYhFn16r657+LBpixqKIe2JlN?=
 =?us-ascii?Q?XpyCxy/VILNkeYe2O6O9olEmOyYXOPhs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8gGuJ2L0Zij0sx0F2mW+ZYlWsKTBIJ9bzMP49ZIKtlN7cWGGvD4TbZA7izdD?=
 =?us-ascii?Q?dn+5sU4/JVcppiOJXYXInonLgHYAOTWfFq8NWnQOnP1dsl7VZhsXgNlEFl9T?=
 =?us-ascii?Q?zn6vGOBRIzRuA6J8vYKdy14/3osFcZzzxijesEA0qpHv625pTP63CA7/SDnr?=
 =?us-ascii?Q?uc4XwHq+FYyGCKjpFOf3tGak1mc+Z3kucFpbQBeOt+krlVvk3KJOMs9wFQFQ?=
 =?us-ascii?Q?zfT+L53rF9z9sA8sUxP1aiGfAIgkcgBlILNnQ14RwCm3I77Z3AG5LYR4mUyE?=
 =?us-ascii?Q?6SeVO6cVz5FppyGh6chWGzWUUpkqLoMS/m5iB0yJnOnt/+o0sl9SF9LMjVCg?=
 =?us-ascii?Q?WM4i+clgUnxpx51iSSt78oVUSkyV5y4vAemwD8Ad3GUqOHEvRw1IAu0C0phR?=
 =?us-ascii?Q?4ZmiM0JtApwSa51JsJ5b5/cRdrdnEmJDtQMqwwiqYb8y1pJwqpxSmjB7SxgX?=
 =?us-ascii?Q?soZuHIrrP+pbjB39WUav88KNPYJtLN+tN5nN/PfDzvpfLHzDVr8lzZ1Ad+bm?=
 =?us-ascii?Q?JCkj2VYadVkEVvw1f1jMVYvN/Zswi78lB1GD2GHQITt6C+5QDvfAdTYXsR2B?=
 =?us-ascii?Q?4FcZZ487LtM9xZUUmwxRaHI4Mkt19X9a3AcgvjhXeSWzQvQU4p4EV/5vPbvT?=
 =?us-ascii?Q?IPzCAaI5T9BIYEv54FBVha+5+Fti1lWGIelrmfA6c9mxLfSx/oo4gkw8FnMN?=
 =?us-ascii?Q?bhpsZnYfPx1UrvzeARXjTmhASiIN6tIfzQD3p5ifIEgJTZ2K9uY/pXqXwCSz?=
 =?us-ascii?Q?9OBzV3ygCnXQBU4XlM5EcVf3qXDqiKZ/qsr80ys4PVhcnqF2qC/OQ0X1+4cC?=
 =?us-ascii?Q?1GyNKrXBDnJGO9cGoD/NW6+JxgprxIwXCR/l/bOJHzWy1pMXe0qfkIJr445F?=
 =?us-ascii?Q?4AHA1/bHJH3FVEovEn2ARQJu4gqA0nsO0pfJsb/jBJJ98ToQkI6cqrIOwiUq?=
 =?us-ascii?Q?+JzQ2n2x3lDgo7nu2KyfsVvo/tFGcOSxJVtiL1BDaRcGf21vbYa5vndj2voZ?=
 =?us-ascii?Q?6e+QZU0cTAWR2GP92YDyIDh/dqjP74w4yYtWhXpcyo2gg81mq0CqxvdPD1Jy?=
 =?us-ascii?Q?nQ7QFkYXTdKMAFPtJ2kTksR4CjN0sn6ntuWkpcjHkM2cF1QEtnLwDBaAKOzs?=
 =?us-ascii?Q?KjxURi5Ckp/qdKYSUIX/8fb0siczYC3J1+3UIgZhY4DJM4A9yMBwxj8H7I5x?=
 =?us-ascii?Q?t4ZkxFx0JoxDvB2F2p05D2kt3OE/jcAsYK6pQzOHxLH5TxsRaFnRx8IfvLbj?=
 =?us-ascii?Q?teg2PdFntTwslTbOCcSX2NW0t2iVg6+72ZOEZmmkAEbPx+edENhwM5ndhD/S?=
 =?us-ascii?Q?TNAmbi+cV4mZQlkQ7HuVvtk1qWHULUn5lb2Mo53vZCLWv9RJRDlk2TM0mfWY?=
 =?us-ascii?Q?RMSHeiQwC3fXL97dQFx+WBJvoEWFQTCRNER1uAVniC9kLCm0RiDEW2VriGMq?=
 =?us-ascii?Q?jiMxAONYO+v5kIDfr8mzCPUiUY45UWpIlFF1gn3rcWuu4vOvxFqlO3bSCvbj?=
 =?us-ascii?Q?RrDHL/dM2eeg1H6G1+ehpXJfyDR6QQ4hVNBG4mptZ+YdVg7gxJiyo1T63D0p?=
 =?us-ascii?Q?5RwOPNcSYW1ZB6gys+U/BlJa2PVm7pLaMNUN92Nn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ed512-88bf-45e2-3632-08dd510d5d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 17:46:39.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2dbhIypiuLHCEhgPqwpHZTmPY3r5bNJw+Cjm1cwkDTSCL63rKPFdnW0O4vH48A+VHIKQFTAbcuGKebGZVV1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6915

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, February 19, 2025 7:43 AM
[...]
> Subject: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
> enetc_map_tx_tso_buffs()
>=20
> There is an off-by-one issue for the err_chained_bd path, it will free
> one more tx_swbd than expected. But there is no such issue for the
> err_map_data path. To fix this off-by-one issue and make the two error
> handling consistent, the loop condition of error handling is modified
> and the 'count++' operation is moved before enetc_map_tx_tso_data().
>=20
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 9a24d1176479..fe3967268a19 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
>  			txbd =3D ENETC_TXBD(*tx_ring, i);
>  			tx_swbd =3D &tx_ring->tx_swbd[i];
>  			prefetchw(txbd);
> +			count++;
>=20
>  			/* Compute the checksum over this segment of data and
>  			 * add it to the csum already computed (over the L4
> @@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
>  				goto err_map_data;
>=20
>  			data_len -=3D size;
> -			count++;

Hi Wei,

My issue is that:
enetc_map_tx_tso_hdr() not only updates the current tx_swbd (so 1 count++
needed), but in case of extension flag it advances 'tx_swbd' and 'i' with a=
nother
position so and extra 'count++' would be needed in that case.

Thanks,
-Claudiu

