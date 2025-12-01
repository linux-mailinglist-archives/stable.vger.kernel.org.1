Return-Path: <stable+bounces-197713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C49C96E06
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4A064E2270
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709B3093C9;
	Mon,  1 Dec 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JStTmV4I"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1B2E54BB;
	Mon,  1 Dec 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588149; cv=fail; b=aWi3Woifel3ctA4oUetMk+3T7mKpvVpLcXZcfShVF9As/967XQzdef2WudCQPh6ST0o3pv7zVzd297jVOwdaLU3rtsTqAQb+COsF0L1APj/8IvE3+cpnfI9dlgNPLocNiV6Jll29sWbxgflL2Pe6v1L/ISCO1vZdRcIbdyGJ0Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588149; c=relaxed/simple;
	bh=mnFLmTVy6eLQoDo3c2BSxYpWQFrKxSro0RM4kjeNiHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ug9Qw9pxXQtvqhDLYWCu6xxgs113kvp5mVxKIVE5InqiW2AYhhjuuSpnldEmjfctGai3u2XISrd7YzTztMAElUYW+Rk1z6n5NLerRm0qotYCrysicuaNgfMSaGC/XFIYKsTljNHVV83MVheP+HDQtSoP30cigNhmMiCp4lxYS7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JStTmV4I; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B12sdbQ173990;
	Mon, 1 Dec 2025 03:22:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=LPMzjzQoX2Gc67cVOYoB7ysq6IuudtDEGJ64lRZcEUs=; b=
	JStTmV4IA2B89j8GUmDyvmbj7DWJ1PAFpHcUzrAMqgxle5sqAOTmnUL71Nsp4L8Y
	WrijFTFAoP7nqGwjq3ro7RrD9Ab/MD0bMFnt91VwUWi1mZBdfCP5BEO1tyDpTFaP
	Ek0ANkwqpQVmx8lVqJG+8vFEpvCkT3R6mbwNhPreEwfno/Ul/xzJdIHtK7HjFkoa
	bTZzKSI7r7emazanwzckhA+vfm+v6wnrmoWmjKFCyDHIruHuQCbm5yC2khhrbX2e
	1BcJ38Sp4bbhw24mqsPExZx1NMMAg9Df2/dByo7odRMnFTzNGQSwfnpTzxAMxFzI
	EogTBEJjVcqigl+0AaIsug==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4as2n9a4cr-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 03:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCy0rlt0icunfjB0pZ6vUBY0veVsJ/hME4LpG78W/7O7NsB2nfC+CoYVl52ol2jV5kcZYuBzBVbhX0P9nhWbki1INoWvhzKkvqf809zGMj109EHdWrBGohE54jFRxAnohxRtg5UOaHrPYswJlj86qAfzZdT5srGQ3WabzVZRRC74S+MBE3raulBsMSYCBpdNpVAFX4/yT/FUms/ibqF9ORZNtA0ZO+wYGpMEk/W+BdGVsQy6koLVTrb67vKLENxc2RgD9/Zby5kRH4GTZPSuZ7FAzK5rKMhlw/p1JqpWfktfzyMTo2HG8fCjk38ap2MQVtSdc/OEU/wwVR+FHen6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50ZUzS1XAeWSF8m+Hw8zJdEkY9Qj06SOcENkH5wqEdw=;
 b=oiKhtjjYQ0UFqa5+6eWtKPrv1V8Ykoh7JOhSA5XFjglLOcmgQqKLtxst3CLAZFsr9GlHQUmWbflqaJc8+uvi+dGTsiI9sGnkFkH5Zac2BqesHalTwYtd4ZGDKuIcjz21DolbbBLtJQuyI4NZDyLPAVqWO53YJ2dHlVAgtzFuVYj0y4GUlRR/XzI58GqInT9Eu5zEHvcLYVCuELcyj6UFYaNTJj+wspG/ExMD5TH9k9a9BhioCwflEGMz/cersV/N2R/vB/kB+QiVh5xwV/8x7c8OKKnX+RHmHhXRV4BjagTtuHtWClvFesFF1sCrvDCuOWNPkFkxvKdDdFI+sNSf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB4942.namprd15.prod.outlook.com (2603:10b6:510:c6::11)
 by SN7PR15MB5794.namprd15.prod.outlook.com (2603:10b6:806:323::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:22:22 +0000
Received: from PH0PR15MB4942.namprd15.prod.outlook.com
 ([fe80::3a55:fb69:ea22:7c07]) by PH0PR15MB4942.namprd15.prod.outlook.com
 ([fe80::3a55:fb69:ea22:7c07%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:22:22 +0000
From: Jonathan McDowell <noodles@meta.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: "henry.willard@oracle.com" <henry.willard@oracle.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac <jbohac@suse.cz>, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Guo
 Weikang <guoweikang.kernel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel
 Granados <joel.granados@kernel.org>,
        Alexander Graf <graf@amazon.com>, Sohil
 Mehta <sohil.mehta@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan
 McDowell <noodles@meta.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "yifei.l.liu@oracle.com"
	<yifei.l.liu@oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paul Webb <paul.x.webb@oracle.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
Thread-Topic: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
Thread-Index: AQHcVArNCcm8QIId0UmGdqpH+hlyd7UMwW+A
Date: Mon, 1 Dec 2025 11:22:22 +0000
Message-ID: <20251201112221.GA137726@noodles-fedora.dhcp.thefacebook.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4942:EE_|SN7PR15MB5794:EE_
x-ms-office365-filtering-correlation-id: 060f9710-0ca1-47df-bc42-08de30cbe5d4
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtFwd
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU1kNG40Qit0RjZTWUlPNmFWUkJ3cGo3ZlV2MWFQTUpuWEt3UGQveThTazhX?=
 =?utf-8?B?ZmVkOWJtUTBMRTZoREZTQU41RnZvLzZnM09WKzc0UHQwTlduYUFWbWNteFcy?=
 =?utf-8?B?YlNiYlk5Nk9zU1VHM0FFWW91WmhBMC95SEtjQUtMOHRWSk8wUFlMbzYrUDBX?=
 =?utf-8?B?UjduNXRrS0tFM3prclZ2K1ppRDdTWnc1VXVPMWNMSjByNmhwOC8zM0dGc3NM?=
 =?utf-8?B?Tk1TSk1kdnBWSE11dElTR2RMMDVnNTdvbXFoUFRUWVgwWSs2a1lZbUdHWElU?=
 =?utf-8?B?ZmYvZFlJR1FmdzR2VTNCcjl3OE1udXZWOTNBVm9wZE8xZlRMemFCeXoweU1v?=
 =?utf-8?B?Y2NzRFpUL3grY1pUZkxmUy9rQUQzVmhsRmJZT3FLcUN5MFVmR08zZ0pXbW5r?=
 =?utf-8?B?MmVMd1NvYzBYK1loRFhVazQ4dlBGamJEeWcrK1VkMElxeXBkbWY5Uzh1OS9m?=
 =?utf-8?B?NmwwQmQ4VWR5ZVpBbFlzUmdIeDlYa1Y4MzRRRTRmZjdWVGZRRDFjTzJOS280?=
 =?utf-8?B?ZE12QVZ4MlFiMkpWanhsUEhxNmdiUE5HRlI2WG8zNzNYRW5nOWQwUkNxQWt1?=
 =?utf-8?B?QmZiOFUxWFBrSXU4WWFXVUxseTg3TlhGaE83cU1MSTB3QmEzY0k5YWg3UzlM?=
 =?utf-8?B?WWJUZVhhNmNUNVhVUzZFOWVJbTBieU5oODVZTGpxMFVRZjVycmJ2a2c1VXYr?=
 =?utf-8?B?ajlERHprUVN4VGRBUnM4WEVuYjNOU1lUaE91TlBDdHlTLzBYUUh4WnZ5S1pH?=
 =?utf-8?B?b0cyVTNJS0dEdlJCSUgwNmp2Z1lpTEJTMi9tZnpPSFp1SVVCSmhzMXFMVmdo?=
 =?utf-8?B?Z1c4K2N4Ry9CS0RtanRTU0xCRUN2TFNKUTc4ZTRDc29nRlNpeWpnNkcxb01N?=
 =?utf-8?B?ZndYQ2dmL2RpSWVOMmZvODJwK3IyR3BJTVlNZ1pESWZheWF2aVF1MFFKcUJh?=
 =?utf-8?B?dHI1VTdLRHcySDRsaHdJYTFSWWtTaG5RUW1XZDhRUmxPMklFUFZKUVhiVGdw?=
 =?utf-8?B?bU1WK1JlSmh3Tms4MkZMVHZlQVlrRldjN3Rrby9PR01zTEJJU1NWa2FJRkc0?=
 =?utf-8?B?NGd2TmsxR0R4SERwMUo4UDllVUFlNmpVbnFqc2RQS1ppQlpBbUVxbG5aVzhy?=
 =?utf-8?B?T08yY0dsUDd3N21nK2Vlcmp4VmFiSFFTa1phdEZYMkwzMHE0emxFVGV1RU0y?=
 =?utf-8?B?Ni9QM25LODRMV3VyOHI1OGRNRkxLMzkrNlE5amRuUndNUHk3NWswdnF4STlz?=
 =?utf-8?B?cC9qenJNWmQxY0VVUk5jcytUSlZEZDZZRy9UZjRpZzQwbldSZm9KM3NVNlRW?=
 =?utf-8?B?RXovNkdHdnNlVzRBVG4xU3BCNDZwNi9NNXhiTFdHRUVnbXBNM3V2cUFTNXFN?=
 =?utf-8?B?cXNRcUFwWXFKaHBqSWRZRG5YUGZGREhIODZIbGRDNmlSTmpFa0d5b21wTlRW?=
 =?utf-8?B?VmNSR2dRaUNjaW1QN0tOTXlwM0xURmhQZWJRNkJLWEVGZWRFUjdtcTRjalpD?=
 =?utf-8?B?VDgxbUlURnZFU0JtVjhJWGp4eUJ5Ykh0YnBCTTdBL0VEdFhQNXZHK3dOVFYw?=
 =?utf-8?B?Y3pLTzdKalNxVnJvaDIzUDVlODdlUUhWLzk1S0MzTUhKSzhqNG0zTGs3OXJY?=
 =?utf-8?B?ckVCeUtqSWJuemhxcmd1MHB5SlB4VEpvUDRoanB0cDl6enFua2xsQitLcFY5?=
 =?utf-8?B?cXFzaStvOVVYcnhPVGZqanArbzZlNWd5aWpXQ2NXeWdFVHJlS0lOL1NUOWhL?=
 =?utf-8?B?dzVBaVg4ZW5sYjU3VTRmTTVObm1MbktpZGl4eGEvZHlKeE41Mm12bUxhUWdJ?=
 =?utf-8?B?NDg4VGY1T2RiWlk1dlpMaUtDU28ybGdNa2xQdmdUMVpIS1NVMHUyM3VsYXpN?=
 =?utf-8?B?OVpJaFd2RC9QbGdYSnpoeFJSRFNxbUNmSFM0MGxOMzh0NGNuQVE0bytNbWlp?=
 =?utf-8?B?b1JjVnBVbm5iNDdOb1pEbUloaTlMWVBwd2lJcnJsOUtQUkNBaFVaMDFLVThw?=
 =?utf-8?B?ZG9WblFPbytNZ3JSTDhjZnhWeEk0SjZyU0lFQlZBTzdlYTZWWG9uK2hxMVJT?=
 =?utf-8?Q?2t33Zc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4942.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wmo2N0IyN1FFN2dEaVZiNG16dzl2bDN1UlJ5eitlSmVYN2xLZzV2YnV3cGtF?=
 =?utf-8?B?aXd5SEtWS2drSWhYaVZDOE03UmFzYWY4Wk1QVytPLy9Tc1JOWXFKM2tsS2lG?=
 =?utf-8?B?aTZSMG9TNUJHMHBLNXhTb3Ezcm9zb0xIOWRrN0lBM1JIQlNhZ093aWlUMDVC?=
 =?utf-8?B?Qnc2MEtWTG9xdWxOWkZWSDl1Z0szZWhjN1p1WVFmd3ZXZ2d5bmlrOVhuZnNV?=
 =?utf-8?B?aXhsYk1WYm1jdHpCUytpVU1jVDlZRC9XZFlOdUU2eVVOUUJyU1V6bXJTb2tE?=
 =?utf-8?B?YUdyUWtLMjkwRHlScHBUYktKQ3hXaTgydTVHcW10WndIaHA2T3gwTkJVamM3?=
 =?utf-8?B?MWNmL3B3UUxwaVpCNTUzMjVFRktHa3BScXNZVU95OXVsQXJlMXRzQUNBZHpE?=
 =?utf-8?B?WVc4S1ZFTFluWHpudVROUzl1TFVpeEo5YSsvL25VMjdVTThlTTdmMTdaTFZV?=
 =?utf-8?B?SlVOZWFKWlU2UCtCNVVqMVYwU21JUTI1REJTaVJ6NFZDempmL2FRckhpMXBC?=
 =?utf-8?B?SzFLcHY1QXZpeCs0MEZoTUxFRnc1SEVpVkVDS2k0VHlyOHFxUzlJcWU2ajJT?=
 =?utf-8?B?TnRSTS84UFdCT1BIRDBPS0dvRmdPTGFha3VCNk1menM5ZjcvVU1LMGFETk1k?=
 =?utf-8?B?aGs3SzFlbWx2cngxVEZoVE9FMUE1dWJ6QkM2cnFSb0V1SkgrTlkzbXQ1aEhE?=
 =?utf-8?B?WTZqM2tRcG9Ea05sS042dUdtenQyK3QxQmdIZitMamVPMExvdHprSDlZaWFx?=
 =?utf-8?B?bFlyZ3dxVS9GZnc0dVdMOHRFdEpKMWtad0F3RVRsZVVNaWVqV3g2MWF6Q2x0?=
 =?utf-8?B?cjhEOWRzWkY3czYxa2pOZ2UxdXE4YXF0L3BBS3FuaDgzbHRQSEVDWi9QMEVp?=
 =?utf-8?B?bGI5U3lJcmMzMFo1eHBBWXQ1MUh1UEhJZjduVmdiTFdMM2ljTGFMWC9yN0VC?=
 =?utf-8?B?YW5MeXI3K0liem9XT1FXMFVqc09wY3laM0U4dVdKSEFrMXd3dG5QTEJjNVIr?=
 =?utf-8?B?aHFpN2w5dmdMM0pXVHBobGMzUlVOdTdjQ084WExlTzdyZ0R3anBiblNTay9L?=
 =?utf-8?B?MCs1NFM0YTAxeTd0eHFnUytveks3T2FmYld5TFoxR0pFcHNkbUMzR0RHTm5t?=
 =?utf-8?B?ZlFqMW5FSTV0Umx2V05hWnFWV1c0ZzZjVnYxTFpDcUdMZklkQi9JbldqMGJF?=
 =?utf-8?B?b21JQmc3TTl3QWgvYldjajd5L1J4SkVTVVdRYjRPNU9VVGRUNUx6T3VIWU84?=
 =?utf-8?B?TVBlcmcwekU3TmNCNE9aallDRWtpUzZsS1dLRWQrc3lzMkNZOWgyNTZKbUpP?=
 =?utf-8?B?bXZRZXVXZjBvNGd2a3Y3L05jQjN5UWtVbm1WTEI0ME80TmlXUGlDcXo2ekNT?=
 =?utf-8?B?cTFGY2VieU9UdzhRaFA5QmZmelljdkRFYzFwTUZpRW1iNUlZeWNiVkdmUytY?=
 =?utf-8?B?bmhEcGZENW1lRjFYVDlxTHU2djhGbEppMjRKU0FDVG0yM2dPR3BLZ3dOWUJx?=
 =?utf-8?B?Rk9pNGM4ZlZiTWp2OUlhejZOMWZRNnhJM3BQVVBCVVB6S2FBWlpxalJ4L3ky?=
 =?utf-8?B?VldIYm4yT0ZLbDM2aHJKTS81ajRDeGxTUnNzRWF1VVQ2OTdkelpZTEdnNFZB?=
 =?utf-8?B?SklQb0RJN0JWbGFJUVRiZXh3ZGp0amNzSHRxdklVSk5aWUNOSDRQa25MV0k2?=
 =?utf-8?B?T1UrS2EwWmlBYlZLT2JCM1c1R2tYUnpYVkNiVkJaOXZESi9MMmwwemVKS1hR?=
 =?utf-8?B?M2VNOUdrSGdsVi9lUHZIV1BnUlN0VUhDazRyNlhiNGtwR3ZvODZxYmt2WnJn?=
 =?utf-8?B?dURLalBRZ3ZJL2Z1VTNOYy9WZEp6eTdEa0VKckdhMGtuUVNDRWJRNUs4MkFF?=
 =?utf-8?B?aVNmbk5DaEJQYzhScDZOQ3phaGxudCsvQ3p5SEpiaWJOR20rRGg0NVZwZ1dO?=
 =?utf-8?B?OHVOQzNtUExRSE1oM3QyK2VmU2RXUGpld0dHTE40OTF3L0xCaWpmbXBsWG5i?=
 =?utf-8?B?emFZTnphVjdyZmdtU2syUUpOVi9tYjRQVXUrM0o1c25WbXZmTG12OWFZYTNl?=
 =?utf-8?B?Znl5N3krZE54MXlxTHRZTDNFRXRsZ2JJWktEU0w1QTN0NHpHM0NTcFJkamli?=
 =?utf-8?Q?QiPwDYT2HyUbhjtiRn+XHK/ch?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4942.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f9710-0ca1-47df-bc42-08de30cbe5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:22:22.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkzSCFQq+o4RRwhfq+U5w0WLCkIP8euDKD3GqeU0JR1sgNGeK4JG3kNzLaAyRTgMSmTVqmL0BXdkdt/jJZTSVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5794
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <52A835249B794348A67225953168850F@namprd15.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA5MSBTYWx0ZWRfX1zrEfG2nKxJS
 SneA9x68QTzCAkxSP5EOUcBJjSyCQok6hLgmAlouSRmHtW1uQ3KMUGnHmIPhB/Z3AMi8RIj9NH9
 ZhsJMNwzDz9ppq0k8b6yIMrsIKwzsco6W+SKt34owRdc0n/yv5t1tyJ0+5uYl/Jgk8YLfReWkGe
 6mTqgQY0YA+ojAxQnPy6Qii18F95JTwiCqj4AIKACl/TbURVWjUz5lX9xy6OTZBSa98xfVR12u2
 1M20rJHL33qc+RLP6hArIjORrHTjTXnCkQrQ6+9mtekiLHwyYp+2vNUQTjd5YAglr5iCmalF/hj
 s+f2oFBqb5nGG7qfd8uXMDiKRdgBCNM+WKmzuXUSjbX+aYsSAZtl/tCQ206AahP30ifbyzCUku4
 jjOMm/4hyHARbj+CV4zaIlbfff1kYg==
X-Authority-Analysis: v=2.4 cv=W7g1lBWk c=1 sm=1 tr=0 ts=692d7a71 cx=c_pps
 a=r8U4PY7g8F27BymEuqiK4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VabnemYjAAAA:8 a=GEW4-xAJmHXhPH3rcPMA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: p9LP7p6fvBA6B1hpy5fG2YttkOGIE8k3
X-Proofpoint-ORIG-GUID: p9LP7p6fvBA6B1hpy5fG2YttkOGIE8k3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

On Wed, Nov 12, 2025 at 11:30:02AM -0800, Harshit Mogalapalli wrote:
> >=20
> When the second-stage kernel is booted via kexec with a limiting command
> line such as "mem=3D<size>", the physical range that contains the carried
> over IMA measurement list may fall outside the truncated RAM leading to
> a kernel panic.
>=20
>     BUG: unable to handle page fault for address: ffff97793ff47000
>     RIP: ima_restore_measurement_list+0xdc/0x45a
>     #PF: error_code(0x0000) =E2=80=93 not-present page
>=20
> Other architectures already validate the range with page_is_ram(), as
> done in commit: cbf9c4b9617b ("of: check previous kernel's
> ima-kexec-buffer against memory bounds") do a similar check on x86.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kex=
ec")
> Reported-by: Paul Webb <paul.x.webb@oracle.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Seems legit; this applies on the loaded kernel side, so we do end up
losing the measurements but that matches what OF does.

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
> Have tested the kexec for x86 kernel with IMA_KEXEC enabled and the
> above patch works good. Paul initially reported this on 6.12 kernel but
> I was able to reproduce this on 6.18, so I tried replicating how this
> was fixed in drivers/of/kexec.c
> ---
>  arch/x86/kernel/setup.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1b2edd07a3e1..fcef197d180e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
> =20
>  int __init ima_get_kexec_buffer(void **addr, size_t *size)
>  {
> +	unsigned long start_pfn, end_pfn;
> +
>  	if (!ima_kexec_buffer_size)
>  		return -ENOENT;
> =20
> +	/*
> +	 * Calculate the PFNs for the buffer and ensure
> +	 * they are with in addressable memory.
> +	 */
> +	start_pfn =3D PFN_DOWN(ima_kexec_buffer_phys);
> +	end_pfn =3D PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size - 1);
> +	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
> +		pr_warn("IMA buffer at 0x%llx, size =3D 0x%zx beyond memory\n",
> +			ima_kexec_buffer_phys, ima_kexec_buffer_size);
> +		return -EINVAL;
> +	}
> +
>  	*addr =3D __va(ima_kexec_buffer_phys);
>  	*size =3D ima_kexec_buffer_size;
> =20
> --=20
> 2.50.1
>=20

--=20
Jonathan McDowell (he/him/his)
Production Engineer | PE Host Integrity
Meta | Facebook UK Ltd=

