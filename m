Return-Path: <stable+bounces-158560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FBAE84B9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9183AC752
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC817221DB2;
	Wed, 25 Jun 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YU0N4JR7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1117B418;
	Wed, 25 Jun 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858283; cv=fail; b=GD/nbzqxJXMZf8Q3vV3Gw8sH07pnGZZLyqWSZkRpxlX9XBBhSGD2mPdQDU7URr1sAEmV7nTboge1xc+Jqxq7GH5lv9rBy3rTIBnyxx9SgXDbhs5Qzdm8MITuAoUEzRFD0HK4EIzbcHIksHBc6ptkKJjSsKasqU2637doBhFPi3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858283; c=relaxed/simple;
	bh=y+csJGEQKNcm3+Tpjxu0zK6OaS3gAX98ZjofdHEf2gw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qNuSf9REX/BBHsXt1P7REW9XgRoLFYVcHuD2zSOx+r2j2hK69LVIor6HfF8zkyehV9vdxsOU8qgdvdIvdwt/wdPNnV0V70LswvKLr4GBqUuhyFWgJgY+uWktcS3bGtg1URWW5tOrsDhXLRbh5SNirO6VH4APoctx6mWzOfVfeLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YU0N4JR7; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYYBtBue4ycPHjtKFekVBIweNmR8uZUYeKm7aAVqL1gZ2l8NZjCwFNmTRwFnOO3/ykmt0PDi2SGKkGzxzYfeVssgMQpsfkP+5vrkDRjYuDz7whxFBDoKkrqtfv+2pludX65lg594Gg942LL3Y9ioJRNAaEnhT00uPX66scF/xA1i1ThSzrkl2/DmuR8MWfxRjI90D0w/7FKoYE9Clnd2Xh782KjBInxC8rrKxjmUbpJ6orfEayDCjpQdoR2pPYiUwHy/8jNgqJ1hD7I6K4Up40tsM6vLdEafePgvZtrxKqKElR5iU9aAO0O0VQVdGvH1+OVhjXTDTv2DJTjA/n4hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CJg3c/FEuKBvJejPlaDYt5w4AWV3r0Sa8Ly6WJTISs=;
 b=SoALC/EUxTsYjJ86mNOE+EFG8LN9blTkAgWCYK08UctTiyWCJp7eWqPzNQ6nLqhjKR6WzaoD6XdaYLB8kwWBo1a+U8XJ7jwOUFo5RkpnES1kDacMghOA43g6xo3WXO/VSvD+ozP827PAnMU7v+4qoucAfSPDlbeNJJf21pZ9MMUfHZfoK060V9W9szSgJlMhC//jy8mYCu6GVqwC/p+7UmkC9ZUIdCqSyLicxFww/lGGn44iYFEWxZDcys2RW9S6mJqvx7oo3LfoTfqCDRSei+IW+krqN7BuwpWx+V1LGTEySTrFm/n2x9pORLIgHvNKrPeBwPamSO+w0/K6yxcSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CJg3c/FEuKBvJejPlaDYt5w4AWV3r0Sa8Ly6WJTISs=;
 b=YU0N4JR7lYhQPQTpZs6HtTqYzeguT6pxsDeTRwsZssB7QIy0sBwwBGtAEsjv/oSap4JRAcH+v0s6q5ChRWblYZuEtEIGticEWj3f0+NG0e6WC3zniJy0m8zbTJe3ldDoaU66NvYaFN/6Fjpm/PJAm55D4WG06ynxF6u41BpbbGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Wed, 25 Jun
 2025 13:31:19 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8857.019; Wed, 25 Jun 2025
 13:31:18 +0000
Message-ID: <39c23b91-6e5a-033c-e000-c6926b1ea1e4@amd.com>
Date: Wed, 25 Jun 2025 08:31:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
Content-Language: en-US
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 aik@amd.com, stable@vger.kernel.org
References: <20250609080841.1394941-1-nikunj@amd.com> <858qlhhj4c.fsf@amd.com>
 <CAAH4kHZPrDRF3sZ2GxFxMeue3o9PsEL7p-j8bKL2mxgBjR0ATg@mail.gmail.com>
 <8e0807b2-eef5-4172-8c9f-3e374a818344@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <8e0807b2-eef5-4172-8c9f-3e374a818344@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:805:ca::33) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd6b47-1893-44a1-4f91-08ddb3ec9117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXhvYjVvUmNKa1llZWR0dnhtN2NiWUJ6NGZaWnFZKzl2L0NabmlkZkhQTjFj?=
 =?utf-8?B?MURDT0lyR1A1R2ZUWm1qTTZ6dlBwTUR1aHYvb0JwcWpOV0EvTGdVckxQUDFi?=
 =?utf-8?B?eXhoSSs1dG16L1hLVXViYkVnT21WQzA2K1NEd1lOUzV0TjdwdjZUdGM0WFYx?=
 =?utf-8?B?SUsvdFNQQTMzdkZYWHpBZlBub3FQcVJwamtmaWlJVHN6Q2FHYkdraGtwcW1m?=
 =?utf-8?B?ZEFvUEtpeVhxYXk1Si9JRGgyNitTc25WdFYwZmR2U1BHaDlpRkx0WkQ4aDhy?=
 =?utf-8?B?Ykc3NVNENkhOYTE0WVNkR2dDb2hjNitodExFWVVVd01mem5nMHUrMTAybDY4?=
 =?utf-8?B?WVFQNVhDSjFUR0E2aTVpUUxuQUxlQzhFSkNCOXFVUXlHWWdSclpReXdaV2g5?=
 =?utf-8?B?eGZhUC9IVFI1SERWTFF6OVhRcVZnVzBpeWdGYnQ5NzNuWVVDY1ZsckkvNmNS?=
 =?utf-8?B?dzRIRWJVSE9rbkFSS0FKZmZVaFBuSTRmSnh4RnhUSDZrU3RBdHpWUElrcmtx?=
 =?utf-8?B?M2k2NVRFNWpJNmNLNmtZUTFycHJkT3phZ2NlMVN1L3pvSkcxdUpLbStROFg5?=
 =?utf-8?B?dG1YUWFaN1JZamtwWlpZb09rUzhBRHFSeHh6eFQ0bjRndGcxY3kwVXRjSmJq?=
 =?utf-8?B?aDJrbkR6MnphQ0VoOC9Od3NVaVQrRDk4R2hGZnk3T2tHcEk5MVowckJ6VWp1?=
 =?utf-8?B?dUpHSlVObHZGTzFueXpVTEhtTkFadWYyOWplMmMyWHpIK3loSUxIUUtzTFRD?=
 =?utf-8?B?eW1qSnA0MXdIYXlUaHBuZHlJNmk5MlNseDB0MEZ2R0prdkN3N2ZJTEI0VVh4?=
 =?utf-8?B?bEZ4Nm5yV1h2aGdEbzFZanZ0ZGdaWnRTc3ZIUkNKYVRiSEMyL2M5eG5yblZL?=
 =?utf-8?B?U0tnSElvOWF2NEtBSUNCWnBjZjlzNi9qWUxyUWpOZFN5aEFBWFlpNGlnK0N1?=
 =?utf-8?B?THhCMFRYTzVtWjN6a0pscUQxWlpCSHl1amRWaTlUaDdBcFMzZWNRM3JKVmc5?=
 =?utf-8?B?cURwMmIzRlp5SnJ4bDRNUGkxKzNMMXFwbDAvWHJpZ24zV0tDRk5QVlRVNUM4?=
 =?utf-8?B?OXV0dUM2OHhvOFErZmozb3FxWUM5d2JFTGhQMk5EaXJienFBVFAxU1lMMWc3?=
 =?utf-8?B?Z05uWFVBUThZNzhRWlhsa1hsTXlZKzk0dGxuU3NoRDVCeFpvaERTOTl1VWFj?=
 =?utf-8?B?anFRaGVDT2NIcFFLdUZjbjIvWUFYWFZmUzFJWnhiQ3RkTFJxaHZEQ1JjUGMr?=
 =?utf-8?B?ZHN1NTJ5VzZLLzV0LzB1bFNweC9weUoxKzlDSDI4NCtUTEFGblcyYmdSOEpY?=
 =?utf-8?B?dWdRc0N0UW5YWDFRTHUzM1VTQTdkNnVMcDI5ZmJaeXN0TElMbTdVaWRIMWNB?=
 =?utf-8?B?clFNRHBwSDhvZ2VvWUdXQnFCekFSdTZwRUZPODltTXZwaVk2TTVzRTRpYXUw?=
 =?utf-8?B?OEwvMElKOUNGYzdHZzRVbzhWeVkzaVhVaHo5Ukl3T2tMcVMvaGluWWtNN0dt?=
 =?utf-8?B?dlNPeTVKUk1oNFlic3pZdUdESDU1MWp0cnZTU2Y4cGlyaEJKdnFFZnRmZ2NL?=
 =?utf-8?B?amZSY2pIQTFOMlFSOWpMaEtITnZIcUwxQitGcURBYjBpWW04blhyZmQ5Y1RC?=
 =?utf-8?B?Y3FLWjdEZEloRWNDMSs2elNydHI4Q05PUlFwZkhNYlYwdEhCdERUb0w1S0ov?=
 =?utf-8?B?K0RQYVRWVXovOXlPN3JRWUU3OE8reEhBOGNSV3JoU0txSWRhTTIwN2dGTTN1?=
 =?utf-8?B?QnJLUXFMVmEzck9xNFhRZlBYS1QwanRxc1JBaS9lZzZHOHBiSkRySEFFa1Fs?=
 =?utf-8?B?ZmdCYVpUazh5L2lWK3JoRmFCampYZzNjZ2VkdEd4NE4ybzkvU1E3c2h4VHRJ?=
 =?utf-8?B?YkM4b0hJVk1lb1VSU2F5WGtKbktxQ1AvTHhPTWxvU1BEcS9pMDRIZ3V3Umxo?=
 =?utf-8?Q?l7ElkLnwyDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDViazAxYzRXcXBqb3BzL0lqU3l0eXN2Qks2cG9XTVkvTXVTTk9zbktsUVF1?=
 =?utf-8?B?Tkc2UGp4ZW1CdS9sS0dsczV2MlVFZFdvTXNCcGFUZ2ltQlN6cmV2bGF2QTVF?=
 =?utf-8?B?Z2xhZERLWHVHMzZDMUYxV1FFZHJJMVJqUkUrU2k1aWRUNWtuazdsbnNDdGtT?=
 =?utf-8?B?U1lkMEdSYnh0TFpMa2x4Zy84UnRKL3lXV2NabkR5Y2xQcTRwdHoyQTcrY080?=
 =?utf-8?B?eG04dmxsWi9ZdDlWcXAwUDhEQVlCSkE3eUtTN1Y0bnAvdyt3SlpuVE03QkhH?=
 =?utf-8?B?SVd1UGdOdWd5VEE2ZndaNnBmWXpTcmxqRlJNb0h5Ykkvc3cyZXhmaktNcEZJ?=
 =?utf-8?B?VkUzVE1aNko4U3E2T0xaUENWcHdVQUR3aUpscUxVbkNmT3IwSjJBemtUNEx6?=
 =?utf-8?B?cmExZldrOHF2emNEZEt3UlBMQnVjZVk2eVE0Y0dqWDhiU09RbnBkeTVnS0VS?=
 =?utf-8?B?MXBtNW1UWUpEUWoxSVBoYlg0ejY0ZHdTQ3hqbXRRTExGTU5UTnVaNktLaUZ1?=
 =?utf-8?B?T1FwRWlodXJkVlBQN0QzUlR6eHdDSnZCaFVNZk9mWWltSlNYK3gvdHdWbVBi?=
 =?utf-8?B?QnE4bnpncFc3REp1VXVFNU81emxiZVQ5YWRwUERWUDZqVmM3WG9VODgyeTAw?=
 =?utf-8?B?ZkZYWkw4Vk1hcy9ERjdxTG9oM3JSM25NcU9lU004eWtwdmMrOHJHLzY2RWlQ?=
 =?utf-8?B?QlpYM1dhQzJKRUYwcUl0MjBKSzZLZHU3aElDNHhxZk55L20yRklzTlpDOXNY?=
 =?utf-8?B?eGN2MVozU2x5dS9MWXU0a0d0eng5K2JsWnQ1dUNybHQ1UDM3QUZGREZUYjBL?=
 =?utf-8?B?VW1xejdGd092YnkzbmhOV1kzaTExb2RYSFM3eVRrQW5wWFcwd0NzOWhZbU9u?=
 =?utf-8?B?MUVJMnVndm53b0k0WFN4YzNCbGJoYXhDTzZQamRXMm4xTjlhbTU3RVJ1SG1D?=
 =?utf-8?B?ZkpWKzFsc2srQnBKSkZxOUtaYTR2dzJYRnA3azZGK0pmK3Zzb25PMFpYdlE3?=
 =?utf-8?B?Q21hak9GdWZ2ODVqMXF0M2ZiYTlhRUVOQnl5ZFNkb3hDQjUycnBGbGVtM1l6?=
 =?utf-8?B?ZU11RnZPb21VRDUwN0lBbVg4cmw3SU1YZit3bUsrN01LR1NRQ3d4cUo2ME1N?=
 =?utf-8?B?ZjlmY0xaZ092MmpzeFh0VnEyaTgrMDkxZmJWK09xYnl1ZTFPWEdMclJ4eDZr?=
 =?utf-8?B?YWpQTDhGSWx0MUk2RVNMdFJISFBWdU9iY2g4QVlFMVU0SVpiaU5rUFpLdVkz?=
 =?utf-8?B?ZDVQQjRhVjQ5dktnT2tzejdDbkt0UkRycm5Venc1SWhpRHZRbm5JQUlHVi9T?=
 =?utf-8?B?SGNocGtveTJKNGIrZ0Z6aDNsVi9MYzBaTERyOVZFYTNReENrQkVaWEZyUW5i?=
 =?utf-8?B?WHpkVjNJcG1tRlpmQ2VERkVWN3VDeWpoY3RlaDBXNkdaZ2dSb0NRL2wwaWhT?=
 =?utf-8?B?aHBpOXIwQXZMTTRpV1IxRlZMVnZCTGgxTTJPN3liajVwNzFIem5PenlaTlo4?=
 =?utf-8?B?R3dVKzczMkxNcjlwai8rZ2xmcE51aHBXTy9jQkVXbFNIQmh1WENQWGhhb202?=
 =?utf-8?B?OHY4VDVkM1RDL2VyUjNsMTZkZnd5VE5YektJMzdwNGswbXhRM3R6UWN2cm5K?=
 =?utf-8?B?ZUxpRG5ab0E3SVAzUThEQzBRdkFqU0F3UE1FaTRJWjA1TkFCRXpjTXpnS3BK?=
 =?utf-8?B?QTZ4akpOSkdrbTdzLzVmRy9BRmF6SHdkZWRjaG9pWFhoV1hsYWtteGdITzAr?=
 =?utf-8?B?b3RYcFNLQkhhWXpLbE96cEp6a2hUQ0lqR2JFeU1Teis1ZWM3cjB2Z2NCVUVI?=
 =?utf-8?B?UlJRY2RtWjBBR0xGbnlxOTQ2eEQ2WHBsUjVpOGhPUlcyYmI3N1RHVWk1dmx1?=
 =?utf-8?B?aENCRU9TUnNsQXhMMCtHTUhySVdDZG1uaGRVc0NBUXNBUTByaGQ3T3ZTSTJL?=
 =?utf-8?B?UVFTWTk1TU5NWXdVVG9ZLzdhaExCeTZHRUdEajVYQzh1b0hUcC9WNWJvUmxT?=
 =?utf-8?B?b29tTGxNMVh6R3BCL2NhTXRYYkZScWpKZWdtK01LU05rbW5rREMzRjNtV1Ar?=
 =?utf-8?B?cFJnNDA4N0NRNGxReE8wZDliNUtnL0NmdUEwV3FVRVhmb2ZlUHYzNHQzUEVD?=
 =?utf-8?Q?1l130iII2eFE8Eua10KNouSwo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd6b47-1893-44a1-4f91-08ddb3ec9117
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:31:18.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE5IhuuIozLSFZ9mort+fgt6/QPHVXghkk0LGlQgOHdoqEtCxGhvgX+l5ZtV4VpeJ5RZhWd5prEwmYhmTEpqwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

On 6/24/25 23:55, Nikunj A. Dadhania wrote:
> 
> Thanks for the review.
> 
> On 6/25/2025 12:34 AM, Dionna Amalie Glaze wrote:
>> On Mon, Jun 23, 2025 at 9:17 PM Nikunj A Dadhania <nikunj@amd.com> wrote:
>>>
>>>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>>>> index b6db4e0b936b..ffd44712cec0 100644
>>>> --- a/arch/x86/coco/sev/core.c
>>>> +++ b/arch/x86/coco/sev/core.c
>>>> @@ -2167,15 +2167,39 @@ static unsigned long securetsc_get_tsc_khz(void)
>>>>
>>>>  void __init snp_secure_tsc_init(void)
>>>>  {
>>>> +     struct snp_secrets_page *secrets;
>>>>       unsigned long long tsc_freq_mhz;
>>>> +     void *mem;
>>>>
>>>>       if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>>>>               return;
>>>>
>>>> +     mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
>>>> +     if (!mem) {
>>>> +             pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
>>>> +             sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
>>>> +     }
>>>> +
>>>> +     secrets = (__force struct snp_secrets_page *)mem;
>>>> +
>>>>       setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>>>>       rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
>>>>       snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
>>>>
>>>> +     /*
>>>> +      * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
>>>> +      * TSC_FACTOR as documented in the SNP Firmware ABI specification:
>>>> +      *
>>>> +      * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
>>>> +      *
>>>> +      * which is equivalent to:
>>>> +      *
>>>> +      * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
>>>> +      */
>>>> +     snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
>>>> +
>>
>> To better match the documentation and to not store an intermediate
>> result in a global, it'd be
>> good to add local variables. 
> 
> As there is no branches, IMHO having intermediate result should be fine and not sure
> if that will improve the readability as there will be three variables now in the function
> (tsc_freq_mhz, guest_tsc_freq_khz and snp_tsc_freq_khz) adding to confusion.
> 
>> I'm also not a big fan of ABI constants
>> in the implementation.
> 
> Sure, and we will need to move the comment above to the header as well.
> 
>>
>> guest_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
>> snp_tsc_freq_khz = guest_tsc_freq_khz -
>> SNP_SCALE_TSC_FACTOR(guest_tsc_freq_khz * secrets->tsc_factor);
>>
>> ...in a header somewhere...
>> /**
>>  * The SEV-SNP secrets page contains an encoding of the percentage decrease
>>  * from nominal TSC frequency to mean TSC frequency due to clocking parameters.
>>  * The encoding is in parts per 100,000, so the following is an
>> integer-based scaling macro.
>>  */
>> #define SNP_SCALE_TSC_FACTOR(x) ((x) / 100000)
> 
> How about something below:
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 655d7e37bbcc..d4151f0aa03c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -223,6 +223,18 @@ struct snp_tsc_info_resp {
>  	u8 rsvd2[100];
>  } __packed;
>  
> +
> +/* Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
> + * TSC_FACTOR as documented in the SNP Firmware ABI specification:
> + *
> + * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
> + *
> + * which is equivalent to:
> + *
> + * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
> + */
> +#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
> +
>  struct snp_guest_req {
>  	void *req_buf;
>  	size_t req_sz;
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index ffd44712cec0..9e1e8affb5a8 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2184,19 +2184,8 @@ void __init snp_secure_tsc_init(void)
>  
>  	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
> -	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
> -
> -	/*
> -	 * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
> -	 * TSC_FACTOR as documented in the SNP Firmware ABI specification:
> -	 *
> -	 * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
> -	 *
> -	 * which is equivalent to:
> -	 *
> -	 * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
> -	 */
> -	snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
> +	snp_tsc_freq_khz = (unsigned long) SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000,
> +							      secrets->tsc_factor);

I would make any casts live in the macro. Although snp_tsc_freq_khz is a
u64, right, but is always returned/used as an unsigned long? I'm wondering
why it isn't defined as an unsigned long? Not sure how everything would look.

Thanks,
Tom

>  
>  	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
>  	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
> 
> Regards,
> Nikunj

