Return-Path: <stable+bounces-83725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C099BF52
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472092835CF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549A13B792;
	Mon, 14 Oct 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4/AhQb03"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0B4C7E;
	Mon, 14 Oct 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883235; cv=fail; b=o8FgC0W0oiU83rkQJjXn/TzWkwp7YhXXBrocEkbJr0GG19iGvmNtV33tBcW8HBXhsn90osKie8+VYTGABK9JzbT4r4EYNit4WwXMbXcNxKGZTrJP2rW+aUGcdrbwIuey9JxgdrWre6FrUU6XEZL8rBdm3JL8YMMyArXCOL9UH/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883235; c=relaxed/simple;
	bh=YHjwSKRoE21FfI2edU/BGE6g/9HmqNM3aZL9ciRCTLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpZc1MAuDZMIYwLHZssn5AcTu0dPky3LFf8UUcf5fh0z5IaJ0+VU75r3GBuoMl44my5A5qnt6aqLW0IE8AVgEujy1GHt8LgeOfA89qBlEdpFV4une6xpeSW130BsXlRft1DinlHGkScBujufXNsg8OudF9y+Kpz64T3tdvWC42M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4/AhQb03; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BidZhn+oeGmQvnMR9kNL81g50vtGGdcgCD0eJO8qd2IOoxLU6MzdVLrT+JMX6Mhb2ujYxwp9jkMOM0wMwkO2qxU8r2xEgKce3diwKLYegl6dFGm7Wjkm1ZlSCZVJ31IuBa/PYYQHoEvVVSkAOtJTANzmlFAEybCY6r35tpUgtj9BtriIGiTB5zqxQYFu7YHYg7heOKburWY07BHBaOnE43s9LdKOGUnj3dXFSDlMdLWjBaS1f309LpMB1eh23y1wXOHwRyhr2juoj6pG6G2wRJKI18GmwPdhmlafqgC0S9fIgbu4vaESiMrWcMyYd5snpmxPl+BaD7Ji7t6QLRj9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2agiZeXp4/W/sKbAAXqurIdY0c5Fnkd+Kp0F4rkbZk=;
 b=gDdYjH/mcJNDkRZItrY9qCxZytkmUcYhJD8575KL49S3evDh5QCPWjl7ovbr0kFhUV4x94SLQ2IblHaQetWARchVUTM4JkTcJEDZFkFFeJ8Sr8i53ehN4rVvJrsVdkAKo6vIO1hY8r0balzsHaqhcPIJ2QmyNMsNa4Dbsk/AN9YM1NIJzIZUt3OqhCD+sSx/S2EpGaIHkNwD3F8tQMoUbwuYMIHTpFFupIr2zMr8tAyY6ZM4pJ9VLbfvgWw5b2QFYxqg5SP5CvYcC5VmXCXWV141Fbw0FU/QDLK1TAL15hZyDkkuRZjfYBNrcsKpGvSuAM9CR/oJnSp8gkghbIMSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2agiZeXp4/W/sKbAAXqurIdY0c5Fnkd+Kp0F4rkbZk=;
 b=4/AhQb033xXNHBV7uR9AEXnmaSwSgoE3mAkGo19rnbkfiac0OEHXfSCHCMiICEzpxoQ84DLvjgORrygB2nuhZVt2RDKEwUkgqae+13k8DCGxT77oZdgqqQ/+mWRdLcwnmDjleCtC8/rdaI+PCUgUUDV22i011hfUF8HRxSeQVxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 05:20:31 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 05:20:31 +0000
Message-ID: <effb985a-34c5-4b42-8928-cb2618e1aaea@amd.com>
Date: Mon, 14 Oct 2024 10:50:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20241011001826.1646318-1-sashal@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241011001826.1646318-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0253.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::7) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8f1868-f9db-4f26-f20a-08dcec0febff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3Q2UnBRcVhhbFI0c2hOTXdscGxTRHdEYUxZMmQ3bHhDQS9oTTBjMzdiM25y?=
 =?utf-8?B?UHk5M2Z4TG9EdU50YktwMXBZMUpTVmV0c1cza2RvbmhjZHFWUVROOWtPbHli?=
 =?utf-8?B?ZUVmTmljNUo3Q0diNkw3QkpYSXlZRmtuM2RtQkxKUTBQUi8xa2R2cnJSNWJ0?=
 =?utf-8?B?L1k5OTNhd1l2d1pUYU5MMjJBTzRCKytBTkN5c1FKOWNWYnpxaUU5ZlRmOXR1?=
 =?utf-8?B?WTBEeGo1QndqZzlGY05heG1FeFlMdmZmLysvb05BaFc3Z3BvajI5bTZZZVY1?=
 =?utf-8?B?VUFHUUtZVDEzVEhIT3RiRzB3empiRDN5R1BLUk5TeTFGdTgxcHNyTDZ1MXJz?=
 =?utf-8?B?MnB2YTAzT3JmRm55RjJKamtvYkRCSFhCVldma1pYY01Vc0VUU1M2OEVENVVO?=
 =?utf-8?B?RjllRzZ0RzVIWFRCeXdUVlF1MktyUUtpdXRtbWd0S25QbW5oMmk5TzJqeWF4?=
 =?utf-8?B?SlNnNFY5MjRtN3U0ejZaeXU1eTNNd0hMTmFBNHZQUTJ6R3NXaWo2YjFZUFhY?=
 =?utf-8?B?UWFwN2VyZ1oxaDgrdjlTcTZNdFEvRjBpZytYemplOXhMZE96emVrUVRPZDY0?=
 =?utf-8?B?Ukd6YjZuUjZaTlRIc21VajhFNnRlVTdrc1BxdmNIdFJmaFdEbmlEV2R6VkpE?=
 =?utf-8?B?VDA5M1ZVeWRVUkhqSDZrZmlMTG1FZmZJTEtHT0g3T2trQ0pHaGU0VXY2dC8z?=
 =?utf-8?B?dll2a3lqaGplV21WQ2VDNDJjZEx3VHpTWFVPSXZHSmw0ZWVFTlBQTkJ2MGxu?=
 =?utf-8?B?bTZEYWFkZXRJaG80aFlPcnpVSXhNK1d2UHdJYVgrR2NpaEQ4TE1QOXMzUmNY?=
 =?utf-8?B?bGozcFRBd2h6N1FLelZvZ1NzTUVBQk5EcXhPa3JoUjRFWnpHdlM0a1RoVUpi?=
 =?utf-8?B?QmFZdC9TeEJycGRIZW04YlRVT2VpZ1JGTy80S3ZBWmFsV0NGMzdMVGNtZ1RB?=
 =?utf-8?B?S25qNWhSa2FzMWEyY1NnUHFmckxSUnlPeTZndjAyYi9jZTdGdkQrSldnMERS?=
 =?utf-8?B?RWZYOFVNTERJQnJGNERVVk11MTJHbStJWStmVVBySElWdTJlSTRJZlkzV1VO?=
 =?utf-8?B?ejJSTjYzQTJIcVNzRE9LNEk1Z1dScDNZcGJmd1lxdjdaYXdNdkVMKzZMVS90?=
 =?utf-8?B?M2V0NWFQMmFrZ2FkSjBFUkNHWlYrc3ErSXA0cm5Oc1QxUUtKZlhDbmh4VExo?=
 =?utf-8?B?Nm05QlZHczdIUHQ5UG5DeHNiL2hmb2Z5MGttcGkzZ1JNeHI5Zm5Wcmd2Q2lu?=
 =?utf-8?B?M1E0ZWQ2bUgwUE9EdkNPWWVUaG1aMVFCYWNWMUd0eFpiQmpDUmFEMWJZQzN3?=
 =?utf-8?B?NEd4OVlFVzMxa25WWnI5ZnJpUVlPdGY2UngxZTFuOVJJQ3U5L2RlcmJLQWov?=
 =?utf-8?B?WVJsNU5ZT0pjbURwM1RZWVl3RWp1d3pmaWxqZXptTlpVS2lKVm55bGgzTlpp?=
 =?utf-8?B?VUk2UUNOR2Nnd1Q5NHA3bDQxV3ZOelM0eEVmNHp4Z3dTZFc3Tzd3Ti93M0hM?=
 =?utf-8?B?cHpzTFdjVmp3c2pQVmxvUzNuZ2FPSG5uUzk1eW1TSGh5cEEwK1NPWDFPYmlK?=
 =?utf-8?B?U2pVb2JWSjlpQ2VTcWUrWUpYRGlWWS9NemRkbXhKUFJseW9Pd0Zzb25UbmVH?=
 =?utf-8?Q?ndCPJNtwlksC2MD6plaU4IWNyYQdTDmrr1wIHSNEFvqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE9uS2lZc0ZTWWUyRUY1eEV4anY1eGdWNU5pcUtBek53MENsN0xaVHU5LzJL?=
 =?utf-8?B?aGE5bzc4K1BkZkZuV296QnN4V0ZXa2wzQnJvN3hPQXFFME90Zlh2Z0U0V1RN?=
 =?utf-8?B?aFFaUDdTNEp2U1BPS3BSTzd1RFg4VGlPemZPVXBsM1BNa3hRWFdobjJsR1pJ?=
 =?utf-8?B?WFIreVNVcDQ3enRNVkxoT01QSjQ3MzczZlVjR1lMbHJDMndtbUFyWVdYcGxM?=
 =?utf-8?B?eFBSejRDbnFKZ0xrOFM5Ung4RVpZR1prS2NZTmhSZGpYcHkxbHFOdmd5aEhS?=
 =?utf-8?B?dmlPSXVKVHRZQUFFdVp1WkQwYUFRRlZxcVA0Y29LRmJzeU9ReGMyZmJqREhx?=
 =?utf-8?B?M1AvdkFreW9zRDAvdWhWR09BQytVRHc3NUkyc1plTmRJRHdjK0hNbTY4dVhI?=
 =?utf-8?B?eXdlelN0N3pGeE8xMDYzOUM2bFQyNm5iMTVOd2ZzSERRWDhEdlIyc2x4WUx0?=
 =?utf-8?B?NHhDVGNicGpSdVRlRDRQTGtDYzFRbjVwdjg3M2tUeGhuMXA5UXVlN2lCWHFS?=
 =?utf-8?B?NUVLNTYyaHEyWW1TZU1kTDg3bzdNcHpnZzQyOTRpOVdhT0ZNWmpkUkR2ZGRU?=
 =?utf-8?B?MVZHZDE3SkhHTUk4cUY2ZEYwaWNCVEovejhzVFNaVmhEYVNCVTZkQ1FnZXRC?=
 =?utf-8?B?Si9nczJGUDd6bmlGZG4vVFB1NHVZWDNiK3p6YXNMWVdvUXc0VXgxaWttRGdB?=
 =?utf-8?B?SHBJMUcxNzNTclZSUEJ6SXhkZjhWN2tNcUhCY0Q1YlI5MTRZM1c3cm1KTjRD?=
 =?utf-8?B?T01JNWh5NjRyV2U4UkdmSG9TbFQvem1ONzlIekFuOTd2RkxwTHM3Z2dXRlQz?=
 =?utf-8?B?VlZxMlhzSXJMZFlWK09uV3cyeCswWGxHSlJoSk54VXVTS3FveW1tYnVtQ3dU?=
 =?utf-8?B?S2V6L1c4TkFZbXhqazFXTEx2R05IQmNjS3VkcnEwdENYNlUzTzRjK0pKUUcw?=
 =?utf-8?B?NXh0aFBUS00yWjFNN2M5TjlKN1Q1VmhhUlcrd3ZrcU1yMnVFWjhFYmNxYnZW?=
 =?utf-8?B?Q1ZyRmJZWHI2MEZnei9ibVEzWXljblBMZVIvTU5ZTnBzU1FBNVpEK09XL0Zs?=
 =?utf-8?B?UzYwVC9rY291WXNSTlQ2SHduKzFUS09nei9UR24vWjRHeVRIWCtoN2xHNTNX?=
 =?utf-8?B?Y29OeW9kbEpoU044N0lGdlh1TkFLdzZQa3FPUkk3T2lHemRWaGloWmpqbjFo?=
 =?utf-8?B?eXA2RkN2ZWYrVktEVENOeTZBSWdPZzZsNTI0czZwVXNyMUxSTm9BSXQ4cUZ4?=
 =?utf-8?B?M24yL0pJdlhaZ1ZtRXVVOW50czdrN2xUQ2FGdE9PNmErdmw2TE40dmtLZjZq?=
 =?utf-8?B?OFdEUnJUVmVHYURqdVpTNWE4Vy9iYkkwUVZGU09ZRUZRWUlNYXlmN3Z5bE9q?=
 =?utf-8?B?TmZBSGxBcmcybHN5NU03b1NoVlNkZFVPbnVwQ2I3Z0o4alU3bkRZRmI5N2Vj?=
 =?utf-8?B?alpyMTY5K29IQS9xMkp0MkkvN3NaSGc3RjRjU2R3TXFnZUxaQ0tvdFJjcUtY?=
 =?utf-8?B?UUdFRytNSlVnVDRIcDZ0WXRiOFRNalYvUlkyenYyakxCeW5hZ2hpZVJMSjk0?=
 =?utf-8?B?cjJ0Qm14TFZzMUh2b0hiYzdEd0tUR1h2S2VSaGpESXhnVzNjblVOYzRCVmEr?=
 =?utf-8?B?OXp0QUFSZXFmSFJ5cnJnSm9MaFhYb2ErejM1dHhUT2t4cklNVGVONEtxRXRw?=
 =?utf-8?B?c0J1WVR5ZGhwbHpQTllGdC83ZDhIMUNlTFUvVG1Yc2hKVXZvc09JdzBsUm1k?=
 =?utf-8?B?NHBtVFRFcHY0NnRQYzg4RTlrYUJpc0g0eTBONlN6MFdIZU9yVW5pYnM1cktk?=
 =?utf-8?B?MjhRYnJxcE9rc0JoYVkxb0xGVlQxcTN6eTN1NGFrWlRXT1EzTzBKM2xDUytR?=
 =?utf-8?B?NDdrd3JzbXp5cUtUSlBHdjJ6ajVSM0wydFBOUHhHZmlsODNTY0k0SzhOVExt?=
 =?utf-8?B?N1RqU21qUVMvRlFOcm93djIvMTczdExiWXZzTmlibzFCMVlYc2pNT3E4Q2Nx?=
 =?utf-8?B?VkxuczhvWXpIYjVMZm13MVA3VkN3bTROUnFnYm9jN0ROR0UrV2I3VHRiMVpo?=
 =?utf-8?B?QkQzYmdFdmxRS09jckpYYlRUSXRpYjEzNjRoMExxUDM2QzZuLzZUanU1ZTNR?=
 =?utf-8?Q?1GkKXo6/288S9SDw/fG20M6rn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8f1868-f9db-4f26-f20a-08dcec0febff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 05:20:31.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z2eWFIYmM6qafEobkDoJSTqOwufmPfolKzB9+kB8AwEvhpdOxx4xOzdzZOGYkWlLMKf1A/+Txhg2H9cOx39yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

Hello,
 
This patch is only needed post the commit cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq. Hence, please do not add it to the 6.6 stable tree.

Thanks,
Dhananjay


On 10/11/2024 5:48 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cpufreq-amd-pstate-ut-convert-nominal_freq-to-khz-du.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 09778adee7fa70b5efeaefd17a6e0a0b9d7de62e
> Author: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Date:   Tue Jul 2 08:14:13 2024 +0000
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>     
>     [ Upstream commit f21ab5ed4e8758b06230900f44b9dcbcfdc0c3ae ]
>     
>     cpudata->nominal_freq being in MHz whereas other frequencies being in
>     KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>     
>     Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")
>     Reported-by: David Arcari <darcari@redhat.com>
>     Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>     Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>     Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>     Link: https://lore.kernel.org/r/20240702081413.5688-2-Dhananjay.Ugwekar@amd.com
>     Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda372..f5e0151f50083 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -201,6 +201,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	u32 nominal_freq_khz;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -208,13 +209,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +		nominal_freq_khz = cpudata->nominal_freq*1000;
> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>  			(cpudata->min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>  			goto skip_test;
>  		}
> @@ -228,13 +230,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (cpudata->boost_supported) {
>  			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> +					(policy->max == nominal_freq_khz))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
> -					cpudata->nominal_freq);
> +					nominal_freq_khz);
>  				goto skip_test;
>  			}
>  		} else {

