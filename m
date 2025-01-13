Return-Path: <stable+bounces-108531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D72A0C2BB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DC8167E37
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE21CB51F;
	Mon, 13 Jan 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bWFUT7fn"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33191BD504;
	Mon, 13 Jan 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801283; cv=fail; b=lVUL/8cBvtz68RTs4GCurmmlFdBFREqMKgNCzEusTBop3ySvX9VDc38mujnu/KN+7BPgOdYMyUjkqiZoTiOXbn3w9BsBIxBEkWTljNFtJWMlKRtcgBPQhEUHeoJWn12eLS1wODoUAUjegdt+b9KNoCDo/ceZQ/7b5GkYrHuQY/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801283; c=relaxed/simple;
	bh=H5sQ0nndxw+zhbCDlWiWW1Wtnw+/5ptF9+NcPQSwRTE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=F2cMtF4l/lY363MWrYDi07lqJNCWUZ66MqsszNDs85tji3NQuX2CnfVN4j14UlG++FgmMQUBIJz+FXs3FeVKwkl87ZG4S6HPfQ3UvQoMGffmV+nBiRy3r0C/hF18vbsZ76F/+4Sq3MejHKBwSQ8WhRMzIjZtmUrKCdv6ep1dok4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bWFUT7fn; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwTT47QB4Cm2rThgYbvlPYU6ylSrHW16H5MJpK7BEx41qWhK5kiJXJUZHxWoJSGAXjOv8fdZtO1+7FpQCLnasHbfblKyn89vw+FtxtAhWSDyfdl0LFJesjHuRvBdBXBU3F16WZwDNY67sf+z5EFJMDyfycST2KEJDHe5ApQthjV4RKqvlohrX0G0Nc4oAtciD7I+Sip+pfJ1DnU0JLB7CGJZLW/aE4M/mI61Hed93QLO1rh7bioLDlTaKgSya2jrUHxyUcknrE15zkjmLuWpK8iwcgPtNQp6lzn7wvgOicDZKwH4NTXnhbbtU4MmFIwkaCrPjaVo20H1v4Dv4zNltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlMNobTwNI3h9ZoeV9/izl8x75vYV8YfwWfkFB4w3h4=;
 b=rwWUTFxvy++QXFqkBQZjVeITRKnDx7iu1yBmsLW8QXIucb+SVI1B8jjFSmfp3o1jP1gJNypz1Iz6+yIG0PBK1yzC8bTQXORTPsR9YbfwYGatFA4KKQL5WCF8+zwxMWCbNz9nzNToDOQevk69Ap7AnT+H8eYJc3J/LRRGBI8ojRuQ7hfUkEqOoIyTslJXO7As4a/z6IKkkkLZl+aCg3fCoNhS0IsSN9hIRllbhdwxIgmNYzsfRk+UpjR9k3SPRCs+pRm6xFkCGWR1KJuo+TJ3uofb9t3Sh1PgiQXytWPh3E7sEzuJsTyRd8Wg08D5HdgHt09va4rlsfl4+Rs9ztU+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlMNobTwNI3h9ZoeV9/izl8x75vYV8YfwWfkFB4w3h4=;
 b=bWFUT7fnuQxl+45mNfrcX7dzptCLqYqvDFIQ43mIKcvowlgb9WbeDtwibxzsNbE6Wl3QMQERQfCvLOr5Mnd/Ra/JWxNmK9vn1qkVy12j8VHa7KTiwbhtxqI70N3RPVfZepiyr2zeHkcKNl/0vPyKF+aBoqMKJB8VePen2gktbLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:47:59 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 20:47:59 +0000
Message-ID: <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
Date: Mon, 13 Jan 2025 14:47:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Chan <ericchancf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Russell King <linux@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>,
 Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Ashish Kalra <ashish.kalra@amd.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
In-Reply-To: <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdd7677-84f2-4894-defb-08dd341390a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2xSQmZheGhjckQycjAvOElTUytqRmUyNmRFT3JNZEVDcmJZVDVEVHljc1Jt?=
 =?utf-8?B?NkY1OEF1RVk2MTc4MG44QWhURUFaWVdJdlA5aGFsZDl4ZG1iVEcwVjlOVjNr?=
 =?utf-8?B?YTV6Wm5vMGx3YTBrREo3S2k1TVUwclRrL01oOHJReE9wdVI3eUVsZTlrZkpt?=
 =?utf-8?B?eEd3L2xXMDF3b21qQytaNnppcXhRTDdlRXFMQ2ZQWEJsZlBmdGZPbHRNNm96?=
 =?utf-8?B?Zlg3TVYrTjVkMWpXRGZNUC91ekdhY2ZlN1VWRVhHTW9naGJ1YWNyT0ZzNDNl?=
 =?utf-8?B?SmVDL24vc0F2RFdJc0hxZFZUMzRkZzhhQ2J1N0d3ZUs3Y0RXY2VML2Rzb0lZ?=
 =?utf-8?B?QjNkcTd5bHlWYjM3MnpsYUQ3amdZS0t5cVVvcllqRW1vQmdwbkVLOFRSTHBr?=
 =?utf-8?B?V2MyTTRQYnJFQ0g2SUlBZEhFSXRTc0xLVHFNc0ZxcFY1Uys4ZlcxRmQ1Z0Rn?=
 =?utf-8?B?UWRzZ3crOFpjaFl1d1p3MzhtS3pHTGM2SFYxWC9JV1EvckhxbWVTQmNvR1Rk?=
 =?utf-8?B?WjdaNUs3ZHFOa3RsREZ5NHZ5MENGdUVUKzA0TmZHVnp3MEV0RTJ4TGZTM0Q4?=
 =?utf-8?B?Y0I4ZjFoSktveDRIUkkxZ0VGY2xHVHcyRzV4V3hpY05jQnd4RnAzN216QnY3?=
 =?utf-8?B?dU4wNG9odzZieGY0K0pGcSs0YnJla0MvYytJWmZtUHM2TUZqNEgyVHRQMUQ3?=
 =?utf-8?B?ZlJDL2U4cit3YWVIOWlhQTFLdlhBckZhY1J5QVBoTWgwSnZ3ckVsOHA0Zmdq?=
 =?utf-8?B?UzZJdmNYaWRpa0xJNS9QZC9Fd3loTzIzTWdQcnZySzJ5MHVva0JNM0RMaGdT?=
 =?utf-8?B?WW9YTFlLYUR5RkZ5ZmFKQ0RSdlFUUmNWYm0vOGpFY2FmcXJscUgzS3BZOHhy?=
 =?utf-8?B?b0I3eVZNR1lCWTIvRTVsY3hUZjJkZllJeDNGeHE0dnRlVFFFZktJUWEyMWxV?=
 =?utf-8?B?b1phMkNzWkRVUVJROHg3Z1VsYW1sTGtTb0ZMQS80ZWlqbFVnZjBXWEVxK0x0?=
 =?utf-8?B?QWdZZCtrUkxuaHJnNk1KVk03RGR1eEdCbHVJTklhMFY3ak5HN2hzREhPMXFv?=
 =?utf-8?B?dUZvTC9vREI4aGxGN0lMOGJ1cDEwTEZzM3ozeGprSko2VXYwVENmTG9sV1V0?=
 =?utf-8?B?ZGZDNjNsWmdUOFJxbFlDQmdnYjNDbDhsbVVhOFVCN3NRTTc3LzVRdjVBT3dy?=
 =?utf-8?B?alJqT0tlYUFIRDFSdmdmaytHVE10RWxFQWdpajludEJncXNzYzFqMzZMeGdX?=
 =?utf-8?B?MzZQeDhHOHgzbDZNanJ3azE2RjlXTUlnaThXdGlGSEVUbkxyVWxoRXRxb2ho?=
 =?utf-8?B?ME9FaXlNMEtER1E0YlIwZ1N1MS9mMVdyOW5zZ2x0Vld6d2w2dDI0Z0k1Y1U2?=
 =?utf-8?B?ZnYzYlVUV1hHdnNBWlQrcHpaeWQvZXRxNFZOazkrZHg3eHlqc2Rob1M3Q01R?=
 =?utf-8?B?enlMbGNJM1FBTjhLZDI3UExRWENBSnZyNExyL3dTTWN2VU0wOHVjM1JsbVd1?=
 =?utf-8?B?dGg0RUZ2RDFzbVplb2V3bGVDRm1POFp2MmMwb2pXYlVENk5aVitNTXN5SDNt?=
 =?utf-8?B?MDNTUWZkMDA1c3FSbG1qQ1BPY3hEdmx6VTVLSSswMm5WTVpnV2ZkTkhBNEEv?=
 =?utf-8?B?eDVVZzRDU2hpdTFJUUoxWmtET1pDbVlrT3U3bHQ5eXhEaGp5MmxUVHZPMFd6?=
 =?utf-8?B?Y3dDMlNMc21YN2k3YXpPeGVkaUdlbXE1ajB5ekRzVHV2Vm1pOXFrYWFhbUlx?=
 =?utf-8?B?MUdRNTNFb2V0VHlIL0cxZGtNSWpXN05VQk9mZTlOejl0MFFSeG91bUd0T3Ev?=
 =?utf-8?B?d0ljbTZQZWdIMzJrakJPeXBXUDF3VXlVcnpWUVdnazJ5SDVDYW1FWml2Qkpq?=
 =?utf-8?Q?I/HCVWzw69LFI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmhZMGVobHliKy8wM2U4VjkxWW1aVm9KOUdPRmJNVEFhdG1TVms4c0RIUzdK?=
 =?utf-8?B?RkFCZ0RqUWdNaVJTQ1NGcUJhVGdnaldHUlQwd1h2WHlHWEdQOU13N211T1Bn?=
 =?utf-8?B?dG5mVmw3NTcrVTh4SlZKZnhNbzdpQ2Zab3ZPYW1ZbG1qdzFtSllkK094YzJB?=
 =?utf-8?B?Y0VsSm4xVzd5ejM4Ung0eWIwb3BlTWlGSjA5MjM0TTNmSHJWaFFlZTFTYkpH?=
 =?utf-8?B?NXdBb3VwNStkbngwaEpOaU9HYzhKZHhuUGVwNWlVUkg2aDdPNDNuV01vZSt1?=
 =?utf-8?B?T0lhNVRndDNNTitMRGtLZUhvdTd4cG9vdndhMXdBelBxeXNpMW85eTh4YnVL?=
 =?utf-8?B?SjNTT0JtVDBxRFIrSlY5R0EzLzY1K1lPc2ZNTDBuakNycGhqeG8wTTJ2WDFs?=
 =?utf-8?B?UWNmVmNXV1dVMll5SldaUmdDRndmTjJEUU11VitBYkg3OW1KUlNEb09rbDZU?=
 =?utf-8?B?WTVFRXRMcy9EL1pVYlVzNmwvdVNkRkNxcHhIbllFMS9CM2xzakdJazRzdXg0?=
 =?utf-8?B?bDFpbTlnZU01d3A4TVJ1ejd6Wm81bDJPVllKV2VNNE9lcTlRekEyUXF0cXBS?=
 =?utf-8?B?ZGVyTklzeWZvUnN0bHdKWmN5ZFp5aXJtQ2xKOWRxU3ljc3FKSDNXanBlRnNL?=
 =?utf-8?B?dDFsWCtsZU5TRElpWEc2NFE2cjhYcW1QTU5JdGF1TXRKSjIwRGtLOUo3SGdq?=
 =?utf-8?B?ZXRQMXl3eU4yMG4yM3hVKys4dUI1a3ozSWhOOUZ0aHVJaTRJK3l2YXR2c0Qx?=
 =?utf-8?B?WStyVXFXdVhRN0tHRUh6cGJ2YzVUYUowZTY5MUpaQlpzMzBSNjlkK2FxT0Np?=
 =?utf-8?B?dzhOaVFGYTRhNXZhS1Y2bS9pSWhhNDVYQXF6WjV6YTdDYnVzeVI5VGNET3Na?=
 =?utf-8?B?bVJYV3ZhM2hnZ2ZYZVZwRUJERkJOYmtQdEp5NjJkSE56QjcwQlZVZmlhOUVp?=
 =?utf-8?B?ZVFRclIyS2ppMDZmbHFZMVJYKyswcmNjcG0xUHQ3VzgyZStmTFFQODI3RklZ?=
 =?utf-8?B?d1FOZUM3R1hzeDNhQW0zeEo1WUdPNktOK3o3aHd5b01xMThEZDBqSFhnVnB6?=
 =?utf-8?B?RElxaVd1WW1XS25mS2JCSUZyZm9OSFpTZ1ZQZVNKaE9BZnRIbC91V1lGSnMx?=
 =?utf-8?B?a2RUQUdXNHhhL1BzbVpXVU1rWDhSYjd4TkEySEUwME1BWGljRmpicmdxL2lB?=
 =?utf-8?B?VnBCUzR3VHZmQUlSTkVib3lJbEtpQktDa3Yyck5TN0ViQnpDS2Z2ekRrWHlV?=
 =?utf-8?B?U2JYQTl6WTN6dFIzRWk0VmpBajIwMmdYakxjNHJvMFE1Y1BOTmVQQkE4akFn?=
 =?utf-8?B?UmE1VFV5a0haZCs4dE5ia0hPNnEvWCtVdm1tbXpFeGNBbWJLTWZVNkh4THVP?=
 =?utf-8?B?Y1AyMHVVT2FkMVM4cld6V3FobDlwUm5iRlh4K0plRHN1c25JNUJBUmowNU85?=
 =?utf-8?B?WTlTbkJoV05GNU04UFZSVDZNVzUxRjcvMURQMXVRZmxwMG51WWtnVFIyUDlP?=
 =?utf-8?B?WEo5cFRNR3FxY3AzOWI3cFE2SlFkMWxRNnovNGVabGFPQ3VHaUZFNGF5cVpH?=
 =?utf-8?B?MUowcGt5VXRXWTRqNG1DZEVzbWh1cUV3SjRlZC9Tb3R6RXR4NVFoOXFiNVg4?=
 =?utf-8?B?ZVp0K2VrbDhPdlJZY1VnUXBqdGFqUmxDSTFxY01mOWJZK3BOUisxZEN2ZlVh?=
 =?utf-8?B?VkJaajVJVTRsMDcvV0h2TFgrWi9wdThvcS9Ca002VVJyZHN6THRuVCtudTA1?=
 =?utf-8?B?SGZNTGhqaHpsNyszV1lxaVhwaEJDK055R1RuM0c4dlI2cjE4M0xQMVNDT0tK?=
 =?utf-8?B?K2pIbm5KSlVMWEVNb040R0htZG9WVXpyRFpEUlJuWmp3WSsyNkhSNThWN1Rt?=
 =?utf-8?B?a1laTWU1bVZpckdnWDVBUm96ZUZXWGx1cnV5VXZGSTllRkdZSU1Xc1UxWHhs?=
 =?utf-8?B?NXptMjEwSGxVL3M1NFM3MUZzNmZ6dk1TNGMxMkt6TTMrV000NjZ3Z0FVMith?=
 =?utf-8?B?Nm1lNzU4ajJGd1c4MTB4Zk1EUXp6MTYwQTlvWmVWTmJZK2oxRWdvQTVRelRz?=
 =?utf-8?B?OWxOLzlnWmVTb0xyS1ducXVMWjRocklnWGg4Z09jVDJIMVB4TzJUQXNWaHBk?=
 =?utf-8?Q?JfXZLhmxemqfqarz0eBFmcnaR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdd7677-84f2-4894-defb-08dd341390a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:47:59.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fplePzzXX3ZbMTL16Uf4nXqMyETLA/qFxOzJIOTrxW6z/24rhDpQR3BLv6oXLOpqfHnko3vyzpZNl17ZdJVG3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441

On 1/13/25 07:14, Kirill A. Shutemov wrote:
> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> 
> memremap(MEMREMAP_WB)
>   arch_memremap_wb()
>     ioremap_cache()
>       __ioremap_caller(.encrytped = false)
> 
> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
> if the resulting mapping is encrypted or decrypted.
> 
> Creating a decrypted mapping without explicit request from the caller is
> risky:
> 
>   - It can inadvertently expose the guest's data and compromise the
>     guest.
> 
>   - Accessing private memory via shared/decrypted mapping on TDX will
>     either trigger implicit conversion to shared or #VE (depending on
>     VMM implementation).
> 
>     Implicit conversion is destructive: subsequent access to the same
>     memory via private mapping will trigger a hard-to-debug #VE crash.
> 
> The kernel already provides a way to request decrypted mapping
> explicitly via the MEMREMAP_DEC flag.
> 
> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
> default unless MEMREMAP_DEC is specified.
> 
> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.

This patch causes my bare-metal system to crash during boot when using
mem_encrypt=on:

[    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
[    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
[    2.394733] BUG: unable to handle page fault for address: ffffc900b4669017
[    2.395729] #PF: supervisor read access in kernel mode
[    2.395729] #PF: error_code(0x0000) - not-present page
[    2.395729] PGD 8000100010067 P4D 8000100010067 PUD 0 
[    2.395729] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    2.395729] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc7-sos-testing #1
[    2.395729] Hardware name: ...
[    2.395729] RIP: 0010:efi_memattr_apply_permissions+0xa6/0x330
[    2.395729] Code: 24 0f 48 8b 05 f3 30 a3 ff f6 c4 01 0f 85 66 02 00 00 31 db 4c 8d 6d 10 3b 5d 04 0f 83 4a 01 00 00 89 d8 0f af 45 08 4c 01 e8 <48> 8b 10 48 8b 70 08 4c 8b 40 18 48 89 54 24 10 48 8b 50 08 48 89
[    2.395729] RSP: 0000:ffffffffb3803e18 EFLAGS: 00010296
[    2.395729] RAX: ffffc900b4669017 RBX: 0000000000000001 RCX: 0000000000000000
[    2.395729] RDX: 0000000000000000 RSI: ffffffffb3803cd8 RDI: 00000000ffffffff
[    2.395729] RBP: ffffc900000b5018 R08: 00000000fffeffff R09: 0000000000000001
[    2.395729] R10: 00000000fffeffff R11: ffff894048a80000 R12: ffffffffb434f1c0
[    2.395729] R13: ffffc900000b5028 R14: ec5be84ccfb8b000 R15: ffffffffb3803e28
[    2.395729] FS:  0000000000000000(0000) GS:ffff894049000000(0000) knlGS:0000000000000000
[    2.395729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.395729] CR2: ffffc900b4669017 CR3: 0008006f43832001 CR4: 0000000000770ef0
[    2.395729] PKRU: 55555554
[    2.395729] Call Trace:
[    2.395729]  <TASK>
[    2.395729]  ? __die+0x1f/0x60
[    2.395729]  ? page_fault_oops+0x80/0x150
[    2.395729]  ? exc_page_fault+0x15f/0x170
[    2.395729]  ? asm_exc_page_fault+0x22/0x30
[    2.395729]  ? __pfx_efi_update_mem_attr+0x10/0x10
[    2.395729]  ? efi_memattr_apply_permissions+0xa6/0x330
[    2.395729]  ? efi_memattr_apply_permissions+0x254/0x330
[    2.395729]  __efi_enter_virtual_mode+0x166/0x250
[    2.395729]  efi_enter_virtual_mode+0x2d/0x50
[    2.395729]  start_kernel+0x5d7/0x670
[    2.395729]  x86_64_start_reservations+0x14/0x30
[    2.395729]  x86_64_start_kernel+0x79/0x80
[    2.395729]  common_startup_64+0x13e/0x141
[    2.395729]  </TASK>
[    2.395729] Modules linked in:
[    2.395729] CR2: ffffc900b4669017
[    2.395729] ---[ end trace 0000000000000000 ]---
[    2.395729] RIP: 0010:efi_memattr_apply_permissions+0xa6/0x330
[    2.395729] Code: 24 0f 48 8b 05 f3 30 a3 ff f6 c4 01 0f 85 66 02 00 00 31 db 4c 8d 6d 10 3b 5d 04 0f 83 4a 01 00 00 89 d8 0f af 45 08 4c 01 e8 <48> 8b 10 48 8b 70 08 4c 8b 40 18 48 89 54 24 10 48 8b 50 08 48 89
[    2.395729] RSP: 0000:ffffffffb3803e18 EFLAGS: 00010296
[    2.395729] RAX: ffffc900b4669017 RBX: 0000000000000001 RCX: 0000000000000000
[    2.395729] RDX: 0000000000000000 RSI: ffffffffb3803cd8 RDI: 00000000ffffffff
[    2.395729] RBP: ffffc900000b5018 R08: 00000000fffeffff R09: 0000000000000001
[    2.395729] R10: 00000000fffeffff R11: ffff894048a80000 R12: ffffffffb434f1c0
[    2.395729] R13: ffffc900000b5028 R14: ec5be84ccfb8b000 R15: ffffffffb3803e28
[    2.395729] FS:  0000000000000000(0000) GS:ffff894049000000(0000) knlGS:0000000000000000
[    2.395729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.395729] CR2: ffffc900b4669017 CR3: 0008006f43832001 CR4: 0000000000770ef0
[    2.395729] PKRU: 55555554
[    2.395729] Kernel panic - not syncing: Fatal exception
[    2.395729] ---[ end Kernel panic - not syncing: Fatal exception ]---

Thanks,
Tom

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: stable@vger.kernel.org # 6.11+
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Ashish Kalra <ashish.kalra@amd.com>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> ---
>  arch/x86/include/asm/io.h | 3 +++
>  arch/x86/mm/ioremap.c     | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index ed580c7f9d0a..1a0dc2b2bf5b 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -175,6 +175,9 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
>  extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
>  #define ioremap_encrypted ioremap_encrypted
>  
> +void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
> +#define arch_memremap_wb arch_memremap_wb
> +
>  /**
>   * ioremap     -   map bus memory into CPU space
>   * @offset:    bus address of the memory
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 8d29163568a7..3c36f3f5e688 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
>  }
>  EXPORT_SYMBOL(iounmap);
>  
> +void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
> +{
> +	if (flags & MEMREMAP_DEC)
> +		return (void __force *)ioremap_cache(phys_addr, size);
> +
> +	return (void __force *)ioremap_encrypted(phys_addr, size);
> +}
> +
>  /*
>   * Convert a physical pointer to a virtual kernel pointer for /dev/mem
>   * access

