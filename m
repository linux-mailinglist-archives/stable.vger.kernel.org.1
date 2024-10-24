Return-Path: <stable+bounces-88018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CE9ADE5E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8531C20C4A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3814C5B3;
	Thu, 24 Oct 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnW5Oj6l"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB65189F4B
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756967; cv=fail; b=rmhGpqvnTcD+67MCgwNz/Pu6NZL3v6CGzXhYxj5fUSFDZmt62D3azuMMQVKAzTZg5/kC2h27ypojKu5+E/UnIMjo3GqK58UNK6gJS3FVRo7TMgYe4kzbMZGJR8HV9EYpPHAIPWwMp9FrPq7G4Ul9lw9iovQRWiyJFpnuXRHneX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756967; c=relaxed/simple;
	bh=PQN9a8/Mo5cifIpT7Y5/6Ryi/tw55kfqB9JZRZS5V+8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtWY2llT533IG6PiN4TW8PbqmRIR9uFc/TFn1QNMH/K0o6JBuHs0ZvpNf7lTtWI8LDbDhuKxvPXklw624dsGkCI8VF1KLKudh0jUk0rrtAHyuD5QcUiUYekGyTdJGm4B1oqLStD11JzJYYLqRCCY/oDnXLvC2g3+xN4jFcsQXsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnW5Oj6l; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8PRgpSB/GpDZ9F1KuH4YtN6ufugRL71bjlQ9AkagAHj0vdJYEw9W5eTmrNhZZ1dk0b7tfhf2/J2FixOh5mU9p4izOvquxYyXyPq2MYgSH0kc4e0HCGgdqcNYAgHj8Ssg5SMLLuOtUdPxpR3wXecJKjZmxe1K6+p6FcpGCC+70VsQibIaruZSZXzWAqQGJ5ihjMazwv7HJlBQxuai3V1IAMvByM0VZMbV2hQmTa2xL4LyjPE/5TN1Ozs+PrOz8LmzJd7JrX/N8gVWlOY/s7lnEtgDj/s5ci2gwdmKmhoWlAKoDJAzc/9lMEAPrXmikJqgokS5V6Kcpa02QFzdPc/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIBpLtRnn0V4rWJyGaf50hMLHNCfcqViD7MD535zpDc=;
 b=QSEdoBZw3THPMJ7rSMwhs2+Xt9lW8vmPA4QXPfitFb4Ffs9wYKOXq6vz7Wo3e9tW0mfb0oX0cUQafyqkEZVUxEJ1LfOYon+XMxImSB0V8xf5klXPmJBt2gd8mqMFc/L9nt4wmQCMIoxT8NAspPvgy+UGYRrNJpqaDi9f1jVszv29m9hMFpI+AYsjccStQQ0YK2YxQgc6yvHYtjQW8/XGM+h3lP8/Sm1iGHVECqa/CeTd728ryb0yzg4Be9DR+9terPDKDcn+T1AJmLzcKfWybeH1qgmqZUxANJ7jSOCRJQ9ZF1bngqm441nwhPShvGBDbYtfN0nngFYFHlK8hoSIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIBpLtRnn0V4rWJyGaf50hMLHNCfcqViD7MD535zpDc=;
 b=tnW5Oj6l+YQbUE9Uqo1ZiBi8XlAEoo9en9sJGSOkCi0UUIxNh3uidsgJEbAqT/FWMpy03jcMGHR3t2nvfdwivjx9qhIAaiWgS1VTlUMgO62wYBhrJ3YXeIUdjN5Ki9uHPuC07KBOhLn4vqJfWFImsLJcKambWe77uab0O/y+yS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 08:02:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Thu, 24 Oct 2024
 08:02:42 +0000
Message-ID: <87a39a5f-af0e-4247-8c1f-b4e6c4b3a81d@amd.com>
Date: Thu, 24 Oct 2024 13:32:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Request to backport a fix to 6.10 and 6.11 stable kernels
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, mingo@redhat.com
Cc: peterz@infradead.org, irogers@google.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, gautham.shenoy@amd.com
References: <fb8f9176-2cf8-4bdc-a8f9-a1b96e49c9b6@amd.com>
Content-Language: en-US
In-Reply-To: <fb8f9176-2cf8-4bdc-a8f9-a1b96e49c9b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: efb37984-c22d-40d9-aa08-08dcf4023c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzMwVUdXMVBzMVVOUm80SGZKeDRWM0NsMHNVQk5UbVZNU1NTMW5Bc3hxZE5I?=
 =?utf-8?B?Um9wc01oNkZtUUwzTktiTDlKOXJJVGZjTkMxd0RSWVI0Sjl6SmlMUFhDTlpQ?=
 =?utf-8?B?SkR0SjhoZFNlTW9vNS9PbUx4Y1FOL1B4YUYxalB6VnU4RTZRa3hHczZ6ZGUy?=
 =?utf-8?B?OVNBRW5zbldDUkRYMmFFdERIczdDcWw0d3dvNzB1d242WlE1QWJqTDBPbkRH?=
 =?utf-8?B?Vk8wVmFOVlJuWjkwMEtLdmdON0wrdldmVEhnT2JRNkRyUDRNMm5veFp0TzR4?=
 =?utf-8?B?ekltYXAreitldUJwVkx1S3NyZlJ3YjVxdW1FUlU0dXpBNDdFOTdXOHdNOXBY?=
 =?utf-8?B?WHZEcWhvcWY5TFhPNVNnZks1RmVyM0FYV2FYYk9xcVh1dDFXcGxhODBPUHVu?=
 =?utf-8?B?SUwrZmwwY0NDWGFabXNDQWNMUjRkc0c2allFYXlUOXZRbTJnLzJhZHNNUGlO?=
 =?utf-8?B?UXExU3c4Z29hQmI2USt4aE40SHd4MUl4cXhJQnpGSFYzZnF2TjBIUWdQejNa?=
 =?utf-8?B?WVhBT1JKUWhwSjV5MktNM21MV2w1bjBwMFk1RmZLL3pxM2wvUjdVTUZ3NlJZ?=
 =?utf-8?B?RTk1QUFWSm1NMmxLUnRDeWlScXJ4aHJOZWtVL3ZRS240M2xlajk4elFCMDdV?=
 =?utf-8?B?RDJGdXBxaXNFWXNkMlo3TzBTaGVGKys1TVdqOHFlNC90ZllJYWVWZUw4Zm85?=
 =?utf-8?B?RExLMWFYSXpkZmJ0MGxKOEZqQ0tVamV2QXRRN0VFczhmRm9FdnlNUHBka2g5?=
 =?utf-8?B?MGhkV1d3UnIwTzd4N01YUzg1V0IvNk1vdWdhaTFvS1pUOU1YRnBGZ1NRdTdG?=
 =?utf-8?B?V1prdlRJZlBFdU1NODFYUXhoSUM4SG5BT0c2ZDNxOWNxcWc5K0tsNWZ3NENO?=
 =?utf-8?B?MW43WVNkQVhqeG5vK1d0MWNFN1k2OWliSnhFa0wrY3RkbkZvOStFNlI2MHhk?=
 =?utf-8?B?N01RYldkVjJ3dlZwUW5FdnNybExxTndpNkJQQ2p1VWpYcUZRaTIwOWJTNnJM?=
 =?utf-8?B?Yitzc01BUVVTZko4clN5RzlTYW5hd3c1S0tZZFlvcTFVWVNCbVJybGtLNnRv?=
 =?utf-8?B?RXRkZXR0NWE1VnYvb3NUZVdMNUM5cWt4MXQzb1p6cTk0OGNsNGtaUHhpY2Ix?=
 =?utf-8?B?Sk41RndjYXBqU2FLT0lDZ0RCTWw0NkI5MzdVR01WMEhpZ0tWdFJvRnFWVVAr?=
 =?utf-8?B?VHhBdHQ3ZDFhSHhkL2pxalhXc052QVYyMmFXUHBtblFOQ0M2enkyWTlORWhv?=
 =?utf-8?B?WmlYdGVuSlo4dWJ2VmQrb0ZidE5vTWVXZXlGc0NoYVN5UzUvN3NtNHB3a3l5?=
 =?utf-8?B?ZHVQL041Z3lBQ25naHJ4ZUEwNXVFWS9KRmxtdjRBN0ozdDJGQU1ncEtKL25q?=
 =?utf-8?B?THNpYTZ4VXhVRHA2M1VFUWl4ZlpxUjlLNXk3dE1FTUZwQlU3QWRQcEJlOHBY?=
 =?utf-8?B?bStCK1JtQjVJQzVPWGZNblVsdzlKdC9qUFIvZ1NCUStBTDBvdWtmSWNwOHJl?=
 =?utf-8?B?SlJMK1pJd1VNL21BLzRBWFlNdGRpa1hWRXFkL3ZhQWZ2UEJza0ZjUUlGcmo1?=
 =?utf-8?B?VElkM1RUMTZCWDFlT2ErSGNzU1pCOUdxMHlKNzBsUjBEV0RsUVc2MDZlSmI3?=
 =?utf-8?B?b256ZnZINEtWNkhwUTJqU3RPbEg2TlViZWswREw2ZUdVdjJ0bE5lVWRuWmFR?=
 =?utf-8?B?N3U5WkRnKzJGdkN4TW1PemM1M2VGMmMrS2lndnpDUmh0c2FhUkF3Sy82eGdp?=
 =?utf-8?Q?JUTgz1nNXiBlzNlpVaJxFSHqM4Ge7cd9sZAkbRs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnpzUmxvMXJaL0tUT2xGVjNFL0lscGwzUW5nK3ErdWZiekEvLzA3TEtjRm14?=
 =?utf-8?B?MnI1bmx0anI1YTlvU3M4SEYrYmtuMjZxWVk0anRwTkRyQnBsM1RpSDByRFFv?=
 =?utf-8?B?cDJlY21jcktNTjZEOVk0bmp0SnJpN3hRYVRPZFc2KzI1dFQzbVRsUnk4OVV1?=
 =?utf-8?B?U2tYWFg5MnFTQ2JsWmdjTkFGT0hXcEQ0WldqZm4zbVA1blJlcXdaS0lLV1pi?=
 =?utf-8?B?d0VlaTlCYkkwdCs5Mmk5SG4yK3FaSHcxQVBTZTY5UUZOWlV0WU1YMjllS1dm?=
 =?utf-8?B?Y2wwRVRuQ3o5cHY3Q2s2ODk1VEpJYlRWK3Q0T0FkL1RIS2hVTVhLUmd6YzN0?=
 =?utf-8?B?REJMUGM5bGhRdW5aRE9lWVhZc1YxdHZad0FuVVRkQkFJSDVWRDdjTGdBL21h?=
 =?utf-8?B?RHlZRmVSMExvWkRPWUZFVGR3bFBnRFNYZ1hHMFN3K1B6ZElZNXpPRDRldDZP?=
 =?utf-8?B?d0IzcHJpeDkyU3NTMGJvWTlEa1E5RXlHUWZxZFpQdGtJNnBsZEM4djJMRU1p?=
 =?utf-8?B?RXYzVmxEdW9lcDlMMEQzL09IVm9wVlNZb2dya0d6WG4vSHlRWWVVcXhER3Yx?=
 =?utf-8?B?N3pjK2NHdWJPUXNKaEJpMTNBVWN0RTNZa1piRlBISms4UUJaVG9mSCtkV2Vt?=
 =?utf-8?B?VWIydzNjWnYrZTk3a1pkLzk2cWZVbEdiN3NUZG0wRjcySXlXN0MwUS94cHNt?=
 =?utf-8?B?SWpOMSsvWWZhVURKaFBKQXdKclovWFZCZ0M1c3FNVUpNL0FQUjJGTjVkOVNy?=
 =?utf-8?B?NXR1YUh0cnR2c0NreXdYTTBMRHBjL0RVT0hZY3hlbmRNeVB3OFJVRWdTNWI3?=
 =?utf-8?B?QVpITjljNUUvTkg0aG9tSzhOL05aNU1YQkl3MzU5dytQMHJTdVoxUFB6RVVv?=
 =?utf-8?B?YkFRNlN3ZHpOV1JsOFBobVhGUTV5WEFsb3JxcS9yOXZSbEJVd3lDTStJbjl3?=
 =?utf-8?B?Q050QmoyZ3M3M2xUV3dGaGhLQStKNGttclJ5QVpjTVc4ZmhKcVYzTVczNmhh?=
 =?utf-8?B?a1ljWlNvMFp1S2ZKVkhmNkMyQnVXMVBzUWF4bmROakNkL0xxYVNDdWJMSTc4?=
 =?utf-8?B?YlE3SGcwZnRiQy8rVUQ4ZVFPOEJROFZ5dlV3cm5NUExKZ1owRHlnUXhhRDln?=
 =?utf-8?B?a09kVHFOaExXS1JFOXEwM29rUFBKNHc2bDR0UmY1WEJJU2gzaU90VXBrSmdo?=
 =?utf-8?B?Sk9NZmt5dVV2bEo3V1o1Vzg2aHVhY1QyT1FWV1FxWlhmMTczNGp4OUFiT3lG?=
 =?utf-8?B?Vlh2NGtWWmY1Z01OOG4wbXA4c0xjRitEUWNORGxyOWltUHl5bWJ3OFRuRUta?=
 =?utf-8?B?L1BGclR1VWtQK0xuUWh4bk1jMHp3MFNLRmRYeWdsRkcwcVkreGVDN2R0OENy?=
 =?utf-8?B?N2ZSVzY1enoxZXRMV0ZoMzZXWGs4d1hrZFUydzBxaHVVUTA0dlUvdXh6TzZI?=
 =?utf-8?B?UEM2Qi84Nm5LbU9WeDcyVUttejRreEczdkRZeUlWT044RXd5cmpDaWh4N21Z?=
 =?utf-8?B?b2NpSUhpTDN6QVU2ZVVHbmpkeStoWHIwWEhJSDQ2RG91OGk2WmxDTnRCMkhU?=
 =?utf-8?B?cW1La0hTaHI1eUVDZ1NnZ0x2ZkJ6cTJGNlFSYjBCaVhIQ1FLaTdaaTc2RWhF?=
 =?utf-8?B?S2RoZ2V4Y1ZlR2tvMXJ4UmlOYjNPcWdwb1ZSREQ3WHZ3azVBTUx3ZVk1NDZW?=
 =?utf-8?B?YkhhK3UyUTZGcTl1N2FMRjN3aGF6SS9XUHQxbkk5K2JmVzFzK2lMVkdNMVpK?=
 =?utf-8?B?SWlJRWxMemVaMWxGMVN4Y0t5VUtxOVFhUzZPb1cxREhGZWhMNHFMbzI0TlJU?=
 =?utf-8?B?OHdpNUJTN3VUNGJtS3E4OUJLeW04VHVON2Z2Q0VwMjdaYTFaSnlvM1hBQ0NG?=
 =?utf-8?B?K3hZV25SMGJxeWtoNXQxVURic0c2ZkZVUkkrQlVsVGJnRkpTcFRucUNsYStY?=
 =?utf-8?B?UUd3L21CTlJwOEt3VGpCSDZSTHV2R2pDU0xoRXV3VmZhUnNCWUtUNzhEbHB1?=
 =?utf-8?B?Y3ZXOENIbmRkM2E1MDlaNGNIKzhuSEcwRkk2VTdUNDllR1VjbmVaeERrMzIz?=
 =?utf-8?B?amM3c1lvaGlOdVJSZTVmVGw5anZQWDd1U1BKUEJiQVdkUGR2NEFPbnRJdFJR?=
 =?utf-8?Q?I/npmEyIiLuktgL8KAw371SqQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb37984-c22d-40d9-aa08-08dcf4023c6c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:02:42.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV2UTXijP0Ry2zgZISWv5DZgs4JNSeFoEP8vWwIldoSiZqieXPWVy4/FykEBTxrSllPZS2n6VX+Sy3JwTbvBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319

Small correction below

On 10/24/2024 10:34 AM, Dhananjay Ugwekar wrote:
> Hello,
> 
> The patch "[PATCH v3]

s/[PATCH v3]/[PATCH v2 1/2]/

> perf/x86/rapl: Fix the energy-pkg event for AMD CPUs" fixes the RAPL energy-pkg event on AMD CPUs. It was broken by "commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")", which got merged in v6.10-rc1. 
> 
> I missed the "Fixes" tag while posting the patch on LKML.

Fixes tag was present in the patch but got missed while merging in the mainline. Ingo can you please provide some context if the tag was intentionally dropped?

Thanks,
Dhananjay

> 
> Please backport the fix to 6.10 (I see this is EOL so probably this wont be possible) and 6.11 stable kernels. Mainline commit ID for the fix is "8d72eba1cf8c".
> 
> Thanks,
> Dhananjay

