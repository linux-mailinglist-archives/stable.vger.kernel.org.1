Return-Path: <stable+bounces-125966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E993DA6E302
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3106A1726B2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FF267390;
	Mon, 24 Mar 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jn2H40gt"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA5F9E6
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842912; cv=fail; b=OYPYTYOcwPo92E6XcIvevCCQ+ACrEqT0gsZ17lVSvHHOZxO4yAlXPX9SkErkfjbrYKicXXeAkwA448DI/lyQO8ivjCN23vF8NrTVT+z6ldOt7FAAMAsQIxtf7yLp2IHyF9bMEeI9gKwDT+XI0Pdec+vTE5EuA486oI58wXfMHdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842912; c=relaxed/simple;
	bh=7p2sMs0fhhVxWurEDzBgYOSbM3GrENz0JQWTmYQ4gDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEq8QokXmqznVtEbJU94c57GXjz/wIDu44Kst/iQIayNHT15Ley/lE7qhNWy5FZGiyGtFyvNh0DSR7GGsnWVQXoJAOtGHrH4joteTxPDO7rtNYwqXP4b5U1rz0bJBjxllwX0ZWnQH1UEhQ/+h8Xnd4wpNvV4P0+7eYFLgJPTJFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jn2H40gt; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aC1l0sXG+YoXQ5n8jtEpbWeWPJ9nFhad4WorSskNRDYrLisuxbLaLVmTv4oKuCC20oX+wAFm51a8mI/I3ToTiU+MJUVqpr5kY7KfIYOfcpt9+SnE77w2ZekQT8NvUMfW36DMlZX744vw2fnnwKOFNR/KpWPrHw+B9DXelOLf4ziBldOYys1GJkJu5Ha11x7ZvsnhiBEjDd0vxKDCHXS2MpE9eFTlvZxbPBkCarbrd4NAttrlguv1x8aRpEt8WykSWsDdBcjnxE/tORVO5A5eJz1dBKmCBXTFJowxf32JDTvoetxCOJHHSvX8GEex1N91c795SRwdh9NhDyRKzNx7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yHI9ybvqGC9+i09d0ySCsvh1Ob1zOZJYwr4bQplv9E=;
 b=c4+DFQPpBa7HUIbyCzoEThIYgd8SBmgoZGMoMn+1rmK77DfEPF4a5JpAmPdW+LJZNs1y6mdvnnt0+pAA+PutEtrA0uyWbBYUuMK3L8fStxN1r8+2/Xe5YbCYmyIh1KLMQ2wgpgx4Wqi8OSfiDcSepdhzSLtom7zQ9gsGRU1DMtdbszyaNvyatb5HmpW8iAol8Ew+QK83c+uhQsfB5vI0ZllWjt/mJjtFFFYUM1UpMPSf//RADaLZO6jqCXbf9bdBOcDTts4E8xXJkTkXAs01CUJ4PacgC5cq/wQX0Xo4D/hfNY7fo+XjRU8t1+lRoG4GpBdeldOp7MvU4KCBKRs4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yHI9ybvqGC9+i09d0ySCsvh1Ob1zOZJYwr4bQplv9E=;
 b=Jn2H40gteRZpe/rGhZxExmnqT6/w4CKwBbWL6ZW61KW58EDtyz0hxQ1MztyoMgr1IFUY7rpELjkNcqegKtSQ4zLYNc+j6jiYw9lzlKeGJ0Z/2Xyi5IVVakFktFk4hiKT3isVH0OJHpPG+WZZRgAyA4JOf/X/jrPf7ecin8DMLHJl4Z9SgQsqMpC0tOfsURwOfIALlqyitm6h1lFvi/fe8yBvN2OPso/ZvsM/6avkIFZHcukRi78z5QlIdAkim7OF0kGjB1bCYTGH2Vgf8iUmg45NEcX+aeqFvb27bL8+FCui4gP0NfjnM+eMtUjUrkGRlg4A6wnYn9iaw2bGEUkVQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:01:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:01:47 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/migrate: fix shmem xarray update during migration
Date: Mon, 24 Mar 2025 15:01:44 -0400
Message-ID: <20250324190144.244275-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025032403-craziness-tactics-91af@gregkh>
References: <2025032403-craziness-tactics-91af@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: e51c7285-f8a6-487f-aa0e-08dd6b0653d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Otro7k3OnvbyaYMEiXYSVxsi5h/qIlLlIv4Z8BGIMUpt86qKT0IEJHKHX5xj?=
 =?us-ascii?Q?a5UoReQVu2APJ2Xu7le9CFAq1lwVLbWSavxJSAh/HnsPeCm5K3H6Avsf8o90?=
 =?us-ascii?Q?ZlEFJJfS2tFOICFsg0S1mc3K533oI4YWpaKwVe3bqLZdFvyyk82rN41+TnxA?=
 =?us-ascii?Q?OeF0kcQqbJfiwwm+rbUa2ZteHY/k98RQ8dv/9U7oDa80lZam9XWziWYZ9QVo?=
 =?us-ascii?Q?NX3OObEtjGvp01fJ2zJx0ZnmPHcVK3qX1KhRFKHfDcgc9+t+2cCMzPxk57Pq?=
 =?us-ascii?Q?R7uL7H8L0shVLgQBh8zHxtJ5Fs61VpMFcoy0LT8001i7wfqEo8u4d6Ro6ZNH?=
 =?us-ascii?Q?kXOs732kRfSHB7PHeYC5k2y85Ygw2e+KWGKeitUp/dEZwVaOFm6VCds3T4c0?=
 =?us-ascii?Q?Vi6XbTkbqqcDHzgX7SBY15Bc6SzSFDBbLm0Z99mwkcS45J/GgDE9OtLsH3i2?=
 =?us-ascii?Q?lL64Nf7rTO7U8GAKQ1r996GZNTDHKZwPNoh9QBw9GjNRg0T8LbVNC13j+u07?=
 =?us-ascii?Q?04YicwxTpfbldcovDlflPQVZCrnhw3NlkxVf7sUomHyweyZYIdHF3EpQnW4D?=
 =?us-ascii?Q?J0d2x3vqrmktjbN3u3eV5fQ2jrmWjn42LrMU/WCDqD1jZGG0HJ+d0B8JySsA?=
 =?us-ascii?Q?aShRZV5jbLxs9LlvqneT4kv2geJ1/zAUquAT1UKbPv4ncgo4Mx/0YGNTnxTK?=
 =?us-ascii?Q?++EBiRjevH8E5lvLupja5Qs8YbaUOuoF2GUA0MUfDknk6MD/V8imFpmHf5JM?=
 =?us-ascii?Q?DYGaJAS6ozTMHQ6+lg+G4uDGmMfAFPpAXufwTBvktvp4XNNm3vF+Um92VuvU?=
 =?us-ascii?Q?5QodfUhfYR4Uoi+IWOD0j2k+BhUq6SWOQ1XCZO90kaPLdUYujGvX/Fk2sJbn?=
 =?us-ascii?Q?hXP4m+YjdqvgLD/VGgk+Z2zl4DC3m2eirkV7ZYm8hMVNf/70+WzjHIRC6YMP?=
 =?us-ascii?Q?QVyPY2234gjsLUem37WmQAuLbD9Eni+GZc+DA858KUrcw1nGceEPD3xGbOdG?=
 =?us-ascii?Q?sepyPlirzo6gA2U/fhJkigurCXbL+7GRgDY5FtXhaJeO9FIZIp2UEaCbY8Bb?=
 =?us-ascii?Q?BG9ldwv04K43YEVpjWhYgIhNUZ9lu+zAYOKpYq9Iu2/Ub8+b3gpBMW+kjma1?=
 =?us-ascii?Q?tsubicWIN0TGrQYHrTRSfGfIRhb0ljpELdvoMrAB6KGoBQFPoKlBn8tZWJxm?=
 =?us-ascii?Q?K8UfxPbGtWosuULr/pvWBTbPLhjliF5RlU9lIm8r/zSrRQjORTcZzh9R3xKr?=
 =?us-ascii?Q?szszn4yE90IgodSBX8ocvtqprhxlXEp8XUWbyQFtoDu3U51DxGE0Y+daSw5n?=
 =?us-ascii?Q?jRXaEosZuVu1xgCW6I5+tL8osnd3v8maCavEXj8qNZLT+x+pFwYowl6PXUwh?=
 =?us-ascii?Q?uplroKMvYI1nRBg0t3iGhVxQe+Nw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5f5cUrT1RgaWwMYvvGtumBg5RcPSGbdMO7ymh66GxE9MQ9xj965vk2j2lWYX?=
 =?us-ascii?Q?4WDf/VMCAgfjK7eSWWuwzhJ9WEGpzrOnOgjifrVG0KVv7zS9mg9AKJZscD7z?=
 =?us-ascii?Q?Q2NuKhnA5M+GeTBnGHSOCiX1kg0JgulTEBQaNYyKVsGyt59j3prK6OmGZt39?=
 =?us-ascii?Q?AnME3DXzqvJSGpN8lmB502erLcYLvUJo4RoNV5WuH0+ri8LiXvYY56XJORhU?=
 =?us-ascii?Q?+EMR4+gJCzTgIVGOTnphnXQAzxiz5bnt5DANjgcdMq6cuzSY1IvWTzUIgr+r?=
 =?us-ascii?Q?WxC/opUlEyImHiMJZEfXHffkDCt5bDkwvnYJjgYLCkR63c14MljesxWph0lB?=
 =?us-ascii?Q?wAW2jAYj/uvAuBz7V0Tjs3f7Lo9gp5JGECD07He1rPD7TDnItEoOeWPWDBae?=
 =?us-ascii?Q?oDwxJckFq5S+3Jl4aml9k5ZWCwDaPoSS2bqalDd/klnDXFiJr19ne5vN6iuN?=
 =?us-ascii?Q?o1lkIJZT1zJX0vJ7V2C/c1g0BUrWXE6jNLJrHj4DGaQK8hMhKuqIelaTK54k?=
 =?us-ascii?Q?Krzdmc5cU9ho744wsUQuL2L/3tjrX6ZAAyNJ8i88LI2Gq3FaCwRJURh7+quq?=
 =?us-ascii?Q?oLHkaxLEsuMYgdsMoBmpW6yBJmsqZWX/vy3EQG5h0elJllrF/nrzpeyUPPq2?=
 =?us-ascii?Q?Oi17+gWkAMeHfNBwsJZB4gsT0DNTXfYqaJfTkZBhfiZcgKT5TME1seyTQ47m?=
 =?us-ascii?Q?Bo4ABgPW1x/awbUAcA7zOHiPlUpO3WjyW/dkGQWG9t1x9IENtEXQOli+voKx?=
 =?us-ascii?Q?AdNToSGDambljbIyhar4ZxwQ98ed7Bas+348t4+uiHPCYO2yBszDcsk64kiP?=
 =?us-ascii?Q?cws/T+5DC6FpGHwrXuMQs93uYgENmYv7v4cxIrjqwr72bfRH6viqN9YzkEcN?=
 =?us-ascii?Q?uhzgYc8pg9il4ou6Ztt0u0y8NXEBn2AHQUqHB+OpmAvsr1la7H++Bc6QKWxT?=
 =?us-ascii?Q?7elzINS2RRUIkAmgJqajQDKjz34kLjgxhbtlcRWa6SFmBqDoc5+BCrPQSDin?=
 =?us-ascii?Q?/heuonWRhxIVI/ALpDGtxPTvxzuSOYLG2PylAhs9edlZlV6pHCFUVAXr/oQm?=
 =?us-ascii?Q?bOdjIk7t1Oer6hfqLrEj6nY5Iw2v5HLgRAVKG9EHgRBTXIsU++2c2zFfUcro?=
 =?us-ascii?Q?8388Sr+5hnt7HLTMTLv3GSH7D0qwerS3MDJbnIRKUC9AJyzygxfFKGpIDnp2?=
 =?us-ascii?Q?W5GarQxIMl9xM8LwCEruoqHwj43aEAzNRfw3ciZWfD5vihEkvbKjFdl9C3vS?=
 =?us-ascii?Q?4F+bRH8+npeVHR0ArFWc6PCCJ/dLtp4Fm2pK2cMWwntWobRM14roSikOxNBm?=
 =?us-ascii?Q?zqaU5lsBu93ZEfUsw1ttjozQETmrJB9e3sFOC6JDxc1z0nm3CkyGUeOOrJwm?=
 =?us-ascii?Q?PYQtH5B4bj1Wr3tGVwbi8TyYFUBYHGMOA4h+ov+7rZpVYZ2gdRP7C66MNRoD?=
 =?us-ascii?Q?mvBWt3sRVXZ3AeKXEzQ6HyRVIM/Q/JQMDOay7HVVPv/2dJ2/zZliFg2k1lNm?=
 =?us-ascii?Q?kbIKnT1oMFTY47InTzPxBQJAM3BUtuvbqOVUb/ObISMMXCL020NE31siekMB?=
 =?us-ascii?Q?gCdpFsf+EXxVupKwFJDfcGn4TC/4WttbN8Exeqsf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51c7285-f8a6-487f-aa0e-08dd6b0653d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:01:47.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBVDZU2W7cjkdYl2mdSxIZBdT5Q/GVIcLZ4AFYbwZ25Yc+twldMqge7MQdo1HTFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

A shmem folio can be either in page cache or in swap cache, but not at the
same time.  Namely, once it is in swap cache, folio->mapping should be
NULL, and the folio is no longer in a shmem mapping.

In __folio_migrate_mapping(), to determine the number of xarray entries to
update, folio_test_swapbacked() is used, but that conflates shmem in page
cache case and shmem in swap cache case.  It leads to xarray multi-index
entry corruption, since it turns a sibling entry to a normal entry during
xas_store() (see [1] for a userspace reproduction).  Fix it by only using
folio_test_swapcache() to determine whether xarray is storing swap cache
entries or not to choose the right number of xarray entries to update.

[1] https://lore.kernel.org/linux-mm/Z8idPCkaJW1IChjT@casper.infradead.org/

Note:
In __split_huge_page(), folio_test_anon() && folio_test_swapcache() is
used to get swap_cache address space, but that ignores the shmem folio in
swap cache case.  It could lead to NULL pointer dereferencing when a
in-swap-cache shmem folio is split at __xa_store(), since
!folio_test_anon() is true and folio->mapping is NULL.  But fortunately,
its caller split_huge_page_to_list_to_order() bails out early with EBUSY
when folio->mapping is NULL.  So no need to take care of it here.

Link: https://lkml.kernel.org/r/20250305200403.2822855-1-ziy@nvidia.com
Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Liu Shixin <liushixin2@huawei.com>
Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
Suggested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 60cf233b585cdf1f3c5e52d1225606b86acd08b0)
---
 mm/migrate.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 209078154a46..e37b18376714 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -420,19 +420,17 @@ int folio_migrate_mapping(struct address_space *mapping,
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			int i;
+    if (folio_test_swapcache(folio)) {
+        int i;
 
-			folio_set_swapcache(newfolio);
-			for (i = 0; i < nr; i++)
-				set_page_private(folio_page(newfolio, i),
-					page_private(folio_page(folio, i)));
-		}
+        folio_set_swapcache(newfolio);
+        for (i = 0; i < nr; i++)
+            set_page_private(folio_page(newfolio, i),
+                page_private(folio_page(folio, i)));
 		entries = nr;
 	} else {
-		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
 	}
 
-- 
2.47.2


