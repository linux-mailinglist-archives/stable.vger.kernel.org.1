Return-Path: <stable+bounces-207874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CAD0AC34
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00DA6301703C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DA2BE655;
	Fri,  9 Jan 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/KK5Gca"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2C30BBB6
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970669; cv=fail; b=MWs2GyO5i3PN+Qd0r0gDmXPnXWkkPtuFhS0SM3pLIshMSLKXNqBghKTu5egfr3w14vh+tKZSMvjGF1pmgJGkZB5QCEb0dRYPaiOR0LVrMPbdkY+fqOxSrz1XbjlNs2n83BCXaODSZbXBXoZffxjbXbt0P3tyaZJRPcZelVd4ask=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970669; c=relaxed/simple;
	bh=usWyxlF4Pu64JkQwGZDQTbiB1wkzV2lfoK8bt7vX0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gju836/wzP8kbn7rPAX670dr/EafJsAS8mVhfGPdaLSfnwcuAVcijgM5G7v2Hm+5Fui1ZGMN7DlS+Vyjr8eQVfc9//VOV9/4bQTR53zHeGEr6BbL9CfK4wybN4/n2r4lNZbKKDCFUcaOzJ86mLVJ+aIspnB0KBwMMqfKxBSt2dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/KK5Gca; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ1Wz9GdwKfPY94KZ7kbEKqlEJs+sdDRbcMEV9oUBxxeHHlf7ogZQHnh/ufDL5Z5R2sx/JH2LAsKKYPqbGf7pgkzM/O0hfFjc/BUPRUc0ywIjsgCHTuYTf0+rYJdF4iIfN+45g0+mdat9tvIFf9Romwosq2Xtjg/j9usTmCP8y22N3GOpiZdvaYnsYYBu/0iVJbVSCxZWqUomSq1hH/xAJE4WrkN/Cio7T80y30IM84Qes0re4g6jKmcKgpsiUiTYZMNWvt01FPrd2FGBvrVvJk3VW+y6C59GFBt3E1Sa94bmQq19EhvpSQJkUjs2EZXGhDZe4q2zR4oe31WJ0B9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRR2vYrGXqkWjxt28bcreWC6p3pj/KzurKO/gQIPMBw=;
 b=LATb8a+EkFMVZwycL8ClyNL5igYpfODcn3vgiE6WWoNqL435Od7ZZrE5vJWg/MFtqYV8PnnvEG7tl8hLiytxWhuN1njNdFAaN8ROdmhU/CcV/KQGirPaXG6phc+qPY2aaYwKqs6FNobiur5QzTLfU92QAfX7ktnU6xVnGI3sb4ILNdEGUL97tP8hTCa4Xeb++5bCYTvtL2B5f05jhswlE1gnsevTDcQ5UcLy1Yp2Lv3z0f9aUHNX7nMMzic/p3i3QtcJqSYuDP/QiBrKWciQI8UcJSps5ruxNCWiZl5HzHTh4KiGrPEnnClJ29bK5B2dTPtoNHuPYmsToR1+WjsT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRR2vYrGXqkWjxt28bcreWC6p3pj/KzurKO/gQIPMBw=;
 b=H/KK5GcaNLSQDd+oT/mLac6xZED9BOFofzYZuN9gGXDNTnTVYkWWq5kU5Yp3Ti61sU6h2ayNU7WDPPvDYhgi1IJmlTfc7jILgDxhNVRt2bWrS6WDveUYv93A5Fv/KVIi9BNENYlkuMhH+52/FkkNK3kOw/fQy18V0vjD5uS0GfrDuZFDrtEDVLOA2GYAParPg088h+SIU+lJ09kg3l3+qSfT7BhisQUCIzMDRILBqzh6GnOWWv113tIbPeJAsJiczUL7EOq2ElRY0t/MHjtmj0Q96hvhp1GHB4+DqnSZRoBkNXF5vAqk6v4efs4lVy8RX9DiL3g6np4/Uk7gEZTXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 14:57:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 14:57:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
 Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] migrate: Correct lock ordering for hugetlb file
 folios
Date: Fri, 09 Jan 2026 09:57:38 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <B1C9EBCD-A17A-4649-8B18-C16E173D529F@nvidia.com>
In-Reply-To: <20260109041345.3863089-2-willy@infradead.org>
References: <20260109041345.3863089-1-willy@infradead.org>
 <20260109041345.3863089-2-willy@infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: d77fedc8-03b9-4d4d-9e19-08de4f8f717f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U56MusycxYmIQHYhYZyJLNIaWnCaGMjyjITlYIhejW/FylheJeleaf+ENuqb?=
 =?us-ascii?Q?gzqEldfyarAmBhw1gI2wYXCVNkBaLu1HagBAro4Swt5HkJmkNSwDsUa6EFlb?=
 =?us-ascii?Q?EDew8bLYAI8qTpaSatgPc1m1JrUGHDL1Nq2X++D1wDo4iEHkHwQ5T8ozeTmf?=
 =?us-ascii?Q?mSMEKu/IsXmKLyHwaljbu7tfrlIClfFLXllp/SB/gog7UH2HGTxvQKGw6I6c?=
 =?us-ascii?Q?NtSQyHFRmumJ6Sf/n7srOu2HIcuLroIvErrUd7Cg/nq6I/lyOecN/CkcP0HV?=
 =?us-ascii?Q?fpuzAMBbpwn310Mtli0xbV4Zxw0McD4vYWM1WbKKCyq0lkuVVgAMri3xKWRV?=
 =?us-ascii?Q?6ePETePAfmXJPRoxr9nPZ8fg6aaQPFDEVR/tMlSL/eCxFSLp65sci7haIIyd?=
 =?us-ascii?Q?VtmIOq7b3RRA60/JFpTTd1d95crDk8BeulsIX/7n7AO4xZZj1GAImetXzaVo?=
 =?us-ascii?Q?4PUPXrgTnB1c+gXV1p7BEFoMFZxfQgXl6umBeO6GwS46tqR1EFgQMhJzA/D4?=
 =?us-ascii?Q?Lu7Mn3ITqU81Z6fI23vtUTfHphoNnjIav9UXPkP/dNkFgnQ8ZdLT5Y4XpI+B?=
 =?us-ascii?Q?Mg/L1hqxRXJHasi9NCAMmykRyu9AEFI86+4+AlsN9pro5MCJDlYtIaUPzxqy?=
 =?us-ascii?Q?h3eISn3pkFv6EZOyEqHSOiEpOu/pjtc+m2RopKfZUBPShDP1+VptFugx4kh9?=
 =?us-ascii?Q?ek4NB/EyIwbb/y92LughiwZAAioI6Aqz7t/fitpPw7RWC+696UKwXQXtgR3y?=
 =?us-ascii?Q?SemeNJHWUn9xMreTyiO/OrZu2zUayWcYVdEMyf7AWrTdz7raBezMw3ZMTyRS?=
 =?us-ascii?Q?nxgjU9/M1SSpl7vTpbZBLPGy391UNXqcYKsIe6vYFNvBOyYmfYPO/seVhjYA?=
 =?us-ascii?Q?v9d4P+xOdCb/Zzb386FeMCufDRNUxZpVcINxl6Svfju/HD9mN2oLMziDtfaV?=
 =?us-ascii?Q?oWSWesHvSxy0+Es05GWHeO/LuarnZ20QasRMDH9EK31mWGUyl4e40r/kaKw6?=
 =?us-ascii?Q?VP56R+oio1IDtvt4Du41NXJUyCOEfO0zPTZ5fu/cwStz2pFkxuMVBWIRlZRl?=
 =?us-ascii?Q?4ThpiIpP0NNrTZjaspsJ+MNI2xHv6kCrJdam8PPDt6/bCQAjzaIhOzeCExdx?=
 =?us-ascii?Q?iMeEJlRxqbef0MTb3IGix1godBxKTDR1p7L2wx0yinWKyJt+BSlC8UZD5Te1?=
 =?us-ascii?Q?608vlwffCLQAf/LmeJx9mEp5KZWLN7D0c7Hk9FJUAsTmZCDF1aH+FuWLqmot?=
 =?us-ascii?Q?JmmwVWHM39aSqaYj5yb3XIvKbHozyuZFAggUtTJkmAVxfN0F+9UirrbFZ8fQ?=
 =?us-ascii?Q?WIXSvjVepWtmRRijfcO+BSQPdfFvXR2ssBZ+n3LK/0THO99A0qT0znnACAn2?=
 =?us-ascii?Q?wHuijokLxcfb+k8R32fZKWlUM6PuKsP97JDaQWkKj4mSOTt/Jxi3Vrv0oHht?=
 =?us-ascii?Q?aeoRj6GrSH5Xzphj/GB0lMcs7hkFxFHq6u1OY1B20kgFUNu2Q96FEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NEDT3QnzqkvIr3Prgs4JG/JZqHN2ksD2NLU8Pgxh7KLVgafJDBgbJMpRMVhf?=
 =?us-ascii?Q?y9hwrCklXw0/SQlx/xiaOwufde076koJh5DQvobU6t8oAomn6sFIkdKnL5Z3?=
 =?us-ascii?Q?7ogTwFRfUZaABmt72DWUuhW2kWB17jx7cCr9k93ffLohuEthVmVoYhHbwK0C?=
 =?us-ascii?Q?9ziTfxy0/eZ3zgtZDGFNRAvmSrs5vCJZdMBdSblhrHGtm/T1jejw3VSJR2wC?=
 =?us-ascii?Q?VUw2mSgxmSWhPTsAdKQfN4wOk8dtKNPOhZvftMs4vbrToYKHO8E9+trmKTFw?=
 =?us-ascii?Q?Jy+R5oIwAa1zo82VE0r0Y6Vw5z8jR6Srz23AHCACJiGYg8uG+SsTkAgdLp5c?=
 =?us-ascii?Q?k2ik5NNOmGim5i1sB0ycaxOrQBJ0b0mJDF2X9bwqgz94kh7rxy4dJ3gI3qdn?=
 =?us-ascii?Q?ioHeklgxd6MLtALfibZ3oIDlog7IhPd14u5qsuNxI7g6dQU/Lml5YGXNb9IP?=
 =?us-ascii?Q?GYLdfOt5Wfet5xN58O4aqtAysuoOBTxnrf4AWLI4iWpOY2EU8R0SUytrQanS?=
 =?us-ascii?Q?0go90ts4E3hvcDKGL1wE27bdZ05jsuCx2hKJJ8kUUpn6THFxfLAWYplcA6fg?=
 =?us-ascii?Q?BjpmgxxPQjBjhi7tvwfquP5eamX+PGfyUIyOrHGheZE+3Whn26cJ5Tjoj1hB?=
 =?us-ascii?Q?yY8+8FcsQxO/+xVOUbKyze8Qcux4LxkhhnoBvWrCjJpgMaI5+y6RP3TZauwv?=
 =?us-ascii?Q?aUV9MRYKEhatqz2zYCb4eHOxjh2dzm4UP+vafvniwtmqFL03m7eASKpzGX3P?=
 =?us-ascii?Q?Hm2/HmW6bE3Dapk1GqPabALe8/GIG+ydH2G6+LeDdpHbyck1hq6wi5BeNxcf?=
 =?us-ascii?Q?qZDQJRdSwSISnaLGau/WhcTgL33OA21WYen+AjDI6oF8T55w6xgmiXj1b//D?=
 =?us-ascii?Q?yiCAbvvCT2itULVTw//1tt+Ya54PyJk6BK8fCX4spTNR1m6mdoCIKdj+1f7h?=
 =?us-ascii?Q?dYSJBNNeaePER5W8PcareIob2JiUArsEaYRyB8EDCjtQu4J4kplt55LVj+P8?=
 =?us-ascii?Q?XvzZiLwBYLIHdajbnCOtgT0Tfy6hOtNhwU1BaQNx0vzbaU+bAmaOQq3l2n1Z?=
 =?us-ascii?Q?/lQ8O1dpE4GmSKg2zY8K65qAUGIvaxkEbnWtSDj50w6N/GEte4KQ3Gtb/6b+?=
 =?us-ascii?Q?SgkTxmeXvqWu070tfxde5xAqo2uvMpnF5zxpaF804U6yGHFpnn8mHstp2AXB?=
 =?us-ascii?Q?rxv4SYiOugGW7kSnpxMoAQNLMPpCbUjXCh1WAHRYtihmn46kfh5WbjKR1Acy?=
 =?us-ascii?Q?tlP9DWtYJ/vcgfypM/J1+BPzKhxciwueTEGtSRBmJmG7zFUzXaUO8UoHv562?=
 =?us-ascii?Q?/wFnfTlO8C3Ph6LGDUWvnqR8hn9n4kdB64cjPMjOka2DWIXGLzsMg+fKtVNd?=
 =?us-ascii?Q?LJ5FFN4lsaES/g3tLCrwxHv6gD7OzQhJ2UO4WYrygU9zxYuc3f+XleDNv6tt?=
 =?us-ascii?Q?CdULVDG2TQOqhlBeYWXJeqZPNiAuc08ADDIiN4S1yEllFLaqjNd8MIe9nAAD?=
 =?us-ascii?Q?usTPJEF17B0XSOR5Q2N73LZug7GLU1A6gIlPYdeQ2RskWCpm7i9GRvJXXmr7?=
 =?us-ascii?Q?Sl7a9QnYLHRltR7VcaAlbwd9ZEKH73AmQkXP+fdut3UG9+mNFjzRtZomos63?=
 =?us-ascii?Q?5phgR1D9MHFuK2zMGo7WSTMVgkbUr9VGwwQZ/I2A408w/t/V0svBu6W21Cwi?=
 =?us-ascii?Q?5Vs8KcXbSEn/LIJdmYvAr6AGXg9Eha7u6ZDLM4pUdTRFKhpS/SeGsCGMIfL0?=
 =?us-ascii?Q?iGJGQycCjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77fedc8-03b9-4d4d-9e19-08de4f8f717f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:57:43.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPV0W4OSyEVprQ/89cHvBioA/eF8sK2CjuAciDkoM/lPp6dWhXpok5J5Pb94sX9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528

On 8 Jan 2026, at 23:13, Matthew Wilcox (Oracle) wrote:

> Syzbot has found a deadlock (analyzed by Lance Yang):
>
> 1) Task (5749): Holds folio_lock, then tries to acquire i_mmap_rwsem(read lock).
> 2) Task (5754): Holds i_mmap_rwsem(write lock), then tries to acquire
> folio_lock.
>
> migrate_pages()
>   -> migrate_hugetlbs()
>     -> unmap_and_move_huge_page()     <- Takes folio_lock!
>       -> remove_migration_ptes()
>         -> __rmap_walk_file()
>           -> i_mmap_lock_read()       <- Waits for i_mmap_rwsem(read lock)!
>
> hugetlbfs_fallocate()
>   -> hugetlbfs_punch_hole()           <- Takes i_mmap_rwsem(write lock)!
>     -> hugetlbfs_zero_partial_page()
>      -> filemap_lock_hugetlb_folio()
>       -> filemap_lock_folio()
>         -> __filemap_get_folio        <- Waits for folio_lock!
>
> The migration path is the one taking locks in the wrong order according
> to the documentation at the top of mm/rmap.c.  So expand the scope of the
> existing i_mmap_lock to cover the calls to remove_migration_ptes() too.
>
> This is (mostly) how it used to be after commit c0d0381ade79.  That was
> removed by 336bf30eb765 for both file & anon hugetlb pages when it should
> only have been removed for anon hugetlb pages.
>
> Fixes: 336bf30eb765 (hugetlbfs: fix anon huge page migration race)
> Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/68e9715a.050a0220.1186a4.000d.GAE@google.com
> Debugged-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: stable@vger.kernel.org
> ---
>  mm/migrate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

