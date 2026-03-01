Return-Path: <stable+bounces-222474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJJdNmZppGkigAUAu9opvQ
	(envelope-from <stable+bounces-222474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:29:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82571D0A1A
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 823033004CB5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50013148D9;
	Sun,  1 Mar 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vn/30TdL"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F4B652;
	Sun,  1 Mar 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382560; cv=fail; b=ZCbJ+IuUg0+ue6oUEeGuQWP8XHqRmbQpuV4z+aTD5aWJfG2IHl33mNAClsUCFogDbRhnTjl/KvEaJ+3YiBgWstZ0wBjry7s46rZXuFYDh//QYkYrYqD1KgWH4Q11DOn0wBWuOtZOysYFMGbTFqZQyM7XGtSVFgPD9L8vR9EPsgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382560; c=relaxed/simple;
	bh=eqzjGPJrbYlEkvKndwV4LorMcDiJlUvcK1Bvjb2oz7M=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fwntJOAMyoY+04NuQ3dfSMze6KVd3Bbl4Pqzpq605kqwQ7hyU9Y06PFob5fRBpHTuGV6w0Z/oYPtfySgaqiBUU60B0vzHHVu8jvY2oE598zYqUW77zluLOrjv7yZPbeobxb5tQPlUuTFj6WQRsWZoEWc8TOFfFiQZBbAuuP2inw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Vn/30TdL; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkfFpVz5Rm7kmA14QLgLy8IOWw6+P4mvASZdpf4WcGpSDPV8UiRZzajqcWFR0Ud/L2mQIAk2sHGzDrFwSCnW8lCJRn8s10vjCfysXq+XCxMUHx67tu5Owh46CvU2qVAEMPEH5I8N+xpYiKDk1dhQUU0NnzYqLO0RKzsb+V+3ON5qfJJWDk+pMpI12s2lxN9RRKKpeWHDP7l6g8Lip5LmrevvNJfg3iN68tNRoug6CjcwBgfczsbsC/mk1Clud7HfxzipNO63KWQadDYB+ycWU40RjQjWv7lWrPWKH3P7Iqh9sGftEIf1cenNolRkR2Bei9VXz5vja371nIzeE18SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqzjGPJrbYlEkvKndwV4LorMcDiJlUvcK1Bvjb2oz7M=;
 b=gSD8yeh1AczB3tfCTTxmII+kvtBokyvhh6DWU0miu0GGAljc3exulqj8t3wVqYAG7rxQm7p6lqcfJ1C3Gjxs6aiOPM+5bypQ+tF49aQxHyHV/NiKFnz7znSS7YIkyb8kkuIwVZpu2KHa9AGlRux2jGR4qdoPZu7ZMWQiL0UtJJCkkpzo0oL40y67b+IQSTBrx6fyt9C90CA2J/64Wn8JuRv5o89S7wjh2d1Q9g+unM3Z8X6/1xjB+zOgK8236YL/U6kiJCIogUgIeBF5pLHKx+yScfXgRBj0f4pyG1c0PvuNnOiu9k+PzW1SdiVOkDTzMcgSK8qRGGpnSGOfyLe5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqzjGPJrbYlEkvKndwV4LorMcDiJlUvcK1Bvjb2oz7M=;
 b=Vn/30TdLKOLv07xaBXeDO5520iyR2J6KRnVi/aM3QUrFRqoEk1dBfYV+h338jQ3cWemWjX3G+cndQ/12mtHddbmWL2pgbIE/xTIV76Bg++vlpTB7znOwTN944pREemz+44SrB7MZ/Qs46mlqClhVl4QCLB300a0gFLa5N3tucPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SJ0PR03MB5888.namprd03.prod.outlook.com (2603:10b6:a03:2d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sun, 1 Mar
 2026 16:29:17 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 16:29:17 +0000
Message-ID: <05f84fa5-d0df-4bab-80a6-5ff2c418b5ec@citrix.com>
Date: Sun, 1 Mar 2026 16:29:13 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Yao Zi <me@ziyao.cc>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20260228173704.62460-1-me@ziyao.cc>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20260228173704.62460-1-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SJ0PR03MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f796f0-d531-4e41-da11-08de77afaf39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	sZUk25zNnV68g1Ij/M31WndH03uHtuU2WcnFn7MPWnwGH06e1qqTQ/J6f5//sllgS72o352zZyeUW/bKCmrRgYaa5Zkftai09lxSxKkDcXAx3diG+B7OrqKhk3d1zMBrw+e4PVccpGbKCT0DnDzM6KP6oyswkqWEbQ67v3NgNXThpdAyCCVnhfHDQEk7+Xvnxqdu/JFAZ6kx9ykVK6yORfseoGRgSr2eDM7WsZRG7lK+PgxyxAoTFWpxxrQH/EWbU30GQS9N4O7oYkTgsdmCNU/ETwFQ65jntoSFWZutKLhcqe8b1c/1WOKudZOwZHuoczj3gpaSdCa84xgPKfrjtMobxp8lDaJTCSsF/IIdAmwb+PTnCvGJyBnLB8xryLc313UUXFc/FmN1K/AAPWrMLX+h0M+Kw0bVj3oDMxcN5vs29dhp0fqRsfT9Ny6GRlX15+aSlut66AkFHTEt/RJZUUEgmmFm03BX5xQixcUUDppVLRRociR3ShZFvUGw0OzFisQoqsVgU6noEHtGfF3PaQGJGG0Y+5DcI4c54mHi+yYyVrsa52HsPgs5RDqlyztEuQZiCFSs4XeSIVZFwRkurbS5LqhQ5B1AwolVTvz7aIv4zW4/bG4MiqY7cfEbG70yA1bAMEl3iCncsstx3xnK7juZK0fHhLmmCZwCPY5vCAeF0PZUMCZq6D6h8lgYeW11IRUgTjpes0Juseym6nwndVoAEcdYRowbBvFgqZJy4co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmhKemZCRDZGRnkwTGdhWE5zYjNqQ3dUQ2x3VGdWbmpRL1orUHRVcjdXWTJW?=
 =?utf-8?B?R1hZZFJ1YmxVbFlZM2JiWUdRTEt0MDZRT0lqNmVoMGF3ZHJEejN4VHlOeUMx?=
 =?utf-8?B?UzVzRXpUcklIR0c0MFJOT3dxc0xxWU9tVDFXUWNqbElhVFh4MHhiaGQ5K0px?=
 =?utf-8?B?emdEVmxxVXpLQXU5NkNhVTczUENFOVZSelRBOTdWS3IyOUVXWS84bERNT2NX?=
 =?utf-8?B?M3BQc21iTy9Qa2ZleTFPdm8yWkpOK2RWcnYyRWZjS1pIQUJMWGFuM3B6V2tn?=
 =?utf-8?B?eDYzMnVFa0NIeVFCSHBZNVRWR0d6ZHRNUXpSMzVRMEM5cDUxZFIvaWhleXYy?=
 =?utf-8?B?M2tWQW1pcEFNc1ZGSms5YndvcUVobnVPNGMwRjNTcTViNGJrbnB2ei95SlV3?=
 =?utf-8?B?ckxBQWJJY1gxYUgwL1krN01FMEJZWkllZ1Azdk1nSlZMSzV2Zm1XUUVhWVpZ?=
 =?utf-8?B?MmVXclV6amJQVHVlelRJNzhnTGZYaWpLNENXQTlBZWVtcWJ2akx5MWt3T3Jh?=
 =?utf-8?B?NTE0VDVaV3UzVGhVV1JpTFcvc1lHNTF1cW1JS3BTTzY0Vk1CRnFoVTBzMjMx?=
 =?utf-8?B?ZS93SklhcVFtYVhjSFVteDM5bE5hMDB4M2ptRXNGOFpBWTNaR3JGZFQxNmlO?=
 =?utf-8?B?VGxSYXRVd1EvSEppMHdTeE4rQnZlSjdjSlp3Z1ltLzhZWU0weEN2R3RHNk5a?=
 =?utf-8?B?eHRtdVNUUlBQYVJTSkd4bGIyQ2RDb2xuUjl0c0lIY2VhRzZiUFRnY2swQ2Fr?=
 =?utf-8?B?aU9xakcycVEzM2pEY1Y4TEN6VWhnYmF5TmpseEZFQm9UdDV5QVhTUWpGMWJJ?=
 =?utf-8?B?QzA2R3NkQWxnNVp0THQ2ZEhHS3Y2ZHRJY3NKT3lpOW1TS3F5bE5oK0R0TDRX?=
 =?utf-8?B?WXd1MkQ3M3JvUVdqNDdFdUJ2eVBMSnRGcitGQkRnZUlycmwxR3p2WmdQaUp1?=
 =?utf-8?B?dk9Ic1FHVmlLYnhFSEZDZDN1ZkVacDVSbnZSUSttOFFYakFzM2hQclNNZ0Nv?=
 =?utf-8?B?aUxGWHhnVFdheEJHaVNVcnhqM3VCQVhveHVnckpKTE1tSFR5eDZNTXFyblcr?=
 =?utf-8?B?L2FHU0hEbjlQcVRWN1JJUUtERzJrd1VENEd2ODlDUTljQTdxc2R2VTRuRXh2?=
 =?utf-8?B?dVB6OUlCN0trdXZzSDVBQ0pKZTY5dUszSzk2Y3dBWmlEK3FPZGpLY2tvUStY?=
 =?utf-8?B?aE44UUYyNm4rU0JJTFlPU2F0WUhSdFg3SGwxNkRyVU91YjdTMm5VTC8zVWd3?=
 =?utf-8?B?VDBZelJkVFV5RE9lVzBKUW5nMmxxaVJ1eHB5VVQvdTJjR1VVcjN1bklhQ1pO?=
 =?utf-8?B?K2J2NjZZaUhtSFo0c1VyQkxsdXliWEtWdm1jQ2xDVm5ZbkczNzRxa2dEVTlO?=
 =?utf-8?B?UHJBOHZRRVRjVVJDcWtRelptcmVWcGgwTlpWN1laRTRINHNQNEkzRFlYdDNV?=
 =?utf-8?B?dHViQkxXUmIxZ3pNQlluR0psZEdSU1JFVEVnSWQ4UzNUMGg5cHBZbE5GWE5H?=
 =?utf-8?B?Vk5Mb2ptUG41NGErMW1KQTdRamlodXVpTXpVcnJEZVlER2hyRTZIeGEyMFFs?=
 =?utf-8?B?bE1hMkpBQjJwd3A2UWg1OWV1RnFTTnFTbHBPWDVUcmZIVHhySlBkdVpKL1hn?=
 =?utf-8?B?NDVuUWhnd0N2b3p6NHVkRmh3Wnl2cDYzc093OGN0Wm5EVzhMSjNwYlllalRV?=
 =?utf-8?B?dXlsbThPZmRMR2tsbjVrbjR5a0xpTlU2UUNFc29xTkh5d1M5cDU0WlNuRmRE?=
 =?utf-8?B?RjJ5TXQ5NnllRkhHRzlUKy85b2RTZmo5aklUSDNmdzJXR1IwZXBXRFBYTmNw?=
 =?utf-8?B?WG5ZZGFFZ3Iyd0VVRXZ2YlVydENVRWEwOGk3WUh6TWtJMGZER3NkZWNkSVNJ?=
 =?utf-8?B?NFlmVmtIUW1zRy9iS1RDbjQxdE5EL29hSjlDQzlDRWJlYnJuUU1Ia3BSa2c5?=
 =?utf-8?B?bHQwamw1Q0Q0WmRMM0FUOUMxVlJlWTNGM2hYcjcvZk1ycXFRakhBMllzUGhz?=
 =?utf-8?B?TG4wNGJBajViem9Yd2RjVXVqRWFQazNhRDNBaGQ1aU9KVk5RTGxjeUVHQVpu?=
 =?utf-8?B?a0orRGFlVUxjbnpHOWgyb3RCTE1tVGhWNkxSREk3aG1jUG9yeFZpOEJ4SjVz?=
 =?utf-8?B?MnhtSVMrWndaUENsRTdQNUZLeWI1a09kd2FpekJrQkdqKzRmTENCZU9tUzE0?=
 =?utf-8?B?bjVucWtleVZkYVlvSTBvd3pseVUvWWtQVXZ3NHdiS3ZuaE9WcnVMRGtCVkNT?=
 =?utf-8?B?TjZaVEQ0NFg4dzZrUjU1cWJBRjBpWXlYOGtUOWgwWi9ramYrQU5vY3NTVlBo?=
 =?utf-8?B?bTB3dHptay9oanZEb1hZZm1KQTBwSUh4QkEvcktxZzRWTjRGczV0Zz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f796f0-d531-4e41-da11-08de77afaf39
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 16:29:17.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTAboVKqmjag0JA6W/Og73rJE2Uiba0Qw81e1kcFCTgo2Ep8g2hNBg49si2yxL9HGQ0YeM6J7yBQpFW8hdJ2Gal8JnwTo+P4OocdIA3tegM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5888
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-222474-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+]
X-Rspamd-Queue-Id: C82571D0A1A
X-Rspamd-Action: no action

On 28/02/2026 5:37 pm, Yao Zi wrote:
> Zhaoxin C4600, which names itself as CentaurHauls, claims
> X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
> related instructions fails with #UD exception. This will cause kernel
> to crash early in current_save_fsgs().

#UD is the expected behaviour of the FSGS instructions if they're not
enabled.

Are you saying that this specific CPU enumerates FSGSBASE in CPUID, and
permits setting CR4.FSGSBASE (without #GP for a reserved bit), and the
FSGS instructions still do not function?

What happens if you read CR4 back after trying to set the bit?

~Andrew

