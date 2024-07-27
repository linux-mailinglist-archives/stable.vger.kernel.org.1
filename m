Return-Path: <stable+bounces-61973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2193DFD3
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19A6282239
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5540180A86;
	Sat, 27 Jul 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iMAvdI4n"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377016EC1C;
	Sat, 27 Jul 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092170; cv=fail; b=GsA/zRGPH+Qk5ALOrf3BPswCjfK1CH+rfZFKTFjFijftOQd+uw+7x+Z3BSa3fCt3CdqOyKmc7btcr/maMSMqG0Ljbi21oEnUg3QaBGhlZYIF9/kGABmlLt9UQWuLergdBWD1fw5SZ4YoSAvlR/WNSOa1fpZTiLrKKK8i4Z9wMuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092170; c=relaxed/simple;
	bh=uQnGXA4vGGyID7OVG5h+e4U+4K4qjyD20+BRvN5/5vI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhB/tSIokoPxJxyQAkA8QnV1181Yo0WRu2vyfsnBF3ysKoZMUorCyBXZdQlfJ7Sxhxh3EKRdPJsFu489smaaaBp14LLRP+wA2uuH/xxhTZ/r5y3RffidUqdlv/3KoOQVrOPHQ638yyKJyXD3bHochtUQaX52ST6tkt4Qj/IsgcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iMAvdI4n; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7TJs6oGTMvOvzeNZndu04vtgs95Yhxd242Uzhf2R+tSskPF1++SKjS3sVJ0i6de6xjV++gIJTheOVefb1wYzlimtfCymHy1XpG2ITrFgCQ+tRgJJVWbHjEk+PDL4AA+R0Ojjqv6eD7le+SZV9RXU7XGLgGNjX0cSShF8wMuqgvZxsy0A2C1YIaVp0+r6voitqbfD7l/J7n4yoOu6eM9gRZcDnKC2eEfGf/2x3Ox8rQBnpDo2ZcEG+yj4laBo3k93r6r+6phkaahBP9il6BFwPHeow+aLxAg0EtXdn6EVPq5BTtJ73iSsPmz7Y5zGW3h3VWdxNagBY0aXOrR+r7bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGEDtGFbPi20iVVBmy/FBOdFUXig63KC/nw/PrbIWY0=;
 b=yqWfmUMKcsydY3injT9T+70Xe224Wfcb9x0FRApSyeCUP/wS4kfP4X75lleRr6Uipmqcb/xBdTpcjG4Fh9tbDJUQyWiI2OMmm0ALHo43IB6HZiTAA/noIZV6+i6Fh+9dsnA03Nkz09WdEb0s8hO5BlXqn3hIMfT1UXQ0pKotH9G/qNNj0X5FX1GAn0AaDPMDLgQbTN9pKhSAYKcDcSrwk4SVO2FBzHxrLM20XKWbiJ9x3ie0r+3o2Gp2W9sDHt1o4ZTyCFaU94IZhV5loWI9PomLDye8c5Numbs7N4t52wsqS3OT4qyx8E1OhvQSZOEkEXMYn5IhsCUJdMHlwSjzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGEDtGFbPi20iVVBmy/FBOdFUXig63KC/nw/PrbIWY0=;
 b=iMAvdI4njKypquXRJa5hWZ7eOP/qaDgqcrAX+qoON5OoOdsDpie14xDSw+wnNxRs8NzOOwQxeYGXjMnzE+6k4fZWCiZ421i7eaqNFPALnunD/14FY3iGQU/Kh63bBBoUI25O+oBsA59BeHps4VNcm4+Tzr3sJBQZ53SlAc5sKh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Sat, 27 Jul
 2024 14:56:04 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7784.020; Sat, 27 Jul 2024
 14:56:04 +0000
Message-ID: <dc46a633-f19b-4216-8747-e0511e7d8503@amd.com>
Date: Sat, 27 Jul 2024 20:25:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20240727143801.959573-1-sashal@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240727143801.959573-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6108eb-95bd-48cf-b473-08dcae4c3cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzF3ZWdYaFF6VXc3UlBleVFnSXJZdk0xbXpaL2ZFTFdzSEoza25jM2h6OU1F?=
 =?utf-8?B?Tk9sbjN2WFJkRmIyTjFXM1dUWHJ0a0gyL1ZIdEVjTUJoT0JIVkFXZlF1Z1Mz?=
 =?utf-8?B?bFU0MEJYckVGZmduckNDVTdKSnVTRjByS2NDUWQxQ2tOMHZUeWoyT0hvdkZJ?=
 =?utf-8?B?Zm9ZcGM5TEo0ZzE1WktpVGJVOTYzYzhuNnRDNjBWVmU0WXhpVFRyTnV2aTBJ?=
 =?utf-8?B?ZHhMUHhXSHNldVlSZENHTTF4TGo1TXh2dkdxeTVtRzBoS2pDck1pcGQ4K3po?=
 =?utf-8?B?Wm55K1FVMmE3Q0hZYVY0dUNVVTZnMkZLbGRDaVdKVHk2TVJYTVNuUUtOcDYw?=
 =?utf-8?B?cnJNbEZ3RkI1RjlzRDVyZnhMdjhIN2N3ZUtQdmxjZTZXQSt6L1dncXVhVis4?=
 =?utf-8?B?UGowMlF3SmVXd0FoREpNODYxS3ZHSDg1L1hIbzlTS28wM2pzcVRHeUpNTlFs?=
 =?utf-8?B?Y1BzOUtoajJOVnVnMTUrRVVzZjdhdUowUlJQVytJc0lzdHIzL0lIZW9Nd0k1?=
 =?utf-8?B?NkVuTGRoNjRtQytHUG9TK2NSU2czVHBxR1JKVWpyc2ZwSmRaWGp1Rkp2aDNE?=
 =?utf-8?B?d0V6R2MxTXlrWktVSEhhQll1a2dpSllCeHgzZjRSZGgzQk9FaStxMGw0c0hG?=
 =?utf-8?B?WmZOTjBWM1p5MnRDUy8va2VWU0NCRUdMc09keHBZdzV3bnNneDBjTmsyY1A0?=
 =?utf-8?B?ei92YWdHUTZkWHV1VTIrNkRFcnB5MG9PcTZENXdsbVJNb1FHQXR2Ym8yQWQz?=
 =?utf-8?B?TXZva2RIM1NoSVVlRWcyMnpXeWNTZ1praUVxbkYranlZckpHZ0NRWnVCcnEr?=
 =?utf-8?B?c2ZZY2tzNmdDTXowL1M1WWxWd3pOSkZMaHE3RnoyOUl4VWNiYS8vRGdiN2w0?=
 =?utf-8?B?QXlCOVhLRkZmNUpQT2ZVNHZ2a1hvMFJEV0E1K3JXRDM2SkR2bVZrTWNGTGtX?=
 =?utf-8?B?VmZ1YnA2eFV0aExYODVLZE41MXlpZlI0bTBuQmF1UWRwelhob3ltTlhyQ0VY?=
 =?utf-8?B?UEYxeno0NEQ5SldNdG9VRnNGYWtwMk04NEtia3VJckZnYnJWMGhoRlA5VC9r?=
 =?utf-8?B?VnAzREZudFN2Yjh1M1VIMUFMaEtPWGVmUWJncE14NjFQaHZKS1JrTklxSUtT?=
 =?utf-8?B?ZGU0MmNsSEg0V29ERFBKdmhCTnMzREFxYnEzbnpya3FWUCtXbjlyWFNnT3pl?=
 =?utf-8?B?elk2TzZid0ROTUx5K3U1Z1JDZTNCTDA4VVBhQmdoMS82Q3VHZ0hlYjVLK1hH?=
 =?utf-8?B?b0hIOG1wa09GNUdGVnBZdnhHNUloRTB2Mm1qNkRNUDAxOTJFSHlhVmoyMUpR?=
 =?utf-8?B?a0VqYWJNYklKMHBtUko4MTVOcFphUDZwQ21UclFwVjBHdC90d1BMNlRTME85?=
 =?utf-8?B?bmdmSm1Va2p5YlFnbXF5NmRMRnAraEdGVStycVQwSFhBTUV1TDI2dTV3UkFs?=
 =?utf-8?B?VFZjTk43N3pYWXpNZUR4S0hDUnJ4cVBpY1Exbk1UOUtOQ0xCekl4U0ZwNllt?=
 =?utf-8?B?ekk5K0h0aUMxRXJSRVY4OHhYdWRXWTRHenIrVmRUbGNqU3RZaTFtQ0d6UU1M?=
 =?utf-8?B?dGZGSlZxV0pWMU53VVJUZEJCQzgwZFVlb3ZHb1IzMWRRclVORFNmK2ZXV3dT?=
 =?utf-8?B?dHdNQkE3cGswbzFIL0ZPclNmYllpc3hJSmU3WjE5TFhmaDNWdEFBOEM1a2No?=
 =?utf-8?B?VFcreUwraE5paGxKcmQwUW1mTmZjeTU3MTZlWCtqNTdNSVNZQm43TktNQ1Qz?=
 =?utf-8?Q?HmECKB/oxvOKt+heoU30/nDicqgzntnatgNs/NO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5JWW9iZ0VOMzdETFMwR0ZPa2UxTWtEYXNVN2x0VHZJb2wzc0xsZ1ZaZUlJ?=
 =?utf-8?B?S2pNQ2M3ZVV5VFdvSVgrdVpnWlFsMzZMU1ZWdk8rMW94eGxDN3B1NUtjbUow?=
 =?utf-8?B?eTJIWllmUE9JeWVOUXU5ZkgzSTl4TldwUEROSkhyeXJFZit0a1duaW5oMXJu?=
 =?utf-8?B?ZkFwdFZnSHhqeVpQTE9vZGZrbzBVT1lxWnlQcFFRRjBPdTRHZ0MyVjd3U21u?=
 =?utf-8?B?bHhXdXFBU1hpWklOVXF3RlJEUVNNb0Z0dVZGdFlsTXZSUXM3ZlJ2U0dVZGN6?=
 =?utf-8?B?Wkc3Y2h4SUZVN3I4YTc2cCs3anpTUXZlaWhWbnVZL3QvTkhGaFdXZDFCMGJm?=
 =?utf-8?B?MEliWGhvQnEyK2wrVnAzWFJEQlloMTZRd2VTajNiVmJqQ0h0cTNnYVBubmVV?=
 =?utf-8?B?clh4d3ZUcGxuYzJEek0rNzB0eEovUWxUOFBtSmdyRUh4YlhKcVAwUGF6dGpj?=
 =?utf-8?B?THZWYjZTZ0dKWWdtU0RlemM5MS94QVJIejVtbTdySm5ZK3ZiVGNtVDh5djB2?=
 =?utf-8?B?VjFOL2xtdGFxLzhGcm10VXZpc25icWttMjhaeTh5VG5GRTZLc1hYb25VMDJ2?=
 =?utf-8?B?ZjZ2MXF6d0Znbyt0TkFldk4xaWJqRlZxSU9raXo4TFV3TWxIbG5sUGRISm1p?=
 =?utf-8?B?U3RIMTlQeFhIcVUrT2dsckFQdDJoRWNYQkMxS1loZThpRkNHVDdvQ0VvbEox?=
 =?utf-8?B?bU9EUU9FbmZ0c3JIQ05aTWs4VkhsZm1CQ3pRZDRRdGhCSytoRXl6Z3NYU0FP?=
 =?utf-8?B?RHRBaUs5TlBNNHU3WEkxUHhiQlIzUUtVZUg0VlAvRzdLUGxKdGpReDJOWmR3?=
 =?utf-8?B?MDNpOVBDTzdMMExJRWlvUXJUK3orOWVFcm1ybEQ0dHBsWjliYXVuVEp2Z1lR?=
 =?utf-8?B?MGhhdnJXNTAvSm1tTTJ2aVl3bkpYTmxrT1E2Nks4ZGlHckZnVTZkbGlEZGxT?=
 =?utf-8?B?WE9WMFpxc1MvVFN2NzZmdDZNMHlIRzZWVWdoWTY0Nkt3YVhyc0ljMVBYNWVm?=
 =?utf-8?B?aURFNnUvaUVRdnVBNmdyU2g4MUVRcmRSZDJqL2pPUnJGYnIxRmZjOUtFdlE5?=
 =?utf-8?B?dWN3cnVidnRObzBEU2lPUW9OTXhYdExZQjB0ZGV0clNpTnZOaGh0N01rcFdt?=
 =?utf-8?B?MXRmZGlZT1FPWHF0UWw0S29ZeFFzMGlkRjcrNUhvMjlpSkNHVTJISkozV3RX?=
 =?utf-8?B?d1F3OFI4c1NLdEN1RWNFemdBc1pjeS9pSUYzODVuRDd4d04zVFlZeXRYWTlR?=
 =?utf-8?B?SWJBSmZKN3p5MDlpR3pQLzhzZGhGRGgwQ0EzQkRmUk5kbmdEWm44d2dPK0VW?=
 =?utf-8?B?NDBVUGdQZFZ0dUI4VlRqMkZ5Yk5zWXFtc2V0L0NiNlQ0Z3NnSzFFWjdTL1Uy?=
 =?utf-8?B?clRWR3RxLzZhcFR6TFpKclFqSjlCd3FQc2pLd055dzQ2c0UvS0FtZzVLc2pV?=
 =?utf-8?B?NkppbURwdXRwbXpaWXpOWXRib21WUHd4Mkh4alYybktJRjhKRk1Cb1RSSEtr?=
 =?utf-8?B?bTJiRnQ4U1ZkRW9heXNTWERoeXN2TG91eDN3Tk5lRUx6R1JMRnV0RmlYZ2ZG?=
 =?utf-8?B?enhHVkNtbS9aWTdHMWo2c1JNYmtZTlp0T0VCYXFTbUZRbTV6RUpNTCtZZFda?=
 =?utf-8?B?QjVpcXRNR2RpVmZJNGVKclM1OEViZ0ZoUmFZeXpibTF4ZXM1aFhlOGwvcVlz?=
 =?utf-8?B?ZEM3SEZydllQRUV5NDFyTnFaalJHenFkVWszRm5DdDdFYkhwYXYyMTVVN0Fn?=
 =?utf-8?B?NGMyTFBpSWl1TGtnZHhxZUhjY0pZNzM2amxzNnFXS0c5QmdwaDhucUNZUkd6?=
 =?utf-8?B?QW52d1pISVJSTmd5SjB0VDNnTjl4NHg1dmk1c25nNmpDMUpVYTk4Y3lQZFFC?=
 =?utf-8?B?N1hWaXpOL1FuVWQvT3h6Z2dkcGZVUUpOSUVybDlFRnVWUmRyL2FWRkFlTW1s?=
 =?utf-8?B?eW9WRGk5NHJOVGFOR29wU2JVblZ2SnI3cGR6clM5QXp4WXlkdW92UzIwTThr?=
 =?utf-8?B?QS95N20vd0NjbXhTNjFDamg0SWdsRmE3TlJDM00wMmprQmU4dDZVSDZsWDFX?=
 =?utf-8?B?OGp3YkpDTnNpY0U4Z0hRQ0FQYm1FZlZDV0ZTZmtZS0VQdE1VRlluY0ZXWU5j?=
 =?utf-8?Q?vEXV7ds8m7fTt94UfsRJwgN3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6108eb-95bd-48cf-b473-08dcae4c3cb1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 14:56:04.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiKzTy1aKQKA8S20BrYUAgzSGRUbhuJ/5bcu26n1fulWRURJfEOrj+P6D3b4/NOn2M4pXT6PLGFE3oHtCbaoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

Hello,

Please note that, this specific commit causes a regression in kernels older than 6.9.y, 
it is only needed after "cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq" 
got merged, so please do not port it back to kernels older than that.

Thanks,
Dhananjay


On 7/27/2024 8:08 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cpufreq-amd-pstate-ut-convert-nominal_freq-to-khz-du.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit ac333983a0338e3009be4d5a59af25fb2da7130c
> Author: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Date:   Tue Jul 2 08:14:13 2024 +0000
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>     
>     [ Upstream commit f21ab5ed4e8758b06230900f44b9dcbcfdc0c3ae ]
>     
>     cpudata->nominal_freq being in MHz whereas other frequencies being in
>     KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>     
>     Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")
>     Reported-by: David Arcari <darcari@redhat.com>
>     Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>     Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>     Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>     Link: https://lore.kernel.org/r/20240702081413.5688-2-Dhananjay.Ugwekar@amd.com
>     Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda372..f5e0151f50083 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -201,6 +201,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	u32 nominal_freq_khz;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -208,13 +209,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +		nominal_freq_khz = cpudata->nominal_freq*1000;
> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>  			(cpudata->min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>  			goto skip_test;
>  		}
> @@ -228,13 +230,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (cpudata->boost_supported) {
>  			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> +					(policy->max == nominal_freq_khz))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
> -					cpudata->nominal_freq);
> +					nominal_freq_khz);
>  				goto skip_test;
>  			}
>  		} else {

