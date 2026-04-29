Return-Path: <stable+bounces-241840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAzKKOq+8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB3491188
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12D230265BA
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187A3AD52A;
	Wed, 29 Apr 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nqh8GfRg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D53A7F6F;
	Wed, 29 Apr 2026 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450650; cv=fail; b=EA2gQF6GLW/+dZ/bxaDCVsNm3irE2DmAtR/R0A8xotqCa3HU5khJ7+LNBsAychvsgSw7bzh4x996Kg9Rjje1+Lx+HxKcqLwlJL31lvUcjRXS0SH6liSka8p2m1RRFJVmljtC17wep5xLH3zyQpXHO/IYTsvxDu5Y1xrJX7qui9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450650; c=relaxed/simple;
	bh=LgPfH7P2S6j69YrBP/UlQqIwn/wBkTECLaO/yTVEr4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKUDjJZAHB8asbsqiwQNggvWpTWTVwCncpCGJAkOHNFlSbC3KBTiDpQdylBKpua2YtsaANjOI4otQMs49AQV65/oK68yAYeuj8esfsiGGd8/4TUUin0X4dDct233Xr80tNmJ3XvKw/rv8YhBfsyUdQ1avVU6Z6C+ShosHupI6ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nqh8GfRg; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5lZ0G3646770;
	Wed, 29 Apr 2026 08:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yurjzKbvdJZaxz2pgQQT302qRt4+sNM1bLtZxoBPUV4=; b=
	nqh8GfRgmL2IF/L8AMvKYv/xpG7LVbBpioHPniCVey629dx7gbTfraTzhi/08v/U
	VvI3AJuaG6ypm4bICACkNV9A/r+ypzalX7AMTKuijYnltB+0/KT08Nnvq6GAW99d
	L+f/FdPsWhN0/GMP7idmoi5N3yPTMKvDonK9pfZZuWmp2V+Nc9G9arbbP9Yoz4gc
	LefvFCDwd7dhDEQbGUQMHD48U7Lco2bQmyMrgMFDy2ZSRl5zr11ir8kaYj77nmug
	hS1fFRO+or1WL94kFpQd8S8F658ntLhnYhyCkNWJ93UQpiIbVuUpAU/PCc3E80B1
	rQydbUD7LmD7qfNuoiYEug==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju0cq0d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 08:16:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSJXxMnsMDsysen0jvN6OEl0Z1HsDlEIAxGrNODH3mdtuOAfCzFks62vvtkNF3C/3pVz9DmHlJdvCIjmSyDV91bGdBUPR1hETjJ2pNvq569nl9P9TvFfXeCPOO0tSBy3gZGOPbsZ6+zQDt1Bb0qnOk8EEnTQJdO3OTNPuIORGhX5fLe7lPJ7lLd1j5YeWBkjMFnmwSLqepGmtKm2XvZkz4sSQ8VUN8EHYYNCGv1cY5FZ8GWjfwPXcLNwLLVNN/JxLjUTDVUKkGvDne0BlfQgj5aJJlCS3fN0xLLEfomj0EII2WqRLQjMb1VUH9kjvw0/tuYYeqZyaHIbeqT2NnfiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yurjzKbvdJZaxz2pgQQT302qRt4+sNM1bLtZxoBPUV4=;
 b=bZ64/HFEbb38HXdrk4Oj/PQ99UVNbMT4zU/uJ6beT3QCMW+dbMpHt/2v7E8u1DNsMQrzsAKQLuFWecridj/LhKdOJBuy/zLts0fmD2RmN+7ZslQzWF84Zvbc7Mpcnsebj76zEumcEomo+Dn4w4gB6+iWesNumCFZMhiHf4r6beskR5+HKhIuedSgRNHogXUzw1JBw/A/GdbvZ1pGpbRsJw9Ack1ypea1TweydmHlaPXr5VEx84yQsTXRT++njLoxduihRM28C8QAfkIT5tI+0Z1+3z1OAID8QOu2VygDvpEcWLG2FXfTQZvGJvVkD7zHeaXPpUUO96ZeIvw8moYICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 DS3PR11MB9817.namprd11.prod.outlook.com (2603:10b6:8:365::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Wed, 29 Apr 2026 08:16:54 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68%4]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 08:16:54 +0000
Message-ID: <a298419e-c581-41c9-b6d5-9319c24b7995@windriver.com>
Date: Wed, 29 Apr 2026 16:16:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kprobes: skip non-symbol addresses in
 kprobe_add_ksym_blacklist()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: naveen@kernel.org, davem@davemloft.net, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260427073545.3656835-1-jianpeng.chang.cn@windriver.com>
 <20260428184321.309a48036892b8d23a08b566@kernel.org>
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
In-Reply-To: <20260428184321.309a48036892b8d23a08b566@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:d10:31::6) To DS0PR11MB7736.namprd11.prod.outlook.com
 (2603:10b6:8:f1::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7736:EE_|DS3PR11MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: dae87b3f-2acc-4a20-d148-08dea5c7ac44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	12yd4ZYxgN+fJKVfnaEIVWW7qMLaw5zM2qFmgv+hN4XUuY45vxx9yaaz8GgwbV3a6nXqd4Cmm4t9cBLrQp/EFkHwHVjWtJ93n48F170IrO91wes6B6agJ4EDUEkzpkZYRggv1qWdonj92xxAasbNA9DP0yXHje1dF/N0F6nGha2RmvwHXoQpg/Hnk8pF/snKKORNMSqZDb+pijE47U8DDk1FL3v+25RgqlOIQfF05NPwGsVFknwdJB8aOf5HIqSyQX+7zXFHBIENZE5fIbpPKBdQQyS9+shBGEAipQiBA6Ce7nPiDRma9UdCyEWjFwbvd5zbaZalxisMVRiraAV7vsBxKOjkSFhXU6ErU/drygdnr/NS8e8aPQ6D6++SaBelrRgmP4FSBVizwY9uDEhR8clsc4CwyofNviKCNlSEBm13TsdoZ2x5B2nje10+jWmoqUCUla6/6pAQM/yxypBR4atXD3Z8LCUJMJtTibA3vzbW+NllOgBLObPTv+9550ncSxcPyg3SvHD+Q3WTsPS7B+TjK/MoiWQtqO7FYoylIAJ9F0OCWQsWDyspEIkqyBRZXdrTx4Qyl5U0iVZzRNLoYHDrEz26R960f+FlgRvzdNU4+38O37cvVeQr6VOebsFbQvMDtj5JCuPOhK3zsdlTWh+msNae/tJB69m/drtDqV9CVrv32O4qMsAs0PjDLSYGxukQ6kW0rHlvlCI4jEEfLebXMosxFDmlgIZWHv+cZOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnVsTklzN2xtVXY4dWZOYUdjekkrYWtBM0ExS1JCYWxvMjcwaGhheUFGdWMx?=
 =?utf-8?B?LzJkc25URzI3V2M4THJGRENSaGhTWDBveGlyRTA3cUVYTG1JKzlLenlXZEcw?=
 =?utf-8?B?VW1yU05aTmRXem9RR09DYTZwZ3RhRUZSOWUrWkNmeVljRGlyL2NiTG5tNWFC?=
 =?utf-8?B?UWNIY2ExcjhFVE9TS2Vrek1ndUs5S2o0R21DV1A5NWd3ZUJjTXhDL09TOXhr?=
 =?utf-8?B?MzJxSEV1RXhXcGQ3dDQrNU14UEFCZS9sbTNjZ3ZMenh3Tmd5QkJ0cThsT3VQ?=
 =?utf-8?B?Z0Q5RnBlV3Y5NlRVZVBwUmVGMmpmSnhSZkIzZWNkaUhrZS96b2hCQ1c5dG5N?=
 =?utf-8?B?UkZEaXBqZlpRaTRmY1VVZTJWN0RRYVdzOUk0UUpWVk1sdlQ2OUFlTDF1dFli?=
 =?utf-8?B?cmhOU1YzS3kySGN4U25FaUl3RHJCdFkxdVUvd3RKMlN5RlloWDhJV2t4dFVO?=
 =?utf-8?B?bENKUEpYNkVVb1FNMmhpazJwaTN3eWJBa1NtTmtTTUpzS2NqcDFIQmdtcTVa?=
 =?utf-8?B?NnNmZWdwYU9NbkExRFpFdUo1bjVIZCs3dlE1Q3d6ODZkRXNCUUozdTRaYzJk?=
 =?utf-8?B?bnJ2Nmh4Tzd1OGpzb0RhWFp2ZHZIcXhZVnh0eEJTUDRvK2FUeHR6anRwS1VZ?=
 =?utf-8?B?OFpIN0NaYnJwdW9VdWFvd0RNRko0ZGhBT2o1M2xGdWN3a3orWlJ2OU5hVGI3?=
 =?utf-8?B?VDZoN25HZ2FIZmlTMzJJY1JYUDhPRWszYjlQbDI4eHF3YWp1WkpEK1RSWFFy?=
 =?utf-8?B?aDNDVFVLSmU5WWRiV005VnNaVVpGZzZMdnptOVl0YXRVa29tU1g5RHVhcVNh?=
 =?utf-8?B?cGp0MDFxZTVINS8wZzk2aGdmS0VuRlVxaVBDV2ExSEdhSy8zV0pyS243bFpC?=
 =?utf-8?B?WldTWkw5STdVclpkVmxsS3A0eTZZM2dYNXVhVlpmRDYvQ3h0Zi85bnhtYVJY?=
 =?utf-8?B?Sms3eCtrbDkxeDkyQnBPWjE2RnZtcDJwaUNGWlM0Y2dFOW5KY3l2Vmh5ZlBm?=
 =?utf-8?B?NEFocEc1TFd5M2lVVDZzaFJjOXc5cGJQVUZRNWFrOTc3aFNJTWVrczBqQUhZ?=
 =?utf-8?B?L0FSNGtNbmYva1hEQmUyU0Irak5OcXBJNTVYd05HZC9OekZ3TXpUSWFxMkFW?=
 =?utf-8?B?YlJsVUFuSSt1d1hVQktYbFBXcW5ObkdJS2poUlZjS3RhUzJibTNpTE5tYjBZ?=
 =?utf-8?B?MDVML2g0dFY4ZEFsdm5BeERONDYvVG1qUFZyNW5vYytmMEJFQzhmZk5yQ0w1?=
 =?utf-8?B?NVpYVGZleWxGZk1GK3hWVThzSHlHc1BvSnRVWEFNdm9WV3JyRHBsS20zbVA4?=
 =?utf-8?B?RlRqY3hMVmE5T1AvbHA4VWdwVC9QRGZrOWhsa1N3N0F3d2ljbTB5dGU4K2E0?=
 =?utf-8?B?MlVIZjBqcHV6aGxNTE1CS1BKVU9MSHRlbGZmaWNRaFhhdkNRcUMvZnVXaXlj?=
 =?utf-8?B?WlBQRkp2TzBRNmhVWnNJcURHMmxKa1pmM0hzSkxmTCtzL3hETm1xTWN6aUtW?=
 =?utf-8?B?M3U2andoWGhqWkZhWFFoQlpOaU8veE5HN1lLU0NiaTI0c0tpa0J2ZEt2SGVw?=
 =?utf-8?B?Um9vYkxtWFc4b1VlUGEvSGVJNmJ1SmtrVE85R0FiVml6K2Ftc001Y0FuMmlM?=
 =?utf-8?B?cTBybC9sa3M5QXRNQ2tudVl2ZE90VFdwSStHeXV1MlRndmVVbnNaU2JhVXpZ?=
 =?utf-8?B?blU0c1E2cm4veXpjNGFGSVgxTjN4ZzZkQXFRU1l0ZTZUb3Q1RzVjVGp6VkRU?=
 =?utf-8?B?VyszcndsNlJOY0I1dEFaS3dSNWhlZUJVVWhsOFQxZlNpVTlCTlA4QUY1cHRF?=
 =?utf-8?B?eWVPSkdwd3h1QWlQcGE2bWFqRURiVFdIUWY4RStRTE9RRlo4ZFJacnREazZz?=
 =?utf-8?B?eDBMMnlxclkwSndHdC9SS1YwNnZtREdLNENUQXBtUUJqV3JHdmsyWGpoTWxv?=
 =?utf-8?B?TnBZbjBFeU1pVnJuWXZaazc5MlgrSTVldnkySU1qWVpaZnRXdkgxR2ZLODJj?=
 =?utf-8?B?UnppYkxXUXJ5c3RLRTgyL3h6bjRpeHFZVTN2WXlQdnVQanJGTTZPVlFFNEpn?=
 =?utf-8?B?bmN0K2JiYTNoZU5ZakJ3WUF2WXNQbFM4OVY1ZE9WSXlpR3JJR3FIZS9ZOFR5?=
 =?utf-8?B?ekJwYXdZWUVqWk5TSTFNVU5BN0x4eVdCYlFKQXUzT0dTMDN1dTNxSHBiSnRk?=
 =?utf-8?B?Zmc2VkZDQWg1MzNlK3dVWGdNc3ZrSlprOVlubktHbkVTU3k3Ti9LU0xCdDN0?=
 =?utf-8?B?c1Zlc1NmZlIwR1AwQXVHNjFzUmJNVEl4SDlzTmlIYi9VOXdnQmR4UGo4cWtu?=
 =?utf-8?B?eHg0NDJXakJTNDdra1VNUlFqaE1VRDVJUnFVc3Y4RlZSVWhsREl0OUVKbzkx?=
 =?utf-8?Q?CQIfelXEAfQ8VaKU=3D?=
X-Exchange-RoutingPolicyChecked:
	a6ExxSV4OuJHP900tZhp/3KSERl/v/do/k3QaUI3MmgqtrYYBuu+XVkzmlZBQmI1pHcgda3PCjgq4tcrcgSgWc1IUa8vjXmLSxo6wq9+2Zef2fJjNgIcAg8PXWx/IoGTVv2hMeajYchGjZJHkMXTo1OaYeILZojEQYDPD+tWFass3ZVHqOKJCcp6tncVj2tGvFM5hP5v+S6XkMXPVVOya3GfytMHjzz6eUqXx+3OF/+gZJjJD/rqyvRdeMPskBS8gjkUd9Jd7niYLaHrhOlQJsiL2PdIP+Bq6QbjHKzPPj+xaVK6xTg66sxqesDvSawjsUvqBZ2c2Yy8wOUrceYZaw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae87b3f-2acc-4a20-d148-08dea5c7ac44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:16:54.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVg+dqTlnDq0vtGuo2jcYAlqelKsnKaperqXVFJjB28hYnil3bEuLbjPdOvq2fUkwj/RlZJwAzMmdW1CLlHl+6Ap5yWTS02GSd9wyziIfZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9817
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69f1be79 cx=c_pps
 a=LrO9QPEl2oM1zDNvT4V0vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=658X2ejkE-MuQFuiACMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: I_0eA2g3bDX0wCIuTSRMS7B8yoGkuFtb
X-Proofpoint-ORIG-GUID: I_0eA2g3bDX0wCIuTSRMS7B8yoGkuFtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA4MiBTYWx0ZWRfX7RWFJeubnC9q
 mRRWLvkKpMxwLwqwJgPleYHqMdUaZSJZUNrPybZVcUJGy++Nqmq2OXaOpRe7HewCYMwxBzWgO7L
 uVkP0O+G7hNKad1ZxUOXOkWM2v58iy74rE1Kb7/rGJX0p/DnWBAWRJqESWs98rnt/Wra5vZ5fPR
 g9krIw0h2kL9lmDL+M8JKau0j0PLBJIOJYplaVWnMnpRvsR3ct/qivZO2ACAmyfK61ywk6A2pid
 VkIYgBivngaUahGbqFM93LadpxunmgJNJjjX5f7vqDat9EH78c55t6DjrwjHRyhSkWsKHXp1sFt
 1+X6FZoW2TYPxZrDIk2RbmN0/wzeZ52V1JlhXgsPtgSLhmjlivJ6BE1JLdhFZwfwCp2H4lEd5oX
 FZ8dBQOW5pXN2s4KMsyunf6I/dqpsHZmhbbcdS1BWBHepa9xaG2L15qPtIEi1T0nd4pXeE2B8hs
 93a0Tt4s/KQuUpZT82Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290082
X-Rspamd-Queue-Id: 17CB3491188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241840-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]



在 2026/4/28 下午5:43, Masami Hiramatsu (Google) 写道:
> CAUTION: This email comes from a non Wind River email account! Do
> not click links or open attachments unless you recognize the sender
> and know the content is safe.
> 
> Hi,
> 
> On Mon, 27 Apr 2026 15:35:44 +0800 Jianpeng Chang
> <jianpeng.chang.cn@windriver.com> wrote:
> 
>> When kprobe_add_area_blacklist() iterates through a section like 
>> .kprobes.text, the start address may not correspond to a named
>> symbol. On ARM64 with CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=y
>> (introduced by commit baaf553d3bc3 ("arm64: Implement 
>> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")), the compiler flag -
>> fpatchable-function-entry=4,2 inserts 2 NOPs before each function
>> entry point for ftrace call_ops. These pre-function NOPs sit at
>> the section base address, before the first named function symbol.
>> The compiler emits a $x mapping symbol at offset 0x00 to mark the
>> start of code, but find_kallsyms_symbol() ignores mapping symbols.
>> 
>> Without CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS (e.g. defconfig), no 
>> pre-function NOPs are inserted, the first function starts at
>> offset 0x00, and the bug does not trigger.
>> 
>> This only affects modules that have a .kprobes.text section (i.e.
>> those using the __kprobes annotation). Modules using
>> NOKPROBE_SYMBOL() instead (like kretprobe_example.ko) blacklist
>> exact function addresses via the _kprobe_blacklist section and are
>> not affected.
>> 
>> For kprobe_example.ko on ARM64 with -fpatchable-function-
>> entry=4,2, the .kprobes.text section layout is:
>> 
>> offset 0x00: $x + 2 NOPs    (mapping symbol + ftrace preamble) 
>> offset 0x08: handler_post   (64 bytes) offset 0x50: handler_pre
>> (68 bytes)
> 
> Ah, OK. It is for __kprobes attribute. I recommend user to use
> NOKPROBE_SYMBOL() but I understand the situation.
> 
>> 
>> kprobe_add_area_blacklist() starts iterating from the section base 
>> address (offset 0x00), which only has the $x mapping symbol. 
>> kprobe_add_ksym_blacklist() then calls
>> kallsyms_lookup_size_offset() for this address, which goes
>> through:
>> 
>> kallsyms_lookup_size_offset() -> module_address_lookup() ->
>> find_kallsyms_symbol()
>> 
>> find_kallsyms_symbol() scans all module symbols to find the
>> closest preceding symbol.
>> 
>> Since no named text symbol exists at offset 0x00, 
>> find_kallsyms_symbol() picks __UNIQUE_ID_vermagic (a .modinfo
>> symbol whose address is in the temporary image) as the "best"
>> match. The computed "size" = next_text_symbol - modinfo_symbol
>> spans across these two unrelated memory regions, creating a
>> blacklist entry with a bogus range of tens of terabytes.
>> 
>> Whether this causes a visible failure depends on address
>> randomization, here is what happens on Raspberry Pi 4/5:
>> 
>> - On RPi5, the bogus size was ~35 TB. start + size stayed within 
>> 64-bit range, so the blacklist entry covered the entire kernel 
>> text. register_kprobe() in the module's own init function failed 
>> with -EINVAL.
>> 
>> - On RPi4, the bogus size was ~75 TB. start + size overflowed 64
>> bits and wrapped to a small address near zero. The range check
>> (addr >= start && addr < end) then failed because end wrapped
>> around, so the bogus entry was accidentally harmless and kprobes
>> worked by luck.
>> 
>> The same bug exists on both machines, but randomization determines
>> whether the integer overflow masks it or not.
>> 
>> Fix this by checking the offset returned by
>> kallsyms_lookup_size_offset(). A non-zero offset means the address
>> is not at a symbol boundary, so skip forward to the next symbol
>> instead of creating a blacklist entry with a wrong size.
>> 
>> Fixes: baaf553d3bc3 ("arm64: Implement
>> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS") Signed-off-by: Jianpeng Chang
>> <jianpeng.chang.cn@windriver.com> --- Hi,
>> 
>> This patch skips non-symbol addresses, fixes the bogus blacklist
>> entry, but leaves the NOP gap at the start of .kprobes.text
>> unblacklisted.
> 
> That is OK because those NOPs are not executed in kprobe handler.
> 
>> 
>> We can continue alloc the ent without return to add the gap to 
>> blacklist, or do some more works to add the gap to the first
>> symbol in blacklist. I'm not sure if is this necessary, or is
>> there a better way?
> 
> Are there any compiler option or attribute to avoid inserting these 
> NOPs to the specific section? (like notrace?)
> 
> Also, as you can see there is an alias symbol whose size is 0. and 
> in that case, we move the entry + 1 and call
> kprobe_add_ksym_blacklist() again. Thus, the offset becomes 1.
> Please make sure it is correctly handled.
> 
Regarding the alias symbol concern: kallsyms_lookup_size_offset() 
computes size as the distance to the next different-address symbol, not 
from ELF st_size. I tested with a module containing alias symbols in 
.kprobes.text (created via __attribute__((alias))), and the lookup 
returned a correct size with offset=0 — the if (ret == 0) ret = 1 path 
was never triggered.

That said, #define __kprobes notrace __section(".kprobes.text") is a 
cleaner fix. The NOPs in .kprobes.text are unnecessary since these 
functions should never be traced by ftrace. I've tested this on RPi5 — 
the bug is resolved and all .kprobes.text functions are correctly 
blacklisted. I'll send the notrace approach in v2.

Thanks,
Jianpeng> Thanks,
> 
>> 
>> Thanks, Jianpeng
>> 
>> kernel/kprobes.c | 4 ++++ 1 file changed, 4 insertions(+)
>> 
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c index
>> bfc89083daa9..be700fb03198 100644 --- a/kernel/kprobes.c> +++ b/
>> kernel/kprobes.c @@ -2503,6 +2503,10 @@ int
>> kprobe_add_ksym_blacklist(unsigned long entry) !
>> kallsyms_lookup_size_offset(entry, &size, &offset)) return -
>> EINVAL;
>> 
>> +     /* Not on a symbol boundary -- skip to the next symbol */ 
>> +     if (offset) +             return (int)(size - offset); + ent
>> = kmalloc_obj(*ent); if (!ent) return -ENOMEM; -- 2.54.0
>> 
> 
> 
> -- Masami Hiramatsu (Google) <mhiramat@kernel.org>


