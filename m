Return-Path: <stable+bounces-62627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90789401CF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 01:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900E01F2319B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29458145B24;
	Mon, 29 Jul 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m5BPXKU0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686038061C;
	Mon, 29 Jul 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296727; cv=fail; b=u/LMfWpMxijkwBrPubXgQ0N80+z436BPbHCa5foexz+1zjqWZTjbYsurPP4o9QUzII4M2MYlqswkNPgYavzUCEpWiDFTXfLcvlj4rouF/9zR3xQ+me5SRiXQHZPkuYa17oVgbghO6kMtZ/aL75ayZh1XYGS8DTwKHDZvtNT9Fi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296727; c=relaxed/simple;
	bh=yudc5gBDmC0ZTpia+35u8kt+nsy2HGaV5CbxQqW3YQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/T0XSflNH3EPAonYqAnYlwOqHkNuLUAmiAWRhXcpe0YPA4tm1jALjVrm0JI9Ev5xg3EFliuHs6qXgYJCgMyp0cntM20AU9Fy8A9vovVZ67k/lvY6C6R+7sT++jUjaEdAOwgKiqdNKLCV4LCLHnLjV2p4yKGnqkH2tgHayV6hgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m5BPXKU0; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leF2Vqdu4qxaZFIqrlkUEE05xDhpf/WqbgVCcCkK7NlRGk9HLk7b/10tEe7hipJG8J5790TUpHTkMrn5WgcarbBwGEVTzcnktVGtD+Xf227BaIUNvuSq39seNdWX+QYuJYUmU73deqlwPB4wBsEHjmXv81upPKju9kcN8MFWbaqKo6UfJARLmMiUbLlrcANB9skFBtWeDI5RrqgOmU7Bg2Pw6lolhu0ZTYswYLUfPpZd14wCbpJIZNtxjo3BtulPj+rArnJMoAOBK2SwXtSmATmunOk4COkPMb26GcJWjdpcJAvFzoru5MjMrX38Idf8U5tzxxBAkjii3+3AusggYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8tUMQQLWSxhXy9pKJDBL+05rbH9usXfZzH/NvklZYs=;
 b=ebuIuQXJw7zLeTTJT2O2BF7qkSiv5tBj5Wg7KsxEQ1gwdpsu2DV7P3fJN1Z7tcqudM1JBIIbrBepKQzms63AkBQKWen2yf0LJ2McGk8YdAOA8+lmkXjdCGwgPl1EuYOgr9LXovFZBnD7Vgk/9siFSbNpqPRI2IHszgqz6Z6QMM9TIe9lMUOkrQZ/uYX3Zb49wGUdmnseRLkXrdUVUonIMrdTDC/vWMQd8TMgkT+4E2vEEvQT6cTQnCnnFJp+88iupW/7fQx2icWejb1NNHYzEbsg6dzbC8T/1JUPkiNiMTxljOwY1vSiMknnLyA6ZJIISlwVxCFB0wTLO9Wx+tKTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8tUMQQLWSxhXy9pKJDBL+05rbH9usXfZzH/NvklZYs=;
 b=m5BPXKU0yd5D3DWjztZN313NISOxNFgQ0Kfww/rsHAnfP/JKXPpAoAX0XYZvm8BsTV8+tdShhUd4jljArbs8bGzIP5WHKejVrSnWp/JXkS4+ANOs7fJisFkZblmpW6DAtYxkMLl4+SyMS+JZQLxJTJ1hAIwUQSTeL/s3M+ogjXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 23:45:24 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 23:45:23 +0000
Message-ID: <dcfc9264-959a-3bb5-95ad-548a6f019430@amd.com>
Date: Mon, 29 Jul 2024 18:45:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Fix __reserved field in sev_config
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, stable@vger.kernel.org
References: <20240729180808.366587-1-papaluri@amd.com>
 <20240729193210.GHZqfuOs-t9HuYPF_Y@fat_crate.local>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20240729193210.GHZqfuOs-t9HuYPF_Y@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fba1b6-30b6-4f8f-2ed1-08dcb02883cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUVBWXk3Q3k1MjM4Z296d0Rkb2RhNFd6a1NmUG1rMnVlUktQZ2didFNpSXRY?=
 =?utf-8?B?d0xyYW9DdUwyMU56Vm9tc0txT1F4TjdQdWxBc1dDazY5bEowdzN4bkc0Y1Vz?=
 =?utf-8?B?ejNSWENDOUo2TTE1Z2M1MkljU1FGZG5lT01pWmxheWRhT3RVcHB3N3dsNXBM?=
 =?utf-8?B?aW5sWjczVTRERmNjcWhiMlRJTzJYWmh6TGgweEFEUjJQbzBvdWwrRmdQUjIr?=
 =?utf-8?B?Y2Z2MnNlNlQ0R2pDTm9UbmQyWnlEeEtVVWRibjVHN3I1ZkxMQ1B5bVZDNDNa?=
 =?utf-8?B?Y0JKS1dic0NvVUwyMVNPU29ZcmFvdjErVXI1MHUydllrMGN1bC91emVVZk42?=
 =?utf-8?B?ejhCOEE3R1pWTWN6UmJIRDJ6dXRKNWtsV0pOUXJuWjdMTWIzblNsOFRmQ0Yx?=
 =?utf-8?B?TEdRK1FhZGthZTVHd0VnMzE1ZnY3OTFsc0JKVlZTN1FEYVArWkhIWGdSN0J3?=
 =?utf-8?B?UDFNU0piOUlZOGI5TUdlTllFYUZ2L1paeEtrUStjRldJeVhzUmZtNFVuMlRS?=
 =?utf-8?B?aWRGSStsRnBuMFRPdnB0YjZCdVJjaGdDeWdacXc2S2N0Ym02MitSM3pJd2pC?=
 =?utf-8?B?Um1RaEFiYjNEbGxDUUdWS0hTaENyMU50NGdVYzMybWtiekNHdzVndThiTnNM?=
 =?utf-8?B?WWJiRjM3cE9DNjUvYVZwVHFjaUhmWVNhUm5jNjExYnNZOE1tRXowTUVFZS9K?=
 =?utf-8?B?eC9jN0xQL0x6ckU1bnRJNFBrdWNMZzdQRkI0WmVhREo1MFJGVjAyc29YSDdz?=
 =?utf-8?B?UXF0QUpUREdFeUx2YkV1dFcvdHlJZFZZZUFqRGxyUkZmSVIxU1NpczFjcUZK?=
 =?utf-8?B?cGJIN0RsVzNWR1h3WURoMG16Rmh0bUh1aHdEZ20wZ0NZSmlkaU1KSitYYkRa?=
 =?utf-8?B?bUc5WXVjSjVaMVc2Y0NQK1o5ZG9RRFVUbjUxOVVubmVZTHJXN1c1c1c5d2Jy?=
 =?utf-8?B?MGRrM1Z0K2I4UHhUblg1WDdTeC9NL1dHdndwNHZYa25FRkMzeUM0dW5maitB?=
 =?utf-8?B?L005YnlVZjA1dlFsUTZqL081QVpuMEs5MzZHZXdqOFFkVllIQlF0SnV4ak5R?=
 =?utf-8?B?cVlzSFBkY2JHQm1ZS1RVNnA5Lzg2RWt5VTFnQitWNi8zRFUycEdYNVUwQ3pK?=
 =?utf-8?B?ODRHWHdYYmRSaVphdUdVNUFRS1Q4aTNLTXpMMW4rQ2RtY0VlZjJXNlBYaEtL?=
 =?utf-8?B?R1JHN2RVN2ZXWE8zeDBoaG5tOUJsY0h0bHgvMnE2TzlrYUFMRFBnZUVaNzZ6?=
 =?utf-8?B?b3gxMzZlZ2VDaXZyT0RSZkNOc05CZndvc1M3SGZ4L2FqeE9aUzcrK3FHYUhk?=
 =?utf-8?B?MDJ5M1Z1VHpUa1pJQ3J5dVJUZ2d3OFU0K003RXFSWUl6MUZJQkUrdUFBa0Vr?=
 =?utf-8?B?cGpCdU5BV0xoYzNEQjEwN0g3V1lHTko1eXFJYzdWZFd0NkQyMHBSRmVhTTNk?=
 =?utf-8?B?b3hNNWJ2VVY4VG43UE1UWWVPNzVVcXE2R0lPNHYzNHEvQ2dGMm9LWC80bjZ2?=
 =?utf-8?B?a3E3bWdMeFhVWC9XOTFEZVVDc25NV0pqYWdsMXg4dGNkSkFPUTVUZDFuVDVl?=
 =?utf-8?B?czY1YVplY1dKMHhmN251Y1RGa3AyNFpiWG10dWk5eGRoa1ErR1QxaEt3Q2po?=
 =?utf-8?B?Q1N5eVNBWHdZL012eHEySVU1YTNXSXdWbXAxT1YvNS8wWjV0M01jbytnQWZa?=
 =?utf-8?B?TkxVaUpVY2JGS0E3UDFIVUZuYmdVdTlrSVRYSXpqcy8xZmNGeTZFWWZ3b0dP?=
 =?utf-8?B?Nnd4dmQra3orN0hhRlkxT0ZKS1lMWnR5YUsxYXdRM1pqUWJNYmVHSWR2di85?=
 =?utf-8?B?YnVQQzhTNW5OSnFBalYyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czlCcVI3NCtlRUwwbURadDd4YnJNOTNwa0NGUUVLbklNMk1Td0QvTHF6VHl6?=
 =?utf-8?B?NU4vdmloOVZ2cURqVzJWVFpUdzlOajR6KzFVL1lJTjhLY3pRYkxpS0ZTdDNP?=
 =?utf-8?B?UGE3T010YVhsbllqOUUycm5UdEhqbXpaSm9BOExpcmRYNnZuRm84MzFnZHMw?=
 =?utf-8?B?dllRbi92VnNwcXBaRnVEenROWTZVQUhWRjM4MmJlVytCbytDWXNBN2pkakRO?=
 =?utf-8?B?T012eEJEcmdjQ3YzbUhjcVFhN2FHY3h5aFdXMXNMS1dENXRQSmRPVXYzOER0?=
 =?utf-8?B?Q3lub0kyQUhuWSsyamlKeE9LUXZES2d1TGVubjhGdXdHLzFtS2FOckpOc1Y3?=
 =?utf-8?B?NVZHNU54VEVFWkRTWFRFYXYxemhZTjIvSUhza09MUEROTkZ1UFlEVm12bzFk?=
 =?utf-8?B?Sm5Mb1hQZUtZUjZtNnVjcEdjcEhOZjB2dS9SeXZNcllLVzBIQ2FXTm9kd2VB?=
 =?utf-8?B?WXFDYkZFaXVzRkFVNVVZOFh5bXhIM1BEaWFOSDBBa1JiTGJtUmFrS1dTeEJO?=
 =?utf-8?B?MWVSbnRTZkdEYWtHSVF0ZVdSRVkzYVBiOWRQK0w3SWtIdEdvSzBKSHBKcDlo?=
 =?utf-8?B?UllxNWZBN2t5cFkrOGMzNnZWTXg3UEU2Smg0azI3RnMxK0d3ZW4vL1ArZldr?=
 =?utf-8?B?K2FFcE5wMUpWVUNpb2wrcE11eGIrQWhnenpoRHMybVJ1REZMdHd3T2tlZVdy?=
 =?utf-8?B?Yy9welh1dytuYWNNakFIZVR1V21EWHpacm1SejAvaTZEb1ZMUlBTQVhaZXRm?=
 =?utf-8?B?NXlQR0ViVWQzM1JLSzNRMHpWZEIvL0pUa2FhUmV2T0trSkVzdGFWQU9CSDdm?=
 =?utf-8?B?SGhsenhFU3JOMGM5WGRmWTBjaFNTWkxFVkdvaWtmRjF3d1dNMHI5LzFwZlZQ?=
 =?utf-8?B?MFFQaDNsM1dwVWE1ZEFjbzJkdkpVSVlIa205TTNWbUVUVUpwZHFLTGVSL3Q3?=
 =?utf-8?B?TTlJOGhnRDJSNUdhYzZIQkpWNlRHbEUrWEhDbFVZeDUrSVZDWVIrRXVGTm9w?=
 =?utf-8?B?Smxtbm5vS1h5czJRMU9jMGFXYzFpOHUxNHZUUEtsckp4UWV1czJjUnFHK0xG?=
 =?utf-8?B?eXFJK3pwM2JoVW1JRGtSNG1DZzN4Z1FGbTBZcFhsSGdVRlhBK2tvK3BZR2ZY?=
 =?utf-8?B?OHVob0FZQ2l6RFk3TXl6Rk9TQXFWeGZvNlZhZ08wNTZpbDdHSmNadVZXbWJO?=
 =?utf-8?B?dmF2OFFjRjdkc2JVdDk5MkdmNk5iTjIzbFprVXg4bFd5aUU0aUl5V1BtSnRu?=
 =?utf-8?B?TUh5UUlIQy9JR2VRbGwvWVJ3bTVQTlRRY0pLQmhReG5hcnNmQmZLUnZkcmtk?=
 =?utf-8?B?MmJJdk9nSkZwelkzeGFKcmRQeWVSeVpadjVSZlRUYXpscGhWRUY3N05ENXdN?=
 =?utf-8?B?c3BWQjN4UHpnd1NUSzZCOFJuYnkvT0RIakcyVGIyNW4vRnhnc0czRHdmVk9D?=
 =?utf-8?B?ZzhJWFFOSzNzb1JVd1JmVFVqR05DWFdHZHVrTTBKaU53TFhyTG5JNUwvd3Iy?=
 =?utf-8?B?TDhhMTF1QmwwUkhhM3EzM1FCcnQ5eCtndURBSHhYSXJFQVhkSHhjcFh4NVBk?=
 =?utf-8?B?TVNIOVAxTkJpYkx3RDNNUlRRWVp3Rm8wZTlZdWdJcndqNWlieVB5cDhxcFpm?=
 =?utf-8?B?NWNwRWtJcUNaN2FRblB1Z3RtSlRJNE56dGRkbCtQbGVxT3hSSzBINzhXSkkx?=
 =?utf-8?B?aWFjb255a1o2dGhEVmlnRUVUQ0dyWW1TbFB3OGRsaXlISk1UM2hKMFQvdmpZ?=
 =?utf-8?B?SnVRU0p5djFvdXo4c2JVcWdqK1M3WkxsZWZLa2lqZXhzSTZNS3dPQVBidXdZ?=
 =?utf-8?B?endxV0VmVHRMOG03d2JzSUgxbzBsb3VDZmY2TmQ3UDNBbDdjd21uMVpBckll?=
 =?utf-8?B?aGgxQmRTdnVtMDBEWHRoQm5wU2VKRkpqNHg3dnVxMmwrKzFFaHl4b1hOQjlv?=
 =?utf-8?B?NzYxVFJCNVlIQm9TWTVZLzBaZ0tiaVQrRUh1NjA5QVFzbHpjendpdVNFcGt2?=
 =?utf-8?B?dnBMT2dMMzdBcWt4bHRmOUNuUnJrQTZTOC85dDQzOWFuU3d2czUzbmI3TVNY?=
 =?utf-8?B?MHowRHpFUXI2U0piOU9wUTltaUNiWkFiWmlxMzZSN1hqVzg0aHpuRVMxeWp1?=
 =?utf-8?Q?cScl2Hp13h/clWdgRX2dZH6Dt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fba1b6-30b6-4f8f-2ed1-08dcb02883cb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 23:45:23.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtfM2thG2LY7J5Ecih5tdAeyDJMEXMkATuGPMq3zzAIqY4DayFABMuiSjk1ndIiWYj+ly4/nlsjrGLIJKLj8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

Hi Boris,

On 7/29/2024 2:32 PM, Borislav Petkov wrote:
> On Mon, Jul 29, 2024 at 01:08:08PM -0500, Pavan Kumar Paluri wrote:
>> sev_config currently has debug, ghcbs_initialized, and use_cas fields.
>> However, __reserved count has not been updated. Fix this.
>>
>> Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
>> Cc: stable@vger.kernel.org
> 
> stable because?
> 

Thanks for noticing this.

I shall remove Cc tag since:
1. The commit that introduced the bug is only part of 6.11-rc1. So there
is no stable kernel fix needed here.
2. An incorrect __reserved field did not cause any hang/data corruption
or a build-error.

I will re-spin a v2.

Thanks,
Pavan
> 

