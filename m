Return-Path: <stable+bounces-88188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BB9B0C58
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648FE2851C3
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE131E501B;
	Fri, 25 Oct 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k+W6wuL0"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B227800
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879093; cv=fail; b=j7LlniAfmJs0mcsBvEIQrqI+xENcLOFgUIhR0mo/0jn74+GU1qBi/RT11gZr5NrOSeB98EabOAiHpPTZORj5qCMeCmguH4DQuAOMPCZXHJ/rnt36b5gJ3dlEwQbXVhQ1popLNP3l57MaPPbjSblzr8Ez1MQ4/JVwWYD/lqoorA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879093; c=relaxed/simple;
	bh=WFsEqtZKCUVz7PKS8KUFh6pIriSmMDx5gNwq85EHdl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=La86FgXorbuuY0J80UiDVJpsd4Vha2gfw0zG4T2H7w4LLuHP9bVMqtI2SQIw0awU94koCIBLNpvHDmmSqKGUWln5e4gIoaZQ4pkg0pHA946GTHx3kKns0U83H2ftxUIX+lxwOu0a1GE/AATm2wnbZYsfOvNB+oHvF6wgNp4/FY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k+W6wuL0; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSi7N5pNYZGsNger2JacPnpGjyxvZwSZ8RkSPbb8HbUE2tiwkAIChAjj2u7QN1ScxBqJab8WU7gv+oUz8dcAcM5vgmGFvtitpe+Nuw+ONO4lQ/fAQcCOgUUOSqpuEfePAtPutDu0Qyaee7kdIM0e2loAZmcfDitrysw4y5p2AJ96S9d1zB8fDywHvQogpDx7k13j8tiwWNYpvfke6Cqm6PDOK50q122gfK3Xp9aEVYIHoubRV3a54YC0RIwR4oX07ycnfM1jCd+6OklelI6sLtPPD/lUmckmTpcAv9YbgZ/rtRvfY8EXUYA0lCI+jCIY+VKkkGjigGeprJMeZhBZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nCixOH1JMwAY9d0rRVWS9QyRVFihoysY2pFtyD3Y5U=;
 b=u7JcA2X1XakorOaWJKlhxEzKgMuFiBScTGQq4QPz8jGYuwQNTprKutWLlY6icmFZgTczrJPIESyTKK9R6rXL95hS7JRUWUbU17vdtyW7oVhLv91skCG9xC7qkQj/srWBpfVExhW9/HRLHTy77gWeu5e1iD5v2akdKWNZGROcLrDTa6DLFHDykbdM0M9qWzWv3mFc1R1uf426DLIGIaDR5qG2zbNsHMEBx8D9pyK1arw97sX+V7n2DLIRdoOKQ8tiYDb3UkvcWiWRNcl5qVUKUJC92kSH6jy5WITgSylYQhAkApYFIdGBG0A6g7hcoIPKaybn4ye5YnOSzOYRF2Lpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nCixOH1JMwAY9d0rRVWS9QyRVFihoysY2pFtyD3Y5U=;
 b=k+W6wuL0m6wFLstHpSL1fjBsfBpchA9BgnBdoXtPNb0oundaiyRxsxQrCS/xkMvfZecuxHBQl8zV36XlKENvWVvFZXyGyBaQs0H/b8e0aJeTkXJMB6VR3s/puXbzbtgqAIan+ljNEBNA6JePrQyFvhygjwML8z/O9RiaFN6BvRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 17:58:08 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 17:58:08 +0000
Message-ID: <596b2c1f-ea2b-4cef-81d9-5d2c9875282e@amd.com>
Date: Fri, 25 Oct 2024 12:58:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Vangogh: Fix kernel memory out of bounds
 write
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Evan Quan <evan.quan@amd.com>,
 Wenyou Yang <WenYou.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org
References: <20241025141526.18572-1-tursulin@igalia.com>
 <9323eaf1-d5c1-4153-bd5e-1bc12a4b0bc8@amd.com>
 <7bb9d58b-0718-41ec-8043-95cb7be9ac43@igalia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7bb9d58b-0718-41ec-8043-95cb7be9ac43@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 146411ec-dc11-47b7-ae29-08dcf51e950c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZFb29SSXNOTlU3clM5Z0o4QWVjb1M0d1lSUXF5L0N6c3k2RmZrMlVGM2N2?=
 =?utf-8?B?d010SWxjUldCeXBBQTlNREczNkNSMkg3OWMycTBhajVtWmRubVZEZ3pTNXRs?=
 =?utf-8?B?VUhPTW5CU3NBWlF4YVhJSWxUd0dOcmY3dkRIeE5vaG9jOGJ6U0xjb05tcG1O?=
 =?utf-8?B?MHA3M0t3MktBWExzOVVSZzdvR29aVHh2YzFUZlZTWVlZS1doL0lHdUMrdlhp?=
 =?utf-8?B?cStXQnhiYmNQSmZ0Lzh6bmIzbTlwemhLR0dGMFZPQTFCUVFNeHkvR0dRRElF?=
 =?utf-8?B?Zk56bEw2aU1tdWNGeUJxdVFIYzZFSlRIY0NEU3dqM0FaOWtvOThqNXZXcnFQ?=
 =?utf-8?B?ZVI0RGFtekNyWFR6aTl3aE5ZL25nQUhUNVRkakxoMDhLY293UXIrZUp6MXdS?=
 =?utf-8?B?UzI3K3BLQXkrMTd6NFdxMUw2YnMvM2VFOGdkSkpWRGRlZ1FQTWMrTU9PSHVr?=
 =?utf-8?B?T1RZMFJtTmlxQkU4WkJjNXdOZGg4V0RaY3NmR25DdWQwQU5VQlFpcVdNQ1V4?=
 =?utf-8?B?QWtkcHk2NlhyTnBKMTBvMVdvNDhnUmI0WmkwMU9lMXVyU3lkUXpKazBjRnRS?=
 =?utf-8?B?V2g1UUpZYW56Y3d1QXRnMFdKQnU1dENlcnNZOGJpR2lGYXhoREhmOEwrb3VQ?=
 =?utf-8?B?TjdCaEk3eWp5QmJlYThBa3hiRjNBVGxSaE81Q3ZUUmlaM3dZa2ZDdWlUeFpN?=
 =?utf-8?B?N0d6d2VhQUl6YWhXSVBDWWV0R2Q2RmRIejBjcUZPTi93eEp1a0gyWG1uZER5?=
 =?utf-8?B?NThlSm5Ua2NnSWRoUFY4K0gvbXFnZE5KWExOcnprMlFlYzI4dm9SbGxLdmhG?=
 =?utf-8?B?djB0WkFQTmJZS00vMFhqZUU1T2xLRUFVcExXWDNnN2JVbDlyemxScFpWQ3Nq?=
 =?utf-8?B?bFliaE9vbXBqNEFMV3NtYUdPVktHWjFNYXpxNVJSK3ZZM3dWT3E0bzU4dVIv?=
 =?utf-8?B?ekpudzBrRlMrT1ZzeGFIWmw2RTF6aWhUeVpnbnVpTkNJNitPZm9oYlBpKytw?=
 =?utf-8?B?SURYRVpQdlpVNEo1MWZCWFBWampwTlUzbjJxTklLb1NBL2p6SjFjalBhNW40?=
 =?utf-8?B?NHhQOTJOQytWRGdDYnhQalltckpYTG5obVJuUTV5NWwrZVIrZkxoV0NmODRx?=
 =?utf-8?B?WEdPZmZ5dzF6cmFtdWhKQTlpTHdwb2NaUVZJVzJxM2E3YWFueUdKaHpBckxw?=
 =?utf-8?B?LzZEOFl3WDRBY0JqZVhvNTIyMHFhcXFCcW11VlVhdTdBMS9FUzUreXVFS0Fl?=
 =?utf-8?B?N21VVU9lZE5oRlc4VkxUOWV2SXlRNEhoRkFweHhOQ3k1K1F2V1lVd3hFSkg2?=
 =?utf-8?B?cmtDN0N2R0VCL2tmMWRmTlJBdG8vclN5MFFDbDVFZjIrQ3BHNkdUOWxXd0lu?=
 =?utf-8?B?UThOM0RpcVNtbjdWRWNWS2FSUFNLZ3U5VkZXMFZ1aU9veE04ZjZiSEFYYTcw?=
 =?utf-8?B?cEdYMC9wWXAyM2Z0bFV6OFcvRkUzbnJBMTlKQnlPaUhXa05DdC9sUTQ0N0o3?=
 =?utf-8?B?ZTRMZVpqVE5iWkZrQ3ZrTGR3d3h0MkQvL0dMT2R4QTFXSDNQNmttazV2L3Z5?=
 =?utf-8?B?Ky9DRXZxbVAzc2VuKzBIV3JjY3Z5UCtqSDBadU00bmJGcHNBQ3Ryc3V0YkVH?=
 =?utf-8?B?TWZtb05CZjF4dVdBQkVhdkw1MXlPUTJ0YWpRRkdYQnI1d2hUeFBzcEx5SnlK?=
 =?utf-8?B?bUtlTW9Hb01pSFZRTDlLclJFVjBLRStxMkdtUTlrREhBUkp5RzhPUG1aNHow?=
 =?utf-8?Q?gkdfBAJ9pD9/Qll2l6DJgP0XVur42EKWdNZaasX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNhYlMxQld2RTN2UUlSalVRVWZXVjVOQVB1RC85OGxPSmhSWnAxdnBBRUJK?=
 =?utf-8?B?bGhpSy82bUlUVUhJdWtXR05FaVlWVy94TFNsMHkwWnNwRU11aE9CM2JkY2lV?=
 =?utf-8?B?U2NPeS9MWlZqZ2NmNUk0RVlLc3JDajV6SWcrUTF5aVVjT213cytvcTUwUDMz?=
 =?utf-8?B?TUptTE5peVpwdVNEeDBXbjduc0l5T2lqRFdWL3poWXcwYllUTVdmR0hNb1lk?=
 =?utf-8?B?TkQ5RUVkK2gwZWZwR2Eyd3Z5Y0YvMW9Fa2hTQ25lZmxIdXArejBSSVE0SUZo?=
 =?utf-8?B?R2RzeWk1MXkyL29NUmI1T3hVV241VjVyNVhKait0RjlpSFRZNGQwQ3dBaEVV?=
 =?utf-8?B?aHhIbUkxdmxxcnFFQ3dtWk9iTVg2T3ErY0NMa0pjeGFIRHRURXN6Yk5RcHMv?=
 =?utf-8?B?aUN4S1kvKzEvYVo3eDV1UGYrR1ZrVDdtUXVnSzh5T09nYTBrTXltMjIydjhE?=
 =?utf-8?B?Mk9GdlRpYUtTb25SeW9YeEUrRkF4amlqQ2JRNzlBNVVIQXdHZkFqVEd3dm9t?=
 =?utf-8?B?TXcxa3Zsd3hIMGNEbzV4a3RFQXFoKzN3YVpDamVONTV6WmZkMzlEa1huK2xU?=
 =?utf-8?B?aGJGVU15SnZXM0pIMUY0TkJIMXN1TVBvbnlYektCUlIrL1U1a2ZnVGRMV3BT?=
 =?utf-8?B?SmNVcWs3VEtNWHZQUVRlMU1iN1lueE9MRTI4RVFzZm82WjMzVFlkQTU0WjJF?=
 =?utf-8?B?OWt4ODhuYVRNQWVvalhLRmJVT1JJSEJrRGMrQ2wvWHBEUFZyUldTU2lRMVRq?=
 =?utf-8?B?M2V3eHNtb3h0Ty93QnM5NDV0bTArcVRkcWh0Q3lMeTNpbDNQNEg5bEdhODVl?=
 =?utf-8?B?WVppOS9HNlRPR1FlTTZ4ZzJWNXpyWnRoWlVBaUVHS0k4Zi9WMDllcW5FMjFy?=
 =?utf-8?B?cE9FbkNYM3FNaFU1bzQ1MHlKZXphVkN0S3ZyaDBwV3l3ME5OeHJoa2o1YmFm?=
 =?utf-8?B?RklQM3VGNlZ2dUdFMkY5NkZlTTdrR3RLYzJoY3FZQWFSN29xb1BpVzZDTWlQ?=
 =?utf-8?B?MUVidWJFSCtjcnZyL0pwSWRPdklBSE9UVUtTaGo0YzkxVkhOT3JjV2R6OGR0?=
 =?utf-8?B?eGJFUEZIeG1rcSs3b2N4NXVjVGZlNlFDTFBnelhXWDlYdi85ektqUndIdUlx?=
 =?utf-8?B?ek5DWlNsbkpLYU1RQjdkWVdiLzdpUUZxR2dRczNQeGlUSjlzS1RrR3NTNlF3?=
 =?utf-8?B?T1ZuVkpVdGpHeTR5bHczRnFLcDRrSnY3SXlYUUFVQS82Wi9FNVVMQzJ6WTRt?=
 =?utf-8?B?L0pFQjI1ZUlLcVBqME1NZlVrMzl5NHFzVGVzRStZZTdaUlpJV25NL0FZUHBG?=
 =?utf-8?B?TXhtZ3UybE8yQTJUZzROUm12bE42cG5WdGhkaHJhalU2WGdKSVMwYkNod1NF?=
 =?utf-8?B?aVMrcHcyZk9TVTQva2QxZ1lOcXNIZGJUOExyckh4QWI0dXBJdVdhblhWdm9m?=
 =?utf-8?B?enF0cEFKRmRkd3FFYlByVi9YZVpZclZaNW8rNFZkbUxXRTJWVjF5SE8xWUNU?=
 =?utf-8?B?S2lCeFpEYWlzMlZVNlFHU0NBUktKekhHTUF1TzhDNFpyUTg5ZXA5NkFKNW5T?=
 =?utf-8?B?MkFWZ3Q0UENVS25vdUh2QkV2d0svSlVzaERnMFhNZk1uSkhoR2tLTytrM25Z?=
 =?utf-8?B?NDVjWE5hOEF0K3ltN2FreCs2L2ExMXFvak5MMjMzODlaV3ZRWURXTy9rTTc1?=
 =?utf-8?B?ZVB4aVpJYzB5K29uZGZnQlU4dVZWMmMyeDJrV29sUmNQdlFlQTk0eXpFV3Nz?=
 =?utf-8?B?OGhQKzhlSm53TUpNS2EwZXovS2pBNFZpWVVZWEJuY0hVQ0JFTmpoYXkvUVJ4?=
 =?utf-8?B?d0VocFViQnpCMzFpSWVlN1R5M3JBb1ZvMm1CWkVCc1M1TkZMY09XblRmYXRv?=
 =?utf-8?B?T24xRGUwU2RudFRHTkpyRG9tTk0wQUZpRncrVlBKOXBUZkVUMWdFSU9KQXl2?=
 =?utf-8?B?S0poZG83MERpSnUyVVNOL0s5VzBQb1JRM2hIemlRdDhiaE5kamVTVjNlSzBS?=
 =?utf-8?B?ZnlGQW1xcVJjL2NUdmtyeUNIZGNsZ0FPeFM0OGUvRjRIekM1ak9mNUhsVUV3?=
 =?utf-8?B?dTI0VEZkQTVKblJ0S2JkTnBqUTM2dnRjQWtXc0p4ZGQ4VVMrVjQ4Wk9GN2FT?=
 =?utf-8?Q?EJkM7K5jXU0/NLT2gPlhiOMZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146411ec-dc11-47b7-ae29-08dcf51e950c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:58:08.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ0oG4KsnTf1Htx0F/SMtQxojmAwUTYW9gACI4yOOKeZVpCZTkJHx7KhepElYB9aw3+WgiAfDgC3XXPhm7e51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On 10/25/2024 09:40, Tvrtko Ursulin wrote:
> 
> On 25/10/2024 15:23, Mario Limonciello wrote:
>> On 10/25/2024 09:15, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> KASAN reports that the GPU metrics table allocated in
>>> vangogh_tables_init() is not large enough for the memset done in
>>> smu_cmn_init_soft_gpu_metrics(). Condensed report follows:
>>>
>>> [   33.861314] BUG: KASAN: slab-out-of-bounds in 
>>> smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu]
>>> [   33.861799] Write of size 168 at addr ffff888129f59500 by task 
>>> mangoapp/1067
>>> ...
>>> [   33.861808] CPU: 6 UID: 1000 PID: 1067 Comm: mangoapp Tainted: 
>>> G        W          6.12.0-rc4 #356 
>>> 1a56f59a8b5182eeaf67eb7cb8b13594dd23b544
>>> [   33.861816] Tainted: [W]=WARN
>>> [   33.861818] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 
>>> 12/01/2023
>>> [   33.861822] Call Trace:
>>> [   33.861826]  <TASK>
>>> [   33.861829]  dump_stack_lvl+0x66/0x90
>>> [   33.861838]  print_report+0xce/0x620
>>> [   33.861853]  kasan_report+0xda/0x110
>>> [   33.862794]  kasan_check_range+0xfd/0x1a0
>>> [   33.862799]  __asan_memset+0x23/0x40
>>> [   33.862803]  smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu 
>>> 13b1bc364ec578808f676eba412c20eaab792779]
>>> [   33.863306]  vangogh_get_gpu_metrics_v2_4+0x123/0xad0 [amdgpu 
>>> 13b1bc364ec578808f676eba412c20eaab792779]
>>> [   33.864257]  vangogh_common_get_gpu_metrics+0xb0c/0xbc0 [amdgpu 
>>> 13b1bc364ec578808f676eba412c20eaab792779]
>>> [   33.865682]  amdgpu_dpm_get_gpu_metrics+0xcc/0x110 [amdgpu 
>>> 13b1bc364ec578808f676eba412c20eaab792779]
>>> [   33.866160]  amdgpu_get_gpu_metrics+0x154/0x2d0 [amdgpu 
>>> 13b1bc364ec578808f676eba412c20eaab792779]
>>> [   33.867135]  dev_attr_show+0x43/0xc0
>>> [   33.867147]  sysfs_kf_seq_show+0x1f1/0x3b0
>>> [   33.867155]  seq_read_iter+0x3f8/0x1140
>>> [   33.867173]  vfs_read+0x76c/0xc50
>>> [   33.867198]  ksys_read+0xfb/0x1d0
>>> [   33.867214]  do_syscall_64+0x90/0x160
>>> ...
>>> [   33.867353] Allocated by task 378 on cpu 7 at 22.794876s:
>>> [   33.867358]  kasan_save_stack+0x33/0x50
>>> [   33.867364]  kasan_save_track+0x17/0x60
>>> [   33.867367]  __kasan_kmalloc+0x87/0x90
>>> [   33.867371]  vangogh_init_smc_tables+0x3f9/0x840 [amdgpu]
>>> [   33.867835]  smu_sw_init+0xa32/0x1850 [amdgpu]
>>> [   33.868299]  amdgpu_device_init+0x467b/0x8d90 [amdgpu]
>>> [   33.868733]  amdgpu_driver_load_kms+0x19/0xf0 [amdgpu]
>>> [   33.869167]  amdgpu_pci_probe+0x2d6/0xcd0 [amdgpu]
>>> [   33.869608]  local_pci_probe+0xda/0x180
>>> [   33.869614]  pci_device_probe+0x43f/0x6b0
>>>
>>> Empirically we can confirm that the former allocates 152 bytes for the
>>> table, while the latter memsets the 168 large block.
>>>
>>> This is somewhat alleviated by the fact that allocation goes into a 192
>>> SLAB bucket, but then for v3_0 metrics the table grows to 264 bytes 
>>> which
>>> would definitely be a problem.
>>>
>>> Root cause appears that when GPU metrics tables for v2_4 parts were 
>>> added
>>> it was not considered to enlarge the table to fit.
>>>
>>> The fix in this patch is rather "brute force" and perhaps later 
>>> should be
>>> done in a smarter way, by extracting and consolidating the part 
>>> version to
>>> size logic to a common helper, instead of brute forcing the largest
>>> possible allocation. Nevertheless, for now this works and fixes the 
>>> out of
>>> bounds write.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: 41cec40bc9ba ("drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 
>>> to acquire gpu_metrics")
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: Evan Quan <evan.quan@amd.com>
>>> Cc: Wenyou Yang <WenYou.Yang@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: <stable@vger.kernel.org> # v6.6+
>>> ---
>>>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/ 
>>> drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index 22737b11b1bf..36f4a4651918 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -242,7 +242,10 @@ static int vangogh_tables_init(struct 
>>> smu_context *smu)
>>>           goto err0_out;
>>>       smu_table->metrics_time = 0;
>>> -    smu_table->gpu_metrics_table_size = max(sizeof(struct 
>>> gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
>>> +    smu_table->gpu_metrics_table_size = sizeof(struct 
>>> gpu_metrics_v2_2);
>>> +    smu_table->gpu_metrics_table_size = max(smu_table- 
>>> >gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
>>> +    smu_table->gpu_metrics_table_size = max(smu_table- 
>>> >gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
>>> +    smu_table->gpu_metrics_table_size = max(smu_table- 
>>> >gpu_metrics_table_size, sizeof(struct gpu_metrics_v3_0));
>>
>> AFAICT Van Gogh only supports 2.2, 2.3 or 2.4.  I don't think there is 
>> a need to compare to 3.0 to solve this bug this way.
> 
> Gotcha.
> 
>> But generally yeah moving the initialization to a helper that actually 
>> knows the size would be another way to solve this.
> 
> Yeah I was looking at smu_cmn_init_soft_gpu_metrics() and how it has the 
> data of how large table needs to be for each frev+crev combo. But didn't 
> go as far as trying to figure out if frev+crev would be available at 
> table allocation time.
> 
>> Or looking at it how about moving all the conditional code in 
>> vangogh_common_get_gpu_metrics() into vangogh_tables_init() and then 
>> assigning a vfunc for vangogh_common_get_gpu_metrics() to call?
> 
> I did not quite follow. Happy to work on it though and I can look into 
> it with fresh eyes but not next week, but the week after.
> 
> Or in the meantime if you want me to respin this fix just with v3_0 line 
> removed I can do that today.

Yeah thanks for the respin.

Regarding what my suggestion was let me try to explain it.

1. Whenever vangogh_common_get_gpu_metrics() is called it will go down 
into the functions to gather data that match either 2.2, 2.3 or 2.4 
based upon the platform firmware.
2. Instead of querying in vangogh_common_get_gpu_metrics(), there can be 
a function pointer that vangogh_common_get_gpu_metrics() calls to make 
it much simpler.
3. vangogh_tables_init() can then detect whether it's 2.2, 2.3, or 2.4
    instead.
    By doing it this way, you can allocate the exactly correct size
    structure when it's initialized and you can set that function pointer
    that vangogh_common_get_gpu_metrics() would use during init.


> 
> Regards,
> 
> Tvrtko
> 
>>>       smu_table->gpu_metrics_table = kzalloc(smu_table- 
>>> >gpu_metrics_table_size, GFP_KERNEL);
>>>       if (!smu_table->gpu_metrics_table)
>>>           goto err1_out;
>>


