Return-Path: <stable+bounces-237934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIU9OHt23ml3EgAAu9opvQ
	(envelope-from <stable+bounces-237934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D90683FCF66
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E50DB3021C09
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644C3EDAC7;
	Tue, 14 Apr 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="CcXYbt6m"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE943EDAA9;
	Tue, 14 Apr 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186950; cv=fail; b=F9zRq8Q40GsGU4eXjRscuRR6nQsJolk7IC8/vjQMB8QE1f2g7KF8VWmljhvb/lx623SjKY1XhdgyOghvlValR+TTGIHpUMZsegpoQZu42hABRKHOBUnpT+WWGKPJJWkwFwTInNW+eYKV2kUVQmBR/ut353XVqr3EOJS5v2/aqMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186950; c=relaxed/simple;
	bh=z+3Iz+bBIbK6ryX1rglGMmpUJlmLtlky9qDqanS/zhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6dAummL4Cnu6jtte7o0f+RMDLhsR85v2Me2OM8ICL/reNXY2neCJFkV28BvHoZVnk2Y25VGDOUSM7vFLuIfT2JMH072Pmjew3x0zt/tDZSUHV8GMll9+KQc4bJGBXE4fyXilvyuct5pF5THhWrraK2aTFHVHKzlnUqdCZpXKNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=CcXYbt6m; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNojpQ5weTndkGgDD4Auv7FPLZrn269/uxb06ySSwdLewSKtKGT7TB1ueKRhU0pNaWacG9so+Zvml3LIpX11PbMO+1WByVXTpLUxh8kJfe6WmdIP/xqZLZPnT5slGL8/N6cAghNmfMSqu2jpm01xn8x6717tMPo/GNjV+g4owDuIWh2S7TJYfuQTJvGyLvphKCwWgJsPIlYxc3n/oTVSPljINaWt1mcA6D1sVKGco4sBw8D1ypb6L620YoYSCLbJpWjFWdR73vm97GlyS8hgTvpUxkE/eVBjtJV2ZX8w6FszMoHBC/QulW5xgCsmpeoxYrVD0G3WvjEathJtdZhzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DQFe4OnM/DsTvUN3gy1LG9VqBA+8yDAQr4Uk5PLvSg=;
 b=OIf9bMgi+y/DNu2C+nhntuOjIKj+j8217wiu+pNrLqnJgWPD78YuCvNVNwdYtIiKR+PmDCPPG2hc6xmsQH7amFDxwVRdpc+4U1sXtZrOGn5xtuQ0lvGwdIS/FmmWlh5Mgtrs76FXHpwQpcidOaHJQ8ps1XAZI/5ymlpNl/Eq4C7TjVMbBLunv8uIcYB0N24sBitmJhDRHGLMVWkIqNF6PfkiwvrrbmOGKgfVfq5IsZ9C17A8oQL/o/ENFzwr7XpEkpz+zft/gnFkGFVNGvrtBvGmWd/vXzR8XPYCyvBc++wF6+ZaCYjTBXSygS95bQrasUkE4aPlBemPYD1+c34eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DQFe4OnM/DsTvUN3gy1LG9VqBA+8yDAQr4Uk5PLvSg=;
 b=CcXYbt6mlMrEi2JrMxV3/e/9XYxqQsm62ErkgAt6ne5unpHsRUzU9QwctsiE0eOtdkcDksrQVMHzzrDyMjau1VYtBbc9awgNtPQHXOnKQh3CSSWhbmcILfvSTUgXxPW8lm4+lWQsaAkdOQkhepve2jVtSleroEMjjNkoYbPpf/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17)
 by GVXPR04MB10539.eurprd04.prod.outlook.com (2603:10a6:150:21f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 17:15:41 +0000
Received: from AM8PR04MB7731.eurprd04.prod.outlook.com
 ([fe80::6bf:511a:ffd0:e002]) by AM8PR04MB7731.eurprd04.prod.outlook.com
 ([fe80::6bf:511a:ffd0:e002%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 17:15:41 +0000
Message-ID: <d42214aa-9459-42a2-8cd3-509b2b04a9c3@cherry.de>
Date: Tue, 14 Apr 2026 19:15:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to backport (with conflict resolution) CVE-fixing commits to
 stable releases?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Sasha Levin <sashal@kernel.org>,
 CVE Assignment Team <cve@kernel.org>, workflows@vger.kernel.org,
 stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
References: <ca758574-b32f-4614-88c7-266acf9044c3@cherry.de>
 <2026041455-correct-quickly-c677@gregkh>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2026041455-correct-quickly-c677@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To AM8PR04MB7731.eurprd04.prod.outlook.com
 (2603:10a6:20b:249::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7731:EE_|GVXPR04MB10539:EE_
X-MS-Office365-Filtering-Correlation-Id: 83175dd6-657e-4240-d5b5-08de9a497484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|18002099003|13003099007|18096099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9qbWVuwIg7iY0ZIYjkwjOFWJ6XySIGjAvYqc3ROz0IJZedXFlJ43bVL4fDhd8FxtmEJZFxVZlBUaa+tsogIfARjlC9YhDsJp5cP3dEPDbghCk5Jv1wXP9vlAaNA0tkLFMnZWDxhj9kPHsetB8M7/UXW9/BoTc08x6EzXTycd6kNSDpP/9GPK+Nv4cVEwiG4/UUziPNlqcwmk2mlLu1Y1dONhyQwckLYeEW8C4vDLE5ecUucx61yBrYv8SP/oLS1lkOtcs4k1Tdti+KgAxSFejRirIebj+n/Vs5tkR1lWoTwwMSUhvI/IMItUsXuj5o3ch0q8K6cSuKZ3DPPoHtyz2FGXHKmN0T6hCcuMiRtuplYboygqNV5k3OMUK3500ehenp6YmOMEhYtKpc5KLYRv9sNUYRBQEyH27HGVQJP6XIw+n+gsYQ+jBI5c20s0Tao5yBvyLlwbIbbFZxsWB7thb5W4KUAnfnqT3UhqZ6mlFz3SomR5PhOdvUn7zrQFgogqkv772R0T0bJwNKZbhH4O3cijPkksOlFbP/+k87OHbHZIz/lhsRneD/z+Abwoyrzaxx7ZLXvdDF3ZEKXPEDunFbSZaZBZ/6mK78/oRebaSVGIR0DweWhbbhHHMsa1R7b+Okk8Wns9aUWm827F92PJAycIr7msGSw13Rtp0f5r7o6vTYW/J7BJJKGSesXgQEsG21uYRL4jtC6oF+WfxQcenEDjeYTyNo0SX3gSkROAWbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7731.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(13003099007)(18096099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZ5V2VxelJOWGx0UC94YW9qSHptSGlUNEdNN3A2TVNvbmRBYVdJK2puUUNG?=
 =?utf-8?B?RllsMGZkQ0lBZGxWd0ptbTQyWGVHN2Q5R1FmazBqMldvUGptWHpjOFpjUVZR?=
 =?utf-8?B?SjcrQ2NSNHByS016QXEyS2NuMDY5ZXd4M0lKQXI4Q000OTczUk9sRWU4aTd6?=
 =?utf-8?B?VTZZZUNzRUJSb3FlK0p0K29jdG1zREdMdWVoN2V4MjMzUjVNRzFUYUlCSjZI?=
 =?utf-8?B?a0FVNXVWTWtiQVg2Z2Y5d2ptZEZaU1c3bWdmVzYvV1AxQnlUeFpIaVZlSmdG?=
 =?utf-8?B?c3R6dWdYTVpKMXE1NzZUU0xFUnQ5aWpaWjZORUtDWlhYaEl6d3ByOWFjWXY3?=
 =?utf-8?B?aTBPQkRybStVZ0c4L29pdkZrZ3ZWQS9VK3dLeXljVHVZbmVhZWdGcjZhWlR0?=
 =?utf-8?B?Y3VkRU13TzcxdXVHK2s0RUZMK2p0YXkveXVOYWErN1A3ck1JY2xkZU03V3d4?=
 =?utf-8?B?WDZrbHB3OUFFekdIQWFLUzBReDR0TkdKL05sNVNJbXBid2c5RU1rcmVIV3RU?=
 =?utf-8?B?b0tSZ2N3SzNuTncvRW95SXVCcVJaZUZmemtJY0RTMzQzRzN4azZZVkU2YUpT?=
 =?utf-8?B?bUhvb01WT2dqbEwvMDFyakd0UmRKMjhhb2gzSkhOOFB0TjdzWEowU1VpM2V1?=
 =?utf-8?B?cDNpbHh3R2xEMnZrYTJ3TFJpcGpzSmp3TTAxS1EraEw5b3Y5ZlRrdUljUjNO?=
 =?utf-8?B?emdYdUY0NWdqNHdiSHhJaEwxcUpsOHd5dDFQWjVHL0NvTU81R3kwUlg3L0NS?=
 =?utf-8?B?MjdOdFlkUGl1bXZKcWNQR2JHdGJHZWNUQmtMUUpGbjFVMXlxTGxXcUxTaTdG?=
 =?utf-8?B?d2dFTWpNYldneFBrNjJNY3hhamNpQ3JjVFVTZEdGa0NoUU1NcThHc2tEam82?=
 =?utf-8?B?OS9mbUNOeUQrNk5BVzdBZmozUm9Uckw0ZHRiYnFYNDJEU3AybTVJWVZSbHFu?=
 =?utf-8?B?VXpYZWlrNGpuT3NpN2kyY3N3dUwzNE1MeE5QeWZuRGVzQ2JzUWdlZXhIWFpz?=
 =?utf-8?B?Q1dudGJVQ1ptNlUvZG9pNm9vUkxJRGRWbm1zWmo5eG11dW5vUDZZNTluUE9s?=
 =?utf-8?B?YWlsbWlQY3BJYkdkYjhuNTI3d2xVN0lhdWZVR0cweStIbHNNclFDTGxVT2dK?=
 =?utf-8?B?ZTBxR3Q5ajkxZUliSmV5MlFaWEkvVDd3WUs3S0ZQMXlXam90dGZZc0NBdUFm?=
 =?utf-8?B?ZjM1TlVyVWRVUzJubWsxRDhEK0dKcHY2dXM0bU5aWENrK3N1OXcwWG4vd2pO?=
 =?utf-8?B?YXVOamJnYkNNZVZNazhyNDh6VTVKWllFYkR5TzgzYjgzb1NudzJKSkZaekln?=
 =?utf-8?B?QVkycm9BS3FiUWRNb3RsYmU4Zmp2Ukd4VDdHblRlZU1iNDVWbUtmQ04wbEJN?=
 =?utf-8?B?T2t5a3pJdmZPaEZDSHlqZEtkNGFXcWlUS29jSjhjUU9PbXc2RDR3c1V6Y3Bi?=
 =?utf-8?B?c0FIcXdobnR1OXYrdDBac1oyRFBFT2diWmt3UHBFY001WHNlTW5HaXg4WVUv?=
 =?utf-8?B?VEdFdzU3djAzNXBYVURLNWxRZThCdGV3VEFFZnpJMjFxR2JkQnRuRkJnTkl0?=
 =?utf-8?B?dzZoV2I5clYyMEV0UkV3M2lpdTQyZk1nbnZVZmtSelR0b2wwaHJKRXJHMUN5?=
 =?utf-8?B?SlFTTS9wZDJsYTFLTWlsWU12NDg2Z05YNTdzaTdKNFloQWhXK2gzR1lLUU0z?=
 =?utf-8?B?RkY5djI3cFJjOEU1czFRT2hVOGcrUUNYK001c093RkRFMXRKc01KY2xuZjZZ?=
 =?utf-8?B?bU5TS0NsdEkwRldzSmpCYXJaUGpLeEZWWkRxbUpkMmUwSmN4WHo3QTltc3VW?=
 =?utf-8?B?TlhKNnR6cDB0b1liY050ZDQxNHpVaGpzWHRHWXEweGlIaTNaSFZtd1k2aHVK?=
 =?utf-8?B?UDk5NURHaU14SVB5MVRvYkc4U0tWN2hpQ1hST092ZmcvQ3RidzBUMUh4VzNV?=
 =?utf-8?B?dnRLajlzajhoL0lnSHZWTnlHMU9PbTk5LzBsZVBuUWFIREZGRURqQUtUcWRw?=
 =?utf-8?B?bkdqSU5GcnNwdW02ZTlOVFFGcG1UVUlnUlcvb1ZJNFhWbElKc0FUdVF6QVVY?=
 =?utf-8?B?MHpLNm5qVkNqMWo5OXZqOHA2S0krbW1NWENxdTlhZHcxSmhrWEVxSGZHeU1m?=
 =?utf-8?B?eklSZDM0Mmt2Nnl3dlRjRFZwTEdzZnNUUSs4bHVlaXl4RGVKYkNvSnpwVHVR?=
 =?utf-8?B?c2ZqQVI1cVdiQW96bFpqT3l1L05KRUR4TTFkbXp1TlFUK2ZjVjYvZ2thM3pp?=
 =?utf-8?B?WDVKNVFZR25GZWwyeC90TlE0ck11dzZwak82bVA1Ymx2THpPU2JWNDMvY2dy?=
 =?utf-8?B?NzVrRGRKRmlWcnVlWmM5NjB6c1IybmFDVk1HekhFR1N6aGpzMGFhTjdSUm56?=
 =?utf-8?Q?1f5/hu8SuRF/BBAW/zme6qf37eEjLwKcULnIs?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83175dd6-657e-4240-d5b5-08de9a497484
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7731.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:15:41.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3ZOP0VoWWuCqlQidEvE3zUI/EXQPAk+gXK9n3moVoqDuf6r8omNPnzL+oABROwJfdX/yHreZ39GoL33S8uBhvYCs/E9PW/SS8DSIJPlKLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10539
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cherry.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237934-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cve.org:url]
X-Rspamd-Queue-Id: D90683FCF66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Thanks for the quick answer!

On 4/14/26 3:52 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 14, 2026 at 01:40:33PM +0200, Quentin Schulz wrote:
>> Hi all,
>>
>> I would like to backport https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a7ac22d53d0990152b108c3f4fe30df45fcb0181
>> to linux-6.12.y. It is not a conflict-less cherry-pick as many commits have
>> been made to that file between 6.12 and 6.19 when it was fixed, which makes
>> git-cherry-pick conflict. I believe I have a patch that implements the same
>> logic (moving code around, just that that code is different since it was
>> modified after 6.12) in linux-6.12.y that does the original commit in 6.19.
> 
> Then backport all of the needed fixes, that's the simplest way, just
> send a series of patches.
> 

The conflicts are introduced by commits which aren't fixes, and they 
also aren't matching rules for acceptance into the -stable tree 
(according to 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#everything-you-ever-wanted-to-know-about-linux-stable-releases), 
so it's not *that* easy. (But I now know what to do having read your 
answer below and a few commit messages in linux-6.12.y).

>> My understanding is that this means this patch fits Option 3: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3.
>>
>> 1) It is not specified there what to do with git trailer tags, e.g.
>> Reviewed-by, Acked-by, Tested-by. I'm assuming https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> You keep them as-is.
> 
> See the many backports that are sent to the stable@vger.kernel.org list
> for many examples of this.
> 

Thanks for the clarification.

It seemed weird to me to have Reviewed-by, Tested-by, Acked-by and 
Signed-off-by (used in the patch's delivery path of the original commit) 
kept, as the code isn't the same (and since based on a different kernel 
version, untested by the original patch's tester(s)) and conflicts (IMO) 
with the rule given in 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes 
("if the patch has changed substantially in following version, these 
tags might not be applicable anymore and thus should be removed").
Maybe I'm reading too much into this and it's clear for most people what 
to do from the docs? Or is this something we would like to improve in 
the docs? Just trying to make the process clearer (well, to me at least) 
in the docs now that you've cleared up what's expected.

[...]

>> 3) Finally, the last question I have is whether it's required/recommended,
>> and if so, how, to tell maintainers of
>> https://git.kernel.org/pub/scm/linux/security/vulns.git that this patch is
>> for CVE X, in my case https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/published/2026/CVE-2026-22986.dyad.
>> Maybe their tooling will automatically pick it up once merged, but I
>> couldn't find documentation either in
> 
> Maintainers, and stable backports, don't care about CVEs, keep the
> wording in the changelog identical and properly mark what the commit id
> is that you are backporting.  Again, there are many thousands of
> examples on the stable mailing list if you want to look in the archives.
> 

I was rather trying to ask if there is a separate process from the 
backporting of the patch to make sure vulns.git would be updated 
accordingly, and make vulns.git maintainers' life easier.

> By keeping the original git id, the CVE scripts will properly pick this
> up when a commit that has been assigned to a CVE in the past is
> backported to older kernels, and then the json records will be
> automatically updated when the release happens, and pushed out to
> cve.org.  There's nothing special you need to do here at all.
> 

Which you answered here, thanks! Is this (nothing to do but follow the 
"you must note the upstream commit ID in the changelog of your 
submission with a separate line above the commit text, like this" rule 
and everything will automagically be eventually updated) something 
expected to be part of common knowledge or do we want this documented on 
kernel.org/docs? If the latter, should that rather be part of 
Documentation/process/cve.rst, or 
Documentation/process/stable-kernel-rules.rst, or both, and/or in 
vulns.git's main README, or something else?

> Hope this helps,
> 

It did! Now trying to figure out if the docs can be improved to reflect 
what I learned here.

I'll send my (code) patch for stable soon and monitor this thread here 
if there's something I could work on for the docs.

Cheers,
Quentin

