Return-Path: <stable+bounces-172522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A8B323DD
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5839117FB30
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2202FB632;
	Fri, 22 Aug 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g/Zu44ig"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510934CDD
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896370; cv=fail; b=o3s+t0oy9TFyPurOrNDJbxzzve+ysmTWjrpNOMjB163PZ4JIwLfAkVWfKBX1cim0ygIwGLvsXg92M1DetD+GplVhbAlAASjwuOiawOROyIByLLUwr2IgctoOUyzD0qUCnYlDoZ0Qsz4RjBys0Jy0NqWWgmyhLnAsoml/6+/7XiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896370; c=relaxed/simple;
	bh=QoZaD5SKnwp/We+BIzGft1RNNGdd7oZBEbm3kFkucx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdeBiaFH3VD134S8oxNpLKsY+e9FUyXwAh2DSv2KXzC4Q6QEqBtZD+UprvKNnaVKjWqWBogaReh7rlMvPU+cjU5ufxHn3izbkfKGfUOTeRNnOHVKbqYhxRATf/Zem/DzMRPs13oWD9CJ1MTvmNYKzOq277uRXbxHuJScPjM+RNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g/Zu44ig; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dlw1P9dXyo/6vHXkFcfLvoDfxHoQE3EOyzgOEJPgfWMksDdySlOYShyOopJgfGKyda8xJMvE/aJlN950cXtS/icc4zqJwpwAFeLbt6crvlN7iWdZ1UtdFJ0f03TfE0HMaKttVaWs07YUyeKVcYZpUMdek3wTDcwWZgjcp2HdAH56yCiEJWLbqhbtWDxtIQwbHKPm1WbWeYCxZs9/SRQncYKiGwQT/KTTurbbhqqDWsM3isPqicueLpXXrtoF6NywzZ251tsr2eAMY83TMzxkjCRJfm9vNsXPUyEyAlqzyUiduRXzcIs+TBAGlMspNVsDfp8Dxi34A1SeoLf9kgJ+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkMkNhMO7r6CM6BO8Coa6Lv4JT33ft6I1iPArOfbcFw=;
 b=ywaFqEqaz1BrxYfgR8QOtK6VAw/ncADLpuDSjEKlUBUen1AwJJoxNTUDuq/P43ix3xUKQF/6lqaZOfoCZZs+M5xBo36/DuKLn9p7iH3S4KJsyZOjyywjSgLmsMKSlJIlb4UkYuJ6uxG49+mvUbICYKssY/O87sMdIe49JNkS8oW3v0V1zLzlZvJ/S6ivxziQxbwyfUzABc8YHChyT/pMJVOGONIhR1YxK+90ILuY8lAC2P2KKdWPFxqeCX1tMmQLi5afTanavq6/nrHkAjwa6oJJ4TTJcgkRq1rw3YAc+V5HH5TOGHy5CZlfAXH/Zo6Gotg6nXqiOy08waOpxtsLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkMkNhMO7r6CM6BO8Coa6Lv4JT33ft6I1iPArOfbcFw=;
 b=g/Zu44iggzZbMKdlaQ9tlqn+zUTd1tj98LaZhgE8zurYFXUZcPxDtT3iX/HpIC6S3xX8IaUc8Z3A2221H1X0NfwK606yHLVFZPvIpv6X2i5NKAbIS1NCxe7gFmWXBnpahMBPpE4Z8mH0nZlKjnbSVjT9G9/XuzImCvRjxKeW9Vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Fri, 22 Aug 2025 20:59:25 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 20:59:25 +0000
Message-ID: <8f6cb260-d378-401a-ab65-8542307d08bc@amd.com>
Date: Fri, 22 Aug 2025 15:59:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix ivrs_base memleak in
 early_amd_iommu_init()
Content-Language: en-US
To: Zhen Ni <zhen.ni@easystack.cn>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
Cc: iommu@lists.linux.dev, stable@vger.kernel.org
References: <20250822024915.673427-1-zhen.ni@easystack.cn>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250822024915.673427-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0080.namprd12.prod.outlook.com
 (2603:10b6:802:21::15) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: b089d943-bffe-432b-2fd2-08dde1bec657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVmTVFkTDBDRU1kcDFrOHowSktDa2Nab0gwQ0dKRFEzQUErYTVxdzgrcUds?=
 =?utf-8?B?a2FKbUhCaXgrbzdBY0tEUXdsOURZbVU5VzJFc25oOVB4ZlVzcHhuemhnZVJy?=
 =?utf-8?B?ak1WUExGMDBqZVhUK3BPU0dPMThpajVNL2NETHpXTVlPU1JuR29IU1d0aTlQ?=
 =?utf-8?B?YmhhYW1lQXlCMEIvcVQweFhSTGowOS84RjQwUGhVN0dFTXgrRTRLRDFwbVAy?=
 =?utf-8?B?eTkyOGs0aVZia1Bod3p1eVAySG03VnM1Y2ZQSFNjZTR0R2hFWE5MMEJ3UW1E?=
 =?utf-8?B?czN5NkRVbkt3RDI0NmhMemZKZk01cTVEb0pQOHhaMTR5STV4UTN6RWxZM3Js?=
 =?utf-8?B?WCtXQ1Zwa2VkSi9URVVlaVNaQlNlb04xSHBPSDRwaWszQnpFQ0dkKzZtOFEr?=
 =?utf-8?B?YW9qc0cxMks1U2ZnK3NKeVF5UTh0aEszT2lPRjJaUS90bXp5end0eW95a25v?=
 =?utf-8?B?ZzU4Si84L1hTdkh4ZDVVeVc2Si9IQ09ueFFtV0p4Z0dmTjF5MDFLYWRvalYv?=
 =?utf-8?B?Y1F1aG9GL2o3SDZZWWpicVVtUzZwQXIwalVvYlgzKzF4aTg2VFpjMEczY082?=
 =?utf-8?B?R1dQK2dWWUZTRVdnSWVvdlA2elErSytPUWRmbUNGb1BtM1pNQi9vMXlZcEJJ?=
 =?utf-8?B?aWxwSTZSVk9oUysyV2p5d29qc01vUDZXakk1OUlKSm0ydFdBNjFpbXo5U1cy?=
 =?utf-8?B?SU4veDBHWCtBUkxBRitYcjl6TU9GSVM4R2ZUc1VWK1FOZGFoYjZ0K0R3VVZP?=
 =?utf-8?B?Q1NYSElYNDFjUzlYZ2V2Mm5xRXg3aEt6b2JSYmxEYWViaHIwTytydmlRQmtC?=
 =?utf-8?B?ZDU3MVZnVnlzN3h1SmozNlV4OVQzbWxnWnEyN3E0TDlZdmdNTUx1QkhYK2tB?=
 =?utf-8?B?dVJ1ZHdLdzBxb2J3WHkvVnNJQk56TUh1d3lhWFJPcEd1bEc5NHNPc1MwUEpC?=
 =?utf-8?B?dUlHVlh2T2lIZjUyaHNSSTZNNXZIRHZjNW5aTFZseE5UWWRpVDJOaWY0dmov?=
 =?utf-8?B?TFZuT3NsTCtkaC9zTmdPbEZPd0Y3ZTUrVVdoN3c5V0tZRGw1TDVyRlZSemRU?=
 =?utf-8?B?ekJ2NSs3K1hqL2ZQaVkrQkdSSFFWSHh6NzZzZ3lBb1VmVllwV0ova0JkNUhT?=
 =?utf-8?B?L3QwYXloSks5THV3Tk1tWWtFamVoYVV2bzZJY2x6WGZ6MzZucThhYzhsWkJm?=
 =?utf-8?B?WjJLTk1TcXg1a0F6WVo2WndLSFhLOGZBZWhUVmNlNUdmUjFGQlYxNUpkc242?=
 =?utf-8?B?SW5pNVdjazJmakw3aFNoWXNaekpMVUxrWkZ0QXBKTG9zWXIwMVJzSzBRSEVt?=
 =?utf-8?B?VWtqMVRKWVpETll2RlV3QWwxejR0NXdHbHM4S25QVGd5dnVWaUh5OFk1Q3hq?=
 =?utf-8?B?eFp0SDJPTmFxd1VpWTNEdkNUSnRTQWpUN1F4SmdaZ2s1ZVErNlNVRmcyT1Fw?=
 =?utf-8?B?ODRZMVcrdlBjRnhtWEM3RS9HeGkva2R2c3A2NzdxQ1VnNitRTzN4b0dBUUc0?=
 =?utf-8?B?am1pdlE2TzdGRjUvSldHOG5EdERTVGhxWkZZMnM0MUl4c2J1SHVnWEhNZnJt?=
 =?utf-8?B?dGFIejk3ZndYNGpmRVlNcjVFNkdaazU4bm1DbzJ6YzVORG1wMjBZNEZoMFVB?=
 =?utf-8?B?anZ6MU5EQTRWc25rVlFFZ3RtTERCZ1RYWkcxOC9RSUlMWXRiV3RhcEl4YnJX?=
 =?utf-8?B?MUVhb2RUN1A5RHU3MjlvYWtETnBpTFJHN2FxMHJWV1VXN29jYkVKK1dUQzgv?=
 =?utf-8?B?T0hPWHFMN1NMdDFray9KV2lmeU93SFlqV0NiRkY2c014aXJGUXFBaDlIL0px?=
 =?utf-8?B?eHpsQ1BCL3VOekRPL2xOdkYvNXN5T1BKeUl2dkFEVjJOcE5yWlpVYjNlbXg4?=
 =?utf-8?B?SXNpVFRhUG5VZ2Q4UUJUT2k0dENLZVVnMFNnWWttTjB2dTZiWGt5anB6QStZ?=
 =?utf-8?Q?dFsQesYW/Sk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHY3SGxQWHlCWHRzbkhLdHdFT3c4Y1N3MkVQTTBnalcxQzYvNHFMUjdlay9R?=
 =?utf-8?B?NGxvZFVGdlNKMWdsUy9lWnNGb204UWwxWEdvc2J2ajgzTkJKMUdrU3hkWkVa?=
 =?utf-8?B?SS9VWWZPTkVhclhiem5BejlTTnVNVkV2RjRzNmgyVnBPem52a1o4Y0Rjc3hI?=
 =?utf-8?B?bHc2ejZuZHY5bVVON2l3M0xwRTU0Rmp3aFNLNFNTRERYakFqSUZuc3phTDA0?=
 =?utf-8?B?NlhHczJRb01BWDRCeWVac042NkJ0WWpnZzduMy9sbFRId3UydENRSXcxTG4y?=
 =?utf-8?B?d2lWd0J3NlJIS1grMGVGbVlaczFNeWdNZFNPeFE4V09Cd1BiMTNKTjYxVWhW?=
 =?utf-8?B?RC80RWlHeGRrNTVVRzR0WndYOVpmYjdnQnlNTU9hTUdTQnRmZUR2VUZkWHBz?=
 =?utf-8?B?ek5YSG5wU2lodmtsRWFFQXdJQnN0SXRLczNHdG04Vm5wRlNtZXVQdXhDWkF5?=
 =?utf-8?B?aTlud00vWXNnM0tGVlpudXdwM1liWXRtalJnMGNza05nai9rd3RMTVpVR2Vp?=
 =?utf-8?B?bWxvS2dhUUNjQmRPeG5PRldhb00rM1ljU3h5dy9sZjJDUktHUlZhNDlaRU1o?=
 =?utf-8?B?SG9wNGpZT3V0M2JvOWFhL2o2dEFhdVNPQ1BNTVNjZTdHb3hYZTl5MVAvSUZt?=
 =?utf-8?B?a00rdHVCV1ZnSC96T05NL05zVTJpVDFKdnRWcGhyaEJ3d3RWMTUxdyt6RUVD?=
 =?utf-8?B?OUNOUEpSeUZzaWVLb1cybDd5WHhJajVKZVRLejljenZEd21FdkdvdkVRckx3?=
 =?utf-8?B?cUdDYlpzekRvckc2Uk9PeGVneDUzK2tIcHNWQzd6L1NTYmdwdzNybk0ydm1k?=
 =?utf-8?B?TmR3SjJ0U0lodm4wc0lGUnFiT3ZnVUgvdXJHUTBkRWxuVzl2UTkybVloRGdO?=
 =?utf-8?B?a0h5ZWJRaDhLN0JxQ2g1Vy9SQmw1aHB2cm55cTJlZXpQWnArYVZQUWhrZVpl?=
 =?utf-8?B?VldsZEhOZ0YrRmVQeTdpTUhiYmtzYXBBRUFLa3ZxODdLeHM2emNQT1BhZjlX?=
 =?utf-8?B?c2FRd1lPdDN6TkxML1RqTEg1L084Y0hVMjR0TFNNS1JDM2diRGxxWW54WjFw?=
 =?utf-8?B?K1dIRE1sZlloKzFEUnBmc2Zla0FSN2toMXRvVTgxdWxVSEc4a28rUmhwQlBJ?=
 =?utf-8?B?ZHE4VVpaK0pVclVEOHdIMTBzQ0wvbitRSWNCRTMvUXFvUGJ0TjJ6NUZONlR6?=
 =?utf-8?B?UzkzZS9kY3BncGFGZU5qMFg0c2pKaThHcDQxREtURzlGSlVYSmx0Zzd3RHhU?=
 =?utf-8?B?Nk1Cemg0WjRnL01EQzBDZk1jSkxhS2p6N21nL1RUdldmejBjUVQ2K0FsdFV0?=
 =?utf-8?B?NkxXYnI2RGE1YnozTDk4S3Z1aEUxOXorQnNaOUlKVks0QVcvdXpiTWRuVXNs?=
 =?utf-8?B?aXpFelIxa0xHS3BncHFzVkJUZG4ycFFKQk14eWoyRkFNL2k4QTZacHRtTUVJ?=
 =?utf-8?B?R21pL1pkYXEybnlXWnJRSkl2ZzdZNUFHeFdSWmp2ZzJkaTRkWjAxR0lNekNJ?=
 =?utf-8?B?N2tKVW0zdFVabUY4NGR6L2JNTG9rbTlEbDZkOHBnbEhLQWluU2FEL0pXVGpo?=
 =?utf-8?B?U2habkJVSGlsUnIwOVI0K21UMkNwZGRhU2MvQlE1L3VaK1l4V0gzUllGSjFF?=
 =?utf-8?B?TWU3UGQ3QjFmZFo4eXRHWFgzTUJ1K0l3SWpWdkpvVkFoRm9xRFBEYnlHVVhF?=
 =?utf-8?B?WXJYaHNqMkptMFVGb0FMYURzSGh4djdUUXZYYW1Tc2huaW1OdE96ZmtLbWRs?=
 =?utf-8?B?ZWpPN2tkRGEvMG1ObHRZWVZGSDdsNVlYU1Q5cW9Pdm5oN3ZGaHMrdkNKeGxC?=
 =?utf-8?B?cG15UHZXQnlETFI3WkdtRVJlb0U0RUE0bC9tc1VSV2dwWUp5MjUwSVdJY0c1?=
 =?utf-8?B?ZDhXVFVJTHZJeFZtNVNkbFdIQlp3dG0zWUZLbm1uZjdhd2lxb2RrVWhnSHFX?=
 =?utf-8?B?SEQ1T3RvclQ4Q2l0WE4wSG81NWdJMEJKd1pFa0llL0NFb0lhREI3STlOdlgv?=
 =?utf-8?B?cGRjaFhlL0ptMTZHT255cnUzOWtBK0pqa25CcUl1RGhlZGJrWG9KVmxobURO?=
 =?utf-8?B?SndyTEFKMHNyU0xyWkU4bHFpcDJESlRGWDJ4aTRuVEluY3pnZnlhZG9WcTUv?=
 =?utf-8?Q?RjT20aL0+W+TEth3xNlli1LWS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b089d943-bffe-432b-2fd2-08dde1bec657
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 20:59:24.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBX/+bJV4uvxngT68eU8fMPmpN9ULDAtHBAKhCorTNZh3fAxNItb5ENGwP/yPervysog4evCPn9tI5toMj+XrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323



On 8/21/2025 9:49 PM, Zhen Ni wrote:
> Fix a permanent ACPI table memory leak in early_amd_iommu_init() when
> CMPXCHG16B feature is not supported
> 
> Fixes: 82582f85ed22 ("iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>   drivers/iommu/amd/init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 7b5af6176de9..dddc432de7b0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3067,7 +3067,8 @@ static int __init early_amd_iommu_init(void)
>   
>   	if (!boot_cpu_has(X86_FEATURE_CX16)) {
>   		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
>   	/*

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee

