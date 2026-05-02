Return-Path: <stable+bounces-242568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKZlKyJQ9Wk5KQIAu9opvQ
	(envelope-from <stable+bounces-242568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:15:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CAC4B0901
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7BE23013A57
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D7729A31C;
	Sat,  2 May 2026 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OiIFylJb"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F28DB49
	for <stable@vger.kernel.org>; Sat,  2 May 2026 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777684506; cv=fail; b=kF4oAJ4JceS+Z9fT5Aplj73ZNcZrSUAP2bGn7vM3dZJvmyx3H3Vu63nsqgQ0I2McTV0jvM0dg6tAAvgmWv5ZwklINN3cPlnohaGlzqlEwyPT483ccpBA2it+39GORUsdu9OpZF/VWCrFOsk/B8ppGZBwOXQc3gaDikaUWOn1wKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777684506; c=relaxed/simple;
	bh=NamtKI75hyUtgSbq45KRzngHDFgG/sepyvpQW0Gxwq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oA9s44JiCZ1SMDQqVD72b0S8shMdG8dTdWavw0BvFb5YCiaNIWrTRzzSe2boFtbLSFiTlca2M6Jb3gNiX0rLF4N/URkOgf+ykg7HGc8mGWu9C+ekSn0NjeIh7lF2LWfSODg9ZMpLLYMhKvmzwqAuTmgkEgOGJgfts3NL8xmp6AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OiIFylJb; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdjw4+6AjKtCp65F10ASBtSPeV2NDo/OtP9aPDdm7PfNw39JQOAtViFLINLRKEKLZ/rOaJBPr+9vkHdGIAsK0IOo2hO5JLCfVuQHNvW23tEHhzH1t7KyPeQd2/Kb/3Lrt9cMrfaayW3MCIHKj3ohPMW4VZciQcWaockc23hCYfbw4nk3doTn3yH6a1MQeB8cKLrtrz1NssVXu1QaTTnkf6gP8eKA64Mgq6xv5ON2o7IFWBedScXevgi/xayA5eI6Bu8SiwJlaLc5z26g/BnvwfwsLZXNfFKmFDI9dEgJv6QpWAVL3zlPwMvFDPedaY2a5q5c6UwSlmfTWd5zxoYZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3dy2F9KnrrZgt4gqXd43VcGQMc/ozOn7KR344/KtHo=;
 b=iVXz3D0IwRQu8soKF0/08xmKGYEyXvc6++eU9cRSAcYm90PCqFj/ecbTm0TFL21/BYE1yM2kb1fTi6Bshp5+Ppg5ULJsvhbGDW5HZXC1BxHE7tETbun7CEk/FMwXncL2DCIiXxqeibsk1OhKI06PvDjib1cimnnotE0J/dZorvrsr+UTD9RYSraQ+pCfE4LwueKCshSQWt/j09LfyBokxjX7GJyMg2ApjzsQ+fUFuOfai0sLvbvktfvnWX9x4a73QW3dcDON0KD9ajsJGDOttKrF02rMq+ScsWK+mew3PIZH9UweaJ6eWNy2wsU6I6w2AoPLkfCSWEOpM1vd7XG20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3dy2F9KnrrZgt4gqXd43VcGQMc/ozOn7KR344/KtHo=;
 b=OiIFylJbDuACrEAeSEcq3kSS4PDAhpEY/jy8XQ9Uo0CBpMRvjnOwbn8lcppOoSoLafRsax1h9CcPzmkFmgXZRVoyedd8Tt/Aszjz59AxoCETB7oevCQSd/UJGxjzSLytv1rZXqxcQIq82zHe5CYS5IDMXXpTOnD3CBVkjGUN/QVQxUfVmfX/94pG41trE2RWKSp5t/eKyEATx4H2KuSY01VL4Fwl0KbJoShSkv2DbZICWT1AsCDn6uiBOjnGZBXZZFM2PbFLJTFTn16svgeLuXk4RIAGYGfIk0yZy8UxZIWbN1+XLrggrneJD8XfwHWvrDFhx0LZfHjyAhR86CsUfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 01:15:01 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 01:15:01 +0000
Message-ID: <f7f3eb36-1415-460e-a436-edca64cb7fe9@nvidia.com>
Date: Sat, 2 May 2026 11:14:54 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: Fix spurious warning when unmapping
 device-private/exclusive pages
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, aarsenovic@baylibre.com,
 dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jhubbard@nvidia.com, david@kernel.org,
 stable@vger.kernel.org
References: <20260501065116.2057242-1-apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260501065116.2057242-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME2PR01CA0238.ausprd01.prod.outlook.com
 (2603:10c6:220:19::34) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9502a725-656a-4f3d-e6ed-08dea7e83baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m9F8YlUGC8hE5U3Mepy0Lkq4JfEY8RDXyH4BanMzFaDFD30eZc1PNJqcxigDsAKjqpOkZ0r48PypZIKYGaCdtBDjcZrpF12gNkcDQh//NtmNnNfmDsq13hExYyVNocvKGYrWpHom1i5C4AYDCLMphSI1BvwYw1bv/AksiqfcGtadi9i9ZrFT8/iGf6YM7TfLhkUBQgGz24BK3s+r88HdAFkDN18UUc1rzXRlMkjPJZpjqwTigJnTvG9DqvY7H406onGvr0B5XUTxqT8TNMPYZpHeh6204QkNst8vVfexFtmrpe47k6tcjrwRD5NAaqm9rrEBUns64YbL52Lt8NmwwwWX04hOoytk+3UopicMb32PvN2ofdM+Ql/0WnfCtV4TfOpDD1nTyr1z6jdm2dp/jQdXocPTh6Jiqf994ciqzA8u9+GUprwYJ4ajEiGLwxOEK6W9UH+GQNr1PRsTUr2l8psqJbqkPZQg3Rfc0E4/VJuZ517i6hiZvyP0TYWvkWJ3qbVE99+e+CHFDEK88yg3TaS6OrUOmQ85Ak42tnKzwvi4fLl+xGtYvFJt8DswIAEarKu9+YRDzArPDzkb0T9ACZkFZJZU7OdGWOidoCmp4xLnSM1+XpONVE6h+y5bOrWpYmjzgy1fo8RdduTzskpRfGvBXiEHOygnNwiLc/N6sMTgynEw8MddeyYPCLGSuE1v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHIrQTVrSU9VRWxiMHpoSFpaWVI5T1haRHpxaEtVbjlqS0tIc0Q1NGgxV3hp?=
 =?utf-8?B?YVFYQXRvblNYLzcwZktsb3FIR2tLNkpLbUpPTUZPUzl2L2pTNlpVYXFra3VD?=
 =?utf-8?B?OFMxUVBDZm5PMnVJeUpWL1N3cERXSzlJQlpHdS9TU2sxOHpSdmR0NTlwRXRt?=
 =?utf-8?B?Q01NY2VJdFBNbC9nUnBoWXZYZFJaYzlPTURtS0Y4TGQ3U0NXQkx4Z0Uwd0M1?=
 =?utf-8?B?SE84UzlhMXl5OG9nV0NVZmFTY3k4Z29XMkFnMkRqNFNiZG5waW54NmplUUpK?=
 =?utf-8?B?K3JyRHNpNHZKMWIwc2NJNHA1S2J1OXhFTStMaUFIT0I2YVY4SjAzc0t4VmFR?=
 =?utf-8?B?Q21MWjYrejFPUzJqUXlzV2FXaHM4bTdFdCtmMGZDK2RZSDdzOXJSUEFTQnA0?=
 =?utf-8?B?ZGVsMVJNWGdrditmQnIvS2JrQjVFUGh0UHgvUXdZdmpNN3d4UStYYmtCREp1?=
 =?utf-8?B?dWZQSjQrZHhnWG14ZzVaL1VWRm8yUW9tRzJBVnBNeDlCUS9kWnVkUzVnQUds?=
 =?utf-8?B?QjBqUWU3OHFwcm5GZllRMzFoWjgrNFZBQytDc3lMalR3bUJESE5QNTlKTGRq?=
 =?utf-8?B?bGNiNy9vUGxGTDNFREdseUQ5SStzSkhXQ0RScy85Q3htLzNHYXpCRiszeEFQ?=
 =?utf-8?B?WWdWaEpNYVpvZlhyRGw1M0JDdjBaWDNYNExmcDBockRYQTU2STRvYS9YUXBj?=
 =?utf-8?B?UXhZYjB0aUF2Smk1RDR1TnBHcGQxRzBZNlZLZ2RhNkZ6WFRUeG1xcEdiRW5H?=
 =?utf-8?B?MXk4OTQ2NHJ5Z24ySFRrQ0h4d09jc2FuYlRTVHRtZ05DSWdxR2lERmkxUEdJ?=
 =?utf-8?B?TTN2YWdkTHV5bWFWdWpQZ2JoS3Eya1VoZlVZTTFJZkJmMEluTVJFRVlyV01z?=
 =?utf-8?B?cXBGQ2x1aUNoMktydVVvQUdZNzlSL29FbmRodkxodElGMjhzSGxTM0FXK1RN?=
 =?utf-8?B?bVJRQVpNVkZOTWwvMGJFMHZ0MzA0dFBJNjVTYTljc3BwdmRnczBPeTNBb25r?=
 =?utf-8?B?d2pHeG96MTloWHZvcnNsWVhXV1ZlTmN6eXhqd3ZsV2tSUkQ3bE9nVUtuYXpv?=
 =?utf-8?B?YmVFOUZSUjdUa0ZHcjJiNVlBYktCV2FZZmhpclNZV25oTnU3TElsMEpDbXNQ?=
 =?utf-8?B?WGp4TnJGRDBJUUovVklsekR3dVNaVVhneGNPeHVuNUlRSlU5T0JZVjErajBD?=
 =?utf-8?B?VE1Waysxbjl4MXo2bFVPcVhnQXBXVjJ2UzdqOWhEM3ZsK1publNOT0p1ak0x?=
 =?utf-8?B?NVhDRzRoR29QdU00Q0xoS1JGMTYxOHEvUVBLWS9MeDlPcjlmaUR2SG50dHBE?=
 =?utf-8?B?VG5kVDQyaWg5aU1iVzZqSGtuUFRqSnNVYWVKZzVQWEZuWTdDV0s3OW01ZnNq?=
 =?utf-8?B?Z0FrS01JZDRNaGhNY0NjU3ZBNDg5bHJhczVUQVdWazdCWmFrd3FudWVDcTJX?=
 =?utf-8?B?bUpNUWZ2OHllVVlITjE0Zjd0UTcvVGIxRVNGVVRvVmdqMDhHcElwMHk4RXVi?=
 =?utf-8?B?NWx2TmJkSmlhL3NlbFdQOFgyOVdVL0hHMm1aZ1ZHSi9RMFZmaDMwOWQxSXd2?=
 =?utf-8?B?VHZvSGF3ZU5uK2M5Vzl3bXRVVmdZK0t6aEdKdE4wRG92b3VtcHFMY1VwcDhN?=
 =?utf-8?B?QnBYY1JjK002YzF5YitFM3lUT1J5VStUYmg2NnE4b2VHWE16ZjZXUGFqYjFx?=
 =?utf-8?B?dnNQUk1JUEZBWVA0SGdOTUZDQVhVZUNvQXFPRkNmd0JCNFNlTExnNGUwSHlM?=
 =?utf-8?B?NHVVWFJYdEZhY292TnJobzN6czJ4amF1ZFRxa3ZBZGtWSUEyZXc5eDlCbTBj?=
 =?utf-8?B?ekdsYVNHUDhJdnM0YTJYaG42NURKY0k2MzVsWktRUFdIaHdFLzhYZnM2VVVL?=
 =?utf-8?B?ekJod3Y0Yzh6dmhMdzV2WWZEOWVMeVYwcDRaZmd2bEt6MzNDUG0zU2s4VEph?=
 =?utf-8?B?Z1Ezd2xLQ3l4bGlndUdRL0xLUFJGdVFESWVJd2hsc1BYUGpUcG5JeHE5Rkhp?=
 =?utf-8?B?blptRzJlcFJ2azM2R3JFSndhMVFuOTdHNDE1aUFzbmRMYm5HMUZJSTBFZ240?=
 =?utf-8?B?QlEwVXhYa0tQak9ETmxwQURvcEpkV2lDeHhRWklnSVRJZWxlbmwrZWRWb2dT?=
 =?utf-8?B?Nis4MlBRWERYNjFiRHVJSElVOXo5b210Nlc1UHYzdlFYR0hxQjIzR0FGQVhO?=
 =?utf-8?B?czNWa092b0Frby9TdjlmTzE3MllVQ1QxNlg4OU95WldjVkRDcUdEZzJoUVNn?=
 =?utf-8?B?ekp6eUVxVnZkaUx1ejNzdUdFd2g3bVlJRWtQWmhTUjFsSUJVRWdDdXViTHVG?=
 =?utf-8?B?UGhoOXZWVWh0Y29TV1Q2Y2FlNHA0RmljcVQrVXpLS2sxSGtlKzU0cjVNQmQy?=
 =?utf-8?Q?2zy3/AzDGu4rWgFO86EGYuZgPUZMEq/ATyuN3RrWWTtcY?=
X-MS-Exchange-AntiSpam-MessageData-1: 60kQQdoGbzR7fg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9502a725-656a-4f3d-e6ed-08dea7e83baf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 01:15:01.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtiToOb4Nh08+/kyoLPQgUusH9VEkPt+uDxKaDaSRZFiCqOhxtIrV+gMnXNDgj+0y5hKqhLZmJMi3V68ZtDvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
X-Rspamd-Queue-Id: 24CAC4B0901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242568-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,qemu.org:url,baylibre.com:email]

On 5/1/26 16:51, Alistair Popple wrote:
> Device private and exclusive entries are only supported for anonymous
> folios. This condition is tested in __migrate_device_pages() and
> make_device_exclusive() using folio_test_anon(). However the unmap path
> tests this assumption using vma_is_anonymous().
> 
> This is wrong because whilst anonymous VMAs can only contain folios
> where folio_test_anon() is true the opposite relation does not
> hold. A folio for which folio_test_anon() is true does not imply
> vma_is_anonymous() is true. Such a condition can occur if for example a
> folio is part of a private filebacked mapping.
> 
> In this case vma_is_anonymous() is false as the mapping is filebacked,
> but folio_test_anon() may be true, thus permitting devices to migrate
> the folio to device private memory. This can lead to the following
> spurious warnings during process teardown:
> 
> [  772.737706] ------------[ cut here ]------------
> [  772.739201] WARNING: mm/memory.c:1754 at unmap_page_range.cold+0x26/0x18a, CPU#17: hmm-tests/2041
> [  772.742050] Modules linked in: test_hmm nvidia_uvm(O) nvidia(O)
> [  772.743959] CPU: 17 UID: 0 PID: 2041 Comm: hmm-tests Tainted: G        W  O        7.0.0+ #387 PREEMPT(full)
> [  772.747104] Tainted: [W]=WARN, [O]=OOT_MODULE
> [  772.748509] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [  772.752117] RIP: 0010:unmap_page_range.cold+0x26/0x18a
> [  772.753780] Code: 7e fe ff ff 48 89 4c 24 78 4c 89 44 24 38 e8 f2 ff b1 00 48 8b 4c 24 78 4c 8b 44 24 38 48 8b 44 24 18 48 83 78 48 00 74 04 90 <0f> 0b 90 48 89 ca b8 ff ff 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02
> [  772.759602] RSP: 0018:ffff888112607550 EFLAGS: 00010286
> [  772.761310] RAX: ffff88811bbf4dc0 RBX: dffffc0000000000 RCX: ffffea03e9bfffd8
> [  772.763583] RDX: 1ffff1102377e9c1 RSI: 0000000000000008 RDI: ffff88811bbf4e08
> [  772.765914] RBP: 0000000000000006 R08: ffff8881059f7448 R09: ffffed10224c0e68
> [  772.768184] R10: ffff888112607347 R11: 0000000000000001 R12: 0000000000000001
> [  772.770461] R13: ffffea03e9bfffc0 R14: ffff888112607908 R15: ffffea03e9bfffc0
> [  772.772782] FS:  00007f327caa2780(0000) GS:ffff888427b7d000(0000) knlGS:0000000000000000
> [  772.775328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  772.777187] CR2: 00007f327ca89000 CR3: 00000001994d5000 CR4: 00000000000006f0
> [  772.779135] Call Trace:
> [  772.779792]  <TASK>
> [  772.780317]  ? dmirror_interval_invalidate+0x1a3/0x290 [test_hmm]
> [  772.781873]  ? vm_normal_page_pud+0x2b0/0x2b0
> [  772.782992]  ? __rwlock_init+0x150/0x150
> [  772.784006]  ? lock_release+0x216/0x2b0
> [  772.785008]  ? __mmu_notifier_invalidate_range_start+0x505/0x6e0
> [  772.786522]  ? lock_release+0x216/0x2b0
> [  772.787498]  ? unmap_single_vma+0xb6/0x210
> [  772.788573]  unmap_vmas+0x27d/0x520
> [  772.789506]  ? unmap_single_vma+0x210/0x210
> [  772.790607]  ? mas_update_gap.part.0+0x620/0x620
> [  772.791834]  unmap_region+0x19e/0x350
> [  772.792769]  ? remove_vma+0x130/0x130
> [  772.793684]  ? mas_alloc_nodes+0x1f2/0x300
> [  772.794730]  vms_complete_munmap_vmas+0x8c1/0xe20
> [  772.795926]  ? unmap_region+0x350/0x350
> [  772.796917]  do_vmi_align_munmap+0x36a/0x4e0
> [  772.798018]  ? lock_release+0x216/0x2b0
> [  772.799024]  ? vma_shrink+0x620/0x620
> [  772.799983]  do_vmi_munmap+0x150/0x2c0
> [  772.800939]  __vm_munmap+0x161/0x2c0
> [  772.801872]  ? expand_downwards+0xd60/0xd60
> [  772.802948]  ? clockevents_program_event+0x1ef/0x540
> [  772.804217]  ? lock_release+0x216/0x2b0
> [  772.805158]  __x64_sys_munmap+0x59/0x80
> [  772.805776]  do_syscall_64+0xfc/0x670
> [  772.806336]  ? irqentry_exit+0xda/0x580
> [  772.806976]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  772.807772] RIP: 0033:0x7f327cbb2717
> [  772.808323] Code: 73 01 c3 48 8b 0d f9 76 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 76 0d 00 f7 d8 64 89 01 48
> [  772.811337] RSP: 002b:00007ffde7f57d38 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> [  772.812564] RAX: ffffffffffffffda RBX: 00007f327cc9c000 RCX: 00007f327cbb2717
> [  772.813733] RDX: 0000000000000000 RSI: 0000000000400000 RDI: 00007f327c289000
> [  772.814867] RBP: 0000000000421360 R08: 000000000000001a R09: 0000000000000000
> [  772.815991] R10: 0000000000000003 R11: 0000000000000202 R12: 00007ffde7f57d74
> [  772.817121] R13: 00007f327c689010 R14: 0000000000100000 R15: 00007f327c289000
> [  772.818272]  </TASK>
> [  772.818614] irq event stamp: 0
> [  772.819159] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  772.820174] hardirqs last disabled at (0): [<ffffffff82a57ab3>] copy_process+0x19f3/0x6440
> [  772.821511] softirqs last  enabled at (0): [<ffffffff82a57b00>] copy_process+0x1a40/0x6440
> [  772.822869] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  772.823871] ---[ end trace 0000000000000000 ]---
> 
> Fix this by using the same check for folio_test_anon() in
> zap_nonpresent_ptes(). Also add a hmm-test case for this.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Arsen Arsenović <aarsenovic@baylibre.com>
> Fixes: 999dad824c39e ("mm/shmem: persist uffd-wp bit across zapping for file-backed")
> Cc: stable@vger.kernel.org
> ---
>  mm/memory.c                            |  2 +-
>  tools/testing/selftests/mm/hmm-tests.c | 50 ++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c65e82c86fed..3f22a67a4d7f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1750,7 +1750,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
>  		 * consider uffd-wp bit when zap. For more information,
>  		 * see zap_install_uffd_wp_if_needed().
>  		 */
> -		WARN_ON_ONCE(!vma_is_anonymous(vma));
> +		WARN_ON_ONCE(!folio_test_anon(folio));
>  		rss[mm_counter(folio)]--;
>  		folio_remove_rmap_pte(folio, page, vma);
>  		folio_put(folio);
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index e8328c89d855..eb860b5d6f85 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -1034,6 +1034,56 @@ TEST_F(hmm, migrate)
>  	hmm_buffer_free(buffer);
>  }
>  
> +/*
> + * Migrate private file memory to device private memory.
> + */
> +TEST_F(hmm, migrate_file_private)
> +{
> +	struct hmm_buffer *buffer;
> +	unsigned long npages;
> +	unsigned long size;
> +	unsigned long i;
> +	int *ptr;
> +	int ret;
> +	int fd;
> +
> +	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
> +	ASSERT_NE(npages, 0);
> +	size = npages << self->page_shift;
> +
> +	fd = hmm_create_file(size);
> +	ASSERT_GE(fd, 0);
> +
> +	buffer = malloc(sizeof(*buffer));
> +	ASSERT_NE(buffer, NULL);
> +
> +	buffer->fd = fd;
> +	buffer->size = size;
> +	buffer->mirror = malloc(size);
> +	ASSERT_NE(buffer->mirror, NULL);
> +
> +	buffer->ptr = mmap(NULL, size,
> +			   PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE,
> +			   buffer->fd, 0);
> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +	/* Initialize buffer in system memory. */
> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		ptr[i] = i;
> +
> +	/* Migrate memory to device. */
> +	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(buffer->cpages, npages);
> +
> +	/* Check what the device read. */
> +	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
> +		ASSERT_EQ(ptr[i], i);
> +
> +	hmm_buffer_free(buffer);
> +}
> +
>  /*
>   * Migrate anonymous memory to device private memory and fault some of it back
>   * to system memory, then try migrating the resulting mix of system and device


Reviewed-by: Balbir Singh <balbirs@nvidia.com>

