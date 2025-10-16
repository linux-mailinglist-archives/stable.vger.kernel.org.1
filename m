Return-Path: <stable+bounces-185954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8ABE257E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C745E425EA8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291730FC33;
	Thu, 16 Oct 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atkLvEiw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D7x8JE2D"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490C192D97
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606513; cv=fail; b=ZegM8Z4RzA1ncN/eJa6euzX0pSOe1YMyjbtxqxKPpRVSq8DWGhguyawod9UD7ZmZhhcNi8AF+GVAPO6Ou9qmYKWgoNm/0YqofNeO08jYC9u21YuyAKOEQHHKPzPamSXZmbC+ayIeBeOSnx+LPN3ceQKTFKybj1RiUwvbKZKNgKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606513; c=relaxed/simple;
	bh=X3FgILzk/Eb5L/HXsSglINBeK4VkSUZKlVdDBQipbTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YP9MzOVZCfxDAdH/sLXVymWFQyFY6/D9jdPcJgRfcFCwShkJE79/JtcSO5SnauNWpswJsOB4598N1wbTEiBClM/ya08RNSf0pQ4P+C9oHUJUJzS1FL7FZIAQ3OASEy9YFX4yMYfJuLI2/HcqfEM0v/CiZDTAhgeqScOHnJ1TPR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=atkLvEiw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D7x8JE2D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6gEtk019047;
	Thu, 16 Oct 2025 09:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O8UKS25lDBZiUz3NcvDC8NOe8yiK2cqp/GiyJ8tHnkw=; b=
	atkLvEiwi1g9KSXMzTP9B0TDBOIIqlOOuHDBb6i5y5ZpGQ8dDERrr5IZ4WV3L09F
	mNpPb/oqbFWQGF94HDxk6xStTmjzTqLHrJ+1tnuDCJ3O707LBzyfNeHXLlrHnB+i
	8rNDwSqBuVhZ9mhlCGBlNzlewnvHUhR2wCGHHffN34Q2uBUOumPekhNvtGdKx+Qc
	Fw+MhJvfilICCUXFRS4laAix/kmJ9rxeDvEvj+CRi2YAQhmtKUzAf2p33QfBejWV
	T+ht49LYiqDJhli9tmNHOivx+48OqoVeCTLvCppHmMzlFWW0W8vwKPiQ9n0uIFF+
	8q5NK/qKTP690hxmd4JM8A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyrgj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 09:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7OVYk037858;
	Thu, 16 Oct 2025 09:21:28 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdphfnwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 09:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEWv/mBQDsW5rMpT4fdBqV0gFoVhKhzoSKYcGL5uW5G3BhQBbEZ97h+gr4YLr4nB57GJYfLXBZdXj1RCzSBKdV6xJGILYDnDzowc/g1UugKP2m8Z47ZZ+yoFN5jK4//MtDkrcX4bUt2Vlou74145+cvmDVhbyFQ+tKOa+b/yjhcpSxQkdxL+lGphPGcnJA0Ogj3W3UxHqfheLgODgtmV239Mtg7qtsRM52/YQ94pb+rZzvtUdhmm/+PujI8SVjcnONV1SQZ8Ma0xwmM/o4TIT5I8wn/KHC2raR8/p9mEhcIIyNP2rQYSO3+Rp8/2sMqwIfoH5M3/fOp7sI4LkMJ+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8UKS25lDBZiUz3NcvDC8NOe8yiK2cqp/GiyJ8tHnkw=;
 b=WQ2Q7ODIe0Jzezob7SUzHOMAdZ+4fbQl7kdFCVJrfWp3jT4NSEK8p/7QpFNl65x9jk1QMUhPPIFqOsqpe91WF8r2R9XTBOalPGwwKVt4Bp9HLbye0+geR/lC3WpxDcYBqU8ujpmn4ThXsHyGodlF7ik6jQw3t79yRhoU744njxQMUaSJY1Jjy+pV6s8Co2I7bTP5/loTcNupk5HYWJiQMQwvz8/S82MT6pwjuoReGTHgouD/aA4dv2taPRyHkueQyUukAuScKXHyWgGZpMugFeQUFRiMyBukfFn+efKdAC6WT062G3cvMiwCQxj95473aA1/JLTLoUob9MuVFLiB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8UKS25lDBZiUz3NcvDC8NOe8yiK2cqp/GiyJ8tHnkw=;
 b=D7x8JE2Dj/jxUOIjOAj3k/1bMl2PimJp8zCdqEoogYVpIk7DifP9FJbKLJv+Vq+8Bpp7diRTlaPc67qWwVUTinjEiNNqYLJ7ik5llv4pn+gx1EwDE7h5kGN4qXOHeMWYBJIvElrbggh0JIH5Wc+QvPHMSRgZXRyx0W7OH0owlo0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 09:21:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 09:21:25 +0000
Date: Thu, 16 Oct 2025 10:21:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, "Uschakow, Stanislav" <suschako@amazon.de>,
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
Message-ID: <45084140-cd90-4fd8-bd31-f1a8a4d64bad@lucifer.local>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f488f0-f214-484b-f3e0-08de0c95614e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnJlZ2FXeUdwbGRCOWdHOHNjTHRzTk1EWTZLcFMwaUtTQk9ybDgxOWtLRUtW?=
 =?utf-8?B?RHJQTTlhY1UvTDRQYW5sSks5ZEYzRWRnZlFva2dYVTd5UFp5N1E2U0k3QWdJ?=
 =?utf-8?B?S0tOM1UxRjhOMzdNbi9xRElsVEFnS1lkTzZNWXlEaWR2TGVMTXFHSzl3VGF2?=
 =?utf-8?B?SDIrYW9KR0U4S3M2U1dnTitBQVVieVV0Slk2SHZQdGlzV3RQY2huWGx2Y2E0?=
 =?utf-8?B?VzJTUFZIRzZPUUFrVnM3Zkl0TndDVll4Nm5YUXVEZWgvZ2ExbDZuNXhzRHVv?=
 =?utf-8?B?RmFOcmZBZ1dLZ2tycVFzTWhhTzJXeHJqRkE2dkxoTHpxZ251Z0RydjIvbjAy?=
 =?utf-8?B?WUl0RUxFT3hDUzU4ZUlhYWI5OVZKd0QxdzhMLzRlb1hGTjZNNGxXSVdxRmIx?=
 =?utf-8?B?NTFtdTZyZWRBUFEyN3RGS1I3VEJuWGE5bmVNMjBMcEo4ZU9OTkNtNHZyRUFp?=
 =?utf-8?B?VUsvVlEzWDgzWnYwRXlzUkFTdXRKWHhNa2ZDd251WnlDL1hKSlFWMUZtdUNv?=
 =?utf-8?B?VnlOL0FWaEZuT3ZyWDFEUVhyNlh2dGJ2dDRyVkxVNDVIN2o4amg5L1lxbytO?=
 =?utf-8?B?dmd1SFFuSy9MaENOUGRTcmZLQ3pucVN4QktlbCtKV2ZOZXpnUjZjZTdPU3A1?=
 =?utf-8?B?SUlRY1k1Wkk1Zlg2YWpQM0doOFFlb3Y3TW9Sc2lybDFWZ3NmSlVvQWhNZC9W?=
 =?utf-8?B?c0dEcjFUaURmb1RNK0hoblBlKzlUdVJqNTFiRU5yekdsUElnR2R4L0poYWIv?=
 =?utf-8?B?NjRkeXhCOU1pNW44ZXB4MFFKYTBTdHVoWlE5V0VHaFp0Rmd5eWZIaDJ2NzFU?=
 =?utf-8?B?OVl2TWhKQlhzVE1CZjNUS0h4bWtwZHkzOWwrOUNCQ0ZzeDRqYkZuQ2JjSHRr?=
 =?utf-8?B?cGowZW5aTitOd21OalgzZGVKamgwenhuRGtqcjJyZTdvbm9aTW0wMmhNYkRF?=
 =?utf-8?B?aEt3NllmZTB6MlZNVzdhRDJ0TnFrOW9Bc0FCZktBUWdRTkJiVnRDRHVraEVT?=
 =?utf-8?B?SVNPWmxjbUc0b0FyODZtUTBBakYvanF4cTIyYmNzZjhaTEU1REpyNWZjVk4v?=
 =?utf-8?B?WDc1STF6UThEQmxTd0NJRHBONUxmbGJLdGJqNXU0U24wSS9uSlg1aS9hd092?=
 =?utf-8?B?bTV6b01icEUycUNmSGpicjFSenA1SmRrZUpGejZlZE1GWkFWVDAzcm1panB4?=
 =?utf-8?B?YXJPRDBROFJETloxY1NPMWxBakY5TUNRT0hUOTlaSjd6WTZnTzRjam1abXdw?=
 =?utf-8?B?L3JoYWEycVZjekRsNks0dmlWVnliNmhsVTR5WDlJRU5xaXdod3ByNW93OHlk?=
 =?utf-8?B?RkZtVyt4YXQzMldUWWlPZGlmRXV1RDRPbmhZSy9zRUtuZ3F5bU8vYlY3QXJB?=
 =?utf-8?B?YmRaUHFqZTdHd1U3dGI3OUNKRExWSEV3a084d2xZWjA2dGw2b1ZXQStWOFpK?=
 =?utf-8?B?TmZIT0pwYVFHMEhXdDBSaW0rdmM0SjRzMVlLOWM5V2RJTml4aXJ0NFB6M1Rj?=
 =?utf-8?B?Qk5zaVpkVi9pY05wdmJIRW9GN1g1cXNSTGNOUU1MQ1YvUWxRZDNsMDNIay85?=
 =?utf-8?B?OHJzaDc3WHRtUmdvcXJSam1ySUFRNkhCSmYzRDdSUzArSUw0SGtzSXlOSElq?=
 =?utf-8?B?b1E3YlQ3dEhySDAweUJiUHZzYkVxNndLbUt4RFVQWUMzQVZWNklPU0R4TkJs?=
 =?utf-8?B?TGFMamhKVkRNQTFhV25wUUlUZFF5VFdrcVVrTzBZQ1pLTDd1Z0JGMUVWeDBk?=
 =?utf-8?B?RU9YL3dFWERjN1FFaHVSYmRvWEM1aW9OQXNGNkJBR3VrMmp4SFdkQnE2QXBa?=
 =?utf-8?B?M25NcXFnS1JvYVdjTlBKTVJpWFFIM1kyTE50N3YxM3haRTU1cFp6ZVkrc1FR?=
 =?utf-8?B?TW5ObDBaR1RCNXFka0lGUDdaSGFlb3ZBM0M4cjFpVkpUdDFaT29VMTA0MTJB?=
 =?utf-8?Q?6rNPukj0o48DIPgnBgt7ilJSQcT7uee0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmlSQVp6N1JyTzVxeDJuR0NJL3dIRkVXYmQvdlZoZDUrOU8zZWRtQytNUHZR?=
 =?utf-8?B?UmxuRnZBQ1FjaWhoMWRZcVFoNWhieG9Qd3lWWll1RFhRcHptcm1QMXZyMzhy?=
 =?utf-8?B?bzJQamFUY2xBenVyb2g3aDZhNjcyNHRkbkh1QTQvQ3RsTWJBVGVlY09ycUVt?=
 =?utf-8?B?QkpRVUV2RmlWcld4eHZBNFpnNGRhdERrbmt5a3ZkM2pFNXQ3dDF0S3FDdjcx?=
 =?utf-8?B?RkpVTXc3QUszR2U0ZEtZaXFPSHJkazZhZUMvQThxZXgyZVdLM3NneEY0NjJY?=
 =?utf-8?B?eGs3QTdXbGZKNlgrSTd3c0krQmQybmNkYlF3UUVWQlhyNXRxK1dOOVRsNGUz?=
 =?utf-8?B?NTNpYzlTeTdSSmM2WHUzSG9DZ3N2Y0I3ekhVUE95bHNEQWhJeHNlNXVpZTBJ?=
 =?utf-8?B?di9ENWwzeWpiOVVLZWlrUUx4ZC9aOXl6VU5QTDVHMWhYcGJ1Z0dGNXBVZFdL?=
 =?utf-8?B?b2pQbWlZRUVubUxHbTV6bFdJMWU3azhFbTljNE5TMDBzYXBJQVExRDZzYnZw?=
 =?utf-8?B?WVk3WTdkcXI4VWMvYjRmTWVZVjhBNGRZa2IzZFd6dnB2cHg1aGpzZzE0RWJ4?=
 =?utf-8?B?cHZTUTRUcFVtaFd1b2RCRVdrUFkwUzVLWVJNNzIvbjB3RTUyRktWMUdHTmhj?=
 =?utf-8?B?Q0JXSDVJelBSNXptVWt1K3hnOS90blZJQXEzSHR6MklZR0dsbWY3UzNUcmdo?=
 =?utf-8?B?VGl2SEFzbkV5alM2cG5TaEJNYngzQzFOU3dQS2RFbnRpZldXNlpncTU4djZC?=
 =?utf-8?B?NmVjSmVmZ29rb2pGL3NyU3E4cVJGbUtnbmV2enE3R1Q1a1JFNEF1YlluVnE1?=
 =?utf-8?B?cHJIK25CZzhBcnRocGpnR1IyTTEvaG5YWTFUQmlKUWdwbmtTdzhyM0xqd1Vh?=
 =?utf-8?B?RHo3UFkzbTNxTEw0VGVoUm5DUGhqRVNMWXhpNk94RnVPSE52M3hkQVBTbU9B?=
 =?utf-8?B?WFM0V1M2aFNkWHJFL2hiVE14cTBPMlVaM2hjQlhNRGNnYXQ0K3ZVa2E1aEJL?=
 =?utf-8?B?QXo1SHNhNmJES1BoNjk5bGRtRkFLQlNBaXVTcS9IQmRrZzR5RG9jVUh0NCtp?=
 =?utf-8?B?WmpwMnZ5dnRJd245M2o3dmlsRFdBdkhRajZYbWh0TlNkWlo5ZWpybGQ2RFpB?=
 =?utf-8?B?WWJlV205RGdHYUdlU0FYZnFMeXIyd01HdWc4bG1uMkR3dnZGS1dGQ3ZvSW1B?=
 =?utf-8?B?WXlJWS9manNkTDFkYnNNb0lnNFY0eEJweTBaYkFRZ3IwWTZmQ0tBNjVWanhp?=
 =?utf-8?B?THZRSi9sa0hycWc0eEFRTk1sRXIxK01OMzE4UDVGM2tSTC9MaXl3em5aT0pX?=
 =?utf-8?B?UkpIREUzV1FvakxHajlnd2hXVXkvRDA5ek10amRETXU0dEg1cUdIVmJ4TTNJ?=
 =?utf-8?B?UDVyNG9zbEhnRmtqU29wekFEZmhxdmFSYkh0UExvaGk4dXh3VEs3aXl3Nmp3?=
 =?utf-8?B?a1NFQ1J3ZVh5WERjN3JZV2VSR2dQQTQrempDS3FZd2ZJM3pIVEI5aHMrZVdp?=
 =?utf-8?B?SUgyTzhSeHZZeUM4YmNxZnFrek5OeS9obHRDb241NU81TzBqNHh3K2RxeE5Y?=
 =?utf-8?B?Y3NzVVlLVDlYMHlhNW1BbTBhNVAyYm9yN0tDN3ZnQm52dTYrWW44NWtjLzNk?=
 =?utf-8?B?MmtEc2poekwrbHJYSWRUbEptWlhBd1BRcW8yVWNENUx5V2NlUDluYlZiakk5?=
 =?utf-8?B?Nzk1ZTAxbG1jVUZzSzlRV2RlSTVncVE4RmwzNTl0QjdsREhPNHIzMysyYUVi?=
 =?utf-8?B?OG5EWEtVbUVMOFRvd2ZvSGI1WnR2dHpBcUVCTmhBRUx4QVV2K3N0TXRIMnJB?=
 =?utf-8?B?ZEVHTVlTVmRQUmx6WGZwTUZjTXVjRWRRVnRNY1VHZXNoQTc0ZmJZQUphTHlk?=
 =?utf-8?B?dHdSeDY4aktiMDlUVUwweXdtY1Zha1lvRnVaOTVpNXh3YmJCUlhPMFA1ZmFk?=
 =?utf-8?B?Y3pGeEUvaUJXTHAxMVQ3L0lwL3FhQXBIM1BlT01jTkIrWGM4UGlWZTZUWVdF?=
 =?utf-8?B?a0FKdE52NTRoUHpqRW9yODF5UVFlSjErVEkyUmJuZHQxZzk0a0tsdkRhZVly?=
 =?utf-8?B?d1J2MWFicUkzTkE3bU5KVEdsUklMZnlnMENFWnhBVDVWaGpObTNCMDYrWmNW?=
 =?utf-8?B?SVpKRHBNb3FqSzdySUFxWVJTRThTZ0RKaWc1c0YvUkh2aWlnR25JeVp3STVS?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GzeRSjQBHPXI3ymKzeoo6HzEg+eOW5/P/vvRL/zPujVX/ceNS6TznckkCSTNIYqHihe4j59fdcouSCCZs2pFtjG8bRjhSsY5JFgGr3IJ8xup0p1Qdb6u666ocI300pjkLINHXvqydOK0gPQnM2YAXGXJJEnTeSbPs9nzwekX+Oy2pjnit/AiPbXTLqWIN3JEWreIBlxx4UfxC/vEtavDlVQhMLV3sg5XclcIMVY2FodsA1iDj9KVlvphZId0j+L9Rt68Hyf6OJxaqIZi/pYUBP75r8uzRG5CUVdbFwuwYCSOA+ZGZcpw51Ft+wQOEgx7nOaTgjDq2eb4OTDPk79ak9GbiXxXH88TZsoiMjZfGfIZwIjq1x38tfWlHHoBT8bGuVrnwv8kQMWc7hryLf6IzhMELUfiWV/RnDI4D5Acntid+3CQgT82Lr/NzsxVUEOzdGbKG2cze/RAwtH8pjtVBnusjKGoWOTKqPeFrvR/ugjzVV+BHFcm8FU1pA6JWHkHzrS/G+5DIFwn8b1s7/M8wLdFJW9OGU/v8/wPfjbzr4n83VMwa1SbjqfZZKiQ9UUOgi0hE/tsiBumIvPnEaYssC8cgbUBz1SOCZ3AV+rgcbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f488f0-f214-484b-f3e0-08de0c95614e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:21:25.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XrzklOqodjcqqL5BNFGxvOgzQ307V4jjOyMYeEoGPkH6OBkabHwSl1chDc1Cx+XB6HCtFqjkGNnSO5ZOav7DRmtysnjuEThrfgnsgWWNMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160070
X-Proofpoint-GUID: BBN4x5XyVU52_efUZQQzT6Ka94QIIT6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX/6jBKqTS/WZ+
 RUN4N9UpWf+GyRa8MPfSfjYD5pNYswaNdMCOfX3K80dHsTWE5hedAXyZUHMHsK8JTqriqJxL/kv
 8HI+Q4+C9Mtnw6AjAivvYiIrSYxBaHl/juzYPCog2IxmME8Ns747GaW8YlrDEOi8Wbjs1NJJqgE
 5NECCC8ktawk5h2El9B6OmKBz1VQ3ht55Q/lzgzf+TGrf4x0DqsRITVq+QVLkrq6ZY7yaysxB5i
 /Q3RRJeivuljVR6ysWrOWgfrNqNSP1EXw+YQvk8w4oWdUVsCteby/8uiep4N6P7U4yr2vjZjX0v
 Ssoxf0AZ7UFo7yGm0SlIrZUhTqMQCMV1gwjR287NnaH5TYZ5kMyfBab9qJFkaRFB6bxI2oJ2I9Q
 d9PTmFou0luQoI6F4RZbwvgclhwlKUL+rpg9a6K1rXY8Roq1WxI=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f0b919 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=N6QRG5Ykv3gH4ozmTtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12091
X-Proofpoint-ORIG-GUID: BBN4x5XyVU52_efUZQQzT6Ka94QIIT6b

On Thu, Oct 09, 2025 at 09:40:34AM +0200, David Hildenbrand wrote:
> On 01.09.25 12:58, Jann Horn wrote:
> > Hi!
> >
> > On Fri, Aug 29, 2025 at 4:30 PM Uschakow, Stanislav <suschako@amazon.de> wrote:
> > > We have observed a huge latency increase using `fork()` after ingesting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memory and forking itself dozens or hundreds of times we see a increase of execution times of a factor of 4. The reproducer is at the end of the email.
> >
> > Yeah, every 1G virtual address range you unshare on unmap will do an
> > extra synchronous IPI broadcast to all CPU cores, so it's not very
> > surprising that doing this would be a bit slow on a machine with 196
> > cores.
> >
> > > My observation/assumption is:
> > >
> > > each child touches 100 random pages and despawns
> > > on each despawn `huge_pmd_unshare()` is called
> > > each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_remove_table_sync_one()` leading to the regression
> >
> > Yeah, makes sense that that'd be slow.
> >
> > There are probably several ways this could be optimized - like maybe
> > changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> > (though that would require thinking about whether this interacts with
> > remote MM access somehow), or batching the refcount drops for hugetlb
> > shared page tables through something like struct mmu_gather, or doing
> > something special for the unmap path, or changing the semantics of
> > hugetlb page tables such that they can never turn into normal page
> > tables again. However, I'm not planning to work on optimizing this.
>
> I'm currently looking at the fix and what sticks out is "Fix it with an
> explicit broadcast IPI through tlb_remove_table_sync_one()".
>
> (I don't understand how the page table can be used for "normal,
> non-hugetlb". I could only see how it is used for the remaining user for
> hugetlb stuff, but that's different question)

Right, this surely is related only to hugetlb PTS, otherwise the refcount
shouldn't be a factor no?

>
> How does the fix work when an architecture does not issue IPIs for TLB
> shootdown? To handle gup-fast on these architectures, we use RCU.
>
> So I'm wondering whether we use RCU somehow.

Presumably you mean whether we _can_ use RCU somehow?

>
> But note that in gup_fast_pte_range(), we are validating whether the PMD
> changed:
>
> if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>     unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
> 	gup_put_folio(folio, 1, flags);
> 	goto pte_unmap;
> }

Right and as per the comment there:

/*
 ...
 * For THP collapse, it's a bit more complicated because GUP-fast may be
 * walking a pgtable page that is being freed (pte is still valid but pmd
 * can be cleared already).  To avoid race in such condition, we need to
 * also check pmd here to make sure pmd doesn't change (corresponds to
 * pmdp_collapse_flush() in the THP collapse code path).
 ...
 */

So if this can correctly handle a cleared PMD entry in the teardown case, surely
it can handle it in this case also?

>
>
> So in case the page table got reused in the meantime, we should just back
> off and be fine, right?

Yeah seems to be the case to me.

>
> --
> Cheers
>
> David / dhildenb
>

So it seems like you have a proposal here - could you send a patch so we can
assess it please? :)

I'm guessing we need only consider the 'remaining user' case for hugetlb PTS
right? And perhaps stabilise via RCU somehow?

Cheers, Lorenzo

