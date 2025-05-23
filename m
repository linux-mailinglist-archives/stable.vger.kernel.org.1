Return-Path: <stable+bounces-146181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92772AC1F25
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523C17B9902
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A81EB196;
	Fri, 23 May 2025 09:01:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164A1A314F;
	Fri, 23 May 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990886; cv=fail; b=GvcNwOfa9nxv1zFdkWWe/flVybAJ1pf+uowxySiZPrKvcjgGpMspI7j/6q+cqCXb/1zDXrXKEMxUZ3GJf1hV9OVRq740esRWFJ/uuN2jFXfQpdxSr5R6+/SMqUr4WB2L/nxZ5yCsywCp8i1FeyqYjjaoqZr6uAaMpP2eee+D2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990886; c=relaxed/simple;
	bh=PfmGA2VYh6+rdQMgCbp2iebGiPy2fWGeXcaRH8/23MU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIVbsnOcqo003k8ei6wmMLMjwK9vZN34btTG7BC/MwmbwUfYibQhzSINHWswNfX1shMYfimevlCOCBbsOH74z/ZNIhpv+D4+DpgboxVxwL0YoZPdv+OPwE+Kb3//Jau1sBsd6Mr5ekNRO5awXUG9JLngrpRSgNM2TMoepN5YPmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N503Qi011965;
	Fri, 23 May 2025 09:01:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfwun10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 09:01:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyNYQK88kf7GsZ1Y5DumtAZuop09apRq/3TdvbLSKxTQypP3uck4dSPCq+G71TEeKMMFWIN9mlBJMWAtlsyjw98n/UrdvC3deM1Vo//NLZI8QiN2Ly0ji3wBeoiZIkvDX5OIAEuGTMYVf0ZiPMOYLwHQhipPHz8L5wlf9VE7OaBoJbPKoBBF9fiOhtE+PVRJAIoOZ/Q/wWIOGCsAqWoQHhKrE1X3tX/DnlxmnAS4G9PoozeyeaQ8QNX7297E2n0e5Kq5lC5Sp8UIN5RjuCdtrpwTKyJrFrqv4YqYRlkMcD42uqtS7Jo8uNxPRMEIpsLIY3UTv+mOqolgeX7RQfYseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLSHwlXP/xM15/zkQ9urOrIITGxt8yqagDe4FJYO5KM=;
 b=eRxKxywCGO9skbXsw3/unHt29W+kQBqNthDKOfFu3+0RUH09L9O1haOJvtTmH4yGUveWJP/s8o42nevFOoCqZoqvfaMII+7UvsszAzIWkxjZ8zPB+IMJKMTOK84B8XUQm1RSA69XAJ8yL2SOGAzYrRRuMeSy6ZoASokeycM8cHLD3cbB2j52+vtY3ZijQ3OS8oQfYUAXMu8a51WtoAVSWbQWs+fH1DMBLXdlc1y7PCTGxz6bVQwWljEt/yRoKrHAorIpURC9k6tKJQEU9ygdD+k5WebyHFA05lweVOTKp1RSnZi36tkSyyFlAjlzTE3cvnOTxeeMV7KKwe/ZPPwnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 09:01:04 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 09:01:04 +0000
Message-ID: <ba4f9f5d-0688-4537-b721-7b2bda8ead8c@windriver.com>
Date: Fri, 23 May 2025 17:00:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfs mount failed with ipv6 addr
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <> <73509a8c-7141-49d7-b6d4-25a271fbad2c@windriver.com>
 <174798616079.608730.9700383239346135852@noble.neil.brown.name>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <174798616079.608730.9700383239346135852@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:404:56::13) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|PH8PR11MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1985c4-d18c-4945-7895-08dd99d858cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzBRV29ZK0dkOUlBNWNLN3hMTGMzUU9rdk82QkExNVBLSXRpZmZmamlqbEpR?=
 =?utf-8?B?UGliWUpBbzBJUEd0Y0dDNFBHNEUwUHp2M3puRTRwaVRSSm5tTUJHb3p6QjUy?=
 =?utf-8?B?N2FJZTBPaEllRkJVNlhqZ1pyeUtWOXdyVTdpaytSWno5aE9CM042UWNDZWFx?=
 =?utf-8?B?b1A4eWZtR1MwdEJldkJVbDMvWWg4RHh4RjJqTHkya2oxZ0Q2V0dObEVsMjF2?=
 =?utf-8?B?ekdrZW9RdExpbEo5TDlLZnExZ2gzeWdGQkMvTURxcXJwcnovbk4yTW5uZ3No?=
 =?utf-8?B?MjhMdFA2V2tvL1BUYWxLWWh6dmhhSm1pMDZFWi85cUlyeGZzaHJQUHA5UVcr?=
 =?utf-8?B?clJHaEh2bytiLzhqY01ZS1JuT1ZPbVBwZ1VyWERoQkY3aHV2ZUlMMWtzNSt6?=
 =?utf-8?B?WUl6RlRZR0hEZDZiMnRUd0prTFhQZGJndjlJbzJXdnZ4d2ZiRmVLaE1ldTZx?=
 =?utf-8?B?V2pHekNIUmRTNFBJV2E4Tm1IaUMzMTJ3RkV1U2NHdTROdTZHdjJsWHBwYmdI?=
 =?utf-8?B?Mk1YNXJQV1A5R3Avc0FJeXB6RXYxRmpPVHZxNzFhdnVOcXNIUUt6Z0FDdnJN?=
 =?utf-8?B?alU2M1RFTW5ieU9qY0VuZThoYjI5aTR0WWU3TWhDd0FJUUp5bS9HcDh1VGJK?=
 =?utf-8?B?bVVWVStSd3Y4VUNOblhtakR1SW9ReVZXUlF3ekc3amd0dDBVR3Q0SkI1WlVB?=
 =?utf-8?B?elYxem5UTEhDYmJYYXo5RlAzeG5kNXRZT2VyK1B5THEvdkVQcFFxWk12dnQ5?=
 =?utf-8?B?Z2hZcU1YYTRyVGduYWd3R1c2ZW1FS0VPbDk2WENDRFVjR0RoZVZDZE5IdFUv?=
 =?utf-8?B?UlVNbWdVcTRMRjFTR2tqblN0KzR0aFFhZG5iZmMrdjNqeXI1WHBuZ1dJeXVm?=
 =?utf-8?B?SFRsc3dQeERxc0VLa0pTT2plaXkvd2NCOTVKR1krNlJsUXJ1UDd1QXV6clNM?=
 =?utf-8?B?SmM3OS9aUC8rZ2Y4YnVBWStmVnp4ejdRWklILzJHQ3R0SjVGMTE1R0NPMDFC?=
 =?utf-8?B?T3JhUWFmQ1ZTUEhKSGVSYVlxMklUU1NJbDRRMCtvZ1p5eVNEV2ROSFdWZGpu?=
 =?utf-8?B?ZGRYM01wR1ZzMFVlb2VaaDVJc0JSVFh0c2huSWdpdU8weVRzUkJIZ21uYkRm?=
 =?utf-8?B?bjArK201VGR4NHE0V1ROektLY1BVcXVpRHBXZk5sQVdXeHZ4ME4yUUZEYkNS?=
 =?utf-8?B?YXRpMjJickNwNVhsNjBkK0hwbGtyc0RZYVBMZGZZTUdoNVp1dmRsZENTaEFB?=
 =?utf-8?B?SFF2OXpaK05IL3Y3a1pRamQ4TWVzRy9uTEMwZnZ0eDJzbkdQbjRQcTU5RlN2?=
 =?utf-8?B?a25HYkU5YjdzN0hGY0xOOTgxVFlibmdNL010OTJzNDlTVWE5K25GbVoycXhv?=
 =?utf-8?B?dVVnamdZbkJCYXp2SklxRU9TUnlVNDNQb2hMZ3hTWnZzSkltQzRuOFY0K2xy?=
 =?utf-8?B?dVc1ZU1PQ01lQnlPNG5DTHRncGlnRlFEOUlCeDNEckRtWWcxZG9zSXRyYmtG?=
 =?utf-8?B?Z3k0bmk4cnA4bnQ5V00vL2VGblR4WEdML0l3UVRDbHU3ZVYwS0JyMUtsZGFR?=
 =?utf-8?B?QzFHMUN0dnMxVEg2b3lmMmVWK1VBaWwxM0Q3S0dRSm5FME0yYUY2bWh1dXdR?=
 =?utf-8?B?WERnQm9ITjljNGZuVUVKazJhcGZOQisvYzNXS0ZvU3VDRnJjOGpDVW80dzl6?=
 =?utf-8?B?dUxOVFg2ZXJoZ3RoRkEvbjdlQ0pONmhEcm0xT3N5T0RPUUdsSTRZQzdSMUw2?=
 =?utf-8?B?VkVBaXlZd3JsaWtDWHlEMHNqZThuVXVwY0xQRldLdDlrTWVML25QWEZWYUFI?=
 =?utf-8?B?SXhhdGdmZUFseWJPTWs2UWord1RJUkZBZjFhdksraWc2NU8wZUZtOW9uakJX?=
 =?utf-8?B?QWhDc3pnZEg2Q0FLVExnVkZNZUgvQlhTRGFqR1dVc1lMMTQ1Z3BuZlZmRUxF?=
 =?utf-8?Q?l9IScX25vfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhCVmpBUGthTnk5QnFZazk0Y3JUYVZGTFl6cGwvc0FaMVVpdHZaYmEzSmlQ?=
 =?utf-8?B?S01pQVRKVmlNT1Bva3NETUl1VVRhRy9TTzg3UGNsMFpDNzJSSGZTb3ByT05G?=
 =?utf-8?B?MzQ1L1BCVGVVOUcyamgyMUtRZEY1RERQRUhIY25vc2VmQTQyWWg0bVh2a2pI?=
 =?utf-8?B?Mnp2a1Njc1k3UGVybStLZGpBTlArOTNKUjZDT01TS2xGOEhFQU8wOVg1akJM?=
 =?utf-8?B?VUxIYTVGMDdjWTVtU0w5N082S1dHYnVLQzB1bitKMlNKN1lBWm9NMzM0R1Bu?=
 =?utf-8?B?VWJwZG5KN0FTbDRCQVZZYXZ6OXBzWjlZVTZkTGJRSjBXdHh2UDlGbnNKT1Rm?=
 =?utf-8?B?SFlWN1k0NDJRejZJdlNRZ1lTRjMvdUlTR1RKMlgrTnRlVCs0VWJKSXpmbnZi?=
 =?utf-8?B?REVsNE1STUxEZmxwWmdjM0FFOWNkcS8zK00rbzFaQ0dQV1NqMDJveHhwMkcv?=
 =?utf-8?B?TWk4ZGp2dnBxbUtTbUhleXRpbWowV0hMaTBIeHNKb1d3UWgwK3hxRjRuVVVT?=
 =?utf-8?B?WW9NYys0VFZhang4cmVFOVp0eWhEZGE5dTdwUHc4d2tEKzIxT29Xa2ZhZzBu?=
 =?utf-8?B?YVBQeElEa1FmMzRvUDJJM1o4ZjBoZXZ6R0s4NTNPdDIrMDJnbVlLMXk4ck5t?=
 =?utf-8?B?QWxQTitBekIzMUJ4QmdzWHdmYnZTYTZVQ0Nsa25pNU5pRkl6M3gvK3l1cXZo?=
 =?utf-8?B?bmFxd1ZCZlBhUTAwWXNMb01MeWJhWHhpV3I2Wm5EWjE5dmpPZTNUb1JhdU9l?=
 =?utf-8?B?UGlidTZlRi8yZVYrN04rVksrMlFXK0tjSmUzZ2JvNVZ2Y0pzK3doWDZlaTZs?=
 =?utf-8?B?SkxHdzZYb0t4N0VyT1R5RTBVK2FhTm1tdkg2bDBNazFvUWdSbFk4SmxPcjFt?=
 =?utf-8?B?OTI2UlBlNzlENVlkbDFjMjc5S08rWWw1UTRMUXNXbS83UVVpTVN6cFFrR24r?=
 =?utf-8?B?U1BJVTVmVWMxZ2lVSDloejc3S2h2bjhMZEFTTlA3K1I2YVpsL0Y0dWdhdEdP?=
 =?utf-8?B?TkN2WCtZd2NXNWh3QXNJTEpFVkhjZ3o2U045WEFGTlRDV2tnZjRvMW9CRkR6?=
 =?utf-8?B?OUlmT1VPK3lHZyswWk9XdSt1TDEwM3RYazlFQU9SMmNzR0h2Y3NEVm80enZZ?=
 =?utf-8?B?Rnh3ZTJuc0tMSWNISjBuOHIvWkl3d0drSFdwSktkRHYwcFp4dWpVaGM4VkFB?=
 =?utf-8?B?WWdTZlhLc1IzR3ovMkUzZEJxVS8veG5lVE9UT1dNUUltR043eWo4WUEwTDl1?=
 =?utf-8?B?U0VGY1d6azlZZ1FlaDI5clh4UFUzOFRHUFFETS93dmFubW91b1JXR2prYVU5?=
 =?utf-8?B?SEllcGt0UXhqVko0Nk1RR1NHTmlDY1hnZ1hyUGQ5ZTBLUDcwVy9Mb0Rrc01J?=
 =?utf-8?B?aWtBZVVoN3dzWEZWMGtVbEd2dHdrRThXcHlQY2lUY2JjTmlBTnhmbDlHVmw4?=
 =?utf-8?B?WC92Zi83UTZJbldGYmxadUg5bHhjSE1CZC8zV05NLzIvVms1bTFCcm5pVjQ4?=
 =?utf-8?B?by9FUS9jbFBBNVg3bjVkMGZ1N3ZuaVQ3TnNsMUFmbFNoRXluOVlpNVN2bG9O?=
 =?utf-8?B?bzhxclU5RUVNZ0hZVk1MZGppeDhtL2krakJTYkZBbHJ6eUZPRVRPaDU1d2p3?=
 =?utf-8?B?RTNiaEUxeGJaOE8rWXFlbDdObGJnc21Ca3V2STJqaVBkeVdXRVk0N01jRlRh?=
 =?utf-8?B?L2hxcHVBNmgyNS8wamJOZHdCU1lXeXhEcXhxQjJLc01rdTdYeDlrTVl1aUMr?=
 =?utf-8?B?bTdaM3pENGlKc214b0pVNklxUE5UY3ZSVHhHQy9CK3NKdVUyeFYwYytBc3p5?=
 =?utf-8?B?bkFoTVNuUEhraFpJbnFqUXNFcHZSQTBBNUV6RkNyUDR2bG1PVGY5SnpwSE1L?=
 =?utf-8?B?anRzWWpvZ25ib25WODN4UVp4TmpFQkc2UVJIQlJMdzRxQ3AzKzlWZVJwb0FR?=
 =?utf-8?B?TjAyc0tHUGxjZ0NJRUh5ay9CZTlHSU84UXZHWHFDTTB1VEhLWVRsZDlBZUNN?=
 =?utf-8?B?OUlZcURiZldnWkI3blFmMHJadG5va1VHM3FabWZJMTNwZE16NCtoeTdyd1hL?=
 =?utf-8?B?MlpLaVVYcldvb2NaQ1d5YzJnVDR5RXpwUDcvdUFDT0FaSG1IL3hvVW9PMWhy?=
 =?utf-8?B?T3gwWHVTOTA2M1p4Um9xRUd5QTRmQlNVWlYvZ1RqNEpJODdWeXFjNkNDM1Vx?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1985c4-d18c-4945-7895-08dd99d858cc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 09:01:03.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQgAp8ZqUqKWTlPWMcr8KgwDsCRGP0G5sxGgNRHJDhyQ34MUZZSrmDziDHfD0zLXzTaEK6yPz2sL7Xt/5/xkAOuPCP2oWhFvI5fnG7LlneE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA3OSBTYWx0ZWRfXw618FFA9uBW6 25WG6FCqrAmJikXz8pNy8v1iF6flAXj3e3DPLytELsEtPspAybrUFyFQzIeH9yopHOooLplTV/j Eyw5yrdTqGFeuGHoV9xMUXscnxUvZ9IhWQhqs0P8CgKgwjxDd8e32ro/DBbGC9gFEsvPjFrzg9k
 soyqyYBzrYPXOxCZF37t64v5ju53dx5Y0Hs5UwPeXFshPGTIPRYtOFCCBLCtQuCRptKF4oL4KAp g3/b8idmwE+K7UsAPXZRx/CUMRyWT/gADPg8E7BWAzgdl1WMVLaPKo1N+Kbe88XCwQD9ATk0dRu 0rtwBGcZ+EH4r93LG/Ii2ZflNrFlFx5Gu0vVIej4xSvUWg3HBe/QPs0ObGywBRFCBNiFJxFMl9M
 cDHDNHJk+oyOK9OgPI7iUF3gSOjdowHZ4YWXjHtPpMRHs10zpNxu+7xFxYH42GLYZd3O8FBu
X-Proofpoint-ORIG-GUID: DZlaE-4j4bfYdnc9cGLlPXpJhP5Z4sCi
X-Proofpoint-GUID: DZlaE-4j4bfYdnc9cGLlPXpJhP5Z4sCi
X-Authority-Analysis: v=2.4 cv=b6Cy4sGx c=1 sm=1 tr=0 ts=68303953 cx=c_pps a=7NYwoM2WOJnlZ5JcLxGZDA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=n58jSPn0ql7obAd6v0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505230079


On 5/23/2025 3:42 PM, NeilBrown wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, 23 May 2025, Yan, Haixiao (CN) wrote:
>> On 5/23/2025 7:21 AM, NeilBrown wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Thu, 22 May 2025, Haixiao Yan wrote:
>>>> On 2025/5/22 07:32, NeilBrown wrote:
>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>> On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
>>>>>> On linux-5.10.y, my testcase run failed:
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
>>>>>> mount.nfs: requested NFS version or transport protocol is not supported
>>>>>>
>>>>>> The first bad commit is:
>>>>>>
>>>>>> commit 7229200f68662660bb4d55f19247eaf3c79a4217
>>>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>>>> Date:   Mon Jun 3 10:35:02 2024 -0400
>>>>>>
>>>>>>       nfsd: don't allow nfsd threads to be signalled.
>>>>>>
>>>>>>       [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
>>>>>>
>>>>>>
>>>>>> Here is the test log:
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/dev/zero of=/tmp/nfs.img bs=1M count=100
>>>>>> 100+0 records in
>>>>>> 100+0 records out
>>>>>> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/nfs.img
>>>>>> mke2fs 1.46.1 (9-Feb-2021)
>>>>>> Discarding device blocks:   1024/102400             done
>>>>>> Creating filesystem with 102400 1k blocks and 25688 inodes
>>>>>> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
>>>>>> Superblock backups stored on blocks:
>>>>>>          8193, 24577, 40961, 57345, 73729
>>>>>>
>>>>>> Allocating group tables:  0/13     done
>>>>>> Writing inode tables:  0/13     done
>>>>>> Writing superblocks and filesystem accounting information:  0/13     done
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp/nfs.img /mnt
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/nfs_root
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc/exports
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
>>>>>>
>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-test/bin/svcwp.sh nfsserver restart
>>>>>> stopping mountd: done
>>>>>> stopping nfsd: ..........failed
>>>>>>      using signal 9:
>>>>>> ..........failed
>>>>> What does your "nfsserver" script do to try to stop/restart the nfsd?
>>>>> For a very long time the approved way to stop nfsd has been to run
>>>>> "rpc.nfsd 0".  My guess is that whatever script you are using still
>>>>> trying to send a signal to nfsd.  That no longer works.
>>>>>
>>>>> Unfortunately the various sysv-init scripts for starting/stopping nfsd
>>>>> have never been part of nfs-utils so we were not able to update them.
>>>>> nfs-utils *does* contain systemd unit files for sites which use systemd.
>>>>>
>>>>> If you have a non-systemd way of starting/stopping nfsd, we would be
>>>>> happy to make the relevant scripts part of nfs-utils so that we can
>>>>> ensure they stay up to date.
>>>> Actually, we use  service nfsserver restart  =>
>>>> /etc/init.d/nfsserver =>
>>>>
>>>> stop_nfsd(){
>>>>        # WARNING: this kills any process with the executable
>>>>        # name 'nfsd'.
>>>>        echo -n 'stopping nfsd: '
>>>>        start-stop-daemon --stop --quiet --signal 1 --name nfsd
>>>>        if delay_nfsd || {
>>>>            echo failed
>>>>            echo ' using signal 9: '
>>>>            start-stop-daemon --stop --quiet --signal 9 --name nfsd
>>>>            delay_nfsd
>>>>        }
>>>>        then
>>>>            echo done
>>>>        else
>>>>            echo failed
>>>>        fi
>>> The above should all be changed to
>>>      echo -n 'stopping nfsd: '
>>>      rpc.nfsd 0
>>>      echo done
>>>
>>> or similar.  What distro are you using?
>>>
>>> I can't see how this would affect your problem with IPv6 but it would be
>>> nice if you could confirm that IPv6 still doesn't work even after
>>> changing the above.
>>> What version of nfs-utils are you using?
>>> Are you should that the kernel has IPv6 enabled?  Does "ping6 ::1" work?
>>>
>>> NeilBrown
>>>
>> It works as expected.
>>
>> My distro is Yocto and nfs-utils 2.5.3.
> Thanks.  I've sent a patch to openembedded to change the nfsserver
> script.
>
> Can you make the change to nfsserver and let me know if it fixes your
> problem?

What's the version of your nfs-utils?

The patch failed to apply.

$ git am '[PATCH OE-core] nfs-utils don'\''t use signals to shut down 
nfs server. - '\''NeilBrown '\'' (neil@brown.name) - 2025-05-23 
1541.eml' Applying: nfs-utils: don't use signals to shut down nfs 
server. error: patch failed: 
meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver:89 error: 
meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver: patch does not 
apply Patch failed at 0001 nfs-utils: don't use signals to shut down nfs 
server. hint: Use 'git am --show-current-patch=diff' to see the failed 
patch When you have resolved this problem, run "git am --continue". If 
you prefer to skip this patch, run "git am --skip" instead. To restore 
the original branch and stop patching, run "git am --abort".

Thanks,

Haixiao

>
> Thanks,
> NeilBrown

