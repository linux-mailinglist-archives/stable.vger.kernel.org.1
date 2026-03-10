Return-Path: <stable+bounces-223841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMo8HFbmr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:37:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050624896A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5AE830DB321
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F43DA31;
	Tue, 10 Mar 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="QV05TeXu"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01924293C42;
	Tue, 10 Mar 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135051; cv=fail; b=Ngpiinq6zmLeclvG/82m8P2tMW8vcqGDM2dt5MslLf5Iag0KvYVzEUvW24Pmk2eafwwDeXu7zGp1RzmJ5BNqXv7lLJh84ZHVbyA25RWXly/oeMSNQPkimm+g09wRje/KHqjlpJOMG6Rj4QkQ8f+cX/SK+yieBoeumRurJL8j+SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135051; c=relaxed/simple;
	bh=jS9TA4il7Uo7c2NkjYoHKKOBRU2bwfaI/e7LkPrR4go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qz+Za3SZapz7Tnzcq0HKyNY5QztmEStAQzXrJN+jm7ojoDn4/XXNddUMZDpNN081OlP5RC44hocfyQUZsGrCXYmbIU7jN94CTSdsVMJx3Ja2ewsYRkuVyc6JMvXjR1PCuTz/n3lh0ftcCHPACRh0w8JP5Ig4DBV2LPdgVmkeGQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=QV05TeXu; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV3cLIXVNnEt+/KVHQYKMgjhGAoAKtHgjjkS2GNGHcrx8XqsuzXbNaEW3G7WuVJuhSL28WnUdZGObEiXkY0Rm6kviwuvOL7t/QmJhXZZiL0oez3fbACFajvuGEmWA1e/IB/PeuKtft6twXJcr8q2T6pKAp+2VPnK7809bjsEei0+HoUUqYI27+GLm2khJvCUPtgsBEeUGkPUwsIRC0yYogwD7nBeHt/9QPYMIfqdrYSemau1i3KfvM2MTIv2R30Q4kT1ZpO2MOC/uymlVlYdFXsVPiUai+Pdf5TM2KpniWk9cMPrcxL5zqNsLAuQlpOoE0UfTD3mS1wsxpmIhaj9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ezt7r5MPZcpZqnlMod22aGxAG5DNKkRttNoQ3zj5LA=;
 b=V1IFkM0IXS9e8iT24EcCMe6rrmtO3ouDtwOdwglU8B9/ZOX7nQqa/zH8q6l7ne/PWvFRGYj81SHmVXgE+UvzUvyZAKL02Szl+nOvEaVGtJFx2whzdR6b5fDxC/ZviYFHdv+2QCthTyr9iRyXxSHPUaao/5PAFHBp05J1yPK5LvdD5Sx2uY4tiAIs6DxwITAv3L5jtidRYIasQo25NhE88uAVcBnx9gRfxUhLwonQfp1GVzEE6ZSl5wdEH0rktN/AGSOjpXzSleZk9w460j91wfNLtSARrNpRNB1pZd96n89q032JSWBaZ5XXYThEgIpsxjyK8JEgjhU7lYye2NzIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ezt7r5MPZcpZqnlMod22aGxAG5DNKkRttNoQ3zj5LA=;
 b=QV05TeXu1hkH2oCqbM/tTmb+Dotfx78sSGBdpA+7ThtfjBpEzyusiD7kOz34fz0oUw3I+4Qr758U6BRk4Pi7Nn5lvK3zkPwW2O6pXL4QmyRS+CRUxF8UtrTdbxmNAV9wPf6QSLRmyk4HUEuUSHoEFLOnfe0KvCShgCDa/ecF8Tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB5PR04MB12177.eurprd04.prod.outlook.com (2603:10a6:10:648::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:30:44 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 09:30:42 +0000
Message-ID: <b3e4a7a0-120d-4d73-a4fc-a7fa0c64462e@cherry.de>
Date: Tue, 10 Mar 2026 10:30:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, zhangqing@rock-chips.com,
 sebastian.reichel@collabora.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andyshrk@163.com, macromorgan@hotmail.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>, stable@vger.kernel.org
References: <20260304121426.1184680-1-heiko@sntech.de>
 <20260304121426.1184680-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260304121426.1184680-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB5PR04MB12177:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fb2d7f-1f2e-4072-d215-08de7e87b2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	WmBK/+3v6dtW3NbhfzGIYPd67qlxPCBGpcyzncltZDsk1CbxdYR9EC/OB5GDwD2oqFPFYrHUIqWPcdM40ivgMehVRQZReZQgJ9JxbzkeueE2stsYeFTkFAPLv0flpGbITCYXddZexiPYR5RBMqOmG/mLVn0zFTZu3/iuoSjKCp/VElV2+bcAq2rog9AKr8j22pPByfGsCM1phlAmhLIsBwalch29AhndQER2B9A4O6+SZSDBRIbvkQVoPgYtsfHqKWgpbxiGrK/IXOYsh9KM1I3RsWLAx20b6yAFGCGO1aUMg9ta4xcXquBI0IXQ4P0gyZFw6HKgc0wLA6qjmyHHprVfouHcu3mkG+lSwa6MKsXHCnv/GeOEroGmxoBDfb9gvIynZ+MZu5AiCK2Gasd3gdtgqmvuro99K96SNyWw3FKQBeyy0E9THCmoV+Lu+WpI4JFeuCEUeq/wPTtIIcPcnv8TEmnR4FU5+Mm2IQ7KCTjKVwgOqSPflqm8phJcrIQ/WR6h1ZbmFHSbouu0bzUbMamorCzeCstmOGAK8aP/N7Byoy+Oa7oUCzqnqgRqKL1HFP3znyTEQftrH6++BWnNeMw215aX41wd1F5naHlLr+TpoSA4SEgk0k0xtkg/NhMzXRL2gmZbVBEgneTvqj2nXm+FWTUKJRhb22MWWzJEpXA4apDhwU7eFXChO+cuPhL3V5LOnP2KTW8YntkagOqGdtwrlsgl+1XxcHeV0LcSN80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNhclpqNjM3MXIwVzJkVFc2YzV2TjRtd1daR2w0eVM1RUVvU25Eb3c1bmpn?=
 =?utf-8?B?NkJvOERGK0V6S2dkb2lzMEg5SFBOQzd0YzRkS1RNL2h5OFc5VnlBaFJId3Ju?=
 =?utf-8?B?b1FSTDR2OVJMWXVLbmVDcUE1Qi9CdTFyZTFYeVkreGdrbjNseEx3ZlB5M3VG?=
 =?utf-8?B?alNvZ0t5THJWNGE0VCtad3F5VFNqaDNjRHJJVGtTdFZaUFZKYzdDU3FvNkFw?=
 =?utf-8?B?UFlMditxanErVXMwTG1XSXo2QW5JSmRUWlAzcTV4aUtkM2pyQnkwaVl6aGxR?=
 =?utf-8?B?V2RqRnJrdXJjRnNBU1lqR2d1ei9hWjlsL1Y0MlJhNE5XYktlTnZRdWRLWUhT?=
 =?utf-8?B?RUQ2a1VYaW9mWjVtRTZDNW51WVJ1RDNDVHc4V2twRVdYdXlkUzh5c29GRng2?=
 =?utf-8?B?VFhIdG9zZzlEeEVwSGMrR1ZaUTNqNU1mRk5pV2hJUWJVU0xyTE0yVzFpL1U0?=
 =?utf-8?B?M1lSUkdwMWFSY3M4NG12U1RqNWYvcHAxOG9UWmE0cW10VGdTcGYyUEIyV0tU?=
 =?utf-8?B?YnFYT2hPMXZIR0tzOGprREdhKzQ2cHp0VWRsN3pZd3MvUW5FcEdBMVpSOGNF?=
 =?utf-8?B?MW5hdys3RkE1NGZBczRuZFpmTmxwQ1BRV2JUK25TN0RnTEFSd0prQWFWWnVC?=
 =?utf-8?B?bUQrQkVZNTJCUk9xUTlyRlEvYWtnSTNXdE1TTS9ZRHoramRVMlRGQXhycTJD?=
 =?utf-8?B?dHFianA3QndidG9ZTjRYR2d1eE85cDdzMGY2OFkwU0hiK2hTUFh5MmxMRDZV?=
 =?utf-8?B?a3VKTDBXOUJISTJtQzNqanN4d005bzVCSXlkQ3JTYjhOUmR0cTZQMHJQK1dr?=
 =?utf-8?B?dGJJSGNsVnBQWUVRTFNQN1J6YXpldTk4LzZCMkt6Tk85TFI5RW54NTl4TkJL?=
 =?utf-8?B?ZGVHNlh0TlBSd3ZuWXpNK1hmcEtsUExJRHk4cnVtL3Q2dGZESGljRDI2MFN2?=
 =?utf-8?B?SGFrNUtWWWQyS29uK3gyU2ZvMlJqdHJtTzZFc1BHYW14ZnFuWjR3MmtGc1c2?=
 =?utf-8?B?TUVSSUJCSjdzWnJYSWQ3QU11YU0xeEY0RXVERzFqNDBWMWJ4dk1zbTdIQTZX?=
 =?utf-8?B?UHRITzV2ZHpEZUt5eDBkaDhqV2hSVHBzY05SL0dxVXhoU25MNDZaQ2JJZWd6?=
 =?utf-8?B?LzFxRitZMHltNEhrM2FnUW90VGJtWXpZMVVFdTZmMUhvS2ZRdnhxTWZFMWpp?=
 =?utf-8?B?M05VL1VraG15K1AzODFoaVQ2SXJxd0ZzUUZDcUZFaktaOEJQZmlKT2FFQ2lM?=
 =?utf-8?B?eFNqNzRjakVwQjhPeXB3TTdRMjV2SDFibTJEd0paTjNhRWE3aWZDb3FaNGE0?=
 =?utf-8?B?L2ZwbGFCbVFZWjdkRFN0UC8rQUt5bStmWDdpWUxucFlZempmaThOelRvbjJm?=
 =?utf-8?B?UnFTckxBK0RWNHJIYmp6RHNWMldkMVhVT05VU2hYWURTN3JmMVpqNTFQWGdq?=
 =?utf-8?B?WHVsMTMvWmhYNzgySXgvZmFlQnJjZkdYWjE0SW13eUhKajNWUzdkSHdSL3Ri?=
 =?utf-8?B?UDJicEFJbk51VUZRT2ZwQjNHYW1pSlY4dUtJTTEvYm5jWmhsN2NUWms4ZlVI?=
 =?utf-8?B?WDdDaVowa01UTlhSZGtLSDZRY1gxdk5GUHlnTFdCU2JFUTBsSXZueWNkZG10?=
 =?utf-8?B?bnp6Z3MwMGpPOXVhSm1ickNKQmtrV2xSSzVuTXJTZGV2VTlGTSt2UkdLeGxX?=
 =?utf-8?B?aWJNYU91bnljYTVlUndVMFErU3NOTHdQYVN5MzJTUlRXRk5ZSDV5ZHFuRmNl?=
 =?utf-8?B?S09RTDAzZWlHYk5pdHJiZDYyWkxQQkZZUTh4STRMMk1lQjF5bXJVT0xhNGNx?=
 =?utf-8?B?ZWFyS3hKb2w5bDNybWlwckRDYnZrR2lWTXQrWHdjWU9UQlVJVUlmaEdyeklu?=
 =?utf-8?B?OXZWdXFBTm1IWUkzY1NwcGhSVk9KU084SWJpUWd5MWVBWHh4WkFDR0pwN3Rj?=
 =?utf-8?B?eTZjM1pmTUFqUERwMUhyNHZabXZjREs3bDN4YnRxazdBZ2FaNDdkRWJzeHBr?=
 =?utf-8?B?bmhBc2JqanpGWnJFQmtueXoyekRjZjZkVDVwODFiKzBBcW5KcG5MMG9uVnRC?=
 =?utf-8?B?WWJ3akJIVzl3dEpVWlk0Wi9JeUQxdlcxdGtWZXUxZ2dBcCtibFNjejRXK25K?=
 =?utf-8?B?NElNcXFUeFA2dGFyUGNEVHBoVGJudmZxQWZvSUYxeTRZVFNELy9iMy9nektE?=
 =?utf-8?B?M3hzdTZkWmRhenhIVW14NjlDTFBXei9UTndsb2ZqYUV6YWRlcXFXUEpFbzJN?=
 =?utf-8?B?TklaeFBEclBqeHRoNDFnWDlkK2d3cjRyWHUvR3BJWFlHQ2ZyNWxuUTVXNzlJ?=
 =?utf-8?B?bFdqRmUyNmtmWTVYaS9qTndSazdiUUZlRzVaTW5VRGpLUXdYMlhFUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fb2d7f-1f2e-4072-d215-08de7e87b2e7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:30:42.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFHxebAuarCUVfmb37pTEapdVE/H9tWUXk/1c6BxnMELg584y1CobLZAOALLs+qAxgVpct6LIRhfCqI6wTrNKjAh0SEqSCZWpy/ruCKrfEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12177
X-Rspamd-Queue-Id: 0050624896A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-223841-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,rock-chips.com,collabora.com,vger.kernel.org,lists.infradead.org,163.com,hotmail.com,cherry.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cherry.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:dkim,cherry.de:email,cherry.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Heiko,

On 3/4/26 1:14 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> dclk_vop2_src currently has the CLK_SET_RATE_PARENT flag set, which is
> very different from dclk_vop0_src or dclk_vop1_src, which don't have it.
> 
> With this flag in dclk_vop2_src, actually setting the clock then results
> in a lot of other peripherals breaking, because setting the rate results
> in the PLL source getting changed:
> 
> [   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 to 152840000
> [   15.155017] clk_change_rate: setting rate for pll_gpll to 1680000000
> [ clk adjusting every gpll user ]
> 
> This includes possibly the other vops, i2s, spdif and even the uarts.
> Among other possible things, this breaks the uart console on a board
> I use. Sometimes it recovers later on, but there will be a big block
> of garbled output for a while at least.
> 
> Shared PLLs should not be changed by individual users, so drop this flag
> from dclk_vop2_src.
> 
> Fixes: f1c506d152ff ("clk: rockchip: add clock controller for the RK3588")
> Cc: stable@vger.kernel.org
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w/ DP

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

