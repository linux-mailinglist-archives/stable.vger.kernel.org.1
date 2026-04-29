Return-Path: <stable+bounces-241933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZfKQ1X8mmbpwEAu9opvQ
	(envelope-from <stable+bounces-241933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:07:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2B49985E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED57E305BDC4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A6423141;
	Wed, 29 Apr 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGZ2hxWg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E31FECAB;
	Wed, 29 Apr 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489670; cv=fail; b=IXlW1RjN6J4XFZXYnJIffZUFAXH7iempc08h4MS8zZiDFbOjxjqO+rwRnQJgDrST4SZ0UF1ZYgWUwlsHfOe06M2rmDxQmHkMVTzS4+sSQPB2ZyPe6blgl4bVdsUoS59ZuKcZPsyJ8w2z881+iQcmeWN5K3hRhtc7fqwbLkkqaYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489670; c=relaxed/simple;
	bh=bUS+FLNr4EMncF6fKnrDZE1OgFszKbKQ3zfHYBhNIpQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=t/XN4INVqDXbNy8HsHeU+S3QZ+bwYQS+k4c+LHS5NMCFn6/VMish2lByBb557RIQ90z+Qm+zgBdrftiLbC4BK9tMuxdHTr5PvNcimxC8sr5DKX3CKIaehyk1f1rXOCj58zJdsehfqqFyECxlycL8OmJF4Xg8STTh1mnQu8Tbr3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGZ2hxWg; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63THGFRr1572311;
	Wed, 29 Apr 2026 19:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bUS+FLNr4EMncF6fKnrDZE1OgFszKbKQ3zfHYBhNIpQ=; b=oGZ2hxWg
	OOCxZqZ3qH3SX4xnaTDk+d84B2DfHd/z7O1BRSbD+8DtqZawtFc58Ri1pAkPOxPY
	kY7eDky1YwNEHIMPHyRymWiSkd88SP8IFWthx9j+6y/gARWCyXc6k7YSmo4KFX7D
	H81AccVwR/2flKnpA0DTXvPR7wj8U9yHV20dMUk9frTbMAmgu88cYV9a8H9waL06
	TYHGGSBkGwpY1Hzfx6VdYRUBzcL6sSpFnOzQ4zDxnMJWDpQNmpzFUXy3WF63ERzW
	5XGSVt5hr33oqStqf4g7eBtjnNEBAF87IrFMWUvMaemkXg/bvL9Ly2HmesruzaYV
	EJw7eqObBvdPFQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5c7sb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 19:07:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy12Z8c05TC6QHCi1EANfWaDtG+Your41UJl/3NEhKKf69W1khge8HNBv8bwHMisgB43YQlIz9ASCaM/w+nGmpcV5SuWHqCQzF3Cnec42ojMli4KKW9ndPGJc7JowQ+hkDZVmpmYkZlnSlE3sG0sW9p+uNin+h6kw+eODqjbSGRgA2eHp5oc1k69WVUM23jRWQDxheLn6++S8NegvXpAdMwU1AU3h3C4VVd4nBj1omXUdV8Je5zTG9kmqcsIApSFsSa/ovhGVkE/0P3x8b8pvpMltYGwNtw6Sor3FTWl1cXI024Ozheg1cTbm+l9HYGlbQh1vMhIgnxApWsuI3PbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUS+FLNr4EMncF6fKnrDZE1OgFszKbKQ3zfHYBhNIpQ=;
 b=xtFFhfxyr1ZYadhYOSR9hf55nr3e/EcZKVbHSo0zYq0MFNSLui+5lIj/WqLjDYdW8ctDINhdAn4ScHYkE5ZE/KMcmrmlzdvY6dbpQSxLsamPqYWA5pA9oIBUGo2UmDugT7EZpkyN2+o90DCxa4mFJCBMNHYRijlQTNSrwNooUVn3MP4FZxI2xd76K6pXFs2aZN9LaFYtZ6zHti5x76CDis9Ap7li9dPN/nDjdTOwazBIVzssG/IZpit/wInBKHUPEAhkHJbdFXwyr44pX/CS+0PQx35Q7GRE76zySouQMKZX1q9HtzhPwgGHwLJBfeZp3PlL01X6UmjOZnkrohOkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4674.namprd15.prod.outlook.com (2603:10b6:806:19d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 19:07:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 19:07:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix hanging __ceph_get_caps() with
 stale `mds_wanted`
Thread-Index: AQHc15CVn46RbGqR6UeG17Tb26+AdbX2Z8GA
Date: Wed, 29 Apr 2026 19:07:38 +0000
Message-ID: <8f415e00b3a990ee7733ff9339a5f72ff3689dd3.camel@ibm.com>
References: <20260427155813.2561935-1-max.kellermann@ionos.com>
		 <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
	 <CAKPOu+8Yumexe=Athx_fjtoNbTBgP2ENQrXx=idmkNeUwE9v4w@mail.gmail.com>
In-Reply-To:
 <CAKPOu+8Yumexe=Athx_fjtoNbTBgP2ENQrXx=idmkNeUwE9v4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4674:EE_
x-ms-office365-filtering-correlation-id: b1dd2c7c-87a6-41ee-125b-08dea62294e7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 OZdxKgvPCLmfOP0D7oFRwdLIQkU6sB2eUN6jReJkzi1LRWrbsqfVwnqW7vqZUQO7nf8AN3rqDT7NWKBrAzy2wsOp0VFflZx6XhrRA4Sw/Ujx4ii57s/rjfT2sKvuLtwxgr6oSm3QElk7z6oOb5dekY7soOqih9QYQP3tCTuIyG5NsffESlC1PlciqXWD/diY3hIKLDTqHDrbOtl7p8+x+cjQP3C+dVgpL/iNBkB4Q6yb7QK0T82b9H9TDicRvE0UCk/3fQREVtJtAr2JJn2GsR1PNZ+1aGyI20y45oidEW28GfnrAIRZVsxPSXegbDeqIHfSchbW5BSTrBTaCuKeQNSrSL8kDqYjYdKIC/o4DHhl46Am0sBnb19TfG+lDYRoyaTjlmf2AHYbJnO/a9Nr8w4F1702OdLS9hIw4LGE68Oty4WZV+Y3qqQbRg7XJ/CzQBAr94bEjoOpzTuggv8//NT2B4aicXxP2FavmyrTj2dz1IGnjeMO2bGpM7zjmSTyvjna6aaVXFSfWbDeT5xK3ZG4cE0VqNUof+f9vPkbEwUR8FSpoi/j5xFziv5A0QBDhZy+4U1yxY2awsR04wEHkuCQCJjv/Cn6r2tJQKyoh1rlL15GznIUloGmJA+qqQYMvePZmRNRXd0JMMmHUBsCo0ySpbeGnXg1x941jcpiCbwlo3DUKtXt9fPEhdNHcqcJwa5YhAICu2jtlL2kGEQEQvV+3V5zPGWoMg2bTISgr3LSI+WFpufyY93l3H0hSQov
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1lvL1NycGJxTEdOVW1mK0g5N3VqSkM2UjZPUzZrZXRWRTUzU2xURUpWcXNJ?=
 =?utf-8?B?ZzM3YzZnandTcTJJbDMzTnhmbFFvYjRFcFpOWURtaklXUWFoYyt2cGJTTFZn?=
 =?utf-8?B?OEJIMzl1VEJJckpQUXg4OGtyb2U2SVhBRUpnUkF1RDJxWnVFcW90ajVxUmJo?=
 =?utf-8?B?NXFHaVFRYUxGaTFpTU1USklkMUxIalRHYlp5N3NwdFJCNytPenNoQnJQZ3FF?=
 =?utf-8?B?OGlUbGRTdHR0Y0pFalNBTHBYejU0ZXhiOTFwZXpkTXVELzVON0xQaC9DVEdM?=
 =?utf-8?B?NllDSWpKZXEvTGNuRERtK2pXZVlWZW9HS09qQlF0cXVzUmFQL3ZBSjJiYVcz?=
 =?utf-8?B?c2JpdFVBZFNjL1Nleno1WjBzV1R1blUrVWF4QVBXTXU4emZ5TWFYSVNhTW9V?=
 =?utf-8?B?M3VqR1YybG5ISVp6bjV0N1hHUlBvay83bEdqM1Y1enhBNkYvQ1FwM0Z6RzNO?=
 =?utf-8?B?azFZY3FZL2lzL0ZyTjYyNlNycS9wYU16YlJkQmdZRFNqckZValJyWEJjNG5m?=
 =?utf-8?B?N21KZlNHcE9CeDNNalFLZkJPRzdUNGxjVTU1Tk1ENmsvRDVtSnIwbElybnYx?=
 =?utf-8?B?ZEgzc3BvMEhjVWQ1bjZya2JoK05RczQ0UUw5L0Q0dThGNDVLUlorQ2NvZHJB?=
 =?utf-8?B?OTNuM2tuVC8vRThlWDJxdnY1b2tSeFdhYUoxT2ZJZFVEY1ZzU0c3R3EwaW1n?=
 =?utf-8?B?aUlYc3NiM3RubDlJV21YRVlsTmxjejZnUklVcFZnTWRKaktjMnA0cGZwOFp6?=
 =?utf-8?B?YzRQUUFDeEd6SWlMVXNhNGthYU5wdVY1Q3loakZ2cVlXQ0lrYUc0cy91VXRq?=
 =?utf-8?B?ekVlK0R6M3l0cFZNTDU4bEhUeXZ6b202VHVDRmh6T1RXc2lScS9SNDFUUTVV?=
 =?utf-8?B?bWtMMTNEdlFzUUxYeUhyanZLeUZGYUJCWkgrYXpKNDJpaEdDc2hSZGpNNUt4?=
 =?utf-8?B?dzEvOFBLSFhFNWJWQWg0cDE4VG9QZTRmaGhDa1JxOWhoSmJzSGhVWEVJRDVK?=
 =?utf-8?B?NDMyeFRLdmkxOTRuZ3J1aXVTM1B4OHBKZ2RYZXphQTVCaDBZYklJMHdzWWFJ?=
 =?utf-8?B?Z295bkV0RHdqNElRUW90bjBoR1VhNUFqUmVyeU1wMnZwRkw4eUNMRk5vZWJF?=
 =?utf-8?B?TzBJRHBlYmoyRTlMdHN3cjRuVGFMYnQwVitQeVdyajBLMzFqTHZpcDhHNFQw?=
 =?utf-8?B?a0hIR0UzQnp6Mk5DMm4vK2hFREk3MkN6dlhvQmp5b21zUGtWQ3VvOFFrVThw?=
 =?utf-8?B?elZrd3d0VTVYbHFDSmEvMStjSjU1NDV4WTRUaldIUDVKc2YwR2FVV3gyUlYy?=
 =?utf-8?B?ays0cjAzQWdRZG5uYUk5NHNMZ2xya1l4WDg2blF6VGc1QVhueTM1WFJtcG9N?=
 =?utf-8?B?UzN4REUvV3J1NWc2MEJOd3d1UlRlZ3pmUnQybUlYOEUzbll3US9LOFRwa1dp?=
 =?utf-8?B?d21pNmpObW5IM3ZMTUpZRzJqbGNyenlOYzEwOVk0MC9EcytYdlRTL1JRYjhs?=
 =?utf-8?B?YmxZLzZnNWZZSUpoTitpaFRQQjZGdnI0dFVzRUZjTlBTUkJxb2ZpSk1pUGZo?=
 =?utf-8?B?M1ZZY3FUc1BFZnVPa2pzWXI3OFgvYVNXVVVscHY2dE1KcUN6V3ZGbDgzeFhO?=
 =?utf-8?B?NGtpQ0xUSDBLS3VrK1UvOFlhb3NlaUlTaFhhTmI1d29RUFZ1a24zS3J3QUg3?=
 =?utf-8?B?cFVHOU11ZVpNR3VBbXd2R0hlZUtpa2xYTW56bTFGbytRWlo1bmdxZnFGOCth?=
 =?utf-8?B?a2NnbUR3OHZxM1FEWHpObFVSbklUL05TOEJPZ1pTOU5xNWtQenZMOG81eE8y?=
 =?utf-8?B?SVJhQW9RWHBkcEFiRWIrUWJPdmx6Zjh3cUtGQmo2a0tzMmNIYzY0TUgyejYy?=
 =?utf-8?B?Mk96bjZOdzMwdVlSblc1N3o5dVlndDJ0RGpHTGd1bVduUEFSM1B6SEl1eUdZ?=
 =?utf-8?B?RUNjSERVU2x3NWMwZkFtbFl2VlBBeWpVSlBQK3JVeXdmc1RRNXVLWEYrY3dq?=
 =?utf-8?B?eEo3MnV0ZFNuUy9pcVNCeEJHYWNna1VjbnA1QndCM3dHUjBUcE1sRFZvWVRP?=
 =?utf-8?B?bzVkRnM5OW5BTXQxRW9DdFhOaEhzSndiTXFRc0p2N0F2YXh1Rlkxd1FicmZ3?=
 =?utf-8?B?NkNIMzBoQkExck51Y1UwZGJRaU0yTWVISlpEZ3pNS0dITVM0dnE2TGRnejZ4?=
 =?utf-8?B?T3dqc2p4alBhZko3bWRZUFlaWkMwWU1WNFMxMzNnNnBkS3YrZWlqYnF2SWh6?=
 =?utf-8?B?Wm1yV3A5QWhxMVk0YUZiKzJBb3Z0c3pNVzl3RFFSMzFiQjVTN2dramxPalI2?=
 =?utf-8?B?eTdpNk9qMlBhZG1BbGxaQU5RRmt2c0t1cHhuQitKMGRDS3YxOGNhRkJwaTh0?=
 =?utf-8?Q?QSS8fTXx5+0xpcMwN0x/KUEXhwG/GZBzA2zmN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <151C739511F7F54E996336B86413BF33@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	t5n2MRSl9E5Ke+/CCEapVYNFBZ8Y5y3m5cOMOxiC9+xdrg2bXaz8vwIu5ZXy6BXQA9iMyCsVqSTxGvnJbMR+dx4N7iRQpAXNs4fBe24phHA+Q5hejScbZophTGjeAwBAurZTW4QyLVEOKXB+G7fzazeqDdjdAhJlwbqtgoMoOBKi8DTrboPEx87m2Kb23GxMH+NzcdfQFjzjCCjQpBeToiH2s8RL9Slls17En79hvDOrXNFqu1ItJcH56wkc/9C1Ep5EvxPnN3jt8q9eh4FCTGYhWwU0kDhjbABytEaRDoVToUcHr4FiASwZ+6HJBkA3lsoqD1qSKnWDJqSEyzltlA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dd2c7c-87a6-41ee-125b-08dea62294e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 19:07:39.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2n7lEH048rzX27y9nmZlzmtT41jvV6U5XiMmMO9pB0o6/mJCs5eMutZPxY25mDI9eTv7fuxlrUW4/Ydod2uMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4674
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f256fe cx=c_pps
 a=+gGuMjfID3j0L7k8h/8w9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=XGMMn9DKQ66xHsV66bsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4OCBTYWx0ZWRfX8fwVB4yUHG7Y
 bmJK4CXIXPp7yd16r6exR7/lh69Nvj6t2+EktRp89SMuGNmEt2oE7O2OeEYp6NL9r3aNpDiVGHh
 UvW4c2lOT9URU86eQMtLSOJcYwD4d6CXa8tYALhzUDy7RpQWP5ddGivRhSDYMtVyYiE8F+sx5Q8
 nssWmN/egSNwEIsCVlEALDntaIFicVEZZ9GNBnVPX8fHDzPkacpTIiJI1uJ/p9L+yrzJ1PsRq4o
 nCuTJIl+EdPTLsXP2ulKBcxh2pYupM0oDPg5cPiAMXP6iiYiOJXf6YKO5CUOxPhBilT4kqpu/fK
 Je/xj4ZKD6nnoinHCvrBTgzQIYdtGEfAH3P6QABwizWeYruEMDGyNdPqqVZK859Jba5KMeLA/T3
 dbxM8ZCVS5ZVSmOYYpRO7bZLqq9J0U2WUSqrU49Nd8a8Uv7D3B8YwN1pi8KcfwWmJjrQCno+xuq
 mhOd1M6p8QDgFa/SoGg==
X-Proofpoint-GUID: f5TpbbJ1RaSeBweHxyOXEoflsKM_TEq8
X-Proofpoint-ORIG-GUID: V6FypIZ39-5cd128bThYk_kpWt6TB7cD
Subject: RE: [PATCH] ceph: fix hanging __ceph_get_caps() with stale
 `mds_wanted`
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290188
X-Rspamd-Queue-Id: 4DD2B49985E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241933-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDA2OjI3ICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gT24gVHVlLCBBcHIgMjgsIDIwMjYgYXQgODo0NuKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbw0K
PiA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICBmbGFncyB8PSBOT05fQkxPQ0tJTkc7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
d2hpbGUgKCEocmV0ID0gdHJ5X2dldF9jYXBfcmVmcyhpbm9kZSwgbmVlZCwgd2FudCwNCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVu
ZG9mZiwgZmxhZ3MsICZfZ290KSkpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIHdhaXRfdGltZW91dCA9IDUgKiBIWjsNCj4g
PiANCj4gPiBXaHkgZXhhY3RseSA1ICogSFo/IFdoYXQgaXMgdGhlIGJhc2lzIGZvciB0aGlzIHRp
bWVvdXQ/IENvdWxkIHdlIHJlLXVzZSBhbnkNCj4gPiBhdmFpbGFibGUgdGltZW91dHMgaW4gQ2Vw
aEZTIGRlY2xhcmF0aW9ucz8NCj4gDQo+IEl0IGlzIGFuIGFyYml0cmFyeSB0aW1lb3V0LCBsb25n
IGVub3VnaCB0byBhdm9pZCB1bm5lY2Vzc2FyeSB3YWtldXBzDQo+IGluIHJlZ3VsYXIgc2l0dWF0
aW9ucyB3aGVyZSB3ZSdyZSByZWFsbHkgd2FpdGluZyBmb3IgYSBjYXBhYmlsaXR5LCBidXQNCj4g
c2hvcnQgZW5vdWdoIHRvIGF2b2lkIGRpc3J1cHRpbmcgdGhlIHNlcnZpY2UuIElmIHlvdSBwcmVm
ZXIgYW5vdGhlcg0KPiBudW1iZXIsIHNheSBpdCwgYW5kIEknbGwgY2hhbmdlIGl0Lg0KPiANCj4g
T24gb3VyIHNlcnZlcnMsIHRoaXMgaGFuZyBidWcgb2NjdXJzIHZlcnkgcmFyZWx5LiBTb21ldGlt
ZXMsIHdlZWtzIGdvDQo+IGJ5IHdpdGhvdXQgYSBoYW5nLCBhbmQgc29tZXRpbWVzIHR3aWNlIGEg
ZGF5LCBidXQgbm8gbW9yZS4gV2hlbiBpdA0KPiBoYXBwZW5zLCBJIHRob3VnaHQgaXQncyBmaW5l
IHRvIHdhaXQgNSBzZWNvbmRzIGJlZm9yZSBhdHRlbXB0aW5nIHRvDQo+IHJlY292ZXIuDQo+IA0K
PiBOb3RlIHRoYXQgdGhpcyBpcyBzdGlsbCBhIG1pbmltYWwgd29ya2Fyb3VuZCwgbm90IGEgcHJv
cGVyIGZpeCwgYXMgSQ0KPiB3cm90ZS4gVGhlIHByb3BlciBmaXggd291bGQgYmUgbXVjaCBtb3Jl
IGludHJ1c2l2ZSAoYW5kIG9mIGNvdXJzZSBnbw0KPiB3aXRob3V0IGFueSBoYXJkLWNvZGVkIHRp
bWVvdXRzIGFuZCBhcmJpdHJhcnkgd2FrZXVwcykuDQoNCkkgaGF2ZSBub3RoaW5nIGluIG1pbmQg
YXMgYW5vdGhlciB2YWx1ZS4gSSB0aGluayBpdCB3aWxsIGJlIGdvb2QgdG8gaW50cm9kdWNlDQp0
aGUgZGVjbGFyYXRpb24gb2YgdGltZW91dDoNCg0KI2RlZmluZSBDRVBIX0dFVF9DQVBTX1dBSVRf
VElNRU9VVCAoNSAqIEhaKQ0KDQpBbmQsIHByb2JhYmx5LCB3ZSBuZWVkIHRvIGludHJvZHVjZSBp
dCB3aXRoIG90aGVyIHRpbWVvdXRzIFsxXS4NCg0KPiANCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICBpZiAocmV0ID09IC1FVUNMRUFOKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAvKiBzZXNzaW9uIHdhcyBraWxsZWQsIHRyeSByZW5ldyBjYXBzICovDQo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBjZXBoX3JlbmV3X2NhcHMoaW5vZGUs
IGZsYWdzKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHNlc3Npb24g
d2FzIGtpbGxlZCBvciBhIHdhaXRlZCBjYXANCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIHJlcXVlc3QgbmVlZHMgYSByZXRyeSAqLw0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gY2VwaF9yZW5ld19jYXBzKGlub2RlLCBmbGFncyAmIENFUEhf
RklMRV9NT0RFX01BU0spOw0KPiA+IA0KPiA+IEZyYW5rbHkgc3BlYWtpbmcsIEkgZG9uJ3QgcXVp
dGUgZm9sbG93IHdoeSBkbyB3ZSBuZWVkIHRvIGFkZCBmbGFncyAmDQo+ID4gQ0VQSF9GSUxFX01P
REVfTUFTSz8NCj4gDQo+IE9oLCB0aGlzIGlzIGFuIHVucmVsYXRlZCBmaXguICBUaGlzICJmbGFn
cyIgdmFyaWFibGUgY29udGFpbnMgaW50ZXJuYWwNCj4gZmxhZ3MgdGhhdCBhcmUgbm90IHVuZGVy
c3Rvb2QgYnkgY2VwaF9yZW5ld19jYXBzKCkgKGkuZS4NCj4gQ0hFQ0tfRklMRUxPQ0sgYW5kIE5P
Tl9CTE9DS0lORykgYW5kIHNob3VsZG4ndCByZWFsbHkgYmUgcGFzc2VkIHRoZXJlLg0KPiANCj4g
SSdsbCByZW1vdmUgdGhhdCBjaGFuZ2UgZnJvbSB0aGUgcGF0Y2ggZm9yIHYyIGJlY2F1c2Ugd2hp
bGUgSSBiZWxpZXZlDQo+IGl0J3MgY29ycmVjdCwgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0
aGlzIGJ1Zy4gIEknbGwgcG9zdCB2MiB3aGVuDQo+IHdlIGFncmVlIG9uIHRoZSByZXN0IG9mIHRo
ZSBwYXRjaC4NCg0KSSBhc3N1bWUgdGhhdCBmbGFncyAmIENFUEhfRklMRV9NT0RFX01BU0sgY2xl
YW5zIHRoZSBOT05fQkxPQ0tJTkcgZmxhZy4gQW0gSQ0KY29ycmVjdD8gU28sIGl0IGxvb2tzIGxp
a2UgdGhpcyBmaXggYWxzbyBuZWNlc3NhcnkuIEFtIEkgcmlnaHQ/DQoNClRoZSBwYXRjaCBtYWtl
IHNlbnNlIHRvIG1lLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ny4wLjEvc291cmNlL2luY2x1ZGUvbGludXgvY2VwaC9saWJjZXBo
LmgjTDcyDQo=

