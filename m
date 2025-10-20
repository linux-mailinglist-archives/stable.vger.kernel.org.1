Return-Path: <stable+bounces-188204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DBBF2964
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104B918A334A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1233221FB6;
	Mon, 20 Oct 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjpo2lJk"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67A3EA8D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979746; cv=fail; b=JEbpwx8BlIPiuy3AOs4XrrZ+1QyDPw6K1OjbreXhW/DLtYtJ+rCrsFD2Pbpp4teUu2CWn0JoMBu/v4G3QpemXPAiaP8QH0vse0dNQAbr1a1FSr0rCDNN7kPxF3PEsUIZ5z7uLMPmexSNzieRCTzGBlGreZ8UPK9mRW3h51F1C+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979746; c=relaxed/simple;
	bh=DCK0tevVNBzE4W8eEX4FpybT+3E8V0JNEAmlt7o8tTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lb+rHY8TBE5xLeIw87MiQvMzYsjZcsg5Dv5sdNjmOhQHWdCb7HgkPZY7J7Rpwx3jUHOU5TjHvpZZ5CwLKlj/9Cc5DACJSvJkbwsp12Cc2wZ9C+rpRFSrDrtP6E1ANU9gc+QbTXAJzpq2NwGf0qtlIAL43t1BBJeEX+/47QHZrfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjpo2lJk; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx63FfnB0pyAvQ152DACYd6QwlGu65cnWpGOeX9mf0VOK4FEutriNlhjo8mjOQ6aHt38VQbuZ6A/1TInG2w4GZlaE740l4pGz+Tb28lBB0nksggmlQttNARqFi4QL50dR3u2bS3KdP8+g+D68xrWZkBPoLQA02iBAYfAv52A0UL9qhkHtc+dtHneMdgn8SBuG/1stFutaARcynk1w9PvDLjYH1xk2i/KN36Zlk+S5IqbADrqZblRgFS15ZIU/dkED2CGyr5ZiJ6kuZcLBZ0PoeuVCY1euoOTj4OQtCCNc3lwfH8gjohcHteLDyA6xdYWAuW/GRyaK1vF3ZMedoIhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX+1YqD9GA/Tge1KwLBqvi8MizYCxmhQKb6xT7kcxI8=;
 b=hQQXHcRRlMJcDlGnyYxyNRGKL5egIF+jwSizXdV+6nRwIWDle20P3khY0KambKV3036/uKOq4t7mYPSLoPOiMNteeNrauHXCKvkzqmQGjGodyaAtXRHO1l/fetUDQeXhRIiLo6j067isyo9um9u+gx+BzA8ot2mZH8VJFoZogF5b/NNlu/Osk6nVQ5c+B7UQfJyDmvQmQiJiApRzgwoztYIUC1MDJt2GSEOZkzoBDWUTO1fyrWWM3K5MiEumVn87vpj3CxiSjyjzWe40w8A2LhFJdWlxlKvImRL+TKeH0gg9MirYp1bWQpZhk2RLxXr2BtkQqr4CO/v5RfmKfIdMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX+1YqD9GA/Tge1KwLBqvi8MizYCxmhQKb6xT7kcxI8=;
 b=qjpo2lJk2GWsnaeXYnuJepfa2NxLFjT/KI7k9PHhL8jsaIr0SmeSUXus48aY8tLc6RKcNN8/SOimkkUnmMdSRrKVJFpD516ww2himW6lNI8FqDF4D+XDkbcXtRVe2WdMc4qTFLmfADcwnWzlr5zFkEEHf84HF+k/G0CZT4Kl7Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH1PPF6D0742E7B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::613) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 17:02:21 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 17:02:21 +0000
Message-ID: <96bbf193-6cb5-4993-8033-a2a2faf2e494@amd.com>
Date: Mon, 20 Oct 2025 12:02:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17.y 1/2] x86/resctrl: Refactor resctrl_arch_rmid_read()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>
References: <2025102047-tissue-surplus-ff35@gregkh>
 <20251020165309.1843541-1-sashal@kernel.org>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <20251020165309.1843541-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 690c55cd-d764-43bf-f311-08de0ffa6ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlFRdjFRZzFsTlFERUdJeUpxa2tFTWhZdU1tRFZPMXl2S0ZYUUgzRTVoRGc3?=
 =?utf-8?B?RFIxNFFwU09XVzlTVWRWVjhUQWtLK1BvL2NKR01SMDUrR2F5dHRTMitRWWZ6?=
 =?utf-8?B?TTRYU3hEMldtQVlhRGt2WEFrN1dwOFY3bFVLR3pWWWtEQlRVNGZSUkY3eFFV?=
 =?utf-8?B?UHYzM0x1MUlrVHRSTnkzd0FpSVBGMXBKaW9oWS96TWdjanE3c3NhYUZBUkZT?=
 =?utf-8?B?TzF3OHNud21YYjM2TnRMdVY5S2hHUmRNcW8xZUEwWFoyNzFGc0FJQTdSMytl?=
 =?utf-8?B?NGhvenBCSXN4UGU3T2sxaHdnZGRUeXZpZ2tNc2ppSGdmRDYySDduTHJxUWw1?=
 =?utf-8?B?WjV4MVZCdkFyQjVqaURFYlphb3Jxc215WEs4ZkRaeG93eVhRSFJ4K0orL0ty?=
 =?utf-8?B?Zk5vckZZdUFYMGVja0JPWTZtY1pkTXl4V3lEODFaZHJWaVFpMXRDK3hWTksv?=
 =?utf-8?B?YkdSQXlCSjMvSHpMcW1BdEJqVGc3TmlnS082cGtTd09sZy9pN0pndEZxVFR4?=
 =?utf-8?B?cFlYMnZHOVhIS3BNOTNJYkVWQi9Hc2RpZDB2QU41T2VKeWlEcHR1dFN5L2hw?=
 =?utf-8?B?TEkzaEJHQ3pJa1RyaytPd0ZPQWMzMU9nZncxbVpKRGJ4RmdPTFF4K1ZoaWZ2?=
 =?utf-8?B?VWwza295SUJyUjhEQmovT2pCSjdJL004VjR5bVBLNlIwby9hMGF5MkI3QWZs?=
 =?utf-8?B?QW0vOXFSNWtVeFVBNm1IbnlST04zSVQ0cEYvRXFWc3BaKzhMSElLT0QzdE5D?=
 =?utf-8?B?MU4zUTRTbDNOa2lZWEI1ZmxrdU1OeGFuaUJVTTBTeXFJRTNFTS9MaEV3d1JR?=
 =?utf-8?B?elFoY3FFUnhXUWI5STVCQUpmbStvMWJwMEhmWEtmMFNCcEdOM0lId2xDVm5w?=
 =?utf-8?B?T1ZCUTVsb1ZaMXl0a01ZcTZROXAyWU9IVWJoenRHV2dINnlzUlRjZThXQTRU?=
 =?utf-8?B?d0J4K1hIVmZ0ajdldHZoa3kwMHpaVGlVdW1xWjF0NitBQ1IwVXVGcUlrQ2ti?=
 =?utf-8?B?S3VES3VFRHc4Z2M5M0d4bC92VFVjL2lVRVF0UHdobnpCQ1B6RHdOckxXbmVj?=
 =?utf-8?B?MU12RDlFZ2MwclErZUp0c0s4REhNVklsMWsvYzVweHUvNkRnZTE1Ymt0MlFO?=
 =?utf-8?B?WDFtYVhlWnQ2U2FJVUJHMXk3MFVjRXM3eXl3bUlIMWlyYXNOTktzU0RlSjgv?=
 =?utf-8?B?YlBQc1VSbTFxQlhKZFFIQTRQTWZEN3NwUytJSDNyUHphOGZ0eXBsWWwxWkRU?=
 =?utf-8?B?RjZyK0wzUWhOTTdYS3pWZE5XZTdMZ0h6RjkySEdlcU1OM2lETWRkVFVYeENM?=
 =?utf-8?B?d3V2d2xiK2o1UTRIWHMzSm9KbXQzZkpDV2hPc0pXeHhqQ3lQYXpIRVZXYnN0?=
 =?utf-8?B?Z2ZlUk83bWNUdVBqcnFLSHhhMExoSW9zZzdLdTNrOWxDekxWOXhQaHZoU3px?=
 =?utf-8?B?Qk1ZOStEVmhGdWhVZlhoT0RGWjFQZTQzRlZPRkVHbzc4a0V2U2JKWkwrR09Z?=
 =?utf-8?B?Ymx5b0NBVEluY3ozMEV4d0NZT2xuQmVBWjV1bHAxcDlwVis4ZzRYUFRGdVBr?=
 =?utf-8?B?UWlsMmlWbFBteWJNMHpGMW9VUWJ0R3ZlVHlPOXNxSnJrYzE5cy9LQVhaNjJz?=
 =?utf-8?B?ZlJaOGNCcW93SWpHVy9MM2FSSzRYeFgycThGb2RNMk9UWWlWaDAyUDV0Y05a?=
 =?utf-8?B?ZHczdjh1WGQxNUwxK3JhOFJLNFV0MWJsbnppSXRzaHdsYnpOc2NBakZmYmRi?=
 =?utf-8?B?UStCWlZvYUppSmtsclJQam9kT3JBOWJnb1hocWFMemtUaXVmREVLZFRha3p5?=
 =?utf-8?B?TTlGM21aMFVtV00yS2xIbjVGZzdXcFFjN3JPZEtLMUdMTGZJc3RLenUxNUZM?=
 =?utf-8?B?UkdRUFIzNWtDejczWlNPNXpVU3gvUmo1QjZNSGZwbDZEa1JzUnU3clNseENO?=
 =?utf-8?B?dkllZzN5UXdFdGRnUE53bVNSVlVDQTIyWnhvZnFXZkNBSWU3cExLOUsrNHBG?=
 =?utf-8?B?bmt1SHJsSTBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0V4djhTYnhGUmdWdjFyRGMyME5YZFIyN0hOVnBhdEF5T3o1YnVxamwzY1h2?=
 =?utf-8?B?Wno1OUVHNUJSeUN3ejltQlAzSTNiUXpqRGlZajhEdkdwZDVBRVNZWkFiMnkx?=
 =?utf-8?B?eGRuQWdmdGFjYTFvWEhrN2xZdiswZjVzeUZSNFgxUVJLNTN5bjVCOGRQNVpt?=
 =?utf-8?B?U2ZxZXV4bXRZdnlxQ3lUaU9IR3VHSFZQaWY4emI2b0xobzIyTThVMGhrTFpJ?=
 =?utf-8?B?dVNIT1lWNHRKcHJQOFlNMWdjKzdDS3ZQQlFBWWg0MjJSVWlzaVR5bTgyNGpK?=
 =?utf-8?B?WVNKdUdYMmYwclo4ZnNSSy9xRkdoQTlSYnA0Vm1xZzhZLy8vaDBoZVpjM01s?=
 =?utf-8?B?OXE3S05lUVNRUk0vOVoyT1BjQ2t3TWRXdFBmRHBKNWU4eExTaS9NRS9ncXp2?=
 =?utf-8?B?UElUSElKYjlsK0J4NDEvQkJOUWE4YkZ6bTE5VkJOTkkzWHBqZ1JDNGpuaDIx?=
 =?utf-8?B?WWRCaEtlSmZKdEF5Nk9yMFA4VW9XRkZPT2tRV2g1cjFzeVh4OWJmNmZ5YXk1?=
 =?utf-8?B?ZW85RW5RTlM5QXhYVE1sL3E4MzIvTndpOUlvRmRMdEZqcXAvK3MzYmdXeDFM?=
 =?utf-8?B?Z0hwR3ZranlibTVHd1R6OTd1cC8rT0NSMWNVbmV3QnFveVhEd25tcnZ5cytW?=
 =?utf-8?B?NS9senNIMi96aVpVTjRuUllSVEFnaW5GNUYweVdEZUV4Mk5NWVNxQkF4aUl2?=
 =?utf-8?B?Qjdic3dGVG1LYkN5ajdNVGpVTmNBblF2WTZoTnRCWGZ4OG9lR09keXJzMkxL?=
 =?utf-8?B?UlEybWRjYlh0QmFoM1FjODB3Zk5OMWgwOGZGOTBpYzNHTzdrVHFZRWt1WmZI?=
 =?utf-8?B?S25xQ1kxMlNjakV2OVEzbUI1TTdiSGZSN0VTTDdTa2xsaS85eG1GUDZadkQx?=
 =?utf-8?B?ZzBPN2tUN28xUVlpQ1d6Wm4wNDhVUC9GL0VUN0pQbHN5ZjF3ZFU2TklsN2pN?=
 =?utf-8?B?TmlvWWtZTVFqZktOMzVUWjlOSnIyTlFUMkduOGdvUzhybFR4VTFmS1dveVFD?=
 =?utf-8?B?cmlNZW5iQkZ4ampXSDlOQ1g0bGk5VHlkLzhBOUgzczllY0I1VGtYQWk4V1Mw?=
 =?utf-8?B?TTBGb1M4dEpOaHdYWXl6bzNuLzBSOGFjcHJBZTdYbVlEbjNZRm0rRDJEcWdj?=
 =?utf-8?B?M0ZxalpScDd5bHhRdWJMM01sQklzYjRzUEl3OWszTVRnMXpEdm01N3hyRGJt?=
 =?utf-8?B?SFBOQWJ0ZDUySnc5MlZ2QUtQYllIQlAwNzFQRHZnckdlRjNxbldHL3JUeXF2?=
 =?utf-8?B?VXNMN1ptSUVQRmFIc1NuL3A4NHNDQjZGenJVbWdzMktmVC9CTzhEb1RwR2pt?=
 =?utf-8?B?VmpVQXVCSjZBTisvVHN2K1ZrdStmUTVFRXRRc0RJMzlWaERvQW85bmRDK2lk?=
 =?utf-8?B?ZytsaEpTWnVUck02c094Sk1pcS95WnFsbzRiVDBSSTlES0NrY0pqTm5yM2RL?=
 =?utf-8?B?T0NpMUZOUkZGdnVJNyttS1VDbkhOc2VacGJaT0cybVJMM29CV29wWUhxdVNH?=
 =?utf-8?B?MG1wbDJtMkEraTVJVHJHSWxOVmxicC9zbkEyWWNUS0xybTBVQTR4Q2M1Vm0x?=
 =?utf-8?B?ZS9pTmxIRHpKdzEramFxN0hKN1M3RHRVVjh0aXEyRW0zQXhoUHFScjZYbndu?=
 =?utf-8?B?a29kd214M1dDdDNCZzZnMXBOQkFhT3VIRmE1L2M4Rm1sMjdKRGpWS04vVGdo?=
 =?utf-8?B?R2lrazVYRFdzYjgxQkVKa0U5WWc0VE9LR2lrbnVrVE5Ka0NZVzZuQ1poVWlm?=
 =?utf-8?B?NkZ2U1pFSmoyMFRyYThncGtBcHJPUHFjVEk0NnY1MDM0OUxEWE1BZWlNYVVv?=
 =?utf-8?B?T092TnVYdDZIdkJpKzNjZmpCQWNyaTRJT2Z6VE9FVlQrclhtUDE3ZTFMbWFX?=
 =?utf-8?B?amVwTmRpaHdYVkxmY0xUREw3OUU0Q2d0a1NlVlY1blc5eDVTcWdsMkxoMFZV?=
 =?utf-8?B?YmhTdktFQVlPc1RoT2U4NkJRNEpyZFkvSUZNWG8yUmFOcjBVaDN6YzV6NE9K?=
 =?utf-8?B?aVJWbDRicW1maGZ3SUNkSUF2MGt4RUFEZ1RxK3MwbEk2cDZTTVZzZm9pV3Zu?=
 =?utf-8?B?NHVpQmtjMmZyVElRVm5mT0s4WVBiRGNYOHM5bE43RnhheHhmaUk5MVhMNHdD?=
 =?utf-8?Q?owgE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690c55cd-d764-43bf-f311-08de0ffa6ef4
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:02:21.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YX3FwVrXaYMCP//Qvbd7Jw76sRbQARxWUtOh5PhY4Y4R6wjLXyM5S6SeDDADN0jO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

Thank you for back-porting.


On 10/20/25 11:53, Sasha Levin wrote:
> From: Babu Moger <babu.moger@amd.com>
>
> [ Upstream commit 7c9ac605e202c4668e441fc8146a993577131ca1 ]
>
> resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
> account for the overflow for MBM events and apply counter scaling for all the
> events. This logic is common to both reading an RMID and reading a hardware
> counter directly.
>
> Refactor the hardware value adjustment logic into get_corrected_val() to
> prepare for support of reading a hardware counter.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
> Stable-dep-of: 15292f1b4c55 ("x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c261558276cdd..cff5bcaddf42f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -224,24 +224,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>   	return chunks >> shift;
>   }
>   
> -int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> -			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val, void *ignored)
> +static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
>   {
>   	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> -	int cpu = cpumask_any(&d->hdr.cpu_mask);
>   	struct arch_mbm_state *am;
> -	u64 msr_val, chunks;
> -	u32 prmid;
> -	int ret;
> -
> -	resctrl_arch_rmid_read_context_check();
> -
> -	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
> -	ret = __rmid_read_phys(prmid, eventid, &msr_val);
> -	if (ret)
> -		return ret;
> +	u64 chunks;
>   
>   	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>   	if (am) {
> @@ -253,7 +242,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>   		chunks = msr_val;
>   	}
>   
> -	*val = chunks * hw_res->mon_scale;
> +	return chunks * hw_res->mon_scale;
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val, void *ignored)
> +{
> +	int cpu = cpumask_any(&d->hdr.cpu_mask);
> +	u64 msr_val;
> +	u32 prmid;
> +	int ret;
> +
> +	resctrl_arch_rmid_read_context_check();
> +
> +	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
> +	ret = __rmid_read_phys(prmid, eventid, &msr_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
>   
>   	return 0;
>   }

