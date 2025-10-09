Return-Path: <stable+bounces-183713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5530BC9B36
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524893B7690
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F32E285B;
	Thu,  9 Oct 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIr3aiHL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H+MMJWS3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749A1991CA
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022468; cv=fail; b=aDuN9AxhFKIv43doo3jgNJWcAzLiFqzzJYn5saCfvq0KTpHk6ICR1r+hf4GudcDX2gv+ROXG+qabPSb+4aGz/sH2FruzelN8UZFMSY0uglIWXTrE2Zbq9rh+6NV09hiWAzjY/6uVPKM42Cw8mImnoafOyiAS/U7LRcyE/7BLkGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022468; c=relaxed/simple;
	bh=86gA6DKOUJrLmds84lbhz3rSXLXQJ11FIJCRC74sIhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q35WeSdb+DLuHJp5ofQO2CmDODpOI+7enBrRpb5kBTXv2f4BEsHzOCEp5a8kyhgQGVTB8+coJwggGeB7ZMTpNx3+5pk/JrzNHJ6mbt4onemvPxDwXkO0Up6YljzRJgWQvRloFEnnJujzvJ2qYEaOiokYDSSnUgAdrN/yCzBDfjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIr3aiHL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H+MMJWS3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EtqlF025186;
	Thu, 9 Oct 2025 15:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=86gA6DKOUJrLmds84lbhz3rSXLXQJ11FIJCRC74sIhU=; b=
	cIr3aiHLnJ9S9/UuO9GUN1M2VibnsCA1hXHYdzBcKSSoOVTdCy/K22/2IURiUbf9
	3ZoE/5xhJoAx85Q+xZMkx+zsHd6dIxcjCQbgv0hDSV0KLhDyeHafD6IR8VdxI3j4
	o8YxxBiCLs90UgILUwtJwgnyXSI+sZHIFUzPm48P5XjY8NrDwCcfgf1E9Ga9HG/N
	iPZfccZMwCib0/+TKarEHVJMM8Mx1S4OC0G1qk1mPKhYRY+o0hWplRvgRxYI3xP8
	YBKXV19onlMf9I+O1V39Fp1cTzmkuxPDcxpI2UoCchZslWQxf/Eets7tU+D5QrgR
	o1QHNZlMz7DWn7f727IGHw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6bsuep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 15:06:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599F4ITs014474;
	Thu, 9 Oct 2025 15:06:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv67hksc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 15:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjeo2Nzi5DOd9mlvVVHX95bKM1kkKKYXxAiu/xZuN3ML+QH3Ut/AlwvLTJrfXyehbBKYNuXbQDKpn2k0ZWcHH7nJmMrGR222HSSpITMGhPF9op8A/dPHsbvfjT/ghb5s3T0urSnAtKJYZvwBWD0gHx+ueBIUTfDtFrcNPnpz7mTmq2D8SWSwkhpleQ8dV2+dYyoVrUzoZRdajIRTfKwf8uM8ParDpYQioi4UPwu/DtSL8Tp1cVZJr9bgVcSACn7mcmuqnuhsO8QjHeAg9X9af5fTOhlSURP9C07p3m1c4VD+NJqtlWqc50jqxx46f9AnWeFAyzQrfw3u8C4T+MU7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86gA6DKOUJrLmds84lbhz3rSXLXQJ11FIJCRC74sIhU=;
 b=LqmA5GKaD3lCh6KaFTSnIcacJ0Kn8RB1u6RcSdePqLwvQuD+DCmxqAAFELh36wsywSsgG95Th3S3PR2iGWhZRipN8XPMAiHJleAjRKJozlqLt9Urj5vxyLxv2vl/qbISgBa1VkASyK+7bTfid31KnAktMQRauX7iXACsQEPyc1ikP6SWjxQPuHEMkNchEntkuHmf9S2adONyAVjtNJ1+3ZZ/Lb89BQO4LTqprdd7kTfeTCnWyZv0at/9zVOx2Odg3OAYHAp6W6KgEHBcAQGdXr1NrOI9nQOwfmSE6Ypfbp3LbwI13PhQVu6RSskKDYGiHT+LrlUZuFvpd0xNL5fc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86gA6DKOUJrLmds84lbhz3rSXLXQJ11FIJCRC74sIhU=;
 b=H+MMJWS32UjSDOdj+9ewnr/hTSzfYAaZTE3NiRwiMobTSEff02ow0cCFY9+hUJy5NHo9Lru5flLq25fXGs62whkRQ4VqSCV4oS8kdBiKnOMf3v+TmZhh34FIfRxbkhBLBdh8n4+kG6HbCFhTbKbHlhNdpKcv/9wAi3NB0R+vK5Q=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 9 Oct
 2025 15:06:32 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:06:32 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: David Hildenbrand <david@redhat.com>
CC: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com"
	<trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Topic: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Index: AQHcOKaJslt4snb5vUaiZKYBU5CBjrS5agKAgACBPAA=
Date: Thu, 9 Oct 2025 15:06:32 +0000
Message-ID: <007F4FBA-CD09-4D72-A774-33E36335BE95@oracle.com>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
 <805DB7B5-23C2-437F-BB94-2188E310FD75@oracle.com>
 <8a65e8c1-3028-4f9c-bf1f-c8f1d3956192@redhat.com>
In-Reply-To: <8a65e8c1-3028-4f9c-bf1f-c8f1d3956192@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DS4PPFFE8543B68:EE_
x-ms-office365-filtering-correlation-id: 4867e9de-5d8c-4d6d-1495-08de07456ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFlUMDZNZGtlQ1NGRW81RHEvZ0ljZytubHBidzVnWVNhTTlKVmk4OTErQmpJ?=
 =?utf-8?B?WWdJMHVGWWZjVEwySWVZaXA5ZjdhYWRGZEFwNXFnUTdFRVRDK2h2WlhNSC9O?=
 =?utf-8?B?NGFrbmkvL09XSG1sbTNWNk1xMk1OeHZtUnRDRXVhUU82eEdLUUdVSVY3Q3pC?=
 =?utf-8?B?b2pnVUtsaUZSV1NCRDc3MzQ4RktmZmlGa0Y0QTNjbjErWjRLVDk4OEI1RGh2?=
 =?utf-8?B?d0QwR3MzMkx0S21mMkRzYXBEb0JScFVsTGxoQ2ZCREQwelgzRTJIU2hHbm9u?=
 =?utf-8?B?Z0VIeElkaXgwTExUVHdyNGFsVDNJOE1FOTVURXJIaUc0b0R4VVRvdG5WbER3?=
 =?utf-8?B?TWk1OGpHUTRZbEI5RFROcWl4ZFpxUEx1ajZVVi9UbjBRcllJZllWYTlBVDZ3?=
 =?utf-8?B?MkNPYzF5YlhtSXJnVXNzR1hDdDV6YUZmZjROTDZPV3VEOTFPNUVsTldQVGdt?=
 =?utf-8?B?V3djMTJXRVJPWnhCV01heEFjS0lObXNkTWVaSGoveldNRERTeEFzd3FPblJQ?=
 =?utf-8?B?cU96RG9pRHN0ZG9UZzArN0dTMmlTMDY1S045VStvem4xeWRvUnNRL2VXM2dS?=
 =?utf-8?B?RUtla2hnZ3dHUFdrZG9vemFCQXBMWldZeEJjS0RRdlRlR3gxUXZWR1FMZVJz?=
 =?utf-8?B?R1dBdWFYNGo0bUgvT3VBMnZtZGZxb2NLZXJpb1VOWkpkMlM2RStwV2kxVDZW?=
 =?utf-8?B?WXFYN1JDbHZnWmI0bXFxTHl6UTNCMFVKaEpSTG9kOUdMQ25MUisvKzN2aHBF?=
 =?utf-8?B?RlF3Q3MwZ3A4dFRQbmJkdnF1Q1ZsMHVHbDZjMHdpZTQvTlE1dWRXeHUvM3E4?=
 =?utf-8?B?YmVpSnVFMmNzc2xGY3A4R3FrWE83c0ZYM2Q5d0tjNnpMY1pSY1ZTdnNkVFdp?=
 =?utf-8?B?UzNNcUwweUkwTEJJOFA4RmZCWFFEdTVXa2Y0aDFvbnNBQWpNMlAzNVpwYU9R?=
 =?utf-8?B?bzhqOGdwSGdwWEh0bzg2ZlVxVnlsbEIzclV1RDVOUnN2K1piNWNpK2lMaTFj?=
 =?utf-8?B?R2JtVGVMK1Q0L3ZMemNhWU1BWDlpSzV2UE0xZkkra0ZBQ0hWdnk5U0VPcU9V?=
 =?utf-8?B?aWFyaUhhWThPSFNSOG9Jd3NMeEd3SE5KN2c3MUt4dGdlWkJrUFRNd2djZXBt?=
 =?utf-8?B?WGNGQ2hvVGEzYUZjc1Y4UjlCditPb3ZPcTVlQzFnS2syWHd2RXU1VVRIMEhz?=
 =?utf-8?B?YWpmSjVDWGIvWGZSMEhCZkorTnFsbHhVRloyZ2lNdVRNbStkdmNlMlRQMy9R?=
 =?utf-8?B?MXRtd283UVNnRG8zcG5rZVRsZXdrc2FoRkVMd0NXSUtHampnNDl4RUxDMWUy?=
 =?utf-8?B?QndjVlArVUgwSkNHTDVGa2hHSTBaNjFqOGxCenRFckhIaGpDNVgwM3dSWGVG?=
 =?utf-8?B?bThxVXJkdzhWRktSclF6Z3VJSFpic28yTkJWWm1zUUcvWnZmbVBIRFh5ak02?=
 =?utf-8?B?d3pmMzdzUnptdzdXVXdYZjU2RHgyd0FlekxYK0pmLzdyYmRBV0RGYWhPcCtv?=
 =?utf-8?B?U2g2Nkx3bERYYmg2bWZtNXd0dGI1OFNuZklOSTBwZXJ1YURzaThNYnVDZm5H?=
 =?utf-8?B?NnRyWVQ1S2pDM2ZOTWZBT1R1V0R0S0JLK0RsdUswQ25SWFpXdGZ0bUhTRG5B?=
 =?utf-8?B?NVNoRENjTDZRM1pHblJSa1VtTkZ1Z04vbHVwdkdPRzIwTjNYNUUxN1pybnd2?=
 =?utf-8?B?VjMyVStValpKdTcwRTRrUDFaQVV1Z2JHdlZiYytUb0l1OVQ3cTdDS09seWQ4?=
 =?utf-8?B?emxNa3R6UHptaFlqZGFOTUh6eUNYbkVWSVM1cjMxUTRaZS84RCtsNDJLZmgv?=
 =?utf-8?B?OUdtQWlqTXlVa3ZnWkcybm1IRHFmSnMxU3NhNE9mTk53Y05rMC9VcGp4MWFN?=
 =?utf-8?B?dk9xb2ZuVDEySll4eW5vbVltODdlZnlvRzdtS0c1cUgvY000MnNFR0dPRzNh?=
 =?utf-8?B?QjhlMEowNkRGOXJyZVpIUzdjanZPOVFjOVNSaGJwSzRaTTJFR0ZPMGF4b20w?=
 =?utf-8?B?bktVMXlrOWtkVXhMVDJobzJTT3c0WGxpQTBzS3ZWQmFWSVk3UTRveEtYWnZh?=
 =?utf-8?Q?9MBaH8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDVuRDNvOUNMRDJyUHV4bnpMZzZEUFRmQnZlNFBUQ3BkWlEyam5LUlBZcUVV?=
 =?utf-8?B?WEhMRHZVRkdtYllGaXYxQmgrOEJaY3kra0pPeFM2NUxIMUdFNmN3elFta2FR?=
 =?utf-8?B?aFBYMjJMQ2tQYS82MDRKRE9uMTcraFRNejZxdzcwQXJLcyt1RE1lcXF2NjNo?=
 =?utf-8?B?VzBHWmlFUVMzUTJxdllpeEdLOVVKYWFOMlRVMEUvbjdzdGo1Zlp6SmQrTWFH?=
 =?utf-8?B?MjlFRnV1Q09KRnJxdktEZVZVdzRYNkdlY1loc0l3NmJOUWxJSzdPYUtXeUky?=
 =?utf-8?B?Ukh3dVBtRjZiSDFkNml1Y3hZLzRQNDJqYzFaY1hNVUVkSHBKTEZMQVJqbDBM?=
 =?utf-8?B?ekRHK09BNG1FeEhNK2NKTkdDdGN5UjBHcHBCaU81cXRYd2tkbEg1L2hvT29a?=
 =?utf-8?B?bEdXRzRxL2dPbzJmaWJZVW9iU2t6K3RkcDVENXJJSUxpRDVUOGJMdmxtcTBj?=
 =?utf-8?B?ZlBGME1YRFh5Qi94Rll5ZjNFbFRDTGdpVURDbkphZk1BekFpRlE5YVFlMnpE?=
 =?utf-8?B?ZzRqbHYxRGZ1UVZXeENMZ2Y2RjlRV1l3b3ZKZFc3TittRjBFWnUwcGRaZlRL?=
 =?utf-8?B?WDZoOXFTTUJzeGJqK3lRTGYvSFp5dm9xM01vWEFPUC9ndnZ3K0QwS0o2SHpi?=
 =?utf-8?B?dk92cDJXVVJJN25XdzJwRk1WdG9hQXhEMVBEbFpvVG5Mak16b0JRMXcxNnN2?=
 =?utf-8?B?NXNOaVFUMlFIWW5YM3JNYlcxckNDalRyQW9MWmZ6MGVQLzVoZkZuU3hsUElO?=
 =?utf-8?B?b0psUmgzS3IyRnB3V3RxM3ZSTW0xc0lPZVJwa09mSkV6aVoxNjUwQUhxcEFa?=
 =?utf-8?B?Z3FCQm9ocjBsRGNPbUxGVXVTcHZpdU9JWVdGMmYvYkIySzZ0QW94bjJDNUJp?=
 =?utf-8?B?bWRDSkZEZDZiZkZKUkZyZnhKajZpc1RXL3NscDh1WE9XQTBLQ2FGSDQraHFS?=
 =?utf-8?B?VG93REZWQVdSTnBPWm5PdjcwS2dhamZBNGh1Q3poT2pkUG1jYmJIT1htVkZa?=
 =?utf-8?B?UlV4MXZVVzZxRDJ5QTQ1N3RWYTIySlRKSEpNdTBGUWJwWTY0SkZteXYvRHQ3?=
 =?utf-8?B?alRGVmd5ZWk1dHdjOENqR3RZOXc4V3RxamhiMEJLUTFrS0FmVFY5dk53VUJa?=
 =?utf-8?B?SDl4S2lhUUtZZnF6ODMxU1FycEtOeWJSRmdjQndiL0NGTHJ0RTJKM1I1d2F6?=
 =?utf-8?B?T21Ma3YwOTc4SWdtQ3k2eGRJRGhaZnFwTEpzRjlpT0JPTk40bHE1OGVCaVRV?=
 =?utf-8?B?ZGgvd1F2NDNJNlYwSXk2MHQrbXRJb1lYRkIrZEFoQVljTnNtWEJ6RFNiNFRL?=
 =?utf-8?B?d05EeVZZdllDTXBncFhOTkQ4ZVZZaFJML1BkUmxqUkcyUE44Y3ZOTm5vNkJ6?=
 =?utf-8?B?VHpielQxNWR2TTJBbjhpc1AvVFAyQk9pTWd1MFJwNXNJSUlkTG05NVBzVk12?=
 =?utf-8?B?VWJzS3h5NFVOQnduMGxSSDQ3NjFsdXhsVTI0aUxDVWxDMGF3N2VTR0JobGZz?=
 =?utf-8?B?RTlmMzdzWlpRb2g0Q3l5bVBQS3JOUFV2Vi9ndERyV1ltTlBXaW9rMnBIN0pZ?=
 =?utf-8?B?VUdnOWhEcUREMWJEM1RoQWNuemVxRFl1V3FpbnJHa05WMDhQZFBqemd0cXFW?=
 =?utf-8?B?UjArbGIwRGxqRmM1UE5QYVN1cE9OUXFQeWdxamo1d1RzVVdlRWo5UGJ2LzJZ?=
 =?utf-8?B?b3YyOWlVbllDa21Fd2MwZm9UWEZlcStYa3FUb2ZzNFNjK0xhbzBTRlVub3Q1?=
 =?utf-8?B?K3NLalEvTWFaR0puOFVJdmxZWW1LTktEbGRORkl6dGNJR3lkeU55WUhyQmRt?=
 =?utf-8?B?ZDJUa0FURExYUGhTeEZVVlVKWlBwMnZuVmlkRlZwcGZ5dkJTL09OTnhmblg2?=
 =?utf-8?B?a3pKSmxUa2t5Nmh6d2lDWHRHdUJpd1JOQmxFZ1NZSUExdFVTMis3MmdQMDhF?=
 =?utf-8?B?ZmR2TjlvV3JvQTVUMXVtS2JKcXRxVWtUUnBITlJsQkk3TERjbmhobUpmWndI?=
 =?utf-8?B?K1dzSUNpS2VmL2xiN1FUU2V0WTFTeFI5ekFXbSs0TDJxWWRBL3V5VFMxOU10?=
 =?utf-8?B?YUE2dDBvTGx3RmJwNEUvUTBvN2t1aHV0SzhETXNITy9WQ2ZBd24reFJuWVhy?=
 =?utf-8?B?aG9sSVRmYVZFemtFbVNLUUVEbXc1c2F2bW9wOVdwemZjNkdXZUIrQjBXYTNm?=
 =?utf-8?Q?w+jGQQNF9oiUmng40xq2PLA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <594B502737A9894C98F606C96F5CF771@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aZtLxjwnlGLXJMRW8oi1OB/u27/jAkatfDaGLeJs4kY/VUJ4TatEo3gCfvY6082+MxQ3KlDc+5G6UvzTOR7qZLfTO3Ie0VVctBpjDmxxCh1PEBm/BXJfycMvp7uLuXqp8aS8vAsVZyFiHrnFv3LMEHFXRoV1XO9wMuhwTma62HvbOfV4YrLcV10tKvLbYPowIU2ts8r7hM8sAQ7KpE+HIOnYT3KQKPTBp83G4gP4btIWsdvh3ya4X2mQ4CyN3ymqVokkIaPSjIQr/0M9owAFJRB5zPAgxKtutXbA3x28rjA8vaGsqu1dRjQU5rwrwVM4hXQ04EowMLOTasgIHktCyiu6tHW8jJWvltXTvehULsS78ZFVk2pm4J2N5T699GzAc6yY9ZmXKlCdxLZ67mio3KU6R+lo2rsBL8CKP5lV4WqB06VODM5phh/1MHhnLktaRI69U6kwNtjYj5xqmeoT0KwMvWVxlbDArvlJENjICtGneyPERP0jRSFdBnXFaRskjY4+WREgOs6EY7nVMakjaEkWOaEp+PTRaOp4mQw6CKHC7/hEfnrDYpi+/81fH6yDTbYTe3pVF/2VRvbMzFlN8o+pWNbowafFDHdyFa74EgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4867e9de-5d8c-4d6d-1495-08de07456ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 15:06:32.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHM2kZpr+x24FNcxdo7dIQx2mzp618xgqkJ7/X6F4CqW4H+UeAg2RsAbY17EDbAwdTxxex+UM350BP+OqDKAY1xaR69pBWM8deHP7LhzLME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=461 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090091
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e7cf85 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=jY-1FvfwhYTFZjVDRPkA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ftPnj14aWtjDwzsR-s0mk7_p-Ep3uZRG
X-Proofpoint-GUID: ftPnj14aWtjDwzsR-s0mk7_p-Ep3uZRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyIH/8oB+ZDhs
 FSRk0NBDf2ZNTrzJXLwSISzGhKcCVub/XQ/8quxuTwDBtBh0GIZ5WIZNZOSt7bQCAAb5GGNgiJq
 i20qVjaoW3y8y+8RAQCn3C6GGpGeiVa1a6Z63apo+c1fiRXySRXXIaU+/RpQFRF0jhu9Of0Xcy0
 4ERcmKiSNu/2jwzvKi7/JJrNd4YyUfyp6zWILwn49IYK3bHqSZJfs/cj2QH7Lm9YYxq/JP5W8d6
 XVgzcbRoxf5dZQMj9wYSSoiIpRkhe0w4OBWEEuTaVi042P9DCyKk+dGRdC1qrsEEniPXN2zwUn1
 3p34jBEylCVQ/Vz55AS2wj7vNreB+QDqVc/w0OOGjQ3i5ojm+uEpAKoxTddVGWHlp4WAC0KSoXD
 7hD93jz+nWWUrsoiQY037U34RxXqcQ==

DQoNCj4gT24gT2N0IDksIDIwMjUsIGF0IDEyOjIz4oCvQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDA5LjEwLjI1IDAwOjU0LCBQcmFrYXNo
IFNhbmdhcHBhIHdyb3RlOg0KPj4+IE9uIFNlcCAxLCAyMDI1LCBhdCA0OjI24oCvQU0sIERhdmlk
IEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAwMS4w
OS4yNSAxMjo1OCwgSmFubiBIb3JuIHdyb3RlOg0KPj4+PiBIaSENCj4+Pj4gT24gRnJpLCBBdWcg
MjksIDIwMjUgYXQgNDozMOKAr1BNIFVzY2hha293LCBTdGFuaXNsYXYgPHN1c2NoYWtvQGFtYXpv
bi5kZT4gd3JvdGU6DQo+Pj4+PiBXZSBoYXZlIG9ic2VydmVkIGEgaHVnZSBsYXRlbmN5IGluY3Jl
YXNlIHVzaW5nIGBmb3JrKClgIGFmdGVyIGluZ2VzdGluZyB0aGUgQ1ZFLTIwMjUtMzgwODUgZml4
IHdoaWNoIGxlYWRzIHRvIHRoZSBjb21taXQgYDEwMTNhZjRmNTg1ZjogbW0vaHVnZXRsYjogZml4
IGh1Z2VfcG1kX3Vuc2hhcmUoKSB2cyBHVVAtZmFzdCByYWNlYC4gT24gbGFyZ2UgbWFjaGluZXMg
d2l0aCAxLjVUQiBvZiBtZW1vcnkgd2l0aCAxOTYgY29yZXMsIHdlIGlkZW50aWZpZWQgbW1hcHBp
bmcgb2YgMS4yVEIgb2Ygc2hhcmVkIG1lbW9yeSBhbmQgZm9ya2luZyBpdHNlbGYgZG96ZW5zIG9y
IGh1bmRyZWRzIG9mIHRpbWVzIHdlIHNlZSBhIGluY3JlYXNlIG9mIGV4ZWN1dGlvbiB0aW1lcyBv
ZiBhIGZhY3RvciBvZiA0LiBUaGUgcmVwcm9kdWNlciBpcyBhdCB0aGUgZW5kIG9mIHRoZSBlbWFp
bC4NCj4+Pj4gWWVhaCwgZXZlcnkgMUcgdmlydHVhbCBhZGRyZXNzIHJhbmdlIHlvdSB1bnNoYXJl
IG9uIHVubWFwIHdpbGwgZG8gYW4NCj4+Pj4gZXh0cmEgc3luY2hyb25vdXMgSVBJIGJyb2FkY2Fz
dCB0byBhbGwgQ1BVIGNvcmVzLCBzbyBpdCdzIG5vdCB2ZXJ5DQo+Pj4+IHN1cnByaXNpbmcgdGhh
dCBkb2luZyB0aGlzIHdvdWxkIGJlIGEgYml0IHNsb3cgb24gYSBtYWNoaW5lIHdpdGggMTk2DQo+
Pj4+IGNvcmVzLg0KPj4+IA0KPj4+IFdoYXQgaXMgdGhlIHVzZSBjYXNlIGZvciB0aGlzIGV4dHJl
bWUgdXNhZ2Ugb2YgZm9yaygpIGluIHRoYXQgY29udGV4dD8gSXMgaXQganVzdCBzb21ldGhpbmcg
cGVvcGxlIG5vdGljZWQgYW5kIGl0J3Mgc3Vib3B0aW1hbCwgb3IgaXMgdGhpcyBhIHJlYWwgcHJv
YmxlbSBmb3Igc29tZSB1c2UgY2FzZXM/DQo+PiBPdXIgREIgdGVhbSBpcyByZXBvcnRpbmcgcGVy
Zm9ybWFuY2UgaXNzdWVzIGR1ZSB0byB0aGlzIGNoYW5nZS4gV2hpbGUgcnVubmluZyBUUENDLCAg
RGF0YWJhc2UNCj4+IHRpbWVvdXRzICYgc2h1dHMgZG93bihjcmFzaGVzKS4gVGhpcyBpcyBzZWVu
IHdoZW4gdGhlcmUgYXJlIGEgbGFyZ2UgbnVtYmVyIG9mDQo+PiBwcm9jZXNzZXModGhvdXNhbmRz
KSBpbnZvbHZlZC4gSXQgaXMgbm90IHNvIHByb21pbmVudCB3aGVuIHRoZXJlIGFyZSBsZXNzZXIg
bnVtYmVyIG9mDQo+PiBwcm9jZXNzZXMuDQo+PiBCYWNraW5nIG91dCB0aGlzIGNoYW5nZSBhZGRy
ZXNzZXMgdGhlIHByb2JsZW0uDQo+IA0KPiBJIHN1c3BlY3QgdGhlIHRpbWVvdXRzIGFyZSBkdWUg
dG8gZm9yaygpIHRha2luZyBsb25nZXIsIGFuZCB0aGVyZSBpcyBubyBrZXJuZWwgY3Jhc2ggZXRj
LCByaWdodD8NCg0KVGhhdCBpcyBjb3JyZWN0LCB0aGVyZSBpcyBubyBrZXJuZWwgY3Jhc2guDQot
UHJha2FzaA0KDQo+IA0KPiAtLSANCj4gQ2hlZXJzDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoN
Cg0K

