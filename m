Return-Path: <stable+bounces-166443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E5B19CE4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CB5188A48C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E40239581;
	Mon,  4 Aug 2025 07:47:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45C22DA06
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293649; cv=fail; b=HhK5ANgqICfBdpiQF/7YUjFEU0UvzOs//7qdFrl3JbHkFuNJvPB5OiGtO5kCJsf0uHfQAAYSDTha+IyYny1EujrWn+eoC0EUERf5JzNnzbJYX+Lxu7AwyJ9fTc9ITyhlO5SUWcYzAlGKy1umbIAap6pMRlow4fGBXt1zHPgOEL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293649; c=relaxed/simple;
	bh=dD9KaLoKDVRWc/lJjuouBwi6qfb/O9QI9x/mi3N6TeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9IFDpVFEkJyAd0HTBLrkBPOivXQ10vNBAxDev/jX2gHwWzTNJ1aSQJl/xkgQ1tFS0P8eqRfIJH5vJNtz8Mlv/P50OlHH4BWsjNpwohtN01SoQVyNu18DWkU0pt+dkVEbSPKOV30P8FIj2en7cRkOLy64RVpInZrMGuNYfc27Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5747H3391879015;
	Mon, 4 Aug 2025 00:47:24 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 489dy118du-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 00:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPW36x+dWu+NicwvuQ48j74CDADYHNXYcpbfyJfEwLQG7ZRZw3fv7Mk+LP4UzlhDnEfSYmStTebWoBJjW4cjt2mx+yFyI4inEqmwTfqewFZPqCZsebPbXCC61/iedC7RyzuGbf7MFo/5VXClI4dIgGg6JmpqE1ASiV31fFKoE/p/DtDXef4gV7l7xkRh7VB0orwH3ybPqBXnupH1jNvCIbPwC7PJQNttk3gNPByV/scnhhXxKIfpUXValwTxbeLPSfOs2aZxR96TH7kbKOIbdptUjBIQ0LoKmPN3cENB271tOnOrDWNVVnLm2iduaLBSghy38gFAmrYDtBCjSPb0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGkpbs+4IFXioYTbhjcc5yxYziEG3wv1t3ZP0xj5D+I=;
 b=v90uAqFUhUWKjZLdhMG/vg1L8BKvUo+LRKYDIrPC77Kreqt6+Ml+zJUu0HWN12FhWN2coR66+6onqnjkjOe8lCp+yoNpOb8z6b42ocyTgzHOd6zREGV/GVZVmst0Pxd6lhtcdKxswAxvPck0iJqK3UgUVoHLeLN2cEptxLwtRvUL4hjIQrAvwfly3G8FjAOlUIWCVkndnhFBxxTquigohn/hz44255FnaXwEjbzemzq0uiveDbgtXqw3khqzcSkGH+firmp1zTOrsEF+hC6+ISHr5mW/168bsv6xuQ2cu7GfMZgTZeTlk4riHnpyNMaeQFMeNUHftVAP1wBjMKrjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) by
 DS4PPFE901A304F.namprd11.prod.outlook.com (2603:10b6:f:fc02::5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 07:47:21 +0000
Received: from DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b]) by DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 07:47:21 +0000
Message-ID: <4be58827-6794-401b-9a9e-e1ffd66a6a89@windriver.com>
Date: Mon, 4 Aug 2025 15:47:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "cve@kernel.org" <cve@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "He, Zhe" <Zhe.He@windriver.com>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
 <2025080132-landlady-stilt-e9f2@gregkh>
 <DS0PR11MB79597F9B511913D0EF4DDA458826A@DS0PR11MB7959.namprd11.prod.outlook.com>
 <2025080251-outright-lubricant-1e05@gregkh>
Content-Language: en-US
From: Qingfeng Hao <Qingfeng.Hao@windriver.com>
In-Reply-To: <2025080251-outright-lubricant-1e05@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To DS0PR11MB7959.namprd11.prod.outlook.com
 (2603:10b6:8:fd::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7959:EE_|DS4PPFE901A304F:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b9a7a9-88d2-4207-2132-08ddd32b24c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0lBVEROYVZLMUsxM3ZuaTlZd2o4L0tLSTI1bmN0aHVONXhnaE04bVVzVDcz?=
 =?utf-8?B?NXI3LzUzN1ZQWHFPemNRcmJ2VndjdjI1LzNjVVdPanJsNnlQR1U3djJxZlpV?=
 =?utf-8?B?UU9ESGllYnlUZ202ZFpXbFBxa2RvdnYrZzJxVFg4L285eUVaZUpBL1VJdFlC?=
 =?utf-8?B?Zm5Ja2x1bHF3UXlUcmYrZElhQXBPWDVtNmRtcWdWaE9hbEFZWnFXd0QrbXpl?=
 =?utf-8?B?WEhPRGErTnN2ZWZnRWhneWVmL2NyelBVbU9FenllRnIzN3Bkd2RWQzE3YnZJ?=
 =?utf-8?B?eVF6Q2FNMUx4dzNEUDhkZVdlemZ6L2FPOU1vZEF1bGE4dXhQZDkxeHFITzlG?=
 =?utf-8?B?R2VEWkE4bGhyTGV0dEptbjdCaXplSmthekpHSjVsYjZFc0NubDE1eWdXQkk2?=
 =?utf-8?B?blJHbTdXQ1M1ZHlHWWdGTEJoRkFsc1ZtSEx1NWVEdlJoaVRucncycUFBTC84?=
 =?utf-8?B?ODUrNzlHeTgxQTZoSlh0NDFTKzBYUWZBa2dNWHZRRDBOV3Y0c2srY04rbGJS?=
 =?utf-8?B?Z3hYQ1pzRWUxZHlYTEJlSm80Q0RzbHhJa1pqUlZzSDY4Z1d1a2dWUVdkSEdx?=
 =?utf-8?B?aEgvZWxTbXo2cjI4dlROK3VnajQ2QkhOVFdjQnFVT3ZPU09pMUZFN2FLaCtO?=
 =?utf-8?B?S3Vzd2lKNCtSWkFXMmhrTHFEQWJ4S0VpNFBJVm11WWxQZG5LVjBDeGhEMFlk?=
 =?utf-8?B?cUFRZ2hjWVJjemxhbkY2bTdkTyswM3lmbVVZRjBFSWgySENGZlk1ckFYakVp?=
 =?utf-8?B?cWh3cndLS3lOVlhvM3hvRW1zV2xVMzQ5cFBDZFBEdW9Lb0tiNHNsMUgyOU15?=
 =?utf-8?B?dUFHU3ZEWFJ6SXZTYjlFdVdZUTc5T0h1aUF2Z05ZMHgycUhlMTVKZ1poT2Ju?=
 =?utf-8?B?VGlHS21VYy93NURMQ3Z4b1VKUC9UdTBJU2o3bzJhVE9KeGcyZzJ4RDYrKzg3?=
 =?utf-8?B?dEY1RnhCbUdlZ2JmMk5Fc3pzbUNrZkZhVXBqRkwxSFhYU2Y4azdLc05zcndv?=
 =?utf-8?B?dlV5VFc2Q29hcW9zeDlHUG1HUVZSSDN1MkRLRGZKbytIZmJ1RDAzWktCYTRF?=
 =?utf-8?B?REUza0ExL2xPZTBMc3RkU0FMQ2pVb3FZSklUeExWL21mV2huYld2N2VtT09J?=
 =?utf-8?B?T0dEQUUvdytJY1B2MXA2MGZtRWNaQmIva1RTenBGRS9tampuRXhyaStJZVd5?=
 =?utf-8?B?ZGRwTUYrYzdiVUppN0VTM0FnUjA4cU9lVGJPVWVWQ20yRFJKOGgrbVNQWi9C?=
 =?utf-8?B?S1k0RlYxc0ptbyt2U3Y5UUlDbXQ5dmFqWG1GWXZqOTJHTDE2MmY3ejEwdzh3?=
 =?utf-8?B?bWY1TzlKQVZEbStRYmtlb2ZHQkM4RkczdThMWENEUjFvb0gyZHFEZ3FoSjUy?=
 =?utf-8?B?QVp5MVVpR25XYWRUK1RtWFRhc1lWbmhQakZFakp0Q3RLaytuOUoxZ1FQTENM?=
 =?utf-8?B?ZDBOZGQvWmsydnNwcy9XTk54dHNsU0NldDRhM0VWRm1KZXVOQkVZRG5OaWhs?=
 =?utf-8?B?eGRyS2hmM1FnS2ZPNDhVcVhlNTJ2NDdlN3pPaXNyRVNRL3VqWFI3N3grdWdt?=
 =?utf-8?B?ZDYzaHBWSzY5SjZwcWxzNUlmSnVWcmZzZFp4cis4azhra3BENm1SYnE3eklH?=
 =?utf-8?B?QW8wWEVnbnN5Nk0xSFl2bDlQOEptS0JCSzB3R2hSZTkzRTFQMkZWbldCZkFk?=
 =?utf-8?B?blJIMGtGQUY4UzR1emJtRXVHZ2MvTGZoNGZRN1k0L0xhVXF5NkNBQkpBUndF?=
 =?utf-8?B?b2V2OWVoMG04UlV6a3o4MllzcWNMS1A1WlNTdUV0YnpoRUFmZWMvckF2MTFV?=
 =?utf-8?B?a3d1WlE5dkhZRHNab0hPakhhLzZGY1dWSmZoWi9UQTk1VmZNOW9YZXFrMzc3?=
 =?utf-8?B?bTQ1OUNla2xpY0RlN1FWWFEyc3Z1ZlkxdWNWcXVBK096QStHekMxdTA0YSt0?=
 =?utf-8?Q?7Bdf8PEVPog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7959.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0s1N0MzVk9RZkozMmZpSGZ2NS9ZQkpGdHJtVlR5WGtKbDNETU1qNEY3cWJm?=
 =?utf-8?B?SG5IZ0RsQUo1ejRuQk9EcElKOFdIU2tOVFNyaGRUUEl2TnY2TmJUQm1xWFhT?=
 =?utf-8?B?dkVicHN4dGQ1M0lTUVlLZVhWVEh2MnZZWkJsQWV1OWV6bStraHpFc2J3d1pv?=
 =?utf-8?B?NHhoakxCU2JSWHQxdk1zbmNiZFJreVUvR1hhVUxXOERleG1TVTVIWlBjWmpC?=
 =?utf-8?B?M1d5RmJEN1JnV2tOV1VWK0FVWjNOQ3BQTytRNHUvSDI1UWJrbW8xN3lCZFdr?=
 =?utf-8?B?TzZQY0hWVVJ2eG9tL3ZNTDA1L2lZeHNjcGJsODR2dGhwUXY0SW51RjA3eHNi?=
 =?utf-8?B?ek93MklXUUdsck5BM1R0WUVMdzYyeEo3RHl2SWN6STdwZWxRMGtYTXozN01M?=
 =?utf-8?B?a1VscFFqOWpacVJvT1FJMkt6SnJVTURydUFTZitudTNxM2UzeG5FeGNQSFQz?=
 =?utf-8?B?OTZTNVVpL2o3N0JwbU1tYWlwVDBIbWVoSVRzNjNKaVZOYk5VZjlnSFpDTlZ3?=
 =?utf-8?B?RGxMcEpNTVU4M0dvL3gvMHpYLzZFUmVVMDBQaUlpQ2pGdHIyVHdGVnhreWFO?=
 =?utf-8?B?QnYvUmRjWi9jQmlqdzcxaTZEdkR2UHZ5c1R5emR1YWhCMThzVkdKV01PbjZ5?=
 =?utf-8?B?dkU3TWRSZS96NXp6a3YvRG5Vc2ZGbVQ4bklGdnArMXRqVFl0S0ZMTiszUkpa?=
 =?utf-8?B?ZUhZZEUweEZjeFYxY2ZBN21qdDlML3dtdHFrN2Q4WGIyNEZZQUt1TzgzbnBU?=
 =?utf-8?B?VWVBOVI3RGlTdTdza1RVM2x4cDRJN0pHV3RsamdMK09YQ1ZFSE9BMVZWTm92?=
 =?utf-8?B?UGVhTGdLRHVicDk2UXJ0bTZOWFhyYlVxWEE3cW5tdUlyRi9jUVZVYTBNSDk4?=
 =?utf-8?B?OGlia3VXOHlTUXFzN2YySFpYU1BhUVd1OUxMY3BKU1VLWGhzRkgzVGZQUlkw?=
 =?utf-8?B?UXJFVUEzRXdydHhpUlNOQWlQZkVyMHlId2U0eGdMWHladjk4Tkw5WVVVS2N5?=
 =?utf-8?B?S0pZMjdzNENGOFpabkUwcG5Nb1NvZWVYVXRLTXB6Y2xOVlNqblMwOGxML2dw?=
 =?utf-8?B?ZmMzUGYvQnFOakpJYkR3VEJXbHVGc3VwMG56TVJlcUk0WEI0bkY1VHRSV0d5?=
 =?utf-8?B?Y01KaXExaWkvZEpRQU1jUkR5ZG1ZZjhSQkxTMjZVekhTL3BBcXVKanp2K205?=
 =?utf-8?B?MjlZSUZxbWcwYmNVV2V1R2lXM0RyQ0dKRk0zUHZwL29aZjhzN1o0WVBtNXVo?=
 =?utf-8?B?VW5PbWhtU3l0TkZOSnBRTkgxUnRLYkVoVUQxM0k5UEh2bHkzK0xyV2lNUEI4?=
 =?utf-8?B?V2ZvUkNlRWRtQ1cwK2h6VTRKTXFOV0VQUmJaekZvSkwwSEZySGZrMHA3b0hS?=
 =?utf-8?B?cmx6em9PL1BpK2I3T2dPRExnb09jbWtLK2F0ZlQrNjdFV0JEV0dnbUFFT3F2?=
 =?utf-8?B?SExQOFdjamtGRUlGNHZKR09WOFh1eGc3N2Yzd3pvdWdsVEVZWVcxUGZLL1M0?=
 =?utf-8?B?c1hzcHJSeGhWVGlYSnFzRzIyMkRpU0xwRS82YkhNNlpiSEFCeVBPYXZFdUZM?=
 =?utf-8?B?RVZXNFRBMERQa1FKS2g4V1JCMlFNdWVSQUpHN2FwUUVXaTZwMEdEYVNTL1dy?=
 =?utf-8?B?djlISGxLMzlBUmp6OERXc3k1bCszL3RLREdpTHNvclNZdjBDczdzZWg3SUUy?=
 =?utf-8?B?VzRPb1I0bkwxT1NyRy9hQUhxUFJmNkpoWC9CQkUrL1A4K3VST0p6RXFnSzRG?=
 =?utf-8?B?YWdwYzZySU5zN3dmc2NSRFBKa3JQSFZrT1JmNFlLVGpIUUptRUo0Z05SSHdR?=
 =?utf-8?B?ay85QUdhY3VaN3pINEdOb1ZLTlk4UDErdE1pSzhLalFVdHJvVXNMVDkrOWFx?=
 =?utf-8?B?c3JwcWlwajgyNkVJSEhWNk9iVlpETGZ4SSsrZXlXNmVmbUtobWV1NUh4YVlu?=
 =?utf-8?B?cnJNekNDVncrTk03dTh6dkxJZTRSK3o0bWhYSWRIdHFSVUQrSTlHTU1pbTc3?=
 =?utf-8?B?RmlQM3VZbWdSMFVYb3RtUVlkV24vKy8yM0NUWHMwcjEzc0p6L0ovRjFLZDB6?=
 =?utf-8?B?QjZvWnJNY0RrZjZMZkpPOC9sc04xMUV6b2hJMDJ4YjRGUXRXYkRsU09HbEJj?=
 =?utf-8?B?NE81RXFwWjZ2eHdSMVpnQ3cySTd0cVZLN1NwcmR0TTJ0M3hIaUh4MkF6cEN4?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9a7a9-88d2-4207-2132-08ddd32b24c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7959.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 07:47:21.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2sPQY+1AHZi71m/ibJBO/xqC4PvkQXS6bHxHlPfTAqkr6dPrFl3Lt67SLBqkcgy/mvWdcIqv0F9c1ZG5pBgxPs2UylJPNB5i8t7SAYQBNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE901A304F
X-Proofpoint-ORIG-GUID: 5_4mxiIxL7MgNTTGQYdNUHzra1fnVTPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0MSBTYWx0ZWRfX14cyVqqcXGpb
 a9CtHFmuFiBmYgoARKSzirWWFH1MRcpG3kJGWXCQD5bkMJO6EQdQWR9M6TrEergj09nssQNIXKt
 Q6KF+5cFkOfZ5avGhTW1TyOnHVskyomkCXfIvCJY2DTU8ztnx0ZVApDQsmDuTgEW9dungXuEB+k
 mi4JEW2PT2s86wtGUP0xOi1uGRWqfHxCayzti8+jULjmi3xRPksHAHUZpSCxuqm0rNTwbHiq5ES
 cnypO+ms3DrPTOgAHPjw54TaIuAFRPS+nYvN74RR81ONqdsNF4eLTCgqaSWTx8K3azCdlXNtdo5
 Sg/kSyLyyaT/eOfgzRoB+Wb0g7MxZ6PH1+uSjCFfcdnyYMJCOjxXEymF92TJonU1pFv3jBnkq5A
 9AQNko79
X-Proofpoint-GUID: 5_4mxiIxL7MgNTTGQYdNUHzra1fnVTPw
X-Authority-Analysis: v=2.4 cv=LtOSymdc c=1 sm=1 tr=0 ts=6890658c cx=c_pps
 a=NB3Td43k1Dtgf8/5lZavww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=nubRiproaG9niO1Re_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2508020059


On 8/2/25 16:19, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Aug 01, 2025 at 12:04:54PM +0000, Hao, Qingfeng wrote:
>> Hi Greg,
>> Thanks for your check and comments. Sorry that I mistakenly changed
>> the files of .dyad and .json. I'll pay attention next time.
>> The original fix 66951d98d9bf ("drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'")
>> or fb5a3d037082 for CVE-2024-26661 didn't fix the CVE (or even made it worse) because the key change
>> is to check if “tg” is NULL before referencing it, but the fix does NOT do that correctly:
>> +       if (!abm && !tg && !panel_cntl)
>> +               return;
>> Here "&&" should have been "||".
>> The follow-up commit 17ba9cde11c2 fixes this by:
>> -       if (!abm && !tg && !panel_cntl)
>> +       if (!abm || !tg || !panel_cntl)
>>                  return;
>> So we consider that 66951d98d9bf is not a complete fix. It actually made things worse.
>> 66951d98d9bf and 17ba9cde11c2 together fix CVE-2024-26661.
>> The same problem happened to CVE-2024-26662.
>> If you agree with the above analysis, should I append 17ba9cde11c2bfebbd70867b0a2ac4a22e573379 to CVE-2024-26661.sha1 ?
> I think that the original CVE should just be rejected and a new one
> added for the other sha1 you have pointed out that actually fixes the
> issue because the first one does not do anything.  Is that ok?
Thanks Greg.
Just to be clear, 66951d98d9bf was supposed to fix CVE-2024-26661 but it 
failed
to do that. Then 17ba9cde11c2 was added, together with 66951d98d9bf, finally
fixing CVE-2024-26661.

1) I'm OK with rejecting CVE-2024-26661 and creating a new CVE.
BTW, since I'm new to kernel CVE management, why do we reject a valid 
CVE just
because the initial fix doesn't work ?

2) If we do need to reject CVE-2024-26661 and create a new CVE, is there
anything I should do ?

3) I just did some search and found that some sha1 files contain multiple
commit ids. The sha1 file should contain all of the commits that fix the 
CVE ?
Or just the last commit of the commits that fix the CVE ?

Thanks!
Qingfeng
>
> thanks,
>
> greg k-h

