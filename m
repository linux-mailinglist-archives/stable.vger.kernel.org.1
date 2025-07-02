Return-Path: <stable+bounces-159228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0106AF124F
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6471C4074A
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF446256C76;
	Wed,  2 Jul 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DG1yVB01"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B32367D3;
	Wed,  2 Jul 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453299; cv=fail; b=l/o/tzULf/tekbkV9dhWyi+twOs1LqBIR6BNaKJqKgC0jmrgFfAFJh9bZp6LnSYobcoJHO7FuykCBmvfmUAPwUcSwoIxp63eklYielgS0F1aEhZrz0CCdC43divRFD3VbD3FX6B5copxyUp1TQB3XoRbhAiuM07o3m0rHP89OeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453299; c=relaxed/simple;
	bh=wuRx6ntMsioYQLZ+WzWgD9pYtcMMgCZL9S6IU//8+dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bd12lGygiV1BT5ib/CZOONTexKxM1YqjPnuA+lH32ppWoJn1X/kScJaG4hbyqEXH83n2OOH5Ui6yRC6JGvXz7tLFqu5VBBGwJIYA6NfoscvKTeXsmMaacGZqsQOiuOT8jg4DqK1ilTwO+I7aj/qoh1iM2L0cNhx/xJ7Ozz97Bnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DG1yVB01; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHZVxOJdrIYl37EvY3c+IKLMCnXCmHtlxkce0/EsJP3Prv0xbSK0zYiof+l1FjQkqPImRziEUOz7qFRATAHMtM4OS2fOzwqe4cWWrJNu5HP8Ch1Pt/L0XTUdTKYuLP9Vs4IuCbQZ0Fi12Md1nljNmsjQ0HtQQcyAj/YJo1bqrVcHq4pRr+myz+v4LDJCzqWDu+uSvbumQ1LHbfZx8/AylnB25aACOfUyaFk77m3gu/ToFw9e8se8avd2ZYYpvTajdM3tRu8S4P8FXPp+wtpbGb/TvEWG/wruOcZER1GifGJOf3Fq4mRefKWWC1Axkb8sOpvxwKM1l+qXzq5WzzMNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuRx6ntMsioYQLZ+WzWgD9pYtcMMgCZL9S6IU//8+dw=;
 b=TlE7DD8VRICqMr9wJj1/XXvlve1T2+G4R6RmB/fPK4v0FizJRyRzrKxfoUr0gTkplmxUta8MbqC0QMUTGjzfhxScB+SPzZvhK40rGNainYF1eGsSgoaqFw8qVqJsAG46XQcaH+pxL5AVZqzHtz0TUaN3bXsz1Cb7tRXE1CSijlykz7UzvKeZ5BzUOiN+RcRT/t5oOSUpVCCQG6W1Obl2ddi3N4GQuVij3QC0SPA4LhIoN084aor0UXZgzflNU56bL+NXC8a2YHem21Gl6iadBncvVHWQXP1EUuJiE84BakqJP14nj2pIJSACAtqXTewns7ZqUpe1BVHTPgl6kq322w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuRx6ntMsioYQLZ+WzWgD9pYtcMMgCZL9S6IU//8+dw=;
 b=DG1yVB01hlT8Law0+7XZlKS0+JkG+waB/yxMQs/Pl+oRxD/ElpbG1yc3SWinQSBo+aYxPUrZnB5U0pyfNhpdh9Uh8yqDPgnmM48Z0PPt3551EU9/EbjcRdmRdJ8oTZtY73k089Rjboj+SpJq5wyL7qbtEpJ54L4nkLIMpNKuqXPO05KPx0O+k0JeC/lonP0wKZzqws38dtIpJJiUx3BGiqFX5llUpncQyJgtr75IeyfUD5aGscO53e0pcB/XEBXLXu5OtJPYGPDpwit3q7xz6nzAprSyjZGrluwbTnOT6hIGd7Vj0MQuwG1Uj09Do7k0vOIQWTL29lCiR7LHGz7AjA==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:48:14 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 10:48:14 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <fourier.thomas@gmail.com>
CC: <stable@vger.kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <u.kleine-koenig@baylibre.com>, <vipin.kumar@st.com>,
	<artem.bityutskiy@linux.intel.com>, <vireshk@kernel.org>,
	<David.Woodhouse@intel.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <Balamanikandan.Gunasundar@microchip.com>
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Add missing check after DMA map
Thread-Topic: [PATCH v2] mtd: rawnand: atmel: Add missing check after DMA map
Thread-Index: AQHb6yg1z6KcymUhok6ODuofDO4Lx7Qep04A
Date: Wed, 2 Jul 2025 10:48:14 +0000
Message-ID: <58924d4f-2d29-4edb-95e9-ee7ccdb688d0@microchip.com>
References: <20250702065806.20983-2-fourier.thomas@gmail.com>
In-Reply-To: <20250702065806.20983-2-fourier.thomas@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|CH3PR11MB7772:EE_
x-ms-office365-filtering-correlation-id: 16c18789-9157-4bfe-0529-08ddb955f228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjZ5eGNiV0FMWlpNYmgxU0FCV2lkQW0vbDBGMTI3YWlyMVExZ08wR0dFM05l?=
 =?utf-8?B?RVVLNFR6d1Zvb3JHOUhOeXpjOFJoeWxaaE1mbmFMR3ZLOGxJcUc1N3NOZ2dY?=
 =?utf-8?B?Q1p1UWRpMDdPTEhFOW16WEEzUVFXSHhERithQkNndWpYMlVDRm5UWXBLUUsx?=
 =?utf-8?B?R2FPZmxrMnExTlM4djhYMXRNZ2ZXZ0lZVi96bDVzYTlYakZNSllOWXZBeCt1?=
 =?utf-8?B?dUFiTkZNYllpcmxpQk9MZDlHeEM0L0R2ZUJBeWhMSGRGZDFscXNXRytRNTFO?=
 =?utf-8?B?eU5DUE5wN0NSQkQ5MmJYaVg0Z0t0R1Q3N2VPREtQVEVlMlJ6blVLV3hPOUt6?=
 =?utf-8?B?dXU1VFB5RVE4a21FbHNwZUJJano0OEtLbFVndjZHMVg3eTBxdEJ5R25DSVo1?=
 =?utf-8?B?Z1VJbUV0OVVpYkk5dmY1TGpEMVlUcmRKb1d1SlpnWkd2Y2hiOUlnemZrODVp?=
 =?utf-8?B?RWJFa09pK2xtUlJla0tsOFpvT2ZpUlhOY1A3RXJzWG10TVFoZjNEQ3VOMk9H?=
 =?utf-8?B?eXBvS3YvM05IL3ZEanMvTGJJRzFsNXN1c3lSM25CQXJRcm9YSVJlNkFoQkpy?=
 =?utf-8?B?VTMxVldLQTN6ampUSlBGL292WWRUdjhDY3pxL2E1b3FxeHl1azR1dit1djBl?=
 =?utf-8?B?NlBMTGVNbkN3R2ViTVd1ZDV0b25UbW12RTczNVhMU2VGUEZzTlYvdWZHTkc3?=
 =?utf-8?B?OWRmdGc0V1NaYnZoc2h0eExPYUNrM3plVTZYdld3YWpGY0ZJbTdyRHZFSkFQ?=
 =?utf-8?B?MDV1Yk9LMVFRMjRwN1o5TnNOTU9yenZ6RisxVWlBazJIWEFJNGhwbzFrUitK?=
 =?utf-8?B?UGMrYmI2VjNtbVBKOU43N3ZJeFl5bWJ5ZCttTUFYUGdNdUdJRFdRSFRqSEpI?=
 =?utf-8?B?Vk1sZncyNGlpT0dZSlNDNlhDemxIbm5mTHRXNitXcnpUVGY2M0pUVjAvTW5C?=
 =?utf-8?B?Z2lGZFdWU3l4RXZGZFpjZG5oQmZnOXlYNGRTcDBkOS9PZVdPMGJMNTcrVHd1?=
 =?utf-8?B?ZUR5dUNMYVVUc3hVZEpSS0hwVDRSSk9qYmRHV2dxS0t6TmlDdmJsUWV2ams4?=
 =?utf-8?B?YWx5WmdMTFpmcjIzLzRaVTJFajZvZFB5TWgvbU96Yks3R1hkYjB2bTlqVk82?=
 =?utf-8?B?eGZLVkhDV0xHRStPWXZMRzJPT2h4Z1psZzdWWUlnM2FZYVdNUVJwb1A4Sm1m?=
 =?utf-8?B?N3FZbTluSGJLbkV1WXhCaWVlN3F2OExRYWJjRm1mbHJpRk9pVFo2UWNxZUp6?=
 =?utf-8?B?YmQ0cng1NFZ5Q2ZiMEhFLzNEaVlLcWVFSEJCSXhjNlVNQjB4cWNaLzdwcXIy?=
 =?utf-8?B?cUx6L2pqMjVjWS9waTBOUXhUVTVXRE1XcmpZeTNjRHlOQnRWdkRKV0FPWFU3?=
 =?utf-8?B?S05ZRW04VmR5cDdRcitQVXp4ZnV2dVpjSDkwSWJveEsyRlRmL1QwdE1ZcUdr?=
 =?utf-8?B?My9IaVhERWdTSG8ybHpnZURpNHZ0MkJWd3NhejJxNmh2eXVBYWpQYmZXMWZz?=
 =?utf-8?B?SHBQZ0g0Mnh5SXYybTZPUVRFL21WeTdreTVJUTVnRFVMSDhNWkg3RTZtYndM?=
 =?utf-8?B?c2x4bXdxQnBMenliRXA1YzZBaUhFcFA1Wkswek8wb3BFWmNFbUR3MmgzOUZF?=
 =?utf-8?B?cFJmZkRuaWtQQ1RCbGxOYTE5TGZrMmw1bUVjOEIyNG8xeVljL2dmdDdERS94?=
 =?utf-8?B?MUZzL3FnMGg0NnhEWmwrLy9kQmJ5UWhVMm9xeVV6V2RxK2ZEVUJsVGp0cUR4?=
 =?utf-8?B?blhjWURLM25Lb2xUMjlWby9GUlJ4RUpPUWx1RUMvZHNYK3VHTjh6emc3LzVt?=
 =?utf-8?B?WGdPK3g5WTljWTc2NUNlVzhHNmhydXdsZU5NbzNqZUsrMUtodWY0VnpQdVhY?=
 =?utf-8?B?YVZmVnpsa29YZnF3ay9PemRyTEdPUXUybjM2dzQ5L1dweVN2MmZOOEszQmp2?=
 =?utf-8?B?OEZPbGpEaUtZNUUyZ3RhbjU0YVVDUGhZdjhESGRTTGhoTEFieTNvbVhGZ3pi?=
 =?utf-8?Q?WgGTSPv6MwG3+JjrOGDlITpmUDpHXE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2FMSzk2enVMK2dhbm16M2lnNkNmZ1hGR0NmbzZCWHFQTEVKN21IOFJRQmlV?=
 =?utf-8?B?aGVScFFCbmJ6R0RDYlB2NHAxUEFNRXRkN0EyZjRiVTlNeldDOHFNTmVVWnEy?=
 =?utf-8?B?dmV3RFBkb0k2L29LWm9NQnRmeUQ5d1lyQzlSeFdUVUNUWjZsS01oUlV6TU9I?=
 =?utf-8?B?UTZUdHU1WlB6aFU0OGlHM2NhNEszVHczNTMveVdEbWJ6R0RvWi9ieFYrT3dU?=
 =?utf-8?B?WFBIczdvQ2RWVDVVYjF4amlOdzFxeiswdWduZnpQeFRTZFZ1OHBGZjV0cWVM?=
 =?utf-8?B?aFNyczZKczJ3N1dLbVZXSVVDMTZtZ2RUTUZoSTAxbUYrNGE0R1R3Q1AxWkpv?=
 =?utf-8?B?YkgwRkFROU5pTDFtbGdjSDh5WGxvSUJvNGdySFhqM2JaUmZTeUh4QnMwdUJY?=
 =?utf-8?B?WWQzdGlPK2F4NkFYQ3pzZGdLVE1JM0lUU2IyNE90RnFqb3A5SkVRTUc5UGFM?=
 =?utf-8?B?NHZHVzlqdU9Pci9LazlNUG5zTlBMYk1OUXMvS0JQUjNGUkJ0SFZFM09heDY3?=
 =?utf-8?B?azBFWDVraUhXNWR4OW5tS2cwMkZJU0U3dytqZDFteXRaU0NVa3FlYVY2SDFy?=
 =?utf-8?B?SGxjY29XMHAxQms2MHVEVDRBRUhhMms5Q3F0b3ZTRG5oYkl6THdlUFpEcjNN?=
 =?utf-8?B?dERDMzZhY0Y3S1M4YW5uSHFWN3VtRm9sME5xeEl0aFJCZ0VGRFk2MlhUUSto?=
 =?utf-8?B?RTR4YnhqNTFKSUVXaUkwVVh4SXpMOWl0NE9WRU5DbWF0bDZRellRb3JTbHJR?=
 =?utf-8?B?elN6WUZ0UzhnTVFtQnkzY1BTcWw2QUhFRHNiMnN5NGVJdEVjMU9UUkRTeW9O?=
 =?utf-8?B?b3V5aW1KOGdKTGFFVkozSHFON2NkOVgzR1F1dm9Jc0ZGS1E3ZGJrT1dOaTVO?=
 =?utf-8?B?M2xqdXZmL3ExcVZCZ3grWEkwOXh4VTBDaHZ1eUFKUlJWT0Eyd2tUTE5DL3U2?=
 =?utf-8?B?M0VGcUpFa3hYc0puV2RxeFdtd3crdEFEOVZ6bjB6TkZRNEVUaU5YeHVNOC93?=
 =?utf-8?B?emJrdldLYnV1TDBGZWRpRUMwWVlJUHhkcGg4aE9KTWlPcWs3QWtnQjlEajE3?=
 =?utf-8?B?VWJBOFFKSThqM0dyN2VlaW9ZUEJrcnBkZ0x3SldrT2FURVZhTHYxRFdrbWR1?=
 =?utf-8?B?MDhWNXVMR3BVdWJYL1IrS05rbEZjOFowZFlhdUhsVjdIcU9ZZ3pDazlUUkRO?=
 =?utf-8?B?ZUVHSTZvVUh6bFUvNTh0WTVwZC81UzVibjFFbU1DMmR3THFiOTd2aHlZMXRV?=
 =?utf-8?B?d2F4S3F4Sy8xQ0dpMms4eVd1ZkVUWUpIQTNMTnNWQjlodkhvUlBTVzVFSVFO?=
 =?utf-8?B?Q25mRkhSekM5aGhYWW5VRzA4dnZIMWRYdDcvUmxsYmQ3b2RPWk55U0I1TGty?=
 =?utf-8?B?aWNJMURxNFlCcXg3c1B6RGxUZFZjZFZaMnBteVkva25DWitiSHhaZUs1N2Y5?=
 =?utf-8?B?Y21kL0l5K3BUZThrOGNiYkdBUDFySDdmOXppUXhKa0ppK1dZdEZqWFBYSGt6?=
 =?utf-8?B?dGFrVExNc1BRbTlvYUZqamZTc3V5Q2pzSzhORVZZSUM1REVqQ0M3cDZHVDlv?=
 =?utf-8?B?VXF6Mzk3STVRcmhWSUJ5a2lXb3pxL081Ym5aTUZLSVFQVGJZZDRIRXVzQm9F?=
 =?utf-8?B?VW1UZ3NucEtHYzBqUTZ0T3c3T2JxcUE0bFhBd1RKZ0IrTDBXVTlQS2tYL3ov?=
 =?utf-8?B?QjV2T0F2YlFpOEU0SG9WYk8xdnBpL0tIUjRFZkdENloyMm52TjlGd1JURURI?=
 =?utf-8?B?czhIK1dvWTZ6WHduQmg4SlZpUWdFYmZseEtWYTRqMm11c2hXRks3S2NBeHdT?=
 =?utf-8?B?bjUrV1dBK1FVazh1OTYyZmpXMGRUU1RWcGhqSVFJWFI0T0xzcnNHNGltKzdL?=
 =?utf-8?B?ZDNFUzNKRGhHSFgvMFBRSTFDclF6UnFDTDVPei9rb0NjNGhlSHZTTTk3aDQv?=
 =?utf-8?B?akRMb0ZVdWJSMVo2aWZLRFZHLzdUV0lIbzR4V0pKRmg1d3FQbkMxd0dlNTRM?=
 =?utf-8?B?SmxZTlU4dmtPcjIvWHhHYnEwYUwwUm44YTlpMzEvOVQyZk9ySEY3TFpPSGpU?=
 =?utf-8?B?TXBuV2dEWGY5TDdlNXR2ZVFYZmc2V0FQQmFjUlJ4WHAxNGhkMjNlWkhQQXlU?=
 =?utf-8?B?OUwyVkszN2lLL2NDaW9va1I5SWV3K2s0Qkwyb2c4RXFYYi9aU2srMkEzYmdx?=
 =?utf-8?Q?ZnE+Swrrmqzc8l0BdmofVL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C08466CE4F42D42AB7A35DA959D0ABC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c18789-9157-4bfe-0529-08ddb955f228
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 10:48:14.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwXgfqs5g/sKeQgOnO5Lwyo/ebeoj0KFCghtsXn70siW63b0EaSYNGufNSisVnAnZLM0rbWokkCgqey6sFCz1ET2twh8HAOqYZcse6AKQCfyepY1dTD2cYozyaMP+GVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772

V3Jvbmcgc3ViamVjdCBwcmVmaXggPw0KDQpPbiAwMi8wNy8yNSAxMjoyOCBwbSwgVGhvbWFzIEZv
dXJpZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
VGhlIERNQSBtYXAgZnVuY3Rpb25zIGNhbiBmYWlsIGFuZCBzaG91bGQgYmUgdGVzdGVkIGZvciBl
cnJvcnMuDQo+IA0KPiBGaXhlczogNDc3NGZiMGE0OGFhICgibXRkOiBuYW5kL2ZzbWM6IEFkZCBE
TUEgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBGb3VyaWVyIDxmb3VyaWVyLnRo
b21hc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MSAtPiB2MjoNCj4gLSBBZGQgc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiAtIEZpeCBzdWJqZWN0IHByZWZpeA0KPiANCj4gICBkcml2ZXJzL210ZC9u
YW5kL3Jhdy9mc21jX25hbmQuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvZnNtY19uYW5k
LmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9mc21jX25hbmQuYw0KPiBpbmRleCBkNTc5ZDVkZDYw
ZDYuLmRmNjFkYjhjZTQ2NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvZnNt
Y19uYW5kLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvZnNtY19uYW5kLmMNCj4gQEAg
LTUwMyw2ICs1MDMsOCBAQCBzdGF0aWMgaW50IGRtYV94ZmVyKHN0cnVjdCBmc21jX25hbmRfZGF0
YSAqaG9zdCwgdm9pZCAqYnVmZmVyLCBpbnQgbGVuLA0KPiANCj4gICAgICAgICAgZG1hX2RldiA9
IGNoYW4tPmRldmljZTsNCj4gICAgICAgICAgZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShkbWFf
ZGV2LT5kZXYsIGJ1ZmZlciwgbGVuLCBkaXJlY3Rpb24pOw0KPiArICAgICAgIGlmIChkbWFfbWFw
cGluZ19lcnJvcihkbWFfZGV2LT5kZXYsIGRtYV9hZGRyKSkNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiANCj4gICAgICAgICAgaWYgKGRpcmVjdGlvbiA9PSBETUFfVE9fREVW
SUNFKSB7DQo+ICAgICAgICAgICAgICAgICAgZG1hX3NyYyA9IGRtYV9hZGRyOw0KPiAtLQ0KPiAy
LjQzLjANCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0KDQo=

