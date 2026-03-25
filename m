Return-Path: <stable+bounces-230276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMVoH/KXw2myrwQAu9opvQ
	(envelope-from <stable+bounces-230276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:08:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3400321275
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D11305185F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1DC363096;
	Wed, 25 Mar 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b="PEtrBboi"
X-Original-To: stable@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020080.outbound.protection.outlook.com [52.101.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020630BB8C;
	Wed, 25 Mar 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425852; cv=fail; b=rN4oJ6f84W5Vn3YHVrVn9hzen9xUQ3clVBAviDrhYVEFmstB+ujfiNHlx1NkKJMpHa3QJyC3neMBGnPH9d01ZOLl6woJQxHrlymp3Q94j7PJ0qcMYp3cW8bvkuG0nrb+j4T4GxIwH7VCFz7OaZd4rK03+rGuk5k3TD10pvKiNjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425852; c=relaxed/simple;
	bh=bGcsjnn89vzi0BbUzmick1Q7ZzGi64Wctp+hOhg+iOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K8IM4Nd0iDxAGoyxAyh0uhc5TL+IXfCog0X1QvHIAkH9pKwFwVID9moDCiCl3oy68zJzJBqtxNI6jPlcrniC94QukjMQGUHhj58Q6m+IdWXUgAfswIqAY8etQ3NqhTGWT/R/OCPuQxj4CB7qNVx04hle3aUfVQGsggnv0UTyQco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=guidelinegeo.com; spf=pass smtp.mailfrom=guidelinegeo.com; dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b=PEtrBboi; arc=fail smtp.client-ip=52.101.75.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=guidelinegeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guidelinegeo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3/psvPXe0dD7nrBvbQiDPpd26MSbxpu8xOpPqWN15rnsh1W8ftsqQQWIBh5Rgh0+ODBgNdKPOgpr1+UikFdl6BFwY40vAFYkLlOI2XGVBDCAL1+6HT60dF23cbgVvGL9xnU6buK5Gy8eMT/GgIrDlKvrtWx3JSYr3q+T7bRRbGeiowm/GOgT+KtUhN6Mi6Nb+p/gCwl6D4NoRPG/vIAbOSYgRKIB7sLPj5m2cgAo6+4DlEwGvfNhX9XKeo843LZkdxyvCraMzg171TFpA2I2eOobE9RmFqJcTVttpGPTSIX74d8SBW6cZLjrmHyvjjeh6q0+4Nc6Gqv/EJvVUJMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGcsjnn89vzi0BbUzmick1Q7ZzGi64Wctp+hOhg+iOU=;
 b=bO4ByjY/ALTfrIqLy/8a51UqfcbucuGEQZbGN0fZE7BXGSyBtyZagjc3GmmfTNM5ZsKeaLxP0kG4/P3tn10QP8DodJTH6xZbACncxhdinF2oak7alJdjBR3ksLW1rq3zUaLKHd0vVqgWjKyn0qBTSlIqPkJRcwhuU9izkCiSJmJ1vfOaP+u9MYCnYTwuUJ0mJhL1QHkVgiyCVOHI1qH6B0sFRKTFaosadp7GfkGyPNCHTe/bRzIp+fcf6IVTe3aQ3B5wBjh5lmf0WHpkotXU9P6vvml96Xqw/NgFA7gyZoKJdG8/F2beyG6KvX+cSnSbMi40QQ/MtYpHmvtUNp2O2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=guidelinegeo.com; dmarc=pass action=none
 header.from=guidelinegeo.com; dkim=pass header.d=guidelinegeo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=guidelinegeo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGcsjnn89vzi0BbUzmick1Q7ZzGi64Wctp+hOhg+iOU=;
 b=PEtrBboijwVYOBaofEi/Y9JjPdPgjJoqaJEzMcZxt5d1YcjocI2Pk95IAmwXsgwAmp/yG3M+18nXFYmUvcElGnpPAo7eDRiUklBWY4v0Vpz2O88vp2evDt1R6iSpqrgJjso6Vdy0BBCfstjXpANW6ubLMDr2+BQ+ADwyKA74JfI=
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:14::9) by
 GV5P280MB2251.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:377::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 08:04:03 +0000
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec]) by GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:04:06 +0000
From: Christofer Jonason <christofer.jonason@guidelinegeo.com>
To: Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>,
	Salih Erim <salih.erim@amd.com>, "O'Griofa, Conall" <conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, Victor Jonsson
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7ZpCeRIu+55oEGPm8jdqCh4D7WjB/YAgARjkoCAF5c0/A==
Date: Wed, 25 Mar 2026 08:04:06 +0000
Message-ID:
 <GV3P280MB00658AACE08F285D6EF18A7CF349A@GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
In-Reply-To: <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=guidelinegeo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV3P280MB0065:EE_|GV5P280MB2251:EE_
x-ms-office365-filtering-correlation-id: e58b3b46-69fd-4dfe-e3e9-08de8a45167a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 XM75iZS+KRsMPl/NbibBZ8v0KB5CbT1EYO6j/7tIWxku0lrQJqrJUDhtEufN1BBuKplV9ucGmYJgynTy1bPBZ2A6b23TAI3lAEevz3m1Iub04FmGoUziJg/m2n81O1sgNdVFO40DMarofsMzVou+R0qBUbMKjP1yQdKU0q1/blq0g/JcIWKcpNgDji2HhVDGllgCXP9hI5jVqhmQW/BNMhR3Eu2DP90jkqx7H5jiJizTrZbce7orGxBE9P73f7D13iVqqnpToalK3Bn3n2i9u9LgDDgeEtuTrKmGD5S7D0Jo9aG6S4a+F3LSv3Fya2J0Ykl/ivUfnoQ8RfhpzRiucosUna7oJyyywFAHF2uTOSAxr4twrXw5lQtK2E3KpJbuz/j7QLK5PuY8qeaUOsmp1x1HCgM0UJkProw0+eJ1LKuUOPS/vOCqqFxBhHwr9lJf/1bz1xGNRv9C8pZ0LiohgTnUgSnnBIvUsHWpx1CSoFfB7kf/SGIm7vrSnzTq3qy9t25PAb+BB0690Z6cDlYcC1XNong5jnMq6uaVD6t6bn7zTN2M5/xDbQHwNbERJMGrl6wBWhVVxz/vyP+tKLW+auIYThjDeys/K1t/j53XuzwqIpd1HVE9T0jFoo4UGgaj+APZs0egNbtb2QDTO9oPE8BK+l4FN7ck2AAE5UZ6mLRb1aGZKUnXF3p2S0wrcyZQ7VZKwRT3aPDiQw0XMdb3RHBOXjEk3iCHEePROGRbkku96AZg9W7/FwnJDZrdDeXHr3TQ1CVPzk+VLBBHQISKjVzOdg5ZAZqJUZQQifVkSsA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?R/X9aTSrOfP/xPDdJMxKfndZHdxVNHy8BrHkAAEiTAN1yscFho0MlfZK9d?=
 =?iso-8859-1?Q?QUBYKjAiUqsqz9nx8CL+xAA9AVUTe/jnfLHIkdVnH4/ke4nE+Lk3khWZgy?=
 =?iso-8859-1?Q?usw/65BmvhYaht8qVfrw8EMZxzpZl20O0x25atoKYKwuLHPXn+J6zx1Kt0?=
 =?iso-8859-1?Q?qxnTJUiktaRf1m49UsKtvY3EGD2tU/A8JqxrBgFPwvSF3KwfThhF+7pgDn?=
 =?iso-8859-1?Q?EMeCITrz4MCILEEfRnpPJ8SiXuwUpecPBQSx1Jez7kCRG8xom2LBs3Y3GE?=
 =?iso-8859-1?Q?teJI75N5qzmD6TLx9nMozXD5nBV7KZnQR0a8mBalz7xWp32TCdbbkWNwnc?=
 =?iso-8859-1?Q?ZVt19vtZ4EVyJ6jEBhyUe+yPwi1FJ3ODNY9fThkkGPqL8jdcQxXEzByz5b?=
 =?iso-8859-1?Q?/NrJkvCV3UNp9sPBKaAlS3GigSdE4fabtb1uTPfxGFjkd1dPUWY3Ynl2Xy?=
 =?iso-8859-1?Q?6rHH+5ed2oCbsXzZLqzWzXX7GSsoKhheIMYI4eb/zmEraLA+qFr3m9cjbc?=
 =?iso-8859-1?Q?41iFjPKKsSotAXjyj+Vjvj/NBvMHsHFXICIiIOQ6BMUwRD/xyfyRe0yxFX?=
 =?iso-8859-1?Q?T4RDVAFCa13Br7QlFir3qI+RL4oq0rrLygvfkyjOFWkqyTJCl+IFTblD1p?=
 =?iso-8859-1?Q?Sa1fW0WZQSi1Kt30QnhmsvxauznTKKlOYufB0SQ0llJA8o3r8F/oZsUbRv?=
 =?iso-8859-1?Q?DYb/Dk+WFOEyRmVl3Lr9vHa/Yl+nBIs8iBg0P2hRyzR9ECU8fXrPIWP4mM?=
 =?iso-8859-1?Q?g7oU4aAXqLuLOjlDESpox5gc1NBk5xMgQ+EgsD9ynYUpTahknoY1rT+OQ6?=
 =?iso-8859-1?Q?durcxumR1K/rATZ6ZtGV9D9/DK1KMb60M/iEpZnxT61pen+A/fD4jRl5kR?=
 =?iso-8859-1?Q?a1seuwn1EOOCZlg49vxufEFLBseMd7NLcrgFlXElrBB7E4HZe9rph9ca18?=
 =?iso-8859-1?Q?lgFPcOES2JcU/SfJZUmvFlw44UJryB+UdOezNT25KQJ0SRvndUfcHVUJf4?=
 =?iso-8859-1?Q?uT3UbDpNc+mwSkLmyaatGQ3W/d3eWZ3gSISN+vwbzU3KBTDwLmgnDNClyL?=
 =?iso-8859-1?Q?P9U2gHYWZhySZAS+r8l7Dj8jObzM8E2M2N0BE9izRzdddMaPaEUFuKwahw?=
 =?iso-8859-1?Q?ul4PhTXDqYzL5HzMulSrIlsWyETKe4oi1ceX66QcqA1fqCqN7sXyxj2ZVE?=
 =?iso-8859-1?Q?Nwnqu0GjbGNtgTL+bqOLjxS9NQVu0n8sA23qAb+XYpcEAdRAtjdFbecHpz?=
 =?iso-8859-1?Q?AxPcyUatg3mQxmgsMCEHkFFvWLljBA9PZNb79VfCq9Sf0XSmpgRgKMWMsF?=
 =?iso-8859-1?Q?k/MkJExJfsrOTaXu0x2vl/ZhwX/fS3jyJfcfT1txgROZ0cNV3BDwkin97/?=
 =?iso-8859-1?Q?+bM9l61x6+BN5DTekhObAcaR/p16TuVbP94R4Nnv7ztNic/Ee75MhYzvWc?=
 =?iso-8859-1?Q?jqMhFo/ceIAgO6Pmio1vI9+a0OIVNXWhPb53fANJimaD0Xbkb6UMDgltiU?=
 =?iso-8859-1?Q?UujxlLxntse+NZZ2a282vc6Zwo9y37R94MBipsGi0lozc+h3fCEA8Q+yyl?=
 =?iso-8859-1?Q?JWf4PSg4BXQywtc3t76ieGm7ULHSMXrvUt6wF+W3QF1Rj1B42oogJJoVu6?=
 =?iso-8859-1?Q?BczS11EwEjmy78hNLcxS2DWgD2N2z4k2Wl9E6ortmyiAeR7mI3mFIDo75f?=
 =?iso-8859-1?Q?b9lBEQOKi4bEbegrsuBaMUjA1jzELddN1ZACcNTDCttXAzsg+qMDpUHu8A?=
 =?iso-8859-1?Q?vmqNoO9vXhtbiTlvME7EGJvJhk27XICXMGBrFAG495sa/LlY+U8XlFlpKe?=
 =?iso-8859-1?Q?N/lf8fuT+5RBaTpzKMLh2LQyCpdyxOo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: guidelinegeo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e58b3b46-69fd-4dfe-e3e9-08de8a45167a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 08:04:06.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f3403a73-63c2-4dc7-b628-287972076881
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31IwX6xk463IizYy9Cl8Y4T4BTHckhoC6kbKVE3+//6HY3JQu+CM0LXS81ZzvYlcCto5DIL9NGlCJMAqMI1dYHSh/p2SVYzJ+4v9p2Pht75p3Qi4uIkWf02/k3Tj7HzW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2251
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[guidelinegeo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[guidelinegeo.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[guidelinegeo.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christofer.jonason@guidelinegeo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,infradead.org:email]
X-Rspamd-Queue-Id: F3400321275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping on this.=0A=
=0A=
The fix aligns postdisable with preenable, which already uses=0A=
xadc_get_seq_mode() to select simultaneous mode for dual external=0A=
mux configurations.=0A=
=0A=
Happy to answer any questions.=0A=
=0A=
Thanks,=0A=
Christofer=0A=
________________________________________=0A=
From:=A0Michal Simek <michal.simek@amd.com>=0A=
Sent:=A0Tuesday, March 10, 2026 8:42 AM=0A=
To:=A0Jonathan Cameron <jic23@kernel.org>; Christofer Jonason <christofer.j=
onason@guidelinegeo.com>; Salih Erim <salih.erim@amd.com>; O'Griofa, Conall=
 <conall.ogriofa@amd.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; dlechner@baylibre.com <dlechner@ba=
ylibre.com>; nuno.sa@analog.com <nuno.sa@analog.com>; andy@kernel.org <andy=
@kernel.org>; Victor Jonsson <victor.jonsson@guidelinegeo.com>; linux-iio@v=
ger.kernel.org <linux-iio@vger.kernel.org>; linux-arm-kernel@lists.infradea=
d.org <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.=
org>=0A=
Subject:=A0Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable for dual mux=0A=
=A0=0A=
+Salih, Conall,=0A=
=0A=
On 3/7/26 13:41, Jonathan Cameron wrote:=0A=
> On Wed,=A0 4 Mar 2026 10:07:27 +0100=0A=
> Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:=0A=
>=0A=
>> xadc_postdisable() unconditionally sets the sequencer to continuous=0A=
>> mode. For dual external multiplexer configurations this is incorrect:=0A=
>> simultaneous sampling mode is required so that ADC-A samples through=0A=
>> the mux on VAUX[0-7] while ADC-B simultaneously samples through the=0A=
>> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so=0A=
>> VAUX[8-15] channels return incorrect data.=0A=
>>=0A=
>> Since postdisable is also called from xadc_probe() to set the initial=0A=
>> idle state, the wrong sequencer mode is active from the moment the=0A=
>> driver loads.=0A=
>>=0A=
>> The preenable path already uses xadc_get_seq_mode() which returns=0A=
>> SIMULTANEOUS for dual mux. Fix postdisable to do the same.=0A=
>>=0A=
>> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")=0A=
>> Cc: stable@vger.kernel.org=0A=
>> Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>=
=0A=
>=0A=
> I'll leave this on list for a little longer as I'd really like a confirma=
tion=0A=
> of this one from the AMD Xilinx folk.=0A=
=0A=
Salih/Conall: Please look at this patch and provide your comment or tag.=0A=
=0A=
Thanks,=0A=
Michal=

