Return-Path: <stable+bounces-160339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C486AFAC96
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF261AA041D
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324C199939;
	Mon,  7 Jul 2025 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E9fkbdoT"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D0249F9
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871631; cv=fail; b=ZalXfxIpI3a/ZfGZYaj135rkt/i+rDWYYkE6Ab3ui0gVDgZTTCEsvfhhmyLH63G48u/9OXhtmWq43O51BA6OtdOSzHKUDeMKmMcFsHsUZlECya9GHTXpKDqceEGIguSuol7rgWlB7Yj9QuuFl+QOMwdz3wROUx9+MqPZpa9hdjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871631; c=relaxed/simple;
	bh=BVn0FDW66qPvN0LYMayHctZkspVR6JeGEh1/Ja1QBuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lddTvJ+SVztRZsmi7QAa+wH3EtA8qjyEGBdX5SMPfBYnoiGGuQTGZ6vgKEEizMyS8HXs2CgSfUbPCaX79WbVP1Ct85BNWvgyLzeXeVeX6utOolDFNGCPyT2Kfeq+6+owV4WWEX62Ku37tuWw/nPxvTpIzqWZzdlGWXvqSd7s6oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E9fkbdoT; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj5ea7v8V2UxzSpeKKxfVvIEjaZCapRg8L0JJbfM/4f89SaXB0y+zhPmtdm3OBr6ZiZ6R5JQmF3x7meSoLI4qyNfnNVMyoG1H5/eex6Ww1o+vx+0ruyC9tQdS3izy+pl2e+TlTdO+QdulOw0c/UDqUQJ0x4q5Hw6TcuA+8Hk+bwEbN63z2RT4CnXj4vImUuJ/B7/7cLIjiE2E2t7/XsPSbRpklsVJ2wUZ5HYiqgIqLJMT5ruXxIUjCM93v8zT7Ns4F9cPmHKT9D+AlSf5CCytoBSf9spRAkH4YYJokd7pHBPvGCTiundd6TID6UbobXgwSrTy1Rg/y9jxxVW8kdi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLn2zh28gYM4FkOSM46jwuMBDvKO7xwEDWq3WmMM+q8=;
 b=p9YFDOtgr4j36H1Rprmo0nHeldasUJk2+PBMnOrm6n+tYH2DHlRoE33uBPdIvbtekdNroFjlEb4KeZjvFZcddkDPk3kp70obbEAusdJiwjBLImgoiTVF23OWNRS7JIEi3crOUYvNEDWx83BaWzViF6FoiGm23bMK9g2JNrFuqNjhdYGyHuZ774WHNZXj91SOb8XvdrVMPqWYrFvjQX9QtYphlCgeXZzT4h2veOh2MkYY7sIxsXDSf4YuI1U/dOU76NkFedvasBzUtuqtflRQbPfbVuxxdPtdxqKomLS3u5fo1DdRoiuHH6yyaG8bGBaBuegYWMT5GcXQ4Njcv7HOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLn2zh28gYM4FkOSM46jwuMBDvKO7xwEDWq3WmMM+q8=;
 b=E9fkbdoT/o2B1sfNTf6tFTokBmZNMwJ7QybG1B/gPjqlZkCwlriDi8DpNo0rJkGBt9HzwPU5EoAwg1IL4ji/TJXqN/ByMcfN1HdL+tdIjVcs5cPp/CWF4Hfxci868wEVtwl7cGP8DZsBfVDvssMkOgBh5pIGNLCgCF8e1YQ7Hfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 07:00:26 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:00:26 +0000
Message-ID: <3d2a2121-4a5d-445f-8db0-8f1850a72769@amd.com>
Date: Mon, 7 Jul 2025 02:00:24 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=
 <zilvinas@natrix.lt>, Borislav Petkov <bp@alien8.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
 <2025070258-panic-unaligned-0dee@gregkh>
 <8b274e68-29e4-436a-9bb1-457653edaa2e@amd.com>
 <2025070319-oyster-unpinned-ec29@gregkh>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <2025070319-oyster-unpinned-ec29@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::8) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1c67ab-2c5c-4568-b28c-08ddbd23f374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1RxRGhnT0V2dFhveXJVVnIxbDVaUVlzUXpyTlhFU1M0VGNxMi9DYzN4UzFO?=
 =?utf-8?B?aWlCeTZCRmRCZXBZSWJZQ0RhcHpONElGaGMvSDMycUNhZWhzTFU2clhvcDlH?=
 =?utf-8?B?ZEdvSVh0bXJVNjcybTYwVGxUZWFjUFNSU1JCU1lYSE0ycWNTQ3BUOXpZZk9F?=
 =?utf-8?B?aGM5aUdBaEFMeW90aHhhWmZKNDJYVFdEVlExdjlET2xjanZoU2tSdXZ1OEZq?=
 =?utf-8?B?bmFmUHVZU1JKeUpiY3RpQWNKRTRGS1F5Q2RJTXd1RUh4Ym10YzBXOTd0MmxL?=
 =?utf-8?B?MHkzZEpDQUxFYWtPdEpDUFUxOU92WEt2Y1g3OHl2RDhZWHdmWngyTVplcUVx?=
 =?utf-8?B?SGdnVVMySEY3b05oUmowYzNNYkVBMDd1YnVsQkNuQXZVcUZVN0xPd0VnZmZv?=
 =?utf-8?B?T1RJNlFtME9ZQWUvWE55dVpmZm1nQVhLcExKQ29hVG1iRjFPY0RkL2dxYUlH?=
 =?utf-8?B?YUJqcVdLZWx6SlRkc1l6WW9pdWNGV2Fib2FWNUdsUHEvZWxCT0tZdHpvQUV0?=
 =?utf-8?B?MHVhQjYxYzBNTWxsOVJrYTIyYXlaVk8zSUxpeGxFR0E5VjFiNWdMeWt3OHdC?=
 =?utf-8?B?STBkMlBodFhNeWIzY0FIaVNFSHMrTi9qOVpnSGxVeEp1Tk5YcjdQT215aG5P?=
 =?utf-8?B?enRZSEErZGRMTHd4SGtkeVJwa3dFU0VVU3hPeVVxZ01kWnc3R2ZxRDh6YTJ6?=
 =?utf-8?B?QjNxemhLeWxFb0I1SXd4NDRHYTRxVUQzYzUvTWErMHRVd1JmaTgwRkxNTGJ5?=
 =?utf-8?B?c2lpbkZlWjltclBOZXpiMEVhLzhJZm9zVFozdUEzSHp3QzZIYnhRazNvMWI1?=
 =?utf-8?B?N3dDbVh2NXdxSG1mcjNNTkM1cDlCTHFwZDVlQjZWRVlzaTRteTgyanFSK1BW?=
 =?utf-8?B?ZlNQN0tJckxpb1JESVdoVnltVk1lNkh4bGJ4MnZyTTN1NDVaR0Y5cnhhR2tq?=
 =?utf-8?B?dWlWcmFZUElzRWc4V1pzNnA0TWhpRlZnUnpHOTZGRThKRFEwQm5JQmU4Znl4?=
 =?utf-8?B?eEEwR1V0bzV3NkgyN09IcE9aV1RadFBNazdmSENOOG9rRHFGbWJuaXp3aUMz?=
 =?utf-8?B?YUtVc01EdmNIZ3pIeVQxdWFGSm9NM3FvK29RSUpROCtIaDBMNHFQNml0UTIz?=
 =?utf-8?B?NlBSQWhPb2dXYjRhK2hwN1BaVUc4UWEwdzNidVIxN0ZMRTlwQ0Rib05jcXpt?=
 =?utf-8?B?THk0K1lmdm5hWEZEU1h1VFFRMWM0VnN0Z0NMMld2MktmZVdwOE43NUZTYVRk?=
 =?utf-8?B?c1o0S2E4b1JsOE5mUWpzbHBMbkJYdmlyaWcvenFzOHc1ajVxTkM0N2N4S25V?=
 =?utf-8?B?bWE4RHZLaDQyQ2FmeDBQOGJGMG1nSkZENFpuVzRnY0FxY3hyVkJGd21JWTRQ?=
 =?utf-8?B?VkFlZWVSbHNGTGhKYTVOQUxZL3FQWnlPNlBoay9LRDZhM3RuK2J6dXJYSU95?=
 =?utf-8?B?b25GcWgycVdjTUtUNXJ6dFJiWHE0ak5QTmV1ZDFyV1FvS0Fvd2ZCTEEwRTZy?=
 =?utf-8?B?YnJZbEEySGZNTEhGSy9YcHFRdmlsWmErRVp0WGY3ZXZjTTVwQUJOMEhyejcv?=
 =?utf-8?B?Z1orVTVmR1RVK3pIbnBqY1hXRXpjakttRyt2WmwrMVdkOGhnbTRjbHpmR2Vk?=
 =?utf-8?B?TVd1MlpVMjROSGlMRjVSeWpSU2FzNUxnQjRlL2YxNklLZi8xbkxnL2FSSTdX?=
 =?utf-8?B?bXJsYmdTNUdnVE56T2FiNWhLVnA5QlcrRi9NNzQ0and0RUQzdi9BZnlpVDZt?=
 =?utf-8?B?LzFCbko1cDhucXk2a3NrcENOQXh0cWxHQVU4RktzYmVOTkc4aUpBRnZOQm5y?=
 =?utf-8?B?TDhraVluODJzSDRuUWdkV2x3TG1FQU5EZTc4MzFXaitLd1BUZ2tvZjNBckRP?=
 =?utf-8?B?NHpzb0pGM1VoOW1vTlJMSjVtOFhCbDdJRHN0c1VsdkhXMnh4c1diSjBNa3lw?=
 =?utf-8?Q?SxT+TKe2Emg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhaaldQSWZDK0ZxRmhabGJFcUJuUlN5SXlNeG1vK2ZiT3o5Z1V2WkFTQ3hB?=
 =?utf-8?B?M2NMNWgwSk9wQVdOdk1qcFQwZGZ6MHpDa3hTNEZ5Qk1PeVZhREZpcXc0VTN6?=
 =?utf-8?B?YmpvVWF4MlJIb0JOSnlhSE4zdWZZdHRxY1dUdXM5VlR1d214dVZGeTZNYlZu?=
 =?utf-8?B?TmJxZ3REcDllUFFNVHZuVEtucTNOSElHMlZkeGVDeGVSYlRMOGpoVWlRVUZi?=
 =?utf-8?B?Y0lIa0VzWU43eWFhM3BYeXM0VkFNZStSM2NvTnhPNFFJY09oMVYyQnY3dmUw?=
 =?utf-8?B?b0xwcjlWY2oybjE3WlRUZ1RESkNRUmYwbVpJSmN6TXZndENZZ2tsRU0rV2du?=
 =?utf-8?B?amxkQ2F5cWhZUFZqZ3hwUjBzVy9FaVFWa2poOG1Uay9OMHNuSEJGbHBGTmRD?=
 =?utf-8?B?Y3JsNlM5aE9UYUJ0OGpkbjVUS0o1K21PR3dqYUFxMDQvbWNhdThSenFYRDdD?=
 =?utf-8?B?Rkl4SVFVK3d6N3RwUkJNMURVS0NUeWJYRVY0aGt0NXhibEFnekhpWSs5bC9Y?=
 =?utf-8?B?U0NBNEVCRVArell3ZE95U081WnpoNldjUDhXVUViVTNnOHRtS2lGU0NCRUxl?=
 =?utf-8?B?UFpzWnI2QzFzQzVtRTE3amlVS2QxZ2hqdmJKNk4wUnRWcFhSS0x6K002MDl6?=
 =?utf-8?B?Qk0vRXFBanBjeTRsMFlmcmxnT3VEUzRQckZ5R3V3eUpnYWV1OGFPVm1tZzJj?=
 =?utf-8?B?K1NVNFRFeUF4S3NZZ3d5RC8vZ2ZvU1dSbGRWMnNBbW1mdFpDVjUzK2hxbzBX?=
 =?utf-8?B?SmVMbU8vU0h1SXZnbkRhY004SGpOd2UxNWZvSTBGVS8zWHh3VDF4WnU2bEgv?=
 =?utf-8?B?Umg4dHR2L2t6cEFTZE5zM0czNzFPaC8yYzh3dVJjNUplL2Q1bWo5b2lRNzND?=
 =?utf-8?B?eTBNcVRWNFRrUWxVZkhvcWJCSzd4bmVMUW04Ny9Hakk4US91WVN4ZmZCTlhj?=
 =?utf-8?B?Z1Y0N296M25rT0FPc3ozWGtsYjNibVZWSEZOOTZYR283SFYwMFpKL1QwbnYx?=
 =?utf-8?B?ZDlXUUZNVVNhK3hJQ1BxQk1BVy9uaHk0ZGVVRjR1YUJBd1VLRll5QzFkZkFT?=
 =?utf-8?B?dFAxS2pNQWJQSCttTG1vTWJWWWJrUnhBb01jSjdVMXFGbXJPeERHWFFaK2dK?=
 =?utf-8?B?Um9DK3Blc29ZT0NaUjYwbFpyZk5vbU00UVpVUFpLa1ZHanlkUHdZanhsdnd0?=
 =?utf-8?B?YUdONlczSVFpNy9MeGlUSTErZERaODhJenBCSDlBQU5COTk4bVdTRWdXSEpY?=
 =?utf-8?B?WXRlMVdSMEFndG04Ym40VnRxejRCS2tkeC9DekIxUGVjZVZIWW1jSDFWVXFZ?=
 =?utf-8?B?aXE3amJLeGQ0dUVsV0ZNblZuMitxcWhwMUQxYVcxNndVcTJwdkJPY1NDQmF0?=
 =?utf-8?B?dlhyMTFTNGs1dnZ0Ti9WSVpVN054RThsKy9EYjRBcVl5KzZ1b21XZm9sYWFB?=
 =?utf-8?B?Z3A2b0YrdXpIYTZrUHZQNmEyakRXNUpCeDF6T2ZnVHFDTEYybHE5NTVvbjV0?=
 =?utf-8?B?V00xNklrWUJlWllHY1U2aXptMWFVY3REaUFOc2RMY0VEZVVrdlk1eHFBa3FV?=
 =?utf-8?B?U0V1VDNwYUVGc1ZPS1kxZUpPREl4YjY4NHQxZXYrR1EvSHRhZFZ4YThCZXQw?=
 =?utf-8?B?U0FhU0M4d3NQQmNhc1BOMHNlK1dDYU5PRm9sVmhTZElyOU9jMFVmdnZrV1NS?=
 =?utf-8?B?c3dlOVR0M012aGR3WWREWGk1RFRQd3FXT0hKZThUZERMeFZzYnI0UVZIQlFE?=
 =?utf-8?B?czZxeU1SUFc1MVBzYlFIa0NYRXVlLzNKUllUZk1hVkxxS1NCc1UvbDNQYzlE?=
 =?utf-8?B?dUhuQmNWRmM0UGM3bzI0WTFpRlg3QjVTUTBydWNUc2VOMEZaR2k1WXcrMkcr?=
 =?utf-8?B?cWk4dEdmYXQybEJSTWMvSkNWQ09wMHh0bGpMRmU5ZG9QQ0lNd21qZVpGWG9Z?=
 =?utf-8?B?bk80RTJwejhmOWgvVlhJU0o0bGZYSGdVQWgzODRESTducWtPTDF3MkRUcllF?=
 =?utf-8?B?U0NBaVo2R29laWx0UGxCUE5oQnRlNGlBRXdaZlpvM0ZUdlRWMDRMdVFHbVBM?=
 =?utf-8?B?U2lnWDZJeWpWRVNUbnhrNXRJcllrc0dEL1NGUzExMmVyZEtUK0E0c3ppUGdh?=
 =?utf-8?Q?FQFzMeJYn46sfDlT9v92a8Mpt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c67ab-2c5c-4568-b28c-08ddbd23f374
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:00:26.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPh7ftwS9Y/c2ACSWJRQph8kZxSfULRspW3D1MaD8Sm2byjn6DF6GInMCmcBq/+Eo3HXsxnRJslO7m9r3KtyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315



On 7/3/2025 00:28, Greg KH wrote:
> On Wed, Jul 02, 2025 at 12:19:41PM -0500, Naik, Avadhut wrote:
>> Hi,
>>
>> On 7/2/2025 09:31, Greg KH wrote:
>>> On Tue, Jul 01, 2025 at 05:10:32PM +0000, Avadhut Naik wrote:
>>>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
>>>> SOCs has an Address Mask and a Secondary Address Mask register associated with
>>>> it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
>>>> during init using these two registers.
>>>>
>>>> Currently, the module primarily considers only the Address Mask register for
>>>> computing DIMM sizes. The Secondary Address Mask register is only considered
>>>> for odd CS. Additionally, if it has been considered, the Address Mask register
>>>> is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
>>>> total capacity is a power of two (32GB, 64GB, etc), this is not an issue
>>>> since only the Address Mask register is used.
>>>>
>>>> For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
>>>> two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
>>>> in conjunction with the Address Mask register. However, since the module only
>>>> considers either of the two registers for a CS, the size computed by the
>>>> module is incorrect. The Secondary Address Mask register is not considered for
>>>> even CS, and the Address Mask register is not considered for odd CS.
>>>>
>>>> Introduce a new helper function so that both Address Mask and Secondary
>>>> Address Mask registers are considered, when valid, for computing DIMM sizes.
>>>> Furthermore, also rename some variables for greater clarity.
>>>>
>>>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>>>> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
>>>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>>>> Cc: stable@vger.kernel.org
>>>> Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
>>>> (cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>
>>> This was not a clean cherry-pick at all.  Please document what you did
>>> differently from the original commit please.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Yes, the cherry-pick was not clean, but the core logic of changes between
>> the original commit and the cherry-picked commit remains the same.
>>
>> The amd64_edac module has been reworked quite a lot in the last year or
>> two. Support has also been introduced for new SOC families and models.
>> This rework and support, predominantly undertaken through the below
>> commits, is missing in 6.1 kernel.
>>
>> 9c42edd571aa EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh
>> ed623d55eef4 EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
>> a2e59ab8e933 EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
> 
> Why not take these as prerequisite changes?  Taking changes that are
> radically different from what is upstream is almost always wrong, it
> makes future backports impossible, and usually is buggy.
> 
Just to ensure that I have understood correctly, are you suggesting
that we backport the above three commits to 6.1 too?

> And if you do make radical changes, like you did here, you must document
> it in the patch notes itself, like others do.  Don't attempt to pass it
> off as a "cherry-pick" when it was not.
> 
Apologies! Wasn't aware of this!
Just noticed that conflicts encountered during backporting have been
documented in commit messages itself. Will do the same going forward!

> thanks,
> 
> greg k-h

-- 
Thanks,
Avadhut Naik


