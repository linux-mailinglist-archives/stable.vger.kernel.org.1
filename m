Return-Path: <stable+bounces-134564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A5A936AF
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678CC7A11A8
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F14204C0D;
	Fri, 18 Apr 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlYYazZ7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F0188A0E;
	Fri, 18 Apr 2025 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976890; cv=fail; b=bI3CKn02bwcl9fWYjCekmy7vHydcrKXrlKmTa1zun9ullzHdlv2SqejZQYdlxNNx87fF3gm0xMtnDQiFPIXWKm2UjIlbm7rMGueNW3EdsalNPHQQ8H+DgbAbgM3iOQEK9rMnQKoSyfq3KBl146kv1vDjFxTdoAc2RPOAOz6/8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976890; c=relaxed/simple;
	bh=jsSRyuFluG55phuJIFnaGvzU0crY5G7MSYs07zj8meQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bx4jj+UFiZCNd1ihjY6i6OJ+JLYJ4br48xH6XmzwJCWL5JZvcEjFQF7XOTRYMF7T/euQ7c6IPCXM9FvZ97yXeX9wJxiM08JtRQ3MRCT+iVqQAJLZuufv+NeJsqcO2YXWxOL7BTH02i/na4FAF+OxMU0j/3FvQCzsKr8MZNfjsSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlYYazZ7; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOfn53IfE3GmZ4m4JTHU7LKCzwKlWPlvlWZJDXy+D0fhSfCTLxmlmqRoX+s1CKt1g518vzFR7Ye/tH3hkPeZpEOGR+HRtXx4mz6LmZN0bhYxOPezYMQ1d5BIvvkFx1yGhORycw5xcQk8kzNZGJDFoW222dlMOZzdPGaNwyIN1QJHAZnLirZzoKkfDb4o1g3qnzpcHSkEadzdhqZfiqPjlgZbh/cr84XDeBaNtOUMeu2cdqbJewXRsc5pLKj9k8z5MyYsNWIG+OPp92mhRveuQ3tLXP7qPMYW8xb7nkYrdCznkyfuRLelRVsg3jcVbv49gEwEOUZQtLPWo+9hOIfMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUrO7FNeWe59qBs9iNVOZoHW1JeCGbl7PMaKpGvjNzA=;
 b=o1n18VkrfcsIWv8lAgD8bJsg8Ywlz2cwIQcmSHEvU+euASHcWcwmb9Le1BIRT6u2wD0jUiwRkmXUrdzSzEwrwhxSvbXcAAmMWDLLKTYvTrn69YsfUyRA+E5+OxfSLTVid4l7KUJEEaSPwQoCxUC8s5D7kBlAjjqdZ/KgVWpS677paWflZidAKNlM3zpytO7QySX7dv4YwCOf7bM84Qi1fxUkMhosS93Zj0Nt5T2Zz9RunGKonLC5LxzJ+4G8tsXcnXUyYVQXxDWGzuO499oS3d8GbcTytOT6sN/BwQyb0X+SJJE63ebKo37WSdt/mnIuG59NJTDnACPDTORmsqj98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUrO7FNeWe59qBs9iNVOZoHW1JeCGbl7PMaKpGvjNzA=;
 b=RlYYazZ7tNr4H/orpi7gHkCB47Y+cWi05HR2un57gw5fsuiq/JSJCMqU6HSb/M9RWfSr84v4JpY52R2E13NTu/FOES3bt6Lrmi/GLPsD5EpH9lqpadn9Ld86QGybFHHhDbVwIc0j9EibFPM2bN+OBzkAL/eUIdLy3lljRkOwdbnzK3sjdDHzFCddXD9s+XChZ/2zyAs/JXhNVJDTsfriFAKdg2ozUjTDIYNydeahIKqb4N5uG7f95lZOWKkbFpnv/SDOH2IN2L7+SO88yuxqkcp9rC4TdvuQGR3sFldvdv55QMt+7uMXBgO+Gqow4xH/uy/87sKxlnD48vAz/1PWpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.25; Fri, 18 Apr 2025 11:48:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8632.040; Fri, 18 Apr 2025
 11:48:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: david@redhat.com, willy@infradead.org, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
Date: Fri, 18 Apr 2025 07:48:01 -0400
X-Mailer: MailMate (2.0r6245)
Message-ID: <B40DD132-10A1-4DA8-8E42-756758218CBC@nvidia.com>
In-Reply-To: <983ba47e-ab95-4a43-bca2-97b75c3c90d0@igalia.com>
References: <20250418085802.2973519-1-gavinguo@igalia.com>
 <983ba47e-ab95-4a43-bca2-97b75c3c90d0@igalia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: ad68288d-ff1d-4981-f188-08dd7e6ee05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SBpLzj4JFYZDhKZhxCA8pHoe+Tbt95Rkj4LZBoiKIgUhUcLcASYZc2bZEvrU?=
 =?us-ascii?Q?7QXWX8PwiQ7cJg1OLavQkTGbolNQjiWwP84LFnOdxMiuPiQKab2GnBoCUvd4?=
 =?us-ascii?Q?6Pc8DPk3kjNZ+AfpGDq2ILnvqIj7EysSp5egxgi3tB4x+RZtAgqDp9eMmgHU?=
 =?us-ascii?Q?p1hsAzrGb47nVM++67qLFWsANbQJJKbdxpNdCKFSbeEHfuOvZbgZhmaZJEAf?=
 =?us-ascii?Q?3AyXKvozsL1bU1EJafHSuQgfSl453JnKVQLNS175mrlJ/FVx8Jyi+mKp3UzU?=
 =?us-ascii?Q?TFF1tI3PVixtr7mv8UgVBUT4PdeHo0SusrHfaxe3+LpCk7vaefvTf4iMBx5j?=
 =?us-ascii?Q?5fUPbAgZCRiqKU1OmbyWbVWvmIu8dn8cQdlFeKMFMGhk5dD59rRTlh9Q0aIA?=
 =?us-ascii?Q?xcnNlCKiEMPDuBmXotQRslZ4uTkBibDIISoqTogEDLqD5SufU6swWVDV5CHm?=
 =?us-ascii?Q?uiXnrA+t7KH6hOaPZ+EQOn3Tpywneo1LT2GLCu/iE6PesD/lXpjcpJbb9VQC?=
 =?us-ascii?Q?W7eVyG2n71yCR5vIAma2frk8yKe7iMAnidZDcv8Cwl4vwABHLnyP76NVRvWv?=
 =?us-ascii?Q?oPQ+8B30tMngDM7j94/b+7h79jccF2J3zieqb4yH/R2sqc+LcRBncmNMJSHz?=
 =?us-ascii?Q?XLnGK+IolHGH07euGEk10C+tteXf4ZdnsjrGLrysobLPVLKmOaj0YHvdNnoX?=
 =?us-ascii?Q?XjKbe95w0nlNbO1nzQ3U8r9EC2FDFOH1gNwmlVMpCfemULaqSZ0mqpUh7v7E?=
 =?us-ascii?Q?H6zHEl/wj/i+wCS+r8ylQ7bbQp3IIxlbqsLxINHT4C59odV1qoA1tKgoq9EC?=
 =?us-ascii?Q?gu1dqeeBxgdH/Sq050APtqO3W/ZDtp/r8O7djT14KmNIYfiTfgSGW24VQfzN?=
 =?us-ascii?Q?CiwoIoh552yKdj8XxD99gWNP1dXrWyB0hceoKRxXfrg+SB4aYuzdReW5aCMK?=
 =?us-ascii?Q?JuxtmZVimWKIyRdp9m8I7geBlvozO1c/8sm0o6kWQju7RDAi1IJ04vAS14JY?=
 =?us-ascii?Q?8UqJl8wY5xGb+y+3bwVTGqf7+hWWWQuR0Z0mdggYUJ1wbz2deOOpCsK6KO25?=
 =?us-ascii?Q?8n7eueiiKBflJmcg+8Qk4cffDXe48ZCafyozNWrOV8corOMQhKFqse1NdXOm?=
 =?us-ascii?Q?rOsE/fN2CYyLT39+Hm6CfpioNLvEiVi3vxE/eWMeJU25HnQ2hXgN2c/yl78B?=
 =?us-ascii?Q?syzEuTfSAJjuUNrFP+tP8edNF0MrWGVxPg2Bm1ZlJrr2LUGaeC/4haoDtJnN?=
 =?us-ascii?Q?Z+bXI2tBoNm6ovAXbwhU3dcxIh9G5UE5LYD/blKvHN9J6w+kwPK92MDw6xHU?=
 =?us-ascii?Q?22te1E762Ipu7ZDWYrJD9y9BrpM22vkZKfocucbzm99YIUYE0LwCDuXiCl55?=
 =?us-ascii?Q?JMfv3A9BA9x56SrIJflIDjANFBmP7Jzbts9SzVeOb2gDheWmEi3p0I4/LK1n?=
 =?us-ascii?Q?QloAXpBXhjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnq/fGlYQ+lyRGGrJqqO8e0kkEjC18cD4UA+NJiCMyqKyX9KdFeUeZl0HdHm?=
 =?us-ascii?Q?8LMah0JxRnNVkwG3Qi3155pt4DY5nHwUi4yERLOZ8VPeyGvQT90LKX5rXrsa?=
 =?us-ascii?Q?iQ+KynOouUMFLPqozGz+06TzXsaUKcqt+NaAqDuGzkMgkTruY8XvTm6hWv3P?=
 =?us-ascii?Q?QHHOLQYQ8kHHeRF06IoQBuX+WgQug7zuGBJ7FNI7Mpc/1+3QY9azydlgzUT/?=
 =?us-ascii?Q?/ce83OLIzsX3jSiiMQWCyS7ouclTsV2kGBhdqzLsAjkhoBZcNDVwRC42Rucb?=
 =?us-ascii?Q?Rqcclt0o/fSgXXWOJvszoodFjYap3KI0wIgvTHLye6iB/DcXsia2qWMCDQ0N?=
 =?us-ascii?Q?Q3qU6JKXNs3bLTIv0YfBLGdg1aqGbb1raAvCFBjs26cCM31aNlNVNGCdUN7Q?=
 =?us-ascii?Q?aAAEdzJXG6cts4BLvkTcVRqPQpcdKn/vfp1OFohxH3CEYur1wW43qmLsx21G?=
 =?us-ascii?Q?VEFCL05D5smFWo42N2LLYxejdOCobxonAn14nZsNIV8EYReEfMclvJ2oobaL?=
 =?us-ascii?Q?sxi5BKwVfhjbMsxKmCHpfNLQCeSmodBR3mlf1ztVu2zGiKQ6NLSZ1hw5Onbm?=
 =?us-ascii?Q?CY748uhPZttrQ8owPf/+WBPSGLrq2SQqawHY1SMFbMuEiD+JB02gMwsZMBLT?=
 =?us-ascii?Q?eHmSbJ73ql+floImC4gsPZsMU2zEf2gBU7jyx2YgyQPjTZnVV/XHOJEzmA3J?=
 =?us-ascii?Q?wnxNIh63SYIVmiNiPBBmy+KxSFgb82plBzO1RdmUux26FQyaFc9bKfv8z1o4?=
 =?us-ascii?Q?OwVEe5TdzrvQmA+F1of/EjDsKeBDI9TAA9IX+Y16KWB0nF3rctfo/Uua1qqi?=
 =?us-ascii?Q?v2UvqjHWOHYUEt+Tx0K9xjmAdtvdctm5aZUjGUz17C2Tu/fMBVm3s+5zc64w?=
 =?us-ascii?Q?hFspTSlfFYnI9N27sh+o06wniEdkfHZQkdHDnZUOJhR0w3czcSyR1Czgwv5t?=
 =?us-ascii?Q?sAMYv0PS1jsKaLO8VHJ0yofutX1413E41mOx6wrpkgCOGT+SNDTmPK1SkiMD?=
 =?us-ascii?Q?bn9UDENBvVJV1guNv0yLcYwUjyEirqOVg1T0Ju7m5r2Qj90i9Pct9a3bncje?=
 =?us-ascii?Q?rULG7ACGufggIax43niO+Q7fQgcq1Sqq6L7oM9+mFqz+FkhPFzKsc/mMqLvT?=
 =?us-ascii?Q?b4Gxck8EMY8gNQan+1BFXFqPKVG4kVmKKdpwiguIwhfkNGi1hJyuMvM31MIa?=
 =?us-ascii?Q?Env3uMA5jgyHJFrAJtQmf1ufvlVJ0CEv88e8tsXGAo0hY9ERKgqDfdNx0VmI?=
 =?us-ascii?Q?MXtkNSRh/iQyisv7Otp/PZguoTSyNuhcEcUr1SGBhy/GOztwNDFdW7u6Uyvy?=
 =?us-ascii?Q?MYCAGAdv2EJw1ZRe+K4I9U/TfD5wqvA9G/fK80rZ4/kxNIEVzq9rqrEQ75NK?=
 =?us-ascii?Q?evgvmyU/4aPB3Xfzii930NVcIrfy/1KnXyXw/umWd+pLXkBSV9nk9+AOfLt4?=
 =?us-ascii?Q?LUn7aOwZj2ADEn5rs3QZiOLh7CyG8Pz3WaVhsWRHW77ITq6xO2ajfdAYSyHw?=
 =?us-ascii?Q?m5gnNOx+MQvzzwe/oUEENMVOpohQIeeBsSo5uw4dKJGvFCBASXIEMhRa95Hb?=
 =?us-ascii?Q?50/EFeiRPafKzhCYVe842Nq6SAk0jBpk1WxSe7Df?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad68288d-ff1d-4981-f188-08dd7e6ee05a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 11:48:03.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SFF/3jMZb3MsixSrlc+AYnaUNcA8B+CvB3OAHGRaskN6AINqXoADBj2wDnUs7eB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

On 18 Apr 2025, at 5:03, Gavin Guo wrote:

> On 4/18/25 16:58, Gavin Guo wrote:
>> When migrating a THP, concurrent access to the PMD migration entry
>> during a deferred split scan can lead to a invalid address access, as
>> illustrated below. To prevent this page fault, it is necessary to chec=
k
>> the PMD migration entry and return early. In this context, there is no=

>> need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
>> equality of the target folio. Since the PMD migration entry is locked,=

>> it cannot be served as the target.
>>
>> Mailing list discussion and explanation from Hugh Dickins:
>> "An anon_vma lookup points to a location which may contain the folio o=
f
>> interest, but might instead contain another folio: and weeding out tho=
se
>> other folios is precisely what the "folio !=3D pmd_folio((*pmd)" check=

>> (and the "risk of replacing the wrong folio" comment a few lines above=

>> it) is for."
>>
>> BUG: unable to handle page fault for address: ffffea60001db008
>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian=
-1.16.3-2 04/01/2014
>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>> Call Trace:
>> <TASK>
>> try_to_migrate_one+0x28c/0x3730
>> rmap_walk_anon+0x4f6/0x770
>> unmap_folio+0x196/0x1f0
>> split_huge_page_to_list_to_order+0x9f6/0x1560
>> deferred_split_scan+0xac5/0x12a0
>> shrinker_debugfs_scan_write+0x376/0x470
>> full_proxy_write+0x15c/0x220
>> vfs_write+0x2fc/0xcb0
>> ksys_write+0x146/0x250
>> do_syscall_64+0x6a/0x120
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The bug is found by syzkaller on an internal kernel, then confirmed on=

>> upstream.
>>
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common pat=
h")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@ig=
alia.com/
>> ---
>> V1 -> V2: Add explanation from Hugh and correct the wording from page
>> fault to invalid address access.
>>
>>   mm/huge_memory.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2a47682d1ab7..0cb9547dcff2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
>>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 address,
>>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>>   {
>> +	bool pmd_migration =3D is_pmd_migration_entry(*pmd);
>> +
>>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_stru=
ct *vma, unsigned long address,
>>   	 * require a folio to check the PMD against. Otherwise, there
>>   	 * is a risk of replacing the wrong folio.
>>   	 */
>> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>> -	    is_pmd_migration_entry(*pmd)) {
>> -		if (folio && folio !=3D pmd_folio(*pmd))
>> -			return;
>> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>> +		if (folio) {
>> +			/*
>> +			 * Do not apply pmd_folio() to a migration entry; and
>> +			 * folio lock guarantees that it must be of the wrong
>> +			 * folio anyway.
>> +			 */
>> +			if (pmd_migration)
>> +				return;
>> +			if (folio !=3D pmd_folio(*pmd))
>> +				return;
>> +		}
>>   		__split_huge_pmd_locked(vma, pmd, address, freeze);
>>   	}
>>   }
>>
>> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
>
> Hi Zi, I've carefully reviewed the mailing list and observed that the i=
ndentation is not a strong concern from the reviews. And the cleanup sugg=
estion from David will override the modification in this patch. I have de=
cided to keep the original version (the unindented one). Let me know if y=
ou have any feedback with the v2 patch. Thank you!

No problem. Thank you for the fix.

Best Regards,
Yan, Zi

