Return-Path: <stable+bounces-180995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15395B92760
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1DB7A28AB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE8315D25;
	Mon, 22 Sep 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3waNi1aS"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F6315794
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562780; cv=fail; b=MG9tiqHOti21ew2FA2zF438ipblO0qBfuxmQLMnpoDKFxWztKcC7IHAyjrqbEZ05UCNVEfpaimU7LvBPYx0X1UCvlr6acKae2m2GU8TrxBvXlu6Fi2cyZ4xkXnuHlud4N5NjnpszJWg5o2HYBahNfdzcVk5BPpI+2sFezS9UkFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562780; c=relaxed/simple;
	bh=DaDOIZt41+O4D7FbKKORel5lK5uScUgH6qd/Z/jHnJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cH+SYwi1yVIct7veuOe2g4a89SdyOUFP2sH7yPwabeuDIiCLCo5U1oXfSTVtN8tbY1Q/Qf4b4PT+366l5jWBvCM2kbpX5j+ZiRADZBiFDWDjhj0iDMtQw9fzM80kDKqmMsJGqUYzuXhaD277uRScQKlh3p/DRowO4YlanmS6ejU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3waNi1aS; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa5fsdybftnymaF51T+7TXPRmVHr47cmh69qIuOtEoqm0xmKyJ/s3mEA7uXEWO86eDXGt0LQv2V4FoZasZ5HfXdqH6yn425su1EewWYnX5gRJnVDuPWIw0U/GLfVPuuX2owccmRTDTD19n/vYk9Bfb2mtVJbECECXF4HXqe/pDOSNTI3q1LAGEKmL1ctdzlVucWkLBhPNEOIijL55tOUo6HqKRiDrc4VJ46PMuJcXFrfV5S5qgYDL7/6tIgDjBJ3V8OISqjNAkTHw48c1FqmFOml7Df5czS5kL6KTMycInvXSmSu1TaHTXuektgvhOj48NwRETM8UsEhXMnaqvASHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqe9bDUVwC3GHSyT79yTmBOzmd3rTkQtmHaBXYVKN+w=;
 b=jBniQavFF6sIj0NbAFIm2cZ4DYHow04iqDBIce0UrzdzMnj2DU/MBbDn+w8VpkoOFBGkZNnp7fOyYLbV3YSEQ5hmdqJ5vTC3PBGsxHRD36JKmGjK6TuzNln11Kae/c6clH51zfg2k+vE0GMcIDddKdMKUsd5uQ6XT5qhrq9/ivQjdQV2oAgkO9i6GWfssoESXfFtsZUxBeSC+S1qEi5C63XgB+y86MyeUaCmowt0UZPICd92FNY/yI+ZKfvP0fLNSlmwGArQL4GYWwgtdzNXZFItXX7fq2ahYhfB69lbkAkm+PpCQGCH9DFg6FqKGSN1AOUuyEIMAr9e0TyEkyuQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqe9bDUVwC3GHSyT79yTmBOzmd3rTkQtmHaBXYVKN+w=;
 b=3waNi1aS1KiJJC2KzaQBsnooh8B+yAHnSpVPMFLADf71T1keAbTVBE2BPO9n12jl3Ea+vz4AUc10oMfxReCIpk11U8gw2nCQBJD0yh1gAhjkUNF9KOW5q4IEsUy6K4s0lgftrqV+8J7tsBb5Vva8n+5uywRNEeWQtC3+yuvey48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 17:39:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 17:39:35 +0000
Message-ID: <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
Date: Mon, 22 Sep 2025 19:39:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
To: Philipp Stanner <pstanner@redhat.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b2a7a8-cc36-4fbc-6be9-08ddf9feff4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkpTelUvTDhEM3pHclFaeUNLb0JRams2M3A0aXdmcnJIQ0p4Qlhtd2N5VGF5?=
 =?utf-8?B?dWRQVTFZUGRWUVpzMlptZGpjZmpPeW5hV24zR3FIY2hlMk9lcDRFbnIySmk3?=
 =?utf-8?B?WjFnclZSQ2xqOUJuNHp3dnhCS29TejFoV0lya1VEVWxVQ04xRitwT2FOckwr?=
 =?utf-8?B?N1FBNE55WWkreWgrN0h1OEJZQ29YTjRqdEttalNmRFVIcENGN1lrMFBxWWpC?=
 =?utf-8?B?TVQvejVOZ1F2bitSSjJObyt1UmVDSEVwNGVjVTFIeFg2dzU1bFJhajA3c2RJ?=
 =?utf-8?B?azJ6c2lJallZeXVhVEJtUVM0OTVxamdLLzJ4ajFMUCtOVWdvRlFZYjNIdmkz?=
 =?utf-8?B?YmJNNjc3ZGVUTlhRUnUxcXVKTVZOa3dpazlPWXlPd3ZuMlc0WFd6NW5kQWJB?=
 =?utf-8?B?emFIY3o2cVlmWnptc2Y5b2RmZjh6bFdUZTkvYXNYN0YwaFlsVk5FL3pFV0po?=
 =?utf-8?B?WEVNaTM4dXllL0oweG0xRC9nNGE5OTFmZWNSK3o2OEVYb0JlMUlpMnVhSitD?=
 =?utf-8?B?b3ZnTkI4TWY5RDdMdnk5TGlINTRSeVNxZjZWaDZ3dUpZS1RjdUdzWlg4VWpM?=
 =?utf-8?B?MTUxNnk0NUQ0U0t4WVNqaHFEQkU4U3hha05WRHdjRTdGMjA1aTBVSTdXNm1n?=
 =?utf-8?B?aWVYaE9ULzVGTFFQdGx0WTgrRGdFWlRXVEk0ZUlQTEwxNnBrbjlGbEhHV1Fh?=
 =?utf-8?B?SzRhWEdZRG1DemF4QmVkSFZDMmtYSHlralVMaUJobVpZMnNVNzRxNUFTMFZV?=
 =?utf-8?B?UTR6c3VmaDllbmVCSTNucTVNbXhkTXkrcmNZbDdQc0RTekRmVk03YmVKcElN?=
 =?utf-8?B?OTNnNjZkcHhBYmFUM0lxWTNPeDhVTitrdVRvMmZCTzhXUFZ5WmRxbmt2d0JN?=
 =?utf-8?B?dGg4MnFieC9POEdGN1FpcnVXZUExNDlWZEtTTlNKTkdsaTYrT1lTU3RmMy9s?=
 =?utf-8?B?Q2RkSXlvZlBaR1hWMnM4QnZpeVVPWTVJOWU4VUFDQVZhYTlrc2hwazZodm9P?=
 =?utf-8?B?R2h3cUtRZlhTNnZLdlJrOURoREw2cHlJejNaaHlDdkdkRUY3VnZGdGpSeHVY?=
 =?utf-8?B?emZrM1U3cWpmTUU0ZkY2MmhIdFdaVC9IQjZHRUxuVWtFY1RFQ3lNUnh1T2VP?=
 =?utf-8?B?M3l5ZVo5aFRzVDR3Rzdpai9YanFYZ2Jndk8wR1l4Y0dDeld3TDZxanpIUEZ6?=
 =?utf-8?B?czJqeVhGTG9IUGRpdTlUclRoSnEyRFVkbysrblVLa1pSbUc2NDRidEZ6eW5W?=
 =?utf-8?B?dlhtaEZaeEVUc1M3b3I0TmlQY0N3RzRZNXIxeG1NcTJGVy9NTWNJQlNMRXhj?=
 =?utf-8?B?WHFTQkpadEhnWW9BN3QrOThtTFMvdlgrbmsvYWhXbE1VbWxOTHZHS0hmTjVG?=
 =?utf-8?B?S01oSjBtV1REYXU3T3ptMnNaV1RERDdraWd2enNLYXhFWHVEU3F6YS9pM0FP?=
 =?utf-8?B?NS84UE5heFlNMi9Ec1ByY0ZaY282am4rQy90aFJqbWp2ZHU4OUJIZjAyWjY2?=
 =?utf-8?B?WG92ZGwrQ1NVQjhaNHlsZTBUOGlZdHd1anJIcHlBblZ4bllBMStlekdLQ2k3?=
 =?utf-8?B?ZE8zSWtvcFh1dkY0SWVkdWZaSjkraEpLMU9rdWdQeCtEWkw4OGdGdjJ0ZGwv?=
 =?utf-8?B?VzFkcTNXdkd2bG1KQ0FWdmlKS3huNUZlRXJJTmFzYmFWZ2lFdGY2cXVlOTFt?=
 =?utf-8?B?aVhwbGx5aEk4bDVEcTI1UmJZRVYwWjlzbzRrTCtGdDBGdjRxUUxBd0Q4Rlkz?=
 =?utf-8?B?WWJiQW9pVC9jWDc3ZFFWdTZQOU5SU016a09lNUtCWDl3U3BEcnNqOTNZOWNP?=
 =?utf-8?Q?jaMIt9sUAK2Iva2kPxQ4BFm4t1d5YU+Xvn+v4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1IydEp6aDFBN09Zb01IV0VmUEtqcktBRDk5cGNMY1ZveUdsMzdYRnBlQzA3?=
 =?utf-8?B?VG1aTERsVjBrR2pGV2t2YWxiZnlRYUExWlB5eURaSHJGN3k2T2ZvU0RFYzNK?=
 =?utf-8?B?cHZlVGdlM2U5U3lOSXdFV0VyWCtiNTVCYkxFY1dJWjUrSDFwcXNKL3lBeFlk?=
 =?utf-8?B?cG9IdHZMNzVuNlZJczFPMVNDTUp5LzNubkxNMDJuQWR1MVRmL291YllUQ21s?=
 =?utf-8?B?QTU0MVd6d3F3T0VDYmFwMXoydUF3L2pQODFHL3hIQks0Y0kyU0xSQ1BDVGFx?=
 =?utf-8?B?dVVBU1pyVm5vbWNpNnIzWEs1aXBnYStkY3lXcXJEVlRKNDY0SUd5OGw0RXJy?=
 =?utf-8?B?cG5SMVVhVUx0dkV2QzkwdGphcjZuV09DdFdsNE16dElUeG5kRXNzVno0anBG?=
 =?utf-8?B?emZFVDVDQTBlbnErd2VFMkxzRVFzU1lJbGluYUlqYndIalp6Q1QxeUlqTExi?=
 =?utf-8?B?VDRPNzUwa3JQcGZhM2tsL1JNM1hRYXdjMW5IbHhBdllIOGIvVXRDQXhKenBP?=
 =?utf-8?B?OVRZZEV4TnpsVE5hZmZtZlhmaVlUOXFlRFI5bENLdlVKUDlrK0g2bHFheUow?=
 =?utf-8?B?OUZYOGJEbU5yZjNGem84QVdhZDB4bEc3NUVWZmdLSFRLUU1RQ3RXUVhhUnhw?=
 =?utf-8?B?aVZGMGJsZE5iT0FENCtLaDI0NU1xb3QwVFg2aG56VVhkTkx4VnBHVksvUVZi?=
 =?utf-8?B?cDdaK2RlRnVUZno4YWIzQ0dUcm45WGpHM05IaXU1dFoySEJjY1N2bHgxcFdB?=
 =?utf-8?B?UFM0cVVyM0phdlNKam9sejd0czNuRU42dEtWRmw0M1gzQlZlbzY2V2dIRVd5?=
 =?utf-8?B?TS9SK2NDYWw0dXNQN3ZJV2NLeFNnKyswMktsR3pGemhVZ0piMmluS1NOa2Nj?=
 =?utf-8?B?eWpyUnhUVFNGSUp3WS9sL09oUGViWFZ1cnBTVnF4NE50VU1Fb0lWdTJTTUZx?=
 =?utf-8?B?dGhLbk5ZWlNaTkoranpqNkpKbGpraGJKZUZSc29DUTQvUGttZGRzRVdWWDlT?=
 =?utf-8?B?cVpzYStJUDdXcmJHbENvem4vSzFFSHR4ZWdhV0xMNGlwaVdZSUVUdGJRMSts?=
 =?utf-8?B?a1JqYTNZdUxsMnJwVEFIOWpiNFF5OGVPQlZCV250aEF3KzJIMGpiZmV2SU9s?=
 =?utf-8?B?bkNzMmV2d2xTNDMzWUdLU2JmQ1VQSW9uVEgzdFFBaUsyaFkyMVlzeWxuL01J?=
 =?utf-8?B?dkMxVFZwZk5lS2xVRkJXblc0WnNBTEplNEx4NElpTFNYN2VFTXNpUUhBSk1y?=
 =?utf-8?B?aGNkMStmWEpwc3p1SDkzdGxWNFcyV2JQb0JKZEdGdHlHYjZkT2NOZFNwU21Z?=
 =?utf-8?B?VUhlWGQ1bEFYSWdoVFRkMTNXRDFJT29FR2t6K3VXNHIvUnRqS3pmbzRLN0R6?=
 =?utf-8?B?TUpuUlN0OTJRcnZVVHZtTWVTRTV4U0t2RWJNNVIvTmJDYml6T1QzRWNCSUp1?=
 =?utf-8?B?OU9lZWRRVHhNLzlRZ0ZWdkc5MW9sTGQ1OUZmUUx1ejhQTGFrUUV1M0U1WDhJ?=
 =?utf-8?B?bWNFVE1qZTFUdlJBU3E0cnUwb0NjVzVobnhTd0w2enM1dk1WampVWWcvdjBD?=
 =?utf-8?B?ZXRTVlM1SHpxZm1uV3ZMOEtOSmhib1JLYjNsSE05RlpZQVpwZUZvd3lZZ09y?=
 =?utf-8?B?cWxiSm0zcTMzQnM2MkVwR1c1alVqMlkrZUZwNWx0cGF5Zk5xQmdVT29ZUHJl?=
 =?utf-8?B?WUQ5aysvamx6YklXYWZpUzF4OTFFTEJOSFZRa0RrQ1d0b3daQ2ZPR0EvdUt5?=
 =?utf-8?B?QnNLMjI0T3kxc2NIeDBjK3B6TEhxaDROY2NrMWwrYU5QZnZFQk4xUmsva1Bl?=
 =?utf-8?B?SjJETVZLRHhBUHgzUGUvL2hSVkVxajFkS2hPelVySE8yOVVsbTBOOFpPRDRE?=
 =?utf-8?B?dFB3alFwMGxTUU5aeklHZ0UvS2owbFlwYWlYd1MybFZZbnljQ2l5VjVkYklt?=
 =?utf-8?B?VG4vaDF4T3h0SWlZQk5pMUpNeVJKcitWZ1lPUXE4NVBpM1dTaTdHMEU0eFdm?=
 =?utf-8?B?UHJLVUV5TkZwWkVjeXdzUGc3SXpNNEpVQ2xOaVQ0YnVFQlA4dFJLNEVaNzVa?=
 =?utf-8?B?SktsQzBjTGwwb2hQR0EwSmFRNEI5Rjd2aUxVazVVQ25Ba05YQ29WR2dzWVQ3?=
 =?utf-8?Q?1YLRTC4XQ/usWFbBIpRljT5IU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b2a7a8-cc36-4fbc-6be9-08ddf9feff4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:39:35.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnTezGTi8bjGpqJytdMAmlRzX5grnppM9ysJ1mAtj/1vfU0HCL23nNNTlVrZCiod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

On 22.09.25 17:30, Philipp Stanner wrote:
> On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
>>
>> In FIFO mode (which is the default), both drm_sched_entity_push_job() and
>> drm_sched_rq_update_fifo(), where the latter calls the former, are
>> currently taking and releasing the same entity->rq_lock.
>>
>> We can avoid that design inelegance, and also have a miniscule
>> efficiency improvement on the submit from idle path, by introducing a new
>> drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking to
>> its callers.
>>
>> v2:
>>  * Remove drm_sched_rq_update_fifo() altogether. (Christian)
>>
>> v3:
>>  * Improved commit message. (Philipp)
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <pstanner@redhat.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857-2-tursulin@igalia.com
>> (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> 
> Am I interpreting this mail correctly: you want to get this patch into
> stable?
> 
> Why? It doesn't fix a bug.

Patch #3 in this series depends on the other two, but I agree that isn't a good idea.

We should just adjust patch #3 to apply on the older kernel as well instead of backporting patches #1 and #2.

Regards,
Christian.

> 
> 
> P.
> 
>> ---
>>  drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++----
>>  drivers/gpu/drm/scheduler/sched_main.c   |  6 +++---
>>  include/drm/gpu_scheduler.h              |  2 +-
>>  3 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 3e75fc1f6607..9dbae7b08bc9 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -505,8 +505,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>  		struct drm_sched_job *next;
>>  
>>  		next = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
>> -		if (next)
>> -			drm_sched_rq_update_fifo(entity, next->submit_ts);
>> +		if (next) {
>> +			spin_lock(&entity->rq_lock);
>> +			drm_sched_rq_update_fifo_locked(entity,
>> +							next->submit_ts);
>> +			spin_unlock(&entity->rq_lock);
>> +		}
>>  	}
>>  
>>  	/* Jobs and entities might have different lifecycles. Since we're
>> @@ -606,10 +610,11 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>>  		sched = rq->sched;
>>  
>>  		drm_sched_rq_add_entity(rq, entity);
>> -		spin_unlock(&entity->rq_lock);
>>  
>>  		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>> -			drm_sched_rq_update_fifo(entity, submit_ts);
>> +			drm_sched_rq_update_fifo_locked(entity, submit_ts);
>> +
>> +		spin_unlock(&entity->rq_lock);
>>  
>>  		drm_sched_wakeup(sched);
>>  	}
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 416590ea0dc3..3609d5a8fecd 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -169,14 +169,15 @@ static inline void drm_sched_rq_remove_fifo_locked(struct drm_sched_entity *enti
>>  	}
>>  }
>>  
>> -void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
>> +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, ktime_t ts)
>>  {
>>  	/*
>>  	 * Both locks need to be grabbed, one to protect from entity->rq change
>>  	 * for entity from within concurrent drm_sched_entity_select_rq and the
>>  	 * other to update the rb tree structure.
>>  	 */
>> -	spin_lock(&entity->rq_lock);
>> +	lockdep_assert_held(&entity->rq_lock);
>> +
>>  	spin_lock(&entity->rq->lock);
>>  
>>  	drm_sched_rq_remove_fifo_locked(entity);
>> @@ -187,7 +188,6 @@ void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
>>  		      drm_sched_entity_compare_before);
>>  
>>  	spin_unlock(&entity->rq->lock);
>> -	spin_unlock(&entity->rq_lock);
>>  }
>>  
>>  /**
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index 9c437a057e5d..346a3c261b43 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -593,7 +593,7 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>>  void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>>  				struct drm_sched_entity *entity);
>>  
>> -void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts);
>> +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity, ktime_t ts);
>>  
>>  int drm_sched_entity_init(struct drm_sched_entity *entity,
>>  			  enum drm_sched_priority priority,
> 


