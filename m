Return-Path: <stable+bounces-83771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD199C75D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC33282305
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750C6189B8F;
	Mon, 14 Oct 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eY1fG1I9"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD418594A;
	Mon, 14 Oct 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902652; cv=fail; b=VRBXptk/FgROkZD1pclzIhY60DXkcdFKWfqWCbRUzS6ODPUuJFdLdAy1irrmmgLqlNQKYiNs2lFEinY2Um7v5xRqpB6uyqD8ARpXwXNEvGtFWRYdyog/tRzNDLEsiJglslpObBpELJ+0xmMWdPZcMWDb6UPCaTNxOjUzXjOST+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902652; c=relaxed/simple;
	bh=x7S+rlO9ZTHZ4iOV9ndS5bJJzOd46o+QZ9wGTYpDgGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8l7RHqcBHf3jg0VAigFEvAEjb3aHfQ2Bk3S5dYu3uJTQ67EaJx1GjjsKtrwu4FG7zm1KSyH1PJ1sBNOOy+byZFGcLrwSavNTkILR3Qa1HYTovy0iMBYWjJhRHCiYGnMO1pEyGHxwPrDKgqILDYFAQKNcmGH6PYC5N+dRxZbCho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eY1fG1I9; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wquWieF4N7wykhSa4gOEptns9HwvD42AwxCRCe10TcSln6UNIv2p+38A0GVIR06BikuZY0bBE1tiOWhaslkHTHssza5wTuW/39RorH8TRJc8AnLQzzofBKdSKLm/5B1eu3fjNC4FDCT2P8zB0VIMZ5XedQWXWwwoqINHZPQB9cJNsqT86TrvVUQ8kntC2N7pX8vwK29ReqW+krGmOZcL1YFoKRX4BvTWuyP1Yug6nM3uIAQrem+GVN7bUbJvxKey1r1ozb0Z5GhFN5cL+D1HMdIPs6Hpt7m/6TuqGh1UnWgJ0JftZTZSq/SAIcvwG5A5RT8Ci1OJrjMObh+2xlgd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARLF1+QaMeOCfSUN/kc2fbmRgRt2y7jSO1RVOWTZsDE=;
 b=jbz8W2UQm6KTPen0Z9QBMNDXwYcgUJnTJMOPHn7kpf9o9cgh0ODUOs092MP2PkvjkIgojb9RctnWhcGJ4BG0Vr0sLA4zSgwcTTxDUZVcdhsN8Sx7HnXeGHNtnoxPAevEeVifjd5UajGJzEwAlH4QfJTN6pTQ9LDFdN61qhcVTJThpvYrkJfLKFhvRNcgrHG7X5jlhZp1a/QyQp6D6ymJZfj2EteOrUuCdEZgRyMOXTJyf9HDsp5QuTGjnwjOiH+E9y6w5kJuz8SB3RaIMMRRnZKavyR/IBGS6gCf6xQpZIjY7jU1T6fEoy9fj9NAtTnHTkIrp7m3xubqTFoIrRXUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARLF1+QaMeOCfSUN/kc2fbmRgRt2y7jSO1RVOWTZsDE=;
 b=eY1fG1I9NY6OMFihQvo7rWjcgBa/6foT6VrlJ4svBnDP48tME7AH1DOx8HqLWbw5347jaCo/xUj3TXtLt9PjQng/SPjxCm6Nr8oUqZNh943AqtwEdYBgcKqcPaC/W4ZDMP6LO1JcHh1H3MIko8EBof8OAl7jWK/0n2WgwiCxSO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 10:44:06 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 10:44:05 +0000
Message-ID: <47f50e98-86b7-46fa-a545-14a8f1110ecb@amd.com>
Date: Mon, 14 Oct 2024 16:13:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20241011001826.1646318-1-sashal@kernel.org>
 <effb985a-34c5-4b42-8928-cb2618e1aaea@amd.com>
 <2024101443-item-gainfully-9b2b@gregkh>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2024101443-item-gainfully-9b2b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::33) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 088e5334-c803-4ea9-0842-08dcec3d202a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUZ0ZGFyelNWRDJSTm85SWZ2RmRKVTRmNDEvNlYrQkhISjNUVXpqWFN6eVli?=
 =?utf-8?B?VE00RXg2UjRrWms2YnBnUlZPT1FWanRIM3F0SS9USllvY0MxWHh0d1pNY3pT?=
 =?utf-8?B?NHVIL0tSOE9uR2xXUWFianY4WHVkeUpjWWp6MHY4RTZOUVVRSVpLWDBWRzAz?=
 =?utf-8?B?VUNBeE5QMnNsbE8valBTc2ZLRGJiSzIwUzBJb1ZZaVRlQ2xsR0dGbWQ4TGYw?=
 =?utf-8?B?cTlsekJ2c2FxTG42R2U4dWJlQkV3RUhHT1dBTlU5QldTc0FxMWlVbEtKeWhT?=
 =?utf-8?B?MCtuVGtXN1hwUURTSE5mVHpXbzBIYVNzMXlzUU5oN1luYkRUWkpjVlB6Vi9V?=
 =?utf-8?B?NVFscXFBemI0c3VQM1dLU3NXQnNYSzRmZVFXWjI5UXhJRy9uOTJaNUQxcWsr?=
 =?utf-8?B?d3oyN3NabTlmb0ZJc3Q3SG9KSGFQVWpZdnpKcEVKSlZ5RElJZFJPcXBHVmd4?=
 =?utf-8?B?Z2pjclRocVM0V3lLbXNLemhsc2RFcytLSVd3bytYVW81UTdwaEJtbmNZaVky?=
 =?utf-8?B?WmxvWXJqVmZoQ1JISEw5UUJGeHQ1emlFRDZrZjR2cEhJQmR1dm1ta2x5c20v?=
 =?utf-8?B?YWtIRWlMeDBxT3JoYUZOTDhxYU50UFMwYW0vV3BxcW5kV1Ixbk0wOG40OVFn?=
 =?utf-8?B?UGI4OUR0ZnFoOVlWSU5LY3ZhaFREUXkzQy9qWWUyS2xHM2Z0K29saDNkTHNt?=
 =?utf-8?B?ZTV4a1ZGbGRFaGEyMmMwZzN4Zlp4V0RLU01UOGlNUkI5UVM4YmxjOWJmTWM3?=
 =?utf-8?B?N05XV3Brb1JrbHJ6bUVMNDA5SWUrQlNsaW1vN1BQa1RrL21PdTBHK0hRNTNB?=
 =?utf-8?B?VWJVZENWbkMxWDN6SWNqZkFBb05jTHhuUnk4cWNxaTdHemxuSiswS0xmMkpN?=
 =?utf-8?B?N08rV2VucUlOZXF1ZnRnYlN3ZTRiZHg0SGdwbHp2Q1pjWTNadFY5MmVxdkFC?=
 =?utf-8?B?cWJPSVVEQXZjZ29zenpSMHlQVVVqQjlJWkcxNkUvWno4WGZzaE9YTUJqUWwv?=
 =?utf-8?B?SUtPeVc1d0VLTTdBQlVOVTJTY0o0eTYwM0lSMDlDOXQ0d0JQSUJ4SmIxTUho?=
 =?utf-8?B?c3BNRU9uSEk4MW8wdEZGM1JTaUdENFo2bUUxT21pdTh1MFlHZVl2dGRaRFZM?=
 =?utf-8?B?YzZGa085NHR4Zit5OXdkOVZrYzZ5QzJQQ2pKQUJxMGQxUFlISW9Qd3ZvU3lN?=
 =?utf-8?B?VG0wS29SQUU0ejVmenN1bHg0cFhINU5ha3lYQzJ0Vms2Z016Q20yWXVocmJo?=
 =?utf-8?B?b20velVBRkxMR2xZR0Fsd2x1U0hDbllKY1ZHYXdOaWNFTTUvdVZwemVkVWZy?=
 =?utf-8?B?akF2YUpTVDNlWHhYSkJyNjFoQVZ4QnUxK0IxYURwenc0TzJDVGRhSTN3ZzZv?=
 =?utf-8?B?U2ozVHh4TkZ4WHg4MjJjSVVoTnV6anRROVFlR1FPV3ZuSjdrR092NG9xbmpu?=
 =?utf-8?B?VG9XbVdDQmpVMk5YZFI1VzNEYVJVTkdFZjVEczhsRGg4Z0Y1Q2xwZFdaQ1lR?=
 =?utf-8?B?VUw0OGkyRjZmRVF5bUgzQjhFUmJHQkNiaWEvbHhldS81bEFvMWhrRWNObXJZ?=
 =?utf-8?B?cjJlMmVzekE1SEpWdUl6RElCUnBJU1p3MnlyaldXSitLL0lVZ2dOcXFSYmcv?=
 =?utf-8?Q?YlExXJnLf7+IskFlf/3zAqS5s89UKWYRfgPvv1xWlRKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2p4K3MxL1lEMjBRVjY4bG0yTzVBenBab1ZFV0E4R1UvNW9WcUwrbUppamxk?=
 =?utf-8?B?ampjcWRSVkFyaTU3bVN3RUJIY0xGaFJoQnhrZlBlanh2U1hLNC9BN0kvMG1s?=
 =?utf-8?B?VUU4bGZwQ2dMYTJEaGI4THh3VFlZUmc3TkMvUEZaQ3pQTDl0ZktQUDFNWmVJ?=
 =?utf-8?B?dkVZMmJGMzl4WE9aR1UwcVBOejVJbksvVDdrakMvNlZLd2k2alVndmFyam80?=
 =?utf-8?B?L1BVVzFqQlRkbVVIQ080a0U0aUN3dUhlTnZkNWNpdXkvZXhFaE9lTHRxdkpN?=
 =?utf-8?B?c2RZREVuL25EeU5wWWhyMlE2dkQzcVZJSlNBSmt6OXFnSk1EbzRvbWtuMVJF?=
 =?utf-8?B?NmJDWlZteU8zVCtUSG9LalRucDlQV3lhMHlwRFllU2RRZzhYbVRGQjNseWRV?=
 =?utf-8?B?K29saVJUSkMzeU1jWmNPNlcwajNmNzRRbHluRi9qOWZiR1lsRDZ3OGd4MkYw?=
 =?utf-8?B?SFd6dE82ZldCMFNPeU03Z0UxeEZ6ajI2Y0JLZ0tQZGloY01OSDBNVlJrY3JZ?=
 =?utf-8?B?N2tIS1g2T1ZMNGRSVkxhV0EzZ2FoVVM4Mmh4aGg0b3F4eFJwakxHNEFta0E1?=
 =?utf-8?B?M0hURWhyT0J4SE9tZHVSTytMYlBodjRabHlkZUw4WjZWNUt1SjM2NEVDRVU2?=
 =?utf-8?B?QVVPcmdmTzlXYThjLzlOaVptRUdRU1JmUFlIS0JRMW9KWlBCODdWVTBjRnMz?=
 =?utf-8?B?NWN6WTNVcmpxZkRPdDdWeGVUb1N0ZXBuaUtCM1o2OWFZelZFc1dxWWwvZTJI?=
 =?utf-8?B?bWFpM2lxMEVLMEJzbTFnaDU2bENZc2FWYmlrZU5JTXUxSTY1Qi9meFBWL29x?=
 =?utf-8?B?eDAvait3MEhhQ1FqY2REdjNtcTNzVFl1VUV2MzltaDdDUUhHVXNYOThOZFNJ?=
 =?utf-8?B?clNTdXJ4amU5aVpsK040L3ZibTJ0N2h6M1BQOW9lWFh5MjdaMkpuQUQ5YVZJ?=
 =?utf-8?B?RnF5bmxSZ1Z0YVlkQjV1SWRXaGE1RXRZNlU0ci9RanQxb3ZnQXJYaTVKeDZF?=
 =?utf-8?B?YnJsVzlQaDdKbHZlVTVYTlpITkpNcS9pNmVSZzA4eGpmbXBCd3lVMzUwb0Fw?=
 =?utf-8?B?YndIWGZMR2VPSFdLVDhQaXZYZEUra0x5ZStjMGRnejJUaGFKSUlGeEFRaHlt?=
 =?utf-8?B?TVBkK1kvUHRmNExMbmUyK21YRVNDVHVONGpVTEY1bUV6bzFOS3ZvNUE0LzBD?=
 =?utf-8?B?NWpQZ1Q2Zk9zdXYxeEJaRWlEYjBvYjhLcUd6OUJyVnRXeFFOa2dwUEwycngr?=
 =?utf-8?B?VGlNbzlLMEdjVHdyQlZvQ0RrNHVOSmp0R04xYmRFcGNpekwvNnQ1L3gxeEdT?=
 =?utf-8?B?R1VhV0JqZlpOY25xS29ZRHhPRHlrRWMwZndDMFBFVHlPS3ZQMTkyV3UwcTB5?=
 =?utf-8?B?TEZoL3ozN2FXa0VNYW1BZ3ZhRTVCNFF0Tkh3Z2xBMnp0bHhEVFd5UGVSUUF2?=
 =?utf-8?B?VTFMRTJqLzBYQzQwaGYvUEFHclhLZlQ5U2lPUUtaRjJldzJpWUlUOCtrd1JW?=
 =?utf-8?B?NmNWQXVvd1M4WjFFMFVTTTM2RkxrbzMvakhneFFFaHNmMzc0clFhSzVFcVh1?=
 =?utf-8?B?bDJjL3pmK2R4RTdMZG4wMkl6R3ppWWRra0cxb1pGRHozNTJqOGhlYWNCMjlW?=
 =?utf-8?B?OUV1aUNzREJ4UGVLRVZRVnZ1ZVBoZENnd0k5Q1gxZndCYklnMDlQcWFrbmtr?=
 =?utf-8?B?eXFwNjlWREhtLzVoTXhPYmtaYTZyWTBVMGRYQXZhb044WjFuTmFnOGtpV3Iv?=
 =?utf-8?B?RFhGYWp5OTJDNlpwdXRWZTBnSkhJY3g3L2Z4aE5JQ2V1UVkwZnZUS2c4SHM4?=
 =?utf-8?B?Q0o5dnB6VjVrOGNvTkJHM3B2djAzK1BPNjFBRUVQa3VSZXZQZGFGMmg4YkMz?=
 =?utf-8?B?bFRQNEk1TzNGQU9wVXFUY2lNYWY2cXdoUzhrM2hkMDhoUjhmRjNDQUk4MDVC?=
 =?utf-8?B?ZWo5NUZPSmUrWm0wYUw4cm5mTTVCZTFMSTAyaWtoMGpxSEp3UHQ1YXo4ZU5X?=
 =?utf-8?B?c0RVSkF2OGdzVmFUWGszOEEwSmYvcEZGY21lQVJ1VTJLT2VGbC90RlU5b2tZ?=
 =?utf-8?B?eGRGYWJEbkNFdW9kd2NnNG1yS1J3T3MxWkhiMFA5c2J4YTB3MDhIeDQzMngr?=
 =?utf-8?Q?CPJ9cWyQ1XJhEB2FzHxHlYxww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e5334-c803-4ea9-0842-08dcec3d202a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:44:05.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cvle8QWvW2q44wrcLIjLVXyZwRoK5RhRZmIm7iZ4vaUNHZJo7kdqFFmKnm0MQGEv7AK0k2BUnSZhGBogG4SEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

Hello,

On 10/14/2024 3:01 PM, Greg KH wrote:
> On Mon, Oct 14, 2024 at 10:50:23AM +0530, Dhananjay Ugwekar wrote:
>> Hello,
>>  
>> This patch is only needed post the commit cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq. Hence, please do not add it to the 6.6 stable tree.
> 
> Then the tag:
> 
>>
>> Thanks,
>> Dhananjay
>>
>>
>> On 10/11/2024 5:48 AM, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>>>
>>> to the 6.6-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      cpufreq-amd-pstate-ut-convert-nominal_freq-to-khz-du.patch
>>> and it can be found in the queue-6.6 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>>
>>>
>>>
>>> commit 09778adee7fa70b5efeaefd17a6e0a0b9d7de62e
>>> Author: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>> Date:   Tue Jul 2 08:14:13 2024 +0000
>>>
>>>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>>>     
>>>     [ Upstream commit f21ab5ed4e8758b06230900f44b9dcbcfdc0c3ae ]
>>>     
>>>     cpudata->nominal_freq being in MHz whereas other frequencies being in
>>>     KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>>>     
>>>     Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")
> 
> Is wrong?

Actually this tag is correct, but the tag for commit "e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")"
was incorrect(i.e. Fixes: ec437d7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")), it should've 
been "Fixes: 5547c0ebfc2e ("cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq")" instead.

Sorry about the confusion.

> 
> If so, that's fine, but note that this is why this was added to the
> tree.
> 
> I'll go drop these from the queue now.

Thanks!

Regards,
Dhananjay

> 
> thanks,
> 
> greg k-h

