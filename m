Return-Path: <stable+bounces-206088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C7CFBD5F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CD6430034BD
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11C241139;
	Wed,  7 Jan 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZHSFAW0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/Il8laJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB122541B
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756439; cv=fail; b=JoOLzrZ87SbIklGdKi6ZUPavd580NgBDVqmIcQPSgV7LvBoH/fpPNsaGoj565VPRvuOdB+OCdqUKbsLCklZXbbfsbYhGK9FdF4m96R5a2h8kpqVF+ROzMdursQCksEeCs8ijFU3HSTNgZ4dACfJCAgRepnwohGSTWR9cStgdydI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756439; c=relaxed/simple;
	bh=tVQ+3+c1IwHyLz8pU6M909eT+oOYwdz5s1ikyzcufYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Scsf9ZXfVlmWxUX8Bxvgpi4fBT95agcjRLpGCyOsUlxvkNXJtrhYkEH9iUQtz72EUKpJ9pcd0MovjgLqzH0EpAisepRmWDiHEYon8FzYg1YrY8uh9YkavVzql14RL9upmWWhjibdDBrfb5xSZDWp1Vyn+KtB+VaJ2gZSHVvYlEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZHSFAW0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/Il8laJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6071PU9A942617;
	Wed, 7 Jan 2026 03:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LeUUMf1rFyNspyRtZRfbRP7vXSl7buaos26NQWfCuGk=; b=
	YZHSFAW0AqnVRdSdXxuoOg95beZm2wp7Mypnz55IM29Cue8M2oLwno1Ih4dKPvfQ
	8OT6b4BE1D66Hz2+Am6Wo85tBGHkE4+eAfEdrjXLNmXYqR9x1PDYDev2XKP//qDB
	yqKldomrr7o2/5NsEwQYaoMm0z+r+htDMZfCO7FmmIqSbtIzuKAS7JzjEDmZhGaK
	2HfBZQHlHTFEF9LnH2bnBqiMyUmj2eaBEFlGUHigm26IfpYeYqIYDgazXg1F0Nyj
	gwvSPiCW1IhTC1JiamCgjrQrRNz8scwgci15EscSNUBrm1YcbHUon8XvIcZaEKNx
	75qQegyMusk7WFz+BnfcZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhdsxr25a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6070cnqR013571;
	Wed, 7 Jan 2026 03:26:16 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj93phn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX7TXg5AFGqsO+05dBnXXqf/kOrdr04iHK0tleqTSpql7LmNT+uyTgYl8DDxTQVOCPWDvLIrwiDSkoWT5C+EU7a2GTFVGcOBL7Z2Hj7M6rqtbtJtSRNCGtBvGvwFgGaCluRi7DCkE7ErSZqfxAI8j9hA0fliuu/IsHynYqN0SZODU7CilOLdPGjEacDPNfTlU9XaaMH9av12AYIg5lSrYB17jzI5DPyGG726pAMJhy/U/yBT+qEdGX8It2vVff2rPGLZNbqQ4HuEe0XLSVtlWdSHlz37gj66lYRVO9Fh4jzlZHbtwpuzoI9z+BjCohxaIC1Iil//Ampk0LOxS15+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeUUMf1rFyNspyRtZRfbRP7vXSl7buaos26NQWfCuGk=;
 b=pESF3Y57e2QhC85BhDJAnr44GR1BVCCio7C55436lKP2Nxd+xIeCfpUyJ3Lxc/VRm35QLfdcklHFthJPlWznND+vI/N4E9x3gN4VdPhQ4HBcz5LmzSZGR+Ku+gM20MP/pIUv/ea/ImSA8Kim8bs28mJgO5dyLEHepoE0IDjUnn8c+GpwQyPQnQDwJKa7rAYUQr5iWMXFJ0zpi1jVw2/GrYPsBPgyvs1sBXVacAY6fQEvGFGsdjT4B4V+C2q5VfWrKGoZmxxGIgS6WjRf2RoDon4KYpKRFkDMJT2rjNf/oND4W5Wne7w1PLjdE35T3/+b0Ft8tYEzXiCwKxUp8DG0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeUUMf1rFyNspyRtZRfbRP7vXSl7buaos26NQWfCuGk=;
 b=i/Il8laJHtUuXg+M2cNSC4KaOyhxjiL+9oecAet8O3BWyWMUSEBMif1n1A9EAe7ipyvOzDKKaRqExkD654ppHqGtH4QZERUOuIYZBRlJZA2GtadNiObR8LR2D+X3d86BFXOFjV7AgchlYGjQlQhldkwL/HAC0a1ivqq9jZZgnHE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 03:26:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:26:11 +0000
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
Subject: [PATCH V2 5.4.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Wed,  7 Jan 2026 12:25:59 +0900
Message-ID: <20260107032559.589977-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107032559.589977-1-harry.yoo@oracle.com>
References: <20260107032559.589977-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0056.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df5a8e8-8814-47a1-fe40-08de4d9c811c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDVIazhkYjlOOXdFYm1TZXM0aDhrNXJvdkx5N1hRYzRzNUFid2ZuVWhZdjdE?=
 =?utf-8?B?S2V5ay9mV2JudDV0bVFsQm5HdkFKbUtsd3dYRXpraTc2N1E1MkF0V0xBbVRs?=
 =?utf-8?B?Ris0R3YrNmlqNkIvWE01cXY5WTRoMUhsVmhFeWlvU0xncTgwcDkvUzNzQmY1?=
 =?utf-8?B?b2NHa2FPdTREZiszMVBFU2QzeS9zbXFnVUVSWDlLS2FqOG1oWTFTOS9IbDZV?=
 =?utf-8?B?dUJGcmZuRXF5M1V6MDFHa2RGTTl1T25GZ1B3Z2JrVUk1Rk1rZUthbWp2bDBk?=
 =?utf-8?B?S2lweldlRkJCWmxSSFdIN3VtcHFQdkpXYTRUYTRjV3lxQXBCODE3Zm5sMlZY?=
 =?utf-8?B?Ym1FZnBTTGh0bnR0ajRTUXl2RzhkelNSaWkvR1JZOHpoL2ZJa2FmNWZwSmEr?=
 =?utf-8?B?V3MyYWlxU1czbFM0NHJMZzF3SW44UFZzVlFIZ0NJOTh3MTYzdG1QOGRDYkwv?=
 =?utf-8?B?c212QWhNQXBhSWk2YVNwTmVkS1dCMWV2WWUzVHJTYzEvb3F5U0l1ZUhrNEJk?=
 =?utf-8?B?L0k0aysrenFPSlRLakdKMkFRSXByQTFrNElzdTdvWHdRSVJ6WldVSTZKK0JE?=
 =?utf-8?B?dGRYOUd3VXU0bzVURXVONzdKT0VKUkNNclBYenZVTFJEVFFqMjhjektRVlBa?=
 =?utf-8?B?dGJrQW5YaFc3MVQyZnU1UytqMlpYNjlIdWd2MWJTVDIrNWZoalpkNjRvKzFN?=
 =?utf-8?B?ZlhidkMycmRTZGZXdHVZV3hFUkRGZzk5Mks2R3dlMkRkdEswdURQNmJYQmlt?=
 =?utf-8?B?RW9KNW9Vd2gvWUFKb0FxQzNrcDJEZkN3VEJWMUpWWVMwRmFJUjRNdGowbS91?=
 =?utf-8?B?cVhEKy90ekx0M0JtZXU4alg4a0djUFh5b1I4SHFyYmw3T2EybE1CNkNSVTZm?=
 =?utf-8?B?cW9oNjcrMUJBNUQwNHF4c2tHa1BHR2xRMVdoenJkUWNzeXBLU2RmbDE3Wmps?=
 =?utf-8?B?dVl4NU4wcEVWUkFHNnMyRzFzOWwzSk1XOG4wTFZLQ09IbDdVc1lzUEdsQm0z?=
 =?utf-8?B?NVB3ckJFVFAyaUNMMEpXbGRCeE00dFc4R29vYng5QXVuaFEvdXRYZk1jbmpi?=
 =?utf-8?B?aFV0dThMTUxKQXBkQkhFaEZUU0YxaExESmwwTGYwMFJsWnh6TWIrS2lPWUg2?=
 =?utf-8?B?ZnlOUnFvL1lMZzNkZm5idGZpN1hxWnR6eTdidFp6dkM0UGg1bk9LU1VNSDNB?=
 =?utf-8?B?T3d6UDFhZGpYY3E2cUlMNzRGT3VUVkoxc2s1OTlEdGRyaVoySnZCUDdYZi9U?=
 =?utf-8?B?bVBod2QySUJsYUwyTUkzZ0ZJRjZ0R200VFREMVhhbEtIZldMOXloU3V5ZnZh?=
 =?utf-8?B?NDVEQ2VxemIvU21kQUhMNndtemczakM0T08wYmVCWExmQ0lTS3BiemlobWpo?=
 =?utf-8?B?dEF2RklNa01NdHB6a2tYRjYxa0RtUW50cDUrVUQ2bS9KVGdscmlyS1RpV3Uy?=
 =?utf-8?B?NWxlVWV4cTl4d0c1cjYxN1FRNlErTEFpdVlJZDlYNWdxeXpGbDlKbFRxdlkz?=
 =?utf-8?B?cjF4N3FRUzJKVUlkRkh2RkRMdExWamV0NDlRb3RHcVNTWnJhNmdnSGVGMSs2?=
 =?utf-8?B?KzBOMjFOa3BrMjM1eUloMEpqS3A3SW4yYmEzMkUyU0VqdlMzcWtUNUo4S0px?=
 =?utf-8?B?WldGQ0xlMllkZURQaTNqeHpJdzkxNGFCMXdPSFNsbld0VGMyamZoQVVHS1NU?=
 =?utf-8?B?K0dBbEFYZkY5a2U1aTlQNWhTSFdCTEU1QjdaQkptbHQ5Nk8yQ3Bra2FsUmFh?=
 =?utf-8?B?YWM2TWhkK3FhNTFCTld6ZDZSN3JNRUN0OEY3eXFFVXphbEc4NEZSa3Y4YXh3?=
 =?utf-8?B?b2w4SCtTWGlPSSszdXpEWkxPR3VsMjFWM0JSVnF1WXRZS0tjN3pZdVVzQlRs?=
 =?utf-8?B?QmFmWkVwdTZCSzRLTFlhNG91Q3ZrdVVyMG9PbnprT1VBRkhQVHdPQVM2OHIv?=
 =?utf-8?Q?iWRFCKYKzO4I1FmiKOH6druvWHLoxySP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDlmbnJlQnZXcWVsdURFNWNWQzJPVGw3TFp4WmxWWlNVbkNDemJWNVFNb3dk?=
 =?utf-8?B?OVNkY3hJOEFaQWRYeGxIbnhYNTA0SGtrNCtpbVppMXNFNFo5WkF4U0ZyRDR3?=
 =?utf-8?B?OXVuMVhycTFWQU85R0VZbVhqcjJJU2w1cnI5OUVsSE5RY0RDcDcwZzd4VTFD?=
 =?utf-8?B?SHBEWnArV3JuZDVxbUlPb1E1NzJ5RGRzYk9qWldyYlh0bW5CbmFsMko1dEhQ?=
 =?utf-8?B?aUNHWEs4azMyd1pnZGkxbmlYeTJjclpnam1WMVZMTzRNTkQxRDRTbmR3QzBZ?=
 =?utf-8?B?NUM1T2hvYWp3b212emMwVkgzYmJ0Yk9pY2pUUmhyRXZKeXd1TTVWbFpQY0Vi?=
 =?utf-8?B?UlF5S0YrU3B1clU5S054WjhhZUcrSVZKc29jL3FBZks2Y3NVSDQ1UzJCTnVH?=
 =?utf-8?B?dElHRjdKL0E0UGNZeldTWVVFK1UvU3VWcjhVWUJiNWxNWW1EUXFzZ25oSFJh?=
 =?utf-8?B?Z3Q1SE9qaE5rS291R2VPQ1poRUpTVFdhWTlwTEdtVEJnWjBpdTlVRzRSUmpT?=
 =?utf-8?B?NElKa0dKRGllcFpHREJrLzNFV2FBb0RJMkViUDVKWnBHdjJmaS9FTU1oQ0tD?=
 =?utf-8?B?MzVKVGNJYWNwdjRwMlRjcmlBeFc4emo0c3VtTE9JcllZUUw2bDVjOEtJQ0Jh?=
 =?utf-8?B?Z0tNd1pEWjdkNDBERkNiUXV4OStSc0UydUtISVF1SHpaa1Nmaml3M2xyeFlT?=
 =?utf-8?B?WCsxVTFYSFpmdWVWRE9FL0NSQXNEMERQUjE1QlJaSHFBc2VuSStGSTlTanNP?=
 =?utf-8?B?MHZsamNHQVh0dlZFNjd6alNRUUxydXpSNVVaQVdBOVJNVTFtOFNobDJ5V3p5?=
 =?utf-8?B?a1BLWGM3aHFDWTZpR0hHbU5VZEczNTNHbk8vdEIxOUd1c253NDZoRkZmNUxU?=
 =?utf-8?B?S2RoaHloSGV3dUZDbHdIZjRGUGVnYjFTWEZORTY5OThMY1ZibmRTdVZpd0pD?=
 =?utf-8?B?Z09rR2poZ2dUYjhLbGowTnZSUUk2V2JlVExzQ1VIMU1yaUc3NVNYS1ptbDVm?=
 =?utf-8?B?N1pCYno5elRrdGMzemRWSUJ0alJreURucWEwY0VmMDk5b3BldndSRWJnbjJo?=
 =?utf-8?B?NFkxS3lCM1g3ZUVreGdWQklSSi8vZ1IwdjZkdThNaVBGY3NrY2JhN0o1ZnNB?=
 =?utf-8?B?U2dVZnFsYmNQS3IwQ0wrVGxCN25OK09yKzFOTTNNb2NrNmdyMmFUYndlTnRs?=
 =?utf-8?B?ZE1UVlVaTUZFZDY0ZllJZEZ6eXpTVHNEbUJwSWIxL3E3b2VtNk9LeUR3dWY4?=
 =?utf-8?B?NzVLNnNvd0lwQlMyOFdHVXpuSlRqMHRxZHBQaURsejJnbTFGWFFla1hGSTM1?=
 =?utf-8?B?STArR3BiZDBCdmtSMTAwOUhOWkV6RW5mS2luTHRvRHdXU1R3K3l5dUQ3Sm5F?=
 =?utf-8?B?WlB4cW9seEpwWE5idUZrZldkWllpUitkVUlMcXE2d1lGc3pzaTRrNVJmVldY?=
 =?utf-8?B?dkVEUTZFOXh5S1I2RTIxZkRnZ2czalh6RW0vS1pJVUNrelBQVFV6M3VJMnVr?=
 =?utf-8?B?bHFSR0N5STJaYlBHR295RHUvV1ZMaGo2dTlTQVZOd2M0c1pMd1pOQ2hTN0ZX?=
 =?utf-8?B?L0oyZFlLeFkxMjYyUXBvU085eXdUMC9FQVd6cG1hUkNsSDJ3Ukd3T0Y0VkZj?=
 =?utf-8?B?OUgwellRcE1jVHVxY2JjYzFkcVhDTnhpdkxIVE10cmxrVUVlZUVnK0ZwTXZO?=
 =?utf-8?B?ZC9pcFF4bXRVTzRhY1l5ZlRBeW90N2RBTHQvNzhiL0xQeFFxbS9zSVlnUndr?=
 =?utf-8?B?SHV1MmtiSGVMMHc4a0pYdzZrTnVlNE01bzgybmx5dnJTNTd1R1Fha0JIWkZG?=
 =?utf-8?B?by9abEVlU2xtZDl5SlFXdEJ3TllWTUpSL0tKQmwzN1RpOWg4bnhySENVeUll?=
 =?utf-8?B?WjM1Qk5GdmdlbDgrT242TE1VT2t4OXFKZXl3Qy9jNXpmTGFrYzVrMy9vc1dH?=
 =?utf-8?B?blI0bU5kTXJ3azd2dTk4S1d1WUcxcnNMRTM2Q2hzaDdjUDRDU1EwTGJVOUM1?=
 =?utf-8?B?TnV5YUE2STFjRTNOU1VzaUErMTNqUWlXZzUxUzZrUXZYMjhnbVNPY3I5cEwx?=
 =?utf-8?B?alVIbEp1RGNyV0ljc0Y5RWxINXNsblMwRzJGdEtkd3VHT1NncHhiRWJ1UGlo?=
 =?utf-8?B?Y2t2UFhVVmRMdnVib0xHdVhXV1pkbzliQi9PcDVyWWZjTXNsT0dDak5GZklZ?=
 =?utf-8?B?ajBiZml2emhyTE1PVzQ0UnhLY3BnZHJvbzRiL1diQnF2cXJQd3kvV2syTERk?=
 =?utf-8?B?T2M3TjAxdU5VbzVOL2JhbkFBOG56aUFJM1Zhc01iQUNvUG9vdE1NSVJFUDZp?=
 =?utf-8?B?Wi9vVE8wVjRmbEZ6TnF1MVpGNEdheStWR3QyVlFwc3BsVWoxT0ZQQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/+bRMHvMW4puTb7K0Jq2sLJSWb+FMLWCD1ij/5Jn0xawBtEPJ9iZDNTcGyQ006U9NHnMormGkfiE2GkvkBryqaUKpYcZnD0wpgZle1k5k4GJDzDfjeDhffsy8/x22+lmUsrB4IVpg6SqJks1p3+BpC4qp1uwQ6OVt4YyyPnUimX2TlhwVyidQNFLeXOTwGR7S2K/7F0Av1J8MBi1KAyhWen7fTqk9VnKk7NdXdYoNuFCyMczB0SkH5ykBEK6V6saMYw2iN9NgikymofQQMnRRDaReylhb/ivpYw4wt3jd6TORmc47BPpAaQXEQNvfKhvXQ4ZC66OKNMo+7jmY/znDSScZjC/oq1ateMLAovq7GPXvkl7z05mp/x8q/4sCnDjIH7G9rMZIvn14vPnxIJnhHluKLuiSkwsOCnVbvrgVG53RB2yh3xrjdHKs8/kpLl9H3itIkdkoFjfA5VciFAdJqdp3wXi3lya9n1jYT9gWJ/TdmahIZWuyHt9b8JWZLLUNeWiRSjrCxBRmdXBir2Qbt0YIh3GGAX+g/Mm2yoG42m7MXc5aAka4OL+7A9ucz4W9tdjLoivugfxz4r/3JkJqg3FbEuLwjL9nqkjVq40Qvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5a8e8-8814-47a1-fe40-08de4d9c811c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:26:11.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvVhkDiaWv0Ao95GGrhHbdilirwNWkb+jyqczFn3243uH8vOGWGtqaTWDLxdZtTjQTN/imJry3nSKDv//AIKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNiBTYWx0ZWRfX6jjEF4e7gBJX
 aPY5tFD12Y8PEe3w6zfHwEZu0kn6UWsO+AYs0E2qRjaKGLNDc/klflAcrdrIDTbTVeHsv/kzIre
 tybBfQ5SQ5NzA95hwgdlqc04THsSoofVU5vFQexOu1iD7rUXc5I7dQzgeQYq+H/9Rqbz4NSBLGz
 xBrMh/URdWpt+VAQKDekJ8/WIctbf/hpXLwd/38aJlUyq/Bo+JOY/N+3jgf77XfejKQiUIukNmt
 vFzUCPo/LuBik4Ki1/HnAUXBefCcmgQwa7NYjAogD8i2aNd4xEnncsnCFAVC/fbcMA+MtiQs2qo
 vS3Sx29FysaTyWAu6ph3EHzsW6Tex0ebspS5119FlNv1KzgcwW6BD3vL3j/184IBNDhNpy9FJ3I
 LtB0oMbP4NoglJf1tOA/sNzvuMSVs7Bo402zQPtmQT+skiQbI7DkQ4AXdlPcs5Uug8KVtZ1zYRN
 XQBr6Zw/Kfyh7vrbfyA==
X-Proofpoint-GUID: o1JxToaysftErT4GJnJZKp7r43-4dBT8
X-Authority-Analysis: v=2.4 cv=OLwqHCaB c=1 sm=1 tr=0 ts=695dd259 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=7CQSdrXTAAAA:8
 a=1UX6Do5GAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=nrACCIEEAAAA:8 a=7ipKWUHlAAAA:8 a=968KyxNXAAAA:8
 a=eh1Yez-EAAAA:8 a=Z4Rwk6OoAAAA:8 a=K6bJOSjN_L0kULG0WO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Et2XPkok5AAZYJIKzHr1:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=L2g4Dz8VuBQ37YGmWQah:22
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: o1JxToaysftErT4GJnJZKp7r43-4dBT8

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
 mm/mprotect.c | 100 +++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f222c305cdc7c..7ed3b4e86c239 100644
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
+	pmd_t _pmd;
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
+	_pmd = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, _pmd)) {
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


