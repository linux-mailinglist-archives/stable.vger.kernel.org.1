Return-Path: <stable+bounces-167038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79779B20973
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3506542511C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42962D3EC8;
	Mon, 11 Aug 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlCVCMTP"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD12D321A;
	Mon, 11 Aug 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917079; cv=fail; b=BtbUaNSjGy/FKjAByXSdn2b8qseeVws2oxvvaYDeUX8rN0z7I5w6kpAg87IhDj3Z+d7Taz1tWTWILH3JZBd9nYFAKIvNEXsqeTkEuljvIILbgPj7XT4jQj/JcVX+Ffco7Yby5lM9wkHgoa6HyaGN08ZurhY5hDl6oe7MeTmSjL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917079; c=relaxed/simple;
	bh=+gZY45+i4V4+YT/rriyYGrE1+d0NCU13Bdc81CxHXm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDg5/9W5lX3mP4pd9fQ9F9PA+wyCcfxqTuWgpV8QHz+LaGmKcFRMv9LeVKfpqbeNIaxKGohyhykZc3NJBdgCwFpI5YgfV1KcgSOtjEk/aqhTct4NDVhT1sUEECWGOmX5KYt6+MD7RfLyyfqRtwZh/Vvmjr0/UtYuHK1VLg1zrHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlCVCMTP; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb4Nut7Cuc6cWwOO1A5tsLFQEqqSVZ3sjLy1rDbLcUDHt654/7/BnKD6aKf5RA7p6UMu4EWmo0JibP8/J4VLgDljEERSt7fihFwvTMfBT7ulgN/8nUVCKFAsG2mJJMIVoY+7GpkVeU1HlK1o8erc4NnGL8A1pNxBZxnGmbZ+hGW1YUtjRgc8srjcLIaMdAB7zmv6T0OHdZLcxOPIq/GltxttcTIyGMp82kPcXa0KA1MSqeAM9lzVEQNyaxl52XCfoJsQYAFsmcnegbB29dyJgY+ytzsl8RlK6ud8BH+6QwHTX01Rwv+YSl52zVeN0c/p2NzfhBA0oW7BfHwU4hKkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPxkPrKWSo3WpXvPx0wKm/9qNfgK3N7ibG1AmDxBqPY=;
 b=GtzuG3Q5mdhjHo2sv4eskivMtl5fme7LOtWtvzwM4wPaMyxwzfU8FhijrwTWYT65m+KRGjEFN+N3mPyJFzUMwEdmDfva4sZsQBBnP+vn9hXgQY4eOzccXRnGGYQUbzMEfMk11HRcddiA9BzWQqsqPF1XRICtn+Y9WmsLmJYpFj4Dhw+fJW8fXBhIx9dM6bsxybwt1bGzebbGERGfu/DQJJZehqFQ3tXQju0oONJddavPJPos8czn6brHhaOpWqjPMZbUULqAukNG4QHuwjZuwfyfk7VUVtLuqlqXM088YNeoOR5mwdvmaSrnbMsiB2/n3rBKIDmq4gaJHTLRfaYHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPxkPrKWSo3WpXvPx0wKm/9qNfgK3N7ibG1AmDxBqPY=;
 b=NlCVCMTPtprKmR0Ig/ey2jgpEWZE7YiuRNd9ok2lUv3mz/urJgQFK1zn7c+SiQxF+h4OzTDKuew+v8TNvfm6cnBpL9IbGFC/LSCf6/Xs2Azqza4OnU0gxc79iI8S99gPIN/ACsp1RaDP6YlGoHbNEAEOCwazjLDYnt8UujMNoTZPrGCvM6oGBXReo8rCnPVSDNUAEjajdiGkMpmMn+SKWp20wfOswAIyp2qgi3vyV14tqtt6WjryYDl7v1Dk37k/xzRRu/2TyaRqdXbRclNi7bcb7jI/Hjupz5O6dZvlTw5KJ9zKcRlQu+Osvm6uYWRxbBN2kDpB6TxKTtRERs+9cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:57:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:57:55 +0000
Date: Mon, 11 Aug 2025 09:57:53 -0300
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
Message-ID: <20250811125753.GT184255@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
X-ClientProxiedBy: YT4P288CA0065.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: aeefcbfa-cd16-4b3a-31f1-08ddd8d6b070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aOiI1kyhokc54nxURhxaU8pVnkpVZGlMEkw5E/irLKL1nxk0zX935bEG3wt1?=
 =?us-ascii?Q?Zt+GLdrTpgLuYlucakpiqW2nDAT4NywgU45MUSpjRo3p3kjquvrJkrNnaWT3?=
 =?us-ascii?Q?nA2NwnPs4nUlgRHUIY/akTfALY5tnsty3IhLLxE64K46TYHG3cNRCErgOLv7?=
 =?us-ascii?Q?sfCmiFbcU967t1o4pRAO1w+ZH/oZzS7rZWuBhXLAc6AVA7UNk8B22sk2ERuG?=
 =?us-ascii?Q?BfzsV7rIZHDYnLnL4xHs4nardHIDoWGZ0PwTntvy+TK6xbBAMFNFv5eAn1SH?=
 =?us-ascii?Q?QDauZD6si+ZcCC1KTu7Qub676XLm0gcRV4L7ATrNyHbp4iPxxNC27dw7QPEs?=
 =?us-ascii?Q?OmxziQvxO86gUsSo0hqE7sWxcwDVqeMQva7dbdiKO+fB/LvWHZnGPU6Wnm4v?=
 =?us-ascii?Q?g18p2eT4mExlJWOMnKaS5XutRo2Ai5AM9dkR4hvgmXBYBL39Wn6PMu6Apr8/?=
 =?us-ascii?Q?IfPtWjBRUGpRFU/rGRd7mn8B3OYSpSEQvQfkS6ODm7aul+1iRgliEB9jTa1d?=
 =?us-ascii?Q?TLDGw98cWX5hdWhndPIrBbkCGYzJjNE+dt6TnDf0/da2YrWWpxuBjxl6CGhS?=
 =?us-ascii?Q?cWMKO1yMeFfoah/+44Gm7mIno7TUkMKi5A/kHtKB1PHhA6cAbnAG7R0eFatX?=
 =?us-ascii?Q?3JEFZEaTU58GX2B3/3gYUMcnrt4qPkdE3iK8pKVN9F0zOm/tndH754i+T3+O?=
 =?us-ascii?Q?axER9d4AIm6GVUnyo494BnPR3P7SMTGRxKqW7mADc2MR8g1MBbuKuD/SN7T/?=
 =?us-ascii?Q?B0WsLmaUpfqkpA20Bdhp+DZ5/T1YOdP/2SkAaoJxSbAqLRiVr126PufAFh2Q?=
 =?us-ascii?Q?prrUw/rWwrYFSXUM+bgDkDlVskdR/5kzEZp0pL4hTBHStA1jWB8g0JWonyZQ?=
 =?us-ascii?Q?HxPx3e6Tj8td5wdg1ZqVLKoZ6bObCcbFm9BVTFBj1/yYYD9vQJjbF9oavqfD?=
 =?us-ascii?Q?xTic1bzH4SXR6C0wsQDU9BDdJGV//mT3y+nMZyVCRe16vQQybcDTmCdbzTuR?=
 =?us-ascii?Q?Y+3VI/JmmmRybzv1+ROhR9nZilBrZj7wMPPVIx9wHzgdRve5cuER+T2KiTIF?=
 =?us-ascii?Q?sN71wp/DRUrpQccG+XkYGbva37/1x8JUFe2z7/kJNpZT6UwlZPJa0DxaSsFW?=
 =?us-ascii?Q?albtDN5PfwmxhuGtAFTNRzwveNDHBY/SxZLrUOjEL37SX/wgnxHHs4VhKifk?=
 =?us-ascii?Q?crJbGhZ057n3CXZ3ov1zLU92Z8UkwLOF2KU5bUXpryuqE2pdGB81FpZS80Qu?=
 =?us-ascii?Q?X5fU+Sw+BSnNIErMy//CNSry/kPiP/FsmmmGD+9kB9hW85Hq8k7wKYVU9alI?=
 =?us-ascii?Q?9GjWnGrC9sios/IKhCP2FIbkoFvywMkhiRKJcFJ01NL9RuaVj/OlGbZ85JPU?=
 =?us-ascii?Q?D25m634WCJeQE2NkPdmi/uCJ5xBbSULjnmD0KMGRy7XtpTPQz0bNChZ+pNOw?=
 =?us-ascii?Q?d/vvlOwOI5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmOeqa2SbCZ8EsLJwxph9fgKtIN3yXZbfEtn15oaCvEcZ5d+bpWc8APtdDVz?=
 =?us-ascii?Q?M8Vu/kPTd+zyyVCGmDHPqZvLEiXxaBbU+16Q71XaFPfpQHif4bkZFMPQJSuH?=
 =?us-ascii?Q?1HMaiHwnVYjB5RkyS9XrUEhMEbVrzxh2l2qmrwQnaDcbBQCBHerf2HkP7/vn?=
 =?us-ascii?Q?RVJ1Rdv+heyUGh7bj/m3csvmUa5TmJ/+wt9guGYEB51GCu7K7D1tsZaUkrsu?=
 =?us-ascii?Q?SLpGzQMGU+3E/1ypntk9MpUPiaj5jpNtnftdfZUYqOOgKNMV+lROvNqPd4mR?=
 =?us-ascii?Q?FvCHT1hEHboJrZ0+XnCWEuN8dZR/uEOga+JwSxRLLV1TLzWldmwrz7vLS4QJ?=
 =?us-ascii?Q?ZE0iZsDALepLqfi1GTPNxW3q+pSrmoWiXI599BYWC12SuwQaNWyI2a1o/6R6?=
 =?us-ascii?Q?G2ri/YQVEAzXiwamWeJJBGr4Ong+YoIF0AmAutpCplkJIfCth6aeaX/pFviQ?=
 =?us-ascii?Q?HXbZ6W9l1gk2YW9Zp/V1SSfNNAhoh+16XSw8b9d4gPnoMXLD5AUk7kf97A91?=
 =?us-ascii?Q?DQ7HoF+TP4fFwDRjEjHySp6jKvHevl9gms2fOaYAJ6qk8VNQioqKnRh/RMrC?=
 =?us-ascii?Q?4TsIMSq0C2qpye1qImy/A2qfLBRJfDqwy275uo2phmr6IuercsDQL/rMWPNO?=
 =?us-ascii?Q?1F0F+38p7jYWzavIXvr9E2+rF4qfOqkUpx4zjtA0ec3UL6Yetqlj1xPZ18Yb?=
 =?us-ascii?Q?ZSf+UwCvUHy/JbrASCsE4c1/jQnWmBNsjv2JeVbMmUxBW+lhSrqho/Jvix0p?=
 =?us-ascii?Q?Bo3b9QzMeJYPx0kHFfssJ5cT3lBZU6D+OPqMqjEZLbbeRoOPmltaHuOPtvhe?=
 =?us-ascii?Q?XKVkXvr0mFBQQuXrkxLYHltqIo8qjg8KTytBropZ6NtjjzYgutf4zD4Q2Qjd?=
 =?us-ascii?Q?+kZHH9yWqjEmnIL8BrCqRxJaYDAZjLcigGbGC02hCl5VlIb/FkiLz+sNIWCo?=
 =?us-ascii?Q?37+Olnzc8jLI14ZDZUJ0NL3QJtjG8F/5S0YUVZduk82n9IE1ytQcYMdMnpV2?=
 =?us-ascii?Q?ILG8Q3RZDlh9kCR9WRNk4b1eRPKlX/3GL+r2wWzkU22vwf5J7EgKDoxFJk/h?=
 =?us-ascii?Q?z1hHG2Znh8DMv6ZOgTaY3jfIh2UEknNRH+oqDhtaaLnbG3GzUbuoLktDdMko?=
 =?us-ascii?Q?FwkkXdcfQDI5yiwp746n7IjQ0OqxOE2p63EB96J7iVcJBKTOGXHPjmjXVHeS?=
 =?us-ascii?Q?GCIOt9yPgw4Gt1ASSIcBvdRaSzQjqV7TQfJg1rqB7wKxUTbNpaH3JG6yC6T/?=
 =?us-ascii?Q?fqrIxTuyD4nPyHaBo0M2bo6ZR+XRlh6CSr5VYYSsH7XPd+yJzfNRycCzwLqb?=
 =?us-ascii?Q?+r5RMY8MJrdATYo+J8oXO/0HAQ5bqR1Rz28AEbLNetWQxTyFiQTRop0ndBG1?=
 =?us-ascii?Q?D3v9ngrPs6IbV5QiDCYDAp0jUcGi5Y9+AFG8OwPJcmmQ/l7jl3kfMWJi8vGR?=
 =?us-ascii?Q?JuZkuG30zssZl7V1lWNsy2X/l8uQVUDDjnj87v4RKE7whkG7iiI8qs71P9G7?=
 =?us-ascii?Q?h70IkPNrNMI/wVGD4qSXIrIcn24cxFQCbeHsSSw5TcSuXefeTXXCxNuMFOxx?=
 =?us-ascii?Q?E9Ujdkoe/M6lldIngDk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeefcbfa-cd16-4b3a-31f1-08ddd8d6b070
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:57:55.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxgVgfqOfs7L6fJbe+GJtcKon2sx7+Te0DvcAbH74+VZExGISWAbIf80n9fbvmfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

On Fri, Aug 08, 2025 at 01:15:12PM +0800, Baolu Lu wrote:
> +static void kernel_pte_work_func(struct work_struct *work)
> +{
> +	struct ptdesc *ptdesc, *next;
> +
> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> +
> +	guard(spinlock)(&kernel_pte_work.lock);
> +	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
> +		list_del_init(&ptdesc->pt_list);
> +		pagetable_dtor_free(ptdesc);
> +	}

Do a list_move from kernel_pte_work.list to an on-stack list head and
then immediately release the lock. No reason to hold the spinock while
doing frees, also no reason to do list_del_init, that memory probably
gets zerod in pagetable_dtor_free()

Jason

