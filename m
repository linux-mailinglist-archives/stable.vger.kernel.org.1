Return-Path: <stable+bounces-223122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO5uDmBxqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B69205794
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7D74300CA29
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718E35DA75;
	Wed,  4 Mar 2026 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mNY5QXaA"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089E3446AB;
	Wed,  4 Mar 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646735; cv=fail; b=oB2a4kqvG1CV9LvNOkTmPJnzFW6VqeP/b0CD4Yf6UooFIWV51A371x9Z8cntGtJ1LxL5EdEMSzi8E/i/BAJkdwhmXNEROE9eRw7URwoTLy456foLFkx7SA5GEXzuKyuZHVnjYuG/I8t/bwpCUMJJWSiCEEZDMkTjSKabV3a0pjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646735; c=relaxed/simple;
	bh=P8GsN3RDLlmEp6Xzl1stIZ/81M6eTc8z312os1xw+7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1AcUUAkxqyECT4p8LFt8mO77s0SNfM3TNpyoXaDji1JZSAMcRl4Kh9Z2IX2zdO7y30l+317nqOkY0yaz99HY5f8/up9oaIu7SvU7L6nb4CqVmwczOKzrb9fp0rr3XaJtRal91MbMxmhsbwBv2Cr34aEjTaShYuNuSwwqUtyeW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mNY5QXaA; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoJ5WcGazqQaYc90b2/dlIkk4dSoKXSaix+a5CfajJR74ygAfPGS05fmEBz5Cdj8aPG09MD8wtKx8wFPgw6x3pqNbK7p2quIJm+juOJ/eHKihSTdZboNx5l9DQMgj/q0mV2ZtbIhUr4H/IgjBgT3624Dkq7BJzSzMrLs8GvfjFfPav4Jd1M3E2XBHlRdZ2zH9amu2F/do+6RcTjlMPIQK3M4HJj8neQ3sgdmWoQQuVZsrT1GcuzoYoQ2whiE7gXRjN/CjOUy/PehpLzXS9PDbV9VwS7h75CYgMFq6g2Zn04hlx8oqSpQPHYugJOSwXTPe2MrYIS8uJ5LYYqqOq7a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8GsN3RDLlmEp6Xzl1stIZ/81M6eTc8z312os1xw+7g=;
 b=Xh53JepnIpKKOQ0AVVbGuO68eNHHRwtlPchIUAuf84lCpsJZML21hkkATK2g8dIeKwa8YhNL5L2Ap8b191gYG1HBmnlr3/43CQCVjDy+cXq9WX/MC+TB7x/FqqdmgQluAo4frDDPklxttvi6Xcp8KvMpKKKMpV4bBH2PLIMNfRuwvv4yQyJhH2WKC9JFCK65tbRqcjjrZCK94AMxrjPd+eVuyMCk0x6m97cPsRavXfwr1LSHzJ7BCdndCOS2ZMKynzdzLUHdkCr2j5tiooVN3QFh3yzpFJnhVIl6AsYRXA+2/XTGPEgMPdkQmdpAGvQ+mwrwJhTLZp6Z2TigBYUEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8GsN3RDLlmEp6Xzl1stIZ/81M6eTc8z312os1xw+7g=;
 b=mNY5QXaAcPzjAa/HXJJe3yK9XRDPhBe7nG7hbf1pJdaTiJbhuqKaugZaz7uWTvQWPDwtoiq7nz3GNlfrMdckugmqXcQ9unrc7a2rxt4IPdgjwnzMlmvmwQ1QY+ksoUJFBPc7iKYEwBZ9kH7AUhyV2FPNVEXA32O3DFR0vFlOFjWI8UXJmjs2BLYTUbjIdks+2uQMCBvc8oOMxemBidH0ycduD86SeOd4bmTgzY9W2vSycVmYY0HPE3Rcsweq4W7sxdEcIDnw2tqUE2OgfdaI4icnfA92DJCAyOgnVz0jqzrY2N1k6EkErJNkITgpKoIaWiO0CHXhNOirUOSXiV2AXA==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN1PPF570520B79.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::415) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 17:52:03 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 17:52:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"graf@amazon.com" <graf@amazon.com>, "guoweikang.kernel@gmail.com"
	<guoweikang.kernel@gmail.com>, "henry.willard@oracle.com"
	<henry.willard@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz"
	<jbohac@suse.cz>, "joel.granados@kernel.org" <joel.granados@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
	"paul.x.webb@oracle.com" <paul.x.webb@oracle.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>,
	"harshit.m.mogalapalli@oracle.com" <harshit.m.mogalapalli@oracle.com>
Subject: [SEVERE] Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Thread-Topic: [SEVERE] Re: [REGRESSION] Linux kernel 6.12.75 fails to compile
 with -Werror=implicit-function-declaration
Thread-Index: AQHcq/1MJ0ZQ8kX8tE+l5S0JLRjgyrWepzvN
Date: Wed, 4 Mar 2026 17:52:03 +0000
Message-ID:
 <MAUPR01MB11546202F5CB445AC8683A176B87CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
In-Reply-To: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN1PPF570520B79:EE_
x-ms-office365-filtering-correlation-id: f6672827-9451-40fe-de58-08de7a16be3f
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|14091999006|6072599003|461199028|19110799012|15080799012|8060799015|8062599012|31061999003|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXd4QlY3bTNpY2pDN0t2Tjl1Y3pwdVZhMndhQkNsL2RMQXl2Yzhmczk2bjJj?=
 =?utf-8?B?bVk4dnZNVWI5VnVBWlVwbjl4UFJZU2hMbkIzbUQzZDcvd2dvTElGeVV6d1JX?=
 =?utf-8?B?YkkwMGN4OTZiY2ZpMGNLbGYyQ25YR25Qbm1sY3hxV0FFZDlsNzRBZWo1WjU4?=
 =?utf-8?B?REtPUWx0elBCUDRCWDhEL3pLM3JYSVpsdzhiRWpJREgxbGYzL3B3UmVaSmFn?=
 =?utf-8?B?bkcrRUxwNjJBcHJrdi9oNUpjUVM1YmZxUGQwbFEvMW9VY2xjUG9IY294bUpL?=
 =?utf-8?B?VjlWRU42bzRDajNpTWY5YkppTW1JVVZBc3llUVRYVk9hNHY1c0cwT1NPOXoz?=
 =?utf-8?B?WVA0SUE0d1lYWWxYczl0dSsrTG5DNHdmV3BHcUVodTJvcTNtd3pvZzhvdmZD?=
 =?utf-8?B?VXdDQUF0NGJSelZuY2RaZnFRc3dYWGNaYUMwSnJpTjRVaE5YUSs5VXh4K3Nx?=
 =?utf-8?B?Tk9hL0tqbEJibHlSZVFFYlNIQ2FjNHpKVEpZZTZUL1N0TmtPUGVJMWdvbW4x?=
 =?utf-8?B?UnlWWDRLSkhmQzZQLy9iMFdzOVd6eHl1Ui9OV2xzR2VnYkpMNjc3ZjFkaExE?=
 =?utf-8?B?RzBxR1o0MjVHZitDY2dxbzM0U1Zib2ttY2cvb1IwdFUzK3FUWFdIeFBFRTVK?=
 =?utf-8?B?aTRmcjY2L25KZ0ZTTGdXNmp4YlQ3dmllaHdzVzlKM29aM3lIWXNSbGVEaGtu?=
 =?utf-8?B?TDduY21UbzFCenNjK1RiZTBueUlpTnl1bEZPbFNhZHZFRTI5MUdyZVV6OW5M?=
 =?utf-8?B?U0FPVVlWWWJEZHE0VTk4S1Yrem9RZWxCOHBEc2xMODdUb1hOWjhuNzA0NGhj?=
 =?utf-8?B?bWRmZVl2a3B4WGVRZzgzOWl5bmtPSUdPak5ETUtvMEMrRk1YVFA1YU8rWmhU?=
 =?utf-8?B?aWw2TmFvcEl3Q1E3VldWUnIzZWQ3emQ0UE5RR2UzMmRIOTJ1cjEzOFpqUjV4?=
 =?utf-8?B?U3ZFMTFkZnBiTmYzbDFjVlRTRG1Ta2hIQlhLRDBEOTNZaGYxbmswRlB3UTJv?=
 =?utf-8?B?QUgxU0tvQ3NYcG51czV0aENVOFV1bVM2a2VJSjRDSnkxamRrZHdnSHhoZFR4?=
 =?utf-8?B?aFNZZVpNUEFXUlZ1ZnJyZTdZR1FJMldPU1lERHFWSjQ3TFNpcDg0VDkwQXJl?=
 =?utf-8?B?Q1NzaTc0dWtzbHpDdFNESnFQK1lleFJJM3JRR2lzYlZQdUcxVC9wT3VmZnBC?=
 =?utf-8?B?VTRXZzVVZ2Y4c3BYVUZuZzVya1dydEZEZWxDalp4a1ltbHdOWjRkNjg1Ykl0?=
 =?utf-8?B?Sm1vVDM2b0w0V3BBZFBwdCtzQmozWEdtK1dZUXUwVElPZWh1ajhvcVRaRGhK?=
 =?utf-8?B?VVZuYU9YdmR1LzdXd09Nc3NrS0Vzdmw5WVRiZjc3OHFHNUsybU90VnMrYUxM?=
 =?utf-8?B?eDRjSEE2VEhGMEpobnowR1JKMkFFbmFkcHR2a2FOOE9HWHptUlM5THQwakRi?=
 =?utf-8?B?NWd6ZFgwUnU0YWVVTDM4SmpINm5jdjJ3azZXNkVmVW0xcDZZMWEybkNiTmpE?=
 =?utf-8?Q?Bp6uqU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2Z3b3JKeDBwRmxGeE4zY2JIa0lOM2NmdEFsdTFQdk1PVGx0UW50ZCtSUHh1?=
 =?utf-8?B?dzAxMnR0ZG9mZ0pXd3RCTDNBbFovdm54QzVnNFB5aTlwK09wUFEwcytWeHN0?=
 =?utf-8?B?OTRPUGZ5ck1JNExTWVZIRUZlOXlxbGNWT0RYY0YzOHQvTzdMbHhSSXdoZFFz?=
 =?utf-8?B?WHJoNVRBQzh1dmdlYWZ4aklXT2xlbWNqNGxVZTd6dWRnK3hhOXlSNnloWUdi?=
 =?utf-8?B?UXQ1eE5pMEhtekw2Yi9ZckFsKzZWQ2RGT080NU9xNkZmVHpSakNWR3lqUVhp?=
 =?utf-8?B?aEVFSW9QZk5lZlY4Yzk1bVdpdDhSU09lRllQTnRaVXNZazdHZDlNZDFNMTFt?=
 =?utf-8?B?YXpSV1g3NkFTRi9jRHpxeHZVS252eEVQcnRNMXZlcHpEbjlDSjNXdGlEWjAw?=
 =?utf-8?B?WHZ5OU90THdLcXZ5cHJFRnRyVDZIZ0Fha0dkWitpT1RCcTlxSjEwUzVOU1pU?=
 =?utf-8?B?ZnFMRjNMK2dkQlk5anhaQXZPUk9LcnVjTG1YTlQyTXpSSU9HNmUvVVFhL3BV?=
 =?utf-8?B?RnBqSVF5MnUrRjc3YUoycnk1aTB3NWRTZm02MXFEdHAwVENBMzlzQkpnWW5k?=
 =?utf-8?B?dWUwRHNGNzFhUGFLaHVyRXgxZWVMQW8zbk5YWEFITzk1VXZIUVI1Vkt2Rnhw?=
 =?utf-8?B?OTJVZnp5Zm43elV4d3liU1M5b2NlTXdUOUFyMFNISjB4S1lLazhmeklaOTJU?=
 =?utf-8?B?OG92RTg5by9MY0d0K2Q2U1RENFEwWC9RSWhtc0VkcVQ0UEVNaEJzWngxUjRH?=
 =?utf-8?B?QnRkWkFZcTV2bkN4OTBYQTNtS084c1JiSlZOTi9vWkd5anFUYUMxVDMxcG9H?=
 =?utf-8?B?ckhzRTlZQnc4YmFhRjFkKythL2FBanJXMkp5blg5SWVGR2p0Zm00dzMyeHJI?=
 =?utf-8?B?aVdvV0g5UVJnRHlaeGlsdGMxR2c4Sml2aGd5UlVSWWNCWUd2dEo1RUdoQ3do?=
 =?utf-8?B?NUViMTlieEsxMTZhc0xMRGpKd0VLQm51SDUyZEtteGlNTUpiMjJLTTJiRzhX?=
 =?utf-8?B?MitnR2lFcFRzRDMzSU1iN2NCRjNENWNFSW13WGpmOFlCQzArS0R6MU1EMGpJ?=
 =?utf-8?B?cC9KQm1pcGdod3Q3ZXZraGRiMDZ2d3d0cW10RnJ5a3VXV052cFVmWG9OSE8z?=
 =?utf-8?B?c2NpRUtvTFRvbkR6Z3hXaFFPZy94YzQ2M1RrbVZrOFVjaThDSmR5T01jb2hh?=
 =?utf-8?B?TmU4Q0RJZW1Hc2RQeDVvZEwzRXJZYmFhMnNCaVg0eHhscDE3K1haZk9RSXV2?=
 =?utf-8?B?ZnUrQ3FiSW9RSzVLU0t6VEtpeTlIUW9NYzBZZjhtbEI3azgvTHM0bzBLcWE0?=
 =?utf-8?B?VjE5WVl4RzFGcnJNbnRiZU1CQTdEY2wwSWtTUDFNVzl6MUNmWktvNzVIaExG?=
 =?utf-8?B?WStKd1l3YndqQUNBQ2pJVnVjZkhZOERpSjBCbmc0c3hTQkFpYU84dHNZeU9X?=
 =?utf-8?B?WUQ3NEszNnVxT1h4WGRoK3pWQUVvY0hWWm11bFVsdzVKR0FzUTY5WnB5M2VL?=
 =?utf-8?B?Wkk4Z3VGMFI2U0J1S3JJUUErV0Q1enRyV3lPM3VUb0tZWE94MUlUOE82bEtz?=
 =?utf-8?B?OEdrbWRrTDdSSVhMUlhENWE0SDFwRzNQb0dRWGt6TWgybU5CQ28xQS91VmJH?=
 =?utf-8?B?WkxsYXEyOG52WGRpSnFsNndmTkpRd1B1d1daekhDb0JPVkdXTGZUR2V4SnRK?=
 =?utf-8?B?cml5TERTOXFEazhibjZiNG1jUkh4WXkzcVlNVWlvOFUxSDYzOHJUaXJhRzU2?=
 =?utf-8?B?ZUpzYUpKN2RGRE9ZdHFUMVFlTGxOU3BDM3lOSDRkdDZ4NHp3aFF6NkgvUUFR?=
 =?utf-8?B?YldRT1FwK3BTR0g4TXpyM2QzdkNQd3BtOGxwVmpXbW82UHBGZ0VPd0NRWStR?=
 =?utf-8?Q?73wquw5TJfzln?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f6672827-9451-40fe-de58-08de7a16be3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 17:52:03.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPF570520B79
X-Rspamd-Queue-Id: D9B69205794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223122-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linux.ibm.com,linutronix.de];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:dkim,live.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Action: no action

TG9va3MgbGlrZSBrZXJuZWwgNi4xMiwgNi42IGFuZCA2LjEgc2VyaWVzIGdvdCBvbmx5IG9uZSBw
YXJ0IG9mIHRoZSB0aHJlZSBwYXRjaGVzIHNlbnQsIHRodXMgY2F1c2luZyB0aGlzIHJlZ3Jlc3Np
b24uDQoNCk1hcmtpbmcgdGhpcyBhcyBTRVZFUkUsIHBsZWFzZSBmb3JnaXZlIG1lIGlmIEkgZGlk
IHdyb25nLg0KDQo+IE9uIDQgTWFyIDIwMjYsIGF0IDExOjA14oCvUE0sIEFkaXR5YSBHYXJnIDxn
YXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4g77u/SGkNCj4gDQo+IEkgZm91bmQg
b3V0IHRoYXQgTGludXgga2VybmVsIDYuMTIuNzUgZmFpbGVkIHRvIGNvbXBpbGVkIGluIG15IGF1
dG9tYXRpYyBidWlsZHMuIFRoZSBjb21waWxlciB0aHJvd3MgdGhlIGVycm9yOg0KPiANCj4gYXJj
aC94ODYva2VybmVsL3NldHVwLmM6IEluIGZ1bmN0aW9uICdpbWFfZ2V0X2tleGVjX2J1ZmZlcic6
DQo+IGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jOjM4MDoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uICdpbWFfdmFsaWRhdGVfcmFuZ2UnIFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAzODAgfCAgICAgICAgIHJldCA9IGltYV92YWxpZGF0
ZV9yYW5nZShpbWFfa2V4ZWNfYnVmZmVyX3BoeXMsIGltYV9rZXhlY19idWZmZXJfc2l6ZSk7DQo+
ICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gY2MxOiBzb21lIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IG1ha2VbN106ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDoyMjk6IGFyY2gveDg2L2tlcm5lbC9zZXR1cC5vXSBFcnJvciAxDQo+IG1ha2Vb
Nl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjY6IGFyY2gveDg2L2tlcm5lbF0gRXJy
b3IgMg0KPiBtYWtlWzVdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY2OiBhcmNoL3g4
Nl0gRXJyb3IgMg0KPiANCj4gVXBvbiBzZWFyY2hpbmcgYSBiaXQsIEkgZm91bmQgb3V0IHRoYXQg
ZmFpbHVyZSBvZiB0aGlzIHBhdGNoIHRvIGJlIGJhY2twb3J0ZWQgc2VlbXMgdG8gYmUgbWFpbiBy
ZWFzb246DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTEyMzEwNjE2MDku
OTA3MTcwLTItaGFyc2hpdC5tLm1vZ2FsYXBhbGxpQG9yYWNsZS5jb20vDQo+IA0KPiBMb29rcyBs
aWtlIHRoaXMgc2VyaWVzIGl0c2VsZiB3YXMgbm90IHByb3Blcmx5IGJhY2twb3J0ZWQuDQo+IA0K
PiBJIGFtIG5vdCBzdXJlIGlmIGFueSBvdGhlciBrZXJuZWwgdmVyc2lvbiBpcyBhZmZlY3RlZC4g
SSBjdXJyZW50bHkgYnVpbGQgNi4xOSBhbmQgNi4xMiBzZXJpZXMgZm9yIG15IHVzZS4NCj4gDQo+
IFRoYW5rcyENCj4gQWRpdHlhDQo=

