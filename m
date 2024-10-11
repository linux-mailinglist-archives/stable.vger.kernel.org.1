Return-Path: <stable+bounces-83495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21FB99AD64
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 22:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325BE1F23722
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E431D0F42;
	Fri, 11 Oct 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFXOOG8N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IIyWPOCA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424351D0144;
	Fri, 11 Oct 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677455; cv=fail; b=Ipxp57V3wHmRfWRt+FFB9TLciTb0jLn5/A8LFAmSfOaEYeosmPIiibpHcYuYLwKa/egDdFTFQtJME9zO/EKZb1tTxvaXMZ3tYzcuEgXzqY79rx/EWrGiUHWdjQjxQ/dKuW1+09bFFuKV/hM+ddsMN+YRwwOh/aoF9gwXC/sacY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677455; c=relaxed/simple;
	bh=n0QIo0Gtai2HSvqjPc06QaKg2ZYurlP6RaNtkHTfTys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BrTzLDGktl06bMyM0Uclg8Bn4g7/ZbzI7Vded6sBDwC1paVCdPhlu24+cUDU83MI9WEIHAx1S9D8Ey+Gqk+8+g5LvfRB0jXot8VlKeQQXbpgLnlTJiSO1R67hdOAn9HuyQFsfJbOQHJFMPLWgtZmqfExhS2lGdA3onRaM7xHwx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFXOOG8N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IIyWPOCA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJQekO007065;
	Fri, 11 Oct 2024 20:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GDflhITs4mTcoEPj6cv+cBwB75jX8rpHDsS38C4ijqg=; b=
	DFXOOG8NZZjN7WxP0nXRjOtr0bRuF1GJw2f8DN1K/1dTeAGOBUGnxx4gDv5plVoL
	jsYL8hMthhLvVsO71IpTRGX7mjuIdfOpTpWaCoFpRrHGgyGTEXKscbYdtpPDBAje
	HRh2jZ2+lIsW/7fM3ClQHFsr2COqMhrfii00RVDl0RpcLJCN7XculJkYW2ty6z3s
	kl78cQF6UuSgUJWduGtcKxTed1D43uX+qz2FqBV5e4+AsCCCe6XKw1zHOYXVv2BN
	zzEcLSsC1bPBaERdhbR+6lTmku+ZBSmPCWQzr/jL9d4e19XcDNdkGZLSZwGpqy6+
	1AKAkBqr2yB3ttjAeSDg+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ynr3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 20:10:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BI98rg014612;
	Fri, 11 Oct 2024 20:10:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbnxvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 20:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+kZ/jLUrPQJumuOhsjztm6MUBMV93JW7J8S+DjjIX0YianzaKoEBVt6rZ3rwrp7LFe7IXUS2xJRLbGGq6yomrlzKNdlwpIMq5qJUiOTHdhx/wk6bMaxGGHr1oeAY/WoSIPtpKcsopmjGxIlFtqmMumsfyWW/71C5F80oSF35l37G7HXznHyNWD6oeCgJ9+yrMft1cHv18kQd78x7Wo1F3O16YHzR3Sk/q02u+4antvr8ZiZ+yImeL+JfkVa+79Cv1ihAJsx2AQQ11cQMimL+hsu6j3vcgwIFA3v4uQKbixJbLrW3dAAudDkQ/VyRluCHtabrTAKAKcDPSW/3NBlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDflhITs4mTcoEPj6cv+cBwB75jX8rpHDsS38C4ijqg=;
 b=h1YD+ZMizzYkbqJaXiVncaYUw6UbQ3to5nfUbQ3gHUttiAQ8uH48B2vnwK9XsS6icBXGwdKOA0x1zGRvnysD2HRfHu6vKJuJN5XkF0Uqk75JO2pGaKzVZkIkYNOmNkTRxy8mTaoNq44HBadqy0O5K8GqPqSr6EKwrUzvSmpxTIhPiE2pBL4T7E6etcp7MMiYJgFCTK4emPUQMDd72V5Smyfd09zf8zGlj5E6btC34mt0jHCTJu6nv1aKNhmTTa7z11L6GdiLBaKZOaRBOEkig7XlDrkSuCmG6bOQJ+XHe+Wl+dya977YqaNTAUs52IdWwTvTk6DpD2kNRIz5iRwfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDflhITs4mTcoEPj6cv+cBwB75jX8rpHDsS38C4ijqg=;
 b=IIyWPOCAygRzMY/WbPYnxH9oNkjZAVn2zkt4nrCrR2t8YFOwAK6r9pP62NzbVVJXsrgY71b7h2vX7iBQNZ1JG9oMEZeePuuVS8ZzYPYSpo9KdWQJEsMoRn3W4tuQlE36AmuAXMSiiVtO166IPsfZJc905ULgiPKdogSeOxS3+uw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:10:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 20:10:00 +0000
Date: Fri, 11 Oct 2024 16:09:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Helge Deller <deller@gmx.de>, Ben Hutchings <ben@decadent.org.uk>,
        Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RFC v2] mm: Enforce the stack gap when changing
 inaccessible VMAs
Message-ID: <2i6snbyauv7hn3oitgwt54qqeltyq4eplo3ersiubtfj72jtwf@fodbxw5hvf7g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Helge Deller <deller@gmx.de>, 
	Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@surriel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241011-stack-gap-inaccessible-v2-1-111b6a0ee2cb@google.com>
 <dantzkqu2pyeypcbljes6omc2wuyqjguhgd4lcrk2tijfyyd2g@fx46a4mynnsh>
 <CAG48ez2ZrTqEwnV18isAeYLT-FE1r2io+eXcqNp=ck1n0E08zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez2ZrTqEwnV18isAeYLT-FE1r2io+eXcqNp=ck1n0E08zg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: a3366808-d1d1-4508-1d41-08dcea30af79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0h4MnFOdkRKK2thMGtlY0FXdDBFZVMxMzZZcjZ5MTdSdloyQjBybjFLRXRW?=
 =?utf-8?B?MFV2SFgwMHpENk0vM2NnUDZyazlXVE5VMk1KRGFlTGdDSUQ4NW5Jb01FTW5J?=
 =?utf-8?B?c2hGVVNCcjBxcDcxazB4M1grN3ZHSEhlOW5IdU9CWUJxalpYSXRKeU9oZFZT?=
 =?utf-8?B?TCtxUURobnZqMVllUmZ1WE12cktLbHYrVkx3cnRYdG1qNC9lRmxCL2RtOGRv?=
 =?utf-8?B?YmdVTmVWT3M2Sm1rWFRkL2ZnTDBhY0p0OVRoMG0xaTV3ZjJsdHVVQXd2elZ3?=
 =?utf-8?B?aWs4Ump2MU1wZ3dBME9xNkt6c3pmYSt6ZDFaZHB4U0d5TUtucUdJSjlRTUM3?=
 =?utf-8?B?QW9CMUFwa3pMU2JjUUc0NllOaUtEdzF6WmxCampKNlVDTVRhM0tFbXc1cG9k?=
 =?utf-8?B?a2hEWVdrWkN2UStvQ1JJbExPVm1Lalg2U3NubHVOQm4yTC9PRHNWcU9LVzRm?=
 =?utf-8?B?Z2FzTG1iSUdheXZnMjZXeGY5UWRwamt5b2hMWVRxbEZETEV4UUNNWkFpZkpH?=
 =?utf-8?B?dVJYdGRyNnNHbHE0SGNwNzVUdkNLT3g5cVVKTnpVTElKenJWOWVUUXlyaTlV?=
 =?utf-8?B?WXJaK1ZvUmdEcDREOWxSTjJLenA0WmV2SHdnMlpjVnBGZDdlckFYY3hOZlZz?=
 =?utf-8?B?VWc2azcvQUtuK1VNeEY4Z29NK01Ka08wM1ZiUlNCNWpCMlpuQm1LNzIwYlA3?=
 =?utf-8?B?ZHhmaytwVWFqWENOdDI3L0xFUzV2RDBwaGpGUXNTRkEybUFIWUxCSEJyaFM2?=
 =?utf-8?B?WkV4bUpXVTFXNGpDUGl4dWMvM2pXb3dMTGg5VC9Ib1pVZXBHUy8rOGNNY2NI?=
 =?utf-8?B?UG83MGxPM2dXdVFoYUxRalJYZ1dQakVwLzN5TUw1WXBsTEhHTHJ2UlZlSEhH?=
 =?utf-8?B?am1BVDJXVk43cmxTT2phTjlOZWE4RjJMd1piZXlmczkyV3Y2SzFmcUlMYkJE?=
 =?utf-8?B?SFlja29pdGtneHFwcVpJbHJ3WVd1YkRpK2EzelI1clI4VVByRkNINWdMZkdi?=
 =?utf-8?B?ak5qZFpzNlBySjhySWhIaThGcWw4aURhMjV2T0pXdW16eDdZNnBTcTRvRW1x?=
 =?utf-8?B?d1BaK09XZS81T052V254aldCZlpqUXRHTlVIZkVYbDA5UWVRTFFrWXJZZ0ZW?=
 =?utf-8?B?OUl4TXhKaHpTQWsyVXN3OU9pd0pvU2dxUktJMDNiMUErU011czhiWHFGeVZ2?=
 =?utf-8?B?YVBVcWxJYXBQakZnMDU2YjNiaXZ1Y2Zuc0VYVlAwUXdIaW9mdFdRaFJWMTFz?=
 =?utf-8?B?Z0FuUFhxaU9PQll0MG9NT052OHF4dllhSmdRT00wS0lwbXBHUE11VStQU1Fm?=
 =?utf-8?B?OGthRFpvR01GYU92bGF6bGJVMlRCUjFTQ1ZjODQrNU9qdW9VcEtUT0sxVFJW?=
 =?utf-8?B?NXNNUlVHNVBoSlhMa0JhQXdpSkhqNTVZcHh5dUxBM3VwbDBIU01GcFF5QlB5?=
 =?utf-8?B?WU5ONFJ0V2t4dDl3QjVuV015Y3ZLaFF6cXZuS285NDFpKzhhbG9tRS9BOVhT?=
 =?utf-8?B?cStkNnowQW55TWhlL2h0Y3lMZE5ScHY4dThldVJBSU9Icy9pMmE3cjZMN0JY?=
 =?utf-8?B?S3FvY2JlNUVuZkd5bi9lNkpHdzE0SVdEYUM3ZHdvMUpQNHMxbmNkLzBTSlU3?=
 =?utf-8?B?YVQwQ3pGbVJYN2NueVYxc2ZIVXR4YnNkYzBLaklFYzNuRTlWNWJYTGRDTzRF?=
 =?utf-8?B?V01yWkcwUWJCOExzVm5xcjBzeno0Vjh4ZlBoYUkyeWhtQ0N6Zk05YktBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNMWlNYS1N1VWtGRlRyaHZXZkxlb2tlRWJhaG41YmtLMlpWZmp2TkVkVlky?=
 =?utf-8?B?MmNOQ0ZrOGhtZldhUFlXNFp2WUJTR0tKNW9tcFVabVRjN2ZtcWVCQjhEMkc1?=
 =?utf-8?B?NnRHL29yU0tLckhITTQ1akI3aHR0L3k0Z1o5cWd1NXYyL3pkYTRReXd4eHEz?=
 =?utf-8?B?RXY1Wll2VlUzMGYzdlIzSU04WHc0R1FoQi8wTEZ6RGJLMnhTQ2g3U2FuMVly?=
 =?utf-8?B?NGw5UjJzWjMvZXR4QzFFdmdSZ1R4TFl1MGNQQTdvelRxTms5aGs5MlZEN0w3?=
 =?utf-8?B?djRWaFJHMjBLZmYwblZ6cUFYT1hhQWhxaXU2OEh6c1lFemZZbFNZMEVsd05U?=
 =?utf-8?B?d1B1ZkhJY1NiV1hTbm1JZ2xiKzh4b0IvZW5INEZaVUFlZ0JmeXpUb2QwNUdE?=
 =?utf-8?B?d0lVSk1kVGtDeHRROFcrcmZmTk15Y3IxSHNhTDJ5NHZCcmk2Q3hYYjVZWkZV?=
 =?utf-8?B?YzBUcmxKcjNZbzFuelI5MTIrV202MzduMTM5OFJhNmZ3QTNZU0NwY09PSWRo?=
 =?utf-8?B?VDlsMUhIbGEwMHoyMjZWSFM3Um1OanpLNXo3OGxXdDlxejZRcjFqcTNISmVP?=
 =?utf-8?B?dHRMRUE5dVZCdGkvRzJpMFBkcFhRZ3loV2VoclZqZDdwREtxemR5TUpTZXlO?=
 =?utf-8?B?Q0NjYXh3OGw1VlA5K2luc0xjSGh1WkpDNXFqeGpUdThIc2ZHUU00MGpsKzBM?=
 =?utf-8?B?Y2ZoaStLRXhNQnYvK1RVZStxdWF3NWVXYUxjVk9aZ0d2TThOVHliNmg1VzVX?=
 =?utf-8?B?cUdISWhmRCtabEF0dXpjMHRHSjRWT1NKV2ZoN0hCRGtLTmt5NlVmOEZQc2FH?=
 =?utf-8?B?dnJ0RllnQURPOHhTQlBiOTdwRWt0UVZBNFZRYkVXeFowZEV1ZTFtdWEvK3NI?=
 =?utf-8?B?MmdiZTJmSWFlWnBxeWMwVVcxQTBNQ29UOUtyUUR3aDByRnVMd1hYMGE2WHd5?=
 =?utf-8?B?UXZzMCtSakIvVnl5WkpWNnVKdXV0eVBDUTR1Y2htb1pHa0FjY2lUdzcxSU5n?=
 =?utf-8?B?Sk1rbzRpd2UrSzRXU1BoQzBlVExvNHl5TEdnZjY3M1A5UWFhT3QzN0pmRUNR?=
 =?utf-8?B?bUJQczgzRjAyUy84YXg3WFg0UXMzalpEVHZ6VzBpeHVVbGlTQUMyR1RLT3pM?=
 =?utf-8?B?SjdYaTJ4dHRpbnNJNDBEM21uSUJlTldwM0Q2b0tFNFlIMng4UVZhWkFOWEtl?=
 =?utf-8?B?UVNQNUJGV2c5ZUJWQUp5ZUJBdnNLSE45bGZmTW1BWFh2c01BV2Nnd0tUKzdS?=
 =?utf-8?B?MzZkeDJyeEo2QjdzaXExdUhSUDVVQmc5aGpBT2puWitreVZYVU1uUURDclZH?=
 =?utf-8?B?NCs4MkcwR0NDOVhVeFo1dFV3M2RmV3lsb1F1ckg0UEtxZlN1YStxNlNiNnBS?=
 =?utf-8?B?VG5ZTUZoMWxSVDViRFNnRjRXajQvNEpWMVNmbWtGNm5qVVpoZ3lUOVNOWXov?=
 =?utf-8?B?QndmTWhEdVliNlNlSVFKMXdXUHlNUzNZeTJuR1dQUGpvSXkxcDVydnlIWEVX?=
 =?utf-8?B?L2Uvb3kxSEplemhzc2VHRnlhTUFnM1p1c2w3ZysyVm1RSWRSM2RtS3VqQXhr?=
 =?utf-8?B?aVJvNTJ3QzAwaDlldjR4NVNTRCt0TzJnY0IzdkZWai96VWtXVk9YZy9nS2dK?=
 =?utf-8?B?ZVhYUWNRNXNCeENIWjZaWFdLWFZmZU5uUmJ6TGVpZmNta1A4aFFaWGQ0bFls?=
 =?utf-8?B?TlRBM2JkZWYwVFRBbzNkdmxiV2J3anBUZFkvSVNIRVFWZjhqZ0l3Z1BWdUJV?=
 =?utf-8?B?N1dpM2ZrRUtjNVoveHRYNURNTmp2dk9wNWVBYThZQ1hiV1RHcnBsRk9XT2Fx?=
 =?utf-8?B?aGpwdnk5YVF2dkZ6L1NONTd2RnY3cDR2NjRwY3VBL1RFV1dsWFdjSjI1OWMw?=
 =?utf-8?B?eWxqekJrWmhrYVVSNklYS3JPd1NBMEt1STZ4aWNmMkx5VWMzR3k3ZzROUk82?=
 =?utf-8?B?dDdsTEp2U2cyU2JVdHFQNHBqdXRCK24wdGxWZk1QVjlaMkJHd09HS3BQSzUy?=
 =?utf-8?B?T1UvUXpRemJ1NjFYWFlPODNrdVp5WjV6Vm5vd1RUVGIyVzdCQytRKzJOUVVY?=
 =?utf-8?B?eXFhL0ZSb3pSM1d0VVpLOE1qYXdOL0FSUWl3eHdjeXpJakU5UUlOK3RZSWNi?=
 =?utf-8?Q?wtfWW73/awJGVT8eGBYptASzr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rGFW3Dtye92v7stbxwcu2BSqY9vpjNKmJTmGDr6GursimkNSJOGmy7Lzck8OITakWvZEQ1ZDm0iAkMhhJdUPglm/04uOHzpURV99onfmD3s6fPHiOLSwuXALQ9fGAR2M360Mu4lVDU4iJ2hJbqRwrm+V0G6qAOwRoIgvZpkKMaJ8DYACzLakZwf1JqNpmTbOx2fqXvXEElVeeaat+/EK1WbYu73wiUf7zO5AxLxisTr6XqUU5PBr4p3od6Ol+CPMdTr0o7h52yoBc2TRq2YDpmt5/ZAreJvkl9jGOXUSWZoyPaOHR79OEwy2Vt1WiW0YxgimQLI1pKDXEwgMk65gprDJR/5HrTlwWRk5wrmmvJEJKuNyP1FCiZajHnVmOEkmbv9z7WG/fBOni4vBE5q8TXFaSpcUoawaxCjC8HrIA22asm2C3AF2YRmSKbG4MfbyhITAzOrfE/+fTAJuHzH0qagnBzAkwoLZjcTkNA6WbmagEge1bimZryFmAiyxkk6dEIP22uEsre7DHQd7qc6xar+HMYvzCbljr2k4tiXFxqktmdm4LSLccA1wcQMb/exj4pD6DgiAdA1Ic+hRS34oZ3ACkPZ71EDLP4ogb7/aXLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3366808-d1d1-4508-1d41-08dcea30af79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:10:00.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4BnhHAayLezzhGSd8HGd9THqyba8cEXvKZxk8g2Chj095Q3EGh19YJoHbmetiznqDzELE6jgfNvprx0+O7tSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_17,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110140
X-Proofpoint-ORIG-GUID: TRzVzcVb0SyssmnEd6KOYcjWy8WYN5uP
X-Proofpoint-GUID: TRzVzcVb0SyssmnEd6KOYcjWy8WYN5uP

* Jann Horn <jannh@google.com> [241011 14:47]:
> On Fri, Oct 11, 2024 at 7:55=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > * Jann Horn <jannh@google.com> [241011 11:51]:
> > > As explained in the comment block this change adds, we can't tell wha=
t
> > > userspace's intent is when the stack grows towards an inaccessible VM=
A.
> > >
> > > We should ensure that, as long as code is compiled with something lik=
e
> > > -fstack-check, a stack overflow in this code can never cause the main=
 stack
> > > to overflow into adjacent heap memory - so the bottom of a stack shou=
ld
> > > never be directly adjacent to an accessible VMA.
> [...]
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index dd4b35a25aeb..937361be3c48 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -359,6 +359,20 @@ unsigned long do_mmap(struct file *file, unsigne=
d long addr,
> > >                       return -EEXIST;
> > >       }
> > >
> > > +     /*
> > > +      * This does two things:
> > > +      *
> > > +      * 1. Disallow MAP_FIXED replacing a PROT_NONE VMA adjacent to =
a stack
> > > +      * with an accessible VMA.
> > > +      * 2. Disallow MAP_FIXED_NOREPLACE creating a new accessible VM=
A
> > > +      * adjacent to a stack.
> > > +      */
> > > +     if ((flags & (MAP_FIXED_NOREPLACE | MAP_FIXED)) &&
> > > +         (prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> > > +         !(vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> > > +         overlaps_stack_gap(mm, addr, len))
> > > +             return (flags & MAP_FIXED) ? -ENOMEM : -EEXIST;
> > > +
> >
> > This is probably going to impact performance for allocators by causing
> > two walks of the tree any time they protect a portion of mmaped area.
>=20
> Well, it's one extra walk except on parisc, thanks to the "if
> (!IS_ENABLED(CONFIG_STACK_GROWSUP))" bailout - but point taken, it
> would be better to avoid that.
>=20
> > In the mmap_region() code, there is a place we know next/prev on
> > MAP_FIXED, and next for MAP_FIXED_NOREPLACE - which has a vma iterator
> > that would be lower cost than a tree walk.  That area may be a better
> > place to check these requirements.  Unfortunately, it may cause a vma
> > split in the vms_gather_munmap_vmas() call prior to this check, but
> > considering the rarity it may not be that big of a deal?
>=20
> Hmm, yeah, that sounds fine to me.
>=20
> [...]
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index 0c5d6d06107d..2300e2eff956 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -772,6 +772,12 @@ static int do_mprotect_pkey(unsigned long start,=
 size_t len,
> > >               }
> > >       }
> > >
> > > +     error =3D -ENOMEM;
> > > +     if ((prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> > > +         !(vma->vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> > > +         overlaps_stack_gap(current->mm, start, end - start))
> > > +             goto out;
> > > +
> >
> > We have prev just below your call here, so we could reuse that.  Gettin=
g
> > the vma after the mprotect range doesn't seem that easy.  I guess we
> > need to make the loop even more complicated and find the next vma (and
> > remember the fixup can merge).  This isn't as straight forward as what
> > you have, but would be faster.
>=20
> For mprotect, maybe one option would be to do it inside the loop?
> Something like this:
>=20
> ```
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index d0e3ebfadef8..2873cc254eaf 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -790,6 +790,24 @@ static int do_mprotect_pkey(unsigned long start,
> size_t len,
>                         break;
>                 }
>=20
> +               if (IS_ENABLED(CONFIG_STACK_GROWSUP) && vma->vm_start
> =3D=3D start) {
> +                       /* just do an extra lookup here, we do this
> only on parisc */
> +                       if (overlaps_stack_gap_growsup([...])) {
> +                               error =3D -ENOMEM;
> +                               break;
> +                       }
> +               }

Okay, so this part, before you were checking the next vma.  Since this
is only going to be run for the first vma (vma->vm_start =3D=3D start), we
can probably move this outside the loop and just get the next vma then
move the vma iterator back (see notes below).

> +               if (vma->vm_end =3D=3D end) {
> +                       /* peek ahead */
> +                       struct vma_iterator vmi_peek =3D vmi;
> +                       struct vm_area_struct *next =3D vma_next(&vmi_pee=
k);
> +
> +                       if (next && overlaps_stack_gap_growsdown([...], n=
ext)) {
> +                               error =3D -ENOMEM;
> +                               break;
> +                       }
> +               }
> +
>                 /* Does the application expect PROT_READ to imply PROT_EX=
EC */
>                 if (rier && (vma->vm_flags & VM_MAYEXEC))
>                         prot |=3D PROT_EXEC;
> ```
>=20
> Assuming that well-behaved userspace only calls mprotect() ranges that
> are fully covered by VMAs, that should be good enough?

mprotect can split and merge, but I think the side effect here would be
doing an earlier lookup in that rare case.  And it would only matter if
we were not going to split, so vma->vm_end =3D=3D end works here (since
splitting means the soon-to-be-next vma is already validated).

Annoyingly the merge will re-find the next vma.

>=20
> (I don't know how you feel about the idea of peeking ahead from a VMA
> iterator by copying the iterator, I imagine you might have a better
> way to do that...)

vma_next() maps to mas_find(), while vma_prev() maps to mas_prev().  A
valid operation is to find the value then go back one.  The maple state
will do the right thing and return the state to the previous entry even
if there is not a next entry.

All that to say you can probably avoid copying the iterator and just get
vma_next(); then move back with vma_prev().

There is also vma_iter_next_range() and vma_iter_prev_range(), which may
make a better choice as the next/prev range will either be NULL or have
a vma that touches the current one - and that's the case we are
interested in checking.

>=20
> > >       prev =3D vma_prev(&vmi);
> > >       if (start > vma->vm_start)
> > >               prev =3D vma;

