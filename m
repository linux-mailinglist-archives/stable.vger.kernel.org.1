Return-Path: <stable+bounces-88185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18F9B0B4A
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C628A2A1
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A9226B8F;
	Fri, 25 Oct 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xov6/URv"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C276216DF1
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876585; cv=fail; b=FqqIVz1UXOFv7gD8poqTR2DAUywhXpW89K2sUOJf3dio4f/l9ltPKbXPwEtuUBuE26doy8gB2GOPJ2GGr0xS754C27Nlpe/Ex5V+G5tUOneUkzloWTyD3RkWblbq2GsTn2Vez+IbHf7/OU5X4ZXkY3GH86EIjzVfhrD6YJgq5Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876585; c=relaxed/simple;
	bh=9C2IO46K4xUg9pa4q/Y67ql1MYYgLypHAJXePYdGfxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0GFoY/SQ7Wrj4+KHx08TosvioBjBbad/YScFGuVYAdy54kjEJRDLfKX9VtAFyT5FFTkfts4gFSBrAk/2c1F5WPbbg5DB2JGHOvJ/DGlpmQIkmiv1oyk6/1dqQawDPMOmuyuMD+bAYuLUKPy0Ib++6ssDAlBjX/Wrg4Wewr+T4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xov6/URv; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYGhCgM4aWhxED6uxEqK5/+Pdtb73FjBG1emHTKut4fyTaDdvbjoSKn5+ntiQ5Hk9FcsK8723TtjvsM2tUnTZgn0BjC7QkwsbPfjfjAmzZObAOBVP3s/IVF/CX8RMLx7GiNZ8/kgrYIQPtiG9FQksEr7msqSzqw0W1UtB1DAiTxmTfPnp1xTB5P3wHl8Jq746OTBf5dbz9R56ZSYDi5U0JaNLbrBasa6RwlaeQwfjxZ6AlhKuX9QotguDNwsAZOAX4x36tlQhW3G1ZJdSt23nAKBJCTULqHVMFoiNgDVGjffWzDyHwJwvcSPo7cE3m+Dz8i5DWaCR6ns8dY8uGfdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZVX4s0dneSfLb01Yuy0vVq6MNMl30h6R0AI2ecuYoY=;
 b=bhYURt0rL4d+kRcBNjedPOBbTLPthF9YIcYQXGH9hhoReVStkjCQYhdgRmU86bQNnB9mCuDfB9BqpLSlkhbeJPppqPW58ifgxSdy8TVnnCr7y1R5whdQ+131FItfKeYmh0FVPswBjb9U1V9jzqOvJ0N17TWNrFQgdBQajPxu/Vb80wty61dHO9bXl5rfCxm640Iq7O67sMnaS+tUW3mYlJxLeyUQLT9l4C18ZKrG/oOMZlPitDjGzq1EiWII8qWfcy4st64Ics9dI6Dg6Ktw4meCdX1IcjvPBnpO8v2YSwE3OO+60nQVO8Bqut67zvv1C60fgITYDtH0GiTw90VStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZVX4s0dneSfLb01Yuy0vVq6MNMl30h6R0AI2ecuYoY=;
 b=xov6/URvNvru5THWXDG0X6r/Ww9HuBrIjyrQWfTWl/P8glam2Oh32vq/5dPzderRpm7TCwpRAOFFqfVGgypMsHOYomTezrIdjfOvQTBp27XKYRre53hgEkolAWkMQ8zvdm7FwPU3+959sNkIGrV2gA/RtSwu1IvVsa4lCo9K9zU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 17:16:18 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 17:16:18 +0000
Message-ID: <d8d55df5-a5c2-4460-9bd1-e6e7595edcf0@amd.com>
Date: Fri, 25 Oct 2024 12:16:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Vangogh: Fix kernel memory out of bounds
 write
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Evan Quan <evan.quan@amd.com>, Wenyou Yang <WenYou.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20241025145639.19124-1-tursulin@igalia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241025145639.19124-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:930:89::28) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e27ff8-018a-4d45-1f80-08dcf518bd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3A0L1NoY0xNNmJnTkxUQ1NmblF4WmJRUXAveDJMR3BJUGovTjlpSVZ3SEZl?=
 =?utf-8?B?OFBPTmpJRFJWZEhVQUJ6WFMwYjNvbjgyUWlpVEt5aGM2MkFXVjQvMjVOcmlY?=
 =?utf-8?B?d3FHUDYvV3VCVlF0cHNhckRSL1VHNU1ZQnNiaGNaWFZQMldtaTEzVWpwRUxU?=
 =?utf-8?B?YmczY1ZwL2Q3R0Ntakg0eXc5eHd6dkJxekJjbVZNSHExQkZIZzBrNFdGYUds?=
 =?utf-8?B?SFJZK1MyeEZ0MHFqRGxydjJVNFg5M05Ba3EvQVprZDNjeHR0bEJTY3Qwb3lB?=
 =?utf-8?B?QmduaVd0WGZSOWJHKzFVWENMZ0JhYUJ3VVNUd043RURFSEpPVXMrVG82Q1FU?=
 =?utf-8?B?SlZGVGtvZGRLekd1M3I4WFlRM0RFVlZLSGZMSjRoVTQ4eHF0aUxYT2JkZ3Zu?=
 =?utf-8?B?aW9hdGMwV2RLakRJZjhBMHdwTmh0bFBKSEtoNE1KRUlwcHFySkpVMlBzR0tn?=
 =?utf-8?B?Zk5Rd2NLUi9oOXRiRFErZXlXUVBOaDVKdCtzVWJkNXRBT1QzZGdJS3FzdU81?=
 =?utf-8?B?WWZlV0NDcHYweGlwVE4rWEE5OCtlRk10anVFUXcrYnNvR0IrYXlraEF1MHd2?=
 =?utf-8?B?NDBsVlN2QTFaQWk2R1ZkNTN2ZVV3N0pxZzYzWURRc1pOc3FQN3lUdmNVemdk?=
 =?utf-8?B?WERDcUtPaXJjSTl0MzhFaWxrRFlLb2F5Myt1VTdEUGJPc3I4NFI4bDFiNXRr?=
 =?utf-8?B?TXh6RnljZkp2V2lCY3ZZeUNmMTAzenZhQnErN2NGa0RKZWdieDVhNVVHK05F?=
 =?utf-8?B?M25BNFNLNDFYWEx0M0wxejFadmdkeWNtTmJBbElUWElDcmJodWNpSFV4NGY2?=
 =?utf-8?B?WXFNTTBOT04wMnQvQXVCR29MdDJLMjM4em9sbHFKS0JpRWNhdDFzeG1XcGUr?=
 =?utf-8?B?TFVzVGR4MHJ0R2ZNdWFzNGVxbmFFdmx3NHI4SVFObzliNGRFc0s1ck1QUGRP?=
 =?utf-8?B?SjZ3ZElaWW12TCtUbHZhZGJFTFB4WXprYjUvcUZLaUhvdHF6b3NPSWl1clpz?=
 =?utf-8?B?R3JjTW9HWWJFVjd0R3BxM2VFbFZiZmlPb2o1emU0SlF1NWtveGdyTTJERkw2?=
 =?utf-8?B?WDkvYVRab01XZXRGcmxjK3FkK0VlQmhWMUR4Q1pxaWRaRldVdTZ6YTZoSi85?=
 =?utf-8?B?aUt5U0pvOGc5YlNIdmg2bk5Od2JscWk1Rnp1UzduTVVqSUhnNyszWlVjZUJM?=
 =?utf-8?B?SHRWVWdIRVQyd3J3WnpMVHNUc2cySFFMdEVrMDFFb3p4OTBWbzZNRWpkdHpj?=
 =?utf-8?B?dFF3TlFIRnVxM3hrVlNwa3FMb2tlMkowMVlLZStaR1N0VGtDQzFiVDBlWlJn?=
 =?utf-8?B?UXA4enFJTUdJWERQU2hUWnA0bnF4QkNmL0o5YzhsY1BVc1VPOVFsTmppaVJC?=
 =?utf-8?B?NzVwazZJTEc2UUc0SXp0NHZQdE42ditNWDdJNlQrUnQrc0l1aFd5VlN6WWhN?=
 =?utf-8?B?YzdMVTEzM2M2QytiNDlBZWR6MDArMHlkbVRvbkZ2VVZzNGRmdTQwK3Nucm00?=
 =?utf-8?B?UllpVDV1bEtsVmd6WWFlcXBRQUZGcmxpOGYyZHNUWG0yaFF1S2dLVWRHU3J5?=
 =?utf-8?B?YTBaQk1OUUdOQVBaSVFqcDJiWlgwSERkTWFCSUJwSnBvUTlqQTRzbnFsOHZ1?=
 =?utf-8?B?dndUNXYyUjFKMDN3WHhsbHFhenpsK3FEY29Vdkt6R081NTliR3JBeUt0WjZF?=
 =?utf-8?B?MHNucndxR2Nzd1dvTi9YZXd5U3FHOXRlWi9JamRocWxGcnBoVUk4SkNvYnRw?=
 =?utf-8?Q?b3rY6fJwMDezsSYYzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODlnVWFNUE1xY1BPSVFNcjRiY2tEYVhHTm1hcU5jL2FQWjIzMFBjWXFqbVV5?=
 =?utf-8?B?M1BsdjFYYzdDYW4vOGNiTGhiRkZET1dpQ0NvRy9nNVJOMUlmZi8wRnV6WU5v?=
 =?utf-8?B?ZXJlMnJwWWRCNWgzQlJXYmljcE9ra3p4RUZwVis1eCt6dVdaMm9EL0VOOHN2?=
 =?utf-8?B?MDRNbVRVMW44TUxMVytSR0lLOTdqSjRwbUlGVU83SWxLTmtFTFlaeCtGSE9y?=
 =?utf-8?B?QStaV3ZRbGdocnN5MlZPU2RGM3ROb1ptYjd4NC9DN0xjNVJYY2UyTUdCSHNv?=
 =?utf-8?B?ZEhmOTB6SU83RmhIZm1nTUFQN2lHV3M2K1hXTDNxdDNPMjlCREgrR09TamI3?=
 =?utf-8?B?dlF5VGVDbkd3bTNmSFBRcVpjeWprZ25CRHdER2plUUdlemRKSEsveVprTjh3?=
 =?utf-8?B?YVh1VWFKR3FOZlN2OXhMMDdFTkZGQ3h3anRob3I2MG9POGtFRU5qclVPU0dU?=
 =?utf-8?B?eGZxUVBRaXpwU0pXT2NyV0FTdVlQK2hnazlQc0hwUHJ0MHBuR2c0K291VitB?=
 =?utf-8?B?Wm5sbEpHeHFYaG5paWo3bjJHSzRocWx4K3NXVmZOb0Q4VkFpM2RpbmYxcVJL?=
 =?utf-8?B?ZU9MeEJPRldWTk9aUUZIZ01kZ3Ftb2tld2dWNEMzdmdtcllQc2FZWXBRZm92?=
 =?utf-8?B?MUJrdXdKbmU5NVVINHBDbGsySnNPek5FbmZYWTlTekREVEpPdGJQZWVJWWt0?=
 =?utf-8?B?L05reTFtSWp5cU1VaTluamhrL1cvRXpKZGU2Ylk5R2lFNitXSzJKN2FqZm1M?=
 =?utf-8?B?N3dob3BOSmh0UlN3MUZkeEQxbDNUa1h2a3oySllHV1VYOEN3RjA3ZGN2RFpj?=
 =?utf-8?B?WDdoWVllZGRYNVdZM0tNWGk2S0lMUUFlOEZHUVFkQnJmSUdVVEJGQ09iMy9B?=
 =?utf-8?B?OVp2Q0orekhibHpXWUtINjZTL2JYS3pKRVB2K0kvYmlOUzc1ZXVYMXMrMkgw?=
 =?utf-8?B?cWNRUWtPWWM2WFlOaENBUEhsUEdlZU1JMGhCaWUrd1dPbEJuT1dXb293R2FK?=
 =?utf-8?B?aFMrL1J4RnM4bzFhaUlZVUxQTlV5VGpLVzBaWmxUTUFxcUVhV1FmaGo5WFQ5?=
 =?utf-8?B?bmlLZG9NRXVJL1RsbWdUMGlaR09DTlA2eG13RTRSMW40OG1yVHh1Q0FSNmpH?=
 =?utf-8?B?WnRFeDFiSFZPYnFQTTJGRXEyalc0ZDRCb1ozYWo1Mzk5QUlicHp4VGRoQUlx?=
 =?utf-8?B?RmZtcGF1N1l6aWJSNER4YVJyYTZLbE5UOWJ4aUx2dGt4U2VjRFVrZ2x3c09D?=
 =?utf-8?B?ZnZ2KzU0M08rQVBhMUtPODF1OVk1ZUk4NkpYVWY3WVI4Ynp2ckk1TjRRRi80?=
 =?utf-8?B?dlN5OC9aS01EcEJsOUlqS1prVit4OFNoYmNCTkwrSjJISUJEeDhsTmxkZXhG?=
 =?utf-8?B?YW1SWDhGdmhHZGZwLzVFbUtEOWVwRkhxMHpPbnV0NFhmb1FTaFpaR09TNnZ6?=
 =?utf-8?B?TzZSeXNHZ29vS2pabjMzZFZqaWJvZkg3aVZ3TEpSb3NuZG5Ocm02cWlIYmdK?=
 =?utf-8?B?WWlIeDFLLzV2TTRuK3lNdnJOT0RPcHY3bUVJcFdFZ3VwalNCeWd1bnU0djln?=
 =?utf-8?B?UWxyb1BEa1hyd1ZwazhJMXVSRmdNd2RmQ3JJcTFiVkVnalpMc09HRUFld0Mx?=
 =?utf-8?B?azZLaUl5VTZ2Mlg4a2ZueGlnR0ZwWjBTUUhSTFA1Q2JkV1Zld2FyZUlEMVZE?=
 =?utf-8?B?SVY1UUJoMUQvVVN5VzB3QVA4cnYyRWRkSHBjN3laWDhITjVjVzNVc29RakVj?=
 =?utf-8?B?Uy93aUR2bk9STjNBRzErUlVVUllYbXFmaytrL24yZFVublVNMjUvL0ZQZGJK?=
 =?utf-8?B?NXlRMjVkLzRBczZMY3JyejVQOGlBcWhLc3RVMEp4Sy83b24weUh0RTZpK2dT?=
 =?utf-8?B?NmRTNHRESFV5Y1oyUjdzYVlUeXlGWGFoYWJjQnYxNTJXbnduRVJ0YnNCZmdM?=
 =?utf-8?B?Q1NxWjFXa1NxaHUweVZGVW5ZRFBvTG9FekRibkpMeUpNL1VrWlcxNVljd1ZG?=
 =?utf-8?B?TERHS3QvaTNJbE9PNCtFV1dTYXFrY21PaEp1UURxNE9xb203ZDV2eUxINEZj?=
 =?utf-8?B?Rmx1VmNaYjBuYm8rWkVBL1JqSFdtai94QlIzK2FINEJXcXVmMzVjaEhKYjN0?=
 =?utf-8?Q?AiMaVGC2iQufXTpNVEUFu4jCw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e27ff8-018a-4d45-1f80-08dcf518bd20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:16:18.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuIVWAhTZuixaoxArGWg52xSUyLld+d2dDQ/3hUtTTzK2SnxQncWBqsM5COJaNwgwsDD0iwH0KHD93Zv+tcZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

On 10/25/2024 09:56, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> KASAN reports that the GPU metrics table allocated in
> vangogh_tables_init() is not large enough for the memset done in
> smu_cmn_init_soft_gpu_metrics(). Condensed report follows:
> 
> [   33.861314] BUG: KASAN: slab-out-of-bounds in smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu]
> [   33.861799] Write of size 168 at addr ffff888129f59500 by task mangoapp/1067
> ...
> [   33.861808] CPU: 6 UID: 1000 PID: 1067 Comm: mangoapp Tainted: G        W          6.12.0-rc4 #356 1a56f59a8b5182eeaf67eb7cb8b13594dd23b544
> [   33.861816] Tainted: [W]=WARN
> [   33.861818] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 12/01/2023
> [   33.861822] Call Trace:
> [   33.861826]  <TASK>
> [   33.861829]  dump_stack_lvl+0x66/0x90
> [   33.861838]  print_report+0xce/0x620
> [   33.861853]  kasan_report+0xda/0x110
> [   33.862794]  kasan_check_range+0xfd/0x1a0
> [   33.862799]  __asan_memset+0x23/0x40
> [   33.862803]  smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.863306]  vangogh_get_gpu_metrics_v2_4+0x123/0xad0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.864257]  vangogh_common_get_gpu_metrics+0xb0c/0xbc0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.865682]  amdgpu_dpm_get_gpu_metrics+0xcc/0x110 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.866160]  amdgpu_get_gpu_metrics+0x154/0x2d0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.867135]  dev_attr_show+0x43/0xc0
> [   33.867147]  sysfs_kf_seq_show+0x1f1/0x3b0
> [   33.867155]  seq_read_iter+0x3f8/0x1140
> [   33.867173]  vfs_read+0x76c/0xc50
> [   33.867198]  ksys_read+0xfb/0x1d0
> [   33.867214]  do_syscall_64+0x90/0x160
> ...
> [   33.867353] Allocated by task 378 on cpu 7 at 22.794876s:
> [   33.867358]  kasan_save_stack+0x33/0x50
> [   33.867364]  kasan_save_track+0x17/0x60
> [   33.867367]  __kasan_kmalloc+0x87/0x90
> [   33.867371]  vangogh_init_smc_tables+0x3f9/0x840 [amdgpu]
> [   33.867835]  smu_sw_init+0xa32/0x1850 [amdgpu]
> [   33.868299]  amdgpu_device_init+0x467b/0x8d90 [amdgpu]
> [   33.868733]  amdgpu_driver_load_kms+0x19/0xf0 [amdgpu]
> [   33.869167]  amdgpu_pci_probe+0x2d6/0xcd0 [amdgpu]
> [   33.869608]  local_pci_probe+0xda/0x180
> [   33.869614]  pci_device_probe+0x43f/0x6b0
> 
> Empirically we can confirm that the former allocates 152 bytes for the
> table, while the latter memsets the 168 large block.
> 
> Root cause appears that when GPU metrics tables for v2_4 parts were added
> it was not considered to enlarge the table to fit.
> 
> The fix in this patch is rather "brute force" and perhaps later should be
> done in a smarter way, by extracting and consolidating the part version to
> size logic to a common helper, instead of brute forcing the largest
> possible allocation. Nevertheless, for now this works and fixes the out of
> bounds write.
> 
> v2:
>   * Drop impossible v3_0 case. (Mario)
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 41cec40bc9ba ("drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire gpu_metrics")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Wenyou Yang <WenYou.Yang@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: <stable@vger.kernel.org> # v6.6+

Thanks!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll apply it to amd-staging-drm-next.

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 22737b11b1bf..1fe020f1f4db 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -242,7 +242,9 @@ static int vangogh_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
> +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
> +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;


