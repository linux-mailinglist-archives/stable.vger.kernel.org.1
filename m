Return-Path: <stable+bounces-196855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968EC835A7
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683CA4E1A92
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C58872618;
	Tue, 25 Nov 2025 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1CrCfiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YqfdE2Bg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B69125A9
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046168; cv=fail; b=i0TFR8lT5Fxo6NYgkfy51VzxOOcON79O8i4ZF82ouuFv3rk4X6d+qWMY4TZPCHl0N0vE8If7EbCYV99fkqL1uUQx+ToJrDL2t/+qY6E42uAkyMXcBNF7BLW0XHYHTdHpYi1rtzKVuQAksYbx3nyDQmfpi1avQFSegruFXJyn4tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046168; c=relaxed/simple;
	bh=/uRbe3G9lKbV/tflJTNKKFM3kQjAV9HHih9akkkZX3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubVSAHPt8+vPWURQcPvpChe90J77ciDiQXGxQmuyGxG/d/amMEDL0mrI1dUzMYbbOHdAhFnYBQNmb0MdB1gDfO/wVJMaoic8aNWx2zx2rMy+KqQRBUqqOyLrwusn2eUU7Ik0W+43ZWoaE16uFgWQwsOzefdMfhOU0Twie02W338=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S1CrCfiZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YqfdE2Bg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1DG642343698;
	Tue, 25 Nov 2025 04:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uniC3M9ywi/rZHHk6oGwZ6om92Qy4q38a8WPFiI2a0g=; b=
	S1CrCfiZwbRMMUgx/jUrGXSHNrW4ZdtAuNilXb0rm/qnjHzw7hdCPFC+Zqpvgn0L
	SAJt7ZDRhZSE+QGditkA7AbMvGTEFD/gwGb/tN3UB1fr7fdR4v2WbB00OCIApfvW
	jO/mZgzi9HmWJOglOKEaf+DV81K46/3xxX80cWZzk8SHnWpDhMs/TVMAuOFTG4pH
	J9lmUQyZvGMTVoPIqk/np9EO70nZ73Th9e2M9H2pMql2aZCjCvkehnqSZpmSaFgp
	fRZnJR7XFEvu4qZjZQCahWLgi2uYUBapYtm6Hik8qtO2VU0bwaYnyTh05EBX9GFO
	Qi65gKpqglU9xDX1Ik2UNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkbdac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP1l3jk032861;
	Tue, 25 Nov 2025 04:47:15 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8xr4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 04:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1L3fyE2tnJfb6zBoq/cJLxRM0o+/DwkXuHsOrHrh9BmsTTZ3ZIRdxWNIya+pqbHsywKtVH6Uc2OFPHm/FT0Tk2l/2LMQhpYqrkT+Qdy/SwgU69DtfxRiB3I7/0pSLBJAFw015itICqR7Kbh4TPZMAEdGvowFiIbLO3EqchzcKik3qF0IRc9EwfPTHglSZ3n6aKgHRceC+WBlHbA++GoQb94pK0ggMUBIpdUZq3HdK+yNs5uh6BTQG5hf+BCj6wpNjLdGyajLdCqWFvdzCr0NNJs2H6NvYYpqhQ68cZID+Rs5GJIwLf2GQ1EFzWSV+IApgGuVlAf/WuwmEDNyL+3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uniC3M9ywi/rZHHk6oGwZ6om92Qy4q38a8WPFiI2a0g=;
 b=LfT3kOm2m07MYeAEoWI2GfT7jy9hHrwdpDyJWKWgT5ZyxL5OoDv5X3h1Ulpl331uw4V+Ij5t29SMefDPBKjHydz+2dxyeBXDxEI6D93j/gWCEquJ4BcdQa+mXVUf5QmIJmWQcoUJsVF/swuo4QoaKs0cBF49uKo+UgByivbWVRMzdsgJBVw1DerH/3uoEQatZyBwYL97TtSjC50AlaFpAG2bc9CX5/cnYZrBR5I7xiVZkiCla0Y1Q9xtkwYLPjhnpux174Ioy12TUrAHNvo6Y/pZblUz6nv5htdzVBsZkgIgEblWabFuENy8g9EjDOhe/WEZTq9C/KXzX/ED60iePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uniC3M9ywi/rZHHk6oGwZ6om92Qy4q38a8WPFiI2a0g=;
 b=YqfdE2Bgij0kjKC463TOaVW19bFETqxmET0WfkivD44o3ZfzFTiX34aWXbt8agPg4SYw9KdTtC2uYrecmE0+yIkEa40JUNksF4g1QCUOA1bb2DJ80WkBK8Yyh9c7d33hVSXl/TGMmKJv9zLESWAcdjhvEHzlUuIhF2eijJ42CCg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 04:47:12 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 04:47:12 +0000
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
Subject: [PATCH V1 5.15.y 2/2] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
Date: Tue, 25 Nov 2025 13:46:46 +0900
Message-ID: <20251125044646.1074524-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125044646.1074524-1-harry.yoo@oracle.com>
References: <20251125044646.1074524-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0131.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c74f71b-7da6-46e5-3d52-08de2bddb2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aSsrYjRYaVR2akV0MWFJQ0dITlJqRHRiMVBQY1VBNFdkbFBzZHpUZnY1U2tP?=
 =?utf-8?B?SlMvSSthbk03MmEzZGRYOWZOSjZBNVhNcXFBMXBKVmpENVNxYXMxNDdIRnRl?=
 =?utf-8?B?WnJaYmdQdDZOSzcyYlBaa2haalNSakRuQmgyVmNUWS9uQkYva0VKdldUWnZu?=
 =?utf-8?B?WXk0UzArVXk2dVQ1MVE1Mk9seUY5c2liallqVEJ5azF5Y2crcVFKRkdjYXA5?=
 =?utf-8?B?Zmx3ajF6NDJLS3hCNGZhM3JoVFlEVHFwelFCMU1MajdES1owZEU4RVQyQXov?=
 =?utf-8?B?enkzaHZMcWRjOTQxYTBKWU1aLzRKbGRvdVJGQllsdkdEL0lkeFB4UjRSOG1y?=
 =?utf-8?B?UVpsU1cwNkttT3p4aks3VnQ3MjBFUldRSGZuY1BwdDV4Rm5UaGowMjM3OHR4?=
 =?utf-8?B?SllCeG82UVJ2c01STm9PUFFvUnZ6ek9iUERCNjE3NWFMc2pVSGRnVVZ0SDY3?=
 =?utf-8?B?YXN5L1V6ejZncFNhZVkvSTlUV2ZPMmRGSEpBZEdiWU5PRTRTNXF1NXpkNWdL?=
 =?utf-8?B?Tk0rOXBpSHdycTZEQlVMVjBsWlBBMm4waEZ3ZGlscFdZQ051VkNUcURHU1ox?=
 =?utf-8?B?VEIwWVdiRXl3Yk5jWlBlQlVCSzZDZE5XRk40VlozRkxEd3l6Y0tmdXBmalo5?=
 =?utf-8?B?cXNBUzZNSjV6dkE0YnBneWhrWlpnK3JzNWlWcllaaHJJVzVsWnM3aGhxYkRn?=
 =?utf-8?B?TDMwOC9UWFh6T3BQSVdyNTNzbFVSMUhnVHJ5TWRFaUhIbU9vVDk2cVhUVExP?=
 =?utf-8?B?MHpBYitkQ1BpMmx2Z0JPTUtTMTBXTzZGb0NLV2l4QW02VnpkbWNPNlBtd1RV?=
 =?utf-8?B?THVxaU1VQmRpbTNEUmFmVDFtZjNJdjlQd3BIa3VlTkM5ZlNlR2Y0RldSTStj?=
 =?utf-8?B?L0s0em84cXc0Zm8rQW05TXkvRVBOR3FXckNRYWF3dGZHS1JLN2UrZWlnVEhK?=
 =?utf-8?B?Y0x3UXhmMjl3U0tJcWdaeFh0VExJR0hRa1krQ2xNZVNodXFwZExCOGJnaFRs?=
 =?utf-8?B?aHJTdERwcDQ4S1lUc29tN255ZUZoQkwrTnFXMjZRcEpNY2FFeGtPck53emFG?=
 =?utf-8?B?NXllUzJGSkpDalRXRk5XbnluTU5pdnY5VG1tZXpSY3BHcFBZRVJ5MFhjTnRR?=
 =?utf-8?B?ME9TRm9saVRpdVIvdEFNcGd2YklqbjlRamhtNTdqNWdNWnI4WGZVSkdKVHVw?=
 =?utf-8?B?T3ZpWUUwVmJGQ1hSMkJFaHk3bTNKOU5TclJRWG1UeDNjOEJBcVFZaUdNMEZL?=
 =?utf-8?B?UzBUQ1FHOEZjdWVLTzF6RVlJZWlNUUhUZm83YVJDTFBCaDdBaGRrcTFsMmQ2?=
 =?utf-8?B?aG1mWGlZL2FYNnM1R2tNQUpTZ2dSNFNoRUIxOWtEQ09VbUY1a1BwREI3RVZL?=
 =?utf-8?B?WW4zM0Fkd2FxVTZVS3VZb2VlcktBY2J0Z1VnempnSER1TXNSS3J1NWU1RE8w?=
 =?utf-8?B?OTgzaCtZa1h6MmxxRjZ5dWJiLzFXOVRRT1R1UzFlMXo5dUhGZVo5QmtOaGVq?=
 =?utf-8?B?b1k5OTJhSzRQRXJscTgyT0Q5ejBobHh5WThoUHlMamJJY0t4S254TSs0SzlK?=
 =?utf-8?B?T0pTcDR1d3NtSlBHMElOZUROdGh6b1dtcW9SaEhJeWdIMFZ5Vk0rQy9BWDha?=
 =?utf-8?B?OUFxZlpUYlBuYkcxaXdSdS9HOHRDb0Znb0NrdnRPdmdMUm03dkNwSEVTbFhH?=
 =?utf-8?B?cUpuNEZ3dkw0TUFvSUNLYjNXa1Q1M2F6dWU3SDhYYldCZEZ6a1ZCWlJaL2JU?=
 =?utf-8?B?eXJZS3JjSTg1T0sxVGtjL2VLY2RvRFB3azNkbXhKMzBOTFQzTGFpVE5JNk9Y?=
 =?utf-8?B?OEdRUWhBUHFZMmJMck5GMXl1d2lpNEIvUm9LR1FmVVdycE9QZ2E4dWpSanF1?=
 =?utf-8?B?bHVKbkFVdnc0NnlYSVRodUVMd2VMVXB2TFZHb25NVHVPWUw2LzBKNzQyeldY?=
 =?utf-8?Q?/dLP4GKyozNjny4ydSaNTLXv9nUXvVix?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJwcFNvSzMrbkRzWDJUY243bG01bTBQVmFJR2Q3cDFkR3h2a2ZNZ3JXNi9Q?=
 =?utf-8?B?VkNiQ2puUFE2VGVoSUZYM3l3MkNCTThxVWZtUHd1eVpPNWZoWGJiWThrcjJJ?=
 =?utf-8?B?ZmN4MXgxcU0reHJVSUpNbTg4TE41WFNjSEVxTndRR1hub1hZaWxoS1NQbFZY?=
 =?utf-8?B?ZlNqd3BPZW9hR25pb1c4bU9WSnJITWlwbGNxSEdIMXdBWVBCQUVRNWJDa3JE?=
 =?utf-8?B?RFlmV0NhZ1V5R3NTdUM4RkMwbXU3UUQ3OVFiQlBKRmxIOGpNOFp5dFE4N0JI?=
 =?utf-8?B?azQ5Nk9vMXBSa0lSdXFxV0RSQkNSQW4rd0orQStsOUNsUy9QQVlGWHpkcFhL?=
 =?utf-8?B?RW83S1NFY1IzYWVIRHVTdG5zVkI3WW9WQ2t6N1hGL1hlcUFBNXhPbUt3NUxM?=
 =?utf-8?B?UXFsMVo2SnBxSkZQaVBIWldFaFNKT1ZTdi9LZmVmZnZUNlFVL3hFQ0pKeEpi?=
 =?utf-8?B?K2hZN3RZQkI1Q0s1TGZ4UFd6Unk5U1g2aWdjMXlHRGNnaS8xcmp5RENtdTJz?=
 =?utf-8?B?bFU2SWdEdmVMQ0V1eXRoOEtiOG5DZUVjU0dLeHVRV2c2bGwyZzBGdFhWUDZo?=
 =?utf-8?B?RHprd05YM25vOWNnMWxzSEhUVklGUDNUTldhTkplMzlXa1lYK0llMVhBQXNZ?=
 =?utf-8?B?ZkVkTzUxYWpkQnh3ektrY2cxd3RBWEg0ZnBaM0RGZmcxY1Z2djlhT0dSZHFD?=
 =?utf-8?B?bVVrbGxBMU4xZDlESFJjOUcyNk1jSnkxZnRKUzdVRm9xSk5BeEpkYnRSbU9v?=
 =?utf-8?B?WUt2bnkwTnlEQmJBT2ErVldmZGc4cDJxT1hYa0pYT0pyQVUyNHE1anZCeTcr?=
 =?utf-8?B?d1ZHaHRZT0djNnU2SHRPb0JhT0NQeGVEbU11YUpMbEsyVXUweGdiVEhacUNK?=
 =?utf-8?B?YitsMHJyRHdYYk9RNXllQzR0NHJYai81d2hRMjlRcXlPSUVCWms5T3FyZTE4?=
 =?utf-8?B?S25QMjJwRGRWM0xHcmZGRXZ6NFltQmh6QXpxS0hCcmFDeEJ4OWhCdk1kZTNi?=
 =?utf-8?B?TTMvY3lQazdZazl5eU1oZjNkZW52QXhyaFBiRzIxajdoa0xVYlEzemVsdlJ6?=
 =?utf-8?B?c1NaR0NXTUF3aXRVNmY0ZmxTUlVnKzJsWEpkMGQ2WXhucTVWRk9GTURJWUVW?=
 =?utf-8?B?bytETmhRSlF1cGdQcUtzUWtFSjNDRHlTOEc1Vkk5YzRwRmFEY2lxQ3NFZThx?=
 =?utf-8?B?aVZYWENCcXk4OGx1U2R6QnN4aGNrZjg1VkZ2a01nTHl5bVJoWWJ3R3ZkcTJv?=
 =?utf-8?B?cnZHSWR4VDgra2hNaHZPRlg3N3RROWp6OHZ1M082Nk5raDJSTkNoU3UzY3dX?=
 =?utf-8?B?WGllcmhFREdBeWtaRTRjU0E0RlRJWCs1TG9RdnF0eU4wbWY3bzJ5YXhlUXE1?=
 =?utf-8?B?Q3J2K0x0WGdVdjJTbHRqcVFxeWN3VnBjajJHWDNwK0Nxd3pGdmlJeWZKRkhS?=
 =?utf-8?B?cHVQZ2lteEFuSW5QSFhiUzZCQWNyUDdVRDZ4ckk0czVuRnA3NnBMQmF4WGh1?=
 =?utf-8?B?czVWMkp2emdTWTNRdFI2R1d5K0pwaG0zMVlKMFVNVGVKNVpxelRINmV1dFpV?=
 =?utf-8?B?anJLZWhEbHpHT1BEWnZCZjI3RjhJSlYyYmZzN1d2Qy9la1JoajdKVzNFa3ZY?=
 =?utf-8?B?MkdKaVNHaDFvdWJKTjIreHJPOE8vNFRJRng1RW5VeHFHUURLZHFKckg2K29R?=
 =?utf-8?B?VWcwZ2FJTUJWZVgybmlwaU9XZGJPTWhkb2RGUEdFbHFXcExYb0VlYTBYUFhD?=
 =?utf-8?B?L3hrQmI3QTdEWUU2Q05xb2JqY3NpSEJRbWhGOXBXU1NTQjd4eiswY3VHVmJz?=
 =?utf-8?B?cEVUN2FhQUZYT1hUclJNTDZja3VPUTZCNmNNbk12ZkRLc0RHbUtjKzVCL1A1?=
 =?utf-8?B?Ri9lSmkwaHplYlJmM0VmbTUvMk1XaU1FKzBaR3VaSnM1YnJhaTk2RmtJRmlK?=
 =?utf-8?B?OUJXbnVkdzB6MUlrWnZRMGYydFcxZlZQS0pnbDJiSlFqaGwzUEJzamhYV29q?=
 =?utf-8?B?cWY4L0R2RVFRUjloZk9xUHFvRXp6cWVTSWoyNnRZcVRyOFlKQXpEZVRoY0Zw?=
 =?utf-8?B?WnZKSzZEc09HSmJ6NzdENDFqNlo5ckVMYTdkL3BjKzFJN2xJMnp6MW1JaGpl?=
 =?utf-8?Q?os2BmGYg30RHhJEpvvoluP+v4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vTu2GUkyqJ6kWcXyh5Jp0OOo1wEbZGNdMRzHHu8m6ZZipsiOTAxGYsDT6bWFhIgpbtgCBJnfkxfiCAwbSMc8IxqtPLI/fF8TmGLjPlTG/WZuoWisO7NEazehmSfJ57OchoENav/hhidzZkulN3cPCNLFHlS1Hn4sDRZVZX4r+foxg4cl9JsQBq6sEMmZRRgmRbrlcA6WagmZfOrQ6GGNbgyI7E43AIpY/ATVwf9fENQoA45/BLUMNgd1oh8OtptAouvRlz8ib4MzdOqnrGkvFlceaeZ1wnEaTDUbhSRMcpcyR2HYT1f4o+6g4eqHLTZlaVP4KWIyg7kXA0WCMG0esXjBQj8U0awrkuqzbZCm6phJL9A6Lq5OG4L2qm0FC56oiRzk/Y3V/ItnlWxfMO01OR23njCiFdfA2aY6dzcfjGaNaYlYusBblOI/SkQQId09jdFHnewa9VKVdTQbTlQk2lnwfWXVs0flS5fyTT6Uu0c3voNO53UUQZUtRtxLeklWQ7Zl4aLLhrB5IIwHeT7MIL2EW0/R0cbmSeggROVLgL3E3IQ2zbKcos9AkqIc3vTzqryVDVhxrIAvyUBVGt4NQTM083uPk97YrzA+paa5Uvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c74f71b-7da6-46e5-3d52-08de2bddb2a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 04:47:11.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmzUS1631uw+qV4RX2ESq/sFByIE6SY6dhhJrcBTBCe2rrp5DcuWzavS3lRRn9X23aPMcF7wGZcmbq044CvTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250036
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=692534d4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
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
 a=gpc5p9EgBqZVLdJeV_V1:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzNyBTYWx0ZWRfXyKI2VcVPojQn
 JiQbGuW8cfne4CxL8gg3KD6LoiNOx5XL3OsG5hkI+CZ2ca/gReGRcEccJd+uy3aVCxNraLrXHhr
 iZhL9gEeHEEc+T2Tcwzn36dAHoktZ3MGlz/ppx8vKdhhPH7n1OK6qBuZg2Sh/jqcieS8/hTeXqh
 8aIjLNff+pwQgV1bD8SlaYUjNRbTaW2A0tkf1GYgGLVGz9Bm/fE3rCf8WmfxB5htctKGmGE64ka
 vmxBcHzrjQmmqv/elR4zNRXaGcF+NcYurLdqOjU1csi5sBM8SzkFJMfuk1ouMouTK3dAvaU5s34
 oDw2QLmdBcRn/3lL6yD/y8jNCXQ/eZYNcfxbiEI8C12iuLQMInV5ozLa4ys3c+4ra4/53Z06HJ9
 AbTnsQJawad1TP30cUexuSxVkmc9bw==
X-Proofpoint-ORIG-GUID: MuqyhaU6Zac5I--Gx4vrjfXAbBsqroPQ
X-Proofpoint-GUID: MuqyhaU6Zac5I--Gx4vrjfXAbBsqroPQ

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
 mm/mprotect.c | 97 ++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 58822900c6d65..15a966de86676 100644
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
+	pmd_t pmd_val;
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
+	pmd_val = pmd_read_atomic(pmd);
+	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
+	barrier();
+	if (!pmd_same(pmd_old, pmd_val)) {
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


