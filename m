Return-Path: <stable+bounces-104315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CF9F2AC5
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2511D1888870
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF91B415D;
	Mon, 16 Dec 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/F67V0a"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86F20E6;
	Mon, 16 Dec 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333381; cv=fail; b=c6TGcXYVdLGqFOFOFccROlsSYNGl36B66oPnZoi2WYSHk6G+WTEl0Injjt9WHzCy6WqpDDgF7Y9upvR4tpVJch+7NUguzU6oOZeUy8+VS3pKB79VzPPejY1mafQTHJFSbTsxRJlpvLg4hNZWTYafdwK0kRtqouJby0MrhOX4OoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333381; c=relaxed/simple;
	bh=IMcVwABlYlDoGShv1zs4MfP2m14oJ6i9W+DoaTnjK+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwXHoUTEPuM0zsm/aEooVERZET2I2qr6Ciq2uPYYwuILT8c8nGVW58vbsYZY8drqHZRu8nYZmKARgbWKHzhMXK3/zh6NQpSJ8BnJj+hhP74OhQlS0B6gRTUaOUG1UQknwCDtQ92h3wMegRcHQoiFtrIFZmRT/ZISHThe/FCB/yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h/F67V0a; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuGygS8dr8FeewIXX9t8v5J2z4djm4S4Ba4vXGdEi6WxXQPJEiFU2lzgJuV4eQIjGlzjMYjCzafHS1itC+Nn8KMUrBlIyix0Ms1WJbuB1cdB78LOE43r7rUud/1EJpr9Q42A0JPG3CFye3EeZY1j2AzwUznekxbW3nDA0qxp229pFmHOnNk0reC3ysYE7CV7dEz7Omg0UQX3t72pa7xVmxF1fWwTbaXZmKxwSU6Wxm8xFIF0WYr3DO9k+ldA3La0VnC0L/0otl4bqYT8drZG4WcKqFfbMimiR5bhEE/abpP+IAEXmIjyLIlBYvSN3KqmeUcCpFREVhsMGrp0GdxEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eqUZ3cuqc55lO+AMCMstCYCd6+1uP4XDVErMPoSm1w=;
 b=n7hCRAKE6JqUXufNfua47tKSWdUkHDtK0n4OLJj2vfF2HoQvCcA5i13OW7cwKEcnL7ncoZGxjwmAn44ye0MbuLBiH/AO4+ArwBEhRnRDvZG3/ZGTEUma170oCmQ1EwSYtsz7NEPEuUVAGTLcGgP8421pE+aV4DvmXiUKmkrfNX51ExpZquNcLTP0pODmQjCUEkgtAfdaJib3aLR9Q6wSKkFPBmAcxUjekr4NP5r0yU0+RhUZaHkjuzNSEUgtiMem3qazGPKSN1MF9RmtIKj54pu/dylDrzsvxLWp+FfY8ZrmsGmCno4CE5SSx4yn/vOF0LEfNl9DXtjv5bAh0R+BYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eqUZ3cuqc55lO+AMCMstCYCd6+1uP4XDVErMPoSm1w=;
 b=h/F67V0aUVzayh92ZewFxg0P1J5x6/WH3SiaBKJGOjzJcgPNdpuW3LZwCMymJnOj625yZ6UpnjpSS3QaHgacVm4W9AL+JxAni/Rf6frRtoNq1I/E8XtcOJdijmi0TcVHwDTDXTTA4JEXKciGmkzoxR/eq2OdAGc5PW7DMKOiwUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 07:16:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:16:15 +0000
Message-ID: <25eb1e35-83b0-46f4-9a9c-138c89665e05@amd.com>
Date: Mon, 16 Dec 2024 08:16:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: zynqmp: Remove invalid __percpu annotation in
 zynqmp_ipi_probe()
To: Uros Bizjak <ubizjak@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <20241214091327.4716-1-ubizjak@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241214091327.4716-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cccaa43-80b2-4ffc-8894-08dd1da18726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXQrUGw1VlhCTjZDcXczTy9vM0xjYjlwRVg3R2Zoc2ptWk96b3VQWk81R0Y2?=
 =?utf-8?B?dDQ2L2pRcnlVaGhMZ0FlS0JLZDlFZ1BBRTcvZ2lGK0gxSFhQaExBTEVaSEpD?=
 =?utf-8?B?Ym5zcU5TV01CMHhtVlRzMU14RWkxY3gzMFRVMzZmSW9mNlFuU3k3SU9iOFpV?=
 =?utf-8?B?N2ppRmtxcEF0U3NVMDEzL0RzZEVya3NURi9oSVdNMVluMEVxZG5FN29HMCtI?=
 =?utf-8?B?UUJSQlg5TFlKUTdPaHQzZTB5R1RXU09jR3dHRkJVRW12akdhMHdPalQ0SXlp?=
 =?utf-8?B?UkIza1AzZ05Nc1ZYS0R5YWhTZWxodW9jdUorMXM0TlRTUlBieGlpbHp3WlQx?=
 =?utf-8?B?eU93WjBTMHcrdlRSODRxbW1KbE9QUzRBVjlUM2tQVEY5cUVYZFQzMTQzaEJv?=
 =?utf-8?B?cG5GdGY4MDV4QXZkN1VJV3VTR0hKTi81U1RySE9IN2swZllNdHFyYXcwaEpr?=
 =?utf-8?B?cHNvUW01WkpGTFBQb1MvczV4NkdNNXpFN0lNS3pXTnZtSy8wM2NKdFNiU2Mx?=
 =?utf-8?B?SVVFSmJUK1JObTJnR1dzNjZLYythVFE4bk5nY2NkYlBHbERGcFNISEhPcjll?=
 =?utf-8?B?cmdnZlNBYm94Q2Jla3djbHpMWXowWXVzQXZJRXBqbXErMzEyYjQ5SEw4dGxY?=
 =?utf-8?B?eXJPK2IvdElaSjRoYWp5SGZJU2dBNUtMVy9ZcnFwbmt1Zm14ZTV2aEhuV2hP?=
 =?utf-8?B?a1Rvbm4rME43M1lmb09naTBMemNxdk9oNGR5am1VNFRqcXZZUkpYcDhzYVFO?=
 =?utf-8?B?NnJKRVJqNTVJYS81QnUycFV4QWVLZDZJSHkxOUEwWHFEOWJlcXF1dTVSQXQ2?=
 =?utf-8?B?c292SEVkbmNsVVBsYjJVMXdxdjVxUVVSb1RmK2FiSkNRUFJTNFlHTEg0L1ZK?=
 =?utf-8?B?WHgwN2FkaTliTHJyUDJiRTFlZjBZMDkrb2Q0SlI2R2J5OUZhRzc1MFNZNStB?=
 =?utf-8?B?bDcwK0NRNU8reDRvWlJQZ3BzWmxVaTYyd0o3NVVKUE5uTzJYS2ZUayt1OTlC?=
 =?utf-8?B?Vk9JS1VOTWRWTFR4ZFNNTzZRVkIzeVRlSmxmRUEzUlYrdmRoRjk2L3FWVndL?=
 =?utf-8?B?NlQ5bEZvT3E1ZzlQdzM0SkphRlpLNVZsZENaVnFVRU5MWHVNRnF1Q3M5czEv?=
 =?utf-8?B?MjRhVnNzM1dQb3ViaG5DWDlBNU5SY2dzRTNRY01JbUhCaGp2NS9Ebm9XYyt0?=
 =?utf-8?B?bXlZeEZCdlliTzZDR0o2WkVpbzVCczVza1EwekxINitXK3p6KzBFTFFnNG1t?=
 =?utf-8?B?V2EyNS9IZUNqeHVGUEM3YU12UjgveE1qdldLMkpiMHR2RDIxMVBXTktGeE9N?=
 =?utf-8?B?UXFRT3RWS0lGRWQydmJtSXZ1ZHpmam5qQnpyQjNkb0VGVGFXTlpNaklqVm0v?=
 =?utf-8?B?TEdQUm9MZko5VXAwNHpUM25kb28vaHI0M2RBUnBmMnd5VFczendGL3djS0FL?=
 =?utf-8?B?b21rVFBFNXV2TnU5UGNsQkRmaTZ0V1FpTkxWdDllKzlpd3J2VXExbnA3UGRm?=
 =?utf-8?B?R2NHK3lYRklEUnNCMnp6eVlJc0grdVk3NVg2ay9PT0dMaWJDZ0laTWlzNlFL?=
 =?utf-8?B?K0dMWVZXSkhQa0x2eGVCZGZXVVNhTXNFY016K21kK25tU3F5S1pYR0tKRFpo?=
 =?utf-8?B?WmdEeHZjRTJpcUh3S3pBTzJqNWtnUkNuejI3WTZwV3hkWFp4RDBURCtOZllS?=
 =?utf-8?B?eVpKOXVSbXltcDRRY0VhWjFxb1FxeXNDSlgvNDk0RmROOFdmVGs5eFg1ZlMy?=
 =?utf-8?B?b09QWHcyVGg0RmdOVXRrMTlOYis5QWtqbk8rWWZEOEphT3FHOWdLckZ5aHRT?=
 =?utf-8?B?dEdPNVU3UkJFZllmS2JYd0xWSlFYSlZqQ05Rd3NFT0pMSDJITm11dUNzcUJG?=
 =?utf-8?Q?fNCVNLs5zeJDh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGNpZmsxZENzcDhPcVgxVTFhOUdVUWVPbmtpYWlkWHlZTCs3K05KWlVuUmMz?=
 =?utf-8?B?aTlnb2g0SHhwR2owUGZzOHIralgwU0JxbEVOZmMrd001blAwanNldGh5dlEr?=
 =?utf-8?B?bkZZUXVOdGZjVytQMjRmTE1hSGEraVZHT1o3UXk2U2RIZ2FQNHp5Sm1Yb2JV?=
 =?utf-8?B?dk5CL2VhV29Ba1p3TEdCSmFVYWt1TTlNVlZmSUtESndJU1V0RUxiSWFXU2Q4?=
 =?utf-8?B?cVY3NHJvWEdoNW9zMmdObURCdXB2cHArVjhQUmYwUU53eldWbDZuemZ3SEgx?=
 =?utf-8?B?R1JDWFJaTEZGQm9RNG9Xb2FyNmtES1grbE5uU2xsZGlhYTQwNDBFRHV1VDBH?=
 =?utf-8?B?S1BwdndsZmUxWUdwOTlaRWlscXZKcmhMa1VNaDJ4ekU4YlMvblhST0RlcHAz?=
 =?utf-8?B?MHJKcW5yOXlSMCtIOGxiTjltd2ZWSzdncmhqYzFoNlFURUU0SlNyMHUrQkQx?=
 =?utf-8?B?Qks1UW1Wa1U4UzZiTnJIcmJyVHYydGlHeTdmUytoUVNtdHkvbEYzNGFRVFN5?=
 =?utf-8?B?Vms5MXFBeVVJc0dGYktxZHEzYzZGTHREczBnVXJvY0hKZ3pSYnVKdjZUMEVj?=
 =?utf-8?B?YndLT1BBeG1idlFycytXam1BeWtvcEx4bjlEWGZYV29TUnZTMnRIRkYwMU5r?=
 =?utf-8?B?QTJidGFaZVA0ZERFSDF5TFZDVVZrVTFvSkhXWjlKNFhlMW9sQUVkcCt3NElT?=
 =?utf-8?B?TjEzR2FrS0xJdTBVYzYyd29QRUlKYno1RGI1UnpnNkhRYXpJSjhKRzd1Qita?=
 =?utf-8?B?NWN5R1JBdzJ1UmxUTGM5LzFjTEExSkVMeXd4SW1ZNDZZRHZsb08wQktQQW85?=
 =?utf-8?B?RlVGWHB6enNFL1ozQVUvREtwblYzbWRBODVCaC9oeFZCQS9TcWVkcEMwVFNU?=
 =?utf-8?B?ZFZ3S2x5SHgzYmxMalpibGVOOHFwN1d1N0w4SVFOVUJaaDlaSkxlZ09BajJJ?=
 =?utf-8?B?cEdHVFRZQ1BMWGRRVUMrYTJuNTNYOXpaQUh2eG4rbkpFYVZXSFQrY2d1bUFq?=
 =?utf-8?B?OE1OUE4wQmdKQlNBaWxuNnVPWk91M0VweWpMMGJZOFdzR3FoRWFIR1FPQnEy?=
 =?utf-8?B?aFRnd0ovclBSR05uSlJIVXNlOTUrTC9zWVBzMmZYak1CKzFjTkJqTTQrRnlz?=
 =?utf-8?B?cko3eW54Ty9hREFrL3BDNFJUbWtZeVRhNTRoaVpIUXhDQVBWNEtTYXhtSldO?=
 =?utf-8?B?RnRaMnhIQUdGOU1EL08xOEVYbkVEaFZYVFI2VkozTTNHaGhkamFreXQzdi9D?=
 =?utf-8?B?UVFKc0VINUhhRXdqY2lGaERMS3JNclBuT0hvY0lTbVhYVStkY3ZDVHNSV0Fn?=
 =?utf-8?B?NDdieVgybjdzZ1E4eitiUXZaalUzWGlOcDJrOXNCTS90K01hZTdGZHFsTTRX?=
 =?utf-8?B?dC90MGVUenpxdnlyTGMzdmlkQW9WRmtOdUJXTmxKSW8xRWlQMG9XVHZYMUY3?=
 =?utf-8?B?RjVQSHo4WnpnZnI2OEhsUkdBcitHU3ZqbFl1bkdSQjh3UVhrT0c2cmFXdHF0?=
 =?utf-8?B?dHBCVTJmMnhpSlBHMFNDeUZ1bjRvb2dkbG0yN1NmRG44b1hPVmNzSHNKRlRk?=
 =?utf-8?B?Y0ppek8xY0NqTGVFNGd6UHJVNWtiRDdFRzhWbitsVHlCaTFuYnk4UWJVUUZV?=
 =?utf-8?B?cUJKa0kwYkw5bVM5Zm9WNlJ0VkhYUG1MaFBMVTBjY2JOd3hFZmZFUmRmUm1Y?=
 =?utf-8?B?Y3NpT21vbWRlbTE1MEhTZWZiWVJMQW9LOStHbU9kSkltTFlYNmo1LzFKMFFW?=
 =?utf-8?B?WlRiNm5KSHppVzd1L1ZNd1J4ZTllbTZoNHk3TkMvRjhxRUdsRE8rbHl3UlBT?=
 =?utf-8?B?QXBudWdhdjcxTXZYY3U5RzRIeXphQjJkZ1RaRG1CM2JWd3UrSm1VUG5aZG5Z?=
 =?utf-8?B?RHk1bkxDbzFKRTFTRmxSc0lJTmFwakNCU3JSKzhZTXBIam9QVjM4aEtKVXQx?=
 =?utf-8?B?aUFjaWVkeThibGxQc1hBWFRRd1B6WWdDNnZmTzJHcmVMWDRoV01CMTFwTGVo?=
 =?utf-8?B?TG1rR2U1ZU5IR3pFNFI5NHNmK1RMbTNtb0lEY3ZqNG0rSndxUXhyWE5qU2xz?=
 =?utf-8?B?T3NlVkp5dlBiSjdxd29kZmhIVWQyN0NZV21ZTkRuM2gzeU52UmNLYUdCWkZW?=
 =?utf-8?Q?qRfthurFTJC9mKyPOvhhQOIxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cccaa43-80b2-4ffc-8894-08dd1da18726
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:16:15.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmPHikXUuAGi/SalGPG5+YCCHpkTU2g6+NkmkcdhAvzt10Cozal27HHvsAv6QG4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436



On 12/14/24 10:12, Uros Bizjak wrote:
> struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
> so it should not be annotated with __percpu annotation.
> 
> Remove invalid __percpu annotation to fix several
> 
> zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment (different address spaces)
> zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata [noderef] __percpu *pdata
> zynqmp-ipi-mailbox.c:920:15:    got void *
> zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3 (different address spaces)
> zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype] *out_value
> zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
> ...
> 
> and several
> 
> drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of noderef expression
> ...
> 
> sparse warnings.
> 
> There were no changes in the resulting object file.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tanmay Shah <tanmay.shah@amd.com>
> ---
> v2: - Fix typo in commit message
>      - Add Fixes and Cc: stable.
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index aa5249da59b2..0c143beaafda 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *nc, *np = pdev->dev.of_node;
> -	struct zynqmp_ipi_pdata __percpu *pdata;
> +	struct zynqmp_ipi_pdata *pdata;
>   	struct of_phandle_args out_irq;
>   	struct zynqmp_ipi_mbox *mbox;
>   	int num_mboxes, ret = -EINVAL;

Tanmay: Please take a look

I think this patch is correct. Pdata structure is allocated only once not for 
every CPU and marking here is not correct. Information from zynqmp_ipi_pdata are 
likely fixed and the same for every CPU. Only IRQ handling is done per cpu basis 
but that's it.

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal


