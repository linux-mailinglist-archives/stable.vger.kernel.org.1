Return-Path: <stable+bounces-56260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195C91E369
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9444D1C22002
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB416C86C;
	Mon,  1 Jul 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7WTyw3o"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4116C86A
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846488; cv=fail; b=nwb5dz8mTZxgNTgyjvddRlJfxxv/pg8jJkuvqsLuqylshD5xTK84Ux9dSRqZaZoTQ0K2832ekK/GHt7xHKRhKPhLiqHzhaDVN9OQOJ55ijv08I7St8yiTpwPVfV74MWvm0/UvFJka2EEjhNM6U87zxMi3IBq8dDPLr3il8vS8/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846488; c=relaxed/simple;
	bh=x9z55jQ0u2MrHEYrl1BnBtqs0KRPNjM67RKCkIAfO40=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hf8hOLdfUZx7ziH5kFAA4Njljs2cjMQuW2PALGIVlTX+m7CwjNwGJExNFXAh5nfm1BA5zCi6ztJb1wvIslMpZQnkbnGTKQIjDmf8nycdOFgk/amgX1NlIpDu01LtPv2AmAjs24ANYNx0E8N74J7nJEuVaIyYcpQPRUAduW0G3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7WTyw3o; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7CeTHtKUS1Y5TFOo9bDyBxSUrlAypPwxRQD3OuytEyco0lQHeVsSEfkj3X0WxpaicfeN7Zql8xUN1iIqHJKwkGS49mZHE1r4Mc9sKhmb3wKdAvIbQ/Ufs9nQIDMETBRZ0nWbwcBqqm+wx/OKXEN3AFKIhsR7gQBKNzBhEC6/arX2XFxm+sl17YIvzMgESb3BJf8mkkZaHbALppQTAcpwILYe61SB3Wnp4iIxpumwBjJj/LXlUGQvVDBcCZtI0b/6k4N6KRJV3sF2ZFBnnqQ2jgLlujxkMBc4IOhfvh01xpEyVQ0J/pFqM73TCTX1ncixpNIA85bTMq9tCvPEZ5WLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36fOiLLwM/4Wz3jQOcBFvw96QPrbsQ8nfs2tOGZh1QU=;
 b=MJFkVNcyvkmFsfAo0f55PJ1j6lAPS83zGjX3SBM1KESGhfPgPu8lvYN7StpfGATNri03mK4HGFDrLT0T5aTlqhH8aez1sIPlM7RjH35dJpOKQiJAjfWh9qhjlT9Y/W/WicpBPyVz30QlT/9iF/jhbRW8WwJESW9nTkHPNGqdeiQzcaoBOtzj+CWpXcz/+B4xAAHhlNZo+n+4nG9Xd9FiLD1FhtuHITOjBHUT+b0O1Eqd/DBDllSYDntHlQw1WS7buojJHKI/XVW1kJPH7s+kvl3C73BJUx45Wu5YVKErZ3lynMIcyVFLxJWzpeXut18pgC3UZpJD9fXf6B+VjSbNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36fOiLLwM/4Wz3jQOcBFvw96QPrbsQ8nfs2tOGZh1QU=;
 b=N7WTyw3oOgFF+Rl7qf+F6nvXJ6MDUm+gNfMdL5oMjIAOePRdS/oKfjt7wxlw3d1SbpwmSRhAotFsuOZbu3DzKPy4RncGJMoZjV40OhNZQClJnjJ54NFGX4ZG2MQvzjMj/bOSZp69mYvn9PPS5bmEWrhYlgxBPcrZEW8hslpoHhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:08:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 15:08:02 +0000
Message-ID: <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
Date: Mon, 1 Jul 2024 10:07:59 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: FW: linux-6.6.y: Regression in amd-pstate cpufreq driver since
 6.6.34
To: Lars Wendler <wendler.lars@web.de>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 52533b39-1868-4e35-3456-08dc99df99f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym1lRXVjVXRQNThsOHlGMmRpazM5Q09SajhmclhpSGZBanQzbGVWVVlycTVC?=
 =?utf-8?B?RCtOT2hUVjB0WGNKcGRnNERyTXUxTEMydlpmVW9Zdk5wZGhZTldMbTR3UXdK?=
 =?utf-8?B?eS9Ma3Qwdk1IUTloV0hzb09NemU4YW1WNDJzK2dLTFprTkE1M3Y5dkllODVV?=
 =?utf-8?B?di9pNzJjMVFOMVppdkNqQU8vTkQ1bmtTTEJKMVlVNS9YakN5cmMrelROczFj?=
 =?utf-8?B?MWI2aXBQZUFuVzNIMjlaRlJxQVNObFBsQkQ0Zy9Eb21RZVZXWEJEZlgwYVBY?=
 =?utf-8?B?SzFNdDkvTGV1eTUyZE5CVlJHazg4TFlnbEJnbkZpMDUvbGtUdE5jb2lTV2dI?=
 =?utf-8?B?UlAzdXU1N1JZT0VibHovaGJ5TW9TZk9xM0RCQXhHdEZiV1AzanpaUmZ2eis4?=
 =?utf-8?B?SDQ4dExhRk5GaGhrNFBhY2NJNUFCTVA0bThWRnRFZWxldTVhdzBBMWxaM284?=
 =?utf-8?B?L0p2UHhOQ1BxeTlBeXVnZjIvbnEzSlo3VXR0YjhoWUZHL0xjOWdnVUxwRkRO?=
 =?utf-8?B?anlhTW1senhSdDlBbUUvSzdmcDQ2OGw1UXNYd3RtRDdzdHdjQkY2VUpQLzJG?=
 =?utf-8?B?MGs1U0VvUnYwOVdlRVNZR2RhaThHWjdYcWdxeExWQUF0MFQrMjVBQ1JqZVFk?=
 =?utf-8?B?SkNBaGdTWHN1elRrWlNYMzF2M28zY3JVRzJKRjlMc2dUcHZkRGxNblhFcWZ2?=
 =?utf-8?B?cHlKZTdDaUZRTVJVUGpoTnpQdUpUeXpzTUNKZEZlT2svVlVmUEU4eVBocUY1?=
 =?utf-8?B?S1lJdHJ3dWFWdzZxdHNMTTZIV3llUUlTa2h5dmhSWXlmallhRFhwanVhckw3?=
 =?utf-8?B?SDJBQ0xaSXIyY2ZrSk05Sm1PUmdnTjMvLzlYa2UyWTk4ZUNGQ20yRUlZQWdW?=
 =?utf-8?B?U1lra3B3aE5NS0p4RjhHSVpZaFJpbDNmL1RvaDJJaTJvYjkzTTkvZ1hNa3hI?=
 =?utf-8?B?Yzk5WFBKSXFOZEF6eXU2SWlISXBYNm1vZzl6VHFBNVp6c3hiWWdJMmpoZ2Zv?=
 =?utf-8?B?SUZ0Ky8vclFWYVdvYWhKQTZxYmZjcWw1Z2JTM0U4N3p1R1Z1Y1VhUHZVQWFI?=
 =?utf-8?B?SE54NU1uMjMyZk1lL2ZDVVFWR2pGYlNvR09xZ0M1cFc2cDVuNjZRSEhFbHoz?=
 =?utf-8?B?K1JvdThkWjRpcmdKN0pkWnVLQ1FKdnd4Wmk2Q0c5RDE1dFd3MnZLVlJCeTlE?=
 =?utf-8?B?bEpzR2VDRTlEZzlFSzFhUjRNUHF1eGxHNlpvdXR3bmcvT0ZCUlUzd3czWTlN?=
 =?utf-8?B?K0czblBhY3N4TUtucmtXQ2hvK3ZhMDA2ZEFjQlRkYXpOWjY0dzMwUy8yUGIv?=
 =?utf-8?B?SXhxam1DT2F4YXZRbVgwWHBSclFYNlVwSTdpSHZHSGhmVGh1NTh2aHZhUDB3?=
 =?utf-8?B?dUlQQWpFSUdXa1poUHp0QW41UE83b0tsZGtrbEFjWnI4V1A1b21wNjliQTZt?=
 =?utf-8?B?Zm1TOGQ1ZEJZaFpHUW1oallZMlBFTnVuV2wyNTM5elV0ODJIVmJaelNpbi9M?=
 =?utf-8?B?NVFCRW9oZS9kd21mbHErSzN3b05DK2M5WEROcGJpdWJDVEFKbThzQlBoMEZF?=
 =?utf-8?B?SUp4NnYwakUwTjZTL004Y0tRcjRLb1p6NGhPUmdrRTUybExSVldtakFjZFlR?=
 =?utf-8?B?eVRxc042SnN3MEt5ZVg3WXZHNWVMZVBkQk5DTWJEbG5vbzVLQTYxUXVKWTJu?=
 =?utf-8?B?dUdTclpLektVa2RKNG4yc1FaZ1NEeXZoUUcrczVDYkZBcVlsYUd0akZsMURQ?=
 =?utf-8?Q?+OeC2LkoTrVvLddS6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFuQUF3cFEvK3RjMURZNk93MHpiUzRWeGoyb2Qyb0psNFlLVnNFTHNCLzhw?=
 =?utf-8?B?ZGcvRGxpamVVandTZERGQy9ISWs3ajR1cFFDalNRRXhHKzFkWjJzUjBRMytP?=
 =?utf-8?B?YlpjSkQwVXFFaU9iaXk1YndCWHVhQk5yblVWZVdKNG5HVmcrSTE4WnR0WHhR?=
 =?utf-8?B?WmNqZmV5Q1pNN2VnbHNhaC9uZEc2TVlBVzBFdjFuclpKcGZoeUZUdnZxUVpJ?=
 =?utf-8?B?RU1PRUlWeXZGVzg4clBFbHFpU3V5UWgzZFJLcEZhdG5KOGtuRHMzTS9SbHQ2?=
 =?utf-8?B?MDhWMTBUZ1MxZjNJaFFyMHhwM3BMUis4V2dRT2d1K0FhbTR2cjlxNFZMRHBJ?=
 =?utf-8?B?cWJ5T0lrT2RHcm9rcWVKbTNqb2RDQU0rZUJRNGxRUGNXVFlFSURyTHl2OERj?=
 =?utf-8?B?SFA5NFFlM1RQNlIxcGtwS1Y1YzZsNEtuaDg5elk4aDJxWnlyUGMySW4zRzN3?=
 =?utf-8?B?SjFyWDF3bm03MW9UbFRTaDdSUmZsZjBBL2g0TTRTdGlLTUZVa252YWRMaXN3?=
 =?utf-8?B?by9FdThZbmlQcER2TXhEcXBCNFQ4KzRmaURzZS9JTEJjWFlxakI4M3dXbFJN?=
 =?utf-8?B?Q29aeTNWTzk0Sy9VNVVjWnhDTlBIK0hjSCtmY1hSZVJPSUM4Nk1wUlAxNEFx?=
 =?utf-8?B?NTl5WXRDa2NuQ1FiV09xcmM1cit2dlFSZVJKOVNObEFBNENPWEtObmlsMlBS?=
 =?utf-8?B?RnBOZzluWm9rdHV5UE1pL0lIQ3lRQXovaHowaHpOY3ZER2J5T1pXR1ZHSGVh?=
 =?utf-8?B?SFkvSHMxWC9NYlptcWpnTmZQS3U3MFYrYUEzeHBhcUpZWVpiL2NGdThmcldP?=
 =?utf-8?B?TWQxcE1SL2V5ZmJmbVE3UTVuVlRaLzl1WVRsWEk1T2Zkak03NWR0VEY0Qk5F?=
 =?utf-8?B?NmdhMmxkMGhuS3JUbnIzc3FuQW5uQVRkZnF3eC94eU1kVjUvR1N3RWROVGo5?=
 =?utf-8?B?RkhPUndCRHIwYnN3SWUwTTFFOXlkUTFJckZpN1BqdXVjUFVQTFFrZzVvd0hY?=
 =?utf-8?B?c09QbUQ5NUJFQ0gyOTNaSXh0Y3Jzd0lUS1kyVTVrTkhmaUZMMC9vMG1VcDE2?=
 =?utf-8?B?M0wxYml4MXE2bktiT2J2blpLTmJKUWh2bHhyNStFUm41a1BFWE9NWlR5MWEr?=
 =?utf-8?B?RUE1NmdCMVRpa1dPZTUvREFRanhVMHh3YTA2cW9Kbys1L2V1NmtSWW1vWjdp?=
 =?utf-8?B?RjVobVdXS2srVzdpV21KYkU2cUs1VmNGOHluTmFid1NBQkIyVStuNDQ1Zy95?=
 =?utf-8?B?SEZXYzhITHlEQXZnWXpTd2JHY1piM0Jmbys0QWJhdlZoM2o4VWRUaWlGMWgv?=
 =?utf-8?B?eDcxa0s4Sk5NWmR5UWZvcDRmU2JDTXpyWENQQzFRTXRxTTM3bm1QMXJPaXNZ?=
 =?utf-8?B?RXlvSkh6OUlrR1c1dkxOT2JDb3o1blRmRkRDTFJNeWFPQmZORStRakhJQnVL?=
 =?utf-8?B?MzVNd3cxRFV2bnYwQ3NuVE9Lc3AvUUpoRyt6OGhkR0V6bXRQT1Fib0NSWWtu?=
 =?utf-8?B?STFZSlNaNG5TaWk5U2p5dEhlTFM0L0hEMTBodHA0RVhLYlhGazBJcjJjVUZX?=
 =?utf-8?B?MUZmUDVrL1lqam9CRVdGMDVBNlM4c0dGdEJRTDFMQWw4L003MU95RWRsUTg0?=
 =?utf-8?B?WUVKa1V4b2VFV2dWN3N1OEZmdDdwTVBrMkFBZ2dHNzdKbDEyQlk5dWJhbWhP?=
 =?utf-8?B?Zi9QdU5MdzFqTVY0Snh4Z3hKQ3oyTWdUUHNWWW1jRjlWeVlXeXNTS1JRNW91?=
 =?utf-8?B?OE5OOXpHc01YOU5kcW15RU5YV0dvUVIwMGNtVythMS9Rb1M0Q08zM1huYnAv?=
 =?utf-8?B?Si90Z3hpT0VMb1h2RW9EZ0VINXJkdlJ6K040Q3R4WjNrbmorV25vTW5Deldj?=
 =?utf-8?B?dEliMjJpbUJoUVd4UWZ3RnhnSU9NbkJTL3pyNDRIWFVLZDVKampDUGd5WjEy?=
 =?utf-8?B?a0pMd3lmZXl5b3dVM205cHBoU01NT3U1d2xBSWV6cUt6NmpUSXdtNjlxRVZm?=
 =?utf-8?B?cERScDRzK1pySFdBRitKam5IZE9MU2dReWJ0a3lveXRZaVhkcWRuaDVISUNH?=
 =?utf-8?B?cUEvNldGLzE0UzNDZzZQU1VsaStxNHJOb1N6Ymg3OGNkQjBJV2FPamNtU1Yv?=
 =?utf-8?Q?/zpYffDt/4U59t7QrDlYcZdfq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52533b39-1868-4e35-3456-08dc99df99f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:08:02.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFI3yD4KlrmqfZy5PnPqV9Hfx8sk5+/m+JdTzuTq9Tgv/HsJ6h3UyPXBrutO6tfueGoM37VjT1W4e084Kv+9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

In the future, please send this to the regressions M/L and CC people 
instead of just sending a private message.

For now, I've added the @regressions and @stable mailing lists as this 
is an issue you find exposed specifically in the LTS series.

Hi Lars,

Can you please test 6.9.7?  If this is still failing, can you please 
check 6.10-rc6?

I'd like to understand if we just have a missing commit to backport or 
it's a problem in the mainline kernel as well.

 From the below description it's specifically with boost in passive 
mode, right?

If 6.10-rc6 is still affected, can you please see if this commit helps?
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=linux-next&id=e8f555daacd3377bf691fdda2490c0b164e00085

This is going into 6.11-rc1.

Perry, Jassmine,

Can you try to repro this using bleeding-edge or linux-next branches?

Thanks,

On 7/1/2024 4:33, Huang, Ray wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi all,
> 
> Could you please help for a quick fix?
> 
> -----Original Message-----
> From: Lars Wendler <wendler.lars@web.de>
> Sent: Monday, July 1, 2024 5:30 PM
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: gregkh@linuxfoundation.org
> Subject: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
> 
> Hello dear kernel developers,
> 
> I might have found a regression in the amd-pstate driver of linux-6.6 stable series. I haven't checked linux-master nor any other LTS branch.
> 
> 
> Now here's what I have found:
> 
> Since linux-6.6.34 the following command fails:
> 
>    # echo 0 > /sys/devices/system/cpu/cpufreq/boost
>      -bash: echo: write error: Invalid argument
> 
> and indeed, disabling CPU boost seems to not work:
> 
>    # cat /sys/devices/system/cpu/cpufreq/boost
>    1
> 
> I have bisected the issue to commit
> 8f893e52b9e030a25ea62e31271bf930b01f2f07:
> 
>    cpufreq: amd-pstate: Fix the inconsistency in max frequency units
> 
>    commit e4731baaf29438508197d3a8a6d4f5a8c51663f8 upstream.
> 
> Reverting that commit (even on latest linux-6.6 release) gives me back the ability to disable CPU boost again.
> 
> I can only reproduce this bug on my Zen4 machine:
> 
>    # lscpu | grep "^Model name:" | sed 's@[[:space:]][[:space:]]\+@ @'
>    Model name: AMD Ryzen 7 7745HX with Radeon Graphics
> 
> My older Zen3 machines seem not to be affected by this issue. All my Ryzen systems run on latest linux-6.6 kernels and have the following configuration regarding amd-pstate:
> 
>    # zgrep -F AMD_PSTATE /proc/config.gz
>    CONFIG_X86_AMD_PSTATE=y
>    CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=2
>    # CONFIG_X86_AMD_PSTATE_UT is not set
> 
> 
> If you need more information, please don't hesitate to ask.
> 
> Kind regards
> Lars Wendler


