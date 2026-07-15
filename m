Return-Path: <stable+bounces-274658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UMPOL7LgVmo0CQEAu9opvQ
	(envelope-from <stable+bounces-274658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 03:21:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F0759DA7
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 03:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="fW0beh/1";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274658-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274658-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFDFC301C3D7
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E153793DF;
	Wed, 15 Jul 2026 01:21:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DF374E64
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:21:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078511; cv=fail; b=oMcwSHutB3miWk5n0WF/r3xIqAjcl1EsspqZekSdEZ9GgWrjjSlN4ISqpaJ+vEiGL3EvgY2SIVeHAKewmrma954KB8rkjT63Ftpi+/jAW2DwgXIp/ztkAPZro+eEzUiyV9KyU3X5INaXAcov+bhp5Z/3DPYz4LroPTlj64OUw+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078511; c=relaxed/simple;
	bh=8YNev70RP+CjqyMQS9NafyjVmfRhgB6LV+G19c5RgLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BerMf0aEFlqFjhuAc/yBn5pq7r3nh8r2M+WvCM1//0eVUSxE8nlTBnm1yjqxwQPtMfTPBTmOMcQhvH8EMRMTxgwZvXLg+egon8ZtlqsbMFQhH4m5ZQmP/CDtj4c6LP+YL+MHv+8gw2E3/o7PJY1Gk2tUYXEt5XeiFP8x5XF0r8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fW0beh/1; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4RQzF4Cn0aBEFVtX/Pd0UjCGiovGYVfWK9cBCNxOG0BOcevc+zmm/g3zN04OFoPE+CET32aL5oauZW+mn+zxl5bn9gPHMld4CwJG9oA1VMbTDOO+EuM8DUSnOxizanaSH3GGs+Q9bks2jOfCsi6wAn0lJxN0ttn3/EegwXDdeWEIaMAbIUVuU81/zJkKUjw8qph99nHuS0lcw4CWcYqQ0wGbwf0bE/M7ynwL8jkvtVZ8fw2IBLl18v7kfPS6Wmvtpa27V1U4UfAIBt8Zp66r7escuPjIhtQPxeF15HsNZnf8WESy8V8tos/4ZHqJYGmS6B+BZE0pvXwrAIyuyTgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ylT28yJ9ttIimzkW/Rtoq2yoVQBfnbFpVdc1PIpUWg=;
 b=aJRzJyHPPt0ku2FH7cNYwSvRZbtYDR2MvYKQqt12Xrk6+35UKYHs0w/l1aTycp4O4alzQPrDAfwWUwWO3XLSMqXZerBdxib0Vg5Q9NIiJvCBQVhFgoZzbR3Q0I4QlEvF6RIX+QutJJvRbGqqA8gPVDccC6fGCWp8sQyG6TxrEKDI8JO4Yw1WT2KfLT5PStgCFsR0hv4vCBI8b5GwRlDatkrxUKa5hhJQQKvcSwaH29RIPqAL3uDGP4d3K+j7uMQP0vgEu0HQklwsz9vVe1tyNTC4KSms3yKw8PZPaptAOzoNLJL0yHsOWBfMEn1WolbBCWZ0s7UJLHmn7c/y89ju1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ylT28yJ9ttIimzkW/Rtoq2yoVQBfnbFpVdc1PIpUWg=;
 b=fW0beh/1DpcdjltxqamLej9lXbSC1lIyi7i/5mmktfXTTsfkyzFx8fpLR22HfS1OigoSYv2Vp+ntr5hD1RSUNrebG2FQGvbfSS7TRKWjmemN7h5KXknxcepBUQiTE1OX3XyPxO/6wlzYyOJjINd6KiqMR7m2WXh/YIRKlX9UUxY=
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 01:21:46 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:21:46 +0000
Message-ID: <eab814b7-8bc7-4ce3-acf4-ec32e3c06dff@amd.com>
Date: Tue, 14 Jul 2026 20:21:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Anisse Astier <an.astier@criteo.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <20260714043329.3510162-1-superm1@kernel.org>
 <20260714200600.stable0012@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260714200600.stable0012@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0121.namprd07.prod.outlook.com
 (2603:10b6:5:330::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6302d5-d11f-4a7b-83c2-08dee20f6f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|11063799006|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NgnoQ+lG5/UBT7oSsv6p6x8Kr2inQQ1NNz4JAzxSW2qx0TYUH+dA4KFC2iLLu/W3hrNGrUR/lzrv1j9FVlBKo20CbV1IO9JlEAchkLNwDmQ4VYQb3aMe+m+vsgNHyHALQpUVAhdmRrUYrCrP/AU3+gtGT+zVt2lE1BX7I5zGFqrb2ljY3elVP7mNEgU4w/6WfeNCtUQ8JqqCVCZEhpIPH5ocDsvOzrKqOtNxyGxhslDEmmfnyW93D4OdlOtdgY+kcas3TXRyU5wba02Wfla1IEhFGl/P0OW86XfFxkguiUq1yOGlNXuXPNtEUl57pW6NryF6mK21vsAeYmtPLxl0pO00yRfxVJSGu/xA7Ud1LCZ2isguBc8pRYHO2GytexpLru4dNdkyz8BsaQE23f+3EcKlpkzt4d7S1L7J0CfKUENzM48sJReYoObWpr4Rr1SjvT+XKOH7wA02etNQeZ/FZuQuFICnve1bqU1dD111ZAMjYb2Go6/cYuZ8gDA0Cn2rveVtqBVzyBtMHOo9a1z7xyYyYrwHbP5wWX9WmSdR/MLW93j+Al7J3XskogFWYPsYLA+3Wjp9JRqVez7ytgbJe+qw0Mi041K5w5JGBwBOzDVfYRnDZFQoz0SlYMPo5eo1o6+ksOr8JYGNmF2Cs57f+lEm1bMEl2JJvt++j3NfRVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDR3RCtVZE9zczc5cFFOYTUxbEwrUzVqRllwandPMXBCaDR5dHFFRFRoN0tR?=
 =?utf-8?B?czFBL3hMVEVzeDkvSWtZbXkyY0tyRlB4allJNExOVlViV3VramdvMzFuU3ZU?=
 =?utf-8?B?c1pFeGh6NCs4eDZRSFdKdDVhYm1ZQkxGNDV0S2VtRHlkMGVQZGtyRmxoVURR?=
 =?utf-8?B?MzlOaFVkcGR3dzRnTkpHbnF1SGowSXAzeG52YnlaRi90M2x1Nk4wQ2xWMWRJ?=
 =?utf-8?B?NHFUL3lncXJrbmNCOFF2cVhEcUYwbWdMampsOUlDTnVuMnp2bWRJUjF5YW1O?=
 =?utf-8?B?eE9GWDFINncrSllSU0l6dktRSWYzNHJodVBQVGJ3ZGFpR3J0VVBBLzE1dzB4?=
 =?utf-8?B?VktYYkYvdEs4bWRsZEtNSzJ6azVHMUZMY3hWUnpXSmF0a0hxVVhjRnZhZG54?=
 =?utf-8?B?aUlwSzRJbGY3SUkwU3FYM0lUT2hyNUxDWU5CZW9teENnUUZoeFk4VTVXQzJx?=
 =?utf-8?B?VktKYyt4UkQvbHRjNG5Hb0gwREN4UE9LQ2tuVThEb1BHSU1IaUNBb0g3YlF3?=
 =?utf-8?B?NzIrOWRPTHJvWVFic3EyaFg5TTV0eUVCRXRBRWc5UmJZUE5xVnpBYkppVEs1?=
 =?utf-8?B?YVZkY3l5YXphTmxjaW9IWjNZVE54SlJnRHQxdWNEREJad0hhNVhJTTV0aVE1?=
 =?utf-8?B?WlFHTXNUYmtyYjdOcWg3N2dxMS95Y1E5Mld5aXZ0dmlXL3d5Q1V4bE5rd04x?=
 =?utf-8?B?by9YM05POW1FWUkyUkEvRi9Bc29ob3VKb01FUjFkRXBsQ3JxajM5Y29MTmor?=
 =?utf-8?B?bnU0Y1ZiQVFRSk91YTNTZHNZYXFSYVJoZmdQaldZU3RNcWdwckFiL2p2RURT?=
 =?utf-8?B?bE4yeHZ4WDZoaENOc2VCVExlbTd4TlNnVUxJYTFvYjZuUVRyWWxZLzJ6bE41?=
 =?utf-8?B?VzhJcG9tN3JHd2tldDBhaWJBSzFrWmhmaFNSMVRoVENKZzNnMjRnMDZqL2NV?=
 =?utf-8?B?NmdtV0s4eWF2ekc2ZW5FYWtKWE9ieHp4NnpaRnRNUFJrL01JN3JUY2JXV3gw?=
 =?utf-8?B?bmoxNDR4K1pCWXdpM0grRFdmRDBZcXdIbXMvY2JZNkJpQVpXMEJKaW9Qa1Iv?=
 =?utf-8?B?MnRCY2UvMW1DcHpkZzkycDVYRzVIdjBrenBPR2FPcVh3czRBRGcrZzN2eXhV?=
 =?utf-8?B?L1ljbVMrQmF1QjJMZlJGb2ZNOHpONW5QWHdkR0REbWU3TWpRL0s5SHIyclNP?=
 =?utf-8?B?N2VCTFBDUlZTMDRHT29GRmwvQ3BPNUZOc3JJeW1KdENjZGdma2NHdGZJWDlF?=
 =?utf-8?B?a04rOXM3dlh4Rlp3NmtuQ2F1TU9Dc3VKclpHam01UkFSTTQvQWRwbFJFOEV2?=
 =?utf-8?B?QzV2bVRFdWtiakpKVzI4WEdvMjg1VXpZS2V1d1BhMStQQ3FZaUdwNmhUb2F1?=
 =?utf-8?B?M2EreE40QWVCakc4OG8wZDZpcmRBZmRhTFNvTmZEd1dzeEhtZTR6TzRybkFh?=
 =?utf-8?B?blg5RC8zY2hVZGw5a2U0WVoyRkcwTUlQLzhpY3RqNFdqcVE0YWwrS3JuWjdI?=
 =?utf-8?B?dGFqd2x5RXRMODY4U1VrcC8zcWh1YnkzVUlVRWZEd3VuTjFFQTJpQ3NmbGx0?=
 =?utf-8?B?UEp5UFJXc1lUZ0FrbmpOWnh3NlZCSlUxYzdlZ3d0cTlKR09iTXorWkxoRG9w?=
 =?utf-8?B?S0RjL2RLTkRRdlJLc0ZkYlZRTlZ2VHhsR0hpQ28wcHFmTzdDL3VzY2RWenVQ?=
 =?utf-8?B?ZTEybmx6OGttYWtxSmRJdUYzNVNNZWhrVGI1dDlLaGpRT01NQndvZkRLb1Bu?=
 =?utf-8?B?MW53Mk8yc2xFVXBvRmFVZ01zUDVjU1JQdVQvbXRlOHN5aG1ybGFQVDQxcGFp?=
 =?utf-8?B?TjI0N0dvaU1EZ3Z3QmdldGMzV2Nqelp5ZkxqTDBYaEZqdkNoWmNpUDZ3SkNp?=
 =?utf-8?B?ZG9vcjBXNWxJZXI4Yjd4MzArQ0p2NGxQdlh5OVpPY0k1VFhRdnVxNUNKbVNt?=
 =?utf-8?B?c3NQeldmMGozRGlyM3FkQzVXKzU4UW1BYkdwckR1WGpVY3dhR1FzTE5LNnVD?=
 =?utf-8?B?eFc2VngwSGhuY044NDF3ZU9aS1FqVzJOeUtycWp3SkhVSGNwd0NZV0tXdlZJ?=
 =?utf-8?B?S1FHQXp0bHZqQVlYbWFKYiswUWtsc2NWeVlpY2hJeEw1eE1zYTNIZldzUDY3?=
 =?utf-8?B?MHZmamp1ZjVjcG1WTFFqSkRZOFA5NHJIUkUreU9oZ3g2WkJvdUV4UlN0ZmQw?=
 =?utf-8?B?d240T3R0ZTVHdzJJWnVUVFhOVlhyaVhNU1ZrR1R4SHJTZTlUYUM3ck1aK043?=
 =?utf-8?B?NTlrR2I1djNzWWJ5QlFXMHlNdjU3VmMyWHE2OWliM2RZZzBXQldNT2lkS3dy?=
 =?utf-8?B?Ti9Ba2g3SmFGdkpWOG50c2Ixb3lFM1NLMzdoSWhpN3RFWVY4SWJhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6302d5-d11f-4a7b-83c2-08dee20f6f9c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:21:46.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdGYh6QRS2npVWFZqn+ADQeHIe/e6CpDITUiOffB6hJGR92Kgp0E+UwUehipMptaWpDE8uV7SZk/PkSwbsMHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274658-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:an.astier@criteo.com,m:ardb@kernel.org,m:superm1@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:dkim,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B3F0759DA7



On 7/14/26 19:12, Sasha Levin wrote:
>> Background for this backport is that fwupd needs to be able to do CA
>> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
>> process checks for free storage, and needs this function to do it.
> 
> Queued for 6.1. I also pulled in the follow-up fix 79b83606abc7 ("efivarfs: fix
> statfs() on efivarfs") on top, so the broken statfs() error path this commit
> shipped with doesn't land in 6.1.y, thanks.
> 

Much appreciated.

