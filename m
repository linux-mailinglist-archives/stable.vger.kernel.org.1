Return-Path: <stable+bounces-241480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDe3KMdX8GlQSAEAu9opvQ
	(envelope-from <stable+bounces-241480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:46:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1847E388
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96A62300B9EB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF834D91F;
	Tue, 28 Apr 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRYr6cFs"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4786341
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358785; cv=fail; b=PfuIRfEQJrlhp6N7e8PaVShQ5NTsxfyLE9AljhRa6o5ntv4qljV+5kKh4hLugLOC0jRCAgrvlBaKVcKvm9W4+vKEjHT5ZDd+8tf4d7uB/crAjUvxMvVjkNXTRjsnX3gq0++e7dx2VkIJQ4zaq0+1hC/XNUwLCuYJcXcgsxrjE0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358785; c=relaxed/simple;
	bh=09c4oQq0MfU5YdB0YqiBkhZU/7C61mxae7pGfoe9DHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktY7l8dJvT2G3bdIqrUb9i2Br3Ov9CFnIQUwxQzqqhU7gL7MpVaCeKbALRmcVn0Ilv3BNa1aTev7MIva8lTt4yLw0jEkaE9STxykOM8PLSWdNKfamwckdjZAmnbTm3H8TbYZDOYYJr8Y2l8lB7hoxxrTDHvElIqJFP6JyWLPsws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRYr6cFs; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV3XSshuAErcSNje0ZVVfElVWRQEStu/X3pRC96zQC5e6znt87QFfhKXuhrFV8GAavfYQvPaiinQincpXLA865KyLZ8b9oCxkM6D3qVh763GE0mAmYNoK/NCEiMdzStOhaoKP+6adXpxk51TiYZBYch4P74SgCEbSx195GKZFwstC8oJUI+zJ/XERrV+r6vGY8WzVBfm7B9tZjqnHoFiFEl8i+46i0lR7n0ADGUkEkqzqH8AmmWxPPEnnzYJKULW2S6ZjhSap9s1NipG9VIQKcC0N2riDhiFGutA4M12NQILLeGgeByIvPzCVbTqhEH20qYHMOH21QaLG+EJ7j0g5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNsbmsAdcPxvEPMHi1CD6JcKHRbgv5u3I7Nquyq+jPc=;
 b=KOqBDAlu5onczAru0AvD5G7OXT0E95DKNa0e+y/UmjEbh6eollyOi+p5SdJWRRwaUpED4HKk5hXAO960UAw9gReqOW8HOXlXT5hnVa8BkOeAjtV/EeUXby1lCkojhH26efejE7BiohptvVo67us1ZMXPX3Fg0Nb96XmEQTCFGWHPnPNXTuXenGqw2VbtPIZX1av02q55uIz5dWdJKZ5uaEBgkfLi8+/ih8kkmpdac4bv5v0uZA/ceWLxzIqgD3lQSU73BLDqezxrlWlNShzB9mPhzwKn5e1VwbjSDpySQOupAkBLFhsd/JBLqYI6nOqmjxHZIe9lkiBeZCGdFFWUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNsbmsAdcPxvEPMHi1CD6JcKHRbgv5u3I7Nquyq+jPc=;
 b=xRYr6cFsJfw9otfyUYqhuO2YJjkaJG0dy7OFUMHsZQhqqyobRQn80VHYxD+XjWhZPOM6C86CKuit79Wisi/tiWAHhiALoPWfZW9nlQyNgYNOyE+sCCBHUWBJ2nlXpN957pEX3pT5jbNhsjvPvUnLybIzKwdW1UGRuSxxHALi72M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 06:46:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 06:46:21 +0000
Message-ID: <7b71dd61-4e6e-436e-a5d4-d462aeb6a0da@amd.com>
Date: Tue, 28 Apr 2026 08:46:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: reject IB addresses with reserved
 byte-swap bits
To: "John B. Moore" <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260427205336.25202-1-jbmoore61@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427205336.25202-1-jbmoore61@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a75133-9804-46a4-fbdf-08dea4f1dbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1wiPcm514rKh3kO7AguXqEQcEcwUhq+PV9y1PCIPquGDsfFAv2uktMvwW2vnXkG71DErCchg2R+XPAH3AZSF+2pGzf+blgHThb6q4L+ZaMOO/NIDqpDIsmD84yqbC+NxcMQXVnmWCwIMJImBTxxX5UEDKt1nTTQ6y/+V+14dHc6Qspuxlfer0lA2EFkW0jn7F+7FpzoEzWXqcYeATPDLWMyZbB7WvnCrs9PJnlfdxTh2xM2+X+rcEo0E8cVVCU7hkq+AOyLMQIO+b8RMBnCBp89iUeijcS2LKgcFd6pBUfdk46GX7AUFS9TcmV6teKxlEfNGYY/BBfKgXEsEAOCg2w6vk7LfzTCsOFihyU6C7H471yxvWcaYg3c83aaiyEcP+h6Z5KimLK0g28eoeFYaZ7LHeUzq6xOE3E1Y+eq8Whlu5s/THiokCtQWCPvm+TV156JLBQagSvHhkionFvyXxmGiEnOSV2afwgWcv3gw0QnTTtZu07vK7MnB5JQ+0Wy5fy/Vf1st5PqAjf3hG/JXQour1PnxKP6WGSTI/NZDb49RLbbrO3NOeXDF3OLYgdr8055uYg7C6k4odiyA/VOcin0bbVVGEu732QBYWcYkdTEeC3a2E4o+JDqIU6PygdPhZL5Lsh9E2UXhEv688I8lmMf7wIDJLpk0Xi/h/rVvt0VrwnvNhLwn/SkZJCchKkf86OjlYgR48z0waHelFA6uYPsjPmAaMj3lSvLJh0rS1Ac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVl1OTJ1U3Q2dTZPTGxwYk4rdUNvMmlud1B0ZEhCUEJhbmtjaFVXNlR4Smc0?=
 =?utf-8?B?WFo5SVkrcTNLbTRZbEE1dnlJcWlvL2hqaVl2QUxCMkhkelNtQUx3UUNHT21j?=
 =?utf-8?B?bEN6SGl4RnVCbGlmMlpkcGQvQkxlT3hTOEw4Nng3TllkZ1NTYUF1TDVXVHpC?=
 =?utf-8?B?c29pMTg5ZElpQUU1eVBuTlhoeTZVcTRCbEQ4NklPa0NucmpsUGlYNVhhOFRz?=
 =?utf-8?B?Q3VOMzFGazArdFlZTWFlRVc4TTdDVWljRDBkRXVDUGNwODdkNVppKzlsM3M4?=
 =?utf-8?B?UTdkdm5UMElRRlVGTDRzbEJ0Q2g5NHAxRm13SEY0N0srd2ozZWJ1NlEwNUVS?=
 =?utf-8?B?RGhwcHJMai9YZUJVZEIvNmdzcGI1OWcvR0pKVlBKcVd1VGxWa1hRcm9LbGVS?=
 =?utf-8?B?ektZV1RYRkZyemF2SHN3eFZ2TGZRTnROZk9YZFgwL0t2NFJNbithbXNGOW5U?=
 =?utf-8?B?TVJDanh0ZU9tMHQwZERZOXE2YlMyZ2xoZmZ6cTZrQjgwUUFzMkVsbS9hRUho?=
 =?utf-8?B?bVNDdjgweU9NL0hjVE04Y3lLb1Z0REZuWE9HOXpYVXhsN1lsN0ZqWm5pY3hT?=
 =?utf-8?B?M1pWS2x0WjVTNlk3a1VvcHFmTGdHb05xTnZyWVJucWM5RytzSk1rZXgvL2ZI?=
 =?utf-8?B?K1lrNlJrdzEvTnhrL2JKNXAwbGNYV0EvbmZZelBMRFZEVldpZU9CNGIxWGNl?=
 =?utf-8?B?SDZxTHNMQWUvYnVZSDNtTnlFNE5ENDkweWJWSit5WHNjL3JLR25FYW02L3Bs?=
 =?utf-8?B?S2pZZ2lJMWRYaVhWajZMZjJYamRKdnlUYlVkMWJlZkVpbWJHRkhrbkh5aE1X?=
 =?utf-8?B?TkREb2p1c0RPdU5XbVRoSHB5MkhaUnpLb0xKYjJpUGxOWGVwdGRDYmNXV0dF?=
 =?utf-8?B?U2JpQ1FHd3NPS0h0Vk9rMkdZb0I5ZTZNeTFKZ1owMUNzSXVpNWx1U25YZmht?=
 =?utf-8?B?YWEzMUJvcFhoV05rUFg3QVdQSmlEMVJrVFZUMjk3T3VXNm8rU1dmQzVEQURM?=
 =?utf-8?B?RGtrL1FoNStPMURaUXpPREU0SmllZ293SUo3TENRZGVGa1RwcXZVLzVhejZV?=
 =?utf-8?B?KzVPTjVjenBIa216Z1F2aTg3SEhaY0xlYjZUVURSeGlIaXU1RkZaRjNmTTNF?=
 =?utf-8?B?MGRrNFFiS3EyaW9nenpxWE54bC9ISXBJNzVFdG92NTZxUDZWQUJpelYzWG1i?=
 =?utf-8?B?ZGZXWTNNQXA3U0gzcjEwZlR2SVBxNzBuSDNlZmpkdDlYeThIYXZsQkdLaUpt?=
 =?utf-8?B?WFJxWHM3Rk5CeXlHc3dVMDBPT29RVzUyYkJGTThoaVlOOW92MmJaelNQTGdF?=
 =?utf-8?B?cXhLZVVxenBoT2pxcGtuWlNvcHhNazhlSDl1cy9yM29mcmllNFBEejZrSkR6?=
 =?utf-8?B?dE12emhhYkQwMVBwSmdpRWhnemhvT2NBaHZ4aHJxdk1lNWNMOHhvUEx4TE5O?=
 =?utf-8?B?aHptSlI3VkpOS3lRZEx2NUJlSEtJeTQ5MWUvZCt5dWNnVDc1R0hDVVJXUGZT?=
 =?utf-8?B?dXZkMG8rOGJVYnZnZmQrbGpnNGxiZzhSRW5pMldrUXk2UUtBdGtVV1RXTWUx?=
 =?utf-8?B?OUszaml2ZWJvd01jMFVycUZnYkhQdkdpVEk3bjJ1Q2pwb0tQZFJGTFZnOU9R?=
 =?utf-8?B?ZEpKSkxqK3hoTGxUMmtGTGV1NCsxWTNCVUZTS2d3WjR6ZFo1eVFNWmpLVElQ?=
 =?utf-8?B?MkZGNDYwRVBPQXpCME1RTzB4VmJxNm54RjlqS01mM2pGc2FOMTViazlXQ2p3?=
 =?utf-8?B?NmMwbTc2WjBZOXJ2U0JRaEhIQlpxK2FqTDN1MFRPb0gvb1o2SEZHbjkwZjZj?=
 =?utf-8?B?SUVXRlFBczZNVDBxSEFJUXJ6WEJrU1F4RzRIY0NnNGN1OXA5bVFEcHpBR01L?=
 =?utf-8?B?bjVLZFgwakNqWExqRDZYWUpCbko2UzVVTUd6dU1IM0g0UjNZYjR1cGp0c1U2?=
 =?utf-8?B?VTFnVkg0akhscDk2VE5NQjQ1VXhVMVRzR1kxMDNtVzJ2MWpuNGZoSFRpMmxE?=
 =?utf-8?B?aFN1RHkrYjVZdUZENkhRU3JteWJERjdkL2dUOXdDUkljN2RaNWJGZ0pESnZI?=
 =?utf-8?B?ZzR5RjFjK29IbWZqOVJCelNGcm1HbEhZUmFhUjBYSm9acmczKzFaREx0bGtV?=
 =?utf-8?B?ZHBZTGtBb1V2aXh6MFdxUUJKeU1TYlRQK0V3Q2xicUg1OU9tZjhVODF1UnNa?=
 =?utf-8?B?TS9JK0VqaS82OTRJczdpWGdYbUVVdkZWaDZVR2hvNks2d1VvTHpEeDVOTWVO?=
 =?utf-8?B?SGhPRHJoNzBRLzBaTjNSenV6WW02d3o4SlhBN3FWUkVPSWRNb3lSZWZudDZj?=
 =?utf-8?Q?QjsqBS/XdwKf8wWXl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a75133-9804-46a4-fbdf-08dea4f1dbce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:46:21.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D7hWc1aheuE83fXG0Z2BBg19EBqADYZ/hCEaKGHY186Xji3+xofs6Z0GGZ2G1KC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
X-Rspamd-Queue-Id: AFC1847E388
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
	TAGGED_FROM(0.00)[bounces-241480-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/27/26 22:53, John B. Moore wrote:
> Reject IB GPU addresses with bits [1:0] set early in the CS parser,
> before they reach ring emission callbacks. On legacy AMD hardware
> (pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
> fetches. That feature was dropped on all hardware that amdgpu supports,
> but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
> that crash the kernel if userspace submits a misaligned IB address.
> 
> Add an early check in amdgpu_cs_p2_ib() to reject such submissions
> with -EINVAL before the IB is allocated.
> 

> Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")

That should probably be dropped. The issue was there much earlier than that.

> Cc: stable@vger.kernel.org
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

@Alex do you want to pick that up or should I do that?

Thanks,
Christian

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f3b5bcdbf..c44692a2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -386,6 +386,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>  	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
>  		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
>  
> +	/* Reject IB addresses with reserved byte-swap bits set.
> +	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
> +	 * for IB fetches. That feature is deprecated on all HW that
> +	 * amdgpu supports, so these bits must be zero.
> +	 */
> +	if (chunk_ib->va_start & 0x3)
> +		return -EINVAL;
> +
>  	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>  			   chunk_ib->ib_bytes : 0,
>  			   AMDGPU_IB_POOL_DELAYED, ib);


