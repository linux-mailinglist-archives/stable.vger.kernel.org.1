Return-Path: <stable+bounces-223196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHEVH6J6qWl77wAAu9opvQ
	(envelope-from <stable+bounces-223196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 13:44:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623A211EF7
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 13:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD0E630699D5
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB937F8C0;
	Thu,  5 Mar 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="glm0/Xed"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43039A7F8;
	Thu,  5 Mar 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714414; cv=fail; b=C4yU10Tb6FHwdxjeKAyEBakoU1chuev3EmLF0wHpPG2sAPw8Zr6Hx4bBwHSY86D2i5fakrLIpeWsqC5q+SrJKyoWn9xr86e4wk46V5TE3T9GQCc9P3BruL0t2h55Q9LXGDQiohTUODXcjBkJr6PUNk+K52o6FGRIVIEzKskmqtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714414; c=relaxed/simple;
	bh=faE3yArPFBh724rMD6WlT71QNlUD2v4HLBxLwrcIVkU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxXIyB7Mqtti8bjIq1PnJJp2fxMGlV2bI5dVTdZrKC8bpy/LrWFb2L3n1OZk4A8mdX7tS+ApiK3tThU6+4zCgBiEyYBVMbtrT2VMsmdfzRP/MVAvoUii5/g73RrAhspA576hNv1W+Zq/qPaithW/QFTgEhbk9qsPdFMERTf52pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=glm0/Xed; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXwyACBw3EewFGhZ8bVsONmZ9O2cTI0L8+LfXYn1jCHQrLoeXS0dqWjEY2Ci3cm4JOxjMjUhrTrnJBFBubUS8OU7yoUaa3dC1tnUukmobzbeLV4DMqr2IxyT9gNFjq0xwO9vcUEpZqsNzJtdlyb4wugObXbOH0qsnRf4wQlBC+wjE4WkfQrLuxL+2Dcv6Cz4KjeGywfOgr2ZBEb33ZQlyNAZ5PJwA4ui8Ntd9RV2GEfuJI5L9OYncPY5WRZ51fpH8eFUHiGHLBcCyecEgfvHYn4WlQEqOjwJH+jMX13Dkx1GukHJOmzHn1b7P9K0xioKr5H/IYxLoMCHumSyGQb8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faE3yArPFBh724rMD6WlT71QNlUD2v4HLBxLwrcIVkU=;
 b=iKtOtZOZCsJVLl4T2k+EYlbFM9SJmBXXpgRf8fDHd70fcbH/+WwZTfqY5doQqLSzVtFMWMkVRhlY8lLbXW93ARm6ZwQXml+SrqZRqHQHiGiW/7j9F+0A24zNPSvK+xGUaapWTxnSGIT7DtTcVIGHFr55zLTFaB6A8tPYdXjFg0xuwHr9IzyNhlxJ88/iJQ/9WKSLkIxs8LbVh4/Ec+rItFDi56ynbH/DlGKnM7oWh+EziQSCyaxse25VSbLc4pRBBP/GNktGG1DN+i252Yusx1NMOkl/zmIPOablEBGssg+hPgIUAp8V6HODQ/y8MGSpk8vspIwr1HpWZqB2umJNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faE3yArPFBh724rMD6WlT71QNlUD2v4HLBxLwrcIVkU=;
 b=glm0/XedJDOWjv/rjDSCIC632geGE+quirIj4cVzKISBnUMSB3KkkBt0Ul+O20vaMgsHqRirHJJg/CHEfDiM6ty7YPjITrtdEqL9/bWOkvsXMy4wxUMhwdkCZ4p86hm31fo7wPN7OSi37fo4jYgqBPjiYBH2n+PILX3EPFYi7YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by MN6PR03MB7670.namprd03.prod.outlook.com (2603:10b6:208:4f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 12:40:09 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 12:40:09 +0000
Message-ID: <c916e668-f056-4ac4-9113-c9b219cf092e@citrix.com>
Date: Thu, 5 Mar 2026 12:40:04 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org,
 David Wang <davidwang@zhaoxin.com>, lukelin@viacpu.com,
 brucechang@via-alliance.com, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
 cooperyan@zhaoxin.com, benjaminpan@viatech.com, TimGuo-oc@zhaoxin.com,
 QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, me@ziyao.cc
References: <20260228173704.62460-1-me@ziyao.cc>
 <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|MN6PR03MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: c57d3ed8-4a92-4be8-613d-08de7ab4563f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	wyHxqBuBt9lr2cD3OrgAZNRX6GPmmfAFF0UJXkFfIa1DExBgDNJOBpOUq+Pp57lKCP+kV3MRyvSbgpI34Liyub9jwweXGZ68Ypdyoep41iGMKigyEcOQa0lkDDbekG6UKbQel/2TB1+DTFVlDS5d1ejffxvmG+JrxAQxpjDCedy8F6prjHfDqVuAhqKLMmkiijJT90grUSikq9G0z5QEUC6Me1IGzhx4cq45vnDfPoEZ3lk4ExnWbJLySYfB2rUemtqsHS693SCYf/CrU1l3g85JadZJqtz17wM81C75Kd1DiAkwM38pSHrlv/zgcSwJBrrqXxYXL+z5dF+2F2SoleeKlVaIwOdSe95aAPeLanonclpZwi7F69REKl0+1K67D7WgtNMgonfO/UC2NnHoeLX98GCEwdLBg6Fr58c4mvSE6fEudfSiqvwQ17SXOeQgJ7rQPEeQBEVCHrFrWKVDczBmWiB6qCxdcPzXjidSsIKRMoLI92mJc/xeKi5urZdEAX33i9m+Rw4Vz4m6ATvidO2A6FgJGTppHZJ04bsug9TFpt9/XG7LvKKhSeQDb+40bVB9mN9EbPy1sYHFRi6zSl10GQyrlQliKc+Rpm6Bcf7y79katykx4FYnmZfSH+3Xa8/Rup5DrTyC7cdPLC+Y1mvenDZtPJPPM4yeippd0qfcNTaoI1lmZnf31h/hpHFWrZ8ahglL9d1Ruz8PhnwrFMfjU/24Ih1NE6Rl3vTig6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEwrVnpLQWU0WDhqRmttMnNaeXlpbHAwWE5WbmFrb3Bsb29NNW1zUGM3REVm?=
 =?utf-8?B?T3RLSmtBTXc5dytvbkV6cGZaL2tJY0ZoeVBQdndUTm1QdmY3RVRjUk52bWN4?=
 =?utf-8?B?Q2d6ckN6dUhkVjdwdFJrQmVTTnpTUFNlT3FDNDVCYm4xcld5WDVlRm5rdGZ0?=
 =?utf-8?B?Skoya0gzUUwzdWZra3FxTGFTNnppbWNqMFNPcnFwZnZHQmxuV29mc1MybGlr?=
 =?utf-8?B?anlETG5FK2QzSHh6NklzN0gvRmR2OFc2VmxHejcrc2RIVHAzWHhMM1llYVNa?=
 =?utf-8?B?M3lkbWVkdjIzczFLSEl5YkZKNlRDSm5uL3EzUVd2UXNpZlN3d1U3bG8rcDZI?=
 =?utf-8?B?VGora3d6NDlvZm5TQkswR0xCbG5YNEh6b0JvV1ZaWms1YUV1WnAzSXpGQjds?=
 =?utf-8?B?SG43VTFEd2hqMHRzMVhhSzJDOWpKclFDVkNndnl4VWFpWllyQmZHMmh6aE9H?=
 =?utf-8?B?akkweWFQWWppbnRQL01wWCszWkU5aU81ckc1bUhtOHVtbXl3N3Zodit5d3NX?=
 =?utf-8?B?M3JiTkZnOStZc0V0M1hqc0hNalFqSHhyUUl0ZzFONElQTHdYR29jWUVSMzZR?=
 =?utf-8?B?ZVArQWErSGNPRlNDRTVJNFJ6OTI1TWU1Rys2Y0pRK2NKckxJVXEzZm1FSCtM?=
 =?utf-8?B?TGd6QWVKMURyRzB0UG01eTFMdlpVZ2FmQlFuVmFyaVp4R09WdDQycktLUkRv?=
 =?utf-8?B?TmRWU2J0UjIzZHFTNkFwM1M0V2tLK0w2MHl5OUthTG9KeWo1TXUzT2FjNVhG?=
 =?utf-8?B?UHRHY2lCWXlXQUlMWEZDZGRUNlhnY2xqUWJCOFpZWGJBMHZtMzV2bTBtcndN?=
 =?utf-8?B?bWFxZkFWSlZaaVJZZlFoTlUvZ1R3dXBwZGxoZTBpVXJoWW1xMUQxREJ6RzV5?=
 =?utf-8?B?S05iTkhUQkEwUWdzc0NUYmhlVDV0U1M5a1p4VE80Qzl2eTJRcGE5RmQ4Uk5Y?=
 =?utf-8?B?WENPRk5tOXdYUy9oUlVIZ0puTExkY2h1bnMrSG5NMWllMDhieC83bk5jTE9l?=
 =?utf-8?B?Q2craFZtT1pWeDlKbUQyYXgxRTRQQWpvdjdrc0padTNQTlgxTm1UMzVLV2s4?=
 =?utf-8?B?WDEzRzlVSk8rQ3FGQmwxeDJ3cm5EdUVRU2x4eHpSRUNaY3hsZ1NDeEZ0bFJF?=
 =?utf-8?B?aXBOeUs5NFk1M0VUUVVSZTNFc2NxeXJ6NnlDSGN3WHJLeEl3VU04M1pDZXF3?=
 =?utf-8?B?VFdBYTlLdGxua1ZkVWRFbEZ6UjYwaXBoYTdsWDVlbGhkOGx5ODZ0MGxEZitB?=
 =?utf-8?B?NUtCSVhzUXBMQ2E0emJLSmZCcFo1U0ZNQ2ErdU0rcnlTT1hNMldCZ2tIMjNR?=
 =?utf-8?B?SFNxTWUrSVE3SHltNHByNENPTGJDcm51QlE1c3prUHpYMlhTcm9Oa1djYWZk?=
 =?utf-8?B?VGxPdFRicG1nL1k5Mm5YRStGT2lkRkFOdGtGQnNWZUFkbjVONjg2M3BFb3Qy?=
 =?utf-8?B?czRvTGJQVnBhY213U1h5V2FURk12RmdPaTRiTHRENjBHSzR1ZUEwTVdNWWtN?=
 =?utf-8?B?Q1l3aUFNOXNIVFpCNFc5akZyMkpvT0NhMWx0NXY2a2JZcTJHb0I0YUYyOTRD?=
 =?utf-8?B?TG9iSlpBVjB6Z0dEdGhoeDJpOVcwN0tBTTBKZE9mWXVBVmRHTmM1ZU9BUGRP?=
 =?utf-8?B?TjNESWdlRzczc3ZXZEd0VCtVWS81U2RJeEhaeHl0SENlK3RYMUp6MmU1STFM?=
 =?utf-8?B?dGFJb1NWYkxCemQ3bjhUamNTeVF2MDBiTGJJeXJoWElDbVVlV3podzM5SW01?=
 =?utf-8?B?UTQzZWpHcGJzbmthRzdkTFMvczExWXh4Qk52d0hRVVBVMHA3elpIZFQ1aUw0?=
 =?utf-8?B?MUtOaytzRUtDYnlIY1RrL2p6UWFiVHIxM2M0bExQYldDdkd2SDdVTXJCV3Za?=
 =?utf-8?B?SDIwRnpVaERxOVBlVFFJcWZlSWZ2OHZFcS9wMU9CTlhaeHNFNit6WndIRmho?=
 =?utf-8?B?ak5vWGlhZ2lQSTgxV0JDaUJhKzcvcWt4ZWVrR1o5cWI2WmtELy92VUlwcVVw?=
 =?utf-8?B?cjFmdzJtSDVGa29iSUpLY0hORmFYaXB1RklnOGd2S1ViZjUyTC9GL01KVEJJ?=
 =?utf-8?B?V0UzTkpjbC9jQnYzN1RZaUtIaVJ1RTNwZXcycGt2Y1RPMHFqblFoMFEyTmQr?=
 =?utf-8?B?dStyYzNHMXozeDhXSXVZQ3UxWnUxSUxxYWdYNG1JSFA1UVN4U1JKSDVOWHZU?=
 =?utf-8?B?SVJVWmw0QTZhS21hTG1BeGtNQWVqYzg1cm00OTN4bGM0WE5iWWdLU3lNYzY4?=
 =?utf-8?B?dnRrNk1jUmQvMUdFMGFBT09YT0diU1pObE9BdG1NaFJWakdLOHAzeENlRmY5?=
 =?utf-8?B?djlvbDNUd3luRVRzSmVQNzd3Z3RDZXp5cEtmNC9SVXVQRUZlUStHdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57d3ed8-4a92-4be8-613d-08de7ab4563f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:40:09.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6k1m8wEVn/+wSegHj5bVMxSRy1UfpCCZE/zhM3SafTn39262C7+9g5vmDjdt/YAyiECDna6apNGoGtMrHC/JZpfMcbhXYYJqG5juti4Q0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7670
X-Rspamd-Queue-Id: 8623A211EF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[citrix.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 05/03/2026 9:03 am, Tony W Wang-oc wrote:
> Thank you for submitting the patch to fix the Zhaoxin CPU issue.
>
> After internal clarification, we have confirmed that this is an
> issue with the ZX-C CPU ucode:
> When modifying CR4.FSGSBASE bit 16, the ucode propagates its
> value to another MSR register. During execution of FSGSBASE-related
> instructions, the hardware actually checks whether this MSR
> register's bit is set to determine whether to generate a #UD
> exception.
> When the CPU enters SMM mode and then returns via RSM, the CR4
> register is restored but the value of CR4.FSGSBASE is not
> re-propagated to the MSR register.
> As a result, after enabling CR4.FSGSBASE, once the CPU goes
> through SMM mode, executing FSGSBASE-related instructions will
> trigger a #UD exception. 

/sigh, SMM strikes again.

As this is a ucode bug, can it not be fixed with a ucode update to RSM?

~Andrew

