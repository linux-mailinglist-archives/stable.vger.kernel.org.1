Return-Path: <stable+bounces-146020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783AAC0363
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 06:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EA91BA2DB4
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832714658D;
	Thu, 22 May 2025 04:35:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796415381A;
	Thu, 22 May 2025 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747888512; cv=fail; b=UXXBlxBfJmly3SUaaT8ro6X3nMMJNxgeodULpwOk0gqzKppWF37tulHaU0rF8i8tP3O0zvCcPeUTgpiVUEm8R+Kms+/1YgxHeIM/F+N2MfY4MQmK3+fGYxoFOzr6YdhrHuS0qhcQu1LENlZYYSMtlBgMnOZYJPp09ywzKZEA45c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747888512; c=relaxed/simple;
	bh=Afx/XFjPv3sIcQ7zMC4TjEezFkJVu+uo0vycP59LBi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DetHpXbtAxLCF7Wd9KUIf/bk/W/zVvVk+hv5YRx/UaEVmfURuMiOW6jaYXL/17JIHwAFijytH+QKkNX2d/HalNxXnc3e70tuvxSBDJOqQ86TMCmRN/f3xx9lt7NwBJ4ObqJ1WuVIFmeDCaDWlS0rlAGUBFbmcZsu+41PfHkOXgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M4Kb8e011924;
	Wed, 21 May 2025 21:35:00 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfsa50a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 21:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5RS1ly/czgHJvR9F9GSz7y9j5iX1w+O2oP3Qphjfx5prxzbdrHoHVWMc3oQ8wQ3d/fzfbAeq2t/xGrh1JWsY25Ptf2sKYcG0rNz4BArUzVxuKbKVMgxoM3eTnXd/JweIYAj+6DDikEYFsaFb3F6jKB5ktrjor1fjVD259//Ro/o2jUnuFYhuRWi5uSDlcM4/Pu1a4JPDsb5Ea35wi76szgyTqCRrh0MZuyyk5DOKmivnfR5MyYbZNN96QHXvEKQBZLMw7d741eONDtjoYFak73ahLy+zlxz/EQCiPxRaoqeYjQGKv1n/vvhAMWwma7l2xd8VQ68kqZqw3nni/Cgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/OqeSm+FQtJMWIem+XrPv7zKAQ3o8FE0v2mNB0hzJQ=;
 b=wRzRUrAoF3HJo20OzpC8fDGrwcBg1zw7WF8oSoYKdd9UzXHWKU9SVXvMQSM3tahG9Q87gOEMKixQziW2s2vD23OC96pGKk1ijhoaHLkKkwQTLRhIiz3xbGI2BHYj+M0oILfWL3BVXARcd1alkSbMMgXR4TrU+jb+NHIzRIe7oIYg9P5cfmiwgooG4YaDavzI6U5sh080ikewHUSOC4NlDvdZ4Z7Z840lmAb8xiTTMLFt0eiCbKIE1o8/51Vvo4KqgQBA04+xWqVBqG+DF+WvpQ2mhAaI6LCf947D8XTQndxmGUnY5cEjphwJBjGk/YEo6s7bvSPNuZeUTUGEAiryig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 04:34:57 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 04:34:57 +0000
Message-ID: <faf777ea-3667-45c7-b7f2-111b9f789e73@windriver.com>
Date: Thu, 22 May 2025 12:35:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfs mount failed with ipv6 addr
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6bb8f01e-628d-4353-8ed5-f77939e99df9@windriver.com>
 <174787036205.62796.16633284882232555223@noble.neil.brown.name>
Content-Language: en-US
From: Haixiao Yan <haixiao.yan.cn@windriver.com>
In-Reply-To: <174787036205.62796.16633284882232555223@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 198441c7-c50e-47a6-173d-08dd98ea0147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXAza2xldEV5K0xpTTV3OHZ2ZG1hbDVhU3NLWWxGR0JHWVh4OTFTYitiZ0JN?=
 =?utf-8?B?UUM3Y05CZkZDQ3IwUElmUGxDYnlsQ1NqWU85TDJtZlArNG9YVHJUUFJSM3Qz?=
 =?utf-8?B?bk13YmlCQ2JoeVhnNTNtRmd0NnAyYjZMQ2FNVnA5T09IS25HK2VDN3gvTXRG?=
 =?utf-8?B?cnF2Nkt1U3Zrd1hzQ09OTVpxUm5IVUNCUklQVkQ3cU8wNXZCbkV6bmk3aFlm?=
 =?utf-8?B?LzRUUHk2RVkzblFMdlFEeTlldklSMjBoZmFYQnBSSmlRcnk2SWQ0S2N5SkhH?=
 =?utf-8?B?T0tHbld1SUp2NXZOcVBnS2NpZldjaDVZTFZaU1d4VDdlQis3Z29BQk5qdnA1?=
 =?utf-8?B?cnlrSXBUOTNVYk4xckxlRHQyYnhjd2VuTWw2cUN1VmEvV29KaHQyTWV2Unk1?=
 =?utf-8?B?Wm9xb1lSZXNVanRKRmdlelJaeWl1c1BULzlLQ1p4YW1NdEc3ZG13L2pQK082?=
 =?utf-8?B?QWpuVEpCdk45QmI1bTVwZ3lZWFIvQmE1Y3RTZXJZbndGc0pvNG1xSUJPclQw?=
 =?utf-8?B?U1FBZkl3N09jdFRnc3NOc0xzK1N1UkN0a3BFUkovYnJpdGNad3RHTnU5a2ZV?=
 =?utf-8?B?ZDVaRUxhSFRBUDJEZHg5UXcyUEtGNU5GaHFFSUdqUDNZODhOK1lTajlIOWlR?=
 =?utf-8?B?OHVWZFY5Z3lFUEQzMU9FQzVXK0M1TjFuYXFack5kYThwcFpYNzFIWExqNVAr?=
 =?utf-8?B?aVN2Y0hEY0xlV090ZmtqZVI4dXRhd1pVcXc4a2RwVStnbjU2NkFiYVpIMk4z?=
 =?utf-8?B?cnhDVjAvWm1panRrSTVvbW1PQUJPL2oxeDZmYnpnTDRPbUREV2xIdk1FdW1Y?=
 =?utf-8?B?STQxc2RZUlZ1aFZWNCt6VjdFbmFYcy9zOHdYTExwNk0xV3Z1b2MvcG9FVlFq?=
 =?utf-8?B?akx4ZFBFdmFQUkExekRWUndXYnpUY1FBME0yaW82YkdERjdKcVY1bmxDa1lr?=
 =?utf-8?B?ZUlKZXE3Z20vd2xBWFVMSWRBMXRDbThnWDFGNW5OQWRDaXVxVFRqbDAvU29i?=
 =?utf-8?B?enQ3bUFuUUd3dnMxTXplbU9PNTBvME5GQW5uQkRGT3hjVHU1Z1JPNEVPZUVv?=
 =?utf-8?B?Wkx1aHU4bHRjTjlWSFBOVGgwOHJTYUQ1MXFaWkdRQmFkREZwenhLN0ZhaEtF?=
 =?utf-8?B?T3I3YlUxMTJCV2ZrMU5Jdy9qMndYR1J4UGkwZWhpRjl3TDdHZGhyR05Scnhs?=
 =?utf-8?B?V1RJT2dMNXV2dkQ0S0F6U203SHlTZXBFYXJFTEVmZ2hTYXlxOTRlWWMyZFpo?=
 =?utf-8?B?SzYzVFdxSDhYbHJlbS8vS1BsWW93ZDE3RHBmSUxWYTcxM1VmY0cySFFLRWhJ?=
 =?utf-8?B?bVRyWDdENS9OU2ExQzc0S3crbnVMby9LMHAycTRCUWtaeGh0UmNWM0xEcVVy?=
 =?utf-8?B?dkIwNWNLSlNxZURkOHFsenFmZmRwb2pFRXNjR1ZRdkU4UDQ4UVJ2K1A2K1VS?=
 =?utf-8?B?WGN1REZkV29LUlYzVXpuWTJ4TjMzdi8wcVBOdUpmckF5VjJVOWZkaDZaZGZV?=
 =?utf-8?B?YVhFak9wNW9lMW8yaGVtYUlYTEVDNVZiaW9EWmMxcTR2aTl5U3d0UzRKdlZC?=
 =?utf-8?B?WWtoNGptaEhMVHpNMVFrQ0x5S0h2M2l1SnJRWkNScEFlMzVpQnFBREJmZG9h?=
 =?utf-8?B?R3ppYUZmWmQwblZmbG1Qblp3K1d3UEZzV3A4ek9hdGtYTnJqcndlYXZFdDJV?=
 =?utf-8?B?S3dUWTNPbWtQN1M4YkdZaFF4TFptOWd5WmhIWkd5SUNYZnJNcWhZY1E5aEZJ?=
 =?utf-8?B?TFprcW5uMzN2cFI1NGY5VFphSmREQWdjVmp3SkJycW9qUVdYWEwwVGNpaHMr?=
 =?utf-8?B?dzJXdXdBbGFQU1prSmR6aVBESVpVdjliSVpJTGNhZEdTM1JOUjlPYmlGKzVH?=
 =?utf-8?B?MGhoVXpwN1l6TnVyeXgwS2Jrbngwa0cra3BDMVZIVk5MUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFV2SzdNVjFyRUhmRFZaOVZESEZOdlVGSGF0aklVMTlRMktwUzhkK1d5QUIy?=
 =?utf-8?B?UjlGNVQyWGZYVWRUT0piVTE0SHUrblJYU3ZXM3BOUmtqYS90c2NBL1lxNzFF?=
 =?utf-8?B?d3hYNUpNTDZ2LzdDT1hhSU5XUUFEZ2JYY3RYc1l3dFI5VWZ2b2NlR1BLOEJT?=
 =?utf-8?B?TDlmNDd0cWlpWXVFMXNTaHdjTUV5SjQyK0JITlc3anRYZ1QzZGJqU0lqRHFB?=
 =?utf-8?B?cHlCSms4S0ZoNndGQzZvRmNpSm9DYjRURzJ6clBSaHdiK2wyZ1NvOTNhNUxR?=
 =?utf-8?B?ekRRakZzZ2c5QTAzb3oxY21VTjRQckVEYXlma0Y3cEg1d0Z4RG1oMHYrd3Vx?=
 =?utf-8?B?aTM1dDlYdDZHUGlzQzA3c2xNdmswK2xhMk5Zd2NIRjRaYmhzblVvRVM5RjBY?=
 =?utf-8?B?b0lWMlUyd1pIUFU2Y1VEbEFGcERrU1Brckd5SzhVcHR5QXlZcWNRdi9MTmtG?=
 =?utf-8?B?bW9rYXYwQk5yWmE5OFdlZ1ZlbmlSSmRWSlh6cnRjOThQdW9tMG1WTUN6MFFJ?=
 =?utf-8?B?MmV3ZW9WRGNWeEVZdUd5N2hITU14Z1psYitlWnErdDZ0elF4dU1laHZ2MExO?=
 =?utf-8?B?K080cWluam9pVnB4V0txY0tvMm1CaXh5KzNFM21CNHoxaDFpTU8xaXZ0WkU3?=
 =?utf-8?B?S2FYdjdOZzdvMWlHYnY1ZnRYOHBEMWtmZGE3Q05RcGxwU2NPNkZ5Mkc2bFVp?=
 =?utf-8?B?bm9LVzFHZEVrVVZRVVR0U21vbjRZRld1MkRYaWZmWUN4WVNoN2lqK0hRRVM2?=
 =?utf-8?B?MXg5RjdJZXA4QTBta3k1cmVJTG9lT3UvUkxBeHcyY1NValBZeURUOWlUZnJP?=
 =?utf-8?B?a0VkMDNHbGhMaUU3UWR6Vlp1eWpjSUYrNUIvQ0dpeXE0NWUzZHRLU2JIMnNx?=
 =?utf-8?B?MU4wSDRYdkFJejhJMG5ZWHIxSklOMldCanpOcytZTzVibjN1eUpKdHN4U3RP?=
 =?utf-8?B?UVJtdW1LYlY4VE9DblBzK2tPS3NaZzFtbW1mdzB1WTF6Z2hmbUFodHFLcGND?=
 =?utf-8?B?VG16ZkJ0S21TbWM1NWdicWpIK3UyZmozdS9vd0xPdGZSK3dJZjVmZ2hkWHdi?=
 =?utf-8?B?eGE2aGUyZkdUMXVKSWxnUU1QeEdOdDRESk5iWHJNUVVITHNWRWJNais5K3pD?=
 =?utf-8?B?RDZqaHlPam4rZW1RTU9vWlloOHlxTjZLMk1MYzJVcFZoRkJsdzlEZm95WjJu?=
 =?utf-8?B?UTZhdEwyVENzL2JDclJDYy9KdGhmM3BUSkpReUtFRFk5b09xT0FudW1EYnVh?=
 =?utf-8?B?MkMxN1U4SUt1VXIwS2ZQTHhrWGFZc2RCdzRvbElxcVp1VWhiUjJ4Mjd5THRW?=
 =?utf-8?B?ZjBmZldvcm4wMWhZUHdza29VdDIyN2twS3Jqb1M1amo3ZWVPQkxicDlmTXcz?=
 =?utf-8?B?N3E3MExpUWVzQ09EeVBqTWNYQldhU2g4YTdDbTB2MWVGWUwzdmNORHlDSUx6?=
 =?utf-8?B?YkNac0Y1bGlaVm9qSXc4cDFrS1I1b2c3UkJxdGpRYys2N1g1cGU4NFdZWFZn?=
 =?utf-8?B?K0pDMmp0NDE2TDJDL1hrU1dIbzB4R2RDUGt2N0dKS0E4TElNdFhkWjVFRktN?=
 =?utf-8?B?UThiN0w0dlJWNlJ4YS81dWZ0dHZWM2dOaSttb05SMmlocXM3YzlVZWNYL2Fi?=
 =?utf-8?B?NlJ3QXN6d24yU0g5N2VSTVhub3p4c2RSN2pyTUhIRWZZemh6V3A4VEVidVlm?=
 =?utf-8?B?UFhHNE4yTVFxbkorM1VBbnkvTm0rQVQyelN1eGVPTmp2Z200cFZqSEgzWGhw?=
 =?utf-8?B?ZURNeVRJcmFhb21KRmtseUYvTytGcTNGa0ZQQmZabVhWNitOcTZnanYzN3Q1?=
 =?utf-8?B?Qkx3dDc5V3hUZ2dnQzlFWkF2K3JxbC80eUdzajdHQTdxMlhER3FELzBUMnh5?=
 =?utf-8?B?YUVRdkNXaHNzWVhXd1NxL1JRZHBRUUNRVDZEWG1Td1labUZiOHhhZUVXUWgv?=
 =?utf-8?B?a0tkQitkTEVHc1VXQTZ3MCs0a3QzSndzbUlldzdZQS90OStPL1FYdUUzbG4v?=
 =?utf-8?B?TklOSUlCQ1JSSnFQRlVCMnZ0S2hnRy83cTY5QUQ0dGxnUkpGOVoyTG1JeFZT?=
 =?utf-8?B?eXdqeU4rcVhsU0NFT3JVK0NrUHhselN6N2pna0VQRStVZHRIODVUYmx2bFhB?=
 =?utf-8?B?UUlyUlg2eklwUjJmbmptOTVzbHZGQU1Ma0VuZmYxWm80WDVMcjVTeXJpVWs1?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198441c7-c50e-47a6-173d-08dd98ea0147
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 04:34:56.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJTuz63YG52xtlueFvJf9V75lFzd6M09uRyhzoYBmtopGBO3GAk8jkGH3As5hgRBVeUXhvM0ZoZGmAs1f70TRqNH5wsxy/jruTxQxMG7LyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-Proofpoint-GUID: 4oQAIgMMdwZawBIuLSCb64aNFoartlOo
X-Proofpoint-ORIG-GUID: 4oQAIgMMdwZawBIuLSCb64aNFoartlOo
X-Authority-Analysis: v=2.4 cv=KJNaDEFo c=1 sm=1 tr=0 ts=682ea974 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ohSTu4VjT-xp73rRBukA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA0MyBTYWx0ZWRfX/wdCArl3ZT9l slNyYmjr446Ii01Rt9EpN5gsSE0NsrKW5zjWXJyPcC0qSTFUntj8Wfa/mpmLLHfz8hCLXYgHOOb rufe1F/yvlkf9kmB8VNVtMRIc0eGpAmYmtWBYrp9uZYgrK+L/EUhLiuq7205eZLb/g8h/Xv5UYF
 H0cf8+L7f9z/b/QZjkfTAjDT3HG3leypand4G+KWQc3c8P2GuPddr/JMlFaS3zuL6gq687imzTd N5GKYvWFkjtVzf/WNV7BONAs6H8xwPkC99FWf6ltuSL2DIM+iLfxybhxBa/nysmn2FVUXecyNju cDXydWJ31+JCMIwH1se6wXBJzkbBTJ2bsxh5+TpmCaQH2Wj0X7F05W/Y1SD6UXXkBPKrvyC0+Nx
 2zs0Qlo543Cqefv9DHpb1aB0zOYWw9qtESfPIErjEPQIbK+GHIvvqqJweqHDJzGQGngYL55g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505220043


On 2025/5/22 07:32, NeilBrown wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
>> On linux-5.10.y, my testcase run failed:
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
>> mount.nfs: requested NFS version or transport protocol is not supported
>>
>> The first bad commit is:
>>
>> commit 7229200f68662660bb4d55f19247eaf3c79a4217
>> Author: Chuck Lever <chuck.lever@oracle.com>
>> Date:   Mon Jun 3 10:35:02 2024 -0400
>>
>>     nfsd: don't allow nfsd threads to be signalled.
>>
>>     [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
>>
>>
>> Here is the test log:
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/dev/zero of=/tmp/nfs.img bs=1M count=100
>> 100+0 records in
>> 100+0 records out
>> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/nfs.img
>> mke2fs 1.46.1 (9-Feb-2021)
>> Discarding device blocks:   1024/102400             done
>> Creating filesystem with 102400 1k blocks and 25688 inodes
>> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
>> Superblock backups stored on blocks:
>>        8193, 24577, 40961, 57345, 73729
>>
>> Allocating group tables:  0/13     done
>> Writing inode tables:  0/13     done
>> Writing superblocks and filesystem accounting information:  0/13     done
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp/nfs.img /mnt
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/nfs_root
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc/exports
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
>>
>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-test/bin/svcwp.sh nfsserver restart
>> stopping mountd: done
>> stopping nfsd: ..........failed
>>    using signal 9:
>> ..........failed
> What does your "nfsserver" script do to try to stop/restart the nfsd?
> For a very long time the approved way to stop nfsd has been to run
> "rpc.nfsd 0".  My guess is that whatever script you are using still
> trying to send a signal to nfsd.  That no longer works.
>
> Unfortunately the various sysv-init scripts for starting/stopping nfsd
> have never been part of nfs-utils so we were not able to update them.
> nfs-utils *does* contain systemd unit files for sites which use systemd.
>
> If you have a non-systemd way of starting/stopping nfsd, we would be
> happy to make the relevant scripts part of nfs-utils so that we can
> ensure they stay up to date.

Actually, we use  service nfsserver restart  =>
/etc/init.d/nfsserver =>

stop_nfsd(){
     # WARNING: this kills any process with the executable
     # name 'nfsd'.
     echo -n 'stopping nfsd: '
     start-stop-daemon --stop --quiet --signal 1 --name nfsd
     if delay_nfsd || {
         echo failed
         echo ' using signal 9: '
         start-stop-daemon --stop --quiet --signal 9 --name nfsd
         delay_nfsd
     }
     then
         echo done
     else
         echo failed
     fi
}

Thanks,

Haixiao

> Thanks,
> NeilBrown

