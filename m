Return-Path: <stable+bounces-226888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBtHdSjuWlILgIAu9opvQ
	(envelope-from <stable+bounces-226888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:56:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC32B1436
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86864315EAFE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40D3F7A80;
	Tue, 17 Mar 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4YzCDKn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CE37C91B;
	Tue, 17 Mar 2026 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773498; cv=fail; b=hP9vAJ+fEkySOvptvTr9FPRkyZZmNfNC15Pkj186+XsfQQlK8JZIgRbrevSlULa4MF2NzjvAZB8MosNDZ9IdygohHOdEiYwNVj/HXcOnnzZUEyQ3wI70DQDmyInItnKeVT/xSpchHnoN5huUFAgThezGGTmjAIjZ44pgepRvdzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773498; c=relaxed/simple;
	bh=849VC7XUmLFudq2vrxvBZBryfx6f3z6TjT+Oqcjx5h8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LXDtMbdrkhN4QIm/1zhm0HA4tJ7E1e6GOQFLvKl62NHbYWaNqj5ybjg33Bh8qalouqAcgyC+wBN60aVDQcIA+QoL+XzkYGC9lwReqILRCe2IGOVdjVXXQc/pS6ZGN5ea6R7bNfVqcF94lyK+Bks7md8YUE6VA09he2p6vAexYcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4YzCDKn; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HFjXD94073613;
	Tue, 17 Mar 2026 18:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=849VC7XUmLFudq2vrxvBZBryfx6f3z6TjT+Oqcjx5h8=; b=i4YzCDKn
	f1yn3J3Z6WJPUfCHDIEhUptbEzlPaFv0IOMVwFNpxo4XY0QtLsDjDR+d/tvoGrm7
	rn5+q4WVH3chJlNVhC8AlAdDIqlQcys/QrLvRxTddieQGlzADvdvSBbXJIOEBV/j
	B57rKJ5WepsVt1lstEPoC9qW/X9kVqwLOUjXYJaXrgDQ8E5U9OjAHpdBnKIML5TR
	6U+zN2slABdKhsYH54MDxllXb/JtMQG0JgaduhNC3J6Uxd3F5Cv+7E5qNhEfc3Ss
	9i65/D18JC3KZF5FdJFCkBxu22bROO5WKsT0elyV4TxLRI22/sdK5Q6P70sE0HSY
	Y/srC180KNHrjA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64pesv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 18:51:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXff38FPkiMpXpf4KrWuRGvHHkKOtcKC5fwsmhwRESYoqVK+huq0mEe64BZy3xB3L8GIgxQLVoRNFLVefQkVFGznuQd9nPBQg9PCNvYjEkJvloOKnBHV8PqNqvR0/WV6lj1dUQl+wUBwVRtJv1w2pvqYah4/SO2rsDuxf/y9yplGfvpzqRQ6RJeKRf66b6FQJMUAgu+hDu28KNIW9qD08t3LZUKcj6/kjSej1AcRmO03P4Ye3gjgiG2vwDjIuCZqGLAbp/0N/Ecyuvf9bm8DUUodVnhkbacCcskc/3mGEm/l/eybKjCckB/zyN0OocBEEjT/vgFjIgyix+HGBjIZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=849VC7XUmLFudq2vrxvBZBryfx6f3z6TjT+Oqcjx5h8=;
 b=VYR0S7Qd+Xj6YQbgGJQBnTvYpM5R9KJauJes2mFpu1ovu7NHrEOkQM6tnjYdqtEiHEaAwz2RBwxO+U2G9/+fDwTZl1p0cQe8vqqpDd3d0O3+UcBPrDuRpAASV7S2qYCqDQdBVSA9DEzvjfVglzruQXWpAaTMAHA/2ceuRuU8T5t2bqG9phOyEpdj5zMHcV+QKq20ZwLaQZ6DLPzUijB9PozsIEd8NZIoeRBATusjOcapkyFpTEpDiFC/A0fJNerbmqxzGLgBnYW+uVMMHvf4T9jllLBg7WnKOyfcamVn81ojnhLOIo0kewOi3rbPbYPmg2kF+n4Dfiw+HotcOMpsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by CH3PR15MB5513.namprd15.prod.outlook.com (2603:10b6:610:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 18:51:21 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9723.013; Tue, 17 Mar 2026
 18:51:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "cfsworks@gmail.com" <cfsworks@gmail.com>
CC: Xiubo Li <xiubli@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Milind
 Changire <mchangir@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when
 crypto allocation fails
Thread-Index: AQHctYGZKZGAFrYAKEmLW1Q60nV0trWzExGA
Date: Tue, 17 Mar 2026 18:51:20 +0000
Message-ID: <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com>
References: <20260315232500.251088-1-CFSworks@gmail.com>
		 <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
	 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
In-Reply-To:
 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|CH3PR15MB5513:EE_
x-ms-office365-filtering-correlation-id: f37366f3-0466-4833-5318-08de84562e0a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 y7EaN37OLs1kJHBCUNHwmu1yGjHFbBcHtlZ5mMh0XL3AOa7iVsf109uZVo8gYCWPcqeZQ/H3U9yVDBwCfpDCHedf0drG20Sn3mvvH9FU+anLkXC4nOxpyxnEQg6YMmsWdxrl/x3aw2qSyWVBnmzKRv5MpHdU4fbGTK/P+p4j5VHKRfZhu6wExuODkO/FFkj4H0Qu/uDUsI0SDv6qbRr2kg4V57tmCTZdD2GWt0fKpzPPiwWK0xJOgYgmpg2zI0BukPpg1bEJFzOSKKDTpAfVmTYG4ZO0gmo4o248YATvMg1p9jpe5iit5Ho8gsVOcRlNis/ZtJ5+5bRqlN1mtPfNB1nid0w6KvyGBYKqYD2yBTJrfriPgs6AVfH0ZOA+T6Nu8CxXE4PMUUS9ewGFc3k8sU9RzkVddA6zUFq84eQimNPmh2UEsQJMPtseY+LOwhzB5fcav+a882NS8QPzbUFWJiwl3J/+/PPn8Jkau7o/O1C9mAg853n3h8LwjK1rkhY0m94OUgYXOj6izu765aRe1wA5tEkj7NsUCxPaJ0WJXcCr2GFdUN2U19z5BYTMKFF4j44isVmrO7VFUaCSsOm30iWmUUKDpxdJHE540S69lqlIWuRDDAVVNh00x6pcpIKbWoZdFBY75le83O2srOZ5YEdLOhbEWrI+l6ajDRKfFafAEkEoelDFQ99vae3muCvg49FflUdbH+r0v4mPSVuhZ1hMixLQ51K6kbOd+qRp4CZ3c91tvT9FBcebfRus/5MW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y21qWGROR1ZmQUt2L0NuNWp1dFk5MEdEOU15cEtOZGdlcHNJM0dOQTZtUW1J?=
 =?utf-8?B?TXhDbWZoaU5IZ1Axak1SNFlxbHYwRTNNUkRKb212KytzZzJqUlpuNVpKWVh6?=
 =?utf-8?B?Mi9xVjBnOHlFZ2JUUWhBZVdKOXRBZUp4MWpMaUZJaW1QeXJXb0c2UnJFVysr?=
 =?utf-8?B?bWlYK2pVdjQrOXNzWUNKT2FqaVBjQzZERFl1a1VYTWpSM2xkMytjYUpsbVN1?=
 =?utf-8?B?VytGK2pFeEVCNW56WUlMYlgrcWdHUnJwZkRXS1pKMDN1c1lTdnlLSUY4MERo?=
 =?utf-8?B?ZWt2K1VpTXZDOHFkQS80LzdHSkpUcUdiWDVwNEY5ZlpMQVZIMDNXd2t0akJw?=
 =?utf-8?B?VldLRTZ6aEZNN05kejU0dC9VK2VUKzBON29YZzB2c0UxaFVqYlFNK0tRdW5x?=
 =?utf-8?B?NHM3TG1JTlM1bHRNL0hwbnNXN3grejJxK1JlNERJVm8xWWlPZk00MlZPMlFG?=
 =?utf-8?B?TWxKaXdZaVYrSVRiendqSDdlcjNWTHNyR0NHVDVuNWZyU016dmJLM1l3Q0tj?=
 =?utf-8?B?SGVxZGpwWGYvQ1BzLzFTSEY0bmwyWkIxRHl0emM0Y09QUHpScHhmWThXN05O?=
 =?utf-8?B?N0paQXpCV2pyZkVSVWY5azlPYXJVaXJBUWhBdVEzRWlMcjViYmRkR1JVSDU0?=
 =?utf-8?B?VWQ4THFUNURZNlBPcSttYUxaQTYxWHl1ZE9hOGxwcDk1bGpzOWZMNklQYVZj?=
 =?utf-8?B?TlpVbW9ha1VDVG5ZR3VsV3JRNEFOZmtMTXNsKy9FenVkaFVYRWlVUC9RY011?=
 =?utf-8?B?S3EvMUV3Wk1jOUtHYmgzSld3YUNDbWZYNkt0V2lVMm9tUFNFczdyOGpGQThv?=
 =?utf-8?B?UFZ3aUFGUVFML1krSGx0RHNWSTczSXJHTm9vYTRyZTJ2YkY5d09SQm1UYkJp?=
 =?utf-8?B?LzZQakFwS3V5M1FObkc5YUFydzNldXdQeXlyZjRucVFGSjNGMWpIeXB5eEJp?=
 =?utf-8?B?Q1ZEZGFDaFRRWkhMS24vT1BWWWRhUlRRRW91U1ovSG93TlBSS1IvOUZpWHlx?=
 =?utf-8?B?RVNIcXIwb0NGc0xkYnJwMUkyVVpaWTJJQWFCNk53TFo5TG93TXlvU05ibzhw?=
 =?utf-8?B?VEU0dUwrM0JzVFVxb05Bb0c4WlVNTjRTU0wyRGg5WUlUZ3U5YkhnTEVjN3Z2?=
 =?utf-8?B?T2dMVWhvZW9vMFdGV0F3a2x5WmdkVTNaNXVuMlJ5OFVDRGQ3SnZzOG5HMU5o?=
 =?utf-8?B?d2hSMkhmVzMxNExvd3MxdEtBRC9FVDRXaVJOU1hFcWM4bWk5enZmUjFYdU1K?=
 =?utf-8?B?Qzg1b3Yxa3VzQzFaZHBSVWZkWmtxL3NsSGpxbUlxQVR0dEZCTGdQZlRJN0VC?=
 =?utf-8?B?b1grSlZJY0M5Q0JBaFVjN1JzV2lFcktqdEMvdWs1QURUQ1pBaWlOTUhJK2tM?=
 =?utf-8?B?dGZlZnBla2lyYnJBWkF3R1R2YTBTOVhrbFpRVm4yUFZONC9qMHNwOW5XZEhx?=
 =?utf-8?B?RGtib1FuVkEwRUF3OVdJTHNlelZ6MW9nWEhzZzhSWjV4Q3pPT2J1NDBKWFhs?=
 =?utf-8?B?KzI5T0VUWE12cy93emN2TFVUS1hObVVqWnFxN2pOelJaSmE1aXAvT0k3M0Zv?=
 =?utf-8?B?WnpYcUd5eWtUVzhuS3k1bmJQTUlva05VU0NJaGRUekhwSTYxWm1hdXl1YUZw?=
 =?utf-8?B?aFdMdU9BWjlSQmhqUFhNK0t3VFJuc25UVURJa0hxUFgwc21VVjY4NGVjRDkw?=
 =?utf-8?B?NjY3dWRsTmZHRHdncVVGTjFONGdBUDZzOE90UExVUnphOXdEUm1OcFFScDR2?=
 =?utf-8?B?TjkzK0RIY2h2V2E4WnJhUnRsY0o0aThldFBieTBzbStSVTk0enR3TU82YlZI?=
 =?utf-8?B?blNyTjBkcWxvdVlDYWlMZ2NNN0UrajdOSUxNWnQ0TFpoUjgva3ROV3FUZUxP?=
 =?utf-8?B?bktldWFTeHVxR3VJcGZsdHRONDFNTmp0OTBzMGUrT1REcm04alZyWHVDZEgx?=
 =?utf-8?B?azNLWStzdGFoNjluU0djMmEzUmxrdWNVQUxGU3QwT0hzWDJyNHJJTll5UDJq?=
 =?utf-8?B?Q3QvVUZqL1dobmpwVjE0TDh0eDNiWUNTNFZMNXBWNU1mcmJOaVkxMTNlUmZI?=
 =?utf-8?B?eHNZZXc4SFBqc2kvcDAzSnZDY0t0L2lwOUNsM3lyblNHL1B6NHJ6RWQ2R3Q4?=
 =?utf-8?B?cFdtWXZjbzNRUDV3VFNJNzZYalV0MHF1VTZQaTY5T29GanNsbElKeUdaRHpP?=
 =?utf-8?B?WXdFQWxLWmtNd28velV0VU85WTZrWGwySFFEWlpQZzIzRnRaK0xNcFkvS3NB?=
 =?utf-8?B?RkFtZm1vekdPc2tUbTFKNDR6WWRwOE5kbkJjQmg0a1gzai9vNjd1ekJlWmh1?=
 =?utf-8?B?bk9KWHp6S29BeEhXZVBRSXJTMWxxQ01aQ1JsV2pwcWwzc0FDaklDMGUveUw2?=
 =?utf-8?Q?LBzg3AUrTZwxXFdojPxPfjTNeSViAZ1tiq9/Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3997F79ABFDF484CAB22864CCE86B39D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mMdvT/e1vJRF5gMdUn9coDRWxtR8HkuYbcGLexaAZti3+HHUVJ4pWxQlTnFQylUxDUorBwqgElCMKy2THN3RQ6cOx3AUcaEeL9N/dmJpvuqwJAvbGRNiVcXnY8aBHJN+jsis4KtZX1P+9IKzQxILjA9vQIgsthFQEEvIiD5L5zsjfVjGg1l8gOGFuE7mxDjn/WlFCum/9dEN8mvLshJffPqXtFbABTyfNRiYjcbyG3h0UiyUdmrAy7JwV1mb8So2wYMALMFZxoMWqIk4MttmIOwQMnc/z3F9Ooj62eILP+nqcoT4zgCRhlehfVNHrlu74NN5xs33dFZrQhXRuUo+mg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37366f3-0466-4833-5318-08de84562e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:51:20.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JitzCk97YDwZzbhAas9JO+MC+jrQdjfUse+J37Ac8HeZMBubgeXOEMD+b44q+IV8xufQtbgkBFb3d3bzSMoZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5513
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5eDBOmtzqgb-FE4XfNf1bmaxaGfcOAvF
X-Proofpoint-GUID: q2L-e8alULEVDa0fEEBrKK87bLAR50ce
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b9a2ae cx=c_pps
 a=23BBZRleo/1KOgyGqX6yRw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=4u6H09k7AAAA:8 a=VnNF1IyMAAAA:8
 a=6WOIQMdHwpv7dG0ZfUYA:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2NSBTYWx0ZWRfX9xm5pnWe3Y5Q
 KFA58qEc6L7DhNjx1MRGkMtiRxiFXUD50WfK7GFRIuf1cyBgneSqyJBziknKTAo1Q1AiPftwK0c
 zx15eJbZdpF1HlW0AexIHH+wzsfP5UYESIlwIYyjVsO66P3/bjROENngFp3c13PiYzhoMuuPmSf
 K2x5NJGKevIBvepfKJtKv46PKohGhVT1jCxJOB72tuN2n3d8YHnb22WRfRZRvrpjRkswKoVSDLh
 xZtUcyiolLwVSDg+rUxZU4xKOk7ReM1KFE9rFsvr4iNRJOQm6dbzin4SgufpRFvQR8Nd65HHyVP
 xPIDcT5k2vU2XIW8qZ1e+sCbph++vS5Agr7ON81wqHxsyXxEVigt7CukTbwyMGaQm0HCxrtFLPa
 LBziRUVuuEP7q8Nnlapt1lXCmiAKZ5EloS8bnfa3YUDbzSrFVu4jh9uawI0QL7RFxjD8F2blbzD
 ZxxDKg3spSx4std7TCQ==
Subject: RE: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170165
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226888-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4EC32B1436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDEzOjE0IC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
T24gTW9uLCBNYXIgMTYsIDIwMjYgYXQgMTA6NDTigK9BTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3VuLCAyMDI2LTAz
LTE1IGF0IDE2OjI1IC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4gPiA+IG1vdmVfZGlydHlf
Zm9saW9faW5fcGFnZV9hcnJheSgpIG1heSBmYWlsIGlmIHRoZSBmaWxlIGlzIGVuY3J5cHRlZCwg
dGhlDQo+ID4gPiBkaXJ0eSBmb2xpbyBpcyBub3QgdGhlIGZpcnN0IGluIHRoZSBiYXRjaCwgYW5k
IGl0IGZhaWxzIHRvIGFsbG9jYXRlIGENCj4gPiA+IGJvdW5jZSBidWZmZXIgdG8gaG9sZCB0aGUg
Y2lwaGVydGV4dC4gV2hlbiB0aGF0IGhhcHBlbnMsDQo+ID4gPiBjZXBoX3Byb2Nlc3NfZm9saW9f
YmF0Y2goKSBzaW1wbHkgcmVkaXJ0aWVzIHRoZSBmb2xpbyBhbmQgZmx1c2hlcyB0aGUNCj4gPiA+
IGN1cnJlbnQgYmF0Y2ggLS0gaXQgY2FuIHJldHJ5IHRoYXQgZm9saW8gaW4gYSBmdXR1cmUgYmF0
Y2guDQo+ID4gPiANCj4gPiANCj4gPiBIb3cgdGhpcyBpc3N1ZSBjYW4gYmUgcmVwcm9kdWNlZD8g
RG8geW91IGhhdmUgYSByZXByb2R1Y3Rpb24gc2NyaXB0IG9yIGFueXRoaW5nDQo+ID4gbGlrZSB0
aGlzPw0KPiANCj4gR29vZCBkYXkgU2xhdmEsDQo+IA0KPiBJcyB0aGlzIHF1ZXN0aW9uIGFib3V0
IHRoZSBwcmVjZWRpbmcgcGFyYWdyYXBoPyBJZiBzbzogdGhhdCBwYXJhZ3JhcGgNCj4gaXMganVz
dCBkZXNjcmliaW5nIGN1cnJlbnQgKGFuZCBpbnRlbmRlZCkgYmVoYXZpb3IsIG5vdCBhbiBpc3N1
ZS4NCj4gDQo+IElmIHRoaXMgaXMganVzdCBhIGdlbmVyYWwgcXVlc3Rpb24gYWJvdXQgdGhlIHBh
dGNoLCB0aGVuIEkgZG9uJ3Qga25vdw0KPiBvZiBhIHdheSB0byB0cmlnZ2VyIHRoZSBpc3N1ZSBp
biBhIHNob3J0IHRpbWVmcmFtZSwgYnV0IHNvbWV0aGluZyBsaWtlDQo+IHRoaXMgb3VnaHQgdG8g
d29yazoNCj4gMS4gQ3JlYXRlIGEgcmVhc29uYWJseS1zaXplZCAoZS5nLiA0R2lCKSBmc2NyeXB0
LXByb3RlY3RlZCBmaWxlIGluIENlcGhGUw0KPiAyLiBQdXQgdGhlIENlcGhGUyBjbGllbnQgc3lz
dGVtIHVuZGVyIGhlYXZ5IG1lbW9yeSBwcmVzc3VyZSwgc28gdGhhdA0KPiBib3VuY2UgcGFnZSBh
bGxvY2F0aW9uIGlzIG1vcmUgbGlrZWx5IHRvIGZhaWwNCj4gMy4gUmVwZWF0ZWRseSB3cml0ZSB0
byB0aGUgZmlsZSBpbiBhIDRLaUItd3JpdHRlbi80S2lCLXNraXBwZWQNCj4gcGF0dGVybiwgc3Rh
cnRpbmcgb3ZlciB1cG9uIGdldHRpbmcgdG8gdGhlIGVuZCBvZiB0aGUgZmlsZQ0KPiA0LiBXYWl0
IGZvciB0aGUgc3lzdGVtIHRvIHBhbmljLCBncmFkdWFsbHkgcmFtcGluZyB1cCB0aGUgbWVtb3J5
DQo+IHByZXNzdXJlIHVudGlsIGl0IGRvZXMNCj4gDQo+IEkgcnVuIGEgd29ya2xvYWQgdGhhdCBw
ZXJmb3JtcyBmYWlybHkgcmFuZG9tIEkvTyBhdG9wIENlcGhGUytmc2NyeXB0Lg0KPiBCZWZvcmUg
dGhpcyBwYXRjaCwgSSdkIGdldCBhIHBhbmljIGFmdGVyIGFib3V0IGEgZGF5LiBBZnRlciB0aGlz
DQo+IHBhdGNoLCBJJ3ZlIGJlZW4gcnVubmluZyBmb3IgNCsgZGF5cyB3aXRob3V0IHRoaXMgcGFy
dGljdWxhciBpc3N1ZQ0KPiByZWFwcGVhcmluZy4NCj4gDQoNCkkgdGhpbmsgdGhpcyBpcyBnb29k
IGVub3VnaCBkZXNjcmlwdGlvbiBob3cgdGhlIGlzc3VlIGNhbiBiZSB0cmlnZ2VyZWQuIEFuZCBJ
DQpiZWxpZXZlIHRoYXQgdGhlIGNvbW1pdCBtZXNzYWdlIGRlc2VydmUgdG8gaGF2ZSB0aGlzIGRl
c2NyaXB0aW9uLg0KDQoNCkZyYW5rbHkgc3BlYWtpbmcsIEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVj
ZSB0aGUgaXNzdWUgWzFdLiBEbyB5b3UgdGhpbmsgdGhhdCBpdA0KY291bGQgYmUgdGhlIHNhbWUg
aXNzdWU/DQoNCj4gPiA+IEhvd2V2ZXIsIGlmIHRoaXMgZmFpbGVkIGZvbGlvIGlzIG5vdCBjb250
aWd1b3VzIHdpdGggdGhlIGxhc3QgZm9saW8gdGhhdA0KPiA+ID4gZGlkIG1ha2UgaXQgaW50byB0
aGUgYmF0Y2gsIHRoZW4gY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKCkgaGFzIGFscmVhZHkNCj4g
PiA+IGluY3JlbWVudGVkIGBjZXBoX3diYy0+bnVtX29wc2A7IGJlY2F1c2UgaXQgZG9lc24ndCBm
b2xsb3cgdGhyb3VnaCBhbmQNCj4gPiA+IGFkZCB0aGUgZGlzY29udGlndW91cyBmb2xpbyB0byB0
aGUgYXJyYXksIGNlcGhfc3VibWl0X3dyaXRlKCkgLS0gd2hpY2gNCj4gPiA+IGV4cGVjdHMgdGhh
dCBgY2VwaF93YmMtPm51bV9vcHNgIGFjY3VyYXRlbHkgcmVmbGVjdHMgdGhlIG51bWJlciBvZg0K
PiA+ID4gY29udGlndW91cyByYW5nZXMgKGFuZCB0aGVyZWZvcmUgdGhlIHJlcXVpcmVkIG51bWJl
ciBvZiAid3JpdGUgZXh0ZW50Ig0KPiA+ID4gb3BzKSBpbiB0aGUgd3JpdGViYWNrIC0tIHdpbGwg
cGFuaWMgdGhlIGtlcm5lbDoNCj4gPiA+IA0KPiA+ID4gICAgIEJVR19PTihjZXBoX3diYy0+b3Bf
aWR4ICsgMSAhPSByZXEtPnJfbnVtX29wcyk7DQoNCkkgYmVsaWV2ZSB0aGF0IGl0IHdpbGwgYmUg
Z3JlYXQgdG8gaGF2ZSB0aGUgbGluayB0byB0aGUgcGFydGljdWxhciBsb2NhdGlvbiBvZg0KdGhp
cyBjb2RlIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KPiA+IA0KPiA+IEkgZG9uJ3QgcXVpdGUg
Zm9sbG93LiBXZSBkZWNyZW1lbnQgY2VwaF93YmMtPm51bV9vcHMgYnV0IEJVR19PTigpIG9wZXJh
dGVzIGJ5DQo+ID4gcmVxLT5yX251bV9vcHMuIEhvdyByZXEtPnJfbnVtX29wcyByZWNlaXZlcyB0
aGUgdmFsdWUgb2YgY2VwaF93YmMtPm51bV9vcHM/DQo+IA0KPiBjZXBoX3N1Ym1pdF93cml0ZSgp
IHBhc3NlcyBjZXBoX3diYy0+bnVtX29wcyB0byBjZXBoX29zZGNfbmV3X3JlcXVlc3QoKS4uLg0K
DQpJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIG1lbnRpb24gaXQgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlLg0KDQo+IA0KPiA+IFdlIGNoYW5nZSBjZXBoX3diYy0+bnVtX29wcywgY2VwaF93YmMtPm9m
ZnNldCwgYW5kIGNlcGhfd2JjLT5sZW4gaGVyZToNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAg
fSBlbHNlIGlmICghaXNfZm9saW9faW5kZXhfY29udGlndW91cyhjZXBoX3diYywgZm9saW8pKSB7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGlzX251bV9vcHNfdG9vX2JpZyhjZXBo
X3diYykpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbGlvX3JlZGly
dHlfZm9yX3dyaXRlcGFnZSh3YmMsIGZvbGlvKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGZvbGlvX3VubG9jayhmb2xpbyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2VwaF93YmMtPm51bV9vcHMrKzsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBjZXBoX3diYy0+b2Zmc2V0ID0gKHU2NClmb2xpb19wb3MoZm9s
aW8pOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNlcGhfd2JjLT5sZW4gPSAwOw0KPiA+
ICAgICAgICAgICAgICAgICB9DQo+ID4gDQo+ID4gRmlyc3Qgb2YgYWxsLCB0ZWNobmljYWxseSBz
cGVha2luZywgbW92ZV9kaXJ0eV9mb2xpb19pbl9wYWdlX2FycmF5KCkgY2FuIGZhaWwNCj4gPiBl
dmVuIGlmIGlzX2ZvbGlvX2luZGV4X2NvbnRpZ3VvdXMoKSBpcyBwb3NpdGl2ZS4gRG8geW91IG1l
YW4gdGhhdCB3ZSBkb24ndCBuZWVkDQo+ID4gdG8gZGVjcmVtZW50IHRoZSBjZXBoX3diYy0+bnVt
X29wcyBpbiBzdWNoIGNhc2U/DQo+IA0KPiBZZXMsIGV4YWN0bHk6IGFzIHN0YXRlZCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UsIHdlIG9ubHkgbmVlZCB0byBjb3JyZWN0DQo+IHRoZSB2YWx1ZSAid2hl
biBtb3ZlX2RpcnR5X2ZvbGlvX2luX3BhZ2VfYXJyYXkoKSBmYWlscywgYnV0IHRoZSBmb2xpbw0K
PiBhbHJlYWR5IHN0YXJ0ZWQgY291bnRpbmcgYSBuZXcgKGkuZS4gc3RpbGwtZW1wdHkpIGV4dGVu
dC4iIFRoZSBgbGVuID09DQo+IDBgIHRlc3QgaXMgY2hlY2tpbmcgZm9yIHRoYXQgbmV3L3N0aWxs
LWVtcHR5IGNvbmRpdGlvbi4NCj4gDQo+ID4gU2Vjb25kbHksIGRvIHdlIG5lZWQgdG8gY29ycmVj
dCBjZXBoX3diYy0+b2Zmc2V0Pw0KPiANCj4gTm8sIHdlIGRvIG5vdDsgdGhlIHZhbGlkIGxpZmV0
aW1lIG9mIG9mZnNldC9sZW4gZW5kcyB3aGVuDQo+IGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaCgp
IHJldHVybnMuIEknZCBldmVuIGFyZ3VlIHRoZXkgZG9uJ3QgYmVsb25nDQo+IGluIGNlcGhfd2Jj
IGF0IGFsbCBhbmQgc2hvdWxkIGJlIGxvY2FsIHZhcmlhYmxlcyBpbnN0ZWFkLCBidXQgdGhhdCdz
IGENCj4gbWF0dGVyIGZvciBhIGRpZmZlcmVudCBwYXRjaC4NCj4gDQoNCkkgdGhpbmsgdGhhdCBp
dCBtYWtlcyBzZW5zZSB0byBjcmVhdGUgdGhlIGlzc3VlIGluIENlcGggdHJhY2tlciBhbmQgdG8g
YWRkDQpDbG9zZXMgdG8gdGhlIGZpeC4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczov
L3RyYWNrZXIuY2VwaC5jb20vaXNzdWVzLzc0MTU2DQo=

