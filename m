Return-Path: <stable+bounces-225600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBWEG0EmuGnhZgEAu9opvQ
	(envelope-from <stable+bounces-225600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:48:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F168429CBB1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12815303C50B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5953A380D;
	Mon, 16 Mar 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MruOeXS7"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7063A255D;
	Mon, 16 Mar 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676014; cv=fail; b=sOxOHDnozqjp3O+jDyo7J1c/a09lgeNruSxAE0w+bcSI3uMpRlH2bUZYfit2ij3h7IsuSg8j/ugmfpFHRBn1r7LPdPjw0y48dh6uQVR17ASLyKY30yDETBQ+R50y1ailouX+o/0hgZrwjAK0dX40I+QQYSuCAS+kz2V+JmmI41c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676014; c=relaxed/simple;
	bh=m+WspjEo6IRqd6fJjwRCGauqBlkkhpJShOl7uZ1hP04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwn/AgU3rNfeDWl3NjeWKmUwsvLvkhwi9AALiGc/sUE/OkvvrtbPiSiHYBt1rG2TrIo2hiFCDmwYag4ScsgupXxrgHhYtUgN8LxpogE3URfzkYNYpsdggzyy7FH6FnZO2m5OH7FpHcGf4vRGKDFLVx8cVQ07f/ThAvMl6H99l4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MruOeXS7; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6F6C1apRq8oEV7ZQOFiWq+NlZV04UrHdTWpxsrw8Jerqp9+kIzF6B2lJkP/Hcfj54VDiJ5QgW2H/bQSQLHNdZVSDJcnCuv3YiHseUCDGMPJySV93iqIXEWcOwCQgwtgsRf8OXplcLCyMuM4JnRyRxhfWvFooOHyQMFd7zrJBf9c7/NqhNOQs+1L3hR5wK0YZ/gkT9ngNsLoqQCukNp2kowaDZSWBi9JYlMiriIUQb6MGZXyGwxt7ETwHD4DjcyUDA5+Yt8S7WwJC7mE8XkkQ2IeR5g45StdtIxQnbSGABssKuptTTn998YqWTc+ZmDkaMBmDVqqaT5BiKn8hk5erA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ6XE982oOZ2IImIJP/3fDWQUBuc+rlVgfgVGHLTt7s=;
 b=EtIdYJqEwvfqXoT3irMO7mLtiwdE2UEuYbfA42GsQCZxVf2naKfsHTlc85VKcIypTYiS6fYO6ygfsrRq5EWLrgDhMg1EDpy3KLpuSRBIRq5O7Dx07sWi615AuBCpi2Noe0JKYDOzrOqejWUAyyGKQ3m6RIvjUwKk5LrLdwgd978osZTMyBuZT8AA5qdEfvajyfenyKWdYM2adDMS1txxbwrdA5LtBcJbLKlfEmPts+7djpXT8NY3VREwYcmwAE7+uGYr+XCH9uvSgjU5BHjONbFIT0xonzqziLHJOspnoW+LGgdF6XDZQ0I5IKnlAtYTXT+jwIJMEinCUZCcZRPLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ6XE982oOZ2IImIJP/3fDWQUBuc+rlVgfgVGHLTt7s=;
 b=MruOeXS7iUbQVvjdWnALGW+MnKNPAIu6kVRxa6jPJBmjCKImEWmk5Qyte9YYXe8h96OE+GalazXhlbHQQJXN1XEXDazCCRqYIXzWEk6TpBtzIfWpdbF3/I5b35zCbHVpjxyPwrXT6tIk1i6ctqO1arYMD8uUk0OtWIQHF7bNzTqT5ikTPwXq0eVfGICl6y9/B3ZRsUHaYrICzUQdvRRq9QOSX14Olm1SdcKAeUp0cGxBL7wKbimgX53ywd8QtyzDHGbFn9mUG4oTH4XAD70OddaIzkJIIYyhLYNIE8KLNIbZcqrx36Icsx7ZOubC4JPeMTCSZzlGhWkAiTXzl70rLA==
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
 by SY0P300MB0433.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:281::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 15:46:43 +0000
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda]) by SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda%4]) with mapi id 15.20.9723.018; Mon, 16 Mar 2026
 15:46:43 +0000
Message-ID:
 <SY0P300MB076988C583395625B91DC00CC640A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
Date: Mon, 16 Mar 2026 23:46:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <abgcKvuSQc2ZYKw4@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <abgcKvuSQc2ZYKw4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:d10:33::10) To SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::18)
X-Microsoft-Original-Message-ID:
 <365fc57d-ee3e-4c54-977f-345789426d20@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0769:EE_|SY0P300MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: 539cc38d-4b69-46a5-3720-08de837338f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|8060799015|19110799012|23021999003|15080799012|51005399006|461199028|41001999006|1602099012|40105399003|3412199025|4302099013|440099028|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGFSVy9RS245N3B2bUU5V3hIbnBEbXI3MW9lM1JkOXNWeGg2cWR2NVdNQlpY?=
 =?utf-8?B?ZE1rRkdQTzRvZFdlWXlGd3IyaVpxZmt6aTAzWk9xK1h2a1lpK3RWMkJDcjB3?=
 =?utf-8?B?dG5YSkxWa1lYT0lobU1ZeWNjWWdORjRva0U1Y1g0V3hUWmVrSzN1Zmhta2FY?=
 =?utf-8?B?QkkrdUl6M1J4c0FOQjdwSjNxcGsrUVpTWk5VMmpKa3pXbW9hbTM1bVpLMFI1?=
 =?utf-8?B?aWtWaFVOMlFrYWhyOGdpOExJMnFiRHdOWndYN2pIK0lhd3dJV2U3TW9Wcmh1?=
 =?utf-8?B?MlJKQVd6OHlJMzVxOTRTN1VsTU1jcE9GcDJSQlBLdlRaNDdxM1VDYVBvSFFw?=
 =?utf-8?B?MnFEa291VTFaTU95ZVVaSEhKUzNaeUd5ekgzeWtEeWJoTXB6S2lBb2crSWVz?=
 =?utf-8?B?My8vc20wQUd2T3o3RGJLT2NGcWc4cTVTRkhiNnl1VTZSSDZoWjUyRzBOc1BL?=
 =?utf-8?B?V0ZKdGZjbVVLR05sN1VOd0d1aUpGYzBteWNEdzJQOUtCMUk1TjB5Q1k3L3lU?=
 =?utf-8?B?QVpVcFBwaHI5L0RMdy9tdWhMeDl6RFc3ZlpHQnh5WkRabTdxY2tra1dhMWVM?=
 =?utf-8?B?a29lUnU0ZmZPQktSYzdJK20vSEF0UVFtNXlGTTRjeHNNdDBmb3ZuNjlYQ0N4?=
 =?utf-8?B?TEdObk1Qdm0vN05GQ0UzblJXUEFYc1JGc1JKTkUzOStseDRRTnZLZGJxN2V5?=
 =?utf-8?B?bVRUOHNmRVhVb2V0andOUGtPK3RMY09mN2RtQ2dFbkhJb2tkWVdRak1qZ1lv?=
 =?utf-8?B?YjIzQVFHdWZMOWRsTkgzbEtvaFJUM1F0R0VSYTQ4aFF5OTVQSlR0NXloTTM5?=
 =?utf-8?B?dWpwcThDRG1tN1BHU2tzOWpkUmREME1laFNLUXk2Sm05dGNOQXJxOEFOdTZy?=
 =?utf-8?B?TFdLeUVNdUViOTV2K0lkWEJZanV2SjNCOWlRanIwL2xxVWhpN0g5MFBySWhY?=
 =?utf-8?B?MEIwSU4xWE5HOUFTYUNvQ25BZUJaZ2FMUVRZRlk4RWZzRXdwU01RYmxBTGJ0?=
 =?utf-8?B?QklHeFdxaFhqc3ZhVG5PbXEyZHdpUVV0VEQxRUZ5d0YrME1QczdnTXdBV1pE?=
 =?utf-8?B?QmNVYTAvNXF3L1dNcFhCR01SVTdpTWlrWGszK3diVWdZcmVHK2YvY3lrY1dD?=
 =?utf-8?B?bUM5ZW5Db3dwdjVzU1NzNmh1RVU2L2Z6TG1lQ05HTTNDRkRmN0xwcGh1SUJI?=
 =?utf-8?B?aXNMeFBKZVA5QmRRdlJUcnNZL3g3c0dBT241SWxPM044Mzk1YStoUFBCbUtH?=
 =?utf-8?B?WHdlSk1tcmhBL2dRbFJmREp3MjNISDJvZU10UURsSktYejlyUjU2bk9SejhQ?=
 =?utf-8?B?Q1RudGhRbGJnY0QxeGVFUHpodjdva05DNUE2SmZ1WmZwaFNiU3RSRXI2SzlG?=
 =?utf-8?B?b0FuZjFhR1lLOEFSSEpUT1NmWEM5ZXhkdG9TYlNHRUxWaFNENC9ERGVNV2pY?=
 =?utf-8?B?akQ3TEMwcTlyVStObGVCWUE1NFpySnBod2R5elJ3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZYM25aSjluaXhlS3I5UVFUc0NmM3FHcWU5SVVEUjF3Nzdxd0pnVmxwcS9Q?=
 =?utf-8?B?Zi9jYlRJSEp4QmRiRVhWOUkrdDljNGtkNXR1bVk2aXRTQVZJb25WZUpTbEZ5?=
 =?utf-8?B?YTM0ak5meWhCN3pFdzZPSnNxRXNqYkMrSDBHaDR4WkdNV2dFWXRsWS9kbFo0?=
 =?utf-8?B?RnVGVWM3YU5SR3JSa0ZoN2VXcHhEUTE3YzRscEoyYk5iY2hORDhLd3J2YXdI?=
 =?utf-8?B?M1JleTB1RWptYkRrTFhDZXBtcnAyMUFwNy9JenNnMXNOelJZbUlYYStHdDVm?=
 =?utf-8?B?SU9vNGhudkIzdGVEcUFjRVlHTTZ6RzA3Y1FnVHJYakpyOXJhaGFxQVF6L1hv?=
 =?utf-8?B?MGF6TFR5UUxTdllVL1MrMEkyZWQyR2p6ZEdOeU5OSVcreXRvREUxU1I2c1c0?=
 =?utf-8?B?aVFxL25pditXOEZaa3BGbzBIaWRzdDhCYW9mdms2QUZpVDVKTDJRWU9nK3pO?=
 =?utf-8?B?U3I4R1RzTmQ4RjYvbUdqMjNIMU8rd1JIZ2J1a0pqRU5pMTJrU0JxZ0tMeERX?=
 =?utf-8?B?Q0hrZ01HbVBjc1E5TmY2MzEyRE5ta3ZGbkRMT2JzS0k1Q2VJNDlxUmRxTmlY?=
 =?utf-8?B?anZmNklxMHMrMFBVRFBWaHB1cVhzOG5LaFRmN2NWWXpsQzl6ZzVwYW5NNUg3?=
 =?utf-8?B?TG43U09RSjFBcFZxQlhYbUVXdUtRcXQ1ekNMS3NxdmFtcEZDV05qcmhRTlpy?=
 =?utf-8?B?RE5pRUFwSTh0cHhhVmpSNXIyWHFqYVJHb1Fpb1Z6a1Bnb2ZTV21DQXdReENy?=
 =?utf-8?B?cXdaaS9IWmJjQlcwR05XYytxTTZWUkVVMTFMcG9nK0lKZEdUWEJpMjhLUGo3?=
 =?utf-8?B?K0tEUXJIYnBrTzJESThKRzBiZGs4eTV1YjB0ZmR4MG1lM2Fnay9qTHY1UVVG?=
 =?utf-8?B?REZIbkN4cmx2LyttVEVqeWw4cytKa3RyRmdpMHV3b1VIeUU3YkJRSndHU1l5?=
 =?utf-8?B?YlduTVJBLzROQlFjSmRVR0ZuRUExK3Q1NzVVUnF1ZlMxa2FNNDNzVCtleGxU?=
 =?utf-8?B?N0dST0txZ1dEalFIYmZJMHYwREdFRW9GU0ozOGNwMENhdUI3ay8rTERtVW5U?=
 =?utf-8?B?MWVGM3BwWUhhZWFyMzdrcGRxVGg0a3RuZkQ4VEJWRENzNGJ5K3BvRFYrcGVt?=
 =?utf-8?B?ZW1CNEFIRzlkeVNMSW9XU20vN0FrZE02bzg0dFAvZ2FCaHQzRWoyWDlzWUIv?=
 =?utf-8?B?cTRkRE1JL283TzQ0VkRWVnlxNkhXV0haOFpxSTR1VEZPdkxoNXRhckV3RS8v?=
 =?utf-8?B?YVVENVUzaWNEd2NzV0NubEtDc2M5S1JPdEt3cExjMnlOZmYwcm04THlkalp2?=
 =?utf-8?B?Ris2cWk2VnhRNWRvdktPYmRScjlFdTM2SjRNTWJwYlhqdUY2K3FrRk93WmUw?=
 =?utf-8?B?RURybVpxZnRvTGtDT1pSUnB0RlhoSXI3cThER3FsZmljRTFSTjE4ODZCUHBZ?=
 =?utf-8?B?WjZDaHJLVVNKeVF1aHgrckd0cnhXM1pOWkw5a0F2Wm1TaGhPS2dJMEZtNTZT?=
 =?utf-8?B?N0ppQ1NoME5pL2FZSFl1WFRva1dMQ1pOYnhVTU43TjJwZjdKc1lES01SWDdZ?=
 =?utf-8?B?OXNKdEVTYlpBN21tK0JlWStUclk2SFNwSFpEVzZ3aHdCSjc4YUVWMW5IR2Zu?=
 =?utf-8?B?akh5TlVxNTB4aXlReFVMTlRXUSt3MTUxMFdLTjA3d3VhWmJWd1Y4MitVaHJR?=
 =?utf-8?B?R0t4MG1sdGNlbENNNnY3UzYrMmxGcXY1TTBlQUkvaDlXdWt1NllDZUxUa0E0?=
 =?utf-8?B?Y1NrdHZrbVFjeEdyRDRWY0N6Z25HK0dCN1V6VHBReHplSTk3R1Q4WkJNYXlR?=
 =?utf-8?B?ZzBTaWlCUXlGWmdCTzNBeWVCZ01EMXBLS0ZwcjFJem1nZjdNNnM3aHVEVTBw?=
 =?utf-8?Q?RZkPjmFRCzyb1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539cc38d-4b69-46a5-3720-08de837338f1
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:46:43.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0433
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rsworktech@outlook.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225600-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: F168429CBB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/26 11:05 PM, Paul Chaignon wrote:
> On Sun, Mar 15, 2026 at 12:02:48AM +0800, Levi Zim via B4 Relay wrote:
>> From: Levi Zim <rsworktech@outlook.com>
>>
>> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
>> For example, this causes bpf_task_storage_get with flag
>> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
>>
>> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
>> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
>> for correctness. Add a comment about this limitation that architecture's
>> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
>> bpf_local_storage_alloc always fail.
>>
>> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Levi Zim <rsworktech@outlook.com>
>> ---
> 
> Note there may be something broken with your setup as lore is reporting
> that you sent this v3 email three times. Not sure if it could be an
> issue.

Thanks for reporting! But I only send PATCH v3 once using b4 with web endpoint.
I only received a single email myself.
So I guess it is a bug with b4 or lore.

> 
> [...]
> 
>> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
>> index 605506792b5b4..6e8597edea314 100644
>> --- a/kernel/bpf/bpf_task_storage.c
>> +++ b/kernel/bpf/bpf_task_storage.c
>> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>  
>>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>>  {
>> -	return bpf_local_storage_map_alloc(attr, &task_cache, true);
>> +	return bpf_local_storage_map_alloc(attr, &task_cache,
>> +					   KMALLOC_NOLOCK_SUPPORTED);
> 
> I can confirm that this does fix one selftest using
> BPF_LOCAL_STORAGE_GET_F_CREATE on riscv64: test_ls_map_kptr_ref1 in
> map_kptr. Other tests using BPF_LOCAL_STORAGE_GET_F_CREATE are still
> failing so I guess they have other issues.
> 
> Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

Thanks very much for testing this patch!
I am not sure why the other tests fail but perhaps it is because
a big issue for fentry/kprobe on riscv64 is that the first function argument
cannot be read as a0 register is clobbered [1].
I will try to run the selftests on riscv64 when I have more time.

IIRC the issue is workaround-ed by using PTRACE_GET_SYSCALL_INFO for ptrace.
But I got surprised by it again when adding riscv64 to my CI setup.
A working kprobe/fentry bpf program on other architectures cannot read the
first argument of exec family syscalls on riscv64 at all [2].

[1]: https://github.com/strace/strace/issues/315
[2]: https://github.com/kxxt/tracexec/actions/runs/23147343712/job/67247821299#step:6:1429

Best regards,
Levi

> 
>>  }
>>  
>>  static void task_storage_map_free(struct bpf_map *map)
>>
>> ---
>> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
>> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
>>
>> Best regards,
>> -- 
>> Levi Zim <rsworktech@outlook.com>
>>
>>
>>


