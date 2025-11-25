Return-Path: <stable+bounces-196861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F061C83608
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C03AE86B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212F22068D;
	Tue, 25 Nov 2025 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aiHxmO7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J2Wu6tZB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98B21D5BC
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764047451; cv=fail; b=NJzrgZ6lz/jV94uAWKR7rJtTp4aNUBa8bO/wrBxjADa7FiObZ8oPOTmsn7s2/vyDUFR6zt9a7ljTQCFVvOvWUutVGybhCVIGX2Krfcx7FTUIykZwyoJTBb89Qmq6NpCzvJyKVO3JZCIDtNXeTHyKdX2LpD/7+NIi/jnfWM5LZvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764047451; c=relaxed/simple;
	bh=q66h19Xe2gS1n46dNIMcKV8lgZn0a/b30xRy40lL+0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sz7Ex7wHAddyGRNSGe1PccIoVKwcKwbu8OrVJJjS80z9sOeRQkcGskULkwLPGLvcLhDh3WyHs2qeL+oF8/CHR0IxLrKCl3q8GdDh4Vf9PMyOh5buiA8gE6kASSGh5yWLlHyDtK3jGlvN/3cy51ibX7HHJk0e06iWWPYwTTkZoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aiHxmO7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J2Wu6tZB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1ChuG2342923;
	Tue, 25 Nov 2025 05:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qs7EipExxATw/Y2cK4I+wnhi0+fzTLYKA8psZ4+g8yw=; b=
	aiHxmO7ZNwdgvlqDrGltfNP2OHOHuGPdwvCAooD6lbf6gyIDsMLc3ss/+j4u9tC8
	3zY9fJkxS9MOo5/0H2R7+6Z4K0w6DmFhG8tugrk4gaRiuLKkUezBBEgZ/bvApypi
	IJxjW1HhC4tEKL48DF7947NZdNR+zMHNfkh+oIXYVrs0od3JWaMGh5icv0daDKb4
	PgscrBqQEh+K6EnOhoiNqL7IM093aOREyRNbOWzjRNZsgpZdtw/iFBwOoXcZfN2g
	HmabhunzvGoR/uRqMqBMkhENuPeKNzQvLeEM0Ga7GQQV/G1F9eM+nbO9X4JzLKyH
	+ORPLu2O4VmXcObmKbiDMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkbduu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP3fZEA023147;
	Tue, 25 Nov 2025 05:09:49 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk0g7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSC+Cv1C3U+Lc4gNy5PfnvwgWQn9X2SxznY1wfsSEJt8mBkgZgGHnKLEvudCeIeJmFQjH+lxUEVAzsDbgXG3rvfaQDNtORVp01U+b7xGKXRuN4zQKW/jFdB+D2i79jBoFVzxwJXUY4pla3z1FdSwv0eXQGZeRtlAHCNVfDA2N/tKrkvM8t1E3fztvL+1tSXFyllqWHZql2OQFJ9kZrbfGOkIY5lW9bfZB9swMenC3SHVBhiQFGqJJELFOtFn7YOPXNQI/J5a3QNr8CPRHo4SjKmp1FauBIPDP5pNl+U+H2xcEdgkrNF6j23XUPjaQSxAP8kqBlpt+e83ldjcI+Yurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs7EipExxATw/Y2cK4I+wnhi0+fzTLYKA8psZ4+g8yw=;
 b=aLW8HPEXbalOMNel66lIGzK33NbKOZ8VZkGK2IUdbyORdMNpjgDtxYw7wBAl0v+kf+Ls2qxuw18Rk5XoVGN/lo5ySn5RpBFwD/mMQA1QHqFWKOCfHHQbPZmfBXraYUqIcSZaU0dddNDCEkprdmZhHqPTMUn5omzftR37NMrRVzLnilf5mzxf7Luwl5veYEbJvFAgshiEs46Pr3vlhuy17FZmaqr8wxOtOD9AhxJC2iSorba34xxPQgqSka7iZ36ZWiS0AoOsnLCy33o3Z+dyz+7kvK25fi0AzJo46HHAfRDC5ZpjAxY9zuWEh/yn2bR0UyBWWQfP1r+3wCRCPCjgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs7EipExxATw/Y2cK4I+wnhi0+fzTLYKA8psZ4+g8yw=;
 b=J2Wu6tZB26BVjs+BjzQ/WjE21UFXWvzzGNAAbitku8OfonuX3eKZbXYsOeX5Y95NiopkQp3LBY/oz7GTpBoveCc6aK67Bh2n0KfpHA8z8MGuSXSE+vVMzRVs52DtuAHBN5+iHIBIl19Xx85o4a+WMAH1kFQY2LRy+TrGedsi7TI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:09:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 05:09:45 +0000
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
        Yu Zhao <yuzhao@google.com>, Zack Rusin <zackr@vmware.com>
Subject: [PATCH V1 5.4.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue, 25 Nov 2025 14:09:26 +0900
Message-ID: <20251125050926.1100484-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125050926.1100484-1-harry.yoo@oracle.com>
References: <20251125050926.1100484-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0098.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c675ea5-5683-49ba-cd97-08de2be0d951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkVjZ3NkdWVHRUtoakVIbEFNU3dJM0NjcGMrajRHaU1CWjBGdFZRQTBzdmFF?=
 =?utf-8?B?ekFzK0ZqSmhvVWJBRHFZNnNmeEs1bzkzazRkSERneUd4TmxsTVk4eGNhd0xD?=
 =?utf-8?B?OU53N08xaDVhZ1VVajl5QWdsaDh5UStnS3gvVlBCTjhOSWpJWXpHdCtkcktk?=
 =?utf-8?B?NUpQMUN2WWovNlV1V1VhUkpwU0NCZHR0MHFhcU5Rd0VkQnVUTm5pVmhhQW1U?=
 =?utf-8?B?eDVWbUI4REdtYUg3ektuOXBTQVNMRnE3K0ZOSFFTU25ib09IOUFudnpNYzd3?=
 =?utf-8?B?S04xUGJzRzMwVHJ2aUNnQkJ4eXBiZnl2QTg2US9lU2xWZ0ZIMHBEUlNSU0VW?=
 =?utf-8?B?Q3MySmFadGRDelBYeG9xVzkyV3NGQWdrOWR6MXJ6b1NlUDNvb2RtY0FweE1M?=
 =?utf-8?B?MlJKRDFjQSs4M3dYejgreXdIdjQ2MHZ2ZlVlUXRiOFcxbFAwNGpZOWxJenhp?=
 =?utf-8?B?dUFvSUc1TEhVK3dvQzFVTlMrTkRJTUFXRWxLakk5UHZ6cEJtWW8rYlBWTmsx?=
 =?utf-8?B?MFJSbzZQb05OQVBObU9MV2dWUzk3SU5JRURmanp0NUpFNy9IVHFHMDI5KzFr?=
 =?utf-8?B?UFdFU3VJMURMTkN3RGhZcjNWeG1Mem4ycnZiNWZURVNSaERLNWpUV1o2TVRS?=
 =?utf-8?B?ekxiYVhRaHFhMnc5ZEtqYXRpY0c1RWlpeUJOOWRNb0JVZmtkOVhkcEZFZERR?=
 =?utf-8?B?NThjZ2M5Uy9oUW9EOHdNK0piZzk5SnJqK1llWEVvcUVTaVd4cTRPNTZ4UVpT?=
 =?utf-8?B?S3E4Tjc1S3VEME8yK3JJK3FNN0dKbExwd3ZRSkNnVWdSaXlCNmlmREZ5dXZu?=
 =?utf-8?B?WCtDdk92alRBRXg5d2ZOQTlkZm05SWkrV0FTYytnbmNQVFo3UW5jWllZMkpE?=
 =?utf-8?B?NHhKakE2V2FteTJIQ3NWdE1SanlMSkE1V1phWTNmK0ZSa0VHUVV3b0Q4OTlo?=
 =?utf-8?B?WnZRZG91VVFVbTFPVXJyeTF6U0ZhWXZQbVZISE5BWUhtb1NWQ1owWnAyb3RY?=
 =?utf-8?B?MFJEYnZVZ0hvRFYxYmVkSXNKajdTMTgxdy8rY2NkelhLZ1NXZ29VOWJ1Mjdq?=
 =?utf-8?B?aFpRNFZrYnFIdFE2bGFvQ0I0dUF2RFhKbmlTV00veXBSWUY5Yi9jQnVzN1Ja?=
 =?utf-8?B?Qm5oTW0yWE0yQURUNWYzSURaeTJVaWROM2EzMHB3SjJqempwSG5CT2pwaE5o?=
 =?utf-8?B?VWlNWnVpcmdlM3UraG4yOE94bDVaSmRWS2N6a3RzdmVUMlpUTkRwOHUxQzRX?=
 =?utf-8?B?cGZ2N0lsUGtjKzVlQTIrelNmZUpMaGpGdnB4U1lvcEQ5RVpqd3RSYXhKNzQv?=
 =?utf-8?B?a2pGeTJpSUpGZGlvdHNBbkcyS2lqRzV6bXRFYVlGWXlTaEFyeE5PUlNYWE9i?=
 =?utf-8?B?MEJVaHp5cXNhSkd1Y2VnWlIwNXd5QWRwb1lNV3FGTzBzOS9oYS9XSDlsWDIr?=
 =?utf-8?B?RFFNTzNVMjZkRXhINnpnSUhrOHBxbTBxOFB2QWRLU08yN1RPS2REZGpKZnpM?=
 =?utf-8?B?RndYMVBMNnMwbHlDRmw3VEliWDNwTEFKd2R3S0c3bmNqM3VvRkpJVitoRWpJ?=
 =?utf-8?B?RXhndWQ1ZWVyZ0twTENBNjRNeXRnZGFUTFBzYmlGK2RVRGZYczNST3VERXlz?=
 =?utf-8?B?V09SY0N2WXM2WGxNM2NoR1NKZHcySi9qb3NZbGUvZis5UktRYTkvWXlyWjRj?=
 =?utf-8?B?RTFRbTluOU91aDU1RXdMVVc5YVpkYmp4MGt0eVE5a2tFYnZZalo3UlpNamNB?=
 =?utf-8?B?RmVtSStSK0dlbmdjcUFDMS81ZXFoeWVPdlVpQllCUUVzdkFYU3dlTHdjMXQz?=
 =?utf-8?B?dUNDT3dWNnp6bXJFOHd3bFNMUUJTYXdFMUpobUhmSS9aOU9rQnhROUVjQzhI?=
 =?utf-8?B?Zy8rYVNpRlgxVERtVDBSbVFQakNjVnNJVWtad1hFbW0zeFNhV1pZVnFFWFBC?=
 =?utf-8?Q?3AyrR0cNSVKPWglY8nyKONS0a0c+FhLt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lZUzdraGFDU043UkNnRkFwcnZqc0VNWjhwR3hob2xENzc0aEhBd3Q3eGEr?=
 =?utf-8?B?SmRsVU5DWWxvSWFFTXZWdGdMa0JxcmdYai81NDM5ZjcrZUxCSFRqbWlPUnJw?=
 =?utf-8?B?MFdhUjFheE90YTVhazhoTUl0anNydUFuY1FRZjYzdnlTRnc5YWxqbmNJTE1I?=
 =?utf-8?B?WTk4M2dpMG4vdVVCUWExbS9BTGpUTHV1Y3pyK2NVd3FVSlVFbVhtcDNJVzhU?=
 =?utf-8?B?NjhydHZSVzlHVmQyZlI3TmhpbmVCTmk3SW4wVEpVTko2NFM5bEthMmJvVm05?=
 =?utf-8?B?dXZURE5PKzAvbHBYcDdXT3VDT29kWThWWWgwUlhYNHlkVWRpdGpESUE0bXE4?=
 =?utf-8?B?dDByeVE4ZnhFZHJaeUNsODd2bzJyUnZBTUp1ZlpzSzhEYTh2OEU4ZHRITFlU?=
 =?utf-8?B?ejBWUVgrOHpIa3l6eVRkTVFzTXl2dFFhT2RNVWRua0pPb1gxUzQ1c05Ub3ln?=
 =?utf-8?B?N3ZNZERvOHBkMnhhcERtMTlCQTUydHVleGZxZlpOVUFHbFl6RDdXcVpFQnRw?=
 =?utf-8?B?L3UzZnloRkljTWpFR2VpUDU0SmkxKzlHdlJNeUthMVJINENaMFdISlQ4YW5X?=
 =?utf-8?B?aFVBLzBtdFdoaDhONlBELzFBV0lKUHoyclNKRTVwK1QyRmRrVjhMSTdLYU9l?=
 =?utf-8?B?RHJsNGNJaWVSeEwxNjQ3WGRFQk9DeVpCM00xK3RQb1NxQ2xnYWY1VVRyTnhS?=
 =?utf-8?B?QVZ3VVpCZ0kyc1FFU3F0ZDNkV3p1dXlmL0d6dmZjRElqcWJTSkZWT1VIRTJ5?=
 =?utf-8?B?Wkl1a1hDMEVKL3NZY3NWbTExQ1ZUeENzd2Z3dmtid21SV0EzWlJiTmYxTGF1?=
 =?utf-8?B?a3hOd1NjWm9PdVpNdlRqY2h2NXB1c1BHNVFWMFRodGlkbHg5VE5lLzlpUDVH?=
 =?utf-8?B?K0NGb0dyRFZodG9Cek1sZ3JncEZFeEZaUnJvR2Z4bWxZRld1cWVlMjJKd1Nw?=
 =?utf-8?B?UFBaQlhqTUhQaTVtK2U2cGdEM290QlJ6clEraE5HUjFLVS8yRXZuQy9XZHRa?=
 =?utf-8?B?VFd1OStldEgzSm9OTDVaeGZrRDNsVWJGa0FJZVQwNlVSV3Q1R3hqemx0bktQ?=
 =?utf-8?B?aFZabEZLbHBCSVVsTFJPbC9tZ1RjNitvY0ppQitnZlJtY0VaVnBkUXNtTEh6?=
 =?utf-8?B?eDZYNDk1WDBwS0Q1M2RyZ0M4US9EOE9LV2FBei9EQWNNdUx4UGdsREJBbkY4?=
 =?utf-8?B?SzhHaFo5Sk42dk16UFN1VEo4UGNiRTZiMHg2UnNWZlM2UlMyYkpncVpMbVRy?=
 =?utf-8?B?UktFNXZXZ0tUbTVPZWNieXhmbU53S3JxQ2xXUC9vVDNISlhZNjFwYno0bFJx?=
 =?utf-8?B?eHhQcXF3Y2ZGSk5tNUk2RXYzMXgrMzN5Rk1DRm5ucGp0V1ltOVVuaEkxM3hq?=
 =?utf-8?B?ZUVhY0JUM1VIa21MZk45SXB2allXLzBtNytyYUxXUU1PbDU1a0FkN3lRSysr?=
 =?utf-8?B?ajVsL3d1TS9PK0UxN25UUTFGVGxoQ3BwTDJRdk9vSlFYMi9HRzdhbVk2eFQ0?=
 =?utf-8?B?N05TYlRaWkFwc3lLdGZjL3hUVGo4SXVzb1dCNkVPT1JyZXJoNWltbCtZSTJj?=
 =?utf-8?B?WU01ZWNnU3hxODlQSWk1a1kxS3Q4cjlKQ3djSFQxeWJsVXlJUkxRZkhiRmll?=
 =?utf-8?B?WStlZE9FNWZCMDZPQ2FHMVYvakZCc1Uxem5YMUlocGpDOWhVNzdPRnBjNWNX?=
 =?utf-8?B?VFpweGFoaHNWUldndzNGNG4xWTVUV2VVdFh1MEp6cEthbjV3Y2h1WlN1LzdL?=
 =?utf-8?B?ZE9EaTVFTi91S2NJYmlSU1FZem5mOEE1anREUTBRVk03WkdDVFd6S0ZsbjRj?=
 =?utf-8?B?bDUybFB4NDNraUl3RlNuZjlTR3BZL09iRGZ5bk02aFhSUFBGSFc1Y2I5S0hs?=
 =?utf-8?B?dzVLUSsrNTFWWFFaVHhvVjU1anlFMGNoZWxkY0xYM3EzWHMxQ1RsQWdmMmhn?=
 =?utf-8?B?a2VGNjFWeG9TcTlWQzBXbEt1NktEeVZyRm1DVUs0OFRqRVdzZFN4bUxhN1lw?=
 =?utf-8?B?L1o4WHZvZkZxTnFhMlI4Z2NLM2tubjFCWEwwY1BRWU5LUUlDanMxSTlOT0dV?=
 =?utf-8?B?Y295LzFGT0dDTlpWUmhMZGx0SEdUcXFPZDNMUEJSb1dGVDkzNlVhMVdidG9F?=
 =?utf-8?Q?519h0Vmuvkz5HQSN0W67SkUPU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pscEljDP+wSRtrDm1D6g/mUHAeFIXTp4atBsjpuXgtl0eyWPtiBiNh/c1A04QrGxm+pkxiN2Ave8WdMrOnY6K3nkaKaNAfIzREZzFIetsQlraRwIl6oGKnNroWoezDAnAOOragAgTlfYEyd+CNY+06m0Wgrn+v6OlFJeHBJ9Eod2h32Qqrer3TgB88mPYhxLk+U6MP/Sjedir1LQ4KUw7dw7ifJFuDoHV/zK27dp/7kOyO4y8wnPTe8gUfrEWfrEAFtj+M+uU1cF6KdJcRRnvjFzMaqBRX9zPSVS6VTCLOLrjvmMMuwm+aoqI01x9ZXhRzJ5SlgzgDtClqkSz9MELfDt0WzZyUp8RuXXCXvxEUuQWf/g8adUlSVvtOShbUn73J1eqeRJneDQo3OUlV0lRAQI2qYTPWJ2+0E8zBQT8R7TNz6otL9hWfnPGQE9u4ysUatXXsVtv9dr443UdfV07yEDsjs0eE/Na9uaJ8pVIptQbxtFeVHiGdreC6rUejfSsaVDcKEF0w7XGeXcTNbKg58q3Wqrk3NYuk+2wYRzPflTu3Znd/SCaVd4kM3B8OeZkLIs5Vj+cZFENqeb+PWUW1PuXJ8fHaeHFe1UXaY4aZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c675ea5-5683-49ba-cd97-08de2be0d951
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:09:45.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q6hiXJNaO7why1xrEQdImuXlCk9pxTJ9ngbrd6KVkGhQc7GIFqoka+GnzhzgkZkk94iXY1fHeQak1JUyvui3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250040
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=69253a1f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=K6bJOSjN_L0kULG0WO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0MCBTYWx0ZWRfX46Jh+ytxi0Ht
 1CKhXalpVowjKsuMqWrkTs5lAPAzP8sbprhbKPQ157BBkcBMRg9Q7+eIr+qO7MwEltZ3i+A3iqC
 YF2jPRVtGnq0cQYt+sU1kIUos6PQrXH8Z3jpUrLA2vM0reaw0PBjdl7qA5G7vG+B6R/gJk4wFc0
 u7ug+lxUzHDkR28iwIdMR0ArOfxBEExP7X3OK+V71a8qRM9nVmDYVBPbOcBwiTrRV2nNlSC8v0q
 JLO8DI9whHxqsoSWGCtFON9kQA/k1nMUFCcwHOpayY0NCl+OZScroRpecCNlPMYGcCmqdzMvAMY
 VWLwP28AKNA2zB5tsVxaRBXEdJ1jE98brRhBsKVG0l0LT6D6/b8rp9a4lHJlegAIDaXbUywQC1P
 cHnzjYOJBq+Y+fufv85j86KkozjEk8L0oY3YYY2Z97HqDh7zOjM=
X-Proofpoint-ORIG-GUID: 7Gcw_7wdlO7jUHTBwX7GsPbbvo_Dzzr8
X-Proofpoint-GUID: 7Gcw_7wdlO7jUHTBwX7GsPbbvo_Dzzr8

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
---
 mm/mprotect.c | 100 +++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f222c305cdc7c..3b2f956cc0619 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,29 +36,24 @@
 #include "internal.h"
 
 static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		pmd_t pmd_old, unsigned long addr, unsigned long end,
+		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	pte_t *pte, oldpte;
+	pmd_t pmd_val;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 
-	/*
-	 * Can be called with only the mmap_sem for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_sem is only hold for
-	 * reading.
-	 */
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	/* Make sure pmd didn't change after acquiring ptl */
+	pmd_val = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, pmd_val)) {
+		pte_unmap_unlock(pte, ptl);
+		return -EAGAIN;
+	}
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
@@ -161,31 +156,6 @@ static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
@@ -200,21 +170,33 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 
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
 		 * Automatic NUMA balancing walks the tables with mmap_sem
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
@@ -224,15 +206,15 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
-				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-						newprot, prot_numa);
+				ret = change_huge_pmd(vma, pmd, addr, newprot,
+						      prot_numa);
 
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -243,9 +225,11 @@ static inline long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
-		pages += this_pages;
+		ret = change_pte_range(vma, pmd, _pmd, addr, next,
+				       newprot, dirty_accountable, prot_numa);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


