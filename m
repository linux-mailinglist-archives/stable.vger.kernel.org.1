Return-Path: <stable+bounces-93026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73739C9010
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711AFB3F391
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841519F113;
	Thu, 14 Nov 2024 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlAUXFBb"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA53365
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599286; cv=fail; b=IVRleqUKSdTYPstGhmHiAK7/cRd2rfPg5mV3xTUg63rinl9NxeC7E1rP+XSbSqmnKH25MUGoXv0Y/SROPk7jFbyztKE0oo4CVtms9ppFd9ujF2+kd6XUaZRbCa71bNQnm3DbY6agIHNVOihM1pXRJ2C+Ij+ukk8uih5ni/mB5vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599286; c=relaxed/simple;
	bh=021ytTkt0HXeOAwLpsoQyrSRiVuGBcbryYKLSR8KfdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhhxeWAskXk8dIhyiphw2VGaFVrUNWC5JEJFqWb20soE5MTRWWTZjnFMIAQtiIrpjzTIc77FzH9cBMF4rFgzkxRfs6DMM4TxpQK3/M4fj72P0HKu75H7wtSFFkFORVVnPG5CzjCwfYV686qb+alouJYznBQaPgtZjurW84Id2jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlAUXFBb; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMl+4rWoVrkNSDCqOEJqegKwX0Z47ARbyPtKGNoOfKq184eHBJK8PgqGWLqDnGj+fliLvVepDGZbDEOTHBoqD8K2BnqU+h6vLxXBTZRBqo26jt2q5lQ58m7sX5MoYrEfZ8PAGYq4SwSub5xcOrcfEA9ucrFbY0J/t12Zxhcw6zBmzNuYPjBJuzPs6Ya+Gl3gbSCF1kIlzJ+7XEWndvFDFrWCYtDbELsBzAr/C+tsejRNHwFPwXEYhNdxFi6paM2fSyt7mrb5FodMGyJJWITuD/7C7/QVebS/LXdBHGYIqSQpNhxzABj6yB+uW9j2BC9S0i4aGJpGKpA+QL4/hLERDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMaB/RA+ZBBf68Fysi/89cxHlN1feGm+vejlkjvRhxU=;
 b=L3usOvERED94Iv2RlsRIvON5shrI7HjNFBSzuXqb/3dAWq16seSIfi2J/c7oqGsDzNnjtX7tQWxTgXcS72+beP+rQr5n3WgeMlbb8x824fQn3FtoBurD4+5fabh0XTLSPdD4bZK4bOwyOCvn4OjYVMURzcy8FFEC/e1l5zQhyg8eNuJ0Y0h81dFqCp9sF2ZojIy0ILPRQNR1w444xBZ12jUfjeQd9WvbSRYqeyVDpMYyGctj72XiE9XjlMYYAH8YzkqezN8jEA1xetbDXl/7mUbV/Rncl1cNCpNwdk7izyUjx1GcwH7Jh74iomNZZoWcojeuzpDqmNDP+LfZnAZ9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMaB/RA+ZBBf68Fysi/89cxHlN1feGm+vejlkjvRhxU=;
 b=QlAUXFBbjyWCINfYnUrk6Hqb9ZrJyRjPQ+0iCusUUMJThFsT0LtJPhQTixI0rAmu1ZGwzkc0QClcfTe5dPo7JSrH3lmhdRwyDbTnDDhYz9mMYQL5C2/4COaeFoYkaHYhbwngnXunPJwuDMHiZ3jUbYgkJDYjDfznPKJrFzhJ3HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 15:48:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 15:48:00 +0000
Message-ID: <e5aa5895-5a6f-4620-8537-dba03f91aeaa@amd.com>
Date: Thu, 14 Nov 2024 16:47:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
 <81849d7f-f1e9-4ace-af5a-7f36ab5f5c22@amd.com>
 <26165549-bb0c-4d6c-89b7-273648ff4512@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <26165549-bb0c-4d6c-89b7-273648ff4512@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3817dd-88f7-4d81-525f-08dd04c3b79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjkvYUxYUFpPcWI4UDdoMVVNTlV2bXZjeGdaYkt1TldENmhxSDd1OHRYQ2dO?=
 =?utf-8?B?YkdCY1RhbHMwcExmK3F3VE8wUk1Ua08vZ2p0OEx0ckR5NWRFdmhMbFpqTXM4?=
 =?utf-8?B?cmJLUXZESzh2VHBkMGJvRHUvcUMyUVk1emxKQnpHZ1NGWDR5QWd6NzJKNk54?=
 =?utf-8?B?UDJUd1gwMzdXbXpFeXBBMTA5NW5NUTRibWFVVTgxdjRhbnBldW9Qdlk3Rnpj?=
 =?utf-8?B?N09lVDZ4SVV1OG5yZUFYT1crbEdFV2VLN0c1TWRqZ2hRWTVZZXhRbDJZUzVr?=
 =?utf-8?B?TlZaUFRkL1pRakNWclNTYlRGMk5xSmQyWGVaWUw0NTRremZkMFJoN1p6eUNx?=
 =?utf-8?B?RThZV3F4S0JWSkNjMHplb1NnL3dVVE5vRFNlSVRvVWl2SHFqaFVoT2Izc3JL?=
 =?utf-8?B?Vit3WkRaY0R5NUZLTXBSMSsvNitsaGlWeG5LM1JiM01YVkFWallGVmprMnZ1?=
 =?utf-8?B?ZmZFQUJJQXVqTDAyT3B1V2h5d1cxUHJnN2JsOHUxa2svcWtqN3JjanlKdW1N?=
 =?utf-8?B?YlU4WC9raUQ1ZlV1cVhFejNvKzJYUklMWFpqSnRhcHJlWTJqaTdsRGhCYTRI?=
 =?utf-8?B?dmdMajZuVTltdHlyOWpyRXExME5kZmRTYTVWVXE0YVFOVGtUekFiTXZyMkdl?=
 =?utf-8?B?clp4N2NwS0JuSmdldGdES3JnQnVxaHhscEtTVXU5bHJzV01laUdkTVlySHVS?=
 =?utf-8?B?R2VRWGVKTy9UTTZmelVHQzJqMktmUEZZRHUyRUZ0djVmY3pjYXRQT25KNGx5?=
 =?utf-8?B?U1U3aHB1SGRIMXZVRldDcHoweGJWdDlLY2sxSm1ZcTlpTmRrcWpqamxuR0E0?=
 =?utf-8?B?NkdQVjBUR1hMNzQwRHltZm5NRlZqUDg5N2dPOVdjSEdjQlBXeWMxclcxV1Bn?=
 =?utf-8?B?L3RQV2JxbytmTVZGVTFSVHYxemVqVzBrNFlkNXNtMjc4MWYvN3U4cnFqMEtU?=
 =?utf-8?B?VXdIektreFNncVg3WmdIeW1SK2hmcnNzdlREMURZOExUR0JkWTFaMHNmWVAw?=
 =?utf-8?B?a2NWc2NhVHpJaXovaUFscGs5UGNUV3ZGc0dXeWJBUGZobEE5WGc2R3Z6cklQ?=
 =?utf-8?B?QnVya21YQXhydVMzeUlodFhDZkZ6WVE0a1dpTC92c0tkNUszK2JvZjUzQ3c2?=
 =?utf-8?B?T3JPTHdJZldncjlaRndodVJudmhRSnRpTU1yZGxidytHaUVjamwrWlFEZEF4?=
 =?utf-8?B?bkJLc2pnMzBkUThJS3lUcjZtTnpkQ3U2QUZVRTR2WU1PNWJScldpVVhDL1I5?=
 =?utf-8?B?bmMxOTBwekFnbzg3UGN2ZVE1WVVYYjRlME5kcVBzN2ZEeFd4eE9yMDljdUt6?=
 =?utf-8?B?OUhqOFFJYXdOVVBSdUZLSDc5L1MybDZqZVJQV2xIVE5lRm14a005cnJuVHU2?=
 =?utf-8?B?V2hpNVBsT1p0TE9RaS9UWTl5TndoT3hsQ1UzOGtPa2h5eVZEU0hrQ1FTcng3?=
 =?utf-8?B?Rm5may8rZXozYVpSU3hVM3dRbkVjUzVWcElGejJ0UGwrTXVZZFpRMGdIamJH?=
 =?utf-8?B?OW1nY2FvS1JrUEE5eis0bXV4ZVhBdk5pYVlXcWR1YzRLVVdjbDJ4TWovSWMv?=
 =?utf-8?B?Ym1jV0txTFZMZGFtdFJhTW5zYWh5VDM0UDJKMGs4VDBUSjRqTW5oM25yZXF0?=
 =?utf-8?B?N3NnbmlDRnAvejlUcENoY3pjRG1yT2FzNDE4ZFArTlptZnB6YnpUT1NYYVpC?=
 =?utf-8?B?Q0ZuUVE5TTMvcC9ZbVVwM2QrVmg1YUtMYlN2K0RHTlNTdlEvVDZhdG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtxcytJbS9uTHkxdVVwZDloNExxUEFLZ0VZTzlvSU1PSHBqTWVQQU1WK3ds?=
 =?utf-8?B?SHo0b0FJdnFTSDZPUE1GUC9jeGNTUk00UVZlNzhoampuMGs4dTZkWU02ak9B?=
 =?utf-8?B?RzR3TzNGNnBZMlgwaWphdEJhMXRPTUMzNmRSWHc3VUw2OFVxQmFyQ1Z6WE1G?=
 =?utf-8?B?R256Y1RJZFZTK3RUaUFHTU5mWHJmTTZHdzhmQW1zbno3N1JQcGRjVlJZNGpV?=
 =?utf-8?B?ZDFvOTgxMWk4TnNaVGlCeW14S2ZnVlR2QXNXcGM3dDZXL1dwYzZubTgwRTRG?=
 =?utf-8?B?TCtiUmRyMUJPYVM0Sk9YM016RE1zRXpnc0FNaDJIWE1WOUF4NkRIa051ZURn?=
 =?utf-8?B?cXVlMGtzWE1GbTlzMUFwUzN5Yk1EaU5TNmR4U2dObWRXRXk5WWRGdmhQRUta?=
 =?utf-8?B?Wk9iT2RwS3VONlR2SVUwc3BqR0hwMHJCUHNibEtHazBETFVYYlFlaGg4bnRR?=
 =?utf-8?B?Y2M5dkMwRmZZV1pleGZUclZWVjdSY1pLN1NaVURyeng3SWJva3lFY0FTbytN?=
 =?utf-8?B?M2JPaHlyNG9WR3Iyc1BXYTdmMVJWVURVLzcrT0JuQW9PM0lLUHFFb0xobkZa?=
 =?utf-8?B?UC9xQzVxUWwzWDlnaXllVHRCWkV1ZHJvUXEzSlBrQVRyNU1kY2QrWmhjd3Yy?=
 =?utf-8?B?eGliYk1BVVd3ZmpVbkFLYll3Vy9lK3hTdDNBVDBrMTNoeE5YV3lHWUovaFNF?=
 =?utf-8?B?VU4xT0RxQTAvVFRncnNNdXZpWW5va2FYWm9HREt3ZmIwTnUxV1phMlpSNTUr?=
 =?utf-8?B?V3FVVnB3R2dyVGs0Q1BzVHhIVVRDRVJOcm92K2RQQlBGOCtOTFEzblYwUGpB?=
 =?utf-8?B?YmxUZUxmMDZtdGxvZk9RZ1BqbGEvbHUrTTczblNLQjRXTTI1aXN1OXJXaEJB?=
 =?utf-8?B?dWJqNmdxcXViQzRnT2R2NlV3Rjh4dTF6RkRtNzdVVlVlbDdQOHlWd1JRU3F1?=
 =?utf-8?B?QlQxT3U3ekNDZzRHR3FkWS9lc0wwQTd1WEZBdE9SYkpoajlaOTl1bE1oa01S?=
 =?utf-8?B?KzJGRjBMczh6alF0MXozclBTelFXYVRlbG5zZTJ5Z0p4RjVsMExkbU9HeWhh?=
 =?utf-8?B?Q2pUMGJ4Zi9RelVBZXNkVzE5YjBwU2pLYnFOVlBuVjVqbGlld1lIbkNLUk5v?=
 =?utf-8?B?RDB1Ym03U0JiWlpGTTBUVURnYlNaRDNGaHVzdlRvZ1lwUFJuUThXS0VzNkZy?=
 =?utf-8?B?QlVrSjc3SFZPTEF4NVUzY0RRQVo4bmM4aExTNGlxUFFsWlI3YUtZYUJZQWJX?=
 =?utf-8?B?MTNyV3ZzYXpQaFdrS1NSR3hOcjhYWldtN2Vxckh0TDRIZjhjZ2lDOUN5OU5R?=
 =?utf-8?B?d3VCM2FrYzFDZ0JnTks4eW1HTExqUk04cTc4Y0IveFlnR1FBM0VWejFRcFN0?=
 =?utf-8?B?M0hhVVlwM3pqdGtBOWs4ZDBCbzRzNDIybDhqV1M0M1ltcytzdUNKQWVGRmNQ?=
 =?utf-8?B?YjhvMXFmZXo0L05qaG9HbFFkWTF6ZExGQ3NmWkFuZ09QTFQ5Q1hBdXQrQ2hP?=
 =?utf-8?B?TmpSeUh2R2x2OEJDUllSQXhzclprcUZsS003aE9aK3V5L0UvY1Bab2pVR1l5?=
 =?utf-8?B?L2kvSFl2MWtyeXNjOEJtaFhqb2FyMXRiSUJGckdxVjdTMEFMRHk2Ulo2aVBX?=
 =?utf-8?B?WTYwOW05LzBZcUpOWTNVV1hDS1hOWTVENVpMWGNOOGJrNTFvUUNqMFc4NjdG?=
 =?utf-8?B?NjJ0bGJnVTNmYzNTTUgrUStxMWY1WWhSME0zcTVmdEJwcVdkT1FjQWVOYitC?=
 =?utf-8?B?cXdqS3pUSEFyWDZ1SG5oYUZVTmlCcXNNTjMzcEt3YmlhMHZyWThNbmU1OFdS?=
 =?utf-8?B?c2gvamRBWHJWNmdFb2pDRm9XRGJERmxUbmFnYjlwK0dKTjQ5UU8zRG1yOW1a?=
 =?utf-8?B?cHEzVUpibFlJV1FpeS8zYW9JdkxkMVNwd1dXamxwWVRVM3c0Z1kvaXdTZHp6?=
 =?utf-8?B?aXgyd2pLWDM3Q2s0WDRlVWx4cUZDUXJLb052TVZGaGpQcDVwaks1L2V6Y1hW?=
 =?utf-8?B?c2hYbnFVQVpXSksvaUJHN2hMbUFqdUkwK1NMS3VFeWNOUVRDaW1CNkVSL0x0?=
 =?utf-8?B?TkxUWkFGZytzb2ZBQlBITHBQZHh4U2RJbFVXcGFpVVRHWjYzRTEyY0pHYVow?=
 =?utf-8?Q?oO1HhUuKPdRHIvblr/oQxbm7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3817dd-88f7-4d81-525f-08dd04c3b79b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:48:00.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5662RigzixxZOhRmgyf8w/IbvFY7f5C2qeB/f4WL3QmuuVE6rtxNMi3lrHJmTZZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

Am 14.11.24 um 16:38 schrieb Paneer Selvam, Arunpravin:
>
> Hi Christian,
>
> On 11/11/2024 3:33 PM, Christian König wrote:
>> Am 11.11.24 um 09:05 schrieb Arunpravin Paneer Selvam:
>>> When starting the mpv player, Radeon R9 users are observing
>>> the below error in dmesg.
>>>
>>> [drm:amdgpu_uvd_cs_pass2 [amdgpu]]
>>> *ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!
>>>
>>> The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
>>> flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.
>>>
>>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
>>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index d891ab779ca7..9f73f821054b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct 
>>> amdgpu_cs_parser *parser,
>>>       if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != 
>>> &parser->exec.ticket)
>>>           return -EINVAL;
>>>   -    (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>> -    amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>>> -    for (i = 0; i < (*bo)->placement.num_placement; i++)
>>> -        (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>> -    r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>>> -    if (r)
>>> -        return r;
>>> +    if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>>> +        (*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>
>> That is a pretty clearly broken approach. (*bo)->placements[0].flags 
>> is just used temporary between the call to 
>> amdgpu_bo_placement_from_domain() and ttm_bo_validate().
>>
>> So setting the TTM_PL_FLAG_CONTIGUOUS here is certainly not correct. 
>> Why is that necessary?
> gitlab users reported that the buffers are out of 256MB segment, looks 
> like buffers are not contiguous, after making the
> contiguous allocation mandatory using the TTM_PL_FLAG_CONTIGUOUS flag, 
> they are not seeing this issue.

In that case we have a bug somewhere that we don't properly initialize 
the flags before validating something.

I fear you need to investigate further since that here clearly doesn't 
fix the bug but just hides it.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>> +    } else {
>>> +        (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>> +        amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>>> +        for (i = 0; i < (*bo)->placement.num_placement; i++)
>>> +            (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>> +        r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>>> +        if (r)
>>> +            return r;
>>> +    }
>>>         return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>>>   }
>>
>


