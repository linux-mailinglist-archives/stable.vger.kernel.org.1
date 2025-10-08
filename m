Return-Path: <stable+bounces-183641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF65BC6D2E
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 00:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A94D4046E4
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10052265281;
	Wed,  8 Oct 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7miMbmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="swZTuCCh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3B84039
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964172; cv=fail; b=noPBWQg7WLPM5LP5ZZU6m/mtCgibJfWU3YQIgZXRDMHkNjD0QFsCTLwGbfnO+whyDyYsSDQYihrDZwHo6Q6HAUosnviZGsP7z5IMJ61Fp373oT9Eguq306ie2Mhny+sE3fbAXRDrKHa291tE2JpE75xV9RYVE7sZJz6OdxFyiEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964172; c=relaxed/simple;
	bh=l7XgiFiIEqijmSPQGy215HZ1qpJ2pmnaMv/MJXdIxu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEddzlpvsMBNRc6IuGOJPjCxAGHwjBOQ63/G7FtOdckH1k6KOg6ElrezCYnSF/V1LuZk6Ikhy+tMQWh4g7kqZnlsxQ3qrmGzZV35cMMFM0xbJzbaAL3eahP+FGdAyJP2PGRL45MP6HA92cKDc/OaTyOsS4twVg3wcn/udzRbsHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7miMbmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=swZTuCCh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598Ku8ii001504;
	Wed, 8 Oct 2025 22:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l7XgiFiIEqijmSPQGy215HZ1qpJ2pmnaMv/MJXdIxu0=; b=
	L7miMbmz/x+Wcb0I0HMxFcywgFyJes1tUu1lzc8Lp3ISlwx2MH+FEmXSg/0seU7v
	ofVmy7pnajH/FZBAmsLog6nEfJTvPLlVU0udsvmkqSVEBik3x+K+89b6jC+ftkZG
	cFpar/BFffJYKDRJnda0Tn1wetdK14Z6vWQMUhZrwRzPl6v8Wn457Yn9Op648+7y
	jPAcsXCbTrkJAjAu2JW2/hpPdxMexoBuELxglChUJypHij7YH76FxwASKjkCOb56
	RzGTut+il9GZGkxodei8s3eYZcCo+q6hdFmGhOzk9/eTDSCEOjBeM9fg4yf5upQP
	AnXqwkoajIYEBX7Z9AJsHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8prgcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 22:55:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598LiDlq037001;
	Wed, 8 Oct 2025 22:55:49 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv632ntb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 22:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSSuT+wC168y0bBCwX3FP36VvnDR7ss09Vo0jgbuOiJb9cFrF/+2iFF+SDk8yZQXD8SeMGA0XufqOwuIJWQf9ZFXymTiksBSXZLJcf0i7kGqKgo2f0lljkmddySEX1IU+0xzvyKA039akhZENfQo5PW0CqpoqmLSEcGnI5fWiqHS+ojdcXyrku84qDbTT8IJMhHTLiSoWlYPkLi/Ld9g1fZClfjnS+1cMfnaLwK8SWWxqkT0z4reyUIapH38eOZhPpW1DT5DsEKDAh4eUBaxRS+Eo44tYj3aADO26Y3ctBc7nOCmpYIhjP20IlmnUuHoZtF73NLJ/xd5ACRtt04I6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7XgiFiIEqijmSPQGy215HZ1qpJ2pmnaMv/MJXdIxu0=;
 b=QiUYExW+OKTvmVVE/znzHyTigEo/cOom/WX8D+2dflEHuE/4Xg3RkJHpm9GiXGKnP1YTtBxDjJtDiXMu74Hgc+lHceTOisYWCcAf7yxGIP++D5itDjz8ode5O5iJDRMz7xO+wUbPWGBwA0Y+Ga5MNn77RR0PJjMWXy1TvJZzB+cb/Ro/WHsjYNKooRNJbByXxpIwkR+EB/fui5jRDpCskpKgDQX5dqaop/AMfZSAuGLHc8GSf8SP9awUcYc/qIDRrOrIMz9kzJmjWZYcOKbCfsYVexZnP9gkSb3kFSnjTH3ZcTDlymre+/Yw8JZhBoSRwNpDGKMC3K3b0j/efTXucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7XgiFiIEqijmSPQGy215HZ1qpJ2pmnaMv/MJXdIxu0=;
 b=swZTuCCh6Q/boPpROvaqJlVshRnA2F+y9TMWDAMsp0/SzADjxYswod9hb/7tKYSa+V3tedqUR2AYXQr9xaUxd6rGy2+HHCShH2fg0rtQq9BFIkL2n0miAANKdUC/xMUprzd4ZzE7I7GqGUSzyNssZTAxOlJIOuQow92OZ2hzroY=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 22:54:55 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 22:54:55 +0000
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
Thread-Index: AQHcOKaJslt4snb5vUaiZKYBU5CBjg==
Date: Wed, 8 Oct 2025 22:54:54 +0000
Message-ID: <805DB7B5-23C2-437F-BB94-2188E310FD75@oracle.com>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
In-Reply-To: <2dcf12d0-e29c-4c9b-aeac-a0b803d2c2fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|LV8PR10MB7989:EE_
x-ms-office365-filtering-correlation-id: 9e644a1f-9f06-4e0f-d894-08de06bdb2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WG1jcUlqeXNIR1ZsOXk0Vks2ZHhjcmt4SThTVmxtcTFHc090N0I2R05RQ0l4?=
 =?utf-8?B?dFBONHYzWmE4Q1V1Rm5pUmdnN2prU2xjb1BjdXp2VVJuU1Q5YVNRY1g4N0w3?=
 =?utf-8?B?OFVzUHZ5VHJXMmNMQnNoNmxWQ0p4LzZmdC9IMGh0eERodmFtTCt2OFdZMjI1?=
 =?utf-8?B?NzBITFQvRHpRcnQ3TkJBZmNiUkNsdXIyOWV5VE9PaXRMTFpVRXY4QUExaEZm?=
 =?utf-8?B?OHZTalFWcmZxVmwxNnFaNW52VHY3VjNSMjNnU0JJbXJvVDlzamtBODQ2Rkd0?=
 =?utf-8?B?NGhOU3hkSU9mUUJXckt5cFpBenJDdGpGOWJiUEdvTXFiWGIvVllQSXJZY3V2?=
 =?utf-8?B?WHRMVjNHTkx1OWVpTjFETUsrdG1SQzNVa29LdC80MWRHQ0tMcW15SU4wbExL?=
 =?utf-8?B?RVRxUG5UUTVpT2N0M0VrS1B1STBZL2lTYzhaZjN5c01WOEVycnV3Rm9NUHpr?=
 =?utf-8?B?eW5XLyt4YVYyYjRqbkNvRzJOU3V3ang4alFWTkJPSEdnZEY3RURGYkdQbDUx?=
 =?utf-8?B?aFozbnNhSnIrMmFDdm4zWjVyakR1V293TjNXdVlqdzVkdlpYd1Vsc2pHZGdB?=
 =?utf-8?B?Snc2RTk3U3ptZ2VNM0ZydDNxcmRQU0lvSGphazU0WWxQK0prVUpjam1LcS9o?=
 =?utf-8?B?ZXJYYmhHcTIrQVVwNzIwYjNvamFXYW02SktBK25JUVgwS2VnTlNkbUlXa1Ev?=
 =?utf-8?B?VFBoUGNVRWVxOUFjT2k2aVNjMlVsbnBxWjhnSUxJM2tyUjVmVjZ2U0IrTFF0?=
 =?utf-8?B?bERIalFoTWtQSDNOSHVOVnNtWE9HaWFJbzUxRGVud3g4WTRxWDMwVXZDQWNW?=
 =?utf-8?B?Q2tkKzl4VksrSHhLVHZ2bzNibVJMVHNtRUhxRUVzbUwxNWU1R29TdWpSRFpz?=
 =?utf-8?B?N0lXVHlEMzEveE1KVng1UW54MWJ5c3d2bDdwNEtSL2FrZGViaTJ0NU5RbTNm?=
 =?utf-8?B?RlExSHFtN3hkMTVJZE9QSXM5WDhPNk5FTGd2NVg4eDhOdCtXNVdOZUNsbzdL?=
 =?utf-8?B?UkRYTTUwbVFwSEoxYkFaWXl0RmRiWi9KYTZtaUVCN3g5WnB4ME1QQnlXR2dN?=
 =?utf-8?B?Tm03akNBTkJqU3N2UmNMa1BabnJ4eDFoN25zeXNmcVNtb2hYS0pMZHlyZXdC?=
 =?utf-8?B?b2JISnZUcE1DNk40NUUxTEt2ZjROVWpwSElBdjN2VHNTTUJiUkI4WUJBdDJh?=
 =?utf-8?B?c3RtdVlmaXJmSER1NVRtbGFuWjZseCsvOEdBb0J5RmxZSXgvTGVxMHpCVmRv?=
 =?utf-8?B?TDBqNGZjekl0UUdBR1pCYmtUOFpocWcxNHBqS1VudGtlWGNvakNhcWtVL0Y1?=
 =?utf-8?B?SlQyNDFaZEVMeFhtVEQ2THY0UlhTL1VXMmg1cjFjeDhCdDBqSDFaM1FtaEVz?=
 =?utf-8?B?czBkNkZnWHA0Sk5FMmEwa1N6bGQ3MUhqemgwRTA0Q0dXM0l1d2ZlQjduekwr?=
 =?utf-8?B?QUxTb2RNZDU1eVVzSElENVBwUUNQd016Y3NhNG82eHg0VnNlY1Y0dG1LT0xK?=
 =?utf-8?B?eDB4Sm1GNTRTRHIwVTBNUkc5b1R2VHdTc1l2UTZSTEg4MVBZYUtnV2NpaHpN?=
 =?utf-8?B?TnhLYWdGeU8vcDlFZWR1N1phRjVkNi9Jc3RmYnNjK05kSVdXelBnbUFsYzhv?=
 =?utf-8?B?Zm1QREtzUWtmVGU5SDRhWUtFMVN0UHcyOXUrUjlYdFQvMGF1OFBzOGhlOG51?=
 =?utf-8?B?NFExY2JlYm45ejlQcG1zS0ducmFuWFo3OGVrQ3E3QjFuOWdxMWhRc0RtVDBL?=
 =?utf-8?B?eUs4UU1abG1heVFOaFRmZXpieE83YW9QTHgwOXEwcE9LUlVVanY0TllxRmYy?=
 =?utf-8?B?aFlLU3g2YThlcDVseVJkRnpVbCtrWE11RkxNZU5BYUJpRkRlWEU2UFIvaUNH?=
 =?utf-8?B?M0tGSEQrOUI4TjlCdkFSWHZRV2V2QlMxczRUYnAveVJnWllrMW9VMndMWTdM?=
 =?utf-8?B?RHJtUnhoZ3pxa3M4UzZLMkhuUWM4WjNYVkJTNVA3MDNtTGtTRGVnZzdNbEU3?=
 =?utf-8?B?QmtOcXlyMGp2YjQySlZ1bWc0dFluaEFoVmVhTUlUT1UwK3V6Y1diYnNDdDdM?=
 =?utf-8?Q?6JPg7c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEVOcGtGbTJPUGpGbXRrT0R6N2JCbFFQemFvcEhER3hBWUVINXQxRnpzaDJZ?=
 =?utf-8?B?ZVpibDdZSkRpZ0tSQVJHR3BuaWc1YWQzTkQ3dERvYTl6bmRXTTIrbUV3dGky?=
 =?utf-8?B?L3VQMG9sQ0lRSDNvZWxoNElBSE56cHgyN3lGbi9CVElxdjVyaGpod1RyMXJY?=
 =?utf-8?B?a3NMcTBHemdVckF2WGlBM2dNc21oa3NYNy9ORWZBK3ByU0NtdUlLS3dReHNl?=
 =?utf-8?B?TUJtUXB0cUlQYm5NK2pUV3JRUGxqZ1l1dlNwZ1NkYlNUU0w1SHU2ODBiVTd1?=
 =?utf-8?B?Q0d5RzYwZnhoU2pHc0lWRVFFNzVmSmNlRnNWRStFTnhmUWQ1bFp5QlNxTG45?=
 =?utf-8?B?czNnVmVHQ0JiMDI3L04xc0ZQME93K2dIcVhPdnM2d3NxdE5TTkErbHZLOWJB?=
 =?utf-8?B?U1VjRUs4OElqaDJ4YUxqR0VrY0FncDNXSXZNaVNxdy9RWHB0dlRkb1YxQW05?=
 =?utf-8?B?UHFGa1NQekJaYXRBTXZGNTZSek03bnh3VzVyV3I4Rm5keUFCUGxSOFZlNmM5?=
 =?utf-8?B?U1MvbThNTEJzaTdSTk9PVjFYVVhNb1k0M3EySWVsKzE5ZjYvdHE4czZxVWFN?=
 =?utf-8?B?N1hqMlM3RFZvb013YWh5WW01SkowUTlqV3VjN2hyOVVZc1l1OElBYkNIVUpT?=
 =?utf-8?B?b2RGaHZQV2hmT2pIeDB4K3lzMDNDcVhkQXV1dUF0dzJCOU1BdGltOHBwV0Rz?=
 =?utf-8?B?MlJOamxpT1JHM1kzbURFd052ZDVjTkRqdG5FakxmU3lKVktTSHI3VUdSYlJh?=
 =?utf-8?B?dzd6WWJzekNOS1RJejJzRjhCczZZcjROWXhQL2MwL2xFdm1JQ2xFNzg1OVQ3?=
 =?utf-8?B?OElRYStka3hVQ0hsS25YY01naWgxYnFLRnFGWmh3aklwL1pDY1lQaFdmdjgv?=
 =?utf-8?B?Z1pPOXlNYTFpQWxvaWsxK3drR2RHQlliZHV0b1BJNHBlbmhtaXFJTmh6MStM?=
 =?utf-8?B?Sk5wQmZHd1VBVEgwZkk1L3RqNktPeUhnMjdYY1RCaG85U2xadklWUXYvakFO?=
 =?utf-8?B?VFcvdXE5OW5kb1QwUDAyZFlJQVBNK0VIVW1WSzl6eTlvZjFVaHlPdUpiY2hJ?=
 =?utf-8?B?MDR5cWlnSi9zYzFpem9mMU1FZ2Mwa0tPRGpXTzVjV2FiVXhRL1AvRHdWS2ov?=
 =?utf-8?B?SFp6NW5oQ3JhK2ZnUEdrZUdnWW1YTHFzUW45VEl5WWFwWUZhdmJpeWNXdndB?=
 =?utf-8?B?dFZ4Ymx6ZlJ6NFZUTGd3UU1wUUxRZ0YvTkxRZkVLdVJjcDdkMjRYbExhbVN6?=
 =?utf-8?B?NjNBN2ZBZVpGU3E4aVk5dUlKZ2wrS3VlQTRjNC9UaFVQN3U1ejRUbHd5eHZU?=
 =?utf-8?B?Q1RGN3l4QXYxMldJT0czN0JKWU5oQXRWeFhOT2wzZ3ZNc3ozQW1kTVRlbjBy?=
 =?utf-8?B?LzBWSkpHTUZjRGVxZDhqdURoSGlRR2JUeHNWcmhoZDRwWXBMd1V4cnBLSDBi?=
 =?utf-8?B?Y0luS0RoSk9IQjdDS0xLSXE5NnR4L0FDcUovMlJkdTVKTnZkZHA2TFZUd0g4?=
 =?utf-8?B?ajJHZmErWVplV09nTFdoYytnc01LT3RpVEZlRGI5cmllT2ROOVlsalhzcFVF?=
 =?utf-8?B?MWxSdk9VV1VBN0lNellVS0dwRDhqMnBTY1NXMlBtcWRCRUNpNXZDK2cvd1JH?=
 =?utf-8?B?WWgyMjRPcDE4S1gza1ZYN0hwN0h5OWNPOWdOeHNjLzJvOEgra29mLzY3SVB5?=
 =?utf-8?B?RUo2WWxFcW9keDExR3o2YkRlYjFiQmxUSDZDaXUyRjJScW9Qc1ZnMmordkZv?=
 =?utf-8?B?N29IWjhKOXA2QjdUZS8zUER6Z3NYZ2VjdS96UVlZRStjeDNIYUZub2ZVYU9N?=
 =?utf-8?B?THRoREp1WFpHU1ZxS1R6MWRtV2oxaEtVR3IybkJmaHBZSXkxcHJZajdRdmJx?=
 =?utf-8?B?ZVhEdUo4QlErSmtOeEQ2dEgxRVJ6YUFMMFhIdWhwdEtBS1RBVDFoR093Ykpx?=
 =?utf-8?B?dEhrSXR2bFYxS0dIdXJyTmh0enBzSkhPbmpCVVUxbWluV1M2Qk9Hd0lKRFNm?=
 =?utf-8?B?UFE2TW5EdXVqQzRZZDdsNm83Wk9IbDFUYklPeW56dXRoLzRtTVV4NDByckFX?=
 =?utf-8?B?Yzc4Q0FsOHdNbFYyZSt2dU1IQzgyYkNQV01VTE9BOG1YTzFXeFhjR1B2cDlB?=
 =?utf-8?B?bVh6UVFWNW1aQ0RaRXZvZUJkVUJYb2N1RTBEWDdyTmFwSHY2VGhjTGV3NDZC?=
 =?utf-8?Q?lW4TRZwGajlbhIG4fuPCG60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D86E6ACEAC05A488DD5013C48940D24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2KGPkNnqpFuYX7QGEpUP2DJdinFMOhWT23CuiE0GcbUCqPw8wq/hRNQ3+xVHeheoMjpNcfoU4AwG1T39oMiGFeVJUMM2FPU232F+4chiQ4FLLwXq5cQJ3UzNJO3Ta2Ry+GTDoj0bQmlamg6IAuVjr7tn0qzSpSQWp43XlXtFNYmr0P5jULKPOeR3Ht6g7wHOMs1v0493wgHiEb7fpChD2Bl+fOgqvLkNhhxseQHrd0Yh10dGWYHWOKMWhER9hPpE1XaBHwF9Q0WvP28UhRFR0c1b1hZwTQ/oXEp5lF3BRLbzdag4qcIZqlTf3N1vOp/HHaUaVjb5vI9VpouTzOhJWr2+ExeQDgpcghc//e/y12BEwF/0HGijConUfjXvpOtJzrbXJexLU+cE0iYcKwNvpX1+Fu5MOyZbvF0eWfr9RT/ajckkMKPiijbthZOhHD8qI/r40IKbHFsRYOvqHzrqv8XJah+vLU24BV+P+wXHSQe9Q8F1KhCTdPFf0SXuqYF0M/8DqwJXpyw6i93aX0H+ueV+/iN2ziOR3LffWqVGsi2vyyOEVl8KNKqsd4t8NG6/kDfRABZZjBAK6F/NpJEgf0D0HQ8oDy4Y9meaZQHGLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e644a1f-9f06-4e0f-d894-08de06bdb2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 22:54:54.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAcgs2E3k21swHt1IW7NZ6+Jjz3Yr9d5qBmmfPTqA7NXFt1z7INEK2runmvPPmCYN+Q8riXnc/+uQcCRbL1YzPTGYBNwNR3cvSz9N2/csns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=541
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080161
X-Proofpoint-GUID: xC9-GcavW7crlo903NLKlEvH3pQIkmCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX1U9SfKwuB7CP
 0ZkuKJGb2IgHigz2eBNaBrBE0ncglSoH9HwFKLTD4/VIyzw6ioc0RCw8dA3Xg38VYtFTgY0hYv4
 PJK4cdXYuaki9+tL6map5dFsENEo180HXtpvAwILjrUHLPbMa/fWNW3STPu+Bpn9FxYrUQETEa6
 XBjkzRss+CQQQR0NY7Lvb3VaYSGPtIPcZS52HPmTeZxyAxzB42qzxr/jdYKgQnYM3LC0EzLl3Bp
 ESHYQrqaOClaghpNM2AySDuSI80bwJMUmrCG9+PrN2N4GICU0rzsUm5iHkZPjmD+orUbQg1hIDi
 bZe+gpIutrD138Rd9NhlfVOerKbhbqHJM2mEf60RkLN5fsWkGckPzZf6qOlu4fDnRP8TQx6RLrr
 6Sczs1TFCvYE5igUxvFJsUO7xw3krqcaGddSoO+irE1DrrZLfEA=
X-Proofpoint-ORIG-GUID: xC9-GcavW7crlo903NLKlEvH3pQIkmCV
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e6ebf6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=Zb0ZAW6MIa2yiHuasHEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624

DQoNCj4gT24gU2VwIDEsIDIwMjUsIGF0IDQ6MjbigK9BTSwgRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMDEuMDkuMjUgMTI6NTgsIEphbm4gSG9y
biB3cm90ZToNCj4+IEhpIQ0KPj4gT24gRnJpLCBBdWcgMjksIDIwMjUgYXQgNDozMOKAr1BNIFVz
Y2hha293LCBTdGFuaXNsYXYgPHN1c2NoYWtvQGFtYXpvbi5kZT4gd3JvdGU6DQo+Pj4gV2UgaGF2
ZSBvYnNlcnZlZCBhIGh1Z2UgbGF0ZW5jeSBpbmNyZWFzZSB1c2luZyBgZm9yaygpYCBhZnRlciBp
bmdlc3RpbmcgdGhlIENWRS0yMDI1LTM4MDg1IGZpeCB3aGljaCBsZWFkcyB0byB0aGUgY29tbWl0
IGAxMDEzYWY0ZjU4NWY6IG1tL2h1Z2V0bGI6IGZpeCBodWdlX3BtZF91bnNoYXJlKCkgdnMgR1VQ
LWZhc3QgcmFjZWAuIE9uIGxhcmdlIG1hY2hpbmVzIHdpdGggMS41VEIgb2YgbWVtb3J5IHdpdGgg
MTk2IGNvcmVzLCB3ZSBpZGVudGlmaWVkIG1tYXBwaW5nIG9mIDEuMlRCIG9mIHNoYXJlZCBtZW1v
cnkgYW5kIGZvcmtpbmcgaXRzZWxmIGRvemVucyBvciBodW5kcmVkcyBvZiB0aW1lcyB3ZSBzZWUg
YSBpbmNyZWFzZSBvZiBleGVjdXRpb24gdGltZXMgb2YgYSBmYWN0b3Igb2YgNC4gVGhlIHJlcHJv
ZHVjZXIgaXMgYXQgdGhlIGVuZCBvZiB0aGUgZW1haWwuDQo+PiBZZWFoLCBldmVyeSAxRyB2aXJ0
dWFsIGFkZHJlc3MgcmFuZ2UgeW91IHVuc2hhcmUgb24gdW5tYXAgd2lsbCBkbyBhbg0KPj4gZXh0
cmEgc3luY2hyb25vdXMgSVBJIGJyb2FkY2FzdCB0byBhbGwgQ1BVIGNvcmVzLCBzbyBpdCdzIG5v
dCB2ZXJ5DQo+PiBzdXJwcmlzaW5nIHRoYXQgZG9pbmcgdGhpcyB3b3VsZCBiZSBhIGJpdCBzbG93
IG9uIGEgbWFjaGluZSB3aXRoIDE5Ng0KPj4gY29yZXMuDQo+IA0KPiBXaGF0IGlzIHRoZSB1c2Ug
Y2FzZSBmb3IgdGhpcyBleHRyZW1lIHVzYWdlIG9mIGZvcmsoKSBpbiB0aGF0IGNvbnRleHQ/IElz
IGl0IGp1c3Qgc29tZXRoaW5nIHBlb3BsZSBub3RpY2VkIGFuZCBpdCdzIHN1Ym9wdGltYWwsIG9y
IGlzIHRoaXMgYSByZWFsIHByb2JsZW0gZm9yIHNvbWUgdXNlIGNhc2VzPw0KDQpPdXIgREIgdGVh
bSBpcyByZXBvcnRpbmcgcGVyZm9ybWFuY2UgaXNzdWVzIGR1ZSB0byB0aGlzIGNoYW5nZS4gV2hp
bGUgcnVubmluZyBUUENDLCAgRGF0YWJhc2UgDQp0aW1lb3V0cyAmIHNodXRzIGRvd24oY3Jhc2hl
cykuIFRoaXMgaXMgc2VlbiB3aGVuIHRoZXJlIGFyZSBhIGxhcmdlIG51bWJlciBvZiANCnByb2Nl
c3Nlcyh0aG91c2FuZHMpIGludm9sdmVkLiBJdCBpcyBub3Qgc28gcHJvbWluZW50IHdoZW4gdGhl
cmUgYXJlIGxlc3NlciBudW1iZXIgb2YgDQpwcm9jZXNzZXMuIA0KDQpCYWNraW5nIG91dCB0aGlz
IGNoYW5nZSBhZGRyZXNzZXMgdGhlIHByb2JsZW0uDQoNCi1QcmFrYXNoDQoNCj4gDQo+IC0tIA0K
PiBDaGVlcnMNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCj4gDQo+IA0KDQo=

