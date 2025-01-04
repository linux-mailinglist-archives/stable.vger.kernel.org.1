Return-Path: <stable+bounces-106742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55EA011FF
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 04:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1307416495C
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93DD27E;
	Sat,  4 Jan 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZbWbziAW"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2084.outbound.protection.outlook.com [40.92.62.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926836C
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735959778; cv=fail; b=BWq+4MmYVndVZSwmuVlIRCH4kn6aoKIKq4W5TEmFHmKr9G5ke2oFWa+iiYZfwI2/mwEeC7kfFZ97Q43U+JBC26sXVT6LRWTn1sQVMNJobQpPTVuuNhbHwUJjS6cHoc9GxHQVVpgQTyNKn8ZMm5PoCm9HZIZ705v6k4tNnbAhsOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735959778; c=relaxed/simple;
	bh=yvZiUuAngk/L7P/FUUI7MUPMBj+EC9rfUDEZWmXm0zY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eFazylCxlB+zWraUIsr4Y6BhiefoWfJLrzmQHMC0j41+PQhzAXYQkm/sApY0hHcPl089uom02hsRXVCSyRKFTMu3XJElkg4smNQH10YJF3QjzhODyMZoH+JNj2ZuWSY1m9w2nJXZJajk7YzGSa9VE0Xb7GN0uVoDEbOb5ES+8rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZbWbziAW; arc=fail smtp.client-ip=40.92.62.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYIzkjeObK+iV3ftQHG9BzbtnlpeBYzF58WjakeqLHNOb+bHJ3RR4+MZlljTb5HYyrjIe8M09ctR/dOp3U46fZwGuO1B1P57w/GI8/8xf+IGbHkMvMYyY3RQXcfA3lfq0ARfqWvrkPLgi0arhTgQPIuVBgq1nKH1uSOwVBUF7NfRnEv95YEmaR8dYWmUo8VkQtDzsl0mmSH9cUhQBafzuOLeAwqYNPRjxkgg4KBnJCIxS2xbuFYJQ3v7eP12PAos+lXPKC/BNj8wEOyqzZ2sWYhAVqr1ETVzatoMO3nNTMXmdfPRqMXU2jkpV2yyvrwyG2uVh5DVea8SlVONKCFMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ7XmsMlJqsL9aUKd3ynb8BsxapeMNNEJPeil9gdrjo=;
 b=Z5XxJICMi/6cNbtM0929GnlKW4Wg6pc5Uil0ovb+o5W3oDu8znDPAZ8uQ1A65Wt/2vBq4q5lQmv8WuS0NhEabu4nCOueBtv1MzQ3B3ma6yrBnEN+2tZkKk0YVbcZFHNnGkytdsFPWJWbLC+rrTDP/5mcFy8Sw2FWCYDwz7ZFlvZyFW4UiHWdq5A4mbkRFVeOBjrHsLLMeXkptkJaNMiDGlIG+23G57Myk+Qu9DhKptaM+EBwIShm4JcjKXz+sKFnzVLbGnDz5nZGg7Abjrteme4l9qWUxkhjfcF/5K2wOJGYDtn4TUFTjG6/AUeAcJ52Ih4hx9Y9Ch11XaDYpxguIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ7XmsMlJqsL9aUKd3ynb8BsxapeMNNEJPeil9gdrjo=;
 b=ZbWbziAWc7LkAAN3K+hZVV2xsaF9PkpiIywTeVuqnrMld1cxQIJ7bVQXmQgRzBSWpPtKCbjBuh/Bc9ZDJ0caE6PU9fmho5MfR9RkeP1KOrkbUDN5zWSsoj+SCD0qJ7aDevtbI9uj9puy4cKV3UEAtnaP4MYMJlPC6/EOIC/Arr22OaxTKdT7u2b2r9uy7LGzu8459mpFT5z46hhW6H978soeoVAtXVjj/ybq7949nCyPYZVB9KnHMUAgKpdU6jeMPBmgApe9I77byseQrkna+cnYeG46uhBMdValZMK3t9HsD89hKJrWL+UQcI13WhQWPW9DawYLIeg5liQ3OROTSg==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY8P282MB5033.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7; Sat, 4 Jan 2025 03:02:52 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%3]) with mapi id 15.20.8335.007; Sat, 4 Jan 2025
 03:02:52 +0000
Message-ID:
 <MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sat, 4 Jan 2025 11:02:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.6] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>,
 Alexei Starovoitov <ast@kernel.org>
References: <20241126073710.852888-1-shung-hsi.yu@suse.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <20241126073710.852888-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <d30f8c08-815b-4e83-8ecf-54ea26d87fd3@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY8P282MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 438c676d-ccd1-4810-1e62-08dd2c6c46d0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|7092599003|6090799003|461199028|5072599009|15080799006|8060799006|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlUQ0RLNXhNV2w4aGJtYm54Z3RmYktlRzNzQ1BOSEl5YXcyTVF3YzhKVmZH?=
 =?utf-8?B?MEtyTENmd0U3RjJ6ZVFKOHBFdTNZRVpZUWYxZkNCT1JvVnJ5YjV5U1ZxZVJC?=
 =?utf-8?B?RlkwM2cvNy9aUW9sWGNXS2lMQ1YvU3FvWW8wMTZ3Z1JjVDhFZ1NQMHRjb3NX?=
 =?utf-8?B?Tm0veGU5SS9RQTNFRnZOYTBHVzRZbXpha0ZXWVhwSWJPcXJOYm4yVU96UlY3?=
 =?utf-8?B?WVZGd1BKallIMmVWTTBGbzQxOU1HWlVYVjBGSkU1VmhCSVZMb3BKOXlBTy9L?=
 =?utf-8?B?MEFZUXdKR1lTTUZsOVRFeGVOWWNrMVdwdjVXc2JYalI1MjNmSGRkNGI3a20v?=
 =?utf-8?B?RnVCb21MaFdjVzNDdTFWY3BmL2paMDYyM005aWl3SDlMd0pRcVAwenB6WHVL?=
 =?utf-8?B?dUVhU0VRNHBRbmkrTy96T2g4eHlyVWZjMHorV1dVRmtBTFUvQ3plVFBlK3ZO?=
 =?utf-8?B?bFdoMFk2cjBsNFJsUDRzdm4xTVhxUWNQdmJxMlJZb3RVTnhGSFZLTHExUE8y?=
 =?utf-8?B?QTdzSHRwRWRkVGZkM2lESVEvbnZDSGh2MDNOOE9DTzBmS0FJeFUzL3hQVUVD?=
 =?utf-8?B?a2g1T2IvT2FWRG9HUWNHQUlrOHE1RmV1alZ1K04xNml1SFFDN2FTU0k4SUlq?=
 =?utf-8?B?UlNaT2tsRWgwTjVzVGdWdTFvL1g5Q2ozdU45T1BrMzNHWXFJWm80YzhlVE5K?=
 =?utf-8?B?UmEvT2NQZkprOU5FMlc0ZjZhbmRpdjlFcGNqZGNTT01BVkNzQ3NFMHFQT1p5?=
 =?utf-8?B?d0liUmdjU2VtMGUzYW9jTS9wVFhmam9xbXE5L1VaRUZ4ditFMDBtam1KSkov?=
 =?utf-8?B?M0lUS0RtbFBhYnJmWjJFR0g4L3dXOEpzdFk3N2JWeW90aGNlRk5GSXkyajFC?=
 =?utf-8?B?SkZodVY5TXVneCtIWTNEMmlBMmY4ams3NDBMaEhUZG5FUEZsRUlTSXZvemJI?=
 =?utf-8?B?ZElQYWRpYzhoMGN3VXpwRzNPM2FZbmhIYXQ4SGNmaHViNW9qR00wQnRUdlJQ?=
 =?utf-8?B?S3NQRUVEZ3B5T1lWMzZtd3J5cUFrbHNvZmRETlhZOWJTV29qaHNERnZuTTM2?=
 =?utf-8?B?bUd0QnZqTzd4RFc5SUtGWE5Jei84ZkRzS1UzUFVKeXN5eGR1VGR0ZjM0dG85?=
 =?utf-8?B?d2cxUXVGcTdhb2hXaVZXbVU5NFVtenhzYTVVS1pMdG9USjRsY2VGa3J5dHpF?=
 =?utf-8?B?d2l4S25MNTQxclpJdTFOVkMzaENVVHRnVVd5Y1pHejRTMzkvS1AwK3JTUUpT?=
 =?utf-8?B?cklzd3NIT0hLSk1MUmZpU05lemRBWW9xNzU5Y3l6QVNQZWl6OWpkTHNxYlFH?=
 =?utf-8?B?NCs2UU9NMVpiNEt0QWJJUlBnemVIMS83bkJBTW5ocWxkcVI3cEtycVFMTUo1?=
 =?utf-8?B?TFRsamhQVENESiszbEJHOGpOaFJuS3Jrck9OM3ErM1ZuOWhsUmhBWGgzZk1i?=
 =?utf-8?B?bzhnS2lkNlcrS2M2elUybUhmSmpsdkJXVFVrUDNaYkFUeU9nOWt6OXdHeVYy?=
 =?utf-8?B?cFBvT0ZCWnBMK1JDbDRZdTR2WmM4R3VONzZMNTRYRjN6akNzRmhOT0cyZzFL?=
 =?utf-8?B?T1NDeHF5R0dQd1cxWENLRnVMem9YTXZocTlyZkdWR3hVeFlSZmpENU5PRzYr?=
 =?utf-8?Q?e6GdsKiwuiAyplbxxioGHlhjG7r38eDpkmEEqstfQAbU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0c3Z1JwWkFNM0ozNG1VQnJqMnZFK2wwU25QZzJXOGNmS2QxUGZ2cnJlR1c1?=
 =?utf-8?B?NU4vWXNoVHY0aytmN0tNdm1VczRESjdVcUFrYWFkdFduMUxHTVNmWnlwWm9O?=
 =?utf-8?B?VXREby8xUHdnaWVXUTYxVm1ZMjFGR1BrRGhoUCtFZWt3UWp4OU1saXAyUFlZ?=
 =?utf-8?B?Z1I0NUlGUkF4NFRvSGpMQitDQ0FCYXhaVWZHVjNQQm1SdDZ0WVkxKytUVWlS?=
 =?utf-8?B?NzBVenQvMGhqcVdHcmViN2QwdExBeHA1U0xkVnhPY3AvSTVVamplaWl2c0VH?=
 =?utf-8?B?Mm1jNnRiNVN4aEcvQzFXWUw5NmdEYjRFc2dXV1ByWjY2ZmRPZnVKUldFc0hH?=
 =?utf-8?B?eE1Yc05FTWhabXlzaXRFKzNNVVNYZkgvL0M3dWZ2Z3J4MmpNR2JVelV4alBR?=
 =?utf-8?B?bHN3M1ZQSmpGb0psd2hlY24zek53Zm90TmtaeUhPOGZ2SDM5T1lYWWJCUDE5?=
 =?utf-8?B?N0dmWFNNVkdDb2wyTlE3WXJwWkxLaXNOTURtd1YrS0tuZDRBZXdTTXE5OEpO?=
 =?utf-8?B?VTAydyt0MEFTempqREkxeUtjTW5HSnYrZjU4cGlIbUdCbGkzVmI0eTV4TzJH?=
 =?utf-8?B?TmtCWWphbTBTZ0QxUGExTGRCcE55OG1nNnlIaDhzNmtndnB5My9NUzFFVlht?=
 =?utf-8?B?c2ZBVEdOeDZiVlNjOWVKYlB3MGZOY0NyU1JmMmRMRjN0VEVPNlU5a3JQTFdG?=
 =?utf-8?B?T0syQjgvVWx5UXN6ZmlTZGhCd0plY21JSHZYRDdEVjN2TGFyc0d6Uk5pUTBo?=
 =?utf-8?B?RzhkODVvRW85aUVzVyt4QlJBckZSNDZhWEdsdVdrVmZmSzR6SFY1ZFZnbnNk?=
 =?utf-8?B?QTJpNnJRV24xMWZ0bGs0ZTlpTWhDMmVsZ3ZyNHB5OG9DZi9va0dUdGdCcCsy?=
 =?utf-8?B?NHJEM0x2YldhR09Lb3MvajltcSt4bnZScmhSYnN6S3cycVZCRFM2MTZVc3FY?=
 =?utf-8?B?cWZPVlBpRXNBVmEwNmpFbGdFZ0VUcVpuVGRXb3JIM0g3WGU3MG9scVNwSzl3?=
 =?utf-8?B?RE9SL2JQbnBiUHA3Z0RGTkt4NzlySk5tTE9hTW1Nc3hWejRyY3psdlUzMFYy?=
 =?utf-8?B?aDQwcTA2NWdBbkFNU3EraUJPNXZQMjdSaGlsbmFzWGJIOGN1YU1EdzlIc29I?=
 =?utf-8?B?VFA5OHlKK3AxbGNuWmh5cmJGYjlML2RsVkVvSVVIcFdPWitveXB3M1N2eUx0?=
 =?utf-8?B?NUVJOE95TmNGZC9xcm9uOGQ4UFgxS1FQZGtPakdnMktqTlBiQlgxL25ySnh3?=
 =?utf-8?B?RzF1YmVEaEpaV3RMYVFLVXlaR2JrNXl0VTVoMExSZzlZTUZTUk12b2UvdHBq?=
 =?utf-8?B?ZCtpOCs3YzhGQ0hFelRGRUpIblRrY0ppY2NwSDRzd1QrL3ZRUTZEMjBENUdM?=
 =?utf-8?B?QWtVK2I3UW53OWs1L01BRlh1QUxGUllrQ0Z6QmlUelhEdFU4aXlqWmFiYjhj?=
 =?utf-8?B?YjJHZVpWaWU5em1Odjh2bkJCTjV2NUJxNzJobFNocmFjT0JZR2Z5S09DQ0Js?=
 =?utf-8?B?ZkVlWmJQcVVrYkR4MjlOaFZLNU1jQ01zUjhxNmVTM0FTQW1TeVVqUThsOEUv?=
 =?utf-8?B?TU1lZWQ2bE94SEhlOGlDcERSbEFCeklPWTdFMm1CZDVacUpFd296THpPWmFs?=
 =?utf-8?Q?3fGxUrDWvO0yKvbwMTbbt7V/+ORJXBw7pJ7jO2oXKIiw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438c676d-ccd1-4810-1e62-08dd2c6c46d0
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:02:51.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5033

On 2024-11-26 15:37, Shung-Hsi Yu wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
>
> [ Upstream commit 41f6f64e6999a837048b1bd13a2f8742964eca6b ]
>
> Use instruction (jump) history to record instructions that performed
> register spill/fill to/from stack, regardless if this was done through
> read-only r10 register, or any other register after copying r10 into it
> *and* potentially adjusting offset.
>
> To make this work reliably, we push extra per-instruction flags into
> instruction history, encoding stack slot index (spi) and stack frame
> number in extra 10 bit flags we take away from prev_idx in instruction
> history. We don't touch idx field for maximum performance, as it's
> checked most frequently during backtracking.
>
> This change removes basically the last remaining practical limitation of
> precision backtracking logic in BPF verifier. It fixes known
> deficiencies, but also opens up new opportunities to reduce number of
> verified states, explored in the subsequent patches.
>
> There are only three differences in selftests' BPF object files
> according to veristat, all in the positive direction (less states).
>
> File                                    Program        Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
> --------------------------------------  -------------  ---------  ---------  -------------  ----------  ----------  -------------
> test_cls_redirect_dynptr.bpf.linked3.o  cls_redirect        2987       2864  -123 (-4.12%)         240         231    -9 (-3.75%)
> xdp_synproxy_kern.bpf.linked3.o         syncookie_tc       82848      82661  -187 (-0.23%)        5107        5073   -34 (-0.67%)
> xdp_synproxy_kern.bpf.linked3.o         syncookie_xdp      85116      84964  -152 (-0.18%)        5162        5130   -32 (-0.62%)
>
> Note, I avoided renaming jmp_history to more generic insn_hist to
> minimize number of lines changed and potential merge conflicts between
> bpf and bpf-next trees.
>
> Notice also cur_hist_entry pointer reset to NULL at the beginning of
> instruction verification loop. This pointer avoids the problem of
> relying on last jump history entry's insn_idx to determine whether we
> already have entry for current instruction or not. It can happen that we
> added jump history entry because current instruction is_jmp_point(), but
> also we need to add instruction flags for stack access. In this case, we
> don't want to entries, so we need to reuse last added entry, if it is
> present.
>
> Relying on insn_idx comparison has the same ambiguity problem as the one
> that was fixed recently in [0], so we avoid that.
>
>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231110002638.4168352-3-andrii@kernel.org/
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/r/20231205184248.1502704-2-andrii@kernel.org
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> This is a backport to fix CVE-2023-52920[1]
>
> 1: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/

Hi,

I think there's some problem with this backport.

My eBPF program fails to load due to this backport with a "BPF program 
is too large." error. But it could successfully load on 6.13-rc5 and a 
kernel built directly from 41f6f64e6999 ("bpf: support non-r10 register 
spill/fill to/from stack in precision tracking").

To reproduce, run  ./tracexec ebpf log -- /bin/ls

Prebuilt binary: 
https://github.com/kxxt/tracexec/releases/download/v0.8.0/tracexec-x86_64-unknown-linux-gnu-static.tar.gz
Source code: https://github.com/kxxt/tracexec/

Best regards,
Levi

> ---
>   include/linux/bpf_verifier.h                  |  33 +++-
>   kernel/bpf/verifier.c                         | 175 ++++++++++--------
>   .../bpf/progs/verifier_subprog_precision.c    |  23 ++-
>   .../testing/selftests/bpf/verifier/precise.c  |  38 ++--
>   4 files changed, 170 insertions(+), 99 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 92919d52f7e1..cb8e97665eaa 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -319,12 +319,34 @@ struct bpf_func_state {
>   	struct bpf_stack_state *stack;
>   };
>   
> -struct bpf_idx_pair {
> -	u32 prev_idx;
> -	u32 idx;
> +#define MAX_CALL_FRAMES 8
> +
> +/* instruction history flags, used in bpf_jmp_history_entry.flags field */
> +enum {
> +	/* instruction references stack slot through PTR_TO_STACK register;
> +	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
> +	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
> +	 * 8 bytes per slot, so slot index (spi) is [0, 63])
> +	 */
> +	INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
> +
> +	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
> +	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
> +
> +	INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
> +};
> +
> +static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
> +static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
> +
> +struct bpf_jmp_history_entry {
> +	u32 idx;
> +	/* insn idx can't be bigger than 1 million */
> +	u32 prev_idx : 22;
> +	/* special flags, e.g., whether insn is doing register stack spill/load */
> +	u32 flags : 10;
>   };
>   
> -#define MAX_CALL_FRAMES 8
>   /* Maximum number of register states that can exist at once */
>   #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
>   struct bpf_verifier_state {
> @@ -407,7 +429,7 @@ struct bpf_verifier_state {
>   	 * For most states jmp_history_cnt is [0-3].
>   	 * For loops can go up to ~40.
>   	 */
> -	struct bpf_idx_pair *jmp_history;
> +	struct bpf_jmp_history_entry *jmp_history;
>   	u32 jmp_history_cnt;
>   	u32 dfs_depth;
>   	u32 callback_unroll_depth;
> @@ -640,6 +662,7 @@ struct bpf_verifier_env {
>   		int cur_stack;
>   	} cfg;
>   	struct backtrack_state bt;
> +	struct bpf_jmp_history_entry *cur_hist_ent;
>   	u32 pass_cnt; /* number of times do_check() was called */
>   	u32 subprog_cnt;
>   	/* number of instructions analyzed by the verifier */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4f19a091571b..5ca02af3a872 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1762,8 +1762,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>   	int i, err;
>   
>   	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
> -					    src->jmp_history_cnt, sizeof(struct bpf_idx_pair),
> -					    GFP_USER);
> +					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
> +					  GFP_USER);
>   	if (!dst_state->jmp_history)
>   		return -ENOMEM;
>   	dst_state->jmp_history_cnt = src->jmp_history_cnt;
> @@ -3397,6 +3397,21 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
>   	return __check_reg_arg(env, state->regs, regno, t);
>   }
>   
> +static int insn_stack_access_flags(int frameno, int spi)
> +{
> +	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
> +}
> +
> +static int insn_stack_access_spi(int insn_flags)
> +{
> +	return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
> +}
> +
> +static int insn_stack_access_frameno(int insn_flags)
> +{
> +	return insn_flags & INSN_F_FRAMENO_MASK;
> +}
> +
>   static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
>   {
>   	env->insn_aux_data[idx].jmp_point = true;
> @@ -3408,28 +3423,51 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
>   }
>   
>   /* for any branch, call, exit record the history of jmps in the given state */
> -static int push_jmp_history(struct bpf_verifier_env *env,
> -			    struct bpf_verifier_state *cur)
> +static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
> +			    int insn_flags)
>   {
>   	u32 cnt = cur->jmp_history_cnt;
> -	struct bpf_idx_pair *p;
> +	struct bpf_jmp_history_entry *p;
>   	size_t alloc_size;
>   
> -	if (!is_jmp_point(env, env->insn_idx))
> +	/* combine instruction flags if we already recorded this instruction */
> +	if (env->cur_hist_ent) {
> +		/* atomic instructions push insn_flags twice, for READ and
> +		 * WRITE sides, but they should agree on stack slot
> +		 */
> +		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
> +			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
> +			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
> +			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
> +		env->cur_hist_ent->flags |= insn_flags;
>   		return 0;
> +	}
>   
>   	cnt++;
>   	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
>   	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
>   	if (!p)
>   		return -ENOMEM;
> -	p[cnt - 1].idx = env->insn_idx;
> -	p[cnt - 1].prev_idx = env->prev_insn_idx;
>   	cur->jmp_history = p;
> +
> +	p = &cur->jmp_history[cnt - 1];
> +	p->idx = env->insn_idx;
> +	p->prev_idx = env->prev_insn_idx;
> +	p->flags = insn_flags;
>   	cur->jmp_history_cnt = cnt;
> +	env->cur_hist_ent = p;
> +
>   	return 0;
>   }
>   
> +static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
> +						        u32 hist_end, int insn_idx)
> +{
> +	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
> +		return &st->jmp_history[hist_end - 1];
> +	return NULL;
> +}
> +
>   /* Backtrack one insn at a time. If idx is not at the top of recorded
>    * history then previous instruction came from straight line execution.
>    * Return -ENOENT if we exhausted all instructions within given state.
> @@ -3591,9 +3629,14 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
>   	return bt->reg_masks[bt->frame] & (1 << reg);
>   }
>   
> +static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
> +{
> +	return bt->stack_masks[frame] & (1ull << slot);
> +}
> +
>   static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
>   {
> -	return bt->stack_masks[bt->frame] & (1ull << slot);
> +	return bt_is_frame_slot_set(bt, bt->frame, slot);
>   }
>   
>   /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
> @@ -3647,7 +3690,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
>    *   - *was* processed previously during backtracking.
>    */
>   static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
> -			  struct backtrack_state *bt)
> +			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
>   {
>   	const struct bpf_insn_cbs cbs = {
>   		.cb_call	= disasm_kfunc_name,
> @@ -3660,7 +3703,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   	u8 mode = BPF_MODE(insn->code);
>   	u32 dreg = insn->dst_reg;
>   	u32 sreg = insn->src_reg;
> -	u32 spi, i;
> +	u32 spi, i, fr;
>   
>   	if (insn->code == 0)
>   		return 0;
> @@ -3723,20 +3766,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   		 * by 'precise' mark in corresponding register of this state.
>   		 * No further tracking necessary.
>   		 */
> -		if (insn->src_reg != BPF_REG_FP)
> +		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>   			return 0;
> -
>   		/* dreg = *(u64 *)[fp - off] was a fill from the stack.
>   		 * that [fp - off] slot contains scalar that needs to be
>   		 * tracked with precision
>   		 */
> -		spi = (-insn->off - 1) / BPF_REG_SIZE;
> -		if (spi >= 64) {
> -			verbose(env, "BUG spi %d\n", spi);
> -			WARN_ONCE(1, "verifier backtracking bug");
> -			return -EFAULT;
> -		}
> -		bt_set_slot(bt, spi);
> +		spi = insn_stack_access_spi(hist->flags);
> +		fr = insn_stack_access_frameno(hist->flags);
> +		bt_set_frame_slot(bt, fr, spi);
>   	} else if (class == BPF_STX || class == BPF_ST) {
>   		if (bt_is_reg_set(bt, dreg))
>   			/* stx & st shouldn't be using _scalar_ dst_reg
> @@ -3745,17 +3783,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   			 */
>   			return -ENOTSUPP;
>   		/* scalars can only be spilled into stack */
> -		if (insn->dst_reg != BPF_REG_FP)
> +		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>   			return 0;
> -		spi = (-insn->off - 1) / BPF_REG_SIZE;
> -		if (spi >= 64) {
> -			verbose(env, "BUG spi %d\n", spi);
> -			WARN_ONCE(1, "verifier backtracking bug");
> -			return -EFAULT;
> -		}
> -		if (!bt_is_slot_set(bt, spi))
> +		spi = insn_stack_access_spi(hist->flags);
> +		fr = insn_stack_access_frameno(hist->flags);
> +		if (!bt_is_frame_slot_set(bt, fr, spi))
>   			return 0;
> -		bt_clear_slot(bt, spi);
> +		bt_clear_frame_slot(bt, fr, spi);
>   		if (class == BPF_STX)
>   			bt_set_reg(bt, sreg);
>   	} else if (class == BPF_JMP || class == BPF_JMP32) {
> @@ -3799,10 +3833,14 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   					WARN_ONCE(1, "verifier backtracking bug");
>   					return -EFAULT;
>   				}
> -				/* we don't track register spills perfectly,
> -				 * so fallback to force-precise instead of failing */
> -				if (bt_stack_mask(bt) != 0)
> -					return -ENOTSUPP;
> +				/* we are now tracking register spills correctly,
> +				 * so any instance of leftover slots is a bug
> +				 */
> +				if (bt_stack_mask(bt) != 0) {
> +					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
> +					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots)");
> +					return -EFAULT;
> +				}
>   				/* propagate r1-r5 to the caller */
>   				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
>   					if (bt_is_reg_set(bt, i)) {
> @@ -3827,8 +3865,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   				WARN_ONCE(1, "verifier backtracking bug");
>   				return -EFAULT;
>   			}
> -			if (bt_stack_mask(bt) != 0)
> -				return -ENOTSUPP;
> +			if (bt_stack_mask(bt) != 0) {
> +				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
> +				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots)");
> +				return -EFAULT;
> +			}
>   			/* clear r1-r5 in callback subprog's mask */
>   			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>   				bt_clear_reg(bt, i);
> @@ -4265,6 +4306,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
>   	for (;;) {
>   		DECLARE_BITMAP(mask, 64);
>   		u32 history = st->jmp_history_cnt;
> +		struct bpf_jmp_history_entry *hist;
>   
>   		if (env->log.level & BPF_LOG_LEVEL2) {
>   			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
> @@ -4328,7 +4370,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
>   				err = 0;
>   				skip_first = false;
>   			} else {
> -				err = backtrack_insn(env, i, subseq_idx, bt);
> +				hist = get_jmp_hist_entry(st, history, i);
> +				err = backtrack_insn(env, i, subseq_idx, hist, bt);
>   			}
>   			if (err == -ENOTSUPP) {
>   				mark_all_scalars_precise(env, env->cur_state);
> @@ -4381,22 +4424,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
>   			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
>   			for_each_set_bit(i, mask, 64) {
>   				if (i >= func->allocated_stack / BPF_REG_SIZE) {
> -					/* the sequence of instructions:
> -					 * 2: (bf) r3 = r10
> -					 * 3: (7b) *(u64 *)(r3 -8) = r0
> -					 * 4: (79) r4 = *(u64 *)(r10 -8)
> -					 * doesn't contain jmps. It's backtracked
> -					 * as a single block.
> -					 * During backtracking insn 3 is not recognized as
> -					 * stack access, so at the end of backtracking
> -					 * stack slot fp-8 is still marked in stack_mask.
> -					 * However the parent state may not have accessed
> -					 * fp-8 and it's "unallocated" stack space.
> -					 * In such case fallback to conservative.
> -					 */
> -					mark_all_scalars_precise(env, env->cur_state);
> -					bt_reset(bt);
> -					return 0;
> +					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
> +						i, func->allocated_stack / BPF_REG_SIZE);
> +					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
> +					return -EFAULT;
>   				}
>   
>   				if (!is_spilled_scalar_reg(&func->stack[i])) {
> @@ -4561,7 +4592,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>   	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
>   	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
>   	struct bpf_reg_state *reg = NULL;
> -	u32 dst_reg = insn->dst_reg;
> +	int insn_flags = insn_stack_access_flags(state->frameno, spi);
>   
>   	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
>   	 * so it's aligned access and [off, off + size) are within stack limits
> @@ -4599,17 +4630,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>   	mark_stack_slot_scratched(env, spi);
>   	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>   	    !register_is_null(reg) && env->bpf_capable) {
> -		if (dst_reg != BPF_REG_FP) {
> -			/* The backtracking logic can only recognize explicit
> -			 * stack slot address like [fp - 8]. Other spill of
> -			 * scalar via different register has to be conservative.
> -			 * Backtrack from here and mark all registers as precise
> -			 * that contributed into 'reg' being a constant.
> -			 */
> -			err = mark_chain_precision(env, value_regno);
> -			if (err)
> -				return err;
> -		}
>   		save_register_state(state, spi, reg, size);
>   		/* Break the relation on a narrowing spill. */
>   		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
> @@ -4621,6 +4641,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>   		__mark_reg_known(&fake_reg, insn->imm);
>   		fake_reg.type = SCALAR_VALUE;
>   		save_register_state(state, spi, &fake_reg, size);
> +		insn_flags = 0; /* not a register spill */
>   	} else if (reg && is_spillable_regtype(reg->type)) {
>   		/* register containing pointer is being spilled into stack */
>   		if (size != BPF_REG_SIZE) {
> @@ -4666,9 +4687,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>   
>   		/* Mark slots affected by this stack write. */
>   		for (i = 0; i < size; i++)
> -			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =
> -				type;
> +			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] = type;
> +		insn_flags = 0; /* not a register spill */
>   	}
> +
> +	if (insn_flags)
> +		return push_jmp_history(env, env->cur_state, insn_flags);
>   	return 0;
>   }
>   
> @@ -4857,6 +4881,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>   	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
>   	struct bpf_reg_state *reg;
>   	u8 *stype, type;
> +	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
>   
>   	stype = reg_state->stack[spi].slot_type;
>   	reg = &reg_state->stack[spi].spilled_ptr;
> @@ -4902,12 +4927,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>   					return -EACCES;
>   				}
>   				mark_reg_unknown(env, state->regs, dst_regno);
> +				insn_flags = 0; /* not restoring original register state */
>   			}
>   			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
> -			return 0;
> -		}
> -
> -		if (dst_regno >= 0) {
> +		} else if (dst_regno >= 0) {
>   			/* restore register state from stack */
>   			copy_register_state(&state->regs[dst_regno], reg);
>   			/* mark reg as written since spilled pointer state likely
> @@ -4943,7 +4966,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>   		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
>   		if (dst_regno >= 0)
>   			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
> +		insn_flags = 0; /* we are not restoring spilled register */
>   	}
> +	if (insn_flags)
> +		return push_jmp_history(env, env->cur_state, insn_flags);
>   	return 0;
>   }
>   
> @@ -7027,7 +7053,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
>   	if (err)
>   		return err;
> -
>   	return 0;
>   }
>   
> @@ -16773,7 +16798,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>   			 * the precision needs to be propagated back in
>   			 * the current state.
>   			 */
> -			err = err ? : push_jmp_history(env, cur);
> +			if (is_jmp_point(env, env->insn_idx))
> +				err = err ? : push_jmp_history(env, cur, 0);
>   			err = err ? : propagate_precision(env, &sl->state);
>   			if (err)
>   				return err;
> @@ -16997,6 +17023,9 @@ static int do_check(struct bpf_verifier_env *env)
>   		u8 class;
>   		int err;
>   
> +		/* reset current history entry on each new instruction */
> +		env->cur_hist_ent = NULL;
> +
>   		env->prev_insn_idx = prev_insn_idx;
>   		if (env->insn_idx >= insn_cnt) {
>   			verbose(env, "invalid insn idx %d insn_cnt %d\n",
> @@ -17036,7 +17065,7 @@ static int do_check(struct bpf_verifier_env *env)
>   		}
>   
>   		if (is_jmp_point(env, env->insn_idx)) {
> -			err = push_jmp_history(env, state);
> +			err = push_jmp_history(env, state, 0);
>   			if (err)
>   				return err;
>   		}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index f61d623b1ce8..f87365f7599b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -541,11 +541,24 @@ static __u64 subprog_spill_reg_precise(void)
>   
>   SEC("?raw_tp")
>   __success __log_level(2)
> -/* precision backtracking can't currently handle stack access not through r10,
> - * so we won't be able to mark stack slot fp-8 as precise, and so will
> - * fallback to forcing all as precise
> - */
> -__msg("mark_precise: frame0: falling back to forcing all scalars precise")
> +__msg("10: (0f) r1 += r7")
> +__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
> +__msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
> +__msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
> +__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=2 R6_w=1 R8_rw=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8_rw=P1")
> +__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
> +__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
> +__msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
> +__msg("mark_precise: frame1: regs= stack= before 16: (79) r2 = *(u64 *)(r1 +0)")
> +__msg("mark_precise: frame1: regs= stack= before 15: (79) r0 = *(u64 *)(r10 -16)")
> +__msg("mark_precise: frame1: regs= stack= before 14: (7b) *(u64 *)(r10 -16) = r2")
> +__msg("mark_precise: frame1: regs= stack= before 13: (7b) *(u64 *)(r1 +0) = r2")
> +__msg("mark_precise: frame1: regs=r2 stack= before 6: (85) call pc+6")
> +__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r2 = r6")
> +__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
> +__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
> +__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
>   __naked int subprog_spill_into_parent_stack_slot_precise(void)
>   {
>   	asm volatile (
> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
> index 0d84dd1f38b6..8a2ff81d8350 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c
> @@ -140,10 +140,11 @@
>   	.result = REJECT,
>   },
>   {
> -	"precise: ST insn causing spi > allocated_stack",
> +	"precise: ST zero to stack insn is supported",
>   	.insns = {
>   	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
>   	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
> +	/* not a register spill, so we stop precision propagation for R4 here */
>   	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
>   	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
>   	BPF_MOV64_IMM(BPF_REG_0, -1),
> @@ -157,11 +158,11 @@
>   	mark_precise: frame0: last_idx 4 first_idx 2\
>   	mark_precise: frame0: regs=r4 stack= before 4\
>   	mark_precise: frame0: regs=r4 stack= before 3\
> -	mark_precise: frame0: regs= stack=-8 before 2\
> -	mark_precise: frame0: falling back to forcing all scalars precise\
> -	force_precise: frame0: forcing r0 to be precise\
>   	mark_precise: frame0: last_idx 5 first_idx 5\
> -	mark_precise: frame0: parent state regs= stack=:",
> +	mark_precise: frame0: parent state regs=r0 stack=:\
> +	mark_precise: frame0: last_idx 4 first_idx 2\
> +	mark_precise: frame0: regs=r0 stack= before 4\
> +	5: R0=-1 R4=0",
>   	.result = VERBOSE_ACCEPT,
>   	.retval = -1,
>   },
> @@ -169,6 +170,8 @@
>   	"precise: STX insn causing spi > allocated_stack",
>   	.insns = {
>   	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
> +	/* make later reg spill more interesting by having somewhat known scalar */
> +	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
>   	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
>   	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
>   	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
> @@ -179,18 +182,21 @@
>   	},
>   	.prog_type = BPF_PROG_TYPE_XDP,
>   	.flags = BPF_F_TEST_STATE_FREQ,
> -	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
> +	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
>   	mark_precise: frame0: parent state regs=r4 stack=:\
> -	mark_precise: frame0: last_idx 5 first_idx 3\
> -	mark_precise: frame0: regs=r4 stack= before 5\
> -	mark_precise: frame0: regs=r4 stack= before 4\
> -	mark_precise: frame0: regs= stack=-8 before 3\
> -	mark_precise: frame0: falling back to forcing all scalars precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	mark_precise: frame0: last_idx 6 first_idx 6\
> +	mark_precise: frame0: last_idx 6 first_idx 4\
> +	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
> +	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
> +	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
> +	mark_precise: frame0: parent state regs=r0 stack=:\
> +	mark_precise: frame0: last_idx 3 first_idx 3\
> +	mark_precise: frame0: regs=r0 stack= before 3: (55) if r3 != 0x7b goto pc+0\
> +	mark_precise: frame0: regs=r0 stack= before 2: (bf) r3 = r10\
> +	mark_precise: frame0: regs=r0 stack= before 1: (57) r0 &= 255\
> +	mark_precise: frame0: parent state regs=r0 stack=:\
> +	mark_precise: frame0: last_idx 0 first_idx 0\
> +	mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7\
> +	mark_precise: frame0: last_idx 7 first_idx 7\
>   	mark_precise: frame0: parent state regs= stack=:",
>   	.result = VERBOSE_ACCEPT,
>   	.retval = -1,

