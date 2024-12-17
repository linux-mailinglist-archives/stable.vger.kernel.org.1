Return-Path: <stable+bounces-105052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0E9F56D4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B23161C58
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2A1F943A;
	Tue, 17 Dec 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XJu1rDqd"
X-Original-To: stable@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022104.outbound.protection.outlook.com [40.107.193.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839B1F8EED;
	Tue, 17 Dec 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463348; cv=fail; b=s2hEb16f7lOvkwZnyPM2ybJBh4ZM5coH6r/NPmeRIP/7bp2X6XvMfQXByJ07Q+apEFVxtM/+Aqx5V5n99PfVC42ESA0Ar/GAeDZIMh0fYbao1Ov0Wze4ic/Yrh2LScLoM0osxPV8tTPOmcU7lh6fekNWP65w3nJTzxdzTkkSaSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463348; c=relaxed/simple;
	bh=OHTyuA5AOAOkkGl5Ab+kesN7Nfb4WTK6ykvj7ZB1L6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KY4j886F3+LQhIKZRGKuwvl8zH42FFEnBLujMdbSJ7c8ylypJNPRyKMxHIQPagxESXZmVwdEU/JYCB/vMYKySGjCzGYSFhx0hCwkRjkjCB6+IV0RJLhx8KpxipxhzzUuzriNNKD5upEECKcvK3ukqNN9IDLFGRgMLehLnhhPbVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XJu1rDqd; arc=fail smtp.client-ip=40.107.193.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCIz6Hl4ifyuzcipG+5Hcd7npziWrZB8d1uaqW6IWo4UaXnj5VXq41QhIECi2tKrOdC6yZX9+9wF3nfJQ4XIqkrnO5Icn3xlFG2mI/fro+kGpiKVVsFVA7shosBbMO2F0D/ZQHCQjEZPXm3LrxcBdVQZw3N7JHT0uZOJ8LZ4CdDoGYWYG01RI6tcIvbC8rTQx0epKpaDs9YfN4Ud0+TaA+YalHtI/mED6a0s5PnM85HMOn0HRsieW5aBdZ+XWaIzHj6NdHz+xLsSGhRQJy6e853RHz2Y5ihXXl7IGolRrihGwlqlNusujAglJgyQW3cHvfDdnF2kC7hiscWBCCsKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfQ+iYgjwU0veT+4LBNAEkDtBqiNcweUP5phiQWZUlc=;
 b=LsGManv3hKk0EZxHYtwBrUPEj9RX4AlY6X+Lja0048lugZkp9q5PjZMiMVpLbJIV30CyvpKz0Dbk1FbbrXXcM+26bYZaOPTIlhsYWtyDbdHYXxS9dH/Uk5JfqWCK0GC23cVu3QOHWR71KvnabSzIT2n2pCeQYYjc5xEOUWsC0YC1vH484gL7NUKo9FLGaQ07H4oTnyHinwmnybaknewNxxSmUlJ9KA7p4k890NKVu/Jg6ksSKw8jWQCafXvezkU/nYs+5xn7ThJu4JQn3W0D5hJ9Lj8/5MpkNidbzOyPp/hFbuF6y25N6PyXiPTR/BIgULwEtznneWPjRVUvGOFb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfQ+iYgjwU0veT+4LBNAEkDtBqiNcweUP5phiQWZUlc=;
 b=XJu1rDqd250pay0eTq5rGYWN7wfLDs0O/wGCzhhOMijCoDEtGXD8zOqNHdaizxmx5IT4qlVZ+7J4JqnA2zGQAA1nsZY9MAtdTdQqWQLX+sjup1/ln2WtTy7zuMw5PFtxpaccDVmMcwRe0PLT2HjYy9jDN7fU3fEhKGdaufUhpo1rgqkA2x+94HpyQDGGEdAYJ+wlDyStex8ZXZbgFcqjW8a8876muC9iMkPnstPHxvyIoiHEVzNQ4nANDeJzSrWWP7OHFccPVgk0wpE59HQ/g+kNG4q+9n5BpTqx376oeV29Gf7z28HLFQCN23sqKhDx6/RVTwmSZoyN2QyaJboxoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9564.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 19:22:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 19:22:24 +0000
Message-ID: <c320510d-c0ec-4c4c-98b5-457c193cae6d@efficios.com>
Date: Tue, 17 Dec 2024 14:22:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20241217173237.836878448@goodmis.org>
 <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home>
 <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 18abc373-fd08-4d6d-b8f8-08dd1ed022e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWJIVHRMTTNCZ0RsK09CcksvMjFoa1Uya2dMdSswVWdyU2FNTUFFdVlMSXJ0?=
 =?utf-8?B?QS9Tb0NZNG4vVXo2YytUZlRMZ2JoUlcrZ3BUK0I2S0NZSS9yOHVZK1RJM2I1?=
 =?utf-8?B?dVZ4WElQckNGNEVCMGhDS0xQZXNCTkN6Q1FZM0hsaEFwVHQxTTJHZ3J6N015?=
 =?utf-8?B?NWEyc1paMTY2cWVWYWh2WWJ3M1hKWGpSODJNdnNJcDdRNXZFQi9XdVJpNGZH?=
 =?utf-8?B?K1JkbWtYMmdkN0xPZVN5cXdJR3d3NE1tZTdpelpXSnp3VVE0RGV5UitBeWhN?=
 =?utf-8?B?cUxldk1jakVUTnpMTVBzSDBQSDZRWGQwaHQ0QU9qWEE3R3JuWEdTRFJNZ3hI?=
 =?utf-8?B?bVdWY2g5UXRMeFdiZDZjNnRzd0M1bU1QeDFuSGgxenhCWnFPRnJvbGRleXV6?=
 =?utf-8?B?MTZoWG9EWlRxYm5tVHRRanhxMit3L1RybGNka3pxWks1QldoRGVucVpOS0JL?=
 =?utf-8?B?Sm1QblczNnNzR3hwZWdPendyNDJZZ0NBd0NOajhXU056c0RQa2ErcDNVeDdJ?=
 =?utf-8?B?VEdkQzlnMFRHcDZuNjYxaGVJdzFNRU5jTDMvemxTY1h4bFh3N2ovUSt6aXFP?=
 =?utf-8?B?aU5sTTdNd2laOHlQVVZERE04Q1hLNHJwcHJlNEM4K3UwcUFieitZYUNkbkhK?=
 =?utf-8?B?cmhFSnlESVVIK1E3VzJJQ2RpZlRURklqazl1NkczdkhnRDl2RUVzWXJzR1pO?=
 =?utf-8?B?ZjVpSWlSbHdwcG1Zb2pQZTd2MGhmUm1ybVVSTEwyWS9Yb3lPWGpQNVdyOHQ5?=
 =?utf-8?B?Q3hwa0tWNGJmeE9xWXR6Q0RsbzRldEpta0YyQlpxV0hlUVVHbC9kRi9hbDdm?=
 =?utf-8?B?NWxwVU1BWXNVZ1J0aUpITnZRdDlWQjVaRllHWDJLWnBHQSs3WEJJaDJvM2hS?=
 =?utf-8?B?VDR5T2FabUFIRzBQeFduTURwdnR6UURJblgxazNQREpaR2MyWVl0YXdIR3ll?=
 =?utf-8?B?d08rc0pSQjBNVFZRc2JrSkhwSUV1VUdHUFlqY3FpVG5LSEpEejdxTWxLd2U4?=
 =?utf-8?B?VVlyVlhLanNDN1dKckRnN1J5NitQeVZaOXJERzEwek94UGxQQW1nZTlRMGZh?=
 =?utf-8?B?dGRBcFFhRy9kSVJoWmJQTkVrYVlqeEt3TEc0eUNyZTRDS0tIa3lyZ3VFaTYz?=
 =?utf-8?B?eG15Zml4K0VLbDdsRVNVSU1YcG5qdFMwQkVBUkNpVFBBV0p4US9LbmN0M2Fv?=
 =?utf-8?B?VzRoRkxaOXlOTy9qVkdYdkZDRkZkejQ5SEthSEdJaERZYWZuY0JMVlJhK1Qx?=
 =?utf-8?B?b0FSNmEzYjZvamkyMTRyeC9RczQ1OGh5cXBqSlNkV2NTREdJWCsxNDdaN0NX?=
 =?utf-8?B?TVZjc2JNeXR0NUZMQkhySjloV1pIcExyaFMxN2QycXpXNGpOV01QNzdNREJG?=
 =?utf-8?B?YlRuNm9nbnVQVkg2Tmh1SmhITzYyc2Rhc0NQU0NHa3ZFVUZYb0NDbHJBcDRq?=
 =?utf-8?B?MEU0S1FCVWl2aGpzMFFGTEdVNW8xc0pOeWQxZGl3RGZjMHpOZEdLYUQ3VVJT?=
 =?utf-8?B?c1A5MmwrRVVISzl2ZU1tVlNBSXJpLzg4R1k3SnVjaEZhZk16OXN5Wnd1YWQ4?=
 =?utf-8?B?SVF3ZVJLcTk3NlhWRTB3b2RTUkpYMlpsdklzY3REWGlkN3BqaWdHQWFhTGxY?=
 =?utf-8?B?a1NQL3VuOEpaUmxzbDMvcEw1RFYvbHdFWkQ1dnh0UXhXaTJsN2VSNjYvTHp6?=
 =?utf-8?B?T2NxTys3bU1ZRWdHM2lONW5Vd2owcHZUbGhVQ2JVVlFzNzN1SnhwVzZqWjV4?=
 =?utf-8?B?emtkbllUVFhhd2lJcmZvd2ViQktQK2VFblVJbG10d2t1U25XQ3BIV1dqdkNF?=
 =?utf-8?B?d3RaS1d4Qjg2cmJJK3FtQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hJNTh6cWdxVDdlZUdlY1p4NkxydnJvVG5USVN2c3FTb01rMXp3Z2VPQzZq?=
 =?utf-8?B?L3htWHd4emltMTVEUnU4TDcwS1ZxbU1ONm04YmpaK2pPdFUvOFBkdVhpRy80?=
 =?utf-8?B?bFFFUjVTKy9VeTRJOUVDb1k2SXVuc3cxaWFDb2R3dStBQmVZd1pzdGdTaERM?=
 =?utf-8?B?VEtmYzJCUFFhYkc5emZkR0tPaU53RGdEdE55Y1VvREdwTzd5K1lOcmxNMTBT?=
 =?utf-8?B?bDhqYVc2V2tvcFRQTjIxUHAwSlpabEkvdTN1dFlaQUtIc1hHMENHaHgvVnNY?=
 =?utf-8?B?Nm9HdWJ6a1JNbldJa0ozZ0JNVFd4d0ZMc3RsTkJYT2FmUG1JaGRzV1NwREpV?=
 =?utf-8?B?dFRtMHFLb3BFeFpUZTI2ZDRlY204eFFTY3FsN0srclBxSFlKN0VCMVpNY1dC?=
 =?utf-8?B?N2l4Tm5TbllFUDB2dE14bnZNMXVzeGVPekg2V1N0QXlDc3UvNXlhNlFiV2dR?=
 =?utf-8?B?aTJ1d1lCZWNEWTZCRnhHbGxYc1o2V2lGQW81TG9ZckViTVM3a25GYkpFdjJU?=
 =?utf-8?B?S05LSnFudEtpRWZjSDJZQjVEUWxHWkptY0w5ZDhrM2lqYlZwblFOMXMzc0lj?=
 =?utf-8?B?eXVDVXFjSkdDVWdDbXBtRHhyTzVhNUJ4YndSN0RZaVBaUG5hQnBsUWJEcFR4?=
 =?utf-8?B?VnVjUCtIaUdOUFVPaFVUd2FJdDFKVDB4M29qMyswQTY5MzlvaWpkM1B4dU9G?=
 =?utf-8?B?ZzhyRmFZMEFjek8ybld4eENmbGhkelZKRkpCTDNxaElnNTlzOFBURXYya1Y2?=
 =?utf-8?B?eG5qWUoyTTZvaFNIeFp6OGhVVFlOUDQ5Mmt3cThNY3VKdkJPeEk2Zll0S04y?=
 =?utf-8?B?WXZtcklkQ05rMXJyVDZsMHQzbEtyMDltWWFaUEFWckxFK2RQK0tSTitGM1Rm?=
 =?utf-8?B?VWZ5aWtsTm1CTUNDMy9tRXZ2citqU3dvUVpydFlXaTRwNE9vcVFaZldJaG5s?=
 =?utf-8?B?Vmp2R0JMSDJNRXNwU2tqaFBId1gvcXFjZWFIaVJRRVorTGIwODdaT2cvQjk0?=
 =?utf-8?B?VkRpN2xXOHNBNWlyemdsb3daTjNuZUpSV0ppRWxRTTVrZ0hXb2djalpXZlhj?=
 =?utf-8?B?Wk9BZm1lbk42enRzaDJwVzZMb2RnTWV6MlQxSkwxMmt0YWwzN2JvczBNSTBR?=
 =?utf-8?B?OVVPL2M4R3dTbXpSZmJsNXJ6NlRYWDhQcUVIWkJFYTMvOCtpVHg5Y21ZTUhG?=
 =?utf-8?B?TTdyUEU4SWt3cmVXbGFzQ2FidVBBU1AvQ1QzNmlPYVFvRkhFQWgwZlRGYUtJ?=
 =?utf-8?B?S2Q2WjZKY1R5aHBHM2F5eVZLRUM1VnkrQWNlVTQ3TGxmOFNtWTVsUVpwMCtr?=
 =?utf-8?B?aitFZE0yZndOSE8rY3RseDdHRm5Ed0o1bW1OVi9sUk5nS3ZhcUc2citlbGlH?=
 =?utf-8?B?bk5rNEZHWVQyb0drODVOd05WVlRuZk5TUitqK2dzc2JuTnEwcEI5OUswejRt?=
 =?utf-8?B?Y3g2SzV0S0pFYzVBQVJSL1k1aWNCcGZRc2hWZjhKWitjOFhjWGhnL3Zyd2xx?=
 =?utf-8?B?Q2VjQk9Jc2R6OWVUSFRVQzlRSjBVTFFJakFTdi9WR2xYTnJqQnBhNUlSYlNY?=
 =?utf-8?B?dkJEcjVMUk9uTXdndDhuVy9qOW5GdGt6UDVVbEJQUCtxdmt0Y2RFWWJzaVBQ?=
 =?utf-8?B?QU9Ea2k1Vk9oSVllNCtKL3ZwK00wbmxSc1pNNFV4MzJ4dW1takh4a1kwSXow?=
 =?utf-8?B?RnkwQlJFOFF4aDdjOWNTMFZSdVlxRDQreGlLdnQ1TXNrSHVZc3ltMlNaUldl?=
 =?utf-8?B?TS9mTDFYaGJPTVdyNkhxamRWVW90bUJhZm8wWW9RMWNaZFFzamZVaC9mSk10?=
 =?utf-8?B?cjkyZnUyVlB2NUY4OHFIQUlhTy8xT3I5UzhJd25MUERIaEtuc3hlbVNJWXF6?=
 =?utf-8?B?MDRCRnpmNERyWTdPeFdrbmppSTl1REI2VjVGMnNoa3FIZDBqNTlMb28zMVFy?=
 =?utf-8?B?M2NjQ3JXeXFyNDJKN093TmxuQ2JnbDhoTmMvM1RzbVpXOENBeHVScEJCVzBk?=
 =?utf-8?B?T0JIekFLSGJWQVlRNVRtOEo4SWNydVJMYmszZktieWY3THhRbXROdnVLNWtV?=
 =?utf-8?B?SGttZjFpVEtxRC8rYnp6NURoSHhZZG5mMFhQOGxoM0lOQUtCU3VRU1JSc1RU?=
 =?utf-8?B?RmxhQmkxYmNHdFJJTk8xRFc4SHFoTkZ1eVZsL0tLMTg4SXppV1VqYjNLMUUv?=
 =?utf-8?Q?zBg+3Jtqfgv8gSu4O13j0hs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18abc373-fd08-4d6d-b8f8-08dd1ed022e9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:22:24.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slUvTdI3gL3uBFOW6jwmaWqpqF5r+BCbZQ8goUrILKU2wnzoy9YTlzmok/5u6CdoTQo2sdi+oUlK0W/QcM5yToWVfpGCYU8lzyAub5+GLNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9564

On 2024-12-17 13:24, Linus Torvalds wrote:
> On Tue, 17 Dec 2024 at 10:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> What *woiuld* have been an acceptable model is to actually modify the
>> boot-time buffers in place, using actual real heuristics that look at
>> whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
>> of the previous boot.
>>
>> But you never did that. All this delta code has always been complete
>> and utter garbage, and complete hacks.
> 
> Actually, I think the proper model isn't even that "modify boot time
> buffers in place" thing.
> 
> The proper model was probably always to just do the "give the raw
> data, and analyze the previous boot data in user mode".

It appears that you just summarized the LTTng (out-of-tree) kernel
tracer [1] model in one short sentence.

If this can help in some way, within the LTTng model, here is how
we're solving the problem of mapping addresses to symbols:

1- We have a statedump infrastructure, which dumps internal kernel
    state. It could dump the kernel and each module base addresses
    into the trace. (we do it for userspace tracing)

2- We can hook on module load/unload to insert event about insertion
    and removal of those base addresses into the trace buffers.
    (we do it for userspace tracing)

3- We augment the traces at post-processing with DWARF and ELF parsers
    in Babeltrace [2] to augment the trace with symbolic information
    using the ELF or DWARF files as inputs in addition to the traces.
    (this already exists, and is used for userspace traces)

4- We already have the integration of the LTTng Userspace tracer
    with PMEM and DAX to recover traces after a machine crash.
    Those buffers are self-described with an ABI which allows a
    userspace tool (lttng-crash) to extract well-formed Common
    Trace Format [3] traces from the buffers after reboot. We've
    never had the incentive to port this facility to the kernel
    tracer so far though.

Thanks,

Mathieu

[1] https://lttng.org
[2] https://babeltrace.org
[3] https://diamon.org/ctf

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


