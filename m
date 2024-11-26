Return-Path: <stable+bounces-95488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408239D91A3
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82C3B21063
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 06:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE37EF09;
	Tue, 26 Nov 2024 06:06:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE98831
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601196; cv=fail; b=mYGU6+oAyJ+bNqpZ7EQmZwI8s9YDbzlPjruo4J2M11SMmbYPu0DdJb7WRSbf1QWvCsDEah4KJ2J4+mW/zV9VGUHw7T87jd/DW+kUaHA8rbvcAIDLRSBvy5t3PBF9L7DCLEhk1d+Py5jfHuKfzJRn+eZd2sCCuyrYrP3eLYB60p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601196; c=relaxed/simple;
	bh=qptvV2fA0WyiyTf9lTNTBjZ1X5B96cPuMVEefxgoSnc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l53kNmH/v5uMSDsDeJTuT7dAOvoIaGJPeCVYvz03aFqYK9h/vMHoXUyMFTSMHDjSJ8EuiPqh2CUkaojZ4LKpZn/CAPV1038hjtudkhuhR3KahCtHlgJZXdoG4GpEKktEFbBuj7re6Vefb8TVEVtTJSZmRGFrdruo6Z4i0cnegNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ5gCnN001452;
	Tue, 26 Nov 2024 06:06:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491ax79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:06:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDjYJYVaf96gBbfbSHZGXsNneLgAh0lgom1+1sLgmpzHiGc822O9SLzWCD68yjlnTJDYU6HolkPLYZnIcCtiojBhZ4rHlCeraIxg5pXo63TbVQMYQpuJl17wF0n3Fl8tUw7o+Y/7zZ3zNvxhBfG0gpNb9ngldM/Mj+ImPjsL+WD2VmO+9JVdkSTk4PVx/u5LGnC4XO/j3viugE8LJbjMOs3cvxTpvTW6r6LEf3xKprgB+rMkOBpjIv2V6CPFzf4gKxyJu7KyA1VYFUozraJRbRI5rhRkVzUTZeaAGk53olwLXgWWzWMpWQBMBL/vQad9tu4FJEWW/lkMn6ufU8nHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbJLkNspy6vugnFyAlQwBtri1uY4ozl6GVYXVP1Y1P0=;
 b=azwvZQtx2OcJeEZ/8ZgJYDKmJMy7JFw3AN1NTtcihCzT85Bjzpy5WCGC3uPkdcPhhfitLXhZqaIY6qFEw1x2mpbuAmEfq1Xfwgp9wRdMVw5c0w5zasnh7OYH/XFWxIiMotGOBrfEQVDNJcdopY3n36bzyJ8l7v76dZWR9g3mI3GAgKshgbsMIByPMUSjv/T+oCbuVgDWsxpH7jUyI2YTXxWw8xE2PHdWXsEaJV9s1Z/fJXOznGH6iSO6/JAQt+sZRGEfhCfTjUB3aTjO1RJrniowDYJQUVVh0waJqJe+o/DTV+9cNJzRdCpWc+5UyMSnpayWcKyXisqrbeM9ZIkRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 06:06:15 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 06:06:14 +0000
Message-ID: <ab3bbe36-55b3-47e5-ad82-7e7889aecf52@windriver.com>
Date: Tue, 26 Nov 2024 14:07:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] serial: sc16is7xx: fix invalid FIFO access with
 special register set
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20241125213652-485aa8aaa283363e@stable.kernel.org>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <20241125213652-485aa8aaa283363e@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a22ed0-3805-404c-d012-08dd0de06ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXVLVHJ0K2ttcUZnd2JpVFczVEZ4UHdheXREMkdNM3hwWFVWd1RDT3lIWE13?=
 =?utf-8?B?b2JsdGkvQmpIZU9PeWZlRkpQUlJVLy9IWmkvOVZ4anE4WFJHYkxtQWVQQS9L?=
 =?utf-8?B?Mk5iYlR3dWVLdzhSbU5kV1RRUlg2Vjk1aXRabnduSmVYMldtajA5K0pRckUx?=
 =?utf-8?B?TkJTc2YvMkM5OEJxZXJqTnorQlUyZjZ4YkhZbC9ZVW5Wa3hMVDgrSHQrVHJ4?=
 =?utf-8?B?dUM1VzdIK2duZ00zNnVvT2VSUEhHUG0rNmhsZDJ1Wm1wbzhXdTNEdlVzOTBt?=
 =?utf-8?B?QXU1RFBGd2lFQVRTN1k3S0NKdmhWMnB1SjBFMnVTVlEzQWJDOW9uWmpvUis3?=
 =?utf-8?B?cDlJMUFHMW04T0IwUXJQWEJPcW1FZHJWak8wbk5oVm1lTmFFNStDWUZFQW1Z?=
 =?utf-8?B?a0JWVVJ6QjVRek56WC8xMzJhK05LSDhhanNseFNKRjV6aDVLTXlDdlFHaEts?=
 =?utf-8?B?RFpEKytwU0c5MXc1OWJWT2NhS3d0ZE1yZ1FjK0lyZ0lhY3M2WGM3R25Ycjdt?=
 =?utf-8?B?amZLOTEzaGQrelY1dXkrRjlUOXAyU3NRYVF2V1VSOE80czNnNGp3TUxYUkFw?=
 =?utf-8?B?dzVobGsvWDFuZkZkSHRHZm94TnorMmV1R3RnMCtwRytqMTA2RVNRa2Y4ZGNN?=
 =?utf-8?B?aVdrSlNUVFNjK3hPN25ZRG4xVk5GeHhtcWw2YldNaG9LQm1hY0d5a3FSQmVN?=
 =?utf-8?B?cGVRYnF1ZXFCLzlvOTA0S2pxS0JJWjhWVTRKbGg0czlFMEpZTU9pbU1wa3JC?=
 =?utf-8?B?dThiVHpTK0Y4VlB6K3VkU0t4UG9sdWpNN1lPZ05oNm9EQmFZeHEvUGo1MDRi?=
 =?utf-8?B?ZC90Y0V3SmRQYTZiMENpUU9qK0FaNTJ3b1gyVkhNcEVOR3Y1Y1grakhyejZV?=
 =?utf-8?B?V244YkZOYzl2cW51R0lIR0hrbnBtNURCTmhRVHZxSW9LRDJmWXRiZ1NJc3V5?=
 =?utf-8?B?bGcwUUVacXA5QzhBSE4xcUt1U0F1dTM4QjBDWGEwVC93ajZyN3VScXRCeTF2?=
 =?utf-8?B?aE1rYzVlUE1vcWx4cHpGY0lSeC84UkpINURVc0dENkZDUlVWN1JjUGlpUFg1?=
 =?utf-8?B?TEFNR1ZKVEtPY2Yrc2YzWUtZdU9rNnNZejhuTlVCNW04cHFpUkxCWGhuRzhr?=
 =?utf-8?B?cTcvN29jZUJ4b2ZpMlozdTcyUzVaWXpRM01jMVdUZVZrWVA0cU0renlpblVL?=
 =?utf-8?B?amJvcGZ0Z0FhRXFnOTlTdFNFQWw4djZ0K1JtQVNzZFFJaDZaTTJjdEU4MFdS?=
 =?utf-8?B?OWpvNmJJMHl4OUtucUVJM1B3WFpGNHRxOHpMdVpWRU5WMmdHZmUyR1NwN2M2?=
 =?utf-8?B?aFFYd1JVSGluUXh5eU02WjdIMUFwdzdEcE4weUpuV0luZjNzaU1ZalN5eUZT?=
 =?utf-8?B?a2JEY0lKMHcrM1BHWFIwdFRVM2xiaFp4NVdtVXE2YnlnekhqODM4NnF3K0Fp?=
 =?utf-8?B?aU4wWGRVZUVVSlYzWkMvWGcraWozdE9OQ0hoc00rRFhRV0lZOSsvWjdPUjZz?=
 =?utf-8?B?N1A4MVVaSmN5L3dadUNoWmEranFqalRuMWFRamUxeGw5ZUc0L0ozamJnQ1Er?=
 =?utf-8?B?RDB1Z3hwOW9lU1dhajNEMXdZL3cxeEZNVk5nS0VhYXUxdnFZSkdiaTFWVXZk?=
 =?utf-8?B?dUM1cHZ1K29RL1dkSXlRbDlYWnhFc1NkNDBuZTVVZVNWaHBvTTFWRkpBNmRG?=
 =?utf-8?B?aTk3RkRyMFgwaGtQRUFMNHU0VUtobmdXVi9Ud2Z6VzRZYUZoU1o1a3VKa1da?=
 =?utf-8?B?bDBZQjJETXFSQ2lkYW8zelVWZmtiRW5jNlh3VU5JaGxUanVlWnRVOWF6YzRa?=
 =?utf-8?B?RDlxdm9EQi84bEJrdk92dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkExR3ppNDZJWUVjMGE4cG5ZSHduRTNEYjJoQXJOZS9RMFJXVTFpaDk4c1BS?=
 =?utf-8?B?WDNoQWFhQU1LY3JYMGNzYStPNDBka3JqOEVDQituMTR1Zk53TlNPTHF3Mkdj?=
 =?utf-8?B?WTROaUtrM0ZCeXhhcFZ6bFFORk5qRS9GY0NiNEVHbERlTlFBSDZSMVRrZm9Y?=
 =?utf-8?B?U0tzeVRPU1NGRUtVc2hNRUszYzRDVkUzWTBzZHRNY1ZReTd2OWdKZ0dxcHBn?=
 =?utf-8?B?S2JNcS9NRG4zME9aRnpKbEgyUXNFdFpsTGtkU2ExS0d6cklUMmlMSVArTGRv?=
 =?utf-8?B?R3gxQ0tzUFNZS3pTNDN1SE96dmFqb1VOQk85ZkVIVXhBODFCVU83dEJ3clFP?=
 =?utf-8?B?TUFNN0NhcDBhN1RjVXVPL1QyOW9HaVJZR3Nub0o0eWQwck5SL1BRK2c2T0wz?=
 =?utf-8?B?TEdQeHRaakJlSGxYYTBoRXVlcUJCUEVsRUlUejN0T0RmVVpSM1Z6QzM2RnlG?=
 =?utf-8?B?OTlKdUtZaDg5UVhBWUIrRWFSbk9KdzJtR0c2MjM4My9Mem10UkttMnJSZ0hH?=
 =?utf-8?B?WEpHdk4xaTBtcFVKUm4wbmdLYm43SUZXTFkvNE0ycldjNVZUSWxvQkc2K3Bp?=
 =?utf-8?B?U3grOTVPUFdSczhOTElPdUNjV1N4eGJwblJiWVV4R1NidGNkTUt3NnRGR2Z5?=
 =?utf-8?B?TXBDQnZZYkZZYWNrL3pwN0NiRGtoaEZsN3hOL013dHV3bXdKVi9sWm9VOXNy?=
 =?utf-8?B?VHloL3ZiZ2FPWklUdW1nSlp5RnQycDlmL1RCTE1KWjIvYlBlSlRrWWE4QXBs?=
 =?utf-8?B?N21QKzBsR084NFZCRmt4cU5IalVSNUJ2dXd0WEx5SVYxYlh4TVh3LzR1bFdO?=
 =?utf-8?B?NUsrcjg4MDVvUW9uVVZISGxxODlHWk9xUTZ3NHJCd0FQLzdFTyt5Tkl3TkVI?=
 =?utf-8?B?NHppQS92YlVDbHNocFBkbGVPVytFcUk1dU1KcVYyR294dUtxWHB1SGdGWXhs?=
 =?utf-8?B?TVB3WmNKVTZyTEowaUo2TzZCS25pZmJHS0VwSzRQeW9HWFlUbjZaYmczWllG?=
 =?utf-8?B?WEMvY0VubFpKZ1pqME9VNWtQWEVSNUNCdytEWEh0eFZNMzBNWTJySFJ5MUJ2?=
 =?utf-8?B?cUs4eU5taVoydFpqR0c4VHQzY3ZJRVpKbFBuWng0c1BIaUpUUFpTVkluVVBB?=
 =?utf-8?B?MEFNWnJXRFczN0lUeUM1VS9yaFE3bFBHdTB2VnJwZEdWYVdOOTRIWXN6RHRo?=
 =?utf-8?B?YXZ0TnRPakpyT2QxSHVSNlk4c1RUREI1bTU5QU1mVm1HSHArenl2cVhCVmJN?=
 =?utf-8?B?THBBdkFLNERDYUc2RjVRdUZ0Rkx1M08zays2RHVBNkxBTmFmeEtFRWU2MWZR?=
 =?utf-8?B?ci9iaFlPNzgxUTY1ZVJ1S0RhaXhpYUhhTmRpRDVsLzZHOXRFcjlJK0NucERk?=
 =?utf-8?B?S0tIaU55blRKek1LbmJ5TXR6Q2wzOGFveHFvaHJpTU9PSVlIWUtOdlJiazlq?=
 =?utf-8?B?Zkg1Ri8vRWV3SDZ5SmFKaDBtMDA0VFUwdi9ER3dUeHFHbzF6V1BBWUhzb0xW?=
 =?utf-8?B?cXgvRFVZQXlEa3VzR04yQXVyNXhMcUxndVlKYVpQMEY3T3dZQW4xLytzeFZU?=
 =?utf-8?B?ZFF0MWdHd2ZpZzFQTW1wbVhIL3RZVUJOWGxxTHMzTXh6M0RHUUsxaThOcUlO?=
 =?utf-8?B?TXJ0Ukw5Y1VoUXF5ZEwzWHRwRlJBQ1k5V3lNdGpVczk5dHgxMHdtbDJQa2ZB?=
 =?utf-8?B?cGdqZStCSVFTRDJiOStoeU1hSW9tak0zYkhyMnZiVndpd2FQaEFmMTYzV295?=
 =?utf-8?B?WFB2RG5oVTl2QnZaRHllOW13UnRDZldtYTR2L3RVQXVGU0dwVGxqTEFXcHBx?=
 =?utf-8?B?RDlCTi85em4veEtwZGtGR0lqOFdPWEtZNVc2eGlzdkVZSXdDQUVUVklXRFBj?=
 =?utf-8?B?VUFaaHlXSjcwRndXSXRNczZBYnJFVUpsZW1ENmRyY3NsbEFheGNCQzh5YUMw?=
 =?utf-8?B?emJHSVRlLzMxTmtlWWU3bkNIU3F0MDdMWmJpQTJqWTBGOFh2c3BIK3pqdnlQ?=
 =?utf-8?B?Mms3RnpQSEVwU0lHeGo3ZmN4SVNVaUVEb2FvSlBVOU4zdTVZT1c1eUJtbVE4?=
 =?utf-8?B?OHhtZG9KdkhvKzJvU2FlWm9rNkUyLzl6WlJuZUNZcGlUVjVEbXdJZDVFZUFk?=
 =?utf-8?B?My90MUNGMTQyVnd0RldhUXJlM0ZmR3Q5NkRBS2ZtTVdMYkxLMzR1all5b1lP?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a22ed0-3805-404c-d012-08dd0de06ef2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:06:14.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8DXVRTW7KxT1qabOebsT+L81udmaXDJ/jVmd//RaND4+ySRfSRxrLBdm28qyNGNWno/YR6Yk//r2Y7ZSZNP+QgYZlRrQiFVS9ahY+xmFZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6745655b cx=c_pps a=7Qu+2NBwJcyibZ5HEcOKcA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=ANv9NCA0AAAA:8 a=t7CeM3EgAAAA:8 a=PjLayv2rAAAA:8 a=ag1SF4gXAAAA:8 a=NCCctUBsK-y-AM8T1VMA:9 a=QEXdDO2ut3YA:10 a=Hn0ac7NHSattSG0oRJar:22 a=FdTzh2GWekK77mhwV6Dw:22 a=qJi-GwaokQ_QderyKa0y:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: IRiv1mXC4sgubaa20LBJRnGwkzz2uVi0
X-Proofpoint-ORIG-GUID: IRiv1mXC4sgubaa20LBJRnGwkzz2uVi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_05,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260048


On 11/26/2024 11:13 AM, Sasha Levin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> The upstream commit SHA1 provided is correct: 7d3b793faaab1305994ce568b59d61927235f57b
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Bin Lan <bin.lan.cn@windriver.com>
> Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
>
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
> 6.11.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: 19c41869465c)

Since the patch for 6.6.y is present, Please ignore this patch.

B.R.

Bin Lan

>
> Note: The patch differs from the upstream commit:
> ---
> --- -   2024-11-25 21:31:42.179789487 -0500
> +++ /tmp/tmp.38G55Mxp3K 2024-11-25 21:31:42.172164427 -0500
> @@ -1,3 +1,5 @@
> +[ Upstream commit 7d3b793faaab1305994ce568b59d61927235f57b ]
> +
>   When enabling access to the special register set, Receiver time-out and
>   RHR interrupts can happen. In this case, the IRQ handler will try to read
>   from the FIFO thru the RHR register at address 0x00, but address 0x00 is
> @@ -22,25 +24,27 @@
>   Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>   Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
>   Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +[ Resolve minor conflicts ]
> +Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
>   ---
>    drivers/tty/serial/sc16is7xx.c | 4 ++++
>    1 file changed, 4 insertions(+)
>
>   diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> -index 58696e05492ca..b4c1798a1df2a 100644
> +index 7a9924d9b294..d7728920853e 100644
>   --- a/drivers/tty/serial/sc16is7xx.c
>   +++ b/drivers/tty/serial/sc16is7xx.c
> -@@ -592,6 +592,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> +@@ -545,6 +545,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>                                SC16IS7XX_MCR_CLKSEL_BIT,
>                                prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
>
>   +      mutex_lock(&one->efr_lock);
> -+
> -       /* Backup LCR and access special register set (DLL/DLH) */
> -       lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
> ++
> +       /* Open the LCR divisors for configuration */
>          sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
> -@@ -606,6 +608,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> -       /* Restore LCR and access to general register set */
> +                            SC16IS7XX_LCR_CONF_MODE_A);
> +@@ -558,6 +560,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> +       /* Put LCR back to the normal mode */
>          sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
>
>   +      mutex_unlock(&one->efr_lock);
> @@ -48,3 +52,6 @@
>          return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
>    }
>
> +--
> +2.34.1
> +
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.6.y        |  Success    |  Success   |

