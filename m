Return-Path: <stable+bounces-181991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892CBAA652
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB443C652D
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4423E229;
	Mon, 29 Sep 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hfe7bEYz"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012046.outbound.protection.outlook.com [52.103.23.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AFA78F39
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172296; cv=fail; b=ds9e9MmGqDyUW6LIJTW3emipAloX6KW4y6Z3AsrUH7YtEoucPGw1EH11smhMcAnpJ0MCZlVbf8NiU7uATB1FG3GEbvRyzIa+ZlbHOqqnplhfIW4WVzlQQoQYiMnxQUbNZi1X9tmVAiLei1jJUrnR38xgYH4SgdA+akNrIhb7URw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172296; c=relaxed/simple;
	bh=VMmXPa8pOybq4slvWPxgIvL7WjZD+TncCzQCaBZ28+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DdQw0M8cVKoapnrP+s2d+1/H2zKXs048iqiNCsRwTh4Q494PEF3t9tqeQq91l55z4fq4B6mO70azMtBf8FYTcFf7Vl9BCQxcaT7k0zXLU9msMxE8S/t756iXT4cF2Ov0vbmsm+4dGD0MoLuf9OJOd3F+3hROEg/YXM48cQf1Gik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hfe7bEYz; arc=fail smtp.client-ip=52.103.23.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p00WpwlM3m7JNu4y8LRlSvy+tYuJ1XbwdXY3JSyPJaDXMH2kWk5Qcb4/vj0LI4rjgLM/+DALamjE1EqrSWqtXDrjSg64xPreT91dZi/zu3G2ERTX2tZQnuxd2Ru6HXYGl0oHt8Bj9rs67r1VV4mw7cAHp7eL8Oc60WhSy4XH7DjjSmDaOu3vSGLvpoui+kWFh6LomWyaQPKt+U6+g0j+FRxWMVlLkzkx3A867/wpiXUsl9PPOykHcHfJiPapkuuKA7UsbyyGd/MZuYOevKlQ9zNXRW0L8rLzp/UaRghp2c60g6gaLrpAXYWlanULJiKrAFwn4ktYMtTPg3VNqHi/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMmXPa8pOybq4slvWPxgIvL7WjZD+TncCzQCaBZ28+Q=;
 b=C+sX94/nc+TDG4HWxbzGyV8+mhT2tt1BHKl5Y1mdE36MJlTxOx0SQcRjGJGWFWZbItIqkZpQzj1rGDcZzshqni10JMEyaD/imnjmuHQIJzsyUyybXhozk1stfIjkMbFPf/jvUWGZJLhm/klioS9in3pMFGxa3igmXW+OEKGHQE89ZlYeWHDv8d5vbK0WtAUVHDoh1Tr0k41CURXkyvDYXu3BLZ0yJIwwAs7O0UC9YcuJDKf6Q/1f8DSqXu1vrkEwaEHYN9kMLk2i0SzbOAvQXKKWDIwxK5PMo1DMKDyRFcxDPY1xdVhUibocT9qPzVsKuA+m9DKdMY7DfHAHLWNqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMmXPa8pOybq4slvWPxgIvL7WjZD+TncCzQCaBZ28+Q=;
 b=Hfe7bEYzDjMPtLGqfKsY+J2Xi+C81LynNXjQh6cQ6r0XCGga0kFPgV27OsQYTI0i86kDqqIQhEc0BykHeoMBZjjw1Ll2gXLR6TIfdIYCdDYs3ctv3L2Nn5XwojYBbZEH+tfp7+ifrjX2Lu+Oag6krNZ6MNKXV6nL6lpwbI8e+tr5wwvanHYOtOXOhDW7/upWQIZD5M9OwEMOCTK9YZK06tqWkXSzU6zdKH1ezHgtizTsWsLa+emX2/X8fSQ8Ak6/6K2kGnEr0vWn0n2jZxN/4p+K/xl+CplGH1LRixztfRwHAm/CSHbT3ASZ8ox34x7ExDUYAmwLj70DioxZ35Gttg==
Received: from BY5PR04MB6376.namprd04.prod.outlook.com (2603:10b6:a03:1e4::15)
 by PH0PR04MB8294.namprd04.prod.outlook.com (2603:10b6:510:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 18:58:11 +0000
Received: from BY5PR04MB6376.namprd04.prod.outlook.com
 ([fe80::42a5:b39a:f00c:cf4e]) by BY5PR04MB6376.namprd04.prod.outlook.com
 ([fe80::42a5:b39a:f00c:cf4e%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 18:58:11 +0000
From: Brenda Wilson <brenda.prospecttechconnect@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Executive Assistants and HNWI Directory to Enhance Your Marketing and
 Networking
Thread-Topic: Executive Assistants and HNWI Directory to Enhance Your
 Marketing and Networking
Thread-Index: AdwxSoEvDiD69ZEaQvGTbq2GhU7QpQ==
Disposition-Notification-To: Brenda Wilson
	<brenda.prospecttechconnect@outlook.com>
Date: Mon, 29 Sep 2025 18:58:11 +0000
Message-ID:
 <BY5PR04MB6376BF3999FA6E294F9E57C4941BA@BY5PR04MB6376.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6376:EE_|PH0PR04MB8294:EE_
x-ms-office365-filtering-correlation-id: 718dad8a-980f-4681-e813-08ddff8a231a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|8062599012|8060799015|19110799012|31061999003|13091999003|19061999003|440099028|40105399003|39105399003|51005399003|3412199025|102099032|31101999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5EaMddxH3NWSIwwAhYnYvivD/yuolTt+T8c34H0b38Hiv065U5qzqUWhEa?=
 =?iso-8859-1?Q?rn/uBVsw9oGjlB49mdsAPldnjHothX0sHepIi2kAlby7Q8+zZMgWANpQCv?=
 =?iso-8859-1?Q?3h5SYeO54MioaylF3GDZ0aA5tfHLo4QjM8tFhw8LtODnnJm79PQLwp5j5x?=
 =?iso-8859-1?Q?X0qbeFhbNOD1I3WperQcAsyIrFBGcIb1l24Juct8t5fHM8cLKhzhy4JlOs?=
 =?iso-8859-1?Q?xpwVK+pmOhlKPgmCswQS1L6U86ixcWBZeFLYVF0E/oz6qx/13+z9nv0/DX?=
 =?iso-8859-1?Q?qmTOkAbJ3Duivfr82Ut6+8WwGeOMLTNIhnCLp8bqHHsml4mBt/Sq0b50se?=
 =?iso-8859-1?Q?hcJFuQiU836uivljNw44gfnra5wkw9DuS+1Iuu3ZOTOPCrOeywzT5MapnK?=
 =?iso-8859-1?Q?nb8vOwZodlTrSANcb44KU9CHRs/WJHlZ//pFJmSHaZdrc3NZPucoYtJOzU?=
 =?iso-8859-1?Q?Elzg0frSvj7LXSwa59pYAoyTB3K99RFXHSMUND1tPJrh/zIib4tJF3fDpR?=
 =?iso-8859-1?Q?qOzPq8e2PT1tGXQWeGyfTH5mlfZ3V9zBM0OmB41aTK2crxfqvdwZocmkep?=
 =?iso-8859-1?Q?etmhrIAba0oaBoSdkx2V1y9qIq5CRWmbT2Y24tOyBasUt46tiYpvpYQRDa?=
 =?iso-8859-1?Q?VwXPnXRCnYm0VPZQPeG+X4pRLmCHz0ZeqMqlHQiZQ5HmxT6OvI4PVWawrS?=
 =?iso-8859-1?Q?MPnhomNJ7NBWrb5K7RN8INbN9+RuT0p4wzc4KXafCdG/+fK3UinmATc+/i?=
 =?iso-8859-1?Q?0uPzVV0Lb4MJldIljD1xu+XlLMfDnbPr0s46i+4KdrHtQaA0VB6KaSA8Es?=
 =?iso-8859-1?Q?zOeCWA6yk5ozRoYtpzLwncRvjnQ06uwFrRzhSMn0Jn6JypmTNTZyBMhUx7?=
 =?iso-8859-1?Q?1CD5kHOwTEJ5TReD6wrJczywSE/XzKENe20QPKgQW7L3h4KrEd1jzdBAix?=
 =?iso-8859-1?Q?cRyCuL/bkJKzNWCvbA/5kjKhXJVoas3U1GEWugWYXCY4XiGxk5ADpQ3FWN?=
 =?iso-8859-1?Q?BIEOpP65jcpx3PFE+1WLd2kTiqm/ctyPh3sCUfN+wb6SXzByPQUeMSzDBm?=
 =?iso-8859-1?Q?fC+tZ91PzFaayFLLZiTltkIk7qGSN0fOBobW0OHMqmiB2KD5p2KuBSXV8W?=
 =?iso-8859-1?Q?i9QrnTTWW3Qc7JJGDXbJaV4oxqqCQffo6Oo3Uh+fo1nbWsslVKDXjCQcLC?=
 =?iso-8859-1?Q?7YXOof7y3LIAoTiTXkP8Y0MXoWiEgcLwOOxX6IQJIt+Qr0w2KJk3Of/aGy?=
 =?iso-8859-1?Q?5E5zLZRsuFTGTAFmKBz7g3dKt39VRWmOFZujBGUbhfEuVIXoNLoTwZ35SM?=
 =?iso-8859-1?Q?FqUFYFe0wSpgeGvG1Py5B1I9Vl6bTGKisICRgMoYCQ+PGZKSHjUWxoHthZ?=
 =?iso-8859-1?Q?5t5Pwyp/Yu?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jmF7qD38LlPDo/TrS6buRUOoEZZFM6nymPy7hQHJzeNSkyvSfG1PIUZ5zE?=
 =?iso-8859-1?Q?MPz50rWhmor/rcR7a3mP2JD7qJ3c4IfTrEVP3K5/MfwC8jZPzjfVLdRw8K?=
 =?iso-8859-1?Q?3z6tV5JBGPbqchMsngYgPN5gQYr4EnmukSKAYsTWqVqhF9CdcJoxwjJnKu?=
 =?iso-8859-1?Q?4v1Tovr9PBr4mqQmI8gViPSGPB3YEbK3JGaPWwyto8LWLy/IQgqo1iDAy6?=
 =?iso-8859-1?Q?TdTtR3aj8XScM+d1e2AmZ/d9e1PY5tKiDlNFIibCHX/SnlHuBUoVlZY8Wq?=
 =?iso-8859-1?Q?2j8s1+5zQUJkwP9Udj0bZCbC1pzwSOtUGrA611P4mf6Jm5//Tp9EhD0SM6?=
 =?iso-8859-1?Q?CCjbCvhx6IolPVlAYhFNp6lSIFWqCNVjM+iY8H5jphKmdrRR7Cfz0cnlOQ?=
 =?iso-8859-1?Q?EW91bBVhNms2dmwwFlbJN1AoP2mO9gfx3SWhDVHj4Khs/pj+nWjC8nG4OC?=
 =?iso-8859-1?Q?eo+jcF35qEV4QMzQCdts4wJo3GwwV6JyJQ/bmFn/eQcE55E6PSE409SZoE?=
 =?iso-8859-1?Q?gEioIioD2U3m1A2HFB4jPom8Qr9s5IxutLOTYQ5W2TBi+WV6gTXa1nfkN7?=
 =?iso-8859-1?Q?usoMxRNO6uWMUFIvSmCblURFK59CteJReI5xAhcTNGiE9S/X8j7ogdMbMP?=
 =?iso-8859-1?Q?ZNlbqV8LC+fngo918ZPeoRzLU96nhjKHzSmYnLOR8hGDpVmrM1IKk10a1V?=
 =?iso-8859-1?Q?8KQIfETk9lDndmMr2pq0hjRK6yHbEisGwFS53l3xNU46wt5C18brLjZolQ?=
 =?iso-8859-1?Q?cWID0ZcUH14tCFRwv48bC5jn6bJLdOjsaGQALSTq1NJzbmkp8vHzdH+pJF?=
 =?iso-8859-1?Q?KsS7UvNpusHQK4CMd4AUrEM9E1cuJIQhVCibf+IlHAU5ZO0DVuXY3wnSLS?=
 =?iso-8859-1?Q?N8z1YbqOjOXJmR6bUAbIBT4s8FL8LUn65n8NQUkG87ymillUdtssxD8LRE?=
 =?iso-8859-1?Q?JhsCiTZYUxBDE2s86mHQ4S7XpICBbDS6OkjtJRR0MyC9Ib7ExhCrU4gVoO?=
 =?iso-8859-1?Q?G44KXj5d2GiK4qHHCQYXO75+AstKnPTuaS20ga75EEwg0+zxywCa7HYPTo?=
 =?iso-8859-1?Q?Xq1ZnGj3+0EyahrI+5fHPn22tjxW6eTn8e0Vr+B4B8GUSkGASMouUP7sd3?=
 =?iso-8859-1?Q?leN+ihQoDr5Kzyj3iChH/S/StGgr47vxrEBjtJqTyxyzpdK8pcOkk7GPJ+?=
 =?iso-8859-1?Q?bjBlANE1rPhCsKv9sRbAwsfJnS9ieRYtdonjwit51oxIgMKhSfk3xC5q4/?=
 =?iso-8859-1?Q?aZg/Wq59XDEqn2fzcx+AETZByJFhBHBpSLtpd6sGsbFrtbS2oVkcYF9qdT?=
 =?iso-8859-1?Q?KjMo2eTIEvgJTb3hQGwzVNybne/+o8dJzW6eI50GtbhBbQMMLBXi/sgGo4?=
 =?iso-8859-1?Q?hMAXSXrfLx53Bvbk6XyQ3qEGKJeq2c6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6376.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 718dad8a-980f-4681-e813-08ddff8a231a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 18:58:11.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8294

Hi ,=20
=A0
Our verified database enables accurate outreach to Executive Assistants and=
 high-net-worth individuals.=20
=A0
Executive Assistants (by region):=20
USA =A0=A0=A0=A0=A0=A0: 50,000 contacts=20
Europe =A0=A0=A0=A0=A0=A0: 15,000 contacts=20
Canada =A0=A0=A0=A0=A0=A0: 2,000 contacts=20
Middle East : 2,500 contacts=20
=A0=20
HNWI & Senior Decision-Makers (by region, incl. EAs):=20
USA : 500,000 contacts=20
Europe : 50,000 contacts=20
Canada : 10,000 contacts=20
UAE : 7,500 contacts=20
=A0
Titles we cover: Business Owners, Founders, Entrepreneurs, C-Level Executiv=
es, VPs, and Executive Assistants.=20
=A0
Data fields: Name, Job Title, Company, URL, Email, Revenue and more.=20
=A0
This list helps reach gatekeepers and decision-makers who oversee charter s=
ervice partnerships.=20
=A0
Happy to share prices if that helps.=20
=A0
Eager to receive your feedback.=20
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

