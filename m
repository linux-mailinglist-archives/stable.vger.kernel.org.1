Return-Path: <stable+bounces-179233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E7B5287E
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41B2A049D7
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468124DCE2;
	Thu, 11 Sep 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iE1JY8se"
X-Original-To: stable@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2F178372;
	Thu, 11 Sep 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570930; cv=fail; b=vCKDP3C78a6qTVbL1DR8vS4ppxBtwwExKA35YRkUfVxuzCHtJHkbhB/1z4SVMi3Ch3dkb0fHt5sXzw6nlduQilCOrVLITy/CAX4A0GDw/AyNxj4A++KYNGTq4YRaXNbMfc5/yYdMBWYZJ8vmh2+LcfoI/mbgz3D5a8HmiFaXMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570930; c=relaxed/simple;
	bh=bVuW2j0rBPoXx7lgPR4hsb1g1iGmrGLDJe7divqA+JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkPRp20An+GdTQ+ZVH1A+uCETyw29jbAkB2BplAoOu0wZajXVu782HsdTaSTwPviemL6+gzqjafSPLc/dQFLIO0m5n7d3hHxdKo6C/nmjOAmUMAIeRmCcRd5+wHYJu3t2dYmZvzY8XCwvI80hv9SVRrmbhvazrDjdqa1tlxConI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iE1JY8se; arc=fail smtp.client-ip=52.101.229.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJd0+oPyaAWHFmCzXQbPPFpRDAmS8H/zpK3ircjCpNJwalsiOOML4pB04/mRYPW9Uu2fWL7lsANGKaRuu83VXFub3SUQak5PCw9cSfDNXKxtHkePn2+DFjlkQvWkzakzGBENkpKgOzF+aSRhJTATSqhO/F0vCdMVrICIqoaTPkaW9gC8x2MuFkxuiahwNaJ97xgeeH/z+w/gdCTYsXf+BgrIj6iLB5jX0dRF1mO6latlf06xIYI4felKw/m5e6ZLdXbDy1pzl5hnm0Km3YNq2bYM/7DzbDvFFHd6OQ2qkkI3PC0Qfpf82GArBkdYtoIj4ep2QgveIZPoA3q21iFX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVuW2j0rBPoXx7lgPR4hsb1g1iGmrGLDJe7divqA+JQ=;
 b=e3qgRyxufuNdkDUOpNqCcHcx4NJuRvvGjZJrQLKex+oDbQhBPUq3UzfR7IJxvADYi4AKJ5ry+1cgQeYs7Exf8cbyjqMwpf1BcPCwkY/f0rhibRbfjV7TAGrq+bGgrHXhhKQJIyni0d4zhdbiZYVMn2Qt9Ammx3bLvbuxezBW89Vk59g2X6CCdGbOn1tivlMTDVNWqSe9dRq57kNGvZ2shCZzkRPFgB9kLyye1giCpj/as5470m00uwpJpfQrcFwawXtumx+dx59q9cSyDRav2QBchQgm8EFcTJUk4/36Z8Czv2Hyfg0VdOmb3WXtrdR9GzKreo4jtnyQYhsXpJfluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVuW2j0rBPoXx7lgPR4hsb1g1iGmrGLDJe7divqA+JQ=;
 b=iE1JY8sedF4NbgO7g114RN12s0FO26zKcGp8GRuK+eP5Re5gX5g+pY7bgIq81wtvkrm0CiaE0ZP45weMOHer45Rtn2wm8M8GV3ebEJyLmW4B8S25GOQlzrVw7sm1fR1oIx3eVKB8lVtfuEnOwdmh0/ALb0/1TAHQl/dxHlx92AQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11553.jpnprd01.prod.outlook.com (2603:1096:400:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:08:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:08:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
CC: Lee Jones <lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin-Gabriel Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] mfd: rz-mtu3: fix MTU5 NFCR register offset
Thread-Topic: [PATCH] mfd: rz-mtu3: fix MTU5 NFCR register offset
Thread-Index: AQHcInyxKhDbPc9T6U++vqTR8C25sbSNf9CA
Date: Thu, 11 Sep 2025 06:08:39 +0000
Message-ID:
 <TY3PR01MB1134611D6044793CD6D5AFB0A8609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250910175914.12956-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250910175914.12956-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11553:EE_
x-ms-office365-filtering-correlation-id: fc5b9800-5d32-4f98-a244-08ddf0f9a6ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zq1Rt6prUDkaYelF2k9RhxFgsoxHv8NkoxC0BPEFaus0faMIqIkX7n6ZS+M8?=
 =?us-ascii?Q?rT34LF/wdl+S0+NiOgV2vIkxPhxlz6Bp1nrv9BsKPfBUNRZCgJ13Gmh5YtU0?=
 =?us-ascii?Q?s3UvRM8QM5jSt+QcKt6xnleuutJP/JcXPGnL/RwksBYl/ysOd4tiT9zZtDmF?=
 =?us-ascii?Q?J87aVmRlqvhGvs64anSztGt5zrzbyxB2APZAR/E9IFx1o0I2jZhQbatSjXol?=
 =?us-ascii?Q?t7+AfnmCAi4wCwJnGTLfrY3EmNDRDeZ7VeFbyRdz1czILJncm0OwgaqOWloF?=
 =?us-ascii?Q?aev9Q8j6XgFMrLZ0QqSIV0ZKFDHAmgvMVdh7fBLQvXhcke+MPTRqEaLUETC7?=
 =?us-ascii?Q?yGJ54Blyuud+FThYRxfZyj37iKLy0w7BPFDP/rKmhppE++c8W8VgGDGPJnV7?=
 =?us-ascii?Q?QYXXoO7PaXwfkfK0E3uxBWut9SkKRnnE98xU+FlhfnGsipRnI24CUf3PaZoB?=
 =?us-ascii?Q?fsxpeIePXIpx6gygsDY+hfK2thz7R2dOymRaxuN1NxR9QmdTLrb5pUw4b8TE?=
 =?us-ascii?Q?M7s/nlet+Tyqwup8PByPAv1qLN/MPKuUJ4Gl2FFb+6IKp5kHOOw6bP18wE3A?=
 =?us-ascii?Q?MrDyZJL5EZBC0weFnHed4cMHutu1H8r2p6aPdu3jKsFYD3ILMOzTkm3DVKXg?=
 =?us-ascii?Q?7XzAET4/lptyisruoepItX763r2KdHSOWzKpa6OB5hsiTw17Mb9MaCtGoGvm?=
 =?us-ascii?Q?D0skZ5Uha3Mg+14rMjX0ASFFq8Mfp35nCi0x9dBp45yxZ9hBvOLq0QUb3cD9?=
 =?us-ascii?Q?wYM7MBJA9dE0vyTNCsXIGCxtAK8BtNypZgrMxbLG8eTfS1Z8geOvYhJ1zqpS?=
 =?us-ascii?Q?LMKFvH6n86tUBlRq8HDYqO9lWTOJQ3FUOuGilGZ+u1HvKoFEU1mZ0YKT4vGp?=
 =?us-ascii?Q?Z91P8i1kW8/fT51xKZp1J9DrHxU2yFRnPTfG9RtgKOg+2aCHQh+iYlL9tWb3?=
 =?us-ascii?Q?k7uwgNEy4afyyLO+CiIohJ40pjADwU7qX2ljRgnZlHcf/n9saV8cuS/UQPow?=
 =?us-ascii?Q?002DpJc8m/A35mnArUhvzEKAbtWvmfaUCWE+J0Yez1TinMsfT8hN7fUCcmE1?=
 =?us-ascii?Q?BwMY9czjw+FQmk9OSJnde6FgLTnaE1XaBEe9nlY7aWLqjfIwosRbFx6Gngji?=
 =?us-ascii?Q?r+wbjy7h7tAdxGWfQEPUZ4YG3GlppNWHRhEOfYRH96zR0uhg+7y09Bq3vkfF?=
 =?us-ascii?Q?D2r31uyIVe4QYXsbvybXr/WyiVhpX0C20OXZV5Iyyp71rsvaImq80l5i9SvI?=
 =?us-ascii?Q?nvJRqiiqhIy+38UTVaZg7jb4Y2dT8djHPwn3X1GYVUlYNvj8Kle2MgFFGi3e?=
 =?us-ascii?Q?5hl4QibCY3g6isQn/bfMW478iylK9ZoUqKsnblb3qz5U+PFINSPa4PJAUSyL?=
 =?us-ascii?Q?0x1AVX76aclnx1GIp6cmm39KytkCl7zunrIdWEJLkww904EBJQGvPpZDxM45?=
 =?us-ascii?Q?kQfEseCFqwEFvlQOw1c99ht07am8OMjqgad8+82lRkmAsM2OEFLjSQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YQwl4XZXY7IuG0s+YcSRTfoGGjMM65ma/Lmeo++caEB9NclFpToAAT+1mzql?=
 =?us-ascii?Q?ZEhbapEokuj9r8J4sRNY9A8TSeBC6aQFIPeS/KwnRZyd1MrmDODCgmRZhv4P?=
 =?us-ascii?Q?MhIvyqz3HtkJh64yJbc2s5uT4fVRvaio4aLTRsDqa8/RVKbNVHUc03cPQr/I?=
 =?us-ascii?Q?qEKgrEudMjnv/juqwgJ2vLxFSycMkmosoZhlp/gzC1YGXSihxYLo7h+N9YH0?=
 =?us-ascii?Q?saIUGeuRY/sHvGBlMXfxDWZLQmc8/Pb1t3YjrFI/SalxdCIEV3iTDkz//2gT?=
 =?us-ascii?Q?CtyZdvz7cTjrmBxK2Vd4HrIzYC4CNjBI5xQXaaZ0pPClaGCOhVPOXbZLtrvG?=
 =?us-ascii?Q?ID5zbII1xDRosRIsFIzygc7pdOqHViaqb8+f0CXgQ9TB3nvALAcBPtm2Dz2S?=
 =?us-ascii?Q?bINYI4S3lbyLoXI2sdh2k+9v0fcrMpvE/KlmhpYXIW9EsyO+jE2nUX4erdkC?=
 =?us-ascii?Q?Fg0SswISE+JFQAkCaE+erTiykxT0XiXHY2JVgHyUFlMPsRvL8xpXpkAPuph5?=
 =?us-ascii?Q?PXqTeevz5fMkmgjuqHb58dHymQq2xS+/cL57/9P0ZGWWSG7TPFgY8nBk/kAF?=
 =?us-ascii?Q?Mtpln85C5xs66tzUzvQIhDX9jgoTmXA2m4erY64U6c6+nhJv6awhATLNB4dD?=
 =?us-ascii?Q?pQHkQVQhMXjW0oTDqIoNhnYi44u6IOtzL4xMY8EQ+i63I3T7GItjbemdH7JW?=
 =?us-ascii?Q?+lM1zRsde2kh1tTL0pXlnKadF+g1bvPahu5ru+KNivYm2vNcKNAOcBIh50OB?=
 =?us-ascii?Q?Y7+fXPyTHtRNa9j0qZCvVM6phBWasqFJ35qpnzTamnWDCr250dXjVO/7T+/Q?=
 =?us-ascii?Q?1k/Qejy40DvZvRD92Rh+YEalCizkgJuy7r69nFxB3TjKCq8IwgZ6KBUVR9wj?=
 =?us-ascii?Q?FcfLczK78DR3zae7k3cRneoIFc7lBuKLbCVFXEmcKYtNZGZnuMGL78tZRZvi?=
 =?us-ascii?Q?KaT8QEEK3ovR2hWXqRoYe1ra5AEwy5vYz9Ht7P5SOQPE0altertZ9Y+4943K?=
 =?us-ascii?Q?uOL39P0hdHAE8ZFjv1sw42xeY6IDfyTCGL8uAK5yeL8N0lcjr7yff93dDVUY?=
 =?us-ascii?Q?mJ6s+MMY9m0hmnwwJ0r1gtPsIUIEO3dxyFF+OKZS1HWjzQQp7Aq1nrvAUWD8?=
 =?us-ascii?Q?9FYvwrUfjmK/EZyOWmmxMPyMLRVK6YHiVXqeBvqKptCW4qh1awYbLM24+N+d?=
 =?us-ascii?Q?LZ7B3KBGxhEczsCKzp1lZYXS8F9x4NeAJj9dCQ4L+YwEEsXi2SV8VwXpSUII?=
 =?us-ascii?Q?IfjsytXIqLb7JGoNjXFicchMp1+RUIQ23GUJW2OJPQy+EszfwHCdRY7LEnqv?=
 =?us-ascii?Q?rFtF88fjTT49z0ISxRM+9NEN4ZjhWkn23+g/9nB8e7DBN7IdUQQa14rGVBe+?=
 =?us-ascii?Q?J4ma2QaHCpLJhC2FFm3ZwfgNMR5FLYJ9Mq1gyqZlEAN70z12SyDjXZf6l6z8?=
 =?us-ascii?Q?uWA8QqepEYMhnh9Di+d7x+HuRz9UurX1KTp6e20rTRetkHWItDtqEVCmZEnG?=
 =?us-ascii?Q?QtJe7m7zSFLYaPg1yuILeVMeCez0mXmcOXNQLcyj7GgpH66vk15s5rz5G8B2?=
 =?us-ascii?Q?Vmzljrol4+4KCjRVFX1C3DxdbfzR16lw6Y8024CFjbVY1DelsiJVX86Iv7RW?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5b9800-5d32-4f98-a244-08ddf0f9a6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:08:39.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSwioiEqqu5bLiXwYuXA8jlRBo+StLMkqN/RiwmSqgUcXBzMmt9JPRI9hoCAl86FA2+L8CTiuwDAntqaiRj2IsgNy7ZYPKRXbpXCCmsEZA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11553

Hi Cosmin,

Thanks for the patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 10 September 2025 18:59
> Subject: [PATCH] mfd: rz-mtu3: fix MTU5 NFCR register offset
>=20
> The NFCR register for MTU5 is at 0x1a95 offset according to Datasheet Pag=
e 725, Table 16.4. The address
> of all registers is offset by 0x1200, making the proper address of MTU5 N=
FCR register be 0x895.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 654c293e1687 ("mfd: Add Renesas RZ/G2L MTU3a core driver")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

