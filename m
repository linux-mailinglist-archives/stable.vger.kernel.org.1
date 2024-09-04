Return-Path: <stable+bounces-72981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992196B605
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3FE1F25ABB
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF31CC14C;
	Wed,  4 Sep 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="GxtIM1dL"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068131A727F;
	Wed,  4 Sep 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440876; cv=fail; b=HTawaD52MKYHn1og46H3Y3v16yNNrxz0A40VFwJ0Td5qoYRi3z3KkKxN+jpF2M9dksBHp6xcUy0V0KCYWGgGXhJn0gBH4m7SlEH3Sy0kLIRMQ1xgI8E0DhS9xMyUQGNVFZ8NqzpGnwpVaDe3+qOCE6ggFatoSvNwW74sBo0rGeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440876; c=relaxed/simple;
	bh=8r+oj93UpN+nisSpJ2GiJlQmvEnJaN41JGE5x5DTKoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQXBJ30cHGhTL/p/h/h7IAGKpfGpk9sVX25cMi7xQdoJjXYv5X+CAdhOJENmUmSbl8Ez5Wk3eCTaeI56xaegdreoYBnaP2e8mE2B4ZYZWz1kD/83ABW6syzJ6Ddo2iZ6oh3vd/QH6SqiBbS0Ocg/YsNHvmKxK7QHKPI5A+hYNcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=GxtIM1dL; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWHo/qu1zwXdo16iI26qt35QR/z/csm4raunvk9gLzyIh6PHnq5v8E97L6hOn45M0FWBxlfvu3WShDzwzSt6hOOUcs/xZgkkK3DXizqJ30kPAIGWL4MV9ihuDV0arizihpOztJKFlwv8qKe+DovHhXvx2M6c/CqLuJ+2LlcaHkhxYYxXMKo9LanLkkiV2htLHMSgerFdmxASd+D+yC6ItDwpGElhKatpXbb3Rzu2Y7Pyf6go5SytD+Qvh1mdHAR42zR7UOaEQHEgzy7sN/t6pwI07iCSoojY0mmQ7WYg3BxjrxaeRmxpEnBgsR2OldLv1pdBzv5rEYrQ8rxwimH6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r+oj93UpN+nisSpJ2GiJlQmvEnJaN41JGE5x5DTKoc=;
 b=XaVUiXbymWQOueGcpiOfzYSmE1Ml45dToy35IEIfdl1WXR1BxMuXMKkAGe04nNYPRIOOEEBgVuQaKo/sDSHO6h3hN6Ou6g4C55l+0QXQPuyL/p2AoVY5K/Q76aKysdTDahcBXmAumCZxScKcej3Jh2FyqlJaLyDLw/7sGwaP2+lDRaRF5b7e90cYZCI77dyIvM7cEcrtcweEo93GVHDHWrmhQ1uq65gBnsyPWFrTevXLFZ363xxl6VoXsT+XHi491GZ8c1Sqwa4jZ7cITfbeQV9XT4LsNCIV5NyTdX1jF8jtc962UNoo6FdFBuPh28v3nGXlowKyJEkXErnR4w4o3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gehealthcare.com; dmarc=pass action=none
 header.from=gehealthcare.com; dkim=pass header.d=gehealthcare.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r+oj93UpN+nisSpJ2GiJlQmvEnJaN41JGE5x5DTKoc=;
 b=GxtIM1dLwThD/pt8fq8NFrDh1RfbkXXN+ryHCiXAtbiGhIRvRTFl0RnOFwzBxz3e/Q2jevUGU3gVhi+jbGbSsmJTg7nkuR+3e4q1V3z7Hb9PszaIoYuFMWG3LWOiXQ3m+9je3kWeGSGO4GgKcW4WovbsRPp29NgKvgMeXPxCbb60Zr08YHzIzkP/ICr528zpJYJEQHQBQY6jzxfspFHRcPeOVAp9z6ZyP16Cu4QS1frrct43cnpAwMRNJV0wDD6JO3BOBoBdDK/uXc69/PFoM43s7tWbBdoCIMYqdESteRcYmvET1StJp88dwdonk8Gk5A2zqPHIUJe0+iS5DNBwew==
Received: from PH0PR22MB3884.namprd22.prod.outlook.com (2603:10b6:510:2a1::22)
 by LV8PR22MB5027.namprd22.prod.outlook.com (2603:10b6:408:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:07:52 +0000
Received: from PH0PR22MB3884.namprd22.prod.outlook.com
 ([fe80::d41a:c85c:91fb:d6a4]) by PH0PR22MB3884.namprd22.prod.outlook.com
 ([fe80::d41a:c85c:91fb:d6a4%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:07:52 +0000
From: "Pu, Hui" <Hui.Pu@gehealthcare.com>
To: Liu Ying <victor.liu@nxp.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach
	<l.stach@pengutronix.de>
CC: "Wang, Huan Kitty" <HuanWang@gehealthcare.com>, "Wang, Tao1"
	<taowang@gehealthcare.com>, "sebastian.reichel@collabora.com"
	<sebastian.reichel@collabora.com>, "Ray, Ian" <ian.ray@gehealthcare.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/imx/ipuv3: ipuv3-plane: Round up plane width for
 IPUV3_CHANNEL_MEM_DC_SYNC
Thread-Topic: [PATCH v2] drm/imx/ipuv3: ipuv3-plane: Round up plane width for
 IPUV3_CHANNEL_MEM_DC_SYNC
Thread-Index: AQHa/p+6fjLDHuu9dEusB29XN7AxVrJHUUeAgAAB5ZA=
Date: Wed, 4 Sep 2024 09:07:52 +0000
Message-ID:
 <PH0PR22MB38840E2AA9F1CADCD2530297E19C2@PH0PR22MB3884.namprd22.prod.outlook.com>
References: <20240904024315.120-1-hui.pu@gehealthcare.com>
 <20240904075417.53-1-hui.pu@gehealthcare.com>
 <918336db-3c3e-4b5e-a9c8-096c9290f9d1@nxp.com>
In-Reply-To: <918336db-3c3e-4b5e-a9c8-096c9290f9d1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gehealthcare.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3884:EE_|LV8PR22MB5027:EE_
x-ms-office365-filtering-correlation-id: c2f71fc3-3d3c-4732-5fda-08dcccc10e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2dibm5IUFkvcTNBTnh1Tk1TcmpTVHhqUGRnUy90cjdEelNOMkJ5eUNMbTZo?=
 =?utf-8?B?UDA3UWtEVDN6WENsM3g1Z2FwdnpiVXJoSVI4U3NPdlV2NndOOGk5RTJmRk1u?=
 =?utf-8?B?azJjWFJIK2Vlc3BRemU1aW4zSGw2QkpXaWdNNjlzSVdudU1XM28vU3ZGN0N3?=
 =?utf-8?B?RnNGNDVtSVl2c1hwVFArMWxScFB2YWF6Ymh6M0c2OWVaaFBLWHhhVllNVTRX?=
 =?utf-8?B?YURlbitDZmJjaUY3ZThRTEpxaXJBZ0dQbTNibkV4YWdKMS91Tk9HZ013V0Yy?=
 =?utf-8?B?cml1NzdQY1RyRVEyd0VQSVpCWm5qOXpqWmFYdjdIT3JWZWdiVDUzak05WS9E?=
 =?utf-8?B?SXlnUjk5eGNXV0VjOTFhdGhFeHJ2L25jVTJCYlZHTXc4M0pPalBBMTZyMUh4?=
 =?utf-8?B?V3h0R1lSbmE2ajh4TTBmQnhuUFgvWWNvK2lHNml4dWlncHZkNkZ3b3RUS3Fa?=
 =?utf-8?B?MlNiZGN5N1o4MDI0blljQWg3aVJUQzdBR2x3ZGlWVHNwbmxBbmJWRWFZMzhU?=
 =?utf-8?B?N002dG54Vy9aNXdKWTVwbkF6Szh2V3VLYXQ5Z0dudjVMSnFZeEJaY3czeTFz?=
 =?utf-8?B?dWRTU0RVRDU4ZlFaNnBYdVRDenJvTkJkckVrNnVRTk0vUUQzZXdyRjlGdzZo?=
 =?utf-8?B?bHFlNzNYaW5OZ2x1ZEl2UC9VWjlraDlkRzZxVG0zZnNYd0RmUzRtbWRKUENB?=
 =?utf-8?B?TnRyTVhUMnZFQzVzcHBWcHNaL0xVcVJzei9PTlVJRnhMS3JsN3BDMmgxTVZy?=
 =?utf-8?B?c2RPWWo2blRXQVMyTHZ4TS9neG94Z2tJdlBZbUszTkFYYkw1VER1cExHSUN1?=
 =?utf-8?B?R2YxT2ZxZXNQVEJBWCthOEtMTkNGdU9Odzh6THJLVnRNUnNNMVF6Z3FjMUlO?=
 =?utf-8?B?aWhXMXNMU1pJYXcvZFFnSDFpRm9PSU9lZjVYOVZienI2NWlqam4vcW9sSzlP?=
 =?utf-8?B?dENIcnpnNGc1Q2hKWWkyTGQvQ1k1MEdsdkhsYUJTckovMmRWN2RzV3Z1QVl0?=
 =?utf-8?B?YmZQdkFFQnFGYTZ6ZDNPTGNNckoxajVaYVhoZ3RUSmd3QXRqcEVzMGRaYkhF?=
 =?utf-8?B?TGFaWks4YWhpS0NxWFZwMEc3T3RVNTB0dHkxek1iN0NjczU3RGREaVFBN0dV?=
 =?utf-8?B?M2ZRMWJQcWdHaFdSMlVJeUI2MzloVUhLR1RDVkJNQ0QzbHN2OUd1ZDhrT1Vv?=
 =?utf-8?B?NUJsaEsrR2EvUlBWTzFhWkZLNGtoSW1PZlpDWFgwb0FHVGJ1ZUlYUFhldzQy?=
 =?utf-8?B?WGVGeUI2bkMwWHRoMW9STURwUThpTVAzM2ZOaEpvNXVtandXbzNZTURtMktv?=
 =?utf-8?B?THNEYnBUdTE5YW96eVFPVU5yM3dzK0xmYktXOHdPWm14SXJkcTNYYmJPQTgw?=
 =?utf-8?B?ZlJLUmhLUFRmV00zOEZ5cjBYUThQTG55N1ZpYlZmOFIzdUY2WURuVjZzU2Vy?=
 =?utf-8?B?OExhcTdUOUhoS0QzT2NvN1A4LzR1L2VnQjRRc3JRV2dkQ0VxVEVrWUFtWlh6?=
 =?utf-8?B?SVJXSVEwSndMVDc2Y1RmR2VMM1QxZytDY0owS3hoSU9SWnN1ZmYySlh1ZUZ1?=
 =?utf-8?B?NE5SZk1ERUNadlczMEZabHFFYnlXKzFLNElOQ1NJRTJrMnRsQUh5RWpVT2pZ?=
 =?utf-8?B?RFZ5clUzaVN0ZGpyUlhYYW9Yd2FEYTRrMm51UjNCSTBIcDlzN2FQeXVQc2Ft?=
 =?utf-8?B?Rkt1QnhyR2FjRkZKcUttc1VFQ0xTYjdwUlhIWS9VTlU5SFN1SXJFREcvTVo4?=
 =?utf-8?B?d1YxeVQrZVJCVUgyL3dTVnZoZkR3NEtic0lnTGJpa21DTStrUUxoeTZWdFls?=
 =?utf-8?B?NHoxdU9aZmRsNHN5UlNaOWF0c2poTmp6RWYwdWtGenErWURIVndCS3E5N2xV?=
 =?utf-8?B?aGgycmd4bVJXV2t3ZVZFWFBoVnZGK1ZnY0VQQnpDM1dIV3hZYm1nMTZJTWtw?=
 =?utf-8?Q?zVm37rpivQg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3884.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STgzU3dOa0VNdVlnQkxwZjR0RDJzb253cGZLblJtdTVPMVJCVE5Nd2k5aTlZ?=
 =?utf-8?B?K0RXNVRMdTNNWFF3d1pXV0d0S0RzSWpONFZTUHNyTDhTRXdaNzBHUGQ0eU1n?=
 =?utf-8?B?YVNNVWJ4bjN3dVBKRStZWlNudm9PUDBmZFpMSk9HZEgvYmlJYTBhWEJYSVVu?=
 =?utf-8?B?QkpNY29zM2FqRjdmUW1LNDFwcUY3cXIxdWZIUjB5bENoZUdrRHQ1aFplWlpD?=
 =?utf-8?B?RWVKd0NWcEZrZ1ltanplUStBY2thTVUwd0IzZkZNUk41bFR5c3N2RkpCc2NK?=
 =?utf-8?B?UVVscVdhVm51TGh2dFlGMU9DNnNOZFhvYWMzME9aa0x3WHBiZHhoYkhJOVFz?=
 =?utf-8?B?dkxYejJjcndESlhyZ29Mb2VrZDlMeDVwNEJMT3E0eStsTFBlRUZ5S3lFRHMw?=
 =?utf-8?B?R3BRQU9pNE9UREhzME9oVCtvcHdzNmxML0VLNHEvMHIzaExqanJod0thZjUr?=
 =?utf-8?B?dGZFbjFKS3hCQ0pMNHRxNDkvK1BhYklmQjdQMlNIK2xXTW4zT1F1eGVnNGFu?=
 =?utf-8?B?T1RlRmx2dHZrMUV2QzZFQU1OWTN0VjIvbnZ1L3BhZndpZlIzS3R0aENqbHp6?=
 =?utf-8?B?MzZ4SVBHY2pVcHVGVytJMSt1K1YzeTBsMHdoeTNGemhvM0JPL0V3QWdNUVNx?=
 =?utf-8?B?SEJ4WjdTVXZpaDdNS25wWG1LNk1lNlhBYzNvWFFmY05saTZndnBjOEVHNW1p?=
 =?utf-8?B?Y2s2YnJyQ01FVWtNSmt6Um12QllzTU5XT1B1STNERVRjZGowYnBlS0g3bGI4?=
 =?utf-8?B?dEQ1QkNValM3Q1dJdmFvUTJneDQwTFBhTnN4WnBtbjA1cWkyaUkySUtoOCs4?=
 =?utf-8?B?MWw3ZG9tNlhHQmdQRzA1Y2Z0blgzdHBzeUVSSWZBQ0pCRUlrVURaZ0I1SS85?=
 =?utf-8?B?M0M5WlVxbE5Yc1pLVE5hUFRyRHNIMGIyYnM0U3lQdENKTy9GQ2dHSW90QUda?=
 =?utf-8?B?VzVVeHpvVVBQTytHOXFkelpCdFNoblZWYkNEUnZ0Sy9CbEQyVVA3QndjbHZZ?=
 =?utf-8?B?Rk1UUE5SOVJaTnQ0UktHMEYrYkZNaGFiWWM3aGFjaXZzdnN4bHdDdTlyQmNn?=
 =?utf-8?B?SHdsT3o1WHN5Z01pWXJGcnpSQVUxZ3pxRmZrcG1EekZncGdoWlRmZ2llMDdp?=
 =?utf-8?B?TldVK2ZZSG1nWXpGQzI2U1gwNFExZkcydHp1MnVsTnR6UU90NFp3YTlUbWF4?=
 =?utf-8?B?TmpNOExuMFhpc1hiNkM4ckZsNlFQRFZkUU45MVBoODc2dVhzaDdxS2JHWklr?=
 =?utf-8?B?VlVFWFhiTGVraVRialB1cDd5RXgrOWg2anRPcUtKU2FzKzJhajVEYVQ2WlBB?=
 =?utf-8?B?dDNTM3VrWFB0QTFFWjBORy9pVFlHdWFaSW4wd2R5SEdCRXFwUzVsLzBHM3pL?=
 =?utf-8?B?MHF5REtpeEw5MDhiQktKU294bG5zQy9wMVhQS1VaTVlYQ0ZaenpCekNDQyt3?=
 =?utf-8?B?cnlxYWlqdi93R2l5N3ZBY2U2YkIrdGw3ZU9nNkp6Q29SRUwvT2dZTHNHeEJr?=
 =?utf-8?B?K0Nmb3Z5NEVPV0hFM016VWhHWDFBYk1HdEdqNTlMSDdIckM2c2c1SCtJNmJ0?=
 =?utf-8?B?aEZWM2kzRlJWR05OUGpOb1NLK056ZjV3MTZDWUFsYTk5WnNSb0s3TVFNQkta?=
 =?utf-8?B?a0ZLSk1lYmpsUFRIaU1DamwwWEdJemFxKzQ1VWFQYVNMWjlMa1lrTHNNM1Zh?=
 =?utf-8?B?MDIzNFBXRDYzdEVSdnIxZ3UwOEhsUnJvdDZuRlpFcTczV29Xcm9tODIyOW1V?=
 =?utf-8?B?ODRONy94ekFpUGRYSGxueFEyd3dWbHZwSHllUzB6andMNzFSOWE2Z3EvbkFG?=
 =?utf-8?B?VHJZNTc3ZlhpSUVwd1ZjMUtLTFlHTVpNemZIZ3lUS1V5R0I1Yll1SERRRDNN?=
 =?utf-8?B?RXJMbTBYdmpsS3JHOVJiZGd5KzhROGZtNnFBclh6LzhYUXlxYUVKSzFkYVJ4?=
 =?utf-8?B?eUw3RUZqZ1czenNWNU1xcGd1WUlsWDE5Sm01Zzd4WXVNZ0hzYVpqUnJETXFS?=
 =?utf-8?B?WFZCeG9mcnovL21COEczcGlHMEZjL2NMVmNXVGlGT1lsZFZCT3dYT1EwYXpB?=
 =?utf-8?B?KzRzdURMVXpqcTE2bkRGZHBJWGZUaEk3ZUEwc0NqL2ZQMUZCc21ITTE3bllH?=
 =?utf-8?B?ZUZnU1RXNUV3Y2RWam93bWs1aXZ0RVFXQ1VPT1VqakhUYmszdmdvSGF3NDJm?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3884.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f71fc3-3d3c-4732-5fda-08dcccc10e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:07:52.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LHMWUY/fkwFb1mmWJTE4Rr0I4cv4kOPweb/q6y2Ol8hBNnQIoXmS+dWJqIfVEBRfKX4r6xjDZ5wq1z5EelU537XQS8ge8YWIvVUdQgRL/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5027

PiBPbiAwOS8wNC8yMDI0LCBQYXVsIFB1IHdyb3RlOg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgNS4xNSsNCj4gDQo+IFdoeSA1LjE1KyA/DQo+IA0KPiBJIHRoaW5rIGl0IHNob3Vs
ZCBiZSA2LjMrIGJlY2F1c2UgYmVsb3cgY29tbWl0IGludHJvZHVjZWQgaW4gdjYuMw0KPiBtb3Zl
cyBpcHV2My1wbGFuZS5jIGZyb20gb25lIGRpcmVjdG9yeSB0byBhbm90aGVyLCB3aGljaCBtYWtl
cw0KPiB0aGlzIHBhdGNoIG5vdCBiZWluZyBhcHBsaWNhYmxlIHRvIHY2LjIuDQo+IGNvbW1pdCA0
YjZjYjJiNjdkYTggKCJkcm0vaW14OiBtb3ZlIElQVXYzIGRyaXZlciBpbnRvIHNlcGFyYXRlDQo+
IHN1YmRpcmVjdG9yeSIpDQo+IA0KPiBPciwgaXQgY291bGQgYmUgNi4yKyBiZWNhdXNlIHRoZSBj
dWxwcml0IGNvbW1pdCA0MzMzNDcyZjhkN2Igd2FzDQo+IGludHJvZHVjZWQgaW4gdjYuMi4NCg0K
U29ycnksIEkgbWF5IGJlIG5vdCB2ZXJ5IHN1cmUgYWJvdXQgaG93IHRvIGlkZW50aWZ5IHRoZSBj
b3JyZWN0IHZlcnNpb24NCmZvciBiYWNrcG9ydGluZywgYnV0IHRoZSBjb21taXQgdG8gZml4IGhh
cyBhbHNvIGJlZW4gY2hlcnJ5LXBpY2tlZCB0bw0KDQp2NS4xNTogYTIzZTgzNzZlNjEzDQp2Ni4x
OiA3MWY5ZmQ1YmNmMDkNCg0Kbm90IGZvdW5kIG9uIHY1LjE0Lg0KDQpJIHRyaWVkIGFsc28gdGhh
dCBgY2hlcnJ5LXBpY2tgIGNhbiBzdWNjZWVkIG9uIGJvdGggdjUuMTUgYW5kIHY2LjEuDQooSSBz
dXBwb3NlIDRiNmNiMmI2N2RhOCBoYXMgYWxzbyBiZWVuIGNoZXJyeS1waWNrZWQgdG8gdjUuMTUr
KQ0KDQpUaGFuayB5b3UuDQoNCi0gUGF1bA0KDQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBMaXUg
WWluZw0KDQo=

