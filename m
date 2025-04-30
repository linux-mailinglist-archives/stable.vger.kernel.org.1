Return-Path: <stable+bounces-139124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB7AA46EC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1794D9855A6
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ABE21CA1E;
	Wed, 30 Apr 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="okEkWw8e"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190F221F27;
	Wed, 30 Apr 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004901; cv=fail; b=nCGj+rz7AciopvCoucWKjKBr2Q6nplHtSE6hMHhLgnqCX8l/CQokQOzdQpbWphQtjzyJO3Pf10qGWTlS7Ohrsk7kio+jgmbvvt2YKnHiQS0ibbsX4DsdyBirhca0r59DRokwB1AmaNOEw8Z8xnKDTnclSSvLVw8P1G2D6FvLHtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004901; c=relaxed/simple;
	bh=AFN9PoPOopX7t5JizsHHEN3GFrClvGCrliOLeehnhzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egjOjwOzmVKrylXF2e7EXDJ1pFO6P6m4oTrvfRg8O+VcLfw3/3mr36TbRaHBH9uBfZ8ly6uY9SAkwCZTAcIDhAn2TKxboGg7QFCGxqA8cTZ8amBY5iUAJClWUKjc4iHP/9OmSlJlfgLUV7eDp1Bp3bhXxgbziZthaENqLkvBuKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=okEkWw8e; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgQJKs1S1h01q0fMdC7lSnm8TEbomJIHYT18k5QnX0/IMYDKjIWOlaYUy8KuKyAHvMYnIk2luGzkU3N58riYHXHk7RFRLJg7Xx19nr4AvZU3cxIhDvisRBqIdq3lT5R4QuzvYrZELOhjRUPU5HmYgNAnSHVRs6e8Mr3l+M6d0sOnsG1d2sQB3AiR+wZ3TPn80cesOlCeMRbpgSbejukf/7B+r4lKwq2qPHjb5QKa2q4VzZdcTooXGFNvQ0qx15mjkQoAg5lJ/JgmWE6eLHZsH/QfsxVkB4F2l4BQv9P7nq2cMbWt+5USugrT8i8I8FG4B5Ssrm3SwtFbBTu72Jp4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCMkMVnQuNspJ3mIBdgoKNyjifFVods7xrapzIHTeQA=;
 b=O3HBUK0ac3tCsZnOfKxBsJ8DHKt73kaLnOaxYzvTB/9i/eLETKRawDvbBqnpgme3tX5COTH+ZlhpAxwycxGGnadrM8hqhybhPoDPLgNSUXlHbKoRNbjIw5ZdbQTgdZ1L5P1T0KNMudJYPNRJP+aaNK3onpA6tkLpJSz584KysK8tE7Qevh26ddtClbm8XOQuMet5Bn6obFtSrPwoMMeY4KNdCgpg7Ie6bC6YmpHQJocbKjU4OEyKi3BiAy/44selKp1ygHYDJ+aKB3LMFWeB5InPlgY3C401PnN97roAYEU3O3ware02G5dlSMPACrHxf3UnU+DoRfwI/nM0fVA0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCMkMVnQuNspJ3mIBdgoKNyjifFVods7xrapzIHTeQA=;
 b=okEkWw8ews/aQE2/ifYcrAEgqH2BNU3eUMZmOzOP6MQBfJn8xptyn/RsVfpM6+WY6bL2v2Rgr/8DqwdBT+Azm3xjqKDCUdr8HvBMT9jvx7qsPddJ2nTTS6TXFghlK5eNo33+dQcf1dAT3vdeKc/BVu6gE1Q7+e4i2/A3FKZrcvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 09:21:32 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 09:21:31 +0000
Message-ID: <a7856b43-a198-477b-9a3b-d32b1730b76c@amd.com>
Date: Wed, 30 Apr 2025 11:21:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/sev: Do not touch VMSA pages during kdump of SNP
 guest memory
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 thomas.lendacky@amd.com, hpa@zytor.com
Cc: kees@kernel.org, michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
 ardb@kernel.org, gustavoars@kernel.org, sgarzare@redhat.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250428214151.155464-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bbd32c-9eee-4b92-949a-08dd87c864dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdpZUFLQ29YbGJ6THZOaTNWRkxodnB1MlIwb3RjNzlseVA2OUdDVEhxWlJF?=
 =?utf-8?B?dFh6VFFJUkVuaTd0M0ZVK0FTUHRaUE94OUZoczZEb0pyaTVLOWFvS2FpSlEw?=
 =?utf-8?B?S2M2ZzlySmxPTFBac0lyc0VTbkMxY0RML1krSzVld0tOUDFPWmxsUWZRZHhZ?=
 =?utf-8?B?R2szZUpyQkRkc08wajhSS01EcXk1TThnRU9UNlF1cWQ3RTRYcFZ2Qk1sbFU3?=
 =?utf-8?B?ZDVVTTJXRGNXWWpXNWI1UkdNYkVFTzhyWDVjL3F4eElWcDA1QU5Jd3Nqa3k2?=
 =?utf-8?B?Q1B3UmJ2MHJPb204M2syU0kyZGhIUXR1Q1F5aFpjNzNGQlhOWm9rM3dud25P?=
 =?utf-8?B?SDFWZUhjMm9qVEdyY1pyZnNJd2h0YlhjdTl4RFNZcytSeFBDbGF1NHQza2h6?=
 =?utf-8?B?MDJaT3VkV215TzdzSWRxRmg5WWoxM3g5Q3hxd2tESVBwbDRrWUpCRDFqV2Ev?=
 =?utf-8?B?LzFRVVZVTnYvSVgyeWhrSVJwOTVsNDlNWng3S2VHQWZKdGF4ZlpEMmRQcVQr?=
 =?utf-8?B?QmNoM0FmRVFXd3JzWGRoVWdlZ2ovck91UkRCU3loaDFOSndveWRRcHRzZ0xL?=
 =?utf-8?B?OFNDOHlNWTE3OFFHSk5KM2pId0loeEJOL21FZkJ3WWlBbWlQVDcrU1VTN1BU?=
 =?utf-8?B?a2ZkMmcvUEVyQU1DVU5xSVEwb1FLMzMzYS9BMzBrNUpTaEV3eS9lVnV4eSta?=
 =?utf-8?B?ZXZVamlRTFlTWUR3VFR1TmxUaGdRWHZoL00wbGphL2pBSC9HQVN5MGpXWE9a?=
 =?utf-8?B?dk45WHRseU5wQ29YMGpMd2FRRzkvclBZVXZydEVYYXE0WHlIdG83RkFmWWV6?=
 =?utf-8?B?dElrSEFZZVAwcXFTZ3VVMDJsaHBEcnJUamN2MXVmZ3l3dE53SGJpQkJld2ZC?=
 =?utf-8?B?Y0dlY25EVnVpL1dSN01DQnBwUS9WY05HbFNZa01YdlJNemxTQS9UcTJGclZ0?=
 =?utf-8?B?bUtxN2RuQnJyM0lGb2hlR0svbURhcFBtTXBRaDdTcDZzdmhUcUJZL1FlSzk2?=
 =?utf-8?B?bnZ3Q01vcEh5U3hyenFtUnhzZ2o1VmNPdGVqT21kYWcrd2hMbTBuK1ZPRmFl?=
 =?utf-8?B?cXA0TnhxbkZMeHppeFh3aEpKaVhKc0dLZnVUZUZiY21KeXkwQXZDZlVHbTRE?=
 =?utf-8?B?aW5XUWpxOVUzNW01bG1JeGlxdW91aE90VDZiYUlscUp0V2xqWkN2UVpYUkhO?=
 =?utf-8?B?dzM0bkU0WEdBdmxKL2RpcTRFVDgyRjBoMTlvK3lIT1U3MlNMbzZJc0ZqN0Ex?=
 =?utf-8?B?eTd1WTZpOU1ldnBVSjExd1JwMmFJSmhaRnhXSlNhdFFUOHJiaklHYmJoRFZj?=
 =?utf-8?B?UFBQbFBvSllrcjB5ZHJiSU96WmdNYlkrREFvZUoyQkFuaWZ1VklaZHBsdVJs?=
 =?utf-8?B?YTN5TVRldW5vNE1LOWszaVJJMDZNYmZ2VXVDRHU4aGZ3M0VCelNRMWJJSC9v?=
 =?utf-8?B?VEdSTkxGMGlCRWRzYWlaWHFFd2lzKyt6b2ZMcVNBVmc3Wnh2VWkrcDd5aENa?=
 =?utf-8?B?WHM4b3NFLzFZdmg1WXVXRWg0bnV4RXpuZTZINkFMc1RWc3RqU1BPTER6VGxG?=
 =?utf-8?B?clNEYVA1UExXS3F1US9VVTRPazNTNFFkM1hwZHFWbFJQRTRiQzFWSXRKcGMv?=
 =?utf-8?B?VnVERmZJL3dnOHplamp1YU9ZcnQ4U0p0MXBHQVB2TERIbndSVC9XbzhUMHNt?=
 =?utf-8?B?WEFyVFMzajRXeGFuOFB5Wnlub1FGL24wVUxQd0plMzF3ZzZmNS8xL0dua2ty?=
 =?utf-8?B?VkJ1d2crdFVOcllxY20zZVo1VHVLYTZteXFuN2l0RWllN0NibkFkSU9Mc3FG?=
 =?utf-8?B?TnRUYTdxS2NyRXMrc2QrTGx6N0VwM3JmR3VCOEpDUmZnS1FyY1lNN3FpTHlU?=
 =?utf-8?B?Ukp1SmY4SldHZ1JLOUhBajltcHpSNFFaM3RTcWNMQ0x2TVk3NkdtV1Y0eWRq?=
 =?utf-8?Q?mF/ieuMjQjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anJyU1FOc3BkNVZPeUMxTDFmR1Ura3ZpOHV1QU1rMGoxQ2RPOWpqZmo2cFVC?=
 =?utf-8?B?ZTQ5OUd5WW01dnZEcHZzMkc0aHBuY1IxWUVWU0hZVTQ4cGJ4MXhHSnIrdkF4?=
 =?utf-8?B?RmlnRmNaRnA0Z0ZZbkpFOWdscmxMSUFWTDA2KzUvSlJybEFGTzN0NUhIdTZv?=
 =?utf-8?B?NUJFeEtaa05zRjRLSTFyTjVWTVZFZS8zeXdpTVpISHNCcnVGN1kyK0g2bHJp?=
 =?utf-8?B?L3hXL21nM2FyOUlBYlVLelc5Vkt0RUorM2phbytxTTIrY3l4SERtazc5bXZR?=
 =?utf-8?B?b0d3SUNPZ0N2b084WkE1bXRySEM5ekRTT0NSVlgwQTRMd2ZZM1dHbEkwNGJp?=
 =?utf-8?B?OHhFY2RHNHp5SFBoS3NiS2l0NFQyN1p4K1dvdWRVR1YzdzZwbUYvWVU1czFC?=
 =?utf-8?B?TzZiSGNGWVh0SzZ6eldpSDFTZGQ4TEczbUtZUnVsc2VoVStpbGFIMWdocUFO?=
 =?utf-8?B?NWdtL3h0VHpiTGFCU0dpMEFacUV5VFEzRFB1bytJQ1EyVEdLaUhRMTkrU0NQ?=
 =?utf-8?B?SVBBamZSN2V0c1o3SXcyWFJPSnF5aytpWHlrZVIyRnRmaDIvVEtJRkQ5WU1q?=
 =?utf-8?B?Q21BSXBWZ25FM1BWRERVVER3dTlkMVl4Ni8vRnQ3eTdseW9CMFdZMHhkcVdt?=
 =?utf-8?B?NnliMi9NV2Q0MHZ6aDg2UFB4aGY2WGZKMmRjUkxOSmU1dWs5MzB3S05MK1FM?=
 =?utf-8?B?bzRzcE43ZnBLd0VBQ2g3U3RwaGpVcjRhd1Q4OTBSWGxsNUR1b0IvUU9RQkZW?=
 =?utf-8?B?dnBLZGZJVmpoQnNNVE5wLzRWMDJtZWk3T1NJeUtjdTNmY1F2YzVYc0Jpdnhh?=
 =?utf-8?B?Nzc0M2tUQTdSbUNjTjdFSnRQWWptOUs4T0JGWVY0YXQwMUpuTTQzU0hYcEJa?=
 =?utf-8?B?djd0OEE4YXBpM1FKQjUrU2pNcmtMV3BQdWk1U1NaUjN6ckRvVWRJQ2pRK1ZK?=
 =?utf-8?B?OUZ0ZjdYcDNhaWdpVkhHaElPUjRXejVERnp6OUUvN2xDQ3VxbW5uYnhrTkJj?=
 =?utf-8?B?RkhuNy9YQTBqVDBjbHpha25kNUYwSDN2TktEcTlleHJsTzAwTmk2VXpIS24v?=
 =?utf-8?B?L2VlYXJkRXVkVFpacDFEeUtzcWxwU0lvUUlva0Rsbm95NFFBYjl0a0duNEYx?=
 =?utf-8?B?WVdkd29wSXNyYlh3aml0cUJzMFZac0FDRDJIcUdheW9SRk40OTlXbEYwZFdu?=
 =?utf-8?B?QWNTSUV3dWJPVmY3b3pJQ2s5dlNIRVduYW9OTWRZZ3c3TVA5M0VqTWFTbVBk?=
 =?utf-8?B?a0t4UWl2K0RYdmt6L0cvUXJ1dUlpM0JMbmNadkExT0dLZ0Z4dGJ3aUN1YkFq?=
 =?utf-8?B?aEhJc2VSNkxvZ2lENmFETXBEMmhRTlpkR0FXMDBiVllOVHluZGZ4RGhZSDA4?=
 =?utf-8?B?bUZ5ckRrU2hZQk5XQ3ArRjNHYjEwTkxBNS9PdTB5T0pES25DazNZcjJkNjFC?=
 =?utf-8?B?T1F6RUtycWVYTTErYnFMR09PSjA4YjJCZ05BVmQ3NjJpbXNyZERsc0dsSjFN?=
 =?utf-8?B?YmNGUXpJRnFiSVE5K1p6cTBXS1VzaHFmVEpERzZoa2hrM0xva1dMdVEyb1hD?=
 =?utf-8?B?dmE3U0tiMEtWS2o2MUhxUm5Td1J4UDFKZ05MZE9lVkthNXhCUVI4MlQwZVlt?=
 =?utf-8?B?dlZsZHNVdzdDcTlPcnJPaHVWY3IrNTNBZ2tmbFlZOElTRnBoKytRb2pGc2Yv?=
 =?utf-8?B?akl5bDh0Ly9iUDNoZUI3dzQzZndsM3VFWSsrV21ZQ0JxT21lMU9Od05XbTg4?=
 =?utf-8?B?dUhTTDA3bXlKWGdvMG9JazlidDN4M3paSlFHSHZWd3BqWk4vVWFRZjJJTEdw?=
 =?utf-8?B?cVlSL1cxUGo1OGFWVkZqQytreTQ3TW5xSzBMMGN3QWJhRkl0cE9zVnVYZmNT?=
 =?utf-8?B?dm0wQ2gvaWhoSE9CQ1V2L1BFZVNtVGorRTBlRHB4aWVieTBhb2dWNC9ZbjU4?=
 =?utf-8?B?ajB4UHRHN05nb1pobE9BZERuQk85ck5WS3VXV1dTaWhkSkV3SFU4MU1qMWMy?=
 =?utf-8?B?UnB3eSszaWdHd2dmbkRGcjR6dEJTcG5jNG9JeU1kYXJlT3VZTHZsMndEdEhT?=
 =?utf-8?B?OUQwcU1UQ2l1WmVGbFBJV25BUW5pVFJDazdGN3padndvMEZPL3JHbTU1dUcw?=
 =?utf-8?Q?URAa3W1FyhePIS5voB79WBHqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bbd32c-9eee-4b92-949a-08dd87c864dc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 09:21:31.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV2yjzelBDaVAXHR15q2qD2ZcEBo7TjZ8GTO9wSwbyEqTkIrS+aqIRBstyZYV8A0qVzrLCNArpXlA/JnwY4GmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1


> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running and subsequently causes
> guest softlockup/hang.
> 
> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/coco/sev/core.c | 241 +++++++++++++++++++++++++--------------
>   1 file changed, 155 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index dcfaa698d6cf..f4eb5b645239 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -877,6 +877,99 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>   }
>   
> +static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	int ret = 0;
> +
> +	local_irq_save(flags);
> +
> +	ghcb = __sev_get_ghcb(&state);
> +
> +	vc_ghcb_invalidate(ghcb);
> +	if (event == SVM_VMGEXIT_AP_CREATE)
> +		ghcb_set_rax(ghcb, vmsa->sev_features);
> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> +	ghcb_set_sw_exit_info_1(ghcb,
> +				((u64)apic_id << 32)	|
> +				((u64)snp_vmpl << 16)	|
> +				event);
> +	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +	VMGEXIT();
> +
> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> +		pr_err("SNP AP %s error\n", (event == SVM_VMGEXIT_AP_CREATE ? "CREATE" : "DESTROY"));
> +		ret = -EINVAL;
> +	}
> +
> +	__sev_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
> +{
> +	int ret;
> +
> +	if (snp_vmpl) {
> +		struct svsm_call call = {};
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +
> +		call.caa = this_cpu_read(svsm_caa);
> +		call.rcx = __pa(va);
> +
> +		if (make_vmsa) {
> +			/* Protocol 0, Call ID 2 */
> +			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
> +			call.rdx = __pa(caa);
> +			call.r8  = apic_id;
> +		} else {
> +			/* Protocol 0, Call ID 3 */
> +			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
> +		}
> +
> +		ret = svsm_perform_call_protocol(&call);
> +
> +		local_irq_restore(flags);
> +	} else {
> +		/*
> +		 * If the kernel runs at VMPL0, it can change the VMSA
> +		 * bit for a page using the RMPADJUST instruction.
> +		 * However, for the instruction to succeed it must
> +		 * target the permissions of a lesser privileged (higher
> +		 * numbered) VMPL level, so use VMPL1.
> +		 */
> +		u64 attrs = 1;
> +
> +		if (make_vmsa)
> +			attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +	}
> +
> +	return ret;
> +}
> +
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
> +{
> +	int err;
> +
> +	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
> +	if (err)
> +		pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +	else
> +		free_page((unsigned long)vmsa);
> +}
> +
>   static void set_pte_enc(pte_t *kpte, int level, void *va)
>   {
>   	struct pte_enc_desc d = {
> @@ -973,6 +1066,65 @@ void snp_kexec_begin(void)
>   		pr_warn("Failed to stop shared<->private conversions\n");
>   }
>   
> +/*
> + * Shutdown all APs except the one handling kexec/kdump and clearing
> + * the VMSA tag on AP's VMSA pages as they are not being used as
> + * VMSA page anymore.
> + */
> +static void shutdown_all_aps(void)
> +{
> +	struct sev_es_save_area *vmsa;
> +	int apic_id, this_cpu, cpu;
> +
> +	this_cpu = get_cpu();
> +
> +	/*
> +	 * APs are already in HLT loop when enc_kexec_finish() callback
> +	 * is invoked.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		vmsa = per_cpu(sev_vmsa, cpu);
> +
> +		/*
> +		 * BSP does not have guest allocated VMSA and there is no need
> +		 * to clear the VMSA tag for this page.
> +		 */
> +		if (!vmsa)
> +			continue;
> +
> +		/*
> +		 * Cannot clear the VMSA tag for the currently running vCPU.
> +		 */
> +		if (this_cpu == cpu) {
> +			unsigned long pa;
> +			struct page *p;
> +
> +			pa = __pa(vmsa);
> +			/*
> +			 * Mark the VMSA page of the running vCPU as offline
> +			 * so that is excluded and not touched by makedumpfile
> +			 * while generating vmcore during kdump.
> +			 */
> +			p = pfn_to_online_page(pa >> PAGE_SHIFT);
> +			if (p)
> +				__SetPageOffline(p);
> +			continue;
> +		}
> +
> +		apic_id = cpuid_to_apicid[cpu];
> +
> +		/*
> +		 * Issue AP destroy to ensure AP gets kicked out of guest mode
> +		 * to allow using RMPADJUST to remove the VMSA tag on it's
> +		 * VMSA page.
> +		 */
> +		vmgexit_ap_control(SVM_VMGEXIT_AP_DESTROY, vmsa, apic_id);
> +		snp_cleanup_vmsa(vmsa, apic_id);
> +	}
> +
> +	put_cpu();
> +}
> +
>   void snp_kexec_finish(void)
>   {
>   	struct sev_es_runtime_data *data;
> @@ -987,6 +1139,8 @@ void snp_kexec_finish(void)
>   	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>   		return;
>   
> +	shutdown_all_aps();
> +
>   	unshare_all_memory();
>   
>   	/*
> @@ -1008,51 +1162,6 @@ void snp_kexec_finish(void)
>   	}
>   }
>   
> -static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
> -{
> -	int ret;
> -
> -	if (snp_vmpl) {
> -		struct svsm_call call = {};
> -		unsigned long flags;
> -
> -		local_irq_save(flags);
> -
> -		call.caa = this_cpu_read(svsm_caa);
> -		call.rcx = __pa(va);
> -
> -		if (make_vmsa) {
> -			/* Protocol 0, Call ID 2 */
> -			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
> -			call.rdx = __pa(caa);
> -			call.r8  = apic_id;
> -		} else {
> -			/* Protocol 0, Call ID 3 */
> -			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
> -		}
> -
> -		ret = svsm_perform_call_protocol(&call);
> -
> -		local_irq_restore(flags);
> -	} else {
> -		/*
> -		 * If the kernel runs at VMPL0, it can change the VMSA
> -		 * bit for a page using the RMPADJUST instruction.
> -		 * However, for the instruction to succeed it must
> -		 * target the permissions of a lesser privileged (higher
> -		 * numbered) VMPL level, so use VMPL1.
> -		 */
> -		u64 attrs = 1;
> -
> -		if (make_vmsa)
> -			attrs |= RMPADJUST_VMSA_PAGE_BIT;
> -
> -		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> -	}
> -
> -	return ret;
> -}
> -
>   #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>   #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>   #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> @@ -1084,24 +1193,10 @@ static void *snp_alloc_vmsa_page(int cpu)
>   	return page_address(p + 1);
>   }
>   
> -static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
> -{
> -	int err;
> -
> -	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
> -	if (err)
> -		pr_err("clear VMSA page failed (%u), leaking page\n", err);
> -	else
> -		free_page((unsigned long)vmsa);
> -}
> -
>   static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   {
>   	struct sev_es_save_area *cur_vmsa, *vmsa;
> -	struct ghcb_state state;
>   	struct svsm_ca *caa;
> -	unsigned long flags;
> -	struct ghcb *ghcb;
>   	u8 sipi_vector;
>   	int cpu, ret;
>   	u64 cr4;
> @@ -1215,33 +1310,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>   	}
>   
>   	/* Issue VMGEXIT AP Creation NAE event */
> -	local_irq_save(flags);
> -
> -	ghcb = __sev_get_ghcb(&state);
> -
> -	vc_ghcb_invalidate(ghcb);
> -	ghcb_set_rax(ghcb, vmsa->sev_features);
> -	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> -	ghcb_set_sw_exit_info_1(ghcb,
> -				((u64)apic_id << 32)	|
> -				((u64)snp_vmpl << 16)	|
> -				SVM_VMGEXIT_AP_CREATE);
> -	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> -
> -	sev_es_wr_ghcb_msr(__pa(ghcb));
> -	VMGEXIT();
> -
> -	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> -	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> -		pr_err("SNP AP Creation error\n");
> -		ret = -EINVAL;
> -	}
> -
> -	__sev_put_ghcb(&state);
> -
> -	local_irq_restore(flags);
> -
> -	/* Perform cleanup if there was an error */
> +	ret = vmgexit_ap_control(SVM_VMGEXIT_AP_CREATE, vmsa, apic_id);
>   	if (ret) {
>   		snp_cleanup_vmsa(vmsa, apic_id);
>   		vmsa = NULL;


