Return-Path: <stable+bounces-128875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD4A7FA96
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DE63AA127
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D026739F;
	Tue,  8 Apr 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nvaydg4G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSa3HyIQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64247267386
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105985; cv=fail; b=nyEnEkGhIRXfY2d1Tl7l9+nwH7uIlfPQJAZp1c50Rfx2hc0ad3zbfQSgXrWq163rsF7lEl+d8jUqAfaTTM6SuGVldFXEN5AIbU3j40Kc4P0BYzVFKKc0Etbp39lb3yPXfOxC2Mji/IEY2xngMIUt4G6wvIvJiZT6AFtdYyC++VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105985; c=relaxed/simple;
	bh=3Q8cUu8J8ChnVrmCLgYvKlj8VPqtZp6RiIQSBStPk08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W41DGIcq9DfGhWdGwAILDeQzfMMxPWHU56LPUiVqHxulKGI2lqYxjN30FhWDrtK8lYmDIYhTcnpzOwVNEtZ/GHuDhC0E75SrcQRJUToChg5dMY+TIdtEDyaPCJdGQsWvK2FqW8tvcf7e7VG4BnKK+M5/zJnFOkDcaAXejJRBJmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nvaydg4G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WSa3HyIQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381uV6R015189;
	Tue, 8 Apr 2025 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+quzue0hiNHgqGs31BU8ODXTq8XpZ6voW5ZCniIcX5c=; b=
	Nvaydg4GFnlmig/hf7ZWG2LNUB68TL0lqMFw64YuzgDkkTd02xQk9lZeBr0/lztz
	kPrYdTS4fBc+988zYhAkPqCT6tsDvc+xhZj3ZEm/mSmTmyf5HSfuyCNDrMVOdAeD
	YlbxHf9zwY4EGS5YV28xD2D3TsWhQ7hxOclWoA9+Yx1qnEfoQ7Kw2kqBNAn4RG1C
	I+yBc9QXti2NjH5Ub5/UWSxLHyv9B0jZtrGRjClahLqQSljQrzdIcHAqdiGQaN9V
	F7uYMpI6F2dFCEozOhIpwWqTTCjl7EUYOuSwhUU96DRtrJHPAsrFdUSysn0lpHQL
	J2xh7xAuCoevlI2FPBp6rA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2vdq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 09:52:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538995IF022287;
	Tue, 8 Apr 2025 09:52:57 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012011.outbound.protection.outlook.com [40.93.14.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9sbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 09:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGd3b/09HurwZstTkdIxsJakad1iBDOzQxMMCkL5A0CRACm7UQfP/SichSH9bl/eBnprUo1nNgayGrxsZ+W8mPgZBrtLryO3UJaJyUBZYFLq+Q7NH3gn83EPVA2YHVrKkMaZMOAMITIBf1cIQNXdr6Rme8K5hr/lENZfI1V3UV/GqmnOxFPtjCxgBQR4u6NVp0Y39x8ni+14BvbjkNIaU8B5Hr5T5ydPVuIveMa2M+LvDWjXLpbsLtXh8s7+lNQ2DPFnR1uUrJxr+/a9KRBEDQq0pEBgnz1AKs4NASA2EMt5E2+gRTuMnWmyTFA7T7cGy3xsq7bJKunqL9snVdW42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+quzue0hiNHgqGs31BU8ODXTq8XpZ6voW5ZCniIcX5c=;
 b=p55VI2zWWeSFNJbHRk7LqI5A0dwruZdlRihUAtMksD40iGHHboA1b326w48x8MaGXjPISMe1O5bcCOJsu7LmUfKIFqCoCsrdKsvxusOYpTcU1/+gNMa2ywEAtVHfec3vNdC/w4Mzy2R36GhS4fqLsEpSwXeuf3pb9VUVYBobbBXwZY2hdD0e4CeqNLNJguwRtWhpDxbODkpmfEhwzDiuQTEH1fd/58Z3rnNKZTXx2KZ6khg5HTFlxJpkE3w3n3x/Vua6M4tF2YbAzMO21FxvuIkY1eqsYGvzDFhBOQdQfxEnxLE3MNhu456qxFgxEI/CQIP/lT8+kS8Oo5Fj5Myx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+quzue0hiNHgqGs31BU8ODXTq8XpZ6voW5ZCniIcX5c=;
 b=WSa3HyIQ4Uk9npW/mhmAu8+ynw9zILJ0m/9YS3bjqEiI14Kgo6tDt/X4JbojQRkfegJVliI8x7mfh624IZj4fRgF4QFqtGilK0V5Gari8sog/mOVHks7vblCFdGFWlFgpwinHRe4gjO4U6NJcWUf+z/icUV6xjXTdyGg/GKHvQ0=
Received: from CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15)
 by DS0PR10MB6053.namprd10.prod.outlook.com (2603:10b6:8:ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 09:52:53 +0000
Received: from CY8PR10MB6873.namprd10.prod.outlook.com
 ([fe80::bf52:dff8:da0b:99d0]) by CY8PR10MB6873.namprd10.prod.outlook.com
 ([fe80::bf52:dff8:da0b:99d0%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 09:52:53 +0000
Message-ID: <61c27910-8d4f-4d25-b0aa-cd6c393e1754@oracle.com>
Date: Tue, 8 Apr 2025 15:22:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] arm64: errata: Add newer ARM cores to the"
 failed to apply to 6.14-stable tree
To: gregkh@linuxfoundation.org, dianders@chromium.org, catalin.marinas@arm.com,
        james.morse@arm.com
Cc: stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
References: <2025040844-unlivable-strum-7c2f@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025040844-unlivable-strum-7c2f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6873:EE_|DS0PR10MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 573472f8-1f3a-4acc-1906-08dd76832178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2txRDN0TjViVGxRVWJ3eUpmY2x3bWJPeGJ2SVNKQ3lDL0dNOWhRUXZaZ1pp?=
 =?utf-8?B?MGNGZmZnSDJEUzNnZTcySlFFNGZKN3VRK1ZCN0Vzb1pPaXZ3SUhWRkh4UWdT?=
 =?utf-8?B?eldSZXZOOFM1eE56N0lOZkdkVVBjK3lkRUVCZ3RZSjQ0Zm8vYnNBYnhRUFNi?=
 =?utf-8?B?c0dyTHh4MmZwZDdDNlM2M1o2S1hFTi9Ta3BFZ3RPNWVyMkw0TVUxMWtEa0Y2?=
 =?utf-8?B?ZWNmdzNObEFEeTdRbG5qNjFmbEwwREpSc0F6eHNSaWh4VkZ6RkZQRHlTS1dU?=
 =?utf-8?B?cENWaUJlNFlBaVJhOGJnQ0JKQ0J2M0hpT0tXZm0vUFFVcWdKU3BrcVZFcE5u?=
 =?utf-8?B?OXlwRk5KY0U4cXRVaCt3VHQ2Tk9RdnUxNmJZSkdNZjhxVVkzZ0dWa3htZkVZ?=
 =?utf-8?B?Y1VDSDlPNjNETExsSzJFd2Npd0NwODM2Mm9RYUtpdW5kTDJZZDF1Yi8rTVFB?=
 =?utf-8?B?MksvcXVqeTBqbXk1UWNsTFpjRmtOdHBqSVlaSlNobGVGUWhwdFI0VjR4aGpL?=
 =?utf-8?B?OWp0NDkwOFNoQnVReFAwWHBLaW9zZW4yK3lOaTJ4S09yaWxzMnlNb0FsNUJJ?=
 =?utf-8?B?R0YrSDZjNldQWFFnd1E0enVBMnF6bXJOQTlMVVdLYjVLeWdacnMzRElmQzJG?=
 =?utf-8?B?Ull5UFZ0UWF2MGhKVjNQUURIOXg1U3dGWE9ROS9UWE9ZWTYzZ2JDbERzVTZK?=
 =?utf-8?B?c0hYMDlJRGIxcG45U3N5THlTRHVUN1FEajR4WVlyV0hzVlV2bnVCWlhiYmlC?=
 =?utf-8?B?K1FBWm05Vytyc0xONnJpZThZcCtGeHBoNTFBai9JOXR6YlNtUWtvSDNVT3kz?=
 =?utf-8?B?enozbjVlQ0J0NFNOcHhPUlZuYVI3cWtkVklkU2ZJblc1MjBrbVNmY3VOZklJ?=
 =?utf-8?B?eUoxd0s0Kzl3LzlUZFdWV0lqYit6aVVPWkVITWVBZktrYXgvWUwyTjJvdzJT?=
 =?utf-8?B?UVpiamkyNG9FS2hub0xVTkJrRTIyL3E5QWJpWllUYm9jNWFMOHA0dUM5dDBN?=
 =?utf-8?B?R2hJaTR4N1haRkVnaDFvbGx4SVl5bks3bEdiVGRoZkNQcFVWVjNvOVpZNzE0?=
 =?utf-8?B?ZENhZnhoOWZRWGpqa2dacWVCN1RxWVhuU0h2d2NUL3c4MjZ2UWV1Y0gwaTBi?=
 =?utf-8?B?bVMzWG56VzEyWGk2UG9LMEZqWEYwdzdDZHM5aTJtQS9WRUFady8wS09kU0E0?=
 =?utf-8?B?UHlLcmc3KzV5L0IzeXVpbERpcWZFNlVpbVB4SDJpeDNVUDhTY2JPWG9YQVAv?=
 =?utf-8?B?dm1zV3J4c2J6N2JvVHNaMktSaEhDWjN5anEvN3BkRUkzcDF5NGpzOU1wR0l3?=
 =?utf-8?B?NkI2cjVSbDFqQWxjQXlLdnpNQWdiM2dOUFZ6RkRrRHpUaGtQRXFwYS9vTTdi?=
 =?utf-8?B?QWZRenFrRnovZkJOakVrU3hSckU3N0hVbzZRcnhsVUpPTmFNQlppOVd3NndU?=
 =?utf-8?B?Z0JkNkhhMjBlSHNDTk9BazBXTmM2YVVxRFloa01vMFJCYWp0QUdwZGdNT3d3?=
 =?utf-8?B?N1lwaWlGcUpBZnY5OXkveGx1TGdWRDMxQmNaOThnQTJ3ZVBKRHoyTzRRaHFv?=
 =?utf-8?B?bDhURUZ6Rm1ZUHZCUkZINHpVMlVINzR3SWE0d2hLaThQSlJjZU1TWnJMQU1p?=
 =?utf-8?B?YlZVZXBseWZhQ2ZUMUhzK0VNWnQxV3ZpUkNLVVdTMEw1VDhDaGg1ZEVSMmdG?=
 =?utf-8?B?c2V0TDZjL3ZEWVU2ZktXS2xFU2QwdloyYzlJSHcyNDViNDVpclZ5dDNpWWwv?=
 =?utf-8?B?ZzFFclQweDZTYllwVmNGVWZPWEZyVGFoUWk4UXhDN2hRVmM2WGN1bVdHbjlV?=
 =?utf-8?B?dktIRWRPRHgrU2Fnb0NtbGhlV2E4ZmRsaStrVG5UY2sxL1ZNcnlNaUlvVCtQ?=
 =?utf-8?Q?/TPuVXQ48+uYG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6873.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUc0a0c2UFZnWHl3RXl6MTI1MDkxUDAvbzlRSnlFUnVQVTZLZi9qY2hkS3Rm?=
 =?utf-8?B?RmdUelZTd1o3QmwwRUo4S0Z4OVowcXAxbHdxWGFhUUh4QitKcG96TUZISElm?=
 =?utf-8?B?ZFRzZ2RmTzVia0RBSXdQQThySWlQMW50L3hEcGNPZkJDd2tkdnZ0YkpBYlBY?=
 =?utf-8?B?eGhDaExQNUlJQUh4ZXZsWkxyQmpUdlBKaU5Ydk5GV0lMc2N4ekRKcXYzUG9R?=
 =?utf-8?B?V0N4OVRIcHB0WlN3M1RlN3k5S1BDZEFJVEM5L3ExYlZNTzB3QlQ0OEFobHkv?=
 =?utf-8?B?SGxaZTA0R04vWjhCeGhGU2hZWnA4cmJzejVWeTQwRlgzWEEyQW5tbFl6NTZU?=
 =?utf-8?B?VTdHWkt4T3NJNDlhUVZ6YmduMkhhTTFydVVJeGNRRGJ6bkpLdUo4ZVB1djA1?=
 =?utf-8?B?SmJtdHRxZHFteWlUZHp2YjY0UlE5aGF6bFhTV3pxQ2hnakppRUZncTY3Zmhn?=
 =?utf-8?B?dVRIemNVU3VWVU5aMi9FYXdLazJUbUF4em5ZL2NVOHdUbk5tRks3dVBrRzAv?=
 =?utf-8?B?VlZSV2lGMHhZcnZiZ1pCSlZuMjRVSCtOY0FEaHlVR0RmKzRLZ2VjdHVhZlpn?=
 =?utf-8?B?MS94VWJjYU91bDN6N2xtY2NFekVvZVg5ZGdLd0JUNzdLcE5XeHZ5aGxUakZ0?=
 =?utf-8?B?Uks4N3RKNXhPMjVSZHdsTithcG8wR3J3M3MwVTZ0VE93ZHpib01lR1h5T1Bx?=
 =?utf-8?B?TVJIZW5QdlgxWXBJV1dOV1RRNFlFT2N0dFBkc1lFTlQ1dXJDcFNiY0g3b2kw?=
 =?utf-8?B?Y2ZnMlM5VkJqNmVNK0ZIRHQxYS9lVktXcThhc0JqY0duV3M5Zis5U0xpMUQ3?=
 =?utf-8?B?d2kwcjhhL0NvK0hlSUplK1B1SnFMbks4eGJtc3p0Vm1EYzRraGkrOE4ySmNR?=
 =?utf-8?B?QlFhcERoSEpDdjJwZ0RUUTE2em5VMG1tVy9HVGlmK2p3bGpPb2pHZFBJSmR4?=
 =?utf-8?B?NnFVdC9WamVnVUdBbXliaWtDYlloR21UcnhDV0xnSEZvRzl2N2QwQVlNS1RV?=
 =?utf-8?B?VTZQQWd5Z2x3NnRjVTFkeWM1RFNhTXBtTGZ0amtiV2MrQnVUbWZZZzNJTytR?=
 =?utf-8?B?bWVhV3VWQ2ZvMmpSR0FPZmNEUjlnMXcvNXl0OEdaQW9jbWNzT3pueFdyaHFS?=
 =?utf-8?B?anNuQTk5Y2NpTjlvbHdsRzU3eFBhZzd5TXhYbmZDZDhoSFhranVKRFRCZE5w?=
 =?utf-8?B?L2JRWG1WUGg0Z01ZNFhzSjRoWkZ3ZU1BZzZwbUxlcjRPcGFoK2NBMk0wRFRu?=
 =?utf-8?B?RXVmNUY2UWNIcXg1dDZJQTR1dk8xa0l6UUVDWlF0Zld1Q1pMbHVLSHJULzNa?=
 =?utf-8?B?cVdzSjdUK0lPQzhGS3ByOWcybi9veDVvOXMzRzVuZTNaZytXcnJpMU1xRkpO?=
 =?utf-8?B?VjJtVWljeWdGM2Frb2tMdDhyT2tZRHRPNk05Mk9SZWZRM08zRnZyMHpPQ3FJ?=
 =?utf-8?B?WUgvV00xUlBhSXBxajAwREF4MFpzMDdaZCtQNkRWYlRwNjRXTnhuZkpiemdE?=
 =?utf-8?B?b1FqMm10cDU5dDdKdWZPMDBJWEYxSSs5N0t2RDU2YWhNR0c5WGMrMjhzZEZI?=
 =?utf-8?B?MUFDSzQyeTlTSnEyZXVhK0c4aENXenJBLzZ3M3dCSWRQODNEZWxFMmlRRjlC?=
 =?utf-8?B?dEZUZHp4T3J4SHRRWGt4TkVyUDkwdU92NDUwU29uM0VwOW5HcFFhV2JFY254?=
 =?utf-8?B?VzNXbmRzUzE1amo4OVF3dHpneDNGdytjQ3NWSWVkNW4vS0ZKY2lzSGJLZzZ6?=
 =?utf-8?B?bEN2WEhKSjVDRURFMFZaMEdVcjEzdGhvMHY2ODJUVHhtN09NQVUxaG5jem52?=
 =?utf-8?B?K2FkU3ZSVlJnTW9IK09vWGJtSlJhdnN0WlVtU2JiL0FXTWZEUVI1NDdNRGgv?=
 =?utf-8?B?Mk1sWDRsdEhhNU9kK3BPMmVvUUMxNEFIL2dtN3VyeWpjM0Q2UWJmVi90NUlH?=
 =?utf-8?B?MTVWNzA3NHJBa1RVK2RxNjFKSVhiSi8wWU5MMmF6d2xTbkM3S3JTVHFta3Jv?=
 =?utf-8?B?bUZWdnQrNmpmbzNncURzSUdKbEhobXQ1U3M2YkxCMHluNGMrVWVvKzJVb2No?=
 =?utf-8?B?L2l5VUlDOGJEcldOeU4wSkJFWHZZRk1Sekg5OHAwb2l0enBzUzVDV29WMEdP?=
 =?utf-8?B?NG56N0s0ejRuOS9uREpwckF0VDhIOCtBa2xDeDJBSlNwK2ZsS1JORE5CdjE0?=
 =?utf-8?Q?z5x436gAnqWkVvuuJi/TKEM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a1plEPDmCGkE7mm/zY1qgmRmNAKeYoKK0bm+2o+uHKcyxz9SlDaJv+SlfqK+5NS1HbV8LboiX/OAiy6qcOPHLzLVh9YqV/X/9Sr0k9qY2wQqdLIgNKk3THqS8ENChbbLhk95qGqCQA6VcH755asQ67SFsN1SzktbYecxkcobx3Vb1nTzCmTp6WK0UgzZpmPvKZq6ntIUiL3u6Hi2Fug6FWspcbmlcCwXbqe/zeOw5YRWbH43VhjTA2USdy+jcBZMzEDxNSjhLhNWstui8Kpbt7pNW5HtmSbRk+DELsH5g7FgkiWEtFApMbBgYkwiSOa2U1htuOgWX6pe73o/o7IwmBZFwIujDYKtz2Ivo/jU30F4T5VNGxIvrqWCSDVnFwGO1U0i6Lcl0R67b7Z+JaF+rkfy1DkUl8m7wiqPEZt9Ok48lYjP4xbsm5i2xHomp+vx3EWMITCE6q3ZUC9jQ0rNtzzDhqsoua449Qym3/H+Lu4LIbH2Hoojr0wfz5SQBDMaArFAZPfxmSr1T0oxuzH4qDj6QBKca+9awGGt35cJk9nlq5gqoCViTD/37UMeeQHgR8m00OIU9BV8Rk7+xOHO8uqXtvb2NCVyEkFVHiqD7pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573472f8-1f3a-4acc-1906-08dd76832178
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6873.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 09:52:53.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiwOqZexiRpYqD9BDHaljoHeVWo1lF9azOjuXao/J1vz81yOnLGGLR19Mg6AyFpjS3hhsIEkxhT1tdKxD/bq9JfwNvxpnkuFmElMVB5/MNAfuTaqBMWs2WBA0FPZlx8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080070
X-Proofpoint-GUID: h32ChVKodoHPkCKW2Jml3Vvy6Io1SiQN
X-Proofpoint-ORIG-GUID: h32ChVKodoHPkCKW2Jml3Vvy6Io1SiQN

Hi stable maintainers,

On 08/04/25 14:45, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040844-unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> 
> Possible dependencies:
> 
> 

Note:

Have observed that mostly these dependencies are empty in newer stable 
FAILED patch emails.

Thanks,
Harshit

> 
> thanks,
> 
> greg k-h
...
> 

