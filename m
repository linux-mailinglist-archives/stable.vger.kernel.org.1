Return-Path: <stable+bounces-223325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAmFGRqxqmkAVgEAu9opvQ
	(envelope-from <stable+bounces-223325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:48:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D047921F1DD
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F253008E22
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BE37D12A;
	Fri,  6 Mar 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p++0Tm3u"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F98344D86;
	Fri,  6 Mar 2026 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794133; cv=fail; b=GxVnj+x3e/nGwzxw+Si9bfzHQXKBCHEXQKqtnERAYKYvPxiAtqPruLxAcHGVf7uD8wrgqcDB9Q8N3YVxph/O2+SGj+rQ4/xC4D8LpxFW9VqqxU0yzTZtkgdj2yTJYcDJdq8Vabk2aJOuGvblo/CGTWRwmRTFmfb7mnUOplhlHMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794133; c=relaxed/simple;
	bh=JzNeeee0M9VJAieCXkhw/di80ZKa05SWwmvC0UHSNFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VnQa7eAt4iHiOksEDNic8LRKuPyv6t4RK8QkchgqZiE2iX23jryDhh+s1dUq+LX0aR0WZBttY9sQb2dftso/b7kW3BslwgsRYlq35zjp5JfoaLo1t9bMOCm0/QTCn0kieCeCrUBud8NTE9fjQQ8k+9AqgQ7F1qc3Jyu+PLYayGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p++0Tm3u; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo1WHEKurkP7Ge6xNy3IgWNYnUqHjWG5hlUOyXhCjePqFGOCkQeSYuLnMR79dISkv4DiPR+4aTK475yK8XKMD+40xz239jPOWSDP/8ViQr22dIw7Pwqfhww4ZK7QeiVmReFHlSRc2xM8eXDzrc1kU7uZzsd5tCl45kMFz7PZP1o99AkNbyqMOCojxzOiziP6Nw1JgkElHCTNPEAVDXGSJ61A5Ws84AMjQ8xSgxiZl3M6pxqZo8JnQC+ILDLdjWlDoBPP39Wmgg35e83oE2nbvmpuUs4nQzneL54IJt6Yp25Ty3LadzpxAqfqsEqVTkqi9kJ428b4/KZWDbh4qjtH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCRckrB3cu+ypQYYp1C4zGcWteJsxI5yNHONpsMGif4=;
 b=U/kTL7UclwNcOxOcTzezVDOsHWCSBNyP/0tATJJ8T14/Nqvxfmbs7XoxfpB83reU5cg7CzvaPUNOKE4HkuY6MKMIZGkSlZbFSj2pYaL8OOJhbDV+L9MXyV4JejkCT8gu8XlbWz2akft10JVQmqBUG6nvKx9g5YoRq5F83VOeXYoGzoEmBUL+JTxjUrKM2LMKFe7M09WX4M2dqjMzGREuQbp/oi9ZHgxD5HFLmfRNzTI3xTKTDHHlGOrB+zbuSHpf8cDWnD8yZs99VWuN+yXbb2mpligOTMepoX/Zj+wpoxaA4YMagUlwdu0EpTG3SgW4BTwceADYYCIes6JB7oVPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCRckrB3cu+ypQYYp1C4zGcWteJsxI5yNHONpsMGif4=;
 b=p++0Tm3uGwGMA7DSjf4Z7E8EE0anCahwJXf2d7+3QKRl1K9Cr64OocysJREjMaTFe5LEOttZSFMEeyAlehdKfDqRyLzJwCMkFl/MhZijXd5gTW4YeVoKR1d4JTRYnPXfxUt7Oj4LccI/dwHOOqaTUcW/8FLrEIRgVdk0XkkWkXRY9W9JVv6QYAPa8Vjs9ecgqXnUdgwjjJsyeLcPp+kXeNnFyG73KyK8j0MYHwAbI4VzusvzcJzZbklIDe4HGaDUTfQHWBjjHODaGrhVCGarMQ0uTdDiRW6wGvr33e8Q+V9g3nUzIEgrwxSgJUHyC9mfSV2pSdH5H8BdLwUjBPCSoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 10:48:45 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 10:48:45 +0000
Message-ID: <32970563-29bf-4569-befd-a8f4c5a3e689@nvidia.com>
Date: Fri, 6 Mar 2026 21:48:39 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>,
 stable@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
 James Houghton <jthoughton@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260305-contpte-fault-loop-v2-1-0216f0026d7f@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260305-contpte-fault-loop-v2-1-0216f0026d7f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c8aa83-1b03-416b-1548-08de7b6df0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	lemJEiLHlZCxtqwaa81xblJ9i2qy4L9oG3p6nKvjpJ0oCVM1wvMXdnvBS5RTJpi1eddzZFFwOAIB87LkAIvkpT6rEo2cswkakTgs7ZGEJBrWGPx1vUecvSiGeVQ3lHQ7B7559lvOHyKCdbbTxX4kG9Qk2/rpU6BDO/saoGTEsH2SlibjwOUZo7JeYxkUl5EvydzdDh636Li+EKNSPlb++3+jpV2sCgGnrlFqhnPbGT3RMuHydMv3NRsm+wBKdc3fqysVu7Yi0IGPKZDDujX25vQs8Pn449Ki/twGar17bfbesR4sByWhloJwAAoUTJ7uZsJJZC1KDwONSDMxaaZzBebQW2gpEHUp/H8iRuyhQJyeIK7U1CS6HJYnV+UjRjQxKfm5oVyHkEg3a1eZN/GaXR7NkWG0tHD3AzsdslBnB2eLMoLADIizxq6Ue0LwX9OeBvxk1fy0eyNyGnFS/pJrnHDb3KKRspnQUJrpaE3Vb03iO8RkOn1A0Z5Y8teUAmeOicHgMFU/PmJ1XZ3+Rwdy9VKPwfBu3sU9JKgmT7b9DgaYbDgxvVs0SXVQWrIiaelAXpDYOH+3MTKL/C1x6Eb+EkdG9IZtdqWDLYmF3nVBfjujOsRHzc5lPH/b5wE11QtYlIzweZpnzytyEYOBafYEUiuIPEiuRMtc2ifo+S/sSJ95tGax2QXRAUz3xzx5IT8r3DHw9HDiHTS8hDon4fG6lAnDlYx9opnJG32CZWjpg6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZhT3Qva25JUCtMd0ZuN0twU2RIV3ptNmhuWmhEUHEzcXJSOVlOZXZBWDZ2?=
 =?utf-8?B?YTI3YUhmL2lKU1d0L1hIODExZzdRc3hydjN3SlI3eDJRVWdtMWxKaXpFQm5C?=
 =?utf-8?B?SGttU0xiOUpmRXZ3UFIzeFNTeGdoL2tLUzJjL2VDNmtVTnd6YjFnN1VGcy9S?=
 =?utf-8?B?SXlZRWl5dDljeFcvakMyK2Z4UGlFVndpWWc1b2x0M0NRQ09ucjd4dkJpUGEx?=
 =?utf-8?B?UzFHUldHZTBNRVJqdFU2TEpNZVFVWHNQWFZVcHNFNTNSWko1Uml2Q1NhYjVQ?=
 =?utf-8?B?ZEVieWM0WWw3MzR5cVhtNXpzVVdnbklGcHJ2SHZVdXBpQVNtbVhhcUVNSzJK?=
 =?utf-8?B?UjZiSTk5cnhIYURHVEdiWlVzdzU0cTRZbGJsTnZPTkt2elB5NlI3ZWQ0UGk2?=
 =?utf-8?B?SVZ4QkJacUNORHlycTl6bDBEZEQ1QWxXQ0R1a3B6SkZVRytCYU1qYWJkbXdC?=
 =?utf-8?B?NFQ0UEtydnNuZ3o1by82dG10T2hTbUVaNDBhaVZSS0dEa010RFFKNCtjdUNP?=
 =?utf-8?B?M1ovWUU2VjdhbDlra2VscmFTMHh3WnRxRERCWHRWeXVhNm1DZWtJbkFnakIw?=
 =?utf-8?B?VGM3TThjNkc0cWRKWG56bXMwdWN5THBYdmovOU56VlpaOHFTcGpWaWlOZ29W?=
 =?utf-8?B?by9rZEhtVUhKQlE1a2NqZjlKSUhkUVlGVHRQN21nWFg3WVF6RjdSRWdzTkNr?=
 =?utf-8?B?QURxZVRzLzVxVVZqc0JGbmF4ZmxUTXFxUTFZalMvNlF2RzIxTUdubDg0RkpF?=
 =?utf-8?B?L1dQTzlCUTZUTWh4ZHRZL1VUZ3BEZVJzMUJTdmxZUkhRTlR5MkxVb3I1UytG?=
 =?utf-8?B?c09IYnQzS3JHc0w0RmpIcDVUak9uRktsODNlY25lU01OOUNuSkpheW5wem1a?=
 =?utf-8?B?K2k1VEdDdXhEb1Z3d0dZbW1nTTVRNjZkRkFlZWhCTUVhR0EvN0s5Z3c0RzhJ?=
 =?utf-8?B?RzNjVFQyQ2lJYTgxcFF3Z2s2bkdvaEFwN2JOTVpneEtBbXRZeFFvazZ3Y2VH?=
 =?utf-8?B?VVcyUlBQV0h1NlQ2Y0RVV093TXByTDV2Qjd1aWw4MiswOW1taTBQVHduQVJv?=
 =?utf-8?B?d2hhalZYaFpUTmgxVVFLWDlxbG9aYmJhenJ6RTg5OGsyQXE1anhvR3RtZzM1?=
 =?utf-8?B?Y1RMYU1CUHZhVXg5Ym1QSTZjbFZvTWpYYk84WFcxMGVRd3IzUzRkU2YzLzQ3?=
 =?utf-8?B?Y3pXU2NmZHBqaktCM3JOeGpramlZUEZSUXlZTmtoeitVMy8xanVwbkR3R1hT?=
 =?utf-8?B?dlZjQTZMSFNJTEZoTERTWU1tdEx0M2hSYXNRa1VhVXNiVnE2MTluWkZka0VR?=
 =?utf-8?B?S2JRL1ppLzR4bjFzOG03dmxxREpLQU1oQ2pmcytQUDMvQnVVSHo1TTFKM0hC?=
 =?utf-8?B?UFVaNDhZcUdGZ0lzUWNYVU9jY2RHaUhNdkNWK1JMUHdsT3c2anhndjdENlBV?=
 =?utf-8?B?U29aQk9UMzIreVJOTXF6Y2tHTzV5ZFRTMlYzMWMyRXpuV0RNeTI0b1daTHhl?=
 =?utf-8?B?QmJKV1Zxb1NCei9nQndDY3dPeDg3ekVyM3poamZySHZGZEJrenV3ZTRDRFhl?=
 =?utf-8?B?SDBSMWI0Z0lMZDQyQ1BHL3Y4SE4rbTg0M3RwYXZ4TE9KaFR3cDdMY3hVYnZ2?=
 =?utf-8?B?NTcrZ3djMEljdm85dGdKMkJvaWV4Rk5CUWpRQmM2NmM0eVEyRW9yV0taY3ZM?=
 =?utf-8?B?bGtnL0tDU2MxTHFXeGdyQ2wvMy9Xd3I4QW1xZ0RIUVJKczNVb0k0aGNKanlB?=
 =?utf-8?B?ZlBaNzUvYUxhRGJjbWowRU5zVHVNellnczJUakVjaFVpVm9CV053c3d1dk1B?=
 =?utf-8?B?L1MzYzFQUWZEdElpYkJuQzR4alVlSnoycFQvZ0JrWnlqZ2FTODI0NlJWcE9m?=
 =?utf-8?B?L0VpK2xka0l5R25LUCtvdkc4VXRFTFJYRnFFZlpyVzBhc1Z3QmM1TkpWUHBj?=
 =?utf-8?B?QTVvZk5PeDE4Nk9Ta2Q3eENsdU5mQy9nWVc4Q2pnL0hSamNXRnBpMDdybGJy?=
 =?utf-8?B?eE9VVUxuR3N2eHVKS1dwYlFzZGdoQThTa2h3RTNxajBLUlJVZFMvelErUnNC?=
 =?utf-8?B?WFhtZjlKdjFvcXJQR3RxT3o5dmNqK09Zc2xEa21paERJODdJQWFhcEdmaFhM?=
 =?utf-8?B?TndNKzZnYlcvOXc1TWgvOHlkVVl4VzhPTlVRODd0aHRxZWQ4NW9SY0hySVAx?=
 =?utf-8?B?d2QrWTRpS01la3N4Yjd4S21lekpqeER2QU05T3kvOVBPUHVOVzhoVWlxdTNQ?=
 =?utf-8?B?RVBnNFdCQXF2aGd4c3AyVzZJMHIxOFNuTWovSUs4YlRwTVN6blhadHM0WGNT?=
 =?utf-8?B?R1NwYlpxSlVYWDJNUmNPZDRFclBneTZpaGpGelJlckVISEhEdEVNUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c8aa83-1b03-416b-1548-08de7b6df0d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 10:48:45.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/eQp2Pejn3Zk7KKEcTZmrdya9hlTgTVEQ+UMJgF227M9MCMVYMxxfGsn1kEDA12t3Oc3xKCT19abhPua+Avqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
X-Rspamd-Queue-Id: D047921F1DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223325-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,arm.com:email]
X-Rspamd-Action: no action

On 3/6/26 10:26, Piotr Jaroszynski wrote:
> contpte_ptep_set_access_flags() compared the gathered ptep_get() value
> against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
> from all sub-PTEs in the CONT block, so a dirty sibling can make the
> target appear already-dirty. When the gathered value matches entry, the
> function returns 0 even though the target sub-PTE still has PTE_RDONLY
> set in hardware.
> 
> For a CPU with FEAT_HAFDBS this gathered view is fine, since hardware may
> set AF/dirty on any sub-PTE and CPU TLB behavior is effectively gathered
> across the CONT range. But page-table walkers that evaluate each
> descriptor individually (e.g. a CPU without DBM support, or an SMMU
> without HTTU, or with HA/HD disabled in CD.TCR) can keep faulting on the
> unchanged target sub-PTE, causing an infinite fault loop.
> 
> Gathering can therefore cause false no-ops when only a sibling has been
> updated:
>  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
>  - read faults:  target still lacks PTE_AF
> 
> Fix by checking each sub-PTE against the requested AF/dirty/write state
> (the same bits consumed by __ptep_set_access_flags()), using raw
> per-PTE values rather than the gathered ptep_get() view, before
> returning no-op. Keep using the raw target PTE for the write-bit unfold
> decision.
> 
> Per Arm ARM (DDI 0487) D8.7.1 ("The Contiguous bit"), any sub-PTE in a CONT
> range may become the effective cached translation and software must
> maintain consistent attributes across the range.
> 
> Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: James Houghton <jthoughton@google.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
> ---
> Changes in v2:
> - Clarify commit message/comments: issue affects per-descriptor walkers
>   (CPU without DBM support, or SMMU without HTTU / with HA/HD disabled).
> - Clarify sub-PTE comparison semantics: use raw per-PTE values and match
>   bits consumed by __ptep_set_access_flags() (AF, DIRTY, write permission).
> - Add Reviewed-by/Tested-by trailers from the v1 thread.
> ---
>  arch/arm64/mm/contpte.c | 53 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index b929a455103f..1519d090d5ea 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -599,6 +599,27 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
>  
> +static bool contpte_all_subptes_match_access_flags(pte_t *ptep, pte_t entry)
> +{
> +	pte_t *cont_ptep = contpte_align_down(ptep);
> +	/*
> +	 * PFNs differ per sub-PTE. Match only bits consumed by
> +	 * __ptep_set_access_flags(): AF, DIRTY and write permission.
> +	 */
> +	const pteval_t cmp_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
> +	pteval_t entry_cmp = pte_val(entry) & cmp_mask;
> +	int i;
> +
> +	for (i = 0; i < CONT_PTES; i++) {
> +		pteval_t pte_cmp = pte_val(__ptep_get(cont_ptep + i)) & cmp_mask;
> +
> +		if (pte_cmp != entry_cmp)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)
> @@ -608,13 +629,37 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  	int i;
>  
>  	/*
> -	 * Gather the access/dirty bits for the contiguous range. If nothing has
> -	 * changed, its a noop.
> +	 * Check whether all sub-PTEs in the CONT block already match the
> +	 * requested access flags/write permission, using raw per-PTE values
> +	 * rather than the gathered ptep_get() view.
> +	 *
> +	 * __ptep_set_access_flags() can update AF, dirty and write
> +	 * permission, but only to make the mapping more permissive.
> +	 *
> +	 * ptep_get() gathers AF/dirty state across the whole CONT block,
> +	 * which is correct for a CPU with FEAT_HAFDBS. But page-table
> +	 * walkers that evaluate each descriptor individually (e.g. a CPU
> +	 * without DBM support, or an SMMU without HTTU, or with HA/HD
> +	 * disabled in CD.TCR) can keep faulting on the target sub-PTE if
> +	 * only a sibling has been updated. Gathering can therefore cause
> +	 * false no-ops when only a sibling has been updated:
> +	 *  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
> +	 *  - read faults:  target still lacks PTE_AF
> +	 *
> +	 * Per Arm ARM (DDI 0487) D8.7.1, any sub-PTE in a CONT range may
> +	 * become the effective cached translation, so all entries must have
> +	 * consistent attributes. Check the full CONT block before returning
> +	 * no-op, and when any sub-PTE mismatches, proceed to update the whole
> +	 * range.
>  	 */
> -	orig_pte = pte_mknoncont(ptep_get(ptep));
> -	if (pte_val(orig_pte) == pte_val(entry))
> +	if (contpte_all_subptes_match_access_flags(ptep, entry))
>  		return 0;
>  
> +	/*
> +	 * Use raw target pte (not gathered) for write-bit unfold decision.
> +	 */
> +	orig_pte = pte_mknoncont(__ptep_get(ptep));
> +
>  	/*
>  	 * We can fix up access/dirty bits without having to unfold the contig
>  	 * range. But if the write bit is changing, we must unfold.
> 
Looks good

Acked-by: Balbir Singh <balbirs@nvidia.com>

Balbir

