Return-Path: <stable+bounces-205078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9ACF82F8
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B726F3009FAD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842693081A4;
	Tue,  6 Jan 2026 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OK254umE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jLjZmcG7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895D312829
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700320; cv=fail; b=tCGP9301HVZKm3PoiUA1wuD4c0vI2eR3nHtX2TVJPgNKNCUzEcl7Bs1Omorqsa1gzMCQoE6BQc8xqPZIk0FwH4J7+KAofwWLwG0tMmueCanY05p/mVoEI8u6PvMAwo6qsLy+oqnEruKbaVbPJ+V3dpMZ4j8Q75N55O50qEkY53Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700320; c=relaxed/simple;
	bh=ej4kyO3SegunqOGyXscxb0yQpS+MsE9Ci7aNkNz4tws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRFCOFU8ZbWzvZs1Ql/lt5VaRXhX4j1gBsUJmter7Iwm3N0XBdhYc/pecpGdEPGiieVU+sK4/GDjslA5IJ1ZWztQjjoyeXrldx54pUGQAd6sod81vK5nRvRteBFXmXlYl+ynRurURe0BV5jndDICwD/1ppXAXyfG7d8znI2YdLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OK254umE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jLjZmcG7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606BncQD3713556;
	Tue, 6 Jan 2026 11:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8VdTedqbTkdjd1Ux2zh5cq3MSgtXMsCtH+VHcuWDaRI=; b=
	OK254umEcI884FTZMSikrbaQg9tKdCoI7S+5JNVggehWbhl61XWlE8MAgEYIC6oH
	pTYWA/uDkD6gc415njr/LcaqE4GIW7BbsIjG8boI5EcBdca/QvzBF/sPstdsRVfl
	VQCJZ9fagCjU5uagXRizmVxXjRLNUATsICqqMWUvl0HDbt8QDjhs4Fi8Y15rylAZ
	lu6K+0g7vhmoOELuIDKHwcSpyfV8gCxYnAno0tu+Df62Guh7r4oOz0LTzX4XSriQ
	5aitttJIrXgeZVhaZGP1mNrF5cxRrLEUnGfjhvNC2CUnFzacRProcl9eU2YGmOHP
	6f+PJW2pwsbh1eLKlKhj1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh1v0g016-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606A5U49033958;
	Tue, 6 Jan 2026 11:50:55 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8g0xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnFdssXzKBQ23VZMueT2juCgI2A7hoRHuXugNMB8x6f6Rk3cbKoBAWVzBl6Bqzn4llrHKDKdlzDuznhYVK46VTUPMPdOlbwZAnUIlw70U5oyMvs523CZeQHlRdp93LZbF4IdalnOFEcRM/hR2xF69Nl/BpmMJkbk6wvt0GFYGvpQY9OTStuiyqW6unMtZHpanR32864BiPHDPPpgpexiFsTrP0Jgt1+VyGftR/ilCYTdJM8fs6AWX7zSwIGZvytt4WUTOQYuI4KHJdAwMpk9kzq5vFKnyj90NnQLecvSPRY1y/g1K0Xkaimib/etXPV34m6jkNGWEvhYrSJMrOoOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VdTedqbTkdjd1Ux2zh5cq3MSgtXMsCtH+VHcuWDaRI=;
 b=SrYpWqThraoX7DBJrgkKGPRPcyfkxogEc3l9f9s4NRO3xatmDz1PUT7EWTqVbkGqiVV0QRR1RmVaUjZLeldVQQkh1uZcg5z6A6M+w6V3lbVv57mE82ar9pZWkOyMKzw5y44vzfL3hItZqvOP2Q3n8xiTsp3g1HKLyThcFg1mPIp/J/aKHbXFoB+4GWQ2Zbn+xeY27WQxgCFGAaL3ZR8zvZP12MrfDvKKBsXnCtUll8Pr6E5x9lx7Z91Myknp2HbaPzhFae5l+xXMdcLZKvdyHVuqKlG1bbbbAQIz587oY1kbJ1DhtoX8/681TYNHOUYZ0AA6W9O9qY5KCKp9TFfzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VdTedqbTkdjd1Ux2zh5cq3MSgtXMsCtH+VHcuWDaRI=;
 b=jLjZmcG7sE5GW8aAh109kOkJRkOvjjWhOGkcJ20SIujmHa9pDzC6vr+Dn9zmvG6jQZaO4nnWXXMkYcIYbQplYbW34G6RYUDbYZDQywVfe/UmZDIZesLBIvOLM6si0oVy9bz8OHoJnZ9QVGLK1fZqYKe63Blm8tkx79n5BOkv5rs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:50:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:50:51 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Alistair Popple <apopple@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>, SeongJae Park <sj@kernel.org>,
        Song Liu <song@kernel.org>, Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Will Deacon <will@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Zack Rusin <zackr@vmware.com>,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.15.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue,  6 Jan 2026 20:50:36 +0900
Message-ID: <20260106115036.86042-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106115036.86042-1-harry.yoo@oracle.com>
References: <20260106115036.86042-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0071.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a2dd4b-91e5-4413-ce2d-08de4d19d733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXVPUVBScjdCdFREZVdWZ3lQbUh1aTVxem1lUTFNUDIvRHBZZWNYTnQzMHBO?=
 =?utf-8?B?ZFMrY1ZrdThadHprZVN3NVdFeHl0WG5sSjY3VEEvUkRPTjlkOGNiU2pvK09k?=
 =?utf-8?B?NkNGVlR5TGRKYTA3Q1hNbGVlNDN0YkVvUFlWY2t1STdtbERQSkV6L3E2L09k?=
 =?utf-8?B?YlZaeFRZaHhTMlBzVzY5SlBGd215Y1ZXWmhCOEVXcUZmc1NkdEZsWFB3UUdr?=
 =?utf-8?B?dDFJK0MrSVAvS2JPcFJkSFQ2VWpoOHExbUVwM2VHbFZyRmIzODRMTmkraENG?=
 =?utf-8?B?SUlGQ2hkWWs1Y2p1QStiK3d4dVlWSjBicXVNcWFHY1JCZDFuQmJ5ZXJIYWhH?=
 =?utf-8?B?RzVaV2JidGJWSlBLUVpNNHNudXVXUzNHQjIxQTRwTzAxbUo5b21hS0VCUjhq?=
 =?utf-8?B?RkgyWDZGTURqcXdQODg1TmhCVXdhTGoyOFVqeGlOa3ZPSXdSZVdhZnVVQm10?=
 =?utf-8?B?YkJkaXVwTE4xenozazh5UDlFc3Uzd2RxWkVmV01sUUJSRE56TFZrcjB5Y2p0?=
 =?utf-8?B?Vnh3ZzJvNmQ5aWJOM29mdjFWdjAxT0JyZUl6Q0VOdGEzc1dFWEUvbW1hRGJx?=
 =?utf-8?B?VFRXWmlrVUZLbUNyNGkybjgwbzdnVHNUVkZqZEFpZ0M0bWxOZGMyUGxINkhq?=
 =?utf-8?B?Qk9qL1FZblM4a2RDclNBNjMxcTE5eWhsa2hvNVJqZXYxUWl4ekVSZzBDelV0?=
 =?utf-8?B?Q0x0dEFjUVh1VHlLNFNLOVNBZ1A0V0wvcjlVWnA3OXVBK1hNRHJkU2Z5K1gx?=
 =?utf-8?B?ZmlwZFE4THRQWmp0NVhHdkF6MFJjbjFPSGsvb3FVOXVoR05TVThmT013YUp0?=
 =?utf-8?B?OThLdC9uVDludzI0QmQ5TmNJUWRnRy9oRWRUN3BVZkpPU01ucDY5OUVJcGND?=
 =?utf-8?B?alR3L0ZlVjg0Q1luL0Q3akdzWmZELzNUOXczamZPWDc0bzRsTTNoZ0NpTitO?=
 =?utf-8?B?endtOFk2enluay8zZWtIVEc4M3YxTWl4dGFTM1JRcFlVcklncW1PdU9uc3V5?=
 =?utf-8?B?UnhzeGNYY0lTQ01sY1FuMGxoMXRxY2d4L21PSm1YUXNER0tMTTEvNkZRanJW?=
 =?utf-8?B?bVdEZUc3K2R6Rk9HKzNVWjBvTzkyT09hdSsrWHB1VkNaWjRWODh6Vm5LMi9P?=
 =?utf-8?B?OFVZUU9TUlQ1YWpsYnhqbHNITUh5Tm0wRzIrVEkrU21wakR5UFF6NEUwMGpB?=
 =?utf-8?B?elFVcFF4bUVXd1RoazRRSmYydHJkMFMzNkIyTnJiaVB0aEs3enNQZFliWHgw?=
 =?utf-8?B?WW9pMmRIa1UvME5IMzF4RjRKeDVMV2xkZG9Jd1RUTzJyaHJsM1ltYlRwdW5Z?=
 =?utf-8?B?VzI1U3pON0VZNHJ4Z3FqbGRrclNxbFRNeitabmRqd1FwVU9CeWtoRDArcHhB?=
 =?utf-8?B?bFI5d1FEeXpiVkNMM2dET3pHb0QwT0FrelJWYWN6UUs0b3ljT1FFRmZ5SDFR?=
 =?utf-8?B?TmFUc2NsT1E2TTIzbUd6ckI4OGdTZWJKT2tueXNyQlpJTjBBbjhqSXhwQjhK?=
 =?utf-8?B?QW9qS1I0SExoSXhQaDBnQjZzR21xVXFnTFg0bUFxR0grSjYyaU4xZ05KNVd1?=
 =?utf-8?B?aU5vY2NSU0JTam1kQStEejZjcGpvVEJYQjlZY3F1bUw5UnlGdjUxcXl0Q0Jz?=
 =?utf-8?B?VC9nRmZKcFdiSHdNT001Uy94T2lHTy9wcVp4N2wwWjQ2eFpYTC9jaitVUWFD?=
 =?utf-8?B?ZmtJMXhXd3VkRXRVbWlTcU5KdHRlZmU4a0tDYTVXNmpZR0oyMGxwdE1PRTFa?=
 =?utf-8?B?ZDFudGtxKzVmRXV1QXlENmc1dnZQVDV1bW10NXJ6YVp3Y1FBL2pvanM3NERX?=
 =?utf-8?B?WGJQbmJtMGNLZm5uZGV0aDN5SGIrbXNHVkhFUTBqS3huRm5OUGtIUk1mWmN3?=
 =?utf-8?B?c1ZJZmZldjh0MTJBSXBITkZRbFU0Q212bWN3QWtyWlljZlJYTlE4c05wQTJW?=
 =?utf-8?Q?kofxtmjws2dmBMqfnDblBdC5UHkpdkKE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzAzWVNIKzFDMkdCWkJXcVU3NE9QYjUwMHpvRElQSjJlRkcyM0tOODZIMm5n?=
 =?utf-8?B?NTk4Z3paZ0VZUHVpUWlXbk55M1k0R2djNHpic2c4STBxSUkxVllPSURRQ1lt?=
 =?utf-8?B?NUFkbkRMWG1NWnlTNVlTblU3T2VvZmdGYjZzbzRGZm1pQUZiSlc2Ymx5WUMv?=
 =?utf-8?B?YVlyTWJEMkxhdUZuemdVVHcxcTVhaVdJdGljYlRTY01TZEVtbnEycWhIamw3?=
 =?utf-8?B?VUtOQkxBOTFLZ2NnZXJJK0tlWnFxS3JrU1g4emN6Zmk3YzBHRkF2ZmhORGlT?=
 =?utf-8?B?K0RyMlFpMGd2RkVEcUhQRWNyNXdXODNJV2dETDFXbWd2UUcrSUZFRTlEYy9N?=
 =?utf-8?B?OGRBSjRrcFNrajVsWlkzWGlGZEZ0ZCtoSVhld25NemxQWmp2ejhkTUFySUxh?=
 =?utf-8?B?NVBnN2haa29DY1pXODk0aXV3bTU1aDg5YkFnMmtEcFlGSUtKbGJYTXlxaVJ5?=
 =?utf-8?B?YnVXVDZhc05rU00wNkZpRzZ5K0VwZGlBc2VJdkZLcXFYRTZLbUd1ODFubFh1?=
 =?utf-8?B?bE9Vb1ZVdjJjSGRaaDNvN3NHVkhvTzk5d0lTNEVvNmxmRnk3TDV0L2ZPMnVI?=
 =?utf-8?B?QnJVc241Y2RzRFEyRGlTemVKd2FwQXU3MlBZM2J3Snd5VW1HTDhNaVdyRC9r?=
 =?utf-8?B?ZFRNL1VLWHprbGZmdlRXdU9MRUNocUNQY0ZqdXpIT1M3c3JXbDBqczVCdXBU?=
 =?utf-8?B?NUZQK0lyOW1pQ3R3c1RjRmJRaGYzMEZGa0JzWW9TT3NMS2Z4eXdCQWtPVHhU?=
 =?utf-8?B?MkxYME9XckRJNFhJR01jVkVCRS9XMjM5cWJsT3RjZnBsVDcwVml4SEVYOHpX?=
 =?utf-8?B?OTZrbTByNlJmUkxLT1dSWHlPNTQrN1BPaG9kbUVkTWwxNURkRFp3YTVSaUM5?=
 =?utf-8?B?UVY3ZUhlSkJhZkFjcEg4dnRTbzdhMU9oRmRFL01mRmNuT0FBTVRISmJKR09z?=
 =?utf-8?B?VW9aaUloYndEaHNRWlYrMFRkdjJZZGtEMDYzUHhTQ3NpUTRXdlBYdXA4bGZV?=
 =?utf-8?B?NWk5TVV4ZGIzREdxNUdSM2tPZzBCMEJhYmg2Tk1VWng0bjgxeTVKVTAyZXFS?=
 =?utf-8?B?eGlvbU9uLzVwRHAxTy8zekxwckFsbmNTcTlrZktkN1RFTGZMYzIyQ1NxZHhI?=
 =?utf-8?B?VjRCRE41UzZRb2NJT3M2ZSt2ZDh5dEducDYwbDhUU1ZZK2VQSG1nbWdld0RW?=
 =?utf-8?B?NS96dW1yKzBpaXNIR0lrNWkrMlN1dWt3WWJjZFpVTVN3NkJ4TWx2ZU9nOGlQ?=
 =?utf-8?B?K2c2cHBBVjZrR2V2RHprNmg5MU9CdmJ6VElzOUJ2ajQwek1yc3p1eUwrOWoy?=
 =?utf-8?B?cDBLRUxjSnVIUzc5dkIrUG1GalI4TWRSWDJJNUpFcnJUc1VVZGErYmRhcVJh?=
 =?utf-8?B?TSthTngvTFZSdFc3TFNGbUExZzZuUDQ0Z0VWNzRYMG1COHd0MnlZNzBGVk9I?=
 =?utf-8?B?bXM1RVZabEprVk80UG9WeHYvTGdkVHJPRkRRVVRLU2RUclAwaXZYcU9KamVl?=
 =?utf-8?B?V1orc0pnYndySjVRdTZTZ3BjMGhsZzhvQWFjbzhPdGhuUk5Hb2c4NnQ4Zllx?=
 =?utf-8?B?eFFsa0cvVjlaazFITDV4TkhhalJKUVBYMzRiK0swWnQrNkt2TFpUVm51RUhj?=
 =?utf-8?B?RHExSXJZNGJOSWhQRlduYXk2V2gxVWVNVUd2RUh6M0M3Q2h5bVVCemU3Qlg0?=
 =?utf-8?B?SWIzRVlmSmQ3dDZuaXNDNDBRK1pQNlpnejFMcXp6QldFTGpKdzdwWWNuVkdF?=
 =?utf-8?B?bm9KZzd4L00zd2ZabXNsZU01KzRRczQ4Qjg4ZHF5K3dMU2h0NWlDZ1BicEQz?=
 =?utf-8?B?d0h3QURVL2loOUtxZnJlV3JUejM5TTRyNmJoYlpUOUdOcGJNZ1lQRDk3WU1u?=
 =?utf-8?B?RlJ3ZUIycWhuMS9wNHgydHJ5NTk5ZHlSOXYzZVZGWHdWRjR5b3JiallwcGdx?=
 =?utf-8?B?R05tL0h5b0xWKzRCRHgvUlU0L0pPRDZMTlloQkoza2NpNGNBeTdCZHZnTk9X?=
 =?utf-8?B?Ti9IN05HT3d2TVZVamJ3Z05XYkovZnRXOGtZZjZWMmpYL21YWlhpTDlQRFNN?=
 =?utf-8?B?Tkg1K0lQUW5qM0E1QWJvc2xmRWNvUmJGOHAySGhwaU01MFJVcStURnVqVUx5?=
 =?utf-8?B?SlhlN3VSd2ZnNnJsVDhoak9lOS9Uc0MvajdpVlY3NVpQTWRtU0JBRHBrdmNo?=
 =?utf-8?B?QVluaDU1ZTBRTE5YYVByZ0k3SXdwd1JYdzU2amFTb0dFSWhXVktQSWltdW5T?=
 =?utf-8?B?QlJDZk9LVFFKcDFWbm9tenl5SndVb085WlFkSk8waVhZbCtTOGI0MWpRNGMv?=
 =?utf-8?B?OW1mczBvTVhoVkwxM1FqUkxtTVYzZU5lWTB5dWpoMlV3eFNWUURjUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LP7FPxcVjFPV9LhhpjbGU7kzovjGIUK0OGJfdgj/l+xXhvAC/+yVExEufF72K1nBWb3sZnYkZwQ4Ffqm62nav8WFZUrVMvwPl9DuXvqySLrXqyegyYrRJyS2O6ro6RjZlz7q8Db86AVuZCLh42biS+PUUgrCNlox6vz92Q6QhjselB3cA4vUCD1ht9aKinTyK7zn0F8QkSCda47CymfbFqa0R+BzRvNy0MSsU3YncCzNa35md3vekLBpX/Rzpe8aUvIsEzbtagTURM4TIzRRDc2rCGGq+bbImdrFYyPYUOSqNTPWhkL8LAMYgQc3eHvtav/iQnBA2Upg05LZc2Dqn0+p5l/QsfJyOeNk4Sq7G1Pbzax5FfFwRZ734EHtNKwZcz49jDAaAuvYaUfun3D+jWDfsLqswjsNi6y/CWrpXZAoOhCgmh12p/HJ2F+17QB74RftFS+WBBJYNUdU1Ns103suhJvLmzekqk6KHg9+/H0Osm1yKlMkf3ww0L6/v9kL7sozn9MEn+SFOUJmmCt/UiNxTDfL/QeQjodsnhj4VvVdsxR5xwUB8ms9dviohWIA4bkxVFICQ0+BDv5aT7/HVxaXys/SFrRMDbDoYgjk3AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a2dd4b-91e5-4413-ce2d-08de4d19d733
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:50:51.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leihIBdELSjMfcuIzTtMparaT+wt7jovw+BFARcAGAkmJx4GaR+3Ahak57/Wwt3ECwBJi43GF+qE2hj+GCY+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060102
X-Proofpoint-ORIG-GUID: -mb2j-yiqxIXYzrdD6tsF00XhDitl5ci
X-Authority-Analysis: v=2.4 cv=JPA2csKb c=1 sm=1 tr=0 ts=695cf720 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=VIDqgc_yIPV4B56qbn8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: -mb2j-yiqxIXYzrdD6tsF00XhDitl5ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMiBTYWx0ZWRfX6sBG5Ytr16Fy
 3Iwe2WC0J39blv0+WppSOsP2u1+DuNDcmfrf/E9NFwg5lbLtFNPWofzdec+IBGCoS9qfkaI2CHl
 pg723Z6qR8rWIfxnjwnzsQ4OEgridXCu6PIPCACyowcZkB+6yYHGBj+PK/9y08RjDvJrVQCDVYR
 8M9Ef+ovQYgDT9lBpY0CMP+9BN7/xLEXfUvSASvapVsX/yHLODbiZy7J79xhWQEhaHf42/v4JcG
 f9TeXjgfjBi47ePpnfrC1+NvutW1WbyCvJqfOeWCujYBNzPa7zk9iOdwXAGTKBmQgZ7dDIES5/D
 HL0WCfu4HHcI0sWQcgsjnbtOg3CHTS1OigJglIsjF5dGxLQdqbaUim/71GCr71FSPa4ONKoXHAB
 JI//Np08yOjImKDFGbTIla5RMSfio8CpczwTB3+ZXSh4zm/waUUj2Ujnhlh4mN5ZOojB/V38dXE
 BS6Hsjn5/b4VEcQ75qQ==

From: Hugh Dickins <hughd@google.com>

commit 670ddd8cdcbd1d07a4571266ae3517f821728c3a upstream.

change_pmd_range() had special pmd_none_or_clear_bad_unless_trans_huge(),
required to avoid "bad" choices when setting automatic NUMA hinting under
mmap_read_lock(); but most of that is already covered in pte_offset_map()
now.  change_pmd_range() just wants a pmd_none() check before wasting time
on MMU notifiers, then checks on the read-once _pmd value to work out
what's needed for huge cases.  If change_pte_range() returns -EAGAIN to
retry if pte_offset_map_lock() fails, nothing more special is needed.

Link: https://lkml.kernel.org/r/725a42a9-91e9-c868-925-e3a5fd40bb4f@google.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zack Rusin <zackr@vmware.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Background:

    It was reported that a bad pmd is seen when automatic NUMA balancing
    is marking page table entries as prot_numa:

      [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
      [2437548.235022] Call Trace:
      [2437548.238234]  <TASK>
      [2437548.241060]  dump_stack_lvl+0x46/0x61
      [2437548.245689]  panic+0x106/0x2e5
      [2437548.249497]  pmd_clear_bad+0x3c/0x3c
      [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
      [2437548.259537]  change_p4d_range+0x156/0x20e
      [2437548.264392]  change_protection_range+0x116/0x1a9
      [2437548.269976]  change_prot_numa+0x15/0x37
      [2437548.274774]  task_numa_work+0x1b8/0x302
      [2437548.279512]  task_work_run+0x62/0x95
      [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
      [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
      [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
      [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
      [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

    This is due to a race condition between change_prot_numa() and
    THP migration because the kernel doesn't check is_swap_pmd() and
    pmd_trans_huge() atomically:

    change_prot_numa()                      THP migration
    ======================================================================
    - change_pmd_range()
    -> is_swap_pmd() returns false,
    meaning it's not a PMD migration
    entry.
                                      - do_huge_pmd_numa_page()
                                      -> migrate_misplaced_page() sets
                                         migration entries for the THP.
    - change_pmd_range()
    -> pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_none() and pmd_trans_huge() returns false
    - pmd_none_or_clear_bad_unless_trans_huge()
    -> pmd_bad() returns true for the migration entry!

  The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
  pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
  by checking is_swap_pmd() and pmd_trans_huge() atomically.

  Backporting note:
    Unlike mainline, pte_offset_map_lock() does not check if the pmd
    entry is a migration entry or a hugepage; acquires PTL unconditionally
    instead of returning failure. Therefore, it is necessary to keep the
    !is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() check before
    acquiring the PTL.

    After acquiring it, open-code the mainline semantics of
    pte_offset_map_lock() so that change_pte_range() fails if the pmd value
    has changed (under the PTL). This requires adding one more parameter
    (for passing pmd value that is read before calling the function) to
    change_pte_range(). ]

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/mprotect.c | 97 ++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 58822900c6d65..9e15902771000 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,10 +36,11 @@
 #include "internal.h"
 
 static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+		pmd_t pmd_old, unsigned long addr, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
+	pmd_t _pmd;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -48,21 +49,16 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
 
-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_lock is only hold for
-	 * reading.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	/* Make sure pmd didn't change after acquiring ptl */
+	_pmd = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, _pmd)) {
+		pte_unmap_unlock(pte, ptl);
+		return -EAGAIN;
+	}
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -194,31 +190,6 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	return pages;
 }
 
-/*
- * Used when setting automatic NUMA hinting protection where it is
- * critical that a numa hinting PMD is not confused with a bad PMD.
- */
-static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
-{
-	pmd_t pmdval = pmd_read_atomic(pmd);
-
-	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	barrier();
-#endif
-
-	if (pmd_none(pmdval))
-		return 1;
-	if (pmd_trans_huge(pmdval))
-		return 0;
-	if (unlikely(pmd_bad(pmdval))) {
-		pmd_clear_bad(pmd);
-		return 1;
-	}
-
-	return 0;
-}
-
 static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -233,21 +204,33 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		long this_pages;
-
+		long ret;
+		pmd_t _pmd;
+again:
 		next = pmd_addr_end(addr, end);
+		_pmd = pmd_read_atomic(pmd);
+		/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		barrier();
+#endif
 
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
-		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
-		 * check leading to a false positive and clearing.
-		 * Hence, it's necessary to atomically read the PMD value
-		 * for all the checks.
+		 * between pmd_trans_huge(), is_swap_pmd(), and
+		 * a pmd_none_or_clear_bad() check leading to a false positive
+		 * and clearing. Hence, it's necessary to atomically read
+		 * the PMD value for all the checks.
 		 */
-		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
-		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
-			goto next;
+		if (!is_swap_pmd(_pmd) && !pmd_devmap(_pmd) && !pmd_trans_huge(_pmd)) {
+			if (pmd_none(_pmd))
+				goto next;
+
+			if (pmd_bad(_pmd)) {
+				pmd_clear_bad(pmd);
+				goto next;
+			}
+		}
 
 		/* invoke the mmu notifier if the pmd is populated */
 		if (!range.start) {
@@ -257,15 +240,15 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
-				int nr_ptes = change_huge_pmd(vma, pmd, addr,
+				ret = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
 
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -276,9 +259,11 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
-		pages += this_pages;
+		ret = change_pte_range(vma, pmd, _pmd, addr, next,
+					      newprot, cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


