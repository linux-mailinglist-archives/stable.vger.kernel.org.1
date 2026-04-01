Return-Path: <stable+bounces-232780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB9dLzEbzWnOaAYAu9opvQ
	(envelope-from <stable+bounces-232780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:18:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC037B166
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D005D300E269
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F26336ECD;
	Wed,  1 Apr 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gGWHfYTF"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7238C2DF;
	Wed,  1 Apr 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049118; cv=fail; b=g15XGsrM4/wgZZKseOsIlARkdv2XJ7X2zWWOVAE6th0B5qEPitzT+vPj6y0LrJJaxCQmKD/N+5X3s1mAt0sLIGjHpJeHYb6on1Zqkg2TwxewXn8Er2t5a+Sc8BXEE/ojVIcWFz3wtwo+r0gf4/jfljFDe01gM9JQcj7kyD8Cd0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049118; c=relaxed/simple;
	bh=UD8ZurkYtvIq8GZ0H8A5P2Y//nUOpLMGQVHkoUm+lkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7XO1Ylrd6T7KuK0eAy6M01VsQ7wXtISaF/yL9DNHJWXPwvdC4UevWh3ZoLBTOXnB7Zlumc9RPR922voDX5EFPlpIFW8dNcUgATZn/uABhq5Azu0mDq/xdNVzPrcquUL/YvPdSclx9ncHxChrErvLPf0Jdd/LgAUIXEvX74vKY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gGWHfYTF; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhUr7rBBhFJNo6v5Aag389MGc8AjWTc5/1K20f/0rozeLcxppePbFDqGmdrCm+Rrsj+kl9lvUU5l1F8k250RQtpFAnlDHvfVXnc4st0amMV+vTzSKXapiyDl6LhvK65umFKLOb6bZ4jCfFc3CETrqv+/ugfzWLNfSZuJ8Rnum6tyIlDAc9DwG26UFJsNU7csMnydlJIquwrjWVpBt9qbZYvPg+7l50h9YeU4fcqYIbJFqkJwXgTs5uaiXJjgnntxTh28zCoRF5859NhmK646ppeK3PX9Tb2yNHw0jl/IIdVJ9lDkJTTD4eoWWFbGlkLg1fvPQupAXlQ8Ynb68+mTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9npmlan8U5WUNr+ezbrNKUw7A1SqBoelsFCSF3p+iuo=;
 b=SkYjJKzeTibxuXoretLvobZfFqwMA9h4VRzBpPtIeBBMEhDmr2kEKWHyD0Y2pDXKS+Oosfwqb3FEMb0LlMjjNLhq3XSADS9fGyYKCfLfVLP7t/6KF77YhWjJh2SVMoYx8pHGOtySoSf19CJN8Ns2Y+4kspT54zKQaurFWsQ7TlcTFGZbLWmvvuwthzBMqq6hd0CEKeoHR/yXJdOfoXtsrHoOcIEHsQHKDi3vVAZzd/YzQ431GsdCx2Qb0U3nROO4geWgMy2c0QK7ET+g/1f6lrpnHszVzbZCg0fYLyWU17mp46ROFHlKICC4pFELDOv9whA4Ww1mZn64uFsS/XdbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9npmlan8U5WUNr+ezbrNKUw7A1SqBoelsFCSF3p+iuo=;
 b=gGWHfYTFJVbWA/IRlHYm4BTW5HLHZ9TubXU/UGevnBqtIBDXG9SDkt5gmAQ+mAYUZt4EqPMdLviLw2eLKSDLWQO27mT0lVrZrrtxuiTS1nUDNOhmKnBKpQ2rzxukuveLiwUTK7iJ72oSqnCjSm7U3YI/TKlmQw1KrLVoDUZd40w=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:11:53 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:11:53 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, Christofer Jonason <christofer.jonason@guidelinegeo.com>,
	"O'Griofa, Conall" <conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "victor.jonsson@guidelinegeo.com"
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7dnEu4MVLVXG06oIZXnf3P2bbWjB/QAgARjkoCAIuly8A==
Date: Wed, 1 Apr 2026 13:11:52 +0000
Message-ID:
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
In-Reply-To: <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T12:51:04.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|DM6PR12MB4332:EE_
x-ms-office365-filtering-correlation-id: 71f3c5ef-08cd-434c-9e14-08de8ff03e1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 qleH7Rl1ymt3CCM+p1JWnPjjcI5nDQ/R2dMUyLhZXRa3LspuKgYn/9/e52P+W8G1LH37URdTyYUoEqaJnpiZty7JUITloDj8cbyP6Znxvm5okBNCzNLgoZIhKxfeSL+ULAm59QXoBKs6s6wiCWSGa0py6S7Iylq2os9ScI5VbdtJeTYlrouWavMNWjYA7M2pe3GRbGxShMF8e+0FPUKKMI/J1VBts5kTMIyeDkXBB6iHe8WnYxaK5TvQDovUtXOYny2rF03pQ/wL4SsfY1qqShvUYYGrWT/bDQx8ujKIgewD7wFShux/qUTR02xCJLKkCOKJD4LzJOv1QaaPIQcCNpB8xmbgTt77a/FmPB9JMm7Tn0Uwe76CccydtlQjqdW2ONFawECzbMK5CQawdUDQC+JN4zCazGmVkkl7wsFjOFrJwI7x+sdcYdjG9KiMj03zlqb3SO8qDxXSQbtjyeL/hV0iYxC4Ivh5Gw3/Xj0j1+4O+Wd++SoW/V52pnfe/XiJ+x1T12SN8oz7N4F+a2iVfuZNHlU57B1G27DNDKKb4MpOZSIeBx5B+rZv4gZ2VWPKF9LuoHnwEnjrVct4hTi1QL/Bb9V6Cr7C06iJFM7CRJTIe3evVkz9P0PXZquOWvEJ+8UN1pzJsEjyiPcFWGjseCeLOJwDjjh21CDZk20yqLtMs7ETAW4YMVDONCZ8SD4co2EvOi2ZI1NkU5z8k+EjkFj4pG9OxS9AFjAeH41VuNRbjPjOMXOM9fj1jC6HITVDy7i/1+cL0A3Xdd5gGuB90RSr6VmliFvCKu3yWmEV3ac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sDIB+5s74RVz+3dUjeL+0w+28WQOKRC7ze7fd+tiCi/febBYAL+1ux6oz1AS?=
 =?us-ascii?Q?AZiy19G+GgoPl7DZi0Oh1zqeJIJL7QaaPLplYdNNUF4gSR5MPMzvmej4r18S?=
 =?us-ascii?Q?pIulG/dl4mC+OQUjorobhZaXkg85oTFRvnRF+in6q7PWSJ6eKnpwaFnvEmEc?=
 =?us-ascii?Q?LGKbKpaM3t7vtGudNvbjHK/vIHa0wyDkJ00faWtWnCjeSZtBXpk1n9J/BG6n?=
 =?us-ascii?Q?y+pLUPRztH01piV77G0F81lKnWXsZmxidgEV5qdxd3YAyVZpKYv5ic5Xq+Ic?=
 =?us-ascii?Q?+/UgmRlSGFi/ZBYfxpQbKz8c4BHTyxCvX8v0KHVK8pm0GfFkfeiYUQ1mGnHD?=
 =?us-ascii?Q?f0nMdIt0kTUhbvg5nv1va1cKyWOeUn0Jcr+Q44wCaghsE63Sx5xHonouIhdM?=
 =?us-ascii?Q?CsYySRm/PZaQ8QOJfTkzjpM+2/yPaixbrS1SUaCPtLufz3gjV6rVRO7i7PoC?=
 =?us-ascii?Q?Di6K96wCaFN9XQ8E6+ZGRIaG4ll4jCHBlaXxyqNIAIYiOk1fereo/XGJ2EEF?=
 =?us-ascii?Q?WEW3ID84Tpp+ujuShb+Xa+bOQLAngzKOxUMMeKSrLUzkBRefZEr+o44TJJxn?=
 =?us-ascii?Q?jZGkCi/WtljleZWFig7Q+dQUHZEjlapQ/tvsSTiW9VSLQaxD9xlHDBTcxNrc?=
 =?us-ascii?Q?J55WemPUtq/yzfwgOQMPXsXuumjXQ64OCmVSiYY58TtOORdYKQtg46iDSOnK?=
 =?us-ascii?Q?kvO+WQoUax5yHlI9YfUa1K8xcmfsljpKUBsd2mofU/ZTLM6VSF6zAOgTymWM?=
 =?us-ascii?Q?z1MRjewkpvlFKc8yjyWRHBuUm4vFEMzRc+h1bPi55Ba2tk1TAvLJtsAwC3U1?=
 =?us-ascii?Q?XVgAqWBmIH3zbS792fUmLjSNUJ4tWBf3j97ip2jspZdXRbgtepnsQMdGteo5?=
 =?us-ascii?Q?aQ9OCdKRGmz+vZYbDTGgfXHwShD7L1GKvtZBEYgsZr4BNFeXTOOgVGEopOyL?=
 =?us-ascii?Q?7hOctjqA+ABhcKz/isHsIVqsCHwm+/+TWaUj7K2/Lodexmyy7UvexR2F1zhb?=
 =?us-ascii?Q?laKSgzqgTg6iuyfan01Ryf0if0SiqhBgkjuQTy0xfNJEY/MY/FtBPhMDjtGf?=
 =?us-ascii?Q?jT6Gh8USUOp/wAn7TuuIiRcShr4KTKQ4FzBW0ldWlRs2CsxVsvls1r2V8hZ8?=
 =?us-ascii?Q?iC+9vAUJinaT9K+HPo5V+jP4BF75XG45X6FQgS/4hqsgY/BoJr+grXGncMOT?=
 =?us-ascii?Q?tigjz5QDmWzKjUQ60+1461gIy6pscHuwS/cDdVkRdND3+l9fTA/kmr6FiZa1?=
 =?us-ascii?Q?sTEwGEASmyM6lpnnZM3S3HXf9jUVMGycit2ELc7I5vWFQXgKESwKGAeV9Cfg?=
 =?us-ascii?Q?Dgq5mwaFR52iaPPFkY5m2ZEnUBUwIZFOk+qTzsm7HgEr9qmsYvSEzLYm6pGC?=
 =?us-ascii?Q?TVRtUGVnNEOsj5uwINTvQRZxfxt2wZVJG4MoXzKDF5Oyxp3k0XX4k77Uvwy8?=
 =?us-ascii?Q?wcK9BoxMgqEm1EmUtRrJv3ScRv5VzkO92DTRATxrZr9I5P9PUG9cYJNLiVNW?=
 =?us-ascii?Q?+m9xMxSIOrC7jPYGVT6lVkcV86u/Z+DVZ4Qo2hsySHQGmBRH22lZawnpe4X+?=
 =?us-ascii?Q?yw2v15BBAxKzqF7rF7DabJJ6l9AXwlwLTwf15yLuWCheu8+YBAFfsaD5C0KB?=
 =?us-ascii?Q?HwadkVl8j8p2ocqGzEhZvBUcfsw5w5X0Xihcqx0batvcR4u26FPx/whWYQCM?=
 =?us-ascii?Q?tBvHn4TF6uyjERt9vP1Tkd2X2Z4oIdUNq0epIOdPrOJ0PMp4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f3c5ef-08cd-434c-9e14-08de8ff03e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:11:52.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLR0qECYQyWe4NyJXqjXKBgZO6RBI+Ea+EDs2DTqJUkOfpRN9d9AP2JAmTvdFDZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Salih.Erim@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,guidelinegeo.com:email,baylibre.com:email]
X-Rspamd-Queue-Id: 33EC037B166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Christofer,

The code change looks correct to me - it aligns postdisable with
preenable by reusing xadc_get_seq_mode(), and the scope is limited
to dual external mux configurations.

Since this is targeting stable, could you please share what hardware/board
this was tested on and how you verified that VAUX[8-15] channels
return correct data with the fix applied?

Reviewed-by: Salih Emin <salih.emin@amd.com>

Thanks,
Salih


> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Tuesday, March 10, 2026 7:43 AM
> To: Jonathan Cameron <jic23@kernel.org>; Christofer Jonason
> <christofer.jonason@guidelinegeo.com>; Erim, Salih <Salih.Erim@amd.com>;
> O'Griofa, Conall <conall.ogriofa@amd.com>
> Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;
> andy@kernel.org; victor.jonsson@guidelinegeo.com; linux-iio@vger.kernel.o=
rg;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable
> for dual mux
>
> +Salih, Conall,
>
> On 3/7/26 13:41, Jonathan Cameron wrote:
> > On Wed,  4 Mar 2026 10:07:27 +0100
> > Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:
> >
> >> xadc_postdisable() unconditionally sets the sequencer to continuous
> >> mode. For dual external multiplexer configurations this is incorrect:
> >> simultaneous sampling mode is required so that ADC-A samples through
> >> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> >> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> >> VAUX[8-15] channels return incorrect data.
> >>
> >> Since postdisable is also called from xadc_probe() to set the initial
> >> idle state, the wrong sequencer mode is active from the moment the
> >> driver loads.
> >>
> >> The preenable path already uses xadc_get_seq_mode() which returns
> >> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
> >>
> >> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christofer Jonason
> >> <christofer.jonason@guidelinegeo.com>
> >
> > I'll leave this on list for a little longer as I'd really like a
> > confirmation of this one from the AMD Xilinx folk.
>
> Salih/Conall: Please look at this patch and provide your comment or tag.
>
> Thanks,
> Michal

