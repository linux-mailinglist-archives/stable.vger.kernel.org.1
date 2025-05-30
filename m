Return-Path: <stable+bounces-148160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194FFAC8D52
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135797A234C
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED80226CE7;
	Fri, 30 May 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7H+kTNx"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31421CA1C
	for <stable@vger.kernel.org>; Fri, 30 May 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606926; cv=fail; b=CjM6w9/yhHMIDbhlwOgM6jyfyT4Gk5p9m6/tabPe00W+ntc6jEWKp2U3ceGDfKdkr8yjDkDRAxzw1ujdL9GuItEu3Tl76diJ+KQP3w00s0MxqPyLpMKyo+gpnQg/U8R9NJhvI+UjV20cDS1QGO6XakFnDTBnAalJkKshS1k43GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606926; c=relaxed/simple;
	bh=hgQYKjuys0R37MkxYxzUQvorIXnCeIXijYpG5hXkoFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xfp+6uvhMbIiXyuatFLOQI2rcjUxFdzkw1/5/Js/3IftYX18sbVIcPq5ApxBtvXGXELbYu7i2f0LIhSeZ8medlnKmjEz5CyUfkFDAqOeBJ5Zoh+XDm/lYp+PbEmYqt8LE09748nlwQ2JN3gII3GlOJ85PA4flxgWLmIJt3ZCclE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7H+kTNx; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYrHfOhiXNKZmasDu/XkWUlRGsmy6T6OgtP8G+R+TGv27enVYp0EjtwCeyhNhFES30NJmWywyYiZ9vqvU+nWwVavbjb7p7myxIFtd1zCNwMqhwZRQm0k9v3Hy/3oxtlci5bPrynxa+RUKT2j4YpAGpBwBUiYaF5MiVlwOtQoL0J49Sm5CZSv83krVwrBQQdiCv0nYPbdL6EvF+CB0uQDPINW2R5cIizBqA3OtEdZIgP2r2sKE7CRJrc4dVLnF65EOh35JbQRnxwKKk4Rh5PYBcAMahA+Dv7eWFSHACA/c3pk8SAaX1CurZY5wuDUjOkzChZx7ZkB/ojtsOf11Wgkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlWWSvCCpaROliNFagGEFLgP5HJ+FvKsriBm1lWGrVQ=;
 b=LQwsV5lQhhEXObaaKcJNCPC7/Zxh5QqHyovlgdFDj8cJ+A2CE+F2weS6n0RouCM33hVlY0jvTaYqFiNfIPV+KNlUM3JNNrfGxofOPrBFIA0i0bPzCbhJkm6py2Z1HJIC3Canp6dTaEwkE5J8wIcEOB/vHZB1WfbRJq5vQDLjPGGrgQo1TNO7nSViIiOw1ADsulmTay1F3rhtXkOVmDe08ZHF+7GhEUW2CQVXGq+slS99ZAEr/lwSt9agvbr4kmuFPEVhfZH77w9z2Q1rTakfxkuTW3v933nJJv0F3DjTRkFSpeSEKnMFdGdNYJBOakJnGYvI2BbC4wDnNorllwU0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlWWSvCCpaROliNFagGEFLgP5HJ+FvKsriBm1lWGrVQ=;
 b=t7H+kTNxBTe+HLXSGdJ9FeGUbk4gB8NigTEnn6r23EYM4EvUWdx0LZUDj+2rdHE32znJWeTCZooEmNDHtMNgCFXcIDb0PFCrRNjJUJIUe+hUyLX0CRMVgyX9V2Q/r2Jrw0/64dX6cP73B+S1179Hbu3XUwsfKgwND6hG0l5/KlvCmePkK+i8iZBlvctZEVjzgHZHHNjyuYWUvNPM2f5llIAo/fJ8VhAm/pxUeXN/mWd4K4cG8/bSKKQLOo26g97amrkMuAztCtfGq3rm740729Wc6D600RV8cIUG3AoWgOmYVmlFQvsUXzgVS0Xlm+onCnJCNCpQltvfNdEe0srP6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 12:08:41 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 12:08:41 +0000
Message-ID: <db802f71-7eed-46b1-afcc-aa926f1a1bd4@nvidia.com>
Date: Fri, 30 May 2025 22:08:35 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of
 device private pages" failed to apply to 5.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alexander.deucher@amd.com,
 brgerst@gmail.com, christian.koenig@amd.com, hch@lst.de, hpa@zytor.com,
 jgross@suse.com, mingo@kernel.org, pierre-eric.pelloux-prayer@amd.com,
 simona@ffwll.ch, spasswolf@web.de, torvalds@linux-foundation.org,
 stable@vger.kernel.org
References: <2025052750-fondness-revocable-a23b@gregkh>
 <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
 <300d265c-ff6c-4e01-a841-e8925e5d6d3b@nvidia.com>
 <2025053035-prison-lagged-0a17@gregkh>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <2025053035-prison-lagged-0a17@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6438ea5f-de76-4b93-0ec5-08dd9f72b7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGp2ajVocnk1R3JhbTI5RUtSRlpQNExvM1FVQmNSSE1ialVORlhUNk90bU11?=
 =?utf-8?B?emZhT0hqYmtTV0JuRTZUTlVyVGh3S1dIeWhMUkh6ODZYbUJIemR3Vm01NHZw?=
 =?utf-8?B?NTRyVjlUMTlRMEdyL1FtM25lZzBHZU1FN3BPQ1NEK3JCeVZWNjRQOWxyeXh3?=
 =?utf-8?B?R0xvSW1LeldNeTl4d2pxTmN3N1JDV2RaNTFMbk1rTjlob0p6Q1pHMGttOHJr?=
 =?utf-8?B?OS9PRTBvWjFNZmcyT0FjdUZkZnZjSk9LUGxwSDhnbDBsMmtDaUZsVkcxeG1p?=
 =?utf-8?B?bUVyeGJibFVkeE5CY1JhYUZhYmdQWHYra0o5YmNOcTlHbDhLOXpxMVF1WUpr?=
 =?utf-8?B?NFJiWE1NcEFua29ramRZQWh3UFFWZGlhakFIQnkxVEw4bmlzdlZtV29XV3Ni?=
 =?utf-8?B?RkRaY3RLTkc5RWJXeDRaY056WXgvdThJdXdKMm5RNGdHK3lBN2VlKzJwRjJ0?=
 =?utf-8?B?TTVvdjFGRnJCY3FyR0FNZ1lsTmcrbzFFMktZREZrNTN4eVhzSEdtNEdsaWVk?=
 =?utf-8?B?eDVLQjRsb3NMeUJuWTZXZmR5VW9jM05ZKzQ3YnZoKzQwUWNkQWtMMjBxMkti?=
 =?utf-8?B?QXdmbHMrV3lXczhkKzVvcmhXNjJHcjFiTU0wUVNVWjROT2UzODdGYThEamh5?=
 =?utf-8?B?WWFMRU5zMTRWVzNFVFVBNEJTVlIzVXdoZDV4U3c5TkNVZEJjMkdUUGxCZmVK?=
 =?utf-8?B?SzFkRFEwUjc5THQ3V2NWSmhmay9QRFVqSGZ0NDBoNE1tamk3SS92VnZoQjgw?=
 =?utf-8?B?cHVEVEJZUUZoVm52UjExVmxXcUZrQzk5UjhZY3I5Y1c2SEJnSTNKdnQwckxS?=
 =?utf-8?B?cDlhcjl0eHpzWkhKbStYcDIvd01mYit0TkFDcVZQS1d3bVMyOUtnaVhFci9I?=
 =?utf-8?B?UnFRT0l3c21wRk9YbVhCMm42c0tvYVM3Y1ZneGVobmdvdHlzRnoyTTh3dm1n?=
 =?utf-8?B?UVJaYjNBN0lLa01tZVlQWGJXMmdrMXZFQVN2czhYaE05K1Z0VVl5bitNS2pH?=
 =?utf-8?B?NlRFdk9Lb29ZbjNyL1E0RkpVWUltWDhLaUFPL2ZZa1J2MUk1NVNjL2FRVkNS?=
 =?utf-8?B?MFRHa0ZvcGRIdnlFNXlTQ0xOZVdUUVpERVZ5QzNKVkozYy9FK3g1a1VaUVRa?=
 =?utf-8?B?djBua1JYQlBDMUIwSTNuUGVPRTdjbmpibnphcmNlUmhFWi85RjhWdFpOeFlk?=
 =?utf-8?B?MWc3djFmZkZ3c3dzbzhqWVUzeFhVTmVNTGlVZ0UyN2xEYjRHSnc1MXZHUEkx?=
 =?utf-8?B?b2U4YjhvSEtKVlNEMTJDb0grWFoyVWNPb2ViZTQ0R04rekpPbmdmbk5zRmFG?=
 =?utf-8?B?b3pWNFliSzhFZTdlNDlUdTkrc0pBdEhlQk5PY1pXYkMyQWNCT3hIdm05Vm1m?=
 =?utf-8?B?VDJ2VHEyeXU0SE5HTmZVSUFEdWxYaVZybHBwclFZdXN2dnRDR0NRWmcrMGNj?=
 =?utf-8?B?QXltaTdWejY3b0grcW1FRmUreGlyOWRzUVlPUU9wUEY1ckllYzkwRHBIcVl0?=
 =?utf-8?B?RnZWT0RnOHBvZTRtZ1Z6M1dVYzN0UzF4aVFJbEk0cFlvL3dUMU1WOHIyZkRX?=
 =?utf-8?B?S21Md1JBUEhjMHNHUnZyeHdlK3NWNzJVY21QRGtGNUZyR2ZiWnNkbGQxUHZU?=
 =?utf-8?B?MGp4c3p3d2thZGVyU3pPQzR2YTJiSGFEUGtzdkM4RGUvNTRFbzdneHBkNity?=
 =?utf-8?B?SkNiNnliSFpncmpqdHJvV0xFNmltNXJ4a3VmRHdZWGoya0xkZ29hK0dzS25O?=
 =?utf-8?B?VGQyL05sV3V4QTNPd3lNTFJWcWRjamVtS0RMaG1LZVFRa0ZXMjREeVcveHl0?=
 =?utf-8?B?M3R3VHRSYm9KVzRTN1VncGEvOTA2Rko2Wm0wUmRvSzFEby9ReDc5YkhWanJG?=
 =?utf-8?B?OXptRU9UeGlPNTlxL0FNUzVxZFVuMGJGbTh6V2o0aWVtS24wMXNGeTBUVDBT?=
 =?utf-8?Q?VXstr/gITjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEc1ZDJXT1NTMkkrNm5Nam9iMEpvSGdLWFJ4dVNtdHo5TGJIckFqMDhpREJh?=
 =?utf-8?B?eXE4b1U0bndSMGs1cndGRG5JRzErNmNZaVg5MGFFT2JrNm8zV04yTWZaVmc4?=
 =?utf-8?B?dXVUbk91cU9zZk05TnBQUm04WFdPalBDS1RWSm11bTM1N3VURHhtSEtudWNh?=
 =?utf-8?B?UnVFdXk3N21XY29CYUZzTENabWxKaUZqc0QzbnI0V3lQRWoxMWxNVCtjTlRV?=
 =?utf-8?B?SUhOdHorSS91RzZNc0IrYTk2OW5ZRU1MWGlmTGYvSmkzNWdESjBxUnc1clVV?=
 =?utf-8?B?aW02U0N4aTVpL1dxbE94NmIraVAxcWRkTWEwZ3hXdU94Y1pUN3dicm1KU2hs?=
 =?utf-8?B?OXBFcUUwTEZibFhyTmNrSlhCeW5kV2djRk1Ha0xUQlIrVS80R0ZyUEhKNldE?=
 =?utf-8?B?Rk1HekpFbFpvb1hCb0NYY2hiWncwaDJVbERpdC8wT2pKZ3Y4WlNZZ3lHRGs1?=
 =?utf-8?B?eFZaZmN3WDc5NHg0ODd5QkhrOFNRS2NZMzZsSUZhMUZ2WTVnZTlkTkNUK3BC?=
 =?utf-8?B?U0QzeXh1ajQ4ZENYTC9ERXRrVmx1RHpJQVVYSHBITW9HYWx0Z3JOKy9uelRr?=
 =?utf-8?B?WUhpV01mNXZyc0dZd1VaSUJWMUFVUUF5S0JKVkdib0dWUUVuZzVlQjZQaFNW?=
 =?utf-8?B?Y3JyQ3FMVmIvWS9aM1NBOFdleDU5bEp6QW5oRWxmRWxSZVdscTI1UExnYU41?=
 =?utf-8?B?aGxMOG1XWFhOUXBJR0xUWU40d0hQZ0VIaUJwdDA5eDdsQUZzSHo3YUV4a1NH?=
 =?utf-8?B?UktsUUpQRnhLb0FPUVRHRS9DcDBjZHBLRnNyaitwTXE1Y0RSL3BLd3BrZWdD?=
 =?utf-8?B?ZFVHSEJVVWVudGRRRnVMNjF3eHJjOVhJYzlFSHhMVDlBMERPOTU1RjhtTlY0?=
 =?utf-8?B?MkRMcUtzeTRDZEMvekFLMllMV0JDVVYwOThNUm16LzVaL0dTVEU0QVJpQmpF?=
 =?utf-8?B?SlZxekZpOWlBaUlWTWFNRFF0TkEyK2h6SWZFbDJBeVRJVlF3dHYzNHRxM1N2?=
 =?utf-8?B?aE5IenVSbW93cG5TaU1seE5vOU50bHB6aVpPcGZreGdPNkhSa3lRMmtxK0h1?=
 =?utf-8?B?ZC9XZTFQVHNEUjd4RXZ3ckYyVncvVXo5OTZoU1BHV2dWRTZQcU1jeHdJUXZF?=
 =?utf-8?B?cFo3KzN0NktVTjlidE9ndUFneGpPZGhqdTIyWXJtNGNMTVFwYlI2SFQ5K1Qy?=
 =?utf-8?B?ZVZNS1B4UVBhdGV3SGg1cENkL3I5MHhRcWExdDR2L005ZEtoQkpxZDBMcUw3?=
 =?utf-8?B?S3EzYWt4cEd0bUVCTlhBaWNUOW5MSjdrazBuUWxxVzNiOXJiVHBKbHFZRlZz?=
 =?utf-8?B?QTh5WGU1bTRYakFkb3FYY0tSclppUjBHb1Fpd3IzdzhuTlNERG9rUG1zam9w?=
 =?utf-8?B?NXRBRVMzcElwT2FORkI5RHp0V0hxZUFxU0JBcWluYjZjM3dCMmNNZTBzTTBE?=
 =?utf-8?B?UEo2UHhFVjRJdDdTS0VjRGxNM2FWQnpocnY3dW5RWkRlejFEWGEzNE9RYVlv?=
 =?utf-8?B?N1hHdnZQVm5lOFZXWXZLL01hd0hGbENIVlp0akpkeUpBWUEzTzQ0MEpmT1Fx?=
 =?utf-8?B?ejRHbHZKUUo0LysrZ3NnMVZUSFFSRkJWTm4yNDBkZS9WV3V1bVYySFVhdXNO?=
 =?utf-8?B?by9GY3hzVmRrM1AvMTBnSHdSazR6VHdOLytsaXJqdlo3Szl1OWRmaGt4ZUhx?=
 =?utf-8?B?Y2NHenlVd1A3UTN0L2NIeExuc21jeUpzZE43YmZRWHplRmxERTBZa0Y2VzBj?=
 =?utf-8?B?bHdSdlpTNUVvZzRSZnk5S3JxdG5Ta0FzK01aOCtBanh0OUZFUFpzVjl3UXhx?=
 =?utf-8?B?V21FRnEvc3IrRjdYd2RRcTlDbzhnb2ozYTI3ckoxbnBkd1pMaXdDTmJyeUt1?=
 =?utf-8?B?NUYwOUxKK0F6UjF6cXFCdml3VzBCTklhN3dmMmU0MzZKMG94S2pEMkRZU05H?=
 =?utf-8?B?c01vajh3V1dVU1loSElWTG9nS1ZvRE5uT3VYZ2ZVVWJxdERUYWlrM2cvL01z?=
 =?utf-8?B?cFNBdGkrQTcyM29wTTFjTldJQnRXTHhSNnlTL3JjVGYwMTZtVmNIT2ZYOEw0?=
 =?utf-8?B?OVNNRGpJbVdvc0RFR3RnKzBMNVhaNjEyS1BmOGNvc2FiWVNHYWRNTFlQZzdU?=
 =?utf-8?Q?F/f/q0vGiIOV+ujWUMqnHW3SS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6438ea5f-de76-4b93-0ec5-08dd9f72b7a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 12:08:41.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un1Ol2xvQI3uwElriiLObn+iA9TfH4cZFnaIquHQv9BA6Vp1vCfrOVYavSBtblQhkmZVmwsUG30DIBUgr4IwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On 5/30/25 21:59, Greg KH wrote:
> On Fri, May 30, 2025 at 07:54:32PM +1000, Balbir Singh wrote:
>> On 5/28/25 08:59, Balbir Singh wrote:
>>> On 5/28/25 02:55, gregkh@linuxfoundation.org wrote:
>>>>
>>>> The patch below does not apply to the 5.15-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>>
>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
>>>> # <resolve conflicts, build, test, etc.>
>>>> git commit -s
>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>>>
>>>> Possible dependencies:
>>>>
>>>>
>>>
>>> We only need it if 7ffb791423c7 gets backported. I can take a look and see if we need the patch and why the application of the patch failed
>>>
>>> Balbir
>>>
>>
>> Hi, Greg
>>
>> FYI: I was able to cherry pick 7170130e4c72ce0caa0cb42a1627c635cc262821 on top of
>> 5.15.y (5.15.184) on my machine
>>
>> I ran the steps below
>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
>>
>> I saw no conflicts. Am I missing something?
> 
> Did you test build it as the instructions above asked you to do?
> 
> Try it and see what happens :)

I stopped after cherry-pick, I thought the patch failed to apply as in cherry-pick failed :)
So I did not try and build it. 

Balbir Singh


