Return-Path: <stable+bounces-104389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D59F37CD
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7771632BF
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B144206F22;
	Mon, 16 Dec 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8m/idKZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5742066E0;
	Mon, 16 Dec 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371263; cv=fail; b=RUAG7Uo12GAqBfu04czSRALtmzE3smFheKqrtUDBAVjMwuJYcL619jwp1M6pjFXJOgLmUPH2TT6por6Md1H0Yriao6RXVeGrkcxPDQf5ChfBI0Scc2sk4PAIhDB/Y4x5fhxQk7DcZ6OmuJb3VMMV3eKVPuc8JV/+1JbopBBfyAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371263; c=relaxed/simple;
	bh=hWTxXALnKyXjURScR2nCdUt5giDQ4a75MPqEnGD9L4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ei6+wvwxEDYr7ssabt0L305R4NfY2LQN85czcjojVOwCNJgxabzKZ+LMQikpb8hdjEKCuTicly4+giBAA4xcChm8QxCTy4KrFwFp6Z9egWdQzdhhturI3dJeycp2L933j5FhidsA83s2+rElXQReQHtYfXnFEBo0iQO/5UXx/48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8m/idKZ; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7vMTrSUWbHHbnQGHAGAEq4d1twVE2Yml42w6z97oc0GoL60JlrewaH+PkUvD7HcV0Jicy5o6DGMQZRn/suHFzWEpX+9Axuq9gE1AOy356hSthGKzPgEegJzQe6i0kkL2LxcFUOKv/ChmHp4AQlfnOr1k/pHgPJDrM+s8MFXDxB9DKJVnDM14L+Ah5BvUQzyxJ9YOTBdy21WUButyBGX38vLole/ydLI6D+EsOugPKHqmzOaXPVJwMnlAn9rr8NxUlNybq6/tp1FXw/kLFisWdXGp6yq3bYD+hX9+AvJwugZiYtFviyyvFudojIesXWUX+cUN6Hpox5ZGdNdZysGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0TIfG75wJO5lrMLZtdzhGADL0JGb9XEc+PuAWLT5vQ=;
 b=JOffgMo0swXKlzBy/glxCCdazWGQQ4xbFDHspmZsaX/D/gvAi1UrJgcoqFeD/4mF1CpJ2BPGsyMnp6CAAH/kPJuIpu9iVOjESLZobiNVTkmDF37ArX9se24bWCyBV84awWbpznBhQeBMma4t5fD2+vYzDIb+QL4mF47B1X+VKeZK8NW79CpdpJ/tFCk/4P+ZN7Mnp1CIZJh4L5Kgmrjw2ed1uSG8Ng8CWOvyTXgBN6JCR/hEogv0FGdMkkZNY2EngtdgL7fee/Cf7uNUFqo/7IwnsTG7U3sBDlQhrEv7+PxXCS3w1tnkuP8c2GBCBpA/w/8HYJ4o9OzOeSnghzdEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0TIfG75wJO5lrMLZtdzhGADL0JGb9XEc+PuAWLT5vQ=;
 b=B8m/idKZTBYiH6gBtoeAzE4E4HiheDsmop5doGS/loQNINe51G55UgxhRiV0xqblFLERB22AnWADPB+KBbO0vBOy+LwysVmDbv2y/8LcYbHiy0m9DLA8WWE3IOI9aiX49jMeBE2uoNledTf4YpLR5oFSvsPvrqx56dJHcMg5Ffo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:47:36 +0000
Received: from CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d]) by CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:47:36 +0000
Message-ID: <65a1d19e-e793-4371-a33d-e2374908d7f8@amd.com>
Date: Mon, 16 Dec 2024 11:47:33 -0600
User-Agent: Mozilla Thunderbird
Reply-To: tanmay.shah@amd.com
Subject: Re: [PATCH v2] mailbox: zynqmp: Remove invalid __percpu annotation in
 zynqmp_ipi_probe()
To: Michal Simek <michal.simek@amd.com>, Uros Bizjak <ubizjak@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
References: <20241214091327.4716-1-ubizjak@gmail.com>
 <25eb1e35-83b0-46f4-9a9c-138c89665e05@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <25eb1e35-83b0-46f4-9a9c-138c89665e05@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0008.prod.exchangelabs.com (2603:10b6:805:b6::21)
 To CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4956:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: b321ffc2-5373-4c7e-cb3d-08dd1df9b9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0lOeHUvbTNjZUN0ek9kQ25URytuL2ZXb0pYSjhISVpzcVBSaUFGUlRBNDk2?=
 =?utf-8?B?L3o0NXRIYnh2TnZLTHdTbksrT00yTkpWeU9rVmxncVdvaGpsWjlqSnVKN0dh?=
 =?utf-8?B?UEttb1k3UlZjRjVveFpYSUFUa3FmcXF5NmdBNUlpTkVZcVF6bE1ZZFlFWGRa?=
 =?utf-8?B?eHZtRHI5MGRLK0plaW5hU2d0dm9SZUpnMjFvckYxbWJjalhGUEJ1Zm40YUhL?=
 =?utf-8?B?SjluYlNaU1l0WVB3cHNONzZMNE1mMnFOa3hUd2thYkpNYWVSL2x3ei80WDhS?=
 =?utf-8?B?YWhGbEIrZlFuS2RHbzJzWFVVdjZFUCtiUEJGcjlQYjQ5RTgrcDUwVEpkOEh1?=
 =?utf-8?B?enVnd09pK2JIbGY0cmdhYW13MnJkZ2w0NlpKNVkrUm5QSFczYm8zR0FHa0RP?=
 =?utf-8?B?cVovNEtQdWM2dXNDTXhXR3NSUnQ1bVEwb05TS1ZqZTFiYkppSk5OaFduVS90?=
 =?utf-8?B?YmxseEQ2T3lEN0wrMHE4ZXlGbU1LcEJGbU9DVVdVdEExK2dpZjZ1Tnl0Uzl6?=
 =?utf-8?B?VGRydWRUZUJ1ZVJMc05ZeVdoSTVPUWFFSUVnTFM5alk4OW54blQ0d0IzYllG?=
 =?utf-8?B?Y3hxSXZQVzlqSGhWWGxxZTdqd2poNm9lMmlFTzJPQy9DVlJpQ204U0UwTUoz?=
 =?utf-8?B?ejdBNnpFOFpVemNkSThkaW5IeGdSL1dsSHVhU1QyM1I5YkE0Uk5lajBLeG8x?=
 =?utf-8?B?UWlaNDhQbU53eWlLVi9OT2dQVU1hWDdDNjU3OTdJZWxEVmxmMlV6MVNWM2Yy?=
 =?utf-8?B?Mm1seTdFL0p0WDFWWWJPeXh1RmdMc0swN3hsblVoc2l2bjI0SEhkcVV6b2pE?=
 =?utf-8?B?VmtqNnRXenVNTDhINmZ4eGxCOUlFbEFhYzluUGJMLzJlMFlBQ2V4aTRXS2J0?=
 =?utf-8?B?QUl0eGFjRFRWNlM3dVFnMUFKOVhmWHdQUEtQdHJvazZ3NXdLTmMrNlNJZVZt?=
 =?utf-8?B?dzB5V250VXhlVEJxd2lMQllaS0Y0bVJ6UW04bHlnTk11Wk8wOW16b1I3NXIz?=
 =?utf-8?B?ZFlNUCtreG1Ma3JpUU0vSk44YmN4c21ydWpRWS9BcW1BeUNRR3hMTTQ1RnBE?=
 =?utf-8?B?WWEvUXF1L3FJdVM1ME04Sk5pUFphWVZhbm5QSWdxWEk2MU53czBIcGk5OGRh?=
 =?utf-8?B?S3cxYVFtc2xqQUVBU0ZEamVtQ3ZxTFQzc095RTV5cTNLYTNaRUIrVXo3UVF2?=
 =?utf-8?B?WUFxVS9nOXhyeXZxMlUrZXpjalFaRjJHQitKckNxbnVqLzVNQ2dVZWcxb2d6?=
 =?utf-8?B?Q1dwVFBIQU1lVmYwTWQ0a0tRYnNieXlDOWMxSHRQMVluV2dFRWd3ZENDTWth?=
 =?utf-8?B?MWFvUGRnTGVvc0JEdE5aMmUyL2oxYWxsSFU3UysvUEthbXB4Ny8vN25QN3li?=
 =?utf-8?B?WnFKQzJDV1VKaFBwS3VmdUV6MU5vSGYzV3FBZEpTblV4WHhKZURLaWVlbGM4?=
 =?utf-8?B?ZktLNWg3VlRvcGpVR2IxeUIxMzZ2WXo2ZHdUb2lDcGcvVDg1aUc0elJyM3Vk?=
 =?utf-8?B?M1pQVGdQRzZwU1RWRnRGK05VcHg0V1BYOURpVHBMY0lqQ2k5THhiWHBCakho?=
 =?utf-8?B?ZXl0U3d6ZG9tQWJkeHNjUVBoYUYzYmJKTktybVlXbHJNT0xlbW9iVHRCTHM0?=
 =?utf-8?B?eXUvZVJmdFZLVXRsdFJQMzM1K2RzYktaRVBHOTFHajNHVDVxZzZpclA1MUFi?=
 =?utf-8?B?MXZCSHJyemhkTUlUUFd2R3k4NHNHc2JnbWgwYkRKa1FyUnQwQUsybTNJcWxF?=
 =?utf-8?B?bzdnaUtIaVBnZjdldHc2cFFrTU9sRTlxL1pGTm5HdXRDZmZlajNJbUI3Q3dM?=
 =?utf-8?B?Q0d0OG9rQnMrUDY1SEN2T2NVZUVXWENxU0xaUzBOZXVRaFhyWTR4ZmVLYUZv?=
 =?utf-8?Q?MrZoXzP0ozn+q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0djdDZRNmhpR0tNWS81SG1tb3Uva2ZLUzRhdlUxdUNldjNVdkdwbzFiR04y?=
 =?utf-8?B?Qm80L0IyZk5xNDU2aUlDSzRLdEFpV3p0VG44dCtuQ2dVOGhtZGdJaU9RNGFY?=
 =?utf-8?B?Y1dsM3E2S2RLSlhnTGdwRVFudExobWxObTVQTDhlTGh0aDZ2cWJmRFVRYWE4?=
 =?utf-8?B?di9lUFhiUi9samNTYk1MMFU0ZDJZL2dWdmZjbXE5NEVyV0wvZTVBNzlUS1k5?=
 =?utf-8?B?bFRlWUZLM0tiUVhyWXZmUFFvcjM0c2E2TkJvZVNFMmY4VUF5OUpVUW5VaFZy?=
 =?utf-8?B?dWxzNTVQd3lWek5GWkJiaUhBUzRLNDdGek5MNGJQZDI3Yi9nN0tRVmVrVTgw?=
 =?utf-8?B?N2xrS1J4VlJqbFQvd2tNUXpXUEF1b2FXNEU4RWx4L3Jmd2xoWWw0dDZDYTRm?=
 =?utf-8?B?WWFqS09tYTl4S3RMQzBJTFhKNjVWU0NIRXJ5R212d3VNa2V5VWh3VnZjR2Fx?=
 =?utf-8?B?dkszS3dKNnNIYlFqdTNvQ0Nud0g1Ukt5OHB0ZXl2OWkzZkJobUZxcldSM3Bv?=
 =?utf-8?B?b0J6SjF5SnM0b2FHOVhUZ1QzVmsrOEJCTzZ4QlZ4ZmFvUExmN3ZDM0VFWHd0?=
 =?utf-8?B?dFZOSG8rQmVGYW1Jb0p1eGlFVTdZS2g4SHIzVFZsNERSTk44dWJ3Y2Z6VUh1?=
 =?utf-8?B?aVdjcDRicXkwaHNidG5UM21icFFUdTlFTGtnTVo5UGFvSEJkOGZ1Nm5OZGcw?=
 =?utf-8?B?OUp2ZGZNNUhsSmYxeFF6V2JqUnJ6T2NBd3lQTEJESWw4RVJpY3kwWk8wa0dR?=
 =?utf-8?B?UHp2T3M1V1JjTE5vNVlmdkZRNFl4UXhjR0puVVRETmc3ano1MGJ1Q3dCaVVL?=
 =?utf-8?B?a2JBaG1iNjNXZFhlY3IxTDRmd3RPcWpseVhwNTFuc21hTG53TjlOQitLemVQ?=
 =?utf-8?B?TzJKczZoaldxSE8xRFBqNWpIZzB2U2lyTzB0Qy9NUjVoZktROThBcC8wUWt6?=
 =?utf-8?B?WFFyeFEyRWZ0K3JkajJWOWNBZmJyZ1JHZ3IxcktrMjZvZG00ODBVd3k0Nnds?=
 =?utf-8?B?NWVJbzYvd0tmdWlzWi8zNjZicGFLZ2c3V0QyY2x2ZWoycjh5a255UlJmR2ZQ?=
 =?utf-8?B?ckFoWnZWSEd3WGdQdnl1UzBBblJkYXRKNjZmUGp1b0RyTVhvLzNydTM4QmFn?=
 =?utf-8?B?N0RKTGJyRmxYa1VrK1k4RGpKT3ZGWkE1YWxVdEt2U2hvZmRqd3BYaU9GSy9C?=
 =?utf-8?B?bEJENks5K21EOEprNDNINzNNbWhxamdtQ0RjOE5SWG9LdU56V0tFb0tidkNN?=
 =?utf-8?B?SW9sREtkUXJEYUswMll2aTg3RTBhZld6L29KY0QzamQyYklWdWdwdnpUT0xx?=
 =?utf-8?B?Rk81bHdkNFN0SmV3aDV1R3JJV3VIeWVOQ0d2LzJROHVxL2VzZTl0RXdFQ0Ny?=
 =?utf-8?B?UjNOUzVtT1BxYkhvQjM5b014ak9idGg3cmpLbXZzakhzNFVlSU92YmhRbnJU?=
 =?utf-8?B?VDNoSFpQY2JUMXNZUWVsR2dxYW9obmdYOHFlT0dMVTBidVR1TFErWTljQnBS?=
 =?utf-8?B?aWxNY1JqSHNNZ3g5Uld5QUxXamVWWnYwYVNBc0RBS0xwdHBDUER2V0J6U1Az?=
 =?utf-8?B?MDFMeDF1K1c1ckpXK1NBMmZLN2p1WUovSlJlSVBaNndub1lHcjFMaDU2RFNh?=
 =?utf-8?B?dVNlZ3ljNllld1UrZUZYbzAwTTZQNHpnVXRjWjJIdkxmd1REUGFhWFFtYUVK?=
 =?utf-8?B?WUlFRGFPbWp4L0xnU2NUZlNrdXFJYkt2NjIvdWNrR1p1czJvZk9odkt4Q2p0?=
 =?utf-8?B?ZnBCM0hmS1pXU0hwZ1lyakc5NUh2NkVYMUZTdDdGblVXR1ByOWl0aVFqMGlq?=
 =?utf-8?B?bzRDT2dJNVk4U2JPQWh3QURPMDFITmhvUnFUL3R6RUtxQkN3S25lRXdMSGVs?=
 =?utf-8?B?eTlDSkJBV1hwLzZlc1dXR2tZek0wcU9jWGhSMGJkL1IvU2lOaGx2ckp5czIy?=
 =?utf-8?B?K3hLUVA5d2VESWQ2QTN5WWordHBXMXUrNko3aVpqUUFIZ1VKWHNRN0ZtaUp4?=
 =?utf-8?B?aE8wWjNpSEpybHZDZk04Z1RMMk9sS0FpcWlyWnZQOFgyTUlsYWN1bThHcHNQ?=
 =?utf-8?B?bUZOOUZmeEQ5Y0dMdExPUVVweUJWTHUxamNNelphaGM0cndIQWZncE5kT3Nh?=
 =?utf-8?Q?7KVtomLhwi3zTii904ZlFjpyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b321ffc2-5373-4c7e-cb3d-08dd1df9b9e6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:47:36.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55UiCF1MLpqCC6vFTYnBwb+pAKtfb2EaDNKonsmApPA1lQOBNwCJHYkH8gP277hT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

On 12/16/24 1:16 AM, Michal Simek wrote:
> 
> 
> On 12/14/24 10:12, Uros Bizjak wrote:
>> struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
>> so it should not be annotated with __percpu annotation.
>>
>> Remove invalid __percpu annotation to fix several
>>
>> zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment 
>> (different address spaces)
>> zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata 
>> [noderef] __percpu *pdata
>> zynqmp-ipi-mailbox.c:920:15:    got void *
>> zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3 
>> (different address spaces)
>> zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype] 
>> *out_value
>> zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
>> ...
>>
>> and several
>>
>> drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of 
>> noderef expression
>> ...
>>
>> sparse warnings.
>>
>> There were no changes in the resulting object file.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>> v2: - Fix typo in commit message
>>      - Add Fixes and Cc: stable.
>> ---
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/ 
>> zynqmp-ipi-mailbox.c
>> index aa5249da59b2..0c143beaafda 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device 
>> *pdev)
>>   {
>>       struct device *dev = &pdev->dev;
>>       struct device_node *nc, *np = pdev->dev.of_node;
>> -    struct zynqmp_ipi_pdata __percpu *pdata;
>> +    struct zynqmp_ipi_pdata *pdata;
>>       struct of_phandle_args out_irq;
>>       struct zynqmp_ipi_mbox *mbox;
>>       int num_mboxes, ret = -EINVAL;
> 
> Tanmay: Please take a look
> 
> I think this patch is correct. Pdata structure is allocated only once 
> not for every CPU and marking here is not correct. Information from 
> zynqmp_ipi_pdata are likely fixed and the same for every CPU. Only IRQ 
> handling is done per cpu basis but that's it.
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> Thanks,
> Michal
> 


