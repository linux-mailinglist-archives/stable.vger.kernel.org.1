Return-Path: <stable+bounces-143269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4BAB3838
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9A860411
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED72D7BF;
	Mon, 12 May 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSRVSwUT"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD318E750
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055730; cv=fail; b=oNJFhiWlYVle2mEc4xqDBkStW01AKFJV+TlqjcUmir+QWjyR8IGgFFYwXNFdaCUEOPuw5vZ9OtiHu23sXP46jNFV/Fr9TxewVftyIpaYakXXoRJjPT4hDB/mF89ROs19fiO3X/EYvEf69Pe/w6u4riPRronKgaZZg8DjANlR0sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055730; c=relaxed/simple;
	bh=Q4ZgFc4COn1P1kEWCxN9ML4gmpsgmO84YYBQaLUp9C0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=tPzXoAG2tGCWrPh6It57XCx2cX8YtHXKHb2NRnxOWLUoF+oBIHbGkyZXMFKr3MVqnXQQJ8ob5iDWwpOYX4AWRvjYnpb6235hHxW3wgVbI4AVNje+lMyl+8/kp1UBPs2iGnyl5D4gsv4U91kujUM4WdS3dqpUXPGSg66tnDkbCvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSRVSwUT; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDY9ZrUMdkYIRTwD/Uidjnie3PrjouIL2nPNRkkAbGtz0G3qf76TFBgISwE7scEK7ED2HJlFudeJjeVvehPrSTlJjBDmIvO+MxNVByAErX0Fo4ufuEUuFVsg0g/LxXEE64//Ot+v1dN0G3zHZ0bPxJL1QS1gEwP4mM+K4X6BTMdTeRrykfoLoR2tzWwjWdMyMVP1y4yiJp47/hOqCZnBWWxEI1r4UKFtlW5s7ESVnl9AmouIKRvmF1MB8bgDxuhZKXl/I5XSHe7/oVQIslowhr381Q7465O7KuzZa9vJ/du5sg48Q/KaJdFA4WQIFWew2NBHCfplt5eHInBa5/cspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orSoWRZsd3FhX9Vm5jQu11G3fifL3BLwX5XZevneSCk=;
 b=GBj59ELgdPH7FEUoqXaTNsjAFCKQfm6pYfki06RT7dIOFYsJi3Z8OTFcFCIaNWSo4nM7BaXzH9OWIHMpcuiiKbauxlPieeRIUsfk8JJRuSy5Bo3gYMbelEz2b8vI3e2iZ0FbUcbkYFcWbF9XWoyK/cT5OSRaRGODdtSaYU7KO0slfG6KFyASWz9JjiRdZ6mEEnqBhsTCpFsFEvM9gf05w4DQuUafFN3iW10LTe7YWpK3B6YoiFNVkI8LLiXHJLZQcIOXUHnPBk/aOW2EOPVRHepwgyQ8HnwfCPVqcN0cmB5zSJPdFEf6zjSulBZhpMywrtVeSAOqNc5G1yVWj09ObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orSoWRZsd3FhX9Vm5jQu11G3fifL3BLwX5XZevneSCk=;
 b=GSRVSwUTtd3IiHxvaTDE//Es43D2jRoeTZccvZSLFl7o8LmNXZSXL2yXoeYY2sz2fusc4HclJkyzqlEpnT5p+L0wkUhMrET+5Hvu9M3QVlIWS5IlvhTQAaWs4v3WFUeAl767gbjvY838mmsXfLj9S9WD+rz4ZmooJbhrTV+GPxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 12 May
 2025 13:15:24 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 13:15:24 +0000
Message-ID: <9339fb64-a62a-fdb7-5686-dd9b2a4cdf0d@amd.com>
Date: Mon, 12 May 2025 08:15:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org
References: <2025051242-predefine-census-81af@gregkh>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Patch "memblock: Accept allocated memory before use in
 memblock_double_array()" has been added to the 6.6-stable tree
In-Reply-To: <2025051242-predefine-census-81af@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20)
 To DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8a0244-248d-43a8-e9b7-08dd91570e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3FWUmQrZmVxYXpVZFcva0RDdWdGRVArQUoyOWt2SlFvam5YRTR6SFp3T2pW?=
 =?utf-8?B?L0dWYm1YWnRBUWFPZ2tOaW9VblBESFFQMlV6eHRHR3pPNTdleGNWOVZxZEFO?=
 =?utf-8?B?NXVBMUUxc3liQmtiTWwyeTRNNGkweGNHdkdKVTdVSTRPOW80WmpPZkZrVFN3?=
 =?utf-8?B?YVZPMkxWZEFzRk1mV281bjkzY1lhNW5ERkNCYlRLUU4ySFJCWVVER3lmeGIy?=
 =?utf-8?B?SFRmMllqWkZNd1d1T2gzZTJEbWd5QjRmVmRoa0toT2pnQ1FmZEoyMHlGTGs0?=
 =?utf-8?B?ZXJlbHV0dWIyenN4Umpic041MWMrOWlzZ3lycytiS3FGT2QxSmQyQjFkSzBE?=
 =?utf-8?B?eDZ4RXZOOTBJeFNCWEJsOG5nQnVoNUtnbmV6TjVvNWQwdmJmaXBpR0hybjVS?=
 =?utf-8?B?M3RDVHNmZEVJMEg0My82S21wUE1DWFlydmFpQTk5RHNKZW00R1ZYQjlOVWIx?=
 =?utf-8?B?a1JGajJTWEZNcy9uUTIxQ0pxbFVEMUV5c1RTM1NwWkREcGRMRWZ0ZmRNNEhr?=
 =?utf-8?B?cTFUUkpBbzZyUGt4WWk2QnpESFRCOXN5WXRJdWl1bE9zNUt3Sm5nTVhiS1FU?=
 =?utf-8?B?YUsxbHlJODJVMmorZzVnekEzRityNzYwK0tSdDBUNm4vMHFzOGV4Z09Sb0Mz?=
 =?utf-8?B?ZXVFbWVPOXZoTThscHV5dmUvODlQSkQxdDIvTUIremRBdXhydlJBRURTQkI3?=
 =?utf-8?B?WDZmNzlrV2puVUFHTjlXZUhzZUFXeWlrVzdvSy9xZm94dGdwRjB3a0NHY21N?=
 =?utf-8?B?c1NwRmF4Q3RFYUlDY2tBcmZIMFVUaGpjdERkYTBIMFQ2ekR4WlhtWnpyaGZ2?=
 =?utf-8?B?YjAxc0NSTnRMTzVUYkY4c3ppUzNIMC9PeEh4OHNHaFNqSkZxV2Yvb1hoa2xl?=
 =?utf-8?B?cUkwRnBEYnRDMmRNVGE1djlzTXBNNDJ3RThKRlhYMUxQb01JUGEwem1wWmZs?=
 =?utf-8?B?QzY2bERSUmEzUTZuK1dtZzJSeVlXSFFpTjNPR0NEelhXdElWUWZoMzhlei9q?=
 =?utf-8?B?Q1lxVkJtcFpDYWJDSjBLRzYrWFRPWUJsWUh1dDZMQ3o3N1Bnem5aN1UycHMx?=
 =?utf-8?B?Nms0M2JUNzU0VnY1SW5KUkIyTW15RmVKWlRZSjlNaHNkNWRRQTVhbVZZOFhY?=
 =?utf-8?B?TzB1Ums1djdPamNqL3I0N012U1FPY25sTjBPbEVtbG9vY1AvdXk5eHhaS3Zj?=
 =?utf-8?B?NFNTSWFuSWJGYm4yY1hBZzZQaXpsM1QvZDJ2ZEdGU1N3b0xyUmdhd0VXcUlY?=
 =?utf-8?B?VW5iRVhPRlYvVXVjSVdtNlN2NHIwcGxrTldxTEIrdHJUSTVXaXFhWkdoODF1?=
 =?utf-8?B?eWZzSWxYVXR2UXlZTjBVRkpNMTJJZFdIbW5lai9VTzJLUXk5RVhLY1VnSjEv?=
 =?utf-8?B?OHFCemxncnFMMkkwenFDR3dTRGFoUTlyajJMRUlNOThZbzlnOEpmM1FoQXY1?=
 =?utf-8?B?RzQxQjlmY0dTUituaC9oWEJ4WFV3VEZpaUR6cFZ5Ym5QOGJNWUdyOXRpRjh5?=
 =?utf-8?B?WmxWQTd2QmpKbFR1OWRheC91R1dRK2pJZlQrMmgxTGtnaXhKZ1RFV2NDMDRn?=
 =?utf-8?B?eEJxNkxlRVhhaWNJQ3BNWVIzV0hYL3BPenRjcVZZenArL01xM1JjK08zRWt1?=
 =?utf-8?B?c1EvS0VyM0lnZkdpNnJPV24yanN1c2pVS3JzVmpMZjd0ZXJ3dWtjSEE0VTM2?=
 =?utf-8?B?c05hdU03N1R2MGJ5M2NrZWxzVDgwaGcvMGdrZDVhQnROdW5MRU1iREJTUWli?=
 =?utf-8?B?OFZJZXY3S3ZPOEd2VWcyUFFHRGgzMlFxazhlY2NlRFZKNWtrTXVEbXRZSVNr?=
 =?utf-8?B?b0dTR1FUODlFQjZzNm9MK0J0bGxYV0F2RHNvbytNdmkzZ0cxTEgwYWV1RlJ4?=
 =?utf-8?B?ZEMrdlQ0RDY0K3NOSGpDWkl6MXZrUUo0M0JOcXpxUmxEWFNMazZVMmlaU3Vv?=
 =?utf-8?Q?EsPsfGsQ3dmC+FG/7HVrS+seKEvU/V8p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjU5dW1IU05VamJwTkRtcnowa2x6S3BnenZXa0VuUm5GVHYyMm82WjNkVjA3?=
 =?utf-8?B?TDlzYmd4V0NHT2k2Y1ZBWDFrSHJ5cWM0ZmZpVWJUOVB6b2ZhV1lQWUh2WHA2?=
 =?utf-8?B?WGIzaHVSVFZ6T1JxZ3cyVzFva25WYlcwSitsNjloUXhmRmY1eEVjVkNUK1kr?=
 =?utf-8?B?RTdGV0x2N0ZEaTNNSUlaZ0ZHOFo2YlFsRFJVMmFWYWxCL2ZXdDU3eFY4WFVk?=
 =?utf-8?B?UXUvS1RoMSsrMzBKMXNIdndZblBaNitzeWVoOTRCdjE5bnVSMm1QNTZoYlBR?=
 =?utf-8?B?bkpJODJxYWVNSjJScjl5T1dGVnQzb0ZmQm80KzFrZzR3U3B2S2Rwd2pheXFM?=
 =?utf-8?B?UDdqdStsQ1JId0Z4aHlESCt3eVlQUUk5MXNxY0ovd1FmZU0yaVMzcnl4TXYy?=
 =?utf-8?B?MFJKVy85ZldQSjRpN1M5WmU0bWtGYWRlbzE1TTNmNlR4SStvcjN3UkJrQUkv?=
 =?utf-8?B?S3Q5Zkt3ZGp0ZExoNGVGMlBFSlF3d0VvODAyeU95YjZESHMrM1oyT1ptS0sv?=
 =?utf-8?B?L3FCKzZZcStkTlJ6TVVEeFVrc2JSRjBLaExwbkFxNEREVVBhZ3pjK1dBV2tP?=
 =?utf-8?B?aThVYkwyQ2ZsUlNEZGJPc0huSE9tTHV5REdnWmtsa0hpM0ErUk4reGlZcDNS?=
 =?utf-8?B?d2c4cndHNWROZ21tY3hyWDFXOXQwTnhnTHl4Q01mSW1MeXk3c3paWi9kTkFy?=
 =?utf-8?B?QjFZSlB2NWMvS2lRc2dOUHBGK0RTQVhMUmdSNStXTlkzZy8vV09lOFh5enMz?=
 =?utf-8?B?dHhmUCtKQkxZNEp3ZmtLZmpUdXRCQ1NEVXRTWDVyZWVBcWpkaGY3QzRVM0Vy?=
 =?utf-8?B?T3VGYXo3MTI2RnJ6eHlnemdoN056OXB4dGE0SGpLQ21GTmhpeTBTK0gvSVlD?=
 =?utf-8?B?L1ppTkM3MXpDR3ZxVlVGZjNldFppby9CYzRXSUE0ajZVRGhRd1B1SFErcmtY?=
 =?utf-8?B?T0IxNVdpRDVFYlVTWjhVSlAyTTFpVStGUXV5TzVkdHhOT3dQVWdVTVVMZWp6?=
 =?utf-8?B?RTJrZnprWGpSV1VLYjQxWDd6aUt1eEw3STNzbXdpZ1pFVjdpbkR0L0xCYWd0?=
 =?utf-8?B?WHhiUkhHZ1hJdGdjVC9PWnFpWmQ4b0ZtOFFxRnRmYS9ZZXVGQXh3TktLWVp2?=
 =?utf-8?B?aWNoZVBheVhOY0ZIY0NtZkRWZS96Y1FxVUZpQlovSHpEZ1pNMFRHaG5TN2RZ?=
 =?utf-8?B?N2FPQkk1R0NNeVA2VmNpRmpoejdnZGd5TzZtU0JaZW0yb0twekNuczMwcXp3?=
 =?utf-8?B?MEE1T3NRc0h5ejErWE1ZdDJjaU4rTkpyY1cxY3pobExaU3U1VXRGWE1tcXNz?=
 =?utf-8?B?NXVFR0xRK2RxUzFvSWJmMkRLN3V5cHVOM1JiSXk1eU1lNW1mOHNUTGlGaTh5?=
 =?utf-8?B?c2g1a3VtMEVBUTI5aHRCWXYzbUxjOGxEM2puWGlGYkYrSnFXRXB5Vjk5Vi9k?=
 =?utf-8?B?SVlnLy9ieUMwdVoxWDB4aXJuQlJHVFNjWjdtTVlwakxaVEkzWGRMaUdYQXBq?=
 =?utf-8?B?MUgyRmpyMkF6UENBbUtnVERkNndSUDROcDZqR0lqMzI5Y3hPMFlDYlFQTVpY?=
 =?utf-8?B?R2s3NDdJY0QwUkc2eWlkSDVvdmhnekgvdGRWdGZ2VExoUkp3Tk91N2Rkenl5?=
 =?utf-8?B?dE5ReUpsU0w4NE4wM1RPOGt1UnN3SlhzbDQ0L2hSM3VlWGN3NVNtVzJQWGVl?=
 =?utf-8?B?YU5YNU5vb056Q1VVMXZGMXlxWFhRZWo1a0pRSnNka0J0OGx3UmZBRlYxTVlu?=
 =?utf-8?B?UCs3SDFLbXkyR1d2YkJPTzQ3ckxXWVg3VTU0Z1JnQzBsUEhTN2t5b1FoMTA2?=
 =?utf-8?B?bGd1czFKbG5kUTdiMkR5TXM4TDJkN3U1T2trcjZIYkJERWUzcHl3QUJ5S2Vl?=
 =?utf-8?B?VVB4SFo0ZnZjTTFEODVPVFF1R0h4SmYwYlF5Vnp2UVZOR2drUHpOOGlvNXA4?=
 =?utf-8?B?T2ZKaVp5aG9UYkZtOXRVUHN1azhIYUZOZlRxTWV2QlZwRzN0R3I4V3JzM1Yz?=
 =?utf-8?B?NERkYXdZcllKUGZISFJDNnJ5Y1c3QjZoY2dOcUFycUU5ZTNQd24zS2xGekc1?=
 =?utf-8?B?ay9yYTVCem83cVcxbzNNZE03dzd2Q1pMbS8xREk0RHI3MnJGdFlNa3krcXg3?=
 =?utf-8?Q?ixq2MnyevlrE0aNerbt+XjYOg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a0244-248d-43a8-e9b7-08dd91570e02
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:15:24.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YBeVwEsCDxQArn6Fq3lmSGnZUGNgJSvsiWijdseEhCP1jf1dRzoza74tGnb1xd4Y5ZDpTJ9xRZ7YeWUKwZiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF

On 5/12/25 05:34, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     memblock: Accept allocated memory before use in memblock_double_array()
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      memblock-accept-allocated-memory-before-use-in-memblock_double_array.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

The 6.6 version of the patch needs a fixup. As mentioned in the patch
description, any release before v6.12 needs to have the accept_memory()
call changed from:

	accept_memory(addr, new_alloc_size);

to

	accept_memory(addr, addr + new_alloc_size);

Do you need for me to send a v6.6 specific patch?

Thanks,
Tom

> 
> 
> From da8bf5daa5e55a6af2b285ecda460d6454712ff4 Mon Sep 17 00:00:00 2001
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Thu, 8 May 2025 12:24:10 -0500
> Subject: memblock: Accept allocated memory before use in memblock_double_array()
> 
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> commit da8bf5daa5e55a6af2b285ecda460d6454712ff4 upstream.
> 
> When increasing the array size in memblock_double_array() and the slab
> is not yet available, a call to memblock_find_in_range() is used to
> reserve/allocate memory. However, the range returned may not have been
> accepted, which can result in a crash when booting an SNP guest:
> 
>   RIP: 0010:memcpy_orig+0x68/0x130
>   Code: ...
>   RSP: 0000:ffffffff9cc03ce8 EFLAGS: 00010006
>   RAX: ff11001ff83e5000 RBX: 0000000000000000 RCX: fffffffffffff000
>   RDX: 0000000000000bc0 RSI: ffffffff9dba8860 RDI: ff11001ff83e5c00
>   RBP: 0000000000002000 R08: 0000000000000000 R09: 0000000000002000
>   R10: 000000207fffe000 R11: 0000040000000000 R12: ffffffff9d06ef78
>   R13: ff11001ff83e5000 R14: ffffffff9dba7c60 R15: 0000000000000c00
>   memblock_double_array+0xff/0x310
>   memblock_add_range+0x1fb/0x2f0
>   memblock_reserve+0x4f/0xa0
>   memblock_alloc_range_nid+0xac/0x130
>   memblock_alloc_internal+0x53/0xc0
>   memblock_alloc_try_nid+0x3d/0xa0
>   swiotlb_init_remap+0x149/0x2f0
>   mem_init+0xb/0xb0
>   mm_core_init+0x8f/0x350
>   start_kernel+0x17e/0x5d0
>   x86_64_start_reservations+0x14/0x30
>   x86_64_start_kernel+0x92/0xa0
>   secondary_startup_64_no_verify+0x194/0x19b
> 
> Mitigate this by calling accept_memory() on the memory range returned
> before the slab is available.
> 
> Prior to v6.12, the accept_memory() interface used a 'start' and 'end'
> parameter instead of 'start' and 'size', therefore the accept_memory()
> call must be adjusted to specify 'start + size' for 'end' when applying
> to kernels prior to v6.12.
> 
> Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.11
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Link: https://lore.kernel.org/r/da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/memblock.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -460,7 +460,14 @@ static int __init_memblock memblock_doub
>  				min(new_area_start, memblock.current_limit),
>  				new_alloc_size, PAGE_SIZE);
>  
> -		new_array = addr ? __va(addr) : NULL;
> +		if (addr) {
> +			/* The memory may not have been accepted, yet. */
> +			accept_memory(addr, new_alloc_size);
> +
> +			new_array = __va(addr);
> +		} else {
> +			new_array = NULL;
> +		}
>  	}
>  	if (!addr) {
>  		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
> 
> 
> Patches currently in stable-queue which might be from thomas.lendacky@amd.com are
> 
> queue-6.6/memblock-accept-allocated-memory-before-use-in-memblock_double_array.patch

