Return-Path: <stable+bounces-141940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E9AAD0C2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8107AD5EB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51C20F081;
	Tue,  6 May 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SN9IwWHA"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA42B9BC
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569083; cv=fail; b=Pyl0zNqGkKf1kTaBe7vZlVtfDxwILKL7wsP5JhGhdxTbgeHef7QQyElZ8/YJBoJsbJwi2LIyB7X7EG6hwq4fEXcAOqCYVt3bVl+vhLYGiOIuX3sqsoUWxybbFD0V9vFtuLD0a5K1Fy7HBy0r9f8xowKOL5qYQCAf7rVvVdrprow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569083; c=relaxed/simple;
	bh=2Q7mgQKVxsDXGaocTyUxZKkfiBTaLqI2PRkYucZAOA8=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=DwHNvshtl0pOqO/ZSDAHf6sgvHosRiFreudMNa9+4VIJtCgQArlwXlAhMF9SUG7g2nC3Co/vbL2YiET/0AcSZjpMJTlQjE1bcKjy5+9vMY6MJldkBusE9ByLLKnDjoVEI6SC8T6Scu9OVr73r46sdgEfrJXJwLrekNeSLV1vNc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SN9IwWHA; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdClZda41n+9I8jd44Zg6/1u58mYzKy4zVYZaWpfEoACw5mGu5/ittZ+PnVUcHYaf7vRIAlmjYitnqrORds8+72oy1VVdctrdUQVcv+J3VPeBF16+8R1fwshcW0QGWwZsh/KKysvbW7Fq4t0mV7t/8QOtSzhJIT3x8gxaZaFkkVcM3fWARO8X90DmcTGQaeddpb7BY7Z8oYhoc8yBHAuxn3Vd9chauvf+YDiBOA+PDYYmMZOVtHOZjCtAMINEuv8ibuRzVD2+k4tl3Swc5OW8r9EV+IM00ZCp9JkmdJoIk+FsNVYoukkzK5PCuRXOiy/brbtHAgmD1VTUUKErTDVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN5lNCJcHhbNJqkzRLulG3EhI1F7NeMX2kGsMn0+CVg=;
 b=wyTzELI1eanBXzCSO0/L0VdyJnq1VW11uBe3gdw6U4p0XekjgOcg2MDbtZTJf6xckp7pJGGNV/u1s5qCQJZXtwDyMXk0mc6TP9LLH1kyFT79YQY1+22Io52wmV5yQ9DW09fV10WErF/YhffuzL+4S3i4Ezg/UoabdjltnKX7ujeTu5ZYSaa32GVvaBOhCvnpbDq3iNod/FpQdJzJcAkhxZGntXo2Bqvl1ZEbc1jsf4/7W5s4GqRQjlgH3+0eaaBwNxd2RqmTDneT3AJbUKeMtD2TRlrSywO7GEpBQ2yiOlKO8FbMtVq7/jowpfy2WKK8d6hqwhIUU6ojeqXjqm2rrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN5lNCJcHhbNJqkzRLulG3EhI1F7NeMX2kGsMn0+CVg=;
 b=SN9IwWHAr/VIZCNycwfEUozKO3ofAPv9IaZtcBYxepDzwapBgslY/qpGy5iFH3YoaQjxBPIeiHt2hDnzDdt+g8CGaBxEx0mpHpURuaxQ8tqCM8VX86Oes+7xih4nONO9XYPXQEDp5HN+x5OX05LYgQGet6HRteF0WodUURyfwlPfj0RLSAvzXzhD0k2nR+bQvo8QKBm84hgJqxdhTy5l+QYMSHdFR5AP+dlfaREMBhfxXv1QegzdBNJ5xP16EaVsCtdLFfFaW9w2VHi8QJdVxNM4oYAQRhSUEqv70XP9V5hV1YvZSKnz4qDrRsiLrMeUNPBwtG4OqPVkoebJgBMxKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:04:36 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:04:36 +0000
Message-ID: <02831f94-5bdd-4b15-8fc8-34fca73bac9e@nvidia.com>
Date: Wed, 7 May 2025 01:04:30 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 7/7] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
References: <20250506215511.4126251-8-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-8-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2d4ba3-4c62-4dcd-5e9c-08dd8ce9fd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3h3VUlZeEpTM3dXUEpKOThUT3VEVm9rc05nSWJCb05Da1FJdSt3clhwQ29k?=
 =?utf-8?B?NTFvUFBaMVdQYTd2eFo5OXZXSHZub3llSmpEZ1ZLUVU2dTc5VitvZmNNK1dY?=
 =?utf-8?B?ZUtFNVZqakM4ZFlidHBDWmNOMXpwbFk2ZjVlRVA0Y2pYcHpRZjVwc3BsRWRa?=
 =?utf-8?B?YXljQjREek5VQmR3UE5ueEhKZjZSdGFYd0o3bnpWS1V1UmdpNlBBaTI5Q0Iw?=
 =?utf-8?B?SVRxZlEreEVYWTlITWs3MUFta3RuTXNQdkhXK2tMMDY1V2Rpb3A4endjUEVH?=
 =?utf-8?B?ZlFqdUc3eWlGd0dQTGlKWEhuako5R0E4dmlzNll2RUZFR3FpaUpRcXNjeS9r?=
 =?utf-8?B?TnVOWTFtZ24yVTVLRzliTTRDSTFUQ3RjMHR3REhacGlhT2pXV1JOUTZjcGhZ?=
 =?utf-8?B?RDRDTmZEdi9XOG9CNDlLSGh4WlZMS3R0U210L0ViVEZsT2oxSXpsTnVXRmxC?=
 =?utf-8?B?TG5xeXFyQzhpVHNEWlZGU2FIK09zbmR5d3BRajVvaHJlcXJRNGNoQjVUeU1i?=
 =?utf-8?B?SXhXVmM1T2tha1R0TkhTWkhsNTNyM1JDZXBtWWZpMVpHUTVQRlF5anNBaW1z?=
 =?utf-8?B?c2ZWeEpHdjNaZll3NlhreGo4bk4yRVNhZ3pCMjBjS1ZMYzRMK1JnRFlXbnpi?=
 =?utf-8?B?bGd4L1dCb1pCZ042bFpNb0pqeDU4bWpaTHhvS3NqSTV4eTF4ZGZBSldibDZI?=
 =?utf-8?B?eDhEc0JGeHVKdG9OT0FBclIwd1h5QnBMK2R2L05aZnFiOGJ0YlZTQ3lxRk8z?=
 =?utf-8?B?NFZhWm1PSk5MMWFMQXMrRkxiTE40UG5KbGhMRE5rb2dYQmpRUHovc3V3azNk?=
 =?utf-8?B?WEI2cjRZck9NajJuTzc4T0hhWW9xdlRQSXV3WFBRNDNRZTZBOE14dUNZNVBt?=
 =?utf-8?B?R0tqMGFpeTIxRk9mT3BuWE50UjFxU3JDWGE4NXlmcHVNRXp4UDlZZmlqQXM1?=
 =?utf-8?B?WGxLZGt0REZCR3Y5Q3RObFIzTVZSbFpsNGdYTU9oSWFDV2hrNEhSc2diRko2?=
 =?utf-8?B?L3dETGdHSExtdjhJS2RXcytPc2hDd1BMV2JPRDRLRGcreVcraHdIRE41VUt5?=
 =?utf-8?B?NEs4M1dmTUdhY2txTGZyNDA3VFU0THZkWUd6bmV2cVF6WWxqdGZ2SkVDVjRU?=
 =?utf-8?B?N1pkbXYyc1NHaWhhV2g3SkNYbW5BR2tIbXVQeDVTRTBqcGJ2bGZ2b0xVVENr?=
 =?utf-8?B?RWttcFlsbVQ4b2FxVEFMNlhNSFBKSk01d2RCM2tvR2RUaU50ZmdlYlVlTkV3?=
 =?utf-8?B?cHZuSW9UNWFEWGVtam12S0J3azYrOGtqV3Bhd0paV1ZHNE9WbEJMa0JZdmhh?=
 =?utf-8?B?Z2hxak9rMW9WWnlKbWtycDQ1K1FMSTdaN216eG5hNE1ZeHZqekJIZkhCOHNk?=
 =?utf-8?B?SUF2UW1NVDRTOVFMQVcvSXdWMXpGSnNFOFlQRkFXeWFWM3dsODVjai9TMXVz?=
 =?utf-8?B?azl1bE5rbnp6RnhUb3JQQWpKRG5ydmdFVi96TnlTcDJ2amJaQUpxQm81Kzh6?=
 =?utf-8?B?a1pHL3BFdVBMUVo0bDNUNVhsMjBRRWMyV21OTVoycHhMUE1PL2xmQVB2N0tm?=
 =?utf-8?B?RFRWRHNUazRPeld5M0RKNzBLSEViOWpEUUpXZVZOcSt2OU5SeC9xWjNBMmhu?=
 =?utf-8?B?eklhTUhNRWxva01JV0JRN3VTc0hnbGwwR1h1SzRWQTJKUHp3bVRxQTE5K3hZ?=
 =?utf-8?B?Z0lSL3lWaS9Ia2ZJR1gzMG5KYWJWbkduTWlITHpGdWE4ZS9FZmM0ZVRZYlJY?=
 =?utf-8?B?eHR6aXZKeTR4bnc3TUdVd3dHR1l1ZHpXQTlsTEc4Sm1MajZRbFV0SUl4V0o1?=
 =?utf-8?B?ZG1SMm1nbjVrK2J4VndGZnRZTllESEpTTW1VajhOT0hydk5LMENzb2VWdU9G?=
 =?utf-8?B?V3hubWdCbnAwYnJoWDJPMWxFbU4rdXdXUXFWSmZmaXFYRnM3eHlnUEx4d1d2?=
 =?utf-8?Q?Gt+THshAEX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllSdE15dUdWNkNHdUZ4a01jUlFEdG1ERnpJMDkrU1RrdmxFbGpHR3MzU3JF?=
 =?utf-8?B?S3NmZlQrak45elVkbWFYaWgxaWZheGpJMGZEZGN2N1lUb2hiQUtaN052R3I5?=
 =?utf-8?B?OHg0TS9mekZ2cUZ3SndIS0JqODFlMHJFbEZvQ1RRTy9pTHpGbVdpcUFodUlW?=
 =?utf-8?B?OVNlcEVvWGhFTlQvTzhoSE1IV2dYdnN0VHc0dm9waHRhT0o3bXY2VnR5aFFM?=
 =?utf-8?B?Tk9Od2Q3WDl1S2NWQjB6RUZMWWF0Q0RCNUJkWVp5Q2Rna2k0VWVXTjB1dUVK?=
 =?utf-8?B?YndXWHdrbXpMTW1ocWNJd0NTTUhrYXUxdWNpdzcxYjhWVksrT2lrUGFtUWJN?=
 =?utf-8?B?dFlvTEFSVC84QjVxdm14Z285WGtUdzZ4NXNmcUVJeWY5TzlDYklhYW8xaXE0?=
 =?utf-8?B?VGZjMEd3WFRnRmNESlNpeCs2NGYyZVN0VGdXbnE5bTRSUGF1VTF1eENBMlg0?=
 =?utf-8?B?amJlS1NHenBSaGpzYStONnVPN3FXTU1md2tXenVZc0ZXRitVbzlxTmsrQTJD?=
 =?utf-8?B?MGlycmJab25qNzJ5YXp0ODZtVkt2OTJORHV5dVV2MzU1Q0YwWW5tNHM2VGh1?=
 =?utf-8?B?VHJCWkFMYmhkQUs1cjM1bmhPUFFWQnJNWGh3c0lYYUZTbnROVUNYTHA0dUtp?=
 =?utf-8?B?VHRGT2FUaElRYy90MVNBb1JDdncvTGVwbzMyc0VuTUdqa00xT2IzYzJub2tK?=
 =?utf-8?B?QS8zanVRNEhjN1JheE50N0k1MnI1eWZwalNZV0Vycjc4QndIMFZGQmk5TWVT?=
 =?utf-8?B?S1pLbkFWWnZ1ak9ZTzArMzJrakVpRVRSN1draWZ4eEVLNWJzUGVKeVhZVE4w?=
 =?utf-8?B?dzkrMURYTGxzcldTaEpnTWtnVDk0cDZOSk9CQ3BDRUkrSGNEbGt4RHpOQzJR?=
 =?utf-8?B?SGRDQ2hMSXJtSG1vWThFdzg3YWh0bUhpSTN4V3RuNXM3RHY3d0JVY0JQL052?=
 =?utf-8?B?V1hSSWdIcW84ZWNSSElGV3ZoNTBVa0xzSnA2bGJIdWpXZ0tEbEJDT0xtNXM2?=
 =?utf-8?B?c2FIeEhGdlNCU0RYNGFmQUpiM2xwUk1MM1pDZHFRYTBTYUkzd0JZcnVkektE?=
 =?utf-8?B?cFZ1Q1NaS3ZXM2g0MlVTdWdQaHAxVGpEeHl2dStKS0FYa0lqaHRrRlM4RzFY?=
 =?utf-8?B?bFNQSm5ZYUkrdHNablRCeDc2bHRXckgrSGdFS2tqUVlHSUxmVHpYcHM0c2ha?=
 =?utf-8?B?ZFlQYUdRUGZkeEJZYkFlYXVYWnFhNUN5OTZPN3N6Vlk2RDVWN0lnemRIbkxk?=
 =?utf-8?B?QUZqMmNzbnBZaWt6UUhETkFtREh4VjZ1RSs3aitVVCsxN2M2L2J4RXBXemFX?=
 =?utf-8?B?dzlZOE5lV1piOHVUWWZaVHRMMjBxbVM5ckN4aURxNUYxdEhVYzhMMDVUdG0x?=
 =?utf-8?B?SVJ3SExYK3N1UFBqZGNDTWF3V1dQZ3BtUHpWeGJQdEFkd3NMcEQ4YWJVNnFv?=
 =?utf-8?B?VTR2ZHJiUlZaTG5Fak5BV1dUZjZIL0htQlBZSWxLdGQ4SHIzUEltbXErMTFw?=
 =?utf-8?B?NDluMXUrcGFvU1NheUtjUnpaYjZHTERLc3B0Q0RCZmdFVEdzTi84dUJWY0Fa?=
 =?utf-8?B?NlB0QnR4QS9XNWtCWlh0NGNRWDFLdkVIT3J4RDExWlRBYm1zNCtreXhpNlBO?=
 =?utf-8?B?Ti8xc3lnYVN1V2k5RHI0U0w3RGVnV2JiR0xPRDRTdEF0RnJYdG0yVmUxMEFT?=
 =?utf-8?B?c3NvZGJub0JoY0hPUm9acVIwMjk3QTFJWjh1ZysvSVNpdVhwU3lzMDJxTHlm?=
 =?utf-8?B?Tk84TFRoNXdJYWxjYW5lSHJnWHh4TGhSZmRQVzJBcWpSMnM5NEpOcHRMT1hP?=
 =?utf-8?B?WlJWa1lmM0hXUmMyVVBMbmZPTHpYOUtobDFPeHNuK09yN0p5RWxWaCtJdFNZ?=
 =?utf-8?B?d0ZLdXRTTVJzdVJEdzlVNTV5Ujk3TEovTVFCVnp1QzM3L0NSSlJEOHBQNFk2?=
 =?utf-8?B?bkZrajdkU1pVbm9DYnNJQ1BWT29Ddjg5anQ2YzlRb3NVelMvcE9WM0JjT0ht?=
 =?utf-8?B?M2YvdXMreDVwWTY3YUtaTzlPNitpS2dzbHpjcTNUNWJWY2RjUEFLTEZ1Z0Z4?=
 =?utf-8?B?eEJiNTJxK01tVExuSWs1WkZDZWhka2R4eWtMeG1XWDE1cjg0d1pIL1dNUW1o?=
 =?utf-8?B?cnozOXNoMWw2cVR0RFZ3Vk9rMFFLRTZaTzQyTlF3dmM2dEhwN3d1RnIzV1JJ?=
 =?utf-8?Q?DY18ZyjsBxWxJePlfDAYqSVcWGN/89Ypx2uAyTObVt4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2d4ba3-4c62-4dcd-5e9c-08dd8ce9fd3a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:04:36.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMZl4kPNenIHwwy7cyMmB4sfwmaWYSJX4sA98CBnMZUWFlKzCorTOKzcVy3+PNfYkHncquU1XOjrWDUToy0j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Ming Lei <ming.lei@redhat.com>

ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
we may have scheduled task work via io_uring_cmd_complete_in_task() for
dispatching request, then kernel crash can be triggered.

Fix it by not trying to canceling the command if ublk block request is
started.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Reported-by: Jared Holzman <jholzman@nvidia.com>
Tested-by: Jared Holzman <jholzman@nvidia.com>
Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250425013742.1079549-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6000147ac2a5..348c4feb7a2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1655,14 +1655,31 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * Either the started request will be aborted via __ublk_abort_rq(),
+	 * then this uring_cmd is canceled next time, or it will be done in
+	 * task work function ublk_dispatch_req() because io_uring guarantees
+	 * that ublk_dispatch_req() is always called
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1694,7 +1711,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1709,9 +1725,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (!ubq->canceling)
 		ublk_start_cancel(ubq);
 
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1724,7 +1739,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.43.0


