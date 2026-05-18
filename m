Return-Path: <stable+bounces-249251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N0aHdL5CmpF+wQAu9opvQ
	(envelope-from <stable+bounces-249251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:36:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14A56BADE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD043084312
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C93F39F2;
	Mon, 18 May 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="J5E718Ao";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="YMp5rt90"
X-Original-To: stable@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A93E172E;
	Mon, 18 May 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103577; cv=fail; b=cxZ5RYU0dOrxggiGpFFAhp7GTqWWvdLP1qrOKb1Jlbg2XEoshSQLw8ghrO0ugoromL5fq2HA86q26rzu1Wz6hweL7G4+soQxo5FXibyX7nDY1oAemhoK8wFJ/3r4m+myuvC8I1/X8KeHGCgOXHzgIaFnD7I2TNXXsB4mff0ScXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103577; c=relaxed/simple;
	bh=8BaVQpYs3Fs3XMkNNIj5+GT7vXjusmveGfyZZprzSzE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7wDxUGmhMSvQTbG7A0JGnkGeXXFFrwL5e6cLrEt8pHJDDrCNLnSsfcB0OhdygUgO2mN4LFurGC9pXbGQQxFrhU8e5qhx2yJTKspNVJHNmCFqEgG6NBR/o9K2kYfe8wxyAvacqDtHlbJ9aq6ExtCXx/9jZEa6RJPXXVB5iC+oyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=J5E718Ao; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=YMp5rt90; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBIfNt3424332;
	Mon, 18 May 2026 13:26:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	HIZNhk7W8Vj3v2DNLvxQw46ZPZWSR0YoNe8HB/tQSIs=; b=J5E718AoKo2+I7qL
	33cDK5li++pzJoUDo01TChf7d47WkFoZeUn67xNd8XuCkRn60NUJoEPSpPxs0IHx
	7RR0cvn7vMO0E0uNImS7C5mE7R3efwSHAMAloJ1kD+ZenPD91THM6XyGPGTcj2t3
	Moeu7TApEqshO/fvs47udlljM8qoOV28ZxRsymOZ6eLCVMiCDnxUk8wgFjKEEfeP
	UegC7pTaOnPU5fb6L0kBYrexLD4qBlfUZxXA1sAJdeG5LqukSOeuRtt69nqKanNx
	/AsYX+8NCEUOcBmy+rzdOtLzLCXBjRX9yPPwFG0Y8FLMxypTAqicc5VAnNIvv+D8
	JemDSw==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11022116.outbound.protection.outlook.com [52.101.66.116])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4e7sn9ge6c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 13:26:05 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBEFlsiXaojAcGcOjNRAZ9N1VvOyraWfvWln2XQG1apQg8YnB7luoRsKHwQkbvL52suyVMuT/piuiai+3xniv2jmmpHRfQuFreO7nfvADFuCR9rH8O+X1O84ehza2OdxXwtuwsU2wbJflIZg/jOkJomr4NgGUuhNHr67E1dkkyn9DF7S5jsEfIgD0+/cNmynPsIsG6KWVVWyUwTo2fryMkcUp+dggRYSPCcBEoqXvLD/o7ox5YIKdSTWzY+UjDrpJtWuk1F9eKW/J1iwNlzgBOjrNWTrOM6T23iw6miSotwxHBc0b6hryyRbteEm4cBv0h7PACDw16dA8OvlWtKsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIZNhk7W8Vj3v2DNLvxQw46ZPZWSR0YoNe8HB/tQSIs=;
 b=I+hzfZAvtJC4oQrzIot0RIWNxQOuD//F+rYgHYHLzjxryzfcHXdLtouxAvHKAzY56JQeZWoAZVEaebbWcOwyVOCPdQesZxTdNtZEhz7bAns/pnsVLoZsrWX3vUj2A49Yj3jLFCNCBUz7U2ffkKfCTQX6UwuyrBcEoGectzTHm88Of4uf6ivcJ0pGTfGlFdhL0/DN3kxs9fmGAoNOhMC4hoHQ7yXjUGv1iS5uy3zHaEHFSAIs8R/4fcqvjokRetBveUVw/NrAhiHoOt//nSvXKrE9a5+guInHkT86Z5KuVWLCdf9KqP1RlvYnnMotafngMo6DpotnsFlY7uhqGfghNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIZNhk7W8Vj3v2DNLvxQw46ZPZWSR0YoNe8HB/tQSIs=;
 b=YMp5rt90GuV6m7WgwXod1caraXc5ggH0jbhSBIKUwXbx5sUhJBDOFOJKayiAZqZxTZZEq+VWlabUF+TYHFLGNQP2vWDVLM4s6CPqnrJJd9FMW1uZwGSDOzlszohTSS8ZJ70SRrXNXeyOfgLH2v72LnR/az9UdDO+N5GFP0keH0I=
Received: from AS8P192MB2043.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5bf::11)
 by PA3P192MB2866.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 11:26:04 +0000
Received: from AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 ([fe80::9f05:d0fe:f10:78e6]) by AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 ([fe80::9f05:d0fe:f10:78e6%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:26:03 +0000
Message-ID: <432742f7-5396-43e0-803b-6c1969ed2499@westermo.com>
Date: Mon, 18 May 2026 13:26:02 +0200
User-Agent: Mozilla Thunderbird
From: Matthias May <matthias.may@westermo.com>
Subject: Re: [PATCH net v2] usbnet: limit max_mtu based on device's hard_mtu
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260119075518.2774373-1-lvivier@redhat.com>
 <539202f5-43ba-4938-a9b2-393c1bb3e072@westermo.com>
 <3550f13e-124c-492f-a5b5-ae6ad95f09f0@redhat.com>
Content-Language: en-US
In-Reply-To: <3550f13e-124c-492f-a5b5-ae6ad95f09f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::8) To AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5bf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2043:EE_|PA3P192MB2866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7927d171-a770-4bce-4c05-08deb4d03f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hbiuJ/IusuUQLada9czg5nd1MxS8tVD63ALWjTN7JtgMLR7YBbzjxisVrwul92i6rYfz6vdGoBN3I4HIHVdKPw9n05qo0UjMYg9osI+uaHJGcdrwT6+RvSd7/+0oH15OSSiVAE36693Z+7dFYJJQ8iAITIFHjl4xNWf7rRRzFuNeHtoh95O9NCVtVlJNRvwk/r/FAGKD9ZYDomCB9iEG1S97dXPGeGFIXXxabSP62v3+poC3J95WhXG3eHtFSwn+TPqxH6tGjNdz6l+m567nBC11FdPmk9R8USqZW6GDQ1DcOkvfj/6OrLe3TG1uDcX0Tg905Fuh+tVMYTcZya7ynJ0SlZoTB2BsqszmeUON5/GKxvefjSdHdb9RQMHHT37uu6FbtNpi4ab91bFJEhDlZUXkclMnyvKimaZ+3EkJ8ix5e5Amk4VLjCls5FZwT1NrHY6tvR9IXQUoz+IC1dsPA7L2aTzCwSlgv/oCtOH0MvueaC2CPstlaZAL7sRj6E2IpxPYkECeyGWNYhuTIuViKDG7dEUdiI5MxOSUhF7zig+svzPoIMTuouBsjruuM9q67f9Bj2ZeRtjG+vZ7OcgR2LMbhwCaaWKotXvTLRSWbhR21N7h1w7pcbc4DXnYGPBVKkDCEynBKNQFG8DtK9QAtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2043.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0YyNnQzaWJXZGF4LzdZSkpYV2FQVTdxYmJCZXlmNmp2MTFHbE11eUtGOWpM?=
 =?utf-8?B?NXpETmRUNkpDMGozTHhVN2JhNjg5YWo1ZUNyMWJ0eXA4YzlzY011MmlWZGdq?=
 =?utf-8?B?QkhCUHo4RzNaWkxFaE5qRmxqQmJkTldOSnZiUDJ6NTBPdU4yd1hMN1p2SzNx?=
 =?utf-8?B?c3F3enZCem8zZ1E1RHc5L2JTR2R3V05yQmFaVU9JbFVJNGhETVJFbVFMUk5L?=
 =?utf-8?B?SjVjRHRocGVjQjByRFhGcUwySk03NG1oK0V6VE1weDFURGRETTd0QTVHWWpR?=
 =?utf-8?B?QmE4enVqSm1CUGxQNjlGa0tRUjhrU01sZmh4R2V3S0d6MEVUSHc2Qk1zSVp4?=
 =?utf-8?B?Q240d08yN0hubndSZW01T0RJcDlITFZlVUNuZjFpdWUxZ3UzcFN4cFViaGJ4?=
 =?utf-8?B?OVF3aENXb1VXYWE2VHdqUGdSMVJPTytBQXJHQ0x5ak9UTkZRTVROSEF3bENH?=
 =?utf-8?B?SlEzeGhNUWdpR1NyZTBYUHBPMlFyalc4NnhmUDJFSXZsNVMzaXdxM3d2UXBu?=
 =?utf-8?B?Y1FPK2F5MW5nQ0cyb1RYWExISExlRWlhb3kyUk5HbERYaTJCemNvK1c2MlRm?=
 =?utf-8?B?UWpFTWMvUitHWGtXZDVYZTFCekE2S1V5VVRqbGlpYWpjSE9ZQUhKT1BvNXI5?=
 =?utf-8?B?RHRnbTJkakE3d01vV252M1lWK0Z6d2pOYjRMTnFob3JiUUNqS3pSeTVoMTF0?=
 =?utf-8?B?TERRQk1Wc0JkVmQ4dnlmOUUxOU5zTTdxdFM1S05PN0xzeldEcllCN2hLbU9k?=
 =?utf-8?B?eXBjQ0tmSlM2S0owVERZQlRBN0JDMkhWMFB6SGFad2lKcVpmeTlDbEc1NHNx?=
 =?utf-8?B?Qlk5WUlYS05VWFFORExEV2w0VmZqQml6NjFzZHh6N005bmZCdUNaMkx4K3Np?=
 =?utf-8?B?OVg0dEd0UEZJMS9ETW9odFdhaVAvdmsyYUZOa1c2UHlPRWVUUndaT2MzeGVL?=
 =?utf-8?B?anpnNjUxTHJWaFRjak1qbFRNQ1dJeGRXVlNpNllKN3VMcnczN3g3Mk8rWitB?=
 =?utf-8?B?bjR1NTBSOVFkelhZYmFhRHpwUStHUTg2Yk1UTlFZRFlYQTdzbXFydHl5R1Fx?=
 =?utf-8?B?OUtzRU1lM1Bwb2RLdUpCaTBoVDFDU2o4bWFaMzd3dk04NVdTdHY3WWV6TFdT?=
 =?utf-8?B?QkVkeENoVDFOeWdNOFdCRkZyb2d4UVdCdzNBaEdPY2t2WWlQbXF6dmVlZ0Ey?=
 =?utf-8?B?d1FhVVI0ak8xdm9VMVVtN0tyU2h0OU9TYXpTRXpWQ2NLZmNSYWRGTVUzSzly?=
 =?utf-8?B?TVRwbEdwS1JlamFpRmxHV1JHNkRjcEdxQTBvck5KSTdFU25EazNYUjRyZE5a?=
 =?utf-8?B?ZWdXU3dLV1pPQ1lBai85MEMzc1pqeGJyNFBQeWxTT2NzY1B0L1Vjc2VIcitG?=
 =?utf-8?B?QzZENy94SmFrSjFib1hRVmgrcmxodnFUU1ZhRXdxcUtwam1kZVk1Vnl2SzVi?=
 =?utf-8?B?VGlCM2tFNTViWTB0WDZLdHlRT05rTm5pNmRaakxWNXRHY0xMSjFWTVZYY2JP?=
 =?utf-8?B?UkRFdm1LMGtmQUlyRWovT3FjNU5rNGdnMzZyb2FvWG9RMnBIMC9UNlNKKzNy?=
 =?utf-8?B?UmFIaGRBOWhVMEVrN2dyK0Vna0t2c0FUWDF5dTNaTFc3UDJoSDhneGpDekc2?=
 =?utf-8?B?a293TTlWaXRYVUszT1ZuT1ZJS01SV1ZpL0creWgyZDB6cXY3Q0sveU9RWHk0?=
 =?utf-8?B?MDRNM1VzUjJIM0UvZEI1MDBNNzN1K0NJVDhTazZ6dTVBSU5Kd1VKVzVxeE1Q?=
 =?utf-8?B?ZGdHVzk3eFprS1pQWGEwOHhRcGVmeUVIczMvWXR3ZEx0RklrU2k0YWE0cldz?=
 =?utf-8?B?NW5vVDFpbWQ5aHlFYWV5dDJSN2VUT2ZIUG9Ld2dSdWJJUHdKS2xVZmZwR1R5?=
 =?utf-8?B?bHB5YmZkUEdlTDJtRGs5L2NwR01ja2pvV0FzYnoxRTRlQ2J2NFc5b1BkdkJw?=
 =?utf-8?B?QU85UnNhd0J5Q0xTdTdxaDdNQmdpZ3NMbUg4eHJMSW9wMVJudUZDVTlaSGpQ?=
 =?utf-8?B?enN3SlkrbGRCbE5ScEovaVRFdGVtb1Z6VUQ0d3RGaUdhTkk2Ymo1YVM0YlBD?=
 =?utf-8?B?Q2MybXZFT21xTkoveGNUVkE0RHdMYjJVRjNzY1I0WkltdjkyaGNjelZtMitR?=
 =?utf-8?B?SU1ucW0zUVBxOHlYZ0dXSHhLbGEyWkxIRm1hazkrVCtRb3h2RXN6TFhwSWhl?=
 =?utf-8?B?L0Mrb01ma1RkeGxaRlVGTUt1OTduQnJCbmZhYnZxNHhUL1VQSjVuOHBhUWRB?=
 =?utf-8?B?SGZiaUdjT0Z6ajBHMGVrUW1wV0pEQm5iV0hSTUdVMmVGVlhkcDNtWnRaanVF?=
 =?utf-8?B?b3FCTU5rZnJvNCtKby9TT1drRnRGT2xCVUNNMmpCRWkvOXhhYUFvUT09?=
X-Exchange-RoutingPolicyChecked:
	SiTcNG8Rk2/V+eE03IX+aIVSP5VqDeyhG5z52K0hp/OHSKWVnsAhFEZuAN4SsZelyPPvniOYZkVYztS7s03gMNP/mhHIa1/6JMRQ07Rv4YhD22CDNJTNo5ICgS+zoRpPlY91x8h8uMRkrIxEx3ol0loRI+IUx9prxyiUviuAArUpM2aaUX/TRAY7OTGRrJALBM9SPTRTnjnvCEC1LNWGhMkWB4G24ZsgnOi+KSBP7xaE9qv8040hu0zH71GbgX2nwdsT3Kfr6yiN3OoOUvQ0jWmCOmpPPmOLHRW2c8Ig2lMDJmMifiPuPm04OSQJbaNsuJOtqgqqZ8ZSmRlY8ImoDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r+SBzwFMJiHtSahML28gVfvibkQ55fRocwMWDTmbz7M6RJ6TAbIafuuIc06zLAVYY5NzC12jATKGwFFbEoiWmV/9O0esnSwxAr3mK1tp318LATfItysblRPo/fJ1P2gEfXIb39QrMEH7uvkpqzEnnvrCvr9ppQPWNTOgga/lRU1VSO8rTTMJ3RE2hLaqoY8vARnxaVbPThpIdrhMjTnmFz4tG7nC66tHGi3hAzkhzq2+DXLqxzEoTvHkaAYAZjlIgIigh1Jy6FC9AHSW19rSvR5pkjCgOqFy6Ao7LULhhr74mQdBhGWz7oAz+Q66ZWWrJV71+qS6m3+ldtDQBWaUUpkdgaM6U2te8uXTHm893/uUsEJvvgQW3No0CHU9gok3XsgbY8NTK2RjWR3TRZvOc11yJtoNnaYnqOkNel7pwnFAj44ESdv3jH+JBfhKIMN4axYMQRlRretDWh+IxVMDcko8GNO+BEHeOO6bAiDiz+nYuQZOtLwYTwXdKsr7UqaQ9botRsZ1v3nSely7mRGtvYSaFNx7KgfUbb6Ip5I0Qp0E6KYCNhubpQr8KScWX+NvvTW2UTY8PGabi+J2+ebkX4rAQr9/kuRILms5VCfqcs715FEVNRpcIqNiVX21MP93
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7927d171-a770-4bce-4c05-08deb4d03f0a
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:26:03.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70TWypztCbCyme6jkdxGpepOACCJoLcqRldbiF1VO1aDITllJtVECbtndVkjDxDJOPYz2urTg9h2sXqBph9g1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB2866
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 144.2.103.240
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PA3P192MB2866.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMCBTYWx0ZWRfX9XuEOufbrWbN
 QtRy5l1hxA1FV/tE7xowyU7nwl6dP2FWvmMedsnd2ukP7yvQJP27JZoEOVa1vs1Ws85v+A18yOr
 hwq1evSpFTaVAyGbwqWCGRRx9W4dLiJdysLcgbd282x+ZOikpnATgXX7/LvIE3tFqPe9QxVccR3
 AdwQooJo8HmlV7Zdw1KKEV9beFInjCk0spVh+DaVdILSDb/Hp/eDrzeG+TRo45AcxpTf68DxJwi
 lb/VGDmtFVAzlQYuwixRywUKMddGkCsMSNcVR9R92Rx3+AVrxmwlv2EZb7vRUJUsQqm8YYelMhv
 llubHu7gm1r0aSbuJShf9vRK1wn0Cf5kRVc4HGOJiS071QbSQ6grpdxUKazIz1RCUfhs+6iY2+q
 fQ//TAR0AnhleFQQDdTxMZNG32fTT7zTDAJuauCahazqzgLGyBzbRg7Dv3lMS7KrY+cfzXuVBbT
 bgm4hrgOtoNYBYGUQ4w==
X-Proofpoint-GUID: wzMF556461dIlrASaZaCwF6xAdNFnp6d
X-Proofpoint-ORIG-GUID: wzMF556461dIlrASaZaCwF6xAdNFnp6d
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a0af74d cx=c_pps
 a=f5BtQftweRdMEbMfvtUAxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=uherdBYGAAAA:8 a=p0WdMEafAAAA:8 a=pNgXkJcRAAAA:8 a=20KFwNOVAAAA:8
 a=-i4I5E_jAAAA:8 a=G9lmmAS2ovl43HdeB7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tKe0A8swS_RTMQ4Dt1Wu:22 a=YQreJwxzuLcQAHRr27xt:22
X-Rspamd-Queue-Id: DA14A56BADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249251-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kern.info:url,westermo.com:mid,westermo.com:dkim,urldefense.com:url,beijerelectronicsab.onmicrosoft.com:dkim];
	REDIRECTOR_URL(0.00)[urldefense.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthias.may@westermo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 18/05/2026 9:36 am, Laurent Vivier wrote:

> On 5/18/26 09:21, Matthias May wrote:
>> On 19/01/2026 8:55 am, Laurent Vivier wrote:
>>> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before 
>>> calling
>>> the device's bind() callback. When the bind() callback sets
>>> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
>>> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
>>> hardware limitation).
>>>
>>> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than 
>>> the
>>> device can handle, leading to silent packet drops when the backend 
>>> sends
>>> packet exceeding the device's buffer size.
>>>
>>> Fix this by limiting net->max_mtu to the device's hard_mtu after the
>>> bind callback returns.
>>>
>>> See 
>>> https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/3268__;!! 
>>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>>> cC2wnv91MtZrak2pu7K-4cU$  and
>>> https://urldefense.com/v3/__https://bugs.passt.top/attachment.cgi?bugid=189__;!! 
>>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>>> cC2wnv91MtZrak2pq4lrvZI$
>>>
>>> Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC 
>>> drivers")
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> Link: 
>>> https://urldefense.com/v3/__https://bugs.passt.top/show_bug.cgi?id=189__;!! 
>>> I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E- 
>>> cC2wnv91MtZrak2p8csXaww$
>>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>>> ---
>>>   drivers/net/usb/usbnet.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>>> index 36742e64cff7..1093c2a412d9 100644
>>> --- a/drivers/net/usb/usbnet.c
>>> +++ b/drivers/net/usb/usbnet.c
>>> @@ -1821,9 +1821,12 @@ usbnet_probe(struct usb_interface *udev, 
>>> const struct usb_device_id *prod)
>>>           if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>>>               net->flags |= IFF_NOARP;
>>> -        /* maybe the remote can't receive an Ethernet MTU */
>>> -        if (net->mtu > (dev->hard_mtu - net->hard_header_len))
>>> -            net->mtu = dev->hard_mtu - net->hard_header_len;
>>> +        if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
>>> +            net->max_mtu = dev->hard_mtu - net->hard_header_len;
>>> +
>>> +        if (net->mtu > net->max_mtu)
>>> +            net->mtu = net->max_mtu;
>>> +
>>>       } else if (!info->in || !info->out)
>>>           status = usbnet_get_endpoints(dev, udev);
>>>       else {
>>
>> Hi Laurent
>
> Hi Matthias,
>
>>
>> This change was backported to 6.6.* and caused a regression with wwan 
>> devices via USB when using a mux.
>>
>> Tested on a Quectel EM12 running the firmware 
>> EM12GPAR01A21M4G_01.300.01.300.
>>
>> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.819620] 
>> qmi_wwan 1-1.2:1.4: cdc- wdm0: USB WDM device
>> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.829601] 
>> qmi_wwan 1-1.2:1.4 cellular0: register 'qmi_wwan' at 
>> usb-fsl-ehci.0-1.2, WWAN/QMI device, 6a:c3:49:88:47:b1
>> Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.840579] 
>> usbcore: registered new interface driver qmi_wwan
>>
>> The parent interface (we renamed it "cellular0") requires an MTU of 
>> 1504 (4 bytes overhead from the muxer).
>> The actual wwan0, wwan1 interfaces have an MTU of 1500.
>>
>> With this change it's no longer possible to set an MTU of 1504 on 
>> cellular0.
>
> This should be fixed by
>
> 55f854dd5bdd ("qmi_wwan: allow max_mtu above hard_mtu to control 
> rx_urb_size") which is in v7.0.
>
> Could you have a try?
>
> Thanks,
> Laurent
>
Hi Laurent

Thank you for the pointer to your patch.

The commit is missing on the 6.6 branch.
It applies cleanly on 6.6.140 and seems to work well for my case.

BR
Matthias


