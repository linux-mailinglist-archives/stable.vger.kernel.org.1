Return-Path: <stable+bounces-219711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE9aEJtln2lRagQAu9opvQ
	(envelope-from <stable+bounces-219711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9E19DAD1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1054E304C4B0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2531197B;
	Wed, 25 Feb 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k7yAYy8w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574A30FF36;
	Wed, 25 Feb 2026 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053715; cv=fail; b=nwgCo5/2FC3Plg0KgWFPBjXHuGinoNhjCZLDfjGoJ4d++V1WdV+4lPwkc6Nfly3nbdQCNdP+Ix0byigNZu/ovheuWwdMl/tyAn3TgC1lUAEe1baP30R6HGFCdsCzUkPWgLNuJAeVkhuAh0VnZ4Aa54AcOVbRN6aHAY0j5ISqBzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053715; c=relaxed/simple;
	bh=Ke8FsnDTrDfQpOxpJs0enAww8th8J1lPAe/BgmV0clU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EV07XN+ebHm3hrTXDiMffuy/Gy1V2aNqqkOw1anP6wbasJDuDWmIyXItUy7Ds2NIGFdKFUOgi/nsXY51AJxV/v4v77P1CoYNZgI32ghEpVMga2dxSflDuNGVJ/KFMMoPdbka04qIjt6XIr1sk0tVOyP7bcwd21NbGl68CcGqN0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k7yAYy8w; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDFipc2032984;
	Wed, 25 Feb 2026 21:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ke8FsnDTrDfQpOxpJs0enAww8th8J1lPAe/BgmV0clU=; b=k7yAYy8w
	W0AQJ+H+4JITkrpq9a6vcHYA/kJIivDYSiob+fIKF6Qc53R4ULcbDyjn7QJsXl6W
	iAXPx/nMRlsrNvwq5hV7tP7engKGl3j7vU2ZAWdFjGnrNnvr0hibNEJDthvjan1K
	2zZKOubWIXnMK+CYro7sJ+YLrkHX7MgeIjSvJHghXHqoRvX/9K058DcVO3dPaprX
	lozOoWbOcXP7Yp724PY1fruj8YfNisu9w1r/HE/xUx9ws+bsSRgX1HgXvLJ4AUrq
	8wIR0LzdHT7kzGvJ0dP8U7KfEzCaEjxxVYozb48RtPqNPJklxaM3UiXwGQTWA7i/
	9+DOhuAtb14z8Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gj0yy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 21:08:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPFGhy5JzXt8rpLEMjgfwjheOCR4Iirn7YNrQY2m3hNC/Pgm27Joj/xURtVtkdeCDfqgK2xBbC8ArHwBNSTVDG3EfPNyfI0ObtpDBtdeSWM7a9P6WDF+R6IA+Bz1xsDVtgpC1gFUcavcNgt6/4RQjewPM5dbterdhTpfLBtAIYUeLdLi8Jm7sLxZpWhMn+fGX+jyBVZ040/ASb7JA2xgVz8XdhDeCUYCHZE1xeS8EKAQPkaJvmEPIonrMmlhmXNfkqeexChIuL6w9tAQdVNqMMEEWYkcLkeqmhwX9VJb0I91REg+ei2nC1AtZoWlhq1wrEB5PHm6aaLITnIBjTMZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke8FsnDTrDfQpOxpJs0enAww8th8J1lPAe/BgmV0clU=;
 b=XNZz5SJ9j8KlBl6DHyoPVYaVKT7RyjZrPMq6lTHMHN4TeY90zeyGSaEgi/Ttc1RJxF94qSGGOzHyi/oPtO3VICB5pzlqC0F2pjqGACqgzsI49UUjZmBSUdjdLKR/39VGSezhCmv1ez2rEYKyiCS9iYVU8cyYNrEkAWB01f6ZtKLqE9MTupZpy/iBJxTns+CfXd/XNmKK4VYEVI9lOWexO3/xMTWTKEl31j7OfeCcoEzM64FCJk+OWr3G8KNh/m6ppuiP41K+7cqA8XqefHuNoGlysM91mevGDJoOJVyplUEjNdVKHATj2FO2Z9i5Dk7nxWSeYQIQxdK46hcgfnECvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL3PR15MB5385.namprd15.prod.outlook.com (2603:10b6:208:3b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 21:08:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:08:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex
 Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index: AQHcppgDS668W704B0iRyTKXxOujMrWT6I8A
Date: Wed, 25 Feb 2026 21:08:23 +0000
Message-ID: <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
		 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
	 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
In-Reply-To: <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL3PR15MB5385:EE_
x-ms-office365-filtering-correlation-id: 34330265-1db4-4520-2737-08de74b202af
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 J+nLi66HkNHDIm6JMukMvbXsVtXxgmdBFrV6Xb40U/ynNr6a0n79wSIBVilAQbJa+DPlFphGzdcNPLcbEvuWD6lvcP4jQ2Jjw5BtIYKgOkz62+3Crv4CS5lfJ2t85A473Iwm91TNCR1FOK95z6qnIcgTvKRX64CmQ2DQfutOj6wAQqI/VzmEflKJ1XN1SLrPAzNzFIFdOG/fTgTO6tg78BxyqzY805I9uMioX983wpUV+NU/XpmxVx/5996tD2lAsKlhBmr3ohO2nVgUXE1qYXCo4rTJr1NM9a3g1BZpeHxI3IMupVmjLbl6IXV3A0vHqd5HSRPFNfhzukxC5Vdhc1oCHnGdmwWJYe3+8PJwBGcoJVH7qCDTgOr47t01SnBCAOvxKEacJYW+sAxuYg+LugrOO1xEQmAaex+gr0BSNASKjKYsYPdDM2RBdZzpgeAQwW7KNqerRVpItCCLAthVGiZGPBISRda4RuXjFhTEUGFrjKazDoVkLQWOAunAtiLA86NuCzoOzkX8MJ4D4XO6/CPW/PS27OZfrtoJ3MCx7IKqWReql9mKbJ7b0OuIU16aofmOZbY0UA9XUUE4rcPi2vxNfQKYhDaW7ziGAn91M2MRhl1GqtgYQfF3QeG6yz44ZsLrwIDY7Tif7hz3WdXGbqguupfOxMvcCYXWMNxo38L3Qv7hcQrOrr3rN/LNHXslyrjdRCjhEdRYqT6d3tO/af/qhM4g0yyRkbsOfMzUvEUxgP3kgy9KT+Iy5mO7GwfhhK/gvqa7Gj5mx5nnmRKSd4D8U7MO1Ve7RH53h74Z+ek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEVuaXlDaldtakNIL2wrUlhTY2lNU1VRSkZndndmYXRlSnN2TGVNKzFaYkNK?=
 =?utf-8?B?UVJyQ0dpcWEvRkVDMmVkQSthMjZNVjNaVGdyazhiaWdaSXBiNlN6aWZ1c1Vp?=
 =?utf-8?B?TkJpZ1lianhzOFo0Yi9IN3E1NW01dEJWdUZPQ0UrWUJuTXNFcGlaMnh5UjVG?=
 =?utf-8?B?amtJWFB6UGJSWW1vWkhYKzFNU1M4TzJoSi9MbGgrMGZLYWNCdUFseGhiR3Z0?=
 =?utf-8?B?MHZSVDhxdWNFekpzdGNHMVh0Ni96NlVsK0JvVVRlM09xVGV1Zis4OW9lOCtX?=
 =?utf-8?B?ZEdHd3ZKVXBPaS9Lc1NaZmc0VHdrQUZnUXM1WEo5RTl4djFaSFlHSis2MVRa?=
 =?utf-8?B?bFpHNmlqM0o4dERXVWl4RDJHV2JoNHdQbE9NdnJ5cnQ4KzIrcjlGZFEwVlIy?=
 =?utf-8?B?bi9FUS82SkNwRWdOb0IxKzBLUlAxSGllQzhWYURNdmtsdHo5NFFJMTJtbDg1?=
 =?utf-8?B?clVaQnBrVHJmcFB0SnVPVGVBQkh1RjJWSU53WEdvRCtpcnFBeWtIcGF0UjBu?=
 =?utf-8?B?Q1pNRXB4VVI1T0xuNVFCMjNXVG9UZWx1QVBFMlNxaGJqd3JSRUtNZEZqSTMy?=
 =?utf-8?B?ckdkL2tOekM1L3Y1Q0twRHNYOGIrMEVrM2cvKzVPK2k1TzdhbzRwYWRROTFT?=
 =?utf-8?B?NGNxY1pVRlRnNmJwbnJZbG9jYk1Ic05iUE9JeU10SGZKWjJ1TGw0eS9EV1ZR?=
 =?utf-8?B?aERwY01mQlI4cGpsemsrZGZCT25rQnppQ0lrdW1STisvWG43LzNjanRIejV1?=
 =?utf-8?B?UGhFVVNSTklCZE8zNGdsSE13L3M3L2xUQkY2MnNUWHVxbmM2SC9FcnpMYkc0?=
 =?utf-8?B?TUxWQ2xxZVkxVWdkK1U3Z0xhR3NHWVJHdXEzbmlJQmRkQXc4bjBaUjVMMllp?=
 =?utf-8?B?WGZ1eHpnVUUycnp3UEdSM1FhN01PbDFTcXNCSVB5QkpKOXYxYVBtd2diMlNN?=
 =?utf-8?B?bGMzRGoyNFN2L1JFRW1iZnhqc0NWK0ZQdUU2TWk2bTBwYlFkODdsbWRjRWJQ?=
 =?utf-8?B?dzliS2RQWmZ0TlF4d2NKUVJZaFdiSzZkOGRjTFlDV29EbHdibTdRMFU1M3Zp?=
 =?utf-8?B?TEVWdGpaK0RCK0lQMSswVFprY0V0aEFSQlpoMWEzMmFQcjQwZ0VlZW9pQ2Ux?=
 =?utf-8?B?ei93aDV6MEpLRFFsbEg0c1RlZG1XcHRQMjR5QTUxY2xxTnhoT0ovamdYZDVG?=
 =?utf-8?B?V3BFSGVGSWxlSlBiNW41ODViMmFadEw5S0ZMMVFUUFdhbExwQzkxVmRMdnZU?=
 =?utf-8?B?TFZhc2M2cVFweWZaV3pwbE1CamhkMERtNzdWSnU5U3lVZ3ZjUjIrVkU4eEVI?=
 =?utf-8?B?UWJQR3lCcjdmYVdGY0VhaXI1ODdIWlhFb0paU0IrYnNSQmpSMkNXWU9SWnVD?=
 =?utf-8?B?VnB2L3pzNHNmQk5mM3YycHNQSmU4TlJ5cis2UTBLZFhaQ1ZuZ2U3dVV2REJj?=
 =?utf-8?B?em5hZys2bG0xRUFyS0NubVlRaGw5UkRMZWl2SzdkaTBVY0JUakZsL2VuQjZM?=
 =?utf-8?B?MmYvc2NDZmhacEZQSStVVFlwTFZ0NlhlYzhxTGgvTmR6Szh2NDNJNUpjRTB6?=
 =?utf-8?B?TUdvNjhEem1DS1kxNWFaekFOWDMydnpwSWJJcVRleUtvQzRUT0dkelJsR0JK?=
 =?utf-8?B?cUJDWHBqYkhoL25nQ1NmcW8vOHVyU0JiRHFuWDNkRUx3U1R6dHdCK0htNFdy?=
 =?utf-8?B?K3BVcUlIVW91TWRla0diczFVOWZTZzZWRWx1M1pCQU9CbFQ2N2sweWZ4czM4?=
 =?utf-8?B?QzVvb1FRTGhDb0lhMDM2ciszZHhMc1RsY3BUN0ZXbVBHT3EwcnJuNnVOa1lu?=
 =?utf-8?B?MHJDZU9hdi9sd2tOUXUwQnBXTi8yTzVySWJVckRQc1ZYU0JSZkhESkgxWW5y?=
 =?utf-8?B?N1VBRE5rV2Rla0MwMGh1ZGhLdWVMbTl2U0Iwd29ONVpRdmtjMVo3eDVxbDND?=
 =?utf-8?B?Z3dPQlQ0RE5BaytOT3duSy9oazZZeG9XY1NNVGFkM3VyMFM4TXhucWN3UDZS?=
 =?utf-8?B?Ym9SWmZVcmV0aHZRM3hpL0lGUTZlSkxLckdpZnlLdU15TjVjdHRmK3M5Rk03?=
 =?utf-8?B?QU9YYzlLdG50SXo3ZW5xNmVwd3F3M2swSUpVTWcyT09Ga3lsUDVlTkswUWVv?=
 =?utf-8?B?TXVWVGdWL3dWOFZzd3c3T2Zoc1c3TmwvNHJGYzhZd01vR1BHNjBNVFlMd1lO?=
 =?utf-8?B?dTRnb0tJczkyZ0NkV2xjSmtJdWUrUjlwdldBY01CaFNZSWdZL3lpTGlTN3cr?=
 =?utf-8?B?M3B3WlM5eXFGVVY0S0tHRGFLTzQ3Y3VhekF3UTEybzgxNTJJYjFBOEF4ZW9G?=
 =?utf-8?B?cVhhZFAyZWJvMVdrSUFxdjRFblhiN0FGMDFFUUR4R05LbHdXajlBa2V4VC82?=
 =?utf-8?Q?Ib9LxNr4Lc5gJU02c1pTlXyfS/qtE5a1YAviT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FF85E3A7B38864684569FFDCA3D7F91@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34330265-1db4-4520-2737-08de74b202af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 21:08:23.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5k6+MUyToLBJr2bl6ouqqcu0SwZ3sEuu/tv3s8Zg6amGd/PgjzWr+awLn2w+RKLCfBMXOSpTzDWvytiUtNdig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5385
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699f64cd cx=c_pps
 a=lrInUZDIVE0OTqvzw4499w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iZ_xbhvpPaIHuTYzhIAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 57RLiyVn73uOFYrh0uitX-hXciyAV-ce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIwMiBTYWx0ZWRfX4UM0+2Rdsi9T
 nWUvuNsi4KAnOex8CNodycfRMJImpQ0Ekh+/3NBikxJUrqsoa8xA/sIZoeISE7I8yEqeV3TXgtH
 K+a0LNZDlE7i/+Y9rbyK9gtb/guoWVI7Nc9CwMxmKz6AiG/JHStBlur8QRSjNR/FwxSXYUDZ851
 oG/3MrnmPUO/6OTrADJRz2bStTA6fG8ipVkjRCOPZRArvLx9r390JZREP6mT16e0uyFbUjHd7+w
 JNGunxtVBPbrcFvQWWR+dJZXdUvK3djR8FX/20WAYKS+fvCuIXBQznxE8ytvnSMZz2aQTmkc6us
 TT5j5yoFI4xtE+t4RBs214taM3nyGXCfwBY1RnsBk1pZOYJw9hz48UuEN/P4w4NqUBkOUVGeV6l
 WBbCWXVX+KpfwXvPmbW+ZPYVL1VkUtDCy7486JZ9FOFdKsYoGJMBJadKUbyZFs0pd/vGJKXvLpc
 W4em4075DewE6LAE4tQ==
X-Proofpoint-ORIG-GUID: nMUsQd3DpQeA7TAfKzvHa52QaQ_IFWxS
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250202
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dubeyko.com,redhat.com];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DFE9E19DAD1
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDIyOjQ3ICswMjAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IE9uIFdlZCwgMjAyNi0wMi0yNSBhdCAyMDoyNCArMDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdy
b3RlOg0KPiA+IFlvdSBtZW50aW9uZWQgaW4gdGhlIHRpY2tldCB0aGF0IHlvdSBkaWQgc29tZSB0
ZXN0aW5nLiBXaGljaA0KPiA+IHBhcnRpY3VsYXIgdGVzdGluZw0KPiA+IGhhcyBiZWVuIGRvbmU/
IEhhdmUgeW91IHJ1biB4ZnN0c2VzdHMvZnN0ZXN0cyBmb3IgdGhlIGZpeD8NCj4gDQo+IEkgb25s
eSByYW4gdGhlIHJlcHJvZHVjZXIgc2NyaXB0cyBpbiB0aGUgaXNzdWUsIGFzIHdlbGwgYXMgc29t
ZSBiYXNpYw0KPiBzbW9rZSB0ZXN0cyBsaWtlICJkb2VzIG15IGhvbWUgZGlyZWN0b3J5IHN0aWxs
IHdvcmsgaWYgSSBhY2Nlc3MgaXQgZnJvbQ0KPiB0d28gY2xpZW50cyIuIERvIHlvdSBoYXZlIENJ
IHRoYXQgY2FuIHJ1biB4ZnN0ZXN0cy9mc3Rlc3RzPw0KDQpJIGNhbiBydW4geGZzdGVzdHMvZnN0
ZXN0cyBmb3IgeW91ciBwYXRjaC4gQnV0IG15IENlcGggY2x1c3RlciBpcyBjdXJyZW50bHkgYnVz
eQ0Kd2l0aCB0aGUgaW52ZXN0aWdhdGlvbiBvZiBrZXJuZWwgY3Jhc2guIEl0IGlzIHJlYWxseSBp
bXBvcnRhbnQgdG8gY2hlY2sgdGhlDQp4ZnN0ZXN0cy9mc3Rlc3RzIHJ1biBmb3IgeW91ciBwYXRj
aCB0byBiZSBzdXJlIHRoYXQgd2UgZG9uJ3QgYnJlYWsgYW5vdGhlciB0ZXN0LQ0KY2FzZXMuIEkg
dGhpbmsgSSBjYW4gc3RhcnQgYW5vdGhlciBDZXBoIGNsdXN0ZXIgYW5kIHRvIGNoZWNrIHlvdXIg
cGF0Y2ggdGhlcmUuDQoNCkkgZG9uJ3QgaGF2ZSBhbnkgbWFnaWMgb24gbXkgc2lkZS4gSSBzaW1w
bHkgbW91bnQgQ2VwaCBjbHVzdGVyIGJ5IGtlcm5lbCBjbGllbnQNCmFuZCBzdGFydCB4ZnN0ZXN0
cyBpbnNpZGUgb2YgVk0uIDopDQoNCj4gDQo+ID4gVGhlIGNlcGhfY2hlY2tfcGFnZV9iZWZvcmVf
d3JpdGUoKSBleGVjdXRlcyB0aHJlZSBjaGVja3M6DQo+ID4gKDEpIEl0IHJldHVybnMgLUUyQklH
IGlmIHdlIGhhdmUgZW5kIG9mIHN0cmlwIHVuaXQuIFNvLCB5b3VyIGZpeA0KPiA+IHNvdW5kcyBs
aWtlDQo+ID4gcmVhbGx5IGdvb2QgY2F0Y2guDQo+ID4gKDIpIEl0IHJldHVybnMgLUVOT0RBVEEg
aWYgZm9saW8gaXMgYmV5b25kIG9mIGVuZCBvZiBmaWxlLiBBbmQgd2UNCj4gPiBjbGVhcg0KPiA+
IGRpcnRpbmVzcyBvZiB0aGUgZm9saW8uIEZpbmFsbHksIHdlIGNhbiBleGNsdWRlIGl0IGZyb20g
dGhlIGRpcnR5DQo+ID4gYmF0Y2ggYW5kDQo+ID4gZm9yZ2V0IGFib3V0IHRoaXMgZm9saW8uDQo+
ID4gKDMpIEl0IHJldHVybnMgLUVOT0RBVEEgaWYgZm9saW8gZG9lc24ndCBiZWxvbmcgdG8gY3Vy
cmVudCBzbmFwDQo+ID4gY29udGV4dC4gU28sIHdlDQo+ID4ga2VlcCB0aGUgZm9saW8gZGlydHkg
YW5kIGV4Y2x1ZGUgaXQgZnJvbSB0aGUgYmF0Y2guIE1heWJlLCBldmVyeXRoaW5nDQo+ID4gaXMg
Y29ycmVjdA0KPiA+IGhlcmUuIEJ1dCBJIGFtIHNsaWdodGx5IHdvcnJpZWQgYWJvdXQgdGhpcyBj
YXNlLg0KPiANCj4gSWYgdGhlIHBhZ2Ugc25hcHNob3QgaXMgbmV3ZXIgdGhhbiB0aGUgd3JpdGVi
YWNrIHNuYXBzaG90LCB0aGlzIG1lYW5zDQo+IHRoYXQgaW4gdGhlIHdyaXRlYmFjayBzbmFwc2hv
dCB0aGUgcGFnZSB3YXMgY2xlYW4sIHNvIHdlIGRvbid0IHdhbnQgdG8NCj4gZmx1c2ggaXQ/IEJ1
dCB3aGF0IGlmIHRoZSBwYWdlIHNuYXBzaG90IGlzIG9sZGVyPyBJIGhhdmUgbmV2ZXIgdXNlZA0K
PiBzbmFwc2hvdHMsIHNvIEkgZG9uJ3QgcmVhbGx5IGtub3cuDQoNClllYWgsIGl0IHJlcXVpcmVz
IHNvbWUgaW52ZXN0aWdhdGlvbi4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

