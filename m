Return-Path: <stable+bounces-188129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDEDBF1F87
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CD63AE106
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684521255A;
	Mon, 20 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vpde557S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uaq21ZyY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8C4CB5B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972514; cv=fail; b=MviWNPIovw0fENYEef1tEKzK4xOXfZa/h6oB6inPXoWStz+ej5hV1iQSPGibrPR+vTKfR+w6gDAq0tcSG8kcMLuSl+aoWsDcFTpuXMSnk2+fWGztEnkTaU8yCVSBTCxFVg4a8suUiROEER4xt6wVOxCeqGeDEigQPUARQPL/dkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972514; c=relaxed/simple;
	bh=W8G14vysx5sqkZp3thlfiGb3jg7InUTxTZ86GP4N8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSrFNdZWFZqGrQBJgDups/CDHd52P3idW9Tw1pROs1/Iqjo95HiiNUsfKkCxN2Oo2rJ3gnbiaVWHg7SFaT7EqaYWJIecYJyZq/pPS1ieGG9+pWmuYJZQLNMcC0+wmhuf5loDEFTB9y2iZGuHXL3MmGqMnoUKkYdn49sUsjo2Xjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vpde557S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uaq21ZyY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEvGAA032567;
	Mon, 20 Oct 2025 15:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qBSSKDVMlxwnYQWscFNLIl7ez1ynBZTWUbL2zf/3VPY=; b=
	Vpde557SXM1Ue/vMbNk0cJ/fqwNs7A1gP9j4nk7129XOc5mgZf/NzYbrDSzXgQxc
	nzq6Va9/QtF5YtpFD60F+Du7WGosoer7b3aarxBJ/Sby17xsjwh1KFl+W1TmOy9P
	ehQyi4jr1iKVpXrufGJNU1ECbE7HpcEudmC9iIy93Q3KUpRX1yyX2UGzbpJ+sILT
	stXX5bLaqmvwQ6Z0CRoF8GHGch/l26AM/vt1mwrq3sWLG24cEB+4IOc8hjhmxc/v
	BnmwEygL2aJRaZpO55aEtidibQf4UnqwGeLNBe/S+Ivzgto2510OL12W1Wx92LL2
	0UX48pYicGrgEw+6ipvAmA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yptem5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:01:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDvgYZ004361;
	Mon, 20 Oct 2025 15:01:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bb14vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkO5BLXsHrrd8XbauZjICcWVsgnOr34G+JzhhisIOQxfyLzqnogtKC9oVDNys33CimDUuaNV4deWNZosIcYKkBaH3HZp1S7TxaP4tjDEIbxjB+c+P0wv8m70842sK6eRfJrf+w+0kfpGNLSPuPWUtQcgLvisn2AdB4r4A1xGB7EPNz1y436qAYfLK5lawWamdakUhn2wDymZsz0ol2e6PwbE2ypJV/IDtdTjXESIiw4Jacitpj+ABbq8q7BMfDukdy1kOSZz22YGBfjCNGy38aHz8ocyQRsZTAjd9EXZ/EgioGLW4N63fxNquxziZHn/I8nHHlU5Kf+xsnyaOEfq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBSSKDVMlxwnYQWscFNLIl7ez1ynBZTWUbL2zf/3VPY=;
 b=l2LrfNUJt/JP//oK9K5AU2uS5tfry3F8UpZ3b5fWQ0iXY3Cbef8nakR9v0qdwtNFWp4HcdMdCOcto+nL43OIwRBziKmgmh3EENos9iT2gluoLwex3o+k5htS5PLzzvioxcD7A0uudcWZ+fBNTjDvT2+wFDcM3U++Osvf/ng1uFw+l4MBrbHt3NegWhI+DVzWTsnXAwRUfhKJ2rBgC2BFYdBQL7hpJS0f4InJkr8hegQuFBIBBp0QdEHI2xHJDFUWx+dBvwiLmR82SsRrmXyQXh/3U0UpAwrgiRhWQDzqqV+23vYTC5sN8+pYYgAWFLBWGUSFUl4QLhkUGxEXNbczDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBSSKDVMlxwnYQWscFNLIl7ez1ynBZTWUbL2zf/3VPY=;
 b=Uaq21ZyYkgmcQ+ukaoYZmlpFmTt6JTJHFNbEjfcpfjAsRw6LHa/NyLHZOF4Sj4lHugVmYFsjvNg4gqx079GcYTVTgi5XQUWvNzZCkQ7s/xwwH0EiS3o2GLPXH8q5EDBZbM1vOgvUu/oeQjVxIPx6KVBijex10Dk4I5YdwRQwZjI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 15:01:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 15:01:08 +0000
Date: Mon, 20 Oct 2025 16:00:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Message-ID: <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 748d89f9-73b6-40a1-c5a6-08de0fe9803e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUpoNFV5MVJHV1QwQWhOdEp6b2dNVkhYZVhLWjVNT0pLbER5VXlNWG45TUg3?=
 =?utf-8?B?cUVzZFRkK0wxWDg0SXZyYlFjQ0xoMC90V0FKSE1SMUV4cUt1bjhSUHJVR2hI?=
 =?utf-8?B?Q0M2Tm9XZzBOU3d4R3JvTHJqd1ZTNXZYS3RwKy8zNmhERyt1U01ITUxzNUtS?=
 =?utf-8?B?YUJ1L1RpVXNIVlpKb085V28rTHZFb1dyNnNESSsrdGxtaXJvWm5odEZIeERL?=
 =?utf-8?B?MDBnU1o1UTBQclI4alNLRCtoQVZnU1NIYVVDMi9zeUlIVlZ0MTE5SWV5MllC?=
 =?utf-8?B?azB0RmYxNnAxemZPSW8yTmp5UzVtRG1RY1FaN0p1K1o0RmRobHJDaTVIVGN6?=
 =?utf-8?B?RUdHK1A3Zk5qNUxVaDlQODR2aFA5TDRHbVB5NkpBNzdLQTdQeVhyRjZzQXpn?=
 =?utf-8?B?WHA1bXpqR0F3U3FwZnBwOEJzN2dWS2JNWXUyNDgxeFF3dlRWQ051SUVKVlEw?=
 =?utf-8?B?dVFLOG1ldVpsbjJZTWNsbExxVWREYWJ3bDFCQkgyVTZDZVdPdk5VazFGM1Rk?=
 =?utf-8?B?WGFyaUFwOWU4K2lnQ0RrSXk1amdJYU5CbitwVG9tZUtwMk1PRUNTNTdtSksr?=
 =?utf-8?B?U0haS1pZekwzdS9wOXgxS1lyb3g5UGZTbHJpblpyS0VUYjNXa0RhT0JSNWRI?=
 =?utf-8?B?bUhYM1F2UnpjZkp4d0pCaitYVllxWGVLRmFzNnJSNDcxRjk1MDV3TWhPdEVh?=
 =?utf-8?B?QmhneTlVMlRUVjhTY0tWWTE5MVJZc2F6WE1MbWp2b3N4OFlaZEd1Sm9UTDJU?=
 =?utf-8?B?MCtnVDhHUjFDSWxyOFpvUTYrTW1TY0grU2FxdEpka2dxMURmVzNxK2NIZFM1?=
 =?utf-8?B?TGNzUSsvRW5FWkVHdEpPa3BZWEo2UlR1ODJRbHV0OHJSR3daUlZWTUxjT1pJ?=
 =?utf-8?B?TFlzVFFsLzZMR3Y5QmJKTWkvWGtEbTNaZnF1czJhbC9hQ3ZsenpsVVllRkUx?=
 =?utf-8?B?Q3ZVTVNiYVRaVk91NVlXVWZlbEw0Qm9OTnNTOE9ETUdWZDhnYUNJS24xNFB3?=
 =?utf-8?B?M3ExbElOWmhuSW1wZ2VVdWNEQlFacW5GOXVmRE5Eb0VXRm04VnBTTnpzTUJO?=
 =?utf-8?B?bTRpYVdYQ3ByMWlKdGMvUlNEYTIxK3lyU0grbVZ3c0lWT0JHZFlhTWtnTTRv?=
 =?utf-8?B?VnFJSXA0azNwWDhwWFZ3MEwvODdLN2Uwa0pCbUQrdFAzeXVFU0VVcUNXYmpO?=
 =?utf-8?B?UTgvbzRCVmRtWFEvb3pHaTdQQWdxZDFYRU4wQUcwaEV0b241S1pSTzA2cS8w?=
 =?utf-8?B?RitnOUxOZHVPMjd2V3VDMTdIVkZ2S3JXWVk3ZW02VFVIZ1BtUk9IY01QVkQr?=
 =?utf-8?B?ZExheDhCeEk2ZnRTUXhMaGFOQStmSXpONzZxM25qdmRVRHFybHZPblFTSmt0?=
 =?utf-8?B?bnBDTWRheXVSdnJqTkFNTG96ZDdwS1JFNkMra1h4RmRjS0JFMHl6N3d2UWhC?=
 =?utf-8?B?Z25PUXd5OEkzRisrY0FtU1ZDTW9YNjBWQmYvNUZFQXpxektRRXB2SzJJYXJ0?=
 =?utf-8?B?WUJ0ay91bUVRL0VscTl5NGpXOG5NU3EwamVVcjRqNU9wczJUSHo1YWViTTh1?=
 =?utf-8?B?UTQySFVaUlI3Rjl3M1FMWUdaczRidjVGWkRrRHB2N2JCeHhxTWd0cVhnaDZB?=
 =?utf-8?B?Uk0wd0E0YXAvazd3UmVJN2JjMU9GSkJVeGx5ZkR5VlFxNmpjUml6ZWYwVUdO?=
 =?utf-8?B?ZkYyaDVZYzduanhXWnRiWDZYcXdIR1crWjcxMHBzR0pVQUt2R3dNMGRGdzZC?=
 =?utf-8?B?ZytEbGlEUmZFT1dDLzc1WnBYTkRUUThjeGVBWndvWHVrbmZTYm1ZTVZJeTJk?=
 =?utf-8?B?cVdqK2NVSE1IVnpaaEQzdkZZYk01cVR1MWdUQ0sreTRRekdWTTE5bU1nTDJk?=
 =?utf-8?B?SjR2aVh0dDVibmwyZ3lHYzJJYnZ0TldTak8wRUd0N05mWGlVdTNmT2MwUDNG?=
 =?utf-8?Q?trm/UJwrWN4SwtyLWWk38ERrSNksQ7IK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UERocjdVVWpuQTlhbDRyNWhkM1pZVkxCbjhKZjkyTjcxeGhQbjdiL1h6SUlE?=
 =?utf-8?B?eW1ZOXBhUmxucStEdm5sTkRYR2VXejJ5K2tVei9SOE92RThDZFU2MmU2aEQy?=
 =?utf-8?B?eXRPbXBTWkdHRVJQU1RFREJuK0dvT1NNUm56TkxlMURaSlZ3dmw2cmZDTTNa?=
 =?utf-8?B?VlVQY2RqTE9nRm53NVFDdnE0aGhxMEU3VVY0a0xGSzhveWhVd0NpeEZlbklD?=
 =?utf-8?B?TWRpYk1RSmV3WFZ4RG5CeENpQ3R4RXduYkpMbHhRdjJHS0lQZ1ZzTndZZitC?=
 =?utf-8?B?WFo2aE5sdzk5cXlLQW1nbCs1eVBvRE9EUGlRNE55QnJhMVFQdGM0dmozSWlC?=
 =?utf-8?B?ODU5bmJ6TmtIelNuUk9tZjJYYmJHaEx1TlZkaFRSanhUK0F2MjgxS0dwWVc1?=
 =?utf-8?B?R2VxY3YvZE1yR2tibHBtOVNmbzJoT25jZ244WXRRRmZrQktKUFJlY21ybjdr?=
 =?utf-8?B?TFhEMDFLSDBuK0pqVm5MQWFuSHk3NmUwdGl5SnY5NHh0aHRvQlRVQ05Tb1Zy?=
 =?utf-8?B?RXlHeG9kYWQ3WCtFZ1dwT0x3K1laaFplaEJ6czRrT0poVUhNZEFtd0RDc3cz?=
 =?utf-8?B?N1llTG5aVzhQWEtRcGluMjhySUNvTTVMNnN2MWlCNGZEbDlkU0pBb2gyaTVY?=
 =?utf-8?B?WURrcmV4ejd6d0UvKzZXVnlnZzBvSjNMRXNjMkJVdWlMRXJmUkFHYjZWczll?=
 =?utf-8?B?UmExWU5sZURsZkZUT2dSMGc1a3RPNUpvRlM4K0g4UmpiVnFtdjV4VnIxTjNa?=
 =?utf-8?B?cklXRnZxY2Y1RGZhMlJWVzdnMWVFTjNUa2ZPU2lOdzVhd2E0cjJCZGlmdGZC?=
 =?utf-8?B?ODVLdkJrNHZSY285b2E0YmdPd3dIWGhudHZrZkhuOHZMbVFpb2syOXJqMnB0?=
 =?utf-8?B?SkFvSmsyamVUdDNPbVNibkFUa1BjY29aUGVueU9kRHZRV05Rb0ZNL0JMZits?=
 =?utf-8?B?UC9LMzUzaWxaVUdFdWg0Ym5HeUJvWUw5TWd1V1g4WkxjMTlTYytpYjBYazFk?=
 =?utf-8?B?N2x2Z244NUt4NVhiOTUyWXc5VHl3SU9SVDBmK2djUE84enA4a0dvS1NUN0ty?=
 =?utf-8?B?SXZyZ2hjK1R1cWhtVk1saXpMWVdGdXhiR0lNK0w0VWcxQ3hTWXYrdzhwVjJ1?=
 =?utf-8?B?N0lLWTFVd2d6N0hJMU9ud01sa0NVajZjajE0WG5NeXhWQklZczEwSEJBamNX?=
 =?utf-8?B?UExLRU5seWs3THN0Z3BrZVBYMHN4QWVCOUlDb3I1MmFyaDU0MFlVQ2tvUzhD?=
 =?utf-8?B?VnBrNlZMRVM2SndZWDlKMXRCbUVneDlscXhTdjVrNUxaY2txU1dUemhwUXVi?=
 =?utf-8?B?TWZZNVhxL2F4UUgvWGVxRHlYU0pFSU9NSE9teFBiUjBOZmlHUTlJOVJld3FL?=
 =?utf-8?B?c3FOS2xNZTlZamtpemJnQ1BRVVQ1MGxEeDB5Nkw3NHIyYXVLblk2b0NxeUYv?=
 =?utf-8?B?bTA4TExsN1BFOHYwNGUvb0tRaE9DY2JIcHUwb3J6eUs5ZUptRXp6UWp1WGVX?=
 =?utf-8?B?YWcrTERhQmdFT29DM09hd1JXV2U1Zm9yZnhiMjY5TnlQMEo2NitzR3Fhc1k3?=
 =?utf-8?B?azM2aGpxR0tncU1uc1ZxUTRtUXRXSURSN3JPdGRSYVhKU0tBS0pqZVk4Vnhj?=
 =?utf-8?B?SCtPN2VhVHY5WlZWT3laNjVhOFozZHZNMnptckJYVXZSbWY5aitwVytQaThE?=
 =?utf-8?B?Zyt5M2d6M3pCakZCS2ZlSVhraEY2SytlWGxnbmhwZGNpbGJNWm9KQzBhOGVm?=
 =?utf-8?B?TWZvQ2pCcDZvdTQ1UmxTdWZYQ0EzTWJON0E2VUc4RFdoWERMd1JXZ29mUkpp?=
 =?utf-8?B?SGxQdmF5MTMzdGRDTEo0b2RUaGErT2RBN2VWeDl5alRNOUlHOHZmNlFzellz?=
 =?utf-8?B?Q2FSOXlnQ3dQb0lMUytScFdkakZCL0UyOFNLN1hVQkVyaGlhOXYzUnk1MFNS?=
 =?utf-8?B?NStpR3N2dFlld3BSMUl1OCswRnhUelprajkxWUo5VnR0Qncxc09POW9zcmo4?=
 =?utf-8?B?d0lLeWthbVdHbW9MZXhuQ0hqNUFOL0hUYmx5ckFLdCt5QjIrTkxhVHFpYmxv?=
 =?utf-8?B?bVdKcTd1UUdvSEZJYTcxSVlleTNERTBHOWpXQWozVjJNTG1yV2diMEJUd3Z2?=
 =?utf-8?B?azV3Z2YxczVjS3oyODExV1hIeldsaFBmdVpCMS9xOWtkMjlVeXNzYUN2ZHdr?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tc5adxK0W6K7izRdjpKOJ44Ysl9BL6N8bm+uBpy+x85PNZhhCMSGS7+slT1WxzU9l0UZYkNBLlbjrqKxeSWV5LJJnNecpMUHUY/g+5UOGpclsG/x+uUtGa6HZa8sIluSSd6KsruGeEv4ajYEyomWnCFVrha83hEcSJZgFimqd419HV7AUa6aXPUt2nuS5BVVH5SkeZa8IZ+7rNhOutD9nhNh/KaFME74+XIJJhkV7tU6lAzZ78Ffsg9WfyiO2Fzs3VBwO9zRiT4CmeqFixnnycPPbSVZkIdVfA06NRFmEP4sbrzXkF5ucss/OJrTLCNDfP7NCQOUp8ZMQMVIIS2yok8i/uppWPkSPl2L8Siip3NXh2scfD0tS4XJCoWZXAcjLa1xjyghaW7G/2SC664EMsUC1+z3sY1uDYs6Lo3M9xU1j3l3wi46tcrYkShHUQqr/IGdplkgc5k1hOf7lZCyFowW+3Embbw5D1WuOXV0IBPymn6MSlGa7xAFk5Ki+O4MNeyfRRdJjcFz5ASugJsEzvtPf0QfpYW4+ZjU/89YrrK0nnCtQ41Mq6qZG5+O2UNhlMv2LSWlB+WpgWQQXYGUbaHLPdfUlczqoM+Qiew7su8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748d89f9-73b6-40a1-c5a6-08de0fe9803e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:01:08.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERyrpnhtEeHsW/4FIKIdqpYYkODHYDeDVEtg0QEDCeg5jfeovPlTV9Tv9qPtIPySNuWUAAON1UUD7PTpyALpuc+86/msnl8hqkAal27Siyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX2jjJFDmzGe8W
 6WMidsGrZ0YnHsiuuUMOmcslzRnlYkWGckPnY5FB0dLi2gcVqs6euoW1JZgrKwEJL45CPeNYWHi
 rWFS/+zsPOT1Fi6v67rptISybDvEbBhFAI+w5qwFA1Q3XZ7iNujR7s+ioF135f8zUGxy/vfG3d3
 UCaoJ3pQxzfid4Kj65n9DpNwMpwXPJErTwL3pfs3F+nIVI4aQsq+Q0agt3UEqBt6gkMXDWwASEs
 xO8IAAIyvIzOBsyLeqFMK+DjGf+4JHIUzPCfB+agkPUFMZyyEMRi01vaEm7tg5RxogGgefx/Svf
 xr1kgxqPWkzPzc7AzuKpXbuerNPtY6uNeNf3l1kM/MXq2vayojGX1Rg4DP3n/lztUYm0+fIRz8V
 MKnHFGhuZ5baJq1BMm2vVBzlihQVlQ==
X-Proofpoint-GUID: UM8KT7xpoNJ56ynWJKiRzPTXhB4CTROp
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f64eb9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=0ViZBtRzkWvg1MalTvEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UM8KT7xpoNJ56ynWJKiRzPTXhB4CTROp

Jann,

Please bear with my questions below, want to get a good mental model of this. :)

Thanks!

On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> On Thu, Oct 9, 2025 at 9:40 AM David Hildenbrand <david@redhat.com> wrote:
> > On 01.09.25 12:58, Jann Horn wrote:
> > > Hi!
> > >
> > > On Fri, Aug 29, 2025 at 4:30 PM Uschakow, Stanislav <suschako@amazon.de> wrote:
> > >> We have observed a huge latency increase using `fork()` after ingesting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memory and forking itself dozens or hundreds of times we see a increase of execution times of a factor of 4. The reproducer is at the end of the email.
> > >
> > > Yeah, every 1G virtual address range you unshare on unmap will do an
> > > extra synchronous IPI broadcast to all CPU cores, so it's not very
> > > surprising that doing this would be a bit slow on a machine with 196
> > > cores.
> > >
> > >> My observation/assumption is:
> > >>
> > >> each child touches 100 random pages and despawns
> > >> on each despawn `huge_pmd_unshare()` is called
> > >> each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_remove_table_sync_one()` leading to the regression
> > >
> > > Yeah, makes sense that that'd be slow.
> > >
> > > There are probably several ways this could be optimized - like maybe
> > > changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> > > (though that would require thinking about whether this interacts with
> > > remote MM access somehow), or batching the refcount drops for hugetlb
> > > shared page tables through something like struct mmu_gather, or doing
> > > something special for the unmap path, or changing the semantics of
> > > hugetlb page tables such that they can never turn into normal page
> > > tables again. However, I'm not planning to work on optimizing this.
> >
> > I'm currently looking at the fix and what sticks out is "Fix it with an
> > explicit broadcast IPI through tlb_remove_table_sync_one()".
> >
> > (I don't understand how the page table can be used for "normal,
> > non-hugetlb". I could only see how it is used for the remaining user for
> > hugetlb stuff, but that's different question)
>
> If I remember correctly:
> When a hugetlb shared page table drops to refcount 1, it turns into a
> normal page table. If you then afterwards split the hugetlb VMA, unmap
> one half of it, and place a new unrelated VMA in its place, the same
> page table will be reused for PTEs of this new unrelated VMA.
>
> So the scenario would be:
>
> 1. Initially, we have a hugetlb shared page table covering 1G of
> address space which maps hugetlb 2M pages, which is used by two
> hugetlb VMAs in different processes (processes P1 and P2).
> 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
> walks down through the PUD entry that points to the shared page table,
> then when it reaches the loop in gup_fast_pmd_range() gets interrupted
> for a while by an NMI or preempted by the hypervisor or something.
> 3. P2 removes its VMA, and the hugetlb shared page table effectively
> becomes a normal page table in P1.

This is a bit confusing, are we talking about 2 threads in P2 on different CPUs?

P2/T1 on CPU A is doing the gup_fast() walk,
P2/T2 on CPU B is simultaneously 'removing' this VMA?

Because surely the interrupts being disabled on CPU A means that ordinary
preemption won't happen right?

By remove what do you mean? Unmap? But won't this result in a TLB flush synced
by IPI that is stalled by P2'S CPU having interrupts diabled?

Or is it removed in the sense of hugetlb? As in something that invokes
huge_pmd_unshare()?

But I guess this doesn't matter as the page table teardown will succeed, just
the final tlb_finish_mmu() will stall.

And I guess GUP fast is trying to protect against the clear down by checking pmd
!= *pmdp.

> 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> leaving two VMAs VMA1 and VMA2.
> 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> example an anonymous private VMA.

Hmm, can it though?

P1 mmap write lock will be held, and VMA lock will be held too for VMA1,

In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb_finish_mmu()
for IPI-synced architectures, and in that case the unmap won't finish and the
mmap write lock won't be released so nobody an map a new VMA yet can they?

> 6. P1 populates VMA3 with page table entries.

ofc this requires the mmap/vma write lock above to be released first.

> 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> uses the new PMD/PTE entries created for VMA3.
>
> > How does the fix work when an architecture does not issue IPIs for TLB
> > shootdown? To handle gup-fast on these architectures, we use RCU.
>
> gup-fast disables interrupts, which synchronizes against both RCU and IPI.
>
> > So I'm wondering whether we use RCU somehow.
> >
> > But note that in gup_fast_pte_range(), we are validating whether the PMD
> > changed:
> >
> > if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> >      unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
> >         gup_put_folio(folio, 1, flags);
> >         goto pte_unmap;
> > }
> >
> >
> > So in case the page table got reused in the meantime, we should just
> > back off and be fine, right?
>
> The shared page table is mapped with a PUD entry, and we don't check
> whether the PUD entry changed here.

Could we simply put a PUD check in there sensibly?

Cheers, Lorenzo

