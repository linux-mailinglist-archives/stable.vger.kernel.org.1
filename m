Return-Path: <stable+bounces-141759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4395AABBA6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9843BF94B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7922E004;
	Tue,  6 May 2025 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAViuJs/"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077622126F;
	Tue,  6 May 2025 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513133; cv=fail; b=YZKyG18L0TsAzJCA3MRj95+PirHKFuvdlQ4de7UeQ6U+JobOqTB9qE0qlc150UcNfiBj3J0ZSY4oBH/LF3+/V7rcOmsWSLO76+0qCF2yOcFNa6pfREPUx3uEN9k1KfmSZv8JC2ad+t87fMw2RZdzWAHqjsdLd6Tbe+kxQ4h+8Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513133; c=relaxed/simple;
	bh=Li3qR0LYTBoS3u70lNuFdG0di5HlXLOj+IUUURcY1ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OmKjl0F5PLcXIH9rzuZWkE0r6AgMU2jqjBlI6uc9Ddn3Oz6hAxQJxh3VNxHU/rm8MQnbz6fdp0sonk32uVmyIgaPljLFlHEAUY5v0unO1uIvcTtUhDgz+/StKre+k/P5fwd7x3gJZsg9n9d9/od0GX4F5zVVLxAXZoMinIrL4E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAViuJs/; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky13auWYPB0TZti3TDHXj4khY6DgsclTVMcws+II4uxki/sE/Bl2xmflnRqRG9VKWHi+Uz+F8aFa+ff6g0qLvv1oePVLJ0ToKSM3O9kgdD9ql7X27Q3OZL9wko02q7DnNtNTSFkpioolPR3x0WCKWs0zN1XdJN0OTRfq1UyzlaaPTcvcTddwE4LzzW54tL0VMCBjO7mzaPwGHozWjE8AUMGQg7eaQdRFaQKgeaWeVho5I6pbQuhECVyn6qCZP1njsxfkfsxtdF7+PA9956Ca0+8eOvyRsOnZD2inDqYSaeyTvABcN4bwAnBy25yK8+tMFAixvb1e1/LWQBc4FRnbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL45by0biAlj7Yvb0TwTpq2j2cXJF//uaS5V/jYhL3Q=;
 b=TzOza5tkXNKgWrRpYf78PcV4Y3nJ64o5nWOy+XVKAD7nyaIm+o9VWFMhsFHyLIx1Kh9k60NKE6uth0omZZ5XRebBXSh7u6woJ7OtgSBE0tORy9E2lczNhk4AmUVLL3rcXwveq94AfdDcCnC9oEwwkV9c57zOslGCfSaskb55GEmiahMYcx7dIVwo3AaXzfBCek8YIw9/roEu3LjTJxoty2ZwDpZWPP0G2DdBvPcTKvJPPzLbw/7Rvy4s14ZFoMdlF2qsLHytdtdYT1caa//auLc/8pk4jSKJYQOew67AsiiUjupVkuFiQEm+Ly3sAqCQ/EAMvDvEVhB0pPfozZyHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL45by0biAlj7Yvb0TwTpq2j2cXJF//uaS5V/jYhL3Q=;
 b=GAViuJs/6x0Gu9aOisZqwxXR39MF0VwdWH0ZQdPsCvmqOoKLOY6KtBSROBtPmq2Bthj0IVV+OvlXNvYY19sKF/jvdN246USyiUMFOwXddTQvZXA9MZruMuz4ov64DnOiaUZ7lafepldkuvm+dP909USH5FQtJHHsB4MutUaud9mLpLMmvaaPqvg+/I497iH2OiUPiK2O5LUD3yYRwUDaWlD6AgV/Y3XImoNp8r7i8q+6eyySR8YX0D9qGwCOB9PUv6aMyLkz2V44FHqR7S593vWktdrJ3rIpolg5+k9e46HHSoYh8N/Q+eDY4XkYQhaYTzBXy4eu4EI2BnQwHmbPGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Tue, 6 May
 2025 06:32:02 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 06:32:02 +0000
Message-ID: <dc61b9f7-bc3c-4fec-8386-0f40fa869dd6@nvidia.com>
Date: Tue, 6 May 2025 09:31:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 519/642] net: ethtool: prevent flow steering
 to RSS contexts which don't exist
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 daniel.zahka@gmail.com, almasrymina@google.com, netdev@vger.kernel.org
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-519-sashal@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250505221419.2672473-519-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 790d1622-03f4-4fb4-fe50-08dd8c67b62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnV5M1RyYzFvMmpFTDdNcG4rcEJMQ3ZCZ2luc0EzV3lyclNKWEVYZlltZHlT?=
 =?utf-8?B?SEx4M0diQmdyVnNtZXhxUk5Db0Nubm1VRzJYdFNBVVpZQTcwd1hITjYzTkZL?=
 =?utf-8?B?alIzWWdVSXVjV1ZWODd0Ry8zMjNVWExja0M0c2E3UjNaZHNDUGVkUFlvZWJ3?=
 =?utf-8?B?QWhCNUdSWTBGaEdCRXR0M0xwR05RUlJHTnNvRXpNS20vS1NycmZzWUMxWjJt?=
 =?utf-8?B?T3hpT210L3BTUUtlUEs4RS9kS3NTOFVLQVJUbStPT2I1ZzFGL2x3dVVrOFU0?=
 =?utf-8?B?UUtpeGJKSDYrY3M3M21WNmpWbG1qenZZYlhhQnRZOXFZK2xRSVNiSGFUU2Jr?=
 =?utf-8?B?YlJuZTArc2JXbVhBSnRKa25RdXlNWGV3VVZ1N0MwS051aHl2MG4rWS95SzZC?=
 =?utf-8?B?QkpGbUpvZFRSODEvdldOZHhRM3FzNzJtcVVqNmFDOUxvZDVJY0VHVEx1L25W?=
 =?utf-8?B?RTJOY1VHTzQvc3U0aWxaeHdBSG9JbnB5cFhPV0hXcVZkNEplN1NaSUd2TDVX?=
 =?utf-8?B?LzhISThsYkk0UWp2dFdDVWxqY3BHdWpXd0NlbllXN0ZuQVFaRm1OVElzazRu?=
 =?utf-8?B?aTV6eFdUenQ1cHJiRC9ESENGWFBUWGpiZ2FzN21lUHcxa1pZZmFFZ2x0Tmcz?=
 =?utf-8?B?QjdKcm5TSzBxMUd0a2E0VnMzMWZRT1kra0ZoVnAwcHVwb3pOdUVBTlJTM09R?=
 =?utf-8?B?eDZ2Z3Y3NnpReHBrNFIycFdnV1EvcTV6K1Q1bFBuUFNTTmxpY2tFMVI0UEpP?=
 =?utf-8?B?U082ZGltYXJQSHFQQllSNUp1WGc4bFdXTmRFNEZ2ZFpXcXhIRmtPMUVSM1ZL?=
 =?utf-8?B?c2liSGJqRUt0NWVpRi8yNFljUEYvRmZKTEN2VWZJdy9XQjhxeWttVjZ5bTBS?=
 =?utf-8?B?YW1oQ0EwYU9Zc0pHYmxzSWtZbElBbFJraDVpN1pZcjVVeGIwV0RxL0FObDdu?=
 =?utf-8?B?R3REMVFEWHUxS29XRldnUWRmaWdvRzkvMjFocU9EVnF4c0RDcG5oL3p6TnZx?=
 =?utf-8?B?ZlNmUWtQSVIwSlRBc0Jrb25CbzE3NElGRnRaTVg1T1BqTndhU2dTK1pzSzE1?=
 =?utf-8?B?M1F4VzFiYXFvTlhXRUc1SXhUc2p0dHk5U2pmU2xnQ3k3RmlhN0xoWXRnMktY?=
 =?utf-8?B?cks1a0Fvb2ROWUNoVkNHTTFqNk1nOG9IV1NPUU9GYWpXeDJ1VzFHSXdVckRG?=
 =?utf-8?B?T2c1L0VlS1dwaXVsVnBDbW90ekpEVHFoNUJQSEIzQTRuU2ZqZ051dUcxbFk0?=
 =?utf-8?B?R3h6bmdzaWFmNzZkSjdSYm5uVGtMaHBLa1VNZTM0ZisxZGx0R2xjOFcyQUpH?=
 =?utf-8?B?Sk00TEVMcGRLSzhDMjI0ajl1UjJaQm5nTEN5STRRVHl0Ky92WXZNRzR2alZv?=
 =?utf-8?B?YTNyMnI3eEJocGhyazJuOGFUNTFUVHpqTGxyYVJUU2VFNzlaaXdER1dBaTc2?=
 =?utf-8?B?QVIvRU1XRWE5VGl6dzhhcmJJakozQjFRT0FNVzJXUHhxMHg2b1JDTW55MWJm?=
 =?utf-8?B?RzRjaDJMUXlFU25TejJpeTFocXZ3QW8zcXNNMy82OHQ4cmZNbFdTVUtWTjQy?=
 =?utf-8?B?MGVJbXU5clE0Nnh6SGErb0RtSlZ3WUkxOGJTY0ZrN3Z5dE1iNEpNUDRmTGhi?=
 =?utf-8?B?aHlBMVRaVWxNelNHbXBQdko1eVdQUGo2SjFCR1k4dFpiU29GaUtBcVlpYisy?=
 =?utf-8?B?Y3Q3blhxSzlIak1sSEJEc2hUVW9waXhIQ25IeTE1OXprVXFSL1NMY05nOFA4?=
 =?utf-8?B?cTJUYVNSYzNuYnJqSFk4UU8rZHBydnQ0b3BaaXMxVkk0UlZtNEhvVXJUVndO?=
 =?utf-8?B?MWxlV2hkbWVsdjc3SDFYdzVOczVnQkIyUURvdUdWOU5xUERrRnM3NW1Dai9u?=
 =?utf-8?B?Q0tmZ2wwWTlWRnpLb2RBMXhBek5XcklDOWNpMmpjLzZHdm91SHdXeEJneVY2?=
 =?utf-8?Q?7/Hv/Go+WjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9nZHAyNkZIYlRjQ1FCQkxaN0xxQWJ5L2x5aE50OW1oK3BhYkI0WjFsNjl5?=
 =?utf-8?B?OEYyVmErYzdiVndMNE9HQVRJR2pFTHB5R3JCNkRIbVAxdWExM1A2TmpMbi9u?=
 =?utf-8?B?RlE4aUdWS3FNY0FUbjRXdmZObG1MbzcrZVhubVhobm5FWG5IMDd3aGRuUzBK?=
 =?utf-8?B?Y3M0Tnhqa1lGdng0RExINzlqS2RLK1pTTWNBMlg0OXg0d01Ic3lJR2VSVkUy?=
 =?utf-8?B?ZWpyaUlJb2M4L3NoMzRYTjNTQ0QyZzczMG5aWHNtYXY4c2xKWWhYYjBHbHRJ?=
 =?utf-8?B?Wk9xODQ0dk01OTU0QkI4YkU1T2poQUVyUWpTRTZ5aUoyNHAwRUVlZndwM2wy?=
 =?utf-8?B?OWJLSnJIRERLeTNxR2s1SmhxaTc4aWJCekFOSTh4eDAxS1AraE9YWnpOdEpr?=
 =?utf-8?B?MU9yMTl6V1lBZm8ycmQwVStaWERGVG5jRGJuYjJBTU84U05BSHU5OTFTYXBB?=
 =?utf-8?B?NFphMjJiUzB2M3VadXhIcVF5S3BibUM4dFltdWlJKzh2R216RnFydnlLSGI4?=
 =?utf-8?B?c3NERFd5cER0ZzJzeCtoZTcyVVU3QmNTRUhCaW42aXdQRG1kM2R1QkxjUUY4?=
 =?utf-8?B?NlU1aGR0ZytYNGV3eXJhNVFrQ3o5dXljeEhrY0ZlbXZPYis3YlRvTUg1K3gy?=
 =?utf-8?B?TVZQZS9RSytXSEExVWp6VE4rU1VZWG8vUUJCb1BLWnFNQkpPb0IycjJ2NGdV?=
 =?utf-8?B?Y05QcEFvbjRwR2xLbDkrSUc1UnF5NDFOYjFiWlVVYzJJWkZmWk8rQUoramh0?=
 =?utf-8?B?b1F5Rkpteld0SjBIdXI0WTNKOU94VHByYVk1R09IaWNwVG1MK1U1MkxJOTVB?=
 =?utf-8?B?TzVhNVYvODRUMGhCQ2VxSlVqSTVleGZHWTA4dzJPaFc1Rm1VOHBIVDZNQlNp?=
 =?utf-8?B?aHptN1NIL01TRnI5L2EwUmEwZXBCcU9ya1VXQnpFWXo0VWNhL3djV0YrdWlr?=
 =?utf-8?B?ZHI3QWFYQWZhWTM2MURCbGUzZVorcmZtUWROZ05udTllMnBIbUFqencwMzJ3?=
 =?utf-8?B?eHZiV0hjR0MrVzBKbGJuMFFRKzk0V1BlSWc5eUJQNUZ2MkwydlF1M0FJd0RQ?=
 =?utf-8?B?dFJZbDNqbnRuOE9EQ09ucTVXbTIzVFhlcEFjS1RCb0VRd2RIRDFqbFhic201?=
 =?utf-8?B?THZLMEVnYk40ZnY1V2tkY1FnS2I4YjErdWJuSnM1Ykx0ejUvNS9IMlRVVGlB?=
 =?utf-8?B?dDc1U01NaVc5SHp2ZjB5MzN0NVdxUTl2SzlGT3pOb0s0L0RMMnJWTEJGTVJB?=
 =?utf-8?B?OE9aaTBMQ1cxNEg4REZzVjBBWmdaT2gxRzBLamlrNEdja1c0cU5RTmdabjZw?=
 =?utf-8?B?UFU4UHdwNnlQWW01OHB4cUJrcFlCOVR1WlpIVjdHZVNsRnlydnE4Ty9pc2tj?=
 =?utf-8?B?Nk1LUDdxNHhweHFDNzdzYUpCSTlPTmRiRlo5b0h5dS9IVUp3Rk85ZlBlVkly?=
 =?utf-8?B?NEhKOU5SZTdrU0tydFNMbG1YSGpjV2lDUWtkRkhpSmFHYVJGYnZtZkl1Mlcy?=
 =?utf-8?B?RGlRZXlyeWVDYVVRdzU1RWgydCtzaUw1WGh6V2hBMy9ISXZ1aWE5QXJZempO?=
 =?utf-8?B?T2JxNDVyZnpFYmtDUXdQbWE2SFk3UU5UMFc1VzVOK08xVHdoNm4zQVdFRko0?=
 =?utf-8?B?ek9lamNJZllwOHh4dnZaTm9lV21ObEFnakxMTkN3YldZY3JhMHArOTVBZnJ1?=
 =?utf-8?B?K2c5UFcrTmF4TTE2TUZGK09QZEUzVjQzdGhCblpITVZPc0xKRnI4dFVsMzFs?=
 =?utf-8?B?WmRKcjVpMWE3TG1VTGdBbzZHdTBwSC9aVXFhZzF5UXNMTklmR0tGTi90emIz?=
 =?utf-8?B?V2pUMkl0akJiTllESGJTbjl0TmFXVStueFBJdWdwZ2VReXhpWFd6bzdjNUhn?=
 =?utf-8?B?alFpQWN2N1FhTFBDNENiY0VCSmovaWx5bWFxOEs4eHdvazh3cjBhZFA1Njgz?=
 =?utf-8?B?aE4rT2drc2dwZ3FmeU1SeGRQcmpwempBaGlER2s0Z24vL3NMNnZYUG5VRWdw?=
 =?utf-8?B?cmFkRysreGl6SnJyTUhlbXQ3bjkxYzVSTSt3ZFFNVm1JcVMrNDFYek9BSnhM?=
 =?utf-8?B?Y09IenRmZmwzdDJ0WjlqdG1TdzBLS1RKNEwxSTZBZ0tQb1B1ektKWWJYQXRl?=
 =?utf-8?Q?usFMKW/9gKynUk1Cq4EyKN+ko?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790d1622-03f4-4fb4-fe50-08dd8c67b62c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 06:32:02.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNtuuk4DOz4UhlP/Pgp0kTCa0U/sb11FcG5EplzRd3s5TIwnhTcETR/E0ZwqQRZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

On 06/05/2025 1:12, Sasha Levin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> [ Upstream commit de7f7582dff292832fbdeaeff34e6b2ee6f9f95f ]
> 
> Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
> when in use") we prevent removal of RSS contexts pointed to by
> existing flow rules. Core should also prevent creation of rules
> which point to RSS context which don't exist in the first place.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Link: https://patch.msgid.link/20250206235334.1425329-2-kuba@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch caused a user-visible regression, I don't recommend taking it
to stable.

FWIW, I tried to fix it:
https://lore.kernel.org/netdev/20250225071348.509432-1-gal@nvidia.com/

