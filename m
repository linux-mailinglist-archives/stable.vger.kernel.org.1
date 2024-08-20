Return-Path: <stable+bounces-69739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88EF958BBE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6195C285B25
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93949194129;
	Tue, 20 Aug 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AHlSm64y"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC119148F;
	Tue, 20 Aug 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169518; cv=fail; b=PZ27UN+GYwNo1iv7XbX7MQvhU+Co7bvKlh8E79FngDbQljf4lhuN3NUUYi54Di6MwCaq2N2P7hRdShMZJXAp2J1CER2l/pzbiYE+phb8zXUatfki9MDJtXT8zRpkwOCW6zS/QNxHkMNm9b8LZNlTAzIipEv9Ua/zmtGfMW8RJbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169518; c=relaxed/simple;
	bh=AmiDgTzFnJcMYFtgNpPdbjeafxkqK+rokT1UbtjeO6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEuLqkZylsNur0d8oyl8fwoP+UwX+EpFpvtISgEaXEYyvrC81I97oSE1xwx6FX+M3d+Lu/7ZGSG2Ym+7gk0OfHrLPsDdNYsTa9G2s0/UNoHvNWK4ikeGNhjIzpBY1d5eiwRAMJeyrAIInfzdBbc4aVOia80D1DxlK9ov3ixV79g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AHlSm64y; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOEOh2UpVqwJEpyhw/t1+joiRsLEZv4j2EpuUw+BBOFNoKBjlplvxnd7Li2o130wgSMwiY9gp292CeWZFvIGPBTLjgCAsLJ0i37rfCpTSfRLjAQ7IQ2phx/W3tmsDvTjZlaLygTf+47pxtiSuqpJy9gd0ausSWDhvZUhV0pHfx6kCLIj0gwZ/WBvVjsZcWwWwqwbr9EItxK34UgtSk7hSiaTSO3NHtDHgX+CTG0MNUPCFf+5VI70iMxGLEFGEs+tLXi7pxFK/MlohW1r4EPErc9So5k/cfXfLXVMv2i2/t3bI1rK9Sc1aQzc3RLOPiU/rqTbvHiCURqiG7xzETt1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+S2PEc0bxxe+iKO8RUx3NL+98AeIA+LN/JD+0yonWg=;
 b=M/C0YxTAUb2JsFkn8/J7ntkvYeBVjUvG5BZkgc0VY//MriGWmHRvtv6wBMxVsq6gEWmCUFVsR1wUodPZMa58eclHEXJL05zP2Kkd8kZj/bklIewUJF+0SJOBbzvM9h7stZZRk3Uo8EFmV1jWzUDdodfWz+45fgIFoywVs0QETEckyKTvGVIygLTpn8t4Rm+NFcpeIUauU9SBgRnkvnwjJqjuIOTOsjWEJugiYd37RWRFERQUXCi5gUo/eW3A9Pw2CW7AfGNwQi/BtWUwq7bHHrUnbMmYWra0gP2zt67h9zY1/+0ceKTFb5lfGb34/t6cDcjgG8yMyY0HLmlwqvxxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+S2PEc0bxxe+iKO8RUx3NL+98AeIA+LN/JD+0yonWg=;
 b=AHlSm64yCMJRpRPHjqYhretSoyeCkYO4iXY2J3mgK/2pO1Co4BLtqZ7WKOKM2UZ+mo3lSIs+YB1ugsR30aqcr/xnjRhVZlHYkN9Zbdq7EunVnmJ2ov2Uhf5biznGsyWnBebRyfGNvJLrAZHrgIDzo6ubULHCfyUZgNvyjWFk/bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 15:58:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:58:33 +0000
Message-ID: <16bbce82-35bc-4ee7-ad00-b8319148a415@amd.com>
Date: Tue, 20 Aug 2024 11:58:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/amdkfd: Move dma unmapping after TLB flush" has been
 added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Philip.Yang@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240820120055.2972871-1-sashal@kernel.org>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240820120055.2972871-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: b30d698a-3181-45a6-8aef-08dcc130f167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9YczBwZng2am8wWGdMNzFBUlBkYmRETGhmYXQ0amZqdHM2UHQvS2RTSGE2?=
 =?utf-8?B?TFNMOUJiTkZ2UVJhMks4VkRrQzVRNXdUaUVsb0VLa0lYTmwrdVNaVVNLdG5o?=
 =?utf-8?B?bHQxaTd6aDBwcGhjeGlZU3pCaGNPL0M0b0h4djNueVpkV1BJNEZidzRmYnQ2?=
 =?utf-8?B?YWljTWY0MEh3UFJHbkhvR09nREdYRm44eC8zUlZ2VUV2V01Qc2NzYzBDVUtZ?=
 =?utf-8?B?bnVLWnZNaUZCdVlWS0lnQm0vSGw0NG9CY3VTQWpnV0xUU3pUc0g5NnFrVTlk?=
 =?utf-8?B?SXR5UndmcnFyMkhsTnczZHh0R0MwWDZRNmFob3FBVU9GclptWFFKeEg5RFdG?=
 =?utf-8?B?S1AvbTRNVytTaXk3QVpoS2llSVo5SU5GK0J5WnZEMkIyNnpWbjJlQmVCdWJo?=
 =?utf-8?B?QnJFMTQvc3lLY0NJTklaN2o4Q1RXOWJFZnJ6WldmZVFGTklCUk5YWkVIWWxH?=
 =?utf-8?B?UDJ2QzhubWZvUkl2bmgxcitGWWlkRExRRHRqM0xjWXI5T1crTDdqQSt6WUhu?=
 =?utf-8?B?RXZVak96am9Zdjl5bXF3WXQvaWhMR1Rrb3JRNXRydFlwdGxYUFY5cVRZcWQr?=
 =?utf-8?B?b0d2dE1kVmEvL1JPbUZZZngyN2xYYUpyYzlJWTBibjE0cTV1d3owajhTcUNF?=
 =?utf-8?B?K0FXUmVuVGIwMjBNczdYSitCRUh6WXJRMldUYUpiR3lzOGN3T2ozMks4VHlW?=
 =?utf-8?B?UmxveWpicDBhRGxDeGh0LzNtb3VjenNRU3VsVTVQWDdzejdiY1dQWlgyd01S?=
 =?utf-8?B?dkFXa2V0QkFtM2NSU0tjWXY5WXBLUGJDcklkYjNnVkhlaHg4TjB2dmU3SFVN?=
 =?utf-8?B?T055anRPeXQ3dHA3b0kxSWdiaXR2RGhqNnJLWTlXczYvTVd5NUZsWXZhWnFJ?=
 =?utf-8?B?MkhzOUdaV1BVZ3JiUVpLTU5mdWF2N1Q1SFVRME51aFRoVW5oOU1oK0pPTWlU?=
 =?utf-8?B?UEFaSHduemFNc2RlbEJRcEl0VzhEUVVYVE5OTjh2Rm5KYy9xMVRMeDBGR1Ry?=
 =?utf-8?B?UzRQMlBmd1hxZHpIYTNWTkVzekZzNmFIRXlCb1RoaWRRbGhXbFBjWUF1eDdo?=
 =?utf-8?B?NCt0WEJsVC9zRWw3R0MwS3NlL2pYYzBUZFpNQU4yQlBienV3c0o2YmZTU0pC?=
 =?utf-8?B?UmdKSjY5NnhWVmV3bU5WT3Y2aHBPbWJxRzlkTVNOanhwWWRqelhVbDROdzlv?=
 =?utf-8?B?VW5MYnF2NndLYlM4a2FiSFE4QU96Nk5yTEtaT0Zoek9sV1IxWXM2WEladjR6?=
 =?utf-8?B?WUdoQmRvd2tPTmN3UVNSQ0MvaGRvOHhlcURkeFY2Z3ZUOGJnREt2YkdObGt4?=
 =?utf-8?B?ZzBIOTQvanducHFmc3ZlcnZhZHNuVWFJY25HKzI3VjV2OXo1R1FpNVFtYU51?=
 =?utf-8?B?Z0dGcDJzOGJYSkY1QmNsOUtPSmhwMWtsclFSbDlLMGU4VVFyQWlaa3E2bGlo?=
 =?utf-8?B?bDMxQVI1cTNtZDMzMVMrKzFDc3VuNUxxSG5kUXBmMlZmRzNDelFPc3dBMGJJ?=
 =?utf-8?B?aEJPYkNYclNTSC9pYWlTZ2tONW93S2J4RXpnNlcvUll2V05weWZiV21RV2xD?=
 =?utf-8?B?TXBlVVVqYWlmT0N6N0RkMkJGaUQ4bWJCRnFjeHVDODlKTUJWcmdneXc0WGU1?=
 =?utf-8?B?c3lTMWt0YU1VUFZFazVXd0cvWU04NkRDNEZaWTZzbVZXblFhaU9wOTFXSVJN?=
 =?utf-8?B?SHVUZzZhRldjbkFpT05hZWxOWTZvT0ZBU0pRaWxwNllXNlhGcTVzTWFGUkkx?=
 =?utf-8?Q?4fzlQy7PdMVj0TYedw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUZGT1ZmQ2JURjA4WmxEeHV2S3ZVVmV1cUREL24vWGltNUZQdk1NRXlkSkN1?=
 =?utf-8?B?RG1JVXcyYldDbG9CRmFVRnNxZFdxVm5obkVvcU94RXBxT0EwUzhYQUFjQ3I1?=
 =?utf-8?B?dS9oMDVVajZjOUsxN3NCTXJyRjRTRFdKL2h3UFJEczFGZkR0OHpzclViaG5I?=
 =?utf-8?B?Wm13U0laakc5WldTbnUyMjVJL2hUaDdpY1VQclVCRzRscFlLZllwaVJKSS9E?=
 =?utf-8?B?cGlKaVJxSXlDOTN1NGFQUUx2NS83ZFdLdHJoeXV2dFJLSnY1dG9hVnI1Unky?=
 =?utf-8?B?cWIvQ1U2U2NENkZnUk55U3pBOWhyQTI3a3ZoWENUY2JyTkZpYndCaWQrc202?=
 =?utf-8?B?VjNkVFViZCtZYlF0VkhqK0xnZ3QrK21tZW40YWcyY0dlejRvVWtKQWZ4Nldn?=
 =?utf-8?B?eFR3SHlSWWFqNEhIeWJ3YzE2dktUNDh2ZXhQVDRyeUxJdmpPVjIrZG40QWpK?=
 =?utf-8?B?aTR3NTExeFdqYUJKanVjeldJVlZJZ1hSaVUrSk9OMG5tMVFXbE9xVGZ5Sjk1?=
 =?utf-8?B?dmF4TWE1cnUrb0ZOeDVTNmJQK1JyVEV4cE5jWjRwc2l4ZkxPWDZaaTJUK2ZX?=
 =?utf-8?B?WUxSTFQzUzI0OWFBazR0b2lMS0ZFelE1VUx3bUZVeGZGU0tReEtnb2hPSXZ3?=
 =?utf-8?B?dUN0SlZESTRGM1kwZ25HNUd0MzdkMGVCcXppbkNBMDVSNy9nQlhLUGpJaDZM?=
 =?utf-8?B?SzVJNy9oQmdxMS9ZcWEwcktORkxRLy82M1FPREVEdUgwSmVxdXJCSVkwamI5?=
 =?utf-8?B?bnN4SCtMV0sxRUJQenE2NnJmTTU2VVZyV3NPZk1KTU9iR1JqdGsvMVJ0MWZs?=
 =?utf-8?B?U0lVbnp2SnJLUkxsdnh3VDJ2KzFvcUNvZno0Q283d0g0aVJ0VkhPMWpueDRJ?=
 =?utf-8?B?ZWhLQUF0TVUwWlljVEJaR0RlRXFUYzV3bTdtSmdsMEw4dHVVYlBiSGNvT3RQ?=
 =?utf-8?B?N205T0NWT1VWbisxY0J4dDRjUnN5R1JTWFJIRS9UTFRhWU1mSmFuMWRzQUxJ?=
 =?utf-8?B?VTRraUd2TWNmc2JwbHJRUmcyalJOeFo4V3Nnb1JuQmI3SHl6R0RNTG9xYnNw?=
 =?utf-8?B?d0M3YXQ1dXRtQTc2Z29jbzdMK0VmZzJzbllldU1RSmNKazZKVTI3WDJycWJa?=
 =?utf-8?B?WDJHeW9MamV6YW16Sytqbkx0QnkrLzdlUWpyMjVudHFuRXdNRTJkU0srcEZ2?=
 =?utf-8?B?bU1qNXprSWpxUkJ3U1FSd2h0Uk8zOFd0dk1FalJCNVB1UUs4amZKVW5jZFZh?=
 =?utf-8?B?WndkM0JPdk92RVBmYmpJSjViMm83SGNNT2lCU1ZlbWtrSDhCazN0YlNqU0o3?=
 =?utf-8?B?OTRGK1ZZcThaYjVyM3R0RnZkVVJQK1l3Nm42R3J4VkJPdTVaWWJHTklYMEFF?=
 =?utf-8?B?ai8yejNWd0kzV0NHUEc0VjZ4NVVxUGJYNURMK2luMUFmVHZRKy9qZ21vVGVy?=
 =?utf-8?B?Sk90QmJyQ3YvQXU1SWdmeU1vL0x1QlRyMU9iVm1oN0NmdWYwaGYzTFk5SW1h?=
 =?utf-8?B?d0svWU55WmY2MDNNcnZEQkZNVjFiSFdPNHlhcDJGTHY3SEJFRlFyS00vRGp1?=
 =?utf-8?B?aGt3UGxDUFJVSkc0WmswMVMxWXZ6TFRQRGZ5eGRnT2tudXZ2VDAvLzBKdHpp?=
 =?utf-8?B?SGtwTzVMeVNwZlViRHFsZU5qa0JYRXZKZVdwTGZPQ1owVHNiK3lhcUN4cC91?=
 =?utf-8?B?bzZXeDdkNCtWemw0eS9hVlIyTUpmV0p6TTRJdDI2VytHZ1pxOWdxNnVQamQz?=
 =?utf-8?B?K08rTUd4cjlCSFZEZTBzWXYrd1g3UU9QWHEwN0RCR2JYSmU1RTFGODN6VUxF?=
 =?utf-8?B?S0VEckc3UTN1bHZhcGdaMFlMOEs4UzRmUlhhazlyelNWQWFOUGNidVh4dXR4?=
 =?utf-8?B?cTlza2xoZ0Zrd1NESVdqWm5JOXVseWdTUE1Iei9ScjNBaGFieW5hRGU2aHJw?=
 =?utf-8?B?TzllTlMzdGxveGtpbnFTSjNyUVdsQmZWT0dYOE9LZWd3b2VDWTl0azd2aEJ6?=
 =?utf-8?B?QWsvdHFWenllQ05GZUJCTEw1TlV1OVJyYVQrODR1NEZvRkdGVyt4WkNNN29I?=
 =?utf-8?B?bFBlSE4vM3BpQk9NeGVBWGpISk5xMUhJM0xMT3h4dU1ESkxXaEtpUU9sUS9V?=
 =?utf-8?Q?/oSbASP5L6DpLoyIOiszArTEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d698a-3181-45a6-8aef-08dcc130f167
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:58:33.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cA70gUTsOMIhkpRGFlYDAs/bHte4s3VYE6CQQkXRm8pul3D/CARgM+tBEK+tgA5tgdFigqtkBFlS0oeOuTfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

This patch introduced a regression. If you want to backport it, I'd recommend including this fix as well:

commit 9c29282ecbeeb1b43fced3055c6a5bb244b9390b
Author: Lang Yu <Lang.Yu@amd.com>
Date:   Thu Jan 11 12:27:07 2024 +0800

    drm/amdkfd: reserve the BO before validating it
    
    Fix a warning.
    
    v2: Avoid unmapping attachment repeatedly when ERESTARTSYS.
    
    v3: Lock the BO before accessing ttm->sg to avoid race conditions.(Felix)
    
    [   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.708989] Call Trace:
    [   41.708992]  <TASK>
    [   41.708996]  ? show_regs+0x6c/0x80
    [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709008]  ? __warn+0x93/0x190
    [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709024]  ? report_bug+0x1f9/0x210
    [   41.709035]  ? handle_bug+0x46/0x80
    [   41.709041]  ? exc_invalid_op+0x1d/0x80
    [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
    [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
    [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
    [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
    [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
    [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
    [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
    [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
    [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
    [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
    [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
    [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
    [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
    [   41.709967]  do_syscall_64+0x3f/0x90
    [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
    
    Fixes: 101b8104307e ("drm/amdkfd: Move dma unmapping after TLB flush")
    Signed-off-by: Lang Yu <Lang.Yu@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Regards,
  Felix

On 2024-08-20 8:00, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/amdkfd: Move dma unmapping after TLB flush
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-amdkfd-move-dma-unmapping-after-tlb-flush.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 23f8ef0f6e5deee5814fda6ec2e2ee4c2f19a384
> Author: Philip Yang <Philip.Yang@amd.com>
> Date:   Mon Sep 11 14:44:22 2023 -0400
> 
>     drm/amdkfd: Move dma unmapping after TLB flush
>     
>     [ Upstream commit 101b8104307eac734f2dfa4d3511430b0b631c73 ]
>     
>     Otherwise GPU may access the stale mapping and generate IOMMU
>     IO_PAGE_FAULT.
>     
>     Move this to inside p->mutex to prevent multiple threads mapping and
>     unmapping concurrently race condition.
>     
>     After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
>     kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
>     before free the mem attachment in case failed to unmap from GPUs.
>     
>     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2fe9860725bd9..5e4fb33b97351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -303,6 +303,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>  					  struct kgd_mem *mem, void *drm_priv);
>  int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>  int amdgpu_amdkfd_gpuvm_sync_memory(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 62c1dc9510a41..c2d1d57a6c668 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -733,7 +733,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
>  	enum dma_data_direction dir;
>  
>  	if (unlikely(!ttm->sg)) {
> -		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
> +		pr_debug("SG Table of BO is NULL");
>  		return;
>  	}
>  
> @@ -1202,8 +1202,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>  	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>  
>  	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> -
> -	kfd_mem_dmaunmap_attachment(mem, entry);
>  }
>  
>  static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -1258,6 +1256,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>  
>  update_gpuvm_pte_failed:
>  	unmap_bo_from_gpuvm(mem, entry, sync);
> +	kfd_mem_dmaunmap_attachment(mem, entry);
>  	return ret;
>  }
>  
> @@ -1862,8 +1861,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  		mem->va + bo_size * (1 + mem->aql_queue));
>  
>  	/* Remove from VM internal data structures */
> -	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
> +	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>  		kfd_mem_detach(entry);
> +	}
>  
>  	ret = unreserve_bo_and_vms(&ctx, false, false);
>  
> @@ -2037,6 +2038,23 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  	return ret;
>  }
>  
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +{
> +	struct kfd_mem_attachment *entry;
> +	struct amdgpu_vm *vm;
> +
> +	vm = drm_priv_to_vm(drm_priv);
> +
> +	mutex_lock(&mem->lock);
> +
> +	list_for_each_entry(entry, &mem->attachments, list) {
> +		if (entry->bo_va->base.vm == vm)
> +			kfd_mem_dmaunmap_attachment(mem, entry);
> +	}
> +
> +	mutex_unlock(&mem->lock);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>  		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d33ba4fe9ad5b..045280c2b607c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1432,17 +1432,21 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  			goto sync_memory_failed;
>  		}
>  	}
> -	mutex_unlock(&p->mutex);
>  
> -	if (flush_tlb) {
> -		/* Flush TLBs after waiting for the page table updates to complete */
> -		for (i = 0; i < args->n_devices; i++) {
> -			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> -			if (WARN_ON_ONCE(!peer_pdd))
> -				continue;
> +	/* Flush TLBs after waiting for the page table updates to complete */
> +	for (i = 0; i < args->n_devices; i++) {
> +		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		if (flush_tlb)
>  			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -		}
> +
> +		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> +		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>  	}
> +
> +	mutex_unlock(&p->mutex);
> +
>  	kfree(devices_arr);
>  
>  	return 0;

