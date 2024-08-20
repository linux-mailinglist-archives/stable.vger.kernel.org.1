Return-Path: <stable+bounces-69701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6E9582E9
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0A91F21C50
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC718C004;
	Tue, 20 Aug 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EhMdRM3A"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3518E024;
	Tue, 20 Aug 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146752; cv=fail; b=XJly7m5fbvslA2+i/rS16pjdMjJ47c0wOte281OVEkN10x+Jnb1oJXJw/CP8jGfBKwNty0GsxHIUDzCdf2SEqwTxNU/UkZkiCAVuqRxbRcV+zvyVQgb7zmG0BRGJPRp+PPhj58G+5uA42J32NESQlZZfG0zy12melZbUQYe4Hmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146752; c=relaxed/simple;
	bh=RPHfCk/W/iHRLPmeiyGPu5HX4qfsg0tcsXtLgaFPqC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JdxLXbDv8Kv8Xzmxv9Ws7nwHdxXbg/t2YBDe7Qpcg+30YGEpqROWd7q+0O3mPtu63KVXb1d6yONWhj0UJUS6rayCGK8+tIUADZAmgj7RV1Txreqi6CC1jma7K7JRqwwNaM6t2gfO1x9YcysWVgE7wOtPb/uLDmzAysUluT1WvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EhMdRM3A; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/8tDhJDRS90WYnnWcsfH9R+u5pjnDDcuFWKNDNRk9mg88NKl5fABi2e+HAefEjQSiy8uq7eFXOPEdFbZIB8fI+Ckf/402FO6DqfuL7e9GocrPonYfbRwJd9Hfbzpbg12qG9sMdydKjlu+vtGMYCwU6MiK9NrpbrzTJ0cTEqDVoTLIFtiKHdxmXhSiB3g/rNYnvFOfDMbVItz0JmP3IrDPozVX2kqJS37d754eF6rn4Rbw0Iu1rInD0NW/WHFSIR6XAOZ2Iv6Jv99kdkMWxz0CTBXzzaIlL/lmqH1nypGbOHsLQ4AwtTuw9m3e5WnGGOAT9NX891sN6xgYgDb5jrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCMBPO991GC8SyeU2Z8ygIYdWHI+OxA9hDp0QrR6y2A=;
 b=eEL6ID66nBM9vQFqTa4il4LOfiR5BD8zJu1nMDM2zlfXCueqEXFHtQvR4swQ14WS1W39urTDet8r/ZRJ4cCYOdrEwuNEYQ6bWtQCcmpM9clHRpdrojtTzU8tg51OTDGfdbSy28pUwXhKH+OgdI+WbpeC/KVqYfPKY48galEjCtSUvqnz/ken8n36pvRjPXNvml+r1jrHdQT2xvbVyXoRCk+n9Ur29kBDxvj4D+xbXazEMf+YnOHnUqHKtf2kSH3m/wv3EXsI5GKgkJrJ9Fbq77S719XVquNiaJ27mLl99NihkMpUiKcMuUy4jHrSId5/sX7KuhsD/wzGwWz5kpklAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCMBPO991GC8SyeU2Z8ygIYdWHI+OxA9hDp0QrR6y2A=;
 b=EhMdRM3ACmjOXlMcJhfqwzRFRhOmFSsUYkUaf38HYP2G7VF84GhJvB0JH8nsKrJ7C3WBlGOjQPw9EGoO7lSF8R0lWSkpGXPDCTklnJL4kgrGe2H2lmbyfsZsAEFhuXNNb5Ue+A/I9AoS00L79IV2E028WlNTOi6gc/gQDuxqqBT4SlGU/dzHrReX2uXDGlora9amcytv7arhUOR3jVs5v0Qnw4mLpnFcH20O/H4v3N6hUe/Vwch96NW4rUAm0eOfk7zzLm57tQ8Ow1/xsMGxTdjatasOX+YMej/QZcZgZUXw6RL+rSt24ItyurCTcQ9Fuv5zASfcFF+N310oTNmr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 20 Aug
 2024 09:39:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 09:39:08 +0000
Message-ID: <9ce9044c-085f-4eff-b142-ab36d39d90b4@siemens.com>
Date: Tue, 20 Aug 2024 11:39:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix driver shutdown
To: Beleswar Prasad Padhi <b-padhi@ti.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
 <3e6075a6-20a9-42ee-8f10-377ba9b0291b@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3e6075a6-20a9-42ee-8f10-377ba9b0291b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed6b33d-c797-448e-14b3-08dcc0fbf044
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnRKVHFmTVc3RTh1bVcvOXhqa0ZQekl1NjlNeGVtTEJwN3RCblZobmFRK3J5?=
 =?utf-8?B?S2tjTUJtQndWbGwvblZ5dlhsY0JGWEV1SGNHSTVVMExDZVkyTEkwak5XdVN1?=
 =?utf-8?B?eERYTHhzRzJadlVKOVdZRzV2b3BFaGs1d1NiZHdkUlhuTEd5Q3JQOVVvQkI5?=
 =?utf-8?B?T1FlQ3lVOFFQYlFvcUY3L3FsdHdXK1p3RTRlOFBVbjZObXRZTDhyWlVEMU9Q?=
 =?utf-8?B?bW8xenhuY0ExcksyRmxXZUI1eUwzU1FIdGVSQ1Q3OEdhSE9VMDBqNWU3N0JB?=
 =?utf-8?B?b0tFV1kxMENnOW5JUzVuRnpjYU9TOTFXRlhuMlFaUUo0VExyRnU5K2Z5eTBC?=
 =?utf-8?B?YkNHdU9INGY5cmRCaERaRHJYRTByZm1HWjh6eG9UNWZ4UzAzQWdYVGdmOTFQ?=
 =?utf-8?B?S3pjbS95VGRGNE5zUDc4anFYemh6OE9JUlI3RG5LajlWZE5hczFZcVRSUmU5?=
 =?utf-8?B?enhrWGZOL2R3QXRoQ3dHbzh4SDBXMVBtREFBOG1SV21DL1o0N0VwaGVHSmRo?=
 =?utf-8?B?M2J0cmFnbkRFZFJPeG9vTFd3T0ZvT3pUY1h5Z3NORTVkRDFlZTJXdE43SXQy?=
 =?utf-8?B?dHl3SzVGdWx6NitIV09zYjZFNGxad2todTBRTTBqZDB5VVh5dmxFNjNWUkZx?=
 =?utf-8?B?WEVmUHZvN1pLNW5Vcjd2QjNUUGhhQkkwSjJPU3ArR214eEJhZm95OFFVc1NB?=
 =?utf-8?B?N1R5QktVbjlXRmtLOXdNWDlBRjFVRGd1MkxwSExTM3FjVGpXRU9GSjFGRWVY?=
 =?utf-8?B?T3p0dGlnbm1hSytYN1V0Ly96N0FuRlQ3SHNYbjRKSUg2WjQ2RzVEbjF1YlFo?=
 =?utf-8?B?V0dWbHcxR0dTdTJMWHZtS3ZWMXZaNGhsbld2bzZHRmFpdzY4TmtLdnRoNlk5?=
 =?utf-8?B?MGxQNXcwZEp0aTZuUlhsWGdhSnlWUWNHUi9CMTE5cTNETnIrRlovVXBPN3Br?=
 =?utf-8?B?SzZ6eUU1bkluM3Vxc2RoRVlSM2s0c1NWOFZYVFcyT0NiczkxZG14RVhDR1Zv?=
 =?utf-8?B?YUMrZ2RmTllGNE16YnV2cTZoYlo5TDZoM2VIZXlLMjEwMFZmMjJVK1U4L1pH?=
 =?utf-8?B?alVudWNNM1FxTDM0bzdiczJRWnF4dXhhSVRlQW00NUtIZDMyQThsZGpTbWFD?=
 =?utf-8?B?aHk4RWZmV0MrZFo0ZFdVc2xnWnBNck5sRkZwYlBpUFl6V2lPSCtmS3lrV2tK?=
 =?utf-8?B?bHNDbGhDYzUza3Vuam13SUlHaXo4Yks3MTgwR3hML0thNXVhVVEwV3l1UCtw?=
 =?utf-8?B?Y202Z3NTMS8wYWFRU3NJUFBYeC9LVlA0b0xLTDh1a01KT2dLakpoNCtBak82?=
 =?utf-8?B?SWNna2hzN25WSEYzS0pRZHpTdnViK0tmZEpwNXY5cXlQeTAwV1J3bHRTYXhG?=
 =?utf-8?B?SlpZQkx5dGpraUEyS3pIb08ybnpGN1BBTm15ZmFIVUlReWRROVcxSHczV2Ft?=
 =?utf-8?B?b2JnMSt1TGhOTzJydm1EZHVrNXpRRjBnOGhvU2N1K2UrS2hIRGM1bG8zY01Q?=
 =?utf-8?B?R1N6T013ZUtVamVQN0d0RzNCUTJDdXhzS0s4c1ptK3VQQ0NOcUxwVUxzR2Vi?=
 =?utf-8?B?NEVSaSs0cWxwTy9nWFFWVllDbnlTaTNFS3VvVTB4V1ZUOWxndHM3cXJwV0t2?=
 =?utf-8?B?dytLRldlM2pwL3cwMFdVVDlVVlZTTmVEcnRyYW1YOGpQdC8wUzVEZk9sU3E0?=
 =?utf-8?B?K0tyRSt3RC8rVUpCKzg3dzlmcmU3ZWozSnZjTGZEOW8vQUlQdFkvSHRyeHVK?=
 =?utf-8?B?UWFSMmdZQ3hKSlBuUjliTVRiR0p4eDZ0MDZ0TnFrSU5pMG1JdmJGZXFsc1Zj?=
 =?utf-8?Q?R6asCLr3FP5b74l1/2m6/+Y/ENGOEMdR9aMs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWIwaFNQVyt2bEcrMk9QTmcwQ1JZYW5lSE1LSENybHJrKzd6N2lHQ2tINEc3?=
 =?utf-8?B?WWVlZ3M4SENFSmY4M01LdUlPWkc1WnhCZ1ZvZm10MWtUcDZicjkvbXBpaVpD?=
 =?utf-8?B?Z24xY1Y1MXJkc1ZneGlBSkFEV05tcTdzdjU5d0t4bXVUY1huNmFZLzBxUzdY?=
 =?utf-8?B?V0Z3dnBNREs1SHlpK2JuWERzVnltUXlGcEpyU01GYjdBNkxjTW96VHNya2FR?=
 =?utf-8?B?ek4yNjZRbEY1dkhpeDlxMDVVaDNPUWVRekxHdnFDN1NqSk53bHFmdm1iVkZG?=
 =?utf-8?B?YnJ3WjJBZHo0WDRteFE3WkxBMjZDb0lzV040aEZHcUxRdDgrYTJWV3hkbUJW?=
 =?utf-8?B?NWxWYXBPdjlubzRGVUNoTkFJWlhSZ2tFUGlUaEJMdFMxUUhkMXd0VVlmWi9o?=
 =?utf-8?B?d2d6cmFPYW4wdlVqUklZZ09tZ2RTZk9US2Q2dUY3OHJIWXFRRGNzcU1iMVQz?=
 =?utf-8?B?ckdPbWhPdVVHNWVDd3g4djNnYXVLcmhhN3ROOGFxaWpaZk1EaEdtZGtaVlFx?=
 =?utf-8?B?aVBTOVVKSzB6cWNWKzV3QWI4OXZtZUw2K2FaQ3ppZW9tQUkvblFZcFlGQ3pZ?=
 =?utf-8?B?bkV2SFBpQk53N0IxSU1rcGZzR2ZxeUxkaFp5eXNMVnpROEZ2aVJFSjNXZ2NU?=
 =?utf-8?B?YnR4Y3ZiTENndUNQUE1hRXB2cDJ1K2tlT0NnTTB6TDdoSnoyK3BtVHlVSnM0?=
 =?utf-8?B?a3hJWEdqaDYweEphMWJ1NFZDc0dwbEV4eExRSHRIbCtkU0R6VzhuL3JxRjFm?=
 =?utf-8?B?eHdRSFdUNkhwNVZjcU04RTZ1UlA4ZDZ1MVlYQUVlQjloWWFUZmRGK2RkNkFQ?=
 =?utf-8?B?a3k3S0x0TjZCd0h3cHVWaW5yMjdZZ3R1U29mS0swSjJHaEJvLzJ4WWtEakNQ?=
 =?utf-8?B?Z2kxOXhmOCs5V21aOU5ReDJJaytabFZ1eEZzT0hDMTRJOFN1U0p6T3ZqZ3ZG?=
 =?utf-8?B?c3BWTVdnRzV0U0VObHBWdjRRSUZOVW1Sb2hkSFlyZENjRWlRaXNzZ0dSRnc1?=
 =?utf-8?B?YzlkdVN0Mm1QUWNWb3BhanV0a2RiV01MUG9FWGswNXhsSDU3Q3RNQmhJMkFH?=
 =?utf-8?B?R09Iak9tMW93RFVZc1lwUDk2dERUZDE4WVIxaUNsRUo0UlVNR215TGZ3REU1?=
 =?utf-8?B?bllmaW9TaFJLVjY1cVBhSy9zYVFkQnd1dkdTTXdhM1ZLc01JdVFnV0J5dk9t?=
 =?utf-8?B?bWJWT0NiRjg0bXFFd3FWVm5ySUw4TWZaN2JRQW1HR0dVZEdVcUF1cGtQVHE5?=
 =?utf-8?B?dWFmbWswaGw5QWtNUXdmdFNwMjNhTkZuQThtc2pYeFEyTGhTaXlmLy9ZTy91?=
 =?utf-8?B?UDAzOEMxNUl5Z05mMWdZNFlxTWxNa2wxem9iMWFnd3BGSkRoOGlUVmx1c1Za?=
 =?utf-8?B?WEtpd1ZjMEVnT0x3c0RLRlhwdS9SY0swSHo3dmxiQW9NZHF6NE1YNDkwWFdy?=
 =?utf-8?B?ZWQzM3U2SkR4Z3hmN09mUlVXUXc5bU1kTWFNc2F4dGJWaUh2Ynh4amQxem83?=
 =?utf-8?B?ZUhsbTExTWNCZDBqb1JHajMwUTB3Q3NnNE9DZVppRHE2UjNkeEN5cy9maExj?=
 =?utf-8?B?QWxHRnBXekEzSVN1M1BRVGUrdE9Eak56eUxKSnVRSXpRdGFIVzBvNGovNzR4?=
 =?utf-8?B?bHk0WTI2M0JaRG9TM3hSUWlVYUx6QVh3OFU1TWRTV1hjY3JQLzFwampFMVdz?=
 =?utf-8?B?UG13c1JLYXdJbGFBSEQwc2QyTUhVYTFNTE9iZHd1RWhJZnpLT3FmMXlGZHZZ?=
 =?utf-8?B?NDJkOE5SdHZoSnVjS2JxRVVVK0VCejloNEt3S0NKUVY4aFlnVUpNeFcwMnZC?=
 =?utf-8?B?dkNMbnk3QnNFc1F1K0ZvK0tpMFBmNjVvV2RXR2ZyM0hFUlFrUURwQUt3amQ1?=
 =?utf-8?B?N3pHUVNiSXY1aFdhMmM1YU1JQ0d6eUY3b1pMZzJZSjg1WHo4R3RUbDlkMmti?=
 =?utf-8?B?c1c0alpndWJSSzVvN2N5bG40RmNhRmdRQVhvcEJOMDlSY2drOUxLZU5tS29r?=
 =?utf-8?B?YjBhdFNMeUNzbVpsMkFsUUNGS0RHTE5JbTZqaHAvdnBXR3dTbHh3eWJGOHpO?=
 =?utf-8?B?TG5ucUxPM1pUdkc4MmZMdjdLUEpvOGpLTm1aSEg3eGg2QmNsMXFyMitIY0lp?=
 =?utf-8?B?RmhOcDRvQWw5alpqai9MM3N3bUdNTHBOejB5V1ZRY1VTQ2pzQUovdDdiWVJQ?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed6b33d-c797-448e-14b3-08dcc0fbf044
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 09:39:08.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrCW62gt9jSvAqwBh16lpbgKJ2t+hvBbsPf2SG2BTKI34Q1ZBaT6ZAItqGrFG+eiQvmKzyqAsaMqTuxgvFTBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5353

On 20.08.24 11:30, Beleswar Prasad Padhi wrote:
> Hi Jan,
> 
> On 19-08-2024 22:17, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
>> first. When core 0 should then be stopped before its removal, it will
>> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.
> 
> 
> Did you check this on top of -next-20240820 tag? There was a series[0]
> which was merged recently which fixed this condition. I don't see this
> issue when trying on top of -next-20240820 tag.
> [0]: https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/
> 

I didn't try those yet, I was on 6.11-rcX. But from reading them
quickly, I'm not seeing the two issues I found directly addressed there.

>>
>> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power
>> up before core0 via sysfs")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> There might be one more because I can still make this driver crash
>> after an operator error. Were error scenarios tested at all?
> 
> 
> Can you point out what is this issue more specifically, and I can take
> this up then.

Try starting core1 before core0, and then again - system will hang or
crash while trying to wipe ATCM. I do not understand this problem yet -
same VA is used, and I cannot see where/how the region should have been
unmapped in between.

Jan

> 
>>
>>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> index eb09d2e9b32a..9ebd7a34e638 100644
>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> @@ -646,7 +646,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>>           /* do not allow core 0 to stop before core 1 */
>>           core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
>>                       elem);
>> -        if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
>> +        if (core != core1 && core1->rproc &&
>> +            core1->rproc->state != RPROC_OFFLINE) {
>>               dev_err(dev, "%s: can not stop core 0 before core 1\n",
>>                   __func__);
>>               ret = -EPERM;

-- 
Siemens AG, Technology
Linux Expert Center


