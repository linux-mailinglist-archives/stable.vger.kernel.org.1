Return-Path: <stable+bounces-230394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNCmNu1zxGljzQQAu9opvQ
	(envelope-from <stable+bounces-230394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:46:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192832D749
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE3B303010C
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 23:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFF25A2B5;
	Wed, 25 Mar 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oG+qmtsl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U9BOMmqb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CD1A6832;
	Wed, 25 Mar 2026 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482410; cv=fail; b=n6t7phcbxDlqBUXtZr5ACiee+4+/fGc0GTybm9Ho8cA/+nQnRVxpzYf+XILGGuijfJoVVlqpn48r/IhZbCfiJ6knf9yk+YCUqJmCBsE0J+56lEIFCQ0ohkJyvvh+bVuPE602IZARxvqgOMX3KZFa1XMq4nOcRcJcBKZS2ddLeCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482410; c=relaxed/simple;
	bh=SrdmGJ25vDJcyYkMTH673BkEnWvKPK7sfpy8fGVS8Oo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7TUlzQeeyRwVJnFJEUVzP6mrkoh7VURH6wXGbZD27BLWmL63T6Wv4SXsMUuZehqP2aLhrhKIPem+2TDFTbhmwYK5EEtwrZT+BUjeIusBJ6aaCXj7CbQaBOTdUCI9dTW2gP2TkFEXNMHiepY5qWI22xwZUZ/BHgCWMcoDrNwko8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oG+qmtsl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U9BOMmqb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFtwHD2525827;
	Wed, 25 Mar 2026 23:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vVg6dBKlm71SDwtHmNFrJ23vqkZpUINuJdJZXxrEveY=; b=
	oG+qmtsl9JQoic2sJuYT2nPRQIRF3XMHVHGW9vHMAstOvYIeyyFxnYd01RheZvO/
	B46tDPt3UKgQ/qm7QAVAZNNNNRjjxvQAh5qGG152A1ouFACBj9cJnoN/mc3KIcsr
	Cl3jlg+UcLNXmaA2MYTmreEKGEfxwhBxi5uvieQzomQdIEwJ2KWMz9bR2oXJKttx
	xy4HAq/i4dMtvh6/4LAeP0scQA7BEddr0NryKTLTnTk4e75CgzbUX9BEKl0Ivpo2
	7C/LiUyDGxZD+Kj6fjA71HbUQcGhnI1Ow4LTiFVwXtNi193prRDCwLorcVhakWtb
	hIqDR3qIylyDfLvpzFPpmg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnqecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 23:46:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62PLapHo000604;
	Wed, 25 Mar 2026 23:46:15 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsc5y45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 23:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6sxKpj95+cyC2RxLc9jqs21/dIK2NN0Uks/kPm/MZy0koqvTO8GINoshhWa5vlNL/nVL9msgYzkD1ins6Lro0QeMYus1ySsglLM5IBTj/HHeCSF7atuEXsBN7Lz02sFYDqez4ap68EgjBXkiyq9IPToUw2rMvG975RUEccMVIRxHAXSoZWn29d5pCBFKvE3oG6oHSVoVTCaDGUrExjEdnnVqkyAy61Wiv6bcGJ1xXOmCMSlFXUYN8kyRb0qHqnGzaCjPLXYpfoJ5fEUMvVIVeaqriXJWlztPem8vQZBhoRHuBfDZ4JiRsmoTyhj/fhd0tQGWHxL9F+h/+NivnFY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVg6dBKlm71SDwtHmNFrJ23vqkZpUINuJdJZXxrEveY=;
 b=w+7EwWYf0MSegnRGemhjJXlo3Rq8DjKkxuhtO1YA9mN+qSGII83iL7oJk5YKagrhpDA8ozD9t7ZYhhNJqOT1YN1QujA20e/JwDPPMlao3VlHUlJyJBU41G5Gz/KElSLFj1k7sO89KWtOXEMo74V/sndclS+sMV+UrE0+slSgbxvfrb84VvMgR28B/3T4eQgPRHlZM9zzIeoJZd1QruzFefUb+jq9m+LaywBYnf5GYvmOkAsvE6ktb1mwpbDwe8mATbsfyAjX1s84+x13fsB7F6SOLg8W4l5KwQhMs3AwlHluCuhK+uupxcg+nJwHZ5RGkJXWMebcO7i6GKWKknKGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVg6dBKlm71SDwtHmNFrJ23vqkZpUINuJdJZXxrEveY=;
 b=U9BOMmqb/ADo4NlpjigZzFCI/AGEOjWy2zobMRM86u3+M8BOIeHlOfBivpsEqW1VwoNqOYklrXQmufmAJTBx8sS6aRTJxxVbFuSvr+6EbAQmAS8bXfkD1mDt0SZoHA/+TS7H8re41IsqAC4REcunRB/zYMNVI6C6HEUaA3FtwnU=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 23:46:09 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 23:46:09 +0000
Message-ID: <67287b4a-7b93-4061-af4d-65e4a163c61c@oracle.com>
Date: Wed, 25 Mar 2026 16:46:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash
 calculation
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jianhui Zhou <jianhuizzzzz@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, SeongJae Park <sj@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Sidhartha Kumar
 <sidhartha.kumar@oracle.com>,
        Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260310110526.335749-1-jianhuizzzzz@gmail.com>
 <12e822c4-a4f2-4447-80b9-2eec35a03188@oracle.com>
 <CAEgWzV5ryMBgJWH3QmWfr9LaZoihXcffFWKjK6OfJF=pDF6BtA@mail.gmail.com>
 <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
 <1075f7a0-232f-4268-94b3-573d11c4203f@kernel.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <1075f7a0-232f-4268-94b3-573d11c4203f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::15) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17e529-92ec-4479-0f42-08de8ac8b0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3wRXm90c1eBO44CIqilcFYLJzgmW9ikADly8MQTgqg9hVSplv88LSJnMy5HiytoaVbF6rE7AUg0+hy6IJJw1aslYUEX4F1Me798gHJF8eKucf7+attuj3IaEwNijRCv934u1xKHqtUN/MLJje67FcV59wkV8wq/RCHjL93Z3D29o4w9xELi1bha3NIpk6TG9RxUI5soXL/msN3xmS2nEKj8FoBFj6WxdA/dU/3gCrVFzSrbM7hE4dwZbxVnLz6ZkgZR7SKkXuzm2/eEeMigz08lT34V+S0ZS1xw1PlKLE3S2WimKLw+sPy7WZ6NqRDfaZe307JscBjPo3qgRvLwPRAXNmsqqlJ7MaPz/6RTHOdylqajuF9Pmb0XfRx2WgY5MNoTclo+r+GQ0SA1Pyrz8ZW1oAy+lEHdX80wwMMvgPkFn9dBhzOAGEDqoEiczbo+3j68UCcQNiIsGCEN97Oppt+zPgd+vz06OOKdPaZCj6WQEHRInvj2Yvh5y3FH2Nn5PtNcSqhZ/u1Uqgdk291fagN5WvwDzsh6iROiead4D86YmBqqtVA7la4DywAodyDs09WLY1Ri18AtNszzCN9liYUabnA8qIlHAIb+ukwUOYiC9UVJpHCoJ+lS1fl0u4GpXzRVBmxMTxhJI0FufTLLWLYwGO6/MQA1TnvZDFOvVwZEPiAfbdII1VBwcBy8DHb2qccxfu+fWk96/7Km7Ugh3Hf2ICJ1FnnWBB5F8/ozVcWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWM5Zi9zbFNyeUJTSHJPQkgxT3ZFd3VlcndtQVAzSG9EOFFRSHAreFpHY3lv?=
 =?utf-8?B?S1V0dGFYc2M5dFlNc3N4SjFsMGwzQzJnVWhSVmJaL0lOQ1ZTVU9QTE10Qmdt?=
 =?utf-8?B?VW9rejBxUGFHQWhDaEw0QlFXRW5UOW51ZG1kc0VaVzlWeU81OFVvNkZvK0lK?=
 =?utf-8?B?eVZmcUpJZ3haQko2eXAyV25meEo2UXRka0R1R1g5bUQ1UFlzTkMyKzl6anhY?=
 =?utf-8?B?ZFRLaVFBaUFTOU1kcUpBOWFFV25IcDBBRTB3T0o4ajA3aUl0aTg5eW5oSWov?=
 =?utf-8?B?d21OaldDNFJSTkJJUnM1ZW0xWWZNd3J2UWVPNlNES0Z0Snp6dDlSaUtzTG5G?=
 =?utf-8?B?TEFIOTB6WlZ2RFNHQzFRZ0NNRmQ1dnNQTi9hdXlxY1Z3TGZUTFV0a3N1bURt?=
 =?utf-8?B?cUVzSlJxVHdqY0pqbHBtUU8rZVlHLy91blZLVGxHVWJGZ2FydnA5TUszSnVi?=
 =?utf-8?B?ejliVExOTi9jM0RLMFJFSkdDakQ5TmxHenVoRUdYU2gwMWFMK3pVcTAyTEJr?=
 =?utf-8?B?cUhXaUR4eE1KWDBtd1QrQ0U2d0VjbmZpNThzdVRXV2paRURYRHpNdGoxVzZC?=
 =?utf-8?B?K1l0NVJBN1JzNkxaL3hoS3FheXUyTUIvWFBYS3ZaYVMrcVBES1hoT0ZySitl?=
 =?utf-8?B?enR2VlFOcVU2cEhqSDNzeUNOVUIwOFl3YmRiWVM0SGxNR3ZGZi82OXUvN1Rj?=
 =?utf-8?B?aUtaS2MxTkZFaGIxTGtXeVRFY2VHL3RNTGxEMGhlRUlVSGFmSWZBMlg1TnFP?=
 =?utf-8?B?dks2eVMwZldWL0RjVGJpbWFtN2xTY2QvV1JHMmFBMkJpc1BucTZ1NkhBZU1h?=
 =?utf-8?B?ZUZyOFRBMEZtdjlSRnVrY2xETGlDMWZpTnhWSVhXVmVxcm9xNmRCY3czZVZI?=
 =?utf-8?B?SDNmOHljSUd0SG9FY1Brc1l3b2N3Wm1NdEUrT3RsbmptQUd1cytlZk1kd3JK?=
 =?utf-8?B?MGdJZEJIZjNtOHd6OG10QXNuSWU0VTExL0RZSCtacE5ZNUtocDZZOGcyMzc2?=
 =?utf-8?B?SVB5RTVjaktiQ1Z6QkI1c1lvUUo5eUJ2RmFoNEJmSFRWSGx2RE5BSHFEcm9x?=
 =?utf-8?B?T2RHYUVKU2E0TzhObCt2TDlLb2xUU21USnBiQmNuL3hsWDYrdU1PR212aTBB?=
 =?utf-8?B?aHcwWWU2ZTdFV25WcEt6REhiK2xnR1pJbm4rMVJNZFp6dEg3ZERtazBCbVJu?=
 =?utf-8?B?Y2pnOEl5N0Nhc3hRd1BQdHhqY09YQm1BcTVRdllRdU9pcFltY0lnR205VFFX?=
 =?utf-8?B?Ky94bms5aXNzWWRoSzlRUTQ1MlFveFpNMzZrcmhiOVJhdFJqeFg3MHFaT3Bj?=
 =?utf-8?B?cXhXK3l1aW9Wa2JMNlhXUmFJcVZYeDVtTWoweDY0VzFuM3NUUHJ1Mkg5Rmc2?=
 =?utf-8?B?VW5Ha29GbW5wTFh1cS9FbUM1K1g1TjFWMXhJVWFURzdUQzNCMkZpb1loQ3Bm?=
 =?utf-8?B?QXV1OThMeEdQWDdpMHIzWnJjZXNEdjR6amlidkVmMUtRcXZNRlVmalEyMSsv?=
 =?utf-8?B?WXdYNkFZWkV5MTVRanFqV2lMVnh5dzQrYW5pQUlTY1dFK0wyUTNhWDMxK2Rk?=
 =?utf-8?B?SU5pMnd2TDc0QWRkVlBpQStZNEJtR09BKzdBTlhhc2RhS3FXM0psYTQvNHVt?=
 =?utf-8?B?TzBXMG5mWm9vME9GT2tnNDRUWWZZVDg4YnJ1SVVFWERYWGM0aGdoeGRKQWpF?=
 =?utf-8?B?a3J2MmVpanNNVzd5c2w3MXJTVTMvdnhOM3dwMCtTRW9EOCtMM1NWRCs3a3lw?=
 =?utf-8?B?SEpQQjJjMGoxTHdwelBsRHQ5UWpMbzNmTGsyZkZZM244a0JaNEVRbGo5VVpa?=
 =?utf-8?B?UnFkZFgvOFl5WlUzWXE1K0Q4LzNvdFUvYnllSGxicXVnR05vMjRteUdLQnFK?=
 =?utf-8?B?K1RPY2p1WlRLMzQ5NVhSa0lzdVVXSHhOb2NYZ1ZnQW1FNVJFNSswQWNOcXpu?=
 =?utf-8?B?MCtOMUJMTWExSVBoaDhlTmZJQUx2U0lENVNmcHBLMWl2b24vMDhqZzR0VmY5?=
 =?utf-8?B?WGNoSXlXdnpnZEpVSHVDREltRUUxZzBobExGdnY4WlMzRHZsajZoWnZjWlRo?=
 =?utf-8?B?SnJhbE0wMStkR0VVMWk5dGdOZm41cVgvSnl6T08zdDFtb0pQOFl2ZlpJSnJk?=
 =?utf-8?B?NjFwT1IwUEw5ZXE4VElCckVraVh3R2xEWWJsbzZXN1FRK0p0Z2NQRnZCZ2Fy?=
 =?utf-8?B?L08wVk8yWjJxOGFnSThGMkJiV3Bmd3hEQkNLUHV2QzJJaHVKaWRINU5kS2xE?=
 =?utf-8?B?Ym5pRnVzc210SkMwMURsaG5BenFZaGUyWTRIdE9QUHFzWS84bmZIUVhxZWwx?=
 =?utf-8?B?b0lwVG9TWkI2M2xXWjM3dlQ5dEJ6Z3BLWEFiTHkrQndGRXdMMzJrQT09?=
X-Exchange-RoutingPolicyChecked:
	N7a+i/83p3JwZyeD/lhHczJWKfdsjA7aboR8zGBnOhkCei6ZN5+L+/T0aS6smPirRnUk+zQtVDUjjHQJNWsry3Zy0o5ssaLJoXdCgxCc1qyuYHZ6+rntpcoejUnwZ8o4s7ZKFZ/Vi6KU5XL5GTmadg2+XWWS3PK0sSyQNaucCWI3zWRkdw9iQZB3eTf6TgFXGQw3ol0MpnazbMyQJ+HiLQD1esRylgPDj+oBTylVjttCs7W0Kkgqi6Zp1C2yenSJInyr71PHgb8SxpSvhzWt6jYZoV2S5i2v6rVXWWTqR/mNxw+26jjZGPr/WJUDWQ+j8NP6VjZtjCjTXNMXcjDEAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c4jX7r6NJAZvV8p10GW5GQK9SNHgmrZ20dnqbPjFfccHNSujbNkHvDoqtlEfTlKIju5AVH2vjhFpAnAmDt398j4nUU7ymYflS9v57qgOVH0NW9AmKG5vRQj/fcojggMFiSndIBZ7+3kqgwu9YhkZ1Jq7sQb0f8YFoOoYvkrE0vqDg1DukQDEVaM8mRMz3IrzLe+b7Yy+OE4nIkkka6sKcGFQE6YLf9ymRwDD71JTHF6IfeBSQ3tth/UYfBhSjqa+PYGlUith/mIZFzlAX2WdtI6JRfEqtEdSZc1+KSmxhCfaJ2gROjMxJhGWdHfA/+iHPQCdi/4hYcTg8rJZdGOiURNdjxWY6TKOVerFKEzOXWNkGm8IqJtWlQm56crZWePJ8Jv3eqklHjLuvN60xoL1BCYnpA9gtkXRsrCgORIJAeAqz11DuwZma2Dn54mmoU5U9Fm9sG/Zfwa6Nl+MhKeZha+fz8IWXiktVlCTfGmJDI8wLSLPV/XyH/b3XjMI9pDaIVGL/d0VH7PvIvkPqn51uY/xWJPIKqUcJWZHv36FCxGnMCqapAuL8FfbMPJEZRiRjp3op50Lxvc8/9ei1VnCnrX0zR/471kyMObl6Wu52G0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17e529-92ec-4479-0f42-08de8ac8b0a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 23:46:09.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j40UNrQlmHl2OPx6Smqi+2Eq460pd5Mkha0Ety5nu8BZO2wb1oFxQnIM/zh7Blkdq6If/kTWcwdYQ843P5bNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_07,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250177
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE3NyBTYWx0ZWRfX6FbSsC0grTKi
 iCAUE4vSmEOt1gxdHUY/VCsWTw4KZlu3Kg1rpqPzA666QscYblVbv/ddAM2R7efIu4Nh8SIHwo3
 wGYm/h892e2dQiaH4W66IGPL2aQcmxXKAYqvwXyxO4ymVAGRDl5Al7nAbah/OF+qXIcruwdWS3o
 rV7fMLb7GFcvg2KIO4ivM3lyIQwLJUwId6MFyakreAC2wQo3mBXUUIEn7NftiQx+kpJOoI1avT/
 l7YucLxmrSDWkyzrxVcKu6MbigBRFb+E8LlsATWH0xj7boodNRMZi6FRgbYqOnXA49lJnICZzLc
 sTLN/6X9yzJRHLBVlozrWZdQ+eN33I2AGdjPVNqQmhSGHEF+9cM2RkQmwpiRr+YkPs+aY+UhyEx
 IJocgs0xIXDPTk/wKlqiKIl5xNGXn+Rf4DlWWaJlrL/qo5av98Ey01vigHebYgXL5GnlGamtl5N
 tWBu5sPUH6FMI58Fj2g==
X-Proofpoint-GUID: TinJAt4jATGsGL4P1anDWAeIToLLwTZg
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c473c8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=aewNAQ8kkjm9Pm2e3WgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TinJAt4jATGsGL4P1anDWAeIToLLwTZg
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230394-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,gmail.com,linux.dev,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jane.chu@oracle.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4192832D749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, David,

On 3/25/2026 1:49 AM, David Hildenbrand (Arm) wrote:
[..]
>>
>> --- a/include/linux/hugetlb.h~mm-userfaultfd-fix-hugetlb-fault-mutex-hash-calculation
>> +++ a/include/linux/hugetlb.h
>> @@ -796,6 +796,23 @@ static inline unsigned huge_page_shift(s
>>   	return h->order + PAGE_SHIFT;
>>   }
>>   
>> +/**
>> + * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
>> + *				 page size granularity.
>> + * @vma: the hugetlb VMA
>> + * @address: the virtual address within the VMA
>> + *
>> + * Return: the page offset within the mapping in huge page units.
>> + */
>> +static inline pgoff_t hugetlb_linear_page_index(struct vm_area_struct *vma,
>> +		unsigned long address)
>> +{
>> +	struct hstate *h = hstate_vma(vma);
>> +
>> +	return ((address - vma->vm_start) >> huge_page_shift(h)) +
>> +		(vma->vm_pgoff >> huge_page_order(h));
>> +}
>> +
>>   static inline bool order_is_gigantic(unsigned int order)
>>   {
>>   	return order > MAX_PAGE_ORDER;
>> --- a/mm/userfaultfd.c~mm-userfaultfd-fix-hugetlb-fault-mutex-hash-calculation
>> +++ a/mm/userfaultfd.c
>> @@ -573,7 +573,7 @@ retry:
>>   		 * in the case of shared pmds.  fault mutex prevents
>>   		 * races with other faulting threads.
>>   		 */
>> -		idx = linear_page_index(dst_vma, dst_addr);
>> +		idx = hugetlb_linear_page_index(dst_vma, dst_addr);
>>   		mapping = dst_vma->vm_file->f_mapping;
>>   		hash = hugetlb_fault_mutex_hash(mapping, idx);
>>   		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>> _
>>
> 
> Let's take a look at other hugetlb_fault_mutex_hash() users:
> 
> * remove_inode_hugepages: uses folio->index >> huge_page_order(h)
>   -> hugetlb granularity
> * hugetlbfs_fallocate(): start/index is in hugetlb granularity
>   -> hugetlb granularity
> * memfd_alloc_folio(): idx >>= huge_page_order(h);
>   -> hugetlb granularity
> * hugetlb_wp(): uses vma_hugecache_offset()
>   -> hugetlb granularity
> * hugetlb_handle_userfault(): uses vmf->pgoff, which hugetlb_fault()
>    sets to vma_hugecache_offset()
>   -> hugetlb granularity
> * hugetlb_no_page(): similarly uses vmf->pgoff
>   -> hugetlb granularity
> * hugetlb_fault(): similarly uses vmf->pgoff
>   -> hugetlb granularity
> 
> So this change here looks good to me
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> 
> But it raises the question:
> 
> (1) should be convert all that to just operate on the ordinary index,
> such that we don't even need hugetlb_linear_page_index()? That would be
> an addon patch.
> 

Do you mean to convert all callers of hugetlb_linear_page_index() and 
vma_hugepcache_offset() to use index and huge_page_order(h) ?
May I add, to improve readability, rename the huge-page-granularity 
'idx' to huge_idx or hidx ?

> (2) Alternatively, could we replace all users of vma_hugecache_offset()
> by the much cleaner hugetlb_linear_page_index() ?
> 

The difference between the two helpers is hstate_vma() in the latter 
that is about 5 pointer de-references, not sure of any performance 
implication though.  At minimum, we could have
   hugetlb_linear_page_index(vma, addr)
   -> __hugetlb_linear_page_index(h, vma, addr)
basically renaming vma_hugecache_offset().

> In general, I think we should look into having idx/vmf->pgoff being
> consistent with the remainder of MM, converting all code in hugetlb to
> do that.
> 
> Any takers?
> 

I'd be happy to, just to make sure I understand the proposal clearly.

thanks!
-jane


