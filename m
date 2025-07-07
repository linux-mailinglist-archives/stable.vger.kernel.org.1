Return-Path: <stable+bounces-160409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E5AFBDDF
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4D81BC27FB
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F482749E6;
	Mon,  7 Jul 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cd/Jy8N+"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233D1BF37;
	Mon,  7 Jul 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925157; cv=fail; b=ljo/8nZCwDk4vlfxKb71dL8t6ZzymZwdOhy+ornfygLm5uah26OVEjZNQ43WzBlZeJ4sGvsXVRcoESBpeMP6QZPeLkFN1G+HB+bRbJ5lf6MfdQi0SY1TXMzqc9VlaJZg0MCmvirSbq3gUiRAsAM5sOzhJBqCdShQkStuPZZ+A6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925157; c=relaxed/simple;
	bh=lOQaU0Opls+xoOrJWIbL0ooNd+eOrHMIH17smxQ5JDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Srasy72P6ZEhSQVVtdqk4gPhXy/o+vmk8bRm9Sgj9UHIyY8FVeW97SIHT3LEJTLHTDNtFxrGia4279YLJf1V3OWE8dXy4HS/e3VxboeeZj3ZnJWC00XWTbXdHwGVnumZ4cAPRVEGix3yOYR/9unKzfQVPfrAnYtj06NLMiZfyyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cd/Jy8N+; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq5BXdr34tFTu9jW2LTNoya8PI5V2qZ8zAyXwO/DXWlxxLcfB96JipL7z8uZm0lXS9a76feP4J4mAhrLsH4wqDV253RVhOBUZysanuct2OuupWzcfjQDcb+g4JMRXmr6xzm7Jo62t0jrGv/PjhqQDRkhock8dj+0HKn5epClUzM2MfB7PBQbQMUJhMu7L//nQ1ai2/BcNM828h0o7vEKb86C6z1lkYxXCWgDWo0B44wOtY8xaPUOPliWCK/N62c0XXEm5S3XyWISkm9uG+mg7WsMDBvCcjZz6bPCmSfUc6MF5qmonBvTF0mgHFQjV4lglTMpgpVta1i7ebsuu+lRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6bjSlRw05dM7PWaNHBUMtQwsphmpphYVjEjR1Lb9yA=;
 b=NjNL95eDFOGgLv8LsWLTJzz1+rr/7Ia4ZjEROsztz7+9csmIWLlE/bwWz5MWuRedJI4JycCBKu6s0LBTcPTBmTT21WuCwMuCT7Ls9ltu4PC7UXPKKBEExLC8FGFseg2nG9kv5FNq6U8PCROarilKcyeOz+a/dgLtqqWh9N1b7CXcaReL7fmjei8BqUAtVDzdwpQ00wgVPXSR6uzd0h3FE4OuDT4IXMfxxYv33e3J9+Fipbp7v9vqhIoGuT2CYSmajgw3daKZU9etpFbF4+AW8Lt75tzXEQAdUVzjW/lnd4vg8KQgMpdi/qWLvg/WBJ17elLTsUDBfsLg5b1y6oMbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6bjSlRw05dM7PWaNHBUMtQwsphmpphYVjEjR1Lb9yA=;
 b=cd/Jy8N+XSepUjoGWs8XGwjT9dgYRxUSwwvfW/O21dS6dLopa6FsP4m91gMQvLfKg+kKV8dQnwou8adT9SOktl0c3hLCsISumnMN4FbP84Wem5xkcN/2xJA3vbrLGZKGHZoHvJxqzUUR9wp25S5HHzifoyp8ylY4gDWRcWR6BWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 21:52:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 21:52:32 +0000
Message-ID: <f8446083-815e-41e9-a1e8-f8d5c409dc36@amd.com>
Date: Mon, 7 Jul 2025 17:52:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.15.5
To: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org,
 gautham.shenoy@amd.com, dhananjay.ugwekar@amd.com, ray.huang@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: lwn@lwn.net, jslaby@suse.cz
References: <2025070646-unopposed-nutrient-8e1c@gregkh>
 <d7527ee9-fba1-49ad-9a71-6d955eeddc3e@web.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d7527ee9-fba1-49ad-9a71-6d955eeddc3e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0284.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 511aec49-7c44-4f46-d977-08ddbda09391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9qcDhZU2s4SlVQYTA3bUVxOXBHcnQ5V3BZQWtBSkJiQ0svWktGcDZ3Sk5m?=
 =?utf-8?B?a1ZvQnRRV0lxQU5OdCs2bVU1YURMNis2b1ZEb0owN0VtRDlVWHVmSnBIdVNI?=
 =?utf-8?B?VGd1Z1kzeWJhV0RVZWlNMDQ0dnFhK2E2amVaZEhrM3kwR2Y1OGhhSjBXaEFm?=
 =?utf-8?B?RzhVdUtROHNLY2djai9aaG1uYmlPWW1wQ09KWEZFQmE3QUJqYjBHZU9EU3gy?=
 =?utf-8?B?VkE1VHRERVpWYXMzMXFoeFl0UVdtR1N5MVp3YU53R005SkdUMWZJQmJTbkNH?=
 =?utf-8?B?QjZRQ0FRUTZKeTV2MEhTbGxYc05aSjV4dGhITmE5RU5HbU84MGxhdWNkZUJB?=
 =?utf-8?B?YVBaSklIQW1MVWxpcHdRK09za1hHd2VGNGVTbHh1eUhJVDd1dGg5S3VoYmU0?=
 =?utf-8?B?ODg3NWJlS1JuK1I4MnRUVkZnWnc1L2w5TXNlaU95T1FNZnNxZDNWY1c3YVc3?=
 =?utf-8?B?S3hXdlBlbVg2M2FYNzAyaTY1VmJCZWpVMXBVUjZlUkZxWmlnTXNQVTRMYWdE?=
 =?utf-8?B?OE1MUHRVS1pZRHNVRTdpZGV3QndTUitmQU1nMDAzWVcvQ3h4czlZRGUzQWJq?=
 =?utf-8?B?SHdkK3R1L0VVOHlkNEZRWTJSUFV6Z3VEV0YzZkEvTWdlYVpXYkhETk1UUmI5?=
 =?utf-8?B?ZHhtSHprOFdqRHpIZlVuM3plcitOK2RiQkYzZFNuMnNYTXdzVE85d01sbEhj?=
 =?utf-8?B?RitPYU1YVFVNaHlpSEFsRjBkQUdGUWN2bjFMYlJvRTg3eXFNQ2dWZmdiYW1I?=
 =?utf-8?B?TFNhOXdtenNwTnJtbWZ4RWUrSm9ZMDltNzU0UWdYeXI0Qk9pRnBRYzlsQnlj?=
 =?utf-8?B?YmxaMHlSL3FFQkJmY0RNdmphM3VpczJmV3BzaVlpd2w3TkgwVTJoMDJwaDls?=
 =?utf-8?B?aTluOTdsKzhTeTVTNUNXaUMwVldiNTBtblNHajhZZWlMYXV5ZVppLzBrWTRk?=
 =?utf-8?B?RHlieGI1UkkwTEVyNy9kYzRJaXVmNWFFeEhWbFFDVE1oRnNMRUQwOVhMUU9L?=
 =?utf-8?B?VzlSdFZncXZEVGlWc0J1TUdQNW5pUDBIVC96aTQvU2ZacTFNUnkrbzBRUzNM?=
 =?utf-8?B?cXhIZWJ6OCtSbklMVkZJUEE3K0dVTjBvcmFqRjMyVWVkTUdKRXoxckxhb1BZ?=
 =?utf-8?B?dHY4Nm1KRjNFR2tqcFF0UjVkQlh1T3Y0NGdIMm40bk9qaXVBZ291OVdocC9i?=
 =?utf-8?B?WW5PZE4vcUQxcFFjOVM5bk1JMnNiWnkzTzR0VW44dVA2eW1HaG5wQm5VSlVi?=
 =?utf-8?B?Y3FrQS9XU3Fmenc3dTVRWENJNDRJbEZ3M2NvL2VwVzBGR3pxSEhudG93TVhF?=
 =?utf-8?B?YnN2K1FUSXk2S2IxNGs4ZGtrdUlzNHdQbjZWQjZ2aTBRZ0VXMHdRNEdKcmc2?=
 =?utf-8?B?eWhlSWlQNDcvRERyeUpYV0lma3VnTzA1d0ovZkpmdm85bEI4Y1A0RjUwRW1B?=
 =?utf-8?B?MUhLQWo0TXhtcFpKZmlWaU1saFExSzVUeTdLMGVScmVVdHE5c2x4Qk1NZm9P?=
 =?utf-8?B?V1kzdXE0Zys2NU5FZ2UrVTFadEVqSkFQVWp0Y3gvY1lrR0xvK2V5Ty9VUzdQ?=
 =?utf-8?B?b1NWWGNERW1FMmJGT1pWSlVMcVY5WFJ2RmVVaWxpbGZEUTRNOUtHeHBLTTBw?=
 =?utf-8?B?OGt5TStkNWxJSTJ5ZVlVTlNNR2xaS2UvL2tEWmNOWUxIYWt2V3JvaFNZMGdw?=
 =?utf-8?B?QVlRWThZdncwbXRKQ0xlMHlsdDBlb2pJTk9EbGlZdm9VT0NmN09PN3AzcC9D?=
 =?utf-8?B?d0M1RkM0bmV6VC9xY1pqR0pHV3pqbzMrVkJXT2dzU2p4cEczK1hiU2c2Ly9R?=
 =?utf-8?B?bTJoZ1R1VnQwbDRvWWJjUW55SlNrQi9kMnN2M2RQNTVVNGxrUVZqTDI1Z1o4?=
 =?utf-8?B?T2JoK2dhYVVUdDRkV1A3T0lIc3NwOUlIOWdXdExiNTBaeVhuWTRLSkF1dnVy?=
 =?utf-8?B?SmpRSWFqODdVU0NQNDlBcmt1WlBZMnR4THlhWG8wM0JWakVJUm02LzA4N2xa?=
 =?utf-8?B?TFJjaVltT3JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDRhM0Y3SkxBSlllblI4T1puQ0F2TUxiaTcxcU45Y2wxa1hEcWlHck1sci90?=
 =?utf-8?B?aVJRelhYdGRmSEtad1kxanpIOVk4bGY4bUdaWHdFZ1ZPUnhyNHJiNXFzQVNm?=
 =?utf-8?B?bTF2azBMRWJRK3JVSDZjaXJQR0hSdngxRGNRdTljQXZZaklTUHpQay9SeEFW?=
 =?utf-8?B?MG5lRno1RWlpSTdjOWhPeS94SCtrK3Z5VUllWCtjQy9sQVZMLy9yOC9GN21C?=
 =?utf-8?B?ZyttUUg4UmFqeWhXeEZwK0k3dk5vbnVoYWVhbG1JcHJqYkt5SURZUHJPWnNU?=
 =?utf-8?B?KzFjd1BaY25iUjVJeHB4RlJPWDJzZHgxTVRGMldxaDExRkl1SmJ3Qzc0ODls?=
 =?utf-8?B?bWQvQWlibmRVeG13RlhEZnBGdHhMY3FaS0xEeEdOZGxPbC9ZTzlXSktYWGd3?=
 =?utf-8?B?eUtzbXAvMldxWXQwYkdHRGExckdUMGp3QXZOSmJ1K0ROVEFoYUVsSGdIdlcw?=
 =?utf-8?B?TkFDOXRGNEJJaXZDMDdBNzBoa0NvQVZNWVBrc3JtKzR3cUtqTEI3Rk4rTng0?=
 =?utf-8?B?a0RLUUl0SkhUUklkZXlZMHNUQm1xKzFMZHVNRStEdFhLWHgyRkdoUzNjdGhw?=
 =?utf-8?B?d3YzUVFkTC9qQWhYRHoyOWhSMlJqZTVXQlZXWmZPQlZMc2lJZmxqTFp2Sjgv?=
 =?utf-8?B?QjNjaUlyMllzaVdYQmZIb1hGSng0aXhJUUZPTmNxRjlYcDVhVVNSOGpaRVpG?=
 =?utf-8?B?TFl5aHpTeS81Z2hJSVZlb3Y2a2F0SGZUWGpzWVpzanlLVzlsMjlLOVJkaERy?=
 =?utf-8?B?WEU2bHg5eXJtbXBmeTY2V1NxK1pXZlFHZTQ3NXA0WEI3UFhmY0E0SzZpSWZs?=
 =?utf-8?B?WjMzMHpJdGFVK0l0UFFMTlRodFNYSEVjUFRoQ2o2aW9razRGMmM0VU9GMzUz?=
 =?utf-8?B?VzFoOWI2RHdaVDJCbGxjSkxldUxoOUozdDFEYmd4NUFKcG5FMVhmd2hVakFl?=
 =?utf-8?B?Rjhmbloxd1N0Wi9vUjVOYkdiVXJBa2Q1a1F6dEFhOGpIblhqYUtkTVF6czd6?=
 =?utf-8?B?YW1LUmJla1BWVWZJeDVWM0lRcVJhYW1XaGZFcDdmbFdyRWovK1VRNi9kdTZE?=
 =?utf-8?B?UEdCOGE0R1dXVnA1amdNa3lkOXUvMGdwaWd4WkZBcWI1NFc0MEorOVl1YTFk?=
 =?utf-8?B?aGs2Uit1b1g2NDZUd1Z3Tk56aVg4dkY0Vm9PYlVvZ2NJMHVJa0grRjdVbk0z?=
 =?utf-8?B?TmowYzJ2NW1WM3czTTF1bStyUXNrejh6QlM1VjJzclJxQ0VxVTltZm5nbVBI?=
 =?utf-8?B?M3ZuZVVwbmN0Q0UycmI0SWM4Q0dJNFd1YVRjZzY2ZVArSFZ2VnZXdDkwNmNj?=
 =?utf-8?B?ek1SSEFWellkOXpGZWRRem4wTjF4QjdCTnZMaGRUL3l0RXpya1N4MHkrR3Ix?=
 =?utf-8?B?eFRzT1RCWDZ5VjZieTVyRm1yV1pWanpHdTltYXpyMjlvaTVZdFd2c3pwUUht?=
 =?utf-8?B?QzUrZmM0b2Z5S21iUUhydS9FTm5Md0l2REVmV2Jybkx2TUg1UXQ5T0lsNTZJ?=
 =?utf-8?B?Q3VnZHJ6aEd5Wjl4b2M2cnZhQjZOK1RyUVdXajRnR0FWUHN2dzRScHVLdTNk?=
 =?utf-8?B?WmpNcDZ4NTB4Z29ZRjdmbll5S3QxYmp6K3VTV1h6Qmd4am9SVUUyZUV5ZEli?=
 =?utf-8?B?ZHRPcW5rNXNRNmFrdlZOMWNzOWlNVG82QTAvaUJmRzZxMUYxR20xTFNFVjZq?=
 =?utf-8?B?UDdMTGRjZVQwWmYwVlk4N3EvOEc3S1krbWhnZ3V6U3dsK2VEQTIwY2lSaFdC?=
 =?utf-8?B?Q3pRWGdNOUNNa0Zhd0p1M0dXVHVnRWR1QllSWWtLZlRxUDQvSExka3AzZzFH?=
 =?utf-8?B?WUhQVVBuamJvYmRZemZ4OGlqRXdLalBsdXdQVGdUaC9RNEhBZzRTQXdBWmp0?=
 =?utf-8?B?ODJaUXU2SzlLamw5MDZHSnlhVk9RYzFoM0l2bG9zTGIybXRaQ2tQK2VlNW5Z?=
 =?utf-8?B?Z0VockxHYmM0VEVhNFRWaVJlUnE1ZlB6akE2SGdhd28vQlo5TkIxTDQ3TWpH?=
 =?utf-8?B?Z0Ztb1FjeEVrWlpYUHZWN3l2VmtVMTcrcy85cXZKcTRtZksvbGYzakpzdWxN?=
 =?utf-8?B?TzN6bzJMNDE4T1g0NmRNRUdtYzBLQWNMYkhoWDlkeWVSYmV3YVg4ME9iRCtC?=
 =?utf-8?Q?SII06sAeVaIbVowJZzzaABLeh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511aec49-7c44-4f46-d977-08ddbda09391
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 21:52:32.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7V3wMEwlR2ihSRFTfN0Kn8d1PORab+3evFTV/5FqV2cYGP1WT75PbOAAJ5d2XpSzZNaeHA9Qa4YHcYrgttPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017

On 7/7/2025 6:41 AM, Jörg-Volker Peetz wrote:
> Hi,
> 
> upgrading from linux kernel 6.14.9 to 6.15.2 and also now with 6.15.5 I 
> noticed that on my system with cpufreq scaling driver amd-pstate the 
> frequencies cpuinfo_min_freq and cpuinfo_max_freq increased, the min 
> from 400 to 422.334 MHz, the max from 4,673 to 4,673.823 MHz. The CPU is 
> an AMD Ryzen 7 5700G.
> This in turn increases other values (scaling_min_freq, scaling_max_freq, 
> amd_pstate_lowest_nonlinear_freq, etc.).
> 
> Bisecting this leads to
> 
> commit a9b9b4c2a4cdd00428d14914e3c18be3856aba71
> From: Mario Limonciello <mario.limonciello@amd.com>
> Date: Thu, 23 Jan 2025 16:16:01 -0600
> Subject: [PATCH] cpufreq/amd-pstate: Drop min and max cached frequencies
> 
> Did you notice the increase at AMD? Is it intended?
> 
> Thanks,
> Jörg.

Yes; this was noticed back when it was created too.  It's intended.

