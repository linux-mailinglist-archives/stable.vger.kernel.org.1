Return-Path: <stable+bounces-181601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21FB99D24
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CBF7B253E
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C3019B8;
	Wed, 24 Sep 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VxKlhqTH"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDA2FF67C
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716586; cv=fail; b=BAMGHploL9azvLlk1vMBi7PY+4wnk25C1HrRGL7UWvrG/DGbegvimRePR5+n1H9zG9fA7diVeMWp/i+2zsd/jCNGZINeuJpHg30DHdeV0k3iEE8Z/NuGzasxekEO0+6GdLTxaZkc40d5LmP9fQkxeeCA+ASSWxqZoQq+01ERdnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716586; c=relaxed/simple;
	bh=h5izFw+I6Ni584vbmdpR4fQhkuWP3mrzcBlYMA7MGW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BwqQY1b/PTB0mD/PrlygJaLLQ5MGLftYzfSOf0ZcdwyeqYadQTHWYlikqvulXeYd4wMWzcndU3zrPNvYH1hKfw/1tj5fm+0gSHj5GWxvEZvfarmZSQ/zKKbwdAZ2egdvY5D769hARFWEhltJCF2rUPYIYGoUJGNk964Mbbgikwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VxKlhqTH; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy4YIwS+Xx8Z3y0E+DPWMtPh0uJ3mwe+fLPBlT+u9elu4qdjTXo6vRqMOCCs+/+/cMy1MfTcfDF+XC0V/6CN5ezp5UezyFoQNWMyk/q7wZsdaaTHDqisImMNePR9xoqLkGzAamrlTHQeDpBOSvs/np08bjGf3F0d53vdr7xw+2BN8FWjCFHxQLbANi8rOyGCZO/OK2IFxAaU0p7fH4kbke/cGRuQGBnWwcisUrbv0rqRz4EY1ElRtrJXmr2tjuSuK4Ngeau1I1Od13Ebxl4IlU+PTq/uRBqXSID4ef2C85R0SRUro+uhGi72Rw1gUN9uhBr29s9io6xo1xz39RXX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCsiCK2lY7rgGkU1RReWwSkk2nCEg1ctJrncokPspQ8=;
 b=A2A40tTGMVK1cn3mxW2a9KTygE/cBRs7BoYGR75hNwnEyQBcoLYF37gz0c1sEj1c45HFTcNXAFAxskIysxVMN7PucPNZjVLX7PolryCO9lzESzSfUkSmO5VQFPf6djVii7j0R6aFm0BMJiOHTHIMreHtwDHpN81VgaJwbC+qnCuJMplZa7VpTDbbGfF9gQJ90y3ycXxtS78EyqH19uIvsQ2Al72vEiRgj4ZabtrsOUoZktOS1OhJv+I+Jni76GIYFGZeIwS/R1z/bFsr7ygX6jd0jiRDRsqQqinWTvnQtyz/EXWSAE5+JazvmqxwHv5FKZPVSVDxH9sTpLaIwr5GUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCsiCK2lY7rgGkU1RReWwSkk2nCEg1ctJrncokPspQ8=;
 b=VxKlhqTHDlO9TfZhLvCme2rRnYGFcuru8I+noguWLwL+eqXnnmJ9KcP0Xgh2cAu/J3GpVCev8LfHfQS0SY6avMeGdWSLvQd4z24/UcokvjRSqIKJMVbvVS5rNkYUVDtTPZNiowMb/w9C4O94CW9NjVMeY9UnjJVLKAvaP0ieBH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:23:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 12:23:00 +0000
Message-ID: <a7afe3af-eb0b-46b8-be20-2ce2933fdef3@amd.com>
Date: Wed, 24 Sep 2025 14:22:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
To: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, stable@vger.kernel.org, gregkh@linuxfoundation.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
 <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
 <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
 <DD0Z8GX3Z56G.3VLLBSJUG05WK@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DD0Z8GX3Z56G.3VLLBSJUG05WK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:208:23e::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d6d376-ea6d-4f85-4fb5-08ddfb6519c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzdoT0ZLL29GcUtOdG5VY1VKcUIzSXY5RjRhd1I1TkNkSXZveHh1dURxWjdP?=
 =?utf-8?B?MEFnd0tMY3ppdkFyMFREOXhZbVRlZVVuWTEyQnN5a1M4WEkzSHg3akY0VEpL?=
 =?utf-8?B?SXNOQzVLWE4vYytIVitlMmtFVnpUZDIyYUJqKzdXM0dCNjZpaWRQYVRBeTVB?=
 =?utf-8?B?c2pNVGd3MlV4OGw3UFQrdlNHWHF2aFhjNy9TOExCemI5aU4wWUE1a2wwdm1o?=
 =?utf-8?B?emltQlBtSkdNZ1NpbmRPUm9SZEpOckNoOWNQcjZ4QXM5UXlpNlE0TEoyVTUx?=
 =?utf-8?B?ZGlRcXJva21RVEJqTWxUS3FnYmlNcUwwdWdjRnR4S0QrK2xnNDBBcnVtUkQr?=
 =?utf-8?B?YlozNWtTd0ZYUnFqRnVxelV5OHBFRXZsZnF1NjJWQUs5TXcrcVo4L1YrZDNm?=
 =?utf-8?B?WTYwRStBKzBzNlhEdGJYejRlbXRTS25IQUp1Mk1HbW01SW5YWS9RT2RuNG42?=
 =?utf-8?B?ZFM5aFVRWE9remQ2QU5FYmRncGJtQVJ0QU5US0xWc1QxaS9lZk1EMWdwTFcx?=
 =?utf-8?B?M1NacVMySHk3c2sxOXA5VW50N29hVE42ZG9RSTVza0NENDl3aWJJRWZqMG5I?=
 =?utf-8?B?RjV0eVY1ODN1eC9EQmZGb3JjeENkUjlOTW4zcE0zMkVIMHB5MzdEeGxhd3hY?=
 =?utf-8?B?Q3BjNzRMRlMxbHBMYlIvNkZIdEJMQjB0WHd1ZWZVeDhVLy9wZ1ZaeXB3TmhT?=
 =?utf-8?B?eUtYMzNBZFBRTlVNT1k3QmE4T0FOZ2NLU0xvcy9lTEZZWjk5Z3F2M1E5UjZY?=
 =?utf-8?B?VFBRRXhaaFJwdnNRT3hqN1A4ZjBJS254V3BpSGdxMkRkZ2VuYWZYeXZKNEhr?=
 =?utf-8?B?NXdrL1RINnFyelJIdlFLb1I3dm1Gajk3QWxLSlRCZG1UbmtyR2UwSWkrNGZz?=
 =?utf-8?B?bkRzWTJmanNnRkVVMlpOU0FHdGI5Q3dOQjI1RVVDYmZ2OUNJZWQ5eXdlemty?=
 =?utf-8?B?K0crTGZWem5sRndxMzhENVJrZ0tBMVUzK1lZTzVhTXFQNFdXcUVrRFRoT1J4?=
 =?utf-8?B?b1lya0doOFp5TnVCVm1OY0MvVHpYVnRyenhWWmVESHgvSEx4enBlc1JZV3hC?=
 =?utf-8?B?SXd5SDgwS2FMRjVuaGhxdjdkNVFxUkpGSkp3UnQ1bWtIUEI3SzU3U1BuMlVG?=
 =?utf-8?B?QkthSmJsdldtRVNXc2diRWZIQ3h5anRzSDU3VUU0N3BhcjBaSno0b2s1cU5y?=
 =?utf-8?B?bDdSc2RpdC9mNlVqdkFIUnVZSnJYU2EvanduMXkvZjFlQVFBM2QwR0x6QW4z?=
 =?utf-8?B?UHdDa0l5bm5Dd2V2L2dJQkc3MXJkSDVMVC9NNTBMTlBJZDR0Z1lISHhXT1Zv?=
 =?utf-8?B?MzRkcXpsQ05xMHNyV05pbEtiR1lYdTNBbUt5OXV0enpXcU1tZzVsU0VZanha?=
 =?utf-8?B?aDM2dC9pSzUvT1BoMkJJM0k3WGNsRXIyaERlbmRLbkhzeFdhNW13TC9hQ1B1?=
 =?utf-8?B?NUR3cXo1ZmMwdjlUYzhmV2xGWDFqcUZrbE1YM2lkdm11Mm1RQkxYZXhrMUtK?=
 =?utf-8?B?TDhkWVJXVW4xZ3dYTzFrTHpyYVlnTFV2UHJwaHk1TGxhSGRZMzVHaVlKTjZp?=
 =?utf-8?B?N0UzMVZnMVY1SUFzVE1jR2MwaWdJanJGM1hIdHd5UUEyd1JUUmozUnNVbFR1?=
 =?utf-8?B?VzNVQlkvK1dvMm52YlIxM0c4YUN2NFFQbVBhalAzNExjS25OSVNNdE4rU0lZ?=
 =?utf-8?B?R0xKVHFmKzVQZmNLeXVWSkprdFl5S1lDdVp5RDhQQTFZNFNCNld3bkdkSTdi?=
 =?utf-8?B?bHNjR1JCeXYxZ1pCM2I2dFJ4cDZGRzd4c2VsMVgwekdONXpYWkV4ZUwyWEl1?=
 =?utf-8?B?TThNYlhBRFhNcU1VMDdrQTZRL09qRXlvUm8zSnR1ekd1T0tZT2lSZ3lhU1F4?=
 =?utf-8?B?clFuT2pNRDBIdnQxK3VaWGM1SGNOMUlEYllzVlREZFI0bmRRaXRhNUZvR0Rn?=
 =?utf-8?Q?eMX2e1ovKfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWEvSnhlTEJjUUpIYURPWnhoNHBBRHJiamRsS21WWWNZbmN5dk1YVWJHRTNj?=
 =?utf-8?B?YkpqNjlHdmpZNitrZnJDMkR4WUVQZFJQbGUrdG1WUHBXQ2JVWGNRNVJFMXdn?=
 =?utf-8?B?RUs0cU1UcU5oUW1JcVZLNWs1Y2ZUZnNhTWZVYmh3K0tBZGh6NHBtMFBueGcv?=
 =?utf-8?B?THVhTnRIODBRMkJFVXdZb3FMdWlBODJ6OTZSRkhrSHJLUURuZHhmNGkyeWhV?=
 =?utf-8?B?RE5KOEIrSFk4TmlJa0JWZklxWnVCcDAvUUprYkdJQ1lkTWJIT3JCYm5MVytB?=
 =?utf-8?B?NE9YVzRqbWZyUzNVdTNINGh5WDllbnhkRUFPZTljT1hGN1FVUXZhTnZGK1Zs?=
 =?utf-8?B?aXpMMklwdFlRK3RJRFRNdlZvTE5YL1RsYk5xMmwxRFhqb2d0R2JScE02SXVG?=
 =?utf-8?B?UU1FK2FsaDhxeElmcE41MXVNYVBQRVEyUVJUOEtuN2h1a2diZ1llUFBtTEdX?=
 =?utf-8?B?UEdFSnBaV25DOEZBY0tpSG4wUm1ydy9LSlU0MW44Q2lHNVExMGw0T2Y2N0xa?=
 =?utf-8?B?SDVqckhNUDNTTEFHY0VxSE15T2l4T3hMa3JtaUhobmhkYXdLTGU4dVBaamdK?=
 =?utf-8?B?b05Ocy9hckxDS1lJblZKL3VaUVNnVHlUVk1ONldvc0RFU1c4MUd3T2JxWm5u?=
 =?utf-8?B?Vmp6ZU9XcmJ3d1RpbTEwV2N2UDArSzVUblhjbFhCTDgyaEQ1OXYrSkZuS1Vp?=
 =?utf-8?B?NGo3VjRaN0hXc3BHWVJUQ2hkMnlFSk5maHJjbHNqSVc3V1cxM0RpdUhmaHRQ?=
 =?utf-8?B?SFVTaVN1cFYxb1gvRnpQVXN3ano0bjgrdFZ1ZzlLdU8rSlRlQnF6RHFTSzJq?=
 =?utf-8?B?cm5mUTBRMlJURDQydy82SSs1UjJ0SjhleXZ2OGI3cEJjeVovb09SWVEyN2tX?=
 =?utf-8?B?Snc2NGRqeEpwMk15amxRN0ZBVUlINFVqSFJwZWRpSXJFNDBGVm1zVFpnZjNM?=
 =?utf-8?B?VmRDSGZMYTlHOHNrWkhkbGZjOE5KMUExUlYvTmlaYVUrVjEyeFFOMkptanFz?=
 =?utf-8?B?N0N3dFkyeE40bEFXTTB3ME1LNGk0cnVHV3dCSEYxTmhDMjlXWnZXYUVzcU5J?=
 =?utf-8?B?RFlxNlAxZ01uYkdhbGV4RXNHQ1JBQ0JsUm1qbzUvRXgweEVxU3J5MWJiRS9G?=
 =?utf-8?B?S0VkVlJXVEQ0S1BRMXhZQ1g0bmRoc1c5bi9Jd2NSNlR0TGsvN2dCYkFmbFp2?=
 =?utf-8?B?dmsybkhrRWQ4NytjcmRjTGV2NXNSbGJKT3R4S3pnV1d4SVZTUm8rVmNTcTVw?=
 =?utf-8?B?eUs4enVrd21mNUpneE5mc0FSakJRMUxFcVM0NnlnQ2dtZVZCYmoyV0JLbWdN?=
 =?utf-8?B?d1lJbTQzUGVsbGZPUVlBY1c4Ri9GUDJtaElZVk13emZMK0JmMnpGa0p5WXBm?=
 =?utf-8?B?VzQzczNPdkhXcCtsR3phMTRCQk9saGtZZCsvYlpzdHBrcVlWYnUxUm0xWC9i?=
 =?utf-8?B?cFVncENtNW1xRzdrRjh2U25QTit0Y2tVMUFiRzMzNHBFYjhZdEljbzhTTDM1?=
 =?utf-8?B?VkZleklHdW03VmZvTG1hQVhvSzZSdm5Xd0J5U1FhSjZHYnZkaTZ5RXAybGpv?=
 =?utf-8?B?d0s0cHFmcDFRYW5YQi9UZWErVXhUQitlc0V1UkVPdmtYOE94VXMvU0xPNTUw?=
 =?utf-8?B?WWtkYXRHNVJJRC9pTUpxdWdDQXo4RDY4QnN3ZzFPR1JqNHZBTmhVTlp5bWJV?=
 =?utf-8?B?OTQ2SmNWdXd4Sll0eDNxZGlZclh1ZDEvaWVydHZDdXhhWE02eDdzWnN6bGhj?=
 =?utf-8?B?UnZmS1J4TGQyZGp0S0ZvT3ErQU5oWTVWa2YzZk56K1Q3TDZFbFlxSEFhZEVY?=
 =?utf-8?B?blJXTkJZYzdjSm1NOWRlQUx1Wi9mODZYcjdSTlE5aU9acThka0VKMFV3emdw?=
 =?utf-8?B?VGh1VXc4M1VhKzFiVnoxNC83dzdDK1d5T25UVzI5V3BEUk45QUptTnNRK0dH?=
 =?utf-8?B?T2tTN0tNZjQ5eVdmMFREdnNQTkxucFZDM1h4c0NWeklBWDB5ZDg4MG9renhN?=
 =?utf-8?B?bFN1OUVwTzk5WVdNOWJFQXRsQXNiaXFQYkpNR1VVN2h6d0RkVVdrdnJqVXZR?=
 =?utf-8?B?TWdpeU5XNzlMOENhOERsNHVEWXZ0YnlsSlRFUmFwTE5CWU1hcmUvMGxXckkw?=
 =?utf-8?Q?KlXR09OCFvuMccSBg+6t3j2NK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d6d376-ea6d-4f85-4fb5-08ddfb6519c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:23:00.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HMBFDVD71Np6cYT5W9/qAuy9+/ySAMPCPfcGFVxoTDHswhCXj+hY/6BU6pFsGU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 24.09.25 13:00, Danilo Krummrich wrote:
> On Tue Sep 23, 2025 at 2:33 PM CEST, Christian König wrote:
>> On 23.09.25 14:08, Philipp Stanner wrote:
>>> You know folks, situations like that are why we want to strongly
>>> discourage accessing another API's struct members directly. There is no
>>> API contract for them.
> 
> Indeed, please don't peek API internals. If you need additional functionality,
> please send a patch adding a supported API for the component instead.
> 
> Drivers messing with component internals makes impossible to maintain them in
> the long term.
> 
>>> And a proper API function rarely changes its interface, and if it does,
>>> it's easy to find for the contributor where drivers need to be
>>> adjusted. If we were all following that rule, you wouldn't even have to
>>> bother with patches #1 and #2.
>>>
>>> That said, I see two proper solutions for your problem:
>>>
>>>    A. amdgpu is the one stopping the entities anyways, isn't it? It
>>>       knows which entities it has killed. So that information could be
>>>       stored in struct amdgpu_vm.
>>
>> No, it's the scheduler which decides when entities are stopped.
> 
> Can you please show me the code where the scheduler calls any of
> drm_sched_entity_fini(), drm_sched_entity_flush(), drm_sched_entity_destroy()?

It's this code here in drm_sched_entity_flush() which decides if an entity should be killed or not:

        /* For a killed process disallow further enqueueing of jobs. */
        last_user = cmpxchg(&entity->last_user, current->group_leader, NULL);
        if ((!last_user || last_user == current->group_leader) &&
            (current->flags & PF_EXITING) && (current->exit_code == SIGKILL))
                drm_sched_entity_kill(entity);

Regards,
Christian.


> 
> Or are you referring the broken hack in drm_sched_fini() (introduced by commit
> c61cdbdbffc1 ("drm/scheduler: Fix hang when sched_entity released")) where it is
> just ignored that we need to take the entity lock as well, because it
> inconviniently would lead to lock inversion?
> 
> 	spin_lock(&rq->lock);
> 	list_for_each_entry(s_entity, &rq->entities, list)
> 	        /*
> 	         * Prevents reinsertion and marks job_queue as idle,
> 	         * it will be removed from the rq in drm_sched_entity_fini()
> 	         * eventually
> 	         */
> 	        s_entity->stopped = true;
> 	spin_unlock(&rq->lock);
> 
> The patch description that introduced the hack says:
> 
> 	If scheduler is already stopped by the time sched_entity
> 	is released and entity's job_queue not empty I encountred
> 	a hang in drm_sched_entity_flush.
> 
> But this sounds to me as if amdgpu simply doesn't implement the correct shutdown
> ordering. Why do nouveau, Xe and other drivers don't have this problem? Why do
> we need to solve it in the scheduler instead?
> 
> Maybe there are reasonable answers to that. And assuming there are, it still
> isn't a justification for building on top of a broken workaround. :(


