Return-Path: <stable+bounces-96204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE79E15E0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F9B227C3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34A1D7989;
	Tue,  3 Dec 2024 08:34:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776191BDA99
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214880; cv=fail; b=eAr1oftkPMhGgm65K5Jp5SdF2/QoBTdqjtW8kzHkO9pEwvJPdKBMuKn5K3xuRP92M/QBnTb10sA2cqZtmFNxI9wQOYF0qs3COY1Px/ZyY4sNcrrefR4OQJM9C3Hwls3UsURk6XDS9fbka04HPGL3Rlks7FZ2xpJ5QJEKcl6bFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214880; c=relaxed/simple;
	bh=UTaXVLeO6l3tdrtvsIHYBR4CslQbraglZ7OsMAf+CX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuRKhVvzkKbQXX4O5peCBnK44BEX5NiiEwGw+v2gJt0pcNSINUPYROixDLP8OiSwax6kJidZe8D2TQ89Ar1zFFWAN9nAODBu2hGWS2R18StU2jMbnWidhv7cNfgD2LBh4Fk0u3Q7a5qDXW60y+G4TBfRbJ6RBlX63Oi+jtP77Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B36T47X003928;
	Tue, 3 Dec 2024 00:34:36 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43833q2n5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 00:34:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLRWtSl26ymuD8xtSSXjj3//SiUhbL9S6zeBMEo0+5IRl59R4tJloq41B6UuBvCn98Q6hgTwxEoQvJZW5CyCjA1ajOsXLXx5aqzDbP06EVW2H8T1zle+vwd+JjK/h1H3M9v2ySwgAjfuq0LeXTmVGxHP0tFY/efgb5EUq9eH2Y+a/7ZlS8hFD+k7642e7j/f4UZ+zt/JgKHJdcFawYdMzdl/3NMI8E6iM3g33e08LCU4IzHVGFiGANWab31VdDFD011wPRDkZH4UxmbxRVvvirBgA83CkbXwezxNEjRj/YU0WKRO+0Q0Wl4JgUhGFgE2c+mjBvgfQotdIssJZp1koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXLAB1/0GZjC+xc+CX6s3iJCAFxVHDU8W4mLvcnO2tI=;
 b=dYhBim/826zCoZNauVpv//nW+ADgTneNaMstgd8EkN+HPc0HpBwCjUxpLiEbN6E8HTRYRHYsR/sdDlyqIcZtJ+fKWM+DguDjS3WW9Mz04wbRB2wAfH2PcOfYnuuG1/DHt7yyaEOt+cDxpeMO30iUYneu8HP2ixYH/MVivRkH/YmmKUH8CjwZjrru1f4C5egON3q6sLyyEqHpC1iJAGJyXM+A2qik43OJq5Fqif+yFdSlbDyVTn7Ao91BCPIvTHpKRkxX0YcNJiXdzVxEyhvTpJq8YA7E58Dfa/XA9oMgqvVhV+ZFMRK5xVGQSPc9XKMgDvcJHN4NW///c1GLGotB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:34:32 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:34:32 +0000
Message-ID: <1674ed4c-1e86-4d7e-8840-3b7d14f9987c@windriver.com>
Date: Tue, 3 Dec 2024 16:34:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] crypto: starfive - Do not free stack buffer
To: Greg KH <gregkh@linuxfoundation.org>, bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org
References: <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>
 <2024120340-vessel-pelican-1721@gregkh>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <2024120340-vessel-pelican-1721@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA2PR11MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8462c1cb-d765-4579-96f7-08dd13754f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxHZWhVYlFmQ0FRSUVhSnVXS2VYSzZCMnVmaE91WXU2am1VZFkraVZGR09S?=
 =?utf-8?B?RmdUZnVjSjN3TlBJdGY0RUZ1V1hWZFZFM1g2TTVYVGdITDR2Qk5FMlVGM3h1?=
 =?utf-8?B?MWhPc2R1cXNwUjFLeThMRG40SU9QVVNkTFp6KzlKelRMQWpqNm81a2ZsSC9O?=
 =?utf-8?B?ak9CZUhWTjhnSzlISXQyRDN3azhxbC9CT0NrU0ZmMHBXYmEwMEwrTnVkV2gv?=
 =?utf-8?B?dVdoR2laZVViQ3hHMlI3YmJ0cHVTaG5ST1pSUGlYbTkzNFB6YzNSWFFwRUNS?=
 =?utf-8?B?aFFLMWxYQmpqbWhZK0tXZHluS3p3M1dnSUlOZFo3dEhWQTc4dVljMkowTUpC?=
 =?utf-8?B?MjNJVnZOVUVtMWNEamNUdCs2cVhqS2RpTk42dWF2NTFGOGZoUkVqQXh5Tnlv?=
 =?utf-8?B?Q0trNk00NXRuRGtoN0JseHZWKyt2amxBZGJPYUtLRjhzL1FoRlVvcElJcXZH?=
 =?utf-8?B?eWRJdjYyZnVOenBrWWgwbjNpdGxEeERXYmRhM1pWT2ZSYm80ZEVOZXJZYzZk?=
 =?utf-8?B?S0lETnJCTzJWMThONGZKWGFaR0tka2dHVXN6ZGxZbDJDR3pvZmQ5VGRHUXBH?=
 =?utf-8?B?bkZWYjk5aTM5T29MdUdCS0hDV0dOaXlwa0QvZEgyTVZjeU8wSDhWM1RBeGxM?=
 =?utf-8?B?dUdOS3FXRWxSODdnODdaZnAvZDdDL1pIRGJ6Rnc1Z3hwNldIZStOVzNBb0Z1?=
 =?utf-8?B?OGpITmxMdC92ckNWZ28yRzc2dHdoTmJHZ1ZHOGt3QWtNV01USjRYMkNTeFZ2?=
 =?utf-8?B?bTk5VHM3azNMaGx1dFZzOEw1N2FxKzh4Ti8xbiswZUczcG5RbFpJSitKMjhN?=
 =?utf-8?B?WGVyT1JjSnRZUnNhRHhBT0JtUnd3VlBrMzd5RmdhTzFuTCtidlY3OSt0eDRq?=
 =?utf-8?B?ZExqRHpzb2hUY1lseUJWQjNvdDh3a21pdStJNDlvL2VQUHBvQUYxK0VJSzIy?=
 =?utf-8?B?R3hMV2pVVGpoUVBLUWVYUXE5aUtYdncyQ2FpUjdWTjVTRkg1WXU5TDFCTk5D?=
 =?utf-8?B?V3U1RFFHMnUrUnZJK2pQdWkyWjNMc2RyaWY5ODVJN2xBL2RQelBQK0tJMDhj?=
 =?utf-8?B?ZGFKWkYrTTc4aVpBbERuYUVhbXlucmlNdUlnd0l0Vk5lbk9GVk5ETExEaVBK?=
 =?utf-8?B?TFk0SEdOMEFQamZ4ZWo3NFJiTjQ2dE5iak1neU5SRHhjeXZpeTNPUndLKysz?=
 =?utf-8?B?NjZTNGtpUHU5WDRVdFA1Wm5zdDJEMmtGc09CMExtSUFEQnJNakhiOFFPa2xU?=
 =?utf-8?B?SktzZ2NkajN5RmZrUlBnT1YyNGpINUVlcW9CcDM1Q3dlWFdjNXJwMU9uL1dP?=
 =?utf-8?B?Rkhsa205T2w4eVFjWXU4YUtIb2l5Z0ZjbUovRm0yNmNkVmNmU2Fqc0lsbS9R?=
 =?utf-8?B?UDFBNDFzWDNIVUFWS0VzQWVKaCtleUNMWWoyb1dPOW1xY0RnNkVnOEJZSWtQ?=
 =?utf-8?B?UEFGQlFpakFpbnJ2TEtYUDdOY0V6WkhPeG1Xb1BYYk1FSHp0QlM5U01xK3ZQ?=
 =?utf-8?B?ckFHMitQQ3lSUnltdnhxVnFVeUh6czlFYVM5RDY5Yk93dXpKbklhTnJLUGJ3?=
 =?utf-8?B?QytiZ1lVQll6akE1NzJwZEZKVDFOZzNxcExhSzFUc05ITkZPa29BQVJNRHFF?=
 =?utf-8?B?WEtzQTBwUjM0V3k5S0VCOXJRMEZjcnZGZmpkM2gwWkFXbkU0OWdva1lWSDVy?=
 =?utf-8?B?MHpEZ3V2d1hBaEZCcHFUQkd4cktEcTd1Q0FKOThvY1RoUTQ1ZDcraTNyemJj?=
 =?utf-8?B?TXJKcUFUbGc3ckt2dzdxSXlkS0c2ZURpR1BMVnNjRHJ6ZUNYYzFiTjBTOHJ6?=
 =?utf-8?B?anNkR25uTFVTajhCeVVHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akQ5S1JJMDluU0N3RGY2by9VdlNuWnplbld4ZzM5ZWxOenNXcmVvZU1SOXFB?=
 =?utf-8?B?Z0RvcDlLamhrWlJNRFMrSWdPWlFaYnlGUlIrN0N5YTlxaWNhVVVxcHljd0xj?=
 =?utf-8?B?cWY4KzNaNWdPbUtVbG8wOVVPaVdYcWFtUVptcDFZOUZGNzlVd0ZxRS9IRTlS?=
 =?utf-8?B?bXlKNEM3VkJjQWtVdElnbUExRklPT2lCVFZVVU1sVWkxcDd3b1Y0NFVLYVpM?=
 =?utf-8?B?c25ZYmJ2VW1BV0pzVmsxUFdqNFhqSW5OWmVUSkxFMG9DV0dYTkpaajg1RkZI?=
 =?utf-8?B?dVVDdVFjcGZpalJtWHF6NHlYZ1ZFTWZnR3FvODJNbmxvZk93YXVmTkZNTFNP?=
 =?utf-8?B?QjNxVXpRQUQzeE9lcnpKcGtpekhmVTBmQ1RrT1FTZ2kwcE16TDFLamxWSk4y?=
 =?utf-8?B?ZlJXWjNSc1diUGlMZVl1QktiaWtnOFJxM1cyUS81eVVua0IvTGo4RHhXQVZR?=
 =?utf-8?B?RmF3RXdvUjYyYXFLRVNCUldLckZHQUpjQ3VKeEZsYnFDTWQ5NEVReTdFZ1Ev?=
 =?utf-8?B?TmwvZmZvZmk0K204MEtyUVVWTWEyc0doUzdEakhnRks4aklsZDlSakwrZHhm?=
 =?utf-8?B?b1Excmc1QVFCZi9zYXV4QkE4dmNRaHhsMUhibDJMMW5NeG92dU05WmhsM2NG?=
 =?utf-8?B?VU01blRDeXV2RVhUSkd6dklEd2g5dG00bTU4SjhObmVZcjRkVWwxbDJCTmsz?=
 =?utf-8?B?RGQrSFRyNVFJL3pCV1dHMXBEZ1plVjY4cXJtOHVib0FPRnZLcE5aOGl0SXRH?=
 =?utf-8?B?K0M1a3hta1BPbUsyMnRDRURWZXFKNWVQMks3U3l2RVpKSG5OYUdmdWRXc05u?=
 =?utf-8?B?U0VwRUVkZU5RY2o5Ti91SWxlWENTWnZGUkdUK3NNdEJtTFhkcU5IaTB2Mk05?=
 =?utf-8?B?YWpzN0tHd0pEbHdQdm1pK1pINjdNN2QvUmlFOWh2MWFSM0hXeXVtMXFZVEU3?=
 =?utf-8?B?VzJFM3NLVjk3Z0ZUeXJ2aEcraEx6NzdOWkUwZURMeXJUSFp5MERpQTdUTHJ2?=
 =?utf-8?B?aXVIVUFOb3ptUjk3SmlVajlpamgxTHFOd1loaEt2b0JrZHI1UmczVEh0Slow?=
 =?utf-8?B?cUlDV2dGRjBVWmNZaURocDJqYnhLVko3dnFFQjVmVGRaa09TdDRYdE9FQW5y?=
 =?utf-8?B?UyszZFNRa2JBVlVoWi9vd0lkL0hoZUhRcmZ5TDJmZ01QT085SUF4aVc4L045?=
 =?utf-8?B?ZGEzcjhUL2dIUG5RcDFGbWdFMzRpQkdQUnBrRVRDZ2xrcmlSUjhiTmo5YXBZ?=
 =?utf-8?B?Y2ZyeUVwMEM4dUc5RlBFRFdSanpCdDVvdWRrQlJUMHgwUjdXVXpnTmdhb2pK?=
 =?utf-8?B?bG9ZOTBFQlVHQW5TSlpZcUtZajdVamNGMGt6VjVoUjdOMFBabUR3YzUxRGQy?=
 =?utf-8?B?NWhLc2d2RDUxc25jVm85OFNja0pkNHA3bTRCKzFCcmgzaHNUcHQzNXVxQWZQ?=
 =?utf-8?B?dWRjWTZWdHVoN3FsbVZpNUJhY1Z4V1Rid2lwdXdpTklUV1o2blkvUTV6MTVM?=
 =?utf-8?B?dllQUGY2YzVoM01pTHgyZkhkdmlMNUdMdWFDSHg4RFNRbmVjb2NzNUhoUVdQ?=
 =?utf-8?B?QndwdFdnY0U1eTJlSFAxUWlveVpzcUgwTU8xekVPWXVDUCtGNm5KSXk3YVhB?=
 =?utf-8?B?TWZJQkRxV0lTeWFkTGhzZlRWZ0x3QnE2aGROL0Z6K1FTdklZTEFQOTNqQjQz?=
 =?utf-8?B?d0dqUVNtTEttZU44UCtyOHJ1aTNrdms4ejdTK2ZuNW5GajlmRHhrbDJMZWcw?=
 =?utf-8?B?VWs0NUJqd2plMnNlVlVSWUo1bVZkdkY0OHRTb1Z3SDZrTzdUZC9VMHBZMTI2?=
 =?utf-8?B?eElPVy80QVpOWVJUdXJyODl1UXp1cUxwOEdVRmhzTlZ5Y25vSTQwUUI3NFRa?=
 =?utf-8?B?RjdKY1NRVVRtVkk5bU1uYTV2NFRFOWNWZDYxRkw2UVYvT2RMaG9Yd01kU2VL?=
 =?utf-8?B?M3pvamRPVGlsUXBkaS85NGE0a3kwd1VSUTV2eXVuWFVoem0za3gxQkl5d056?=
 =?utf-8?B?Wjk4WlppWHZoYVcxVmF1ZHR5UGhpOVhPWWp1RjdqRUNrMnVGSEN5eFEzVHFE?=
 =?utf-8?B?K2hRVUtMWGVSbjNNeXdETTRyd3hYVXNBV2RpSUI4cEJqRTNkaHVROHFIT3Nv?=
 =?utf-8?B?azd3MExWZFBjUkE2cXhST2JpdzdvWkR5MFM3UDllS1BNQkNmZFRaOCtJUlRB?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8462c1cb-d765-4579-96f7-08dd13754f5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:34:32.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odgnUIrw/Wvhq8fpJMa539BGiVNCdhlX3qR7DNYCp5RHcqVPZU2qAWaR+UJLJCTEkb/DjNjLOTFD2hV00apTTD3McfpQ5k4ZnbXc2d0dTzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-Proofpoint-ORIG-GUID: KdCgrwn2cghBs3f51R3UBR0-XE21Co1_
X-Authority-Analysis: v=2.4 cv=bqq2BFai c=1 sm=1 tr=0 ts=674ec29c cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=Bq6zwJu1AAAA:8 a=VwQbUJbxAAAA:8 a=tKN3EHSjyOu_oM5FLGwA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=FdTzh2GWekK77mhwV6Dw:22 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-GUID: KdCgrwn2cghBs3f51R3UBR0-XE21Co1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412030072


On 12/3/2024 4:23 PM, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Dec 03, 2024 at 02:52:13PM +0800, bin.lan.cn@eng.windriver.com wrote:
>> From: Jia Jie Ho <jiajie.ho@starfivetech.com>
>>
>> [ Upstream commit d7f01649f4eaf1878472d3d3f480ae1e50d98f6c ]
>>
>> RSA text data uses variable length buffer allocated in software stack.
>> Calling kfree on it causes undefined behaviour in subsequent operations.
>>
>> Cc: <stable@vger.kernel.org> #6.7+
> The cc: says 6.7 and newer, and yet you are wanting this for 6.6.y?
> Why?  Why ignore what the author asked for?
>
> thanks,
>
> greg k-h

I want to backport it to fix CVE-2024-39478.

Bin Lan


