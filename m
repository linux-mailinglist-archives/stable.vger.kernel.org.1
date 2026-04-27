Return-Path: <stable+bounces-241246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBssECIQ72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:28:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D546E5AC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0327A3001FAF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74AB37BE9A;
	Mon, 27 Apr 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z69c9ntK"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E003914E4
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274908; cv=fail; b=ZcjLNhQgH76Z9EyBBZGp3zguQKlntKjphDs5G7wsd8mFA/izt5XpsuUGfA3mvRE6p+BSghJXiuZV7qK/xfqUy7ORr+ILMHHRlofqhaSZOdGhMFhMyN/Jw3jDY6i4Tve80FTXrDBrxmC4tNvnaHog4qGekvlNfi+C38Y6gELt1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274908; c=relaxed/simple;
	bh=/RGsPOHeaO1F+YeHhRhFSov8odcexooDSU6AaMica3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X306nXmjn2vTQQWM/DgWGWEXS+B2zeDQBDZr6Q+8vArbOpRpLLCLJ/JX6BszJrVX87tpG58KjwcGYWrCLRkCd5a6gr6Z85lcctjqmTv0zrEkQ7mKbS/bakVk9YSqBooPOifEw1lrwIygsHMlnMv7LrVXMmLbUiVE5t0Js0gDWv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z69c9ntK; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/2v4LJiqicRufqtflBURap1lebAwxYcrneEj9BJQWavqi9iI9dNsc4CIwCwsaX9HuvLHRf5VScEJOIexb2/wM3BA7KD31pgxrAo4MFYnxjSIpxG1n0MSWEfVlA9mdmnO/WS2VJhNFkpnoQRqPQrpUvUZgK7kEpE2Oaeg5pF+5/Eg9E4xJ7OAhAFyzRzh8uloWWMId3rRiGDfzADjN0OX7sMbJYcsCi9Hkod/n9l/JL6u20fCXm0D845xPBm6dOCruzV1X7M+2iATZDE03NCSVH6eXujjgrY8unSNVobtIwWhDHVkseo2R5aeRiWHytP32Xeho4OiOASom8gzzncVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtxI8Li/WJtci8pQ6DTkgny/ARuk28a9AlaM5U1q7DI=;
 b=KP1UPPc5Ikom0nLhr4PW6zuiCk5BhyXEmn7q9y8JoEPKz4bZu3p6LN2O8LogMXVpxbg8edy2rou8Xdz5wdo+YumqHh8pznmVOMn9O+zLjIM+WrUUe0EKxFH4PELwnyKLGxJt4sfr4JaXZH1W8ZIJNOmWW0QA2rkv6ymUeruASz5wSZEv4imS1sGeToeEVavOuNkzDs5i9cvm7oj+tohgQuHGHD9rL54izTSqUdiXuwjla0zFJH1VaYC3FsPxZ4yHXOucf4WM2wn1PIfBEJVPC8r9ZnniAzb5jB1lkx3MeklHnx2R56aYNtYyXq63bcIfTXEOdrdpksSbxVnEzbURVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtxI8Li/WJtci8pQ6DTkgny/ARuk28a9AlaM5U1q7DI=;
 b=z69c9ntKfASqvt6GHbquQFDf9BnYNbbbLeri2wkc0OAMKdmRWrNGWXpzeHYBfhmnW9cCnIXBbebRsziIDdgBskAE0T4QC6Byjj1U+3YSbYGbjMU7Q8NSSs9VS0hTbmcjp3LI0kZk3vtOfBobMUaAT6zIxLJUkMYVrruh3GOe+wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 07:28:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:28:23 +0000
Message-ID: <cb27e9ce-b181-480a-bb45-a4aa460bab14@amd.com>
Date: Mon, 27 Apr 2026 09:28:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu/gfx9: replace BUG_ON with WARN_ON_ONCE for
 KIQ 64-bit fence flag
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260426215256.50722-1-jbmoore@nooks.dev>
 <20260426215256.50722-4-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260426215256.50722-4-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: d52b1b15-2661-4836-42d1-08dea42e907e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dpOOszrdSuGCmVq1bbQBN925DxXiNfRuLoRk4AQ32OTylCeErooboabeBaHCmxtSm0GUrRLwQvkurPamD58TcbBeyEwSlbv1MXa25CTfFAri5fsZNfnMPeoQZyY2A4qWZLrnU/Da6+HqB5GK17FB95Bd8eob+XnOxLoDdtBEvKHF179n3Pqv1aJ1+i/gWXKS2ujC3rwR/Kb+4XflNKhcEzww0S8JnXUPXf3s5ZZasuFUwsnCZDfvPrW5wnLUsPtpv62tXzTNXMeWyMU40Bb7kFDFAJ8Dod4hR5i5NeVUMOmb4vOZmgS9XInMM/SXCNP1/aNWgVjvgey8XsDHBrPfC0/dafhlsz8A4GhoVYLo1nR04C6Gm87y9q7oeO49Pfga9txls7y39iDXqrr4Kh94l3J6Fwk23AU9Z6JJldi6I6IO/NXHZYrvlR0NgpU9U0pPT6m7LUuuFuCMzjZtkJuAieFlNY1gijZZhK7y+D1EwpNPG5l8FjdsnLzaxrHO8Y5emznhssR9qv+mfP1wt+gXDXd2vIZbN3gGnMUDBtYWPmdwVL8NmQ+kV4HMIgXCyyTaFcYXwS/Qo20s9BfwG4FQVEPN3OidiPjqiOsArR5/+/SlfJtwsrsftDooAs3quksgLBmyFKJTgqj6rOvO/zGs96hhsDFMB8GYh8BAI+PggEVx7M7DPpK8w4cxpqdle1iTUcJGdV3WChM0oUSmmOT5fnpCbUpV7bsYVmcAVuCDCWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkNVZCtlbzY4N3RxUkJzR3pySEpac214Z1E2QVdhdE9EZkhkVnFMdUFEdnB6?=
 =?utf-8?B?YXAyT2xiRVlnT0p1Vmx0bFR2NG5vNkFCa0xQcFdSQWUzOHNnR0dvRGs5L01n?=
 =?utf-8?B?TUVadlRKdUVvb0p2V0Jxa2JYUGk2RFJnaG9mcGNrTzJYN3VaWTBWeUZ6eGZX?=
 =?utf-8?B?dEx6cllBN3FibTZsdXFPTW10QmRaa3dvS1hDTHh4Tys3ZjRqT1RqeVBaYVJh?=
 =?utf-8?B?RHQ1dFMrWVhpQ1BnNC9KcXVtZmpBcm82aTl5WEMrbVBHUkVwNUNodlk0Zmc2?=
 =?utf-8?B?b1liMG54K0dKS0xxZlRJaDlVM1YxbmxuZGh1NW50NmV0MXV1azhqcGduMTR3?=
 =?utf-8?B?NVgzQmF0OUkyMktrOVNyR1JoU1BiVHdqV1MwYUZlcVVmazBEaHlOMDgzeFhN?=
 =?utf-8?B?OTdZN3JDaUpHNnBuMm1GWDRCRzUyUGtSKzQ2Rm85Nk5GWkxNYU9jSlBCKzVP?=
 =?utf-8?B?UGtQcndsbHJnbHRVMjBwQ0IrZUhqQk95Y05LU2MxMUt1SEJrUEV4N2ZsOHZl?=
 =?utf-8?B?UDRTS2FxNHV1RE1QTWtBRW5uVVNvOEg2YW9GcE5pb1Y0ZjZzZGlabS8ya1Vh?=
 =?utf-8?B?QlhFV3VMMklDVUF2R2pvMVJ1ZXZrcTFLUXVIYlR3SDUvMFVWMG11TGkyWDkv?=
 =?utf-8?B?ek40dTF2ZmRtWmZldkk5MFBEeEZybUlraDFkMlA3dXJmbGxzVHNYU09lb09Q?=
 =?utf-8?B?Znh5Mjc2UDJMMlArT0FDa1hmQmlTSmtUZ20vRXZCK00xVlRrSS9pMVlxOFNu?=
 =?utf-8?B?UzNscFBoRElRTzB0VWNtRmVDellTMG04Q2g5KzRpa3UvbFdBaGZjTkZ0R0R3?=
 =?utf-8?B?OHNjckJxUE4reTV2em1IVHhjaklpR2Z2bXA5Um5mS1FxRFo2bTlvR2ZnU2cr?=
 =?utf-8?B?NXlCblZ2cDN4QzNvbU9iMEFndE1CbkJLQm5YTjZkdmJ2Y09vWkpHdUVVSU9Z?=
 =?utf-8?B?Z1Q1L3ExZVhtRkRUcVRDaHV4WFR1TTllM1J1QkVORkRNaWQwUmUvYU5EYmhO?=
 =?utf-8?B?b0hXeEZUK3ZNOWFFL0hJM1V4amhrK0I1WTNCTHNJMmlxZVZSR0grM3dZVnRI?=
 =?utf-8?B?eGZSNGlrLzJqUjdTZG96eDF3OTJzYS9nbzc1L3VMTWVqWWdNenhzR0grTnVo?=
 =?utf-8?B?VkxZL053aDhiY0dqYU1MMHdIWm9UZHR4d285ajBtdWE4OTFWaFlpWkJMcko1?=
 =?utf-8?B?NGs3dGpIS1kzRW1DSDdKcmZFZjJldkpoMzMwQVRXdzZLc1BlV1BkUCt5QzBt?=
 =?utf-8?B?dlJqSjlnM0xHWm15ajlmMmxnYjZ1NldFZ3dlRzhWWU1WV1BkWVRxdy8rM2w1?=
 =?utf-8?B?a1hPUEJpSVQzYU0xbjY4QzAvWmI4blpEUFcvbkV0aDQ1czdlaU0zYVNSMnhW?=
 =?utf-8?B?ZXFaTkdraXRoVmtTTWw4bmsvVkRXaGVqem9UWGZRQmxXTFVoWUVleCs2elEx?=
 =?utf-8?B?ci9yTmh4anVodC9EQjVpUzFMSk95SVB5cjFGaVArN1pUL2hNN29LUU56c1RK?=
 =?utf-8?B?ejh2dk9INU5BRldZaGl5WFVvMEl3VnEvY3pobm1TMjhuUDFabFFFcUtqZm1a?=
 =?utf-8?B?ZG92QWhBOFpWRVFLTVRHdXdxQ21DQkNPb1ZQaTZtbVlXQ3doLy9hYitTYkVZ?=
 =?utf-8?B?cjlicHU5WG1CQ2pMbFUrSHl0RlRkWlBJR25RaGdBOEhqYm5qQmxidVhQZU95?=
 =?utf-8?B?QW1CRy9DVmkxdVNSK3FSS1ZSa3pQN0JWMVc4TFRuSGdTL0x0TWFXdlJxMDZx?=
 =?utf-8?B?Q08yYzVuRlNUUUF2b3JXN2dZVHpWQUIyaVREbHlKOG9iaFVBdk1aMWNuM0xU?=
 =?utf-8?B?OVpQRTM5M2VBb3RXdmtrYk9DVmo0TWFYWUY0RjI4WXo4NnRHQy9ZWlBGcHg3?=
 =?utf-8?B?YUVCMHo5bUhsMmVnaXMzMHZPNXRuUXp4RjlHdkd3azQ3cFdONmluMmNqKytN?=
 =?utf-8?B?Sjk5Q0JRWWdnN1FyQk9maW9XWnFwQmVEUkF3WkViRXhzY0dtZkdwb3lHcTJZ?=
 =?utf-8?B?VVVYQVBSSDhpQXREcllKb0c1cnA0MmZPZEtMMXgyZGIzZUJBYjByZHZyMkdl?=
 =?utf-8?B?ejFKK29ZakovbllmM2hpUXJ1UjV5WDR5TXVCcmpuZHhOM3I1bllDbnZwOWox?=
 =?utf-8?B?eUJvOE1UN080VytTV2o0N295b2dyTGw5dzR4QnFGUS9odllSbzRrSXlkSkMv?=
 =?utf-8?B?SGNNRU8xTHdvTnhkYWszOG5RWU9kNEZHWk1kS1hQcnpIVi9sNk8wU3FHRWxT?=
 =?utf-8?B?RFk5eWx4MmtBem1zZi9sMDlTN0IyL2RxbzRjZkZ0RzFjSDB6RWZCMXZNMlpi?=
 =?utf-8?Q?O8v5S6Z4Vxo0z6pcXc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b1b15-2661-4836-42d1-08dea42e907e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:28:23.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0PycWYdo0xOUFUJ0J4kEFuZCFmqnthvNUxjE5f/d34lWJ2ky8UNzCPQWFVvCIsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
X-Rspamd-Queue-Id: 472D546E5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241246-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 4/26/26 23:52, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> gfx_v9_0_ring_emit_fence_kiq() contains a BUG_ON() that fires when
> the AMDGPU_FENCE_FLAG_64BIT flag is passed.  The KIQ (Kernel
> Interface Queue) ring only allocates 32-bit writeback buffer
> addresses for fence sequence numbers.  A 64-bit fence write would
> overflow the allocated writeback slot, potentially corrupting
> adjacent kernel memory.
> 
> Replace BUG_ON() with WARN_ON_ONCE() and mask off the unsupported
> flag.  This prevents the kernel panic while still logging the
> unexpected condition and falling back to a safe 32-bit fence write.
> 
> This is separated from the main gfx9 BUG_ON conversion patch
> because it addresses a different security concern (potential buffer
> overflow in kernel-managed writeback memory) rather than the address
> alignment assertions in the ring emission paths.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.
> 
> Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org

And completely forgotten: Please drop the CC stable here. That is unjustified for this patch.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47e81c33d..fb2a0f1af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5679,7 +5679,8 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	/* we only allocate 32bit for each seq wb address */
> -	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		flags &= ~AMDGPU_FENCE_FLAG_64BIT;
>  
>  	/* write fence seq to the "addr" */
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));


