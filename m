Return-Path: <stable+bounces-94513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ACD9D4B36
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D08284504
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D91CFED1;
	Thu, 21 Nov 2024 11:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB11D0DEB
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187013; cv=fail; b=jKyp3PUXXbO5qrSeznk7X+bTzBtsiOa6/cBb9Zh2dbUNUcFVkeymdKfvT9obM4jHvcCg/CDUip2k5RFfEDhS4lNZlIo+o0wkwNTgh+YAKufsUUbOqhCAJuvOMDoJ0zVuF5AI/vtAx9/ptjKntrBdAbc6oZW/ebPEfkW6DBA6DMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187013; c=relaxed/simple;
	bh=EnISlzx8xDEQAFQ3vhqTurguQhclHwN5s4LOfaEmGJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxyXXp6+ynzfZQiMpZMylIrsSo4gK/FlasuXtemCSqV7IFMJP1YskuqyFD+Cz9xL/nlRk23NZ+3bHf34JIe4RU99JogLeMEUEmDAsmr3rUZ/CO8pKIGZuwRieHnABDEYGo9TLjiZgVfpxIEzt138ekxI/ZaaVnGmp4WW1lMx7vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALAe3De000603;
	Thu, 21 Nov 2024 11:03:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0nfvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:03:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeP3arZBC4Xx+0d+MsEl+xIzDg8fewxawQiUCWm55Q9aKAkZdyKgKvyafhPwUTFTBaysOfqIKZF340taCx3vpmc/owV+ZxzOixt19S3tuaRmGXIxi4rDhtFoHc9sqFkhXLevCV6PRvFhUlkHl+diSgT35Z5ZyVdwKh/mYCU1OoAfy3izwsohqplCnR/6/yYHurTX8An3q70pwD+B+i8gCOqR1yyoBy4cOfiVCEz2h5TlENz9iY3yxZf92rfj5jF4vzBjUQHDHOXxcjK5/LNQU96xXc3hT/+g47AfjpE0lQOqOFx80aVwOTUZnght7Ltq6G3HGVyBm/NvmZNQWruQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H56tMcL9u4kpI/SCB4o0s4AnJpf5g+dn1CVcqh0hLI=;
 b=xu7OiJEvUE35reCvXKAYoY/D9Jc7MOvsyp/Zz3tJJ5GMvvzRnvxsOC+nmQjmuRlJ/if/9LLv3vRPTWW1wb8l4CP0qm5CoqdPPgLoXqxKt0B2L43IbgXtDV2zT1e2592ALcQt/X7DItT+2t1ok0u9dqbdI1/BlfDcWlOsHg9ZJzSWQQ+PkzsaCt4N4+a3PqpTx9eViuD9VG8Xac9Anw9uOj9iaju3bKo44Ot/qr3jKBDuRlEzrIxER37eC9pD5n/b5z+LtjCk4YcK+LrZePCQPiuVKJNV/NzGmYqjWaHHwmg6eqkRMj5ZKpdtNkGrALkKfffjdEbEg0APO1L/GmsXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 11:03:16 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 11:03:16 +0000
Message-ID: <414cc2d9-f7a5-44d5-9155-9e988b9ec796@windriver.com>
Date: Thu, 21 Nov 2024 19:04:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] closures: Change BUG_ON() to WARN_ON()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
References: <20241121064607.3768607-1-bin.lan.cn@windriver.com>
 <a6vuwspqjsba6hpparaas3knatqv7ictvoqc7tpgdujwzpcwxv@qudc5qgc52tq>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <a6vuwspqjsba6hpparaas3knatqv7ictvoqc7tpgdujwzpcwxv@qudc5qgc52tq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: e6562bbc-9bdd-4377-ab3d-08dd0a1c1983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2kzTFRVTXBMNmFaekpjNno3RjFJakdkU1hWalFTeTN5NzUwODVJcDMyemhJ?=
 =?utf-8?B?TzBybzdsa2U0bXpPdXJVZDF5TExnZnpHeHlzWGpPMjljN2VNb2Fhd1puS1dT?=
 =?utf-8?B?ckZ6aFFUNFloRkhkenRCV3EySURTQm9CNFRYTmUwaWMrdUNSV1ptUEZjRkFB?=
 =?utf-8?B?N2h1RTVCZkE5bmVzYmZUQnBqcHJiSkRPYkUvRm4xR3VzYVpIYXVOeVJxSC9U?=
 =?utf-8?B?NnNnNVFYaHd4TXNPWGlNOWhWWFNtOFV2MWdZODQ2NU15cGE1SEpaL2tVbHR2?=
 =?utf-8?B?aW1hTDJUUC9LTXU4NzdYUEk1MmFJY3ZuQVZpcjIvVmRtazV5Ymp1TmtjSG5J?=
 =?utf-8?B?WmhzM0xYazRkQlh6aHFQYTBQRVgwY2lpRS9LV1U1OW8rRlN1M3d6WHJsOWgv?=
 =?utf-8?B?WjBqUTF4VGtnSTBlaGpwbkIvdXJjcklleEh4Q1JTRFE5cHU2QVBGdVNXQUxX?=
 =?utf-8?B?SGFycGdqWFJzUFJOc1UxOVdreU5VeVlJYWpsdytKU3ovMjA2UUJ2OW81K2NS?=
 =?utf-8?B?SXVuUk95bGtWWFVUTkVsOCtoQVdhWHRiU1d1WSsvUXVOZDhGODhPSi9XTkNP?=
 =?utf-8?B?eFBqSE1hNjJ3Nnl4UmM5aVMvcWZFTE54SWpCRjU1Z2t3RFhlNldSd1F0U1V3?=
 =?utf-8?B?K0s4UFVPRVAxejBNRmp1K1BjYUNEUHFMakF4aEwvS3lIUkFtekVqdEtkaW0z?=
 =?utf-8?B?bkRBRW5IcS9zdHM3TjFIQ0ZHcWxKcFdodTdJSFJROUZCemJpdWxBNldndkR6?=
 =?utf-8?B?dnloeWtqejdnMGsxZ1pEOHR1ank1WHlBY0taL3JTMUM0ajd6YXMyZzQ0YVZP?=
 =?utf-8?B?Y3VhUDFrMnU3VVlldTVPL0YzZ1hMZVgrVEZVZENhZUVaL2RpTTlWR1lIODdW?=
 =?utf-8?B?S2ZtNGZHY2ZXdDM3cStHMXl5Q0Exc01vejNpU3lYVExiQ1E4aWhNbDFiUkRv?=
 =?utf-8?B?NE1pSTJKbXV6Y1FNelVlZ2FSTGpYeHd4WGdvbjZuVEZLWkMwamJqZW1NdnVG?=
 =?utf-8?B?MEdxWU91WGF1bWg3TzdNVUx6N0xkbFlPOWhDRzRPc2NISWFlbytSbTI0bU0y?=
 =?utf-8?B?emNOMTg1R2FtREdPdEJJeXpPS1JqNlRhYmlnck8vcTJacThmaDQxVXluSFpI?=
 =?utf-8?B?SCszWUFxOUlPbDZ1NFN2SURxQVIrVVd5eFpBUFcwRGd3TmJFUDliTGpubWhJ?=
 =?utf-8?B?MkVMT2RPMzRKNkFvWWxYVmFMRVpQc2ZJWkJra1lmRjlTTzBjaHIyUkw1N3E1?=
 =?utf-8?B?bGhEaFlDNFpaZVVxcXRweDBNK3AyQmtVVGRuWkpMOWpwamdUQzM5bUtHN0pI?=
 =?utf-8?B?RjB0QkFBOUNYODhvL3dnWng1NkFpTVR1OHlNa24yRDNCNGI2aEMyMllxSG5r?=
 =?utf-8?B?NEFiV3gwYXY3akR1cWloZ2xNNGZZYlpYWVNZQlpJYjFlQjl0YTh2bG9yNHZB?=
 =?utf-8?B?UUtjc09PVnVyblJmMkVDOGV3YWtHanM4UWQvN3JaWklreDFTQTgrZ3Fpa0E3?=
 =?utf-8?B?UTQ0dGkvOEFTNmRQLzNDV1kvUlZNMHlUUjJMSldjNzRHWkUxU1EvalIxbnJ1?=
 =?utf-8?B?cXJLSWRDTmk5ZE5GVlpjYTJoaFA4dVgxeEtpdzR6dTEraFpYL05QMVlTUWFa?=
 =?utf-8?B?TnFIbGg5dVpFUXZNV1NUUE9NeG5ZMG5YT09SN20xckFiWHMrK3BuTnlURmRW?=
 =?utf-8?B?bmM0UTYxVTVqRm1YR1Z1Skl3NEVwaTREaENCaUQ2LzlFd2ZyNlJ3T0ZDL1R6?=
 =?utf-8?Q?Z1FFWI8nAMPt19Ih5u3ZmxRuZ8Pr31GdJc6C40c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFzVm0yTkpTUk5BdnRDNno5OWJZMWJySmNkVjM1eVQ5STJjQ2ZRK2g4LzYy?=
 =?utf-8?B?cEFiOTFmRDJtVmZnNU9sSmRDZEx3WUdPam1udi9UZlIyYnpqWWE4K1JUZGEv?=
 =?utf-8?B?TWQ5Q0t2ZTlTaXRQbWJkUERIQkxRUHh4VDVBUmsxczlmSzhqZzdpU1daUS9P?=
 =?utf-8?B?ZHFmdk9BdU0xaWxYNXBUQlJnaTdLcnBxRHZDUmNiMUp6ZnNwQU5tdmN4RnV5?=
 =?utf-8?B?ZnVkSzlCRldlZ3lBM1RCMGFidzhUc1RRUTd3TDYzWEIydmVtM1o5QW94eWxV?=
 =?utf-8?B?WENpTUhKS21lZGFweDlKQk9vVVEvM3JvQVVWVjRjcG5KVlpXVWRXbTVrVi8v?=
 =?utf-8?B?V1puQUV0N1B5K0lBdmNCNSsyZE1zU1NEZGZSQk1sNmJOVEdvN0J5bWxwQmJJ?=
 =?utf-8?B?NWd4LzN5UW5uYlQ1WlM5LzQ3MUhCcE1pTzM0K2tlTmpZMEdtdnNyamVOMHYr?=
 =?utf-8?B?Wm9JT0U1aDJWU3BYTmhDSk8ySGtidDQ4Z3JzdFVGR29xNE14dE9rVzVWcGsx?=
 =?utf-8?B?cjZScEtGWWRseXp6Z2kwUkhQN0FucWY3OHhFNkhaUXdJZ2Q0MGUxd0pJb1ZJ?=
 =?utf-8?B?dHhlVFE4SllIWGYzbkt6R09tQW9TM2lXOGg1aHpmMzlMazJoRlpzOTIvUGw0?=
 =?utf-8?B?SlVzdHh6N0RBWXRHUXJpbitOY0NmL1laaERhUngyRVo1OWRwRXdjSmhRRURZ?=
 =?utf-8?B?bytFaVh2czkxYSsrVE54TnRORk5IaHBLSVpic3l4eEY1MkwxYXUvb3ZTdnZ5?=
 =?utf-8?B?elBLdVdKN3J6K0F3OHRHbGJkYi9INExoaTBZQUJhVTM3dm81dkRLQjd0UXR4?=
 =?utf-8?B?VEVScG5ianFPNWt3TmxsTW44cjUzazdyU2ExKzRjOFBjL1R5aUp1akI3ejMx?=
 =?utf-8?B?YlI4VC9WQVJSSzRTcndHMlBTcTRpL1Aya3pyTUh2aTZ2cXptRlRMdWw2OFNM?=
 =?utf-8?B?TzVZNVU3WHAyeGxyRmZmdnBLWVdMZ0hoWWRlSnZZMmJxWUlSM2ZKUTJoemho?=
 =?utf-8?B?cjZWOXhzWW13Z1FjVC9TZU1Td0JoVEhHTmQvQ01CNGI0QzdkdEZjT3B3aE5B?=
 =?utf-8?B?VWZoSHVRMzhoQ0UzdVJRUS9lcTN1dHE3aGl3TjVPc01OWmgrZmoyNktQMnBY?=
 =?utf-8?B?blNkekhjZXpYNDFPcGlUNVRxRnJaN3Uvb1I4TE5iU1U3L25jTmJiMXBRUVpU?=
 =?utf-8?B?bWlHaGxQWmQ0RnI3a1JIQUpoT0hQNy9WeFR5T0JuVGh1RzNQQlRBMjhlbWtU?=
 =?utf-8?B?OUxDUy9kWnlaZituRkgrbVc1bUE4d2NhNUI5TDlSVEQwZjNzc2pzR0FKbVR5?=
 =?utf-8?B?Ty9yWkkzRjRnSU14ejdoM1dyWG5FVXZDVnZ5cXRCTDZnMTZIZlpvS3Q2T1BQ?=
 =?utf-8?B?bU5MNUROR1hXTzQ2c2VvaWpsWjNUaVlncnpZbm01ZFpjaEVRTWlES0FmQTRZ?=
 =?utf-8?B?MXJCdXI0bEZZYTFzRzhVWndmYjZrSzc2SmRrcEFweE51MjZnWG8xd1Fqc0J2?=
 =?utf-8?B?KzUrTm1pRkcwc1VzQmsvalFyN0dRVkhmMXhqU0xDSmI0dnJZdmNOVG1KaXJK?=
 =?utf-8?B?OXlQTUJSejZuYkdDSzc3aGVHYVA1RFUrODRqL0x1VTl0bmQ1WHhIMzRzOFpL?=
 =?utf-8?B?OEF0UXp6ZnlteUJMa0lLMVh2Q0ZCaGFQZDhMdDZsR0dZeXNrNWlRaFZIS01Y?=
 =?utf-8?B?aEtZeHJKMGhYamdsVUY2VE1tOE5LMTdyS2xuV1RQVFBTeFZnWHo3M0tRZkNI?=
 =?utf-8?B?WnpMWFc1RzloT3VseFJJV2FQQVJsSHZsTGhuYktMYy9ERWh6SmlHblE0d2h4?=
 =?utf-8?B?dGtyWHV3Z1FMcmhNVm0zcnlNcE81RTdLY3ZmZ1Q4ZkUxVHpQSVpsTTQ0UGFC?=
 =?utf-8?B?ZTYxWEtCWXhLMHl4TXJlN2NMQnNJNk1reFZkeTFVR0xiVlpPNXpOVkxYUjgz?=
 =?utf-8?B?RnRqUVozcUtrRU1QdGFOTHhocjMrL1BnMG56N20xTjJjSE1iYWVCNndXK0ZR?=
 =?utf-8?B?NWNJRm5kQ1drb0JzTitrUGFVcUxyQlIwaUxoTzhaWUNXeVozZldza3FmYjQ4?=
 =?utf-8?B?NmxmVWFCOExWVXN2aDhSVWZVR1NPdDRJUTFIL25pMFJWVkRDaWU3SGZkNlcz?=
 =?utf-8?B?bll3Z2c5ZzdGaWEzMEpJMTRYRWdKV29nYmZOU1d5N29CYXRxOVZmVXBTTnlV?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6562bbc-9bdd-4377-ab3d-08dd0a1c1983
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 11:03:16.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2CBuHaOKbti0vFn3g4501DE+SKILOXG56Ih3TxmBrwZ2Y41ve9RI7JZPXgx/ZAj0P3JFwyiOj/Ew9bqvBZhG0yf2+hTIdPNjjduOe2TYhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-Proofpoint-ORIG-GUID: SUXut0xVi4nIQ14Ia4WLDRk3sA8S8yaI
X-Proofpoint-GUID: SUXut0xVi4nIQ14Ia4WLDRk3sA8S8yaI
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673f137a cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=WUaimuB7jM4-1_DHG1QA:9 a=QEXdDO2ut3YA:10 a=DeR62mY57puq7Rx3Av7Z:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210086


On 11/21/2024 3:13 PM, Kent Overstreet wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Nov 21, 2024 at 02:46:07PM +0800, Bin Lan wrote:
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> [ Upstream commit 339b84ab6b1d66900c27bd999271cb2ae40ce812 ]
>>
>> If a BUG_ON() can be hit in the wild, it shouldn't be a BUG_ON()
>>
>> For reference, this has popped up once in the CI, and we'll need more
>> info to debug it:
>>
>> 03240 ------------[ cut here ]------------
>> 03240 kernel BUG at lib/closure.c:21!
>> 03240 kernel BUG at lib/closure.c:21!
>> 03240 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>> 03240 Modules linked in:
>> 03240 CPU: 15 PID: 40534 Comm: kworker/u80:1 Not tainted 6.10.0-rc4-ktest-ga56da69799bd #25570
>> 03240 Hardware name: linux,dummy-virt (DT)
>> 03240 Workqueue: btree_update btree_interior_update_work
>> 03240 pstate: 00001005 (nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
>> 03240 pc : closure_put+0x224/0x2a0
>> 03240 lr : closure_put+0x24/0x2a0
>> 03240 sp : ffff0000d12071c0
>> 03240 x29: ffff0000d12071c0 x28: dfff800000000000 x27: ffff0000d1207360
>> 03240 x26: 0000000000000040 x25: 0000000000000040 x24: 0000000000000040
>> 03240 x23: ffff0000c1f20180 x22: 0000000000000000 x21: ffff0000c1f20168
>> 03240 x20: 0000000040000000 x19: ffff0000c1f20140 x18: 0000000000000001
>> 03240 x17: 0000000000003aa0 x16: 0000000000003ad0 x15: 1fffe0001c326974
>> 03240 x14: 0000000000000a1e x13: 0000000000000000 x12: 1fffe000183e402d
>> 03240 x11: ffff6000183e402d x10: dfff800000000000 x9 : ffff6000183e402e
>> 03240 x8 : 0000000000000001 x7 : 00009fffe7c1bfd3 x6 : ffff0000c1f2016b
>> 03240 x5 : ffff0000c1f20168 x4 : ffff6000183e402e x3 : ffff800081391954
>> 03240 x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000a8000000
>> 03240 Call trace:
>> 03240  closure_put+0x224/0x2a0
>> 03240  bch2_check_for_deadlock+0x910/0x1028
>> 03240  bch2_six_check_for_deadlock+0x1c/0x30
>> 03240  six_lock_slowpath.isra.0+0x29c/0xed0
>> 03240  six_lock_ip_waiter+0xa8/0xf8
>> 03240  __bch2_btree_node_lock_write+0x14c/0x298
>> 03240  bch2_trans_lock_write+0x6d4/0xb10
>> 03240  __bch2_trans_commit+0x135c/0x5520
>> 03240  btree_interior_update_work+0x1248/0x1c10
>> 03240  process_scheduled_works+0x53c/0xd90
>> 03240  worker_thread+0x370/0x8c8
>> 03240  kthread+0x258/0x2e8
>> 03240  ret_from_fork+0x10/0x20
>> 03240 Code: aa1303e0 d63f0020 a94363f7 17ffff8c (d4210000)
>> 03240 ---[ end trace 0000000000000000 ]---
>> 03240 Kernel panic - not syncing: Oops - BUG: Fatal exception
>> 03240 SMP: stopping secondary CPUs
>> 03241 SMP: failed to stop secondary CPUs 13,15
>> 03241 Kernel Offset: disabled
>> 03241 CPU features: 0x00,00000003,80000008,4240500b
>> 03241 Memory Limit: none
>> 03241 ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
>> 03246 ========= FAILED TIMEOUT copygc_torture_no_checksum in 7200s
>>
>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> [ Resolve minor conflicts to fix CVE-2024-42252 ]
>> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> I don't think this is needed on 6.1, this came up in bcachefs where
> we're using closures for refcounting btree_trans objects, and there was
> a crazy bug in the debugfs code... fixed awhile ago
>
> harmless if you want it just in case, though
Since it is harmless, I think we apply this patch for v6.1.y to fix the 
CVE-2024-42252.

B.R.

Bin Lan
>> ---
>>   drivers/md/bcache/closure.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
>> index d8d9394a6beb..18f21d4e9aaa 100644
>> --- a/drivers/md/bcache/closure.c
>> +++ b/drivers/md/bcache/closure.c
>> @@ -17,10 +17,16 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
>>   {
>>        int r = flags & CLOSURE_REMAINING_MASK;
>>
>> -     BUG_ON(flags & CLOSURE_GUARD_MASK);
>> -     BUG_ON(!r && (flags & ~CLOSURE_DESTRUCTOR));
>> +     if (WARN(flags & CLOSURE_GUARD_MASK,
>> +              "closure has guard bits set: %x (%u)",
>> +              flags & CLOSURE_GUARD_MASK, (unsigned) __fls(r)))
>> +             r &= ~CLOSURE_GUARD_MASK;
>>
>>        if (!r) {
>> +             WARN(flags & ~CLOSURE_DESTRUCTOR,
>> +                  "closure ref hit 0 with incorrect flags set: %x (%u)",
>> +                  flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
>> +
>>                if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
>>                        atomic_set(&cl->remaining,
>>                                   CLOSURE_REMAINING_INITIALIZER);
>> --
>> 2.43.0
>>

