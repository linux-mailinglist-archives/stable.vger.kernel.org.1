Return-Path: <stable+bounces-158693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A6AE9F27
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF691169A77
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666F22E7178;
	Thu, 26 Jun 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="01NpN6zc"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F92E6D12;
	Thu, 26 Jun 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945311; cv=fail; b=X51SDpZoMf2faPi3SjYBLX2hKY5DypKFsjoIiqYnWD1X/v8Mxu0HttEkFWczEOsh5wFNK1QVAljMONya84kHew2ff4qCz2ge5pMvn4cM9mYA3kq/1jv0BSQtGzmv55Qo7iRUzf3kFyyHRXvqFBIngKs/sFnHAmTXw//lTIMxSIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945311; c=relaxed/simple;
	bh=GZL5xDD6QB+Oq91Xi7iQP45WwHvn6O1+VO33Q91Dt/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyiVxZGMh/icFnif1gM3+MLMo4L0lw/p2VsrZWnXGFtROFpqstzL2+V+L2lM+6teZO2Lis7OGnMbYcMPGGYNi/NOXVekQMfXTC/S4iknM6rw1g77dKZUMELGU7CvC0jCFrlbMolk0QgtDnLb4xh+eRptpQGBD7yYoZDgF7Lr+qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=01NpN6zc; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB1Y4UPSBxk32ZIjp5uhSOypOmXyX8u7bHXczhR3TqcrTL/kD4+58mEIYWJGpBGOps/Hfqo0uerN8zvwncQYF2suyoCrRdC5hn3Tswni+8bbCBUH+gOJGuxzbs+NCxuioBjtAOCV2uWPgGeRIfDrnSKbbsrAb63L9CTtJ3RAS07xiNeUIW587a14uFJc8mPB5/CBaYb7NPiVBCFA8EXKXyqpkpRJmuwhR3n5Splbyp9iXtx4Q5oqrldxaTyuNAG8T0m36SkM6PRpifBwtTg4IstgjFGyiyVn896fa/oCMHa9nXEG19fSfsoNsvzaXCNCV59e8trEYCqIXsokYmJToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+TA1gPz5kAVoPaKQfdXx4o9W+sOIYTo/vjjlG+g0uc=;
 b=GcnFmkamzPynOaqSeMjztDnqMkzJMiB4SoV9BESSKul9ZrzTxv3GlyFFQP+yp+RuoWYWQbJOEZWKrnlHk254HzByEFTCYLODEk8hVcnzP4nDpyGgNV2Yafs8AM1i/VNx1UcHzuFieoYa/T7n3DuoEcIB4dFuP+gdp/FYehcf/aP2XcbOHLXy0qAB6tsqrDHSRQnaEXUja9/Ohtx7pBU2XhvsN/6vu55HCum32OmR3ycEaZhXaq17hjMrl+t8vLcsIwzQZGBEsM/NKRm54x3ntHelxtRTzaio7s0bI2AmDHm8ht0oxmBGx4wgLhXZ+Jj/EhzjyUpWBCMSxdULdjjq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+TA1gPz5kAVoPaKQfdXx4o9W+sOIYTo/vjjlG+g0uc=;
 b=01NpN6zcgyKhTVgi8rtIBuBS8B5UVLwb5ZKVDJw94SameGcCfSmMDx3ZQeWOM+KD9jWyFF1EvqOpk1OeqNkwHwakk/b5cPJj66No+3XTH8uf3+UH4WAIiaIpCasEc2+UFP+3tBXZueMJkQCikzVJJL5spEPK8QqvdVHoK6pa3Ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 13:41:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8857.019; Thu, 26 Jun 2025
 13:41:46 +0000
Message-ID: <069049ff-178a-6d94-d161-5a7b90b6245c@amd.com>
Date: Thu, 26 Jun 2025 08:41:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
Content-Language: en-US
To: "Nikunj A. Dadhania" <nikunj@amd.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 aik@amd.com, dionnaglaze@google.com, stable@vger.kernel.org
References: <20250626060142.2443408-1-nikunj@amd.com>
 <aF0ESlmxi1uOHkrc@gmail.com> <f2292bcb-ccc5-4121-98ce-bf65c0590131@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <f2292bcb-ccc5-4121-98ce-bf65c0590131@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e20bd4-c86c-4018-8ef3-08ddb4b731d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTFoT2JpUWRsM2d3ZWxmNjhGRS9GaTdSOHZBWkk2N3ZzaTAwOEpXN1BvU2Rp?=
 =?utf-8?B?clRnSTBEcGl1TDVEOWJiSko4VWFtc3VoRjRpNkF6VXh5cWovU24vMWR6UDlq?=
 =?utf-8?B?YlgyNmV6anZ2ek5Kd3d1QjBGM3JCWVZ3cXBkZkZRL2RWaVF3NUgzRmdkM05y?=
 =?utf-8?B?cWJQRXVaeEFpODdJTEZmalU4Rm05VGx6UnhqNllPaEdlcVJUUWpiTm5EMnFD?=
 =?utf-8?B?Vno1N1hSMGNtZG01NlJDcE1JN2Q4S0xVdnJjSnIwNXNIVTU0WE1FSzdWbU8z?=
 =?utf-8?B?eFBLd1pGMlJQTHU3OHZBZmMzTmlqamg1b1pucDFHakIxcXBDem1kdzdnRFhJ?=
 =?utf-8?B?YXhUQmlCdW5vcVlmYmh3cEdaTWIwNndqYjEwRzh2L3lvUnhCdGk3aFp2WU5G?=
 =?utf-8?B?R3pDdU5ZUVE0T2JOSHJhRnBIOGNWamxvMUhubzRWV1IyTlhVTFJWNnA0bFdD?=
 =?utf-8?B?OVZhVWFESitoNEVoN0l2bjd2ZGhGV3RNUGFNdFB2TUVPdDJvVy9Jc3dRKzVO?=
 =?utf-8?B?TnZlcVQ4RDlEOHFBVmN3cGdZMW5wWUdUUzZQRGxpWjFpOHk3SnYyak55N0hp?=
 =?utf-8?B?QWFrMW9ONjVyZEpOb3RiVEFzbkFXQm5mN205cXFQcmNGbXNyRDU2aDJGUExT?=
 =?utf-8?B?b2EwMkhFNDhsOVJWQ3NNeUdMKysvaklPK3FWMGFNK1pzYkRqR1p5Mk5FSUlW?=
 =?utf-8?B?NER2bmtBNE1WR0dvQXJlb1Y0TDlQUlJhS3UxcExab0VlMjV2eHJXdUZxdC9k?=
 =?utf-8?B?NnlhMVJkZnA2ckwrdlQ0ZXpTWUw0enJHNDd3d2Jva0xNRUxwd0lsUG5lWkdk?=
 =?utf-8?B?SEVNSGFCVzVZbDE0MUJDWVJ0dFVYRXZid0pQRitubEhVRFpjR29qc3lGbEZj?=
 =?utf-8?B?dnptWGdPRk1GYmVpeGNtSktPYlVZNW0yUStUcXJJQlpqUldLZHZ4aUFkYzJa?=
 =?utf-8?B?V25Ha2xVdHB3amNGODdBdjNDcS9Hc3VreEpYWXhwMjE3SEVoT1QvWGtrN3Bj?=
 =?utf-8?B?dG9XZFFFRDJCOFF3QWxqWVU3ME9oNUd3eDJzQ3VURzZ4Q3VBeFg2ZGRzVGk5?=
 =?utf-8?B?WW1WY2VRdUVHY08vUm82K3dZYUFaaDJXYU1NeG9BaWVXWFZHanYvZWJTRTlq?=
 =?utf-8?B?d2E5RG9XKzFNNDJDS3IyYWhSeUE2RTVNRDdHUW5ZYjd3Z3JsUnBabU5nVzFu?=
 =?utf-8?B?Y3hKL3liN21jWHFlZVhJSjJCV0JvL1p1cm1zMmFTNmJqS2VSOGo4NGllL1I1?=
 =?utf-8?B?Z2xVR1NxazlCaVA2b3AzTXVWaVBEMVh0OFBGcU9zdHNIWTNuWHlwUkwrRmZ1?=
 =?utf-8?B?ZUJQTVlZcVpWQzFGdUs2MGE2Y0tVTTRhZTRZUW9wdE1WRURyd2pDZytzOGlF?=
 =?utf-8?B?a3dEcWNGbGI5VlJyc0s1dFk4eDRoOWszQmpvckxHOXIyenFGOWJiOU5heUpX?=
 =?utf-8?B?clJCVlRkU05EYk9Zbm1QQVBzRFVzZ2YwWHo5V1lqblZhajRGRWNWVStwVkN5?=
 =?utf-8?B?T2N5dTJRZU5ZTVFPRDIrNDBrOTNyZVUwcml1bVdDaDFhb0hFajd5WXRMRHUv?=
 =?utf-8?B?MkE5cFJKaHFzcURQeEJiOUMrWVNneFlGdWZ1Y3ZRRW5Ib296aXRhak1ObmNx?=
 =?utf-8?B?d0ZYamJ0dVY4QWhGY3NPa3F1YzhvbndCdzlLdVRnWERYaDBhU3hheHZnYWd2?=
 =?utf-8?B?bVJWY01iMXZlNWtkMWVkaGl5ZHNMUFlicGpCWWlkbjVMWDBESVZwOGtzdGVh?=
 =?utf-8?B?dUZUZkhxeHhHeG1BZFl1VkpzOHBEZ2YzVjc4L3FQSVVoQ1N0b2o5WmFkM3By?=
 =?utf-8?B?RUVRM294LzZoTk9BL0VRSCtQU3k5Q2V5S1VoZVdDVVFmR1owVHhvZG1qVUtQ?=
 =?utf-8?B?clhjWUVtcGRjQkFHRXdYY09KRnAwd29jN25oUzFnYjdReDlCT0d2RGdudysx?=
 =?utf-8?Q?bmQCOaB2yKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRNdEJrdzh6YnQ4L3ROdVVHVE5DSHMyUm00UEFPQ0lkZVB0QjZ5V0g5VjdB?=
 =?utf-8?B?UUl1VmZ2NGtMMG5wS2ZNVis2RTdIRHdNR2cxMkNpZ3JYYXF5VUR5djBQU0pp?=
 =?utf-8?B?Ni8xKzlXbWxud24zUVJpaVJ2UmFTdm14NTZqYXYrY1BXTFRvT0tsK1lTbVdD?=
 =?utf-8?B?VUhhWlI1c3crSnQ3M2ZSeFRtb01GMXAvUHVVRXJMaWIyMFR4MUp5MGxmeFFK?=
 =?utf-8?B?U2ZHN2phancySVlydWtjVWE2eWVLTWt2ZVlna2xrckVueFUxS1cxdlViT2xR?=
 =?utf-8?B?MVdPUzlxa1Ziamd6Rk9lc0tCdExYeENXRThpakp4akRhYWt3Wkd4SFZBTWpV?=
 =?utf-8?B?aGRhbjdRbElVU0VvT0pxTTExZ21ZMy9CUDNRcFNTOEp0dWY5K1dlb0pxTC9o?=
 =?utf-8?B?RGdnRWJhcFNBeWg4ZkdKdmw2c2JBNm9oQ0FIZ0lvMGVLcUV2Wm53ZWEzMDYy?=
 =?utf-8?B?MjRhOTYyeFhtbWk0bTF2eDhtVWhPWDltWk4ySi9YUkhhdDFPd1dpY2N1VmJN?=
 =?utf-8?B?Uy8yTmMzVW5PRGVHbEEzMk9vSnhCMXNhbkJFQTZZcVA4Q0hucUtCMnM4a29F?=
 =?utf-8?B?ZFRUeDdvYzh3cnA0THRWZ3ZtU2VTd2NrVkxsZ054VjFpelo4dFF1bkY1VGQy?=
 =?utf-8?B?OWhFS0czWEFKa0xJK09DUVlDMjZoYy9DaVYwQkljWlZHL3R1T045R1lMWFc0?=
 =?utf-8?B?TTR0NVlWSTU3d2x6eU9aU0hkRjVmVUlucGQvazNHU09CU1EzUlZRaEQ4ZWV0?=
 =?utf-8?B?aTQ2NStyck1LRlVyVzJQWkNwSUVHVW5TZDNtZndiazRjazlJbldMdzhxTnNO?=
 =?utf-8?B?cENlN01tWlg2dEdsUUlJNlhaOEZFdFdPek5DSE9aQUVtUHYvUVZMeEQ5bUdP?=
 =?utf-8?B?VUJmTXlMdEtxS2JjZElFejgvNWNybkNlWldibGw4ZGRnVExqVUx1bzRFSkFq?=
 =?utf-8?B?SkpkVElpakhLN080aGNzTTk1amNoMW1NbEs4Mk41Yit4blBONW1QVXljVTRX?=
 =?utf-8?B?NlFvcXJWYUpFcEpiRmJVcFpEUjVsUDlkVndoaEY3c3IzeElTVkNUNlMvc3lr?=
 =?utf-8?B?Vm0vdjFwTTV3WUpJYzUrN0swZ3NZYUNMbmlXUVMvMlhKWHVkaGZvbVFvczlN?=
 =?utf-8?B?dFRTZ1JoVVY1cGwwbG1NcFdCaUpvSHVsOW9STFhYSVZudnRKcXFnTFZHa2w4?=
 =?utf-8?B?TjhVMFU3VjZlRGEwb3k0S2lUSyt6WjlnZGU5cVkwRnVTUUtYM3VvclovZGUr?=
 =?utf-8?B?RVhHV2p0Q2tPVU9kWjNrTXBiaFJROFVVRThnSFRPdUxqc3ZCTTkrWG5GQWIy?=
 =?utf-8?B?dTVON3Rwb09WM3JjaXVpdnA2MzZ0VnVsVFFxMUJTUCs1aWNmVng0WjBGVlRV?=
 =?utf-8?B?dnZpMnhyTlVTVkFGL1ZtSGhkcEc5QmdQdWh2QzdjMXVmKytOdkl4L3RlZ3RJ?=
 =?utf-8?B?R21zWWVUZG0zOXFMUDNpM09qSkgvYlBWcUdhelJOOFMyb3c3RkFLWDhaL2tK?=
 =?utf-8?B?S1A4ZzNGdlhPQktBN2NLVW5mU0FFbDJQa3hvZjQ4OXpXV0ttazRRMDN1NGEz?=
 =?utf-8?B?Uko4dVpxUW0xWkh0S0F3R1lKY1dILzhEc2VxODF1Qm0wVCthc2J5RUFlN3VU?=
 =?utf-8?B?bkRueUJaQVpFYXUrN3NJVU5SQXNXWEpXeGxKQW5TbG14TjRWSUxGS1AxckYr?=
 =?utf-8?B?WUhrektwT2pPV3diZVdXVE14UTNWY0JIMy9GRUJ4bFpvUU5lSWg3STdXd3pM?=
 =?utf-8?B?eXM3NkE2L2ZWRmZtOVplNHV2bmF5TDlnMmMxak1lcng0a3VKM21nMFhWN2xr?=
 =?utf-8?B?SFhad3NrWmFJWjYvS0U5YTIwQXNEd1E2d3Zxd3BGN2l1WnZDNm81Wklodkk3?=
 =?utf-8?B?Vk5OS1RNZGR3R0RDaXcrSDRaM0wyeTFETVVKY2s4TnoyR1ZvZC9NaU1JcHdW?=
 =?utf-8?B?SEZWWmdTakhyWXZ3Q2tQY3pmb2oydVhFaFVYa1hlN1ZsTEhPSW9PWWNCY1pQ?=
 =?utf-8?B?RTd3ZHp2ay9MUEdGNlROVXlGaHk2eUs4YkxDeDVsak5uZWZ6Y1FIY0hYWXIv?=
 =?utf-8?B?a3o2UjlaQlkvd3ZjOWVtdzkxMkJnVmFtQnZNRTFxQlU5eG9rbGVyVThyaFFr?=
 =?utf-8?Q?wSmIg7p6aY/7wuyqjhBleSP0H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e20bd4-c86c-4018-8ef3-08ddb4b731d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:41:46.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biuY/Kpuf2cqy8FNAkFpLXdFrFRPFfx1OQw9od2D8LME7jylOJomt3TYIeoh0FZhOboNtuLHcD4B5P7+ytIeBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

On 6/26/25 05:01, Nikunj A. Dadhania wrote:
> 
> 
> On 6/26/2025 1:56 PM, Ingo Molnar wrote:
>>
>> * Nikunj A Dadhania <nikunj@amd.com> wrote:
>>
>>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>>> index fbb616fcbfb8..869355367210 100644
>>> --- a/arch/x86/include/asm/sev.h
>>> +++ b/arch/x86/include/asm/sev.h
>>> @@ -223,6 +223,19 @@ struct snp_tsc_info_resp {
>>>  	u8 rsvd2[100];
>>>  } __packed;
>>>  
>>> +
>>> +/*
>>> + * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
>>> + * TSC_FACTOR as documented in the SNP Firmware ABI specification:
>>> + *
>>> + * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
>>> + *
>>> + * which is equivalent to:
>>> + *
>>> + * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
>>> + */
>>> +#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
>>
>> Nit: there's really no need to use parentheses in this expression,
>> 'x * y / z' is equivalent and fine.
> 
> It will give wrong scale if I call with freq as "tsc + 1000000" 
> without the parentheses?

I think Ingo is saying this can be ((freq) - (freq) * (factor) / 100000)

in other words, getting rid of the parentheses around the multiplication.

Thanks,
Tom

> 
> SNP_SCALE_TSC_FREQ(tsc + 1000000, factor)
> 
>>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>>> index 8375ca7fbd8a..36f419ff25d4 100644
>>> --- a/arch/x86/coco/sev/core.c
>>> +++ b/arch/x86/coco/sev/core.c
>>> @@ -2156,20 +2156,32 @@ void __init snp_secure_tsc_prepare(void)
>>>  
>>>  static unsigned long securetsc_get_tsc_khz(void)
>>>  {
>>> -	return snp_tsc_freq_khz;
>>> +	return (unsigned long)snp_tsc_freq_khz;
>>
>> This forced type cast is a signature of poor type choices. Please 
>> harmonize the types of snp_tsc_freq_khz and securetsc_get_tsc_khz() to 
>> avoid the type cast altogether. 
> 
> Sure, I can attempt that and send an updated patch.
> 
>> Does this code even get built and run on 32-bit kernels?
> 
> This code should not build for 32-bit kernels.
> 
> Thanks
> Nikunj

