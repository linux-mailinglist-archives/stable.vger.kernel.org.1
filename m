Return-Path: <stable+bounces-146059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05726AC08AD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3207A6FF3
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70224E4C6;
	Thu, 22 May 2025 09:29:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E470814
	for <stable@vger.kernel.org>; Thu, 22 May 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906188; cv=fail; b=HsOWoOLPfQ/7bmkaWxMj1ggg4yikl4PdSsEwMZtTqwL0nSblgR+Is5IpDbHCC3IAN+IuhgEkTacVDotMG446MDk/431Ldm0KdkiGu7KUGE725JmHVRb1gU1NoKemEg3GyLNIEzclLqz/bUVRpihqi35qjjSgJJt7C19DVkaN4XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906188; c=relaxed/simple;
	bh=YSyYyll53asBYf80l0uhl+q/jMqQc40RvX8kA7r0A+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJVHy1Vc08ZQoLXhivHrVD2Tu56m0S/kPVgOa/ind2DlPHWK+Zvj5JZvCmVMb4gHlLnJdCHwx9XsUKphvpR//HgrbJ6Wi8lRvYUGbpqMXE3MH2SdS6/AVVq3oIyQFxLpom3voLIaT7/lStrkAGLteQ9ylMev8xu3DtXyu02jPuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7noqZ000706;
	Thu, 22 May 2025 02:29:40 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfsabt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 02:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDUKoLF+Lta8Y0LmVSLN+AdTN0kUJMbIgh33dOmIvYVBguALqx5VhbTdZ+xqDkwsKIfsWgPzSylEUldnJRZP37qu7LHkeERIXio8AtAzMxwpXNPnbH/eZiEldOQLYrndEBqkus9SSyR75MZ5a/r2eKMY7Zk1UHli+G94S/DpKf3/KrXYsiEkcGiN/N9LmwrrM2ZTo0Zgc5V0sWzO/1R3zi/ieaNDoZh6rlmiDbePxceoqvNr0nWzPjm+yN4Mwq2Xr6XzkTKFtGtUETbHNWkjPL9Meo+w8JNVfSbmvDzXv0LMFHWZ/igdQNy5GBMkXSxaF2DciIPPRpIHdi4zS8jR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcJyotCRYm8xF1MC3RUVMpH24MWo2na5IMkkSBHm8Hg=;
 b=KliDy1WaUQLvbeizjJ57B5qQ35RNykFDlnJctS82HqhEGz/9szJzwANl5omloic7TRUuoixnS4b7Qe+Es2RtI9YaBOpuULv2QPBPjux7z0tAdef9VNAhyyN2y/85K/oKVDZSIFjqh4mlFzGvU6Jc0mmX1Swsgsn3CCpWoSIhdoK+Pu7Q6KGqFjowRJUF+tazTkLbf2KTORcpOOAjzG+ipUwwiv2Sn1HtdTVkG3pGwaI6Ui3VmMEjzjnln2wrRr2nQBXouIV3A9sNM7U5xJrPPPk+31eHASDQ8q3o7M6E/etk+xa8urSOMMgAcsuZN5JA4Gs9K/TLGi7Fn+X/tEpmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 09:29:35 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%3]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 09:29:35 +0000
Message-ID: <39787154-1013-40c2-9627-da8b8bbf8de2@windriver.com>
Date: Thu, 22 May 2025 17:26:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Feng Liu <Feng.Liu3@windriver.com>, adobriyan@gmail.com, kees@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
 <2025052021-freebee-clever-8fef@gregkh>
 <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
 <2025052230-okay-announcer-3746@gregkh>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <2025052230-okay-announcer-3746@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:404:f6::13) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|LV8PR11MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5042f335-69bb-472a-1201-08dd99132a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aklCUWY1dGwvbXNEcnBiZTB2bWZWVjdRdGx1cksyKzV0TWxyR0NOVmpDRWdn?=
 =?utf-8?B?VnljTHFGbUl4VW1DU2VodjI4QXFhbG1tTHZVckpCRXdyamMremFoNjBDdUNQ?=
 =?utf-8?B?YnNNSGloc2N5Q0dic1RmY1hWVTI3VDFhSjBuTEd0K01HR3dTb2x3NGJ0dFVy?=
 =?utf-8?B?NTZjOUxaWExNZGJqMnRrVThScHYwYWo1NG1NbkQvOHFiWm5lOVpCb0hncjM1?=
 =?utf-8?B?WUtaMXAxUmpYNVBPUmp0VFZqbFhCaUNHOXRRS0RleWtVa0JiTVRoY29STGt4?=
 =?utf-8?B?WVQza3owUmhMZmhQT1ZYU2tBbWZoamZCMTFmM2E5QUs5Sy9XaFVmcmFGRHpu?=
 =?utf-8?B?aVllQmdoK1dLczNDZW5MY1NEazBYWDNkaDN4by8vSUc3RDlyeFVUU1pqLzNq?=
 =?utf-8?B?Z0tBVGpmaWE0Zm9IYVc3eGhkWVhLRXhUV2FiclQydllUUEc5UkdyUHdkOGlt?=
 =?utf-8?B?NFh6S1JoMHp1TUhNOStjS21rRU5HdkJNdERUNkVWOVJXdWJCMWR2R1h1WC9x?=
 =?utf-8?B?dW9nSUNveWU4NHJRd1V6ZHZES3RxVjUxbmZHUE1pWXV4QVlUNjY3M0laNFl4?=
 =?utf-8?B?czJ5WktrQjZ4eWlxU2l5MGNHWEdPTGNlVWVEVmNOQk5EWDZrc0JrUC9nZ0Rq?=
 =?utf-8?B?YWxadThnODB2WUUza1d0NXRjQ28wZEdFTGx2cW84NStBcU16VVVxd3ZKWkQ2?=
 =?utf-8?B?Uk4yMjU3MzlwRnRZVXYzQmV2WmFYZ3RZYkI5MkF3eFhqVG1HOFQxY2pWYlZQ?=
 =?utf-8?B?MG05UDNPUUhRNzc3aVJlU09BeHhjTDJUQTNDa3poTHMzY2M3YzB1QmI1dnRG?=
 =?utf-8?B?TmNXNXBHb0ZaWGdWSjRnNEJQNnlXd1JBbVlCV2dnQjk0dzA4MjZKQWF5YlF0?=
 =?utf-8?B?Y1haOXBCYmRmdzZGNktkczVxR0FQNW5KR3o1QkU4a2hlUDF3aXFCWWs1NGFa?=
 =?utf-8?B?VmJESEowb2Q1UU5qcjVKL0ZJRDl2bk00SGwvRmZ0VmdReWxRYkppbmM4Nk9r?=
 =?utf-8?B?STFHYU9GMWJhcFE0NzdzNkd5eUFaZkpRTkM3dlF2YzZpd2ZSYmY2V1c5MWxx?=
 =?utf-8?B?R20xdGFKUE1DZ3IxdlpieTJDV3V3anRtaXo2cHh2dStIamVUSWcxR29uQS9N?=
 =?utf-8?B?M2tETlorTkY5Nkl1OFhtL1AzZEV6b2w2S0U4TGh2ZlBLc1BUdXRQUlFyMGNa?=
 =?utf-8?B?RTVNTUZxdWlyZVluN2pySkU0UzN2NkxlUjg5R0FRVnZKano0Rml2QjJJR2NU?=
 =?utf-8?B?anBkYzdFNE90K3pZZER3bzE5cnM0ZVQ3WGdjRnJDVC9zNVBWVmttLzZVUFlm?=
 =?utf-8?B?TlZCaVB1Q2NuWVpFbGMxTWNvM29nUzE1RmRiMFRObmVEQWRFejFwVXRsaTVQ?=
 =?utf-8?B?QkFKODJORy9tK3lKWkc0UUg4K2dVS2FGa2s1bVd3NTN2WnZQUGxJOUMrM1RQ?=
 =?utf-8?B?QnNGMkVLYmU1WkwzN0tHUEdTREJrUmM5WDdnK3JqNnlvVThVRHk0T2ZNMHor?=
 =?utf-8?B?U1FsNDc4RjVhL1p0Q3BxWEFHWUNLUmZDYkF5UW5obUlrVCszb0RNRmhYeGJM?=
 =?utf-8?B?SjZZeHp1eXVWK1FvOWtYUHJsN29uazRYUk5KbVRHVGZBakg3Q1pHUmtHbVhC?=
 =?utf-8?B?ODZCN1BJd2pBWWNpWm55WUdSTnEvdW9qM21McGdEL0k5UXdraTJld1VoSTVL?=
 =?utf-8?B?ODVSMS9uOHByZkZTUWQwalZOUkpaN1V3eU01cUZMa0xlRk5xbGJZdXprMlB1?=
 =?utf-8?B?bHFsTHNMZFljVWJ4TTFrTlJvMmRwbENKYk0yY2src2o5dlhGMDg0WlVieFAy?=
 =?utf-8?B?bHJwSENMMHdpdG1BeWhZV2dOdmNLbUNQRzRleVFzeC9vOTRBTjB1ZlFsU08v?=
 =?utf-8?Q?+jeC3M+7+AH+D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFhYTGZKRis5ZVlWWmorTHNaYU5henVGanhDUDFyR2lnbHc2dHhNZGFjSDQw?=
 =?utf-8?B?VHVzN0JVeUdpVUQySFRJR2QrcXJ2RkNyWGtoTlM1L1RPT1FJTWNqUGdsUll0?=
 =?utf-8?B?NWFMbWRIcXo5U2dWWUlBbVBRUmNRRW1laDZCWTNTZUd5SG55SDA0azhHMURU?=
 =?utf-8?B?WmQ0YzNLVi8rTWpQZWlMSnNSb0RZU3FETG91SUZ4bVhoSXlzdHZOdGdsR2ZQ?=
 =?utf-8?B?dlp6anpDZG03Rm56djV3ckJoTXBxTWRoRGZ6Mzl1ZXBMNXduWFhKOEVTWFFB?=
 =?utf-8?B?dTlKYlVFbjFhVXFzVE1OVUdZazFHR3lwTE5nd1ZNL0V3eEVrbEV5VDlqYnIv?=
 =?utf-8?B?bVh3b2JmNVVjMGhOWjYxN3BrbFI0dStJajZBNEFIRDk1cDd3eU84Nm1QeVNV?=
 =?utf-8?B?KzN4SDJ2b1ZXN0VyWTBNTkd3Z3MySk5XWllNRS81YkpFbEFwU3VPeUJ3Uzkv?=
 =?utf-8?B?Q3cyRzR1MUtIV29pQUc5b3dpRDkrSVliMlNSczhBeE5vTHFMUlEzdnR2Vm0w?=
 =?utf-8?B?eS9xU010MDY0SUt6VmJ1eEMrSDJIVFdWeXZsUlJoRFN6SEZnUVVyTFNXekVQ?=
 =?utf-8?B?U2xqaEtvU0h2VUtvYzhROUNuY1ExbzZyUytZVWI1WmN2a2NjL2tQRytlR2Rj?=
 =?utf-8?B?WG9jVjlSaUk2T0dpU1FmRjNQQXkxakV1ajVuaVdvMzZPVGpBL3JCNG9zZ3F0?=
 =?utf-8?B?SEZqd0ZNQllMdWdRMGNiNWFvSVRGUHU4eThoZ0hmWUEvMVI3bEVNRWJiWnRw?=
 =?utf-8?B?cEJEK2JzUXVxNEtsUG9UbDVGemMra1R4M3Q5cHN2ZEY0c0ZZVDFFS2tEQU1Z?=
 =?utf-8?B?VlY3eStVd3M3VitIUytpNHJMZlNXNzJKWk9rU2tqZ0J6MjB0Y0ZSL3lYUEVU?=
 =?utf-8?B?MG1DR083ZFZxSlNQaVZkVFhLSFkvelVUd1lPc1pOTGhoekJiQXVQMkVOdzlI?=
 =?utf-8?B?R2RmQlBiRi94VXR5M0pSbk5kOGpWM3hYWnVERWJndTZWYkVuR0xhOGxJVGdw?=
 =?utf-8?B?cWpYNzFJSy92VlQyWGRaN3h0N3BTeXJKQ2hCUGkwczQxK0FCOUhYaU5oN01V?=
 =?utf-8?B?bnVxUDBXcUhxcWY2VGZRTDZaaW5FMW1MRGJtY2NwZmNrK1N0bHk0WlBDYmQz?=
 =?utf-8?B?L3lYNVJ0OExYbFEyL25tSVlxM2Z2VE8xQU9mWTF5R3pQU08wTTU4MUtZNkkv?=
 =?utf-8?B?V2NCVkowc0t6bklHMDZTM2FheTJZVWgrZXN4UWFOTzlJQVVIY3dnQ3Y2dmtO?=
 =?utf-8?B?ZDJjYzBIYjNGSUJ2NC9MZGlIOER5ZVdqNDVYUkRDWHdtbGdxMThJcGRpVDUr?=
 =?utf-8?B?WjRsZUhrblNrWmU5T2tXWXlBamdHUWdLSHFBeWQxRUh3Y3B3QnFXK2kzS1ov?=
 =?utf-8?B?YmFWTGlqZ2lDQnh5OGxNNSs2Y1B5Zk9NeHpqRzNlY3A4d25SMExGNGh3Q2NB?=
 =?utf-8?B?MFVCbHdsWllaakt5UG5McHY4TWZXTFc3S1N5WVRXWll3OVYzVmFYbEYra0dS?=
 =?utf-8?B?dFYzYnF5RFJLT2pEa3dzVDBoWmozVVpOUEZpU3VUQSt2RTljcGN6NTI2MDNJ?=
 =?utf-8?B?bUZsaDU0T3gwWHY2MENlYzFwTjVPRjFESzJWaWV2OG5oZ3M5eWFKRU8vd0Q0?=
 =?utf-8?B?MTk3YytXaS9jQStNdEZmbTc1RUphRWVnb25aQWxRb1psVFd5SXllQnBSdVpy?=
 =?utf-8?B?em1LV3YzdFhja3IwUm5adnI3TEMwdzkxOTY2b0h0OTVodnRDWm5RT3JpRHho?=
 =?utf-8?B?Q3Q3UDNxMlRHdm9ERklFNkVyUC9IT1lPZjAvUkpuTi9aZklQV3ZkUGJqRndR?=
 =?utf-8?B?Z25mK0VKVHlmdUpoYUFtMURCTWl5akhpRzYvZGNiajFLM3VUVEdjRnNFQ0U0?=
 =?utf-8?B?Zkw2cmttYis2ejFpVEozbXpzcXlkSWl5M01EWXJMTUNPNndEKzF1anYzY0JT?=
 =?utf-8?B?WW9qNllBSUhKd1VaMTdaR0Vod3NnZnVMMEpuODljZHl4VnVacVF4NVZDamVH?=
 =?utf-8?B?bFNWK2ZWbEdXT0ljOTRqeVBWdnlVcEF6QjIvczJaTjVoZlp0WmhBTndLYWdU?=
 =?utf-8?B?ZG1Qb0NiRGVac2VYYWJnd0JjeTNJMnR0UjFQR3Q0L0FncGRjeUl3SmR2NVRp?=
 =?utf-8?Q?0PzGAUmVj/AcFBbGxTFSpjwr+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042f335-69bb-472a-1201-08dd99132a85
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:29:35.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bHXeemUN/hv1LeTF+oykLKwKDZuJkvkdfpz+/nMOA8DbswxM5FyOTKKDl3WTUtgdEVZRB+MR7qBSum+c49fZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
X-Proofpoint-GUID: ELvOMHk-7QqNu6ohFr_ORXlXQ9iUKIfP
X-Proofpoint-ORIG-GUID: ELvOMHk-7QqNu6ohFr_ORXlXQ9iUKIfP
X-Authority-Analysis: v=2.4 cv=KJNaDEFo c=1 sm=1 tr=0 ts=682eee84 cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=NuhyodQyEoLNqNMYmQwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5NCBTYWx0ZWRfX1w1jpRFnbd37 P3O7OV4y+Pw2Xh51RnkJAXow3FuNxCFMfRW1x9YTfFY50l/klLWv6ZoKVnanl3hXI8i1Yjl2nlA TlrGSrCprB/nCyPMBFl3Uq8Ef4bP7WeLRonUInho4A2U41gpMM8yBpU/Znx9u7M17vxCpz2KOvd
 0eeTTl+FT/ljpLGJbBWK9I4reUheHRp0o2BqEPcfPcq/ja1kz0bspLoRchBTht3/wUqNejIDc2J u15EyiGYw8fg0LJmkUQx3N5N7RsNobNe9toC/l8RbW4sb0yW1iYk2I1VJAIQYCY46PilctBjAiv M8IkseeAwa6XCOf2cJ6SSxUtmRR5dfsWx3Ntzpam1u2VjWkBKff7w1Ayh7sc07XR5JTilFjeY3T
 jFtHPRLlxmZgWI6uSz4MzV6LWyXgyDy4djl9BpkAcakH8lQnfZAv54NmXh8Ssq7GoRpUSP+J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505220094



On 2025/5/22 16:36, Greg KH wrote:
> On Thu, May 22, 2025 at 03:40:16PM +0800, He Zhe wrote:
>>
>> On 2025/5/20 19:25, Greg KH wrote:
>>> On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
>>>> From: Alexey Dobriyan <adobriyan@gmail.com>
>>>>
>>>> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
>>>>
>>>> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
>>>> at any moment, so 2 loads could see 2 different values in theory with
>>>> unpredictable consequences.
>>>>
>>>> Issue exactly one load for consistent value across one exec.
>>>>
>>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>>> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
>>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>>> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
>>>> Signed-off-by: He Zhe <Zhe.He@windriver.com>
>>>> ---
>>>> Verified the build test.
>>> No you did not!  This breaks the build.
>>>
>>> This is really really annoying as it breaks the workflow on our side
>>> when you submit code that does not work at all.
>>>
>>> Please go and retest all of the outstanding commits that you all have
>>> submitted and fix them up and resend them.  I'm dropping all of the rest
>>> of them from my pending queue as this shows a total lack of testing
>>> happening which implies that I can't trust any of these at all.
>>>
>>> And I want you all to prove that you have actually tested the code, not
>>> just this bland "Verified the build test" which is a _very_ low bar,
>>> that is not even happening here at all :(
>> Sorry for any inconvenience.
>>
>> We did do some build test on Ubuntu22.04 with the default GCC 11.4.0 and
>> defconfig on an x86_64 machine against the latest linux-stable before sending
>> the patch out. And we just redid the build test and caught below warning that
>> we missed before:
> That is a very old version of gcc, and why are you using ubuntu when
> this all should be tested on your version of Linux as that's what you
> are backporting these patches for, right?  Shouldn't you be doing this
> work for the portions of the kernel that you are actually using so that
> you can properly test this stuff?

Yes, we tested on our own version too, but also have to test build with the tree we're submitting
the patch to. So we use ubuntu22.04 for the building machine, not the one we want to replace the
kernel with.

>
>> ../fs/binfmt_elf.c: In function ‘load_elf_binary’:
>> ../fs/binfmt_elf.c:1011:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>  1011 |         const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
>>       |   
> Do you think adding a new warning is ok?

Of course not, we just missed this one.

>
>> Just to be clear, is this the issue that breaks the build from your side?
> I don't remember, given that it was many hundreds of patches ago.  But
> probably.  Try it yourself and see!
>
>> We just used the default config and didn't manually enable -WERROR which is
>> disabled by default for 5.10 and 5.15. After searching around we feel that
>> we should have enabled it as suggested by
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9080ba4a6ec56447f263082825a4fddb873316b
>> even for 5.10 and 5.15, so that such case wouldn't go unnoticed.
> Default configs for x86 are very limited, please do better testing.

OK, will do.

Regards,
Zhe

>
> greg k-h


