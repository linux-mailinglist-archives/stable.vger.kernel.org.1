Return-Path: <stable+bounces-194447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B94C4C16B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19AF18C15D7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E73491CD;
	Tue, 11 Nov 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/ESDcGB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cwAWLeX5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A8341AD6
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845215; cv=fail; b=B36W6cCJ3uhvTyvnFNtk+2otvHwEVjJA2L6YCvObXE6YNkECVQx8ygDXNBNQYBiWLbrKextl3xNa6xG3V2QOrU9UJtmR8I3TjEOIsv0INDTu8+1xu1VKKSwZ2WVLY3GGsBJ4ujE7jyQzUm9/Mgn/GIkybi/LBwER1Rv87QLNdWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845215; c=relaxed/simple;
	bh=cIbNAoZW1iDI24X0YQTJOiiWpMKrQVF+J5sA0UL+R+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzkSE2gmNwWywQIj7X1pB6fRVdqDz96vI2KOAKyHuwOKQ0ACfSad08NQWGg6sVbMBzyupWPdG1JcLf80jXJ8iOhCiI8jBMm1eruMZtELGXuQMQh50sfR/JLP0Wa/Ay+cVUM4p8DObBWkGIGz6yMkBzZA6Eld8ia9L71hsvFmc+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/ESDcGB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cwAWLeX5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB78XNi023161;
	Tue, 11 Nov 2025 07:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=41Ll3giwPX7Odm9lGZTSjbCl/EJCEL0tto4z+2KIWCc=; b=
	H/ESDcGBk1xMGvqHJAXAsc2T40nN89dhbQz4/oqhzDhHTISCTNDIzLyarcm6occO
	ovpm6NZTMa6UJqgf8pBJBcGaSIfuXK1S9u6d4qWNUiGuMeG5EF971/VHYeQhOiMY
	4PpRPjshOlHlj4IqnMQM8gvj0A0ujgk7ZG5BnsfEjdfjVj0pk8yB97UD18YcweGx
	ZUDeMHc4exkWu6S7xIV4XlHBLi2fQ3VJN+I0OKWkKzbR1BmvNK+UKwa1nZlYelIE
	x7cUHOyxne3kuqlrw5/+eNZ2/oHORy/WGC8VaWIAs20N4iQj53iwpl1JHoEOf0HU
	566u4gk7uuHfYxaM4tFovQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abwkar7fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4wxJF039999;
	Tue, 11 Nov 2025 07:11:46 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va95n9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdxXzWr+TSCGevY8vyC1441NxZJzH9eMjJOzTy/MvqJhkDi/YUTD3cG1d19eiJQasO5eWWuKYdxDmexO54I4nO+TsjSaJRxkRExlGKvqDe3Lp5s5o4mWpUvpoQXVi28uFLquwF+sl1wfALxQz8cASP3wX2anKD9DrOl5wWTtlj7kyTpCTSANtxBtyt+lobAPsQh6i8tyamQfF60UMNwipxTYMgQqDMOifQV6UwKavRnzzTDZ4niRp5U+oRjPMQLg9SBkRT8k7XXFNfWieZiaSwXT/TbHfo5mm7MjEXXeC1U2TNdNkRrMM3ZQjVgaevcnt681ZaWzwEMfz4ytPVk5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Ll3giwPX7Odm9lGZTSjbCl/EJCEL0tto4z+2KIWCc=;
 b=u9QoykvzUYUVm1rnvuNt8fuLWZsRY9rx5LRAV28lmWjwyrijy1CDvJNTGkk6wMPBGDZLUTscSKjbFuglWWD86FQE7eLvT2LPFCs6HnUU1wCsSI81HexE0HcGAp56p/xFi2tyoXF02iMajdbQxkJ1/Nj1UQTyXIL/rOJt8ThvHWtiyiVkxoYQgbXa5Q0YbanyQ/xqEiDbvXkIDjp+ZZK8QU7p7KDDi3v0SgR1/U5gzqaMzSD8ojUTQ1nGAr+mBojuayL7UT+ivFavuiQo1vTHPIgZXQd5Y1Yw68w7zfsz0cSu/UIdNwUJiu8oI6KE6V7TxccZZSvqEydumeHY0qoYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Ll3giwPX7Odm9lGZTSjbCl/EJCEL0tto4z+2KIWCc=;
 b=cwAWLeX5AijLF00ARJcn0752nHKsv/pu4E0XzYUlzLV6Q25Dm5dsY1qLmNM3ZPl56bBI8YzpK+yBAXS1MKciwOnNJXl2WlpM2SXJ1xtT/YijhG5Eaf+P/bThY/u6BfUErWcOrCgR6GJvP+224bIgS9YaPwUne+N62XTfgyFQlMc=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 07:11:39 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:11:39 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@redhat.com, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Alistair Popple <apopple@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: [PATCH V1 6.1.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue, 11 Nov 2025 16:11:01 +0900
Message-ID: <20251111071101.680906-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111071101.680906-1-harry.yoo@oracle.com>
References: <20251111071101.680906-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0196.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::6) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e64f286-5d04-40e4-ba58-08de20f18ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2JmNlB5VlBnY1hMMTkwdEVEMk5aZXlubDNDNU1uY3o1VnV4alVTRXdEWDJP?=
 =?utf-8?B?MGl1SUNYWEZ6aVowbUFpcWZFaDVmeUNLaFlJUUtJcERSVDZudnBsZ1pLeXZC?=
 =?utf-8?B?a0ovRmw0V2M1TVlWbHFkRlFvV05ISWkycmYxMFdYTFhuWUo1MFFSMThDTXZn?=
 =?utf-8?B?ZGhxeDNJbXBPSjhkWUU2dEYxeUtRNzlVNXBjUURMZHFpUG81ZjBWemozUGZM?=
 =?utf-8?B?dlpDQ3ZFM2MvRmhDOTFiMDNKci93WENNV2hJY0RqNzNHNENmNU9GYmRCQm9C?=
 =?utf-8?B?MzRFWE1qdXBURDRmV01uNEpCUFIvUmJ2ZHpqblhCaStWUW5CNGdFUHdtWWN0?=
 =?utf-8?B?ZE1WalF6a3dqVFdxY1VmazFWMDZkSUdNMjdzQWlrYU1qRFJKQ3BmQ0w4dkEx?=
 =?utf-8?B?K1VLRnNsQmozeWlwbkZqM044LzhzMjRaTWQ2UXJ2cEx1MVYzWHpmMzMzaVN6?=
 =?utf-8?B?Syt0NkVROVFlZWNMTDNYMHhlMlBtcUNXK0JHUDg4TThkMmNVZ0xNTktNcUh2?=
 =?utf-8?B?Q2lDT1FBVW8vYUNYdTA0QmdNMmthL0k3V2xMS3ppTFkxZWlkanNTVnVydzhH?=
 =?utf-8?B?ZWUxWHc3ZTd0SzU0d0JZbW1RRHdFVWRYeTNubWh0SkhTSzB0cU1SbW1aNThr?=
 =?utf-8?B?dVhyOGN0L0lhV3BwdmtwZmhrbnJHSHduNWhqWlZRYmo0N2JsU0VBNlFnY0hr?=
 =?utf-8?B?SjB2ZmZad2tiZ2t6cURCY0xScHV6aVFVMFc4YXBUNkNRWU9NQmIrcmN0dG9K?=
 =?utf-8?B?UDVOU2M1MHZyblNMaDZBTGpKK0ZvVHQ1elhhcFJQS2FUemJJRWdhK0JiTGFh?=
 =?utf-8?B?MENic1lZbGhhM2t3VGwrNEJONG92TThNekl3RDUwa2loUVVSd0V5RTlIOUdq?=
 =?utf-8?B?Qk1EejUyb21YcjVOT1NqT1FoOXNsTHdyQSs0QzFvYWRMR3BhUXR5RjdDWG1w?=
 =?utf-8?B?SW00Um42TGovTnpjMVlGTVdUaG5ZME01N2RCMXU1SGw0amRvOTFXNUw5YlBv?=
 =?utf-8?B?YkpPMmxzc096cHdmT0ZMUWJEaVp6ekJkYUhBNGxTaENXMXpqS0pKeVZNU3dH?=
 =?utf-8?B?eWhYS0VOSEI5aXRpSHg3SmMwZ1phL1hobjZMTFoyUlZtZHpTYjl1b1lZbFZn?=
 =?utf-8?B?UlV5clkrUk9zZFFVZ0ZNb1h2RjFlM2ZwQitaWDc4MU5zL3lwMkE3NnowVGtM?=
 =?utf-8?B?UHk1VmhTVTNhSFlIUGNUU2t6VUhJOURrNm1FSTVFZVFaSmFMRU5CNHdnYkpL?=
 =?utf-8?B?MHI5bWJ4VlRGRFZaYXFYK3QvT0RHeENXZ2NianZVdS9BbzUyaTBLWisvRGZW?=
 =?utf-8?B?ZTR0WDVid1d0TFp1RWVUOWU5UEJtamVwSTBYc01kOGdMMURxRUNZSjhEbXhU?=
 =?utf-8?B?RGVkRVh3TGRGenQ4Si9sRkRiSS9pK2g4aVc4eEs5dW80MmtXT3BqcXFWbVdr?=
 =?utf-8?B?MFhkS2kyeFFKMUdRbThac05ZNjVLclZYVG81cmtKUzZrVUY4Yko3WXVzNjg0?=
 =?utf-8?B?S1hyMWtvVDBBZUp5VCt0U1hQeGVTVmtKL3gzbTNyVXk3VVJsOVhOUnRnMmlp?=
 =?utf-8?B?RDEwL2hrZ1NzWVpPeklsRjJib0xXNE1JK0hUZHorSEMxdWdFanlmQmNBWEFy?=
 =?utf-8?B?ZG11bGJmdEpZQzNPSFJCS3RNbTlLZTRjeUp3VUFhamJYS0lNQ3U0dTlzSlRn?=
 =?utf-8?B?eSsyYUlwcFRlOUtMR2xWU0xkRTdEQUlkUkx3U3BzQ1VLb0RBWXRoSWJyRkQ5?=
 =?utf-8?B?VWtsRi9HZjVrTXNQMVQ2QVVHclJXcXlOa2l2MFlDSU4va0JaTnZ0NUxGWUhk?=
 =?utf-8?B?WHY1eDMzQW15Y2kwUkp3eE5vN056dHFZditkaHNtY0VjZFF0QmRKbnRNRll6?=
 =?utf-8?B?Q3hsamlQb0Q2TVFqR2ZlRGZPL2dsNzhhdTZhYTJqVVhuaGNHUDhkZVR5c1Nr?=
 =?utf-8?Q?S5im3ppSMrgtWgEAGJwYwrSqerZce9Ob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmRoaGpYekh6aHJOVEc0Q1A0aEQ5SW1NTzVDMmVvTnFtOWxmWG1YRzN1U0hD?=
 =?utf-8?B?V3V1VjRiWnAvdUI4S0hhTmpGcWxPSHRpUVZtQW1DOWZhRTBKUkp0RjV2a1VN?=
 =?utf-8?B?bmMrWXRqazZsODVncFBxcVU0SHg5aTJqSUtDeElMRUE3aUtXWHBrbFpVRjl6?=
 =?utf-8?B?SXhvbDFEWTdEV1BGbnJYU2lSNzFDUDlvTzhxUHZIY3loVlM0ZjFZbVI4V2RG?=
 =?utf-8?B?Z2w0ZHhqN1V0SlFZWFVrMEJDTStRZm44OWFzYlU4ZzF0eTJaLzhEaHdTaity?=
 =?utf-8?B?S05OTEJHMWRscktVa3lZSEc4WDlxUDJiNk5Eb3EwTWNNS2F3dUtYUTNCSWdl?=
 =?utf-8?B?a0lTa0dzaEJ6T2xIK2V1SFROZVRUWko1KzFycXlrMkFDY3FPVXlJS1hyRVVM?=
 =?utf-8?B?YTVqMVhhSHpXdnhCcEJxbGFkNDBHRjIwa21tQmJENk8rczdEeFFPOXRlNUpk?=
 =?utf-8?B?MFJZczBDNkpmQUhraHBSZzlnNEZ6NnVNK3FXK3dWcnpGdVBKbGVMVzFrem5r?=
 =?utf-8?B?OG1yb3owOFppQlVKRm9MM0ZwUlN6VWN5b1dwV3Z3NHdlMUNEVWZYTnM2R21M?=
 =?utf-8?B?RFVXWG4wVnBna1IyWGhCdTRzNERXb2xVUlNqdnQzRkJnSWpPZitPSGd4bHUr?=
 =?utf-8?B?UXlsK2s4aElHVEtuRDY4dkovQTJsNnNCRnRBQjU4TS83VnlCQ2RFQzhjajJF?=
 =?utf-8?B?RmhuREoyVHZLcEJzbEY3eFVhSDk4czdxbnN1OVFMK0YrVFNuYjgyR2dORUov?=
 =?utf-8?B?bzBhQVdlSk9FQ2JzVGFqaTlTeVByY1ZxMG5Bekk5bWRvcnoxc29DL25RS1kv?=
 =?utf-8?B?N2hUVTBwaFFaOEtsN0h4b3ROM0dvRURGL1NUcU9QMGlHRjFBejR3SDN2WWFw?=
 =?utf-8?B?NDQwNXpjUXpHYnNFNG9LNW0weWFRZ0lkN0lvM1BwcEtWWXBvcHBseEh4djVM?=
 =?utf-8?B?NjFmYlRBUWp6WjZFUFJrZTNLcjlnRnJ5VG1acXhvRTFmUUg3ejVwdFltN04z?=
 =?utf-8?B?YUZ0V0haZ0duVlhPVjNZT3h4Y1RJNEpOMmZUUmJyTHcyd1VOOXZSZlFnaFJv?=
 =?utf-8?B?M0ZlWFplRWx4SElQZVc3NzhxOEl1UUQ1all4UE9idDVFYlpDeUtMaVVPbjN2?=
 =?utf-8?B?bmZyM1JzMmFZNFpBNlFtNW44eWE1Qm5tQVNYMXRod25wK204YWkyb2FTay9s?=
 =?utf-8?B?ekZIaUtjaGhsVDB6VWJBemhmQ1pHbjhsR1huazdYZHZZUERteStERFFMYnNE?=
 =?utf-8?B?V2RFNTRWTTdJNTR0dUk0emtEVGtBRnVtUHREM1JpN0ZyZmlHMFFPUzJ2TlFR?=
 =?utf-8?B?US9Xd1psbTU3eE5LeGFZRjZtRWpSa2Q5VHcwNWlmWUt3STRsOUdlL2ZPaVpN?=
 =?utf-8?B?Y1d6ZmMzSHY5bjFRVDlJaXJXYVMrZStGci9JY1dGNlVoSS8rR1FMVitSdHpn?=
 =?utf-8?B?b0xwV2MvUEwyQWp5cEFTb1kxcVRQRGJETHdyaUVvaFY4WnR1WVhjOWx1SWFo?=
 =?utf-8?B?Z1lYNmwxZkwwU2hJVUoxSzlZZHllWE5taUp0YVFZeUpSVTBNejVrTmI1czZJ?=
 =?utf-8?B?VUdZbFhxUE5Rcm9KZW1La3JZdXdpK0tGcEYwekl3Y0F5R05Pcm1WWlZLM1dT?=
 =?utf-8?B?a3VqOEdZRHZ1RlRpQTUzUEQ4MDlMSmtQNXRpclg4NjBRSTExdWlxQWdUeVcx?=
 =?utf-8?B?YWlqK1pIeHowcTJuem5kaWNzeHJyVTBabTZCRXlacit0cU1sWThZVk8zcnlj?=
 =?utf-8?B?OGNqSHlFU0ltTWhBZzAwRjdheWc0UHhVMDBqaTlaOUdrRzQ4cWlWb2ljNURO?=
 =?utf-8?B?WVUzVkxMeUFUMFl0VGhsOGpsUnRrZktjd1BxNXVJNGN1SVdTKzlza3pqWitj?=
 =?utf-8?B?L1lKMkhkTGNpQmNUcG5GNFdidGNNNlc5allNRnI1amdjRlBNUW4wcmpnUEpH?=
 =?utf-8?B?dm1XSHFhZHc2VzJNLzJ2azZ3WldLYTdtWVNEaUhKZW10dzA1ZG5Yb0x3Ti9z?=
 =?utf-8?B?REFEY1FwWnFxcGFKanVGUEY0d0RMcTRtZlhIa2dtbVVFQTZyUjZLYXRuNUtF?=
 =?utf-8?B?MXUzWTlWVzlrN2RtQ0lrREtVVWFQN3BGMVhyaDVtZ2pxZURyblQ3RWN6aEF3?=
 =?utf-8?Q?HMckVXrIbtE2QV63cR07SWYVS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ArArDLNjkwQmojZRzUAJ4boej0hK/ALHWLGr6uAkRghishM7jqHuCwcL3UCp34mihhJg8bEUAiPksEJOus88H9ljO/qDmMt8/zOIny/ynCMVQVLPN6Fqxuy6IH9GOB71myRLzwiqeJ4+nzTiwoVf42Fvri2aj/4Jvs6xqC+tNciuYlImAiOQ6mxGzNB+dxxISgbKVoZJdlDZy0qvVd2NcfzSKLdQB5wmsUeveP8B8PUOuH+njuPWkJxK2OScRItUJfk7zJKVqb/8Y3mnn50i7zh1Shw9eekDjef1gkrbLWwU9PQJy4fygyF4l3hcKVjqDq4NsMHJSZqWhM2HEv7g/wYloJbjv3ArpisHdg8mWh+2Jh90kMP94KQE1u1r4K2bzTNrzBjivgpVkDPPS0x8Hy4XegzF3gN/AgOLn6tG99U+kQJg7BVoHm+J36l3/da/uHtiYmds11Fr8b6zqQmBAJqoLws5co8/T7IW6ypKwUPNdEJ3Q6Mb7WRX9j7+Ymq3NE8U5BJ+ZlZ3N2GkFRb4mQUkdvsLDfZNKknvI3cVxWEYLlP1DcDmzD3/dpyK0O2bF23Mukjt6Gey5DDsxoLJyzdUW8Aa46fI89L+I1XSlhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e64f286-5d04-40e4-ba58-08de20f18ed7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:11:39.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx8aOqaALyz5GWSfSpZkll0w6d22m6f8iXNa9ELzS9PHR2yNwFdxeEo6TUwoqFlh714BXZ8jdK8fPZ+g4rAL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110054
X-Proofpoint-GUID: 2UoAZy2DV3DK_SeONmoBCvQ22-ncKgSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNiBTYWx0ZWRfX7ouHaecmu6Ag
 BX0kEPpnFqCZHnUyMebzXxZl7tXYvE5hJYPxnBH2YwAS0MWj/7j8O35rXcdqdJxkwT2QigtVisZ
 hLZfFcDi9O8pcREuN+hRRmePDlbXnkTYSYmAi6NeFkSHi2LlPKTQ1QVrXmqQhQupMLAUwVl69SD
 nKQChD87r6o+7EFveqtJ+2pO2H9/jdCdr4hHgqUpBJ/bMKO3co1erFK3MZKT7+bXT2iqnsCcXtx
 Tf5R6tG9RUhW+OBiDxqypojql7qbxoVZ88x0zujJd82emqMWFYvcPjokKyjN1S+LjHi2RQjL/hX
 8mlQMHKiDZqoJsaCgbh4G138Wyt2tHu3Ox/yJ+eu1G2AIejKoTgPqF4kYjYawoD8Dqc55rAQPaq
 UupoNbqTjisIIJUGa6WquZ9/JEdb5w==
X-Proofpoint-ORIG-GUID: 2UoAZy2DV3DK_SeONmoBCvQ22-ncKgSS
X-Authority-Analysis: v=2.4 cv=BMu+bVQG c=1 sm=1 tr=0 ts=6912e1b3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=VIDqgc_yIPV4B56qbn8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22

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
[ Background: It was reported that a bad pmd is seen when automatic NUMA
  balancing is marking page table entries as prot_numa:

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
    Unlike the mainline, pte_offset_map_lock() does not check if the pmd
    entry is a migration entry or a hugepage; acquires PTL unconditionally
    instead of returning failure. Therefore, it is necessary to keep the
    !is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() check before
    acquiring the PTL.

    After acquiring the lock, open-code the semantics of
    pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
    if the pmd value has changed. This requires adding pmd_old parameter
    (pmd_t value that is read before calling the function) to
    change_pte_range(). ]
---
 mm/mprotect.c | 101 +++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8216f4018ee75..9381179ff8a95 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -73,10 +73,12 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 }
 
 static long change_pte_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+		struct vm_area_struct *vma, pmd_t *pmd, pmd_t pmd_old,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
+	pmd_t pmd_val;
 	spinlock_t *ptl;
 	long pages = 0;
 	int target_node = NUMA_NO_NODE;
@@ -86,21 +88,15 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
-	/*
-	 * Can be called with only the mmap_lock for reading by
-	 * prot_numa so we must check the pmd isn't constantly
-	 * changing from under us from pmd_none to pmd_trans_huge
-	 * and/or the other way around.
-	 */
-	if (pmd_trans_unstable(pmd))
-		return 0;
-
-	/*
-	 * The pmd points to a regular pte so the pmd can't change
-	 * from under us even if the mmap_lock is only hold for
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
@@ -288,31 +284,6 @@ static long change_pte_range(struct mmu_gather *tlb,
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
 /* Return true if we're uffd wr-protecting file-backed memory, or false */
 static inline bool
 uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
@@ -360,22 +331,34 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
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
 
 		change_pmd_prepare(vma, pmd, cp_flags);
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
@@ -385,7 +368,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
@@ -400,11 +383,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * change_huge_pmd() does not defer TLB flushes,
 				 * so no need to propagate the tlb argument.
 				 */
-				int nr_ptes = change_huge_pmd(tlb, vma, pmd,
-						addr, newprot, cp_flags);
+				ret = change_huge_pmd(tlb, vma, pmd,
+						      addr, newprot, cp_flags);
 
-				if (nr_ptes) {
-					if (nr_ptes == HPAGE_PMD_NR) {
+				if (ret) {
+					if (ret == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
 						nr_huge_updates++;
 					}
@@ -415,9 +398,11 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
-					      newprot, cp_flags);
-		pages += this_pages;
+		ret = change_pte_range(tlb, vma, pmd, _pmd, addr, next,
+				       newprot, cp_flags);
+		if (ret < 0)
+			goto again;
+		pages += ret;
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
-- 
2.43.0


