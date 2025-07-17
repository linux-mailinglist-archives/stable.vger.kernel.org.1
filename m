Return-Path: <stable+bounces-163249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DBB08A58
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F180B1AA2F0E
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C8299929;
	Thu, 17 Jul 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Ft3Cuvy"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA72989B4
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747169; cv=fail; b=R/omWbW5MS778OjEexOEdHM6whwkna5erqaY/6KqGoUqXXZrRR+LiLr0w3RnWp2/ZSRxojLwyhwvSGu/9SJ9PxMy4GOCcrmJpM8cSJRPwhGZvRIDDJhi3X3Fj8sJT3pUCpQhW7kC35W/h3I6i5u8j/dM4a52MW8m85SD1C6WViQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747169; c=relaxed/simple;
	bh=saKKPJfSrK+f5vXGCVSoCWDXQP4wjQnLiXKXdTylzAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbOAtxAcaFmZ1zilciQi+uHM3UYuBjTMjOjjq6IpFvO/jqmWJDkEFd9+3jii1vJVZ6A2M1lLch8iiUjTpjFXFKekMxkA3+APeERfaXlYXNNWn6cZUenjIg38/kG59aszx62vMdeXsX1zZPh6FOZ0qDRFIau4xnR+aZ+w6tTVuy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Ft3Cuvy; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buyfXvgLz5zBPiGuTfpHfEWxyw3kvm33wRmpU/t3+8HksP1cQoE+Q4IMOVq4vFKSNFHNCh5HKBqkDLxjo71adTtdICA6bMW0WlW7oOwwEFZ/HYO0mO1OMJKg49p9UoAJCmnoikh2NDibI/aqBAwUocxAY+0J0rg7Il693KfEAF6Gg0PR9k+f/dMFLPqvNF5pVLiFMLSmf+fYrxxWpqnDfNiayf3wjoUC/bVVb4ox6XNrTsU35zr9dSeyAhY8F2hrxP1rY/bK+/0U+rEeRUbcSyb1uEfjM4oCoMRmFzv9j4cXIwFEg98WYr6zuRpRmUQlwJRF0T3f6sM0xhp2iy99oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keyLqs0l1R4ar2j33GrIeuG7F/DF8ztRZKF5qJSFNPI=;
 b=Jn4/e4haLsDUW7hSRApBkolI8eUj1z3oIAhERtav+VVS5A/S9DbCKEIzfyG3DH2HpQWrrwnZ75p6G4EeXj1w7Uo7J5Whnv2hYHaxAzhcf3HwTa+Vz3JM6X7wH/Hd81zJioUesdpagv9dSwOZYnUU3H9ucu2UERtzIASj0EgyqxKOeNEQXYtjKeAR5xSlSFL6iYFEoWybOFNjUvhFXi0NFEcqxjkIu8tKYdxD8QVh/LZA12SYSmzXuh0Bxa5enItNTb4jnhgu4o2dM3tpchRtfT4iAQrfKoEBagaMQTueeRMCfEprrPPrmPaKKYIIcyPlBrFg+b4fCL3ZwkPBfCmT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keyLqs0l1R4ar2j33GrIeuG7F/DF8ztRZKF5qJSFNPI=;
 b=2Ft3CuvydOTZo7yxT8+OeCoCtg34MdqxTIfv0G4urqcXWI82n6q2HXygmnyt1GlOB4BnXUQCD/Jc5VluEN+keoZEqvSGfX/xdZQppj2t1EhrC1FBnRXQFdygC2YCWxGru0TtrX9razcwklMvRaRhXjwqS/ljGGnhHTDf0NcL02o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 10:12:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 10:12:42 +0000
Message-ID: <a1706b67-688c-475a-9621-6751b13d9c5a@amd.com>
Date: Thu, 17 Jul 2025 12:12:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Remove optimization that causes hang when
 killing dependent jobs
To: "Lin.Cao" <lincao12@amd.com>
Cc: stable@vger.kernel.org
References: <20250717083458.920583-1-lincao12@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250717083458.920583-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 27494ccc-e356-453d-cf24-08ddc51a77b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjNKMUN4SjRmVzB6cTVrODRCem85S1A3d0t1MlZNRnFnRlNmb3U1N1dPTVEz?=
 =?utf-8?B?Z2sydFFXcENZOEtRR3g3dk80bW5TMUlNWmVYUXhFVFEwMHlPNEdUUmJITU11?=
 =?utf-8?B?cmh4WW1nZ0M5TFB4TEk3M1JwSHhGR0FyM1Uxb0N4RG0vbDAxc29QMnVWaWlR?=
 =?utf-8?B?cWJlTnN1UUNXZFRTQkV4ODMya21Hc0puakZzenA0RDZBUlRUb01XV3JYVzlM?=
 =?utf-8?B?dUFncmFPWVJoN3pqMCszTjlWQTJubzVJWlBuTnFuRlA3TGh6OUt1S1B0L3JY?=
 =?utf-8?B?ZzNOYlRwT3QvaUtJSUU3NzZTR2JzQ29HdHJ0L0lFQWx6bzQ1Z0R6NlJkSHFR?=
 =?utf-8?B?SHk3WFhGL2ZocTFqL0JQVmQxSlozbGwzQlhneit1NGVVb3pVeEFSWk9FVXdw?=
 =?utf-8?B?Wmh0d0Zocm5uV2VJWHlqOFhMbVZzN3hzeFBkWkxZTzdwSUhUd1M4QVM2Vzgr?=
 =?utf-8?B?Tlh1NTF5UENSMEw5cGJQR211bGtaVFNwWHJVdnlJYmxYeVBHQnljcjY5alN1?=
 =?utf-8?B?RlFSNTc3RzB5M1hkd1FwbHpjaDhZcFdsZTV1SHZmMS9HaVplMW13N1NlcVRu?=
 =?utf-8?B?V1RuVHFxUUxrSWl1eGh3RjB6SVh1eVVtMUZLVU9pVnQ4RTRGQ3NrZHUvYjBS?=
 =?utf-8?B?QjZVT0hzQjdNZ21GdzJxTkVoVmREZWpPcGhoZG9SSnM4NThwSk8xYWdrRkdM?=
 =?utf-8?B?U3BGbE1mUVhOcGhqRkZUUVptQWpoTHFCclE1SnRyd01JcjNqancwQ0ExSVo1?=
 =?utf-8?B?YzE5TFdUczc1eUV1bmpLdzVyMHN5U3I3TjdKcVN3RXp3WUk2THlzekVLTjd0?=
 =?utf-8?B?SlRtc0poOVVadDRGVitGSnhSN01SeSt0a0pHWXB3SzI4ZVNUMm1NNW5tU1JF?=
 =?utf-8?B?dW9tOGluSUFtWVNNOHFSNHRZa1R3U2VNbnNEQmpwb01RbkVQWTIzREk5Z3VY?=
 =?utf-8?B?WW5VVnZ4bHptajROU0kwS3lKTWVmaC9DSzVtNDByQ0cyWmJEQlZCMXR3eGgw?=
 =?utf-8?B?cFROZmtkYmZZVCtOVkxDb0NWRnY3cGU0bEdaWWlHT3N5QUJvSzZ4VjBTM0Iv?=
 =?utf-8?B?RWllRlBXUDFiMEVmRUlBdUVCT1pWczRWVWZSd3grZk5pMHNPZmhMa1MxWiti?=
 =?utf-8?B?NXpEdUJrM0NJVWV1bnJYcytBTFBIdnowcktRS2FJQWVEaXhWSzJBeFg0eEYx?=
 =?utf-8?B?em9vbnVqWFZlMnowZmRkVHJScXRRVldzQWNCRzNvMDRuNE4vckFOSWRlTWJE?=
 =?utf-8?B?TDk4S0JBNUN2MmFocjlHeVNFNXVvR0xnajJiTHZHSHp5TjlNYkpQVUpMaEg3?=
 =?utf-8?B?TW9VclNkdUl5ZDVlbitSc1V2MXJESzM0OTZ0UmFjMnB4MTZ4L3o0d1ljSVBD?=
 =?utf-8?B?c2p0Q2lRT2NPNmNkaEtCeklxeEVJUlR6NFRnKzRKUXJXRzd6cWdLYVhta1Ju?=
 =?utf-8?B?MmtSYlhTUXFBTEk4YThkSTl5ZTdLTHRIeEVtT1dMdEJTdnFyL0FsUk9aL1N0?=
 =?utf-8?B?MmUzd1lNZHRMT3VZaTN6elU5Z09rdWlXdWx2Z1dkRHJkSURXQWhWRzlENlQw?=
 =?utf-8?B?RXFNZ2JrMUFSbVFZdm5RdFpORUEzd0RQUzIzYXFESFBQTHpvY2JKRVJZRlBz?=
 =?utf-8?B?cnhQY3YvR2g4VGtXZS91NWtFTGhVZ3hweXlxN1JtTkI3OGlhQlo4WEdSYW85?=
 =?utf-8?B?UCtSTFl5OFZsYUU5Y3RuL05KMTdBVUNZaDU1QlBlRVdVYmlEV0NOTWlNWDFt?=
 =?utf-8?B?SnQxOFJmTkU5RFBEVkdQU2NsQWJLc2s3TTFhQlU4RXpCYm1acDFtMUdyU0dX?=
 =?utf-8?B?ZlhlYTNIQmZvay9CZjJYdG1aalVpL25yVE5tZ1BuUnRqZlpCRWhvUEUyKys1?=
 =?utf-8?B?NGJJckg0NUVlQ2IzNDdxMFM4STJaOUZCRGlRbHM0Vk5POSsxWU8xWWNNcDdm?=
 =?utf-8?Q?nA0Clv73mVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czNrRkNkNDcvY3c2OXR3UDB0QkgydG5BMUpqMWpMRjRMc1NHbjFZN0QyUHVB?=
 =?utf-8?B?NUgrZnZ2RkZHSDd4ME5qaStqM2ZacXNLVFRKV0o4akdod0d3TlpQVm1paitu?=
 =?utf-8?B?dWhYK0FIdk5CRmJUcW9Nc05uRHcwdnZOQWwrWit3SXhGMUNzSlR4MGZYdjh6?=
 =?utf-8?B?Z0RtQngrZW9OaU11UGd5WnNVTzVVSnRiZHl1Z2hsd0tmT094b0x4djJmaVk3?=
 =?utf-8?B?VjEvUGpoaTZldUlmc2VGN0RNZ0lXSytBRXhFei82ODB0bHRRaThRalJXRytr?=
 =?utf-8?B?TzFjTVk0eVRsckFEVzM3NWUreENHWi9NeWF6N1czZDhJWVdVV1BibFpvZjQ2?=
 =?utf-8?B?eXhUQVlDbUtVL1NPbW0xSEJ3ZkJXUS9seWNRdVlKQXlqMFoyNFJqb0pLcGk0?=
 =?utf-8?B?aWVxUDB0QjErY2c5TVhWMCtUSm95VXlxci9MeDN0L093N0JPWEJZbWhzWDZD?=
 =?utf-8?B?SXhDc3lmQS8xWVR5enB0b29NRUFzaXRJTXhtN0JaZURNYWVMSVVHWDJWeGVl?=
 =?utf-8?B?Yi9YTGx3UXZKN2NJR24vRHZ0dVQwakVrZ2pFNDhlY1crNmtIVVRRUTAvWDFL?=
 =?utf-8?B?eWpvRm9xNERrZkdGSkJUVTF5cTEvVHluVmxRMk54Rys2Lzh4eUNHNVhFNEh6?=
 =?utf-8?B?UXU3Z0l5Mm5EclhtTTR0VGkwOEJlOXVna1A0U2kyMEhBN0pubXdqdVFVOUs1?=
 =?utf-8?B?bSt5Y2V1aXo3NHF3cGRMZFllZk4yNlNtSGlkUXZlTytYREdGeWk0azRWYjQy?=
 =?utf-8?B?RkI3RDh4NjFldmtEcmd5NXhHY2IwbjZlMUxKOEJvNlUvVDcrYS9zUzJ4RnFL?=
 =?utf-8?B?S2U4V0k5cUU0T2lKVXFEZEptNUh4ZDlBalQveFVucWM2NkxDN0VMMzF0UGww?=
 =?utf-8?B?SnoyZGZmekxEejRSUDk0MG1FeC9tbFk0UXM0Y3Q1VWxpK283dm1vZEZmQmts?=
 =?utf-8?B?NU5JTzdWZ1pmT1NMUzJQRWhsL2IzeldIa3lJZnNVVm1CbGxobFN0Wmg2QVZI?=
 =?utf-8?B?YTMrbWIrTGt1OExGR2hPSHdNbHlOZjUwM2xMTmVSNkFaNVpBZHg3TnNTS1Vu?=
 =?utf-8?B?RlpYRUtDbkcxQTBBcTcwR1VPVUkxaTMxc0RFemdZMTdwTmw4TE5IQjd4NW1n?=
 =?utf-8?B?VzBwZzROeG5KQXdsOGNsc1BwOGxMcWk3VzB3b0s4UW1wZkNRVUR4VXE4M0Ji?=
 =?utf-8?B?VVlCcWN6L1lyOWxRcnNOMVpmMG9QNkdHbVRpc1M1M1N0NjY5TGdBdXRnejZh?=
 =?utf-8?B?M1FLaUVtY3Ayc0dtY1dac1ErWUNaK2U0eDlNakVjVFZKVE01T3pmSXFvL1FP?=
 =?utf-8?B?TVVBT0I5SVVxbDlqNkNHOHpmQjRhR3NwaFcwditNUGdBb0tYN2JmTkFESVB6?=
 =?utf-8?B?a0FsY1VsemFvTkJOUTljRHZRMlNPeHBGSXhENVphUHI1ZzFoc0VTc0hsN01a?=
 =?utf-8?B?SHQvc05SK1JPNUhLdktZOXZmMW5GM09tdS8zZzJ1ekVqQmRwNldDNjZ4STU5?=
 =?utf-8?B?bVVYZHJ3a3JUK2poR0x4RVlYWWF4ZmZhL3NoRVpuY210NUZjb3lWdkVtc0RR?=
 =?utf-8?B?cXZxSWhIcWJoVzZVVGtzNjRiZ3RESFBpQlFZTXFIUlNoMm9pNTBPYXpPS0RH?=
 =?utf-8?B?dWlqdE9GUWc0RUE5RkNZWVU4WlVXa3UwSnIzZ0dOblFFVnloN3A2b2VuQ0kw?=
 =?utf-8?B?S1V4RUhlK3JpeUhsU2NZb2ppMU15OTBvbnB5N1lEdHBYSGw4d3E2SlVyYnFX?=
 =?utf-8?B?N29FYldZZmN4Z3hzZ1RVbGpqUnpjQkpDT3phVy9aTWdYeU1yYnB0MHlFdy9R?=
 =?utf-8?B?dlowZlZxdmVqTW12bExibE1TZkFWQ2NvbVl1OXJJcEUwR3gwN25IRzBDd1JR?=
 =?utf-8?B?WVlySEI1WUgrVThOS0dPTDV5Q1A1QlBrcWNiaGt1UmZsamxDZnZxc2hnUW56?=
 =?utf-8?B?ZmQxTGRrRFM3T2tIbmdwRG9aWHJLRnZzZHRsdlU0SnY5WkNiTVQ5OFNtRWw5?=
 =?utf-8?B?eFFoZXVEd3ZXUmZxWWFuc1FmQyt4Zm9pUEU2WHQ3T3JNelY2OHhIalllMFFF?=
 =?utf-8?B?Qmw0MGZnczVKNDNrdGdqNkJOMW03MzR2NFlNZGNWS1p1dmMwb2hncVd3TGtn?=
 =?utf-8?Q?DK/wL7ctTCTBADkrfuNvhBWCA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27494ccc-e356-453d-cf24-08ddc51a77b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 10:12:42.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Dwa4Y4omBMCNYwnGusB8BaAQqtMUeuZ/m3DWbrOqh7z1Lw5Pns/z2vyvsBp/GPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

Lin I explicitly pointed out that you should *not* send it to stable@vger.kernel.org.

Greg and other stable maintainers please ignore this mail, the bug fix is going upstream through the normal DRM channels.

Regards,
Christian.

On 17.07.25 10:34, Lin.Cao wrote:
> When application A submits jobs and application B submits a job with a
> dependency on A's fence, the normal flow wakes up the scheduler after
> processing each job. However, the optimization in
> drm_sched_entity_add_dependency_cb() uses a callback that only clears
> dependencies without waking up the scheduler.
> 
> When application A is killed before its jobs can run, the callback gets
> triggered but only clears the dependency without waking up the scheduler,
> causing the scheduler to enter sleep state and application B to hang.
> 
> Remove the optimization by deleting drm_sched_entity_clear_dep() and its
> usage, ensuring the scheduler is always woken up when dependencies are
> cleared.
> 
> Fixes: 777dbd458c89 ("drm/amdgpu: drop a dummy wakeup scheduler")
> Cc: stable@vger.kernel.org # v4.6+
> 
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index e671aa241720..ac678de7fe5e 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -355,17 +355,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
>  }
>  EXPORT_SYMBOL(drm_sched_entity_destroy);
>  
> -/* drm_sched_entity_clear_dep - callback to clear the entities dependency */
> -static void drm_sched_entity_clear_dep(struct dma_fence *f,
> -				       struct dma_fence_cb *cb)
> -{
> -	struct drm_sched_entity *entity =
> -		container_of(cb, struct drm_sched_entity, cb);
> -
> -	entity->dependency = NULL;
> -	dma_fence_put(f);
> -}
> -
>  /*
>   * drm_sched_entity_wakeup - callback to clear the entity's dependency and
>   * wake up the scheduler
> @@ -376,7 +365,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
>  	struct drm_sched_entity *entity =
>  		container_of(cb, struct drm_sched_entity, cb);
>  
> -	drm_sched_entity_clear_dep(f, cb);
> +	entity->dependency = NULL;
> +	dma_fence_put(f);
>  	drm_sched_wakeup(entity->rq->sched);
>  }
>  
> @@ -429,13 +419,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
>  		fence = dma_fence_get(&s_fence->scheduled);
>  		dma_fence_put(entity->dependency);
>  		entity->dependency = fence;
> -		if (!dma_fence_add_callback(fence, &entity->cb,
> -					    drm_sched_entity_clear_dep))
> -			return true;
> -
> -		/* Ignore it when it is already scheduled */
> -		dma_fence_put(fence);
> -		return false;
>  	}
>  
>  	if (!dma_fence_add_callback(entity->dependency, &entity->cb,


