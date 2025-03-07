Return-Path: <stable+bounces-121365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CADDA565C9
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD233B5050
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D520E01F;
	Fri,  7 Mar 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dQL/FHrR"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03801502BE;
	Fri,  7 Mar 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344771; cv=fail; b=DR3o6eXhOdhuOxS+KUyMuiWZBF5PHi2L5kxA5SpyfyzPcUNLxw4yYEzzjkxy6qCVv0vDqAqVNlBdllhcyQnag1NRKWjyeLD6g3TaAMaBO4lg7+Zmkl1aU9w8zuFYG25P6JK5SdL6nnzIJ0Kq2xOuD4bSPYT+xr0EuRMyUknVk/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344771; c=relaxed/simple;
	bh=qbl8eq/qWz0y6YxlseM8bw10qPpR/4PCdBKIFxqcliA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5zmHvkjQhLlnjGVM0DtPmXSAQhklPUKV5EFzHpMsaxSkLtiY9W3bTk2/Wu3y/MV07bD5fLUYywb0og7shfpE6SfrKOUYNJOFlWN4ay7yA/nCM3dZ7rs/xMeYLmV5BvgzoSDate349dERY50xlB6ObxvxYc0hjzo++cp+OGEwII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dQL/FHrR; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H51o6A/7bQ3xIAJr0dV5o/UbzkBFVn+Wezv1LynnHYUxWOoV3rtVFSQafKYemUwvFrM2iZxD1ybtqWyrQUexfYbTMrsQZJzgaH9kbGgfLxC2fDS87Bnf8wmxMzXx4dqsSyMb3E/uEGRt5SDuhoaIOp+1oy1AL+MaB/GSoVlqtTkIc3wRdGyn999novR0ngxxsKW8INnVbLOeZUP8vJQJzab9wsKDRW+WrzVNAtmXDN+gUMsoahBPAuhmsGdADKf8kOXBjpVB0HswV/gPaTSAQ8neuol+vDL5g2p5Qr01WwzKW/rHL9AzsNP/OBQevk2EQa6JgjZ+9DWf16wY/Ozr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vUWoYBZOImRyYw4DsB8n/DHuNGiGYd77qF9WiHL0ng=;
 b=fR+PDVs4ZTIlK7MtI55WKoOURJYoEf8aI703gu6AacNXPRPCyQ6DZGzMhBVvntA11/IETUa9VIQ4wE1HyNysdg58aoxgZWUAN17Jd/Jo5R+0k3ksfV68CNg5veBsWYsJFWcP+/I6C5YgwCNM05B3jMLaDMLgTGnPnrH0Z/XujLMMwl/EMDY0Bt9dkhgcx/n30Rf40KKnTpSM1jX+h8puMsaDe/A+8RsMe0RHHsnhVBeZE/BopMSCAYhd8rhMrNaqD20K2idI8SPqf7sX2Ij6oVgj3bjIFhMJOhhP2LN498xOLf+fQStFxSWZKHUf2dlfjMZ9cpMVRCK+oWBguQWcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vUWoYBZOImRyYw4DsB8n/DHuNGiGYd77qF9WiHL0ng=;
 b=dQL/FHrRyXZsaTbC+TU7OxDsMgDI+GMKn3jSAHU8C6tJbOq4YTiXnAF03FS08qj/hoFr5ReNH/6reWgjR3OH8n26dpeKRmOgE0pjHpndv3HpZYYJFlrIkoeELRVY57qeRrfVARtFm2VDhIHXl58Dy//7k5FaCa5gCMZruKkDf/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 10:52:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 10:52:47 +0000
Message-ID: <d9d5a244-10c3-4e49-91d1-2b7de71bdd5c@amd.com>
Date: Fri, 7 Mar 2025 21:52:36 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] virt: sev-guest: Allocate request data dynamically
Content-Language: en-US
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Ard Biesheuvel <ardb@kernel.org>, Pavan Kumar Paluri <papaluri@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
 <liam.merwick@oracle.com>, stable@vger.kernel.org, andreas.stuehrk@yaxi.tech
References: <20250307013700.437505-1-aik@amd.com>
 <20250307013700.437505-2-aik@amd.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250307013700.437505-2-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0193.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d6::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f08ad79-6daa-4b5b-486b-08dd5d663246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkV6dm1LSXM5RldUQVdyQnRwUzI1N1h6c0FKQ25pYU1naU51dWtNRTlET2FB?=
 =?utf-8?B?QVFUWnRHaksxcXVudEhGV0YwVWpqUWJpcnBiVTRmTHNjMzY4WFdlbzQyMlEx?=
 =?utf-8?B?TTdJQnI5enRubDRETk4zQzVzN2lGdjhwQUJTZDQ4THhJaTNTZjlZTVZZRitF?=
 =?utf-8?B?Vi85RXpFYU1BenM4MVdsQ05QdUphSTh3NVJ2cXY0TGlaS3VXT01GTmlVeEl1?=
 =?utf-8?B?STEwN3M3dlJUQ2RTRStNU3FNZnl2ZUgrSjV3dnFPYnMrZ29UbmlNZ0VtTG9X?=
 =?utf-8?B?N2V6Rkx2T2NSM0J1cWhnQ3lBR3lZV0pIWHc1YWRmRXFqay9WK3EvWXVvbEdX?=
 =?utf-8?B?Tm5QdVpSbHJYcWg1K21oWlUzMm1IbHZrTlBXZjBVaFpOdEowYTVaNWYzMVB6?=
 =?utf-8?B?Rmp3RTlONkNIMTErR2NQdEF0V1QyL0p2V09aL3hXY1dWMkt4am5GOGlYK2tj?=
 =?utf-8?B?VCs5RHdOQ2k0UHdjbFFqbmNYT0tvbm91VGszdkE5TnJXZzlRbVlUZHhKNzZU?=
 =?utf-8?B?ZTFMUloxU001NlpyWGxSclR3NVU2K3pUSE9qVXRrMFBBemJraVRBKzVrL0hj?=
 =?utf-8?B?RkhrWG1oUGVNNU5zdDVieWhyTHBIcG92Z2kvZ3Qrc1VFZXJPbU1sMEpxcUxJ?=
 =?utf-8?B?NnQ5RytlaXpSNmY2TmU3SGVyS3A1TWszMzRRUXlQZkNkRHZKNmFTZGE0L3BV?=
 =?utf-8?B?RnJTV0pzM0t0SWtZamJOemVmM015dmN6UWtoNWJ6Z1VqMU9aU1MvT1FmbWlT?=
 =?utf-8?B?cC8zazNqUEhXNk16MVNUNFZVSGtyd1daWUp5ajJ5R1VDZVdtSVNxUm1ZYlNh?=
 =?utf-8?B?MktKa2JaMS93SDNkeFZ0VGgvbDNITXpmdFl5RkZWOVBRRmhhdGw1U2ZhdmZJ?=
 =?utf-8?B?YkNBRkRhS0ZldzViUWl5Uk95K0Q3MTFieFR3c1RyeXZXcU5lUlpRUy9YdDRV?=
 =?utf-8?B?VmNqVnFLTFlsa3h1eXYzaS9Eb0EvTjhjdERtUnZlUXJ6aUJNaHdXTDhFZitL?=
 =?utf-8?B?UDFGbXBUdFhVSmRNa09BRFhMMFRDTWNONDVZSFFhV0NlaGtkampHOFZDT2Mz?=
 =?utf-8?B?TXQ2TnJHdVhIZGJ6cHh4d2FJQUJtY1puZ04rY3djVjZQeUxjT0xjdEpaUHNK?=
 =?utf-8?B?dlZKRm9pcE5mM3hLNGoxc2J4L2tpNXA3REVHNFJrVWh6eTVsVElZclQ0dEs5?=
 =?utf-8?B?YjBxUDBRRkQvcEVTRk5OSkY3M2d1d2IyRzlNcTNVaGs1eHNBTUtpWjYzMkV6?=
 =?utf-8?B?ZVFtMjl5a1hlRTRFU0RGb3grYTh5QWtSaDRkU2t3TTVYeXdTa2xIenV3SFEw?=
 =?utf-8?B?VkQ0SWVYSGFJVE1vTVBUbTVBUXZLUGFBM0p3TmNNVm9HcERJZktZdTcwYmc3?=
 =?utf-8?B?NlpXMHRabXFNSnhwK2hBdWxkNWZGZHkyNDhWOVltbmhXZ1hqQjRUZS9Jdm95?=
 =?utf-8?B?bnpPRUZmZVlGKzFzSHhKTktxWXF0WHJ1ZDZqNFdOU09HTWJDMm41MzJwUFhu?=
 =?utf-8?B?SWE0RzBWOVNucVV5VC92UjJDdFI1NVFNWk80Z3E0eGNlc0pHTEErcDlpL0tK?=
 =?utf-8?B?L0tycHkwbnFSQ2FvOUkxdlhDMTNsL3IrWWoyV3pnQmZhc0ZIYjI2VG00ZzN1?=
 =?utf-8?B?QU95SkVrbFhOUHdQSGkwT05DbkowaktUL1kwZzRuaFhRbEdPOEVQdmdGUXd4?=
 =?utf-8?B?aEk4bGhVZEZFVWJMNHgzQ1RKaGRTSFdmV210dTdESkpEL2Ribzc2NCthdm1l?=
 =?utf-8?B?MnNQVU93UUJKdVZWSk56Q0ExekQ4OGoyWVNJajhWRXdQSGlQY2tOWGlqMzBP?=
 =?utf-8?B?RnZhYnRMQjZnQnh0OTV0RUcrQk1zVzM3Zk5QWUlFZllCTituNDZGMmFhQ2Js?=
 =?utf-8?Q?f7k08hjM3MgRr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sll5WXJoNmZ4Y0tSNVZJc0hUUUhybUVqd0N3Z1Z3NXAxUi90QmFoTTJ5SGJB?=
 =?utf-8?B?Y0hTeUJYZ29ZRFVvZlorWlZYQVJ4dmFFNm1QY3RRbWV2Y0JMYm92WU1ZVkc5?=
 =?utf-8?B?a2Vrc2dOTUU0WFIxTVlYZy81R0lKU0RhbnpyNFZKUEUzQ2NiOU9IeUY0Q25J?=
 =?utf-8?B?dEsrYkkwNTBQQ3JWWGVBb0V5S1VqS3NjTDJTcmMrdXpTMnlBUWE5KzdhQmpz?=
 =?utf-8?B?TnhobkozdnFSczdBRVR5bUpYS0pJN1FXWVpwSTljVFNEL3FtaFBLekZkMGt0?=
 =?utf-8?B?QzdOT2tlQ21mMW10Z09jL0lzWlhkUEF3ek5ZdXRuVC82NkNrNkFtWWFTRllV?=
 =?utf-8?B?aHcrU1QzUmYzaEx1aHZYdlhnWk1VVVRRcERVSUcyN0hkVFFINDU3MmxhU0s1?=
 =?utf-8?B?WGhaQVNGTUpKN3QxNmdjYlhaaFUwb2RVUk1RQWZUVEJvbUVRNlRBUGVnb2pu?=
 =?utf-8?B?RmNVYjc5TTFmdDdEY0dIMytUaVlNQ0JMNjlCdndaYlY2WXJVMC9td1pJVEJz?=
 =?utf-8?B?S2U0S2lFVnJjUStOdkZtaENqU2xjQnlNcHVFQjFHcmJoZXZKTDBvWVIvU2xD?=
 =?utf-8?B?VUVMcEVTMlF0eHJrbFVpL3V1eFRYRjdCZzFQS2svSGJobEpjL3NiTURnMFlN?=
 =?utf-8?B?UlBKN3NUUFRUMWFnSUpjbGxQblBMUDc5aVNkWmVnbFkrTU5SUzAwQXg1NFZ4?=
 =?utf-8?B?UjNBa09XY3ZLcys3eGFFejk2QVRnSjhhYWhISHMwMml2c2hsKzYwS3o3cjJ4?=
 =?utf-8?B?Q0pGbEpWZitmbUZyckl4M3pxWE8xdVNvcW9IUlpyU1ZOMEU5MTIwWS9QUU1m?=
 =?utf-8?B?NlNteENVeFBFeW1OY1h2TUNGa3NTajZ3M0w0Qm4wMUlteUZsaUpKZE9ZZmJm?=
 =?utf-8?B?RnM3YzkvQjFSWUVBMjd3bWZDMjVxaFIydlMzV2dwdkRJeHd5TFR0elEyeVVI?=
 =?utf-8?B?VjROZjBKQVcxUlBIcWZud3lmWnd1cDVDbkFjaUNwRUZYeXAzbWZ2UGovdWd2?=
 =?utf-8?B?ejExL2ZiWkp2c2xCanFnTWNnOTJjSURGaWsxbEFVVmhIUnZuNkZjRW40eVRM?=
 =?utf-8?B?NXJKUXZ6ZVZ4enV5Q085NWxBTzNtWi9oU2I3b2hSN2VLbEFtdDVsZ0JQUXlW?=
 =?utf-8?B?OEtUZ3pJTTZEUUg5OVdnV3pYNXFrZEx0TGVaSHRuMmFDNFRMaFFTQllJMk0w?=
 =?utf-8?B?dDdXK3lIWVlsVU5yUk9abHlXbGJHY2Y0WTF5VG5PajVwUlRGN2Q5NldIMnlk?=
 =?utf-8?B?a2V1alBOOWpsaWdSU2lLQ1RxbU1MaW0rbTNBUVdNNGg4c1YrZVE3djV1aGdH?=
 =?utf-8?B?WTdJV0NNNnowMXptaHpUUW4rWXdBV3dyU1N1TWVmZWhaMG1OaW8wMkxmZ3Zl?=
 =?utf-8?B?SG9XRFVPbUZNdHN1Wm5OWHpCRnFyWFdLMURGWEJWLzJ3RnJKTFJVbnYySUVw?=
 =?utf-8?B?QTF0Rk1RK1FxMStEendzZDRDaEVzSWZVZElhOEhjbFpBNEh4V1NjeFc2OTZS?=
 =?utf-8?B?MFNzS3pEOHFLWGRQdFRHdUFadEF1TUxBU3IzZWYzRDRzN2FZNDdNSy9MNi95?=
 =?utf-8?B?VXpiVTNBNVg3cnAwaG1vVDYvRUpZKzdGUVFSb3MxV3JMbFdMc0pncjJWVnVE?=
 =?utf-8?B?NVh6Z0tzYklSYWIwYjdDQlZBekJMMUkyOU9tY2tqb2s0aWR4SDVKYWZVZDMy?=
 =?utf-8?B?ZzZvSkNnNGZuQXZML2s0RTJVZGxFMlcxeEZmMjhsWkFkdlBpUmxMWlQvR01T?=
 =?utf-8?B?cDF4eUZ6bUYxSm41bGR1YzM4TTFmOG9FTDRlUEtTZTNkMWVPaVdjZ1IzVlRz?=
 =?utf-8?B?NUtTT1BNWlJITXJ6R2xRKzJVN3FFNGxsaGFxUmYwRzNMcXdISFNVeFZ6dnRR?=
 =?utf-8?B?NWFmWVlvcWQ4MUFpQjFxSHpSVzc0VU9iUlI3cVRXcGxyTEdyMTd0cWMwWkhs?=
 =?utf-8?B?SEhtMkxQT0Nod0duZzBWWnVWdmhuK3JsMzJlcWpnOU1vMzljZloyQkV0Uzhz?=
 =?utf-8?B?cmRSVGQvbFdQajBTQ2ZGVEFPODFTQzF3aWxZQjdOaG82SmhlQTh2NXF0MkVR?=
 =?utf-8?B?ektiUlRXaE1HUkNkS1Zmb3FkMFYybmpUOFNpUDBaZGlzRU5BNzJzcjFYYURk?=
 =?utf-8?Q?sWH4FXu87P7lls+BRVFDn4jPh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f08ad79-6daa-4b5b-486b-08dd5d663246
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:52:47.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fgDjVepXwMWPzojAT4i5DFx2DdpRVsh9zzudUPpbOHCl9cJ6eSA0nJKA46v4l9/aJ4yy7EdJqun85pjD1YJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863



On 7/3/25 12:36, Alexey Kardashevskiy wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
> mutex") narrowed the command mutex scope to snp_send_guest_request.
> However, GET_REPORT, GET_DERIVED_KEY, and GET_EXT_REPORT share the req
> structure in snp_guest_dev. Without the mutex protection, concurrent
> requests can overwrite each other's data. Fix it by dynamically allocating
> the request structure.
> 
> Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
> Cc: stable@vger.kernel.org
> Reported-by: andreas.stuehrk@yaxi.tech
> Closes: https://github.com/AMDESE/AMDSEV/issues/265
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>


oh. forgot:

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>




> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 24 ++++++++++++--------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index ddec5677e247..4699fdc9ed44 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -39,12 +39,6 @@ struct snp_guest_dev {
>   	struct miscdevice misc;
>   
>   	struct snp_msg_desc *msg_desc;
> -
> -	union {
> -		struct snp_report_req report;
> -		struct snp_derived_key_req derived_key;
> -		struct snp_ext_report_req ext_report;
> -	} req;
>   };
>   
>   /*
> @@ -72,7 +66,7 @@ struct snp_req_resp {
>   
>   static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> -	struct snp_report_req *report_req = &snp_dev->req.report;
> +	struct snp_report_req *report_req __free(kfree) = NULL;
>   	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
>   	struct snp_report_resp *report_resp;
>   	struct snp_guest_req req = {};
> @@ -81,6 +75,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
>   
> +	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
> +	if (!report_req)
> +		return -ENOMEM;
> +
>   	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
>   		return -EFAULT;
>   
> @@ -117,7 +115,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   
>   static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> -	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
> +	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
>   	struct snp_derived_key_resp derived_key_resp = {0};
>   	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
>   	struct snp_guest_req req = {};
> @@ -137,6 +135,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	if (sizeof(buf) < resp_len)
>   		return -ENOMEM;
>   
> +	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
> +	if (!derived_key_req)
> +		return -ENOMEM;
> +
>   	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
>   			   sizeof(*derived_key_req)))
>   		return -EFAULT;
> @@ -169,7 +171,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   			  struct snp_req_resp *io)
>   
>   {
> -	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
> +	struct snp_ext_report_req *report_req __free(kfree) = NULL;
>   	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
>   	struct snp_report_resp *report_resp;
>   	struct snp_guest_req req = {};
> @@ -179,6 +181,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
>   		return -EINVAL;
>   
> +	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
> +	if (!report_req)
> +		return -ENOMEM;
> +
>   	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
>   		return -EFAULT;
>   

-- 
Alexey


