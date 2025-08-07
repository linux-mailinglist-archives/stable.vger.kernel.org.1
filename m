Return-Path: <stable+bounces-166804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484CB1DDB0
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49531AA5590
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB631222576;
	Thu,  7 Aug 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWm68Ab4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2E1DB546;
	Thu,  7 Aug 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596321; cv=fail; b=uhpeN/yZn93sQ2RKvveijH3aWuEuAIjXkNQvfLX1GEgewOp31OPEMb9pfCLR3ZmFtn2rNGyURj5Wt6SvXlpFh30keec06yGFktH5TgQFepyqNP/I8qF9nREyL4CK2si4PiEmIpEsZjyeYf5ZNzzTpgi4f3f/SpEgZxDggL38dB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596321; c=relaxed/simple;
	bh=kVRw3uDzsY9w8Ci/4YLIwWvW4TDIxKiuXaDm7V8UGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qzx5JEg34HQzG8lfBP7lZEQ+W8NQwFhKx8JGhEeAjwI7DCMqVOayLHyZqZ2G6MzUhasLfK7P6WCFlj7P3IYHWtXmcKlrawIoJw+HoZnw0pKlYqRrEgHHcBk6yhMuGDJRmPKtlu80/GTCnJe1ClScj67s/iQb3WO0+8VkPzI9Qlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWm68Ab4; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRXmP3f1WBBg2p5T82YvB1/RB7UlqkuuW4L54hY3wUurRKoIE26Je3eyrahfJvvrqTMtvgPjX0anm4MUq6EmPw7u6ODmtuR1ymzBdoHJ3vCAkPsS+mAD6a/S45QtDZo92BgTP9/oSIevJA3X3Zuqrbh7fIFWlKkk5VP6jTBSrJq7S8U+51mUcA996R/P8kn2VLXlenYHHTjGlaQkfd/3JraxmaKuB8G1aWR/TE43zOg2x81LsRpLi433NsaNrERtYI38l9BmkJHpX98qHFiLXVscCqIVzhfOzO9OMVc0g6d83ttsusentuov73VlV8KUz+E+obVYpgbrgs61qvAVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCZOKuFaQPs8/vCWVzdi+CaBYgbic5euOjIrOfoq8f4=;
 b=Vnk+e5Iqv2o6aL6Mc32EhuPTI9AnbkO7d5AT4I/s7IaPjnRxRVcURY9pI/Djdv87AER14xxvcp9CMTKowDIKFJetAi4cxB6TLgI0DfYJLOouSV3QPlrcVChte+GTslcC0ZPAdbD4R6GedqAKZTnVynkC/G55YBmF1MyS28LuYioDyIWVe2dRUiQmifDz3mKb0u9qnL1oDZhcfNS904eSe15ByeD1OzJdZYqmCwjJww5jgaaaq68G1UnxpTJTmIeZvIC9S51+pdUEee3qPV+9IwlMX44v0gfF9ODRN3uenl+yvYBdMKkrZOYDTbv2x+eu5WV6hNStVIjmbcNChuGsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCZOKuFaQPs8/vCWVzdi+CaBYgbic5euOjIrOfoq8f4=;
 b=QWm68Ab4qT2avip/ZW8vc4Z87NKyAjRc/xZzcItHJEtOnOpY/vj8kDaBDi6YMMlrYTRAdcYNFhdz/CbMxXldIIKx3U4JA8HmTf03/H+O/S2JK8W4LFjPmrNlYMI6qT0vEvQ/1qZn8j7PG868kgDmPUGahrkjkjceBUdqdN8455ffjOuoZZOlL/DSmr4QQAjCEjdDGfbM0irSBY8xBxz94Cs66AWWYkn+cTcp35xBXJd3qHHKNKI6q3NoUb7haD7pFhf5zDxyAlMjx48RQ72sgglFoirhIpoGntiCNbfwd3PJkfjv6CNswzQmZlGS+hd8FNtpWzyK2cUUZFa5wiE3iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Thu, 7 Aug
 2025 19:51:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.017; Thu, 7 Aug 2025
 19:51:56 +0000
Date: Thu, 7 Aug 2025 16:51:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250807195154.GO184255@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0c4d47-7f82-4cf4-8b15-08ddd5ebdd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qSkXhWmKxSS8b1qqgLHZDdZfW8SDPbY6LYpHrTeVIRYZOivcyeBJ9+DHjQKK?=
 =?us-ascii?Q?ql0Cdzn3VCTN8/qVwR/dLCZRqJhm3sC/4fXKaq7WA/ZHtAqDn3N3GzPPuoC1?=
 =?us-ascii?Q?/chErZ6BhvJKvxK8S/s/9zBTgTAREhSswT65K4fLnILAMh3mK+HBWnE1ZdqX?=
 =?us-ascii?Q?AW9v+uIAv9Bg3wEZy7vV4u2HvTZeCcqVep7A+PVxXEbpOLYEtt2VOX5z2xeS?=
 =?us-ascii?Q?VIpvlL3FBFWkKSm3KoEyTRX7UTqshmVAYuCOwE4Ormku565NopnuXegUxJHM?=
 =?us-ascii?Q?InIwFnF3+D782AlRHV7xmMtbH3sdRV0XkkVbp04hMwsOJgZSMVyPW2d7jTLK?=
 =?us-ascii?Q?p1xVKBiioctrrDozqa1HuQQy73JOow4+1dEcXLGnqGdJSKZRirrmxY/sHyH9?=
 =?us-ascii?Q?a1baL2Fyya9YPDXyYX6XEZp5QCkiOyGBCNcEFtqol1X7zSsGT2dupHVSu+2R?=
 =?us-ascii?Q?+grp+G+ZLI9wRox4Dk/hgrCKERpzj6Qdlv8qQxXRsl0rKN3kqVmZHmJF7OFA?=
 =?us-ascii?Q?T+ckzEvIrBfnYYEnCiZK7xHdz+M9JgEvPr3HqtVSQwUmp3cKD8+MgWE8Zoa9?=
 =?us-ascii?Q?cDn3d2wGQ/30sI9WRn2FHfutsqtIc1wzZzo4A81avD1AgHeL3U0mHaELXEgB?=
 =?us-ascii?Q?zsg3uTtdzokLXeT50bzAuOSosiljp2/WOyJml6QaH72t0YOwrFcYRIizqX2s?=
 =?us-ascii?Q?2IR+nOozwVhGLEiUzwlKJJ5z5ezPSx5gMPqG95Ee6fxYvCcc3bEeSIzGuShm?=
 =?us-ascii?Q?EVvwO3njGqrNgW4MCP1FqSEIz8eAyb3CZI71cmn0ipKENzRuKGmZGezymU8K?=
 =?us-ascii?Q?/GjXkGT3yTI7K2aYtBo0RJZUG2iLoiM2Scf+i0TYoQq0HiG+PhiMpQI3aqjY?=
 =?us-ascii?Q?zjt6cI72/b/wgm6gwFOfmqQjs/qQrNWeAaQEBBXh2AKPilu2OYiIciTSwYu9?=
 =?us-ascii?Q?gb8D28oCHPl6LKOkulBR9XF/6/ju+UZ9ZrmjAycFct0dGeXZ6QmT/As7YP3a?=
 =?us-ascii?Q?DpCz1IpCWSX69kp1OILfXTmoJr+jYUjnWc+tMMvvoym8vFQO6cLwysXE5Sdp?=
 =?us-ascii?Q?7LcEnwZzaP3WyWoSzUU1nx4q1sSJKbo/1hQ5pN3/SgFJsZ/WZDN/xuqVwH5g?=
 =?us-ascii?Q?DOgqBwtSbpC4ZolQknZlSRCxug5Etw3bv3l+b4Mlk73FBMEnPuS06C1qrIn3?=
 =?us-ascii?Q?xnY3zRSFKnz05efAHyHJhhk9lRRC8cRbPve1maTAdDtZ3MaqUH3u0Vfu/Q6j?=
 =?us-ascii?Q?ILxyYsMC6JEoxZe3eDYr/tItoRxiQzuh78eHp0zjWJcANTiGS66cVcwu1eVy?=
 =?us-ascii?Q?D8WeidWdiPeqo8smdDe2vWUapk/YdTxvjlJ3KpSkTM40OsdjjrAWZDN5czgQ?=
 =?us-ascii?Q?rcN6nKX0T9l5aUYs4KAjIoWuCxXXmVsU/Ntq9BVv/7tXEFHLrH7m3SsnjFOH?=
 =?us-ascii?Q?SnfyYIUUqHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jp1X7tbQXfm6GihcWEzITeFlnIVsnyut4gDJomLN3U3jgaijEsr7vQGBnoRe?=
 =?us-ascii?Q?k9FD6/oTCqttB9p9KGCRWh2//c73JaU4BPnx64mmc6GlIxOFYaAGeUvCW/vs?=
 =?us-ascii?Q?pUgjCbNFSDhatsU0ybip1hW/M6NIdinIdKQ/97wLlA5dev8NpwE+f+1JFaOt?=
 =?us-ascii?Q?1LI9VKGQitYVSyhsqUY/JWhNBl9SRrCNDvd/9FEvst5gFzCDf68Rf7CPWqJv?=
 =?us-ascii?Q?PJGEfz9EffPOMxXBZg2SS8M2WXVlvh835Rg2pq2gNJhz+0C6XSajSRx2sqpX?=
 =?us-ascii?Q?wrkuCRz4LH22uRXiGE+3Ypk+bPvd3JluS/zI7Jy4mEr7cQHN+GAMKuf8vqaM?=
 =?us-ascii?Q?GcWht0hu8ppzCC3GtM6JPjHYbtMCNin2P24DJ0z/Z2TIKhnZxGQgAymg7OBZ?=
 =?us-ascii?Q?bAIFE1ujm4cPcpuI5zRMZZwM0J5YIUNRaouaw4g9yPuYc6sC/OqM+5d69t6X?=
 =?us-ascii?Q?VUoLvStomY+Jn6oLM/sOjkdytp0rvHyjItojKgmjuTNhIcEadaAXLgjQ7RqE?=
 =?us-ascii?Q?1+AJW/6EerGslMagbaAhP4VTER44Zy4KOJM3LJ80kOxJBG4Brxw0BU1npRdE?=
 =?us-ascii?Q?AlJN7kVTTlGgtRfuntWB4UW9UabL0x/LQH2ip4xWU3mTMefpx1upXRF+EQ/q?=
 =?us-ascii?Q?NCzh6IyXfh22DvZNGbLtdihrfVQFGB9Xst7Ur0gDeqX2lIyQhrmLbSJWj6v/?=
 =?us-ascii?Q?S3WJVPg9DyEg/y95vhjJGVMGI22/bAOudC3NkSpc/rIHRHpLl0MCqluG0Wtc?=
 =?us-ascii?Q?qHTa1eJEY/KeYfkwjEml2woI5hR8GCgxIzdFv/bDCQcuQbwxpy8e9XDiEsBH?=
 =?us-ascii?Q?mKbaG63su7YyimyuNc3GlQKyuypG5WVfoTUAXeG56PG0Q/acRNcGzRkkihMC?=
 =?us-ascii?Q?wahPKeHbHpOXwc8B2QuqINbuZHKSG2iHdqsehkUA9532cL79L1UgnSeAmMue?=
 =?us-ascii?Q?EIULLWH09aP7SIaVNWCEj5Y0hGa5DLjlaMDd8ilLARGA7I3Ai3gaMZpBIAKJ?=
 =?us-ascii?Q?w0gF4/thUOPqc/5AWb83VzRwnS5MLiiGNHjSF7hns0cYLh32vvZtg1BQKaAH?=
 =?us-ascii?Q?+N3j6SBo08V2UGesjNF38RToCpSkU0PlZZKI971klAG+b6aAbT6OjWjp2xvt?=
 =?us-ascii?Q?NNM8rlY4NW+dHjPIztTq5p8q+PATIwcT7dT3eSQkYUE+0chgoDy+r5AzsN9S?=
 =?us-ascii?Q?res0QzmXugXlKvh64gN7KhBJt2riZB/CnErPsP+EeFIr+H6KV1bA6jhz6lvJ?=
 =?us-ascii?Q?0w9e37tAOTTTvQqHvxmuNKtDhWuK0KkduizsQeb3FS6RZJUoEyRx8/zb/k3l?=
 =?us-ascii?Q?b3EnnYFgIHJJ5pcetDDSuyJ+UKR8zLxyLxGMJNS2ukJZNp0Cgu49qrvhyGc0?=
 =?us-ascii?Q?4RUvjkJTbapTrWJUxWMs4TdpGo8Py11YRYplX/rJU4IZsy1bn+LvLWXTi+OA?=
 =?us-ascii?Q?gM4xa9AtAG7tIbgg5cVEh4FH6ONnouCELg1LYrx87veMQ9K4HGsc/P9snhgf?=
 =?us-ascii?Q?FLFL1rPCclzZZjbc+ozIHdCa//2aF4mwSvHR6xpHXtc5yy+dYi86H2lsSDgl?=
 =?us-ascii?Q?i66MdV5oD6p+fMEtf3w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0c4d47-7f82-4cf4-8b15-08ddd5ebdd28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 19:51:56.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGz/WSz8VkIXxWuP7pGfbjuImXbJPp0I7FmDqs9wqVwtMsEREn7S6rNkvgBcqIks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

On Thu, Aug 07, 2025 at 10:40:39PM +0800, Baolu Lu wrote:
> +static void kernel_pte_work_func(struct work_struct *work)
> +{
> +	struct page *page, *next;
> +
> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> +
> +	guard(spinlock)(&kernel_pte_work.lock);
> +	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
> +		list_del_init(&page->lru);

Please don't add new usages of lru, we are trying to get rid of this. :(

I think the memory should be struct ptdesc, use that..

Jason

