Return-Path: <stable+bounces-127341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3874A77E8D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DB9165582
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649E20765D;
	Tue,  1 Apr 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PkZiXL1W"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30861204879
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520045; cv=fail; b=A2g8ZxZf9pDhZj9rrg+gzi7SDStOQtf4cFqDxW+Y8wO/uECPOtOW7NQ7QmGlYgVzeb1uB5dAeMx0jCEHARn5fJI4AHanOuwvDAxBqEWNzPJzO8TPrR9iaJU+xW7oiSFqNJDDuInBzoWfECx6mClw07d33XlJawpzWe//eqSHqsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520045; c=relaxed/simple;
	bh=eVj/deUTvY9YyZmpGJFvecJnpv/qHLVv1cI9BOIJYzw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=NnjttmX4f7MR8VNhXpzObWi9ewfc0g/jwIWh3J7HIYyLpQ+UgRyqeAnTHgcHHMbGOEePQFK+cgod+aGZltvJk2FgK6b5qPWRadWfsFDZ0zg11RjOOfm3a8j1o2UUO7WN1qEgnpVOuxMkKMnBTdwnr6ezNNlk6gaaHsYZXT0lCZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PkZiXL1W; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irw7kb/IBtSsZdcdQMENysbPF7fXtZHZ2R5V2F8qiOQzFh87LvKmmrx4Jl/WU5ux5gJf8LoMA2sUU0V81sqWSD9OeG4NSLg0XqkhQlivVimaze/0akjo4uXIJQ4EgWhvx/8mkSCTtHeWpmNoxnItiOGCm+BjZf/8gWKJ8dEds7qfYGFyjwouohSWqQhs5AtIZwzJ15USSpboWebGCSq9zQ0fY0f96wkX0qQNT30Frt+qlVI6UvqUUBN6Kv+SSfSVnQT6iLhL5TejBjXFAa2RXb8SER2HRaKYlhOMaqd5WWy9hK1gYB1hauf0sGqiEJHMQS37r6BT2TeL6sbvNIRmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I15HUhmwpvURC1DQoaOr0cECvsp6fvAe2oh5NjLlH/Y=;
 b=YpJDXZqG8FCR2T8l166OGaSOZAZT4ZAPjOfKrna7WTqcABlp4d+1AvE/AovQpMjC+dsx14I3OzHkPrBeVm7dLzKJhV+4m/SfmYKA6pvPLtQaerkY1zy247eUA1TsZVV9ICYetlJWV8DAQ30qw+uvy+ztmDnsFMwgda3t3LV/HJ2cAfwOOlFWXZXhlkXVzNqw4IXBij7qGheptyaaajMumyd/ICSsnZZUd82LsDpRLS96UAC1nbtMVdrOLR4Dwx83Vs9o7fcV3VYgQ9LbcPaEWpTYGiOzqBUwelY7SQYvopmx3dSMgPETLfO2V32780sj5fPS4T3YoqUb5e/H7Qa/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I15HUhmwpvURC1DQoaOr0cECvsp6fvAe2oh5NjLlH/Y=;
 b=PkZiXL1Wll2V0svoulj7SWlsOn/eacM8LzcGV815eRuSdmN3c/ZZt12jV0E7RsIC1ySuFMhO+OuOpJeCiS1h3wj3m6SubbvsQhNUQqEe07wcEDmsC/DnHzMdGNxsDxiGLrOQUYh0QoDJh5xVcMGOW9DThR7NgQSF6kYjS4m9z6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 15:07:21 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 15:07:21 +0000
Message-ID: <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
Date: Tue, 1 Apr 2025 10:07:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Naveen N Rao <naveen.rao@amd.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org,
 Vishal Annapurve <vannapurve@google.com>,
 Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
In-Reply-To: <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: c585c98c-de9d-4e74-a037-08dd712ee6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czMyZXplb2dXUng2aHdIaTQ5NXRWd0tGSW1HZG83Tk1lNmNnb2dpYkdQc2xn?=
 =?utf-8?B?NFVlcmNqY2cxNVpHNnJCa3YyT1JSbnRtZFNpbDlteWxHNUdEd0lLOWJUeVZa?=
 =?utf-8?B?MUlCR2loYWtPNEZPeWlnZkpXa2FZVURaQUpoYVlFOVR5dFB4YVNKL0NiN1BV?=
 =?utf-8?B?a3NlYWdXTTRDdFBSYzgyWDZmckMxbGxpTzQ3ckVJbnhFTjlsS25PYWdrUDhT?=
 =?utf-8?B?S3FRV1VRVG9adjBrZHRFL2RDZ0JxS0ZrbXREL09CZ0FRby9id29OUUNmVnVm?=
 =?utf-8?B?d2cwcWsxMHZqeUlGYUdFU0E1bDJJMmd0cWlZTnVCYWR2c2ozT1Q3clhyTVJj?=
 =?utf-8?B?MUFyRHZ5ay8rYUErSHVIM2cxTkNBYzJoNjUwWC9VQ0tack9kR2ZlRkdpZmIr?=
 =?utf-8?B?NVNsWXJTZzRJNEZIMmdyZE1ta1BqMVhYUFRwbjlqVHcweVdSaURzd2dGajJy?=
 =?utf-8?B?RTh6NGZRNmxzY21HUjd6dkRhTWdtUGlXYXV2UVZKVThlTHBkYXR1dFR3dUtG?=
 =?utf-8?B?YVlVQU9zY202ZGYvV0xnOVFwOGRXaDJwWVhna1REN2dyS2FWWk1WdkFmL3l1?=
 =?utf-8?B?SlMwWjNJV29WcTdEeXNMdERoNE5BVUN1ZS9ObTdxWjNuVEdOMGRPem9STjlw?=
 =?utf-8?B?aTJEKzg5OG51bHQ1NEwrcUlFaG9nREhoY1ZaTWYxQ3JPbkk2S25jam0zMEM3?=
 =?utf-8?B?MnBuOEhPUHA1bHZFRGU1SUJlZUQ0TWxaQm9kZEJFcEMvQSs5RzE5SXBmc2RI?=
 =?utf-8?B?OTJndW44ZEplV21xODQ3VkxTS2JoOWZFM2hwSGZnR3k0ZzdkeS9rN0wrWnNX?=
 =?utf-8?B?dDBPLzUrVjhzbFBUSkhEdlFKOGs5OUtHOGNRNkVqUGtlSUhOTVFsK1VkUnhC?=
 =?utf-8?B?Smo4SVpVWmRhby80K0NWMUF6TUdzb1psRGpET29Sd1NNUnE1WW5wU3FOZHZG?=
 =?utf-8?B?Q1NLYlR2RUVPRHU0b3AvNHNnWlVieXJWMnhNNXVSdy81V0YrTlpqeE5leGl0?=
 =?utf-8?B?aWRkWTR0TUQ2cjloSnVETG1ERUhCaW1ZamNFQndoNFRZeHpSZng0WE5DanZK?=
 =?utf-8?B?aEdRL0RpR28xZTBDMEJrc0YwUW5LdDV1VlpOU21mQnB6Ly9jeW1aeUZhSjJr?=
 =?utf-8?B?UHMxUmEyRUV0Z0VJa3pwbkdBaCtuQVJ5bEtaUUFUYytlNzBEaHIyVGpXZlJO?=
 =?utf-8?B?M0ZyR3dsY2Y1QytVMmJlZ3Q4VmdJSno1K2g4bmpKR2xpd1AvK3hrcFJIVWJi?=
 =?utf-8?B?QkdFOCttWXB2WWE3d09Eazk4MmdlMkNkQ0ZZWm94dlZEbUNCVXhPdFQrYkFI?=
 =?utf-8?B?QlhWdXlKL2xBd1VCcnUvaTdib1VDaHRWdWZSMkZ1MTJCRlBMYVJnSVNvNU05?=
 =?utf-8?B?TFllYmZMSldWVDJiSnQ1R2VVeWN1K0Z6cHJSSGhrUm1icGt2Q2tNRFdha1g5?=
 =?utf-8?B?Y2F0Zm01TWVRRUVGbkZFbDhPdWs5NEl3UXozNnlrSlVhajZlV1k1M3hlelRi?=
 =?utf-8?B?cWMyY3FUSWk2RjhYMm42RjVUYVRJcy9OSjdqWDNYS2k1emRMdVBkaFVDWkkz?=
 =?utf-8?B?RGg2QkhhTTVpOSt0OWVnc2FTbUY1OGdndHVweWhIdFBqQ3I3RUtvUzJ6VU5t?=
 =?utf-8?B?QWlmSUU3WmgyYXFUZVkrUWtXQzlNZXVCZXoyRkVLa2pIQjE4TEdxZ2JKUWs3?=
 =?utf-8?B?VjZMUm5jV1BsNkNXQkhMVDZNV0FxcVkzbnhxdlVqTU5RSy9VNUV4VWxGdERt?=
 =?utf-8?B?ZVNPTkQ1eDI3L2hST3lYZUJZVG10cDFDN3c5bHBSc1NEaDR1QkJtV1JDR2Mv?=
 =?utf-8?B?T1VibEF6L2V1MUQ0UTZNbWlUNkNiU3lpTTZzTnpzZDh1c2luZ29SSThrdEF1?=
 =?utf-8?Q?JGKVqEdPvi5xc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z04zUGFJdFZzL1dudDFtc1lEbXpOWTRRZ0toLzdFWVRrY2lwMkZIeUZIWk5X?=
 =?utf-8?B?Nks4MXp5aWpHblBWY1FtM2ZJaHUxUEJZUTllSFdpdmszbTZxdGhNSTJmWGxp?=
 =?utf-8?B?OWQrVndYa1FxMDhaTWIyZ29ib0NCVnZHSWFjeTZvVEFsa3o2ZjViT29VVnRX?=
 =?utf-8?B?YzNPVTBIRDg2VEFkSzQzSmx5bUxhVkR3N0ZJMEhBeUJjK3NkOHVOcW5sVExR?=
 =?utf-8?B?YmRlbEdoVjJNaG1wMDdyeDNOY2pmU1dzWUFOTkdHOTBCb3NoaS9ZRmFQREtU?=
 =?utf-8?B?WDl4Q3dsNEFMWEYrUmFjOWlpNG5oWEw4cTlZSkJnQjROZW1EbFI4Zy9seXN2?=
 =?utf-8?B?Zjh0MnVhVW05eCtkcnBjcEU5V0dRTFNaLzM3YzZKWm5jOWNsT0FLaks3ZHhV?=
 =?utf-8?B?Qm5yZGJxV3J4RWI2UTdYeCt4SEg3aysxYmV5UHQzMEVudnpGdGhqSE1SWTIx?=
 =?utf-8?B?RTF4QVFsYmJxTTFObjdGQk92VlZuRDdPYktPZE1jdkIrQ2F1WU5YZ09ERkFH?=
 =?utf-8?B?OVllTUVJek1HQnRzaHZIWElmSTlMOFIrZUsxVmRtZWUyMDcvMGRsZFMzUzN0?=
 =?utf-8?B?S0lLTnVFZHdKcjZ6djhoekZUSWMvdHUxcGUzbEFhY2Z5NnFUeGZnV0xjSTFv?=
 =?utf-8?B?dUszZFdtai9sZVhheGJsQjJTMUFmblpya0t3V0F4SG5laVNCZitNZVl6NU5G?=
 =?utf-8?B?UGpEVEZuOWpOOFQ1alI5QWZhajFvcmtXckEyZXd4Q0wxbGNpUVJ2WDVJSFVR?=
 =?utf-8?B?MHdYVG52Yko1bC8xM2VtcUt4dS9MaVVQMnVoc2xFblZCaHFmZ2dPUCtwN21M?=
 =?utf-8?B?Uk5sQTk3Y3NUQldCNHVkR2E3VVd5MklrZmxUclY2dC84RUF5NmhLZGtrU0pt?=
 =?utf-8?B?SmZjYVhaaEtQcGFFVDhoVFRaRk1KNUNqRExVYTNYVWV6dUhuMWdqaWh5b0ZV?=
 =?utf-8?B?eXNvcURHdXdvTHI1azZuSFZCRG5GMzhCd3J1T2h1UkNyK2xlY2NYOUlKODdj?=
 =?utf-8?B?YXowMFl4YVJkRnltQnExVzgrMTNvcGptb3B1T1phS0pOMmRqZFdCRHUxN2cv?=
 =?utf-8?B?ZkVydlZ5cVlDdW4zejA1cWg1SzNEcU56MG5IU0pHbjZoNzFUQm5PUmZyQWl6?=
 =?utf-8?B?RFN3UWI5RTdYQmFLejYwNzZtU25CbCtGOWlkbzUrUmNIWnBqd2x2YjJDY3lj?=
 =?utf-8?B?NXZudmZwOW5UVEt3THNnWk5FMWNXTDIxeFdNVHpacUtiem5MUVRxUi9jQ3Fv?=
 =?utf-8?B?cmp5bThQV2ppbW5sZTZ6T3NJY3JOWkRER1pXdnRrS3FVK2RDeFErZjJCdDkw?=
 =?utf-8?B?aFROVnhtVWN2VHpwRUhQb05hcjkxcnFUUFVPL01oeHNlT2FLSXlORnhKVXJD?=
 =?utf-8?B?cFBmZXZVc1BmMGlCV21lblNpYnE5RGovNVNKR2JHT01JdnVxakNyNE5Ha01h?=
 =?utf-8?B?NU9OSU80aEd4R0dCc0tWU0ZiUHZSSTNERiszbHJsN2hsM1RidWl5TGZvZUJ5?=
 =?utf-8?B?S1V0VVUzamxqcHpXZkg2TW5VcnhrUzJZeWoyWlI0YWpPanB4eStKYTZpREl4?=
 =?utf-8?B?U0ZqSnZxcVZlV3hRdzJmME9FQ3lEenIzUTlRL1pDdXdtREk0Q2FJbXJvVkFk?=
 =?utf-8?B?b1I1ZStRYlpDWHFGZGt4MzhZb1laSVdYb0E1TTMweWNDYlZiMm5nTFlML0VZ?=
 =?utf-8?B?ckQ0azM5RTZOUkpoUHJUb1dLb2FsSDhwWHJlUERYSDZ1RktjQnlJZDhyL2c1?=
 =?utf-8?B?elRnRUYxSldBK0J2UVRQb2N0VEVTaEhyZmVVRWk0YmlEUlNvZFM1UVBjVjVq?=
 =?utf-8?B?Z2w4SW9xMlFoeXovQTljNU9jL2FZUndJUlVxZytvcDl3QmNJZnc5d3NBYWxj?=
 =?utf-8?B?Ym90UGtYUm1YYVNZUm44aGo3OUI0Z2tydEx1TTlvQlhHS0VqdHVKMkI0cU00?=
 =?utf-8?B?S0tqSzFOdUVyRW95b21CeklzWmNNYjF2dGNkYXIyK1VDMDhPb1ZiVU82Sm44?=
 =?utf-8?B?MDZiU1ZlWFNsZkhxU01XMWpxUklVYVhYYURYWnRRbzhCdS9SN0lrMm04MWtl?=
 =?utf-8?B?bEhQUytSSnRPVy9hdmpVWlZRRzR2cEhRMy9rUzdra0FzckpaM0grWmdxNm1s?=
 =?utf-8?Q?4e5WBBnzf+LirNdPmkRJKpACg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c585c98c-de9d-4e74-a037-08dd712ee6b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 15:07:21.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDJg5glOXhlie/6uW3usuabAtQEf9VZRerp0Oyhg2Wr40lmd9G/v64buk2Vggb60wNUt7tQOey52+/rV67LpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

On 4/1/25 02:57, Kirill Shutemov wrote:
> On Mon, Mar 31, 2025 at 04:14:40PM -0700, Dan Williams wrote:
>> Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
>> address space) via /dev/mem results in an SEPT violation.
>>
>> The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
>> unencrypted mapping where the kernel had established an encrypted
>> mapping previously.
>>
>> Teach __ioremap_check_other() that this address space shall always be
>> mapped as encrypted as historically it is memory resident data, not MMIO
>> with side-effects.
> 
> I am not sure if all AMD platforms would survive that.
> 
> Tom?

I haven't tested this, yet, but with SME the BIOS is not encrypted, so
that would need an unencrypted mapping.

Could you qualify your mapping with a TDX check? Or can you do something
in the /dev/mem support to map appropriately?

I'm adding @Naveen since he is preparing a patch to prevent /dev/mem
from accessing ROM areas under SNP as those can trigger #VC for a page
that is mapped encrypted but has not been validated. He's looking at
possibly adding something to x86_platform_ops that can be overridden.
The application would get a bad return code vs an exception.

Thanks,
Tom

> 
>>
>> Cc: <x86@kernel.org>
>> Cc: Vishal Annapurve <vannapurve@google.com>
>> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
>> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
>> Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
>> Tested-by: Nikolay Borisov <nik.borisov@suse.com>
>> Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/x86/mm/ioremap.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 42c90b420773..9e81286a631e 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
>>  		return;
>>  	}
>>  
>> +	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
>> +	if (PHYS_PFN(addr) < 256)
> 
> Maybe
> 	if (addr < BIOS_END)
> 
> ?
> 
>> +		desc->flags |= IORES_MAP_ENCRYPTED;
>> +
>>  	if (!IS_ENABLED(CONFIG_EFI))
>>  		return;
>>  
>>
> 

