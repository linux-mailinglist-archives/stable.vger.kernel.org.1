Return-Path: <stable+bounces-200913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C902CB8EBC
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54533006583
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140372609C5;
	Fri, 12 Dec 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YAQXDCcV"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDB25785D
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547391; cv=fail; b=NGQKMmvNK6yv7NbRC2fgE/ViLgad0DzScfU37AYPjLi1gk0IHw7ag1vKh4/OhOyJBBdEUoj4zWww3t0vHKd3dTMCWUcsPWrn6EbyeAtBaIo9yy+r9YxZ6bqb5r7IznI8LsATPauSrgM+IpzXP5gfOnF6EjlxJK4yNYr8WWZ62j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547391; c=relaxed/simple;
	bh=AyeDymIX1to9hTQa0ZbU0YfZNgDTb/Jdvqol/Cii2bw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACu46XyMDY5zn05SIsi8ZAucsWfb6RGW6x90slwY8mUoqym1AdbmVp3ewdGqPKzanV2gJZgNHzISHasDQT9XivDtXCB8y8rdhOz+ZY5WHccAQHHorQYmNaIbA1Y4DpeIfAlUFREUgsE692ilgy+o7ZfwyvOKEBQ2XAtd+W0hr4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YAQXDCcV; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgwY+SRlQ57uC0m4hB7A39XJwdyP1hL50iOS0Rof7uTjxxP8z4xvH5mgp0+gDgWxMrqh2Y/Wl8r85bljhFWXMmAIRQMgIrYFNfSqAZmm+G+skCKFZd5bdKrnD1XC78szmZIiI4cPYsk20B5JCcRZHQdxltwkZvGTdsd48vv2saa3+N+aPL1Ul8uTdtbaFbpuVxb+jzBiV0H+rOsv11G9YGcWf6SiZO3RIcSae9U4wRms6DF1PqPtSszeUI+/DfkTKzROEcLdRLd7PYK0vtwxxLCqAlzsBVYd2SR2TO/xNL1TGWFM6y3l3za3uGeg01Mmr5H4KbzX1Dw3gDO5ulvW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpihtI10wLJ/gOWM7CHtf39YueKE9ACSiBhMhXOlfSk=;
 b=O4x5tPxydM01ZgunGeCUCvkNKEb0kLMenelt+wpRT4hSk6Uxak0dJldCriGTuAb3smCAt83N4J6dEHXqgZjtqqwD3bmPnNfNTBjqcnFjoddFHNO1XMBKOCFptd1ak/sm3n5KdCA1OnDVLCkE0UE8t92BvW2kOs9PGVjVU2IBu7YX5BMzuAvGglAMMIHxzLKkt2htI5yOYsoPARscnxBc52BZgogICzM25IAPJNw9zXjlJxzofCdyn3M2qpBGE6xBGMwcKVs24z3ekO377JHTAL33x+yNvdTTVqGWXvCWX/rYgwQrkHIENFnxRUhRj6gozZjWW2n4e1Zu/jQ54njKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpihtI10wLJ/gOWM7CHtf39YueKE9ACSiBhMhXOlfSk=;
 b=YAQXDCcVIdaDhbyfH0KEEuuO0Bzeb61IOnwnOTIYx/QvIaeCnBs4j1jqQHXVEhJDkza+HCGZglMTxaxzPIyXXMIz0gRxj7fTRfbZtHmuYRlzdgdETQosWV72MdvVgNtP9cl5mw0fjgCLRTxQPU0KldPzI13E/of6c4ovo1zZv8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 13:49:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 13:49:45 +0000
Message-ID: <24e5cb3b-73dd-43d3-9d35-b29d1d18340a@amd.com>
Date: Fri, 12 Dec 2025 07:49:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, bugs@lists.linux.dev, Jerry.Zuo@amd.com,
 aurabindo.pillai@amd.com, ivan.lipski@amd.com, daniel.wheeler@amd.com,
 alexander.deucher@amd.com, gregkh@linuxfoundation.org
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
 <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
 <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbb62bc-be4f-48cc-29a3-08de39854f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhmaWdyUTFoR2hUQXBiVUhNbHdjc1RmMXQrQXZoZXlTQkZPcHFSdTkzeFM5?=
 =?utf-8?B?amRIQUtKRWpwYnFub1lJMGlwZkFGM0R5QmlmTUhlN21jQzM3aGJZNGpDZ3hR?=
 =?utf-8?B?MEFQRGI2Q0xNTzVmM25sbjE5d21Wcm9rRmdNcllXdDVTMVVOMXBwWEgra0pq?=
 =?utf-8?B?TE9BU0pQNy96bHhpbEIzNGtOYTY3bXQ1MDBBbXdaY0QrY1Y0WFlKdVZsZllz?=
 =?utf-8?B?TVdqdlZPMlpHRVh1cVlQZnhlV1B6TVZqb3JGVmlvVFZyNnFMRWdQb2FEY0Fz?=
 =?utf-8?B?Wk1SUUlrTVlVZklYZXRaQ1RrWDNFYjlPK3g3SlZrNXIzNm1Pc0pwOUY2dU9B?=
 =?utf-8?B?VHdBVHk0WjF6bHVWSWRlRjJKYWpiQWpGVFJhcnV5TXJLcVVTVkZROGZqdmJR?=
 =?utf-8?B?TG1VNUEvRlZlanZ6c1pEalcveDlsTGsybGpnWUt4S1NNajBBNGVMVFh4R1pU?=
 =?utf-8?B?dlUyT09ieERuMjFKNEwrSmYvNytraFRJZXhVYUhWc2xMaTV0L3RaaHpoNGZu?=
 =?utf-8?B?NFlHaWxDZWJRMWJNN0V1cnM3Y2JZeTEvcHdWVG9wZng2SGhUSTdYaFcvVmhJ?=
 =?utf-8?B?dVp3UE5LOEpuendUVS9aazNmQlB3U3ZRbytMc2hHMytEWVdENzVTUFRYb2V5?=
 =?utf-8?B?ZHBpRDcxbzFQRk1RZXZpWm5LTis1eVVicnllVFdrWnRZU3doQnVzYUo5Qkgz?=
 =?utf-8?B?WXRKdGtxUHM3WkNxQmE3U3lKNTlienRJQm1VSkVIVFp2SnliTnJLSk9LUFU1?=
 =?utf-8?B?SmFaWmJOM1VUTEppV1VFazEzYzFQeEtkUzBra29GcXRCMjZScUZEaTd3aEg1?=
 =?utf-8?B?QXVNUTNoVUx2ZzdtVVRsMkhnTUVJWUl3Y3BjUkhnanVyM2VRN0s4VDV5Q3BN?=
 =?utf-8?B?VkMwdHl3VnNkVE0wQ1RGRDBZTXIrckV0aVBVdEhlQ2lJNE1lQnJsb2RWaFdU?=
 =?utf-8?B?ODczdVhwT2NoWm1FRm43SitxbEN6cktMNXVhNWxGaDVFdTh3Z0xIUUxwZUMy?=
 =?utf-8?B?T1RLZVdCMGdBdmZ3UEl4Mk5sV3F3WEU3bG1hRmhoR294TXRzQ0FnK3l6WEQw?=
 =?utf-8?B?SVlaRWZCL09iN2tlYjErOEVHbFdGdDN0Ky9HY1JMcitQdm9WU0g4S0hUVWxQ?=
 =?utf-8?B?ZEpRdXIza2U3MTlzQVJrTThWY2lVek14TlFuMTVHYWF0STZJNVplVjRFb3lP?=
 =?utf-8?B?WG5oNDQ1Vy9jK0VsMkxWd2c4V3Y3M084S2tVdjd4blA2ZUtDbzB5WE83Q2ta?=
 =?utf-8?B?NTRnNjlBUlJ3bVdzMm43aDVaZDlObHEya3IyRHFZVE04dFh0amhDU2QrVit2?=
 =?utf-8?B?QUpCM29lWE1UZmtrSmNkR1dUNHNHV3lpS2x1OTlZRUdRUE9nWU4zTVlXRTdn?=
 =?utf-8?B?ZTlYOXcyNXdMVzB2cVBxdERCM2tSWnE1c0dVS2xOTDBTMGYrcEg2Z1V6am1R?=
 =?utf-8?B?VTNRSTA2Wis1NlNHYThQMVVFVG90UmozNEhFYWVrRDJvUkJlUHB5NllsY2VG?=
 =?utf-8?B?bENQUzVveThuV2tBdHhRVlM0WnhDeDFIODNjSjZJOG4raEpUaTZQVHljZjdl?=
 =?utf-8?B?SVJhRmlsMVJ5dGM4QzdFMmg2Z2pyR0NLZ1lOVHdXNG9jZGREV2YwbGVUS3Nv?=
 =?utf-8?B?QnVoa1hRbWkyWE9aaWVpRTZlcmxHWStVbjJGTHpDd1pqSXlhcHpWRTZZNUJL?=
 =?utf-8?B?U3pMOXdLUFQxbzkyVWJLcDFZY0I2alNpeVErclhkZDNJcnRJczN1azlJS1NO?=
 =?utf-8?B?QUJXOGltemhGbGVFaFg4SkZ4RnFDbkNOcEc5M1ZTZTg2U2E4aVRBRzlVb29P?=
 =?utf-8?B?WlBjREhNc0xUQUo1NThuVFh2bUFVU1k4V1ZCeU42Skttc0s0TkR2MGZCSU5V?=
 =?utf-8?B?bE1WRXJtZXNhLzF6K2pDMjhsM3IrK1pObFREeTVJRUJjcGp3RVI1NUd0clRs?=
 =?utf-8?B?bGs2SWZydVlZOGJVU1k1aE1ZZEJsR2hnczRQM0ZEQy9WSDRUZUd6MUY2eUVs?=
 =?utf-8?B?eVdUcHhmVWpaVGQ1ZkQzam1jMDRQUUFsUVpPUU8zM3VNamlTamFENE9BOHlm?=
 =?utf-8?Q?cogUBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNVL0NDalpvVy8xaU1oK1BkR2lXMGxmSEdMZTZRMnc3UTRHaFZWWEhNY0hj?=
 =?utf-8?B?dlNDdW4rWmVBa1RrMlNmTkdvOHk2MDUwZGM2TUZTeU1CSnNKVGhyTnZZdFJa?=
 =?utf-8?B?UEhGZkRCQ2FUcnRrY0JqY1czTkkrVHRua1UxOFJWK21xQ08vSVJnNWRzS2lM?=
 =?utf-8?B?UWFLcjV5bHhJQ0JwckJHdmpFTFlocVRNeEJ2cWJmNkdBNHB0Rnd5Zlp2N1ZS?=
 =?utf-8?B?VFhzN2hnWnRWUVFzYzM5bnAvLzdLZTYyTmw5SStDZHMwWUMrTmhXU1k3dVhG?=
 =?utf-8?B?S2RPai9vUDJEQ3g2cmZubEg2bHBQeWZFQ2liQzd0L3RyeXdkbXUwTU92Z0p1?=
 =?utf-8?B?SDdqUlQ4WTI3eG5lQnc2NStZWjYzRWxUcHBFVE9MWlJOWDJTRTNYaVlYOS81?=
 =?utf-8?B?K2U4WmY2eUY0TmFFVk1IUkVsaEcvWE1NYUFXT2dRNFRmK1pxTkw0cDVrOWVZ?=
 =?utf-8?B?YlRZVlluOEMza1ovZEdVU0tyUkYycVVOSUFFVjRHN2JQWHNKVXU0aFhuVGJi?=
 =?utf-8?B?K2tpSWxTVEFsNnA3RkRtN2t4TnJoWkdZSFVoTUp3dFFWVkQydStTelBGMFJF?=
 =?utf-8?B?cjgxY0d3ZnBXRk1QbURMQVJWUC9nU1gzQVNaRXc2dVBSM2hSRllPbXpYeU0x?=
 =?utf-8?B?WDkxRTdtdXp0R1FZMXk0TTM2VjFXUkVHMzBwMDlFTGV6TjdnUVo5a2ZmMXBM?=
 =?utf-8?B?SWJoeHJtZ0VIa2drdHVnVVc3cnR1amNKK1lZcVZOQzI2Nml2VEFBVDIrQjN4?=
 =?utf-8?B?QkdtYUJ2Q1JVWTBSVzdvZ01jNHpnSU8rcXNoZnJ6ZEV6ak5iQ3RIWkcxNWxh?=
 =?utf-8?B?OTNxY2FiWlArdDhlKzZ5TTJGVjQ4dTBON2h1amZGR25FVDRMNmxwSXZtNWVm?=
 =?utf-8?B?WjkxMDN2eG1aOFN3SWZCZGZ4Z2NEc1Zoekphd2tFalI3dlVzMDBhV2NOS3Zz?=
 =?utf-8?B?d2JkQzFNSnJNUTREc1JpMmloVXFldnJQZ1NRWjNFeHlxRWtEUGN4TnR1Q0Jj?=
 =?utf-8?B?SFRYUEI1R3VMNFdDZUVlUUhUc2tDNTNacTU3TG5Bc1dDejM1c2RSWFBYSXh2?=
 =?utf-8?B?WVdsMWpISFNYSGU0N0k1bjNGSWd2SU5LSlNWME9RdUV6SVE3M1lpVTVBb0p6?=
 =?utf-8?B?RS9IWkp2Ty9zN0NFeE5Vc1lEWEdSdW83ajNGQWtlM2J5YlpCeVZGaUdaRGcz?=
 =?utf-8?B?ck5DWG41U1NIbDhpQTkrOGpDQTJvYjhBRmZCM1l4dWlUQzJjbytrVm5FSnB5?=
 =?utf-8?B?YmQ5ei9UYkVOVUN2UFNsSHVRWjFQTEIyQ2d4Ni9mZzJ0S0prOVFObE9sQjJh?=
 =?utf-8?B?T2NCbVRhSWhKdExrdWlOTWdFM3lmdWFRM05PNTMvVWRnOGxSejJVdTNWdHZE?=
 =?utf-8?B?MUpkamtvejZsdGdRSVNjQll4Um1MYTVwWnB1RzZGL2dWN3A4TTQvdEwrd0Vu?=
 =?utf-8?B?RjA0T2ZraXVjZzBuNVF1MjlkbmZPRGlwK25kMEE4RW5YTDd4RDZnVXBCR3dx?=
 =?utf-8?B?TFg2cjRZeEJtT3I0WEZoMC8vVzVIVGs2RlloU1hqNHNCZHNxVGRBdURtTytI?=
 =?utf-8?B?WHcvM0k0QkQrSTA2QVUwbUxjdk1VeE5tOHRyYy9iZjYxVUtZTm1ML0lkMXl2?=
 =?utf-8?B?NXJhZGxsRVExUHFFY0c0RHNZWlV0Y0VHUXdnaXhRYXFYSjJHRGlGS0N0eDV5?=
 =?utf-8?B?Wnc2RU9pMVpnRnJCc1lZRG8vQ29HOW1nS0w2REVHNk5lMmcwa0QyQ0E1dUw0?=
 =?utf-8?B?NW1LY1NoRStBMHAzVnZpNURRdzRSQ3preU13ajZJS0hRTUZYeDJDalFEUUNu?=
 =?utf-8?B?RWNNVm1tVHR2M2R3UndiNVlrK2hWdkQ4K3B2T0hUc00zS0h1WnhLN3NuV0ZI?=
 =?utf-8?B?RXhBV3NrV1NvdWVVTmhXTERma1phbXYvZkdRNDdkUENnbjZsUTljaUdtTGpG?=
 =?utf-8?B?Z0hNR1JzbmtqMVNUam5hRlJrQWY5U25ZYWt3UkVmVnlGQW1vOGZNeW1pVm5n?=
 =?utf-8?B?UnVtQ1pYU3lRNjlDQUx3bU90MExNeGRpa3JwRzQzVDJnZGIzL3lQYXkraEZP?=
 =?utf-8?B?azlYYk05SnlXQ2dYbkgyTVJ2YUY0MnYrU0t5KytrdHAyYUtzanh5NERzTXdN?=
 =?utf-8?Q?7sGVollUiwW3GOlzXiyR3Obdw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbb62bc-be4f-48cc-29a3-08de39854f37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 13:49:45.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivJGSAjm62eajVIfhlCl4FgqjMQrPHZKZMEv/VnOxCk1JRPc+F6HGFkIMd0aFRMvy6ejhSM2zkoZh1BPunOYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

On 12/12/25 7:19 AM, Thorsten Leemhuis wrote:
> On 12/9/25 16:50, Péter Bohner wrote:
>> note: reverting ded77c1209169bd40996caf5c5dfe1a228a587ab fixes the issue
>> on the latest 6.12.y (6.12.61) tag.
> 
> That is 1788ef30725da5 ("drm/amd/display: Fix pbn to kbps Conversion")
> [v6.18-rc7, v6.17.10, v6.12.60 (ded77c1209169b)] – and Mario (now among
> the recipients) submitted a patch to revert in in mainline:
> 
> [PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
> https://lore.kernel.org/all/20251209171810.2514240-1-mario.limonciello@amd.com/
> 
> But it has "Cc: stable@vger.kernel.org # 6.17+", so that revert won't
> make it to 6.12.y; I wonder if that is just an accident or if there is
> some good reason for that.
> 
> Ciao, Thorsten

It is just I didn't realize that it backported to 6.12.y.

So after this lands can you manually apply it there too?


